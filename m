Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BADC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000A410EA1E;
	Tue, 25 Aug 2026 12:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9Kkj0AA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445D710EA1E
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGNJ7KHUGrniWK2dmvoETvNGoyhc+uo9TfpVFtnDEofTVhOleO/esihJYwxhUxa1fQkp6UjtDqtFFerfebexeEFRQLGlNgPGcON0sqV+qxHoLPBY6DtF+GAK3a9Gg7sOc8Ue/qUe40QUNLQaLDFhWeYHxaswQIaFne2GlS7GdpZ+ae7hfCjA85SHiwUa6XvuFA6d1kgJ0aTrw/nLN8RhOeYuOmcjo2grRJGFwItmvF3SE3H4eWjV7bWIJhNnpqJ5B8XgNIBahY+B/dUda41hZlX1dmlql7C8XWqIHWWr03QSxjGxEMDoaw2UNJWW7+55wVrdD4i23NLFwrc3oXEDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5JT5stZ6/Ize5JTRsh/w1ACQoC9qwXd3SHu1WN6/Hs=;
 b=jZFU9fxCAtutGtCQBg7uoFJ8iHzBO9qJuKAF31sqkbs6M/6ZGUNKNk+fwSnZnfZ/9NyAvOEIxcuvFpyWocQHwo456awrJIljnOJd89vT8hbgNNfnARh2aF4AhFPo1SsJ03z+X1fBCUJn6W7meIXW6BbYjP3fwxCTgzCVTg0SE7TJ1isd7MYe63KO0wQKIoPf9jNjlzyK0rl6kHF4yxpCA7Rq8gihA9aC8NfC6LLsX0pUdJC7e9wSaDQfKcsmPPz1yECnYKI0VEBhz5AkxRAZLXAzXSL9EHa0n5k3F6YdAf+phIWf6Vn7r6kBo1JS0tJZZ5nT0CQ2rJtImqlSfIQBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5JT5stZ6/Ize5JTRsh/w1ACQoC9qwXd3SHu1WN6/Hs=;
 b=i9Kkj0AARGG6cJfgJDXaVbaPL9i7noQTVm58NbYNoCZEmhFiyXtj1Y55XWlePWHdaI0xIqPhIXwPYLMnQCIgQTGUhx9nDu4z0i0eBEUoDLn6Arg7u4oGZd/haqeYo2qWAA6Fa85VfMFlETpR+erD7/YRbO5ZSUydRjq0WCXo9NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 12:24:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 12:24:31 +0000
Message-ID: <5397d2cb-4eb1-461f-82f6-57a1ea5c8499@amd.com>
Date: Tue, 25 Aug 2026 14:24:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-buf: add a generic reclaim-priority hint
To: Ferran Duarri <ferran.duarri@me.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260820190838.221435-1-ferran.duarri@me.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260820190838.221435-1-ferran.duarri@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dff70a6-5fd7-46a6-d3f5-08df02a3d08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: q3ZiUIyiGmIkMyUyXouwua3joRYf9SbU9VUS4HizfEQ6jTGmCT4OwYswOm9gQJen/4+n4Gzfk5GKRGkgeAh8EI3tIgAUJz61WU2h0rmNSJlPxCB/x4Mw2xAsCXyPgRv3h1eJkq/Fhqjm+YoDf9fhsL0BjysUu3NUwbRTq/PHNCBf2WUdqxR8PzGDfw9IbQNeX/0IDUUqUaP84VTRyid14wALcLCHjAk9PAbQQPh0aXtwrMo4lqugDZ5aDzxGwcSuvlxpH0FHVgQJRRM+UE9LUhHY/T6vuFCKZLNFmsx6XlgBLYI29nVB8N7cD2bLlGe8tsX9WeZUDx7rDeElrQNVUefetIKZJWQE0/Xv1SP807dNLZeCkozU4S9XlXH6tVY/I/CdDxoAcOG+m4kMgYAhk8j8EWMMURlNl2PSBc3m2l23RMsll9bAONWHoOdb4c5Qa38l9habrTGk3jhD38i/gVxu8hNj0B7r512iHqudSYvrGffWENBT+17c5HQz5gtitmgL1Yyia0wQsKdDRrVZ+9suNGkdfA3akQ4RjNKdlDRFSXlnQuNwLqCRb/xqe9wp6Uej1rtpvX/E10rOQlrR76is23kwNFfHLMMBVJZO4PCWxVlQT4LwhoiO1IMGyklm4MMLKHx8vc1eEx4ZRb1O95jQmhIOPsejV/fXS4rAAcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzR2NThKb3ZCRkZXOTlHZ2ZHMUl1KzhCelE1TVE0bWJaaStTb0dzL1g0Sngz?=
 =?utf-8?B?N3h2cG9OLzd1L3lqMUxPTU1iUHBUdVp2aTg1dVF4czhHVVllM1JtRDZTcXND?=
 =?utf-8?B?dDd0THVSUjlzSmpPMnZkYmJmZTJxVzlEVEhtbUxlYlNLR05BSHZIUVlWVG52?=
 =?utf-8?B?ZmhTMHh6M0V3aHRPd0tOVUkvSDJ5NEQ5WHRPY2J0TEFGMFZJVU0xNmpwTzd4?=
 =?utf-8?B?c3kveVJMUGdTZEZWR2IxemJ6MjJhSFBIR0lIWlkzOWNCdmFWRDZFZnBWbkI1?=
 =?utf-8?B?TUd0YU94RFBOWTR2U1JNRmxqcFFCbWZXNGxGVjRxVE5IcVc1V2ZLTEtkZzM3?=
 =?utf-8?B?NTNWUTNRS2NsaEUyTm9xUXRNN2dWWktPZEFzbFZya2ZraTZGdGkrNXR1NmdX?=
 =?utf-8?B?ZTQzTTBQbWl6eWlsQkpWN2loakJxVy8wWjZGL1V5TTBqT2pNOStsVW9CMW9i?=
 =?utf-8?B?UFB6VG9pb2k1Wm5tVHlUS2RPUXpiV0pvMDIzM2laNDAvMjZKMnZMRlRtTjNj?=
 =?utf-8?B?QklQeTg4Mzh1MGkwRC9DVTJwS2NPOUc3dTliQ3BlNk9VbTFvMnc3SnVWMnVh?=
 =?utf-8?B?eXJZNTJLb3JtbUNYZzJkeG1tT3k0Y2VSYktHdG1Na3RZQVJlejd3WVNSeUhQ?=
 =?utf-8?B?c1N2OXEwK29SVzgzN1g3TGJaZzRCTmZOa1p4ZVdQOHlaYW5mTHBQbmdyRHRk?=
 =?utf-8?B?MHR0SE9OYTdqU3U1MUxtS0hJR3g1UFJQZENzSnRKK0F4eCtsME5OSEtBUDEv?=
 =?utf-8?B?RE1KU3FsQmpFaEhmSnBObTFNUlFFRU5OZTVRZmNEOWxFWXBrS3ZsK3dxeWY4?=
 =?utf-8?B?Y0o0Z3ZabGcrY3pMOG8zcEZNQWlCK0QrWkgrdnpwcjR1RWNYaGttSGtUTXpr?=
 =?utf-8?B?RGszYytmMVEwVmJETHYvRGNpQ3kwbjFIVEhYanZRa1NMZEVhcU9ocU4xZmth?=
 =?utf-8?B?bnRTaC9MMzdNc3c3ZjlqL1dJVWdMQTZGYkxRWlBzRWxQZ3AxR1Qwcmx1Qmtk?=
 =?utf-8?B?YWh5RUJXclJYbENJdWxMKzYxMWdmdnNMdW1WN3VhbldCdUpuUGZvc0IzQkUr?=
 =?utf-8?B?WWFiRmMrNFA5aWEzUFJRMWFISUJ0aTN3b1RoOFpqTUQ5WHZvejU5ZC94T2lB?=
 =?utf-8?B?c3A3Y1ZjNXBuL2ZhSzBFTm5NSzlSbmZwS3pRckI2NjZsQndrWEdyVFBXQmx6?=
 =?utf-8?B?TmJDV1FmR0VRN2tycHowSTFxWktHcGNjRnZkWDFGd3pUNW43Q2tienZDaWgx?=
 =?utf-8?B?dFJ4Zk1OQ0pjQjJFV3Q2VFU4TzJrc0pDV3BVWmdVbzl4TERMdXBwbGU3Tmw5?=
 =?utf-8?B?UFUzQjlGYUdXYjJKemR1LzJyTDRJWHV1NEdJelZOaDQzQkI3d1pQODErUTJY?=
 =?utf-8?B?NVVNdXI1elFhUDRFWXNpR3ljMTYzZmFzUnorRFFTdUFXMktXU2lLRzVzRVd2?=
 =?utf-8?B?bEFQSU1SVFVOWTc2Y3I2MDh4OGVxeEpLcng1NHFHeXpMTU91WjBibE9YY1NP?=
 =?utf-8?B?Q2pncUxRblVibUhQcHFrS2Yrc0N2Y2tZaUR5UkRRRlloMEtETDlDOWk1MzdE?=
 =?utf-8?B?WlJtUG1aMXlEbk9NMVlOS2FKSTVtZFkxZHhRa1JZcStXSGF1VzVKL1NvU0V6?=
 =?utf-8?B?Ni85S3NJS2FCYytNU3FpMVVTL21BOEFjeVdFNkNJSElUazQ5bFRMMC9jdVkr?=
 =?utf-8?B?OUhpaWdCRE0vMGhsaS9WMjllYkxMdzRYcFhBNE9XSWozWDAxeENxNFhYNWNK?=
 =?utf-8?B?RWk1cW8vcmZHeXRFazlRYkVjSzJMNHpMcHVDcWQ1UjB5K3BIMzZDa1JNN3NW?=
 =?utf-8?B?WUlueDAzcjFHNnBLeVZ6eEJOc3MwN3pDOE9KOWlWbkdoNDRqZXNpZlgySHo4?=
 =?utf-8?B?NjFCQ2d0TUE5RFErZGptNGRsc0JBUVIrWndNblVNY2pPR2xvZXpDdmpQd1Fn?=
 =?utf-8?B?M0Y1dXZMOTFPVHZhRmpCemFRakFYTHh2ekF2N21BVDlqVkpqNWpNa1QrbDZr?=
 =?utf-8?B?MkNrVzZwM3ZoK01FYktiVzJmN2xKLytyRnd1TkttWWF0RmQ3WWlqekRMMSta?=
 =?utf-8?B?dmpEc3hPUGJFWTl5OEVBMkpOYm91eHpLUXhXNGtyMVB4MDdvamxQVFh1RkhB?=
 =?utf-8?B?RjhvQ3M0aFZiWkhNbjBBaDdoUENJeUt0WTkrYW5KdHQ5bzY1aTFEcFB2ZVNU?=
 =?utf-8?B?Q3BCRjdUbm5FQkJtOVJYTHFJOGtkYjQydEVyVG02ZmF5TmFuamdKTC9qTjEz?=
 =?utf-8?B?Um9aM2JoZlI1WUxXQXVDZkpaV3JUR01qVUg0azhVaVhSWHpKK1NjVWl3dXlT?=
 =?utf-8?Q?YPbEAZ+XwytF1KJuzb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dff70a6-5fd7-46a6-d3f5-08df02a3d08a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:24:31.4186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75XuqOXs/GFMDtUhS/aEa6+4lQQtvsdUbxptlEsQm0ehdf7tAn7YMM0+dlGGmp+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

On 8/20/26 21:08, Ferran Duarri wrote:
> dma-buf has no generic mechanism for a buffer's exporter, importer, or
> a cooperating userspace agent to signal how eagerly a given buffer's
> backing memory should be given up relative to other buffers when the
> system is under memory pressure. Pages pinned via pin_user_pages()/
> FOLL_LONGTERM sit outside the normal reclaim path by design, so any
> subsystem that wants a "prefer to keep A over B under pressure" policy
> for its pinned dma-buf allocations currently has to invent its own
> private, driver-specific side channel to express it.

Well to start exporting pages pinned with FOLL_LONGTERM as DMA-buf is absolutely *STRICTLY* forbidden. I hope that you know this.

What can be done is for exporters to migrate a DMA-buf between local memory, system memory and swap, but even that usually doesn't happen depending on the normal reclaim mechanism.

It could be interesting to implement something like that for backing some Vulkan extension, but IIRC that is currently not even supported by anybody.

Anyway as long as you can demonstrate any of this with an in tree driver the whole approach is not something we would discuss in the first place.

Regards,
Christian.

> 
> This is a real, recurring pattern: GPU drivers juggling foreground and
> background clients want it, and it shows up concretely in large-model
> AI/ML inference stacks that tier working sets across VRAM/system-RAM/
> NVMe using their own dma-buf exporters -- e.g. an out-of-tree memory
> tiering driver we've been using has its own gaming_mode sysfs flag and
> a per-buffer "heat" score, moving its own DMA-BUF-backed allocations to
> its own private LRU tail under a private IOCTL, purely because there is
> nowhere generic to express "this buffer can go first."
> 
> Add one small, opt-in hint instead of another private channel:
> 
>   - struct dma_buf gains a `priority` field (atomic_t, plain hint, no
>     new locking), defaulting to DMA_BUF_PRIORITY_DEFAULT (128) and
>     ranging DMA_BUF_PRIORITY_MIN (0) to DMA_BUF_PRIORITY_MAX (255).
>     Lower values should be reclaimed EARLIER under memory pressure.
> 
>   - dma_buf_set_priority()/dma_buf_get_priority(), exported under the
>     DMA_BUF symbol namespace, so any dma-buf exporter (in-tree or an
>     out-of-tree module) can set/read it directly.
> 
>   - DMA_BUF_IOCTL_SET_PRIORITY / DMA_BUF_IOCTL_GET_PRIORITY so
>     userspace holding an fd can do the same, without needing a private
>     driver ioctl.
> 
>   - The current value is reported via fdinfo (`priority:`) for
>     debugging/accounting, next to the existing size/name/exp_name
>     fields.
> 
> This is deliberately a hint only: dma-buf core stores and reports the
> value, it implements no eviction policy of its own, and it changes no
> behavior for any existing exporter or importer that doesn't opt in.
> No existing dma_buf_ops callback is touched. Compile-tested: drivers/
> dma-buf/ (incl. the selftest module) and drivers/gpu/drm/drm_prime.o
> both build clean against this change.
> 
> Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
> ---
>  drivers/dma-buf/dma-buf.c    | 51 ++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h      | 26 ++++++++++++++++++
>  include/uapi/linux/dma-buf.h | 33 +++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..1b1d3ee77f47 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -432,6 +432,39 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
>         return 0;
>  }
> 
> +/**
> + * dma_buf_set_priority - Set the reclaim-priority hint on a dma_buf.
> + * @dmabuf:   [in] buffer to update.
> + * @priority: [in] new priority, clamped to
> + *                 [DMA_BUF_PRIORITY_MIN, DMA_BUF_PRIORITY_MAX].
> + *
> + * Lower values should be reclaimed EARLIER under memory pressure. This is
> + * a hint only , dma-buf core stores and reports it, it implements no
> + * eviction policy itself. Safe to call at any time, from any context that
> + * can call dma_buf_get()/hold a reference (no locking required beyond
> + * that reference).
> + */
> +void dma_buf_set_priority(struct dma_buf *dmabuf, unsigned int priority)
> +{
> +       if (priority > DMA_BUF_PRIORITY_MAX)
> +               priority = DMA_BUF_PRIORITY_MAX;
> +       atomic_set(&dmabuf->priority, priority);
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_set_priority, "DMA_BUF");
> +
> +/**
> + * dma_buf_get_priority - Read back the current reclaim-priority hint.
> + * @dmabuf: [in] buffer to query.
> + *
> + * Returns the value most recently set via dma_buf_set_priority() (or
> + * DMA_BUF_PRIORITY_DEFAULT if never set).
> + */
> +unsigned int dma_buf_get_priority(struct dma_buf *dmabuf)
> +{
> +       return atomic_read(&dmabuf->priority);
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_get_priority, "DMA_BUF");
> +
>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>  static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
>                                      void __user *user_data)
> @@ -542,6 +575,7 @@ static long dma_buf_ioctl(struct file *file,
>  {
>         struct dma_buf *dmabuf;
>         struct dma_buf_sync sync;
> +       struct dma_buf_priority prio;
>         enum dma_data_direction direction;
>         int ret;
> 
> @@ -580,6 +614,21 @@ static long dma_buf_ioctl(struct file *file,
>         case DMA_BUF_SET_NAME_B:
>                 return dma_buf_set_name(dmabuf, (const char __user *)arg);
> 
> +       case DMA_BUF_IOCTL_SET_PRIORITY:
> +               if (copy_from_user(&prio, (void __user *)arg, sizeof(prio)))
> +                       return -EFAULT;
> +               if (prio.pad || prio.priority > DMA_BUF_PRIORITY_MAX)
> +                       return -EINVAL;
> +               dma_buf_set_priority(dmabuf, prio.priority);
> +               return 0;
> +
> +       case DMA_BUF_IOCTL_GET_PRIORITY:
> +               memset(&prio, 0, sizeof(prio));
> +               prio.priority = dma_buf_get_priority(dmabuf);
> +               if (copy_to_user((void __user *)arg, &prio, sizeof(prio)))
> +                       return -EFAULT;
> +               return 0;
> +
>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>         case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
>                 return dma_buf_export_sync_file(dmabuf, (void __user *)arg);
> @@ -604,6 +653,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>         if (dmabuf->name)
>                 seq_printf(m, "name:\t%s\n", dmabuf->name);
>         spin_unlock(&dmabuf->name_lock);
> +       seq_printf(m, "priority:\t%u\n", dma_buf_get_priority(dmabuf));
>  }
> 
>  static const struct file_operations dma_buf_fops = {
> @@ -748,6 +798,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>         dmabuf->exp_name = exp_info->exp_name;
>         dmabuf->owner = exp_info->owner;
>         spin_lock_init(&dmabuf->name_lock);
> +       atomic_set(&dmabuf->priority, DMA_BUF_PRIORITY_DEFAULT);
>         init_waitqueue_head(&dmabuf->poll);
>         dmabuf->cb_in.poll = dmabuf->cb_out.poll = &dmabuf->poll;
>         dmabuf->cb_in.active = dmabuf->cb_out.active = 0;
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..b3d3f2858704 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -354,6 +354,29 @@ struct dma_buf {
>         /** @name_lock: Spinlock to protect name access for read access. */
>         spinlock_t name_lock;
> 
> +       /**
> +        * @priority:
> +        *
> +        * Reclaim-priority hint for this buffer's backing memory, in the
> +        * range DMA_BUF_PRIORITY_MIN..DMA_BUF_PRIORITY_MAX (see
> +        * include/uapi/linux/dma-buf.h). Lower values should be reclaimed
> +        * EARLIER under memory pressure. Defaults to
> +        * DMA_BUF_PRIORITY_DEFAULT.
> +        *
> +        * This is a hint only: dma-buf core implements no eviction policy
> +        * of its own, it merely stores and reports the value so exporters
> +        * (and cooperating shrinkers) have one shared, generic place to
> +        * look instead of each inventing a private side channel. Read with
> +        * dma_buf_get_priority(), set with dma_buf_set_priority() , also
> +        * reachable from userspace via DMA_BUF_IOCTL_SET_PRIORITY /
> +        * DMA_BUF_IOCTL_GET_PRIORITY.
> +        *
> +        * Plain atomic_t rather than a lock: this is a coarse, racy-by-
> +        * design hint consulted opportunistically, not a value anything
> +        * synchronizes correctness on.
> +        */
> +       atomic_t priority;
> +
>         /**
>          * @owner:
>          *
> @@ -566,6 +589,9 @@ void dma_buf_unpin(struct dma_buf_attachment *attach);
> 
>  struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
> 
> +void dma_buf_set_priority(struct dma_buf *dmabuf, unsigned int priority);
> +unsigned int dma_buf_get_priority(struct dma_buf *dmabuf);
> +
>  int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index e827c9d20c5d..4a1d26e0b0a0 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -168,6 +168,37 @@ struct dma_buf_import_sync_file {
>         __s32 fd;
>  };
> 
> +/**
> + * struct dma_buf_priority - Reclaim-priority hint for a dma-buf
> + *
> + * dma-buf has no generic mechanism for a buffer's exporter, importer, or
> + * a cooperating userspace agent to signal how eagerly this buffer's
> + * backing memory should be given up relative to other buffers when the
> + * system is under memory pressure. Every subsystem that wants this today
> + * (GPU drivers juggling foreground/background clients, memory-tiering
> + * allocators for large ML/AI working sets, ...) has to build its own
> + * private, driver-specific side channel to express it.
> + *
> + * DMA_BUF_IOCTL_SET_PRIORITY / DMA_BUF_IOCTL_GET_PRIORITY add one shared,
> + * generic hint that any dma-buf exporter MAY consult. This is a hint
> + * only: the dma-buf core stores and reports the value, it implements no
> + * eviction policy of its own and by itself changes no behavior for any
> + * existing exporter.
> + */
> +struct dma_buf_priority {
> +       /**
> +        * @priority: DMA_BUF_PRIORITY_MIN..DMA_BUF_PRIORITY_MAX. Lower
> +        * values should be reclaimed EARLIER under memory pressure.
> +        */
> +       __u32 priority;
> +       /** @pad: must be zero, reserved for future use. */
> +       __u32 pad;
> +};
> +
> +#define DMA_BUF_PRIORITY_MIN           0
> +#define DMA_BUF_PRIORITY_DEFAULT       128
> +#define DMA_BUF_PRIORITY_MAX           255
> +
>  #define DMA_BUF_BASE           'b'
>  #define DMA_BUF_IOCTL_SYNC     _IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
> 
> @@ -179,5 +210,7 @@ struct dma_buf_import_sync_file {
>  #define DMA_BUF_SET_NAME_B     _IOW(DMA_BUF_BASE, 1, __u64)
>  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE _IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
>  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE _IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
> +#define DMA_BUF_IOCTL_SET_PRIORITY     _IOW(DMA_BUF_BASE, 4, struct dma_buf_priority)
> +#define DMA_BUF_IOCTL_GET_PRIORITY     _IOR(DMA_BUF_BASE, 5, struct dma_buf_priority)
> 
>  #endif
> --
> 2.53.0
> 

