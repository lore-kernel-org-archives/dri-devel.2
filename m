Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763B606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIm0RjGM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA6010E204;
	Wed, 11 Nov 2026 19:02:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE0A10E204;
 Wed, 11 Nov 2026 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794423724; x=1825959724;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wTK0fJZTv6g264VfYWOUeZwmI/BD9vVX8WTpRFjb6uc=;
 b=AIm0RjGMcBZR9Y32ksyTOduiIhYOg0Te9JPZjpmcZs3aCewX0Wg/3I8u
 Kk1ZJnDvQD4n9jWe774iJ06IHUf5EyKqWNqMbq/5094rMlJBMUpzd85wg
 qsv7vtY87c5tGGIim0PTdSv70U+C1pdAl4DZ68JO++cFJkf5YwnvMrHq0
 AV1L8jkVv+4R6F+D5dv1QNSqOrDdzCRH9msCGAY3KL9cFhclNfYvQDcwj
 DYQUbZpO55hDO0qscRSER8euAE6hxovCpfvGz8h6szX2nyReTJxMEN1GQ
 NQWA28vptvLQc1kjrC7A83d79ZoB61MoVAPMs6AckuaRuxtYq91+C3m36 Q==;
X-CSE-ConnectionGUID: Li/N4MZvRLe/vjhiRNOX7A==
X-CSE-MsgGUID: 80RxSIXMSW638Y66ICcXLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3204523"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3204523"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 11:02:03 -0800
X-CSE-ConnectionGUID: dLRLN/n+RNOOGD6Z8qWCFg==
X-CSE-MsgGUID: btg7nDMHS6CL9Tp9YQVYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; d="scan'208";a="10201084"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 11:02:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 11:02:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 11:02:01 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 11:02:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPp75M14cGeswNp120rxORTq/RtxD/A8z6x09ZBOkQMszjU9XWb9TSUzJEhSTXrI+J3fX55SGMb/bl1uUt24PBkw8Hn8ZTxD5ganlk7fZwBWmCH2eGwdWxoOZfoRxo49DcWuyZWfvHlNOpDBzkrRPtZbdVeY+HCLb3j8qtd5GrYlM8QkxznR719THrewlMrx53N99AI0gVv5DGiqvP0T/7cG7Qk5elbZv+qdMjOK25+UAKMps4nGEjBQvCRkL7jFfFgtxh6nqablE+eOuB7uLonZGeqCyM9QqcGDIqUmJLeSXEeTspUFuQp7dyVAqh9wI/aLnPQJdeC/RGaHKDdzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmfub0q3RNztW1O6r7KnOCLyLi/80kYu8jJWsJJeFWQ=;
 b=eqgchKxpbhLNHrivaL2dgg361qdpRsgQqWe6m7ipov3gKCXQEV0gjUr7Ifc5FwRBfvNbCFYFGDDgqAz+fhlavhxW+qFISLfLsgkdJX226TekE8gvqMFUauemeZ6e8T7mQOiOiV7PqdwH8MjLib0VKmu+7teZMJpPXySDY7Nrm+D8wFjljaEN9eaSJG3CS27DzUw80FND4kR3KT/MvaEecwpXYPYZQMWemBmWJxEwGa3DRmjsM11wnpAyeamL+liGmjB6efdV5Bnm9455/jbny6LW/I3z7IrsKwD1Nb6UpWLa1RI8UizuXpKfvr1cqfbmo/k83IIff5VJz5mVi2fiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DSWPR11MB9845.namprd11.prod.outlook.com (2603:10b6:8:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 19:01:54 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 19:01:54 +0000
Date: Wed, 11 Nov 2026 14:01:45 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
 <matthew.d.roper@intel.com>, Lucas De Marchi <demarchi@kernel.org>, "Riana
 Tauro" <riana.tauro@intel.com>, Arnd Bergmann <arnd@arndb.de>, Matthew Auld
 <matthew.auld@intel.com>, Shuicheng Lin <shuicheng.lin@intel.com>, Armin Wolf
 <W_Armin@gmx.de>, Zhanjun Dong <zhanjun.dong@intel.com>, Michal Wajdeczko
 <michal.wajdeczko@intel.com>, Piotr =?iso-8859-1?Q?Pi=F3rkowski?=
 <piotr.piorkowski@intel.com>, Tejas Upadhyay <tejas.upadhyay@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: xe: select configfs
Message-ID: <avS7mZMrS7nQv_RK@intel.com>
References: <20261026102603.2045493-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026102603.2045493-1-arnd@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DSWPR11MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcb72a2-bfde-46eb-30aa-08df4026401e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|7416014|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261009221227099003|261009221727099003|261009223327099003|261009220027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: DxqMfI2aJMr/J64MsMYtqq4WF9PJ0WFMfk00OyqWWJGpUcKNkJ9IoSXUarPwQg19seFPcufiQaLwvinm9YCC8FZ0JWEFuuWZeD5OtZwRBSBwgl1GNxdzJW/nE+xcZL+eziqDlbB6bLHXXrcAFwJ7dUNGXrpen+6fBAqJI29ZW+dKGAWuTjReWklNinkOVUjvpRi71UZOkgky7llfI+hFj2RTJUf2z9GOE1vjssmhd7VPGpC5RhS1S54FWElNrGScnzcDRK1Ik7xnyNLVAiAWiKXvis/CXKD5/zDvn2vTGrGjycYgn2l54a20fX+YcNQV77Db/gmFxbZQbkSTv/X9HhmTZ1iYz+vqyoXvUtefHKtaRFkzgmTZcDV8NLOk71A5AdavqXUfUe6lgO21KxMxp40Lx08qzqpiO6uHzRazNkRDH/qvmCBq9hIDEyCQYnykUfZpmijKNNyFLw5eDbaMLe4s1UC9n5nP7m7Li8E73dBEwbM7iRmd1ZAKxiBCjj92tW5Ec6Bt0kaBEzRaiTTgWMexRQntwS8SA2xHxjE/GOf27stDsy3+0uivZPledCg+1U3On+/SZ/NsI95G/o2Mgpg2hiK4Zh5W1+92a0iM+UIS1Z9ZAf0oM2usKjbuGucboAMnKnAi3LY7uL9HrXae1o7kOUChL4kAnuJEB7z1Y5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009220027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ndaxp6aBohmRRZZsrAdvfazQn9YGFLuENTK6SPk4HSR7OX8E3f4vZCP0Xy7t?=
 =?us-ascii?Q?v4gTZSJVULeZqQtSjsnHbZXXQxa1jYoIlNoGb/jo7vbEhmYWWlbKIt00GjpV?=
 =?us-ascii?Q?19CHvOX5eayBhun7aBREMxyC8qndgrj/tinb/PPxAlbHuab2eR3SygbusnUp?=
 =?us-ascii?Q?Y6tw9/ieZMAYeppwij8X54Bzli0S5gc2urCNmDUS03sCBylK6PN14c1ARbZh?=
 =?us-ascii?Q?9uZJC9ZcofODdxlpVXfG5Z5mb28z25eRhj+/BJm7skxgSeuFhlHdGXyNiyeP?=
 =?us-ascii?Q?qgSUcWVn5xS+M7FSy4HgbFBOiP/tuZNsxqDdFR3Nb9Kfm9Ho/rXJt5880cUZ?=
 =?us-ascii?Q?oZ8nrilfJeec0AHcSxHcVwINbbSxUZaW0DVtQVPGcq3MWpErSouCaC0Y8Oqs?=
 =?us-ascii?Q?fpbWqsolV0S1MLjaZbDVvbYAX+VKMgHk4TY3nb6ypX7TKTCtu0SuUT3hQZB0?=
 =?us-ascii?Q?AEDyZQILhmbT2U+3V+cd8Up/QfaTNyyZuzNmTjDgxDu2PMKM1V3/ubp/DVti?=
 =?us-ascii?Q?BM3JVqTn+q5VdQ5G2WlD7SeunzebTMtS2FLtSdDNX4TeEYSPEEoz8mPFpnXm?=
 =?us-ascii?Q?9cg4aums5QBGtxJ3MBIaSm3x+uiudiibEPZuy8ivtwfNiijQcrQqo0Ii3aqi?=
 =?us-ascii?Q?oRAX0CXSJfQJNEDtvNW7I0+TC/53n+angHIxIM8wqc/8onMCYSS5N6y1qKjo?=
 =?us-ascii?Q?iLvhH+qHJZfb+FRgUlhkzjOqnNJS7icTnBIqKpUc2z1Mjf3iwoeGrpq0oXT3?=
 =?us-ascii?Q?z45tfY9bi58SgTK8uQVTO1rHdkPFNWpXZT2BqzrS7Rd+WX3qg5TaA7uJMQZi?=
 =?us-ascii?Q?AxgTMrf8qf9jnMBNc/xAkzCIq9vkA3LON+6soAyrpvMiHck1NJAYHlk6vXad?=
 =?us-ascii?Q?6dDawMX7dV+ZuRwmDbXa5b1W+Ov6JnUf8IC+0jTaCcVsh3IPa4vgwwon5RPk?=
 =?us-ascii?Q?SEPryri6VFrPcel8QBJ3TyBtCD8bUZY4BSA6hQJw6XP1XQpEikJiUHouGZ0o?=
 =?us-ascii?Q?ckmVFfKln6ws/AESJDxD2oJ7IGa9biNqa4JftRqkWyQqw8l/rF6DDbVzZdjb?=
 =?us-ascii?Q?gVNtnunnKxW5GmN234llzCabUQ557psJo9Qmg/L3Q9G0m3TilDdvgMqcah6a?=
 =?us-ascii?Q?vkG9QRPO23LttU5/JgwxDYSrC5czJgBoVr9/VpnlmX86AayDQZZdtbB+sHAz?=
 =?us-ascii?Q?sVnZoIljDOZBxfu9MelTvRUl94BztciaIbPGzvTQ/xIqpfX3hka57Ujklu3K?=
 =?us-ascii?Q?vHVj1SackWByWU4/DgoCL6/HUxci58rVELpqKHCF38B6rk9ZBSkTWxKpdPIQ?=
 =?us-ascii?Q?GN8GMGFOpEeRbs/anvHvNPhjSQCc8vdHkfYiyXL4yG0M8517/azYTAfIdQwr?=
 =?us-ascii?Q?GEJZ/FB7PbVNhH+3UAPbuc8X0ZpfiAptCMjhBNdyfdhIKDKa9iuFWIHHfm6A?=
 =?us-ascii?Q?RVAooeAKRJyj4ON3Txx9mZdQyuIV5FjIDOsNzRzqjJekXK8e5jn52mlSPLxQ?=
 =?us-ascii?Q?soACBkDLmXfIicZwqeS/V5fMyU7RpA46pldYrzMhx9SLjScPmYJdqjIcTrT7?=
 =?us-ascii?Q?ra3uru+SxhbCCORAxw0SPo1y/iG9SS5d4J5IzgLEKWKqQaOfmspIWR6wGh/W?=
 =?us-ascii?Q?8HOSJpBkz81yDZ+wJgwoNGSHOaPaKDbkmvpiKJxPi7T70gSSM9TismBgdeYA?=
 =?us-ascii?Q?2Iqu2t9/keSGG3DVpigA4+WnbhIwMQo3K1M/ApXpfUyaJTIf8FnCVDJ1YWqa?=
 =?us-ascii?Q?OUa1xNJngg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hJGEc0wgvlQeuhsVq3Rts4nmkwdQViikIAySyWMkGGTWEsAtLuALqAtkIT62iUESV3MjSSdFpq2rAWZ6h27kfYSB7BdFABg3Tszxi7NjMfUCu8WPSVt7/HvLaLnCsDESfoCnCVWA85QEHWFKVPeT1MsWwnvl3H1SY0C4kw3d+M9/5MR2Rye57fz9dQS/YWeiohRUohWE/XpRmEcd+Juui7YNfIa5DwBCUFGtw1H5tCYDpPhuVErPTofooMX1rBKGkcM+5ogWuuTPg3BAv6iW2W+lWJtU1AI7bPx6aYz5oqtjhv1czQ2UHsikg+ZsG8m69+jnW1Ihw8bJO0MKEJ+uug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcb72a2-bfde-46eb-30aa-08df4026401e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:01:54.2574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HhdHtXzTt934Y+S/FIvdhP8Gj7EF7INGZSZHIYXBKAx+rikex3G5A3qiXZkkaxdTCK2jR3FEUZM1W/II7P2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9845
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

On Mon, Oct 26, 2026 at 11:25:50AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The original addition of configfs to xe missed a compile-time dependency,
> which leads to a link failure when configfs is enabled as a loadable module:
> 
> ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
> >>> referenced by xe_survivability_mode.c:224
> >>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a
> 
> A recent workaround added a 'IS_REACHABLE()' check around the calls into
> configfs, which makes it link in this configuration, but this is generally
> a bad idea because it makes the actual behavior inconsistent and confusing
> to users that expect configfs to work if both xe and configfs are enabled.
> 
> Use 'select CONFIGFS_FS' instead, like every other configfs user does,
> and remove the unnecessary stub functions. There is little practical
> difference here as anyone using XE graphics is likely to have a complex
> configuration that already selects configfs anyway, and the link error
> or the IS_REACHABLE() would only manifest during randconfig testing.
> 
> Fixes: 30499cbd7961 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
> Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/xe/Kconfig       |  1 +
>  drivers/gpu/drm/xe/xe_configfs.h | 30 ------------------------------
>  2 files changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4fc8abdc5cb6..b52a8dc28f97 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -11,6 +11,7 @@ config DRM_XE
>  	# the shmem_readpage() which depends upon tmpfs
>  	select SHMEM
>  	select TMPFS
> +	select CONFIGFS_FS

Perhaps another option would be what Jani had suggested:

config DRM_XE_CONFIGFS
	def_bool y
	depends on DRM_XE && CONFIGFS_FS
	depends on CONFIGFS_FS=y || DRM_XE=m

But anyway, we are depending more and more on the configfs for
production choices. So, let's go with you select and close this
for good.

I'm pushing this to drm-xe-next.

Thanks for the patch.


>  	select DRM_BUDDY
>  	select DRM_CLIENT_SELECTION
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> index 327b648944ff..d726800de26a 100644
> --- a/drivers/gpu/drm/xe/xe_configfs.h
> +++ b/drivers/gpu/drm/xe/xe_configfs.h
> @@ -14,7 +14,6 @@
>  
>  struct pci_dev;
>  
> -#if IS_REACHABLE(CONFIG_CONFIGFS_FS)
>  int xe_configfs_init(void);
>  void xe_configfs_exit(void);
>  void xe_configfs_check_device(struct pci_dev *pdev);
> @@ -36,34 +35,5 @@ u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
>  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
>  bool xe_configfs_admin_only_pf(struct pci_dev *pdev);
>  #endif
> -#else
> -static inline int xe_configfs_init(void) { return 0; }
> -static inline void xe_configfs_exit(void) { }
> -static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
> -static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
> -static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return true; }
> -static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
> -static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
> -static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> -static inline bool xe_configfs_get_enable_multi_queue(struct pci_dev *pdev) { return true; }
> -static inline u32 xe_configfs_get_migrate_ulls_period_ms(struct pci_dev *pdev) { return 5; }
> -static inline bool xe_configfs_get_disable_vram_page_offline(struct pci_dev *pdev) { return false; }
> -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> -						     enum xe_engine_class class,
> -						     const u32 **cs) { return 0; }
> -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> -						      enum xe_engine_class class,
> -						      const u32 **cs) { return 0; }
> -#ifdef CONFIG_PCI_IOV
> -static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev)
> -{
> -	return xe_modparam.max_vfs;
> -}
> -static inline bool xe_configfs_admin_only_pf(struct pci_dev *pdev)
> -{
> -	return XE_DEFAULT_ADMIN_ONLY_PF;
> -}
> -#endif
> -#endif
>  
>  #endif
> -- 
> 2.53.0
> 
