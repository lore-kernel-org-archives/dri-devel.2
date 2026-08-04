Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0C2C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 22:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DBB10E107;
	Tue,  4 Aug 2026 22:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VEtwlVsu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B23B10E107;
 Tue,  4 Aug 2026 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785881165; x=1817417165;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=CvakXnTg6XrIkfEge3aFCArAlThiOPsp+YWVuGaPb70=;
 b=VEtwlVsuktLhskUrY/UzYNTYTq/E9rM7mdDQZ9lQzk3YGWKehej3YHuD
 vZPhZWgCkwOxuEZTtoxm9TKhN28OXGUkAwEFj3h+YpgV8eiEzN/K6wR9W
 0jM8Aga9pgXZSr46Pw1ek6q4ZLtaAsqzu0mEZsAt522Ja0vNcr94JqVHi
 Zth0DX0jWl135rXPWL7YWbj5vVI8ung4Ye4s0uOIy1PNp7V/oj8Vka2UI
 wkaT7YtGt8cbEwnPoJ9xGOW1ih6zWO8em7mOhoX/ZliAFptnYr/cQ7Kqj
 +ugM852dYkq1j7symthUJCCoy3VxJpLuxRPiBnnB3Kb3NMe/dQzfszbqJ Q==;
X-CSE-ConnectionGUID: aYnJT7z0TcafxXg5N7GErw==
X-CSE-MsgGUID: z6YqzQKXQ5iYYAk4fIshYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97093381"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="97093381"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 15:06:03 -0700
X-CSE-ConnectionGUID: icviqidEQG6SZf4Is5JACw==
X-CSE-MsgGUID: +FgTQxZlTjqgLxVTcWbYeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="265877635"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 15:06:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 15:06:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 15:06:02 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 15:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1iHto49rCtyrnqrjeAlQFwjonW4p1WCrKqyIKsRVEHHwatgtfxqTlafRoB9P0ktiZaB4207rGzbk2jqDG8zXq7FqYVTkzgxc6Tyl7jGZMKI8d+yI58VmtF6j5ok+TimtvOJ4ejcyqmf0V9zeL2ikqIuGGlB1fKtvnU42onJYpE1A+VZFUzBkCsHbDZYeEv3vj2VhWMzgR26GZQEFymRh6b89whmRFhyhxEfxNizNQJIvacju174i5XERVQJmipjahhLmHJZApdebZ+ytXhM00EH9+Dpt1v74WSUlNbSZXg8Ju7Hb49GtoangY8JnJaTMuP/5svu9LLI4HLoKs9z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/YHr22Z8QRt5UWt7vDis2M91NUTjYfNoWe6Z5OBhVE=;
 b=KToWmDu1uRS7rCRPcbvFkD9tmk+dIiB/MJQ23H+TvG4uPGTvCZjUTp6eAoTK6NxM8u3d3MtHCEijw0PdBROp2CZKpQvINnx6qW7kBDcona2xiEbUKiHMbEaf5JOcEwUspTjXyMvGtAKS1EtS1/PSFwg8HO+H6Mf3Fdv40Cd9pOIHHibgwF0hHtFMJuFWtsCkIaRZXhYOcTIGobpSfV28gbgVBrGTXYysX08vmHSU4i7pFELxHLZH/Wo63ZN2JX6xX8Ej6icJ1jGMChefPrn1FzlwrWMpEWHULWvnxsYUEHs03N5KaXvX5CP45rz678Ona1moxwyRK/krNf5DN8IfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 22:05:57 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 22:05:57 +0000
Date: Tue, 4 Aug 2026 15:05:54 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
Message-ID: <anJiQps/Ht5yLhuK@gsse-cloud1.jf.intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <20260804021441.3054424-2-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804021441.3054424-2-talesam@gmail.com>
X-ClientProxiedBy: MW4PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:303:b5::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a263e0-1a2f-47da-935f-08def2748fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 9NpHu1ANRzjV25DlnGEhFqNoFX6NAV4MxRvR8K6sq88KwI49zpmjrTQMs1JJrMmjYFBE3HOBPbfRj5pPYXXhJ+Pkmcq2QXyPr3NUdLGljTgX8LlukBJHJFaZfEgj9SLYqm1KhVaiCtTlGsjCls007k1g7GoH3OHV7EEqAmx/F44R+Cp5CXHAgXJEEpVWnvyvbLWNrC2QB4Cp74ap+jdJ1NpV+Seh97yjkNj0PcPRJkKBXl56lPfW1QaRSRzhBRYK2+paqvxpkFLQ24AetpQaJFqD0Q5hzJatQOwQr4Bqi9N7kqnY0BxdOaGD2cQRxQROfCjkvbrVtcEpK0k4EyR9Ix5h+FStM596dD4Smkmm05Blbykk4Ja0/zqAsKlj4YBKwg6LfulpLspyMPFl88jDNVKGswTE3aMpJLCACVnLrNLWQKtDmI77nrr3/dVUta2RIfSCngfdKJ0K27GzycR2s11Krjxb2saju1lQLFIru3D8JcovWs35lbERMoCvEpOhsm/DFPraFZmXpQI02eojAhbMr7Q8bdPGYo5I2n7qROhu5GP+8vddpbK3Nsq9Qh/LVESVC03lDG+6MuE3Wci4aDATviljijP8lDRkUzlenDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Dvw0EWbc23TAf2wvfpcCnn4XMN+eQzDLFlB+PSYhTHBNuX5cutnFpX1rLR?=
 =?iso-8859-1?Q?tMuXt+2SI3Ss2kVGa72SzzHmwIpWE5Pr+9mtT4vY4jPewDZ1Tu+bqkAyqs?=
 =?iso-8859-1?Q?9PJpSaRX3HxCxH4qFbrWw+2nLeKLBqajUZxYep+3zpk6WnEOHnSo852mDx?=
 =?iso-8859-1?Q?Pqq9Fouf1vfo58JhYfJzn1RDqHTIyRXU68oCz6OU4DOOOxXGnEzFKdxacz?=
 =?iso-8859-1?Q?dTKefHe30/4cRZ70cBGK5hPYoJZMQV22B4xmSumpfTLo7N49bHSd00OY6v?=
 =?iso-8859-1?Q?E+lucjcln0/C2CEXNBHbpfnZS2blPwAYS3gSv7YudHdsxIQNDIumhlTvSD?=
 =?iso-8859-1?Q?EEYB5wtJx028WDyNudAFLlQimAqVIP3Sj01ZQ5xTgdEI5xWyg6WZUIwj3u?=
 =?iso-8859-1?Q?4f2mz4LhmRp5XB0WSCOZNItnEztzDC8hmWpbsb+Tu+SczEhD1iWd6CzUQj?=
 =?iso-8859-1?Q?isnh5RuRW+EXse7+nYMsL/KjGmK2PtmXTuICzIuvXxUww7+lCNLpvDlisn?=
 =?iso-8859-1?Q?iTFm9tVUx78pIa7a2yKeszJDKnLwb6FAsyADjFMvsuG2BvuhY6RI5Z/HUd?=
 =?iso-8859-1?Q?i5f76/zuchQY+CNdb0QbA+cfvu2/rwOzkCO/WR/G7qrhZeiA46MKjUgHnv?=
 =?iso-8859-1?Q?tOh2FFASGrp/JN4ASGdcxQrylCdb6Vcx8f3uh2RfTR7Bo1xfjzC9pYu+dl?=
 =?iso-8859-1?Q?GbSlJsM79zgPE1F09YcOPwJ52qUOYryNgF4H/ueIFYT+ntZY+krFSuMKjJ?=
 =?iso-8859-1?Q?ZcLH0Nn4TrkyMnULuV+WxtucbOZYB3LZ+GBDqqYGnng2srKPoDjJ0jsQRL?=
 =?iso-8859-1?Q?vRE7zAKL5lAJaG/x1R+ynPJoP+OhyiPNHrtBBPI4bMcpVlbnQgqH1r18SL?=
 =?iso-8859-1?Q?elawLwmQ5BaKozY8KemFJWYMzaGwp9q27tuGu/27CdLUaMDR/Ac57VzzNt?=
 =?iso-8859-1?Q?UFjpvD877RKi73eD701ae7gl3VyY6xpbt7az0r0J9hhNwdwSIHs/46Y+4w?=
 =?iso-8859-1?Q?Ql9YxcK+bxtSiwZwfH4HOKrunOmWK660V5hcuNDXPkBZIsrdCRSzn4QsC2?=
 =?iso-8859-1?Q?YJazrHkdBNgG4LJ9gQGpaEZ00ruCn3gnRYt4n+ZQmqC5hjolLxakc8YXdI?=
 =?iso-8859-1?Q?49RPQRaMlDi87TfJq1zF2P5zt+wXfCYsT/RRoclzCy2leeZnjsIkN1XKR6?=
 =?iso-8859-1?Q?IxtIyv/PMgbn8JYeDb2G3Lt8/dkWx1mYeknGT7MAsU3hA2+swDYCOuh3wk?=
 =?iso-8859-1?Q?0gb1S3g2Q2c7mPRvrmgPZekaJCoeySGT6eWYVRzyalc5PEEjoq5OUEZQHc?=
 =?iso-8859-1?Q?63CiTepE7/z4vvccyoPNLp5fAICBzF3nNbR1bmL62/YAtXmOxuWHSXD7Nj?=
 =?iso-8859-1?Q?9GYL2DmvFPU7Pa1ik3FIn8ijbuSvBpuvv74r8+K5EU3wAHw2qv15NJg3CP?=
 =?iso-8859-1?Q?tlx4H6UEvRh4GYWuiq1nk+FZd1IWYFJ8eukbEjhcZEpSgViSHkfbdsuZ3E?=
 =?iso-8859-1?Q?eFrSoGH38hUdF4XCTMHHiYd+N8500waTSj8hYwQW8ZcdEvBu/KJaznWuys?=
 =?iso-8859-1?Q?mF0L/SS6zOpe7d/3zk5onNSe3X2rhXvD3kUNN6pjJQwkcAeFMD2wC9JX6b?=
 =?iso-8859-1?Q?Z2lB8/8c/MbbKmWkX2yh/Ix5xD2NxiSnJKdGljbVXOPKMpLw/di4VDrWQR?=
 =?iso-8859-1?Q?yej7YeL8n4ZGS9rPy/Xb/3yKfWGbsaY6rQDLofy+x9ir5lue78DD79ey7f?=
 =?iso-8859-1?Q?bBChRYSsTXcTxiHgpB7q1c6XeSKWKkPAX9BxnImtIm+G4S5a8iqHUa7Oaw?=
 =?iso-8859-1?Q?QLaqsV7GpezdKmf1cjATB01yE8BoTbA=3D?=
X-Exchange-RoutingPolicyChecked: czD0TfIRIVYTuIsoab+YU0crAppMdO/Ay61aPMJtels5yRkvEsfeIovExXKuR3KEOOUEfqornMLGuMJqzDLPeajnho9EXN1Cr2AzHh8G0S9+HHjOJkvoDrqmgOJSUZRpVRN4kCVXHQyW/e4AkGxtv3SFO1/6XPawoP02Y34TtRexmxYJmH7baaqOJj0OcoyecvElsHTP9zFoNs7GbGk/SY4sEPbagBQwwHRPMKjMNIRdIABlBBCExHjl7M566uZm7mEWwmipNDNwetVxTxFUCfQDSZVwg+qtS9DrGytjUtp7zjRx+NH81QGgDCx7rC/X/TquqR2xrfbapNJLv7lTeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a263e0-1a2f-47da-935f-08def2748fac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:05:57.5408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFt1AXbWvXajYp0NHDjdpsxDnaHjpqIT58rT5MlryLasvLlz2w9SrC4jpN5nuIarMZI4c077zyTfETOF+B21tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
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

On Mon, Aug 03, 2026 at 11:14:39PM -0300, Tales A. Mendonça wrote:
> TLB invalidation timeouts currently leave no record of the firmware
> state behind: there is no exec queue or job to blame, so nothing calls
> xe_devcoredump() and the GuC log content at the time of the hang is
> lost.
> 
> Add xe_devcoredump_gt(), a variant of xe_devcoredump() for hangs that
> are not tied to an exec queue or job. It captures the GuC log and CT
> state of the affected GT, reusing the existing snapshot machinery and
> the "only first snapshot" policy, and hook it up to the TLB invalidation
> timeout path.
> 
> This was instrumental in diagnosing GuC TLB invalidation ack stalls on
> ARL (see Link), where the invalidation request is consumed from the H2G
> CTB immediately but the ack G2H only arrives ~2.3s later, after the
> timeout has already fired.
> 

Thanks for doing this. A couple suggestions.

> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_devcoredump.c | 68 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_devcoredump.h |  6 +++
>  drivers/gpu/drm/xe/xe_tlb_inval.c   | 20 +++++++++
>  3 files changed, 94 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 5f2b90b18f9..0ccaed176a4 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -403,6 +403,74 @@ void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const cha
>  	mutex_unlock(&coredump->lock);
>  }
>  
> +static void devcoredump_snapshot_gt(struct xe_devcoredump *coredump,
> +				    struct xe_gt *gt)
> +{
> +	struct xe_devcoredump_snapshot *ss = &coredump->snapshot;
> +	struct xe_guc *guc = &gt->uc.guc;
> +	bool cookie;
> +
> +	ss->snapshot_time = ktime_get_real();
> +	ss->boot_time = ktime_get_boottime();
> +
> +	strscpy(ss->process_name, "no process");
> +
> +	ss->gt = gt;
> +	INIT_WORK(&ss->work, xe_devcoredump_deferred_snap_work);
> +
> +	/* keep going if fw fails as we still want to save the SW data */
> +	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
> +
> +	cookie = dma_fence_begin_signalling();
> +
> +	ss->guc.log = xe_guc_log_snapshot_capture(&guc->log, true);
> +	ss->guc.ct = xe_guc_ct_snapshot_capture(&guc->ct);
> +
> +	queue_work(system_dfl_wq, &ss->work);
> +
> +	dma_fence_end_signalling(cookie);
> +}
> +
> +/**
> + * xe_devcoredump_gt - Take GT-level snapshots and initialize coredump device.
> + * @gt: The GT where the issue was detected.
> + * @fmt: Printf format + args to describe the reason for the core dump
> + *
> + * Variant of xe_devcoredump() for hangs that are not tied to an exec queue
> + * or job, e.g. TLB invalidation timeouts. Captures the GuC log and CT state
> + * of @gt so the firmware side of the hang can be inspected. Skipped if a
> + * coredump is already captured, same as xe_devcoredump().
> + */
> +__printf(2, 3)
> +void xe_devcoredump_gt(struct xe_gt *gt, const char *fmt, ...)

I'd unify these functions with the existing
xe_devcoredump/devcoredump_snapshot by adding a GT argument to both and
teaching those functions that 'q' can be NULL. Then replace
s/xe_devcoredump/__xe_devcoredump/ and add wrapper macros
xe_devcoredump and xe_devcoredump_gt in the header file.

More below.

> +{
> +	struct xe_device *xe = gt_to_xe(gt);
> +	struct xe_devcoredump *coredump = &xe->devcoredump;
> +	va_list varg;
> +
> +	mutex_lock(&coredump->lock);
> +
> +	if (coredump->captured) {
> +		drm_dbg(&xe->drm, "Multiple hangs are occurring, but only the first snapshot was taken\n");
> +		mutex_unlock(&coredump->lock);
> +		return;
> +	}
> +
> +	coredump->captured = true;
> +
> +	va_start(varg, fmt);
> +	coredump->snapshot.reason = kvasprintf(GFP_ATOMIC, fmt, varg);
> +	va_end(varg);
> +
> +	devcoredump_snapshot_gt(coredump, gt);
> +
> +	drm_info(&xe->drm, "Xe device coredump has been created\n");
> +	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
> +		 xe->drm.primary->index);
> +
> +	mutex_unlock(&coredump->lock);
> +}
> +
>  static void xe_driver_devcoredump_fini(void *arg)
>  {
>  	struct drm_device *drm = arg;
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
> index 5391a80a4d1..f071bd11f24 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
> @@ -11,10 +11,12 @@
>  struct drm_printer;
>  struct xe_device;
>  struct xe_exec_queue;
> +struct xe_gt;
>  struct xe_sched_job;
>  
>  #ifdef CONFIG_DEV_COREDUMP
>  void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const char *fmt, ...);
> +void xe_devcoredump_gt(struct xe_gt *gt, const char *fmt, ...);

This what I'm suggesting for a header...

void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
                     struct xe_sched_job *job, const char *fmt, ...);
#define xe_devcoredump(_q, _job, _fmt, ...) \
       __xe_devcoredump((_q)->gt, _q, _job, _fmt, ##__VA_ARGS__)
#define xe_devcoredump_gt(_gt, _fmt, ...) \
       __xe_devcoredump(_gt, NULL, NULL, _fmt, ##__VA_ARGS__)

I think we need wrapper macros rather than inline wrappers because of
how .../##__VA_ARGS__ work.

Matt

>  int xe_devcoredump_init(struct xe_device *xe);
>  #else
>  static inline void xe_devcoredump(struct xe_exec_queue *q,
> @@ -23,6 +25,10 @@ static inline void xe_devcoredump(struct xe_exec_queue *q,
>  {
>  }
>  
> +static inline void xe_devcoredump_gt(struct xe_gt *gt, const char *fmt, ...)
> +{
> +}
> +
>  static inline int xe_devcoredump_init(struct xe_device *xe)
>  {
>  	return 0;
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> index bbd21d39306..833fb92cd3e 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> @@ -5,6 +5,7 @@
>  
>  #include <drm/drm_managed.h>
>  
> +#include "xe_devcoredump.h"
>  #include "xe_device_types.h"
>  #include "xe_force_wake.h"
>  #include "xe_gt_stats.h"
> @@ -29,6 +30,12 @@
>  
>  #define FENCE_STACK_BIT		DMA_FENCE_FLAG_USER_BITS
>  
> +/* The frontend is only ever embedded in a GT */
> +static struct xe_gt *tlb_inval_to_gt(struct xe_tlb_inval *tlb_inval)
> +{
> +	return container_of(tlb_inval, struct xe_gt, tlb_inval);
> +}
> +
>  static void xe_tlb_inval_fence_fini(struct xe_tlb_inval_fence *fence)
>  {
>  	if (WARN_ON_ONCE(!fence->tlb_inval))
> @@ -73,6 +80,7 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
>  	struct xe_device *xe = tlb_inval->xe;
>  	struct xe_tlb_inval_fence *fence, *next;
>  	long timeout_delay = tlb_inval->ops->timeout_delay(tlb_inval);
> +	int timedout_seqno = 0;
>  
>  	tlb_inval->ops->flush(tlb_inval);
>  
> @@ -90,6 +98,8 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
>  			"TLB invalidation fence timeout, seqno=%d recv=%d",
>  			fence->seqno, tlb_inval->seqno_recv);
>  
> +		timedout_seqno = fence->seqno;
> +
>  		fence->base.error = -ETIME;
>  		xe_tlb_inval_fence_signal(fence);
>  	}
> @@ -97,6 +107,16 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
>  		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
>  				   timeout_delay);
>  	spin_unlock_irq(&tlb_inval->pending_lock);
> +
> +	/*
> +	 * Capture the GuC log and CT state so the firmware side of the hang
> +	 * can be inspected; there is no queue or job to blame here. Must be
> +	 * outside pending_lock as the capture takes sleeping locks.
> +	 */
> +	if (timedout_seqno)
> +		xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> +				  "TLB invalidation fence timeout, seqno=%d recv=%d",
> +				  timedout_seqno, tlb_inval->seqno_recv);
>  }
>  
>  /**
> -- 
> 2.55.0
> 
