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
export class AssignmenttagApi {
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
     * createAssignmentTag
     * 
     * @param req req
     */
    public createAssignmentTagUsingPOST(req: models.CreateAssignmentTagRequestJson, extraHttpRequestParams?: any): Observable<models.AssignmentTagResultJson> {
        return this.createAssignmentTagUsingPOSTWithHttpInfo(req, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * deleteAssignmentTag
     * 
     * @param id id
     */
    public deleteAssignmentTagUsingDELETE(id: string, extraHttpRequestParams?: any): Observable<{}> {
        return this.deleteAssignmentTagUsingDELETEWithHttpInfo(id, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * getAssignmentTag
     * 
     * @param id id
     */
    public getAssignmentTagUsingGET(id: string, extraHttpRequestParams?: any): Observable<models.AssignmentTagResultJson> {
        return this.getAssignmentTagUsingGETWithHttpInfo(id, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * listAssignmentTags
     * 
     * @param projectId projectId
     */
    public listAssignmentTagsUsingGET(projectId: string, extraHttpRequestParams?: any): Observable<Array<models.AssignmentTagResultJson>> {
        return this.listAssignmentTagsUsingGETWithHttpInfo(projectId, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }

    /**
     * updateAssignmentTag
     * 
     * @param id id
     * @param req req
     */
    public updateAssignmentTagUsingPUT(id: string, req: models.UpdateAssignmentRequestJson, extraHttpRequestParams?: any): Observable<models.AssignmentTagResultJson> {
        return this.updateAssignmentTagUsingPUTWithHttpInfo(id, req, extraHttpRequestParams)
            .map((response: Response) => {
                if (response.status === 204) {
                    return undefined;
                } else {
                    return response.json();
                }
            });
    }


    /**
     * createAssignmentTag
     * 
     * @param req req
     */
    public createAssignmentTagUsingPOSTWithHttpInfo(req: models.CreateAssignmentTagRequestJson, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/assignmenttag`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'req' is not null or undefined
        if (req === null || req === undefined) {
            throw new Error('Required parameter req was null or undefined when calling createAssignmentTagUsingPOST.');
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
     * deleteAssignmentTag
     * 
     * @param id id
     */
    public deleteAssignmentTagUsingDELETEWithHttpInfo(id: string, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/assignmenttag/${id}`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'id' is not null or undefined
        if (id === null || id === undefined) {
            throw new Error('Required parameter id was null or undefined when calling deleteAssignmentTagUsingDELETE.');
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
            method: RequestMethod.Delete,
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
     * getAssignmentTag
     * 
     * @param id id
     */
    public getAssignmentTagUsingGETWithHttpInfo(id: string, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/assignmenttag/${id}`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'id' is not null or undefined
        if (id === null || id === undefined) {
            throw new Error('Required parameter id was null or undefined when calling getAssignmentTagUsingGET.');
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
     * listAssignmentTags
     * 
     * @param projectId projectId
     */
    public listAssignmentTagsUsingGETWithHttpInfo(projectId: string, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/assignmenttag/`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'projectId' is not null or undefined
        if (projectId === null || projectId === undefined) {
            throw new Error('Required parameter projectId was null or undefined when calling listAssignmentTagsUsingGET.');
        }
        if (projectId !== undefined) {
            queryParameters.set('projectId', <any>projectId);
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
     * updateAssignmentTag
     * 
     * @param id id
     * @param req req
     */
    public updateAssignmentTagUsingPUTWithHttpInfo(id: string, req: models.UpdateAssignmentRequestJson, extraHttpRequestParams?: any): Observable<Response> {
        const path = this.basePath + `/assignmenttag/${id}`;

        let queryParameters = new URLSearchParams();
        let headers = new Headers(this.defaultHeaders.toJSON()); // https://github.com/angular/angular/issues/6845
        // verify required parameter 'id' is not null or undefined
        if (id === null || id === undefined) {
            throw new Error('Required parameter id was null or undefined when calling updateAssignmentTagUsingPUT.');
        }
        // verify required parameter 'req' is not null or undefined
        if (req === null || req === undefined) {
            throw new Error('Required parameter req was null or undefined when calling updateAssignmentTagUsingPUT.');
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

