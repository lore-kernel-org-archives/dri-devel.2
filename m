Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07B606EEAB
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TBerevcb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E2A10F322;
	Mon,  9 Nov 2026 15:41:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327E010F328
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794238893; x=1825774893;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gre1VH1L8vGXghU4CR1ProqOQwGCgN+A9MfJATJsKCo=;
 b=TBerevcb9EVpJ2SnrGtRlUyoJ1SZH2XwPwl1ubXCLGP0kcdGc6txL8eW
 KGP0BAHpONxB1UCTHLiaasbiVZUhIhXQlZR1JfAx4HPtkvzeLBISg5YVq
 MaFNSCT8UG5dRWjZbgNu0VcW20ZauXc3CXhpWncgTtUew4k8pehkZVvkT
 887mJ6pPw86mRYxyvn8KM03nRfZpuMHg0/RxKTic7ZfzS0+akyl7BH9BF
 UHCYjJuhzyFcJQPx4DcTNfEx4dgx/0F5sPMP/b2Dnp0/ht4kOaDm01TjI
 NUH2PTPeZ3CsgwgaR6CZdWZlIjtQY9BWRaWAz/xkxmzT19lTfXObsKWWv Q==;
X-CSE-ConnectionGUID: bpa79lOTQTuP/+W2fiCDcw==
X-CSE-MsgGUID: mLBAsd1ZS26/RGUBoUjkqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2862674"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2862674"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:41:33 -0800
X-CSE-ConnectionGUID: jesiBlE1Tbi2LEBIaaWSxg==
X-CSE-MsgGUID: jV0TOFhXREOwM6Y9L7a85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7744403"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:41:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:41:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 07:41:31 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:41:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScYISq3VpW2Jzis9K+/mkDFc4JriydBPXUmZ8worzSJLJq42+tvArVxNQfelQsSqex/oNxPOTNZpmm4Mdb9+h7OeXDvSX9s2uMvMo4umpUjqZgvsX096xs8S7K5E89t22hh9L9PuZtNfSLP5anJgGlp+HPgx9sRMipnf8fX5JdDKwL+4fbs5e1s0olp2rUDmnh4LEXa4qwGWfD36rWKXfLADL8ukzC2aVJf5FHaHt6bGjZCSZEDxlpIbM6ddR1EqjRi1vcIiydF3I6434zSPOKTtAjQ3MGxFQ8XNQLElaGM6qIRgQjgUmTnQbwlLIv+ObeRbgsHY9bwyT+UQHpnTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWiElXgjPP9sSj9mlF9vKrT77/FlZ/eyLpZU2J54nNo=;
 b=EviC3zzyXonGthRYU9ADoCgCKX9sGj5NFSf4+XvqeV1Q8e5iWkfvQ4KO6hSjBzoGAMeCrhJOgrjQNC7jTnj/YUQpmNtHrBA1L48G+jJaDvKsnGxe/OjAVL1UqF9e9ZJYUH9n1+3STl3Vc4XaEE9eyLh9SViPt1TQHNdsp8kxCH85uwazi1W2SkM7P5XRMdj7a94QyQvx8jF7yQRx5cccPQhXnAtQMXXz4aV8vc6o/ZyA/YLpklAJgrlAz18ygadAPjfARcfvDKJ0ThalYaL4aV1D8LqVBynqG1TN1aFebULFN8LtSOCbiUpPwEDqApt9y5OYzsNCI4l+yiMTTM73MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 15:41:28 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:41:28 +0000
Date: Mon, 9 Nov 2026 10:41:22 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <avHpogElibf5F0FR@intel.com>
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb0d580-0f8a-450a-7a78-08df3e77eb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261009223327099003|261009221727099003|56012099006|261021123027099003|261009223027099003|261022075727099003|261021121427099003|261022105027099003|261009220027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: pRcg6/jRYLc1QcM36BHaxmi/oKb1tkvHf4Df9JqdPORF49UKqxmx8JhZBBqEy40Pgc2GeoZQ0hBtf2owoxUn0opgC38LarCQ5q94DrKrhzOeJSjvjY0TIS3v0vJShzLtrJSqddGxUKTlztuSzhARnTUxovgoAxL9Wu2SIWBmU0AbdooUBIC5MiePphYxS7thnGVhqIyNzJ4GzcSu1xzIq+bWug626xZjYr72m11sbj9m4aBcxDDgVlZLbpBobuejTTf+Lz3hwig44GiNz0sUt1bwsx2vzaNAbVkq2QChQ/Ft1w9tPKP/w3M8E43lbUENHP1lBSSdc6oeiq3LGFMD+rZe6/8+4dJQRMM7u6z5TG7USDzRHLBkiEacmRtlr7JCYkN9uqsXF6FhgA4hCDtujMntw94G9l3ICcu2OwAtQjW8d5wcPLjNgwOiAktm8G717qZQLgyutFAIo1j1lIU/Cur2/iREmh6WiwN99lu7mU2qShq1KRzjr+nx50gHb7ISPUBU334BP/Q6gR/QgoyR7bMM43PfqVvfnVRXau+TTrpU0J/gIdcESoi4mXRFCavGOrM3koNeI4RL1CcINnIuyxFtDRBFMirE1YFxpcr6knDeEA+mXgz8FJE9wACuPqZkH2FIwD4xWMKi8Zw0W3G7YvmKBIRNqVXOqyK9EX+E2Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261009223327099003)(261009221727099003)(56012099006)(261021123027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261009220027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p4cule2TeUFV//QPqyIE3Ds8DmLuyo6yI2gFWU9xYVyCOyOjIxV755t1BXqg?=
 =?us-ascii?Q?NfZDUVQWBiARAxbNUrvDjQZiXZF+yEVqmVguNovbAR7T50gWkbWMKYXY4H+5?=
 =?us-ascii?Q?V7cULq/EfP5po4V/jhmcXotfHSCJGEo8pFrk1uqsLJVhxGuEGlcWXf4Eartk?=
 =?us-ascii?Q?WQe6xaMCXYqOfPmAhNKMUlhyNWTEdzMZOUFtVNva1Ynb/8aqubrenmLm1CWR?=
 =?us-ascii?Q?07fSadHhUfSwy8vKlVpnh0D7B4Zen6o7DGbJ9UlVpHlQN3y9bLGWlsCJzbAs?=
 =?us-ascii?Q?fBp/mDKmpNBWuO7gep7RIXZ3kvBE4IqHowvObWrSocSNc2LA4meUtPKN1JL5?=
 =?us-ascii?Q?LgUWmbJF3+sqm8vNWYAGFRbdFh7X7DTLbRvh2IP0YgG4m8AGraJnY56VoLha?=
 =?us-ascii?Q?Plq8YP6T1tXxl1szNyj4gD9dqOYZfGgsb7uQQ/EFP2n+Bw2JNxksQdwiZqD2?=
 =?us-ascii?Q?b7fWLwzsOjrtea2JHj8lgf1ISai+RZgP1EubU5Nf2tIITkSVi6NVXli0YuA3?=
 =?us-ascii?Q?C16YIcnqkA4wvbm9/6sT77oBmhmzBPHJVrZgyDUtUCbLTz5GoyrXK1YxPWX5?=
 =?us-ascii?Q?l124KQSul4bk5YnJkQdsasF3ebInVTqTDr1vTafi505qPfHC5k/NChvbC5T5?=
 =?us-ascii?Q?0hjWWtOElvnBTwFU9z0kyjn3Oj8x5QAhzyLfCngO/zYTRmIpdBbmqqi6qVFv?=
 =?us-ascii?Q?ugyD+pJysTNijahjJMHER89zhs8A3yC35tGYwX3a1LoH0l5bHkVN6kZ/dq9H?=
 =?us-ascii?Q?pablwOAVRQ7WiW31Hy41+8TNTzXW5xx/GX8q3RIBrqGd5e/VvulrpRClNTJR?=
 =?us-ascii?Q?ETJu7gDWjblqoASqNv/bcQzdOS7BG76MgrhNDV6QQnycEYwTTplPt26pqfuS?=
 =?us-ascii?Q?nSR9jCAbeKItm0XLb1dK/z3K0b8jHeHLa/qtwk98UDfrGm3IR5oVJR5MT4v2?=
 =?us-ascii?Q?Fq5Bc2+jaolxAcr91NjaQtUchnOR0wyy1CdR/VkMDg7e9quZwA0ULkwojBE5?=
 =?us-ascii?Q?046lzCtx4cyX2SL2DkuMwNZogtbdNnSKAkzyHf8Rymz8Mx7ObREOtpCD8T++?=
 =?us-ascii?Q?NByyW4WWjYl0JpaAUfPbhScRSrESBa0zMrFh1+lmvDz/HYHrPdsXVkirn3wO?=
 =?us-ascii?Q?gQQ6nn+q1OX3mT7ce37hyTvTDhp/8fzECnvsWpfsMPchMSwnx2ZQ4mn1kfQr?=
 =?us-ascii?Q?XvH7B5JiMXScT+rIAK5OGXTKbMBaDdrgRW+s+WxQkHgLj+G5/BvDF8wAtnI7?=
 =?us-ascii?Q?az1nPVBhOyWlipBr5sO2/WCz5kvty/wNDPal+/mI1x9x9N0iwUS81Kq7Ryrm?=
 =?us-ascii?Q?yQZCJQTGMVPWHPh+ygdaVNzOGLAQ1wJ9BUnjMxzuxYT8m+W8nXQxNJLMRkLo?=
 =?us-ascii?Q?vzjxcQEycHawPf6wbyUoEmQn17Y5SwXBwEBtNt8fSc7UNvmtyJvyUiV5Oj1h?=
 =?us-ascii?Q?mGu5W1zyHrCMXLjVX6zbQddHYgjJnqDqVFRd1ellwbKmwRbbtBmYvtH+3aMy?=
 =?us-ascii?Q?MA5o8bmWhurKFIwMWnXuqsShtokJEP8o7mPkHnNgT/4pmQwsauelWo6miV6b?=
 =?us-ascii?Q?0TOw5+46TF6Deb06QQF084NpkeRHXxUdq+vozJPYKCh4d2HrHGau+uRxFfEd?=
 =?us-ascii?Q?8UzbAwmCnD8H9bXpyeCuryYIJWwggyRRZaBCnaVz23m+Dh84km/OJlmnBi5z?=
 =?us-ascii?Q?AwuUBAan7hi1b/tWwrLSia7hatuQtuu/YFvJA/Kq3alt5Bx+leriXuNs9lS6?=
 =?us-ascii?Q?AfnPe4SQLw=3D=3D?=
X-Exchange-RoutingPolicyChecked: m5YUIyPuqfGy6RiYZulKYt55ukwW1ZJPPw9s5tBIxZvZ69OTTaa9wa/Rp7BVe0M4dAL3C65cRlRVkpfSpi2ml+jHgwQJOVDBpl2QwudGAxjb/VUvCywx1SfxWa5yoLELRNSDFLr6ObTp4Tm1K9ndutmcm6heZiOANgb5SgvBhyvPgN+KachzMbk2GrgXqOO8c2QhWAy365uXF7WH2aFvDzg4yD46dCxCVvi73YpSv/4HgzH0P4zwtUuhy5xpnZJZcwyoKlVw5byyRZjR058PGonDxF9WZM4+Yg9hFSRmW0qyGjmlg1VlcIzbkivqeTIB+sGXn/hZQFZhruUiP8HORQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb0d580-0f8a-450a-7a78-08df3e77eb5c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:41:28.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ8oTkmLa1h5zJzxY2D+Vk/3LN/eUzaVjvcjtgyxiDda+n6f+EEteeypsDmGm+3gosRKlwYyUiPf4VzEIF/zbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:12:24AM -0800, Zack McKevitt wrote:
> Add a new node type, attribute set, and doit/dump functions for
> performing telemetry read and write operations using the DRM RAS
> interface.
> 
> ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
> include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.
> 
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> ---
>  Documentation/netlink/specs/drm_ras.yaml |  82 +++++-
>  drivers/gpu/drm/drm_ras.c                | 329 ++++++++++++++++++++++-
>  drivers/gpu/drm/drm_ras_nl.c             |  53 ++++
>  drivers/gpu/drm/drm_ras_nl.h             |   9 +
>  include/drm/drm_ras.h                    |  67 +++++
>  include/uapi/drm/drm_ras.h               |  19 +-
>  6 files changed, 545 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index a88fdab7a1c7..cf015bba020d 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,11 +16,11 @@ definitions:
>      type: enum
>      name: node-type
>      value-start: 1
> -    entries: [error-counter]
> +    entries: [error-counter, telemetry]
>      doc: >-
> -         Type of the node. Currently, only error-counter nodes are
> -         supported, which expose reliability counters for a hardware/software
> -         component.
> +         Type of the node. The error-counter nodes expose reliability counters
> +         for a hardware/software component, and telemetry nodes expose an
> +         interface for reading and writing telemetry values to a device.
>  
>  attribute-sets:
>    -
> @@ -100,6 +100,34 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32

this we keep for legacy alignment.

> +        doc: >-
> +             Unique identifier for the node.
> +             Assigned dynamically by the DRM RAS core upon registration.
> +      -
> +        name: field
> +        type: u32

should we move this to uint as well?

> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> +      -
> +        name: field-name
> +        type: string
> +        doc:  Name of the telemetry field defined by the device's uAPI.
> +      -
> +        name: value
> +        type: sint
> +        doc: Value of telemetry field that was read/written.
> +      -
> +        name: status
> +        type: s32

and this to sint?!

> +        doc: >-
> +             Status of the telemetry operation.
> +             Populated by the device in response to the performed
> +             telemetry operation. Errors may be hardware specific.
>  
>  operations:
>    list:
> @@ -198,6 +226,52 @@ operations:
>              - node-id
>              - error-id
>              - error-threshold
> +    -
> +      name: telemetry-get
> +      doc: Perform a read of the specified telemetry field.
> +      attribute-set: telemetry-attrs
> +      do:
> +        pre: drm-ras-nl-pre-telemetry
> +        request:
> +          attributes:
> +            - node-id
> +            - field
> +        reply:
> +          attributes:
> +            - value
> +            - status
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes: &telemetry-field-attrs
> +            - field
> +            - field-name
> +    -
> +      name: telemetry-set
> +      doc: >-
> +           Perform a write of the specified telemetry field.
> +           Telemetry writes are device specific, and may be used to set
> +           device limits or other capacities, for example.
> +      attribute-set: telemetry-attrs
> +      flags: [admin-perm]
> +      do:
> +        pre: drm-ras-nl-pre-telemetry
> +        request:
> +          attributes:
> +            - node-id
> +            - field
> +            - value
> +        reply:
> +          attributes:
> +            - status
> +      dump:

does dump on set specified telemetry field makes sense?!

> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes: *telemetry-field-attrs
>  
>  mcast-groups:
>    list:
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 4f4777060a4e..fda50563c4a5 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -53,6 +53,15 @@
>   * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
>   *    Userspace must provide Node ID, Error ID and threshold to be set.
>   *
> + * 8. TELEMETRY_GET: Read a telemetry value.
> + *    Userspace must provide Node ID and telemetry field to be read.
> + *    Returns the status of the read and the value read (if valid).
> + *
> + * 9. TELEMETRY_SET: Write a telemetry value.
> + *    Userspace must provide Node ID, the telemetry field to write, and the value
> + *    to be written.
> + *    Returns the status of the write.
> + *
>   * Node registration:
>   *
>   * - drm_ras_node_register(): Registers a new node and assigns
> @@ -63,7 +72,6 @@
>   * Node type:
>   *
>   * - ERROR_COUNTER:
> - *     + Currently, only error counters are supported.
>   *     + The driver must implement the query_error_counter() callback to provide
>   *       the name and the value of the error counter.
>   *     + The driver must provide a error_counter_range.last value informing the
> @@ -81,6 +89,15 @@
>   *       that are raised by the hardware.
>   *     + The driver is responsible for error threshold bounds checking.
>   *
> + * - TELEMETRY:
> + *     + The driver must implement the telemetry_get() callbacks, telemetry_set()
> + *       is optional.
> + *     + The driver must provide a list of gettable telemetry fields corresponding
> + *       to their uAPI definitions and values. Settable telemetry fields are also
> + *       required if providing telemetry_set().
> + *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
> + *       to enforce permissions checks on telemetry operations.
> + *
>   * Netlink handlers:
>   *
>   * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> @@ -95,6 +112,16 @@
>   *   operation, fetching the error threshold of a specific counter.
>   * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
>   *   operation, setting the error threshold of a specific counter.
> + * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE

_GET and _SET

> + *   pre_doit operation, returning 0 if valid.
> + * - drm_ras_nl_telemetry_get_dumpit(): Implements the TELEMETRY_GET dumpit
> + *   operation, fetching all readable telemetry values for a telemetry node.
> + * - drm_ras_nl_telemetry_get_doit(): Implements the TELEMETRY_GET doit operation,
> + *   invoking the driver's telemetry_get callback and returning the results.
> + * - drm_ras_nl_telemetry_set_dumpit(): Implements the TELEMETRY_SET dumpit
> + *   operation, fetching all writeable telemetry values for a telemetry node.
> + * - drm_ras_nl_telemetry_set_doit(): Implements the TELEMETRY_SET doit operation,
> + *   invoking the driver's telemetry_set callback and returning the results.
>   */
>  
>  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -617,6 +644,285 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>  	return set_node_error_threshold(node_id, error_id, threshold);
>  }
>  
> +/**
> + * drm_ras_nl_pre_telemetry - Enforce permission checks
> + * @ops: Generic netlink operations
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Enforces a telemetry node's pre_doit conditions (if they exist).
> + *
> + * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
> + */
> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
> +			     struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	u32 node_id;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;

netlink review prompts ask us to use NL_SET_BAD_ATTR in cases like this.

Perhaps a
NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);

The same applies to the other unknown-node returns in the doits and dumpits.

> +
> +	if (node->telemetry_pre)
> +		return node->telemetry_pre(node);
> +
> +	return 0;
> +}
> +
> +static bool telemetry_fields_contains(const struct drm_ras_telemetry_field *fields, u32 value)
> +{
> +	unsigned long idx;
> +
> +	if (!fields)
> +		return false;
> +
> +	for (idx = 0; fields[idx].name; idx++) {
> +		if (fields[idx].value == value)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int telemetry_fields_dumpit(struct sk_buff *skb, struct netlink_callback *cb,
> +				   const struct drm_ras_telemetry_field *fields)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> +	const struct drm_ras_telemetry_field *field;
> +	struct nlattr *hdr;
> +	unsigned long idx;
> +	int ret = 0;
> +
> +	if (!fields)
> +		return -EOPNOTSUPP;
> +
> +	for (idx = ctx->restart; fields[idx].name; idx++) {
> +		field = &fields[idx];
> +
> +		hdr = genlmsg_iput(skb, info);
> +		if (!hdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = nla_put_u32(skb, DRM_RAS_A_TELEMETRY_ATTRS_FIELD, field->value);
> +		if (ret) {
> +			genlmsg_cancel(skb, hdr);
> +			break;
> +		}
> +
> +		ret = nla_put_string(skb, DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME, field->name);
> +		if (ret) {
> +			genlmsg_cancel(skb, hdr);
> +			break;
> +		}
> +
> +		genlmsg_end(skb, hdr);
> +	}
> +
> +	if (ret == -EMSGSIZE)
> +		ctx->restart = idx;
> +
> +	return ret;
> +}
> +
> +/**
> + * drm_ras_nl_telemetry_get_dumpit() - Dump readable telemetry fields.
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Displays the set of readable telemetry fields that is specified by
> + * the device for the given node.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_telemetry_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_node *node;
> +	u32 node_id;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	return telemetry_fields_dumpit(skb, cb, node->telemetry_fields_gettable);
> +}
> +
> +/**
> + * drm_ras_nl_telemetry_get_doit() - Query a telemetry value
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the telemetry field from the netlink attributes and
> + * reads that value from the device.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status = 0;
> +	s64 value = 0;
> +	int ret = 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
> +		return -EINVAL;
> +
> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_get)
> +		return -ENOENT;
> +
> +	if (!telemetry_fields_contains(node->telemetry_fields_gettable, field))
> +		return -EINVAL;

NL_SET_BAD_ATTR on NODE_ID for the -ENOENT case, and on FIELD for the -EINVAL
case (field not in the gettable/settable list).

> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret = node->telemetry_get(node, &field, &value, &status);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = nla_put_sint(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, value);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +}
> +
> +/**
> + * drm_ras_nl_telemetry_set_dumpit() - Dump writeable telemetry fields.
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Displays the set of writeable telemetry fields that is specified by
> + * the device for the given node.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_telemetry_set_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_node *node;
> +	u32 node_id;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	return telemetry_fields_dumpit(skb, cb, node->telemetry_fields_settable);
> +}
> +
> +/**
> + * drm_ras_nl_telemetry_set_doit() - Write a telemetry value
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the telemetry field and value to be written from the netlink
> + * attributes and writes that value to the specified field on the device.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status = 0;
> +	s64 value = 0;
> +	int ret = 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_VALUE) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
> +		return -EINVAL;
> +
> +	value = nla_get_sint(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_set)
> +		return -ENOENT;
> +
> +	if (!telemetry_fields_contains(node->telemetry_fields_settable, field))
> +		return -EINVAL;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret = node->telemetry_set(node, &field, &value, &status);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +}
> +
>  /**
>   * drm_ras_node_register() - Register a new RAS node
>   * @node: Node structure to register
> @@ -631,14 +937,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
>  	if (!node->device_name || !node->node_name)
>  		return -EINVAL;
>  
> -	/* Currently, only Error Counter Endpoints are supported */
> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> -		return -EINVAL;
> -
> -	/* Mandatory entries for Error Counter Node */
> -	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
> -	    (!node->error_counter_range.last || !node->query_error_counter))
> +	/* Currently, only Error Counter and Telemetry endpoints are supported */
> +	switch (node->type) {
> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> +		/* Mandatory entries for Error Counter Node */
> +		if (!node->error_counter_range.last || !node->query_error_counter)
> +			return -EINVAL;
> +		break;
> +	case DRM_RAS_NODE_TYPE_TELEMETRY:
> +		/* Must provide telemetry_get, telemetry_set is optional */
> +		if (!node->telemetry_get || !node->telemetry_fields_gettable)
> +			return -EINVAL;
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
>  
>  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>  }
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index ff0dc406c27c..19e3683fb35a 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -41,6 +41,29 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
>  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
>  };
>  
> +/* DRM_RAS_CMD_TELEMETRY_GET - do */
> +static const struct nla_policy drm_ras_telemetry_get_do_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_TELEMETRY_GET - dump */
> +static const struct nla_policy drm_ras_telemetry_get_dump_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_TELEMETRY_SET - do */
> +static const struct nla_policy drm_ras_telemetry_set_do_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
> +	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_SINT, },
> +};
> +
> +/* DRM_RAS_CMD_TELEMETRY_SET - dump */
> +static const struct nla_policy drm_ras_telemetry_set_dump_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
>  /* Ops table for drm_ras */
>  static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	{
> @@ -83,6 +106,36 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= DRM_RAS_CMD_TELEMETRY_GET,
> +		.pre_doit	= drm_ras_nl_pre_telemetry,
> +		.doit		= drm_ras_nl_telemetry_get_doit,
> +		.policy		= drm_ras_telemetry_get_do_nl_policy,
> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_TELEMETRY_GET,
> +		.dumpit		= drm_ras_nl_telemetry_get_dumpit,
> +		.policy		= drm_ras_telemetry_get_dump_nl_policy,
> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
> +		.flags		= GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_TELEMETRY_SET,
> +		.pre_doit	= drm_ras_nl_pre_telemetry,
> +		.doit		= drm_ras_nl_telemetry_set_doit,
> +		.policy		= drm_ras_telemetry_set_do_nl_policy,
> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_TELEMETRY_SET,
> +		.dumpit		= drm_ras_nl_telemetry_set_dumpit,
> +		.policy		= drm_ras_telemetry_set_dump_nl_policy,
> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +	},
>  };
>  
>  static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 9aef097ea10f..ad3b28f2d809 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -12,6 +12,9 @@
>  
>  #include <uapi/drm/drm_ras.h>
>  
> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
> +			     struct sk_buff *skb, struct genl_info *info);
> +
>  int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>  				 struct netlink_callback *cb);
>  int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> @@ -24,6 +27,12 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>  					struct genl_info *info);
>  int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
>  					struct genl_info *info);
> +int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
> +int drm_ras_nl_telemetry_get_dumpit(struct sk_buff *skb,
> +				    struct netlink_callback *cb);
> +int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int drm_ras_nl_telemetry_set_dumpit(struct sk_buff *skb,
> +				    struct netlink_callback *cb);
>  
>  enum {
>  	DRM_RAS_NLGRP_ERROR_REPORT,
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 1765a3130b09..1b2a40040c3b 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -10,6 +10,16 @@
>  
>  #include <uapi/drm/drm_ras.h>
>  
> +/**
> + * struct drm_ras_telemetry_field - A descriptor of a telemetry field.
> + */
> +struct drm_ras_telemetry_field {
> +	/** @name: The enum or macro name defined by the device uAPI. */
> +	const char *name;
> +	/** @value: The numerical value of the field. */
> +	u32 value;
> +};
> +
>  /**
>   * struct drm_ras_node - A DRM RAS Node
>   */
> @@ -100,6 +110,63 @@ struct drm_ras_node {
>  	 */
>  	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
>  
> +	/* Telemetry Related Callback and Variables */
> +
> +	/**
> +	 * @telemetry_fields_gettable:
> +	 *
> +	 * A list of gettable telemetry fields for a device.
> +	 * The list must be terminated by a NULL .name entry.
> +	 */
> +	const struct drm_ras_telemetry_field *telemetry_fields_gettable;
> +
> +	/**
> +	 * @telemetry_fields_settable:
> +	 *
> +	 * A list of settable telemetry fields for a device.
> +	 * The list must be terminated by a NULL .name entry.
> +	 */
> +	const struct drm_ras_telemetry_field *telemetry_fields_settable;
> +
> +	/**
> +	 * @telemetry_pre:
> +	 *
> +	 * This callback is used to enforce any pre_doit conditions necessary
> +	 * for telemetry. This is an optional callback for telemetry_node.
> +	 *
> +	 * Returns 0 on success, negative error code on failure.
> +	 */
> +	int (*telemetry_pre)(struct drm_ras_node *ep);
> +
> +	/**
> +	 * @telemetry_get:
> +	 *
> +	 * This callback is used for a drm-ras telemetry node to read a
> +	 * telemetry value. This is a mandatory callback for telemetry_node.
> +	 *
> +	 * The callback will read the desired device-specific field into value
> +	 * and update status corresponding to a device-specific error code.
> +	 *
> +	 * Returns 0 on success, negative error code on failure.
> +	 */
> +	int (*telemetry_get)(struct drm_ras_node *ep, u32 *field, s64 *value,
> +			     s32 *status);
> +
> +	/**
> +	 * @telemetry_set:
> +	 *
> +	 * This callback is used for a drm-ras telemetry node to write a
> +	 * telemetry value. This is an optional callback for telemetry_node.
> +	 *
> +	 * The callback will write the value to the desired device-specific
> +	 * field and update status corresponding to a device-specific error
> +	 * code.
> +	 *
> +	 * Returns 0 on success, negative error code on failure.
> +	 */
> +	int (*telemetry_set)(struct drm_ras_node *ep, u32 *field, s64 *value,
> +			     s32 *status);
> +
>  	/** @priv: Driver private data */
>  	void *priv;
>  };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 2f832275ee6e..4776c2f9cb5a 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -11,11 +11,13 @@
>  #define DRM_RAS_FAMILY_VERSION	1
>  
>  /*
> - * Type of the node. Currently, only error-counter nodes are supported, which
> - * expose reliability counters for a hardware/software component.
> + * Type of the node. The error-counter nodes expose reliability counters for a
> + * hardware/software component, and telemetry nodes expose an interface for
> + * reading and writing telemetry values to a device.
>   */
>  enum drm_ras_node_type {
>  	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> +	DRM_RAS_NODE_TYPE_TELEMETRY,
>  };
>  
>  enum {
> @@ -51,6 +53,17 @@ enum {
>  	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>  };
>  
> +enum {
> +	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
> +	DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME,
> +	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> +	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
> +
> +	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
> +	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
> +};
> +
>  enum {
>  	DRM_RAS_CMD_LIST_NODES = 1,
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> @@ -58,6 +71,8 @@ enum {
>  	DRM_RAS_CMD_ERROR_EVENT,
>  	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>  	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_TELEMETRY_GET,
> +	DRM_RAS_CMD_TELEMETRY_SET,
>  
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> -- 
> 2.43.0
> 
