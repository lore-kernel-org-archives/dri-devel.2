Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01971606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m5qrlELX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF9910E2B4;
	Tue, 10 Nov 2026 06:57:48 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D1710EDF7;
 Tue, 10 Nov 2026 06:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMl05nZwAzj07zwZfqOGjtY8bpvEOpIra1znMSRK7Yh39PEqsUmrJLwsLto/sEmzijPFiyglbIoEKLpdw2MtbgoqdAP5EQcAIL57xWWoKqzjl8pqW5r7VmWn5wIQ7x4gi25qU6boDwscBOEu8Vqjt+v5uq7SuuwsYmDRTJKGkCuIE1iKHstwJxTgzhEJ269SL2z7Q5KTpCXnuwXJEYUeWteTxhvd9jp4+mrp2a8qrf+6BqVuvJmfRKyWtta+8Ne7vsCYjs+eUkPHbSrpvQMd7UF/sSdo5DcrHvuf0RiJMT6A6oquhtmbOLxG0A5OEJ1Lclob/7WbsC+hPfXR2DJI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWk3IrG5tyGAmnlbE/Od3eckknC/CYh+bbZ3KDy4uPM=;
 b=kXyorVJC5IGYCtySSZqbgxfmhSd6MCKb3z1kFk6k57SP2pl/7dt58xGB58NEfVfDSaGE0VhWVdil0e+k+ix2kalHGTptFu7hcEKEB0G2k4E7RUtuJg9qQICASFVx4P1gRvgmRmCqMF6/zOs9wMIp5Hylk5ST0rx7Z18YlMCkN4LtdWqykb/ird9W85btX5QonVtwKNYRRCyrpeXJtRu4RjpmQGWvtsHLvChyJbyClQph6R9qTua73AIcUZoX/qdhrBr2EL88AtsYQ/s7B9ewBvZ6FO5qay1NB9pYb9w8QQPNAshsyaHKbg6JpE7zzJZZe2EcWX0S4dL3bkA3PhOYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWk3IrG5tyGAmnlbE/Od3eckknC/CYh+bbZ3KDy4uPM=;
 b=m5qrlELXmGt7HuUPsKHpyBwsOvH3m51qYz3VJBM8/ugxjx2gUT2EBO2K9CIhGovkIlPXYVqQ/ePSnp1HhuJDvVsMDY71Y+XGJRsPuLXq6m/WhLscnXtv7nF+CatwR1yw+5/tRrT84ypb4O0jrWMJbMK8gVRJcqy+xCSVgu/o7xc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 06:57:39 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 06:57:38 +0000
Message-ID: <dbe3f45b-442b-4677-aa9c-8c3f2fbdda8c@amd.com>
Date: Tue, 10 Nov 2026 14:57:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/22] drm/amdgpu/gmc: add get_svm_pte_flags callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-7-ray.huang@amd.com>
 <facb3939-a692-42a9-9d42-a5eafbfb0400@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <facb3939-a692-42a9-9d42-a5eafbfb0400@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac5dfd3-ec4b-4eed-63da-08df3ef7e833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223327099003|261028144727099003|11063799006|4143699003|56012099006|261026140227099003|261021121427099003|261009220027099003|261022105027099003|261102123227099003|261009221227099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Fbjq8QwEEPsKmeFTXRfEQ5fWDKeCbv66gY6Tbq36h9zBfT9ey0ES9nIEXo+Vn3qJsYds0W91V9EqJDhit9h7X/N1gDiEuoq9bgghi5hNROphiIYvBcqBX7/7rsYXbdRBqoMvtDWwDQllTgmBAmhJalWcuUfT6be2xa0F3VaX6QkI260WP/+xLVHeMZ6RnwteLckbvx22x3xrs3O+a4e0w7HgDhw8FFWj42E1bDy0u+mpcc2xdyj5ZBS/3btQXK6N9E/GtfmqdmEnzmx1IsuS2CedhTWbZbVeAC10+9NYpuF5d4/OiZ+wzVHrXPKPnqSRvoPOufnsoWhDx6SYRd3fcMtnMYyrNndQ+MB3+7OQrmFmDiJqOnsx+ys56x2C8MupJgSJTDiui04P5Cm5z8on+4zXl1W+/DMYE1MVfYZxb4BwP25ITHhNAGoXCsodn/klS06szf7JQ2X4l0qZMNNcM1HPkupiK+CvVIJIM2hevlNtJ/c6IBaBBOBreVHeIW7kkeEFmC6lnQNJSeI1UtUVTJWCrVP76JK2QK3Ns539FmqLNzRJe8ItwsY6bozSHxm1nncPp+XnbsIoO8siY4+gQWbWxYLPcmwoMcs7NxwXNIfh+Xe0o+db6wRWMp3MEoWQAqRBpyt0eXh3Klxs/Le3LE9fkcSr2sGgnmLED3yUhxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223327099003)(261028144727099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261021121427099003)(261009220027099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWg3NGpEOXpWSldKWU1kODBZbWVLdjRheUJobmRkNVRPTlpycWpXNkplRmVM?=
 =?utf-8?B?ZWc4b2kxcWdtL2xyZ29EcnQ2RHkvRjdIU1pJMlRBc2tPVE12azRCRWx6V1JN?=
 =?utf-8?B?aWFSa2IxS1Q1MzVodlAwckx5LzArblRycjROVjA0azYxRjlBcmlJb0JsVm1W?=
 =?utf-8?B?UC9jZ29YL2syWnhtYkxLWXFla0l4U0dUeGpvZURCRFVXK2EzVWhtcVkzMjEv?=
 =?utf-8?B?eGRadE9yNDBkRE5ZWnBhNEJoWExncnNsRVJSMHFnUVdpVkNsK2ZqanVJdzRK?=
 =?utf-8?B?dFhVeUw3NDJaZ243WDJBWXdDKzlVcnFnbHk5MWdjd2F2RDFPS1ZSYTRFcFRR?=
 =?utf-8?B?dzdsaW8xQS9Ub3ZkWlk3aHc2WGtJVjVTTm8reHZwNER6WDFhZVhwQ2NFaVJZ?=
 =?utf-8?B?OWRPay8zc3ROalN0TnRxZVVsdm5vR2VzSXlmUHpCdnZmbjNRWDdEcjJVV1c4?=
 =?utf-8?B?M2tVVkJRc3p2NStibHlTd1JNMmlodFEzOU9aZDZsMU1ocjUyWE9zR3g4N2lN?=
 =?utf-8?B?a3R3TkNtdGRnOVdsLzkySnVKNzZxbTAyUzE2aTR3MkgwZmZ6bldSRENkU3ZI?=
 =?utf-8?B?eG5KSCtJMklsTHNUUG51cVhCQVlKMTNpS2JzaURGWVh2amZHSTZJL2ovNEpG?=
 =?utf-8?B?U3hJV0VyT2dreFZtRnlMS0R0b1FNTEhQQlU5MitJQk43MElHUGVoY3VQeWo2?=
 =?utf-8?B?dnRuNDdnZlRTMjRibGowQWEzeG5VOHNvWGFlRk01N3BkejFqN0czeTRBS3N1?=
 =?utf-8?B?Z1hKMDU4bzVnWHpzQkx5V3NqRy9FZ0xXVFdRRzR2ZlUva1FMZ0Y3RWM1Y0F1?=
 =?utf-8?B?RHR2M3FCcUxhYklZaEdpSXljcDlodFZVRjExdkpUMGVnTkpSUnFNT0xUN2Q0?=
 =?utf-8?B?VFFJN3puUEhHU2RyczZRUXZZamQrVXJqWk1pRDdCbkl1aW5GNHk1aWtFUDYy?=
 =?utf-8?B?SG9ucjJxQ3plY2g2c0JiMW5pZkhHcUpaNUNIajRzbVVwQjFCT2tOaE9DRlRE?=
 =?utf-8?B?RVBScy9ZdkdIT2R2V1c1STNVSWYzclFaM3N4eGpqLzNJS1BGMGgxR0ltN2FJ?=
 =?utf-8?B?MjI2ejgrSEQ2YmtJd1RqZGxzVjZybEpmRys3QjhrUTZTL1J2N2dMWks0akk5?=
 =?utf-8?B?SDlwcmFDaWkwQWh4aEozUEQ0dFpjTXpZKzhjLytIZnVjcTQwVnFWOVR1b0NT?=
 =?utf-8?B?VmdHbFFobWN0TC9neHpsdjdiditoVHV3Sm84VkROQ0duWmUrTXhkakxKeUhJ?=
 =?utf-8?B?NnZ3UkdKVHd6amJiczZGT3NiK3Fnb0Z5dHJjdWFuSmlMTUtnYWx6bjNLekZr?=
 =?utf-8?B?OGM1RFJjZHdvTGlGb0s4cGJYQnhQYmFxS2RQdzdOYWc2bjlaMHhOU2hSUlAv?=
 =?utf-8?B?bTRIanhLYU5ScUNqNGVFMzNVcXNwZVJhU3hLMENCd1RwZkc4bjJlKzhyK3Mz?=
 =?utf-8?B?cHhrQWxMNDVZZER3bVhUNm8rRmJ1T1AxNXVMejJDM21sc04yYWdSbUY3clVX?=
 =?utf-8?B?ZThmMFdvRGJuNmxQRUxVcGRoaEUvc0FGWlhUbTNqNVNNTUhHMFp3UERublh4?=
 =?utf-8?B?amxaU3lGaGltSmJ4U0U4TUxDTlRaUnFVTW02a1I5Ri9Vc0ZpejhubXd4NWZJ?=
 =?utf-8?B?RWV1VklnR04zWEJqeTNQdmRWeGxuWHhIM3R3cGhjNkttUTM4ekRydXZIRkxr?=
 =?utf-8?B?aU5aZFd5V0JhbmV2MHEwNGtUWUl6aGs4b0l1blRjSXlLL2VUYXdZeWRpaVp4?=
 =?utf-8?B?SEFEUkhEVXRma1FRRVN4RXlPTzYycjVrZ2E0ZzNUY3czMy9mSUFtUUZHOGdx?=
 =?utf-8?B?MkcxaHRFaExRRVd4Z1dYUDVobjFUcTgyTkxOOFZVdzV6TnJjQVlvdmdrdkVx?=
 =?utf-8?B?K3Y5b3J3S09SSTRrd2IwL2RuV2gzcWFYQW5EaGUycDVqTmF1d28xTGVFZEVt?=
 =?utf-8?B?andOTkZHTmNyQXZ1dm1rY2NCL3c4cWNiN3V6YTVrdDJDV0ZOZ2NvY21kQXBn?=
 =?utf-8?B?ODhYQXNuUUo1bU1CWCtrbmZ5VHNQa2N3QmRHV0x2NnhXYU15YjhlWExQNGpS?=
 =?utf-8?B?cmdCZUlNTDFNY0pZTUlwSVNQVnZYNXkrWCtEL2NZZ2lFTmR6QnFPdWZrWDlQ?=
 =?utf-8?B?b3ArQlBOSE1KVFFkcnhkWmljN041bWNwT0pNTVBmTDEva1FaYU8ySk5lZjVq?=
 =?utf-8?B?NDhxTm1pSmRCc1VteVRpRlozamVPU0MvUUFxRXZDUFVXZVA4eXNSY2RvRlFP?=
 =?utf-8?B?bjdvcGJ3QU9taW53NWJySkpwdXdsZWdVZEdNK2s4VldXL2o5dGtwa29wSy9v?=
 =?utf-8?Q?2r/Mzxd8YlXZWL1M9O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac5dfd3-ec4b-4eed-63da-08df3ef7e833
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:57:38.6312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgnuXB+WaH5FmjpJnkVigSzzcaQTyj/3jnCURogbedl1k2WPMWMEsPhaDuOgyiLq44k8uVxnyAd9aWF1mEYpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 9:52 PM, Christian König wrote:
> On 10/21/26 04:58, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add a gmc_funcs callback for computing the GPU PTE flags of an SVM
>> mapping, plus a HW-agnostic input struct (amdgpu_svm_pte_flags_params)
>> and the amdgpu_gmc_get_svm_pte_flags() wrapper. This lets the per-IP
>> MTYPE/PTE selection live in the HW IP specific gmc_vX_0.c files instead
>> of the SVM core, mirroring how get_vm_pte handles BO mappings.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  24 +++++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  69 ++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 119 ++++++++++++++++++++++++
>>   3 files changed, 212 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index cffd5ca3fc66b..3f668fb71a632 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -150,6 +150,24 @@ struct amdgpu_vmhub {
>>   	const struct amdgpu_vmhub_funcs *vmhub_funcs;
>>   };
>>   
>> +/* Decoded inputs for the SVM PTE flag selection, gmc_funcs::get_svm_pte_flags */
>> +struct amdgpu_svm_pte_flags_params {
>> +	/* SVM attribute: coherent */
>> +	bool coherent;
>> +	/* SVM attribute: extended coherent */
>> +	bool ext_coherent;
>> +	/* SVM attribute: GPU read only */
>> +	bool gpu_ro;
>> +	/* SVM attribute: GPU executable */
>> +	bool gpu_exec;
>> +	/* mapping is in VRAM local device or remote P2P */
>> +	bool is_vram;
>> +	/* mapping is in this GPU's local VRAM */
>> +	bool is_local;
>> +	/* remote VRAM BO is on a GPU in the same XGMI hive as this GPU. */
>> +	bool same_hive;
>> +};
>> +
>>   /*
>>    * GPU MC structures, functions & helpers
>>    */
>> @@ -178,6 +196,10 @@ struct amdgpu_gmc_funcs {
>>   			   struct amdgpu_bo *bo,
>>   			   uint32_t vm_flags,
>>   			   uint64_t *pte_flags);
>> +	/* get the full pte flags for an SVM mapping */
>> +	uint64_t (*get_svm_pte_flags)(struct amdgpu_device *adev,
>> +				      struct amdgpu_vm *vm,
>> +				      const struct amdgpu_svm_pte_flags_params *params);
> 
> That looks like a really really bad idea to me.
> 
> Please add the SVM flags to the existing amdgpu_gmc_get_vm_pte() function.
> 
> Additional to that you also need to modify the destination addr and not just the flags.

Will change to existing amdgpu_gmc_get_vm_pte function

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>>   	/* override per-page pte flags */
>>   	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>>   				      struct amdgpu_vm *vm,
>> @@ -378,6 +400,8 @@ struct amdgpu_gmc {
>>   #define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
>>   	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
>>   					   (pte_flags)))
>> +#define amdgpu_gmc_get_svm_pte_flags(adev, vm, params) \
>> +	((adev)->gmc.gmc_funcs->get_svm_pte_flags((adev), (vm), (params)))
>>   #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
>>   	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
>>   		((adev), (vm), (addr), (pte_flags))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index 0cc73982ed6f9..a541173e34a4e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -551,6 +551,74 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>>   		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>>   }
>>   
>> +/*
>> + * Mirror of the GFX12 cases of svm_range_get_pte_flags(), with the
>> + * per IP logic kept here in the HW specific file.
>> + */
>> +static uint64_t
>> +gmc_v12_0_get_svm_pte_flags(struct amdgpu_device *adev,
>> +			    struct amdgpu_vm *vm,
>> +			    const struct amdgpu_svm_pte_flags_params *params)
>> +{
>> +	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>> +	bool coherent = params->coherent;
>> +	bool ext_coherent = params->ext_coherent;
>> +	bool is_local = params->is_local;
>> +	bool is_vram = params->is_vram;
>> +	bool snoop = !is_vram;
>> +	uint32_t mapping_flags = 0;
>> +	unsigned int mtype_local, mtype_remote;
>> +	bool is_aid_a1;
>> +	uint64_t pte_flags;
>> +
>> +	switch (gc_ip_version) {
>> +	case IP_VERSION(12, 0, 0):
>> +	case IP_VERSION(12, 0, 1):
>> +		mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +		break;
>> +	case IP_VERSION(12, 1, 0):
>> +		is_aid_a1 = (adev->rev_id & 0x10);
>> +		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
>> +				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>> +				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
>> +		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
>> +		snoop = true;
>> +
>> +		if (is_local) {
>> +			mapping_flags |= mtype_local;
>> +		} else if (ext_coherent) {
>> +			mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +		} else {
>> +			/* system memory or remote VRAM */
>> +			mapping_flags |= mtype_remote;
>> +		}
>> +		break;
>> +	default:
>> +		mapping_flags |= coherent ?
>> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		break;
>> +	}
>> +
>> +	if (params->gpu_exec)
>> +		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>> +
>> +	pte_flags = AMDGPU_PTE_VALID;
>> +	pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
>> +	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>> +	pte_flags |= AMDGPU_PTE_IS_PTE;
>> +
>> +	gmc_v12_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
>> +	pte_flags |= AMDGPU_PTE_READABLE;
>> +	if (!params->gpu_ro)
>> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
>> +
>> +	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
>> +	    adev->have_atomics_support)
>> +		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
>> +
>> +	return pte_flags;
>> +}
>> +
>>   static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
>>   {
>>   	return 0;
>> @@ -580,6 +648,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
>>   	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
>>   	.get_vm_pde = gmc_v12_0_get_vm_pde,
>>   	.get_vm_pte = gmc_v12_0_get_vm_pte,
>> +	.get_svm_pte_flags = gmc_v12_0_get_svm_pte_flags,
>>   	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
>>   	.get_dcc_alignment = gmc_v12_0_get_dcc_alignment,
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 633772fa71fda..a3a5fa048a393 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1199,6 +1199,124 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>>   		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
>>   }
>>   
>> +/*
>> + * Mirror of the GFX9 cases of svm_range_get_pte_flags(), with the
>> + * per IP logic kept here in the HW specific file.
>> + */
>> +static uint64_t
>> +gmc_v9_0_get_svm_pte_flags(struct amdgpu_device *adev,
>> +			   struct amdgpu_vm *vm,
>> +			   const struct amdgpu_svm_pte_flags_params *params)
>> +{
>> +	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>> +	bool coherent = params->coherent;
>> +	bool ext_coherent = params->ext_coherent;
>> +	bool is_local = params->is_local;
>> +	bool is_vram = params->is_vram;
>> +	bool same_hive = params->same_hive;
>> +	bool snoop = !is_vram;
>> +	uint32_t mapping_flags = 0;
>> +	unsigned int mtype_local;
>> +	uint64_t pte_flags;
>> +
>> +	switch (gc_ip_version) {
>> +	case IP_VERSION(9, 4, 1):
>> +		if (is_vram) {
>> +			if (is_local) {
>> +				mapping_flags |= coherent ?
>> +					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>> +			} else {
>> +				mapping_flags |= coherent ?
>> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +				if (same_hive)
>> +					snoop = true;
>> +			}
>> +		} else {
>> +			mapping_flags |= coherent ?
>> +				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		}
>> +		break;
>> +	case IP_VERSION(9, 4, 2):
>> +		if (is_vram) {
>> +			if (is_local) {
>> +				mapping_flags |= coherent ?
>> +					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>> +				if (adev->gmc.xgmi.connected_to_cpu)
>> +					snoop = true;
>> +			} else {
>> +				mapping_flags |= coherent ?
>> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +				if (same_hive)
>> +					snoop = true;
>> +			}
>> +		} else {
>> +			mapping_flags |= coherent ?
>> +				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		}
>> +		break;
>> +	case IP_VERSION(9, 4, 3):
>> +	case IP_VERSION(9, 4, 4):
>> +	case IP_VERSION(9, 5, 0):
>> +		if (ext_coherent)
>> +			mtype_local = AMDGPU_VM_MTYPE_CC;
>> +		else
>> +			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>> +				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
>> +				AMDGPU_VM_MTYPE_RW;
>> +		snoop = true;
>> +		if (is_vram) {
>> +			/* local HBM region close to partition */
>> +			if (is_local)
>> +				mapping_flags |= mtype_local;
>> +			/* local HBM region far from partition or remote XGMI GPU
>> +			 * with regular system scope coherence
>> +			 */
>> +			else if (same_hive && !ext_coherent)
>> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +			/* PCIe P2P on GPUs pre-9.5.0 */
>> +			else if (gc_ip_version < IP_VERSION(9, 5, 0) && !same_hive)
>> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +			/* Other remote memory */
>> +			else
>> +				mapping_flags |= ext_coherent ?
>> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		} else if (adev->flags & AMD_IS_APU) {
>> +			/* On NUMA systems, locality is determined per-page
>> +			 * in gmc_v9_0_override_vm_pte_flags.
>> +			 */
>> +			if (num_possible_nodes() <= 1)
>> +				mapping_flags |= mtype_local;
>> +			else
>> +				mapping_flags |= ext_coherent ?
>> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		} else {
>> +			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
>> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +			else
>> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +		}
>> +		break;
>> +	default:
>> +		mapping_flags |= coherent ?
>> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		break;
>> +	}
>> +
>> +	if (params->gpu_exec)
>> +		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>> +
>> +	pte_flags = AMDGPU_PTE_VALID;
>> +	pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
>> +	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>> +
>> +	gmc_v9_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
>> +	pte_flags |= AMDGPU_PTE_READABLE;
>> +	if (!params->gpu_ro)
>> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
>> +
>> +	return pte_flags;
>> +}
>> +
>>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>>   					   struct amdgpu_vm *vm,
>>   					   uint64_t addr, uint64_t *flags)
>> @@ -1316,6 +1434,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>>   	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
>>   	.get_vm_pde = gmc_v9_0_get_vm_pde,
>>   	.get_vm_pte = gmc_v9_0_get_vm_pte,
>> +	.get_svm_pte_flags = gmc_v9_0_get_svm_pte_flags,
>>   	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
>>   	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
>>   	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
> 

