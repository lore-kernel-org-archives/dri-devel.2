Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90E1CCA490
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA14E1129F8;
	Fri, 16 Oct 2026 22:10:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C735B1129F8;
 Fri, 16 Oct 2026 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792188637; x=1823724637;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+EHAeMopH/OmSIKzG6QsAYtC9ISzW1N/Kl/FSuARMto=;
 b=d8pInGLWlY0H78BToBBsDA8j2DvG1zh8LNavyZbXTi0j7a5+u2wIQPr4
 BQlnX4i1a2rA3jLrB2NT0VZkpuBBylSbi6Iw31OOL541Y71pdekxFDEQk
 V7E1QLqza9W3Z+gGs8mXENRtx8bNjJoEe8ExBBgkgM9qO5Xoh+y+kFEfk
 n6zFsNGwTih3MQuuL6po32wnFOXgiyFJ61UTpT7bv29pWXVQdCtZ4pEXP
 wQvVwp3mqkqmHdN2ER8EpU3L+y5EUZl0AUL7WYyYQcafNsWKMn0oVGV32
 1J2TstzkHrqT9OSGdL98QADxd+yhwl+99/dXmj1uADt4H26pQRl8+kuA/ g==;
X-CSE-ConnectionGUID: 303+PUqyShqC2+YW+MlsPg==
X-CSE-MsgGUID: S4ucYf6aQe2pvWWSgu7KoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="870374"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="870374"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 15:10:33 -0700
X-CSE-ConnectionGUID: F4bwbbFcTyitXXqvxhexww==
X-CSE-MsgGUID: Iz+P6h7wRLmnUqiyyxWQyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="3796828"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 15:10:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 15:10:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 15:10:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 15:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6VYSrCX000li7Ig2YFcEvt+fLqOhuALoOk02Un3g9OeqT6SE4k2kY2wKJlT+ayTkwQod7IlJOH0ohmjzWz/M63WEQcy9BCH9gWXLJKeP7cYcTTYklaToQdtw5lKz1f8imygaT1Ls9heUbJ3gjziixQ39s0ONDNiOBohPwOgymyH6uHlr50DMq5JmgEmOGCv+bORd8iWKxuGgckxxFt5QfF5tWQs/wzM7lR2ZdiEKRcxNAqCJGtg/NT4GRSUug1ap1LaRCeUZlHU5apaiz6SDooNGS9Tf7thPYNfYG7QDqoYuS9tPJSvE8UBy/dpHxWw3Jn5LTlr6IdTK03HxMT5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMN1uZp9WzqcswZ+cu/AvGha5Z2z0OviDMlYQxqSHUg=;
 b=iQ7SgMeq+WTzGt1RkbTli+wsnJDOh4RmbEgoAHVIU6lwEYjXXQZb+Od9Bl+/WB/BPzI+u1sF1NlBuyjjdwi+7q7df3YdoNQptJ06J7os9hrwFyU5+pG0H9Veath7Rz+bhQ6zXipb5n7OtP5f3nVCOi5vA2fQT1xshqtyHxfufKM2UcwGLZQG9K739HjARQM5/WiT2YGYzhMjeEyAPnNH8a2+SIa9nlwhWsvM4d/wWt8j8aUbfyNjDiEyX75nu7DLDzMoJpi3GKktpF4zvMDFeakPEe6edbdlhxHgb1gzkpvfncnt4L+CKsYQ79b+teufsfoliUY7qb+2wccsUafnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by LV2PR11MB931619.namprd11.prod.outlook.com (2603:10b6:408:417::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 22:10:25 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 22:10:24 +0000
Date: Fri, 16 Oct 2026 15:10:21 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Helen Koike <koike@igalia.com>
CC: <rodrigo.vivi@intel.com>, <demarchi@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <tvrtko.ursulin@igalia.com>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [PATCH v3] drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET
 programming for pre-Xe2
Message-ID: <20261016221021.GC1329272@mdroper-desk1>
References: <20261016214112.1647202-1-koike@igalia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016214112.1647202-1-koike@igalia.com>
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|LV2PR11MB931619:EE_
X-MS-Office365-Filtering-Correlation-Id: 776b6394-54c7-4a8d-68cf-08df2bd246c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|261009223027099003|261009221227099003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2EAkPMx4ftQ7+gNh4OwLojS9avDD1OrGe36m0+HWTv2DpBF6ocClGMBiCmaOEP/D125nFb0bgT0J4Aw5FEzlBF2Y8bGLBI1ThjiihWgaCGB5SUerO3FTSHhvcByO63HASvJu/F8yfUX9B27Jv14NNR6FNwECxOYxF4hP+PtUWs9bVvzPKxE7T116qZkUQ9EOGIZgVrHjgcy2ybyjGi0e7gsF4o/CfwB1feFaAUyRHaC2nTfn/89Svb+TVPG0gqU23NJGP+YhuF3gm69tEJESibEImGGaLk7XlVkx4GABG845WevHIHY32Adj8LfZmTBT4eykePrWxSsTfqklKLVK6BuOalqiVzOAKdKI1BUe4yYo9H4n0WA/NBAC8Mz0HY9psfZ0i+YjI3H2fNoC8HRHpbEMnx5dfZCby+wyqeyHz5JavU38dZpPGeAfWhrOMsu7/GK9wJwIuCnnn9ddKUhtnNJ0KqYzYLOgrGM8RDkUsY6Jd3Mo0ZL8ZtI/YMPMIVM/Fo4V9XzTHYQtAaWwaNpUwCP4Zu71jxBRMb/BhALsT97QUfl/mx9wJE6Pj3poOo/NqYLdm1bx1lOjeK+C7cSs/qLTGJSyxYyhHTIgDMIRNyO+bqvppR2T8zV2H3oVa6MGrqmnvvkqndLlczvllsa15FsZSSyBi7YcMwWmdUGRudQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(261009223027099003)(261009221227099003)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9fA22hd8LR7tSYBCZPA63XFA6u46lA1uZn3RSBZ8bgGFSoL4KXKeL3Eiugp0?=
 =?us-ascii?Q?T3019FhqCDu18rgPoW0gFjBTBouwb6MMNs7a2YNb+9Kd+40+0/iFP4vV5EBY?=
 =?us-ascii?Q?U/gBQdjfqvU5Ipjci8OWqI0nadpNSLYgdJn5kmvpRtS68YMnO/NLvV9BkOwQ?=
 =?us-ascii?Q?8tV0DAwPfDgJ2pnv9TdvQI3BIatx6tR4MQdKmXx1vnxbwnZKnTNSY7bgGn/L?=
 =?us-ascii?Q?l4Lzistgc0PcpveBBb73uJLBY/rEIYAfsbo6qWj097T5OB+hAZbJjCaCgW07?=
 =?us-ascii?Q?68pH8QcPlNQsTY0Dds1VodjtirAeqxbcJcDxgMZN069drHzAF/6YZGf5bZGd?=
 =?us-ascii?Q?L602+4LerhpTrktEU4IqJZTTbCwRcHfqQzgBHMeOMh7Rn7kiV3+KuFfMxiYB?=
 =?us-ascii?Q?n1u7hCeITfCxh3s3/wG4GsM4PyImBjc3kZuveQ9rcCoJponEruuh44K2ts16?=
 =?us-ascii?Q?bQZ5jzGXKv+y7AZDfmerstDrsYAoB2o4y4DeasT+cS6fT74t1+08KSQkQYvv?=
 =?us-ascii?Q?H5kxJtSal7dDTFdXQxEJ52unVONpFRbyokN16aqlFoQY8QUuDuaEFDmu5ydn?=
 =?us-ascii?Q?2QrC2Coo8vSjVe+HDP/7BiG4QtepFkiStlgPeaLeR3uc9cxGZTnGCVHd+9Uy?=
 =?us-ascii?Q?NI/DRug+uBWL+olmxvszPkTVqxcYaQVqlP1yL4B9bSdlsgPQS1fruF/18zsr?=
 =?us-ascii?Q?Ibd4mnBUVcxCTzDCTsFFIFZn9e6n3LcgH0WKO24NRzKbi8vpA11EjYtwWTlj?=
 =?us-ascii?Q?T+3GcomzfX/2vY2QZixr5ZIttBzrtzqraWmeTCBGBOfJJ9LtOVkseQ7/sIW2?=
 =?us-ascii?Q?2JF7Vma3vWIzIQlqsTowE5aplIHmm+dr9eDmpAJHuG87K+qPMu31hJKCNATs?=
 =?us-ascii?Q?ukSRWYkLSKyW9ZH1OI9VrngPc01Uif3qHDSZNH4DF6uUrZPSRHEmWyi27cJ3?=
 =?us-ascii?Q?t5DkOnB3cHgM5YQP7O3/lskY+jBTRr/yhg/dDwQbBh89NWEPxEvSByRake3M?=
 =?us-ascii?Q?zyWfgJfxLLFdwx5HwpOXbOFOyieeYCGr2ec/vEJt0iWM9vJCxoVtSQPH8Cke?=
 =?us-ascii?Q?R4OukJoTDPtZFHcZb19mh2WUdo0eVSmDWYZjG9N31qsnbbNDISn3xJApXvFX?=
 =?us-ascii?Q?50fD8WFrd9uw4y8s47lUEv4EXoO3gVsKaRimxt9oJMsBzAPUk3LH7iokfXFC?=
 =?us-ascii?Q?QymQZZblqgfDpqPJDHylt2V7pVyjlYTaRQOERxyVBV6Abz9qvDlpNAhD1BR4?=
 =?us-ascii?Q?jTsefaugk1kVC5tce6NtsD+W9IX4QfA8VNt96cZhBTS/kFsL28v4TIquhBsn?=
 =?us-ascii?Q?CcWuGJ0nbhH9o/iCIA3YNI0yXx4cyJK1bJVWthzKI078cWO8NFJy43J24QAP?=
 =?us-ascii?Q?DkrO/eFdC56BQyHzRV8fy7DlLV1e5aIeuPEKfkNezsDhLs1jcatiN5Td/73H?=
 =?us-ascii?Q?KIsU1NuSEOZViANEMGTxHAEzWwoP8NIOQ9IWIVmcS6QH4OjaXZeEpsKF72cM?=
 =?us-ascii?Q?6bQujR05X+n7pytCz+E3ZdIZyi72HTjz0Rt0ObfeMNr7NmHAJwC3IIbyyxjT?=
 =?us-ascii?Q?YbpKUp1tC1rPStvlSXYJIlLPnzj8bT7ivONBZUJ3iBGIDJfvvd7ftZmWXE8K?=
 =?us-ascii?Q?wWQ1XflpMAyAjPW5ZbarC6DrjfdnOe2+1Jw9HzOvKwcZ1h0jpt+auaXW58bb?=
 =?us-ascii?Q?Yr7mtGc+s3ok9ABoqQpJPAtXC014Txt6kOA9DsURfBdCSlPh+f+4F1PZkmn+?=
 =?us-ascii?Q?O8VDHqC/8K0AqHMEgvlRGb8ypLJd2dE=3D?=
X-Exchange-RoutingPolicyChecked: Jci8SQy86KDI9lPRrjVzXl4cyDGqN3Tg3sDS53CcsSV1S/weqD4xi8912rYggXGRZtIpRIlS2SnGy41NZKN+lpYefcjuHZO4NvyZbhD9SO6iqKouptrBq1+CW0SuviTaDLUq6RyjiEiKh2QH1F4/CK1Bjf+iWBrzuPeHRfIz+PfPXuwnRqqls3OC7KJP1VsZ9bF0pGsAz20pZhZfP4Y+s258xcez4WdA88RqETjCq3A/JXYCVGQSX8aAnODRy1FrL1no8M5tHTPurg7W37cav4XNlqMVw9X7PBHH4c3nmTf4pH63sL+C280TPrHEucxWksk4vDtE3DVKQrBQVl7bBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 776b6394-54c7-4a8d-68cf-08df2bd246c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 22:10:24.5231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZkBXA5tp7lgsexoJ0gSQAkcd2dAIyw5FK01ZtYNivy5uk3iLJ9ySBcqGYDA6qwwiRBW64PQKIeFZ4yZt/FREk9/cdmXgBrEdHDMPzXXB0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB931619
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

On Fri, Oct 16, 2026 at 06:40:50PM -0300, Helen Koike wrote:
> CTX_CS_INDIRECT_CTX_OFFSET default value is not retrieved from the GPU
> by inhibit+context save mechanism since it is not part of the Engine
> Context. Thus, at restore, 0x0 is programmed back to the GPU, which is
> an invalid value according to the PRM.
> 
> This causes sporadic hangs on Alder Lake when executing test
> IntelAngleEnd2EndTestCases (error VK_DEVICE_LOST).
> 
> Fix it by partially reverting commit c9dfd66cb91e ("drm/xe/lrc: Allow
> INDIRECT_CTX for more engine classes"). Re-add the programming of
> CTX_CS_INDIRECT_CTX_OFFSET for pre-Xe2 (in theory it should apply to all
> platforms, but we got an unexpected behaviour on Xe2 that still requires
> investigation).
> 
> Fixes: c9dfd66cb91e ("drm/xe/lrc: Allow INDIRECT_CTX for more engine classes")
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Helen Koike <koike@igalia.com>

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

> 
> ---
> 
> v3:
>   - Commit message update:
>     - s/programed/programmed
>     - s/for ADL/for pre-Xe2
>     - Add sentence saying it should apply to Xe2 too, but we got an
>       unexpected behaviour and it requires more investigation.
>   - Remove comment "Enable INDIRECT_CTX leaving..." since it is wrong.
> 
> v2:
>   - according to intel CI results, it seems that this default is not valid for
>     LNL and BMG platforms, so limit the change only to ADL.
>   - program the default only on ADL.
>   - restore the comment, but add note with exception for ADL.
>   - update the commit title/message with "for ADL".
> ---
>  drivers/gpu/drm/xe/regs/xe_lrc_layout.h | 3 +++
>  drivers/gpu/drm/xe/xe_lrc.c             | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> index 4ab86fc369fd..e4c7c3549735 100644
> --- a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> +++ b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> @@ -43,4 +43,7 @@
>  #define INDIRECT_CTX_RING_START_UDW	(0x08 + 1)
>  #define INDIRECT_CTX_RING_CTL		(0x0a + 1)
>  
> +#define CTX_INDIRECT_CTX_OFFSET_MASK	REG_GENMASK(15, 6)
> +#define CTX_INDIRECT_CTX_OFFSET_DEFAULT	REG_FIELD_PREP(CTX_INDIRECT_CTX_OFFSET_MASK, 0xd)
> +
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 35b4e8289b5f..18f247bc8865 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1449,15 +1449,15 @@ setup_indirect_ctx(struct xe_lrc *lrc, struct xe_hw_engine *hwe)
>  	finish_bo(&state);
>  	kfree(state.buffer);
>  
> -	/*
> -	 * Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at its default: it
> -	 * varies per engine class, but the default is good enough
> -	 */
>  	xe_lrc_write_ctx_reg(lrc,
>  			     CTX_CS_INDIRECT_CTX,
>  			     (xe_bo_ggtt_addr(lrc->bo) + state.offset) |
>  			     /* Size in CLs. */
>  			     (state.written * sizeof(u32) / 64));
> +	if (GRAPHICS_VER(lrc_to_xe(lrc)) < 20)
> +		xe_lrc_write_ctx_reg(lrc,
> +				     CTX_CS_INDIRECT_CTX_OFFSET,
> +				     CTX_INDIRECT_CTX_OFFSET_DEFAULT);
>  
>  	return 0;
>  }
> -- 
> 2.54.0
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
