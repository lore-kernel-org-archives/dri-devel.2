Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9518606D82F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nAb5Pslr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4343310E7C1;
	Tue,  3 Nov 2026 09:47:09 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C8510E7B0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JErGgP2OYWNRPRjNvwy4MDqsDmZ18A7VMUojctrm9i7iNIa1Ol2T3JhsSqyS+gvRHJvvO8jKmarxKmCUbis1RdiK5J+aktWe8oHWRmvIuyCplCq1RWnoLuLyRErJtKz6bOr6JVRI28jFlIKaSlVHjSMPuhoOY0SIxtr+PGC1miuuruF4t5tC4EtiPNw6dKHyKeBMp/xgrwZo7h+9hQ5yuB32XWNuRWWUTWMCrdVwTjBAQ7TNyE3woM2GDJSh4BU1Z5APq52ZOYcd63cCReO+UkitSB/+5VqKVJvtNCTCCMHn/eZfnD0INT6dztiScb+69YbkR58K2yQNfRjynS5prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRfAE5lM/RCUsJPrIa5QZ/uOcu2NRcRQfgumlTEgJ1E=;
 b=WVLBAr/aH8tGjY1e0W8OJiGsSGXca0vIiOc/CZSt5K3+cxkeW92bWs3cYkrdq3lzXIj6oX2gPFrsLObDfjm4Y7a/Rza8bhpISgDc4hDVLnUoUXtArrGI8a+jlxJIqe+fb1dBUkJM4ejEcu633rAnriExocY9APO7WAVX/dQsAuN8l9bx6V5ApNal2deNHD5xeljssoP8qy+5CYsMeG8P0isDD3nUmZmDeKEN5vYaEmaehlSkq9BbPGT17Fzuax3KGWOaCNEAo6mGdlvtXpViXIh/wYGFHbjeLwO7EA1N8hwdg4ftiNz6sBrXi5qJjlG4kor7OtDmYKL9g1PBLFhtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRfAE5lM/RCUsJPrIa5QZ/uOcu2NRcRQfgumlTEgJ1E=;
 b=nAb5PslrWKwTZQ5eu3n5HLTesWf/yVUQHrPd/ZUdQttJsoRTH++XVMFsI0z0sQGXhzfuAVBe2Wx5l5OHyfWqErQ9TzmzNxJnWQcDb3rYu3vTjGonsdnIgaiPw0L/B1uec/hMTmY3sxeZvKSwJl6a/wKaUKnrjm3sgfaJzo8Ps8g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LY0PR12MB991423.namprd12.prod.outlook.com (2603:10b6:404:21e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:47:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:46:53 +0000
Message-ID: <de29b510-04db-4bac-a45a-ea8bf7632b39@amd.com>
Date: Tue, 3 Nov 2026 10:46:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/syncobj: Silence allocation warnings for user-sized
 arrays
To: "Yu, Fei" <fei.yu@intel.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 Madhur Kumar <madhurkumar004@gmail.com>
References: <20261103085002.3100723-1-fei.yu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261103085002.3100723-1-fei.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:408:f6::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LY0PR12MB991423:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf55686-0468-48a2-10df-08df398f643d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|366016|261102123227099003|261022105027099003|56012099006|11063799006|261021123027099003|261009223027099003|261009221227099003|261028144727099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: a8fy0USYZkaDMS5LGVSdRJHs//f3FPHzpVfTRGNJKM+AKBPiqtT6mZKUH3gDLiUu0FYKtLJCZQJDoths/3zGCspvJMWbpK2LZ23SbbwHld2Wr19XeLioz0HiZMwuOB6AhGatIYqxYSCVQkLoEqxCIlKBye2PD23JpZE/gYpimpYNEQZq+l3l81+SWH/gcJQ6xbAQGMWHkx4h2Ydyvujw8+wI3kqlOYJj0Bpff2hp16am2VxnTS63FEAMfwcfMYeA1yMMrksNAcINNicisvsXzi87qaeqa4LN6w4Pr1pOp25viI+4Fo4UjlFe8UO5B3HIVALFvUbQBrtJhhdN1h8sZ+0et9J4+UDVEUZ56f0JU0Ixsfl03NiA3uu8PPcIhn3mAMMrZymxz3qUMqHecbM+5Fdiqk8dV8Pz86W5d2ywD5CHyzLS67itZFayVolBxs+cs9CoBwh2CHDSWDl0VRz1r97JdofudA47v1EVuAz2sKF3794C1t99xtVBBj9CKCCXiJTOGuEfwwimM3jw/1f26hhg70buSoZXfAvNClsHC5OkGkPb+tiy8eZwUKPu2G3vHZUBvENriEHpjEimK+SifjHA3ZX/R0CL1+xpK3boxprrAoutAYhQxau7X7MJiene
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(261102123227099003)(261022105027099003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261009221227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5yTnJuczBOdzhJRzBSRmQ3YlhZTmRrMkdMeVBsdTQ2OVdqbjJpa2R1RUVG?=
 =?utf-8?B?anBBeVowcGtDbkFLUk5yTUcxTU5qNzNpdTZMTVFtRlU4WjVrcEkrYnVyejdx?=
 =?utf-8?B?NjZ0Z2pGdmhSaDQxZ2lLOEhIWUl5b1FFOXVPbWdLdFVDeERoamg0aUtsUDZr?=
 =?utf-8?B?OFIxMmYwTFM4RjdublBRTFhWLzhQUmV6Vnc5MzJvTVpCdlJZQjZJYnczS0ZV?=
 =?utf-8?B?b1h4Mzlzc2F1clp2ZzNCeGdOVkZ0cGNaUXJKK0RlOU1jVER4Y1ZmYnVQZmZq?=
 =?utf-8?B?eEVuWUJ0WGJQV2JMdTFNNlNkaU1xMmpIay9Qa3V5N09NVGdmeHcrTEcwMUNu?=
 =?utf-8?B?c2tOcS8rbGFITDk1clRRODRpUnVnVVRtOW9JODlldHlwTFR1OGpiUTFrQkZD?=
 =?utf-8?B?Z3lmVUZscTlHRkxvTlJLM1lQSTVJc2xjaEx0UldJbzhCcUdvbDRsdkx1OFlF?=
 =?utf-8?B?cTNoajhNY2VzYUNlMXNxN1dUTHVEbHdNYVY3Z3FsVmxZMEplVWhTdmJSYWV6?=
 =?utf-8?B?bURCUlVoblpXdVQ2bFpndUd2RHM5a3d3OHhhY2J2VndCRmZMZ1lSaHREd3N2?=
 =?utf-8?B?Z25OV2F0M3hUb0N2Znphak1pNFlrUnlUaTZHNGpBeXdqckpxbmQrSVhNK0Ft?=
 =?utf-8?B?MkY3TEEyYXJRUnJMZFpyUDBJOEthVjNwR3lxMFB4UzlBV3Y3TkNFZGxWQUFO?=
 =?utf-8?B?Ylgwbk5GWi9LcTRDQ3M1bUlabkEzRmpZd0xvb2w0amx3RFozTFFhMUU1MFdB?=
 =?utf-8?B?Zkx2Sm1xVHFSN1dYdmJtYmJsMXJYRkZ5RVJnUzgrbWFKR2Y0RkRSY1IwUnQr?=
 =?utf-8?B?dFZvZUtSK1pLb2pIQnFWV0tMT0FzTkozNkhkQVg4cU1zZ1hyNHhpdjg1ZWNr?=
 =?utf-8?B?bURTcm5BQWtBdFV1djVTOXg4em1zdXd1SFFqTWlXN1V5LzlZMUhWTWRROUE5?=
 =?utf-8?B?UGZ5TmdQWFJ6S0R4S24zQlBoUEc2UEY0ZDZBR3FuQmJ6L3cydVBSOUdTZzgy?=
 =?utf-8?B?RGI3K2Y2K3laaXExcVovYzRBM2xBT3lTUWJXRnFLSGNCYlVSbVg3QnAvS0dT?=
 =?utf-8?B?blpGem9PTC9IVWF4REQ1anBnM2dyOGNGcFBzY0w1VlViY1lhMUwxTEdPWnRy?=
 =?utf-8?B?M0R6S1J5dWg3a09GRjZHV1VXZ1VhWXpmNm1wWXR2NmdOTEp0S1E2eFhKUHZ5?=
 =?utf-8?B?cy9EOGkyTUxnUnBnQmZwOEY2UHdxaUp1b0hYZ0RuM3g0WVM0bFFQOTFWWGFv?=
 =?utf-8?B?eDVuaWUrQlNoZ3hVLzB6UDhBbDNrcTF6U1A5NWRROGY3dWR0T1Q0eG5yaUpT?=
 =?utf-8?B?R1Zld0hiRUNkUCtoK1l4Vy9NQWowaHFLdk9Wd0czMGtuTGtoZGxxOXk2K3h5?=
 =?utf-8?B?TG9UQTIvMTl0cWZsZG5HamxuT2xUa3BkL1dnOU5sNFhnSnhFOENuaUNSRlFB?=
 =?utf-8?B?S29pZlVzTUNVck5DNmh6TndhdDZjY2NMdG4wdEtLMGlkYjUyOVB6cFNGQlYr?=
 =?utf-8?B?OTdyZkZkZHNKeWlseVFvZ21UeXJ0cWlsYXkzb1NYdHg1dlZpQUpNbnNHaks0?=
 =?utf-8?B?Nkt2QzJPYjFlWjhodENMTkNoeGI0WFg0Y2dtQVU5bGdLQU5iMitqcW03ZkNC?=
 =?utf-8?B?cTgvN2pKUHRLZVQ4YWNQYTh3d0ZMMSs0WTIvZzE1djVhZ2RDZTFDT0d4ZGww?=
 =?utf-8?B?b1JzQS9HWTJKNFpneVdsU2RzLzM3ZFgvLzFwUnR0emlDVnBndU5lTWRFWHI0?=
 =?utf-8?B?N0RObWVRZC9BeUNLbnltRzRBVUY4YXpMQTRTOEtGZHYzTjlSVVB2UHVVR282?=
 =?utf-8?B?TUNVR0tJQXRpMlhQSTRSQUswRi9ESlJORFY3UVBCTGxUYW5taFdpemF2UG1w?=
 =?utf-8?B?U01pMUR6akhGWkhuNDlaOEM5N1ZXc2p2WTNhZ0RFTkhMSitMZlYyNmh1ejF3?=
 =?utf-8?B?N1p1dy9RejcyMEM1OU02VHVTelo1VlVSV1lFVE1YQ3Q4YUl3VzRYV0F2Ylox?=
 =?utf-8?B?UTJxditnNHNDVER6Z2JtWU1QbitXN3gxcmZQRFJaTDRSaVdxYi81RnVSd3BO?=
 =?utf-8?B?RXl1eEsyZ3VFVjFueHJURjQzNjY1SlV5MUJYQW9CY2w1QUwxOGtKdU8xWUd5?=
 =?utf-8?B?VFNDVmFVVmpDYkR4dGk1aElybFE0citjOFZ4WlFBYzlHRjJYZGR4Wmo3Y29U?=
 =?utf-8?B?YlI4M0h1RUJzODRCcTRJTnVHTVlxN05hWjhQRm5hL2I0a1IrbWtjRVVKZ29k?=
 =?utf-8?B?cE5oTU92V3cvYnJVdHZVUDBmWlNjYzloRjN0ODRObmV3TjhQRE9BREphNUwr?=
 =?utf-8?Q?dPuCn0bA5ifYb4ZBNF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf55686-0468-48a2-10df-08df398f643d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:46:53.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kTaGErxrNCVvntQuV0WGpCutw6PwIeoZf2LH6IEQzN7qVcWxE9AxkAgOcBnr1wU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB991423
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

On 11/3/26 09:50, Yu, Fei wrote:
> From: Fei Yu <fei.yu@intel.com>
> 
> The syncobj wait, timeline wait and timeline signal ioctls allocate
> several temporary arrays whose size is taken directly from the u32
> count_handles provided by userspace:
> 
>  - handles and syncobjs in drm_syncobj_array_find()
>  - points and entries in drm_syncobj_array_wait_timeout()
>  - points and chains in drm_syncobj_timeline_signal_ioctl()
> 
> A large enough count makes these allocations exceed KMALLOC_MAX_SIZE
> and trips the WARN_ON_ONCE_GFP() in ___kmalloc_large_node():
> 
>   WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x10c/0x170 mm/slub.c:5459
>   Call Trace:
>    __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5502
>    __do_kmalloc_node mm/slub.c:5519 [inline]
>    __kmalloc_noprof+0x3f6/0x710 mm/slub.c:5556
>    _kmalloc_noprof include/linux/slab.h:995 [inline]
>    _kmalloc_array_noprof include/linux/slab.h:1211 [inline]
>    drm_syncobj_array_find+0x3a/0x440 drivers/gpu/drm/drm_syncobj.c:1241
>    drm_syncobj_timeline_wait_ioctl+0x18a/0x640 drivers/gpu/drm/drm_syncobj.c:1356
>    drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:817
>    drm_ioctl+0x70e/0xba0 drivers/gpu/drm/drm_ioctl.c:914
> 
> The allocation failure itself is already handled by returning -ENOMEM,
> so the only problem is a warning that userspace can trigger at will.
> 
> Pass __GFP_NOWARN to all allocations whose size is derived from
> count_handles.

That is clearly not a good idea. __GFP_NOWARN should only be used when the allocation is optional and that is really not the case here.

> Guarding only drm_syncobj_array_find() is not enough:
> the wait entries are much larger than a handle, so a count that passes
> drm_syncobj_array_find() can still trigger the same warning in
> drm_syncobj_array_wait_timeout().
> 
> No functional change and no new limit on the uAPI.
> 
> Fixes: 3e6fb72d6cef ("drm/syncobj: Add a syncobj_array_find helper")
> Reported-by: syzbot+95416f957d84e858b377@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
> Signed-off-by: Fei Yu <fei.yu@intel.com>
> ---
> Testing: on v7.4-rc1 (x86_64, KASAN) the syzbot C reproducer triggers the
> ___kmalloc_large_node() warning with the same size (0x100000920); with
> this patch it runs clean. DRM KUnit: 667/667 passed.
> 
> Notes:
>  - An earlier attempt [1] added a size check returning -ERANGE, but only
>    for the handles array, so the syncobjs array and the much larger wait
>    entries could still warn, and it changed the ioctl's error codes.
>    This version keeps the existing -ENOMEM behaviour for all six
>    allocations.
>  - kvmalloc() was not used on purpose: it would let userspace trigger
>    multi-GB vmalloc() attempts. A hard upper limit on count_handles
>    would be a uAPI change; happy to do that instead if preferred.

Yeah that is most likely what we need to do here.

A "reasonable limit" needs to be applied to the number of handles given when that is exceeded -EINVAL returned.

The problem here is to find that "reasonable limit" since this function needs to scale from the tiny embedded device to the largest HPC cluster on the planet.

Considering that using kvmalloc() is probably justified.

Regards,
Christian.

> 
> [1] https://lore.kernel.org/all/20251227160830.34291-1-madhurkumar004@gmail.com/
> 
>  drivers/gpu/drm/drm_syncobj.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index f1d4da168..10aede1c0 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1051,7 +1051,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                 lockdep_assert_none_held_once();
>         }
> 
> -       points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
> +       points = kmalloc_array(count, sizeof(*points),
> +                              GFP_KERNEL | __GFP_NOWARN);
>         if (points == NULL)
>                 return -ENOMEM;
> 
> @@ -1064,7 +1065,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                 goto err_free_points;
>         }
> 
> -       entries = kzalloc_objs(*entries, count);
> +       entries = kzalloc_objs(*entries, count, GFP_KERNEL | __GFP_NOWARN);
>         if (!entries) {
>                 timeout = -ENOMEM;
>                 goto err_free_points;
> @@ -1238,7 +1239,8 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>         struct drm_syncobj **syncobjs;
>         int ret;
> 
> -       handles = kmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
> +       handles = kmalloc_array(count_handles, sizeof(*handles),
> +                               GFP_KERNEL | __GFP_NOWARN);
>         if (handles == NULL)
>                 return -ENOMEM;
> 
> @@ -1248,7 +1250,8 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>                 goto err_free_handles;
>         }
> 
> -       syncobjs = kmalloc_objs(*syncobjs, count_handles);
> +       syncobjs = kmalloc_objs(*syncobjs, count_handles,
> +                               GFP_KERNEL | __GFP_NOWARN);
>         if (syncobjs == NULL) {
>                 ret = -ENOMEM;
>                 goto err_free_handles;
> @@ -1573,7 +1576,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>                 return ret;
> 
>         points = kmalloc_array(args->count_handles, sizeof(*points),
> -                              GFP_KERNEL);
> +                              GFP_KERNEL | __GFP_NOWARN);
>         if (!points) {
>                 ret = -ENOMEM;
>                 goto out;
> @@ -1586,7 +1589,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>                 goto err_points;
>         }
> 
> -       chains = kmalloc_objs(*chains, args->count_handles);
> +       chains = kmalloc_objs(*chains, args->count_handles,
> +                             GFP_KERNEL | __GFP_NOWARN);
>         if (!chains) {
>                 ret = -ENOMEM;
>                 goto err_points;
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --
> 2.43.0
> 

