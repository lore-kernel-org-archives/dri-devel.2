Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA827C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102BD89220;
	Tue, 22 Sep 2026 07:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uM5ds5Cy";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D48B89220
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8T5EXtuGMn3sSI+OzpCZCdbwASGYAi/1vufJWHMFMTX0H1nN8Qhy1eDPW4xK9xBzqSjN8sW569Eah/Zs88xzCZ8o7ZcI/qm9yHStIl7Tf5wxMrx8yimEhBhjTFPj2ntpRgVJdB+D+/1tvL2snVmY/zQdKTt03wZk7OgjComNKxn1rQFSE6SyyG6oYdND8phX7TujkSUVI7bt3PTPTjn5Ipbvq+XvCMWyD30DPyEM3W8y7Bflcbg9O+J2TMVXSwpuvgYey58isSG7e+ILJtPLhkxEl5ASbYMA5tgBwplfL28e1LA5a3Rwz3mpVb0ejFlRMoxIzXGFxvBK8Em/u71HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0a+bTzmGUQlOkywJqzXXjZTIzB34VeYcc5uCQDKmbw=;
 b=ER5i/thNFITAI4LrMXyPZuaCQyrvQSmEG5UA0KCFx7yCQFPaf+TN08GoOb2e9BvDnpBpLDhDcTs0seNUEo1ckJf+6hyJmDQ2mSqEW+Zo2M3lzd1cg1kqQIlorgdWyMJ+N5pY6fCQseFT+ZiT1PlXCvgtGZ34gU/IpWeH2uyntt3WuujEcouNSYBoWM+qN82q3mvCTIzO0iQCnMJevtf35ah/zTuxtIUyQL8mu/h8DdcEaLCpa/4/FC6e4wNb/cwlGnFu8qkVjNJqRBOw0/1xc7JKtoBVIVAre2DnVbsUOlNV3WOjt4d68kaqo92GveontgHmrP6EqYZ6a9uCMiOmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0a+bTzmGUQlOkywJqzXXjZTIzB34VeYcc5uCQDKmbw=;
 b=uM5ds5Cy8XZY0RWrdOuTqYDX1JDqOcN6B10cXJzLhWfUZMgtXBHEfM6bf0G8uIjUezPSGrUyJPVD8t/zegHWXYfsiwjBCfVWWRz5ChjFJtWKEnVxptEunUkttcaLt/OMB6ydPMfKQABmOrtxfJlYsX5twy19AZMy05XsM8wTahA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 07:24:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 07:24:36 +0000
Message-ID: <326a64de-cb55-423a-9bf5-3e8dbadb1718@amd.com>
Date: Tue, 22 Sep 2026 09:24:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/udmabuf: reinstate a reasonable default size
 limit
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Jiakai Xu <xujiakai24@mails.ucas.ac.cn>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
Cc: "robert.mader@collabora.com" <robert.mader@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260919004222.4141024-1-xujiakai24@mails.ucas.ac.cn>
 <d91e2d04-cb8a-4c34-9e7d-e8faf2dfe79b@amd.com>
 <IA0PR11MB71850CE89762EE05B36B7DCEF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR11MB71850CE89762EE05B36B7DCEF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc7707b-29f2-4dcd-8d65-08df187a8e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: damfjzdR5/8+SAjQKCXB5zX0c4LDGzd1A3xZzt/qwK7zX9QReEjAwNGt7reDnomuGTxUG6crhuvayVllk6WYn34Si/6zAi55x3tH7k57/NhLnM/dM28zcEGFi+TOvCX24HIP07Ygc/xeGVc+S3sFhKU+d2oopIGEXF5/toHzRrATDKbhgJEU250XTX6e5XfFdWp54fLOqGy4zddtF6qxiDOdsQJyMsZfXqLbMEVrlAsF3Whpxu3uuKy4OhbNvRnwdmcobwB31h/Z35EzXbPDxteGwAupH6yZlN5GApW/bz5EQW0t92/9touLIYQqvwZygIwdrGWcSHwzcRXVc3O7PGtN8bv6cal+UPLLdxS5S71/S7IZE9+gr8lig6ZReqA4OnLdvbfPr2ceibjhSpbOOV3m5Rc55stUZ3DVYhu1Ddg+e/iayPerJGc3ZV1xN8c3pfAJVl6YQB1+ChIAFZBLvYI2wRxwwKGUNS9ci6m5+J2REq1+uOnCtMrNpbpbsKGBQCB//c535cG82boPV2bXn+iOrHwzyl3jClNESXAVsm4zgKycDzoVwp4ildrqVUcHrrgWPvmq12jWpdglkUl+a2HaX1JXe2kELaRrCt9iZAnXlov5kxJyYV+hn0UsuPVuuQ0xRGoDRwjGWMEd8uwCsQI+nnECaoaxvZbJ3qlJSEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlKYlBPekxPdDU0T2hBWUpVZTRaTTNyUmtHNzJFVGxJL2dHK0FGdjY5bDlB?=
 =?utf-8?B?di9pSW9MczE2Z0xZQ0oxYTRoVXBja3FmZktPNnpvVmw0K3FudEpmVU5vWGdy?=
 =?utf-8?B?VXNOMGx3ak9XRUZxSE1TWHhWYm5HNU5OTVVZS2FQNFpyNUw4NUk5L21yd2hn?=
 =?utf-8?B?TE9CVEQ4cCs0ZERUemdpam02WU5KRWV0YzdGVGRQNnpGb2c4MWRvN2Jialkx?=
 =?utf-8?B?QTRGZVdCTkpNL3QyMGJ0a2dma0dBYW8xUWNtNkQyZGV4czM1YVRNdU01SHhB?=
 =?utf-8?B?cTE4WSt1U0xOMGpEckQ5a1dpdDFYR21aMzRpMDM4WUsxeVVCaDZkYjBOL0Zi?=
 =?utf-8?B?TW5DMUtUVmtXV0cyYkhzMTV4TnMzZHRzc1JHSitOR1BLME1GOEgxbTJhcXZD?=
 =?utf-8?B?b1ZGRUpzcWdyK1pSdWlybnFnemNCOVg3Nzc4TU5LN3JhdVBuQ2xmazNtOGw2?=
 =?utf-8?B?a0Mzc0VLWElBSnVOTUlsaCsvaEc5QWhoVlpwWUY5aytJaGtqSzVYTEozdzYv?=
 =?utf-8?B?UkRSVElLYzF2YXlycFJkSEZyQmV5aHVQMENGYWZGdjduQjI1ZHR1WXZOQTRI?=
 =?utf-8?B?WFMyRTRlcVlqL3dlckgvQXd0bTVRSXBRNDNyV2EzdThrTVh5aFp1L0R2dlhH?=
 =?utf-8?B?MG9hMG9mekZzTHpWcUxJTEdZK2V5K2VwVStNTCt0R3cxUDhtKzFIVEExUk5z?=
 =?utf-8?B?NWlmV1RvaDM5cmxmTWsrQTBlVjh6Ui9ySnRYWll6S0U5WTlVYjIzS0ZtaXRy?=
 =?utf-8?B?ZTB0ZlJ5eDVSVTU3K21JK2x2alhxbG9mN1l3dHFLQmk4Y0FMbDl0U3VIYURU?=
 =?utf-8?B?T2c5UmJRUDIvZExQTGJwdHl1aENldWttMXpZNjZKYkhQd0IwUURQNDVOOUdt?=
 =?utf-8?B?RGg4NnpSaVo1Tlo4WVptTzJPSXdmcUVZODRmellNK045KzF3UjVRMHFXcW9q?=
 =?utf-8?B?Wnk1dVBybXMzZnZvcFVUc3U4TEtLK1pET2VDMnhub01OYzRmL2NNMjZNckdk?=
 =?utf-8?B?OWdIcDlBZGtqdm5IYkV0cS90ODFXT1hZYjl1T0lUcUtEdlpKbW0zYjg5cnZ5?=
 =?utf-8?B?QWdlM0lmRWFWbWczOThPd1FiOVVMeUNWZTYrRVFMRTJVVGhZNmZNREk0OUdX?=
 =?utf-8?B?TVpVRy95VE9nbjVkV2QvZzUxOHFBQnVtc0w0a1h1QkExOGpyVm9vTGZBY0c3?=
 =?utf-8?B?blI3QmRCT2NFRzU5TWxHM0VraGJOVThOYnQ3MTI0K05oSVh0QWhHd3grLzFy?=
 =?utf-8?B?dE9JNHNvKzI0endISHZNeWVNbmJEb0VHSkFyWjFGdlNEeEs5Vkl5blEwTWtK?=
 =?utf-8?B?bUttd1Z6eVZna1NpUjVieXI2S0tPcmQweVNpbE5FeDRqQVhIV1Faa2VhaDQr?=
 =?utf-8?B?YXdGZllrTFUySSsrV3hUY1p0cThmcHZZQ0JJd2VSeVhtcFJuRDgyaDVyaWNz?=
 =?utf-8?B?MWNpUEZXWlIxY0pLNEpsZEdOSFZlemMrd1VXQjJoOEE3NFljSGU0MURlKzdQ?=
 =?utf-8?B?SDVHc3UrNTVlbWFDQ0lXbnRrSXFmeThXckxrRWFYN1NEbkl3Szl6QUZ4WHVZ?=
 =?utf-8?B?WnRidnd3MWR5ajM3QmZ2dWpodTVnUUFwdWk5MTE5bXltMk5qYU1maEtVNEhK?=
 =?utf-8?B?TWtuZjMxK2VTTGRyRzFzbHpqRlhXNS9ISmtlYThHTEh5YXpEZnlETGwvWlA1?=
 =?utf-8?B?Uk05ZVRqTm1FUEJRdGJ3VzFwOWNDYWRqSTJuc2VmL3hiMisxRmVvMEZtakl2?=
 =?utf-8?B?UnNJSkt1NGVrazMyZ1NsNVhRMjJxR2xCc3ZBSUsxUEZvV3ZST0hRam1FV1pI?=
 =?utf-8?B?cVN6Ti9KY0pSQXZoTHozclFSYnNlQXk5cFlhSFMwcHAyb3A4ck93Y1psZ0ZK?=
 =?utf-8?B?S3Q2UlZtWlZLMnViZjhucTNyMndjU283Vk10V1Y0OU5kOWJLRHIvNWdsdHp0?=
 =?utf-8?B?V2s5T1VFT0NKTzFqZjNEOWZ6N3BPazd5ZTcxSS85Qjd4blJvdG5QOGFwZEdN?=
 =?utf-8?B?Vm9LVzFMeHlSVlVUQytrbW0wNjk1MDBYUDdyVUpsOWp0RXJNdlFOOXNHZlQ0?=
 =?utf-8?B?aWZtQ2RzeDREWi9TdWdFYmFnNEFPaDZLZUpHeUJicHFjRWRnWDFuSzBSNHZY?=
 =?utf-8?B?MGRxMnRQbklEWE44bHExZW9MdkErOWVTTE5pMlBHbC9lRW5oTjl4Z1J3by9Z?=
 =?utf-8?B?VDJZdWppeDdNYjN5TFhNaEEySCt0cmdON212d24wTTIzd1dvUmhONWdpYzhB?=
 =?utf-8?B?b1lvdDI1bUMrV0FtUk5kVHlleHBJMDQzN2I4VDExZzI2eDJGWGdUQzFnRkxk?=
 =?utf-8?Q?MsqbciJYqE2phePLF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc7707b-29f2-4dcd-8d65-08df187a8e7c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:24:36.6716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxnTf5uiF/VJmmqLeahIyN2KkFo5qWUxPiUtgSIaEgYjbv1Pp1YlIHwscT6e1mqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

On 9/22/26 07:17, Kasireddy, Vivek wrote:
> Hi Christian,
> 
>> Subject: Re: [PATCH v2] dma-buf/udmabuf: reinstate a reasonable
>> default size limit
>>
>> On 9/19/26 02:42, Jiakai Xu wrote:
>>> Commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
>>> default") raised the default size_limit_mb from 64 to INT_MAX.  With
>>> 4K pages, creating a buffer of more than INT_MAX / 8 pages (about 1
>> TB
>>> of pinned memory) now makes the two per-page pointer arrays in
>>> init_udmabuf() exceed what kvmalloc() can handle: kvmalloc() warns
>> and
>>> fails when the requested size exceeds INT_MAX bytes
>> (WARN_ON_ONCE in
>>> __kvmalloc_node_noprof), which is trivially triggerable from
>>> unprivileged users through the UDMABUF_CREATE ioctls:
>>>
>>>   WARNING: CPU: 0 PID: 412 at mm/slub.c:7021
>> __kvmalloc_node_noprof
>>>   Call Trace:
>>>    udmabuf_create
>>>    udmabuf_ioctl_create_list
>>>
>>> Restore a reasonable default limit of 256 MB, which is the value
>>> proposed in the RFC discussion that led to commit 44e9eb5a7621
>>
>> That is way to low, we want to allocate multiple gigabytes using that
>> API.
> I am wondering, what is the use-case that would require pinning multiple
> Gigabytes of memory via udmabuf?

We use that as replacement for driver allocated memory on acceleration devices.

Regards,
Christian.

> 
> Thanks,
> Vivek
> 
>>
>> Please make that (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) <<
>> PAGE_SHIFT.
>>
>> That should allow to allocate a bit below 1TiB again without triggering
>> the issue.
>>
>> Regards,
>> Christian.
>>
>>> ("dma-buf/udmabuf: Disable the size limit by default") and
>> comfortably
>>> covers the 8K video use cases cited there, while keeping the
>>> kvmalloc() request far below its threshold.  The limit remains
>>> runtime-tunable via the size_limit_mb module parameter for setups
>>> that need more.
>>>
>>> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
>> default")
>>> Assisted-by: OpenCode:DeepSeek-V4-Flash
>>> Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
>>> ---
>>> V1 -> V2:
>>> - Instead of adding a pgcnt check in udmabuf_create(), restore a
>>>   reasonable default size limit (256 MB), as suggested by Christian
>>>   König.
>>> - Drop the second Fixes tag; the regression is solely due to
>>>   44e9eb5a7621.
>>> - Drop the "Cc: stable" tag; 44e9eb5a7621 is only in v7.3-rc1 and has
>>>   not shipped in any released kernel yet.
>>>
>>> V1: https://lore.kernel.org/all/20260918013434.1849135-1-
>> xujiakai24@mails.ucas.ac.cn/
>>> ---
>>>  drivers/dma-buf/udmabuf.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>> index df6dd00462423..4d90c2cb14225 100644
>>> --- a/drivers/dma-buf/udmabuf.c
>>> +++ b/drivers/dma-buf/udmabuf.c
>>> @@ -20,9 +20,9 @@ static int list_limit = 1024;
>>>  module_param(list_limit, int, 0644);
>>>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
>> Default is 1024.");
>>>
>>> -static int size_limit_mb = INT_MAX;
>>> +static int size_limit_mb = 256;
>>>  module_param(size_limit_mb, int, 0644);
>>> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Default is INT_MAX.");
>>> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Default is 256.");
>>>
>>>  struct udmabuf {
>>>         pgoff_t pagecount;
>>> --
>>> 2.34.1
>>>
>>> --
>>> Below is the crash report:
>>> ------------[ cut here ]------------
>>> WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x516/0x5d0
>> home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013, CPU#0:
>> syz.5.27938/167363
>>> Modules linked in:
>>> CPU: 0 UID: 0 PID: 167363 Comm: syz.5.27938 Tainted: G        W    L
>> 7.3.0-rc2 #1 PREEMPT(full)
>>> Tainted: [W]=WARN, [L]=SOFTLOCKUP
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-
>> 1 04/01/2014
>>> RIP: 0010:__kvmalloc_node_noprof+0x516/0x5d0
>> home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013
>>> Code: 05 bf fa 2d 08 49 8b 0f c6 04 08 00 65 48 ff 0d 90 fa 2d 08 0f 85
>> 4c fd ff ff e8 05 43 8c ff e9 42 fd ff ff e8 9b 86 0e 04 90 <0f> 0b 90 31 db
>> e9 d2 fe ff ff f3 0f 1e fa 65 8b 05 8d fa 2d 08 89
>>> RSP: 0018:ffffc90002bc3cf8 EFLAGS: 00010246
>>> RAX: 0000000000000100 RBX: 0000000000000000 RCX:
>> 0000008000000000
>>> RDX: 0000008000000000 RSI: 0000000000000000 RDI: ffffffff835e3226
>>> RBP: 00000000ffffffff R08: 00000000000028c0 R09: 00000000ffffffff
>>> R10: 0000000000000006 R11: 0000000000000002 R12:
>> 0000008000000000
>>> R13: 00000000000028c0 R14: 0000001000000000 R15:
>> 0000008000000000
>>> FS:  00007fc89ae45640(0000) GS:ffff8880f3de4000(0000)
>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000000110c2ff305 CR3: 000000002b3d4000 CR4:
>> 0000000000752ef0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000006000
>>> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
>> 0000000000000400
>>> PKRU: 80000000
>>> Call Trace:
>>>  <TASK>
>>>  init_udmabuf home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-
>> buf/udmabuf.c:193 [inline]
>>>  udmabuf_create+0x1b6/0x750 home/zzzrrll/tmp/kf_src/linux-7.3-
>> rc2/drivers/dma-buf/udmabuf.c:386
>>>  udmabuf_ioctl_create home/zzzrrll/tmp/kf_src/linux-7.3-
>> rc2/drivers/dma-buf/udmabuf.c:465 [inline]
>>>  udmabuf_ioctl+0x132/0x1d0 home/zzzrrll/tmp/kf_src/linux-7.3-
>> rc2/drivers/dma-buf/udmabuf.c:496
>>>  vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:51 [inline]
>>>  __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:597
>> [inline]
>>>  __se_sys_ioctl+0xbc/0x130 home/zzzrrll/tmp/kf_src/linux-7.3-
>> rc2/fs/ioctl.c:583
>>>  do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.3-
>> rc2/arch/x86/entry/syscall_64.c:61 [inline]
>>>  do_syscall_64+0x12b/0x350 home/zzzrrll/tmp/kf_src/linux-7.3-
>> rc2/arch/x86/entry/syscall_64.c:84
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x590d6d
>>> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48
>> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007fc89ae44fd8 EFLAGS: 00000216 ORIG_RAX:
>> 0000000000000010
>>> RAX: ffffffffffffffda RBX: 0000000000611e7f RCX: 0000000000590d6d
>>> RDX: 00002000000023c0 RSI: 0000000040187542 RDI:
>> 000000000000000a
>>> RBP: 00007fc89ae45010 R08: 0000000000000000 R09:
>> 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000216 R12:
>> 00007fc89ae45640
>>> R13: 000000000000000b R14: 0000000000528d40 R15:
>> 00007fc89ae25000
>>>  </TASK>
>>> ---[ end trace 0000000000000000 ]---
>>> ---
>>>
> 

