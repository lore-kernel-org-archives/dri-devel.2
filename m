Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87CDCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5731F10F385;
	Mon, 12 Oct 2026 22:00:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A555C10F2E5;
 Mon, 12 Oct 2026 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791842403; x=1823378403;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xe6FaAjdG0c3WW9s28XXYkqM5DE5mB8msoojBoEFDWs=;
 b=KOGFSEDbggF4v0k18S2Gl88N5Dfb0RxkwhIMGYsvCSLCBlHdjhaKyZUR
 xH4xoKIi8ShNEWNzbgwkN1hnrFtcfX0kN8zzwGuHGufxFxRWxdXvzUUfF
 LdyG2tOFHmEQhGNeh9xZgBt/v8O/CnRO5/o0Et4SJvSQZhJuXRJPQAClX
 MKafUVyjM45mRWwlyHXVZnMtNXywYdHYLxwPFqyjy4WsVyTkUbD7rhCeD
 v0I1wHGvyXQhfYyBjFfIi9rfksAzMKvjpslk4p26i/1BsErmcl5r/34nZ
 Xdi9ndR3nGkww/IM3UQXC+U+iR0I75VDtE113bgBE5k6e69v4Oi2GuhmH w==;
X-CSE-ConnectionGUID: f1ANDZMhQuu8SVd6J/F8MQ==
X-CSE-MsgGUID: wH9yX07cQ1Or0nC5xtdE8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="444204"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="444204"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 15:00:02 -0700
X-CSE-ConnectionGUID: fue3CbpkSYiu1K5vfYth6g==
X-CSE-MsgGUID: Wwaj3af4TcuCVxSVU8jC2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1095082"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 15:00:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:00:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 15:00:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xclvsjg2q7R4Lq5WiTWDY9ZMPKmxbLyBTqG9AkwOKFoseNGanhsUUFZoGtN4vhLdDiDU3By7Mu+IefkvhGxJsUbXhKWfu5MBEOMISihSWSboHm0N3GdyD9iWt7oLTMykY0pgLFW9y4cwShoT7YCWT6lROxYLadAygs1oRvKs8RsGVAipgVIAGMqOt19/oNB2XTt/3380zzG7tp0NdE0vM8Wth6HnU84pZRxrZCVMDm+BOSv1xXRWxQVlJnyS0FzLgvbNG6+3jiFZpYBaV8DYFFKrNo1/zQDwsQS8Qea9hqffM2SduixlxoWTFq7Ngcks+cphhJDXKFCjAmwQu485Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZEksjKEvdcvB9j19wsz/kH7N9mHQl3yNo6PvfgvKQ0=;
 b=iHIESDOdk83fa+N61Kw+AwriLhaMDNdI8VdiEdD+Ohh8cm8dVhnkRtruJMuECqjk+iyHijwJ2RHasX6nRHC8889XN9o09CYgSBxpzbqsexVe5SJNghaGO+tcw4xo/iwfhFsAaSqRUtc8rTZOaBcuVgHW89nQ1uc7t++RFMpTYuRq2xDrhkolcP0940u3r6fOgoRXUvDzdoeZVinMNPzRqmgv50VMhmT5R/PvA927qnLuaNwm9jOsQxktYkmV2LpTKgzoKjz0+i69DSkQAW3mtBe7ewSV2kZERtgp8ahFHXOybYulQSgFgRoRGINs/6Kpc2NAb/xtpzbsMaAjxToC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 21:59:57 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0472.016; Mon, 12 Oct 2026
 21:59:53 +0000
Date: Mon, 12 Oct 2026 14:59:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/xe/dma-buf: Use drm helper to detect dma-buf
 self-import
Message-ID: <as1YV/cwS0BdxCJC@gsse-cloud1.jf.intel.com>
References: <20261012180543.1488703-4-niranjana.vishwanathapura@intel.com>
 <20261012180543.1488703-6-niranjana.vishwanathapura@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012180543.1488703-6-niranjana.vishwanathapura@intel.com>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4193eb39-49cd-483f-ca80-08df28ac2545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: +D0+QEUFEx4fbY8iQLcJ6gNaOFf5niCG8+PlLgDwotGCG27W8QyqlIxtsA0d1XPOYSMeDcRKD2HYFEU66vMITLCB/TuaEc+FoLT9+ahrqCp9jI/UeGNaAiF/AtkQGMwRp9PapXgvJL1ex4hs9xP/2qJWRySKOtoVRLwQo3vuJ/5UmJ6IebF+H1vfIsVuno5szZA1JCUyIReDgww9F5TRc5V7fvkk24uV4PvRegXftbtLlWRMLVb/O1y4wn8+2kuTq7MDms3vsPJn7zn8DNqCgA562brx51eP1Yhc1Z43pp045UY0bp1fAoPXvLeN/wBzrbDlQphfGIZbk+qWlEJaJIUQPkmM7XCL2ld6MDtubF+QyE/k/kRjXlf4GxBPOerEscT11DIYW7LcNNv/VZn0KGKyQ7TgSDmirMN5Mv/BjSGuhzZwa/nunbDBPoUy3AJjnNypw7OggPDsQNg8g715KvBi5s30P9J363RxBVUHEReAltXsAxCPXkg43wVK+zLe56lhWV8GHUz63KNWH9R4YKcp8dpYzC10xLn2gzI+9tC70dUdNdo6X8x0wm/CBgG7y8/YiL/uTb9PxzuJP9ImwLZOAp916VUECgd+lXveLJbU12QzDxt5q1BCx7crUscjM9dX6aqdX4EwV7XFQ9QY/+Tkb4AIOun51QcOEcbb51U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZOFX6BfsWx5m/L0RXCujkdOAILVncsOiTuLxCiBZx1IO/w+Kj//OlGGU3Uk?=
 =?us-ascii?Q?SEKefmgt55fR5AxYKeCtjIYB8aPPfNTVOwx20/luqem1V6DYMxY/nO++7dCn?=
 =?us-ascii?Q?vkz3zisqbxbmJKMuzk192FXQ/eeCQYqqqqLtbgTZapYTJFuUN6d+4Oh7oS0B?=
 =?us-ascii?Q?ut9UCymt3nsgqKuq6NaQj0tkeY+4FJfHtmh4Jo6CvUb7AV4ZIp7eAyXdySai?=
 =?us-ascii?Q?aDWkfhGR3FmHlYL7u98X/pokXlBbFWbeIjou9U9asa/o3ay3rYeRX1Tkj6OO?=
 =?us-ascii?Q?qtKzRANjcg1y50ieh6i9tPcXYzVCT02v3KCo1CDKRvg2YAF5puJNDmTGqGUR?=
 =?us-ascii?Q?4ONnEgFsuaX4S8I0VSLm9nrBWNU++s762oxQepy6m0ccjvZq/Ixk1fJtACjV?=
 =?us-ascii?Q?NhXlUP5zV8tXAjWerAFu90JQeDG4E5xbvxNgkiMso7sOOqD6gm0M87Nz1Kz4?=
 =?us-ascii?Q?NYH23Fi9xaULoCP65EFsd47dhUTNhg0Ju0mThvw379K50a5WZox6YpqMdxVA?=
 =?us-ascii?Q?Jra0t0BkZAU4AYeU9UWHcapAKN2D+8L0/rVgTMxjUeEcig8BlP6ruep3RqgM?=
 =?us-ascii?Q?tk1gIwuQdpOLYSZ4IwUr4bPwcZwSVYs5snSSIYVDFYBGLpAdA11qHyrWX47d?=
 =?us-ascii?Q?p433DBnMzWMLhPaxJ/d3EkbJ0QYjcobz3is2gydeCx1GNw34ToMCbWOZP3JS?=
 =?us-ascii?Q?jlIFyC1Sn+cBgm50I6mwaglJNYonJ1cv6XfPpdIclKbCV2NCrzBzszBDk66Y?=
 =?us-ascii?Q?XrYYpJhd2vUANMbCxvaht3iO8fbxcaU7dwqkOPb0lUbEDxOmDQnD7J3Oc+ug?=
 =?us-ascii?Q?apypydKA179AlZoV7lUPvzUokP/tptdnse1dbL1v6KRgL6xemDjhH8IMoBtM?=
 =?us-ascii?Q?7634J/ArR6QINAQ/IHacLvRqp3nYElUGFbp44r0jY1S3tYf7emeF+t/6NWd3?=
 =?us-ascii?Q?qPB/GSgzX2ZOjPUq4D1zZO5bZs6tzBbGzf3yGjOog14moM4gDeEsHoi7lAnu?=
 =?us-ascii?Q?D9YPwvWNGn9+r+/HAKwXfXjOkZm0JcQojVILo7MKonoiYUkijRsNFd1BpCCm?=
 =?us-ascii?Q?bPdcXClVr0Ayp5ZHJvrYcYkPhjHx7bhWL8I8ze4XTpaWzXW47CqJpsuL4W/r?=
 =?us-ascii?Q?irwuvDryl9+6hSbDnBnrShTouwnr6MRwQCeBFt1YGGkyaQsTIIjh0IX7Gf3S?=
 =?us-ascii?Q?PpSUDKoi1djSggp3dbbSbIlfbJhlqeGL1u3q0aTW744POjmZILYHKeYYVMRI?=
 =?us-ascii?Q?G8Q+mGxLyxS3+X88wf3h5Lz9UWsCzawWj/dPIwtL9RQr6HGDMsznmL4agSrh?=
 =?us-ascii?Q?A4DXYt23xfjvms/A9NO4NbN1WWm/Dg9FwktXjo9FLjJkN7l6ByBapaU3+/rU?=
 =?us-ascii?Q?ESqdTjKSs7hMcXRntmpw5O2RmEodWzeQ8YI322rHWXOJBx9YMxFWIFOomCWr?=
 =?us-ascii?Q?588wshUvXqiybpN0Pb0PWkAZl2r6WUEf4gppa/kv/3TNs4tsWfKyHHMeOhQm?=
 =?us-ascii?Q?hQ1FOM6MUxkbm0Irqg6DJL3CojjE5VjtSLXXyknnjVnGcfvcWn6XxJtN+3/6?=
 =?us-ascii?Q?eG+O1+FCQm1r4nr8bd6+9D2cG/NKEnnRVuV6lHJBaS/+TFvcEO81jkt2nhz9?=
 =?us-ascii?Q?QshFS98zcA8KRVo4LHT8Ue4gWr4JqSO51ySySngBAPuTYpbQOc97HZ1MykUx?=
 =?us-ascii?Q?gJ7K6qo5xG2QrskjYoMYL4o5l8rhg4SrYXesm7hX294+Db1aqMNZeNYKhq4Z?=
 =?us-ascii?Q?2CXR978cG+qCV2WGmrILJjt+ImrW+Yc=3D?=
X-Exchange-RoutingPolicyChecked: DV7ORTa3o6/fLaFibqNWh7pwIaR2jWkABRSzvCDYL/rq4owK4OY+v0qbrrhA13JpmKoJKuID++xhNVi+fi3BjWNkjuq7JOeLCmsUyTaxny8rIhR9srFxc+pTjw3/n8jLSZmqm4QKvTdfOQqdv6PuvM2CUvPbCDuxpahlymPET8Er7Kmu03y++C5ncRtLTPoeKH5KDqwID6uiCPyYdT+CXolODBCzE9sORdQchR99V4XZyg00scNnNtAj2MVkdgfCHwsKk6ibBM4DrcwMWraDcDDvcI3rmx0yQQ/Cjik+FQS1bjSt5xiM6+hjV7FZcQs8QZVFLwoBY5LBDg0bTAuRTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4193eb39-49cd-483f-ca80-08df28ac2545
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 21:59:53.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2k8ztHktTUp6XNCSBP9Sy2G88jFdqQOAiagtBsI3DZl+ygGttlqMLvp8aTUBuuSs8hqYjJUipZ7dwVmZTxx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
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

On Mon, Oct 12, 2026 at 11:05:43AM -0700, Niranjana Vishwanathapura wrote:
> From: Farah Kassabri <farah.kassabri@intel.com>
> 
> Instead of driver-specific code, use the new drm helper
> drm_gem_prime_self_import() to detect self-import of a dma-buf in Xe.
> 
> Expose the helper within Xe as xe_dma_buf_to_gem() for future use.
> 
> Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 23 +++++++++++++----------
>  drivers/gpu/drm/xe/xe_dma_buf.h |  2 ++
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 6a85b292dee7..4e1b447f4235 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -239,6 +239,12 @@ static const struct dma_buf_ops xe_dmabuf_ops = {
>  	.vunmap = drm_gem_dmabuf_vunmap,
>  };
>  
> +struct drm_gem_object *xe_dma_buf_to_gem(struct drm_device *dev,
> +					 struct dma_buf *dma_buf)
> +{
> +	return drm_gem_prime_self_import(dev, dma_buf, &xe_dmabuf_ops);
> +}
> +
>  struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
>  {
>  	struct xe_bo *bo = gem_to_xe_bo(obj);
> @@ -372,17 +378,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>  	struct dma_buf_attachment *attach;
>  	struct drm_gem_object *obj;
>  
> -	if (dma_buf->ops == &xe_dmabuf_ops) {
> -		obj = dma_buf->priv;
> -		if (obj->dev == dev &&
> -		    !XE_TEST_ONLY(test && test->force_different_devices)) {
> -			/*
> -			 * Importing dmabuf exported from out own gem increases
> -			 * refcount on gem itself instead of f_count of dmabuf.
> -			 */
> -			drm_gem_object_get(obj);
> +	obj = xe_dma_buf_to_gem(dev, dma_buf);
> +	if (obj) {
> +		if (!XE_TEST_ONLY(test && test->force_different_devices))
>  			return obj;
> -		}
> +
> +		/* Test only: force different devices */
> +		drm_gem_object_put(obj);
> +		obj = NULL;
>  	}
>  
>  	/*
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.h b/drivers/gpu/drm/xe/xe_dma_buf.h
> index 861dd28a862c..d0c7893a5a6f 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.h
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.h
> @@ -8,6 +8,8 @@
>  
>  #include <drm/drm_gem.h>
>  
> +struct drm_gem_object *xe_dma_buf_to_gem(struct drm_device *dev,
> +					 struct dma_buf *dma_buf);
>  struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags);
>  struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>  					   struct dma_buf *dma_buf);
> -- 
> 2.43.0
> 
