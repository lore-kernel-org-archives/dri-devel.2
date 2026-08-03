Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755F6C55838
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A292710E027;
	Mon,  3 Aug 2026 17:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZAeO7Rx/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A0410E027;
 Mon,  3 Aug 2026 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785779195; x=1817315195;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8EBSgbLNoNuoRqQNR5XKUAjyOtdHMfXw5VMdXItXVPk=;
 b=ZAeO7Rx/tAqQF89hgKCpl8e+HqoTGmMoOx/hyv//I/bPkpX49xvFSvqe
 Ip1XIhOa8m6mmB6A6mG9bD8PjDoIUxV/UL38W2kaxc3Lc0cuySIYWhUYu
 MwBdUYIGwfF5OI0LrPwLRKGerEjhn1etIvDq5Nju8krX/SD2yViG4hiu+
 DLyShit6njVfbX9eamghsN7dPmm7Fv62LJVlW8sR6CBQ/ApqJjKWB2bes
 BQefo63RLgsmwE3mFiyW53Rxk4ouMvCzPaj0S43Aewf2msMmDavil5MIH
 P1+1f4Gz48eSBorAIIlpN0dITGt0hZTtmQXBwv4zZL8ClPz8N6GOvEdM8 w==;
X-CSE-ConnectionGUID: THRbNA8yQvOWfMl3tKHlqg==
X-CSE-MsgGUID: 4MJnD5YeTFiHYhQvrlVizQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86356640"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="86356640"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 10:46:34 -0700
X-CSE-ConnectionGUID: vVLaCeOiRdOVn6Gy53+9bA==
X-CSE-MsgGUID: BlIROZG4T1Sv+vUjMgd6uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="261345741"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 10:46:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 10:46:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 10:46:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 10:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN43IU1RXRMW6mlbni0a1uSml07fdzzn07qErcF58g2yT8Sg4NnOdgxmUnDUN7g6WQkK1lHJa+LEYzLFLUPtPOaoFYf7ETpJkMOxEpLCzPbXtD6/jOtjs8stcpzotCmRaQYW04uH/O6PIYK+1Cp6ejDHK7J92Zt2uL+VSqsf3ch6vs4iWn9ro+oFK2IXS0B9uTD+aVY5vWFj39kc16D6tTzwsMH0n/789sNJav6Y1/+37aXxD+T+W0/MMKgEDFIf0BtmNKykNw9G8lin6/2p8WYHldfcbczHF0WQtUZZPyJ5PVv3VqIB8t6Rzxl2PImhRY1v+bjQhsjH/645E4vv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivyw3o1i0F4F4IR4kTCxq/ILpTUU47bbZLv27y7jIuU=;
 b=nfmPHuvFIme5l8BgJmfmkaZ/1N21h8cg6xkKPqwLlAtAVenHMyt0JN21ChH41t9Wc6hKlvbqOUSNwbv+YhwFd25XQWFKQT2KULLEjfYRhwEy5y4KPhiGib3k5MSBZ4mJ+Nf1PGlp5z/arwzvylPEQBCCwbzNjEr8QR/J4edJpxQ8IXraxQooEsdZ7oBZxYJOZ4kWIzvqAJqAesOjfoVukWEQ+OLxDaVvEPpKU6zmmT4MFXZn8ufJLISDuAmBYkBb0Kg0W0VkyuElyIh14ja03r+OVwvfKhcpePWx4P5nB11QIxX7JtS6Mq+pvBNnRylKGTq3P0s/UEfJKZyQ9jtBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB9775.namprd11.prod.outlook.com (2603:10b6:510:397::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 17:46:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 17:46:30 +0000
Date: Mon, 3 Aug 2026 10:46:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm/pagemap: Prevent double migration of device pages
Message-ID: <anDT86fV1Xbq6fkc@gsse-cloud1.jf.intel.com>
References: <20260803092553.4117408-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803092553.4117408-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: ce99a04c-c37d-4d4e-eeca-08def187264a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|3023799007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 44mMOvT8M5tR2uPziPTFcc7v1lrxeSLuwwWey6eF/L3DJ3D3V4TNrkYMyJKimHYsc4Rnu3UYkJtrpIT9oWGNXH29K5YhLtoInQf4604mMIZnzxx/+2dS+TLPJDtyh4Hv7+I0xf8Nn+81fxDo1dC8s/vLWqYZf4S/MAUK3zDMk1um3ckjeQUfL3SiDMN8/ZKDn7IDSre7wKDRVXUjRcxlTmMSdpkxGapljQEtOGlRH9rw05MOQmUz0E/LD6fUZZsczgy8ayHdRquhnwW4kG0vyXUuV686Nyx9xC5w24Jv7U2gm8YfKj92tk1QmAcLyFV6A+Tg0uEAd967E78TT3MH2w0OR/Wttzrd25zkUGmtG0GX3aAtCSWx3TTjzMyd4zqajbFxNQGiIktRBe+nhGUKhYXGrHvq2gT8IB48ctCiwCDKAbLFeysoFAcMOD2ooWr86N62aRkNc2D3qT2LMpnoAAgr4J+VvSQIWg3M5HCQPqCR5TrG3i7N18iq2iHjGapx3q6Sccj4Ue2VwFVghH1tpec3+niGPGlhFHMwj5yYB+XJxYtlDDsap0f20TWvcMModkqcxF27E8gMQ9LXX4sTfVftwY3pMpyPjZuKgYKwPXRzACfe4BvooDCt2pnV2S47x6bhcdGUlqv9jN6c1E/qIclLxEwR49GH5YQ4v8OXssY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(3023799007)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kGSy0WcF6HWyixzet28cSDsb3CHY7ApCLICJ6fwXMiHjD4bkndPs00z7jz?=
 =?iso-8859-1?Q?Vk4XqeniEb8EFwqv6sYPlc8YiLahLsxW9gQ5pogAdEoAuPJc42l92lidHB?=
 =?iso-8859-1?Q?RQWA+COID8a+o49W+yGNoUUEYfyDqUvMKyVsuXhlbE6OduFg5wl0jR3SL8?=
 =?iso-8859-1?Q?oWyxo/gaA/c/KlrEV3gVwshnPZXZlJXL4TgLy/j3Y7iIrQwkRHD4aYPzrg?=
 =?iso-8859-1?Q?tfUSawHPCdJQYnK720/ZI3iJe7lptYLa+euCSe+hIWEmCDtQl6OJXvyqn9?=
 =?iso-8859-1?Q?KPzUPx93FYxVTK72606pYzqK69MEoKS9QMC1NdWMyBoorREhkT0YceK+gw?=
 =?iso-8859-1?Q?VBWUCCtCMbjrJ9B+CzX76SaIHHkFw2QS38N9ScUCRrd97dLy8HbIB+mZ8K?=
 =?iso-8859-1?Q?gI8nRpOQejtZOaQvjTANGrCnv53HYMPUcHUhXZer8KclypOjUk7NAWXvWu?=
 =?iso-8859-1?Q?siaFmEdiMTRz22ddTQarfvpQeKP2nH6R8D6Or6xV/ps4yoyH7Una8kTA6I?=
 =?iso-8859-1?Q?YoyiGeI/ukWM2tCF4OE71kUG+5cN/GDQ7jVUyFgvnHHySgY8repx2yl7lS?=
 =?iso-8859-1?Q?MUnLB7suMBmEGjQPxjrPPFcnc+zBAkT5nMQ7zrJz69JNcgZK9EjU+LYpLK?=
 =?iso-8859-1?Q?/UphZB06NfiRWSn+OvXtvDz5nkxnO3UtdCmvnRjX3e7b9az62YX8YAvDkM?=
 =?iso-8859-1?Q?DXTsbnFVU7Pmt9m7wcWkmVhXkt6NlqkOrMf1IANQuRFpI0KPdgVbnYzC4v?=
 =?iso-8859-1?Q?p8khBmfWJuCVr87/xGTssM5HODaKzrfbF37ocmzkNcVH/9tJ8v8SFxFswG?=
 =?iso-8859-1?Q?8nn2cYvMsUt/WMkxssXGLC6dlFbGrOgGw6oLN+6E3oIpl+LjEOqh0wOC7D?=
 =?iso-8859-1?Q?cR7tMQDcC13CwF+XxSZfALfEw4HhkDYT6+2cNz5ZVp6iQFknc3dZ7deDZp?=
 =?iso-8859-1?Q?DWq4gW0kUnXIFFIHMjFGp5/qeQ87NQ4zV4dTOC44wEKAN4DvFe2AZNITzr?=
 =?iso-8859-1?Q?jettDk2HYVXTCAUDqI9EodB6JJhKhHm0HfLJHUBQzMWEXEOvI1XioC62rq?=
 =?iso-8859-1?Q?8MxTEOIg+RJ/SCkFqbmcKgebzghMTTnkfUsnu2eQA1k6wNqj76oELuD/PK?=
 =?iso-8859-1?Q?5ZBTbiSA4KTGzd6yu/OYn26RSrM93Y+jyqtPv7fvfddypGTh3pLI3fogYT?=
 =?iso-8859-1?Q?w6OqfmapAceok2rpavGr4gBNV/4Q0LIyKIl4Ogr0Xzuf4kp5TC8/uWd/+4?=
 =?iso-8859-1?Q?SfwsQ6++4m7swizoSI823CzGDfc9T4IVCD8NyiC41+Of3QqbQtp2m9E4+c?=
 =?iso-8859-1?Q?J8JifNVg4czk/LuRCM5RK6hWHMeNEwVyaf9xoUgz0KpnjHFREblTuvPLJ8?=
 =?iso-8859-1?Q?R5W7kWqNsmwsJ1b2lNO4WhZw5yNM7WdVNo6lKMbxuMRWw1VJ9SXXBLs29T?=
 =?iso-8859-1?Q?f5aA6qEGUALsw7D5DvSLgVcvin100XWT5mAH6F9LSuPkFH8u0dnKmtWvPJ?=
 =?iso-8859-1?Q?rxA0yIE/46Np3ACRBb+B6lBun0d2eIA2BAXUOzAoZ0afeKreIUmXEtyUcB?=
 =?iso-8859-1?Q?YqlU5IdZvnH/9L+8cZMsVLOZTMMrfDeJdDDIgh+YocdgfaZTvl8ebcrTMO?=
 =?iso-8859-1?Q?CJGvUVQaxLimvKQVLl8AovqIeMb4Ave8AfwfqnbZtaazNY4jdRtwonBYUK?=
 =?iso-8859-1?Q?0MzXyHsAyie92NHkeLln/nUaZJpE72uI15glFJvOk0gqeO7bE08GX/z2MA?=
 =?iso-8859-1?Q?Q86cYJRtKEeaZfy3eHaEEzV4Ft8ibj6flLtocB1rJ5yxN9Nj7tH7RDjtHd?=
 =?iso-8859-1?Q?RvSRyhxH0Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: jAsHq+I7MlmHhn58P27t8H6iNzSBy56MYtPR/SaO5F008cLj/CG9B5nyCKPqxxlLAa0ji7hjn6zqhmfICFA8zY1V5GOITYDXdXtx837gzLBZTw5djjoTPGxda4tgXHF1RM52yRHeYMkqo5Y7+ws832ytyAHQuHqY9tSaCJoiiFLxIlahMgljN32EaxAn7rpG/Dad71ddvfxFZlxRVrrAI8P4ZSCUTaQ9RPAj/Buh+ttt4AekoIcOMAX63boIhIG5sEZLurU1nBab+ro2IGbvp8L7Gwq48SzUgSX0IrJxW6H0qVPXEZWESRkQ6MpUJ8vIJWwqToyOaeP72DISbIzz8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce99a04c-c37d-4d4e-eeca-08def187264a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:46:30.1391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LigI3Y+7HDAIYNgtbNPu10S1wRTB6bZhET2Ub7Ts06xKcEV9BB+beDlYzBfZ2u8L2fqv1b4XzyRKmzyqQSeGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9775
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

On Mon, Aug 03, 2026 at 02:55:53PM +0530, Arvind Yadav wrote:
> A device page migrated to system memory by a CPU fault can remain
> referenced for a short time after migration completes. During this
> window, the raw-PFN eviction path can select the same device PFN and
> migrate it again.
> 

So is the race a CPU immediately followed by an evict?

> The first migration has already moved the memcg charge away from the
> source folio. Migrating that source again can create an uncharged system
> folio. Adding such a folio to the LRU can spin indefinitely in
> folio_lruvec_lock_irqsave(), resulting in a soft lockup and an RCU stall.
> 

Do you have stack trace of this lockup? It would be good include that in
this commit message.

> Track successfully migrated device PFNs in drm_pagemap_zdd for the
> lifetime of the device-mapping generation.
> 
> Record successful migrations in both the CPU-fault and raw-PFN eviction
> paths.
> 
> Make raw-PFN eviction skip retired PFNs, preventing an already migrated
> device page from being handed to the migration path a second time.
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 188 +++++++++++++++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 7a056592ac66..f7040fc0dea6 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -7,6 +7,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/migrate.h>
>  #include <linux/pagemap.h>
> +#include <linux/xarray.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_pagemap.h>
>  #include <drm/drm_pagemap_util.h>
> @@ -66,6 +67,8 @@
>   * @refcount: Reference count for the zdd
>   * @devmem_allocation: device memory allocation
>   * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
> + * @retired: Device PFNs already migrated to RAM. Entries remain until this
> + * mapping generation is destroyed.
>   *
>   * This structure serves as a generic wrapper installed in
>   * page->zone_device_data. It provides infrastructure for looking up a device
> @@ -78,6 +81,7 @@ struct drm_pagemap_zdd {
>  	struct kref refcount;
>  	struct drm_pagemap_devmem *devmem_allocation;
>  	struct drm_pagemap *dpagemap;
> +	struct xarray retired;

I don't think an xarray is the right data structure here, given that
load/store operations are slower than direct memory loads and stores.

The CPU fault path is about as critical a code path as we can get, so I
think it needs to be highly optimized.

I believe a bitmap [1] is the right data structure.

include/linux/bitmap.h

I'd suggest using an embedded bitmap here, sized based on the ZDD size.

For example:

/* last member */
unsigned long retire_map[];
 
Show more lines
4K, 64K -> length 1
2M -> length 8

Lastly, the only bits that are ever checked are those corresponding to
the folio order. For example, if the folio order is 9, only bit 0 is set
and checked, and the check loop increments based on the folio order.

>  };
>  
>  /**
> @@ -101,6 +105,7 @@ drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
>  	kref_init(&zdd->refcount);
>  	zdd->devmem_allocation = NULL;
>  	zdd->dpagemap = drm_pagemap_get(dpagemap);
> +	xa_init(&zdd->retired);
>  
>  	return zdd;
>  }
> @@ -137,6 +142,7 @@ static void drm_pagemap_zdd_destroy(struct kref *ref)
>  		if (devmem->ops->devmem_release)
>  			devmem->ops->devmem_release(devmem);
>  	}
> +	xa_destroy(&zdd->retired);
>  	kfree(zdd);
>  	drm_pagemap_put(dpagemap);
>  }
> @@ -1102,12 +1108,169 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>  }
>  EXPORT_SYMBOL(drm_pagemap_put);
>  
> +/**
> + * drm_pagemap_is_devmem_page() - Is @page a drm_pagemap device page
> + * @page: The page to test
> + *
> + * Return: true for device-private or device-coherent pages, which carry a
> + * struct drm_pagemap_zdd in their zone_device_data.
> + */
> +static bool drm_pagemap_is_devmem_page(const struct page *page)
> +{
> +	return is_device_private_page(page) || is_device_coherent_page(page);
> +}
> +
> +static void
> +drm_pagemap_release_retired_reservations(unsigned long *src_pfns,
> +					 unsigned long npages)
> +{

This function won't be needed with above.

> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		struct drm_pagemap_zdd *zdd;
> +		struct folio *folio;
> +		unsigned long pfn, nr, j;
> +
> +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> +		    !drm_pagemap_is_devmem_page(page)) {
> +			i++;
> +			continue;
> +		}
> +
> +		folio = page_folio(page);
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		pfn = folio_pfn(folio);
> +		nr = folio_nr_pages(folio);
> +
> +		for (j = 0; j < nr; j++)
> +			xa_release(&zdd->retired, pfn + j);
> +
> +		i += nr;
> +	}
> +}
> +
> +/**
> + * drm_pagemap_reserve_retired_pages() - Pre-reserve retirement slots
> + * @src_pfns: migrate_vma source array after migrate_vma_setup()
> + * @npages: number of entries in @src_pfns
> + *
> + * Reserve every base PFN because migration may split a large source
> + * folio. Recording the result must not allocate.
> + */
> +static int drm_pagemap_reserve_retired_pages(unsigned long *src_pfns,
> +					     unsigned long npages)

This function won't be needed.

> +{

This function will look something like:

	unsigned long i = 0;
	int err;

	while (i < npages) {
		struct page *page = migrate_pfn_to_page(src_pfns[i]);
		struct folio *folio;
		struct drm_pagemap_zdd *zdd;
		unsigned long pfn, nr;

		if (!page || !drm_pagemap_is_devmem_page(page))
			continue;

		folio = page_folio(page);
		nr = folio_nr_pages(folio);

		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
			i += nr;
			continue;
		}

		zdd = drm_pagemap_page_zone_device_data(page);
		bitmap_set(zdd->retire_map, i, 1);
		i += nr;
	}

	return 0;

> +	unsigned long i = 0;
> +	int err;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		struct drm_pagemap_zdd *zdd;
> +		unsigned long pfn, nr, k;
> +
> +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> +		    !drm_pagemap_is_devmem_page(page)) {
> +			i++;
> +			continue;
> +		}
> +
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		pfn = folio_pfn(page_folio(page));
> +		nr = folio_nr_pages(page_folio(page));
> +
> +		for (k = 0; k < nr; k++) {
> +			err = xa_reserve(&zdd->retired, pfn + k, GFP_KERNEL);
> +			if (err) {
> +				drm_pagemap_release_retired_reservations(src_pfns,
> +									 npages);
> +				return err;
> +			}
> +		}
> +
> +		i += nr;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_pagemap_retire_migrated_pages() - Retire CPU-migrated device PFNs
> + * @src_pfns: migrate_vma source array, valid after migrate_vma_pages()
> + * @npages: number of entries in @src_pfns
> + *
> + * Record successful migrations before finalize unlocks the sources.
> + * Release reservations for pages that were not migrated.
> + */
> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> +					      unsigned long npages)
> +{
> +	unsigned long i = 0;
> +


This function will look something like:

	unsigned long i = 0;
	int err;

	while (i < npages) {
		struct page *page = migrate_pfn_to_page(src_pfns[i]);
		struct folio *folio;
		struct drm_pagemap_zdd *zdd;
		unsigned long pfn, nr;

		if (!page || !drm_pagemap_is_devmem_page(page))
			continue;

		folio = page_folio(page);
		nr = folio_nr_pages(folio);

		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
			i += nr;
			continue;
		}

		zdd = drm_pagemap_page_zone_device_data(page);
		WARN_ON_ONCE(__test_and_set_bit(i, zdd->retire_map));		
		i += nr;
	}

	return 0;



> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		struct drm_pagemap_zdd *zdd;
> +		unsigned long pfn, nr, k;
> +		bool migrated;
> +
> +		if (!page || !drm_pagemap_is_devmem_page(page)) {
> +			i++;
> +			continue;
> +		}
> +
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		pfn = folio_pfn(page_folio(page));
> +		nr = folio_nr_pages(page_folio(page));
> +		migrated = src_pfns[i] & MIGRATE_PFN_MIGRATE;
> +
> +		/* Keep later folio splits covered. */
> +		for (k = 0; k < nr; k++) {
> +			if (migrated)
> +				WARN_ON_ONCE(xa_err(xa_store(&zdd->retired,
> +							     pfn + k,
> +							     xa_mk_value(1),
> +							     GFP_NOWAIT)));
> +			else
> +				xa_release(&zdd->retired, pfn + k);
> +		}
> +
> +		i += nr;
> +	}
> +}
> +
> +/**
> + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
> + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
> + * @npages: number of entries in @src_pfns
> + *
> + * Skip source PFNs already migrated to RAM by either migration path.
> + */
> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> +					   unsigned long npages)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < npages; i++) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		struct drm_pagemap_zdd *zdd;
> +
> +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> +		    !drm_pagemap_is_devmem_page(page))
> +			continue;
> +
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		if (xa_load(&zdd->retired, folio_pfn(page_folio(page))))

if (__test_and_set_bit(i, zdd->retire_map))

> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;

Iterate based on nr.

Matt

> +	}
> +}
> +
>  /**
>   * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
>   * @devmem_allocation: Pointer to the device memory allocation
>   *
> - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
> - * migration done via migrate_device_* functions.
> + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
> + * migrate_device_* helpers and does not require the mmap lock. Device
> + * PFNs already migrated by a CPU fault are skipped.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -1149,6 +1312,17 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		goto err_free;
>  
> +	drm_pagemap_skip_retired_pages(src, npages);
> +
> +	/*
> +	 * Reserve retirement entries before migration so recording successful
> +	 * PFNs cannot fail. Otherwise, a retry could select and migrate the same
> +	 * PFN again.
> +	 */
> +	err = drm_pagemap_reserve_retired_pages(src, npages);
> +	if (err)
> +		goto err_finalize;
> +
>  	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>  						   src, dst, 0);
>  	if (err || !mpages)
> @@ -1179,6 +1353,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
> +	drm_pagemap_retire_migrated_pages(src, npages);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>  					DMA_FROM_DEVICE, &state);
> @@ -1276,6 +1451,14 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (!migrate.cpages)
>  		goto err_free;
>  
> +	/*
> +	 * Reserve retirement entries before migration so recording successful
> +	 * PFNs cannot fail. On failure, finalize can still restore the sources.
> +	 */
> +	err = drm_pagemap_reserve_retired_pages(migrate.src, npages);
> +	if (err)
> +		goto err_finalize;
> +
>  	ops = zdd->devmem_allocation->ops;
>  	dev = zdd->devmem_allocation->dev;
>  
> @@ -1309,6 +1492,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> -- 
> 2.43.0
> 
