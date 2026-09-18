Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7D2C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2974E10E196;
	Fri, 18 Sep 2026 22:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Tp9cIj+W";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4386310E12C;
 Fri, 18 Sep 2026 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789768954; x=1821304954;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vNzdbkoVpyFS4PYtRRxHpZhly0sboacrWfN1PFDklNI=;
 b=Tp9cIj+WeEFSeMOi3O2xPo+Ko28TqfPGzVcTPOxQEFpsdVsJf3yoBDSy
 iwq58h611Zn8HQC2+YPac7/xXq10NQH+4nkoq2VA0TzwjinP0o1jgcsGZ
 1UKV67E44UCKitQGSX7zVd9VIiAD/e6y7FiOqL77jAjPXsZEA6YdXv1Z5
 VdotyzfkFLyLJ3vb7e3g7KXU+9Lb8h8qJpUUEws47+hhXwczn479ngf1T
 Eq1GO473kpOGQUmK4eYf65ec1H6tVe7l5ED4BlO/uOi+T6jg/uqBjc/UM
 I4GPK253aVg4IIMjz3UupIyOQDcki3aV9QYATSL3ehRLQm3sN5lxMr8wW g==;
X-CSE-ConnectionGUID: 7svuXZgWR+yOOLxaNEfjRw==
X-CSE-MsgGUID: 1yJVaap/QGOeY3/73hwgvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="803348"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="803348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:02:33 -0700
X-CSE-ConnectionGUID: FkvSKYxZQsaz5lFFMhOyng==
X-CSE-MsgGUID: 0HwkUUsUQ1uAym2nxpHdUA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:02:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:02:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 15:02:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.12)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXDvt1O/+MiXzVGoaIe5cWXGIsU6PxQRZXhic/aY8PVDAzup4f7jgR0YvQex51R+BvqOkcflnvh/lUx1DBRunKok/1IvEYBCfSPXHGdEdAAaXd+7DUNSqWVsY9rFb4lnTiVQBpBOJ0rzFMkfKwXuVW8HD3sUo2wlCnrXOwD1fuNs9BVQ+9N8JAVOIbOhAiIYqukOb2u89qN2bCn7A/lXfQIWa8BMdrmxLAZQjgFo77XpI96GpjEtdVhFSjriE4AncuR+8S4UPT1JF204koaKUCVAIrv8uBdgvLnD2IlUVKozGpsc2wtJuzqLNYbMREw1FRVXlh21maJEilBX887MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueh0aDGsOJLYjySO+kqT5pxr8HCMScbRrLwKg9LFXjI=;
 b=sBO2Mks9N5ZrIPs/j91ULe7C/f6Xv+KVwTCZ5tIdXkiOMatycgIzAPtUcjUUn8pFRn57xK8jRcROD/xj4oaw5Tu0WfRA6NZ6ygJe7bng/Ym7jwp2LZza0ypPvDykBOpW5UxBfhJxp/xJQBnSAnOzFAhD1NwmWPDgC/fbf3uQduwjnWkQpKUTGJ36H1cjc1h7eJBP7o5gYOaEjYpD1pZAo9qn4vhiWKbOQMyu9RIGuB6/W4oNu7wc1UIu3/yni17ySCuyk83DVz/bq+RuDT9+9h9WUpLBx3fugLUuFtuTHXaaxVIXpmeEzMlzQ+znOLzr/0yPJzC1oxPYKI+2dWTFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA3PR11MB8966.namprd11.prod.outlook.com (2603:10b6:208:572::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 22:01:40 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 22:01:29 +0000
Date: Fri, 18 Sep 2026 15:01:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
Message-ID: <aq20tufDkY17Ed3p@gsse-cloud1.jf.intel.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
 <20260917163553.1742580-2-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917163553.1742580-2-talesam@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA3PR11MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee6b9b7-7987-4356-b3d2-08df15d06491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|5023799004|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xudtwePs+CZrhwlrUU4038bO9Jn4xCLNIaH/3cKZ30tqRcNcMFCggWlrtinhR9KdcBmrPllBSZtP9k9vJW6Gx9iHKe7X+fLPivnDG9G21kmdpSV3sLmGVkxREYnGznd18tnC3/A5PyH/dtBj0izzsCKQ4hKpiG8WclGR5JwFYIXhdhVAVHuEIO6Gi0b3JkAg4vMTWohJ511wN1F7i+eF0HULyW+47tx+BsReGIBf0/z5wTqm8R1OKPYk6g22d+i5oLmuqivmVzt4odXVODJx2UFrVBLfwQJfgOwf0UbPwbY0QQOR+jJ5DWgfeo6/H6J9dx/UupTRKIq66Av/km9hIRovp2WFbKb3d69SfXBeJZLA1v84ORa//ri7xfsy74dUVJxF/XWwSCxL6LX+e1Fa0qq9NTE1CrhDwY+AwtYbTpzudXdEvkW6DVkxo3W4fEuTtVMhT2zzYkmJbDeg8w9AbrzhBs28PuaKdHNjpBamsyy3Oc3ETRE8cQzujqzf9asUK0z4SJFwjFY4+4n5ceIIbd97kMlQ+IBiMvFgpacnoNa9FjRFWBIl0Gga1dvqxq9dUllcY0vnNE5eK3w9RvVkJtc30ZW8yg8dIYyo8mVUrVBSoUSmLxrWlFZ3u3wFlnyr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CW+Z1SpD4WAVVKoIhLBidOW1Y3xiP+lhYRHEv3lzatz0teyMlxR6DLs6+S?=
 =?iso-8859-1?Q?TlXKKR8QL6YJgpkOXKocK0BNn/svKXJj7h3QCUfHJnW0ntIFMI+dNx1Qcr?=
 =?iso-8859-1?Q?T61YzEPwC3fmGeJQOwQMNd9lhndsIu0ahY/hn32hMoK+98PFI4Wov8fXr9?=
 =?iso-8859-1?Q?X4433/5IQigfbdFbor1q7SXf/erEGQKFFX2mVKZQOJNeiTEt3S5f6BQDsg?=
 =?iso-8859-1?Q?p34v3lo/1KGBM3HdttMm/jzzr5wJyiQZnQwa0zVMaq57hW62ZxEuYO/TTm?=
 =?iso-8859-1?Q?N83WUwljCZwpVabud1KlXtbhxCMVj1+FHy2XbrQdGKo1JwqWFKzcJoN4v7?=
 =?iso-8859-1?Q?OH5pjglichs1Y4SaegYkdBW6tQvO81+DRGL44rlPPBdzBhT+lYBnXF8lM9?=
 =?iso-8859-1?Q?5d8nfH5aw8OCi2Qd9TK3cREb4dcFa+c5t76XqwnaJS7P8qxFU0xhqgwwYJ?=
 =?iso-8859-1?Q?GvFVs4pdUxuaWU41hqJJO5IJ7JHHHcsr71oOquIuY+auP6F3AngYSA9srJ?=
 =?iso-8859-1?Q?46+/W21Qhr0gWv3h6uQ4LP1cMrIyfwtTirvvtlgupuUJVLoUJ6lxUvxDB8?=
 =?iso-8859-1?Q?mzsCeGSrkb57sLdnTdNL6VYPXm5Zbn+CDALRn7oUBU49TRgiJGwa9fuVIe?=
 =?iso-8859-1?Q?dBAiDug1bzr24WL7lUCEBwd3ywQrKZiwNcutXuH7Ksx5QQOMtoYKoB/brm?=
 =?iso-8859-1?Q?Pz/r5JD9CkIvK5Wo2qrtUjwORujlXUUytUASpqD2Eo5oxj66Tw4Ut+YyQV?=
 =?iso-8859-1?Q?LzUz5f3DxoF61LAzSh8uSc7fUc4c++Mu7wiKFlvSB7rO1B2mBl/CkpRiDp?=
 =?iso-8859-1?Q?LZVCS4FQLruEyKkSf2msOjudPnXs//g6W1EpodrkbXfg2CCF66JPrQzlSv?=
 =?iso-8859-1?Q?zhqNSretEYwUyBip5JOB8k0KnHI0rXVaGDDJqzW+VDBKOYVxRK8njgfmi8?=
 =?iso-8859-1?Q?mePunc8Fb0acRXv4a1WLfBTh6zWjp3797XXQHcfcjFc82o88VesyE3LIJL?=
 =?iso-8859-1?Q?+QbujdiKaGaCMyBKCEzorVAvubOfxgiUWTTadUMnxlbpR6UP7NH7al/5tB?=
 =?iso-8859-1?Q?plZBOcvAGEePbmPmAVN8Zs9YRIt7p0Am4I4V/6aVpOi5xC3Rgp+DO/Gsyq?=
 =?iso-8859-1?Q?A/D+VXqflzMp6lz6F4OGRZZocS4FkI/e9o0E22tE0F1OGOoWFuaNKZGkxq?=
 =?iso-8859-1?Q?A2ddN69yScLwFQy9crtQ71USWpthhY7GGcu/4PwXnRkk+zX6f3imPTxg5Y?=
 =?iso-8859-1?Q?/tV66npHQP4l40WNPlUpm93Na1ImXVj5ZklAQ98YsMGiDfJwQrC+ejdFCK?=
 =?iso-8859-1?Q?s1ncCgHBZsi5jO2Mobfqb2rbIfpcc0vMEx6R6RRBf4e29bRhIF4vZJYfY0?=
 =?iso-8859-1?Q?QWE4SUAm1dsQHwPh2t93H5BsDqt70dWS4rIXAUIBG0+Nby3d0pRt9nVVQ+?=
 =?iso-8859-1?Q?qkOZVIIyK7zvbq+/MHQhHBQS906um7Jdk2Z50i76GJZ4UgGSqCgyGNVClu?=
 =?iso-8859-1?Q?hwntzeUOpFxZhzgvcs8I6azIHYsEb01N4Ns1gkWQPRMz3ZFMg//tXRaDxI?=
 =?iso-8859-1?Q?gSL6hgT1KqzwmdkP1Dg5Tkcwj5XhAdmaSknbX3VgAsrltX87yLRsb9PYYC?=
 =?iso-8859-1?Q?0GIaoPTYELwiYigCQFxP1Ikz3uTFEjRdgwRQq7bICQ93VGl/DJLR1rrjrI?=
 =?iso-8859-1?Q?ld0mAK8VEs7zo+/x4mA7XUb/owO7/jQ8Z+D45kAsHIdU5GsTIXOLm9kcj2?=
 =?iso-8859-1?Q?KvlzIwHiSGho4q/bIp1uvWkH54+ioKSLstQcXzR2fMWWHbXFbtFIklWGdj?=
 =?iso-8859-1?Q?z8dj9FrVzQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4oMtQQCLyxbtktCatYpTPfzW0C0YrmWCYj5rTsfILOTCtsJ9yNMpCQwRFYv5cGRlo8BG64QCi7nS5DuHrv5kTBc+dIfngmOLVnBk4kEk05BkrzHnDzZrCthn48ozB6xHpyc/53uo7tvUtnLxVBOiBLGQnJM22lp5o6EeUa0RjxtLVLqfopm6mNCVZtXd7rGPVOPZGJloHVYFWGBPJLvNXYDEGHG0q/JIWBOXMDZt1vedaGlAJLvc7aMz/5ok0Z0HnClorjhhNnC6K6lOrHcVUwybQ/E7PvdV/UU7ranuaLg8KWOdRzYllKrfGdIrq1tX+iMZoeV/CDA3ATOPC+P9sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee6b9b7-7987-4356-b3d2-08df15d06491
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 22:01:29.5933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv/v2f1T16KNSEgAAkVdTBvhiRaxHrPDnEQbkJuu+uaZr4DfzOyjiHkQAIyzNGojpl1wobqnT0c9cg71yx6I+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8966
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

On Thu, Sep 17, 2026 at 01:35:51PM -0300, Tales A. Mendonça wrote:
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
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>

With your v5 fix Sashiko pointed out:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_devcoredump.c | 46 ++++++++++++++++-------------
>  drivers/gpu/drm/xe/xe_devcoredump.h | 15 +++++++---
>  drivers/gpu/drm/xe/xe_tlb_inval.c   | 20 +++++++++++++
>  3 files changed, 56 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 5f2b90b18f9..6bee8933f95 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -74,11 +74,6 @@ static struct xe_device *coredump_to_xe(const struct xe_devcoredump *coredump)
>  	return container_of(coredump, struct xe_device, devcoredump);
>  }
>  
> -static struct xe_guc *exec_queue_to_guc(struct xe_exec_queue *q)
> -{
> -	return &q->gt->uc.guc;
> -}
> -
>  static ssize_t __xe_devcoredump_read(char *buffer, ssize_t count,
>  				     ssize_t start,
>  				     struct xe_devcoredump *coredump)
> @@ -323,40 +318,44 @@ static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
>  }
>  
>  static void devcoredump_snapshot(struct xe_devcoredump *coredump,
> +				 struct xe_gt *gt,
>  				 struct xe_exec_queue *q,
>  				 struct xe_sched_job *job)
>  {
>  	struct xe_devcoredump_snapshot *ss = &coredump->snapshot;
> -	struct xe_guc *guc = exec_queue_to_guc(q);
> +	struct xe_guc *guc = &gt->uc.guc;
>  	const char *process_name = "no process";
>  	bool cookie;
>  
>  	ss->snapshot_time = ktime_get_real();
>  	ss->boot_time = ktime_get_boottime();
>  
> -	if (q->vm && q->vm->xef) {
> +	if (q && q->vm && q->vm->xef) {
>  		process_name = q->vm->xef->process_name;
>  		ss->pid = q->vm->xef->pid;
>  	}
>  
>  	strscpy(ss->process_name, process_name);
>  
> -	ss->gt = q->gt;
> +	ss->gt = gt;
>  	INIT_WORK(&ss->work, xe_devcoredump_deferred_snap_work);
>  
>  	/* keep going if fw fails as we still want to save the memory and SW data */
> -	CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
> +	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
>  
>  	cookie = dma_fence_begin_signalling();
>  
>  	ss->guc.log = xe_guc_log_snapshot_capture(&guc->log, true);
>  	ss->guc.ct = xe_guc_ct_snapshot_capture(&guc->ct);
> -	ss->ge = xe_guc_exec_queue_snapshot_capture(q);
> -	if (job)
> -		ss->job = xe_sched_job_snapshot_capture(job);
> -	ss->vm = xe_vm_snapshot_capture(q->vm);
>  
> -	xe_engine_snapshot_capture_for_queue(q);
> +	if (q) {
> +		ss->ge = xe_guc_exec_queue_snapshot_capture(q);
> +		if (job)
> +			ss->job = xe_sched_job_snapshot_capture(job);
> +		ss->vm = xe_vm_snapshot_capture(q->vm);
> +
> +		xe_engine_snapshot_capture_for_queue(q);
> +	}
>  
>  	queue_work(system_dfl_wq, &ss->work);
>  
> @@ -364,19 +363,24 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
>  }
>  
>  /**
> - * xe_devcoredump - Take the required snapshots and initialize coredump device.
> - * @q: The faulty xe_exec_queue, where the issue was detected.
> - * @job: The faulty xe_sched_job, where the issue was detected.
> + * __xe_devcoredump - Take the required snapshots and initialize coredump device.
> + * @gt: The GT where the issue was detected.
> + * @q: The faulty xe_exec_queue, where the issue was detected, may be NULL for
> + *     hangs that are not tied to an exec queue (e.g. TLB invalidation
> + *     timeouts); in that case only the GT-level state (GuC log and CT state)
> + *     is captured.
> + * @job: The faulty xe_sched_job, where the issue was detected, may be NULL.
>   * @fmt: Printf format + args to describe the reason for the core dump
>   *
>   * This function should be called at the crash time within the serialized
>   * gt_reset. It is skipped if we still have the core dump device available
>   * with the information of the 'first' snapshot.
>   */
> -__printf(3, 4)
> -void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const char *fmt, ...)
> +__printf(4, 5)
> +void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
> +		      struct xe_sched_job *job, const char *fmt, ...)
>  {
> -	struct xe_device *xe = gt_to_xe(q->gt);
> +	struct xe_device *xe = gt_to_xe(gt);
>  	struct xe_devcoredump *coredump = &xe->devcoredump;
>  	va_list varg;
>  
> @@ -394,7 +398,7 @@ void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const cha
>  	coredump->snapshot.reason = kvasprintf(GFP_ATOMIC, fmt, varg);
>  	va_end(varg);
>  
> -	devcoredump_snapshot(coredump, q, job);
> +	devcoredump_snapshot(coredump, gt, q, job);
>  
>  	drm_info(&xe->drm, "Xe device coredump has been created\n");
>  	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
> index 5391a80a4d1..bc4800b3a3f 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
> @@ -11,15 +11,17 @@
>  struct drm_printer;
>  struct xe_device;
>  struct xe_exec_queue;
> +struct xe_gt;
>  struct xe_sched_job;
>  
>  #ifdef CONFIG_DEV_COREDUMP
> -void xe_devcoredump(struct xe_exec_queue *q, struct xe_sched_job *job, const char *fmt, ...);
> +void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
> +		      struct xe_sched_job *job, const char *fmt, ...);
>  int xe_devcoredump_init(struct xe_device *xe);
>  #else
> -static inline void xe_devcoredump(struct xe_exec_queue *q,
> -				  struct xe_sched_job *job,
> -				  const char *fmt, ...)
> +static inline void __xe_devcoredump(struct xe_gt *gt, struct xe_exec_queue *q,
> +				    struct xe_sched_job *job,
> +				    const char *fmt, ...)
>  {
>  }
>  
> @@ -29,6 +31,11 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
>  }
>  #endif
>  
> +#define xe_devcoredump(_q, _job, _fmt, ...) \
> +	__xe_devcoredump((_q)->gt, _q, _job, _fmt, ##__VA_ARGS__)
> +#define xe_devcoredump_gt(_gt, _fmt, ...) \
> +	__xe_devcoredump(_gt, NULL, NULL, _fmt, ##__VA_ARGS__)
> +
>  void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>  			   const void *blob, size_t offset, size_t size);
>  
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> index 7c3bf32d925..7a0c04fac60 100644
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
