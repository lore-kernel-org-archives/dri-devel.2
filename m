Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D3AF5A8A5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 168B210EA89;
	Mon, 20 Apr 2026 18:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pH2vIn3J";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE2210EA89;
 Mon, 20 Apr 2026 18:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBriwsnjdqJKbuwFD+VY0LO/1FgR2VOhESKWxcbTuEQaPt1IYWSV4PbG+hwxt2U/esTsxPlpQPZJDQJJCKCWXUWf0X/vrTEoRf5BqRHTX0LHJ57LumH+wRn7W2mp1utRNdVInbFis1pSB6jxX53HrbXGCBN8gL7gYbtOSn4qfvzzzeFzTAh+7zfWyZPX+apT58OEeTkB34m0Gi154ro0Jcpvk6Zyz9Nd2wxjZbi/m96wJ6lcQAmJhyzgCYVcXcV3o+PI3BsRgna3/o4KmhDgYoJBo5GdnAY6hUS2QzCvOFiZ8W6IJNu7sx+424WoPU3gikBGlYz/rOIDNTNNY6eoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPAlIvq4Lhn1NEzJJgC+J0QJjCuEU3/rbsm2h1p7jes=;
 b=aNG+F+Lv95IQieMVZgwQPMN0Kba4gJ9AINpfd78QVPd+XBcZ9iKOGr6h8Vz08VoxuZEzX3W8sPQ4ABElYTj2C0njqNsnXZ15L51aqYlRddtUnJ93BdI9DaZBxymM1KYgq1qC0zL+hd74xGhxiZANvMrPJj5Go9A4awsdklkVKeaZKh77gicJViuNraO+f3mnQ4/cN5YuNLvdsvGWTwbJ0EiS2uJNGMfQGVAWhkCC9T6AvlL9CDDocB//DD+K+XFCtJpLSdDJU7ligD/wDltVxyXoABJZYDpnWplJk6cwmwMrjnoA2otylf08DVNNRl8qbeWqHHcQwlgaa75yMV4+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPAlIvq4Lhn1NEzJJgC+J0QJjCuEU3/rbsm2h1p7jes=;
 b=pH2vIn3J5uVDokrMNdZ1mkBKR/vQqWB79H+ogkjV0RER88uc6NHyiDDWeic/e8buKEGU2wCvVuw0DUIO7Z9ULQzPuT9hR6zzz1lMMWbdAMuA6AdaXvEj2lwxAN2ib1w6TEbAEtgH4XLPqTEZ3VV+BfgAS0D92A3W6TjCPFdUbVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 18:07:44 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 18:07:44 +0000
Message-ID: <e494689d-f126-4be8-8337-f04be1abd12a@amd.com>
Date: Mon, 20 Apr 2026 20:07:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Matthew Brost <matthew.brost@intel.com>
Cc: "Huang, Honglei1" <honghuan@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:408:d4::27) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbe3a2e-8af4-4212-60b2-08de9f07b8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: WNQzhPqLyi/DIBZU6PJsDLieF54QVnPTfF+7O+x6M0A0sbFhXCC1b14N2Q0sufPnJeOO2dZWEf6gxHzHx9nmSA+Byk9GwTdmM+dbmwuGc6/QvnD9sqR2HjxHVIWhww2NIrxmIegYXBfDeX4pTAsQ+4TdiKEW13T3tS4HuS8NGycuFsLei40mE6zXuTGo6ez0bluKGiZmKOHbehWOs2zwiDSaBAw2M6LaQX/u5aq5UAAQpFtNmRy8j5KJsR5XquaY43vuGL8a0c9vsO7AJHC8wpACFrDjF3JR/FbMH5yjBhmkmAwQ9bAk8r6/s6uQs21bb0snSUNl41BI8Y+m5wg545pzSZ0ONoaLzwFaq3uy4UtKIMaPZRf28+ryRpAk2+dKPXaXAwVko7dKFGlXQVYKXXEcmMX/aMpaWfqrwHP1EnfjdMquScOVIu1eh1qZrrKSrzoEAU9PmkwLd4b0qoJ9CXGVmn1uDe90/dTcF1LLgGZwJVsVVNCWFPbNTEvghyqMROVeXO9RZxJ9uKZ+Kx7S3kZNCoLJ0BLjoQtF28S0INRyfv/4kYxDg3qPdFMJo2lTJKebSMHnhMVBM0U8G+2LQJ15KIvLCPIUcA4mdxOvyMa5yrB36C858FvtIIlIAml7G6HpLfwvJXqHb+uUH1+CznQOOvgtbHt1VsxB72pWDcZsR6bfCquLEL976aX7s51zAJmmZV04viDn1pJp0liN40DBdrCYuuH5d0pHnwYZX00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xtQVRsYW1DbzhCSlBjbHBtZXp2NmY1MUlFNnNnR21xM1ZSZ05xbG4yWTdF?=
 =?utf-8?B?TUhDZzZ6UE81T3dXYnZyTHkzZHViT3h2VDV4bUFUSGRleWZzcEx4YkRYYWpK?=
 =?utf-8?B?aW9rRVIwK21YdVJRbElhWGFXVGtjRjlNdlVBQTZ3b3ZDVlkxOThLUDhCQ1ZY?=
 =?utf-8?B?S2RCQlhmNGQrSzI1anhmdGUvcXFyQ3NGRXc4ZXZCSlVkNDlqa1FnN2Z2L0pQ?=
 =?utf-8?B?VVhUcW5MWnNLTjJLYkxxNy9SSDl3VTZyNWRlU1RiTUp4a1BnUnhZaGIvaHI3?=
 =?utf-8?B?MnRhU1pIblpabGhLbEtGbUg0SWVkeWxidlhJa3hNTkt3QjhEVzQzWU92cmxj?=
 =?utf-8?B?N0NUUkQwOVJqV2hhakJMSHRCYVVCbnc2cDBIdWg5Uy9sbTZhNXZiTXo2OVB3?=
 =?utf-8?B?cXpZd2RHSytIaTB2NXZVRHRFYm5lbkM4c0RFS0E5OUtLSk9hSm9hcmUwb3B2?=
 =?utf-8?B?Wkx5MytheThBSmN1eDQ2RXcrQXh4SlF6N1hSdVlkSHljYWU5VEh5amRaNnlz?=
 =?utf-8?B?TXBZTGttWVQrWUcvcnJaTFMrcEFCYUJPcy94UC9hNVhyVThhSEswNTNWdWZa?=
 =?utf-8?B?dFVxc1JocnNZTmlmM2tSYVRTYksxUWFZQlp3T1NCU0dHWCtDY0kxSEhrVmg3?=
 =?utf-8?B?clBPWmhGNDhGd2paRFZTMHZrekx5K2hwVjJXeERIamFBczVFcDBKenhCeGw0?=
 =?utf-8?B?RjMyRDlyNy94eXQzRW5nbEhwTlI2Q2h1MUFrQ21zSCtmS28xSWE2czdEbWJV?=
 =?utf-8?B?MGVOT3VCdDdyWmhybkIxRW16dkx2UjlDSHhZTDkyQUo4d3NJM2FLNmtGUS9O?=
 =?utf-8?B?ems0eEJNQ0VlN1hRRWJxR2R5RzZIR1Vpd3lPbC8yWXJOYndyU1ZReEdNZFNa?=
 =?utf-8?B?dzlOeDVSNUtwczZ6YmZ6Y083WnU3RUt6Q2dpTUFaY2pKMkZhbXVTRmZnMk0r?=
 =?utf-8?B?aDlvdzlyV1dnWGNVY1QvWjNwbTF4V1dxRlpaZmNTaUpNeXNNVUppUTJGVVcw?=
 =?utf-8?B?S2Fid1ArVExFVGFueWJYQW13TkRyTTNxNFRHeldvSzg5RHJTWEJVbk5QcGsw?=
 =?utf-8?B?cGFXMjFIb1VPSXFBWjZoQXZVenFRNU5uOGJxc09lcXhNSmdGTU5LZW9oK0tm?=
 =?utf-8?B?WHdJTW9YM2ZxUkRkd3NUOU4zM25ESVBINjU0UkducjlSdVBxNVhwNDUyVE1u?=
 =?utf-8?B?ZFRnUEZoVUZMWDVTcXBKWDY5QlpvbytlbmpsajcyMy81eEFxQ0ZuYUljVTZa?=
 =?utf-8?B?RElobUpnWUFlS2VKZzVDOFN4Mk5NNXBLcG1vN3JmWGxxd0F4SC9zQzBNQTRv?=
 =?utf-8?B?WEo0R2FPdWRFN3dDLzd0aU5MeDNJZWpQcnlEVUFvQzRRTkl1cldmWWlYM3lX?=
 =?utf-8?B?MUh3aDljWlhaYnV2QTMydWx2S1J2Q1lKS2E3TC8rRE5SdndkL09Hd2tQVHVa?=
 =?utf-8?B?eWVxeTNvR2luNy9xU1NRR25LQmNDVXRGUUVBeS9YUUp5YkNPSWhqUjZIS1hv?=
 =?utf-8?B?RVF4cXFkMXdUdVdwanJWTWJpaEx0UjQ0VGhlMHloZU1aUVI5eUE0RjEwcnJX?=
 =?utf-8?B?YTFVRDUzVGo2eG1qOUsyYzR4QmdiM0F5d3lYYjRqQnV1eWZmWGNqL25JVVVQ?=
 =?utf-8?B?KzVIaVlob0pDS2daV25TenF2dGdKcmRiKzMwWmREYUVybFdwVmpvM3Y1Y1J5?=
 =?utf-8?B?NndiZnpNVkdUSUFkTjkvVmpTOTRkU0EzZ1FUbmRKbGFIeE4vdGRUSGVRMXFi?=
 =?utf-8?B?WitvcjN4ZVJhd1RDbFAxRGhWTGQrV3kvVlh3Z0MzOStYbnVjS2dkWURHT1FG?=
 =?utf-8?B?YWp3N0dJOW5Wa0d2a21sK25sUnNtaFZJZmNhZ3RkSlMzR3NiSVJiK090RHlk?=
 =?utf-8?B?Z0krT0xBUEI3Z2c3ZU9HTnVXcXl0M08zVkVQb3ViZFRsQm5TdHV0eERySHdy?=
 =?utf-8?B?QXFZVnNRSEdUaXlrZHRuMUg2YngxcjRIVXdqZHFHRG1uTU1JaEJabDdXZzR6?=
 =?utf-8?B?WjFPZnE1OGR5UGVBNW9pR3ZJNTc5NmgvQ3RlOXFyQUtMd1ZVL09ldU1TRlRt?=
 =?utf-8?B?ME1xUDRmdjhvRy9UM2ZaR0RndE5EZ3lHelpiaEtqUHhmeWVSOTRreGRNOWJU?=
 =?utf-8?B?eWF3RktsZzBpYkNnOXkwMTdqM0xFbmNEdm5iWk9XeDE2NE54NE90WXlsTnhi?=
 =?utf-8?B?Q3Vrd0poa3ZNY2hsb09iV21rSzMrZGlHa1ZXb2xsSlY4UjV6YWRTa0daZG5Q?=
 =?utf-8?B?NUxyUW9KaG9kcWRobjkvSG56dkNpNGg4eGk4QnViWmRZZEdiNHY3ZDIwbDJy?=
 =?utf-8?Q?59QkYaywjand1jjWig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbe3a2e-8af4-4212-60b2-08de9f07b8a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 18:07:44.6110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib2jvrw5Zey65AEs5pRIqoFjBOmSnoQ2hV0SZc4LhfOW/0fld5YyNWR4ekMQdM43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

On 4/20/26 18:06, Matthew Brost wrote:
> On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
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
>>>>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 39 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>> index 406a42be4..bed71ed9b 100644
>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>   #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>   #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>     /**
>>>>>    * DOC: memory domains
>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>       __u64 matrix[12];
>>>>>   };
>>>>>   +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
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
>>
>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>> +
>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>>
>>>> No location for device local memory?
>>>
>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
> 
> I have no stake in AMD’s uAPI, but I can at least explain how Xe’s uAPI
> works here—and admittedly, it’s somewhat goofy.
> 
> 0 == device-local memory, with first-touch placement on whichever
> device/tile touches the memory first
> 
> -1 == system memory
> 
> ≥ 0 == a render-node FD (which could refer to a local or remote device),
> paired with a region instance to extract the pgmap for the desired
> placement
> 
> I believe the reason this isn’t fully FD-based is that the compute UMD
> team wasn’t keen on exporting every pgmap as an FD, though that was
> something that had been considered.

That absolutely doesn't make sense to me at all.

> 
>>
>> Absolute clear NAK for that approach. This interface is per FD!
>>
>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>
>> We also need to make sure that setting attributes for different devices doesn't affect each other.
> 
> We landed on the conclusion that it is undefined behavior if different
> render FDs—or more specifically, VMs across devices within the same SVM
> address space—set different madvise attributes. I believe this was at
> Sima's suggestion.
> 
> From the UMD point of view, every madvise call therefore becomes:
> 
> for_each_fd_vm
> 	set_madvise_attributes
> 
> This choice was made to keep madvise attributes local to the per-device
> VM structure, rather than introducing some form of cross-device shared
> storage.
> 
> A misbehaving user can absolutely shoot themselves in the foot, but at
> worst this only ends up corrupting behavior within their own process
> shared across devices.

Yeah that makes totally sense.

As far as I can see the two interfaces contradict each other.

Either you set the information per-device and then each device only gets the information if it needs to migrate the page to it's own local memory or you have global information.

So why does a device fd needs to know about remote pgmap?

Thanks,
Christian.

> 
> Matt
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
>>>>>   #if defined(__cplusplus)
>>>>>   }
>>>>>   #endif
>>>>
>>>
>>

