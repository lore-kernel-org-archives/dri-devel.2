Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8F606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QH3qrkSo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=cAARlF6e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE73E10EB61;
	Mon, 23 Nov 2026 23:37:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576DF10EB61;
 Mon, 23 Nov 2026 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795477066; x=1827013066;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=FfuEzsKSPW/++u639W98ExNVdT91mVZwc6/8av6yIrs=;
 b=QH3qrkSoK55M3ydYDFW/Y6x1yyPQYhGJ5xIFR9N0RjJT/Co630ING0W3
 WrOHIR2QrYEPEVPtuDNXwWzXkiu6qhNERmbiRgaVaPNp2sUIvXGFQLgtL
 jQZJeqsWjria6ZO8q5OYyEWdFutsTHItE9cSXE1Iuo4ntL8D6BVTQIHZr
 9YXQRqET9TdDh7FVaFO9BF3MUp2bLw4qJxOC2kWcl3G2ZzjTBCAimDGIA
 WSLTzbhZEsl43hO6DyOrPzLBPMjzzmBDuMl9GUuLV70qTCU29ENgX04LW
 zYDZenRx+NuUzgI/1FJiv75RZi9yHLHuovQ8ch33CgOGZO/MFAcTI5qtc w==;
X-CSE-ConnectionGUID: IHqa9DDbQ0m7AJU8M9Vz+w==
X-CSE-MsgGUID: 3t+DJIN9Tgaq3XHNprGFwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4328902"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4328902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:37:46 -0800
X-CSE-ConnectionGUID: kbEaJ3NySbSNK48HgQwZJA==
X-CSE-MsgGUID: lrKxfBHrSaaraZQX0ZH3GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11762934"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:37:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 15:37:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 15:37:45 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:37:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDVldBHj12FSoX475tgS+XIqMZhkqPAQ/JEFgGnKW2iOzz247x0j6gg4lhqCZPmKlOBYwOZA0rOdQoyu08vo8OuRIjrbeB65kMJiMkVFVVZG3kQqUgOh4hPlR2GpOg8o2Bdcy5mmDqN3W/Zb20OLYGJhilGqlrODJFDdZ2fhTok68AK/JuXO8XgAIZYG6m7UjgPXLMHiPQ0gvvwvJYpxz8I6SXSs5YfsTMz095zF1vd7SjBm1Xto3TFvR6s7vGPyl4/2C2KRSrGG4z0QmTICwovTxhIaB/iUi4Q2evJgdt5TdnMk8Ccf0lqbnUBLNpt+x5JB4Q+Y591xW/e6POJeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YfkylR1Ar2sEZkPh+bE4tNwt8nWOYJ/cQXHgvX5VSc=;
 b=fQS2i758ch7rXBOR6ZUwOzQXtCabtdCOuK3WzWSOaqJjDYfI46PV5ZQu0aLtlM/Dj5K8GQ4Gvss6jJ6cMrNmBYSb973nslHzfueDKaoH0bh68qgve7TEd5qegL3bzW7kVnwjgUjc5h9D4V2mZQvjKI/qOwg/uPxQfnayQr+VvrtsxbToq/BK6Ox0Gd82oS0bNbnW2yvON5q8pPEBT5q7u9yq8zPoVC3MQc6rSiyTc3gb7BlivdV9z6u3Swocz3UOsFDZ7JI5eOrlVXeNe6UMNsbG2LTrUdW15y8Q4ZGn7UxdJf6kKZBd7gxZqYsSfFMKRUjEEdypbX6gzUX6uNPkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YfkylR1Ar2sEZkPh+bE4tNwt8nWOYJ/cQXHgvX5VSc=;
 b=cAARlF6eTz4r/08XP79cLyhfmQ28d51JMhDLxuFSda4xNEa2dxcB0QtLR7wW+nQlj9QkfMZT96r0EUx6GPJA7G8OtxqlG9jUZV3+guRyOcK85L3vdofLzi3GvVayY0dcUDe1WJH6YhxQ2fVWbiu03WXeWq4sKZBs/D4rWQ8jb3E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 23:37:42 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 23:37:42 +0000
Date: Mon, 23 Nov 2026 18:37:39 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/ras: Add retired-pages node type
Message-ID: <awTOQxZX0-cuXBoG@intel.com>
References: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
 <20261123150806.2266196-5-rodrigo.vivi@intel.com>
 <sashiko-outbox-229565@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-229565@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: d4eb1157-2eba-477d-b14d-08df49bac495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003|261026140227099003|261102123227099003|261022105027099003|261028144727099003|261021121427099003|261022075727099003|261009223027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: gvv9eQEe1TamjcA2+v/sRs5gaSmppfiokYXVhB41RVLFbRukFzpzOsCXyG2hQzvg9qFDq8kEXCgzwqTTKXrTtTJ0NvfDBcPERoG9k9S5HtTQVfdZHSUwwMeU9FwB9BqhjtZlycQ6MvhE5DakqvT9u6lcv9zK5lqca4N2oaWXhjb3cm3HNrU3w4ICiBy9++NNvnKSFgcFDpz35CTuYWiyCDBLot5euG/odeV8v+0NqJDXjBFxoXn+mC9sFxkqnL8O0m1/2svBigH5A7tN4sqydLhpz9VDzearp954YQ6GTIGPMiTcz/at5QdYzuQILUIOz8mLM17SvLb0m+WOxWxZGVJHHsfI1MIItS4YijkDngnOqr66bIaAZemHOS+Sd+lnOgZYbITSOZwxMqNVEbnT2YV+wreyd185qse6Tgrlkqzkr4ITZddO+EYqzEdRUt2IVMeGoE8762lp0RsM+cxtHgYFgRn3JcVta/T9bmc1kaz//9et7EWsn+xdvOZJDps1xjUD7x7bi2VR/DqLVAI5qWvx+DpNoncX2Xqr/8yEm9rPeL+xRlYbsssUoBrzawnMiCvgMpnkl8eEqG5yaODnHHZtwMeU88ubx9lFvgV3rqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261102123227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DuzMI1+3C5g83HRnsvyWjLsq41/bj9M9pemS2tcaNPY8kbMAy0AHmTwY63?=
 =?iso-8859-1?Q?XyhY1ey1m6OPurhvLlEfUa+emU3KUyGOFt6f2MF51jxCgdsoratX+EjDw0?=
 =?iso-8859-1?Q?HeaZ0uLcBRSFqhtb2jOTcfZusQVCsXnhd6EJeLZcnvBSc6d9WGv2DXCkkE?=
 =?iso-8859-1?Q?r0It1OfebOehIL4EnALR257CZtW9AvkUeD5fTY/xNPYipc4vEdIIBGEU4b?=
 =?iso-8859-1?Q?1NqfD02OYQM84bOvlqbYuMkF1jln5ECgWZV9haprFS4krrrRMWaQCdoB4/?=
 =?iso-8859-1?Q?GeFyIffr/5i/HUeItn2eGsG28AShizOs3vI5fi/iuFwCf5CMis6mTEvIMI?=
 =?iso-8859-1?Q?/Jcy7tqebE4/VP7ec0ldiXCKFlMgkfq/sDEbm+eBjB7TOFdZI+/0iK6NwT?=
 =?iso-8859-1?Q?2Z2dutrQE4B2J/HZwyn9EwOHEbuYTwTLer7sl5OaMdujqrIq9ENFYJti2t?=
 =?iso-8859-1?Q?x+xptLLldtslr3AFUoBinFx9HdF1mrVA3k2vVIUnISYYCrSo1JoEK6/KaB?=
 =?iso-8859-1?Q?xNekfJDPOLHE0UPrgxRxi5RjePgiFccGml721XqSN624tpsr07n4uHFxYT?=
 =?iso-8859-1?Q?6zKznGU8XGVanxrZTlGdGr0yWZYunck+sUbbMqeBCKvf29JTGjKoLNjqJ6?=
 =?iso-8859-1?Q?ubyqBVn2CSinw4I9c5Dhu3Ycb+HLepy1Wl/YWiMtdyQceax2XOnaxIYn5Q?=
 =?iso-8859-1?Q?z48r5xKRcM/k3LxPbjER68lbJtP8Fdrvu0IIBB79BRfkqLKwSnU1ZQILnk?=
 =?iso-8859-1?Q?P5X+sLJLQZV9hQ5zVI3f2yYuLT69s+7Cb9JSzwU5qX+56g1Pa9r+aZJvHr?=
 =?iso-8859-1?Q?LKdVlSCqcsXBjnq8QQREu2png3dYI/FaEovYS+wyeqB3rtRNI4o2pkMDvw?=
 =?iso-8859-1?Q?F4A2OL9GqcVxqH/d3MH9AhRfGGx0lGvBDPuNec2uzC733vCxtJJn3u2QZD?=
 =?iso-8859-1?Q?sPgyFlJTviNZ0sUOaoIsmsgP2CbD2eLapdAB3jmaKneRguLOm7H/P/3vRm?=
 =?iso-8859-1?Q?BDktfVfu+H0GdLXiJzJMdl9qeXQS37TruoZmT5kZ75tbUxpuyINe41Lrc5?=
 =?iso-8859-1?Q?ewI7Xd9aCJOppQAd0AmMQcPSPEhj+FWdgcGww2RHcN1OpaJ5UoFVhlmlmp?=
 =?iso-8859-1?Q?qOR+mnnBrwdHs5iSkOfX50Oia4VOpOPxf50XhBQqvYnR3xwtWw3JbMS/ps?=
 =?iso-8859-1?Q?JszWMatUWd2Fw7724bS0+yB23wt2y7+D3xwRjY6Jnux/7VhWVrhp7Sub8I?=
 =?iso-8859-1?Q?qJJz0ZHFqkuail8W41qiSamRBD49755Z2WJsBTYVvSYQoY5FogAiiib3rY?=
 =?iso-8859-1?Q?XQ+mjGY+8Ra/yl9s8hJtaHnivz/pUB4w/lRrA7TGJhwZj1MeHlFw7CrtbT?=
 =?iso-8859-1?Q?va/PjzuPkPDwKZ4oAKE6EXUhZ4stYh19j32FdA81AuUR1H0SCOvJcq6Yox?=
 =?iso-8859-1?Q?JrUmBMFH84RXEO49qNe+VRwNPyHEAZUKcQIpZ1gFOYO+Loxcf+BxKMt3HJ?=
 =?iso-8859-1?Q?knhKDqqxzn69PXIqPkDQpsh0I05YIlxjngth3FfFxigYwbPwXqzdt9/XNE?=
 =?iso-8859-1?Q?euNW0+KXQI1Mmoln+gy+pV39tbvrnNoXgKdntEOk+wv69cjWGebHHNzdUz?=
 =?iso-8859-1?Q?7c6OF/ODuQYJiU/BlNvUIl/so5le1mCBo7EotHluCGLKZf8MaYOSPB9Mi7?=
 =?iso-8859-1?Q?82mNa0nuvSVbox3GmW8Nr745i4WT8IXuBYSm1TXYCxE0fqqJKToUHqwofM?=
 =?iso-8859-1?Q?SclLR1hOIyVZWqcvvlNwJRx6kqwDflj/NHIoxnJ7p669RMkGlRuyAmjrde?=
 =?iso-8859-1?Q?tymImw1VPg=3D=3D?=
X-Exchange-RoutingPolicyChecked: oz0AilLcUZS4MNeoJvin86sFd/7fr+pCYtSzOk07iiYJaIQEE6q1X5tT8aL9w3c3RxvYqC5iwpdXcKzJEbMFHNdoMAEcCkGuAiacVbGtwJlWGcaZUYdgG00o5VVpxGv26JctdXxdZf6Avoq++R1JQCux/NFGb35dWXoYdAA/EmGYoRm62eoXJunbpDP0shQiuBmEFZ88P0IyHAUIsTt50NPz9ONB5aMoke1qpblqa2etWum9zVdn0lcrHUTetCTcz/pdYcnSxMuv7gx/jxmUvGmpt0g/oXrze2pZjUGAl8So+gh0AYgtiCGq0l2ZbjMo0ai98GavY3PPNfGV2l42bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eb1157-2eba-477d-b14d-08df49bac495
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:37:42.2958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnKnCZA2DJEDoFdFgsKdVoG7UaRFdpO1iWRcTBGQP89j+HdoM7Sp41yb0C+LaannWDPYhKY0AoqscYitRXcJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 03:28:53PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] drm/ras: lost NLM_F_DUMP_INTR in
>   drm_ras_nl_get_retired_pages_dumpit()
> - [Medium] drm/ras: missing node type checks in error-counter netlink
>   handlers

I have a v4 on the pipeline that solves all of these, but to get that
right, I first need to quickly land these fixes that I found during this
exercise:

https://lore.kernel.org/dri-devel/20261123233326.2882114-5-rodrigo.vivi@intel.com/T/#t

Please help with review of those and I'll send the v4 soon...

> --
> 
> commit 27c9afd08cd19612592b285ef905e2efcbf77cec
> Author: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> 
> drm/ras: Add retired-pages node type
> 
> This commit adds a retired-pages node type to drm-ras along with the
> get-retired-pages dump operation and the get-retired-pages-info do
> operation.
> 
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index b099eb67836e7..34e5dab997440 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> 
> [ ... ]
> 
> > @@ -617,6 +637,145 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> >  	return set_node_error_threshold(node_id, error_id, threshold);
> >  }
> >  
> > +static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
> > +{
> > +	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
> > +	struct drm_ras_node *node;
> > +
> > +	node = xa_load(&drm_ras_xa, nla_get_u32(attr));
> > +	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_PAGES) {
> > +		NL_SET_BAD_ATTR(info->extack, attr);
> > +		return NULL;
> > +	}
> > +
> > +	return node;
> > +}
> > +
> > +static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
> > +				const struct drm_ras_retired_page *page)
> > +{
> > +	if (nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id) ||
> > +	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address) ||
> > +	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size) ||
> > +	    nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status))
> > +		return -EMSGSIZE;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
> > + * @skb: Netlink message buffer
> > + * @cb: Callback context for multi-part dumps
> > + *
> > + * Appends one message per retired page, in increasing address order. The
> > + * dump resumes from the next address after a buffer overflow, and is flagged
> > + * with %NLM_F_DUMP_INTR if the list changed between messages.
> > + *
> > + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
> > + *         (requires multi-part continuation), or a negative error code on
> > + *         failure.
> > + */
> > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > +					struct netlink_callback *cb)
> > +{
> > +	const struct genl_info *info = genl_info_dump(cb);
> > +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> > +	struct drm_ras_retired_page page;
> > +	struct drm_ras_node *node;
> > +	void *hdr;
> > +	int ret;
> > +
> > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node = get_retired_pages_node(info);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	for (;;) {
> > +		ret = node->query_retired_page(node, ctx->cursor, &page);
> > +		if (ret == -ENOENT)
> > +			return 0;
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Never zero, so the first message is checked as well */
> > +		cb->seq = page.generation + 1;
> > +
> > +		hdr = genlmsg_iput(skb, info);
> > +		if (!hdr)
> > +			return -EMSGSIZE;
> > +
> > +		genl_dump_check_consistent(cb, hdr);
> > +
> > +		ret = msg_put_retired_page(skb, node->id, &page);
> > +		if (ret) {
> > +			genlmsg_cancel(skb, hdr);
> > +			return ret;
> > +		}
> > +
> > +		genlmsg_end(skb, hdr);
> > +		ctx->cursor = page.address + 1;
> > +	}
> > +}
> 
> [Severity: Medium]
> Can calling genl_dump_check_consistent(cb, hdr) before
> msg_put_retired_page() lose NLM_F_DUMP_INTR across a multi-part dump
> boundary?
> 
> genlmsg_iput() only requires 20 bytes of tailroom, while
> msg_put_retired_page() needs another 32 to 40 bytes.  If the remaining skb
> space falls in between when page.generation changes,
> genl_dump_check_consistent() sets NLM_F_DUMP_INTR on hdr and updates
> cb->prev_seq = cb->seq, after which msg_put_retired_page() fails with
> -EMSGSIZE and genlmsg_cancel() discards hdr.  When the dump resumes at the
> same ctx->cursor in the next skb, cb->seq already matches cb->prev_seq, so
> userspace never receives NLM_F_DUMP_INTR.
> 
> Also, page.generation + 1 wraps to 0 in cb->seq when page.generation is
> U32_MAX, and if all remaining pages at or above ctx->cursor are removed
> between dump batches, query_retired_page() returns -ENOENT before cb->seq
> is updated.  Moving genl_dump_check_consistent() after
> msg_put_retired_page() succeeds avoids consuming the sequence change on a
> cancelled message.
> 
> [ ... ]
> 
> > @@ -631,14 +790,18 @@ int drm_ras_node_register(struct drm_ras_node *node)
> >  	if (!node->device_name || !node->node_name)
> >  		return -EINVAL;
> >  
> > -	/* Currently, only Error Counter Endpoints are supported */
> > -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> > -		return -EINVAL;
> > -
> > -	/* Mandatory entries for Error Counter Node */
> > -	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
> > -	    (!node->error_counter_range.last || !node->query_error_counter))
> > +	switch (node->type) {
> > +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> > +		if (!node->error_counter_range.last || !node->query_error_counter)
> > +			return -EINVAL;
> > +		break;
> > +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
> > +		if (!node->query_retired_page)
> > +			return -EINVAL;
> > +		break;
> > +	default:
> >  		return -EINVAL;
> > +	}
> >  
> >  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
> >  }
> 
> [Severity: Medium]
> Now that drm_ras_node_register() inserts DRM_RAS_NODE_TYPE_RETIRED_PAGES
> nodes into drm_ras_xa, should the error-counter netlink handlers verify
> that node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER?
> 
> Without that check, passing a retired-pages node ID to the error-counter
> operations causes get_node_error_threshold() and set_node_error_threshold()
> to return -EOPNOTSUPP instead of -ENOENT, and causes
> drm_ras_nl_get_error_counter_dumpit() to iterate over
> node->error_counter_range on a non-error-counter node:
> 
> drivers/gpu/drm/drm_ras.c:get_node_error_threshold() {
> 	node = xa_load(&drm_ras_xa, node_id);
> 	if (!node)
> 		return -ENOENT;
> 
> 	if (!node->query_error_threshold)
> 		return -EOPNOTSUPP;
>     ...
> }
> 
> drivers/gpu/drm/drm_ras.c:drm_ras_nl_get_error_counter_dumpit() {
>     ...
> 	node = xa_load(&drm_ras_xa, node_id);
> 	if (!node)
> 		return -ENOENT;
> 
> 	for (error_id = max(node->error_counter_range.first, ctx->restart);
> 	     error_id <= node->error_counter_range.last;
> 	     error_id++) {
>     ...
> }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261123150806.2266196-4-rodrigo.vivi@intel.com?part=1
