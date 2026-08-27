Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0432C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DA710EED1;
	Thu, 27 Aug 2026 07:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oa5B7925";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8FA10EECF;
 Thu, 27 Aug 2026 07:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787815861; x=1819351861;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QlhLGh+5ZVIvUZlwtj/y5dZCGrMeRPzd/Ah8/wcvJUQ=;
 b=Oa5B7925J6OKrmOfxYBOSOt5qzwzC1j78YPTg+ejMLdUvd5w8AQNwQ3l
 4pK+bH2OjRwTv1csJWhqpjxhvvTjLQL2s1rr96nD0on3MGAr2g0x+1WRj
 eEcfN7d92atrl+/UAfKNb6Nfu1HD/1W6tQAR4pKHYr8VRTLjPcS+T6O8S
 3EpqB0vAuY0C2oRHVRetkyzv7a2uRZfwipiYKhU76h/OAa7D3dRVTjl8p
 cqXdlgM80SbLWW0dJD/cyZHY+tc+dEixzjhTPteBeu63xqRuM3CYoBbvd
 U/x/x3QkTWpTtjFCyXq+JB/DRozbl3S4AvdTJmymY/KZ8CAkyBusxFVXZ g==;
X-CSE-ConnectionGUID: pHcXv+cbTmqJwTjpYSI62Q==
X-CSE-MsgGUID: FUG61NjyRdmuD+9YfVMfpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98907298"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="98907298"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:31:00 -0700
X-CSE-ConnectionGUID: JoBwQVm4SFOTxW4f/BDhbg==
X-CSE-MsgGUID: 5I5tUe5CTSuwLMz/qrk+3w==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:31:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 00:31:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 00:31:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 00:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4k9HkOBVbN8hZFjHn4pPYcjPXp9rOnGdkRRGWgMF7UN1t6TwMbIrXuYjMV9y4j3aZYc9OcQdw62nE0UFrH4+KBUkbT+m0yDJbnFZMh2AchVPw3mImFn5x0bs9elWjtg6OwEOs2YfzSOi6LXDA/epjRJSnWUNTdhUVvkWzIz3LpjVPLatmSql2rBeEkqG0oN8QNqYy3AyixxjNd1/1FxGXD2Qc6jWTnKXN01/Z3HlDQuNn/S7XyHHQZzp2GZwR/627EaPOVlThQm3P8ZegoiMOz2HDoQaSr98qe7asNieRa0dG/7kAyr1FKd6/PSA2F/Nww8oyY1jflreg59zCUEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhJ43FlYdAAqY2qpMsQbi7s0+x9yDQhPhjegCEjD65g=;
 b=CngkNzeWcrKels1+8nUHshlUEeA3DuugwEoL+auV3A8B6HzhCM6pUPk6q1qARDWtRJIzp0Gv7Tf200Of9zP8N/+2rARM2f+Nvg2v/yGR+4SjXCzg2psHs4IwActwWuQ6TQ++8pu2oCwhB4yVpOngeGxz+U0IMyeUu9r8LKJytlM23zOIF7tMbkWzQlY9YRaqRmj3kgI1GGj1Z0DgdDmu9i1YqLvdHqPne2OFoBybTFY5d1dvZJMHL9/GXVL+hUTBwrdBLDXtuGmynXXERZxbkanDKcKmRykz/rPZDs9Ww4gM2fmVdyGThYl39r0e65dLXb9ZapAXnhOON1IAiqrXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA3PR11MB894536.namprd11.prod.outlook.com (2603:10b6:806:532::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:57 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:56 +0000
Date: Thu, 27 Aug 2026 00:30:54 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH v1 1/5] drm/gpusvm: extract drm_gpusvm_hmm_fault()
 helper
Message-ID: <ao/nrkOMOllUKqyG@gsse-cloud1.jf.intel.com>
References: <20260827071449.520398-1-honghuan@amd.com>
 <20260827071449.520398-2-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260827071449.520398-2-honghuan@amd.com>
X-ClientProxiedBy: SJ0PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA3PR11MB894536:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a79f70-7110-4c63-f846-08df040d2267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 2fhDQT1BUkqioc0HQ1DZNKT841Vu5iSlETpoQc12llRtgwhsDM/bX+/3oNSUAtNhyFBjEm/BlSQ9htOIFIYA3OIzZT/dGdzxsq0bxZ0xkMmAROoDUoVu+31bIbp9SB/IXbb//Jo5GeK2eptQzx4rKIZJvyg8tHmyXzD9JJzeeW1TZEh5E2WD8x33QBZ5ZpajTWF4PGhgpwkDPyyIzXD31L0WTF3Loa4q0AoJD2OWGM07dSpstd//s9WkRmhE3CYudxDV89PSMGtEjr7tz/GJvwRnOC6DADDRMepthoK0eYj8bwHxb87X0FlNM4JtEenZuoqvBEoM7Oj4OvUIIw2ueVmxTXUTUWhKWtQ17DgOM4/1Ql2kiM8pcwFcZrLWJAcMUnQAyIyNYJ4mfdyVWX5qyIh51nWWzmylBo6g0rwKSfntp6dNhhSTURcYYWShzfcmB+2PMk2TY3e5G46pv58tWSV9PItayl7InGqIhe1fkjc1TPr8qINrywxH/b0IQugMZxl/QlbB2bNzv86oCC2Cq/24mAJEIMKUBT6CtnZUWHY4iTWYRF/0UfsS+uX8/+Rx541xb5l8yG+bjqkoLuj8rNpDCTyE/IdZkS9DKlx9tUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gkGKgomGs0XFEVGNpcSoJe0dtHLFYCSdmflMA6cOXIVd/TTGjNc4RzA8qle?=
 =?us-ascii?Q?RtPBhlCF/66/QzkxB8ZXJgPS1Z2YoglVr9aL4gls1WBuM9QhGOVPOcRQWmSo?=
 =?us-ascii?Q?mKNOQLoKJeDYjacN60CnaBTarOKS2MahmiK8xri4DLjpHWxGVLRATheJRU6u?=
 =?us-ascii?Q?2FUdY0lAlSkH3GjXx6ohoSy/Of4pOgjnb3cSn+je+5XIgi1ozkSV/wLFKBRg?=
 =?us-ascii?Q?QFzeIXRnZyOGNUJJCcJ8paxqolPE3mbi1D2LAEFik0zG9hLRPqp/xCzSgD+V?=
 =?us-ascii?Q?kqYQu050zSxcxdtwQnG7WDvYAoqu7KezZNsMsgTRv6t7aw+zWb0N+U3nd5xE?=
 =?us-ascii?Q?h746AFwimURaw54W8HALdQi9mm98LVARIh0Lw5uHp/8gLHrfI62h27kJwNQ/?=
 =?us-ascii?Q?jdpLWVIlKXsSupn64ZdejoUSvKJoLVkhce2DX75Mk48lj0vn3obWe7nwgyZz?=
 =?us-ascii?Q?9mO1NDWtvEfnrkDUiUDOIIXZwPFmqMZlDUug/icDqfUJJD9Qvx265VejfWWG?=
 =?us-ascii?Q?DiFLhqqiIzoTha+O3x+R8mmTSj3JgRsNX7tgm6SmpOBW00BdgM5hkR4npDHK?=
 =?us-ascii?Q?/pBRDnh1yxLvEzavqpe/+t4Nn1yZeY4/NmG0RqDvvoBMhWjOIQA1lxg+IK47?=
 =?us-ascii?Q?436uNG6edyz7yHn6jSUoCvo9kZCOgDDODF2DuTq9RqbPzkyUBaBSKK8pniPt?=
 =?us-ascii?Q?LrD2fILjTVOziZ2U84ia3mNXV4RNidQCz8QYLD44OZl68T7Y2rhc+Gg60SEk?=
 =?us-ascii?Q?JCv6S+jd8xiln3hKJfocYJekoJkn1QmLkdmiOkdB+p1RUsVT0Jag7x74AKpP?=
 =?us-ascii?Q?PnCiVYj0aA9CBuQr2qCcuDhfsG5DNMd15e1G6dc5yHeY7KCihaniFWrub4E/?=
 =?us-ascii?Q?8R3ff8C8SQMFGejEYw8gXCKLBCzhLzddBM3G6hUr0gQ/R5nIAV7zFNu45KHy?=
 =?us-ascii?Q?Ts6ZnmKV1f8Am+zAO6JuIFF+yhZMC7Swu5tyUNd6MT7hmReNYniUpuRc3T8g?=
 =?us-ascii?Q?i4qAvMFtDDQG12oYgvqxJiP0k4NL4mj8wQ/Se5ZO5I9MLUVso/8Xsfav37hn?=
 =?us-ascii?Q?Bh43/rUnO8vkNTINksrXkyPd2Au7EiXacT9EO0uVnmRbETJgXWcFyFhF1QRF?=
 =?us-ascii?Q?BmAFDKf/Upgh9qkGGbwgKGVaJ742KGr970ngZA2LWgpz64Gwopn/uptAXEat?=
 =?us-ascii?Q?QhvEzf9qOTwPe2e3+kAkUKO/60+dV2WpsDnjR8rbriYyKIKDe9MNSEbIoniK?=
 =?us-ascii?Q?uzBiVluhuXB+VMZfUWpTDKGo2ytkRN/cR7HL3h80BlgnlYraP+PjwgRxCoop?=
 =?us-ascii?Q?4XMfNzzjHEEVwtQrWOxOQwAGnET15x4EdgM9eiHpLpZLZ1zkFp+1P86eMGoE?=
 =?us-ascii?Q?Qtt3vD3zN82hLUOHO1wSv0ogjynyZDN81Gz57TEM61tqqJkH1e5OzhJJtOER?=
 =?us-ascii?Q?WOEe7XSeT2wwGAEcOSkT0x2kfzc6GQbDo4Oddpk7Gw0L+bIdtrYnQMD2wgok?=
 =?us-ascii?Q?6iny/XvGW5x4lEL3BFQVrvXE5PFbMS7wZJ/bPGFxeGGh+ANFYgGJ0/4nzt2q?=
 =?us-ascii?Q?MM9r0wsoqv/UdCWkC3B5coKLwCZJW1OpeIdv4TBPmbiAESu6QljzuQTaZdd1?=
 =?us-ascii?Q?rxTW5zvGzH9FpqDIURz7tay+TO5UWw4bO7qEsXzKteVL4Ib/j1J7HaQwv4yy?=
 =?us-ascii?Q?akxahaEaYwecmdI7PfMUpgsQ8RkGqgGIafPbQUC7E+6Ev28XUjEauUS3RHin?=
 =?us-ascii?Q?5532rnBHHN0U5CsXqmL3OylRkIexlhs=3D?=
X-Exchange-RoutingPolicyChecked: mYKhWp6SQbPcJLGgnJzwHmJYa27foJ2IKaJl6g4bT6UQ8y2/OvwYiK/6P+sVBOMzdh34sodFyL+NvU0B3zIsClCRQ6IhJIhwuECLpHWsHyBBPC+NzxBxL+2fPfgdftaotRYU1MgKZMxMKxX5IxpC8mYZjiFcrGpoJNRDQkhHqOuBTCaDxuIg6SKPV6vXYthfeLVVmd3j82xGHY69gh0IZZN+IppRGkPSsxz6VJ1tzvp1qXGodO68qL3B54FAJd737UZoUpLUCxL/Pi/HxfH5OkNtkOvFdGiZ7hXgJ5E4YfdCyCzAwc7sJc/nrRzjHYegN1GBogGCGX8xwhn14iEBjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a79f70-7110-4c63-f846-08df040d2267
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:56.9553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uxVhSuI8r7NwlrguedGMZMpQ+e8skzcjMIH1YRU+EwAnvjLPXl7SsL3xjGoa9adEkKFRf4v2gnTzCxpEyJT9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB894536
X-OriginatorOrg: intel.com
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

On Thu, Aug 27, 2026 at 03:14:45PM +0800, Honglei Huang wrote:
> Make the HMM fault step of drm_gpusvm_get_pages(), including its -EBUSY
> retry loop, into a helper drm_gpusvm_hmm_fault(). The existing logic of
> the public drm_gpusvm_get_pages() is not changed, only relocated, so
> there is no functional change. Keeping the retry loop in common code
> also means drivers never have to open-code their own fault/retry loop.
> 
> A single fault can later be shared by several drm_gpusvm_pages instances
> that mirror the same CPU range. This prepares get_pages() to split the
> shared MM-level fault from the per-device DMA mapping. No functional
> change intended.
> 

I think you might want to just wait on this until Sunday for this
series. I think this patch [1] is in the core MM tree so when drm-tip
moves to 7.3.rc1, Sunday, we will have a version of this helper to core
MM used in gpusvm.

Matt

[1] https://lore.freedesktop.org/nouveau/20260722-hmm-v10-v1-6-606464dd601a@gmail.com/T/#m68f663ce3e802d7692363c70e6364569134cd6c7

> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 67 ++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index fcfe635bc195..507ef6f0a60e 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1442,6 +1442,50 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>  	return pages_valid;
>  }
>  
> +/**
> + * drm_gpusvm_hmm_fault() - Run the shared HMM fault for a CPU range
> + * @gpusvm: Pointer to the GPU SVM structure
> + * @mm: The mm corresponding to the CPU range
> + * @hmm_range: The hmm_range to fault.
> + * @pfns: The pfn array to populate (size @npages)
> + * @timeout: jiffies deadline for the -EBUSY retry loop
> + *
> + * Fault the CPU pages of the range into @pfns. This is the MM level step.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int drm_gpusvm_hmm_fault(struct drm_gpusvm *gpusvm,
> +				struct mm_struct *mm,
> +				struct hmm_range *hmm_range,
> +				unsigned long *pfns,
> +				unsigned long timeout)
> +{
> +	int err;
> +
> +	if (!mmget_not_zero(mm))
> +		return -EFAULT;
> +
> +	hmm_range->hmm_pfns = pfns;
> +	while (true) {
> +		mmap_read_lock(mm);
> +		err = hmm_range_fault(hmm_range);
> +		mmap_read_unlock(mm);
> +
> +		if (err == -EBUSY) {
> +			if (time_after(jiffies, timeout))
> +				break;
> +
> +			hmm_range->notifier_seq =
> +				mmu_interval_read_begin(hmm_range->notifier);
> +			continue;
> +		}
> +		break;
> +	}
> +	mmput(mm);
> +
> +	return err;
> +}
> +
>  /**
>   * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>   * @gpusvm: Pointer to the GPU SVM structure
> @@ -1503,28 +1547,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	if (!pfns)
>  		return -ENOMEM;
>  
> -	if (!mmget_not_zero(mm)) {
> -		err = -EFAULT;
> -		goto err_free;
> -	}
> -
> -	hmm_range.hmm_pfns = pfns;
> -	while (true) {
> -		mmap_read_lock(mm);
> -		err = hmm_range_fault(&hmm_range);
> -		mmap_read_unlock(mm);
> -
> -		if (err == -EBUSY) {
> -			if (time_after(jiffies, timeout))
> -				break;
> -
> -			hmm_range.notifier_seq =
> -				mmu_interval_read_begin(notifier);
> -			continue;
> -		}
> -		break;
> -	}
> -	mmput(mm);
> +	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
>  	if (err)
>  		goto err_free;
>  
> -- 
> 2.34.1
> 
