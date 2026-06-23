Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10E3CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4011C10E941;
	Tue, 23 Jun 2026 05:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="adeKzljI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AC410E941;
 Tue, 23 Jun 2026 05:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782191572; x=1813727572;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=rQ68+8mcFiC5SBJ9qUe4R8O3p/EPH6JFKrW/od2kkgM=;
 b=adeKzljI8PgY/MsMecL9Tw1kgfNUFaj3F/7WQtfGmB9xOkKNQHMhVHOy
 RtgTfeeLiIeLn7jbEKHhZuwhAoz4HvfRioJ1Gvacgprve90t9+RGQ3nhh
 TFfmxhZiYnpCNganTdN+b/14THze2aj57Xck4seT+s72qXZG4FqErbN6Z
 GBflA/OtY6yuF8raf2Opfltj+iU1zijnqC2sJ+VXYokLqiDGbgVLDU5X+
 oMUrNWcKq1GEX4dk01RU7yPaNyTiRoYcT8ukB2SgqZAirV5Gzd6OgepLF
 slEXgpntBePNGcbfqcHfE75D5UlVh7mkfybbYJPDNOScy0tJ4Kg+PtzZr Q==;
X-CSE-ConnectionGUID: O+qtaDcQSla10J4Hhwos9A==
X-CSE-MsgGUID: +VvOVizxQjSP/nF5YU1EvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94423031"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="94423031"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 22:12:51 -0700
X-CSE-ConnectionGUID: 2ieYU0OaS1m5OxsuS/gdMA==
X-CSE-MsgGUID: VRbrhTpYTlupvPb9Ljcd/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="251350909"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 22:12:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:12:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 22:12:51 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIepRDE7Svpl+B7//vFgAnwxyVmxxrtbitoiwTWp57NWCUK7ZW9QoHegQNZDZXMOO6ybG8gzcE+tMTXeH/9iD0v5QzsHLhtrpCP8ee38rdcdwJAy8yr8l2LphiN4TTGaJ2NGv8hk35iy6uAhaUIBRadaVV+1q1sYc2KaPY+ZoT6YvBwEGjIftd5cyY2JncxWitt8LhPBR5ZHli7dt5dgmncwNRu8m+ppCM/5THK0PM7dVMm6aEK820rdKigLiDWd2gTIrIyIoTVNjGUWOS27EB/o3fNaIwoxZ4UrBDRnBRRCEpRN78CnwDoh+uUkCnuJ063QReWukyoXfzq1xFj3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVDw+n4oSS5xUiRnSNvjA5YUbtASWTYDpf9OzsXLE8A=;
 b=GuqA3TFVxxXwphvRz6ZgXS3mSQVET4SBescVL2h9pnDQe30w0XHbOqKDqSpBiu85q6+JESdyMxe/HAnOHlxG1lYBkUl9Wl5+tO63BJvpm3a6+h5PljZcP4q5v7it5yCrYb6XXJp3GcdB+pPKj2iL3V8M4ILKEutdAXAAzNC5xGutkpI9hzXEEABcfGDTmqJmTuHPyjRrSfIyFsVMA/arzGxGxByEVBI1C3D68/xv5Xv3zBxQjWW4l+vcuhYvFn8C7nbzxdXf0/5Y8PXM1h4WarqmaF4pmDGMd4ImNvMZrLxMqntmvxid24zh6Igts/BNBGtIk6mI19qcQ/n3Y3SvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 05:12:47 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:12:46 +0000
Date: Mon, 22 Jun 2026 22:12:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <mripard@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <Rodrigo.vivi@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <thomas.hellstrom@linux.intel.com>,
 <tzimmermann@suse.de>
Subject: Re: [PATCH v4 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Message-ID: <ajoVzCjwNzVWNk6b@gsse-cloud1.jf.intel.com>
References: <20260618153312.877948-1-jonathan.cavitt@intel.com>
 <20260618153312.877948-2-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618153312.877948-2-jonathan.cavitt@intel.com>
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 7553efc4-0301-486a-a4c2-08ded0e61038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: w48NfkjRDaKUJ5Hf+Q1TYbkHxxuuBp2h/DeuLUsujrQraE/315/YXRy0fy4jFzdaBsQQiogV2kiQf7wgoKmjZGPmj/IVAU0ULe2QTNRfHlIpa7j/n7BUBSCAgBarwJ2pSHUpiwcI2LPqG2T/pDowijEBZ2WRj6J3a1AVKQSuORQMk/dbkj82wbyCMjjhl83OVA3oBpJtOxqbJxklcqPtXtNSa8n63DVX9IacQU+OrD/VGDMUwQ0sFq0lNDWj4npVjnJYBKI40994ANAgGwSVzxtzbTGUKzY7mR+s+0RcERWpaUoWbVyKryKLZvzEL/XElSTA80QPv3pC9oF2FwaV/ALU5H6Gax9Y3/lxp+9qKGZouAnW5HZMg5kZvu5rrBvhMJjcT5eYgg+gwV95Tto+XO5+wUpDm/u7tUsH3cw0svTpWI1Qo/6SexGNZaRepbpvYXZ2Spfq9l4JF/B//wKJ+Pt69vuBqaEyvY4TeL8ATjGoutJgm8sxVUjK3nzJ9hgmdCnqDp8mXljaRzDxHKx6KkdX8xtRn3TrjabkUUcAjQMK0SqHEsw+5pzQuIIe4PHkyf21noVb2jh+IZ0eiKJuxOtLSNwVq0KkLSA2eyzFJkrpoMKRsOD0k2DTaFoieWPdGWTEnD+zMwERUA7TSlszlB6dSe67LIkJQUf+bcFbOLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ertAJ3I9BlPdjdIQXk7IWMvwFzkzAuNF80NaBNgbB5ASK+wC4+6kAxnxTb?=
 =?iso-8859-1?Q?rQo3MD/2emLtehf15enUCxpg7N0jRHvEjLDKiU1HOMrksIdTbtPcql1f62?=
 =?iso-8859-1?Q?SmLGCfLjzHIOPQxeNX7CHuSgoaNPiqssKIAbdfDZ6UZSbAdH/4DBb4FnQb?=
 =?iso-8859-1?Q?FdXO/4BAE0L2tewc33j3tn9hwrtH2uFXoLWcyc432v6KwIk+3OqVYNfVXZ?=
 =?iso-8859-1?Q?kDRcWqdVLpfSzHjLkF8qmEC/W7oNEZXnqBboWVZVWX1VtOEwr92Ay/Gx72?=
 =?iso-8859-1?Q?GtmHqIzGf6VbXyn0s6cZElVx+lBpiYfHccaZ3RqESffwCl9yD3leTWTE4y?=
 =?iso-8859-1?Q?hXSTOY2t9TnoP5C44m3rJ+pZcDakVFpv4v+XjzmZkSEFe+B8hjPBlfk/y5?=
 =?iso-8859-1?Q?4X5icMO2LEJsgqp6cjTTt8/tE4w9idAiVqKRCuzc1zej3NxYytzc2JmFGx?=
 =?iso-8859-1?Q?cR2DeIxq670CO9zJhgkj+dne+1H14d3tB1aL9UPQmvIcKN63aPM4hjhr0n?=
 =?iso-8859-1?Q?cx1FzW4U8oX4o6ZogRgTKIPDFg9zL0sfCDUSidxtT7pfZ85DZRDczZkMxF?=
 =?iso-8859-1?Q?FZ23Xq1fXZsrMU9qKMthBSYDltbEnbpjXr5Cu1f+Ht7Xs4bmTl4PD1SN+z?=
 =?iso-8859-1?Q?3ULfrWnUwVivBogyDPOTLl9xJ7PG2yGdvyjdi0ILYIjfOd/cfCnHwu/U/q?=
 =?iso-8859-1?Q?LyfMlgGBrf7EN8pVcMiSjrEqpD8BkJuufBynsvF8uFMzUPjK8HC901lFNS?=
 =?iso-8859-1?Q?DNFMk94khZVVmiQIC0d1kHBTxj4nLU4YcjCGzYnpSvz223LvFfWQdmD9Uy?=
 =?iso-8859-1?Q?x85DBC17nMKk+dMM7XdIMmc7HIksQTvDNxMWMbaue+u7+Wck6b99PoK2rS?=
 =?iso-8859-1?Q?59f9jR4kBEIVIYZLE8MnEElQRiSFtISHDbOs0wg6VOcgM8pKCeleHDk0kX?=
 =?iso-8859-1?Q?LQ7g5MJjkPT/cnXAXstFWlEXdPL7tkNGpOXH3KWbTSgfI+oBshvedmahYG?=
 =?iso-8859-1?Q?zpdd9ELi3Pk81P/zOuq7rJddRPcjhrW1JEYeKKQCW7Zz3uH+1C2JUUwyg6?=
 =?iso-8859-1?Q?7TJRJXKjGlKKMhoUkxxl4kUnkMs56P1imFtHzpd+3fi4Ik63Jd2rSqtc/f?=
 =?iso-8859-1?Q?nEfJrepzxoa9RQo8Y5MH7lpLI5TYJSmP40RqduOVay1oatXmVlB64WW++3?=
 =?iso-8859-1?Q?iLh38p1/jx/5WAhPtHCQnAU8/LGhPEc3P94GrJleGKqdh80KW0NkDw0a5U?=
 =?iso-8859-1?Q?b5vltrcZRLOnbUs2a1lrCQJJTShqr3fkAFYQCmeSsnYRBysIfqtKLHEU9L?=
 =?iso-8859-1?Q?AEqd/WWnQP6FH9ZtKjpUSJn11U33MvRda77JFKpk1DlXamXVrDVONGEhn2?=
 =?iso-8859-1?Q?CrNkAIAxzesTqVN7HnoPybPbZTTcPYc2/jWQZ6s/ODpG4USYb7TElM7vF5?=
 =?iso-8859-1?Q?aSOFSkNCgJQjjpqPZACFTfnBmBKv72utTA4UaWMxfcFJ1u1UM8SkmuWVSx?=
 =?iso-8859-1?Q?40PVo4EGxiZDAAT+PvW1KdvTzJNRLqxOrLp7EcUo2tWALkj5gSIWJj20ER?=
 =?iso-8859-1?Q?3YT1T+Mzwz8EEmk7AqnaMmrKsZGgDGtyxGw2vbWsm4SqCe3PapuLSWv+EL?=
 =?iso-8859-1?Q?GGScJhPFLFuDYdDhRBRqX9UweJ/Iza2EwK0jsgLxgp7lbQSLhWE1+jBRTX?=
 =?iso-8859-1?Q?p0sE7xDQitHyWsrP/9C0g53dQRabXCHtgM/RHtDuEAnXoeTWPN2/dlEcJc?=
 =?iso-8859-1?Q?KEZQRcXAoRp1cr+Y+jdBDhN7YInBtafIUPH/o+S03Qj5edARGIqETqGNtQ?=
 =?iso-8859-1?Q?f1XEhJTHaQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: EEfanu+taC3kov3iuobuX4IRbrpv/8pQGiGKRu56dhIHROmFsl5LYtiSblSrqUtU6J2cAFxF8lbWHfRaZZB57deZSPipoc6mWFxw2eq/zBuNLtxd/pESApPwIc4719M79G7IWOVC3S8VEh5paKX4MTkrNilaRrpZrRSCQ0MnU47AVpr02MehhjA5D7XR18kc/+54kx9oPlEsPYrn2N6XeEPK+SfAVKiDcDqsbUeU2YyNvDpYXddZ7eeA8r4tQ12wRm+Jc8wn9BBS2IfBuIPLPxgbQWXCTEHaDb/5m6PzpyZBBxBIT391DVO7+GVj1fk1vyQodvwc0/JMW8vp/2hqzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7553efc4-0301-486a-a4c2-08ded0e61038
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:12:46.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBNo4rZ3OrKccDnpVl34hqP8GDmJKOb3BWlBn5wNpsz6lMW9uOHJA7PSv871CKXzOSE8xcHOIj9IPWKkBEmOOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
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

On Thu, Jun 18, 2026 at 11:33:11PM +0800, Jonathan Cavitt wrote:
> Add SRCID information to pagefault struct for the purpose of reporting
> the hardware unit that resulted in the pagefault.
> 
> v2:
> - Squash SRCID with ASID to keep the struct compact (Matthew)
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/xe/xe_guc_pagefault.c   |  5 ++++-
>  drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
>  drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/xe_guc_pagefault.c
> index 607e32392f46..7d24bd828e5b 100644
> --- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
> @@ -78,7 +78,10 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
>  				      << PFD_VIRTUAL_ADDR_HI_SHIFT) |
>  		(FIELD_GET(PFD_VIRTUAL_ADDR_LO, msg[2]) <<
>  		 PFD_VIRTUAL_ADDR_LO_SHIFT);
> -	pf.consumer.asid = FIELD_GET(PFD_ASID, msg[1]);

Maybe a BUILD_ON_BUG(XE_MAX_ASID > XE_PAGEFAULT_ASID_MASK);

> +	pf.consumer.id = FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
> +				    FIELD_GET(PFD_ASID, msg[1])) |
> +			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
> +				    FIELD_GET(PFD_SRC_ID, msg[0]));
>  	pf.consumer.access_type = FIELD_GET(PFD_ACCESS_TYPE, msg[2]) |
>  		(FIELD_GET(PFD_PREFETCH, msg[2]) ? XE_PAGEFAULT_ACCESS_PREFETCH : 0);
>  	if (FIELD_GET(XE2_PFD_TRVA_FAULT, msg[0]))
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index dd3c068e1a39..2a21203b1a2a 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -169,6 +169,7 @@ static struct xe_vm *xe_pagefault_asid_to_vm(struct xe_device *xe, u32 asid)
>  
>  static int xe_pagefault_service(struct xe_pagefault *pf)
>  {
> +	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);

Nit: can you move this below the struct stack variables.

>  	struct xe_gt *gt = pf->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  	struct xe_vm *vm;
> @@ -180,7 +181,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>  	if (pf->consumer.fault_type_level == XE_PAGEFAULT_TYPE_LEVEL_NACK)
>  		return -EFAULT;
>  
> -	vm = xe_pagefault_asid_to_vm(xe, pf->consumer.asid);
> +	vm = xe_pagefault_asid_to_vm(xe, asid);
>  	if (IS_ERR(vm))
>  		return PTR_ERR(vm);
>  
> @@ -242,14 +243,16 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
>  
>  static void xe_pagefault_print(struct xe_pagefault *pf)
>  {
> -	xe_gt_info(pf->gt, "\n\tASID: %d\n"
> +	xe_gt_info(pf->gt, "\n\tASID: %ld\n"
>  		   "\tFaulted Address: 0x%08x%08x\n"
>  		   "\tFaultType: %lu\n"
>  		   "\tAccessType: %lu\n"
>  		   "\tFaultLevel: %lu\n"
>  		   "\tEngineClass: %d %s\n"
> -		   "\tEngineInstance: %d\n",
> -		   pf->consumer.asid,
> +		   "\tEngineInstance: %d\n"
> +		   "\tSRCID: 0x%02lx\n",
> +		   FIELD_GET(XE_PAGEFAULT_ASID_MASK,
> +			     pf->consumer.id),
>  		   upper_32_bits(pf->consumer.page_addr),
>  		   lower_32_bits(pf->consumer.page_addr),
>  		   FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
> @@ -260,7 +263,9 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
>  			     pf->consumer.fault_type_level),
>  		   pf->consumer.engine_class,
>  		   xe_hw_engine_class_to_str(pf->consumer.engine_class),
> -		   pf->consumer.engine_instance);
> +		   pf->consumer.engine_instance,
> +		   FIELD_GET(XE_PAGEFAULT_SRCID_MASK,
> +			     pf->consumer.id));
>  }
>  
>  static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *pf)
> @@ -273,7 +278,8 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
>  	 * mode, return VM anyways.
>  	 */
>  	down_read(&xe->usm.lock);
> -	vm = xa_load(&xe->usm.asid_to_vm, pf->consumer.asid);
> +	vm = xa_load(&xe->usm.asid_to_vm,
> +		     FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id));
>  	if (vm)
>  		xe_vm_get(vm);
>  	else
> @@ -474,8 +480,9 @@ static bool xe_pagefault_queue_full(struct xe_pagefault_queue *pf_queue)
>   */
>  int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
>  {
> +	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);

Same nit as above.

Otherwise LGTM.

Matt

>  	struct xe_pagefault_queue *pf_queue = xe->usm.pf_queue +
> -		(pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
> +		(asid % XE_PAGEFAULT_QUEUE_COUNT);
>  	unsigned long flags;
>  	bool full;
>  
> @@ -489,7 +496,7 @@ int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
>  	} else {
>  		drm_warn(&xe->drm,
>  			 "PageFault Queue (%d) full, shouldn't be possible\n",
> -			 pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
> +			 asid % XE_PAGEFAULT_QUEUE_COUNT);
>  	}
>  	spin_unlock_irqrestore(&pf_queue->lock, flags);
>  
> diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/xe/xe_pagefault_types.h
> index c4ee625b93dd..2213cea886c7 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault_types.h
> +++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
> @@ -65,8 +65,13 @@ struct xe_pagefault {
>  	struct {
>  		/** @consumer.page_addr: address of page fault */
>  		u64 page_addr;
> -		/** @consumer.asid: address space ID */
> -		u32 asid;
> +#define XE_PAGEFAULT_ASID_MASK	GENMASK(23, 0)
> +#define XE_PAGEFAULT_SRCID_MASK	GENMASK(31, 24)
> +		/**
> +		 * @consumer.id: address space ID and SRCID, folded into one
> +		 * to keep size compact
> +		 */
> +		u32 id;
>  		/**
>  		 * @consumer.access_type: access type and prefetch flag packed
>  		 * into a u8.
> -- 
> 2.53.0
> 
