/* tslint:disable */
/**
 * TickTag REST API
 * TickTag issue tracking API
 *
 * OpenAPI spec version: 1.0
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { Inject, Injectable, Optional }                      from '@angular/core';
import { Http, Headers, URLSearchParams }                    from '@angular/http';
import { RequestMethod, RequestOptions, RequestOptionsArgs } from '@angular/http';
import { Response, ResponseContentType }                     from '@angular/http';

import { Observable }                                        from 'rxjs/Observable';
import 'rxjs/add/operator/map';

import * as models                                           from '../model/models';
import { BASE_PATH }                                         from '../variables';
import { Configuration }                                     from '../configuration';

/* tslint:disable:no-unused-variable member-ordering */


@Injectable()
export class UserApi {
    protected basePath = 'http://localhost:8080/';
    public defaultHeaders: Headers = new Headers();
    public configuration: Configuration = new Configuration();

    constructor(protected http: Http, @Optional()@Inject(BASE_PATH) basePath: string, @Optional() configuration: Configuration) {
        if (basePath) {
            this.basePath = basePath;
        }
        if (configuration) {
            this.configuration = configuration;
        }
    }
	
	/**
     * 
     * Extends object by coping non-existing properties.
     * @param objA object to be extended
     * @param objB source object
     */
    private extendObj<T1,T2>(objA: T1, objB: T2) {
        for(let key in objB){
            if(objB.hasOwnProperty(key)){
                (<any>objA)[key] = (<any>objB)[key];
            }
        }
        return <T1&T2>objA;
    }

    /**
     * createUser
     * 
     * @param req req
     */
    public createUserUsingPOST(req: models.CreateUserRequestJson, extraHttpRequestParams?: any): Observable<models.UserResultJson> {
        return this.createUserUsingPOSTWithHttpInfo(req, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * getUserByUsername
     * 
     * @param name name
     */
    public getUserByUsernameUsingGET(name: string, extraHttpRequestParams?: any): Observable<models.UserResultJson> {
        return this.getUserByUsernameUsingGETWithHttpInfo(name, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * getUser
     * 
     * @param id id
     */
    public getUserUsingGET(id: string, extraHttpRequestParams?: any): Observable<models.UserResultJson> {
        return this.getUserUsingGETWithHttpInfo(id, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * listRoles
     * 
     */
    public listRolesUsingGET(extraHttpRequestParams?: any): Observable<Array<models.RoleResultJson>> {
        return this.listRolesUsingGETWithHttpInfo(extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * listUsersFuzzy
     * 
     * @param projectId projectId
     * @param q q
     * @param order order
     */
    public listUsersFuzzyUsingGET(projectId: string, q: string, order: Array<string>, extraHttpRequestParams?: any): Observable<Array<models.UserResultJson>> {
        return this.listUsersFuzzyUsingGETWithHttpInfo(projectId, q, order, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * listUsers
     * 
     */
    public listUsersUsingGET(extraHttpRequestParams?: any): Observable<Array<models.UserResultJson>> {
        return this.listUsersUsingGETWithHttpInfo(extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * updateUser
     * 
     * @param id id
     * @param req req
     */
    public updateUserUsingPUT(id: string, req: models.UpdateUserRequestJson, extraHttpRequestParams?: any): Observable<models.UserResultJson> {
        return this.updateUserUsingPUTWithHttpInfo(id, req, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }


    /**
     * createUser
     * 
     * @param req req
     */
    public createUserUsingPOSTWithHttpInfo(req: models.CreateUserRequestJson, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'req' is not null or undefined
        if (req === null || req === undefined) {
            throw new Error('Required parameter req was null or undefined when calling createUserUsingPOST.');
        }


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            

        headers.set('Content-Type', 'application/json');


        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Post,
            headers: headers,
            body: req == null ? '' : JSON.stringify(req), // https://github.com/angular/angular/issues/10612
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

    /**
     * getUserByUsername
     * 
     * @param name name
     */
    public getUserByUsernameUsingGETWithHttpInfo(name: string, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user/name/${name}`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'name' is not null or undefined
        if (name === null || name === undefined) {
            throw new Error('Required parameter name was null or undefined when calling getUserByUsernameUsingGET.');
        }


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            



        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Get,
            headers: headers,
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

    /**
     * getUser
     * 
     * @param id id
     */
    public getUserUsingGETWithHttpInfo(id: string, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user/${id}`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'id' is not null or undefined
        if (id === null || id === undefined) {
            throw new Error('Required parameter id was null or undefined when calling getUserUsingGET.');
        }


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            



        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Get,
            headers: headers,
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

    /**
     * listRoles
     * 
     */
    public listRolesUsingGETWithHttpInfo(extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user/roles`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            



        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Get,
            headers: headers,
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

    /**
     * listUsersFuzzy
     * 
     * @param projectId projectId
     * @param q q
     * @param order order
     */
    public listUsersFuzzyUsingGETWithHttpInfo(projectId: string, q: string, order: Array<string>, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user/fuzzy`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'projectId' is not null or undefined
        if (projectId === null || projectId === undefined) {
            throw new Error('Required parameter projectId was null or undefined when calling listUsersFuzzyUsingGET.');
        }
        // verify required parameter 'q' is not null or undefined
        if (q === null || q === undefined) {
            throw new Error('Required parameter q was null or undefined when calling listUsersFuzzyUsingGET.');
        }
        // verify required parameter 'order' is not null or undefined
        if (order === null || order === undefined) {
            throw new Error('Required parameter order was null or undefined when calling listUsersFuzzyUsingGET.');
        }
        if (projectId !== undefined) {
            queryParameters.set('projectId', <any>projectId);
        }
        if (q !== undefined) {
            queryParameters.set('q', <any>q);
        }
        if (order !== undefined) {
            queryParameters.set('order', <any>order);
        }


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            



        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Get,
            headers: headers,
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

    /**
     * listUsers
     * 
     */
    public listUsersUsingGETWithHttpInfo(extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            



        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Get,
            headers: headers,
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

    /**
     * updateUser
     * 
     * @param id id
     * @param req req
     */
    public updateUserUsingPUTWithHttpInfo(id: string, req: models.UpdateUserRequestJson, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/user/${id}`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'id' is not null or undefined
        if (id === null || id === undefined) {
            throw new Error('Required parameter id was null or undefined when calling updateUserUsingPUT.');
        }
        // verify required parameter 'req' is not null or undefined
        if (req === null || req === undefined) {
            throw new Error('Required parameter req was null or undefined when calling updateUserUsingPUT.');
        }


        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];
        
            

        headers.set('Content-Type', 'application/json');


        let requestOptions: RequestOptionsArgs = new RequestOptions({
            method: RequestMethod.Put,
            headers: headers,
            body: req == null ? '' : JSON.stringify(req), // https://github.com/angular/angular/issues/10612
            search: queryParameters
        });
        
        // https://github.com/swagger-api/swagger-codegen/issues/4037
        if (extraHttpRequestParams) {
            requestOptions = this.extendObj(requestOptions, extraHttpRequestParams);
        }

        return this.http.request(path, requestOptions);
    }

}

