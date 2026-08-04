Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CDDC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 22:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD2510EBF6;
	Tue,  4 Aug 2026 22:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V7TFU5se";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFAB10EBF3;
 Tue,  4 Aug 2026 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785881835; x=1817417835;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=seoPNEHVIrNn13thg8c0AKsfcuOpJFBHu7IdRgKoISQ=;
 b=V7TFU5se49fvqY6BGZIh1XhpiMgMeFJs1TNGH2ZDscijMzPvc6k/UMLc
 9WTRtGVsoJCrUqqDxAsJW/go1qZ3KrlJHCssD0hltm6beH/AHKyrRZNe3
 JYsx8yfGtU0XjFHBaJsV6SqYg0kxuN1zZKebqQBfvG86FTAsXeA6ors4P
 aO0ug5bECHkBwIPZiPwQvs8P+dh17Vv5nfhivO3qL9SeasXqztIhpJS9i
 QuWlFsAAYNwfFYddCvJ1Ql/1FHU64eUbBTb8UltZ2cfW7Y7vrEB5nUtY3
 vNnkAekBZ2p86ut+Uj+Tscu9gb5R7oeAxwEk73msdLLFKp3cmUQCXcBLm w==;
X-CSE-ConnectionGUID: Ne3qJAPwT6280Vk43DGwIQ==
X-CSE-MsgGUID: h2dGvpCqQTK5n2bbEbgo6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86216136"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86216136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 15:17:14 -0700
X-CSE-ConnectionGUID: nHyic4XFR2SzQqNPMpqegg==
X-CSE-MsgGUID: xPxiL9a8QLeI/tPH6Bhj0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="286267849"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 15:17:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 15:17:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 15:17:13 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 15:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9i1BQM1D4ZzWwZf/DFnH76nuKGKkHyrXW2KzWjPmpQV6BZHykGNkT4Z/flDLuKmGEu30qF+6Drqdnc6RXLKSjjiAUe7saE1mHN0vWywqsqOHjJ5chsEhx4qRgPkmwz3Dbjf/HROsxsgvxpZP4LBWRzmjOIdrnLG4MSoWtL5kiDgtfhKh7cRszTRK2AOQPGzv8zfTh++DnbSr4KXgycC3ixy+iQilQQMjLe0pwgYHXmMpSUqBpXeoYilVYzwjbeFtOONs8xAOFZPp3IL2NslJRYirgqn1e8xb/PkwT28nTp//4Ag0WLdLyXbBouAqecGGQr8Bskuz9rZs2MEVLMynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUTFvzcIUl2fj9YV/lqxJBPygcByQ86ooxQk0KM3rYw=;
 b=PvvOX31I7zIJewcM60qOZODoLvEmIsFW9l2R7JLGVEeziv8eafX/cpe1jHNf4ObsGARC6v+JQ5Z5mZWpAieqzJyct1t1KJyYJcy7XfiYYzo5DOD2xfoGGbTVlHbOivmPwlwq8sreTOKjJ0589dUVEf3/xh19uj3rTc7IGunkcUP+bTM5f7U1pGedfDlzjOxPHOYCqZPAGlidK6IIX+Cc+0Pxqk6CDJo8KvRNgDqUZ9s049m4LtOa+k1cRfpZXkMT0CwYmAb6A6/8b+H3jWWMFsYOvtNRL1g9Mr6TFeXUgnYbxI9oJPSxU2ICLyGHMMZB4RdBxvYNVAMuxRlSA+cvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 22:17:10 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 22:17:09 +0000
Date: Tue, 4 Aug 2026 15:17:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH 2/3] drm/xe: Log when a timed out TLB invalidation
 ack finally arrives
Message-ID: <anJk4mVx3Y5+1mv2@gsse-cloud1.jf.intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <20260804021441.3054424-3-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804021441.3054424-3-talesam@gmail.com>
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff79b5c-fbd6-4534-fe3f-08def2762056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4hj6/lryMgbXtaHzBQ6Oh6p3tdVbBeDs09N2mp0VC/vTbPDT7Px2RyzCa4aBgBstv7Rw9Qfber0hJguCpWRDtrR6tx0nxBkahZzJppR2FX3BqCitMK/nqU+TK8mpUyaAdjWewvR4bWhF/w58seCxNe+9fZ6OgCr+/jsvGMGBdO1kLJa0kJrXiOghDT0zsHcPzzG0w1wdNzJSh5OwqwYpfV0pZUT3dDz7DYXkypSwP0XUz7z9b9Sgu8Q/Likq2I0/q65jbkl9+3UfnTRN8fZVx+bIoNPtSUU+xWoM22htNsF3DKD0YqdDcMfre6w3jV9zuYwQAS35Kmv4Gh6tNJKH2hkCrdEozQPwny3EAnxo0ygt26HzshgT5vmP19kyEPIkpZH2Ph6IXmBaWtmp2JqOH1Htm8SsW9SLhtk1fd1JnlUZ2+7msiMI3oeMc0nCB6SNp98KXNWDZmvs/krdPOojCFzD8BTmGrXAkwRc3qeAGYbnZ+lQYQPvedVmOjWKz4gdnJLKcIWquGr4g888+qkzaybrNVZEQqd81G/DWc/Cyf18b3WdQ6dozx49bXkRWdIU1I0jJLpGhuciJWm2ROo1qRLTYKzaeOHFn8es8rTroOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NTzR6bfemKonyLlO4nIY8YFmDe2CaTfFzhwIOcdhnXCSiDrJXM3jjvP28e?=
 =?iso-8859-1?Q?WE/jvH2hzriCPdPi2OBVGIMgVG9cG8DnReiWuU0d/8XEcrTBf0170UrBuo?=
 =?iso-8859-1?Q?VUC/7H/MmjZjNtBMncveHCQa+Yr6OHRMDIw7pZ/HVoAcMP2NEtPgbnsO8a?=
 =?iso-8859-1?Q?UrZTnwzCXwKoiBVGPKNJLV1zP2Zd6N35QvxH4Q6XmZ0kRpMJvniMkl/Wy7?=
 =?iso-8859-1?Q?IArUkrMqZbdgoMi3xaSwODewr8+IHSQ+8YDLGw/ImmJu4ghcI0pKDZrVLh?=
 =?iso-8859-1?Q?GMQkcCUVE/FSyWNZtR7u9fph/gr6FY8FN8U2asEH+zSrFCtiJ8zbPpxAD9?=
 =?iso-8859-1?Q?nwKAHrwv/wCvgpKOl22cDVVTpRVviKambI8ZCsPWbsOKggPQ4Y/ULy1D2a?=
 =?iso-8859-1?Q?krYDDHMjgjp4yraIXsYITMbriVspSa+oSBUVlsz3VILqTMhkp+/q+/Da6m?=
 =?iso-8859-1?Q?3wlwqIMwtKGhE/7KWPzC+Bv8ANjwp9iD6vB8HANzlwhkXAcBaW15h2LZ7n?=
 =?iso-8859-1?Q?jDiuaQZog+vQy6dLmrPMRqj04VivtMdmxt62t0CEIb4L38GFCWr2IpxgPc?=
 =?iso-8859-1?Q?O0MAvJYABL4IQbUixNuaYuE9ZSCfGRAQVjdRQ/fmw7dWsWypTk6OgotJxI?=
 =?iso-8859-1?Q?FrD/adgeoxChKIuF6ZbpJBp3JPG0a4TuHH1IvKIh4sO1LaTG4tkypEwfYk?=
 =?iso-8859-1?Q?UWfTSauYFA2tGFlwMMilg4uUCUzI9Tel1urG7HRcPgqPOtNnWXlsesXbv6?=
 =?iso-8859-1?Q?M31zRHQr52fC1Df4mgtEgCFF1Sg1gzOyyNNoWsuZ1QNZNSWwA4n/sXS7tK?=
 =?iso-8859-1?Q?cSs9FRwB7l40q065HHohh4+ctxNaDkACciD5+vEmo0qSenl5n19ENy0UZG?=
 =?iso-8859-1?Q?TDkjE2TM/B2/KogdI83SFaV0mjVlPhbsXA2etHMi1rnXY0ykXakDDvF2x0?=
 =?iso-8859-1?Q?sQDdDMn7iVni8yAuVjtLc552QKZKIAFdEpC1c00DMQZ73Rr+VHiiuIIc/X?=
 =?iso-8859-1?Q?VqC5dNK4uqFaSMcKAGthAG42mLIlAX7P/V7xeBSoZm2nzNp/3mAuVJdDtY?=
 =?iso-8859-1?Q?cGmKUQb3QbgrdleOvPIyxqWtpVU4D2tcHzn1XcuEbFSzIW1JORodbYAlLW?=
 =?iso-8859-1?Q?t1ithpNOkTY3vp/iZxYPwTrKaOhtKdo2IKn2Ga62gkcXCKNNmRmTpJTLIL?=
 =?iso-8859-1?Q?L4tOUJUxswYsiRWcgwVosEwbeU3HDiD/pyg7Aiprl1U4l1FwwWpbAcYjpx?=
 =?iso-8859-1?Q?AJs3pnpFBW73AkmLLVFcWzScAxJ1polX6AfO64NysRS3BE7xXvtYs3PQXR?=
 =?iso-8859-1?Q?mxB8Nt/m6IZFR4a1oTHlHY5OYOR4d9proatqQWgHEOTa+LsIqNBodc8sRZ?=
 =?iso-8859-1?Q?6E4z8SQOixDW6Exp2d5vrL0mJvES7UYUmSI/WRR4NT2iscZWVNMbyzsgIl?=
 =?iso-8859-1?Q?dxND8dLieWr5kJ9jv0n7cyejtMMe6gKakzhcMNML5NwygwQiGgdHvcmX1A?=
 =?iso-8859-1?Q?wmBe0cGS6yVSFstL7OY0LrW1MbueKJQhHEmHRa7jbSwivAGmx5hT63zv18?=
 =?iso-8859-1?Q?dKI8SECmrJLJtnzF2H3NIJVRQZ64a9HsWGY4cBD0r3CUVIfaCSFYqwu7pi?=
 =?iso-8859-1?Q?u44a0z0PE0NDWQm+v/klw/d8RHuhtCEJPC7ppQX4R+3XkCQchC4+Oxxm7z?=
 =?iso-8859-1?Q?XeBYNtsS1WcDyKFt4mwUBGkMAMgNFYwYGU366B+x74SXHYGcW/S7scDz7M?=
 =?iso-8859-1?Q?ZP16f1wBRNhctZRfdq4aQDZq2j7now2GCI0gspowPr8UGLfrBcLSRHASa2?=
 =?iso-8859-1?Q?Ok0m+BH1hT6ktR48/hP/DVQ9xWZoL8s=3D?=
X-Exchange-RoutingPolicyChecked: pkTLD1dd3AW3Hf+Sd0IPZnqSy8/JSwXmhB9iPLOu3tfv4hrZ2jT4dVNJQ6mRW/UMdsRknlYwLw0wI4OaZSdTw9tO7bgrq588uq2ViEVNelj/2/OATck+OHZa3dIVopaNhCIBqDJXWrIXHyPbn5meYCMrptSL0fStzfAX17J+UqBPTrmo8gm/ZJjxFsBLYwYZNc7RJHODvw1yeKdaZpmSlIlHVVOezG9gty4hs/FvzlsZs0vUzIkM4EVftdbdojWntxMHNmWBPD8OgSHmEv34B42q94UKdV3dV281/fVtnt46lwqmGHZx2/pIgiTXfqysJz/6EraV14apaNYy9ijmjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff79b5c-fbd6-4534-fe3f-08def2762056
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:17:09.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRxxkwpnIn1hJMF+zh89A1E3FKpsRUqSc3zbhPHaX4BTswXa8JZUNEpzaiWH81b8ltlvlW3WN0RpgORNuqOTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
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

On Mon, Aug 03, 2026 at 11:14:40PM -0300, Tales A. Mendonça wrote:
> When a TLB invalidation fence times out we log the timeout, but if the
> ack for that seqno later shows up there is no record of it, making it
> impossible to tell from logs whether the ack was lost forever or merely
> (very) late.
> 
> Track the most recent timed out seqno and log how late its ack arrives,
> relative to both the original request and the moment the fence was
> signaled with -ETIME.
> 
> On ARL with GuC 70.53.0 this shows the acks are never lost: they
> consistently arrive ~2.3s after the request, tens of milliseconds after
> the TDR has already signaled the fence:
> 
>   TLB invalidation fence timeout, seqno=10992 recv=10991
>   TLB invalidation late ack: seqno=10992 recv=10992, request-to-ack=2314ms, timeout-to-ack=45ms
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_tlb_inval.c       | 16 ++++++++++++++++
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> index 833fb92cd3e..9dd04d5bc4c 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> @@ -99,6 +99,9 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
>  			fence->seqno, tlb_inval->seqno_recv);
>  
>  		timedout_seqno = fence->seqno;

Should this be:

if (!tlb_inval->timedout_seqno) {
	tlb_inval->timedout_seqno = fence->seqno;
	tlb_inval->timedout_inval_time = fence->inval_time;
	tlb_inval->timedout_time = ktime_get();
}

To record the very first timeout seqno? I think this makes more sense.

> +		tlb_inval->timedout_seqno = fence->seqno;
> +		tlb_inval->timedout_inval_time = fence->inval_time;
> +		tlb_inval->timedout_time = ktime_get();
>  
>  		fence->base.error = -ETIME;
>  		xe_tlb_inval_fence_signal(fence);
> @@ -227,6 +230,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
>  	else
>  		pending_seqno = tlb_inval->seqno - 1;
>  	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
> +	tlb_inval->timedout_seqno = 0;
>  
>  	list_for_each_entry_safe(fence, next,
>  				 &tlb_inval->pending_fences, link)
> @@ -424,6 +428,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
>  
>  	WRITE_ONCE(tlb_inval->seqno_recv, seqno);
>  
> +	if (tlb_inval->timedout_seqno &&
> +	    xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->timedout_seqno)) {
> +		ktime_t now = ktime_get();
> +
> +		drm_warn(&xe->drm,

I think xe_warn is the preference here.

Matt

> +			 "TLB invalidation late ack: seqno=%d recv=%d, request-to-ack=%lldms, timeout-to-ack=%lldms",
> +			 tlb_inval->timedout_seqno, seqno,
> +			 ktime_ms_delta(now, tlb_inval->timedout_inval_time),
> +			 ktime_ms_delta(now, tlb_inval->timedout_time));
> +		tlb_inval->timedout_seqno = 0;
> +	}
> +
>  	list_for_each_entry_safe(fence, next,
>  				 &tlb_inval->pending_fences, link) {
>  		trace_xe_tlb_inval_fence_recv(xe, fence);
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> index 3d1797d186f..38288966254 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> @@ -102,6 +102,23 @@ struct xe_tlb_inval {
>  	 * @pending_lock: protects @pending_fences and updating @seqno_recv.
>  	 */
>  	spinlock_t pending_lock;
> +	/**
> +	 * @timedout_seqno: seqno of the most recent timed out TLB
> +	 * invalidation, 0 if none. Used to measure how late the ack for a
> +	 * timed out invalidation actually arrives. Protected by
> +	 * @pending_lock.
> +	 */
> +	int timedout_seqno;
> +	/**
> +	 * @timedout_inval_time: request time of @timedout_seqno. Protected by
> +	 * @pending_lock.
> +	 */
> +	ktime_t timedout_inval_time;
> +	/**
> +	 * @timedout_time: time @timedout_seqno was signaled with -ETIME.
> +	 * Protected by @pending_lock.
> +	 */
> +	ktime_t timedout_time;
>  	/**
>  	 * @fence_tdr: schedules a delayed call to xe_tlb_fence_timeout after
>  	 * the timeout interval is over.
> -- 
> 2.55.0
> 
