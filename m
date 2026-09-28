Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D06BCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 02:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F51E10E71F;
	Mon, 28 Sep 2026 02:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cTtFdJFj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F7310E41D;
 Mon, 28 Sep 2026 02:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790562058; x=1822098058;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QRElCKEAL2xMOdrPPAAVi8iKeA49uWHjzY4X2rwJzcg=;
 b=cTtFdJFj1BFGSLMysIxoiZyslMG5RAj6dP6lwc6zzgtoeorwOxBsFMJB
 Z4GMIceyvSVqEj4M7hYmcc27A6Aq86XHsQaRcFaRWTuWeBeJlHGLkVImO
 sc0bwNs1VKx2Z9b3KPJKXm0Zcha8Cnw2q72ih8bC1rmeAoMYEPWg4bLWW
 KJLipC6ijPtOHVQLwiiGbu5Daj9Gzv1oXMMee4TcrwCLpk/7FARiHYIv+
 NomD0iVQxFHxbOOZyVYXdkUmmr7dUz1cpvu103EgA0AV4GgYyu+FabeYA
 MDqQJpVzlkB8t0A9UYL5mL//1nQwrUVGLtE7ax0Dfm7/Pylm417jj6334 w==;
X-CSE-ConnectionGUID: oKGR1ZKdQFunMtBWGXiiZA==
X-CSE-MsgGUID: GJqX6hpAS4yYLy0Ovb9Ybw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90379202"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; d="scan'208";a="90379202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 19:20:58 -0700
X-CSE-ConnectionGUID: uLOvAkYVQY2rSmzNUL1eQA==
X-CSE-MsgGUID: mMOSjs/QRUWX7iUKgiIEUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; d="scan'208";a="272713551"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 19:20:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 19:20:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 19:20:57 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 19:20:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL0lDfSVsUARJx0GebhBE3z9w2YFnMLiHb1ZxePIIdW9LG8dygEFWuB4F5hPoX2Hyo/7OED6lRQxT4pT+ykoVbdYEexEdct/HJdWoKaoXeaDdRxDip//wrbxutf2dt+tKqY1CwSX72bUW3oUTd7BDYuewFn4UO/1u8Z5vcpywxB2j9osUgDXgu8smqIORPMkgmN3Ohxtya+n7UqbOHofwQbVnSgY2gDv/6JBSOQVvaRv4vNrouIg+boio/CUyVxhm8bq7xHMeInLnrNwW/ID8r8GWQNb7LUw0ceGXET1ql1rJ0ya4X/8WB7BO8AVcBYbwYnFJ3gqXs6XtY195hFm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTERZV1FQW9tAPiDj4Zz76jUDeUM1xS1zGPfnw6eDVw=;
 b=pu+jn6Srm3YZt+y/fluDAyQI4XDMdAxNsC8RIHpCPiWIJnMikfoxH/m26gdzQIrXrTgMpKK+DUzMhTIsld9L3feXp9Fjs/TBrPoW6oJqrrqmPMueiPHTaBCaWl6D+ZOpdwLoniZeLJYXoNWs8+/MVxXoy07FjKCsaWTpcFmrVqVLl1L2YDMjJyOzAGFwc1rggejwtVSoLFdmiQuakFjof0oSgdmoibkRS/PlitiiimAMbGe8ZlFzVgwT/1+WlK1x3eJy9i/IbhbG7DLYEn85AeKCDTuMDSlXvWMNTItVrbfmmHDzLjNYZsyGZKzfvtBpd3X4HUiisO5N0ItJ2GI2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS4PR11MB983458.namprd11.prod.outlook.com (2603:10b6:8:508::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 02:20:55 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 02:20:55 +0000
Date: Sun, 27 Sep 2026 19:20:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <vitaly.prosyak@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, "Philipp
 Stanner" <phasta@kernel.org>
Subject: Re: [PATCH 1/2] drm/sched: keep the current runqueue when no
 scheduler is ready
Message-ID: <arnPBVP3cnDNwTMn@gsse-cloud1.jf.intel.com>
References: <20260928020018.120503-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928020018.120503-1-vitaly.prosyak@amd.com>
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS4PR11MB983458:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b37921-585d-4143-be2c-08df1d072067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wMTRyZUi30J89EJQ1HEGkzRZtIZcZzfdi9OPSQPoIrsJk4ls0fVohHxjLn1xancndLfXx0ZqvaHVVZtlyzk3RZkGzlKWDYg8e6MrnLPXwYiGfWVn9DNAWr7v8ZimmzF3L4J/XxhOr0I6NKb6Gs9yb7RQmZsS2CUsHJInj5rErMjA/urvhvDBiB1MqOlmxD3mahsEPIiFZg3wsjEtLt+BTIYNLB9jasc3GeTJbayVxbUX4Be4ntRRH1Ote/ejSxRbBTMUBZhS2xy9W5nJRwk4H+TzSRpZAHJ3wKtP18horTn4hUWj9zPoJqk/qYQTJcBaNt1NVi9F/pSewh9D+qgyt6wmn2gJDXJ5XPcA8i5NPbEDmqeI1jRscJid4g2c30dJr2DJMZK1wIfYu4LGoR+PXtdd0GUcN1b9+fxBrl4yyGRavAPRA0vGpNBynK0UFS/Wop3fiw8fP+o5afcqLdNITPjqlVtA6a31mJTil6XjvlPr3nuDGG+FyM+qidQJSwX3tLHaaBdj7+o2iLztecTyZfe1owkBwCP5NdINHSHGnUSyAxOH+DLC346vW96IiqeJukkzSYyzYufHkWoVfN/p014ct/Rvhfy24lTCns44cxwvJxgYjQoVa0evdQNycdwC9w8+ECfvAIcOntcZwzBAzePkAz8MzGlsdzWrGM7+8/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kx32WX4hqrnwNRfu/w2w9vcY6cJFXVB1cPh5DyYaXYts8XH+KG+tINN7rS?=
 =?iso-8859-1?Q?FmnEyOwBylw1VmPy+3BPd21WDZ4CGoFjyVV2DpNI1U+6U/W/vt6sWVArjE?=
 =?iso-8859-1?Q?dSs5RHrHoQ/iPtgX+I/8PNtKvejPCu1ScRgULFgjk4kaFuybGwfB5dzkiq?=
 =?iso-8859-1?Q?UKbyeroeuMvy01yu7Tj9X5Gm85CB5bfuT+SNTftNG9p2agXhFK33AgZb4l?=
 =?iso-8859-1?Q?KqKCNj72YFpETzgUwdn8e1AXu0qIiIkh9Doc2SpnOsZqU+Eu6MUZrGBAz5?=
 =?iso-8859-1?Q?RzY7aPObivWoNBOikLwO8yIODrZrsRsgCDIPsEHPHVkd73suO7ki7NT2/f?=
 =?iso-8859-1?Q?m6nFDkwm/gYHcvMWsm+vpv6iQjpNP2qkirn+kTK86xpNaT+rx8rjLi+diS?=
 =?iso-8859-1?Q?up9/HH5jqGqzR4NoelRy8Hcx0/xA4TbUO83R+NKevd5p88oBNqsl6iyQpX?=
 =?iso-8859-1?Q?nw9EOxK6CRs+vlMAjJnKY58BvFMs0qYr/J8GP3wDEEhpchqm+gHJP9sxE6?=
 =?iso-8859-1?Q?ehJxFVqZZwe6b9TQYJJqqOlIfiEDeYimoZxAp94QuJEKoiEs7zTq/Faimj?=
 =?iso-8859-1?Q?AINgjQ4zVfsv9Lz/4WDdsdu0zjDy9OQoOpAfYZUCeaNCIIF/frrh5y15Ii?=
 =?iso-8859-1?Q?zT7fyXPHQgu564FnwXxJoCO34RFdalRDufw+YsGkg3BfMr9VwJTOG4t3wB?=
 =?iso-8859-1?Q?UoOEYsKnQKxdfVCS4sRIQVZ5pHm5E5rHcmO36BakIMJilQCkv+BqmCILYA?=
 =?iso-8859-1?Q?6/MWzXd28L5Kpqo6ZRbr11aFOgYmYzLKyMSLrGVhpSHoibj5BhmUMvb/0H?=
 =?iso-8859-1?Q?nJAWt+fTw1/JEy9ERhMGao8U5DkZdjp4FhEiyrrJKi8SGSNW/it2WEsVHG?=
 =?iso-8859-1?Q?lFSb5gC62ds4X02/Txlrf/D6P9dhbB7DO6mSNt3ZVTMfKB90EQG7J6lCuh?=
 =?iso-8859-1?Q?6h3hAxq4D66DQuv3HtZ7ksQ6PuRch7mHyDTxrWecnmwPAiaxIRrHeftWWF?=
 =?iso-8859-1?Q?weD1VP+V7TnPnH1d5gHIIzv2Us+1Qtg0Ap7CrFvKCG8oB2wpKxrJZDeDQ7?=
 =?iso-8859-1?Q?j7Lfwdc7l/E86xyH0x3QnlOnOXH+FBP7bLxffQsrswsFp1qTqcT5q20nC1?=
 =?iso-8859-1?Q?rZtvfIplRxjvj3mDJmul0wmSD7eq9Ukj3pQVbcwfKJZm7xSH97N5LVgV81?=
 =?iso-8859-1?Q?J/krcMT2JE/ak5chTXYX/VMcI3150VFEKK41+YW6pq4NCdjzs/cBTRXct8?=
 =?iso-8859-1?Q?MmE7n+H104wnqm4LCKKXLOzthVI84NBmctWqZtR9Tb0vlUvOn2afdFGABE?=
 =?iso-8859-1?Q?v9cfsjd50xoT+OcQegil7MsZl3bVtpR4vYOuQWhlmhF97f5rKxoACgyBx5?=
 =?iso-8859-1?Q?kyHFsuYOkM/QnltWMYzwMaSZoiWqUA5bZfZGwzAgZEUc9Xui4NhbYBs6pz?=
 =?iso-8859-1?Q?AfRMy+BHqlOq7O4lPqYMQRYw2hV+abpw0Ue8jznr2Wevv+rNsphEPMrLMr?=
 =?iso-8859-1?Q?FMZTXNBJNXQ23yR1XK0r8r8ND8ZjGp2Y2FG9t1fz2t2eXhrJ1C/9mSP57M?=
 =?iso-8859-1?Q?BzrBm8xsMFXQXig3rrCAal3RwzLEoRTljoqvInYxdVFqqjx5lp80e4kZj0?=
 =?iso-8859-1?Q?HsaY4q4vvwOG0tUqnkCuiPTRiP2KeJkKgKl71HkhJrCxDU+mUftRUAUjfg?=
 =?iso-8859-1?Q?7m8nzikRYJybQeDerLtOylMyYvb+Sapzh5WLYGvTSOvCSWuVG9l60ea/a+?=
 =?iso-8859-1?Q?PDQE4MKbinsl8Z1YxPv4Eq5k1YBuz0QuM6HE9u5HwGlC0lna9klCJnZA/M?=
 =?iso-8859-1?Q?5Mat504DQQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: C+onF1iBBPLhU/xUpli3FKv6/KhsVq1hvCgz/SomcBYs3pdWVRGdtJmoYPacV6nMgGY2MSPTyWkk2XeLaS+tfMXwnpLuekwVmNi79QSD3LXdk9TohCbP1nNOkEVJU6Hgh4tuPFpryYp+ZcFM8ijY9soHTTOhQuadxVeuEhIkcftB+XvbzE/9jGXpEYm05IA+a3k1pdGVoykv2XrW/1HzWtSV3S7Nayqh4QBaPw75/qoH3I8INPTsGjiPh7fL/5YSw3/qA6VPi+j60iyw6pS39n2C3r+HjRHjTz1clkWp3p5Uv654fwZrkqnR+Gj46rbT9kIGkK2ZFNe0G/VG2gJnOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b37921-585d-4143-be2c-08df1d072067
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 02:20:55.6849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccH7j8AE6sjNMjx9K33+zdxv3Zp41SdEboXpUmebfm8xHo0yGTwa2id/eeB/Al/JaO3T6EJYNLzJ1LgG33ZV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB983458
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

On Sun, Sep 27, 2026 at 09:59:02PM -0400, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> The IGT amd_dispatch test exposed a NULL pointer dereference in the
> AMDGPU CS submission path when the GPU schedulers were not ready.
> 
> drm_sched_pick_best() returns NULL when every scheduler in an entity's
> list is marked not ready. drm_sched_entity_select_rq() then replaces
> the entity's existing runqueue with NULL.
> 
> A subsequent drm_sched_job_arm() retains that invalid runqueue.
> When AMDGPU CS submission calls drm_sched_entity_push_job(), the
> scheduler pointer derived from entity->rq is invalid and the access
> to sched->score faults. The reported oops shows the sequence:
> 
>     [drm] scheduler comp_1.1.0 is not ready, skipping
>     [drm] scheduler comp_1.2.0 is not ready, skipping
>     BUG: kernel NULL pointer dereference, address: 0000000000000268
>     RIP: drm_sched_entity_push_job+0x4f/0x2b0 [gpu_sched]
>     Call Trace:
>       amdgpu_cs_ioctl+0x1e9e/0x2530 [amdgpu]
> 
> Keep the previously selected runqueue when no ready replacement is
> found. This prevents scheduler selection from turning a valid entity
> runqueue into NULL; it does not make a stopped scheduler ready or
> guarantee that the submitted job will execute.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 4ebb513255ed..b11e1dddabd0 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -584,8 +584,8 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>  
>  	spin_lock(&entity->lock);
>  	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);

This entire thing is broken, badly.

So I assume this pops too in drm_sched_pick_best?

 969                 if (!sched->ready) {
 970                         DRM_WARN("scheduler %s is not ready, skipping",
 971                                  sched->name);
 972                         continue;
 973                 }

To me, this looks like a lifetime issue that should be fixed in AMDGPU.
Either that, or we need to rework DRM to have proper lifetime management,
or, of course, just deprecate drm_sched.
 
In other words, we need refcounting so that drm_sched_fini() cannot be
called while jobs are still in flight, nor can jobs be submitted before
drm_sched_init(). Alternatively, drm_dep could serve as a replacement.
 
So this is a NAK from me. As it stands, this is papering over a larger
issue. You won't hit a NULL pointer dereference, but sched->ready on
entity->rq will be false. At that point, what does sched->ready even
mean?

Matt

> -	rq = sched ? &sched->rq : NULL;
> -	if (rq != entity->rq) {
> +	if (sched && &sched->rq != entity->rq) {
> +		rq = &sched->rq;
>  		drm_sched_rq_remove_entity(entity->rq, entity);
>  		entity->rq = rq;
>  	}
> -- 
> 2.43.0
> 
