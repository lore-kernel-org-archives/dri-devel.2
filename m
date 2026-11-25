Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CXJhHx8p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C1310F5C4;
	Wed, 25 Nov 2026 06:23:59 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D91110F047
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r17AYM/TNaRDtRQLPpfxosbIxniSDXsZPcVk60YyXxoEVB5rB4+VKqk/7Wh4KLO4dVs1mjxdZmXvwRr6w9qMRbOIEYuCbboyc1nsDAv45eJLyvqH8z0hkvd7/FMyrlPgKH/HM5w6pLr6DE4WUl8SZQmuHLDAH00c7y6mvpadf43uNz6GOmLaf3Gn3xzDyeDr7YMxM2qSv6uNIAWRDhiMY2ePxoZpyXj01u5VTGob/H+PR++G5e1Vl1fo/DTJvmr/ZZdhzvUoX8w7kwE9QjEJcH/uu0ySvVtovbMeRtgxZyAxs471g+8+xVHsUSyS7+TDV5R6ffpVG4xZ7Z/MXH0pJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZUkXXJrZSlkEZI/YCNZGXs5Gbve6Ypxao6LdpfpiKw=;
 b=h1TI9s+HugcPuIt76ifxPYSiE9o4NFEkjVtu0soErHI5DUjd/5V5C+jMkH0zWn5NfPNYC1JhCceuvFAJbZOzESvHTVKBxCC5bnKn1TgJNf4T4zfAGRikYOJuCJIIAZFdFiqrt01IDkA8cMnED3WGA4+okQRuabCXjyFiZbrIGwQ3dFYcjrct190cHtk8WYdBVh93H1WATnuumaUt/pfVXhupuKsPtqCypk5EEa/owu7IsNPPZYUnPrxl86sMjwaQu8gNrOn1+SebRrKl8SPRlu8tsCwBxbmmfWPyqsmaxIT7I7HwvFflt8xSLR3x7C2ONC+DviXipVd9cxYuLPl+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZUkXXJrZSlkEZI/YCNZGXs5Gbve6Ypxao6LdpfpiKw=;
 b=CXJhHx8pstuflCwygg6V9kb7M2nHOPtT+F7KOIZ+wrj+eBVF80q4DcP9fGHwze+VPtOHRf1wR90dj2GIvMDrLQzKW6H6ZmzUr78BtRohF2diL6Sh/qYKCVrXtG0TzMH4CE0c7RMrXDRm+WL18l/wKc8wiH3WA8guIC+c5cxF4qQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA9PR12MB477655.namprd12.prod.outlook.com (2603:10b6:806:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:23:50 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 06:23:50 +0000
Message-ID: <09d90948-25f5-4857-8f00-6ae5057902e3@amd.com>
Date: Wed, 25 Nov 2026 14:23:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About NUMA support in drmsvm helpers
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <316c1d61-f297-41ad-95d1-43aaa67c9696@amd.com>
 <c844403b-8c07-4a37-a988-85d2548bb674@amd.com>
 <3c762d0c-ef16-4e3e-af96-fd65fc492db5@amd.com>
 <fecf82c876bf4822bc1810a6ccbf36b7b327db96.camel@linux.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <fecf82c876bf4822bc1810a6ccbf36b7b327db96.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA9PR12MB477655:EE_
X-MS-Office365-Filtering-Correlation-Id: c204121e-9cba-4fd1-ec72-08df4abcab84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006|261028144727099003|261009223027099003|261102123227099003|261021121427099003|10067099003|261026121527099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: rlMGJPFKmZ35W9HHQTKpLp+VN8PBw+awz6saArq/80SEiRsFV2eFV9P918v/kaj+WmqCgvB8Eg58CdZOEjvWXudq8jPCYsNAlTuLUiX476QmYKNs1U76mwRJ5ybu4veqImnvFbFgdG5ZejMFsnaEj8kvy53fPpA1Ivzhv3G41hFX7az5LHLbiaKU5NE/Wk1rxE9//XD0RPsupQr16TTB0fK5EW3XDVENrC3aXRQVMaP6zV29+i8TNATQpiriW0IhSMB4d7LnhceF1j+Bh//u9Ic0oxOhYSDWyqvLOXtPG+o1Cy1YEAiYPpRw/Jg2DLyoOwDULcaPg5SG74O0DYQUWzcG0KsLGxGKisEYldfY778VtxpDlwGWwvXEW88yS5AjcvtqolYcpkc9OrGyFRCVekAtUMYubmmfwP+9ScYzIhzbP7sfItSiKujmkqJfii/jGuINQ2z3TyxSsarQxE5hQOgbglTEwXf6q/SDo8/AX+7S2tiRySFNzSb01LEiP6wiCjc7yhskhXvRrK/uaFWATB/27RA6WLN8y0Nph8Kj4U0Kwf3MWUfptaXTHt+/GSEopLu059nTh87e9nTSInh3PDGbagH0E+dKgYgJHVlIH6Uxsff4Ew0BmY/9Drg4L9uJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003)(261026121527099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmd1MGJ0UUQreVNsVjRyTmk3V0QvOXlqOVE3OTY2dThzTGZxcWgwUWhVOFJv?=
 =?utf-8?B?RUszWHhhVlBwdGJnRnhZM2cxd1k3NHZzZnRteHpndW1lbER1Uk4xaXBLMC96?=
 =?utf-8?B?cjhQZXY4aE5VdlAxbGdLRHN2TzhCTFBvbjlpWkkyaUFHTC92MFplZ1JlbHhI?=
 =?utf-8?B?M29zRFFnanNINWVZUGhTVDRrUWkvdXlFY0pjTTFBeHVXc1Z2WUV2RlZqajRZ?=
 =?utf-8?B?VjVvcERWNGIzVXBLZkp5NjhOVklSTnFlNHdFSzhidXhKTFJ6N3VsQk84QVlo?=
 =?utf-8?B?UGgwMU1FVldwVjRHaXBNazZHVWpJNzVsVHl5QTBaNnF1Z0RReDQrWXFuY0dM?=
 =?utf-8?B?K1BOTWFDWTZqK212QTdiUWhlQTRReXllVDZlVkJtdTdWZ3Qwc2VEMW14OWJm?=
 =?utf-8?B?NzRhSWw1QU1lb0ZudGhGcEF3VXFVRmUvcEtOZ0JBYnpEM3Y2b3VtLzVhbk50?=
 =?utf-8?B?YThJU2pwOExNVml1R3pmNk1rZWxXNlZybGMyNDJKemtyYncva2NDWUlmNjln?=
 =?utf-8?B?Mlhya0NlQnp5Q3dLc1BRUHBjNXAzQXdYVy9EZkRlVWI4OGZkQ1dyeHJMRzRK?=
 =?utf-8?B?T2pnd2lGa2Ewd0xTUXd0MzlQZXZIakdnS0Z6OEpyb3o4YnpEOHdDMFFGaDZ0?=
 =?utf-8?B?UjlYS0xlKzNXWlc0aVduUTlTQzBGd3J6VCs5ZzFYMGY0QjBWNXQ3TmlOTkxj?=
 =?utf-8?B?Mlh5akNqc2Z3RVFaUHR2Zm1zYUNHSDlTWERRdjhSb3BaYmUzSUtUejRRVmE0?=
 =?utf-8?B?dklXTGUwclJVMTBuS2FIY2haa0UydEVhejAza0UrQUZCb0FhQ3lWaHVFRjA5?=
 =?utf-8?B?bHBHT0U1bk9DK0szeDV0NmhqT3E0R2F0L3NBMUg4QS9HUVRXeWlXLy96b0lP?=
 =?utf-8?B?RWVmYTNKcWhuR0taZElISUFhQ0h0MjBHbzJmWHR4T3dOOE53TmYrbjVEVGtF?=
 =?utf-8?B?UGpNb3FoR21KWGV5aVBEK3VHY0V2eWhvc2MwajkwKzdYWVNSYzkrK28xWENi?=
 =?utf-8?B?djkxd1g2N3pnNk5VTEZRbG1Jeko2UDk4NHJPV3Q1RTc0aGRJaHZTc3V2OVRi?=
 =?utf-8?B?bDZUWXFCUm1KNjd4bEsxa1JGcms1czFYZDB4YVdnZ1pyMk5GcDlVa3VOWXAw?=
 =?utf-8?B?Z0VDY1JBMGZRTlBLWWF4dThaRm8vOUphY3p3RWIwdndDcDhpWlhCS21tU0dF?=
 =?utf-8?B?OFJ4d2Z6N3dZLzlkY0pvczBOWjJwYThOTGZjTzE5Yy8zNDJvczlEMnYzYzVv?=
 =?utf-8?B?WHU4d2VGbStLeGkwL1JTSFh0Ly95aTNRYmdvY1F4TjBXcXNvTG9pc1JRSlVF?=
 =?utf-8?B?OGpCaHBsNkcrSXpiajNMUHZJSWN3UGtsWlQ1cHVEZUhPMEJkeVpZV3dTbWg1?=
 =?utf-8?B?TU10THlYVFJyQWVJYitYQytTM1FBMElCUFVYVG5PVjhhdGhjWEtmbEZTWDdl?=
 =?utf-8?B?d2dMc1lyVUJNZU03NVVKcVNHdzIwUTVaend1WXhDMEUrdVJzczYyNXFKVVFw?=
 =?utf-8?B?TXQ3dmVIMkJQeDU3L3BUbHQ4V1l1N0dPeDUyNEdITFlCU0ZWQUlVUVRMWmZj?=
 =?utf-8?B?V2FCR0gra3U0bHBVYURlU3ZwakZBTGkxeGw5Mmh2OFBXdk4xTEYzNktZQldC?=
 =?utf-8?B?NGFuSXJXeEtiNjZiaDJVb3c0OHJIL0ZOUXFNYS9pc0hVeHFhYy9WUjZvK3Ix?=
 =?utf-8?B?Tk5VZGRaclNIeS90MjBVUlRIcVIxU3VlU2dza0I1U3JtbERQRURxditjT29s?=
 =?utf-8?B?MjRXUXVKL2x6SmF0UHB6M2VncXlWcFR6UTQwTldOdEQ4MHlNMThrM3VDSDJN?=
 =?utf-8?B?SkdnSDhSVEVZTlh5Ums2Q2FzQXhuY3ZwbUdyLytvb1dmZGtaQ3VyVXloRkFT?=
 =?utf-8?B?T0U2UHYycWdPdndpblV1K1M0V3ZUM2NkQ01ldVJPeVEwUDQwN3hQNlVzZmI1?=
 =?utf-8?B?UThSYU9naDdCcDVmcG5WT2RCKzBwS21xelppbU9uODZFek0rUHhieFJtNC9I?=
 =?utf-8?B?R2V6WUJsTXUybkVQVUlXb2ZtTDJERG52NjU2dURnVHVlMnVrbmhGRHFWdjNB?=
 =?utf-8?B?WTgvM1lrMDZ3TXZxbWo0NlhxZ0hxVWhuYmlxSXZmWUl3dGZ0NzFJVUwyWnlM?=
 =?utf-8?B?eHdxSWdoWWtPOG44ME1rUzg4QUtrMmhyQzF4OG1Hdzk4MmdoV3RRRUMySWZz?=
 =?utf-8?B?U2xqMGNBTjZ2VVdFTkRESVd6ektHZjAzcXVmb0VBNjAzZnVPdGdRU1ZxeGwx?=
 =?utf-8?B?UU4rN2NISHdXZ2Y4UkVHenkxNVJRR3VrVnFhOWdDdVRmNFhtSm1ZSXlvVmRw?=
 =?utf-8?B?WnNTZ2V0Q1lUdXR3Z2pOemlYNEh5bDdZbHk0MGVleXZTR1ZIOXFsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c204121e-9cba-4fd1-ec72-08df4abcab84
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:23:50.4662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p4wlkyQNS3vteHFNRiKzkg5VVKUFLGzWTMBTVqHy/0OcPTSxmUk2H0293Q7YFLNCiNa1zetZsj2/xIgd7ETag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR12MB477655
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/2026 9:54 PM, Thomas Hellström wrote:
> On Tue, 2026-11-24 at 14:55 +0800, Huang, Honglei wrote:
>>
>>
>> On 11/23/2026 7:04 PM, Christian König wrote:
>>> Hi Honglei,
>>>
>>> On 11/23/26 11:44, Huang, Honglei wrote:
>>>>
>>>> Hi all,
>>>>
>>>> A NUMA issue is found in another thread in [1]
>>>>
>>>> We also encountered a similar issue, performance drop occurs when
>>>> NUMA balance is enabled.
>>>>
>>>> And there is one more thing about NUMA:
>>>> The current amdgpu drmsvm can specify system memory as a
>>>> destination, but not a specific CPU NUMA node.
>>>
>>> Yeah I think that is by design. the NUMA node a page ends up when
>>> being migrated back from VRAM to system memory should be determined
>>> by the original backing store/address space and not the driver who
>>> migrates it back.
>>>
>>> In other words when applications said that it wants their buffers
>>> to be placed on node X it is not up to the driver to mess with
>>> that.
>>>
>>>> This has impact on some platforms like MI300A that feature
>>>> unified memory for CPU and GPU.  We did a test for 2GB memory
>>>> accessing in node
>>>> 0 and node 3. GPU read/write bandwidth averaged about 2.78 TB/s
>>>> with local pages and 103 GB/s with remote pages, it differs a
>>>> lot.
>>>>
>>>> There is a requirement from AMD HIP to specify certain SVM memory
>>>> to specific NUMA nodes. But KFD also can not support NUMA fully.
>>>> So the HIP runtime have to use linux NUMA facilities to move
>>>> memory to the correct NUMA node, this could lead to unnecessary
>>>> ram to ram migration.
>>>> And it also can not solve VRAM to RAM evict to error NUMA node
>>>> issue.
>>>>
>>>> Would it make sense for drm_gpusvm helpers to let a caller pass a
>>>> preferred NUMA node by interface? An explicit destination node
>>>> for migration to system memory.
>>>
>>> I think we just need to make sure that the NUMA preferences of the
>>> process and any setting specified by madvise() and co are taken
>>> into account.
>>>
>>
>> So we should reuse existing MM mechanisms and respect application
>> NUMA
>> policies, right?
>> Some changes may still be needed to cover the remaining gaps, and
>> needs
>> do some test to verify the NUMA feature.
> 
> I think NUMA process settings can be tricky since the recoverable
> pagefaults (be it SVA or hmm) run from a kernel thread that doesn't
> have the process' numa policy.
> 
> However NUMA policies set with the mbind() system call should AFAICT
> automatically be honored by both hmm and SVA.
> 

Yes agreed, will continue testing and see if there are any functional 
gaps and return to this mail thread.

Regards,
Honglei

> Thanks,
> Thomas
> 
> 
> 
>>
>> Regards,
>> Honglei
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> [1]:
>>>> https://lore.kernel.org/all/b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org/
>>>>
>>>> Regards,
>>>> Honglei
>>>

