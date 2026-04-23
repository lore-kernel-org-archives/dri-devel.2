Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F5F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D70610E329;
	Thu, 23 Apr 2026 10:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oW0RhL8o";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D33E10E327;
 Thu, 23 Apr 2026 10:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGNpkEv8vwTqPHLehILGCpJsHr6n5/0GMSnnCRxvNmWOpoReHsNuwMh/IbJ1Gbnwi3/XMs24SMb+u3dLGGrHxhKot31tXrBtYl4wmoksHI1ObmT0cxvck69PmSfNCdDOraXEOQ8ujeDvW6zC24zAwIg33nGT3l8cGJzyDvD+uUcpy/NEy/CEWNoD8O4u5kQT5hB6G+MvToLO+3sPZJtSW3z0Zc/Si4ROkfbka1rNPNfpa8B37JBc/5x6mi5xLwxw2LJIHTTU2g7vh5yGFnZIBBThbRiLqP3NlwAxQpqelRQ+6P1Gxo0Ndp1gz/2M3vFeiq9BtAId7OafKYcgBaS2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqyAl9REKMib+bn1pcgNqZnPguDZz4bkQ2G7TzVEAfg=;
 b=x8p508hKLTtRcz536gnRfLUwYpRDOEqb51EfbRE/Ahv+U2wU+bjmfJ8JJOGTRHC+fx6kg4DcSTbVBM8YWioH1err56bpv2gEc0DBHSXj5N6zj8j4oABmQ0GfVOuxqD7BFhvwAEbBQdXfxTZg6Vji8uGGSlpjSmOcHsaazMJeO+TFQ4Kszow1YrrUMYVWzB4qMibP9WUZq+yGxLSYn8whVtlQsM3HeRyFrgviiCa7oETTdPpLJER28u5pftWy7Ta8SwJU/n+NovwKe3KvX5ACZHnEl52A+/k9rpizi+7ESauIK/uVcIgeQwDuqkLdJRTt8di/bkPt8t6OQFk0B4KWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqyAl9REKMib+bn1pcgNqZnPguDZz4bkQ2G7TzVEAfg=;
 b=oW0RhL8ot+JamekRT8IE/hyL2l7ppU/bKE/on9OhuSD8F3cdoZcOZj2ZdMXrwKfJbG58hhiMzltwTu8b6ws1B4ebyWP+QiXkOutoIeOmjOCclFH2vxCXdghZmOoj1vwmwZNjn3WDNoHep2iV2T/8/Yqfnr611JWK74+sYto/Rdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 10:39:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 10:39:10 +0000
Message-ID: <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
Date: Thu, 23 Apr 2026 12:39:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: "Huang, Honglei1" <honghuan@amd.com>, Felix.Kuehling@amd.com
Cc: Alexander.Deucher@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:23a::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: e396b533-2796-4979-592e-08dea1248d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: D0petHyK0w1BMeKXaUrCGUKRzq/6SWuTGwfA1rIKYcOXLSBTZQQaZnzTJe4ptnzKTy9p0yhAulnZtVmfR6pglkBsGrtDVW9DP+QMDpon3nJ4Lcgzllx0YqiinnyVDlZET4dODNL2whINCq2dte/Jw/V58Cl4jdbobsyhKJ71erdsqbm571M+xxB1lB8pzaBH8dVy5bi55XGI3lEhxA6tlcu85A/egeW9LXyWQnOIs6dGs+/8MgwP/F3sMsPpcx5diKlSVgf8+L0s4vtp7ysuB2g2NQUNfFVchX6pIwXMv/qDQGi23okGnqDjAcxgWrgm+tdlVuOD+2ek0jFR33BgsGvRf6MTjghs4Kk4UNN7m+Vi2JyDxAcrQPsuugS4Y31hvLw867PM2+yX6sUbNVb2Ks3BGo3/XhETXW1JOb1tg8bZNLA7e7cAeoq8ZmbsrW0gVZr9v5ElJusZOZwHCSaRLygDIruGN1EwPYSP8csKfOlIFCYA3B8UkKPpGeTsj1SLE3D5CXfnwIyur3DHM0ucNKiWh7y3zfov+6PnOdq78bAEDWPBgYihSLwf8l14n7xXOEnJox5ZlmEFFAYPqUlJR+Kw+JBbKyn/fUa5dU1YriDooBstTTt7zjImmsVYZn1MqrK4S1JebaTji10JFeQWbSKnj8YSSyKbOlFzDBKFQRithnogGAPAdOXUJiK2hxuJ7sDOYLYDY2cQLgPHZ163JNcynhcTt8Yj9LKCRvxp95o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlzMmRFeDRJeVJKdDBDM2FhVlk0Y3M0T2RRbUVsdDZtblE1T25RY0Uwd0tK?=
 =?utf-8?B?Mk9sSm9uaFZJc2MzdTR2NkVhN0NyeTZ5ODh1bDhCaWQvZElKREVsZFptWWtP?=
 =?utf-8?B?cXlCUjl6YzNRbkt1K3QySE1FbForbjRlQ1lDQU40MHkzWGV6bXBpaTY2ZTN2?=
 =?utf-8?B?YkE4RlprMkluWFRGR1FBRXV1MkM4d2xabDcrZ2IzSHlpMzJ2dEYxajg4YTI2?=
 =?utf-8?B?ZkdzV1orc2hBaG9tQXZoYWxMZW1DR09yYlZtSW5BYlEyNUlISEl3dHdmNDRN?=
 =?utf-8?B?UjdZMmtka1ZZaUsza2JBVmFXUTJLR3FGbTBMeEVEU1g1ZTRkc0RNQjNQZ1VS?=
 =?utf-8?B?RmRRSW5ZeFIrM2ErY3p2NzI3R3RzQTRzMDlQdk1lazk5NXJvWTJ2LzBad21F?=
 =?utf-8?B?SlA3UWpBMVgxZVVHeW1OZ1NXT2hhQW1ZK1FLQVlVRVJnT2lQMVdEazNGcDkr?=
 =?utf-8?B?ZFBFeTlwUFdid1MzVlhub1FQS3Myc2NxRlZzSmVBRFFHL1Y2U09wZHJFY1hj?=
 =?utf-8?B?WThKWXRvRTRpdW8weUw5dXdwcEtubVliNElnejdDb3A1VEhmOE1nSzRjbTlt?=
 =?utf-8?B?NzJPcGVuMkFpYm9lT0IzaHJZS0o0bkY2cDNneEJCVnpCYUJGS0E5dEhSZW1N?=
 =?utf-8?B?QndtZW54WFVjbVJqWUNZWG1oVXk2S1Z3TW40dXZCSGFGeXpLaitoeWtDeUsx?=
 =?utf-8?B?WWRSNDJjS2JDMUNZZk1pTG02TmxnZERMZkpsbHppNndzQXZCTkIxQzVmVmhD?=
 =?utf-8?B?OWI5R2pGVUllcEFTcFhvZGovTXIyeFBzZ1BweEUxR250U2p6c2ZRQnNZaDFh?=
 =?utf-8?B?alF0b0RmSnZneUl5R2QzeTIzcjE2S3l1b2MvbXJ6L2RSeXExVTJjWnJmR3Mx?=
 =?utf-8?B?RGRnZHVOeHNNVFc5U21PZDFRR2thY0xrWjAwUVNWN3hhWXpUenVKUVRuM09q?=
 =?utf-8?B?ekJzbzZ4d3dTTm53dE1ZUzY0NEswYURJdzN1ZnNVS2xFS29FVSs0Wklhalhp?=
 =?utf-8?B?MWhYQi8yWE80djdOQTNtS1VvTHdwL0VTc3hsTW9STkVCRS9zem9jMzFnYzlQ?=
 =?utf-8?B?RmI2YnN2ODRIQTVJbVcrSEh3dVJJRURhNmVBWDNnQTRqSkZSTko0b0RaWWtu?=
 =?utf-8?B?bTB5ZHFvRmRVS1M4Sk9DMG5rMHVYWVkvUW8vQ0xwS3ZYbEMxc0k0SkZpNzNv?=
 =?utf-8?B?eWhFZGNMdXNCRmluYU9ISkljSkJ3VEIyOXA5bllLWG42M2ZPbFI4M0lwbDh6?=
 =?utf-8?B?eUZnRmhHQmJHMG9LR29qK1JaK0dSTm43aTRRemxTRzlXUDBVcnk5aE9FNW1G?=
 =?utf-8?B?a2hNT01ULytJWGYxWVRwNzkzVW92OFpkMjNJMVpKVm9nWm0wY2daQWhxb3Jl?=
 =?utf-8?B?MVMrdm5NWUdLT0ppL2t5R3JRaXd2R0FDaEd1SWxWL3lTK0JvS1MzMjBpaUpn?=
 =?utf-8?B?S2puWm0vT3RNUTF3bXh2YmVFY0V2QUwvOVJpRGpoZndxN0pSdlBjK24yZits?=
 =?utf-8?B?TW5UUHNJOUR4S1NhVURCVi9qZ1VISlZneWUrUG9iazhvTXhSNUJ3WDl0RkNp?=
 =?utf-8?B?Y1lkVUV1YmlDa2xXSmE4ZEh2aTg0dU1GZU96Q0tRYnVZY2k1TVYyYmV0UDQ3?=
 =?utf-8?B?TUVPMHVOOWtPcVZ5dS9UNHV6Y3Y5TXgvWWlGbExkNmNlY0dDdzZRMWJvMWF4?=
 =?utf-8?B?YXcramJJeFNUQnBVdWFpOUpaNitaNFdTcWRDcGpoRnhDOVVRRmhIbkpIOVIv?=
 =?utf-8?B?Tnk1UE9BakNDeHlDUkNtNkRTUm02LzZMS1paUEJqTWJJQkp3ZnpCd0M4UzRw?=
 =?utf-8?B?TERYalFwOHI1bEgvVTJoT01URkg3a2JzazA0Z1BzM3dPMGtxOXU2YzBzNnNr?=
 =?utf-8?B?TzhLUDVnd1JqY04zRnZlTVRRSmVZVXUrOFBZV1MrK0hpQUJWaFdIWmFObnZM?=
 =?utf-8?B?OVZjUTQ0YmxMWTJVSWN5bG9BRVJqMmx0YnljWTRYMUVDeVFYZWYzSmd4dGsv?=
 =?utf-8?B?TGlvUTNDQlJRNG9RWHpxKzNnMS9FRG5CM3ZaRDgyQmZ2eCsxYk1DbG9YR0Nt?=
 =?utf-8?B?Z1VzS0w2VnFESzU5T1Q2STVDN2hyYVE0empGM3dUOTBVWSsxOUxqc1BCWnI1?=
 =?utf-8?B?dmQ1emtQZnZMVWRLTWZhZXZmZ0tKZ05HMDgyK3dkQTY3cVV5dnZXaGYyay9j?=
 =?utf-8?B?YTAvbXRnMFU5N0piS2k0SStiNHJkY2d0V2owQW53bThjVyt6SkR4dXZxNWI1?=
 =?utf-8?B?M3EvRGZBZmN5UFRuYlFPY0xnNXowQWF6NmpBUFlrbnZCQU5JZFMyQTZnbUFU?=
 =?utf-8?Q?qut6fMxbMMprcrnRqg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e396b533-2796-4979-592e-08dea1248d56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:39:09.8810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: op+YKoHaB6e6SnxzcY/cpPvlfjqmuLvTrXWHolsHSG07n8YOp6U5lzaGuOC0Mzjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 4/23/26 08:21, Huang, Honglei1 wrote:
> 
> 
> On 4/20/2026 11:37 PM, Christian König wrote:
>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>
>>>>
>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>
>>>>> Add amdgpu drm SVM API definitions built on the
>>>>> DRM GPUSVM framework.
>>>>>
>>>>> This includes:
>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>
>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>> ---
>>>>>    include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 39 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>> index 406a42be4..bed71ed9b 100644
>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>    #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>    #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>    #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>      #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>    #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>    #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>    #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>      /**
>>>>>     * DOC: memory domains
>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>        __u64 matrix[12];
>>>>>    };
>>>>>    +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>>>> +
>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>> +
>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>
>>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>>
>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>
>>>> Why are those separate attributes? What is the difference between those?
>>>
>>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>>
>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>> it can not migrate, GPU only can access it in the initial place.
>>
>> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
>>
>> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
> 
> Got it so can I change the UAPI to the following format?
> 
> enum amdgpu_ioctl_svm_attr_type {
>     AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>     AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>     AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>     AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>     AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>     AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
> };
> 
> enum amdgpu_ioctl_svm_location {

The enum name could probably be improved, but apart from that looks reasonable to me.

>     AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>     AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>     AMDGPU_SVM_ACCESS_MIGRATE = 3,
> };
> 
>>
>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>
>>>> Why is that separated into set and clear flags?
>>>
>>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
>>
>> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
>>
>> As far as I can see just a SET_FLAGS should be sufficient.
> 
> Accoding to the reply form Felix, CLR_FLAGS provides a convenient method for deleting large-scale flags, do we need to redesign this part?

I think we should expose those flags as individual attributes then.

>>
>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>> +
>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>>
>>>> No location for device local memory?
>>>
>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
>>
>> Absolute clear NAK for that approach. This interface is per FD!
>>
>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>
>> We also need to make sure that setting attributes for different devices doesn't affect each other.
> 
> 
> I Totally agreed with your thoughts, but according to the reply from matt, it seems like we need to consider the P2P/multi GPU situation.

When the drm_svm or pagemap component has already code to deal with that then it is probably ok to have the same interface.

When when XE only hacked that together on their own then that is a bit questionable because getting the lifetime right is usually tricky.

> 
> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to modify the UAPI to align with xe_svm?

I think we need to full clarify how XE works here. E.g. that you can specify both 0 as well as give the fd to get the memory migrated to the local device sounds odd.

Regards,
Christian.

> 
> Regards,
> Honglei
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>>
>>>>> +
>>>>> +struct drm_amdgpu_svm_attribute {
>>>>> +    __u32 type;
>>>>> +    __u32 value;
>>>>> +};
>>>>> +
>>>>> +struct drm_amdgpu_gem_svm {
>>>>> +    __u64 start_addr;
>>>>> +    __u64 size;
>>>>> +    __u32 operation;
>>>>> +    __u32 nattr;
>>>>> +    __u64 attrs_ptr;
>>>>> +};
>>>>
>>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>>
>>>> And we usually use unions in this header to separate the input from the output parameters.
>>>
>>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +
>>>>>    #if defined(__cplusplus)
>>>>>    }
>>>>>    #endif
>>>>
>>>
>>
> 

