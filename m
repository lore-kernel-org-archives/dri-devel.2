Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD41C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CB810E620;
	Tue, 22 Sep 2026 07:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/WAxTCM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803E010E978
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBMc+GAizUzTyL0GfUsAEb7yErZWCus26OIYY3WBVe3xCV5GOPJTldX+kRv+Uxa7X3e0tB+l6pDA0cloFwgkht62C7WKxKJ4RJXtyY5QiDWYyZ0KYe+DoMflVJGanUmTdT06AaXhsaqA/OrEAZTdVGeSgZFLPKOKnZYjMSdXJpjDs0p4kXgDDC5T7PIkiuIXu+x13HdWoaCI0TjYSE/SzvA47GI8P5Mlrkuu5V4fzFc4p8CZLzrP7VFrbwLRX6mcc0duBFOyqmKhOz0x5LE7mrI8Z1UdZnSNhoHuAzV6S8EqsyjBSDEHPaZI8Sm/iFfn3VcW9x/Knngm6Lbn1DB4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlIBvkZydUr+UM1uyEfLCW5cHxLLRuipmQVQk6c8kVI=;
 b=YXbwlwMw0GN1uQAfXNRwp7T3sEQswfJtwZCYpemGWSr6HbagQadja0BckN/ijzqa+RGyl5WAb4wfu4D6pSbbV1rBujcIXSDRwbeDrSXHV39+JNTlNkPf1XN6CsmK6j/A8KF/qnYuNUWkWZc5SB5LfPl98I6ymzGWy7rXtl3qdrBzRjEqv/qBvtZSPKuIkJpX8qorwtpyvLqnJk2e0uw4DVak0IbOt1ANZaXv+zkS2dmosGnyXs2lSaoVK5wQwl4cl8ACIz6ZcUzr0VzTDMTrPgcaCKrIm9N9opqSv+F4Zkm/PvQBCZkxat4lozXs048nGNET6VYXkLG91+ghtn/0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlIBvkZydUr+UM1uyEfLCW5cHxLLRuipmQVQk6c8kVI=;
 b=U/WAxTCMBCx2vI3y6III+LEWOt3sFZ6KKSqpcqGUApt1JyRLF8pYDjOlQmWQ2RUslG/Ftq0V6hnrlEzSuA15PZRCa5jfmrnHKaX55iz+Ag903G1XJiT51ecNsLZSXxhPUUz+ZfM2xF46/GvGR37bhv/MAbhntKQsLMfAubKCn1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 07:33:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 07:33:46 +0000
Message-ID: <a6e77fdd-52b9-4701-a677-c984ce534c42@amd.com>
Date: Tue, 22 Sep 2026 09:33:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
 <77b5fa08-6c95-4f9d-a12e-5ddca3c1c1e0@amd.com>
 <IA0PR11MB718502111B354D893D71FA0CF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR11MB718502111B354D893D71FA0CF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:256::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3be493-435a-4c1f-a3ed-08df187bd5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|3023799007|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qXo4ZBHSdtPedQRqaejf6RYEB9+D2ESPsYm8MIgj2WF52QVuujt0ZAkxw7id7xh+gzdvjoU7VxGnAFo/h82QHQANPGbGBZUoC9hCWHSWg1c43KBnLmpHZolLhQGqiQx9436sOmOndUxZTVWONMIR7mMxeupOe+hHff9p18iCNMsToKHKnFohe8N3hb1fJXoFHWT+PcbA4JxJxOIzVN1l76OX2k/TDm2YZL9T6SqUL+pMD5z4aNg5mzcIQeCRLbnK6zHGXaSkOFi6p2uPQpMNCooBt4L3y9IOWyhoTH++G5nT0UWP+LijDuxmkA4KYKszT6jD5RyF1buASIjBYGNzItvki+sHABWgF6Me64bdYlKYQulSA/n+ss0cZIGM7HjFdXmn6DB0kc8zVuFDhwdkE+jBv4QVFjFn0hTP3h9DUV+rmjU7SYf7XIPyhpGwHZXpkEhZJJ/WBJZ5uIi8BmjVSDPNkEp2E81aq4q5vBAPPwt/g2Mo5oGgWagbXlnGVLBuF/+jTZVQZAqXkDbfWJcJvI3o6NCekEjW4rzPTk0cCy33a0cGvjlowjvO3jiP/fxsHAHPrPgswlRTdTUXFpRTK+huBs/RKv+gA7pmHDXirG631oQA3MVfvhMCEzBu6dBGcrMzytOfhNHgCecZrt8QZqKrd3nnRzyVNVfthWrysfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2o0TUtsTzh5MTgrOVFxZGpuYi8xTVpmamFENWFNbkttYkl6b0VmUTVqYm83?=
 =?utf-8?B?UHFzTFZNMkVuZ2RqSXc3RVNUeEF6UCs1ZnRnajk5QkY5RGxhSnVZdEhnRmRC?=
 =?utf-8?B?UFVLb01sM2JMOUEzb2tqVVpjVnBGWUhQdG1GOGlSZ21NT3B6Z1E0Q1RjeE1z?=
 =?utf-8?B?cDM0TkU5eWRYY3l0RWI5a2V4SDVYeHE0aVZEaStXUitibzRqR05RaG4vY1hk?=
 =?utf-8?B?MXFQYTc3OWM1Y09GbGswbU9ialNlZDJRTktmSUtBQjFVNGpNcG5jUEptUzJW?=
 =?utf-8?B?RGNIZDFoTU12REk1U1NsYWZ3YlQwYTB2OXVDSlZsbWExaW4rdElYZG9TRnVt?=
 =?utf-8?B?SG03aHJCMUtwZys4cm91aDZiSnBvQlRsajl3TW1sMHdXVk9jUVBIbG9Yck5Z?=
 =?utf-8?B?SHVjRFdjWkhjcWhXN2ZCVTdKZUVkZlIwQWhxcVhwZS9vc0hab2loeXI1TnM3?=
 =?utf-8?B?MCs1bUcyY1lUa2Q0RmVxcTRjSXA4VExKYjg0dWo4V05HRjY3aG9IMFMvL0JL?=
 =?utf-8?B?aTJuUkdHV3VZU2ptUUFvYms5UGIyQ1MvbUVSNVdhWng2MlFyOFQrYVZ3dXd5?=
 =?utf-8?B?QVhZbnRNdkZSRzAxWEh6a3Bid0hPb0FDZXM1cTk1ZEx1bzZQZlppeFBoaEJl?=
 =?utf-8?B?SHZvMEI5bEdLTWx0NmhXSHMrRUpsY2ZDU0l1dCtIdDFyOEJuOHRjcmtXUDVX?=
 =?utf-8?B?ZlpGQUJyOHpndWZ4Vy82ODRUNmVyY3F6K2FPVVo4bXc4Ni9tdStuZmRGMjZz?=
 =?utf-8?B?T0RicXdoTkw1SDJqRDUrNjQvbkJ2cXp1NVhDa0RmdTdzN0ZLUHFvbSttUkph?=
 =?utf-8?B?UnA4b25WdW9waTFKeTZucTZSL1U1VU92US9CR0Nac2tDeGZKZmdKNHhWTFo3?=
 =?utf-8?B?cmx6SUxKZW14VEsyTStBSjA4RDNKM1k1NVV0b0Q4cTNWY25pYkIvWkdBRGll?=
 =?utf-8?B?MlUyd1lMWjNjMjVCa2ZiQytGTFJUdWlsQXY4NGRHdEdzN1dsQXltK0dBMGdV?=
 =?utf-8?B?S2U1ZTlLaTE3VVlybzNCYU9xbS8zTVZqZ3k2cXBrall5Wko3ejFNM2dYZTdD?=
 =?utf-8?B?T3pFSkR4QjNraXJoMlJJaFIrQnFUdnVVUHhnTm9jallIMEQxN0NFRE5PdGRw?=
 =?utf-8?B?ZkJ5eVcyWjNkR2E1Sys2bFBMQ2dGTWltK3ZUc3F3b2JXSWVNVlBLVnZLd3RC?=
 =?utf-8?B?clJNdXkxNXdMZ00vVDl6NytJa2svQlR0d1NUR0NlQ1FUK0J1YWMwSkpOSUpk?=
 =?utf-8?B?b3NNSW50Wm42NG81UVNHZ2J2WUNLTFdqNWtQd0NmZzF4ZlNkM3JwYWhEVkVW?=
 =?utf-8?B?R1VqMWllNVVXNVhVa1hRWHVWZWkrTzNpWTcvR2VCQUo5ZkY5M1gySGxsVm1I?=
 =?utf-8?B?Ni9KZnYvd1N3YitMUzVQRWx0VzN1Z3psV0ZNbGVwMFdubmNOMDVRTEkxbCtB?=
 =?utf-8?B?bFdyblliZzRoUTBiTm9KVldWajIyY1l6MXdrd2NFU1RVT1pkV2ZNRzZmWUVB?=
 =?utf-8?B?aC9PM3V3ZC9BUFhPRXpjcCtOMVZKTWZTd2YvSTBJY3dWZkRiT3J6VUlHbjVj?=
 =?utf-8?B?NnQwUlREbEJuNDZNYWl4SUxiTEgzWUV2aXhjTnBrbUFLV2JsS0F1ekNtU2Qw?=
 =?utf-8?B?L0Iya1M4SDE4Mk4yZHJOcGo2d2RTTmxFeGh5OWYrellUeWRNNnZNbEdraXVX?=
 =?utf-8?B?L0ltazJ1bVBPSGYvL3V3OFk0WWRCYUxwTVFRWTc3U1hnNjBuYWtGTGQ1cDRM?=
 =?utf-8?B?S1FhMjdkUSt5TUtOZXhvN3Y4SnF5RXZMbitka3o5Rld6ZzJ1aCtBNWZiM2g5?=
 =?utf-8?B?UUxZRTZaK2JscmNwS0VrcnhTZHFFa3BmV0pwVEdGQnJYNmNwNzNJRDNTdXNX?=
 =?utf-8?B?cGVjbFE5NlN1aHEyU29KeUpEUTduUDRKTVY5aDFKdXg5YmdpWkZWaE83NGdO?=
 =?utf-8?B?OXQ1Ukgya2prMEtKK0FwTW5QYnZsZmxFaVFaeitkaGpINzFLWUkzd3cyd21G?=
 =?utf-8?B?VTdrVWNLTkdETnpkbmVqd1A0TkJtUWNvcjV5a0Y1TVM0cW45WFRHSnRXNmF3?=
 =?utf-8?B?YldrR0Ntakl0a21zS2FkMmNZQk15bjFzamRha2hMVHdCSFZOT3VVNW1nNGlJ?=
 =?utf-8?B?cDJOdURtRGxPNVVwWkpsbW1jald6R1Y2OGxNSFBZQnhyWmIyMGM3MitCcDFT?=
 =?utf-8?B?blA0TmJ2OU1FV0F0VVN6eUlwZ0U4b0dpMWtGUjlDbFVla0ZmNzFGd0ZrWXlv?=
 =?utf-8?B?TU1CQmpaRFdZNXZrM1pSblB6aDlSbGVHTHBXOWFUb0pUbVY3Zmw0RDBiWGNr?=
 =?utf-8?Q?Kx6tXKRqVfrl7PqaGc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3be493-435a-4c1f-a3ed-08df187bd5f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:33:46.1318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mABDHTWdU0R4vf674qWAszKg4Gr+5UxwGg2jHKqgvg7jLT4GhyInVl/qEbfjNgsv
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

On 9/22/26 07:19, Kasireddy, Vivek wrote:
> Hi Christian,
> 
>> Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for
>> udmabuf pages/folios
>>
>> On 8/31/26 08:00, Vivek Kasireddy wrote:
>>> Since udmabuf allows users to pin pages in memory, which is a vital
>>> resource, we need to ensure that unprivileged users cannot abuse
>>> this feature to exhaust system memory. To address this, introduce
>>> mlock accounting for udmabuf pages/folios. This change ensures that
>>> the number of pages/folios pinned by udmabuf is tracked and limited
>>> based on the user's mlock limits.
>>>
>>> If an unprivileged user/process exceeds their mlock limit, no pages
>>> are pinned and EPERM is returned to the user. Note that, privileged
>>> users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
>>> allowing them to pin pages without any restriction.
>>>
>>> Earlier, there was a 64 MB default limit on the size of udmabuf
>>> allocations, but it was removed in commit 44e9eb5a7621
>>> ("dma-buf/udmabuf: Disable the size limit by default") which left
>>> open the possibility that unpriviledged users could pin unbounded
>>> amount of memory. This change makes the limit dynamic, by invoking
>>> user_shm_lock() to check the mlock limit for unprivileged users.
>>
>> That makes no sense at all and would create a massive problems.
>>
>> The mlock limit is per process, but udmabuf is represented by a file
>> descriptor which can move between processes.
>>
>> So this here can be trivially abused to account the allocation to one
>> process while accounting the free to another process and overflowing
>> the mlock housekeeping.
> The goal is to have the mlock accounting be tied to the exporters since they
> are the ones that pin the pages/folios. As Sashiko identified, this patch doesn't
> quite do that but once fixed, both alloc and free accounting would be attributed
> to the exporter. Would this idea not work?

Most likely not, no.

First of all this is trivially circumvent-able, you just need to create a child process which allocates and exports the memory and then gives the fd back to the parent and dies.

The result would be that you have accounted to the mlock limit of the child process (which is now dead) and then a dangling reference to the cred structure of a dead process. Both are most likely no-gos for this.

Then the second problem is that you often have processes which allocates the memory on behalves of another process (display servers for example do that).

The fundamental issue is that Linux doesn't have a way to track file descriptors as they move from process to process and so if your file descriptor represents more than just a standard file on a file system you run into tons of trouble with resource management.

Regards,
Christian.

> 
> Thanks,
> Vivek
> 
>>
>> What could potentially work is to grab a reference to the cred structure
>> of the allocating task, but that is also not the nicest thing to do.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: "Christian König" <christian.koenig@amd.com>
>>> Cc: Robert Mader <robert.mader@collabora.com>
>>> Cc: Xaver Hugl <xaver.hugl@kde.org>
>>> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
>> default")
>>> ---
>>>  drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>> index 7c4339130eff..e78947f01656 100644
>>> --- a/drivers/dma-buf/udmabuf.c
>>> +++ b/drivers/dma-buf/udmabuf.c
>>> @@ -203,9 +203,10 @@ static __always_inline int
>> init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>>>  	return 0;
>>>  }
>>>
>>> -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
>>> +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf,
>> pgoff_t pgcnt)
>>>  {
>>>  	unpin_all_folios(ubuf);
>>> +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
>>>  	kvfree(ubuf->pages);
>>>  }
>>>
>>> @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf
>> *buf)
>>>  	if (ubuf->sg)
>>>  		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
>>>
>>> -	deinit_udmabuf(ubuf);
>>> +	deinit_udmabuf(ubuf, ubuf->pagecount);
>>>  	kfree(ubuf);
>>>  }
>>>
>>> @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice
>> *device,
>>>  	if (!pgcnt)
>>>  		goto err_noinit;
>>>
>>> +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
>>> +		pr_warn_once("%s: User not permitted to pin more than
>> %lu KB "
>>> +			     "of memory, either increase ulimits -l, or "
>>> +			     "obtain CAP_IPC_LOCK capability\n", current-
>>> comm,
>>> +			     rlimit(RLIMIT_MEMLOCK) >> 10);
>>> +		ret = -EPERM;
>>> +		goto err_noinit;
>>> +	}
>>> +
>>>  	ret = init_udmabuf(ubuf, pgcnt);
>>>  	if (ret)
>>>  		goto err;
>>> @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice
>> *device,
>>>  	return ret;
>>>
>>>  err:
>>> -	deinit_udmabuf(ubuf);
>>> +	deinit_udmabuf(ubuf, pgcnt);
>>>  err_noinit:
>>>  	kfree(ubuf);
>>>  	kvfree(folios);
> 

