Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7759606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kJKoOIKc;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NoON0QAH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E704610ED39;
	Mon, 23 Nov 2026 11:18:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B6810ED38;
 Mon, 23 Nov 2026 11:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795432695; x=1826968695;
 h=date:from:to:cc:subject:message-id:reply-to:references:
 in-reply-to:mime-version;
 bh=sBs491M30YvHLQ3pEnRfVVHpRb7cbSY5OsFG/Ee9F+E=;
 b=kJKoOIKcCaMcQnqFlaV+KUbwP3HYqPBOTkWsbAuIqq7hyMYTwgaKfCb0
 +qWm7zLiXFkkPCJNOs5qwcY7AMA4VaUXs81Q1UBCfTu2IaPtdgblvYRcG
 5A89/hc9VS3jaEU8MySent7oAva/IS63Qzf0YmqWQrupptvBRslbliwo2
 xuMqU23fbkGsJdlqZ5uozUrX6d+KSTqhf5IS551lk7x7NzjmIdcZxGWK1
 bOCGX4KptazLFSqJQvcg2Jz9hoUEVhARfUsApYbOH+KdVSoXfPTboD/gz
 wpe/HFa6ltUEfkXryfIAoqNQY+zvDlLJQgLXlhfVCEMnvSLvZJNXJrLHK A==;
X-CSE-ConnectionGUID: Hp2Xj62yTp6kWNwZmwW9mw==
X-CSE-MsgGUID: DNXsHwaIQb+XYaqSAIeSqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4245582"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4245582"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 03:18:14 -0800
X-CSE-ConnectionGUID: vQY7HqPAQqWhVfNqFhNN3A==
X-CSE-MsgGUID: j1Eh0xHdTZWhuw3YkQUeVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="13074997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 03:18:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 03:18:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 03:18:13 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 03:18:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kybgBiuyhklLvBjdklnVbrqFO0xuLNkJ3PQUKpt4wrOwesLIPz40kAmePoDVkQFPZrZW0YdDpWJ9tIO7yZtxW/YoN+3jSrfhUbXaRsAeDNbxgxeSoGxyd1G20R3fc+hPlLLxJ8wSgLoqqpmkDf0vIJ62vlRTb1+HNuA1MkXvKf+lXEPrAc8Bhw5gAcgKwaCsM4I9QnQ+7gbRCjSMe2MWCItsNtBiA5wWfjN8CPIi/rQvsMwUYAr4JTUsJGlJobeV1f3U4SpSQTSdWVHOJeJFFK9OBhLX77mpZpKaAFm1DDJVgO5GlAPK33ZmqcJ5g1q4Bjvh9xPd9fPhDR4UVcQivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4ULjFrvgILOnOcnkHq/coFtx2AA45DNssqouzD6esE=;
 b=PnZQpL3NaARK45gCCYcC3yyDwQcb5xREeL6mtwmKjDKymb5x8g0jns4rkEBDIMMfgXyih866L4zSV2o5OLnbF+lFctgCFjhVYjeoC1lV6e0vU2fMkLdF73DOQW/VtDNSR8voYbFfyDgWFA8GPH1VN0iUgilkVKX7SBkneRfdAvRLIhnrpvuXWbm8ZSlLdJ1KButBt3q74uZgChgPHHc2E3WK0bwZfZIFhATzmhNlEh5CEoQv457Dh51XjNNp89/0m9Jpfjr+eAHAzGMntyu/c0EJaYhFXCmS7vqNe0zIkEb2/BylyuwzoWGFLhFUQ0XPQnMWL9HgFyAR22X0xkLPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4ULjFrvgILOnOcnkHq/coFtx2AA45DNssqouzD6esE=;
 b=NoON0QAHS7Dw389TO9b2Kx8Qg7ai4yBJzJtZGcDUSlXNROy8x9aWepskewPD2Buv0x7mv7nliLFOQlshUd8wgXQUxyDbnWhAEktNKEvikoRNVa2IlBfwT1vETXC4MZuQ56pjiKczdsdP7q6/P13vgwdkAH99gODuzD+MnEkoEz4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 11:18:10 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 11:18:10 +0000
Date: Mon, 23 Nov 2026 13:18:03 +0200
From: Imre Deak <imre.deak@intel.com>
To: Frederik Schwan <frederik@tty42.de>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <regressions@lists.linux.dev>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Dave Airlie <airlied@redhat.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
Message-ID: <awQg61Q0leUUP3yH@ideak-desk.lan>
References: <aveDNRBLx1a-9hRQ@mail.tty42.de> <avsSK1OE97meC40e@ideak-desk.lan>
 <avtDzWO1sOXYvxZ2@mail.tty42.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avtDzWO1sOXYvxZ2@mail.tty42.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GV3PEPF0003D753.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::414) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 24519d34-53f7-4f1e-a7da-08df495374a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261009223027099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: j83Uxk8dgKSiW+GvkHSEfC+sVmt3oXRITQ83K+yXTde3uyhXozQ91/6LEirDmqSbkNyOA+I20+mJ03Da8tgTnYx7dIKa8AicB0s0pQQTOX1Fdy64RTvZSHxj4CiS0M/1WS8Kp8XbhD+yZe79fBLyjGlgDOdeFOPbWOke9jvJDXORrPDsch8/QctgjgSXf+dg1bDgVOiblmZRuNy2sGwAzLgmXSGQnjvnKba9cbPXfLWMdF77sHJJe9l8v7zHDOIEFKf02JF7lOFo9KN+2KzVyx0Itb3dk+1OvtZAcgmdjH1dJdui/bqDRA0kHe0YyosqDMOZ5codCO7fOfZCpNfVfvyi1mrSQfcBgZiJiEwnmHs7ZIgmZMhdSyyfvMnOC/RB2dd/uf79xI7yfP+D4URzpWjVIBe/YflQ3Hrvb+u45pFr5XQg8+M9keT2JaFV/q8YDlOPl3FvJrz7jXWL4FPQQm571IhkjKJL1GDNUZj9FASDpIIax7lMjjLBbg+beN/GR4OuDYaB5yAJUaYTXCd9F2gS9J6KsxSM2g7QAOanMpQAV3ZhA9KC9CCgmBwCD7+/03pwUMMhND9GurBGcRfcRVj9AqcNa7EnO+gPfHHBtqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9273.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z2y+Z94YaFOFrOLfdpwALzMB5u5uKUFnviKHBLjeXqP3GXuCQHJbGjj2WJKD?=
 =?us-ascii?Q?+5rK31NWR6uK3rGEEQQGdZTqixAfMwr75nwRjfOAIPnEDqDbpWhciIbKAHRh?=
 =?us-ascii?Q?7rxFUgbTkp+AAcUxMe5w4GvAM+jQuY7FbRhjaTAtEJC0NJjmvAcivAdljLwM?=
 =?us-ascii?Q?p+NCvPunlUToqxibl8UE1YjZd+hrMU/A09i4yG41O1uwVxLP3DltqSeCFZSR?=
 =?us-ascii?Q?bYxkc1u1yyvvskjiOR1R0fqLnIfTlIxjDD+QL2t4uAb4ut5IBccrF8IL9rhU?=
 =?us-ascii?Q?3qoFFTB4gpQmHdw/rXoLnsbw/3dfOpgcFgFT+5omPLBdZyN9rA0A1B8aDY8x?=
 =?us-ascii?Q?H8/G9fmG1psh/vLGku22S/ZdUycefI/Q1NAnMD/Mcq+VuZ9ab32l3dL8cRyB?=
 =?us-ascii?Q?ilD/1jzVfPcZTtrGVWUAysMxWBCPjzE5Q4fNYX2MCsd7djR6ol58QIZXvMlE?=
 =?us-ascii?Q?4TfTYTxdEuj2fo2uLSTmcyb9Zsxgi3u+N4hPcXnVG3dYUgkSMGp9sUQ8kAW9?=
 =?us-ascii?Q?TvofKQUhfC7CzFHmGC2OeLpzEcKfGpO7IisdPAq+rTUmezet4OU61IcpTDA8?=
 =?us-ascii?Q?QeBK6EcHFzSUVrRg6/ZPsj0GhEzPmvikxaKiUUOD23SpSYHuj+BaPJO/337t?=
 =?us-ascii?Q?OR05k27+TwOc6PIvTINoICeCEnfHoyhTODYt6GQuf5ntJz0ooV0ue5N3CbRD?=
 =?us-ascii?Q?Gr37/xvH9sQ/rGycXkY9WNZf84J4lZtsPqM+xUMKdhE3o6HIra/cRsBPKeMB?=
 =?us-ascii?Q?0E3tsHhrN3Kcz1z1ATprNTraewie9jL4mjoEb46s+vGAUordYncQXgytjkvq?=
 =?us-ascii?Q?wbCGmKnvALvBI1kJdRLkmqE8nOqr5Tm6OF4geqlfT/wmUMqtsnkwiStXtXJZ?=
 =?us-ascii?Q?0asF8pxo/WMVOWPRtsS3664FcYttKHmmjmuQ8Dfkbve4YtdGDKpDykYrAcLp?=
 =?us-ascii?Q?NqQ1Vz8xxo5mkIY2kr8SHItvEMpaOsrRyUPmXorFYd3/5+Nxa0ZFfv3RbIq2?=
 =?us-ascii?Q?qtu6Ol0wZi4xgdhzD0X3evA4b2+NNSP6tzrENm3cDaBfueMUTkZvsxDl1aBJ?=
 =?us-ascii?Q?XsyGcYCoQglkTHjgLtjn23fbcn+KcrqtiEqpdTo//kzECYah0eEN0e2+Dzoc?=
 =?us-ascii?Q?5tEMcih7ZBDpmOkzruIs/RDJKIMdR2TZiMvk+9JvJ41J8/IeV+1xMs4uINau?=
 =?us-ascii?Q?GdQr5s5Ve1DsdftFSYgfuG9Cg/vl9y2grCTdicJr1sxXWe6nI5Ep+6+egEsW?=
 =?us-ascii?Q?3kXl2kTEkAYeUN9G0r4YDV3n6jZGy/5cJOo+CXZJw/iXhvHAIurSRlpHx55B?=
 =?us-ascii?Q?yh/TO4Gry/mrQDZmzJS7UswS+18XpO9RahnaQ4lQeYmATQhaBw1aApnzdIUb?=
 =?us-ascii?Q?1xWV8peUtoZZHP4Aj3w6enWduS6p5fNpQNi/Pq+rnYNg2E14rQeQ+/aD0Sr2?=
 =?us-ascii?Q?Ay5Ez7nvtDqH7cg+FzmMJq4EgBmUn/7jzQ5O5Uc5zXiI52Pj9Xj7TlML2juS?=
 =?us-ascii?Q?L4Dhx3Zw9MWIkRWA21k+ZdzlRHshmX80dnohk8J41i1brgHnsMpSAlStO4+O?=
 =?us-ascii?Q?M0SxgH6o3EaRornFFWg77uUMtfH95v0FqR9/Kx1v0E+OhNZU1MIxAWN3m8Xf?=
 =?us-ascii?Q?AKUjES2lll+aaNb1IdYqZy9JK4CdNZrl4S/x8TmHt//YlTYVU+nK6CPQyUeQ?=
 =?us-ascii?Q?Ca6GukzRl8n1Jrh1Y+ftrSd/nZiq6Ibhg+9l8AU1CEGS7btUl/Ftma5dUSfP?=
 =?us-ascii?Q?I3LmKd7UKg=3D=3D?=
X-Exchange-RoutingPolicyChecked: IFC6ehDquZcLP5JxBk5LsW8NgwEjp8xDZG3rWOpiIlQMowrS/Hx7u0NyUqVmofv8/RPpe2snGYfs2nGHNjfYUDr0UqjcUGjSuVc664QOYaQEHE2L6TVnG1yD8hlBu1t3O1fKJuch7sQxX4JWKpItgxUs+jgrWyfnuk4IW/bW0FDbUx2SGnVaVwJW+54yPCLe2b3JYmelfhsv3pfF/N9TwUL/I4INlkioQX3O/KZz1VGnJddqhu1UN/dTavFRcCVnFR6JbIRal2X4e3KY1hcLPKgvGFnLxJURd2bCFXaJuot/az0FK5Wn1GBRiJJNFBT8EvfNYVl9E33dWVRlxdBL+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24519d34-53f7-4f1e-a7da-08df495374a7
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:18:10.2365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVHoZVb9ZK/uVqA6ZhxKf5lHTfcPiI0OdPVjJsTOmWHtMB/11Im0nWuX4YK8NLkdMUH2Ioh0Hb5Dzu+UXH3z1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: imre.deak@intel.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 07:08:02PM +0100, Frederik Schwan wrote:

[...]

> From 55a68a5e094557572b278fa3193d36c147f63612 Mon Sep 17 00:00:00 2001
> From: Frederik Schwan <freswa@archlinux.org>
> Date: Mon, 16 Nov 2026 15:38:15 +0100
> Subject: [PATCH v2] drm/i915/dp: Fix source PHY updates for UHBR links with LTTPRs

Could you resend only this patch, using the above Subject line for the
email and making sure it's sent both to the
intel-gfx@lists.freedesktop.org and the intel-xe@lists.freedesktop.org
mailing lists. That ensures that we get CI test coverage for both
drivers.

Thanks.

> 
> 128b/132b links use LTTPR-transparent training even when LTTPRs are
> present. The DPRX is trained directly in a single phase, without first
> training each LTTPR PHY separately. The source must therefore program
> its FFE parameters during this DPRX training phase.
> 
> The source signal-level update is currently guarded by
> intel_dp_phy_is_downstream_of_source(). With LTTPRs present, this only
> accepts the source-adjacent LTTPR PHY and rejects DP_PHY_DPRX. That is
> appropriate for non-transparent 8b/10b training, but skips the source
> FFE update during 128b/132b training. This affects legacy and DP-alt
> port modes; in TBT-alt mode the Thunderbolt subsystem owns and programs
> the source PHY.
> 
> Program the source signal levels for UHBR regardless of the detected
> LTTPRs. Also make the per-lane capability check used by
> intel_dp_get_lane_adjust_tx_ffe_preset() use the source PHY's capability
> for UHBR, rather than treating the DPRX as a separately trained
> receiver behind an LTTPR. Preserve the existing 8b/10b behavior.
> 
> Enabling UHBR tunneling exposed this older bug on a ThinkPad P1 Gen 8
> with a ThinkPad Thunderbolt 5 Smart Dock 7500. Updating the source FFE
> presets restores four-lane UHBR20 training and both DP displays.
> 
> Fixes: a421d8a99216 ("drm/i915/dp: rewrite DP 2.0 128b/132b link training based on errata")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/regressions/40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com/
> Assisted-by: Codex:gpt-6
> Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> ---
> Changes in v2:
> - Explain transparent UHBR training and legacy/DP-alt versus TBT-alt modes.
> - Correct the FFE preset-selection path to use source per-lane capability.
> - Point Fixes at the DPRX-only UHBR training rewrite, not tunnel support.
> 
>  .../drm/i915/display/intel_dp_link_training.c    | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> index ac1aff6edf05..1efc78b329a6 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -773,11 +773,14 @@ static u8 intel_dp_phy_preemph_max(struct intel_dp *intel_dp,
>  }
>  
>  static bool has_per_lane_signal_levels(struct intel_dp *intel_dp,
> +				       const struct intel_crtc_state *crtc_state,
>  				       enum drm_dp_phy dp_phy)
>  {
>  	struct intel_display *display = to_intel_display(intel_dp);
>  
> -	return !intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) ||
> +	/* UHBR training always adjusts the source PHY, even with LTTPRs. */
> +	return (!intel_dp_is_uhbr(crtc_state) &&
> +		!intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy)) ||
>  		DISPLAY_VER(display) >= 10 || display->platform.broxton;
>  }
>  
> @@ -790,7 +793,7 @@ static u8 intel_dp_get_lane_adjust_tx_ffe_preset(struct intel_dp *intel_dp,
>  {
>  	u8 tx_ffe = 0;
>  
> -	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
> +	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
>  		lane = min(lane, crtc_state->lane_count - 1);
>  		tx_ffe = drm_dp_get_adjust_tx_ffe_preset(link_status, lane);
>  	} else {
> @@ -813,7 +816,7 @@ static u8 intel_dp_get_lane_adjust_vswing_preemph(struct intel_dp *intel_dp,
>  	u8 voltage_max;
>  	u8 preemph_max;
>  
> -	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
> +	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
>  		lane = min(lane, crtc_state->lane_count - 1);
>  
>  		v = drm_dp_get_adjust_request_voltage(link_status, lane);
> @@ -1021,7 +1024,12 @@ void intel_dp_set_signal_levels(struct intel_dp *intel_dp,
>  		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
>  	}
>  
> -	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> +	/*
> +	 * UHBR links use transparent training, so the source PHY must be
> +	 * programmed during the DPRX training phase even with LTTPRs present.
> +	 */
> +	if (intel_dp_is_uhbr(crtc_state) ||
> +	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
>  		encoder->set_signal_levels(encoder, crtc_state);
>  }
>  
> 
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> -- 
> 2.56.1
> 



