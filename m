Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662FBC982FD
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 02:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323DC10E4E0;
	Tue, 22 Sep 2026 02:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nkJOYUnv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED11D10E19E;
 Tue, 22 Sep 2026 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790043595; x=1821579595;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KrFe8TBivN9Yg/GApBmiHQk6Md964cofl7QhPYSyW5M=;
 b=nkJOYUnvSbEvw5ucuMVQTo1BAJ8WRUM5KKUVdHJ89Lh1xMS4Dmy96s1E
 uaCEkGUULQxjlzWlxOs/Uh2BkL1kDXEzmPtpsbkwQgelEgVNuEXuHGdx+
 LejkQk96hZ+l3ESnsVUAwnvI4nn+HhFy2MuQ/gn9Pa6ApP3ejvdVneVsq
 GQcLY0cOjTiEfVVGZuGPGSU8r5uP+WMCiE/AwNf9fFJLyzfXV51P1fPdt
 KWPrZ6MjszVn1F3khWrlS0LI7Yw9JKb0ekOnkaGI1Zd7oq8kDrxqMR17q
 oVgsJ3/qI1wXEwYGV/uqZccPNfUTymXPwkKEdzEt3oEzsvL5EHc/RuIKX g==;
X-CSE-ConnectionGUID: 5XLowc6+TnimNSZCxxlUeg==
X-CSE-MsgGUID: x0tfMu8KR9yQ3OQ3do4BAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101270530"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="101270530"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 19:19:54 -0700
X-CSE-ConnectionGUID: Ei9gvZ9bQUa1Xe7oA4xLbQ==
X-CSE-MsgGUID: 0s9nJFzwSry6nos4y5YgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="277707416"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 19:19:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 19:19:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 19:19:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 19:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt+2Nf7XTC9hOKoKPyC/dzRP8HLuljWRliZROjOejYbuk+AVBrVTbNK1sK1wD+UMV2AbC7RbKfL3jsAJOvpUBxVvMf5Zbqsq3gHapx8HFVIaRW0yeEVfHRA73kwOpslKPWT3sMt6ZPTTVemaa1J9AsNGB6mDpoJra1uRtWyNDd/su9+RTk4AygBXD/sevIN4QxLj7T7RtP1x7gFRpGcUqFBWqZvCLsxgIGutlMBWvxW8NVp9ZXkXNzgzO2lnbFHQ3L/h9gtzrmIKQmQI8PYfz1DL00vjjPcGYH7lWumkt2AliE25NwDLZ6fBTud3nOYGG1BQf0ic54g8qW4Sx/U/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWZuVxq2UWtwJLWofDtcZzayV2wKxrqtwYJwVqgZaqY=;
 b=pshwyLxAtWJAlZRFjR+SZfK5JD2HF3lJtbzzNuziNIWtvnEGobDshpzoS6I72dDp3vA6yDrs5PLM4/e02C7Din28Dvj46QYYGSzHI9wuj6iLX4J44HClSEx8biA6DU4Mxc1+e14NY/pi4blkn7RFj7PH+lxyR7n+qpumZVVk9EhOwgZdnX+pu15+DqVtbX3MM40XBT5ouS+ljf0opCd0g5zo71r7WKrbWepqcUbgXtOMggY31c90WtuYw/CuugCWpSi8fIRs9bTc4dxiQrXiIR9KP7n8h7wjYylhqM051N4/tAKRuHcRSpf88kdt8JgFjIGmARAOeXDeiiKyByRzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:19:48 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 02:19:47 +0000
Date: Mon, 21 Sep 2026 19:19:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <sashiko-reviews@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v5 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
Message-ID: <arHlwf7vmajXgR3l@gsse-cloud1.jf.intel.com>
References: <20260921182121.308217-1-talesam@gmail.com>
 <20260921182121.308217-2-talesam@gmail.com>
 <20260921183324.0DDD11F000FF@smtp.kernel.org>
 <CAHBRX4GqGrA-JhPct0K1GO+fO-uwPm+jJDiQcAQ9FBvBENcOjw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4GqGrA-JhPct0K1GO+fO-uwPm+jJDiQcAQ9FBvBENcOjw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: a00d808a-af3a-48a8-937b-08df184ff932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: zrlkOwpPRmmlZ2lOdTCv8wcP6jmdm0I5Jl1inalUHCuwMpjTA/VjDIm3BZMGRAM4wiLRExw0cc2lxho+Ok1Mo+OiCq2yXGj0ddZPgwZ/hyqhk3BjuDDyFVkekYi88fdMn60gfff7Zb/ivNohOdAI/pfAkaO/GjGVrRZwkxrXp1gV7xuY7IN76FbsPUUcBljR4QVFKpNdnBn0jB2KIISJhhiMOjQoQiBhFioI9SmkE+564V/T5swUxwqV20yCo7UEQIqoSQNBr0tqWdKE573+Dl28qHJru7ycEFA01p9zbUodZx3gRsrHiAmFNCU8bqzD8rboTrtEOdU6Xr5t2l6Pg74Y4gNjnwcKA1ZNZI8rcIEzoqgfzQflrrerPpr5PvHOHWBMQmG3SG4MkN1dv61KEfKn5gdyMys42mp2fPnPPAA8gs40Is1s7X3uPH608/8FaRVrL2Ug8wN32zoEnNLmsMBlBFP9cfZSs4NVKHf3wP/ZV04MsS6a48lhYXmEP+UtvMqZt61XZXX7oOpIFe5bNCUnsd8soYVYBfIqB8baFIGTPIgYq/YTzbTc5roDl+IfaKMcoFjSUMBcjjfgyEtPPT859Eq7Mx81ZUBBcmo6lVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SamDnCiEcyBcAyltRYGxhBaBAeUFreL0A7s9KtLzg1FtrY3R6gXgVwlyFL?=
 =?iso-8859-1?Q?o+9JRGtHEdJoWQWJ+WeyPAuFhc91H3M7HE86NgeroxzjEz6lAJSKipecMl?=
 =?iso-8859-1?Q?PPMgoYrKsfj6zqhA+8OZrQgdbd1plHkPu9YNNVm7tGCyoBDXSkEtFSVJ4V?=
 =?iso-8859-1?Q?nMU3xrccAFEnjvZvahT6Qq4EozulkxfwMxMkAjOFw829ZW1AldL7fUEBP5?=
 =?iso-8859-1?Q?vDN2f6QgtlTZM+tiVrajhLv0KW1ShW0gl3bWn964FjpbLsWW2p1uWHvxR/?=
 =?iso-8859-1?Q?alzTtdFW+uNTtZasjedPwuXnZlzNbiz3/YuT3/1P+sVBe68XuRIeC1mVGu?=
 =?iso-8859-1?Q?8BQw/B09g3qm71KRIna9r9gdID9PMQeqGXnlXI2JwNizLr+GWEMMIUpNBD?=
 =?iso-8859-1?Q?93YGqhyHZGOU4Mn01G48Z5S0iJ9gh39c/WdS5AHKxtPCK4HBS5yBChAL29?=
 =?iso-8859-1?Q?UPLytoxucxA92NUYUQWaykIKy2XFmv7CYDaQ4KIxbXTNEnBSZjrXdjrU9w?=
 =?iso-8859-1?Q?52t8V+Pg1xfWG1WnFd7G1RNYYMJdtkXzHnOgefZOL0/nhTCjndLVkE6OkE?=
 =?iso-8859-1?Q?AxL9nvOKC8DvJMyP7fw0hdtLLJKI0nfRMWGWm11hSvs32b25DAXvFYygSg?=
 =?iso-8859-1?Q?khmfZwEfkYf1RDgWU9OnCnI/nEn1tuvCQjaHH/swAu2e27FtBuItGhmKx7?=
 =?iso-8859-1?Q?k+NWly0JUY0fAAApHDvWAHJe8uH3WJNFF1uh8T3FOp+G9ssxa6L0aHnJRp?=
 =?iso-8859-1?Q?HWf7RNnUqRTGO0ddyCPLTbY1fpCEoXQ72lu3Hwn8O5IQLpA1+y995dHfiX?=
 =?iso-8859-1?Q?KF2j1Sv0/G182jh8/Z+XteI2pa/Hj2Sx6XoGBcsUPFbb3/PGRRrHWGzMsa?=
 =?iso-8859-1?Q?JNrBUAKbEM97CpXO6Bd2JmDtczjI6b119y+2t0U+1jtizAUl00QeTjLNBc?=
 =?iso-8859-1?Q?xLfTSk7z6sAvsUiIGdMY08iaMrmQ83v+W2NPz/5+EKDlU8KorH4imBmJSr?=
 =?iso-8859-1?Q?wnuzqmu4PRMW7vGulSEabe0NjajEwfoFdL94hJPK3erwYzY8QDW4aufjCC?=
 =?iso-8859-1?Q?GHxT/g1BELS0fyH4R2TTMKl0XLAsqexeqHYTrm6opPhKfUe24OFo6JOwy5?=
 =?iso-8859-1?Q?ipstmofBmNdBa2liLeMBtycHgMocx7vz/T2LfJaQsDwBdqFu2pYXIbBSUM?=
 =?iso-8859-1?Q?LV8fdZ5zAgfd97CrcFsGC4fpRFFXDhGASZ6E1qv4m+rNi4h5VsLYlWrj39?=
 =?iso-8859-1?Q?iFJqdVZTjWPh+FOEyP8g765aJxi4OJwqBnzSA8ixBpUVMC2q4Ac6UmLU0f?=
 =?iso-8859-1?Q?URMvqb8Y9LWRWeeVK5vUzN36I6U1EArOaAH/+2QmM28oLM7IucSVsClRBo?=
 =?iso-8859-1?Q?dA9+gck8w9uxXUMwN8veFPMhLA0InzAcFLLNyE/G98V5ZoIKXkQGqypKoS?=
 =?iso-8859-1?Q?5CKU0S4MkjGqBlF5QKhdQFbdOnZPjaBTY0Y1y5zdrjVxGMOKZyPCaKALTL?=
 =?iso-8859-1?Q?W7Z4M+cWf/7HSKoBLZHLVUsW9Ss8hnN+ruW6ZS/gVH7rhhm3L5HxQHkZB2?=
 =?iso-8859-1?Q?yXTTvK7CPPBQ5SaV5+8kO4pyqrfrQyuafrXnJSQHmO6wh5WAfFh1FzxGwf?=
 =?iso-8859-1?Q?DSQcZWqA/hYFY8a9vHJON9U/tGEg6f7v/Hx71FFanuaXe9Fl8/cvz30q5c?=
 =?iso-8859-1?Q?se+USv17HFyLrtI0GWLMQryWXdrbUUYq20KRDnVvR2tw02ApYuyy4tSQRs?=
 =?iso-8859-1?Q?ohbH2+iNo7A1KRqXRG2+BJOuK3OZQ7W7easNsgKJTgGw+eAZeWNRiiiHrL?=
 =?iso-8859-1?Q?nOgMFWt0oQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: e1MzmaGYg0ldm1UlKW0KOavpaK4FYDQRH15K2dSzi650yNHBfRCOF7nn5rIiXdrnMMZqsM08oyLrICmlM73DrMXflxLQcYMxwzfH88cAHZzBBA0l5fvHyUjZt2yidJkJaazXE+ysGAs5Pj5cY0Oqj6GQNsAkU2YFliNQIDvJNWRL4UzByhMasRZzYhvRPbXUEuDFksCHlXMNebHfVEcXYoCU1/Wd8dOyZIOKUljGhwCIelzafY9RiqHJO5clmTu75wi4Lci2lKgUpGeqgnYcau/RG7/tz3bQdEnFMeMG2ufSuJwnuLGkwBXzQD+rjGA23cc0xTLrBS3BFChN9n0P6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a00d808a-af3a-48a8-937b-08df184ff932
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:19:47.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDpdguwTJNSiQ8NrqctVV0Cb4CzGGTKk+8r5kwBrfOrrPGF5cOTHKbFS6MF0DDM+KG5FFpRA8do0UeSB+9OIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
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

On Mon, Sep 21, 2026 at 05:28:22PM -0300, Tales A. Mendonça wrote:
> On Mon, Sep 21, 2026 at 03:33:00PM -0300, sashiko-bot@kernel.org wrote:
> > [High] drm/xe: MMIO access without PM reference in devcoredump on TLB timeout
> 
> Correct on both counts, and it is my patch that introduces it.
> 
> Tracing it: every pending invalidation fence holds a runtime PM
> reference, taken by xe_pm_runtime_get_noresume() in
> xe_tlb_inval_fence_init(). xe_tlb_inval_fence_signal() calls
> xe_tlb_inval_fence_fini(), which drops it. The timeout loop signals all
> the expired fences and only then, after dropping pending_lock, calls
> xe_devcoredump_gt(). devcoredump_snapshot() acquires forcewake without
> taking a PM reference of its own - it has always relied on the caller
> holding one, which the existing job-timeout caller does. The new
> GT-level caller may have just released the last one, so the device can
> begin autosuspending before the snapshot touches the hardware.
> 
> Fixed for v6 by holding a reference across the capture, taken while the
> pending fences still guarantee the device is awake:
> 
>       if (!timedout_seqno) {
>               /*
>                * Hold a PM reference across the capture below. Every
>                * pending fence holds one, so the device is awake
>                * here, but signalling them may drop the last
>                * reference and let it autosuspend before the
>                * snapshot touches the hardware.
>                */
>               xe_pm_runtime_get_noresume(xe);
>       }
> 
> and released after xe_devcoredump_gt() returns.
> 
> Taking it inside pending_lock is safe: xe_pm_runtime_get_noresume() goes
> through pm_runtime_get_if_in_use(), and its "Missing outer runtime PM
> protection" warning cannot fire here, because the fence reference is
> still held at that point.
> 

This is correct.

Matt

> Tales
> 
> Em seg., 21 de set. de 2026 às 15:33, <sashiko-bot@kernel.org> escreveu:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] drm/xe: MMIO access without PM reference in devcoredump on TLB timeout
> > --
> >
> > commit a463de937c804fe9be7ed86bfbfa297e4f35c466
> > Author: Tales A. Mendonça <talesam@gmail.com>
> >
> > drm/xe: Capture devcoredump on TLB invalidation timeout
> >
> > This commit adds xe_devcoredump_gt() to capture the GuC log and CT state
> > for GT-level hangs that are not tied to a specific queue or job. It then
> > hooks this capture mechanism into the TLB invalidation timeout path. This
> > helps in diagnosing firmware stalls where the invalidation request was
> > consumed but the ack was delayed.
> >
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> >
> > > diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> > > --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> > > +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> > [ ... ]
> > > @@ -323,40 +318,44 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
> > >                                struct xe_gt *gt,
> > >                                struct xe_exec_queue *q,
> > >                                struct xe_sched_job *job)
> > >  {
> > [ ... ]
> > >       /* keep going if fw fails as we still want to save the memory and SW data */
> > > -     CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
> > > +     CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
> >
> > [Severity: High]
> > If this capture path is reached without holding a PM runtime reference, does
> > acquiring the forcewake here attempt MMIO accesses while the device is in a
> > low-power state? Accessing MMIO registers when the device has entered
> > autosuspend (D3cold) typically causes unhandled PCIe errors or system
> > crashes.
> >
> > [ ... ]
> > > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> > > --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> > > +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> > [ ... ]
> > > @@ -90,13 +98,27 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
> > >                       "TLB invalidation fence timeout, seqno=%d recv=%d",
> > >                       fence->seqno, tlb_inval->seqno_recv);
> > >
> > > +             timedout_seqno = fence->seqno;
> > > +
> > >               fence->base.error = -ETIME;
> > >               xe_tlb_inval_fence_signal(fence);
> >
> > [Severity: High]
> > Can this sequence drop the last PM runtime reference before the devcoredump
> > is captured?
> >
> > Looking at xe_tlb_inval_fence_signal(), it calls xe_tlb_inval_fence_fini()
> > which drops the PM runtime reference (xe_pm_runtime_put). If this was the
> > last active reference, the device could begin autosuspending.
> >
> > >       }
> > >       if (!list_empty(&tlb_inval->pending_fences))
> > >               queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
> > >                                  timeout_delay);
> > > +     seqno_recv = tlb_inval->seqno_recv;
> > >       spin_unlock_irq(&tlb_inval->pending_lock);
> > > +
> > > +     /*
> > > +      * Capture the GuC log and CT state so the firmware side of the hang
> > > +      * can be inspected; there is no queue or job to blame here. Must be
> > > +      * outside pending_lock as the capture takes sleeping locks, hence
> > > +      * @seqno_recv is sampled above while the lock is still held.
> > > +      */
> > > +     if (timedout_seqno)
> > > +             xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> > > +                               "TLB invalidation fence timeout, seqno=%d recv=%d",
> > > +                               timedout_seqno, seqno_recv);
> >
> > Since the PM reference was dropped earlier in the loop, would this call to
> > xe_devcoredump_gt() proceed without holding one? If the thread gets
> > preempted long enough for the autosuspend delay to expire, the forcewake
> > operation inside devcoredump_snapshot() might hit the hardware while it is
> > unpowered.
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260921182121.308217-1-talesam@gmail.com?part=1
> 
> 
> 
> -- 
> Com os cumprimentos,
> 
> Tales A. Mendonça
> talesam.org
> communitybig.org
