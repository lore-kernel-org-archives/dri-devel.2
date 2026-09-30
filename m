Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C784CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC7610E814;
	Wed, 30 Sep 2026 12:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="if9j0aZn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD4010E814
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790770063; x=1822306063;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OOgpiqKWpIg46xmlwlckN/5oX4CsvqMDjAuzmLSrLCU=;
 b=if9j0aZnp6Eh25tN6BUmow48QcaWvrWRhxH7zDY22Y/SfoLxHux65UmK
 zsv3hjSZRJLEV0osl5qjYrEIuIK/jZQLwSwd1kZvQn5DWNc7mZ5iTv5hV
 bGR69VjLuksN174L831MT4WGmt7/XNrTFkg8ZeaWUcBat6YPaiwv8S3SC
 kGEn2tOWhfWRGF7/BDeUVwCla53L3usGSlTK0Iw7iGFPh4AzSrF7EVX5O
 AmksyhkmmHIsKfDfsesak0bvnufcA2t4bIg35rJZQcYe3WmVJ46GcPfC1
 lE8vDGDiFYaDRuraqvqlgf6vkrdHzAf6dM8ObQzPpFeDynobk9Mf8opww Q==;
X-CSE-ConnectionGUID: iVnKupc6QuCccJE/uc8iPw==
X-CSE-MsgGUID: scGJirZCQVqYQS29fRXgvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102076921"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="102076921"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 05:07:43 -0700
X-CSE-ConnectionGUID: tYkqbIDHR+WDlhcj9lVsGw==
X-CSE-MsgGUID: DGzKVbuCQs2qX52tkEBDPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="272132910"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 05:07:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 05:07:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 05:07:42 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 05:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzBJOrTAG0JJktKqIvcHnXvKmCQqaCD1PafN4WmnJ7t+Masmsj4PVW0NDdOueb6lg8Auxw74IWNGkeua6PG+IJdf5U0RMI3CsvddlGZQzQKTcagcqKeEOP7RQi/gGvJnUVO7CoqjL5B2VPUzLMKN4yvLljVoM0OZflHLVLg+Q43cDHSHrOYBE7v94vFS/tlJn6tNqJ87P3pZ+F44j+HQmoocptntubqSRl00m0oOyVB9KEYlectyJuUTL2M1kVTTksTb1b2eF7ZVaZZFr7D9YxPumLTTtkgD1aEUedW1izSUOO5ptiKxLU3Lg3j44JhkRSuoDYKIuW7iGQKnFQXIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsywyyffG4q1NIRnHQi8EB2aSrTnpwVjGXq8b/DCV8A=;
 b=PqUSQxgw3JGD0gz61m7iJFqgPWjCB6Zu8BTAB1VDSIZCAalCuZYe0QCxBGiVSACYUc4grcufN3h8PnjTCYHnv6dkuO8ledlmGuk95T4zU1QNwonAinE/AcdbrGHhikN+bVVGzbS5FOpQcM6W9w9iFI49CRUwK8ovJaSkgRF1wTzpYVlWWM+pouPB3p49P7pGscZaIeRdf7iHCQJ434NvERFgDJw+Od6N7e7SLy2XMXSqSU5EnGBHC1BE5/lKbZRsmWW4YCiNNm6hL0t3yVIkRtnZJcZLaOUhUg41rOdHW5ScbR+Wz6afFUyca/nzX5BSGDGHRKCRgKjXypCG31hh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS6PR11MB362586.namprd11.prod.outlook.com (2603:10b6:8:4c4::14)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 12:07:39 +0000
Received: from DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a]) by DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a%6]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 12:07:39 +0000
Date: Wed, 30 Sep 2026 20:07:31 +0800
From: Philip Li <philip.li@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: kernel test robot <lkp@intel.com>, Linux Memory Management List
 <linux-mm@kvack.org>, Mark Brown <broonie@kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 6375e61c01e93e35ee7acd336a689ac1fae4b509
Message-ID: <arz7g8MbwpU5XImO@rli9-mobl>
References: <202609300341.XNENLUI0-lkp@intel.com>
 <20260929144213.94ba64f93121887c2a599d9f@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929144213.94ba64f93121887c2a599d9f@linux-foundation.org>
X-ClientProxiedBy: TY6P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::11) To DS6PR11MB362586.namprd11.prod.outlook.com
 (2603:10b6:8:4c4::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS6PR11MB362586:EE_|MW5PR11MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e07e81-5d94-433d-8c80-08df1eeb6c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N2BTtAa0nonWyD9BFSC1W0VeLyOgM9oj5wVRol3zSwpk9hr130GbiNdPspJfICbSCK4tKjhgQCzTc1XZo2u8Wjw41oFwPokaVIhmr3TQLYhk+cqQodAM6Cdfb5s2kmXgHwkihhllQWvzx+9b6yN7JXqksUoem58BqZrKsEziXAaC8EiWhC2udZeITGTdGvrQ4zHbXQx0MQWEscghbkvP/AqB53vUDDonIaw1+qrkmVGeqY4K6a8nwUyRjcUirgfz1tj4WwgRnL7lVy2X/4lwVyCudK95M1b4SoKOMZx9ZKFCBIyVmrUPSdKdBhZjRHwDmbaKq5Y9yIH1Kzc0mGOnr2cCC1dqtCailTZJ4T3Xn7t0Dins5QOfKbz2+F0oOS045GaKj3+AenAwz0DjUlRVc19Dkdh44bqItSEMKpVJjTvmxl6haYmkbhTamHChp1YstB1HHpYy3zkdGOic9R104Fs90hAxwt3dizdPC4XkI/nwiItUbH0IOUVtdOI2U51QAuc3CoGGUL3bS8svcfdKOy3ppEEmo35EiDi7madav9wnx6p15p39ToBeVNSL3eOu13LJmjGEtn+PseqC/Ri9GC3oYy3lxnH3NNw/hffKTEbRVtD2ASOn0V3AMn/0rua3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS6PR11MB362586.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82BmIBX9p4TcwFmHVxOTuEiWRhpxfGwu752Z60Zpr6DfbFk+9FNb0a1UOJbr?=
 =?us-ascii?Q?ZZnnAO8Sv+26o5+eho/XL4ZOmXrFDNcBSAgUb1oN8OREv15459Cc6uMVAYg5?=
 =?us-ascii?Q?scDa42n1DBUssbUba0xlfqhrBskLs1I2/9gg0mEBW9tg9T/eTJsBjaHxkNdi?=
 =?us-ascii?Q?xUrXQMPRfoDVpDA5vTkUHXz931nNTmCeyy79hbeVqW3PfIhogeJ5el209uq5?=
 =?us-ascii?Q?y1Xg6M6UuY+mDtUtqEoe0FmBvplGo+Bl0CoZhY7AbStKk3JDeTKW2oNix75H?=
 =?us-ascii?Q?93IiTQlORBBvB/F5K/eVmuJVeiMfLH6jnOCenIsDLt2+OQt9pyMIdv8cGCmJ?=
 =?us-ascii?Q?SEL8/fGnv47mvyrPoRVu5qoshyx7TJSdLdIjRqLDRKUr5BQxm+/H+aK49MON?=
 =?us-ascii?Q?EEL4FpoqXgtvViZm783j0Ql98PqOXabAzPSqXv1E9CMF10et17pCyJDYTaQw?=
 =?us-ascii?Q?+aYWbJO5Z1fuRQC/cAxWJoN8QlhV0LwiPF9Bwwj3OAkmS28eMfaxwHz4cvZV?=
 =?us-ascii?Q?ND/NLv6ATdTE4ZtADFX4UrSX54QBesilddFU+lQFuLu/zgIbZj4I4aYX4TI/?=
 =?us-ascii?Q?dsAco6KrcbJHzLkCpMZJxnO0M65oZT0kGVkQO23VRLZSxhF3mZN3R/MBH9uw?=
 =?us-ascii?Q?b1WtcqOShAPWUyyjBVAlC68agnsTqOm6D2eIZr3cSZ7w10608N5UrTENMOv3?=
 =?us-ascii?Q?6sEHE5AniL3s1TK+VjHj9gtB8tUKp1gk+5sKMDWjQw/wqykf3mAk5yu8KbnX?=
 =?us-ascii?Q?hAJ7NWxGYhMig2hpMd71u7QZzWOFeOlSC9S8s0ub9XslJb9iaNC5DiN8Cmzk?=
 =?us-ascii?Q?/oolEIiW3ly4dSfJm5C4CxQDh3v+j96PJicpdN8qN6ZNt79iToxAzlvlsSgh?=
 =?us-ascii?Q?y637C+dJGkfAlscxC4KdvEDjik5b5wDWPegkLhtAkRk8fOjk3flagsloGYiK?=
 =?us-ascii?Q?g0gCLXwb3y8Ut6BCTi9jeLL1AZ64hIiXoOR6BW5PEDeeAFviIaNm+U3fe7aW?=
 =?us-ascii?Q?5NI87Ax6jaBSx/7RKhJ9u5VxsfSVR3KCGleO2vnXiMJ81g1xmJ/zFsCollXD?=
 =?us-ascii?Q?Hg4ec4c08BE73Y2fOFawlxV7BO84cLYRGtjMgZ7Rho0H40eZIcAdzfTFs6gs?=
 =?us-ascii?Q?O7eNSRzgnuRc4BdKcZGOC3iBpgryW/oWAZLorZA7I/xHHsdijzntUgyFQxso?=
 =?us-ascii?Q?j8rz0c8fHc4+1Vn+2E4m+Sng+XVq4q3CmfNCXasU+BTAM0R4ql1FYZZabnUn?=
 =?us-ascii?Q?dkxNXoOlY8iJnMUYaVJthLg5CjjURPox2jRnhLVrhHRGFPawxPPPUogFMAFO?=
 =?us-ascii?Q?GOJd86XKBi4dlfxtQvNJxi/i6nT+xVAAJLuBY4hqyrKp+dQRwFqrJibaPYix?=
 =?us-ascii?Q?uyJKhkLlVF7B3JYD3oG/YnIvWFaOAAqDW2G4kp6mP+wenrd3ctYeAh3Kt4j9?=
 =?us-ascii?Q?jVG9L+NX6rJpmaYe8joD9BRAxUSuosPKnSPV4dTQXZPlxVhifgTHtIABBqZO?=
 =?us-ascii?Q?MY4KAa3henTKhmnf5Iaa41IGf5qr/Tz8+0IpBD6t9rfkB4K73B82jL11Lg2o?=
 =?us-ascii?Q?m9+AXJ2JjvBERWP1CWUwj+NcSsjLUngSlt5gSBXZrxY2WNtSDfK4kYpLHlC0?=
 =?us-ascii?Q?cCEH6IrRK+jxPgEXeIIFW9cZputKp/xacCv/BT/MLcJYCOwOJJE2s+Hasg1u?=
 =?us-ascii?Q?jxTOQsbrFxzFdTNe/RXm3SsIFn6OP0gQpG8t7vpIFZ85Bp94EKKIzcA+DIm1?=
 =?us-ascii?Q?GR+7qI7wSw=3D=3D?=
X-Exchange-RoutingPolicyChecked: OWOye91UEFk+hZlbVlrTBEUsGzeDwASoeNLZKDu0N2/hworSwJBc54Fgx65jCwxAdE9saPOFPk7EzdbJ8nfg4CcbYCXiziPjUhtX3SNInKBYBiFEmI2RiA0X/GEnfZervBB5GtgBEYuWGfzMaUBixJBGxirLT4V0IkN6lnra/rpZLIQRvV9pH3llzmKkEHV1IHUptHdJLxa/V3RLwwWc+80pGb53hVN/Yz+8cRfbPG7n5xQmfe7VdfiO3AQzo1KGsn5eCn54kiTBJFiDmfBLluDAKvxmoMIsAt9VRESwgrg3MAQqDq5vbfd+ztJWeXSJT0hG/mvxlZYug2yHgNt9Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e07e81-5d94-433d-8c80-08df1eeb6c53
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB362586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:07:39.5515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw4cPT2sruMGRhsotUIZ/blVeI5EKG6+qqHDr18cHhTHXm0DfvEHFF7I7sSAFdI660EDG25DN/TKTE05hN+SYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
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

On Tue, Sep 29, 2026 at 02:42:13PM -0700, Andrew Morton wrote:
> On Wed, 30 Sep 2026 03:09:45 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > branch HEAD: 6375e61c01e93e35ee7acd336a689ac1fae4b509  Add linux-next specific files for 20260928
> > 
> > Error/Warning (recently discovered and may have been fixed):
> > 
> >     https://lore.kernel.org/oe-kbuild-all/202609290155.PQiaOalK-lkp@intel.com
> >     https://lore.kernel.org/oe-kbuild-all/202609290349.4ad3d90o-lkp@intel.com
> >     https://lore.kernel.org/oe-kbuild-all/202609290408.BOs7sk55-lkp@intel.com
> >     https://lore.kernel.org/oe-kbuild-all/202609291109.9RGna4XZ-lkp@intel.com
> >     https://lore.kernel.org/oe-kbuild-all/202609291109.OIsGTysr-lkp@intel.com
> > 
> >     Documentation/filesystems/api-summary:20: ./fs/dcache.c:2010: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> >     arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dtb: clock-controller@100000 (qcom,gcc-sdm670): 'power-domains' is a required property
> >     arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb: clock-controller@100000 (qcom,gcc-sdm670): 'power-domains' is a required property
> >     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:11: error: call to undeclared function 'devm_drm_of_get_bridge'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:16: error: assignment to 'struct drm_bridge *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:18: error: implicit declaration of function 'devm_drm_of_get_bridge'; did you mean 'devm_drm_put_bridge'? [-Wimplicit-function-declaration]
> >     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:9: error: incompatible integer to pointer conversion assigning to 'struct drm_bridge *' from 'int' [-Wint-conversion]
> >     drivers/gpu/drm/verisilicon/vs_bridge.c:306:14: error: assignment to 'struct drm_bridge *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >     drivers/gpu/drm/verisilicon/vs_bridge.c:306:16: error: implicit declaration of function 'devm_drm_of_get_bridge'; did you mean 'devm_drm_put_bridge'? [-Wimplicit-function-declaration]
> >     drivers/gpu/drm/verisilicon/vs_bridge.c:306:7: error: incompatible integer to pointer conversion assigning to 'struct drm_bridge *' from 'int' [-Wint-conversion]
> >     drivers/gpu/drm/verisilicon/vs_bridge.c:306:9: error: call to undeclared function 'devm_drm_of_get_bridge'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 
> (cc dri-devel for the above)
> 
> > Unverified Error/Warning (likely false positive, kindly check if interested):
> > 
> >     drivers/gpu/drm/xe/xe_guc_pc.c:1400:17: sparse: sparse: Trying to use reserved word 'break' as identifier
> >     drivers/gpu/drm/xe/xe_guc_pc.c:1400:17: sparse: sparse: Trying to use reserved word 'switch' as identifier
> 
> I can't find any code in there which could cause this.  Using the correct HEAD.

Sorry for confusion, the initial unverifed report is at [1], and it should be a false
positive from sparse. But this report fails to include the link of [1] and causes
confusion.

[1] https://lore.kernel.org/oe-kbuild/202609250044.R601n2jg-lkp@intel.com/

Thanks
