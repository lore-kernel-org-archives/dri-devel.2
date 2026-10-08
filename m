Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E869DCA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A66A10E8FC;
	Thu,  8 Oct 2026 16:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CdH3rgWf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A3010E8F2;
 Thu,  8 Oct 2026 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791477828; x=1823013828;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ah+nBHm6ENaPDrq0AGXeZHhcT6sqA0Tvn2QUyEUfiKg=;
 b=CdH3rgWfER9Q3wkRp7pQlBN4mt7uOVLR8I5WNBCe62HegD9dh6wGS9y2
 SdvqzT8IfplMXtUXc4dIscSCirlzoR4w7Elgg9YZ7/0LcKD0qXW/oPRpU
 W40WP368gGHhyMF6t0523olXwo+fC1sT6yMtRIYizmLvicMKK/coPtgUG
 XV+qgOeXt/aC2LCv8N/06AYNvxGikuhl+bLDvxWCEdI+EggUQFwuuHFRP
 EsrnoaIw9NmK0XrVJ7FOw20sMjBl5n+fmHUpZn88+YqSBzEjCA9XTjL35
 xyQY+Eot+kv7yJrZSp0dHoBcWQmbvEM1eBFl7MCAQuLwS/Z4WlAgLsn3C g==;
X-CSE-ConnectionGUID: TKccxMslTsa1JBBvxtvxJQ==
X-CSE-MsgGUID: DiJHA9YFTMKVN0u54exF8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="266955"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="266955"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 09:43:48 -0700
X-CSE-ConnectionGUID: we63pzRQQ9eEwUAnylByOw==
X-CSE-MsgGUID: fGJ5S7dhRrqaaqu1ojflLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="425071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 09:43:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:43:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 09:43:47 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxxVmHRixT+NjRUNHncL611mFGda7sRMfZ39bk/fsNOhChTVk1dVHwJexy4fOqffUCoAlGEmLS1r1vM0qK+Zr7ZJflfkNLpZQKooHaRnxVK2tCSwl7oXbnYT/uw4L0erlNlqSicz0mDD2DUPADyTU5z2+G0IOOMUbW6PhtOvlxSXS2zKo2pHlvRGDFMx+p5BFd50QsT5u7TWDH+v2t1ezuVO6h7HhUhqU2eaDkCujLnLr3WVHBB6GFf/T6FdDT5n4pzK8Ku1tJfrZIb9zE85WpGM/adYmte5lMesq4pGA2dtHLHG/c6/UITyZyXDFLjpa5QoKPWQkx6BnNiD/sLYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOec3ToNkfgAZwxOGclUc56UNWlRD7STW8jWwubKn8k=;
 b=xX90O/cngwWl0nrHqqWXPQ1BOVwS/7NOaJSKIYqvfFrW6LOB+6I7KzV9T+gOlJ+hM0cOxpo476/EblLMKmKPnYqZw34yKIz/rUJo+ktKjtmwTZA8pF/Rwy+YLGxhhyp47wbdBImxLTzAX9Gxi4EFgkmpMWlchKQfWMVHmV3jsEYV2hr6M1Ue+Hz7itlgxbmmvae1Gucc+rYmEHfU8yhQFZe+lZrcZY5OzJLTL44RAjGwGWexPd38zei/FVPYWCNJuwzYo1aVKCT5i7NxtSq92TYG12VvXU3RjGhcTtWfOLE8C/mjpvUqqx/lpUiRs1rePcbFcqNCEZLDmLVEK8pshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Thu, 8 Oct 2026 16:43:44 +0000
Received: from DS0PR11MB7192.namprd11.prod.outlook.com
 ([fe80::c747:a502:4a7f:f5bb]) by DS0PR11MB7192.namprd11.prod.outlook.com
 ([fe80::c747:a502:4a7f:f5bb%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 16:43:44 +0000
Date: Thu, 8 Oct 2026 12:43:27 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Menachem Adin <menachem.adin@intel.com>
Subject: Re: [PATCH v3 2/2] drm/xe/nvm: define survivabilty partition
Message-ID: <asfIL5FsBKiL0sUx@intel.com>
References: <20260930-cri_surviv-v3-0-357aeed5fc60@intel.com>
 <20260930-cri_surviv-v3-2-357aeed5fc60@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930-cri_surviv-v3-2-357aeed5fc60@intel.com>
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DS0PR11MB7192.namprd11.prod.outlook.com
 (2603:10b6:8:13a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7192:EE_|DM4PR11MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3517f0ad-c5f0-4c16-88a1-08df255b508e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: lS/UXi0hX0FYHmalkI3EXuT47/JaBoP65Oknzdy+yN0Mg2TEusRcz4IsMOvsndH1+ZbcUxUTs0i0weVfQK5KTK6ZnbbVgcrrwC2xseNYXb9goVLwhdogGYmvKkboB84IrgtHjrYpAWriTjwuzzoCpKSAWP9lGwN0PCNR66zErgu5bDthlAq2NLu3g2yRKSnYVeKo4JYJWomwOseggwllBMrOnBeaSAX370PQXHV+LGnj7Cth/QTVDJ38qHHGGYQIXcsbDFfLoeWGtgrcdOpeZvTSKCCS20VWhMEoLY+puEsyXOe63d3ZZFBSuTddzRyPIgCwBL7nO/PzVkG3EPuauywiB36Xz/fDZkgZxxCidBb60xk8iNhWRTkISEvroNvgE5VZUQv7gtYp3FaxIrPrJZ+VtD7Nd0OfIYcvb9AcMuwF0/mmfi7P06QB3kQeFszjRc2jf9mUHWF1DAlFJGqFv4cdJa9hNwoSTvPSnt3noaAyh5Bd7VIILcTX0flhbzGWn0qEQza5AEmxVCY+pNS97UKrr49Sf9xB0u/sYU4arOTsSkaksP7AhU/lmHNECBIoXvgEtFsFakbh+mNTnEF9WGgbuFopm2bgw16ZUbecnZQa26PGYbZkPQBjYfjog9KiDqTfnCXcS1uIs1hiz1YNxXM3VoqeQ9dOEpfFZzpYI5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7192.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H57KMNctd3GVZ6sVcfzECdyng9hPzLHBnsqKL6TPrtwRJG1rDrvps2DPs4MY?=
 =?us-ascii?Q?nQREw+qi/udb1Ix+/8SjH4WPWqjeWiZmW/gtoLrNPH7A2n2itcAFTYUSvimE?=
 =?us-ascii?Q?224Vx0jygURCziOaAAV7lfxLvN47S+0FKDs9WIZonh8UwdzS9RKdMQUjSE95?=
 =?us-ascii?Q?e3fNZFpFV8/JkPzhHp6n8yAcYhCTpk9d6ApA44H2d2/BfYrqDxeQ36RhWQG0?=
 =?us-ascii?Q?PMKWr2F93Hi1Hyp5A2D8PwW7Imdzg19aPF208Wqu+ldE6R9Iz2m9vCXKclrB?=
 =?us-ascii?Q?O5vtviY/Z9eodmO02QHiUYX3T0l2ebDb7BdDRB0ax5RyxrWKuYJFPCWOYEdQ?=
 =?us-ascii?Q?CCm4ta8WN439jLLuQdtRLakeKf1lsiXpxyRsVwUvVKTXTjVBJ+18H8n16pBe?=
 =?us-ascii?Q?ntIL6Gfe1kl/Kt6R6UokRV3lfT46ojAVIVRRVyu9taqfZWTBdR0mZ8/QV7Dy?=
 =?us-ascii?Q?JiRg8MIGTXnIcYDySoB8qTc5q/JNshoLttthNAZwVUuu5qenD9Bo7FD8L46n?=
 =?us-ascii?Q?jkI3r7r8XI8XEZB7PkKqlktYnMhBd3cXHPYvDagB33QLvziXupk/R7geOr2L?=
 =?us-ascii?Q?MedJiXDJuKSlfdUkZXMN7nLndl63HDkW6Bqx7jkazsAQOT/jyeoA+9qOLCwO?=
 =?us-ascii?Q?a97MIohATxifVMIPRej0GJqTZHEcesor6ElVXGc2UfRjF6bAwJ+F74GOFxlB?=
 =?us-ascii?Q?rT+vlqGZbBKqCrKb9qJym1cs3WfhHG5SoxPQ03wRK+K9hX2Zg6vjh47x5Okz?=
 =?us-ascii?Q?68duoowPVvbquyOHP/yyxCgVClDwJgAbWbpOUi1qChvziXOXSlznlBAVjv/o?=
 =?us-ascii?Q?+cNliw6MwRYYz/EII5MV1nUI5znTP8lDOWMVANDbQJwhyRPJ7llxgYCNLxUZ?=
 =?us-ascii?Q?eXYyQy/X6eVXBWMHUM97jiobcvoJ/Z4SZ1dNxnmwZxHvr9XTaVcqh5lRO4Ch?=
 =?us-ascii?Q?/n2s+2LCoJT9Cdjbaa5kqGOSniv5w4gogPZOJg53D7Vn7dOpD0g1PH1wQiSC?=
 =?us-ascii?Q?OilO7mz6s0F5iCMkaIUCXEDokhpnRYrlJ31XLOmgqQfGrBAi2Ry57+8RQzfa?=
 =?us-ascii?Q?C/QFBW8U3At/6wvHkelnEVs7DgRTJ4RACk4+BIl8i3Y8lzhhyct2Zs5KpV0y?=
 =?us-ascii?Q?rU3w4woDnMyiC0sZwbUBDC1Xz+TB4XFJOFw59Yz+dJve5/AIynGePdSAyXS0?=
 =?us-ascii?Q?kIv6gBKiQvfXrkrJY4uzxpj36cem6oJZ9L2Uz9+MOnNWTFFHFtP0zz7qnJtQ?=
 =?us-ascii?Q?pfjI2XxRDmjgjE2nN+ZQFptCBNjdmRwDbpKHZK1hMj2oMPTbotpXf0jg3uAq?=
 =?us-ascii?Q?4leScSgQmG23mQDK0BJh3qNGxmrdD++XqXCRFpvx7iOkU1V9i0ZOC+Cqr2Nu?=
 =?us-ascii?Q?W/XLdEQRRAKTSZ+M0nLJfYGJM4Tdol5gAhiTFu/6H9pjHSYrZJU6E/M+cmWC?=
 =?us-ascii?Q?P+htd0dFStz6o/WR3Gmikhy2/9rZjPw5+6RQk9aYxrckLRY2+78kvJAeTnRM?=
 =?us-ascii?Q?h9RR9LLmozxVeDT3rAvRP0+HkJ5Ghl87s9rvdE2F7PNWEOaD+11NeoeWjXj/?=
 =?us-ascii?Q?ccQGo/D6sgToJVNpBNZpJJqEk/tsQ+MgTeXowabCuOMSTsj46hMkrD+71Tsi?=
 =?us-ascii?Q?9eATTKjnXB5MmEqZFOuA//j1Im1xFhM3HyjrPcbvegQGPgInEhn3Hqou690U?=
 =?us-ascii?Q?6B1/AzuZhCwUvgdpJsi2MeXuKaqDt07AJk8mxGRy2i77Ezf+5J87ttR1Fy7m?=
 =?us-ascii?Q?Ag0q3bdi5etNqF63SMJQ3vslTa/kpD4=3D?=
X-Exchange-RoutingPolicyChecked: w8vsK/pz46WO8vzNKlUaA/1NUvuInD7+Mp4kgT4qWyXjEjIxK1cVjoUuXMMe168oYCrE+sD68FwLax7Br7JDFPB7rU7tQMsCQtSFCWZwY0vji4bvjQH90cTEa4RvbSkMkD1kj+sD81tCne42Gd4Wsr77nG5MOzm0M62MRa6sPKbYpvtTCuN9Z77m4iuAzfRRtKcCy7a6P5WU8Str49+c8hYExHDoO+4y6j1FQxeF4yBPvlkKuXJMGdeaItiYoBJPCthAPLBYwBVyzKGYpkUSlWKLBaTh/ufN6RmnVjk2W5D1PB/Sy6G75k6v263PL4CqpGYG4fyCyfttiMDlgXq0xQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517f0ad-c5f0-4c16-88a1-08df255b508e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:43:43.9767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBX4GWGfSzz8AvIiTxjsKhqRsY84hvgAx+kIf9MyyKmj7kL2e7B9mtV4Ba6UyN4dwtTp0xaZeaTb27GMb571Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
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

On Wed, Sep 30, 2026 at 05:14:47PM +0300, Alexander Usyskin wrote:

typo in the subject, but I will fix while merging it.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> Define 8M survivability partition for CRI when
> storage is open for write override.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_nvm.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
> index 51a1a431ad85..783c3103a8a4 100644
> --- a/drivers/gpu/drm/xe/xe_nvm.c
> +++ b/drivers/gpu/drm/xe/xe_nvm.c
> @@ -56,10 +56,11 @@ static bool xe_nvm_non_posted_erase(struct xe_device *xe)
>  	}
>  }
>  
> -static bool xe_nvm_writable_override(struct xe_device *xe)
> +static bool xe_nvm_writable_override(struct xe_device *xe, size_t *survivability_size)
>  {
>  	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
>  	bool writable_override;
> +	size_t s_size = 0;
>  	struct xe_reg reg;
>  	u32 test_bit, test_val;
>  
> @@ -68,6 +69,7 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
>  		reg = PCODE_SCRATCH(0);
>  		test_bit = FDO_MODE;
>  		test_val = FDO_MODE;
> +		s_size = SZ_8M;
>  		break;
>  	case XE_BATTLEMAGE:
>  		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
> @@ -91,12 +93,17 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
>  		break;
>  	default:
>  		drm_err(&xe->drm, "Unknown platform\n");
> +		*survivability_size = 0;
>  		return true;
>  	}
>  
>  	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
> -	if (writable_override)
> +	if (writable_override) {
>  		drm_info(&xe->drm, "NVM access overridden by jumper\n");
> +		*survivability_size = s_size;
> +	} else {
> +		*survivability_size = 0;
> +	}
>  	return writable_override;
>  }
>  
> @@ -143,7 +150,7 @@ int xe_nvm_init(struct xe_device *xe)
>  	if (!nvm)
>  		return -ENOMEM;
>  
> -	nvm->writable_override = xe_nvm_writable_override(xe);
> +	nvm->writable_override = xe_nvm_writable_override(xe, &nvm->survivability_size);
>  	nvm->non_posted_erase = xe_nvm_non_posted_erase(xe);
>  	nvm->bar.parent = &pdev->resource[0];
>  	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
> 
> -- 
> 2.53.0
> 
