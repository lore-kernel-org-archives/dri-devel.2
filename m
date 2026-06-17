Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE2FCD98F6
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEAA10EF78;
	Wed, 17 Jun 2026 10:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NZi7sGi0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEE310EF78;
 Wed, 17 Jun 2026 10:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781691362; x=1813227362;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=z6PGdQ+AWjBpXGorge1KgGn0wov/f6HXFTVt3TLKdHw=;
 b=NZi7sGi0ADztpGQAmeXPluL+RVrU21qQG8VYfqvBHi0XeD/bW/um8iU2
 12vQcRcVtiahp8PdGkTqf0Y4e6xC1cmQnG0EV1YUr7y6LEgQ4iUb99NFo
 n9tb1wQm+QOuU+W6PiV/H2gOmjoKbxARuNMsVqIMcRa0V9H8Apzk5IINe
 MSHVk46vXIJjyhm+PA15t2Gpx25IwX1e/NvQhWpWjnwi1DpUphLvOWd2e
 FHL4TZ9uCm3k3xGEkVRUoKSs+ffGrsBfbcnMgIWxM2XSL396+HAnGHyJg
 QkgB/MdbOtWVoCuL1Cp9tB6N4eeswZD9xcnYWsgNi/zZxzLLFYeB2Riqx w==;
X-CSE-ConnectionGUID: iEUY8zrESQ2vnpT2QuA9eQ==
X-CSE-MsgGUID: Czje7OJqRF61xP7GNYbHmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86407370"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="86407370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:16:01 -0700
X-CSE-ConnectionGUID: BPlxohzRQmyah1c6ci/FsA==
X-CSE-MsgGUID: FPDINLwTRhuJ9VYfl9lhyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="278219040"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:16:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 03:16:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 03:16:00 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 03:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZh5IUEpT4ywybWoYstXBhunfXPa4Cm+gdelbG7tlKFO8+iBKlCt2Fn5x6ZutKznw3aDPc5qJEUjnoWSYfX4udoL4DXvzV1cPK86qEK56tduAtgQkQTyH9yrcGhifq5UvVNgmjORmBxg9TEXCO5GZzjO6RIyrk2LeDfKNlDmJGCMwqroKT0JyGpQalTUaznxQlAOsRIkDqvLriBkJuAAh6aixe6CmEl6T+5o0OOfaWlReivcvoEt0Ntor540DbhsjgQ7R260KvN03eptJ2PMmZHJPlwvAJjQHyrpDyZCyDeXM+GYwDAJ7jZM8PzcKoXxUqPu9mjLZs20c2kzVklOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa+W5PpCaFPz1Td3gdTBtrDt15Mll8VYT5hFF1HtXgU=;
 b=u8bF4D6du4zAOxvC+rHdYyCcO6woiv0NbN6aKre+d93sP9prsVQZZv0weHGG6ccEBnbJDdRzadG+m4F2wsnIoNCxD0BGiLEVfj5Jp69h3W7UYSaXpa4jW+MGfwEw784K+WD/I6TNxSrT6maJ0HLW/5rcJHd3jSWZ04lyBBL0nZKiu7KY8Pz8GE0oPX3ybh0ru/HumM1m03hU/XySKYuwkCXZX02SuGRPlVQWfxA/oHYmBUOktA8oo4NcXxUSjtzt4bD09C+cHXZ0NV4DvRQ8Q0vaxgIcAXEIWMXx4wNcYwgm9f5k3KNKuVrvdy0SI/d95xQKoFweAmbUoIBAembNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:15:53 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 10:15:53 +0000
Date: Wed, 17 Jun 2026 06:15:49 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <yaolu@kylinos.cn>
CC: <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <niranjana.vishwanathapura@intel.com>, <daniele.ceraolospurio@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Remove redundant exec_queue_suspended() check in
 submit_exec_queue()
Message-ID: <ajJz1RCk9gNIjw2E@intel.com>
References: <20260617012516.19930-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260617012516.19930-1-yaolu@kylinos.cn>
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH7PR11MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fb95cf-e9fb-41e0-57d5-08decc5969be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: c849bycXMqBrHw5G70URwehS0u1LdNFTk1cZpOYDGV6t15id1BTt+V5gons5H/8l7PwXZo+AvcY+rcAH/v4CKuLvP4TY2VLxtn/L2wFTjRpsgq5I+V9AWz6gYUzfO3oU8wZhAmcCKoL7wsaO5kgGS4G/1zs+PqJDIWH82R6cgDERDvd2IWfVRDfjLA+y7WBYoOzZh28AWRehgE5WGX1dR565qx4bGfZ8yp8QaLIPJAg2QhzVOhYGKQou1bHq2uNbX6L3Q73zxlw7NK3teKH74tyZASZE7trNwfBIkQi/tM/+Csk8LdPq8TtUSPLMT4kpkalIPx55CujbLHVobQmvsebbTMZYOZ40l9vgEWLE21W7ta9WsZVbn/6Cjtp05n/hWLZU2JkzGwTjzu4SvftCgk8f3jqJCaSsDEWMUEfxhbkoI0AUUGWRm/OPeqF7YNhU/ZQ7wsDTUMyHbUaIRmf3+Nb1huNZW9I2Wpr7sHpUtKYk2k09wIKegrctaR5pSJ8aMq/MYHJEhGGsGBuqX+RDhs/e8YyZMAwfqaJXKhQnFqPF08Ht+QBrHANLS2mFQFx+eaSpyhixGNGahFPMJHNNkrMvFWu2sroTfGjM8QKAuQYuTa1gxOSnxccK/6QZ8WIv4PKJcllYdSOl+Q+bz4908x6Zmh+Dd4AB9K2YpowucjlvUJce6ou/b3NTP80YvIpZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4t+ix33ztLY63VA1cPCgynnBZ0RB7K29aRqV6MiosWyTnhghq7vZ+2YgWWk?=
 =?us-ascii?Q?YNQWRf+x+tp1CeAMlDvIOxm/2VlZFUx1gL4VRBRCZ4EnXYEnYfrtmHi6ahv+?=
 =?us-ascii?Q?1H6Dr/nrL5GogSY088gEaH0KtXI1hYV1F+A7w4vL77LiwVfOIdVQeL1g/WLI?=
 =?us-ascii?Q?argFwzyoLWnbJPLX/+RH43o776m+l4W6VO5n7xjKXQeEmyXG6LJULazndFxZ?=
 =?us-ascii?Q?trZfgYnsco1X78wCs0mro47+jYbVc15/j+bmQdGAD9NyNCDDZihm95ui+k1i?=
 =?us-ascii?Q?kt0q2KwhnKjTuiPM8LhijSZhiTznxXX8eU27vtOq47VerdJK+n/HjfwRA4kb?=
 =?us-ascii?Q?O7urlyZ9z7dNaTGpF4S4li4alPVQtge9/y6jBAut9QsCEGDbS2Wgs5kptcQt?=
 =?us-ascii?Q?tF8pS+tIAvu2E+7Ch07jwhWJBuM0YXYLdpcyS0b5Ih2IuxEu7NFkqbn9SmYo?=
 =?us-ascii?Q?ptluTAYHPgdFIhfA4iIEaRCVWFt0fc2n6/1J3nsedeVoPlDzfLbTlDNOIPUG?=
 =?us-ascii?Q?0ZsCv6H8WE535LvHtYbMNJUf0ofHTJVB5en1Sa+FoFiqzDg+ZRnZUAPAFqgx?=
 =?us-ascii?Q?GH+a0uoG/0izI4y4li88vgHJyOHxV1kmcMVBoZorH7ocNJaOB4bqUyWexpbS?=
 =?us-ascii?Q?xoHmGu8+dg3zNevTuwEasZaS1OQOTPQILyBOYfH3fi8rFaIrqN/ybElBd0SI?=
 =?us-ascii?Q?6jTuYnrrTHolGRTK0WoYYwehsIE7XJJs7Q7h6aTq+VdWz7Jq1uiiFUqu6cOl?=
 =?us-ascii?Q?g2pUXaJ8t7zJF+s/8pLmvaQmxZHFL44xOOj+dbUWe4wnN6ibuKYzGQXaJ6lo?=
 =?us-ascii?Q?AlFYVWF7HrJtY1E8XXcVMsb0Z8/sQ4iorrVrWLg0jSy6nuWlBqHpgNQwkDfQ?=
 =?us-ascii?Q?q7geir+vQjusSQgk0P+ULCkXkAaOl9qIkTkv9ZzSYELumyz1nqqiCI2uHH23?=
 =?us-ascii?Q?PWdmpihfGYf/BcLEjL461I+2k/u8rFzPkCVn86djiRZN0C+WMJAwEpD/N1cR?=
 =?us-ascii?Q?OxIPl4LZNUhje7wRZiTOVIO8y1cwijp8Fp0cC2DoP4eqOQtnUOsGutfYDEf9?=
 =?us-ascii?Q?3mncF18x9r1AxDf+K7F+Ij7ohTIuAxqEnBB4T4lFwGCK0RSD5Y8pGyV6yiSS?=
 =?us-ascii?Q?llIGJ9USXpugofmK4f2U4cdojICGiL4R4lJ7S2PEpGCIhmZsq0P9yU1Hd5Vy?=
 =?us-ascii?Q?SkTwa4cnOzOhZ30uLrB89TAos2uyrE2+TqB2wgkpnyxr2P19r+GYimoQg7jF?=
 =?us-ascii?Q?ivTZy9Y+2hlqOtkfE+3mLk1eXdd5ne8jwZ87gNkEuxKwoS09RQstad1Y4AfZ?=
 =?us-ascii?Q?hngb0rM00rzXJdds2TRYZBGWjXyoAKRtFxH8P0cnjsFJ9ckrPqNo6KSy4ECL?=
 =?us-ascii?Q?MOHAx+geB/3fm9+QuBr4cuCFlgIzzGN+bAmvYqDWVCa7ytM+cvdmOMIOZm/d?=
 =?us-ascii?Q?iSocgFWeyvrJ9AQdvxArjZ8xwPKGyzfy/Q6Zo2NOiD0yJXhCZF2ugEwWxvEO?=
 =?us-ascii?Q?qTjRWtDYPrq6BlkJd6cf0SSJMY9tjov5bMJ1U3n8q4LpGSiZjGf8uPDNpIFX?=
 =?us-ascii?Q?0qn3hOqGRcdZ0CA2rmBNeYzqsibCbrOTm0xdmuC1uuytAmO9LSy03lDmy0sW?=
 =?us-ascii?Q?M22beT5FlzCiIzqYDOIZ10XIb4cC4iwNPRBURNTS049mjWZlhH2DcTfOWlD4?=
 =?us-ascii?Q?ZVlI/gwGTipcZ5CcfDh+jyjO4hOA6HL+jl1Bn+ycGIoXS7XJ8Do419KRpxy9?=
 =?us-ascii?Q?44SBLWywgg=3D=3D?=
X-Exchange-RoutingPolicyChecked: PJmuMZ19ATUcWaHjOkcE5PPyHZMIgHx/2ZZwopEY3l3ubE2CYzCZlhVzxvakOYyEcf4Z0EACNGZRT1T+KCi+jY2fq3U1p6R+yt2yv1vOxN8fBI/s8dd6i12+iJXNzov0NS1vn5ZUmPBTNamCqcU6FtgoVqfkG2ptvRlHZWAtbPQ0+FYfx2jCiqkNOx3IH2ccVPprfgZQHEANb1H4Pfi6vEbHZu8e06viVQfUsiLBOk1d7hzmKAx5LZnCdcFOCYrVSRrvRQMd9S/GmDJZRTwN4F3mexf7Z5nX/d/i0ajM2WoUYoiqzPQO1ovDNU+gvISLddJ3siH0UKBkXufatLHGHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fb95cf-e9fb-41e0-57d5-08decc5969be
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:15:53.4803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTzh4ywasRUCSB9JPvfdwN9XWxve7kNj/p5KA5qVWav0bt4rcayGNWEr2joa9mpg0K5c6cd6el2I/Y0zpd2YYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
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

On Wed, Jun 17, 2026 at 09:25:16AM +0800, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> There already has a check for exec_queue_suspended(q) that returns early
> if suspended.
> 
> Fixes: ec4cbdd163f9 ("drm/xe/multi_queue: skip submit when primary queue is suspended")

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

and pushed, thanks for the patch

> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 42110e01b7d0..dce0ecb7ea35 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1159,7 +1159,7 @@ static void submit_exec_queue(struct xe_exec_queue *q, struct xe_sched_job *job)
>  	if (exec_queue_suspended(q))
>  		return;
>  
> -	if (!exec_queue_enabled(q) && !exec_queue_suspended(q)) {
> +	if (!exec_queue_enabled(q)) {
>  		action[len++] = XE_GUC_ACTION_SCHED_CONTEXT_MODE_SET;
>  		action[len++] = q->guc->id;
>  		action[len++] = GUC_CONTEXT_ENABLE;
> -- 
> 2.25.1
> 
