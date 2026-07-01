Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3DBC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D358210E2C7;
	Wed,  1 Jul 2026 00:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YkQAV6I3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38E210E2BC;
 Wed,  1 Jul 2026 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782866847; x=1814402847;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3iiBk4NuNL5YO6GN9gLMi12UmeuqmmLsBSGM93duvJU=;
 b=YkQAV6I3V4MOuI2t6rYYZwJmKCi8cJfarPHIrLK5tUpBSxVj/wP3ezsu
 tuC4EWomaR68hDb4qNoTPiXZPgjfuCQcSg0Y0A+1HEoKOaljMAlz16ltI
 s9VSmnuJSXCiPWV9P3rCEQBJPAhoGa3mOoa/srp6TKxhUZRLYGtfmU88i
 Ck9RtmxBIpnB5PrW3oyPmAjQ8OylRUxzcyruxTzVSW2/Gyw3rXFHb0c8O
 udbyV6abpGyXbWHNG31N1gupHl8SDB37ZhvbgtUtA96iFE6ylXHgPoG1j
 JZfGDAydd0dYR4g0rjtPzZ+1qnENRuM49TWqgWvNCRiF3vrrcyOViWEZe w==;
X-CSE-ConnectionGUID: kObfQwp9QMu4lTNS2bo2/w==
X-CSE-MsgGUID: Mai0UoG8RD6BsiJn5FEQVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83462658"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="83462658"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 17:47:27 -0700
X-CSE-ConnectionGUID: fJpYo2F4T0S+sOrS9c7J7g==
X-CSE-MsgGUID: kC4wQkDYTA+JxzguHS6YvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="290537689"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 17:47:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:47:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:47:26 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhGZmvwTRPeO32wkvyu5JPL+iRlJEbN2JJYDvnq8KPYkEJN/dxXf4rT7fPlWV6tSBqEwbladIznqTJoxwio5/urA/jNKHgRKB2Hl1bsdsMgagDOT452c6rzVCieVWgFrA3jacEeUuCz1rDzw5B3unl7U9Q+BWTQ3gXKYDy5TYLCppN09N4j+4oUp0q2pS/LeuivwOV5rfCUFpvDWynIOwomk6H8AyvSgydGC7i63aSfYfOT3SDxHQJwkH3ebBvzao7otnpRsN1e5QwRA59WkvMgF8rdBHF67yjh2U8KZPP5qwlNf2LeULxav1bLywDErJphIWAmNQ2/bdMY64VRiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxB+dC8Ex4dyg7sfNu/RnZSVtRfdzluLRejLkt8lFpw=;
 b=FZm95QwG1vl2xYkvLncjiKl1vTZXkaLVrAj8tzITtCuOdH4HN7NLUfTfHP9BPvHVWA9Gi6s0x7wmZhMbbreI2Cz7buQDkU7TdlESp6Zlme9R02QH08PgFX5YDX/hMuKhjfFaUg4g1biNQD7yfeYKNAlWfPRguV71C0l0a92Y/Lu39JOpWlEMrNs9CL1QoUJ7Saw+uVGJopKb0kM2ejpC2obLthi3dS6x95X8XwMPLKfq3LHk9erFUK3zBPFjB/LoNX0mXEPKn0O0TNTPXCJdXkgp+KH9xVgfWsKWM2be6JTDJEzFihGxPFkoxPaghvK0qSvRP5bQYeKmGuz9LdD3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4608.namprd11.prod.outlook.com (2603:10b6:806:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 1 Jul
 2026 00:47:23 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:47:23 +0000
Date: Tue, 30 Jun 2026 17:47:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>, <Ray.Huang@amd.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] drm/gpusvm: do not route system pages to
 device_unmap() on IOVA unmap
Message-ID: <akRjmMl21Q3t95/A@gsse-cloud1.jf.intel.com>
References: <20260630070859.372954-1-honghuan@amd.com>
 <20260630070859.372954-3-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630070859.372954-3-honghuan@amd.com>
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c693c13-2568-4bb5-5434-08ded70a5035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YFdprWSWIB1BwO/db7VRGQ/44jAVGu5hs0+ShQhVv7rO6elWDPfFBtrlsHCRnLoAHxBUQR2saopfOIGcZb2+ymwpMWUachzXSu7TLdCSkc584wwlSRS2DMqgXButvzbGtF9PLuPfdw98r1xb1U6To2TVt3urfWxJE/nd3HDm5BmsJM58eNIzZGgHxG/Ca5TwXTxEkjviM4h7luH+a+v69Sw5DHsneupShW5S0aZdMUlKXCZyr9k0VNpYGHuzU81YOeTqsB+sJw8Ruzc6pOz0HMHDZrvybmSCPDNlCtRUYP49fa3F+Lkb0BDNJwgkAu+4MOHzqoblQKqJdkj3682ALoVKJWNdXLP79TxIIFGxz3mDk0NF5CXlQrM6+4dZoX2FmyN5NRDjm6fNoXDcKg/DDSmV9MMdCAfZbHi7INGWppXe6Erf2xP9V4iaI7OaY70xJiqkOyjvrfX5bDCdzTK6GFVhxMy4Y5AiVvt/R/N3DaTslH/mrFXCkEMdWSs0EHEOOdNhc7ZSBLJUoqZbliQCZt53KYtouyR2dF71yfKxnt3cZ7v7j47EZnMCtXKppCO4YjkvdEqjuGHq1N5t5PS7syq17x1DAr+MvymXlRs+lnDXoYuSsycBzBR7sQfZUjS+75DUgHLsCrB7NBccTlz+Pt8RnPFZ+8NluNzF2c5s0o8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izm/WiBrqloiIMR7G8B0fBHghn8obMz8B7FixTh5Hqw3Mc5YOP1Y5bSmxqPu?=
 =?us-ascii?Q?y+H9pOOxiKbVsQb+0sf7zWvAw61hFWDeb+3O0pqozAR6IN9DtHej8lmJ444/?=
 =?us-ascii?Q?TopcZX0oqEWtFIQ5yw8peCUCVLoGzXjIIl2NDS0QE2QaI1qxVxSKQQtv9RTY?=
 =?us-ascii?Q?5JE/rMQ+983IYUoM3WM2IO+vAHJPNcTt7BqNKFzjohm5tQVWpwEFK5EzM5Fk?=
 =?us-ascii?Q?rVZquttG3GIS021vsAE7zeaQ5kv3z5E+ZUbtQahAfRtl6hkKcE/pNCNr0boN?=
 =?us-ascii?Q?Z5Fcc3XGrVcONU1G28LXCn+/24qGXv5WKxUkrR1WeIBUMrcgcNe/9L2rqhUa?=
 =?us-ascii?Q?WDUXzSgxislNu7wOglLTP22BVLniH8rD2125DjO0/sSXle8unF7Mkp7WvsHW?=
 =?us-ascii?Q?CN9PbYCDjc2Kop5pQPEVOh+1IDHe5DJPAg1vjG7EVDQwkhOSKqmq8tPsk+py?=
 =?us-ascii?Q?g1dZO34j2myz4mE4q+S0vtlviPtQ77acm8iWgOJ/qwYcwIJhlxeHdN55cxV5?=
 =?us-ascii?Q?7ZxUstkVhOMNlwkFZzdOywiluU48drTSE/zU5wGBB7E4A/XxRZ0xr4IxEUxJ?=
 =?us-ascii?Q?yotLtEzSvZ/QuoAflAX+FB3kHaDEH+j8MQEwebeiKhbN4mz+df/LcCWLu69p?=
 =?us-ascii?Q?BGai4GRP0wxAC6c56ZVN0x7OorYe5TKUnQ62Zy8a9OtidVSD/Z73qEaSKjEn?=
 =?us-ascii?Q?sCzikaMJk21FOGnrdu7HEJTWJO8PjRgcAlEcDoRhJSAN1bWWG34gfNS3L/+c?=
 =?us-ascii?Q?y9moP7/tUSV/lixVkHuEkKAUs3eYaXukSeWSM982fcGuYHo3lSDztlaaeXfs?=
 =?us-ascii?Q?/oCidE/7txl6VyWqcnd2/+tqkrrDMQrWvG+VJeuqoW74/LNRi85syAYUq4r0?=
 =?us-ascii?Q?c0/wjSrncxuxvA+ugIC734AurLdz+xvRxNs5X5Po8Dm981I/4IfCeJK2DB0D?=
 =?us-ascii?Q?fV3uKBUFMZvq1aUBsOk+t2N0hSPBE9FoKAmTjpnVn693+l+SDAy7FuN6EbdI?=
 =?us-ascii?Q?20q1C4jta4cTuJ/Tpq5dlLxPEM0wpjoUZVbvEP+cknQ++OQUNpRqrUMa99aE?=
 =?us-ascii?Q?UBT0tcfmxtXPg2EWVZsq4w5+avnDjD1XBxrGkFluC4pfpiM8vJ0346IMqbZa?=
 =?us-ascii?Q?b4DY6Is/Q6TCeVc0IvcEfOyOXEl1WbjoO47welV95/PPhsnBRpwY7hlrJIfI?=
 =?us-ascii?Q?uKPosYCttElyXkcc5MELJ9wzTmoKZJpkQo+URITCAG4I2wbe38sH2hBRX0Vs?=
 =?us-ascii?Q?/YmCABrX3Zn36lSH/5dVusg7R9m5blpJPcMaBOO1OBIE9bytYyNQPNij/3Bq?=
 =?us-ascii?Q?ZCPIZpwfLzazrnsFDPuipwrmgrkpTpetuK97eGvPFBSTouawyroQlOq20lEd?=
 =?us-ascii?Q?VAJvMixQz8hp4SIN6cXzzOE3eyo9InpeG1OkAtnQ/TxJcBdfPFgsCZtig4PH?=
 =?us-ascii?Q?bneQMQMVhdDR6lxfM335yMws0fPFJfxe+CPXDL6gnAZnTcduomZjWdCzPiZL?=
 =?us-ascii?Q?qkFAEkQbIbHU8ofaLB3uWHfCLKyuFp7WtN5dhGt/VcLnIgccP/4H+pqUCFgc?=
 =?us-ascii?Q?Dk0l0LBd0u4Tdid2QG+2XjGhQtlstwYKQjhzCzMR4dsFjsZ5MpxbburznMrH?=
 =?us-ascii?Q?8yZfRsgOK81EXJlzQyI9RK77XdxqI0GvAPgwdWkJHBuhie1WlrJzEJA1u2/O?=
 =?us-ascii?Q?axS5uRCOEtIZ3AOteV0SXDrBrpCt5DbORZH/ak43zwrRs8hFwWzF1kJ8bh65?=
 =?us-ascii?Q?i42OVbFSXA=3D=3D?=
X-Exchange-RoutingPolicyChecked: RHJsOOl+iuoylIBnw8pWD2WFJj9nYbTsgUvi24sTK7W3trSoCkKAt5mdtKZT+GS+ykDPpjGyZ4uAKovOASvF7TU7sjDXD0B25k9V08p+igsUxdxydo8ZhVWuIGD0YA7H4xHWGTH4j754bBLZ/GYPzzB1h/qy1hGDqsAytfjEgOsOggcr6yBnxvx5JFmOTvirjedFEUJlczzyOlmRRK8ovDOPtRXKWm+q37Ay3shGd4XtHoNqFCX9VthzoC+NgjaXzJysTjvSIaNeYUN1rfZ4DbexltukGx2WRNTo6mdVyKQ9IQbQm37WdhlJ2JHbhrc3xGlEhta3B2WprXg+WtWdpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c693c13-2568-4bb5-5434-08ded70a5035
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:47:22.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNMdhHuBIvzLmR64wgO0f0kiE0jZ24CGaCWSXMmq63EKejE+tn7k54XiGfJkhLNs6ikusjkfn7HB8D69fBI4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4608
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

On Tue, Jun 30, 2026 at 03:08:58PM +0800, Honglei Huang wrote:
> In a mixed range: ctx->allow_mixed dpagemap is not NULL while some entries
> are system pages. The unmap loop used:
> 
>         dma_unmap_page(...);
>     else if (dpagemap && dpagemap->ops->device_unmap)
>         dpagemap->ops->device_unmap(...);
> 
> When use_iova is true the first condition is false for system pages,
> so they fall through to device_unmap() and a system DMA address is
> handed to the device specific unmap callback, risking invalid accesses
> or state corruption.
> 
> Key the branch off addr->proto instead: system pages only need an explicit
> dma_unmap_page() in the non IOVA case, IOVA system pages are already torn
> down by the single dma_iova_destroy(), and only genuine device pages
> reach device_unmap().
> 
> This issue was found by Sashiko AI review.
> 
> Fixes: 37ad039fb367 ("drm/gpusvm: Use dma-map IOVA alloc, link, and sync API in GPU SVM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/drm_gpusvm.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 3145d55cd86..44bb19658dd 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1163,12 +1163,18 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  		for (i = 0, j = 0; i < npages; j++) {
>  			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
>  
> -			if (!use_iova && addr->proto == DRM_INTERCONNECT_SYSTEM)
> -				dma_unmap_page(dev,
> -					       addr->addr,
> -					       PAGE_SIZE << addr->order,
> -					       addr->dir);
> -			else if (dpagemap && dpagemap->ops->device_unmap)
> +			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
> +				/*
> +				 * Linked IOVA pages were already torn down by
> +				 * the dma_iova_unlink()/dma_iova_free() above;
> +				 * only the non-IOVA mappings need unmap here.
> +				 */
> +				if (!use_iova)
> +					dma_unmap_page(dev,
> +						       addr->addr,
> +						       PAGE_SIZE << addr->order,
> +						       addr->dir);
> +			} else if (dpagemap && dpagemap->ops->device_unmap)
>  				dpagemap->ops->device_unmap(dpagemap,
>  							    dev, addr);
>  			i += 1 << addr->order;
> -- 
> 2.34.1
> 
