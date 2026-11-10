Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8785606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QkG0Cb6g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D109689261;
	Tue, 10 Nov 2026 07:01:55 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7763089263;
 Tue, 10 Nov 2026 07:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsDRNBzqFL6a9CiPcEhCizVuB5gzdJm9lCHuIK87wKI2MgGgzxVGjywZaEd5oedBKg2yN3NpCb4cI3UBtYTTOvyXnUL3ekLBPHrFk9OLChE54S38WnrXHng7MznznruCHebhBvI/7KKeYPOzFDflOp2zospMK22RuV4dBj5t4sjHeYj1Qd9e6zN4DxQ8m6JHKQBtSEPsFBg0cDl+3dxH4bUnxgOrJNMA5BzKHV6SLkbxAjYe+lj8+kXqZTToE+Bf2HLZJ2LDZgVusrE6b8CetWGWeLYJ3ya5X1Y2DJOtf6nfSBEjhgjG9ojZAKou6HP5cVFWyQvFyTQPNH6Ji3H8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Dtep9eFaisAafAR/Z2l6YJ+13h6FnOgwWZOkM6fa14=;
 b=p3Zxfh5lrjpzhUQQ0JZAkQbNjLDQd68XU9FnC2pVT232DV+tIWnNYHrUEUY+bw4+EQ7BNWaxvVia1y2XcgaGXnQP7aV1cGjd267GrrKnQixMY8ppS4gWwVPsWRXxrKIFcUMYH6/T9mkhN13ci95SqnpI0WcoUtji9Nl9HA7wS3FYPh7iW6tC7ENy23a0gLKnv2D/1l+3B4B7ZZ62HSCPRtlAfnESiWngegtvA/5VEVwXzzo2gDgRfHtPa6B0XFj/X1ccs8oAYjAiONqby/Albl9RLyBDYWzbqVowxzcziFnBvpY5F1+wJpfZRvDfi8TnktMlvHG6QBcFqZ3vOU9ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dtep9eFaisAafAR/Z2l6YJ+13h6FnOgwWZOkM6fa14=;
 b=QkG0Cb6gj8nbUxpzD1g9vqXcYe3XN8QCshax1Y1zs9KmFGyD+gPVZbGS1d4tLCgTXadFp89xDWLAey4yyWZyt1r7VRkkauO/2P/F44HxihTRVmtCRWYITdtiEuLRDyi8MMwianh52H1vUi+im3obyetznk8SUVnHDI5xwj69Xh0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 07:01:44 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 07:01:44 +0000
Message-ID: <a5f51d63-5fe5-4a50-b705-a67fc3971482@amd.com>
Date: Tue, 10 Nov 2026 15:01:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/22] drm/amdgpu: implement SVM range GPU mapping core
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
 <20261021025915.2433837-8-ray.huang@amd.com>
 <9d434db2-fca5-4168-acc7-1f5756e1dee7@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <9d434db2-fca5-4168-acc7-1f5756e1dee7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c07443-f8f1-4cc2-b49c-08df3ef87adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223327099003|261028144727099003|11063799006|4143699003|56012099006|261022075727099003|261026140227099003|261021121427099003|261009220027099003|261022115727099003|261022105027099003|261022113327099003|261102123227099003|261009221227099003|261009221727099003|261009223027099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: sX+rKh8O3T8YQh+VybfBzCZQkHBjlr8jTG/la8Fh5POGVUDz+Qk/pRjAOufzoL3DTzh2NrcnLmPG+DVJblYzZikGmS7rSnuy0fZgH70yXsPEOW5duYroUwoWU9MWxPruJZbCT9Hrrr5IYXunk0LP+8FTR7Gj/x1TWxEk3n8aZ5/oseUP321yAMQxMk135fGTvqAlzyfj3eAnOVsFyO4OyG2afS+GGpkBKRbtMugphvgay06lI7yfEokEahcdo5hjUhDeG5gi9vOJXSsM11XCvQLhnmkveQS7e9GyBeEC2ebIDoRQ7sSqliaQ6JUO3yA4jBEsVCeI4QbHpKnMIcauQT87vzwWOQ0zM5+Xz7vmSGc0dUpw974Kfz6E1xc+ZLTYsh4eYlIoZcbgW30LaMacTYosItxuKeqDVFYLsrDQVJaf2baOlQLv5KtMbG0ZqW7HF3inOYL4qiyWQhH8cTw0Wzao8UnVjT1Ty90ifsGPtizBzwe1QVID6jF5c2F7UV/3WTwf4QJOSncGLf7/YMSiFT8wLgdDBRb6m3Q518c+QHFHRks/BNoL+GGmdhMBjImfYNLwybkT9B9kPESZya/xuSexszPzCblmNXnEq9O/hBQqhKd/FW3aBCka+fqhGqC7g3Fef/tC/1qHoRHOiss3ZbLU9pZzNIxJBqO5n8KxIQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223327099003)(261028144727099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026140227099003)(261021121427099003)(261009220027099003)(261022115727099003)(261022105027099003)(261022113327099003)(261102123227099003)(261009221227099003)(261009221727099003)(261009223027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJpUDdCWlBVUEJjalVDcWFQa3JLdjRTMTJSczU4ZjRSTDh4UlRvVlJOQkx5?=
 =?utf-8?B?a2RpQU9SRStSK0R4RzhXb0ZkdjlmTEpTcEdVenZGWGtVdjF1S0htbVNlT2xW?=
 =?utf-8?B?QW9RM3Q3V1NYTG55d005dmluS3lxOENrTUs2Ym9ab081YWJRVmNJdjRIWFV2?=
 =?utf-8?B?UXh6Q0dHOVBPSG1yV3ZOTnBCMTZDU0REQ0M3M01ORTVRVWVUdXVVWDRQZ0tZ?=
 =?utf-8?B?RFdXRm84WUtXTUR1d2Z4TEJVd1BsazBJQ2VhVlhQWjJ0RExHbDNaWlpDVG5o?=
 =?utf-8?B?ZGxiUXROY3ZHSVZzN3JIN005cEhhSXdiS1NRV3lhdU5OMk4rc0NpR09XRmtv?=
 =?utf-8?B?WnlPSzBxT3lOMzg2bEhFdFV5c3l4R1gyMWhpUmlreWNvV0tPUG5CeTRrN1RM?=
 =?utf-8?B?d2t4bkZHblk3NjN6QlZTRVJiZ29Gb2NEVS83ZkExZGxaaWtxODlXQ0hJL2xJ?=
 =?utf-8?B?dTdwMGZ3MGNwQS9VMlYyWDJkUW16R2hXaGZPMlNUdWQzS25kY1R3YkxTSWU4?=
 =?utf-8?B?TDBPMUZSYWhJQlg0RkxKZ3lJMUhVYlE5YVVtd09zaFIwRVdzdXdDdXlMM2t2?=
 =?utf-8?B?bVh5NjZqdDRvQ2sybi9OcjR3TnFhdkhISmJVdk9xME9QRm9OSVRTZTR6U05M?=
 =?utf-8?B?ZmZLQkdCL3BQWk80dXVHcXdQTUVUazEwMXdtQzhzbm5iYlNQY1BUUUN0bi9k?=
 =?utf-8?B?N3BBenczU0x4Ti9aYVJtUDJtbHd5WDBxY3BPR1lIUUFpY2F5UGdENGcxdmFH?=
 =?utf-8?B?SWNQdDE4T0FUY3pud3hROEJZRzdlbmdFZmREM3M2dHlyczF3YXJEcWt4bzh6?=
 =?utf-8?B?TnFaMytDbkYvOHMxUzl0ck1PUE13QnZqcUdkZEY4UVdxU2Nkck5NRDMwU3hK?=
 =?utf-8?B?NktDMzhYY3YxekRoM01FRlBhMkdhZFZCSS95VDAzaExzLzkrKytQcmM4SE5s?=
 =?utf-8?B?cTAzZUhPY2pnbGRUSFN3eHByRlhjTWMrTnlaM1FSSkllYXVQY2NHbHNiYlJD?=
 =?utf-8?B?SWI0OWtYV2JOeGpWYTMyMmtIaWduTVlyN3FsSU5WWjhtQjk4MTJ3V0xjNi9P?=
 =?utf-8?B?TjJXMGo4eGp1MHF1a0huMnFnbkhrd1FjR0pjY0VQTzhXVlc4ZUhWVlU5YjJ1?=
 =?utf-8?B?dU1wSW9lRGpMdjVhcTVXMWlOalFYM0hoeDFucCt6OEw3UE00bE16bWlNaGZL?=
 =?utf-8?B?bUVoWGh0U1JKWU9VSm5yTW9YRDJxYXliZk1oczZtL2JlUDF6cjRKTEVxSEdR?=
 =?utf-8?B?S1RoSVM0cmtkYk1ZV1VPK3JvT0cxLzJFVlN5ZHNIUThYWEQzUUtPRUFKUXZC?=
 =?utf-8?B?bWkwMlpzdWFhMXNjNlVHZXpmTDRmaTIzbG9DZlc3cCt0WFdhMVN5S3BvNkgw?=
 =?utf-8?B?RlUxdUZqakRydWkzT2RzZVIzcEptRkRSN3pnUlg4OW92Uk96eVhVWDRseXRO?=
 =?utf-8?B?N2Z0a0RQNDlrWTNERnVFYjY0eko4TXlDRWloay9jb0gyaTJLMXV6cGRuSUxv?=
 =?utf-8?B?eTZscEd1YnlWMCtYMTg4OFA2MGdrdUc3eWVVeUFkYklGMmFEVW1yMGdvUm1J?=
 =?utf-8?B?ajhuTnQvN29tMzlKVXpPU3V2OEJuNWZORHE4TVByYXVZZDBPOFhuNllFYWhS?=
 =?utf-8?B?WmFaUVhxVjBadFZSaHBKZEJXeGZBVGJHNzh5OTcvTG9Nckl1UE5WRnJGZ2Fy?=
 =?utf-8?B?U0lEUkZvNGR3NmNpYXB5M04rSDJkSWkwZGVWSmVqNGxqSERIbVpycENmMjlr?=
 =?utf-8?B?a2ZZMUxlRCtZMCtySDU4enMwQXErR0NMS0RZWVpWbCt3V09Kbk1SVHJ0T3dV?=
 =?utf-8?B?aHVoeFdZQmx3MVl3QmQrTERZeW5MSkUrR3BPZnhNVGpldk1SSWlEMW94MUs2?=
 =?utf-8?B?SWVHY2lyYzJsRndWOTNyRC9oMDZLVHVNOHN3eGNKSGhZR3k5TlBVdXZLVkN1?=
 =?utf-8?B?bkF6OWQzYmxML0QvSU5VZ3Npb2JrKzNlN0owWlhWNThacUZtQjY1QWpaR2ZL?=
 =?utf-8?B?d1NTQmgwblp2d0tIemtlcFZWbEQ1elZNc1pJWjlTVUM2dktjdHR3bVBBRmV5?=
 =?utf-8?B?cE1henhoQVBoaktoVksveHdxRnFOanRDdTFRNEFIM1VzSk1mUlJiSU1SUUU0?=
 =?utf-8?B?VXczVmFaVHg1dGMrWWFiN1hRTkFtY3llQ2tQWU5Ud2xWdTdScEJFQytQNVNO?=
 =?utf-8?B?b1ZjakEzQm1oUDlTTURQQnBaeU53VmZJTzl0ZWxLMHpwcjQ0b0ZiZXhjSkpX?=
 =?utf-8?B?LzJWc240Z09OamQ1K01mSTVhUklTaUFXVXZCWHQwcGFVL1ZSdnJUcElZTnhy?=
 =?utf-8?Q?FBlqqRWebqXjQ/bSR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c07443-f8f1-4cc2-b49c-08df3ef87adb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:01:44.6471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Hghm2XErwf+baFwXDkkgEamS7H3uF0HMxyhtPhHuc0XFJPWbAKh8IKYCZQT7i67xowQsG8IObBJzZVhcDCKTA==
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



On 11/9/2026 9:55 PM, Christian König wrote:
> On 10/21/26 04:58, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Implement GPU page table mapping in amdgpu_svm_range.c:
>> - amdgpu_svm_range_pages_valid: check notifier sequence validity
>> - amdgpu_svm_range_is_valid: validate gpu_mapped and attr_flags
>>    against the requested attribute set, under MMU notifier lock.
>> - amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
>> - amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
>> - amdgpu_svm_range_lock_vm_pd: acquire VM page directory by drm_exec
>> - amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
>>    PTE flags per segment from entry->proto via attr_pte_flags, then
>>    programs PTEs under notifier lock
>> - amdgpu_svm_range_find_or_insert: wrapper of drm gpu SVM find or insert
>>    API.
>> - amdgpu_svm_range_get_pages: wrapper of drm gpu SVM get pages.
>> - amdgpu_svm_range_evict: thin wrapper of drm_gpusvm_range_evict
>> - amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
>>    pages, program PTEs, update PDEs, flush TLB, record attr_flags
>>    and mapped state); takes attrs + read_only and forwards them to
>>    update_gpu_range
>> - amdgpu_svm_range_map_attrs: cursor based iteration across attr tree,
>>    creating/mapping ranges
>>
>> - Add to amdgpu_svm.h driver private interconnect tags used in
>> drm_pagemap_addr.proto:
>>    AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
>>    AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 417 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  40 ++
>>   3 files changed, 461 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> index 72f954d2df39e..cfdc4e6d045b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> @@ -27,6 +27,7 @@
>>   
>>   #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_gpusvm.h>
>> +#include <drm/drm_pagemap.h>
>>   #include <linux/atomic.h>
>>   #include <linux/kref.h>
>>   #include <linux/list.h>
>> @@ -44,6 +45,9 @@ struct amdgpu_svm_attrs;
>>   struct drm_device;
>>   struct drm_file;
>>   
>> +#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
>> +#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
>> +
>>   enum amdgpu_svm_xnack_mode {
>>   	AMDGPU_SVM_XNACK_OFF,
>>   	AMDGPU_SVM_XNACK_ON,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> new file mode 100644
>> index 0000000000000..d4830e53f3d8e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> @@ -0,0 +1,417 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu_svm.h"
>> +#include "amdgpu_svm_attr.h"
>> +#include "amdgpu_svm_range.h"
>> +#include "amdgpu_svm_fault.h"
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_trace.h"
>> +
>> +#include <drm/drm_exec.h>
>> +#include <drm/drm_pagemap.h>
>> +
>> +#include <linux/mmu_notifier.h>
>> +#include <uapi/linux/kfd_ioctl.h>
>> +
>> +bool
>> +amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
>> +		  struct amdgpu_svm_range *range)
>> +{
>> +	struct drm_gpusvm_range *base = &range->base;
>> +
>> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
>> +
>> +	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
>> +		return false;
>> +
>> +	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
>> +}
>> +
>> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
>> +			       const struct amdgpu_svm_attrs *attrs)
>> +{
>> +	return READ_ONCE(range->gpu_mapped) &&
>> +	       READ_ONCE(range->attr_flags) == attrs->flags;
>> +}
>> +
>> +
>> +int
>> +amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
>> +			  struct amdgpu_svm_range *range,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page)
>> +{
>> +	struct dma_fence *fence = NULL;
>> +	unsigned int flags;
>> +	int ret;
>> +
>> +	if (last_page < start_page)
>> +		return 0;
>> +
>> +	flags = memalloc_noreclaim_save();
> 
> Completely drop that, this needs to be handled by the VM code and not here.

Will drop it.

> 
>> +	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL,
>> +				    start_page, last_page, 0, &fence);
>> +	memalloc_noreclaim_restore(flags);
>> +
>> +	if (fence) {
>> +		dma_fence_wait(fence, false);
>> +		dma_fence_put(fence);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +uint64_t
>> +amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
>> +			    const struct amdgpu_svm_attrs *attrs,
>> +			    bool read_only,
>> +			    enum drm_interconnect_protocol proto)
>> +{
>> +	struct amdgpu_device *adev = svm->adev;
>> +	uint32_t flags = attrs->flags;
>> +	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
>> +	struct amdgpu_svm_pte_flags_params params = {
>> +		.coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
>> +				     AMDGPU_SVM_ATTR_BIT_EXT_COHERENT),
>> +		.ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT,
>> +		.gpu_ro = flags & AMDGPU_SVM_ATTR_BIT_GPU_RO,
>> +		.gpu_exec = flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC,
>> +		.is_local = is_local,
>> +		.is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P),
>> +		/* TODO: add hive check. */
>> +		.same_hive = false,
>> +	};
>> +	uint32_t gc_ip_version;
>> +	uint32_t mapping_flags = 0;
>> +	uint64_t pte_flags;
>> +	bool snoop;
>> +
>> +	/*
>> +	 * The per-IP MTYPE / PTE flag selection lives in the HW IP specific
>> +	 * gmc_vX_0.c files mirroring amdgpu_gmc_get_vm_pte for BO mappings.
>> +	 */
>> +	if (adev->gmc.gmc_funcs->get_svm_pte_flags) {
>> +		pte_flags = amdgpu_gmc_get_svm_pte_flags(adevamdgpu_gmc_get_vm_pte, svm->vm, &params);
>> +	} else {
>> +		gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>> +		snoop = !is_local;
>> +		mapping_flags |= params.coherent ?
>> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +
>> +		if (params.gpu_exec)
>> +			mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>> +
>> +		pte_flags = AMDGPU_PTE_VALID;
>> +		pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
>> +		pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>> +		if (gc_ip_version >= IP_VERSION(12, 0, 0))
>> +			pte_flags |= AMDGPU_PTE_IS_PTE;
>> +
>> +		amdgpu_gmc_get_vm_pte(adev, svm->vm, NULL, mapping_flags,
>> +				      &pte_flags);
>> +		pte_flags |= AMDGPU_PTE_READABLE;
>> +		if (!params.gpu_ro)
>> +			pte_flags |= AMDGPU_PTE_WRITEABLE;
> 
> Don't touch the flags after calling amdgpu_gmc_get_vm_pte().

Will remove this.

> 
>> +	}
>> +
>> +	if (read_only)
>> +		pte_flags &= ~AMDGPU_PTE_WRITEABLE;
> 
> Same here.

Will remove.


> 
>> +
>> +	return pte_flags;
>> +}
>> +
>> +
>> +
>> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec,
>> +				bool intr)
>> +{
>> +	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
>> +	int ret;
>> +
>> +	if (intr)
>> +		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
>> +
>> +	drm_exec_init(exec, exec_flags, 0);
>> +	drm_exec_until_all_locked(exec) {
>> +		ret = amdgpu_vm_lock_pd(svm->vm, exec, 1);
>> +		drm_exec_retry_on_contention(exec);
>> +		if (ret) {
>> +			drm_exec_fini(exec);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Please drop that helper and always use the drm_exec loop directly.

Will drop this helper.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>> +
>> +int
>> +amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
>> +				  struct amdgpu_svm_range *range,
>> +				  const struct amdgpu_svm_attrs *attrs,
>> +				  bool read_only,
>> +				  bool flush_tlb,
>> +				  bool wait_fence,
>> +				  struct dma_fence **fence)
>> +{
>> +	struct drm_gpusvm_range *base = &range->base;
>> +
>> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
>> +
>> +	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
>> +	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
>> +	const unsigned long npages = range_end_page - range_start_page;
>> +	unsigned long mapped_pages = 0;
>> +	unsigned long dma_idx = 0;
>> +	int ret;
>> +
>> +	if (!base->pages.dma_addr || !npages)
>> +		return -EINVAL;
>> +
>> +	while (mapped_pages < npages) {
>> +		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
>> +		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
>> +						npages - mapped_pages);
>> +		uint64_t pte_flags;
>> +		unsigned long start_page, last_page;
>> +		bool is_last_seg;
>> +
>> +		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
>> +			return -EOPNOTSUPP;
>> +
>> +		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
>> +							    read_only,
>> +							    entry->proto);
>> +
>> +		start_page = range_start_page + mapped_pages;
>> +		last_page = start_page + seg_pages - 1;
>> +		mapped_pages += seg_pages;
>> +		is_last_seg = mapped_pages == npages;
>> +
>> +		/*
>> +		 * The struct hmm_range hmm_range field inside amdgpu_hmm_range
>> +		 * is drm_gpusvm internal state. It is not exposed to the
>> +		 * implementing driver and is managed entirely by the framework
>> +		 * as part of the framework logic. This amdgpu_vm_map_range call
>> +		 * always runs inside the drm_gpusvm notifier, so omitting
>> +		 * hmm_range here is safe.
>> +		 */
>> +		ret = amdgpu_vm_map_range(svm->adev, svm->vm,
>> +					  flush_tlb && is_last_seg, true, NULL,
>> +					  start_page, last_page, pte_flags,
>> +					  0, entry->addr, NULL, NULL, NULL,
>> +					  wait_fence && is_last_seg ? fence : NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +struct amdgpu_svm_range *
>> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
>> +				unsigned long gpuva_start, unsigned long gpuva_end,
>> +				struct drm_gpusvm_ctx *ctx)
>> +{
>> +	struct drm_gpusvm_range *r;
>> +
>> +retry:
>> +	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
>> +					    gpuva_start, gpuva_end, ctx);
>> +	/*
>> +	 * UMD doesn't set RO for some RO VMAs, but the drm gpu svm framework
>> +	 * denies no RO flag range insert for RO VMAs, so treat
>> +	 * -EPERM as an indication of RO and retry if not set.
>> +	 */
>> +	if (PTR_ERR_OR_ZERO(r) == -EPERM && !ctx->read_only) {
>> +		ctx->read_only = true;
>> +		goto retry;
>> +	}
>> +
>> +	if (IS_ERR(r))
>> +		return ERR_CAST(r);
>> +
>> +	return to_amdgpu_svm_range(r);
>> +}
>> +
>> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
>> +			       struct drm_gpusvm_range *range,
>> +			       struct drm_gpusvm_ctx *ctx)
>> +{
>> +	int ret;
>> +
>> +retry:
>> +	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
>> +	/*
>> +	 * HMM returns -EPERM when write access is requested for a read-only
>> +	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
>> +	 * VMA permissions.
>> +	 */
>> +	if (ret == -EPERM && !ctx->read_only) {
>> +		ctx->read_only = true;
>> +		goto retry;
>> +	}
>> +
>> +	if (ret == -EOPNOTSUPP) {
>> +		pr_err_ratelimited("range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
>> +				   drm_gpusvm_range_start(range),
>> +				   drm_gpusvm_range_end(range), ret);
>> +		amdgpu_svm_range_evict(svm, range);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
>> +			    struct drm_gpusvm_range *range)
>> +{
>> +	if (!range->pages.flags.has_devmem_pages)
>> +		return;
>> +
>> +	drm_gpusvm_range_evict(&svm->gpusvm, range);
>> +}
>> +
>> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
>> +				    struct amdgpu_svm_range *range,
>> +				    const struct amdgpu_svm_attrs *attrs,
>> +				    bool read_only,
>> +				    bool intr, bool wait,
>> +				    bool flush_tlb)
>> +{
>> +	struct drm_exec exec;
>> +	struct dma_fence *fence = NULL;
>> +	unsigned int flags;
>> +	int ret;
>> +
>> +	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	flags = memalloc_noreclaim_save();
>> +	drm_gpusvm_notifier_lock(&svm->gpusvm);
>> +
>> +	if (!amdgpu_svm_range_pages_valid(svm, range)) {
>> +		amdgpu_svm_range_invalidate_gpu_mapping(range);
>> +		ret = -EAGAIN;
>> +	} else {
>> +		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs,
>> +							read_only, flush_tlb,
>> +							wait, wait ? &fence : NULL);
>> +	}
>> +
>> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
>> +	memalloc_noreclaim_restore(flags);
>> +
>> +	if (!ret && fence)
>> +		dma_fence_wait(fence, intr);
>> +	dma_fence_put(fence);
>> +
>> +	if (!ret)
>> +		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
>> +
>> +	if (!ret) {
>> +		if (flush_tlb)
>> +			amdgpu_svm_flush_tlb(svm);
>> +		WRITE_ONCE(range->attr_flags, attrs->flags);
>> +		WRITE_ONCE(range->gpu_mapped, true);
>> +		range->validate_timestamp = ktime_get_boottime();
>> +	}
>> +
>> +	drm_exec_fini(&exec);
>> +	return ret;
>> +}
>> +
>> +int
>> +amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
>> +		       const struct amdgpu_svm_attrs *attrs,
>> +		       unsigned long start, unsigned long end)
>> +{
>> +	unsigned long addr = start;
>> +	int ret;
>> +	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
>> +	bool need_vram_migration = devmem_possible &&
>> +				   amdgpu_svm_attr_prefer_vram(attrs);
>> +	struct drm_gpusvm_ctx map_ctx = {
>> +		.devmem_possible = devmem_possible,
>> +		.devmem_only = need_vram_migration,
>> +		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
>> +	};
>> +
>> +	while (addr < end) {
>> +		struct amdgpu_svm_range *range;
>> +		unsigned long next_addr;
>> +		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
>> +		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
>> +
>> +		range = amdgpu_svm_range_find_or_insert(svm, addr,
>> +							addr, end,
>> +							&map_ctx);
>> +		if (IS_ERR(range)) {
>> +			pr_err_ratelimited("failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
>> +					   addr, start, end, PTR_ERR(range));
>> +			return PTR_ERR(range);
>> +		}
>> +
>> +		next_addr = drm_gpusvm_range_end(&range->base);
>> +		if (next_addr <= addr)
>> +			return -EINVAL;
>> +
>> +		if (amdgpu_svm_range_is_valid(range, attrs)) {
>> +			addr = next_addr;
>> +			continue;
>> +		}
>> +
>> +		/* TODO: add migration */
>> +
>> +		AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
>> +
>> +		ret = amdgpu_svm_range_get_pages(svm, &range->base,
>> +						 &map_ctx);
>> +		if (ret) {
>> +			pr_err_ratelimited("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
>> +					   drm_gpusvm_range_start(&range->base),
>> +					   drm_gpusvm_range_end(&range->base), ret);
>> +			return ret;
>> +		}
>> +
>> +		AMDGPU_SVM_RANGE_TRACE(range, "UPDATE MAPPING");
>> +
>> +		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
>> +						      map_ctx.read_only,
>> +						      true, true,
>> +						      true);
>> +		if (ret) {
>> +			pr_err_ratelimited("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
>> +					   drm_gpusvm_range_start(&range->base),
>> +					   drm_gpusvm_range_end(&range->base), ret);
>> +			return ret;
>> +		}
>> +
>> +		addr = next_addr;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> index 39db3a18b5f2f..e5a5f52166576 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> @@ -126,4 +126,44 @@ struct amdgpu_svm_range_op_ctx {
>>   	uint8_t pending_ops;
>>   };
>>   
>> +uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
>> +					 const struct amdgpu_svm_attrs *attrs,
>> +					 bool read_only,
>> +					 enum drm_interconnect_protocol proto);
>> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
>> +				struct drm_exec *exec,
>> +				bool intr);
>> +bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
>> +				  struct amdgpu_svm_range *range);
>> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
>> +			       const struct amdgpu_svm_attrs *attrs);
>> +int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
>> +				      struct amdgpu_svm_range *range,
>> +				      const struct amdgpu_svm_attrs *attrs,
>> +				      bool read_only,
>> +				      bool flush_tlb, bool wait,
>> +				      struct dma_fence **fence);
>> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
>> +				    struct amdgpu_svm_range *range,
>> +				    const struct amdgpu_svm_attrs *attrs,
>> +				    bool read_only,
>> +				    bool intr, bool wait,
>> +				    bool flush_tlb);
>> +int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
>> +			       const struct amdgpu_svm_attrs *attrs,
>> +			       unsigned long start, unsigned long end);
>> +int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
>> +			      struct amdgpu_svm_range *range,
>> +			      unsigned long start_page,
>> +			      unsigned long last_page);
>> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
>> +			    struct drm_gpusvm_range *range);
>> +struct amdgpu_svm_range *
>> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
>> +				unsigned long gpuva_start, unsigned long gpuva_end,
>> +				struct drm_gpusvm_ctx *ctx);
>> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
>> +			       struct drm_gpusvm_range *range,
>> +			       struct drm_gpusvm_ctx *ctx);
>> +
>>   #endif /* __AMDGPU_SVM_RANGE_H__ */
> 

