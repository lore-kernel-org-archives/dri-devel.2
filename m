Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC5C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C3410F34D;
	Thu, 13 Aug 2026 13:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OYT4o8mb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F246C10F339;
 Thu, 13 Aug 2026 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786628355; x=1818164355;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2Tsnj3E/ij0Fm3RIC6o/QU4fM/aHu6cZICr+2mQZd/8=;
 b=OYT4o8mb2dRNNPjKQgpKKEEft8wnwrN51tHun2UM2Fx2T+y9CTHvk1yV
 C3cMgL7JdbH3NLgEXESIte4T6GQYT0uiSWoXZQf9+oJdnRj8F8jGmsMgZ
 LK3nbqVTkjvhgcbHbAJkL9ICy4nJGWxmBSEmHhieJoDd+gZEm4rScsTHh
 iAzt2FEbaBA1j3E/tpbd8Mq8VFTXqFF0BJz+WTuOlH/LTrZjlF3qhDpLi
 qGBFeBpJiFqB1Uxu5W3yelaYw7mZnFRSmdVOgx/jL444TPISIuC3KXmNX
 W4tQ/q+hqVHnl2A9xLhpWgWZ6aMrNgelyfaKc4u8hZpbbSD1nrLStdV0Y A==;
X-CSE-ConnectionGUID: Y9FKIZWEQr2Ikij3fAboGg==
X-CSE-MsgGUID: pbvRjmQoSryKwYYfNXJBsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87328296"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87328296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:39:14 -0700
X-CSE-ConnectionGUID: bU21GhMdSOGQzs7T5Be1dg==
X-CSE-MsgGUID: Z5b+uQvPRZyt+/cKJSAWdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="259698600"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:39:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:39:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:39:13 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5TKtNH25iI9nojwdVksNtzjPD7su3ftC34LhtDboJ8LptwhM1H3iG0radoyDiy69IIahkilEPfzCbbkYGgAL0Bdp1PjkPE8K4sjYMfYT+SjJ/9/VjgqbpQuhc6bgEGk5+VLCOI617dXrfY8q/pZ9bSSe8qgcMHMbGsU7nv92JV31y4mgkINiKHYlPxPAAR+KuTOlOKHYB7/AqSjSH7r3dFyjE7rWNBCmDc86bSh31IgyRsTyTUFZPIwAV0/hXkfJV4nBjtHVsZ81EC/OmQP/lXSOrD1+TFqV7d3a+Sa/WKx1rAAUYOC5QlO5ut3bgtRB8qTRYPHjS8P74pDPULAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRYB9HNR1P72d3BMm6RRAZBCN/v0OMnN7lsW6Rq5iXU=;
 b=mAzmi+N1nbZN2pMDyBaU8rjJyZ3YZ+gEK1u5NlXaJGDG7BHNs3VRS16mpsNG4ImI4RgpirOSrRIHeDyxg96cc0I9ZWbOhYYfunzIsuFC5i209kR7WMjwkHMTUmmprGK5UQu464pkF5mkFyDmcRMI+c0/cVRLazysQ6PjRQp0O7XUzRpy4mE5MFJKfQSuYnyCCxXGKwVNvnXsV+4o4EG927giOSpXkAGFZAJrDpDaPlZUZ2dlz8V3wtYuSOCXqFcDcWZjLAZjzA5qrkgsaEUj9RNLZtgbGputmh5WsrQc6MV6DBZ/gwRbSvQGOkzP69iZHN2Xcamc5mN3yfftk953/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CY2PR11MB836268.namprd11.prod.outlook.com (2603:10b6:930:111::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:39:07 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:39:06 +0000
Date: Thu, 13 Aug 2026 09:39:03 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dan Carpenter <error27@gmail.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
 <matthew.d.roper@intel.com>, Matthew Auld <matthew.auld@intel.com>, Xin Wang
 <x.wang@intel.com>, Balasubramani Vivekanandan
 <balasubramani.vivekanandan@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: tests: fix error message in
 xe_migrate_sanity_test()
Message-ID: <an3I99w2KFz6dPul@intel.com>
References: <an1tu0z3T-qX1ogn@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an1tu0z3T-qX1ogn@stanley.mountain>
X-ClientProxiedBy: SJ0PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::33) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CY2PR11MB836268:EE_
X-MS-Office365-Filtering-Correlation-Id: b62b68af-dd42-4ee7-ffa1-08def9403f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QFDO3V9azOGjW2uTarM2KL5ghCtfdqG30akClIiiWeGNuvGuu9fbyvzVywgaQKjCbOfuiPtET+WGcghj/+k3hpn15DAuFc7zwv5n+NN6PbUOBAj7Eugajl55VkyflC2ys9xMe/BRIMF4R98OE+HTXeXxmX+hM7Ew/+8IGu8hZY0uG2ESgAPz6nd2xs+ApAdZLEH3w7BPi03YTvTOhH55XokXTYoNuxlvmLjaNDGYtFpc5R1uQRdcMz7D4Ue8W0s/AvnpITfNG0++vU7OAgnQlJ5d1tg0BjKuKhbi3qFhmoCJBl+mZmnFP2LarUdhIu+Txhjg+SD5epossYf1vjzkBqngQ1oEVeHE+AnCiwZdVoIeb+yeQ9cKiDaY6Fvhl85ZcbjNtGhkn7Yug7MJWHVuoblDWZdg5kisVABuhg24s9C0h68+JqcJy7r/Hw5UvLw5DeT+wJDyPUWFfKkNTjxUn+zub8z5a9x+ULiT7Ig/sceELJLYE1nE/qMdvXCQcu7YF3QRX+DGtXluTQGDvZGoEHpgHbV5cMigxCmtsbkdcx30pMhIq9g76Oqqr5cqrBefRqKOsJo0x1Cl7j/6vlIUeRoB50OuzvU1/U6Jp0RPZUv49NGuFce2GPleC7remCw3DnIT5EdgYAl4EOiWcqtbVJjaL6IqWxZKiv3SqWv5OaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ju9GApfkpfbJyE3/GRMyfAOyAsZz17MdG+tKAP79O7R1lQKSAOE56V2QKXeX?=
 =?us-ascii?Q?KgzKjcZ4h800PRCqm6fAuzpnIvZdAA1qwDhl/Li02yTPvaKkGQGEVLsYiE2M?=
 =?us-ascii?Q?fbKRXGTiXEfR3JSO3nq49Z4XVxUQQ9+WM5E6yxxHK56vw5TZ+AEpeckplnRd?=
 =?us-ascii?Q?pLKcdQVuDv9e31y0Vd9fBHdkzaV7ThGCW9vZUnK3avQwihRALQxJcaDMcO2C?=
 =?us-ascii?Q?SgbjlCCSGXoz+lHGX1Rkz4ipFRn7PdJ0/Y3Kmm8y8j20WflCF1k5yzefpnlF?=
 =?us-ascii?Q?T/IhzqFxrJ/nvvGwjb6BiT383gKZNUZ2wOLEyqBdbQ3onCsh8zw34jADVBJy?=
 =?us-ascii?Q?/bIIZhrTSWWKOcurKFDwAz45rswCZqtbvkvZRqjZZwSiKLOkTVVs6vQqre97?=
 =?us-ascii?Q?NFDqs95lyjqL1GfzsLLDGJtD8BrqlaOmXrWqLG5j6qXTMMbClncoSjZ7keMQ?=
 =?us-ascii?Q?nRq25IDoLe/pSUlSo1MBs85cNIFQ0r54XCe/8011CxyEfCBs7svMO6259lMU?=
 =?us-ascii?Q?y48NZllpCY+3FSpgAfFx+VKIGrjWGkDSvces4Lu+HD+FDSjR4H42NKyEwkOG?=
 =?us-ascii?Q?7JXBa6fXO5cIEjHqAtBRZPBjPTT3ZjdBVqDRUQpBFe1lm82YZw1NS+0EHHsC?=
 =?us-ascii?Q?M0xYKk3xm9ma6gDdyWAviFjU7GhMdYV9A9p7JZVP7hQ99U9FDPfs30qcv8+v?=
 =?us-ascii?Q?9nH8JOdjHLrc5CgWzTsMwuj8VYB7JOVm3MwApevxYRUtKzKwAIxTMWvE8vEi?=
 =?us-ascii?Q?rEpYFJXb0+HjMmHjnvI7ADOYrft/rnNblo1GiwaSYVE+ATy/HTJlMb3jPWun?=
 =?us-ascii?Q?VWpqx5xDtNQajSuoKMwjSiS07c0P2+FOxb2hVVkiE7afQajLloWW/quvHmqh?=
 =?us-ascii?Q?jXtg6uaMl/4qxaFZ60uY/SWKjcCJTcSR8l/Vw2bhu3Mwxep4qMeOdjGN61zZ?=
 =?us-ascii?Q?Ks6W/MdaNOFy92vYPlv/7oHDk4odfoy2RbbUQDNhIaPf0J+tWFxTz9F2nZ7T?=
 =?us-ascii?Q?MBEs4z0XDWBSoyGaP5UpAjMSCTNLW3rldK1CjjlYP9MbFc+6tjKsiVkk00it?=
 =?us-ascii?Q?uxlO7oAJI4lX0OxMb/zZgwz6s2Ncv+7KzY9LonwAjj+vqEh0C6cldCBQo9bR?=
 =?us-ascii?Q?nXFh3+FAYWQUItNP3DrqVEjRpWZO2KeV+nyMGoPIqXrUcOEep3Pw9/Vf8HCG?=
 =?us-ascii?Q?zlLGg7jioexJH4SKlbf6fC/IjOKEt4GHTp3fZIZ4mae9NqCxGthedYdagi2H?=
 =?us-ascii?Q?SVhewIhHfr12DY0objP2vXzGVgrAQRY2Nkj+z7u5W1qUSCjfry5MMGvvbNmy?=
 =?us-ascii?Q?R7c1Fqq0x7s5xGldmfIEomE1Y5zyDuvQJIT75nySMPgAbkuOut3ohfGvUJgV?=
 =?us-ascii?Q?7nZ6E5wjpEHslZ5DbSpSHMjbf1rjfE886QJga78u9wgJjnPpltLFqLyl8U7F?=
 =?us-ascii?Q?A7n4x8wWKD6g1j+iD6q9k5+g2V1ZPj7Z0RGAYSSZjVDuXrvkRB2JSHqA57JK?=
 =?us-ascii?Q?i1z+wr1effe/iqB71NvbnLMTc0Beue7gVFMQtQQIpJoh4yCCCM/e4Mnc5ftT?=
 =?us-ascii?Q?ixkWYYIS6BBnByO9o87umZjy5vgxrPGLiJe/2Ta34yVPhAYxSE+EpJoLpYtD?=
 =?us-ascii?Q?bAyzzIbAJj8dfpqyw79u51hJnc4Wkrsjz4LKzLnW2cghCfTtXN+GVUqtRjw2?=
 =?us-ascii?Q?qVyJjQHkctGuTz/ZaYrvClHWEGHUqsNvNOwCB3r3gXM3sjlXIbY97sIWuqws?=
 =?us-ascii?Q?DQYohtGR1Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: r/AQUl5XTy+SmjgCmWzbuGSg0SpFpDfCpZHQyreVpal08ff5Nx2aTP0H5b7E26PSNb02GnpgoJ3W/92RZfu1HAfj85kHkHaLU2TwaGSHCdS0NCO9GTBeJUTNqF+T+EYJHFxmEq+P1EMc4GiJRmfUPVAkMzSXBbfvWnSbr+ePNNGWkdTnh7XLeqYV+N8ekuNmCL+gziAtS3BnxY2cGk2HPyVWbz8c/5qdGydwM6hkx32RU9lvkMP2p3iLDpgUEuYOx8vp2vf1x/oHQXlI1TWuXmzmXWTUKQm5TPvhxLuM7hlHGQu25jZP1RwbB+REsFXpIshd0z4u06Wimd3DFDEk9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b68af-dd42-4ee7-ffa1-08def9403f22
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:39:06.8501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJlINDYDcn9P9ACoszccu6Tyt9vDK3zoJE4+TP/8sl+p/rEnqjDb3FDlq4lK58EOOqx5GaFa2Z7TEqcdtLTi6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB836268
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

On Thu, Aug 13, 2026 at 10:09:47AM +0300, Dan Carpenter wrote:
> This is supposed to print the error code but there is a copy and
> paste bug so it prints "bo" instead of "err".
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

pushed, thanks for the fix

> ---
>  drivers/gpu/drm/xe/tests/xe_migrate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
> index 3c1be809be82..f10d9513747b 100644
> --- a/drivers/gpu/drm/xe/tests/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
> @@ -198,8 +198,7 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test,
>  
>  	err = xe_bo_vmap(bo);
>  	if (err) {
> -		KUNIT_FAIL(test, "Failed to vmap our pagetables: %li\n",
> -			   PTR_ERR(bo));
> +		KUNIT_FAIL(test, "Failed to vmap our pagetables: %d\n", err);
>  		return;
>  	}
>  
> -- 
> 2.53.0
> 
