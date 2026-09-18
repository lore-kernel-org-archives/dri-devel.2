Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3020EC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8227910E3E4;
	Fri, 18 Sep 2026 22:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W88GcCvg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9A610E1A1;
 Fri, 18 Sep 2026 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789770989; x=1821306989;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=yb3/nAkzRjDelCRV5G14hH6Ez786Y6mfN/8unhsVwBY=;
 b=W88GcCvgMX9vUdiYZizo/pHVZWs0w8sNnKz4XV2NTJYO9eme7UIH9fHH
 OUhPdeprvTOqNqW8PjyDkBf8ypqgopuhXt/nbNT6Cy0TODq61xSwHccqt
 NL0+xf27fwrf/nL3nENLGrm8LdMeFfqnu+RjXF5N6qpBnytr3MkFD7fWs
 WG5THncN+cF0ZKuSb4WpK2n8VvlMmgQHxFAxdA/Zs09BZ/VZqbjDnUXlm
 Lrh2J4Ljq1VL5JiVTMqFBD/XaTpvJpWdPqx+jj+VLEs7RRTGi9hg12vkN
 QPPF6MkV7aoLwDhMvXAkQ9AFZelSSGmDBHwL5QMog1rBEC1FBA6Sm4bCz A==;
X-CSE-ConnectionGUID: eSzfAHVUQPSFoy1HpTvk3A==
X-CSE-MsgGUID: /LTOI5G4QDONpQ8Z66cEYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89235463"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="89235463"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:36:27 -0700
X-CSE-ConnectionGUID: EnmTseHGSwmp1H7kaGBtxg==
X-CSE-MsgGUID: ahuZI5v9Tq2uZjKi+fdc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="298049025"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:36:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:36:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 15:36:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh7oDF5zaCv3jP5PKIkIhAR8uRn02WtfbtS2jETFbIIOnHotdB4V5rk4yguzmxCvFWjfTV/FRcglpcIR4lV2biuFkA9g3hJBge+7j9gkIhOX/PuLxgHd7fPSU1ntsDPkSRInrpcAckYaoQU5ZsfcS4+Q3CaxXjjeCKP+kGGrRSjLFnAhxDgMDvRS86K2EMarJ1MY+1VZ49WG66qM502dDRd76PJl5g8PzKLw/Q0/JFyfZb+81o0RRWFwTV7wWVaxAQV6oosqUsmIGYyJni/FC9ViuIyzlNn/iLg6h5LG+X+3vfckc48gDZaJcXicNh0wGoJahzLDVw8AerhVY7J8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YxKHP846cmCWR8iO0p06dphyXluy5RFyt7buk7de0E=;
 b=wSkBnMCIA2ORFu0lTyoLH3DdvoOmZEzIc/RgVvkTlWrzyjIQjYCI6xc2Ym9ckdR0mq2rG/rhVMqwN67aNIzYK10H/zgKb7KczCUbRpJVPiEThaayHBam8Gs5Pg46ZZtBkwjPG0G7NEj2oqhbbZtliwAthz78/wpu6tGnqCutdKxFttHkDhfe1dRPbq3tIxKQ/I0V9q+IaidwckjF1cS4BDPEsBnHXGvQoJ26sIn64anzv9xYVT4tcyvxtEWhDyLwCsECj2sssFj/UUpYmy1toYR4Hi1MLoNltEePc+qUNnuE4fGDZQliOxLwzopcf1XYSITIwKr7NaXO1frfD48eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 22:36:23 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 22:36:23 +0000
Date: Fri, 18 Sep 2026 15:36:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 2/5] drm/xe/guc: Wake disable waiters after clearing
 pending state
Message-ID: <aq285SiT1wirY125@gsse-cloud1.jf.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-3-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916095337.3104891-3-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::29) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: f3367697-31a9-4003-b0a1-08df15d5447b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|3023799007|56012099006|4143699003|10067099003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LAVWoNWp9UnUzUcZdYOBFta91Bh+tCXWxz4vXim3nV99d+swLcfo5NGgh+ApyduI+eDdaM5UOhSyy6SXCZGy6DxaC5mq6+gbU1K3PBcQ2bdkQtreXSGIBDxBGPgojf/015+hvALEsehAdqZoMvE58Hxv9/TA/9lerzsmK0E3Gn0JVOPfX5Phonv3GLH8md5brY6fprtASu3WMY7P4MlFFy+1wJB6i5UBrsdbcpo82oEFrhXvP79uaFVAWSUQBRJKl+lb6A7e3LUl7kBj4vua22NQNzgdhe/lPW294ijxLEfZhwl1MdBzw9lnQkhCHx19zCdaasrCx3D16ujuxLHsb6Ccgxy6Xp3thTtBUjLbsTXJPnno3+yR5P3r5JXbq0Ai5DsyzpdIh21m9+p9z4S495MEhPWoKGr2APVUe9Aq7hDq2WtzPXgTVr/5tOcB63egiTv4EBlPIpA3dZFxIJHbXkUV08vFBzTmu/Uq1jdwWn3/wllxS8qqGpehPQFVxaYhDJvf6uIHMLSmnm1to1X+3zs3ARqnVMm1fSfWH/GuQyD/n+buEj9iSjgGD9MBiKbTizBdcfuXTqeVEuPQG9BzYIUKBxxbsFPDMP9Ucba4zddYkCqmOpamsJfy6CVGKdKm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(56012099006)(4143699003)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bFrZnamHcLPxrOYd0YnncUsnDlukfuS1JYi+wzjKCZx4P/vVo8evujR3yM?=
 =?iso-8859-1?Q?9p4ZbQO23oadExbWtIR04pPQ806miEKX1vdz+2qLq/6s2ZB7N17F1RpzCl?=
 =?iso-8859-1?Q?keQt3oT9GegLwqBfMMeb+pMfO31SzfL0K5Pb+UUEugWLQPKX4n42o6BkE0?=
 =?iso-8859-1?Q?/k9trIzeO+Nl6I3OcbabUx9Rwcbjmq3lAq/BVUZWkXL+nb2rjY6gnhUrlD?=
 =?iso-8859-1?Q?muHYDCkBW5WahNPZK2ZWay9MteI6V559fifKU7WsxUZ1fgQptOs1V6YbS3?=
 =?iso-8859-1?Q?hDqT2nIvcPpxUcATjd0OBGaUjDlPswAvjvcjQIZiQBIVgyq1xRVWcN2V6y?=
 =?iso-8859-1?Q?/MmuqkKsIsOG3+4IV9IGpvxBIsf8X3JgsTj2EHQDZO1ct2hjU+RcE6UJZt?=
 =?iso-8859-1?Q?k2KwPShM1daY21ljsa9a01i8EhtYrfv1g+Qm6eZmjmrsgZKsjAl2U9IWGW?=
 =?iso-8859-1?Q?U+X4E7IMSXr9c9WXkaRIgUZUQ9Oa5Uold7WUyMA3dbu49rYJB/gH2KkHXm?=
 =?iso-8859-1?Q?qg2RmLw51VAU1qV+0iOoPwEJtid8uHZdu1Y6uobh5CPKPqwIC4TQNSo6fS?=
 =?iso-8859-1?Q?56jwO/oegTuKlmOdSfm9olBAS7ADGbTSx8uC9AtJP7/fKT7zwKXSNoRSBL?=
 =?iso-8859-1?Q?gnkEWiZuTbE9Q51DGmSE8OkxVz4JmHzxOX8PUn0eU32hUOYLDEoq3vHEVk?=
 =?iso-8859-1?Q?K5CK7RCUjM64Fd1dpNYVxU9Ip6oFGh50Ox/SjYtSaQvyZBHs+zXdlZYqFZ?=
 =?iso-8859-1?Q?yHnRMyzwTj4qSdLyE9eG0oZAnRqOQpn0zvWw/1FQ9H8Wktla3p8EFYSsD9?=
 =?iso-8859-1?Q?unSg07BPs6hq1VlSSufkBhdZ6d6GmzWQxKBiwlCsd8xnR5F7zvnSt0pEr0?=
 =?iso-8859-1?Q?cB0+kSDXbq/JUsc5uwDqayxrsE0bd1UqqNv6W2m93E/yoe/2FnPQ2nSEnz?=
 =?iso-8859-1?Q?FirMMFimyGMdEoUk+4Z1om5tK2ksGa08oMswLcbyewptzoLO7fD/UoxTYz?=
 =?iso-8859-1?Q?HdfhwLf/FaKXKc36+rgM5gS7a3ySg2tmxyPFg2tad1Rucbwsb+V4wlena1?=
 =?iso-8859-1?Q?VH6QI5h50NfApvOzZhEI110qd0RJYPRG/ypTBwenyw8sBqaI/S99nTo7EO?=
 =?iso-8859-1?Q?s/1rs0HD0Yz2XwTqcN31b2xch31PuDULI/3jY4I9amNM4QAgXdXeN5LlJY?=
 =?iso-8859-1?Q?xwUH/imx6j9NgpFmugvAhvCnB+kgVBrXSE8yXX5YoL3WfEyRlcN4dTkmy9?=
 =?iso-8859-1?Q?6/6/Lcu7u4SStGoAbqsAZ/JMn8jCPtqlXltehcPV5GV96tAepQEg1NjNfT?=
 =?iso-8859-1?Q?ZG2hRDKI2XvawgZfw0Mm2s7jWU6t4U83VVPkH+yA/tKoxYC4RA6R88HcOH?=
 =?iso-8859-1?Q?Ki18glXE3XF1GRuQILK2y70UP8uon8jCHr2lkmaMDNU5Z2TYdVpS/Sdb+b?=
 =?iso-8859-1?Q?jHYRgV7v+NojZQLcNmhTKj7s9uuaKzpiSm/DAjuRYU/7F8EgFvX05GIbCb?=
 =?iso-8859-1?Q?uZG3VjY7DFJycYVt3hULab635hNQnicZV0WBSbc80AwIhNkZcgeYPtMiY8?=
 =?iso-8859-1?Q?GYIQVmKFxL90DCHF4SBsNQO24PPug35ORggfDsWvKX14zl6K0YynFbVQbz?=
 =?iso-8859-1?Q?vrahtpAAaOleP5XBHT7+JPhq2J94Ag/oyghd0EaY37H3HuA901Zl70p9Hw?=
 =?iso-8859-1?Q?hVWpGnxeON5erIRrQdt344gKQPBOHbCwkRdmppJSWkHQbIv02WQiMnnDuS?=
 =?iso-8859-1?Q?xCNGxIGHxmmZmh+DUWRkm+qxbIjWguFhnlairMugDKSfcEV/yR4HdM9UnR?=
 =?iso-8859-1?Q?IonpgluphajkKeDr6qSni1PsEU5HKvc=3D?=
X-Exchange-RoutingPolicyChecked: 5FFBFthn5tAZxuKXwg4d29UlbkBItuxLN2aKqu+OIhYx6/was3zB92lfBwYlehwaw5kDQ9IGfaueCSLDGxzFLog/P3PIAAdt1utCMolJEtXG70JM6utKA+lZzoVC8HtRCiyCivr8mtgx2AmI1wuECzP6L4hVK1Ejeh+QY3SJIp6+fZQ+2jkRj9hVrJmL3vQw45N7GzkR3WwvdRr5BHQ0canZ8QX2UmvVzMwZGBkw7819FWOizEwnesN4tyHpecShqEK6YJKCL0xPmeNhAcDzDTlE6kN+zkAHNxNuFEAU2a7qS13xzy5lI4v+bANbw96WBNaCHWkojfci9oCx+kprMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3367697-31a9-4003-b0a1-08df15d5447b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 22:36:23.3232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bcw7I5s5yDhkm8z8Fj0CdyPbvfyRbpw8r4S3XU0E5CQIzkXGcIQLDVx8jn9IUoTizg+eEbRZk+c91Xzwb6tgtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
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

On Wed, Sep 16, 2026 at 03:23:34PM +0530, Arvind Yadav wrote:
> disable_scheduling_deregister() waits for any pending scheduling
> operation to complete before destroying an exec queue.
> 
> For a disable completion, handle_sched_done() can wake the waiter before
> clearing pending_disable, or not wake it at all. The waiter can then miss
> a completed operation and expire after five seconds. This causes a
> spurious GT reset and immediate TDR.
> 
> Clear pending_disable before waking the waitqueue on every completion
> path. Sample the destroyed state before clearing the pending state, as
> required by the existing destroy protocol.
> 
> Also wake CT waiters after a suspend completion.
> The queue remains alive until deregistration completes, so waking
> waiters before sending the deregister request does not release it.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

I feel like this is an independent fix (like patch 1) that can be sent
on its own with a Fixes tag and CC'd to stable. This also looks very
similar to [1].

Can you coordinate with the author of [1]? Alternatively, if that patch
looks good to you, could you give it an RB?

Matt

[1] https://patchwork.freedesktop.org/patch/753791/?series=174199&rev=1

> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 42 +++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index f3ba8abfc228..ca24a77dfb26 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -3265,26 +3265,32 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
>  		if (q->guc->suspend_pending) {
>  			clear_exec_queue_pending_disable(q);
>  			suspend_fence_signal(q);
> +
> +			/*
> +			 * Publish the cleared state before waking waiters.
> +			 */
> +			smp_wmb();
> +			wake_up_all(&guc->ct.wq);
>  		} else {
> -			if (exec_queue_banned(q)) {
> -				smp_wmb();
> -				wake_up_all(&guc->ct.wq);
> -			}
> -			if (exec_queue_destroyed(q)) {
> -				/*
> -				 * Make sure to clear the pending_disable only
> -				 * after sampling the destroyed state. We want
> -				 * to ensure we don't trigger the unregister too
> -				 * early with something intending to only
> -				 * disable scheduling. The caller doing the
> -				 * destroy must wait for an ongoing
> -				 * pending_disable before marking as destroyed.
> -				 */
> -				clear_exec_queue_pending_disable(q);
> +			bool destroyed = exec_queue_destroyed(q);
> +
> +			/*
> +			 * Make sure to clear pending_disable only after sampling
> +			 * the destroyed state. The caller doing the destroy must
> +			 * wait for an ongoing disable before marking the queue
> +			 * destroyed.
> +			 */
> +			clear_exec_queue_pending_disable(q);
> +
> +			/*
> +			 * Publish the cleared state before waking waiters.
> +			 */
> +			smp_wmb();
> +			wake_up_all(&guc->ct.wq);
> +
> +			/* The queue remains alive until DEREGISTER_DONE. */
> +			if (destroyed)
>  				deregister_exec_queue(guc, q);
> -			} else {
> -				clear_exec_queue_pending_disable(q);
> -			}
>  		}
>  	}
>  }
> -- 
> 2.43.0
> 
