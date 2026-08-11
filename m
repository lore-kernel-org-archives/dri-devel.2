Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C98C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F83A10E86E;
	Tue, 11 Aug 2026 13:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/MaLKzA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E1A10E1BC;
 Tue, 11 Aug 2026 13:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2QlHVIm/umi1Y9ZPeJ8uXcqhInjJLXl9j8Hz6i5R9fz83p7tV6pjassq4KDc6klOrZ/LbZNSplJThxpjBOFSLlFAvA/hc8QgIzeneEjKgUbPAT775x9OLQqUpAIjzOqRpWxX+7qPR5svcS8b2tn8qlWtqwR4FRtuN0fGLWkFPY5iY4Ohab8Fii0QSOXQss1booMIrfJyy3v5L0TK0inqdk3C9Zdc1DqChMGAKdUItnSB04WCRdf+wfGUrl57TquZQUWrzQf96aXox6dA5OvNc7WW1k4hv6nm5IiUw0NCAkKkJumX7d5CchcML4vvA7mUHzIxNVuUoxTA18vKSvIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6XH6J1fF0TDwDF8AGzjGXYhx0Th4iB+uWdsNXoH7sk=;
 b=H69z76FiGh6vjEBkY6MvEpuDOkzvPLKCcYgK2qFbbf3g8qgo48oOd/EuYQ+6XsYyols9xpXpyTXHDi6cXwzDssZUBRCvk0/C6ug9R3oVyaoIPQemhHf54RhdMVFpDc9YVtGIrunEKJk6ZbtICqSI9ye6gjvVTYRAOKnQHVjMJp0QA0+CVOcLXGYaHEqbNgmo26TN3/tpz71pW90QVY9GVAKF/sBcv8tY/WYvUCcYsmhslQ5Rbh7bfqBDyxBs2KtQYutHFwPrrcp3cxf8EKHtULjgEgf9JMj/ZC70G5tyM9JRGkKWJbuqzVKFIkt5OsdFsYD6uiGkaeIauvmGZArJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6XH6J1fF0TDwDF8AGzjGXYhx0Th4iB+uWdsNXoH7sk=;
 b=F/MaLKzAMpJ1kqYfq7CHokj7EN6JiqbibXOkJQBDIMGlp9VraXrUfDdUdzt+9X9Z0RRkUFPwT3N0BMKi4IWj6BpPPnU683D7TtN0SVMfyPCy25d57yJLks+ZkIT7LL/m/digpf08vwdwaAb4nFAotpuyG86AqtwlaTVgDgJrue4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 13:43:06 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 13:43:05 +0000
Message-ID: <8909134f-a550-4ea1-8f56-21b121d92db9@amd.com>
Date: Tue, 11 Aug 2026 21:42:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/18] drm/amdgpu: add SVM ioctl UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-2-ray.huang@amd.com>
 <461e376f-afb1-440f-b534-3784c830ae63@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <461e376f-afb1-440f-b534-3784c830ae63@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c6439c-d709-4383-2452-08def7ae78c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1nB2Mi8G5SwDPWZb/bwvuTIKsF+nms6yq972DbzGvyZcEb3ngz67Qb2raCS8OTSH6GFnNw8XivmK+z2egtKYvUiSSiwKWm1lgPLnTDR0BUXqcNCtkDzs1471vYMdZ58XniWz1uVbxVDIjb9FtISIN89NNmzHVYwypUsMbVCkBeParhNWoxYCfRi2QhRY1/i3SVfjX9biAxpW8bEutjHOUoM9+8/AH++Se6Mk6WYo4HAPa9lLv723c7nfc/WxOC6lRQcSFjtKBPyJVF+U4v/GutUJ6lbsFaI5JZAhw2XXtR5VIiPqWyeu1Dkp2MdFh9CinWf/V66QZJ6Lvfp4erJS8o9e6XI9m23arOKKgJyaUzLIEdMaRPO2diIK6PrFXsWwHyNYkQFqMUG8lJjAveHRTp9zygUE8agQ1fbBbHVG7vxt4bBP7jdDX6U+4e+66p8QbXHQIgNoxSIKm2FX7m8d9xX1U+zqp6LBgBSGF7lp3Wm1jt14xa+zHjTepocXMR7tTnnDI0sM49e1OmmR3qDTuxgase+LUcjvABbtKWZD9d/TqazSNZA3ratdl2j8TlIqA/S3NzAkACtIRnnioEwlvwX7/yh3OY4k1WpqExVrO4tYEF8Z4WZfgB9YFIe/Ggu57+Et8zE7h4Wv2rRtnMa5455NxEuoKeZZXQL/Lncpyy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFHRUtQRmhCY0ZuUVd6cFJkdGExMDBnNHhuUm1Xa2RpOTlzcHErSzNoYjBD?=
 =?utf-8?B?TXhLbEtjdU84TnJRY00yNEZnUXZKeUdIS3J3blE1ZUo5RFJnVWU0dysyV0dh?=
 =?utf-8?B?QmFVMnhhNFFjd0hpelNETUdIU29Ga29NYy92TzBrRVhQcDc2OEl4YXZZbjFw?=
 =?utf-8?B?ZFFrVVJVb3MyOEhCWkF2dmtFS0wyZFZTaWVaNFhrRFNGZkMyRmlqNWJCVXFH?=
 =?utf-8?B?d214NUc4WFh0L2lUUVM0R1ZzMHk4MS9IZ3Vzd2wyTXN5LzRXY1BZUHdnQzRt?=
 =?utf-8?B?dEpiVy8vQlhVaFQrNEZjNFZIbllKNkxEaTdXdGIwZEtKN2htMVJXc1FqcTJv?=
 =?utf-8?B?ZitZaGg3RDNhNEhmN251TmM0RFJlaDgzWHBJMDBpVlBmd0VZTVFpQTNWczhr?=
 =?utf-8?B?RDlidEZVYXBBM3hYTC93Ti9qRHJTU09ZRHJJWVRYNmtOT3VvSnNpMXlpem9o?=
 =?utf-8?B?QnI4QWxKSTJZMkhkc2JCSTM2Y2dHaFJmK2lYOFNRN0hQQ0N5ZlFobHNyMC9m?=
 =?utf-8?B?aElMOG1LSXhQYWlGMVBEdEQvL1VySFdSbVBScEg3ckVWZUtFNGJkMFlYQjVi?=
 =?utf-8?B?Y2dqanNaakJGaEdmZnJLN0IvaXRUMnlndUlQYnNhbUsvNWhqUTJWS3lXZEUx?=
 =?utf-8?B?VEUvVmpmV1h0SDROcHBGOWhmTFFVSHN1c3RkN3dhc2ZMVEY0S2poSUdwdHdU?=
 =?utf-8?B?N2NUYzdicGxHbFU2RGZVWXJSVWR5M21ZTEptaVFLZEdVM1o4elBsS2xJRjJ1?=
 =?utf-8?B?a3FyY0E5L1BOZGVzK3F6K1d3bDRqdXN0ajhKUXhjSTBqWHcwUjRrYkgvT1FZ?=
 =?utf-8?B?QWNWOVIybTg1VUVHdTkyeTBOUDJpV09GTkhvcjF6cm9ya0JaU3J2WHdCLzBO?=
 =?utf-8?B?c0x3U3Q3WGVLb3dEOVRQQjF1TzRseVRtY2JwZTN1c2h2TmFFSmROMVpWc0lV?=
 =?utf-8?B?N3BYd0dTKzB3QUtma01xSy9UUE5xTWxjZDlmaFZaSDhNaWZyOFpwMU1CaTBC?=
 =?utf-8?B?cTNQNjVYL3JyTGdERmJIRE5xMVMvZmJmN2RYWHpLK01BRVBVRUlHQlRmMnV6?=
 =?utf-8?B?K3piaFhHZmpjUDdQdXNjNGxwYVFhK01VeENtNVFYdDliUm84OC9PZVVFRi9r?=
 =?utf-8?B?UThsVnJ4YjdXNThoLzcwUlZSWFd2eTRIUnBHVDE1Z3NCanVkbUpHd282cmtS?=
 =?utf-8?B?ZkNrbkR6OUY0RjI4aUQ1M1hsY2R2czgvUVB0SEh0aFNlVW9yOGJKclcrUDRw?=
 =?utf-8?B?WFV6MTBZUUd5NHRvWE42ZHppeEozVzBTTmZtV2JVc0h3ZFNCL3d5RlhyMUxo?=
 =?utf-8?B?cy9zK0FMVHZQcm9EVHhJcDM1SURLckkxVnRGM2lvTHZtNnNvc0YzSkRab2Ni?=
 =?utf-8?B?TWJLMWFmL2RBamdGVWpoMWxscDU3dlQ1cExuTEJSbkdBMWtydTFNMXI1UDRY?=
 =?utf-8?B?QzJmbnVLWnF1VVcveGl3Wi8wUGhORXhkbU43NFFveTQ0c3lmWUhtVTc2NzZq?=
 =?utf-8?B?OW5GS1JhRDdlZTBDYm1ML3ErTFgzcE9ZVnlzRG5rZ2RTdUlRUEg3QnlUa043?=
 =?utf-8?B?bS9PaEp5TTVaWWZoZFVMeWZ6blhFNXBLdHQ5Wmh3Y0xzWHpySkxob0ZPSkdS?=
 =?utf-8?B?MHZEbFJibnNQVk9OaDU5Ukc4Y25oL1dBREhjTDVsODIrckRMSTI2NEEwNE1m?=
 =?utf-8?B?akZNajNGRnh1ZWplRHNQck5aMWk0TzROWjVDTTVuWUt2SC9YYk15VDdubHZM?=
 =?utf-8?B?TzBNeTBvb1J2SnJSdkN1WVRsMmNzQXFkYnRld2o2V3daSWFmMmxLcW9qQkp2?=
 =?utf-8?B?MnluM3ZFakFEeWlaSkdwSGlRTVhycWZQQTBkU0RadGo2NFlzMUFyS2E5bWhI?=
 =?utf-8?B?Z0wwV3J5Q1k3aUd3M0hWSHdqb25kcHUrMklhSk5lL1FrT2o4WmJkY3FjM1RK?=
 =?utf-8?B?V0xlL0pHZUVlYm4xOE14bEQ4aEYvQkk1aFBCMDd0Wk4xaG8xZ1kxSXBnY3dM?=
 =?utf-8?B?Q0Vld2RqT0FWZFJJdXFJcDNrV25BYU9HMG55am9jRzlrcEsxYTNBNHA5Y0kx?=
 =?utf-8?B?OUU3S2JRMzVkM3cvTUE3aDU1MTMzRERNMkQwZWx3UytLSUQzWmdtN1B5bUt6?=
 =?utf-8?B?WXFvZHJ6MWJ0VHpOTGNNUVdBS21RYmFzbmwyK2lRQ1hwZ3l4VHpzM3BUSkdE?=
 =?utf-8?B?UnV3MDlWSWV6a1N3ekVEbG1ZbmVINGZqK3lFVm1tWDlhd05KeUFETVM3dEF0?=
 =?utf-8?B?TmcvQ3k4MHZ2eGNYcDlSS21HZTF3amhFY0JzNkd3UEFabDhJcU05WHZnelgv?=
 =?utf-8?Q?uOqE1t9RpO6NhISKYr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c6439c-d709-4383-2452-08def7ae78c8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:43:05.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seQXepicA17/VuP0it7Nz955KLI5KTE3Bzm7DOBwPqv2mF6476d60CCK/0LtFdrHJeYJlkOVc1SLSKLmHawILw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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



On 8/11/2026 6:58 PM, Christian König wrote:
> On 8/4/26 11:42, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Define the following ioctl structures and enums:
>> - DRM_AMDGPU_GEM_SVM ioctl command and DRM_IOCTL_AMDGPU_GEM_SVM macro
>> - enum amdgpu_ioctl_svm_op: SET_ATTR, GET_ATTR, RESET_ATTR operations
>> - enum amdgpu_ioctl_svm_access: INACCESSIBLE, IN_PLACE, ALLOW_MIGRATE
>> - enum amdgpu_ioctl_svm_location: SYSMEM, UNDEFINED
>> - enum amdgpu_ioctl_svm_attr_type: PREFERRED_LOC, PREFETCH_LOC, ACCESS,
>>    GRANULARITY, HOST_ACCESS, COHERENT, EXT_COHERENT, HIVE_LOCAL, GPU_RO,
>>    GPU_EXEC, GPU_READ_MOSTLY
>> - struct drm_amdgpu_svm_attribute: type and value pair
>> - struct drm_amdgpu_gem_svm: ioctl payload with start_addr, size,
>>    operation, nattr, and attrs_ptr
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 106 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index b32c72a662b61..4c49cd36f0e77 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -59,6 +59,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>>   #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>> +#define DRM_AMDGPU_GEM_SVM		0x1B
>>   
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -81,6 +82,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>> +#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>   
>>   /**
>>    * DOC: memory domains
>> @@ -1694,6 +1696,110 @@ struct drm_amdgpu_proc_options {
>>   	} kfd_sigbus_delay;
>>   };
>>   
>> +/**
>> + * enum amdgpu_ioctl_svm_op - operation selector for DRM_IOCTL_AMDGPU_GEM_SVM.
>> + * @AMDGPU_SVM_OP_SET_ATTR: apply the attributes in @attrs_ptr to the VA range.
>> + * @AMDGPU_SVM_OP_GET_ATTR: read back the current value of each attribute
>> + *                          listed in @attrs_ptr for the given VA range.
> 
> 32
> 
> To read out the attributes userspace needs to give the start addr and attributes and get the size the attributes are the same in return.
> 
> Only this way CRIU is able to read out the attributes from kernel to userspace.

Will modify the get attr accordgin to your method.


> 
>> + * @AMDGPU_SVM_OP_RESET_ATTR: reset all attributes for the VA range to their
>> + *                            default values. @attrs_ptr and @nattr are ignored.
>> + */
>> +enum amdgpu_ioctl_svm_op {
>> +	AMDGPU_SVM_OP_SET_ATTR = 0,
>> +	AMDGPU_SVM_OP_GET_ATTR = 1,
>> +	AMDGPU_SVM_OP_RESET_ATTR = 2,
>> +};
>> +
>> +/**
>> + * enum amdgpu_ioctl_svm_access - values for AMDGPU_SVM_ATTR_ACCESS.
>> + * @AMDGPU_SVM_ACCESS_INACCESSIBLE: GPU must not access the range; any access
>> + *                                  is a fault.
>> + * @AMDGPU_SVM_ACCESS_IN_PLACE:     GPU may access the range
> This needs more.  only at its
>> + *                                  current backing store; the driver will
>> + *                                  never migrate pages to local VRAM.
>> + * @AMDGPU_SVM_ACCESS_ALLOW_MIGRATE: GPU may access the range and the driver
>> + *                                  is allowed (but not required) to migrate
>> + *                                  pages between system memory and local
>> + *                                  VRAM to satisfy the preferred/prefetch
>> + *                                  location.
>> + */
>> +enum amdgpu_ioctl_svm_access {
>> +	AMDGPU_SVM_ACCESS_INACCESSIBLE		= 0,
>> +	AMDGPU_SVM_ACCESS_IN_PLACE			= 1,
>> +	AMDGPU_SVM_ACCESS_ALLOW_MIGRATE		= 2,
>> +};
>> +
>> +/**
>> + * enum amdgpu_svm_location - values for AMDGPU_SVM_ATTR_PREFERRED_LOC /
>> + *                            AMDGPU_SVM_ATTR_PREFETCH_LOC.
>> + * @AMDGPU_SVM_LOCATION_SYSMEM:    back the range with system memory.
>> + * @AMDGPU_SVM_LOCATION_UNDEFINED: no preference; the driver chooses.
>> + */
>> +enum amdgpu_ioctl_svm_location {
>> +	AMDGPU_SVM_LOCATION_SYSMEM	= 0,
>> +	AMDGPU_SVM_LOCATION_UNDEFINED	= 0xffffffffU,
> 
> Please make the AMDGPU_SVM_LOCATION_UNDEFINED 1 here and add a value AMDGPU_SVM_LOCATION_LOCAL and AMDGPU_SVM_LOCATION_HIVE.
> 
> The XE idea of giving the file descriptor of the device driver to prefetch to is a clear NAK from my side now. This whole concept breaks as soon as you add CRIU to the picture.

Will change the flags according to your comments.


> 
>> +};
>> +
>> +/**
>> + * enum amdgpu_ioctl_svm_attr_type - attribute selector for
>> + *                                   &drm_amdgpu_svm_attribute.type.
>> + *
>> + * @AMDGPU_SVM_ATTR_PREFERRED_LOC: Preferred backing location for the range.
>> + *	Value is one of &enum amdgpu_ioctl_svm_location.
>> + * @AMDGPU_SVM_ATTR_PREFETCH_LOC: Prefetch target for the range. Value is
>> + *	one of &enum amdgpu_ioctl_svm_location.
>> + * @AMDGPU_SVM_ATTR_ACCESS: GPU access policy for the range. Value is one
>> + *	of &enum amdgpu_ioctl_svm_access.
>> + * @AMDGPU_SVM_ATTR_GRANULARITY: log2 of the migration granularity in pages.
>> + * @AMDGPU_SVM_ATTR_HOST_ACCESS: Guarantee host access to memory.
>> + * @AMDGPU_SVM_ATTR_COHERENT: Fine-grained coherency between all devices
>> + *	with access.
>> + * @AMDGPU_SVM_ATTR_EXT_COHERENT: Fine-grained coherency between all devices
>> + *	using device-scope atomics.
> 
>> + * @AMDGPU_SVM_ATTR_HIVE_LOCAL: Use any GPU in the same XGMI hive as the
>> + *	preferred device.
> 
> Please drop that one, it should be covered by AMDGPU_SVM_LOCATION_* above.


will drop it.

> 
> Regards,
> Christian.
> 
>> + * @AMDGPU_SVM_ATTR_GPU_RO: GPUs only read the range, allowing replication.
>> + * @AMDGPU_SVM_ATTR_GPU_EXEC: Allow execution on GPU.
>> + * @AMDGPU_SVM_ATTR_GPU_READ_MOSTLY: GPUs mostly read the range; may allow
>> + *	optimizations similar to GPU_RO, but writes still fault.
>> + */
>> +enum amdgpu_ioctl_svm_attr_type {
>> +	AMDGPU_SVM_ATTR_PREFERRED_LOC		= 0,
>> +	AMDGPU_SVM_ATTR_PREFETCH_LOC		= 1,
>> +	AMDGPU_SVM_ATTR_ACCESS				= 2,
>> +	AMDGPU_SVM_ATTR_GRANULARITY			= 3,
>> +	/* Boolean attributes below: value must be 0 or 1. */
>> +	AMDGPU_SVM_ATTR_HOST_ACCESS			= 4,
>> +	AMDGPU_SVM_ATTR_COHERENT			= 5,
>> +	AMDGPU_SVM_ATTR_EXT_COHERENT		= 6,
>> +	AMDGPU_SVM_ATTR_HIVE_LOCAL			= 7,
>> +	AMDGPU_SVM_ATTR_GPU_RO				= 8,
>> +	AMDGPU_SVM_ATTR_GPU_EXEC			= 9,
>> +	AMDGPU_SVM_ATTR_GPU_READ_MOSTLY		= 10,
>> +};
>> +
>> +/* One (type, value) pair carried by DRM_IOCTL_AMDGPU_GEM_SVM. */
>> +struct drm_amdgpu_svm_attribute {
>> +	/** AMDGPU_SVM_ATTR_* */
>> +	__u32 type;
>> +	/** Attribute value; interpretation depends on @type */
>> +	__u32 value;
>> +};
>> +
>> +/* Argument for DRM_IOCTL_AMDGPU_GEM_SVM. */
>> +struct drm_amdgpu_gem_svm {
>> +	/** Start of the virtual address range */
>> +	__u64 start_addr;
>> +	/** Size of the range in bytes */
>> +	__u64 size;
>> +	/** AMDGPU_SVM_OP_* */
>> +	__u32 operation;
>> +	/** Number of struct drm_amdgpu_svm_attribute entries in @attrs_ptr */
>> +	__u32 nattr;
>> +	/** User pointer to an array of @nattr struct drm_amdgpu_svm_attribute */
>> +	__u64 attrs_ptr;
>> +};
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
> 

