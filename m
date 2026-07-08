Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677FEC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFF110E67E;
	Wed,  8 Jul 2026 20:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BjstoelM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360D310E67C;
 Wed,  8 Jul 2026 20:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783541660; x=1815077660;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rUcPCc5wjWiqdPXZaJPgfJ2bv8zbaYSLeoixyJQiv0w=;
 b=BjstoelMylQV8v47P/7R0rjBTm1GEzfS6Qjn0Id/LImUbeOWQmfAQ/oI
 HQRUnfK3AgfjVWbFrBDV/oUd/HlMp12fprNwS99yGUMXjHsjxyd5VrKhZ
 f6JhIIRnJzq+u/qZL1IYiIKTb15kgroGvprHEzrVjEMWkHWFsGL5a3dws
 1Q1NZSAC/2Hx4AZG9pz/2v3xGq3j1b9G/tgXmJ6mETUp1A6j/cO2TLE8L
 lAxT0GStbX4icUVa/BCk5/J8oNU6Fc7MSkwrpBYwj7H7wiGSLAqiLU/Fh
 5iE2eMj86p3wi9cmPZqaAeWTy5WOM0LPJ3dfyxOlb75YI6c9XFpdSWYlM A==;
X-CSE-ConnectionGUID: 9q1eNLyjRqq2KaPAw/rDnw==
X-CSE-MsgGUID: dWNc6SZpQEuPqp7dsiMTCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94864100"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="94864100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 13:14:13 -0700
X-CSE-ConnectionGUID: FkN849QWR56G56scW5zB5Q==
X-CSE-MsgGUID: LOa8cV9vRZ26k3xKpHNimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="253898089"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 13:14:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:14:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 13:14:12 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:14:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whpWBjdVCxnifbhHd/5gfkK9muTnnyZZZ9lFyZqyt+1FXiaz5c/TMmRXyA5/lxDYDKBGHvqO8az3TiYl611NRc7hmOMU4qtha+wqUlNqPL6UamStaL/9IJGVpjv3yDW/6DmXz7UL99usXbb0daxy9E3rv++ow4YYh9HKF+zZ2lwiF646dRTEn0IM6jhZ6IFQjoixSydOePJof9MS7aBPPUf45V72BSW3x6hqZ0ePFXV28F9kGVNe8lzbnkMe7JEgdCA9wkbEUDZ1xak6Pq3C7vM9kmjDaskuHIf7vqWIo4gMSH3/gAt+VhZwWD8GCJeE7Gn70scVG/o7/cX2nmu2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQUo8foUopyZsXbpy5Cb1wy4DGVF0lMviVScrLTOJQs=;
 b=GwpFHvRkdVMVPp/hNxAcfphumhbx+GUKm13evYXxOSTIeeKmgbO1c6ADVe8SQEsJCepMzGU2pHbwnjBm5Wh9Z1Cu5EzvG8g90766lJFL6PVuiVUzjd4CFUuPTod9xroZo8UdMATYNzO2V98R2RpXi/HqU5CfEJ7aA71ENFLF4dSlj+pJEuHUFX42cuYRWt79O6VxiRWrUKH9ecNdQTRfJCqwc0QLwg8zvQeaKX0pDAEWSP5h1wKhXkSP1N7DvftgrGbX5Y5/pYk8wg/RTZ3uDx+bAYDG6wYamD8vn5wZL84H0yG+ePuxNeq6braRx23L6iDOvXkBc0/wYAk//XOk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 20:14:09 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 20:14:09 +0000
Date: Wed, 8 Jul 2026 16:14:03 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "=?iso-8859-1?Q?Jos=E9?= Roberto de Souza" <jose.souza@intel.com>, Michal
 Mrozek <michal.mrozek@intel.com>, Tejas Upadhyay <tejas.upadhyay@intel.com>,
 "Matthew Auld" <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: free madvise VMA array on L2 flush failure
Message-ID: <ak6vi07iw4nfMlEw@intel.com>
References: <20260708073422.725186-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708073422.725186-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH8PR11MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc2b6bc-5843-46b4-1a69-08dedd2d77f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: /hcgz0B5r6stZ8yp/kr5Vy6NEQrE8PX+KwM+aCucOl1m/MVLy+QjgA0VxiGxLd8ukk0cqdRbExWvDrKZpv6tRKoY9KBGqGABdMQfospIDT7XQpRl3yxqhgIvVvdA5vufw9dxc4sZNLLah/u9QSc5b4S27pMAuUaawDnKKvdLxROttW9pGVRdtHPFWs8Q8bsDE+U0+560OdCWcZ0+hxsI3y6Fp60BHlc5H1bhyC3z/AEOzm00lRiPnkc9F6hyq0qCUagLSAVCdEn36Yt3DLxwprAn5H3rnNcrfPZfxINf3ce41AkaSDlVAgEKDL5twNUNLzm9PHqM3nCbstsYmtdeEtCXKgUZRPK3p5l745f5haKrLD7Kj1yNhHO3kNnUWlQk78QQfpQBAkKAtE6WX1FXRfCFttzJ3ZhqdPRKVAErtXn8iuYuM4dQcXpIJyM/Qhs6DPT9VQ3RPENY34bYeK+YJtyMu11Q7zGxVlubxWX17RCnUE7rLU3Sb9Hy4x5DqG4R5Ly5CEXL76wCb9Jk3CBbcDpLylQBsMTGfYxb6BefurIRx22z8Odyinw6BnQ/SzkiRbJ8Y6/DjlT3G63TE88SPDhnaStZsuzaM6tgAsP4tiTXucVEFFLCYqmafEL+SIwEGProdw4sfR5+dGcdE5PaaTP8ZI6g6nbmguqBnVbrIQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FniJ2p4JsQCkuaj64gKU2h/leWawM9b44lm4oVzMdyA0/6hAmfMNXFgj6zRI?=
 =?us-ascii?Q?9HyoRZw7DOhwUQs+7i/G0UFYQZBtdlGc2IV9HXa2sYa95TRInPPOT7gJRH2/?=
 =?us-ascii?Q?c+ANUFVtcfZ8jp/a48lQNgJ6ahcgC/b334nWoK+IGKpPTuK8nrATMrvHSYxF?=
 =?us-ascii?Q?YpLG6ZVO042G4TBXeB2O0ImH4Yu6oHui/k7Xfp9JkcxqzvXGNND7P13nkCZF?=
 =?us-ascii?Q?/SBPq6GqpsTB9ytOm+SXMr/hUCJkw8Az71ps/2GQwT7tCM9TzCH8xakqjJEF?=
 =?us-ascii?Q?w0tJtuVKl2VGCeX7qrs2mNip8o6bjs32i9DnpzURbYhie42Wz7jfS6KjP6uu?=
 =?us-ascii?Q?VtQHhtfeDjaTjpHVdkCSQCFZ+whWR8cPYzXQ4pTjQSUiwWwJpOV4ddakfDhv?=
 =?us-ascii?Q?ia8WHhra5NbcTcBvk/KsY+Y0xsism1VCb4ZcI3+151i2Tqg3HGB2XyH0YDUx?=
 =?us-ascii?Q?0YGNo0Xh4nJWIXs2Ekk9fVdnvwjdwWLTcIJq8bZ7jq8u7AjB6tfqIIhTEM37?=
 =?us-ascii?Q?dghFmaxMiKZ2KgxCyF5rVd5hvK4Gou8EwVb95xFqEJayzxbPLgNCZzukwo3t?=
 =?us-ascii?Q?sF0+Ogl2yrg5HDv1yYrO1UJMekokD0mLXLID4ytih4E13XuFNpy4uKK/ixFd?=
 =?us-ascii?Q?rMO6l+QZooT52Hp/j5GIVkUHmABAK9MCrrOR0hCXLW4qSS/nZtYTcHeSTqy6?=
 =?us-ascii?Q?5L6aIU9mPHZaRroujNcteUnJCKuDsiHzTvvJe1mkhUYBBxjPXuCUJnzZREOx?=
 =?us-ascii?Q?58PyAtsMD2oK/OtEXC0ARedIRZfaOCjlsCFba8zqyOYuo+NRHcgpJB3xgnJx?=
 =?us-ascii?Q?qUqMaYQbxscciwgCeQ4HjjgqBfhClMmINgnzxUjKM50G25peUwq+WRy/XJhN?=
 =?us-ascii?Q?YQlB1flEqprTbx8fE4ZxTQy6xcsgC3RVTGwTta22818OFBq/RmqfTnGHolvs?=
 =?us-ascii?Q?kGe3Cy5jY1XlFtqKe1qZy8ZBX0JZRcJD9Uygdis5zfoj2fTYbbvM3O+MuCvl?=
 =?us-ascii?Q?cR/IrlnI8DoYUhIL/pzFNXiRjTKEeQB1WmzAVSyNdOSWnDkQ9j//SFo8HaV2?=
 =?us-ascii?Q?Qhwo2D2aUqRhDih7Wv5SVdpHtNKs2Cnnu7MdkDf+peSe7+Eicid6DARBP3Sr?=
 =?us-ascii?Q?hUv+4y6NarfvuxRrAu4h/Gvki7oJO3x670gDzhFMA5faq9BCrvnL0XmATcxM?=
 =?us-ascii?Q?mGucuxUXfrB6520h4m4LIhltDDRAb0cmqcLN3cSL1v/8vqdKWpgiXetZ9Zsg?=
 =?us-ascii?Q?O2GraaDkB8MiEMTfPn7sh1+ygo9a9wlVxgaoQkobJDDaGkLvjNvURmufOyd3?=
 =?us-ascii?Q?jrKfRUFiMnbCnUg4TegsSiWIkyy5mIKSddH93P27cc1KntmaGmWTWT+6Ma8+?=
 =?us-ascii?Q?hHmwoROyTkatbuNE74dYFlbdzRXlTWnDzq2Yevh2WEjSptJOhl3abohoLvpY?=
 =?us-ascii?Q?gyINFMc4DCses+KE1GBNHxnMsCmBlZONA0g1MgAkuVix3Ps37+qlw0lc/klE?=
 =?us-ascii?Q?18Unve1nhDBzpxV8hs95TnRWaV1qJn+36nrXV3xibrMY1rYJd4ELEkd8c16b?=
 =?us-ascii?Q?w/Y9IKB2tbcrSnDSZbWnkvWYZCuce0uN8MwLwSPaNPInk/8TOs0aBuJWMtLZ?=
 =?us-ascii?Q?1dTrkaYrx4yEVXPI/ey4Ieloa80/Jfbw33hEmn5mX7vXzIo5INsFLRKt73nw?=
 =?us-ascii?Q?Vok0yj3Qcd2L+yr5CF9Nk4OIzcaedc9LgU4Finvx8Cej9Db7w9TTcLN5m8S7?=
 =?us-ascii?Q?mkVRenHbaQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: F6uxwbzEvwQNmKEWFR4dIPDPQudQ0eDhfAOO1fnWEvHKsKomcuiLD0Bxrpsofo0bAS5xZdQvAgO5WFt3J3ROgfndD17VQc/5GsJ/jY4B0lRaCCAo0iDVzzayn+fiDyJoI1CxCJx/txteLJXPgtzPL1UgsUy1x+Pc1Y1wxzw5LHpXcFIblkr85R5FPaXCb6hUtq+IJ0oZ99WGSsLmtyrVAcc0mbfLvo5yF2gt/WD7919ePcKtiwAPTFi+wvJ7tihz+GEX5A1I31Cj1r0MjYtN1IiBIZoWz5+eVatIIPGtJ3cwko7V5NHYlII5A5en4Zl9D6KR4E3MBlH0DO56rMzQHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc2b6bc-5843-46b4-1a69-08dedd2d77f7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:14:09.3417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6o8YgCGX//VaSN0spSEcXyWklct9Hf2fjzxLFEatWFm4hNWRC+DBgvRzL4zK2grIUQPaH39kLUfb/qio5bYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
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

On Wed, Jul 08, 2026 at 03:34:22PM +0800, Guangshuo Li wrote:
> xe_vm_madvise_ioctl() allocates madvise_range.vmas in get_vmas().
> After get_vmas() succeeds with at least one VMA, error paths must go
> through free_vmas so the array is released before the madvise details are
> destroyed.
> 
> The L2 flush validation path added for PAT madvise rejects some
> SVM/userptr ranges after get_vmas() has succeeded, but jumps directly to
> madv_fini. This skips kfree(madvise_range.vmas), leaking the VMA array on
> each failed ioctl.
> 
> Jump to free_vmas instead, matching the other validation failure paths
> after get_vmas() has succeeded.
> 
> Fixes: 4f39a194d41e ("drm/xe/xe3p_lpg: Restrict UAPI to enable L2 flush optimization")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

and pushed to drm-xe-next

> ---
>  drivers/gpu/drm/xe/xe_vm_madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
> index c4fb29004195..246fe1843142 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
> @@ -643,7 +643,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>  				 xe_device_is_l2_flush_optimized(xe) &&
>  				 (pat_index != 19 && coh_mode != XE_COH_2WAY))) {
>  			err = -EINVAL;
> -			goto madv_fini;
> +			goto free_vmas;
>  		}
>  	}
>  
> -- 
> 2.43.0
> 
