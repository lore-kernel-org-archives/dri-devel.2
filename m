Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mZfWRjr/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA97B11239F;
	Thu, 29 Oct 2026 15:16:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153221123A1;
 Thu, 29 Oct 2026 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793287012; x=1824823012;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UoAKwNosnQsHSQI6T7ojXQ9jOO2hrYjOB4SBBZ+mRgg=;
 b=mZfWRjr/rg3+RyChSyEQ5jpPhVa2EDVQ0I0c/KB1aE5qKO9lUCUtGzgV
 Y6NUkKDHaCo601hShytFh7lUNZMKjay3p16/RjNyR/k3yEX2C294vFozz
 8var39A9Hra1kuVE5Fu7BwaJ05lkUj5OUYmdiqIJ0CBU9moUeO/C+JaRv
 2iR41W2AatxsrDyWZlWPdhi/eMLjzcrCzwtnqfgr0TrpVsH886ot4XSp9
 oYgQMFLU5CQaRWGPxDOrV5ZiA1ZXoLbHNyKxsn6MZmoP+9kZ5zanaEyVi
 8ft+7ZyEhIp32fL2Hpe7zTLPLewbx2eOwrD/MIZM6QaDazbZ0RRQNkhEE Q==;
X-CSE-ConnectionGUID: 4fnHQ7pvQyaPg7axKYvcxw==
X-CSE-MsgGUID: gwbSOIBdQtOze8NvqVmzHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1917732"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1917732"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 08:16:51 -0700
X-CSE-ConnectionGUID: 8rz6IBGtT6yZeonDzX9D1w==
X-CSE-MsgGUID: rbgJK3oCQx27SlJfycuHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6943815"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 08:16:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 08:16:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 08:16:50 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 08:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xwdy9DRgKvg87rSOEBxNVfp3b9ib808FoNOH59HGwIv6HetKhwR7h4oN8jsc2ahTOL6JLMRa8zIkhTA1oaWcn64I0pFh4q2uwSHSBAVHtaGT5oEbW+XXHfDNWiHs3Pdp6i01P0ZhryOuaob39SdyS0djdc2m8+VD1Y2WPnDX48NClKGQ2+6DfiAoPsGTNgtSXKZlCu6mrzi38E8jQLu0ae7nlat5hg3s+NGqh9v6GKIGdwlsN/ivFq0ZabAm6VJd2GheoPI/YKX55Hzhs9+aHvXu+5dDndYOt20CKiFzRTrkwVp99tyQbk0NyKu7Ef1t2vIly3IYwzzwLAuxkLQ4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv2UF/a8Vhi4x3xmGCL+sCpOyP/7++Qiy/Qfy4XmecQ=;
 b=MFP/UQkAYqTMfqDlRDhohyKJgviScEGf+QdglGr/6rAv6zbpMdcnG2Q2xT/Iksn05eGipAAYquJKxB4X04BY7ty/4KyulpOyIjrQNSzg+MJSTBHysIuZUkqQzOo1nI1e3q58tuiLC+mZVJgmz7rVoUrzcOCp75ei7EdrpQHUHu03YXK9JD+HAKrA+R+ylaSkrbL7/recdvjppo1htLJVWHkUioEvDEisNvvPpLMSOF3QosOLrnBAAJyayyYgIvYR1VoneAP6rZPWAia4mVmf6w7iNuiciiJm8nJzFXO60JXU/xaBxnXe24mvBOMgsDgOEu9H7ubg+xe5XwZzMhGJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:16:47 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 15:16:46 +0000
Date: Thu, 29 Oct 2026 08:16:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Daniel Colascione <dancol@dancol.org>
CC: <intel-xe@lists.freedesktop.org>, Thomas Hellstrom
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH] drm/xe/ggtt: Cut GGTT initialization from 900 ms to
 37 ms
Message-ID: <auNjXNXpokRw+buB@gsse-cloud1.jf.intel.com>
References: <87v76m1l9k.fsf@dancol.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v76m1l9k.fsf@dancol.org>
X-ClientProxiedBy: MW4PR04CA0384.namprd04.prod.outlook.com
 (2603:10b6:303:81::29) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH0PR11MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b988ebb-3ece-4cc1-8982-08df35cfa5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|261028144727099003|56012099006|261021123027099003|10067099003|261026121527099003|261021121427099003|261026140227099003|11063799006|261022075727099003|261009223027099003|261022105027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: +eiaH2rGOwgueyPGwH0K3Tadb12bYbfL5Rca/WLCr9Fd575sDvzf6BqneFVqn/oMMgdP/lLWSIFXvZCui+95CF8R+fMHfNhhaQNBMLTG7+gFmCKHA5gYsi2NrfxBVv+pF57jr9xdFEyheZwG7Xn0C394SD8pW58rWNFGhf3/FrSNmELPX0SUH/ME9+BRjy+cmF3+RnfsDDt0n6Goytho9tUhdnPRKMhur8qy0XiqNiqGIQzu6NuLBZjvldx7+aChnEvIAkkHevJ6LMR+JarIqvmUWfNBkyL7WOnxboZxgB7zQvXClnfWp7t+vSAKAe1XOV18bAXGyqjXMaaf3a2DeraBgv9YsCBcw/u6rMV9RG1ApoBsKqMb8mXh5dM4NGnsjYT1phJf7Ua8YaHPbG8bf402z1e82Ho4CHP8zUU0qjEKk9wOwBFSDfC6BisS+ID4XKbJ16njC1GRg4hIy0gnudmb4Q/OGJ0s7Gs7T+79fDfazu+cJgzx/hYwwMCmiqtw+qw34fVj3EB8sK1RZxycwsHHKFUB1mwR9M4G/C10H5tdSGK4cpjhPveq9HfGRKjaqYae2VuUED4uTMC5Z8nNvdl+mhvDYlgJqog0PFfojPQCiK9IAUubUX3cSca0du0Eq5z4W6I3DRxf0afPiEJ5RvP/vQWQV7QsnAN/BzGXm+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(261028144727099003)(56012099006)(261021123027099003)(10067099003)(261026121527099003)(261021121427099003)(261026140227099003)(11063799006)(261022075727099003)(261009223027099003)(261022105027099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drLT4NRQi5WjQUla2Ng6U+9gbDUCM4v9T9+ocNF+Co4VguTIn0+iqjCszzah?=
 =?us-ascii?Q?vEctOy/HpZgk5Ydn4/Li0s4Gn3Hqv522ZbYmZqOVOndFAISsrtBOqHo8EznL?=
 =?us-ascii?Q?2XWDq3+PasrbVTtdTJX95WKfYjfBqNt5Tih9Yn2KXfapKOO+S5VsJd86KHko?=
 =?us-ascii?Q?ZrJA4TnS8fH5a6SUeM0Pk0Yi6q1traXHazbXjt22+ijsl9RpMfxdh9qLO5XB?=
 =?us-ascii?Q?BZ+D8hyjDBwC7hMNXXGkXpcV44wAcaAkKhynMF4Zn/Mn3KH01iRh7jqp/TKZ?=
 =?us-ascii?Q?9swIGcbTbezMIS5xXG5qqJTLZ0bY0hqnCVv6ml5v/peviZIImyktiRd9JfUy?=
 =?us-ascii?Q?Iwm4CsPfQcRhZbCj7rs/bwoTG8Y9Kn0lzn2rQ7M2LcnR/1ZVgW2QYz5AfaHD?=
 =?us-ascii?Q?jPKRev9SNlQo+qU0hzROhcRSEuKYNYKo4oQ+X03UzHVExntL6suFcAnHhryA?=
 =?us-ascii?Q?NbTQ6iN5QuDPXvQDk/js+k2/2hB+aqlB6TXyIj6Tijcn77GKQuJkdHZzhMdE?=
 =?us-ascii?Q?/Fz/zhQqUkBaImDk7jtwSHPZ+npSBfMW/JzmEFw8l7kGpLUtH1UFt0UBYbhb?=
 =?us-ascii?Q?/dmUw2FFM3eR3Hsv08eTlS5d5Mdxqmt5HNlxlF/0oFiX3HMpU98UkdP6JTN7?=
 =?us-ascii?Q?ma+8DvQm+n/TvZxGHPvgOggEfowNZCEsqQMlOYOK4wYPfeVlVMnT6nGrZDeT?=
 =?us-ascii?Q?5w/thpBkj/QHQhGA/QACgjW/OvCESbFKzzrNLxclAZ4DWWz1Jsq9XTA7Lo0H?=
 =?us-ascii?Q?NNLhVBj+JWPRr2/OpYME4g0eRiZQuJ53IfkDkdF4CxwQHi9ZpCs8Fmz5MT0G?=
 =?us-ascii?Q?jb22IeveD1r1lnKRkbKybNdEjVKeVxch5Gb8LqsSxHTrnhqzMi+r8XNfPj4f?=
 =?us-ascii?Q?VAwWikC8qibaggJvBOkLS6tyjF0ETO9SOB3zAWSfkOGUbXuDmNog8OUtsjMV?=
 =?us-ascii?Q?q+rEoIdce+f6wOCh4yNdQv87t+OyiT4UlyTQQfAjuQHCD9pK5J8SyplFzlDg?=
 =?us-ascii?Q?2s2sjbNrUArQkBA32x6BXhpTaHl5G1b2XKNxb1AxqklDEOErlQL9jtPEnri8?=
 =?us-ascii?Q?X40nHDAFNJOD53JLff7JP7uCqQcF4Lj/3qrgVG4goO561teVBF/5GTdH68G+?=
 =?us-ascii?Q?sqw9sPPq3vGMjfFcy3UJtNGmmZ+I4taxGrJVKfvo8Tzqx1CigZOULiU9S8Mb?=
 =?us-ascii?Q?Vmby/YYFgmQwTxLbtlwjlCTFRtZjwUl8DlynWZ8UlygH/XqylrxvFbxvuBfh?=
 =?us-ascii?Q?ibLcL1XY1AQi3pyG7NV1qy0QIITH9xh+c4ncuh5l5ljevsp3nVle24mVLzeA?=
 =?us-ascii?Q?p2ozCdlPuQ4TFmm84LeQbybbebWwfUcvBNWvffNMqXbIErM/VVcb6Ts4OtzD?=
 =?us-ascii?Q?vzU33qQuyczizmO086uMN8jUBazEVWn3bYSl5DhgW4isNf0A1ShwnUrbA8rh?=
 =?us-ascii?Q?/JHhO+fXNh2H7a2SBcUbCnNI7M6pBiCLvFjUT/JQ4AKXOXeZUBUoTprEcMOw?=
 =?us-ascii?Q?FeB2FgZMTG+XJET6BVRQrpMQcFYcdYh7qdAwqb3jh7G9IZQrx1oUnZI/hUmk?=
 =?us-ascii?Q?KyaxXNp+6ugwywetQvuox1b/yng064jxLi4GpwjOdycAN23vGtYs1HlaKvCT?=
 =?us-ascii?Q?xu0cHaSVNG/0rCBYASbpfwpC8BroZEaHpi3LbfVWgZMr85tVZq7TzxZ+FEQV?=
 =?us-ascii?Q?7kEYyeoJfsqavFLJhBdXF9htMSznGBXQYbhsexhMtZXlB/MBIaFhEP1O71pY?=
 =?us-ascii?Q?qJJ5Ys1Yrg=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZQWciLpKK+Fu/hxA9Rv4xoVmVu/TxSJ/eIs8n9592YVM1qoqVIUb4YDDaQUOOqnRz/v+t449xXRZmO7Oa3RnYDjPIONu4czvnB9ULQnPH9n9rqoC4s72+6bJ9OKi/DJkstvbnrEgINcQTWQq7ePbjmwYA+lhAEbNjnqZl3ac42DQ0UQM7KV/bvEMqT7MLiYfvsnn+Tgxhsr6QrfbD6ZT/ZCOSfPg50uuXJCrap2kvcrLgaQc1iuvgfXEJBLcMpE/moxBpRZYZUec6jg0xOvU8SEFKkth4xi8XqC8XU0b5PCLH738YQLYDYWZAtPoNDGtnsQsVqZzof9PfjppnIXHfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b988ebb-3ece-4cc1-8982-08df35cfa5a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:16:46.5288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQbRek2LPmjmQi1jqL28Khikqc+qV+nsbW02tVOUK5Tw5rrF7VzRJat6Q0H+PivOTDR8kjQKtINKsSi4LQDd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
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

On Tue, Oct 27, 2026 at 09:50:31PM -0700, Daniel Colascione wrote:

Thanks for this - I have wondered why when I probe Xe it takes a
noticable amount of time - I suspect this is why. 

> We initialize the GGTT GPU page tables on startup. On my LNL, doing
> this one PTE at a time through the BAR takes about 900 ms and involves
> a million small writes.
> 
> Use the GPU's copy engine to fill the PTEs in batches. We build
> MI_UPDATE_GTT commands in normal memory, then send them to the GPU for
> execution. This way, we avoid the per-PTE MMIO write and do the PTE fill
> in 36.77 ms, ~24x faster.
> 
> The new path is enabled by default. xe.ggtt_init_gpu=0 uses the old
> CPU-driven path.
> 
> LNL-only because I can test only LNL. Might it work elsewhere?
> 

It should work anywhere.

> Signed-off-by: Daniel Colascione <dancol@dancol.org>
> ---
>  drivers/gpu/drm/xe/instructions/xe_mi_commands.h |   2 +
>  drivers/gpu/drm/xe/xe_ggtt.c                     | 128 +++++++++++++++++++++--
>  drivers/gpu/drm/xe/xe_ggtt.h                     |   1 +
>  drivers/gpu/drm/xe/xe_gt.c                       |   3 +-
>  drivers/gpu/drm/xe/xe_module.c                   |   5 +
>  drivers/gpu/drm/xe/xe_module.h                   |   1 +
>  6 files changed, 130 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
> index 835ef75bbeb1..04bd4225adef 100644
> --- a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
> +++ b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
> @@ -62,6 +62,8 @@
>  #define   MI_LRI_FORCE_POSTED		REG_BIT(12)
>  #define   MI_LRI_LEN(x)			(((x) & 0xff) + 1)
>  
> +#define MI_UPDATE_GTT			__MI_INSTR(0x23)
> +
>  #define MI_STORE_REGISTER_MEM		(__MI_INSTR(0x24) | XE_INSTR_NUM_DW(4))
>  #define   MI_SRM_USE_GGTT		REG_BIT(22)
>  #define   MI_SRM_ADD_CS_OFFSET		REG_BIT(19)
> diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> index 773777afc68a..3737d085ae68 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.c
> +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> @@ -15,20 +15,25 @@
>  #include <drm/intel/i915_drm.h>
>  #include <generated/xe_wa_oob.h>
>  
> +#include "instructions/xe_mi_commands.h"
>  #include "regs/xe_gt_regs.h"
>  #include "regs/xe_gtt_defs.h"
>  #include "regs/xe_regs.h"
>  #include "xe_assert.h"
> +#include "xe_bb.h"
>  #include "xe_bo.h"
> +#include "xe_exec_queue.h"
>  #include "xe_gt.h"
>  #include "xe_gt_printk.h"
>  #include "xe_gt_types.h"
>  #include "xe_log.h"
>  #include "xe_map.h"
>  #include "xe_mmio.h"
> +#include "xe_module.h"
>  #include "xe_pat.h"
>  #include "xe_pm.h"
>  #include "xe_res_cursor.h"
> +#include "xe_sched_job.h"
>  #include "xe_sriov.h"
>  #include "xe_tile_printk.h"
>  #include "xe_tile_sriov_vf.h"
> @@ -384,9 +389,9 @@ static void dev_fini_ggtt(void *arg)
>   * @ggtt: the &xe_ggtt to be initialized
>   *
>   * It allows to create new mappings usable by the GuC.
> - * Mappings are not usable by the HW engines, as it doesn't have scratch nor
> - * initial clear done to it yet. That will happen in the regular, non-early
> - * GGTT initialization.
> + * HW engines may only access explicitly mapped bootstrap buffers until the
> + * remaining holes have been cleared. Normally xe_ggtt_init() does this;
> + * the GPU clear finishes this work in xe_ggtt_init_late().
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> @@ -456,18 +461,119 @@ ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
>  static void xe_ggtt_invalidate(struct xe_ggtt *ggtt);
>  static void xe_ggtt_invalidate_engine(struct xe_ggtt *ggtt);
>  
> -static void xe_ggtt_initial_clear(struct xe_ggtt *ggtt)
> +static bool ggtt_use_gpu(struct xe_device *xe)
>  {
> +	return xe_modparam.ggtt_init_gpu && xe->info.platform == XE_LUNARLAKE;

Per below (last reply) - let's just turn this everywhere in platform
config.

> +}
> +
> +/*
> + * MI_UPDATE_GTT takes at most 511 inline PTEs (ACM PRM, Vol. 2a,
> + * pp. 1096-1097). Limit batches to 512K to fit the kernel batch pool.
> + */
> +#define GGTT_INIT_PTES_PER_PACKET	511
> +#define GGTT_INIT_BATCH_DWORDS	(128 * (2 + 2 * GGTT_INIT_PTES_PER_PACKET))
> +
> +static int ggtt_clear_gpu(struct xe_exec_queue *q, struct xe_bb *bb,
> +			  u64 pte, u64 start, u64 end)

s/ggtt_clear_gpu/xe_ggtt_clear_gpu

> +{
> +	while (start < end) {
> +		struct xe_sched_job *job;
> +		int err;
> +
> +		bb->len = 0;
> +		while (start < end && bb->len < GGTT_INIT_BATCH_DWORDS) {
> +			u32 count = min_t(u64, (end - start) >> XE_PTE_SHIFT,
> +					  GGTT_INIT_PTES_PER_PACKET);
> +
> +			bb->cs[bb->len++] = MI_UPDATE_GTT | (2 * count);
> +			bb->cs[bb->len++] = start;
> +			memset64((u64 *)&bb->cs[bb->len], pte, count);
> +			bb->len += 2 * count;
> +			start += (u64)count << XE_PTE_SHIFT;
> +		}
> +
> +		job = xe_bb_create_job(q, bb);
> +		if (IS_ERR(job))
> +			return PTR_ERR(job);
> +
> +		xe_sched_job_arm(job);
> +		xe_sched_job_get(job);
> +		xe_sched_job_push(job);
> +
> +		dma_fence_wait(&job->drm.s_fence->finished, false);

You can pipeline this function.

i.e., generate fences in a loop and only wait on the last one.

This is fairly common pattern, xe_svm_copy is an example of function
with loop which issues a bunch of jobs and only waits on the very last
fence.

> +		err = dma_fence_get_status(&job->drm.s_fence->finished);
> +		xe_sched_job_put(job);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xe_ggtt_initial_clear(struct xe_ggtt *ggtt, struct xe_hw_engine *hwe)
> +{
> +	struct xe_device *xe = tile_to_xe(ggtt->tile);
> +	struct xe_exec_queue *q = NULL;
> +	struct xe_bb *bb = NULL;
>  	struct drm_mm_node *hole;
> -	u64 start, end;
> +	u16 pat_index = xe_cache_pat_idx(xe, XE_CACHE_WB);
> +	u64 start, end, pte = 0;
> +	int err = 0;
> +
> +	if (hwe) {
> +		q = xe_exec_queue_create(xe, NULL, BIT(hwe->logical_instance), 1,
> +					 hwe, EXEC_QUEUE_FLAG_KERNEL, 0);

Can we use migration queue (xe_migrate.c)? We'd probably need a bit of
layering rework to allow another layer like GGTT to safely use this
queue but that seems better to keep a single isolated kernel queue.

> +		if (IS_ERR(q))
> +			return PTR_ERR(q);
> +
> +		bb = xe_bb_new(hwe->gt, GGTT_INIT_BATCH_DWORDS, false);
> +		if (IS_ERR(bb)) {
> +			err = PTR_ERR(bb);
> +			goto put_queue;
> +		}
> +	}
>  
> -	/* Display may have allocated inside ggtt, so be careful with clearing here */
> +	if (ggtt->scratch)
> +		pte = xe_bo_addr(ggtt->scratch, 0, XE_PAGE_SIZE) |
> +		      ggtt->pt_ops->pte_encode_flags(ggtt->scratch, pat_index);
> +
> +	/* Preserve boot mappings and exclude allocator changes until completion. */
>  	mutex_lock(&ggtt->lock);

CI and Sashiko correctly complain that 'ggtt->lock' is tainted with
reclaim and ggtt_clear_gpu will be a malloc for the GPU job.

I'm actually questioning if this taint is actually valid. afiak we never
shrink or evict anything GGTT mapped (i.e., that memory is always
pinned). So I think we can just drop the taint - I'd do this in a
standalone patch. 

> -	drm_mm_for_each_hole(hole, &ggtt->mm, start, end)
> -		xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
> +	drm_mm_for_each_hole(hole, &ggtt->mm, start, end) {
> +		if (q)
> +			err = ggtt_clear_gpu(q, bb, pte, ggtt->start + start, ggtt->start + end);
> +		else
> +			xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
> +		if (err)
> +			goto unlock;
> +	}
>  
>  	xe_ggtt_invalidate(ggtt);
> +unlock:
>  	mutex_unlock(&ggtt->lock);
> +	xe_bb_free(bb, NULL);
> +put_queue:
> +	if (q)
> +		xe_exec_queue_put(q);
> +	return err;
> +}
> +
> +/**
> + * xe_ggtt_init_late - Finish deferred GGTT initialization after GuC startup
> + * @ggtt: GGTT to initialize
> + *
> + * All default contexts must be recorded before waiting for a GPU clear with
> + * the GGTT mutex held, so reset recovery need not allocate context mappings.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int xe_ggtt_init_late(struct xe_ggtt *ggtt)
> +{
> +	if (!ggtt_use_gpu(tile_to_xe(ggtt->tile)))
> +		return 0;
> +
> +	return xe_ggtt_initial_clear(ggtt, xe_gt_hw_engine(ggtt->tile->primary_gt,
> +							XE_ENGINE_CLASS_COPY, 0, false));
>  }
>  
>  static void ggtt_node_fini(struct xe_ggtt_node *node)
> @@ -536,6 +642,9 @@ void xe_ggtt_node_remove(struct xe_ggtt_node *node, bool invalidate)
>   * xe_ggtt_init - Regular non-early GGTT initialization
>   * @ggtt: the &xe_ggtt to be initialized
>   *
> + * Allocate the scratch page if needed and clear unused entries, or defer
> + * the clear to xe_ggtt_init_late() when GPU initialization is enabled.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int xe_ggtt_init(struct xe_ggtt *ggtt)
> @@ -572,7 +681,8 @@ int xe_ggtt_init(struct xe_ggtt *ggtt)
>  			      xe_bo_size(ggtt->scratch));
>  	}
>  
> -	xe_ggtt_initial_clear(ggtt);
> +	if (!ggtt_use_gpu(xe))
> +		xe_ggtt_initial_clear(ggtt, NULL);
>  
>  	return devm_add_action_or_reset(xe->drm.dev, ggtt_fini, ggtt);
>  err:
> diff --git a/drivers/gpu/drm/xe/xe_ggtt.h b/drivers/gpu/drm/xe/xe_ggtt.h
> index c864cc975a69..cae8600d7142 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.h
> +++ b/drivers/gpu/drm/xe/xe_ggtt.h
> @@ -17,6 +17,7 @@ struct xe_ggtt *xe_ggtt_alloc(struct xe_tile *tile);
>  int xe_ggtt_init_early(struct xe_ggtt *ggtt);
>  int xe_ggtt_init_kunit(struct xe_ggtt *ggtt, u32 reserved, u32 size);
>  int xe_ggtt_init(struct xe_ggtt *ggtt);
> +int xe_ggtt_init_late(struct xe_ggtt *ggtt);
>  
>  void xe_ggtt_shift_nodes(struct xe_ggtt *ggtt, u64 new_base);
>  u64 xe_ggtt_start(struct xe_ggtt *ggtt);
> diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> index 45fb074812a2..d1c14a02de66 100644
> --- a/drivers/gpu/drm/xe/xe_gt.c
> +++ b/drivers/gpu/drm/xe/xe_gt.c
> @@ -686,7 +686,8 @@ static int gt_init_with_all_forcewake(struct xe_gt *gt)
>  	if (err)
>  		return err;
>  
> -	return 0;
> +	return xe_gt_is_main_type(gt) ?
> +		xe_ggtt_init_late(gt_to_tile(gt)->mem.ggtt) : 0;
>  }
>  
>  static void xe_gt_fini(void *arg)
> diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> index 897724cb5cfb..44cc0107cf53 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -22,6 +22,7 @@
>  #include "xe_sched_job.h"
>  
>  struct xe_modparam xe_modparam = {
> +	.ggtt_init_gpu =		true,

I'd make this platform param in xe_pci.c and turn it on for every
platform which supports the required GPU instructions (likely every Xe
supported platform). We can let this soak in for a couple months in our
CI before getting into a kernel release to ensure everything is
functional and then perhaps rip out the non-GPU clear code.

Matt

>  	.probe_display =	XE_DEFAULT_PROBE_DISPLAY,
>  	.guc_log_level =	XE_DEFAULT_GUC_LOG_LEVEL,
>  	.force_probe =		XE_DEFAULT_FORCE_PROBE,
> @@ -34,6 +35,10 @@ struct xe_modparam xe_modparam = {
>  	/* the rest are 0 by default */
>  };
>  
> +module_param_named(ggtt_init_gpu, xe_modparam.ggtt_init_gpu, bool, 0444);
> +MODULE_PARM_DESC(ggtt_init_gpu,
> +		 "GPU GGTT initialization on Lunar Lake (default: true)");
> +
>  module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
>  MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size in MiB, must be power of 2 "
>  		 "[default=" __stringify(XE_DEFAULT_SVM_NOTIFIER_SIZE) "]");
> diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
> index 6272d9e41207..8aa91822c35c 100644
> --- a/drivers/gpu/drm/xe/xe_module.h
> +++ b/drivers/gpu/drm/xe/xe_module.h
> @@ -12,6 +12,7 @@ struct work_struct;
>  
>  /* Module modprobe variables */
>  struct xe_modparam {
> +	bool ggtt_init_gpu;
>  	bool probe_display;
>  	int force_vram_bar_size;
>  	int guc_log_level;
