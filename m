Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D5606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oCdz/kgQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADC0112BFE;
	Fri,  6 Nov 2026 02:30:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD43110E9CD;
 Fri,  6 Nov 2026 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793932210; x=1825468210;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=kaeMUF51ToU415C+Pvc+NFsyeJTr1pdTsR9Zt71H5yc=;
 b=oCdz/kgQjqaY7NpLpHaXtUa/jm5D7Z5q8wRRJpYzKHJbDNbyZe60J/KN
 hsU/XFCiu2dE0h0f+Nu5UxEmQ5gBFpn16VzYWuSPKRlIPDju6MFyaeyPp
 sq0pGafub2ZxwOiuHXhD871VEfYKufBBygjrZ1oRHiWXs9BlkGIPXrfES
 glhobvSIo9pWlrJSL+Mqjr9soqBX0AZ8U2cUx9tz1ZqZOMftCR8gYq+HR
 7VQc0EFIfVVZ9a96BaRypmQJ0C0LgxdBuua/JalpGQBFd7KHFxoCQ6rai
 D1Y8ThReH20xJBEJmQhxKBOrD1c5yOoczJXlC1SX3Ulj8Eo5nNBBbOCnf Q==;
X-CSE-ConnectionGUID: e9fCcFgLRA24ludV4cGVow==
X-CSE-MsgGUID: 42DiRGP5RC6JU3f/xv12vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2645605"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2645605"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:30:09 -0800
X-CSE-ConnectionGUID: qyTjkWQnQES/5XQ+fKbrWQ==
X-CSE-MsgGUID: jEWwxn08Sd6gOSnT6Y1fsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7072715"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:30:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:30:08 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:30:08 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xybYjdYZD09rYwJLUBkcVXW5IwJXB/6kBi0HNEzmc8IRT1grFBODKuenW/eGiz829KayHikhSRsEwiIn+tySALpySExD9JqnNAhbGaIRQfNE8DyDyltpy8deTdFGy/Qs7hsiwFljmhh3asVccwH86ngZZAfafaBizreZo1naHyIvaZ9YYgszx+1wyydSqoYuguYlewYPyq2JVuycaOqYfd4xAZXGZqyH6h+zlfCdDXbsG1kAcX6JwD08KvNQ4JaZxNxS3dTJuM/y5v4dZGDABDzmo4pQ3Ocn2MUV3Tn8q+bX72HVk1tRaO+tkMmBYVObbLJ5HHTvAziKs+ZZGcOmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pq2hNE3VJt3Ik6bm9rg/6HMOwNrcCZh5dUk60gwJXY=;
 b=ovZOKOJJVgGzVEu0DhKRC0Ve9PE+6Ca7N0tsxhAtLqJ8Fd1iOdvloOAgJy4e1xJvqnoWbZ6who7NPXZu1tSAKNIBO/+f8U3OhwzmE+G/iQlf9A6i4/z1IWbqsLIR5qqpIclCEugX6LTV5bzCa8pNtE7Ce2kGeMTVN9AmD4dJyVVD9CrGdWtp0Dg5Xmv+56gHHZkGZz0I3ReKqaT5qtTIqP3v/Kk3b1IuI3j2aUzjTFQjX+IaLUsKYegM9XeVElNBW5rKXep086IN4uAd+0oj4veHk00ws0kcNQhJJUoh5/3jmJ6TH+N6LYxERjEUv5rKRFj4edjUf1WkK++gws7ztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by LV1PR11MB8844.namprd11.prod.outlook.com (2603:10b6:408:2b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:30:05 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 02:30:04 +0000
Date: Thu, 5 Nov 2026 18:30:01 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 02/33] drm/ttm/pool: Add ttm_pool_page_order_nodma()
 helper
Message-ID: <au07qcYIZwtgeYn5@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-3-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-3-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|LV1PR11MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: cee41f52-e71f-4b40-d94c-08df3baddd2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009221727099003|261009223327099003|261022105027099003|56012099006|261009223027099003|261102130727099003|261009220027099003|261009221227099003|261022075727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: ocmz50cCY8wfP6qG7fGTvHUIniyMIXQkRNRekICTZY5yUwSarKqApZMf2t6yaSsBxRxnQ+PPAk4Vq9/1bQIop/289bYPs6dA0CGKIo7n8J18Su8/f4/P9MMSGfklAw6fyiHftRDyIXtc2+r6/SoKWTznwmjFI3chB9JKc0rTcpVZ3qOpGUd2JJ+gExCEBZswisGbLuyJSNWVco2E4puhRVEJaOZEtbyIZ49Rbae8Vrs1dqdZn1DEuOxzp5miNVFeoLat1w7VdBkgn56B4+GJTSLCtp62uzvBDG6mwAV6gY0y4aERuHJRFNL3EzSxABvndRI4YwNpswW5syBbhlQ3bSJg/iVZR7ZSAXgLU8jv0gzBr6i25/KeYYlCHkmVFa0Zk1ZE5XGW5DSx6hN33KKcmVOf6i6cwNckY1CddMEDKL0rYWhWSpYcUEk/U4YE8+kEA8d9R2chvR2K4Nui8xLCdVuzOoZe6OtjgDnrq5djskYQuhB9RIrF9nhRZG1hduekzzHkcchRwPiqMaru9+kUgKWoTQl7aUOcQZs6BvJOnlDIDSkQPRXUf1wr5BcA+gAYAUu9yeyRP0B/y0UdBhfp3QQhDTgk1phQUMmpBQxuX083RdSvNFcnoNhCiv3GpiRCaKrIZj8/2YGRLHwA8JixniCH5fdD506E5OMfRrV5Hdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009221727099003)(261009223327099003)(261022105027099003)(56012099006)(261009223027099003)(261102130727099003)(261009220027099003)(261009221227099003)(261022075727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CrE+rN/V4xHw5/aLjdxDFytHRJVSY4TcPB2RJXOduZSQgGTkDBiatDZNF+?=
 =?iso-8859-1?Q?/I9sI4aeWHcgbA9iqjy5uUzsUMO2gVno7HJR6AaLjPDvOGV9Duer33jrf+?=
 =?iso-8859-1?Q?xToL3fhGaw5lwxKcT1lJQtHSjtdJYWquhmVaaCeODTNSfPjDnpM5rZhOnG?=
 =?iso-8859-1?Q?VmpVxdRuapJutf7T3KxPV212F8H0xHNwmOvd/w1YN3ySF6Fo6ELYQqoNoI?=
 =?iso-8859-1?Q?Unx61MEzvZ61XtQ3TXArm8WQGSbyo3TS5cRX2zJMW99VIk+HuuRtNtDm19?=
 =?iso-8859-1?Q?tYtMS3DbCS6VQYaHYRVg/ixicmhEqXnx6pFuaICw2SQAin+20P4rUwY6//?=
 =?iso-8859-1?Q?HyO06/lHzD93xrpulh0b9Q6ASULYIR7cX5+By3fBdU+thFs3x+g9WbCbVm?=
 =?iso-8859-1?Q?GY4RKJAPL/xJVDwROTC9veQqnmrSCNM0O41GJzrOm/13yOyBASN5maDby0?=
 =?iso-8859-1?Q?qrjMEuBFfh78sUSdzdZkyWtmKU4YHo/ZahKcC1V9EUYJmYo7X38almBe0M?=
 =?iso-8859-1?Q?87jC+T/bIC2dm9CjVK7v8UcCsM4LwQGhIdM32g6SwwypiGm10eMzGEnT5G?=
 =?iso-8859-1?Q?LfQF5dank7RnnCF/OY9/QOFGistnvXVmnt76Tv5K3WI/QCD4+lAyvSHk0e?=
 =?iso-8859-1?Q?ZoFOQBVPRePL9pEUFCAnpKrH+gzGKXY8/0/GJ0rbhQ2Mco55AYrsTePdzR?=
 =?iso-8859-1?Q?kSBbKZdbJERaASVguKkZkEZe5V8626DaNwe58+v/e1vTHGAM7myXPKHQIe?=
 =?iso-8859-1?Q?MVCTdg8WIsvY86na9BlY0uYCz/BkJoNdGrAbmyYFVW3ne05LLNNTXTB9v6?=
 =?iso-8859-1?Q?FFUlG5TtmWzqsQtV2E8LZcgJch8+q1MSfEL7t1tX8nrkO4V8eTPQILXuF0?=
 =?iso-8859-1?Q?2QNXRFteeIUC+ZW6ZA6UOtkRpsZXKqCwUxr7huOn2sxbDGmG/bkvLVW88I?=
 =?iso-8859-1?Q?jt9+ir0TDGlxBJbtoAdcp2S/jhDTw8tzYb8QdBCasEpVN0d8RPB3G985Tw?=
 =?iso-8859-1?Q?eHGfQHQGstmKdcM2NK51tp/pyMb1GxAqRnn72PqVxVLKTKGpsIRE7QGqX7?=
 =?iso-8859-1?Q?NuPHeiRaz4UGJhrJNIQL7PCTtcP/EgUnxjQnaYN38VffJUVnL0AYrVP1BZ?=
 =?iso-8859-1?Q?sezlhL/+S2oredEghsnxQHyjjX3G1/rqiy1L6PAIGD2Dt7NeQublAI+1Ew?=
 =?iso-8859-1?Q?daW7m4Dl1kadHetbc6UC3pegILuAJ+/BvPIGRYzKFvOuOozSr9zF9o5nxH?=
 =?iso-8859-1?Q?OJuPboYm9C1FKX50AV57H8U/zmh2wfc93XJoBpCgKA9G+aK5VdV/3pPfKa?=
 =?iso-8859-1?Q?MRQdm5qaM/KB70dcizwYJ0kzwDBcgMdDTfMTDRz317qZIRXqbfHoScfX+y?=
 =?iso-8859-1?Q?gfzocE6RGz5kpQi/ZU4dc5iSzLqp10dKrUn/0yw04r5UBNZBI7C8VQWbj7?=
 =?iso-8859-1?Q?MlZt3y/D3HlxfCjRWs5BnhpE0EqPGrAyibGWvhTHVLTDbbQ65qnPkX/JPF?=
 =?iso-8859-1?Q?CKkaaFWoZ2WQTGJp9ncIzNzMPBdSfTJzFl6rE4x+S7kbjWDEA23R7PTMLp?=
 =?iso-8859-1?Q?YczCAGbR5pHGID8FXh5zMZDgeNdMKb0NtTPHfL/ExpS5J4gQ8R/AYb5fbG?=
 =?iso-8859-1?Q?09abHWqw5ypM6OXT/I2U8HQxeF/AiUoBNo81/9wgeA9d85jPpLCaV/d546?=
 =?iso-8859-1?Q?+/esW/AR/EnXV+J2YJQfDH7y5H9uPyYOT5XZ5zOtUYHMsF3J3CHNduq3+m?=
 =?iso-8859-1?Q?newc2fZyi7fGxfhGqoVoBNDkPrKdUaEoRxtdVccn+8uGs4dW2/rnjJ7Jaq?=
 =?iso-8859-1?Q?FYO8PBn2e5WXAXQeME7i756pxAobakr3aJn7IAn5nsnacGIvfKrg?=
X-Exchange-RoutingPolicyChecked: CYF4Kfg9Nm69W7v+SolvmnEnupeNbFWHysPdcyVe0ClWooOM8Ca8bwQPiFRuC1JeDkC+tUHrlFzcGaKxEUaSHj4zXJ2/PsMqbgdLqVd4CSqWgO22Oo2kSoe29if4WrSS81Hstlku+MSCZrE0iCDaG/hYMpf+z1RMDNAKsrAGTr2qOsKDpNsyoGwLgVYWimvUjAoJNVzjk0Vy3HDI2oIA5L/W66Are0iBLaWWsYE7jGGS7vefGTDK1AKiFEAarF56QbdXZMoJgKCP6j6CxgVGed+lifLuZ2qqlMCvT5UCirbXVCQo6ApFJPj96gog0ZosIBYZ19+QY5SpmB5WD6nsRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cee41f52-e71f-4b40-d94c-08df3baddd2c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:30:04.8340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbTMtqOxzle6lmKF2wDfYGvySyquWu4vM5xKuyG8WKAVs1OZPortU10wU//U+3GebFFFmqeNTfM38WNB08P1MaWr8SgvJj2dDEgppqbjRk5freSW7G7HkShlUSxvU56l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8844
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

On Fri, Jul 10, 2026 at 07:55:48PM -0700, Matthew Brost wrote:
>TTM records the allocation order of a multi-order page in page->private at
>allocation time. For pools that do not use dma_alloc the order is stored
>directly, while dma_alloc pools store a struct ttm_pool_dma pointer there
>instead. Drivers that do their own DMA mapping (e.g. Xe) need the per-page
>order to walk a populated ttm_tt one chunk at a time, but cannot rely on
>folio_order(): TTM allocates high-order pages with alloc_pages_node()
>without __GFP_COMP, so they are not compound and folio_order() always
>returns 0.
>
>Expose ttm_pool_page_order_nodma(), a thin wrapper that returns the order
>recorded in page->private. It is only valid for pages from a pool that does
>not use dma_alloc; whether a TTM device uses dma_alloc is fixed at ttm
>device init time, so callers know from their device configuration that this
>helper applies. Use it from the existing internal ttm_pool_page_order() to
>keep a single source of truth.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/ttm/ttm_pool.c | 25 ++++++++++++++++++++++++-
> include/drm/ttm/ttm_pool.h     |  2 ++
> 2 files changed, 26 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index ab242ad4339e..5b7d7f5ae53d 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -461,6 +461,29 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
> 	return num_pages;
> }
>
>+/**
>+ * ttm_pool_page_order_nodma() - Allocation order of a non-dma_alloc TTM page
>+ * @p: The page to query.
>+ *
>+ * Return the allocation order that the TTM pool allocator recorded in
>+ * @p->private at allocation time. This only works for pages that were
>+ * allocated from a pool which does *not* use dma_alloc (i.e. pages backed by
>+ * alloc_pages_node()), where TTM stores the order directly in page->private.
>+ *
>+ * For dma_alloc pools, page->private instead holds a struct ttm_pool_dma
>+ * pointer and this helper must not be used. Whether a TTM device uses
>+ * dma_alloc is fixed at ttm device init time, so callers are expected to know
>+ * from their TTM device configuration that their pages are not dma_alloc
>+ * backed before using this helper.
>+ *
>+ * Return: The allocation order of the page.
>+ */
>+unsigned int ttm_pool_page_order_nodma(struct page *p)
>+{
>+	return p->private;
>+}
>+EXPORT_SYMBOL(ttm_pool_page_order_nodma);

NIT...make page pointer const?
LGTM.
Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

>+
> /* Return the allocation order based for a page */
> static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
> {
>@@ -470,7 +493,7 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
> 		return dma->vaddr & ~PAGE_MASK;
> 	}
>
>-	return p->private;
>+	return ttm_pool_page_order_nodma(p);
> }
>
> /*
>diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
>index 26ee592e1994..753203980e2c 100644
>--- a/include/drm/ttm/ttm_pool.h
>+++ b/include/drm/ttm/ttm_pool.h
>@@ -94,6 +94,8 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
> int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 			       const struct ttm_operation_ctx *ctx);
>
>+unsigned int ttm_pool_page_order_nodma(struct page *p);
>+
> int ttm_pool_mgr_init(unsigned long num_pages);
> void ttm_pool_mgr_fini(void);
>
>-- 
>2.34.1
>
