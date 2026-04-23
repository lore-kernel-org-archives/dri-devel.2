Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A5CF99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E868510F0B1;
	Thu, 23 Apr 2026 11:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CSDa2XhH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF67510F0B2;
 Thu, 23 Apr 2026 11:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWOKFhlZVBUIjwRuMEdEm2Kqu1eVgR1qdGbKuf+IaCHAWTN8SDnbF4bTLwT0w7vTHRTcyuJ/YpKei7nQ9/1zqq0BGdgPOr4mz6xY8kCORwhApPqn5c3beyaGySESrYoprwLsZWImKZUew0OKwK9hQO/AHByhiqq65DqphJI2eIDnyPvxjStH1EUcjKtWjrkt+eHeA3eJ1ERVv8vUU5Kk8lN8MaTfNVs1fqbNGtmp8VpMRSDCPGdH7VYLNHSlXM3RcY+Wii3ylLmm4ZX4ZHMPBLmCcYG0eGd+AGNU62AQYLdP0FdHnGHzytslWMcK1nVAtzd2op3aAT0iIJ4yYrFQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHFXyITl+mDeYZUKzmqAsJP3HpCRJF/BjJEUGeFZ+uQ=;
 b=A3YUIgfuOLwytBB8689SCbSuxiMCMu2gK58gOj4vSarIuO6Oc/BzzNcHzn3xZouvO87seM5mgYn1x6ETxpdreR+JreLxPdnLWKLeE6HJs5Gwg2nmdRClDHr8TFNDD3NPbdqFLhgNkvXaLl2CXU9NpuP6g74e8CzklSkRsEByLiUIMsz0bgwyTXsi3yP/0i8duixoq06xRUFScm0Fi7I4KHrHNduWRSutOXxMnArKf2WKdQEN0BFQZrpTmayIqWjqWec0vO00Mzl4muc3SsPLnZmsjReO9EXiZl+o/2LTNqto7y4kWoeB2KBaS7fM15eqNJp/ozZJgbTFgNKZeWWNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHFXyITl+mDeYZUKzmqAsJP3HpCRJF/BjJEUGeFZ+uQ=;
 b=CSDa2XhHAg/VpQHUyvY/FvyXhyWEMMcoCnF6F15Wsm38lP8P8zwO1DR393jUk3aFYh8OSpqjRbM1/ribbB4m+hcmDgB/lqjH3yJyNYepRJQ2HcS1h96VSLHAt5d5Xk6MOS+im3bk/bSWOozvrMz3UBtx7Ap6Zd62JcIs2ofkEJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:06:53 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 11:06:53 +0000
Message-ID: <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
Date: Thu, 23 Apr 2026 19:06:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix.Kuehling@amd.com
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
 <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd9e88c-8b7e-44c4-56dc-08dea1286cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: sJxdBYaQTW1ohfcGKwAW4gEeqkirTgYV5cyQv+SSN4WK9hBQdq499m5OVeNmYuL4KhWgbaRmTGrKqtptn4DvIfueQ5cw7XZApzlNBb0ME02z+KreIDn8dIxm2LAJ98zPGcUL7KVNxHh/xcl3helKSmfPa/NbLdEPtuJsj+WikvUIPPprkB02ItAqvbbNKIElAPe0fy3O/X/3WE2bJD0WML+g5kn/E3ds0LGM2vtZQP5ewX1AD6w6imADXicO1EI3yszlvPDMkg54v00+UK+xm7SsQBkiEGGz1G+Z8fBUBYgGcJvQiVRx/KhHfcBBYx7wUDJjaMoMNTeDreV03nx9ZSegL8OYLpO0cNriExMxhd8s9ESahsZLYqxGNJZ4FnaC3/euHzkhe8JuIQ27dvyhOr3jLGhUtOF8Sl6hPLswTNYI6g22KEgUfb9iXjHZ0X78LHGwhJW/E4+7vxYzz0yX4m+foi7do2rIBeQ36nYjZSzgcXPg4JUWqIgCv04GcLaDc0BQtkYmYeBPuFZbXofmbGuP/t32SwQ4s31zwvzQnW1Q/ssP4eJxUrSxvGbZ2aOZYQgEaNg7Fc1OcOLqfJ2X0gryisGTIcUtFbtNi6ytcpYR+V+0J9pffo75kO4Sd5gu/vSPW8hF30K20EFvgjBF9Hqj7lSnJbfcvYzg/49vtHTfux4NAXcuZtxZziOfQE9PScopxRruGR3RgXA37MWVZ6Ekr/VXGItOvc12SxMo8Rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RZWEJvcEdSMjRsSkNPR1ppdENsRld5Q1pKMUtSWWtXeUxJbVd5YnN4dHkv?=
 =?utf-8?B?Rm9QUnIrb1hqcHpPUHYweWUvNmRraEVlQ2lCa0VUM1R3bndyU05VVE5aOHhB?=
 =?utf-8?B?LzMxZEJXNWcyQ1NkZkVlQVo1UjgvUUIxSmUxR014QTlaVVVYVjR1QUdyYUZM?=
 =?utf-8?B?aWlRR0hPT1NGRjdPbUR4blZ6RFFoU1F0UDQzRTd1RmFDdUUvTkk2TEhucnBr?=
 =?utf-8?B?Y3A4NUtxQ0ZUSmh0TjZBQ0dOUDVBUHdjZGhoSWNyRms2WXQ2MzRBSVJSSzU1?=
 =?utf-8?B?MWxFNW5XUXFKRHZxSDBEMnd2ckhudTBSVDh2ZW5OZVUrTkV2elhkK1B3cHpC?=
 =?utf-8?B?T0NQdGZjUkFwNWo3UVFtdmpPV2R5NGhUcVI2azIrUEFNUjVJMDlOUFZ1T21x?=
 =?utf-8?B?M1FHc0FHNFFkaXE2cTVzWUgyRnd2UnhETDVoREVPNmhQdlBDbXoxOGE1OS9P?=
 =?utf-8?B?YUJCQTB3eDRWbC9XdHZsOEVxaCtONzNUelZNU1FrU1JtK05MUHBsUnRQUEho?=
 =?utf-8?B?Ky81eHUxY0ROZ1ovYndIdUovTDV5MjdOTE5tQmU5WUh5UmNjRklPQm10U01Q?=
 =?utf-8?B?SzI1ZEdmclRMYllmTTNRNCtibERxZ1V6aEc2bUUxbDc5Mk1seGcycThCenor?=
 =?utf-8?B?SmNLQ25RUHcySTBJUVhjNEhFOXlaTmNhOVREcVlQNzU5V2U0NHRnb21LbnVx?=
 =?utf-8?B?S0ZHREYrYVpjemtiRUI3UXVUbjFJU0w1QzhYNlZEUkNaaGxrcjQ1Q1pzS3BJ?=
 =?utf-8?B?ZEs1cG9jbWtCMHl0RmVjR0tHNFl3MFI5Sk0zWW1ManNFbWhhRjJjdFkxUzJF?=
 =?utf-8?B?T3p5VWFKODBac3p3czBTNXlxQ0R4YnBaejg1dHFra0dHWVJKYkR6RGFiaEFw?=
 =?utf-8?B?Mllkb2gwY29PQWRnSGY2UUN3SlZzZGZMLzF1N0NaUzdLWmM2ZE9kYTlYU3h1?=
 =?utf-8?B?VE5SS3lhNXlSTEV5Wi8vK09kMzJLWUw1WlZsT0FwT0k5QVJTNTlYR3JlNnhT?=
 =?utf-8?B?UmprRzd6M2ttcExKakpBOG83bmJqdnRJR1RQZjMvYnlNSlFGWFR2ektFRmtT?=
 =?utf-8?B?T3RsYkx5ZGtoS3E2NmNuLzVWSHZSWjNSODM2NkdhbFRhVXJ1dzVub0ZzT1BV?=
 =?utf-8?B?NE9ueGFGcmxpczMyVWJsUDBXWXVqdmVQcE9aVis3UDNHVWE3bEdtTnphZXR4?=
 =?utf-8?B?dG05aTM5YkYwODBYNlJNYTBGbDUyVmJOZm82eVlYQTNmakRWMkYvZnp6NEpP?=
 =?utf-8?B?dktxNkNVQzlyNUVEVUU5WVVDOEE5dyttbVdRK3JteFJ2ZkZCanVxOGJKMzJY?=
 =?utf-8?B?TFRTcjcvaEpvY0M5TEtkZjZDNENIWjVUY2RaQnlXSFRpZ2E1VWdJNkc0bHdr?=
 =?utf-8?B?ZXQyRFN5MUE0S2QyR1dkWFRqUktPYjlFMjFkZWxxWkllK1ZhQjFWMGNUN1Zz?=
 =?utf-8?B?OWlmVkVGQjJyRWNmM29SditORkNhSnFOK2N4ZzU3TVByV3JDSDl2cFdkK0ZS?=
 =?utf-8?B?ei8yVjZrbVFJTWxXNEJocWduVHhaWGFuVEYwWkloa0Q3Ti8wTW51eXRjQlVB?=
 =?utf-8?B?eTQxZzZkeVY5T0FXYzh4aEYvV3VaYWJwN0VwVlY0bUhIWjlaak1LcS9QWnlu?=
 =?utf-8?B?V25vdkJoMk1ZckxSY3B0ay9qUVQ2VlRNWkR3bFhRZUwwSWFtK0ZQVEVXOXkv?=
 =?utf-8?B?b29JSGpSWTVMTDhwb1BCM1FOSUNvYTlQNXdKbUsvdXFRTklOem04ODFYQnkr?=
 =?utf-8?B?dmdsT2FhcENPTG5XMEE4cUdvWlV5V0VNWUJoZlUreEd2bzJaZ0MxUjBXdjll?=
 =?utf-8?B?cUtDS1I1eTdkNllSNGZDamx6UWxRM0ZyQ2VlWk4wNWxCZm5ENTMxWll0VEVF?=
 =?utf-8?B?ZHMxdTFxQWc0aGxXS3d0eUNaQiswRVNqNmg1Q1dFTnlaQ1VhZjRCelAvYVpC?=
 =?utf-8?B?MExpaFlHR3VQUjU0cWh4Sk5lQUY0K3dIeGZsL2VydDd4ZFVPenU4dllvSjFL?=
 =?utf-8?B?TjZEOWlmYWxVRlBXeVNuSjBXZllodWp5bVNGZ1JuTXBhNHF0dEI3Z05zRHVn?=
 =?utf-8?B?bjJVMHlpaFJyUEFPaUk3OFhjcEwrSUlWY1Y3SUdMTFlaUjlzU2labzBxNkhO?=
 =?utf-8?B?R2ZGVG1DcDdFd0VxZFA2Yzh4WXZHdWgzQWJHcGFHTHdnU0dnSXowaDhIbjgv?=
 =?utf-8?B?TjdPaGhhSk0yemx5aGtiN2dZMlIvWGdZaDljYzNuYnh5RmZlNGh0dVFaSUpB?=
 =?utf-8?B?NG5VVnVkeTBjMVdxTmZTR2pPYU81cnA4UlpjamxOWkhqWEdKMVJ5N0VIV0VI?=
 =?utf-8?Q?q/+OQmRWWogo7EMsVb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd9e88c-8b7e-44c4-56dc-08dea1286cd8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:06:53.3914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maHvCRYvuSzELtKWoFrzCupdM9p1fjiQ1Q15xBgnsbPKMU41kXN80MpaoHQVSyQbvsB7tgPcSADsPekitgG+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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



On 4/23/2026 6:39 PM, Christian König wrote:
> On 4/23/26 08:21, Huang, Honglei1 wrote:
>>
>>
>> On 4/20/2026 11:37 PM, Christian König wrote:
>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>>
>>>>>
>>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>
>>>>>> Add amdgpu drm SVM API definitions built on the
>>>>>> DRM GPUSVM framework.
>>>>>>
>>>>>> This includes:
>>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>>
>>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>>> ---
>>>>>>     include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 39 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>     #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>     #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>     #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>       /**
>>>>>>      * DOC: memory domains
>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>         __u64 matrix[12];
>>>>>>     };
>>>>>>     +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>>>>> +
>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>> +
>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>
>>>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>>>
>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>
>>>>> Why are those separate attributes? What is the difference between those?
>>>>
>>>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>>>
>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>> it can not migrate, GPU only can access it in the initial place.
>>>
>>> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
>>>
>>> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
>>
>> Got it so can I change the UAPI to the following format?
>>
>> enum amdgpu_ioctl_svm_attr_type {
>>      AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>      AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>      AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>      AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>      AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>      AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>> };
>>
>> enum amdgpu_ioctl_svm_location {
> 
> The enum name could probably be improved, but apart from that looks reasonable to me.

Will improve the name.
> 
>>      AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>      AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>      AMDGPU_SVM_ACCESS_MIGRATE = 3,
>> };
>>
>>>
>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>
>>>>> Why is that separated into set and clear flags?
>>>>
>>>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
>>>
>>> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
>>>
>>> As far as I can see just a SET_FLAGS should be sufficient.
>>
>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient method for deleting large-scale flags, do we need to redesign this part?
> 
> I think we should expose those flags as individual attributes then.

Got it will do.

> 
>>>
>>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>>> +
>>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>>>
>>>>> No location for device local memory?
>>>>
>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
>>>
>>> Absolute clear NAK for that approach. This interface is per FD!
>>>
>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>>
>>> We also need to make sure that setting attributes for different devices doesn't affect each other.
>>
>>
>> I Totally agreed with your thoughts, but according to the reply from matt, it seems like we need to consider the P2P/multi GPU situation.
> 
> When the drm_svm or pagemap component has already code to deal with that then it is probably ok to have the same interface.
> 
> When when XE only hacked that together on their own then that is a bit questionable because getting the lifetime right is usually tricky.
> 
>>
>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to modify the UAPI to align with xe_svm?
> 
> I think we need to full clarify how XE works here. E.g. that you can specify both 0 as well as give the fd to get the memory migrated to the local device sounds odd.

Got it, for this part maybe require more discussion and time to fully 
understand, so this part will remain unchanged in the next version.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Honglei
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +struct drm_amdgpu_svm_attribute {
>>>>>> +    __u32 type;
>>>>>> +    __u32 value;
>>>>>> +};
>>>>>> +
>>>>>> +struct drm_amdgpu_gem_svm {
>>>>>> +    __u64 start_addr;
>>>>>> +    __u64 size;
>>>>>> +    __u32 operation;
>>>>>> +    __u32 nattr;
>>>>>> +    __u64 attrs_ptr;
>>>>>> +};
>>>>>
>>>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>>>
>>>>> And we usually use unions in this header to separate the input from the output parameters.
>>>>
>>>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> +
>>>>>>     #if defined(__cplusplus)
>>>>>>     }
>>>>>>     #endif
>>>>>
>>>>
>>>
>>
> 

