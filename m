Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B511606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2n/VCZH2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97DF910E852;
	Wed,  4 Nov 2026 09:45:18 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C11610E87A
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUsCo01sVYrG/aysq6LoZUlw7YXkWjkmmFq9lGwedsQwn46iLwKlW55PN1FHuRXzqm397tcOp0v2zMftLKbZrKKI9iAkOMxWb1WuOHRYuG+RiA6prWYmJgZh3VYCcu7dyVCqpn2bR8ax0XqZx+yr7vsTrKzFQOLKX4KnKRfJ4QQhv+em3qhEKLauHAXHyqzwg7QsQbsy/TdTf85WYDsBsP3pjB4No+48jcT2YC3qwsBFYSlfxJhzhMum958F8H9t1++g3s6MmcxA2YGVDJS8DbkQkAm7Sb/NZ9dPoizngjaclGYzN8GjW6Iz3G2Eix8DeJUVaCB/GqT3oHM2Nvjz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grC87aXGTMnSpqdYs6SEbsA65QbwhWo0vq7ssx6NQlE=;
 b=olCq6Qis8itt5AfodHGKrRbsyh6UDq2nV4bC8aUkYUawwa926rQXCDyREa/HVKETwod6NJxcSDILvpmcWU5HzJuSw3ZxlnAUsJpx+Ti0q04rvUGC0Zm6aKzXasfrdJys579KB57+NbQnkso495WAjtDsQG1BDGcCap3UllMo3uOB8T5wjVBlp1eMLORtrCX+2I8Xbd6cXAi3c5DrTNWPZQlsntQvT+R7W3BWLNdEleX5otEq45/oECQ3tJzxPaOLCFOAwLMznjXYfeeqxxYcN8PcEDDAqkMqDT4xiDuyTszWL0gzqUBYMC50YXnV9luivNQK6xQYLAF7v3o8fuqgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grC87aXGTMnSpqdYs6SEbsA65QbwhWo0vq7ssx6NQlE=;
 b=2n/VCZH2s4LZLFUh1/ZoIlsMrw1nqV6k61VwSk6Oz8C+OyxlVRxeheFlnaXRkib7N/8LhkRQAuvXhiB0zi2zC5cr5YMBsr8kYjppulNJeHlK1OTxX6Kw7P4lQ1F8Rbr8OC5u1s+ssXgE+BAZ1zStSMZoCafWNNeVVMraSiRrUtg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:45:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:45:00 +0000
Message-ID: <1d8aeaae-7c89-4a99-975b-5467c33554b9@amd.com>
Date: Wed, 4 Nov 2026 10:44:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: "Yu, Fei" <fei.yu@intel.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 Madhur Kumar <madhurkumar004@gmail.com>
References: <20261104030930.3852781-1-fei.yu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261104030930.3852781-1-fei.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb13a7d-1159-42b4-8f19-08df3a584ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|7416014|261021123027099003|261009221227099003|261026140227099003|11063799006|261028144727099003|261009223027099003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: mYzzBFvzKb65sFd3lcBZbveRqW/dbqXiCVXdYgUwHgdt7B4koZzH+KWebU0sIn9/EL40BN5FkswSSNsNA0ZSuYHCJtWJkGeUjeIBtP6IHc1ZMxEjcZp+NDdilaBYiPm6w4eJPh+oksk2g+/nv3eNW6fBqwYCk2HHVz4ByUwJilPIQ2gcVmnkzDtai4qn3Lp+l9x5/B3vipPBAd1cz9Yeq6l4WZg1vpQwTWOnuM3SXreP0OGASv/K6mjKculjdIrQx7OZX3c9qNXKeg/t14fPXP4C3PKKf10FXzqYgiPCAOFry2XdXyGwmTtLw6g4UnYkTEACAhgrSczKVW/Jx6Iy5ByxH5TeRzxGh9Yh941KlMTj1hO7Hc7QiSk+lp3fKODSaGijwPPlkcEZ2BwotpxTdI/6QRl4Tr4Ne50aKwGayS735kmAAe66R+4VJMu8Fd13VOoi+b1mXznNPjgeTk7+vSiAE5TtXQ2KP9XMAegXdwE91fAenQRJXQYdYhZhW1azsPSkoag0QnaZEX0t2N+CcK94WUl+iODGZFA/3B6NoRXcTKDkCsy+2bRR4PqWnovLRH0iA0QNTF/ioJL+JhZi0vQqIYUh4yuq7dtSuXvaSuQMO6/avFDrQkJ7AzdHGJ9H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(261021123027099003)(261009221227099003)(261026140227099003)(11063799006)(261028144727099003)(261009223027099003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qklwd1plcjM4NlM4Y1FleWYvb0NXNlliRUNKeEdZakFVRzJSUkJ0eHNKcm00?=
 =?utf-8?B?eSs5dTN2OStFZGhhNWxPMmhMUHpDMDNPYU5zRjRIOVMrVVBJb0pVOUNrZFcw?=
 =?utf-8?B?ZWl1bkZjU2hXRGVSNW9mQkJ0KzdXQVNJbHNnd3UwUVNCV3lzZ1M2QnJyTHh4?=
 =?utf-8?B?cUd0MCtNeTBvUldMK2RRYzRKRWV0eE5qWEVJbkF6ZWEvMWM2T2RoQi9UTmxO?=
 =?utf-8?B?aE5iWmw3dGMxaGpkZ3VRMzl5Mko2cm15Q2dJZmZwTUdtYnJrTCtDaG5lL3pP?=
 =?utf-8?B?L2NvQWpGaStJQjAyeDF2alRpQU5OVDdxbUVVMm9SM3pxUlFSSlhhVWdQbC9v?=
 =?utf-8?B?QWlueTl3TXR6K0dlUGdWUUg1S3pYcTd5SU5NSEpESFc2bE5JRkhMSmdDblBk?=
 =?utf-8?B?SzI2SEdObEhIWTlNL3RzYmtlbUhXbHJ6M3JuNThWL3htcHpwR3RoTkVBMnVP?=
 =?utf-8?B?Y0c2UTVxWXRyQjhwUTNLQ0ZFYVJwNGdOVW9pNURtQzR3R0tSdk03YldPcTBX?=
 =?utf-8?B?YStZUGNyVnlOWXU4bitzYWh6cFpOdHNFWjVRV05xYkFkVVBaMHd1amw0SU1a?=
 =?utf-8?B?UHlHcWsrUm1SQ3RVM0E0UCtYdXJmMFd3WWVSc2hGR2dUT1lTbHJORDhnOVIr?=
 =?utf-8?B?b3lnMEpGR25hUzJRMWNBUzFPdmIwZ1lNNzRYTGhHeE5KSzZ6cVJUUFNSREdI?=
 =?utf-8?B?S3BwV2hKZVFlS293a3YvWVQ3L3h5c3BkK2MwSWRBbFVKUHJwYkRIMkNhdGNj?=
 =?utf-8?B?K3BGbUh2NVpxRXlQdkttYzdHSEF3bk9kTVBnK0lWMmF6Nis2RlNaQjRYZzUx?=
 =?utf-8?B?WXgycS9KeTJzK1krQkZ4YW9vVWRhTXJiRWpRdHIyR25LTWdRWElUNHY1Yjdw?=
 =?utf-8?B?V1htQ0hXOUpEbHdvUjk4YzBVb1JZcjFMS2JFaEt5aHRuVFJ2UnFycnF5M2t0?=
 =?utf-8?B?ZU1lZk9JZWE2RW9PcFEycllnR1lRajJZekN3aW1lRUxhOXZzcGpNd0pmenZq?=
 =?utf-8?B?NmNBUksxSkRlRTEyTW12Y3BCdlc0YndOaThQTFVBZUNtL2FERnFPS0IyMXBD?=
 =?utf-8?B?Rk5xbG1CN2t3Lzlsa216eFB0N0FNQTNNYmpQMXkvMkhzUXpzSzZaanM1dGw0?=
 =?utf-8?B?N3RqL1ZxZFc3dzVJOTgzK3dGZmwyTTRWSCtaOUd0dmFQMGQxVEZLdkVlMkto?=
 =?utf-8?B?WjkyQzVhU2ZOWm1rWVNzbm5MMkkxWkRORVNqTlhkd2pUUFY0eG9nbnF0RUxP?=
 =?utf-8?B?NnkyazNNbmJsNUUrRUZBMkdkT0gvOXZUc2pDU1gxMWE5ejVtZ0RKRHpLaXk5?=
 =?utf-8?B?ODB3a1B5L3FFY0FiYzRYUkNjOFUrL2JSc2RMRTAyNXZoZDZmTk54c3hOUXZm?=
 =?utf-8?B?TXNjL0ZJdklZMk5yTFZtV3pHa0lXU1Ezc090SnpDOTJ0RURLZWRkellxNEtw?=
 =?utf-8?B?N2lsLzk3YXZIWG9FRnZKc1N5a0JqWk5xZDllWWFFYUx1WFZRUy9JS3JzalNZ?=
 =?utf-8?B?ZGIzRFN2OUF1ZWpvSDdpYWVTU0FOWFZyNXhqZStSdDNRQTluRWl3UWF1NFVV?=
 =?utf-8?B?VmxTZkVPRlNoTHpsNjJaMGVpS0ErU0ZnRnFwR3R5eE1OUnR0aVBIT0RvWjF0?=
 =?utf-8?B?L3p1clVoSno1cXhCY294REFKeVI0bktVUFJFY2FNSmkwL3VabE11V3pWeEN0?=
 =?utf-8?B?a295ZVYxMDFQY1VTQkNmK0hIS2kzZG90NFUrT3V1R2pldUhKT01pTk1taGZy?=
 =?utf-8?B?aFdvc1Z3N0dFRUxBL3QrbWJqSDZUM2pEQldNSDV1N0E4RnU0QWtzR0gvNnNM?=
 =?utf-8?B?Z3dMWkxwZkZQb0ZsaDhLcW9neUpIeDdsc25FT3hzeExTYU5nN0NnY1RBblYr?=
 =?utf-8?B?cFp6QnpLTmcxTW9rb3NXUTFSZHNML2hrV0lLOGtSVFBqL21oRTBCRkQwa3pw?=
 =?utf-8?B?TjdRSUZaa1U4RG01MGZ0SFMxSldFc3kyTXM5NnF6dkIycFZLcm14Qkpvc05p?=
 =?utf-8?B?KzZUYSsvSVV3U1NrRHVmcTZaOU9ZZWpXUGtnT0twMjBoNVhlcWFSbWJETE1C?=
 =?utf-8?B?VXBaaG5KOG9aVWZUc1VFa2dYRG1jVHJLWVpjQ1cxUXg0aS9zNHkzckYzQ1R6?=
 =?utf-8?B?Z1hMbmpRYWhRUVVpclpWSjBvK01OWGtiSmVxRGg1MlBoa3Y1ZFMwYjF5N2lr?=
 =?utf-8?B?bEsxUTA1S0Q4eDhzYTlHRmFVSHovamhCV1lkcG1kSXVIcWxLd0VIelFLUk0x?=
 =?utf-8?B?N1BIQ0tpV2JrSk5PNE1ncnVlSGp1OUZZYXBKMkZFSXBUbXVuc1RzKzRCY0N4?=
 =?utf-8?Q?ZVGoK/J0qH4mLLfpFx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb13a7d-1159-42b4-8f19-08df3a584ae2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:44:59.9755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJtXRRQdXy7GPfJiFno2ECZVpkodY1cShnzNTfqT+iaS3HshTBct5F6oj39Yp1Hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

On 11/4/26 04:09, Yu, Fei wrote:
> From: Fei Yu <fei.yu@intel.com>
> 
> The syncobj ioctls allocate several temporary arrays whose size is taken
> directly from the u32 count_handles provided by userspace:
> 
>  - handles and syncobjs in drm_syncobj_array_find()
>  - points and entries in drm_syncobj_array_wait_timeout()
>  - points and chains in drm_syncobj_timeline_signal_ioctl()
> 
> These are kmalloc() allocations, so a count above KMALLOC_MAX_SIZE /
> element size trips the WARN_ON_ONCE_GFP() in ___kmalloc_large_node():
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
> The wait entries are 64 bytes each on 64-bit, so with a 4 MiB
> KMALLOC_MAX_SIZE a wait on more than about 64K handles already fails
> today, with a warning.
> 
> Fix this in two parts:
> 
>  - Reject more than DRM_SYNCOBJ_MAX_HANDLES handles with -EINVAL in
>    drm_syncobj_array_find(), which every ioctl taking a handle array goes
>    through. The limit is derived from the largest per-handle allocation
>    (the wait entries) and the INT_MAX size limit of kvmalloc(), so none
>    of the allocations above can exceed it. That is about 33M handles on
>    64-bit.
> 
>  - Switch the six allocations to kvmalloc(), so that large but valid
>    handle counts no longer depend on physically contiguous memory.
> 
> Using kvmalloc() alone is not enough: the reproducer asks for more than
> INT_MAX bytes, which hits the WARN_ON_ONCE() in __kvmalloc_node_noprof()
> instead.
> 
> Fixes: 3e6fb72d6cef ("drm/syncobj: Add a syncobj_array_find helper")
> Reported-by: syzbot+95416f957d84e858b377@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Fei Yu <fei.yu@intel.com>
> ---
> v2:
>  - Drop __GFP_NOWARN (Christian).
>  - Add DRM_SYNCOBJ_MAX_HANDLES, return -EINVAL above it, and switch all six
>    arrays to kvmalloc() (Christian).
>  - v1: https://lore.kernel.org/all/20261103085002.3100723-1-fei.yu@intel.com/
> 
> About the limit: INT_MAX / sizeof(struct syncobj_wait_entry) is about 33M
> handles on 64-bit. It is the largest count for which every allocation stays
> below the kvmalloc() INT_MAX size limit, so it does not add a new policy
> number. Today the real limit is much lower: a wait on more than ~64K
> handles already fails with -ENOMEM (plus the warning), because the wait
> entries are a kmalloc() allocation larger than 4 MiB. If you prefer a lower,
> fixed limit (e.g. SZ_1M) or GFP_KERNEL_ACCOUNT for these arrays, I can
> change it.
> 
> Testing on v7.4-rc1 (x86_64, KASAN, virtio-gpu in QEMU):
>  - syzbot C reproducer: base warns in ___kmalloc_large_node() (size
>    0x100000920), patched is clean, ioctl returns -EINVAL.
>  - wait / timeline_wait / timeline_signal / reset / signal on 200000
>    signaled syncobjs: base fails wait and timeline_wait with -ENOMEM and
>    the same warning; patched all succeed.
>  - count == DRM_SYNCOBJ_MAX_HANDLES gets past the check (-EFAULT from the
>    short user buffer), count == DRM_SYNCOBJ_MAX_HANDLES + 1 returns -EINVAL
>    for wait, reset and timeline_signal.
>  - kmemleak clean, checkpatch --strict clean, W=1 clean,
>    DRM KUnit 667/667 passed.
>  - IGT syncobj_basic, syncobj_wait, syncobj_timeline on virtio-gpu:
>    202/202 subtests pass, same as base.
> 
>  drivers/gpu/drm/drm_syncobj.c | 40 ++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index f1d4da1685457..c01cf164a4f9e 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -220,6 +220,13 @@ struct syncobj_wait_entry {
>         u64    point;
>  };
> 
> +/*
> + * Upper limit for the number of handles passed to a single ioctl. The
> + * largest per-handle allocation is the wait entry array, keep it below the
> + * INT_MAX size limit of kvmalloc().
> + */
> +#define DRM_SYNCOBJ_MAX_HANDLES        (INT_MAX / sizeof(struct syncobj_wait_entry))

I really wonder if we should put that into the uAPI files?

Not that userspace is potentially using it, but this is part of the uAPI and makes sense for documentation purposes.

> +
>  static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
>                                       struct syncobj_wait_entry *wait);
> 
> @@ -1051,7 +1058,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                 lockdep_assert_none_held_once();
>         }
> 
> -       points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
> +       points = kvmalloc_array(count, sizeof(*points), GFP_KERNEL);
>         if (points == NULL)
>                 return -ENOMEM;
> 
> @@ -1064,7 +1071,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                 goto err_free_points;
>         }
> 
> -       entries = kzalloc_objs(*entries, count);
> +       entries = kvzalloc_objs(*entries, count);
>         if (!entries) {
>                 timeout = -ENOMEM;
>                 goto err_free_points;
> @@ -1185,10 +1192,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                                                   &entries[i].fence_cb);
>                 dma_fence_put(entries[i].fence);
>         }
> -       kfree(entries);
> +       kvfree(entries);
> 
>  err_free_points:
> -       kfree(points);
> +       kvfree(points);
> 
>         return timeout;
>  }
> @@ -1238,7 +1245,10 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>         struct drm_syncobj **syncobjs;
>         int ret;
> 
> -       handles = kmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
> +       if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
> +               return -EINVAL;
> +
> +       handles = kvmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);

That kvmalloc_array() + the following copy_from_user should probably be replaced by using vmemdup_array_user(). But that should of course be a separate patch.

>         if (handles == NULL)
>                 return -ENOMEM;
> 
> @@ -1248,7 +1258,7 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>                 goto err_free_handles;
>         }
> 
> -       syncobjs = kmalloc_objs(*syncobjs, count_handles);
> +       syncobjs = kvmalloc_objs(*syncobjs, count_handles);
>         if (syncobjs == NULL) {
>                 ret = -ENOMEM;
>                 goto err_free_handles;
> @@ -1262,16 +1272,16 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>                 }
>         }
> 
> -       kfree(handles);
> +       kvfree(handles);
>         *syncobjs_out = syncobjs;
>         return 0;
> 
>  err_put_syncobjs:
>         while (i-- > 0)
>                 drm_syncobj_put(syncobjs[i]);
> -       kfree(syncobjs);
> +       kvfree(syncobjs);
>  err_free_handles:
> -       kfree(handles);
> +       kvfree(handles);
> 
>         return ret;
>  }
> @@ -1283,7 +1293,7 @@ static void drm_syncobj_array_free(struct drm_syncobj **syncobjs,
> 
>         for (i = 0; i < count; i++)
>                 drm_syncobj_put(syncobjs[i]);
> -       kfree(syncobjs);
> +       kvfree(syncobjs);
>  }
> 
>  int
> @@ -1572,8 +1582,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>         if (ret < 0)
>                 return ret;
> 
> -       points = kmalloc_array(args->count_handles, sizeof(*points),
> -                              GFP_KERNEL);
> +       points = kvmalloc_array(args->count_handles, sizeof(*points),
> +                               GFP_KERNEL);

Looking at the code the handling of allocating the array and the just memset()ing it to zero when it is not used is really sub-optimal.

But that is just a side comment and should probably be changed in a separate patch as well.

Apart from those minor comments the patch looks good to me.

Regards,
Christian.

>         if (!points) {
>                 ret = -ENOMEM;
>                 goto out;
> @@ -1586,7 +1596,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>                 goto err_points;
>         }
> 
> -       chains = kmalloc_objs(*chains, args->count_handles);
> +       chains = kvmalloc_objs(*chains, args->count_handles);
>         if (!chains) {
>                 ret = -ENOMEM;
>                 goto err_points;
> @@ -1609,9 +1619,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>                 dma_fence_put(fence);
>         }
>  err_chains:
> -       kfree(chains);
> +       kvfree(chains);
>  err_points:
> -       kfree(points);
> +       kvfree(points);
>  out:
>         drm_syncobj_array_free(syncobjs, args->count_handles);
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --
> 2.43.0
> 

