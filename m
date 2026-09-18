Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D219CC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F5410E335;
	Fri, 18 Sep 2026 22:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G/Jvflz9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CD410E12C;
 Fri, 18 Sep 2026 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789769192; x=1821305192;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iJeNgrl7g6ubII7/gYRGzp3fzy/q1Tun88qwk+RYEgA=;
 b=G/Jvflz9aWYtb5Nxdpnq7znMfZfKc/7WmsWaG95toFTd9mjJu/G3Yf1l
 RAcOfgwp6lSz66us6uwY5uzvigOIyMTDKm7fHsuBJ4VLTpOL9BU4I3ru/
 pYQPSaw1f4Hx6NFLnyXdr2/rzYXy5zwYeRIb0Mi9mUer/wdfzphyrtPXf
 AFFDjdivPKA4nj8AwbbNroDHVx69j7smJvcJuo2MvJOvbwZ98gD93PPIt
 65Tlk5F0UukCRfN8tFbem29LWKf2AXVBIAp2naowmU4x9dLM8ICs1oj9f
 ZdpR+523gEYOmnp0ESLXynqNyBrQblwdDF0yn1xgNQMpu/vXlOaYCI5Fl A==;
X-CSE-ConnectionGUID: wcdePuvSQUSqiQVdAwSUTg==
X-CSE-MsgGUID: kuvJghQCTnaM4quV0GL0Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90433991"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="90433991"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:06:31 -0700
X-CSE-ConnectionGUID: a2iOPm5KQ1SajIwpPH33kg==
X-CSE-MsgGUID: wcMXd796R5aa5eIZVk0Iog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2832897"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:06:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:06:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 15:06:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kElqtJ3wnJ3aXeQxSY5vP3lXjLPVW5ScKp5X9g1kVMCdS5RKveeFr/YfSS09SnJNrEXvL9Tao9Jfydnus/PK1gLGXhw/KFO0SPwZUBUXxah4veyUFS6CMuhbI63Bk7FJprR36/bbeOCUzHlx+6M50BBLN4MCsuuuSzu8APAwmKGoXkNZwB59OcrM15ohYglCbqwvPEbZBiEH4f2WDe2CIN2WB5U5T7WOn1J8dhrguRqIA8AW6RpGEog+o39WjDIQSWcvH2qs4iLgYah0Sv4EsrtJreKmFWeY3rtYuE4FFXLqomd+VdB3NofxVDeJhvFRFJk/M2OogPBNDZlLk0xHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlN7aSrRqgJgnLOsSKkCWtfGcc2WvznnRRWTKRfaucE=;
 b=dPYS5sG6MqXCsBbXtr6w5EZLpBePef9vrNUQhPFqmFDfYKw4urzoMZEml0ZGJNTfBqMNmlqWl80Md3wRVhZ2yL2tRRPOvNBUR6b7hbsgKFo3LqA6vQXXJXu3OSIpbJM+SApqk0b1G5PNJblF66nhSdLlf+RUE0QBqiEdg234ZlMNb6f0ETHGEDU/XjgdnyOfMNr5tnVaWzRfdh3w8yzGc4UbZCvQjGVLtYYkEAIWymNqJkG8oosVPszqKVg/9RSrmVMlFVTmkzuhBBKFSQfm/U1jRn4xKVpIZuOXhR8rXVRheFVyhmasjrXO1MOlDkwF5qtZ2TqyrfUfkNnyQV4KQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA3PR11MB8966.namprd11.prod.outlook.com (2603:10b6:208:572::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 22:06:28 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 22:06:28 +0000
Date: Fri, 18 Sep 2026 15:06:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Message-ID: <aq214e+ia3nHVrKB@gsse-cloud1.jf.intel.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
 <20260917163553.1742580-3-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917163553.1742580-3-talesam@gmail.com>
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA3PR11MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 111d2969-fb1f-479f-b1a2-08df15d11687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qIOIKjevNh9ib8UyVV2ML6nuqHnffPKVyDTC/ESajuWcvlf+bGlS37XR7g8fUHtPU3+E03/MDsLolxPbPnXlJrmVjLVSl4x1nhe4r2X29KotPfFb3J1Brvpquy9Z+b39XhSdZlqRrzpuzB0tVc3jAx70SfAlpUxMt5ZOSsuDIO0fNk9fpW7kf2kn8XTN+tV1u+xDY1ZbYeZuYYHO6NXJrISZv+E5Ljcz7y4KmArf4885ABP0kUg+fLmRPeHmCQ2GZBmM4AHm2ijt/vaYwv1+l05AacDCSfbFPRpYf9MaJWT7jITrSWeyV70KwnhmN2CfW8l94wJ7qnR1pFVYYELFdbdLuOW9fXVM5Hhk/wM3GhV+DPqJDBXCZiElve9zoDYDQRqzQCSUKCsLJvKEzMbuNOcnvDP/xb4Ukb8rvK8XK0xYw1uvS0yy1vSAmQMVSwvTfEMTz+KZjaP4azUGYb0WGJZ4p13Ou7d5ZKiPFOVElvuv356WosB3JAtsJQ4sKeMypHehcjg6lKpTbBUCZcR3hM+s+EPXM51hmwRofh6i0HQRgPV1HXCSw/qyBjx20DBVDL8tl1cH9mRZn/HzpqJfwyFvQ4Jo0RJeV8EXVRhVQvvmQMCfwzYVkHFHGjy4zObP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8Oo7rFnpFAGNlmdZSpYO2aOmx9nkw+pqWlcz7UdYPPY0gF18hYIgQ1GkS7?=
 =?iso-8859-1?Q?eDxBwVZh22SCyoX9ge7wsIAbWm185NBgf59FDiaFLTlIU0DNBP5e5Z1kgq?=
 =?iso-8859-1?Q?UwVaxZUZvRKcIt8rokqZXQUJ1Q/WfJBNenVGchXEK/tnfDC3JN/HwXky6P?=
 =?iso-8859-1?Q?FCUFYqoU8GGTyrtZrbj5wFaWk0Rjvs+OowDyghMVNZGwwuijIrKcP2QBjv?=
 =?iso-8859-1?Q?4kOk3dzqEZpnNL36gth9Y3Bwf9ZpiBasjhRAaAqJjZUKfhCNfHoKUr6A/6?=
 =?iso-8859-1?Q?g4K32rXuemupi/2zPjx4kuaFG7cNVsHtJYtEKUiv6mpXZVA4thFH5TFB3p?=
 =?iso-8859-1?Q?/Zqc76QzY+FgIu8w4OYcHf5/2fa8HTwgoDyP7Fxudj9sM0ZQJd9Bz5v/aa?=
 =?iso-8859-1?Q?Y0HrnAT4x4QR8JhbPI6qWftdsYo+hXNkioY60TKQw+cGRndBuyyTYHm3Hw?=
 =?iso-8859-1?Q?Acvr1yzNIKYB3wCArQeBNDFIInuKXjoA9IkoOH670z8BBc3YnT2c+tpFT4?=
 =?iso-8859-1?Q?fM/crVegZwhPsTKtj2ioWYKYRgC6WcPtBA5v8dReWakONNkZ+IQJMuhUd+?=
 =?iso-8859-1?Q?6+H1XkAleN1fSjRDnb9hglP5Hqy4JIfO43f5C2tgMTav+F5vG6q51apOGt?=
 =?iso-8859-1?Q?wKtC6VnEd3zkg69mPtZGPBVjEJmotizST0CxOIo1ndhshznAFUVemxyx1R?=
 =?iso-8859-1?Q?jhx/oGFLezmo9lLGI/+XMUlNCmJdyap2qN6bQTed1jTA2Iov2jbUEULB3E?=
 =?iso-8859-1?Q?tc9MJCarvG1c+5iarHq449rds+2NNaoHw5dh4fkpxwBxlBC+8+lHhxIFmH?=
 =?iso-8859-1?Q?ihFjs31ccQnKLjshPHMtmyiOYP5oX+HfIbZZkFzvFTXaCS9Az4pGUVX5wU?=
 =?iso-8859-1?Q?4Fizz2MSU1VvtzHi3pjPskjFVoaMjVxNAx7vCvtcob28+xSXijVKSviKbL?=
 =?iso-8859-1?Q?Ee8/WSydSsxhvgpq/pC1+dbZISlmkn433wtBfTVaxGRKjS8NA/8X9vjnKv?=
 =?iso-8859-1?Q?JsA4YhCEvknLR+TboS/UbCSC2q60KDWvaobvbJxZRbVRtmKpzQV0YUl55H?=
 =?iso-8859-1?Q?OhAwdt+HyvIEggITbBzf8EpBKyeOy45/2uz7LUtg7t4sDk7TdK9e6Zq7uC?=
 =?iso-8859-1?Q?74JBuic8wfjfWjvuP3ipVGYGUDVBBPWCoe8G6K4SbAv8C8QVMfetWx8suX?=
 =?iso-8859-1?Q?oeDGNg92Vcu6zYG0f6xDin3arLWRG6eGlXCi6hKTHPq8JigXRXuIWTh858?=
 =?iso-8859-1?Q?d6t0ByXCs/AkK1Kl9c7wwLZUu8Gn33dMljMbYR/dcj5kt+mIRIcKQKdd9G?=
 =?iso-8859-1?Q?+557VeVEGzuyGn8Q/IqcKUchtu7X9TFMYDYa99y6rF4W5LLI/i29DCODKG?=
 =?iso-8859-1?Q?3d8qpkcaHHXcsBQfZidc5kGYq8RWEgw3CbjCdLNq8GZ2JpZfyZHClDJYUu?=
 =?iso-8859-1?Q?8MG2dh+Ta0+UfMhfZi6ZKNTP5jEV5ymbHsylsQOEur2dezMCyK7h8Mge95?=
 =?iso-8859-1?Q?Ijpk+tlh3UjTkq0xMBlFx6LpJwP2Wcpfifa1fZvpfk+49rkWIZWauzSGFg?=
 =?iso-8859-1?Q?lR+huwq5EnOZEwaR+rz3JIkfVE+ml78+zQ3XwCcTpE1+XkgAmVdeSjdr93?=
 =?iso-8859-1?Q?hGG8J7t6jnAaRM3OvzDA4ze7LW6DtO53CTOAZphOkOSdcxEEpq/4ieQsId?=
 =?iso-8859-1?Q?bDWwHj0eLiFjc7kSijWWx+1gPu1fVU9/x2e4vpkYVVNf2FdYUVTjQVDm74?=
 =?iso-8859-1?Q?UuyfjQ2uTJOlgOJLYEfJw9NhjDhoTbdn82uhSWdP1RtWXcA0odO6B6v4/M?=
 =?iso-8859-1?Q?KSIy3Nd4Nw=3D=3D?=
X-Exchange-RoutingPolicyChecked: faQRrrwb/8J1776F5e2AhlIqIWIuItjKc4FShhu4Qxm2pc78Ta95EIE8CkrYLVJzqYDx9gRUdV2uJ06sewyEv0UmxCs9WASdlnQKd1PRBb4Yo8Y8Jfhh5kLnevoNR+a4Tl/EaMWIfx9Zk+rcpEQ7W4CDsGGM6H7+l1vFhzLcBw2dCK343oM4lrDM/WaHeCjlRBuN0NJiY4ula14ij7aU723z7l6Gm/Wn4hoSHO+XIEwacahZFUgwb1WsmwMbmzFkfqg4Mo8t4msf5OMw3B4yrRMiEbM5zOInY7z1MTHQjLbV0QWgJ8EVCThT3zIderCKAavJwwBCtDEMK6OvvkHdog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 111d2969-fb1f-479f-b1a2-08df15d11687
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 22:06:28.1783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHcPpysXKuuT3Oikc1MzgIb6GhthpbwFH5Vy0iqOm2428ObKeEfHQ/FXVmKsVQc7FbsvykUb6nMd7G8yZlCzTA==
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

On Thu, Sep 17, 2026 at 01:35:52PM -0300, Tales A. Mendonça wrote:
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
>   TLB invalidation late ack: seqno=10992 recv=10992,
>     request-to-ack=2314ms, timeout-to-ack=45ms
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>

I would give this an RB but my colleagues have done a bunch of work on
SIGID and I haven't been involved at all, so I need some help here.

> ---
>  drivers/gpu/drm/xe/xe_tlb_inval.c       | 19 +++++++++++++++++++
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> index 7a0c04fac60..7047a347551 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> @@ -14,6 +14,7 @@
>  #include "xe_guc_tlb_inval.h"
>  #include "xe_mmio.h"
>  #include "xe_pm.h"
> +#include "xe_printk.h"
>  #include "xe_tlb_inval.h"
>  #include "xe_trace.h"
>  
> @@ -99,6 +100,11 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
>  			fence->seqno, tlb_inval->seqno_recv);
>  
>  		timedout_seqno = fence->seqno;
> +		if (!tlb_inval->timedout_seqno) {
> +			tlb_inval->timedout_seqno = fence->seqno;
> +			tlb_inval->timedout_inval_time = fence->inval_time;
> +			tlb_inval->timedout_time = ktime_get();
> +		}
>  
>  		fence->base.error = -ETIME;
>  		xe_tlb_inval_fence_signal(fence);
> @@ -227,6 +233,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
>  	else
>  		pending_seqno = tlb_inval->seqno - 1;
>  	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
> +	tlb_inval->timedout_seqno = 0;
>  
>  	list_for_each_entry_safe(fence, next,
>  				 &tlb_inval->pending_fences, link)
> @@ -454,6 +461,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
>  
>  	WRITE_ONCE(tlb_inval->seqno_recv, seqno);
>  
> +	if (tlb_inval->timedout_seqno &&
> +	    xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->timedout_seqno)) {
> +		ktime_t now = ktime_get();
> +
> +		xe_warn(xe,
> +			"TLB invalidation late ack: seqno=%d recv=%d, request-to-ack=%lldms, timeout-to-ack=%lldms",
> +			tlb_inval->timedout_seqno, seqno,
> +			ktime_ms_delta(now, tlb_inval->timedout_inval_time),
> +			ktime_ms_delta(now, tlb_inval->timedout_time));

Should this be some type SIGID message?

Matt

> +		tlb_inval->timedout_seqno = 0;
> +	}
> +
>  	list_for_each_entry_safe(fence, next,
>  				 &tlb_inval->pending_fences, link) {
>  		trace_xe_tlb_inval_fence_recv(xe, fence);
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> index d77be1aedc9..80d2019fa20 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> @@ -112,6 +112,23 @@ struct xe_tlb_inval {
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
