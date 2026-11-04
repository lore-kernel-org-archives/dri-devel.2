Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2102606E81B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aa+rz5xx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D2A10FF66;
	Wed,  4 Nov 2026 22:21:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D54710FF5A;
 Wed,  4 Nov 2026 22:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793830858; x=1825366858;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3kcpN8MMn/Ar2TcQ7rRAo6fykuYZ986cWE5wyQ/c2eE=;
 b=aa+rz5xxwE1n8CheC7CLWjCjZ5Bx6+flGwPXb+voXjmyyUJ4dHgRudzj
 Mf7Z7nPRmC29kJCRj0KXPXV3mIviXC6NANyArCFu3rvs3MCwMxTMyS9rK
 RQgDfozXvKLhJ6cKeknJdl+W2UDYHb4U6JJHGTTFHVYPqKaLOcy+qpL4Y
 brfScKJBVnw1RCQkfg2cFQn9NcjhnG1cY5HTHEYKwrIAOSmn9o2YFk+fn
 2caISGZkb3x9RAC7WGaoHTxeXyxQj9bu4HBs8L2eJic+NdE9e+vPNO6bW
 Pf4zoTLKfC9tIkjWi+gk7bF0/8dm2Qi3NuMOIbQVTfC8IX3GfM8YgjmL2 w==;
X-CSE-ConnectionGUID: tlHiMlCzRh25LjYM8sLqUA==
X-CSE-MsgGUID: L0hxT3XZRMyxiXRecMMXwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2504621"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2504621"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 14:20:58 -0800
X-CSE-ConnectionGUID: s+ReKO0PQ0KhZpxl84Fr/w==
X-CSE-MsgGUID: fH6oUfUiR1qKTHP7ZLeMJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6837728"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 14:20:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:20:58 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 14:20:58 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:20:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWCTde10pOKMOzDYjFOQsh9t9AEmHek5oOvsDwjlRGXA9XZGMpBMzNjQARyJS+NqBxXhpShT8Gdu9VpFBUeucLG9IT3QCetHUN4ZNoiftXVy/GS/+ERkV2GvBx/JvHVMa0MJ/7IqVkW9DNlkC8F2EL03PZdbBUwoA+MXByZkVnVbXaeSfsPlaw892BGvrbGFzYkH0RoSFiJKtiBVYC0xXikc+KpkuEOLw03qIPKxkIG3U6DfiEvC5Ia2FOs2ffcClk13nx/o7kkl5aWcvoPPGfw4O2frrQ6XzWU7RswiGJRC77v1FOc1CmGSKSfvjU0RhXVxpZ62GeXJXln35gRijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USZOlqhtlkaiQei0QWuyiIicrU9VGu+FKS4/tmifWoc=;
 b=G4EqZWnd8RjO6OjKbmKAWmBT1zq+wSNhiYC20WxbOxqPK33j0tP747EVwd8zenVsw+C37NvuYEGbChw/7vV5C8UjxkA1RSzWJ6ykM9ejiGxdNPqvq0CaA1SxhVI8xEzMmFg41iroXWlhZu5zas3QISLTNkP0GnzhJlXlLow0ldo/BAP6s6Mm5b1u3a+pfiZHCtIk+x0otoXCOa49CCiuayJolu95LlA8VkRwz8X6ZgiXhkAEc08DhZnbHXPjFxYDvDeVZQNV/dJK73P2I8ZjScBswh4h/qZi1gosU0RJW76Ov9whWWowuGQ8oFrJh2iRJsEXjGvPnpN9I4zLO212fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB6749.namprd11.prod.outlook.com (2603:10b6:806:267::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 22:20:46 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 22:20:43 +0000
Date: Wed, 4 Nov 2026 14:20:41 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/xe: Add debugfs stats for DMA-mapped pages per
 order
Message-ID: <auuvuRgMmLoP4sWT@gsse-cloud1.jf.intel.com>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
 <20261104215228.1533692-2-matthew.brost@intel.com>
 <sashiko-outbox-198211@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-198211@kernel.org>
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffea263-8269-4ea6-3d6a-08df3ac1dddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|261009223027099003|261009221227099003|261021123027099003|261021121427099003|261022105027099003|261028144727099003|261022075727099003|261026140227099003|261026121527099003|11063799006|56012099006|10067099003|4143699003|261102123227099003;
X-Microsoft-Antispam-Message-Info: JiMlGg+1tE0pzLMgDjFTnSb5HBY4W+lu/K9AA0cMNBeN1svZVwnEErO/Kx7RozPBPXWfhUvZ6vCMLUoy5teW2XCqikPYnnxwqEEQasMaJGtsQHkODN9eun8B+dZ8nKAP2Ftxb2jr+HAvEsMS+ZnnLNA/voEvr75Izyh7GfXs/clffJ4utelWbLzTeO/UNlHRzMhA0i/fLAmpdTYe2fyr8XkY1NDFiXTDiQHg9VGBR5NdabxKbgTY7ZWlkymDBaMv6lxGTVls+SYiVV2lGPoEHhqaKjNWfl1RYYalAVZv8U8HnY3fQhCCpv07LvLhpC0doYXDD2Cpeh3Pqok6/zd01Z7Y5aHxeFB5b0XA3LYtgUQjHIMzCrHE+tmJNH8Nlh6lcvg4ViF5CMPxx9ssP+6F3zNlG4cvlylmwqjdfQXCUgb1UcmabsuCLcQkVNqNwekbxXUfvXpo2mdNJid+cRMoGXZdZa9j3teLuxAq7dVjxn9yHaAgcbo8vps0No9ZqOSlPGF1tqBK9Ou9MFEcJxCG6+lDzVsrQ1xamskrtSwOKFj+tpK34CJC4wIIhz/HtEJ/M55vd/7Sy49XNu451nZrggMKRWwmONgmEMe9ikaa1cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yAAE2E+Eo81LtBDi5KTrPcwuive6Y3rI6v36Mo6TfTh36CmE9CXjiLMi3A?=
 =?iso-8859-1?Q?K5F6sBTgpOosrHQZSZ+N7np91s2xFQAOiBTFlCMVqMQUNsbHJM/n8ACQUt?=
 =?iso-8859-1?Q?a+/Tx0vr0Kb17ImJQVyScrFEVQByeJJskeFyrCTlwVPlk6Y9jDfDecuS1c?=
 =?iso-8859-1?Q?+BaTa21YBlcWNG8n961RAWXBbgZuiZAHw78tZnJJIojPUvTrrCPLFDCyKo?=
 =?iso-8859-1?Q?CIsYKdhL3D3NH4lA+eW+xWyCrvdjlTxXBSKDXYhPrZaI9vrnxSBSORsWE7?=
 =?iso-8859-1?Q?qhZx9Dqsr8PGqIB9ARFpsG73CjqV8hMntuk5H65vH4Wzncudji4O6PnAGM?=
 =?iso-8859-1?Q?rs648S9/TS9FZpEvrBaEDMrycVhX2YliFxXfhCBTC8kBaOZ2rkAa6U6aK4?=
 =?iso-8859-1?Q?TpAvtrqFEoeOGYm9YVZvCK6VJEV5CmWK1303ouP8lGdEQw0/tdcViqf/vY?=
 =?iso-8859-1?Q?ME3dsdWmDaZJsuErGyxPJjAhFL4wxhwESF8rFdYmSfUGGqc9j08ZqPxaNO?=
 =?iso-8859-1?Q?ynV5JRe4nEiMA3yyxj/u7eDGZGx8ASYQrMZ9ixXjy9sb5DJwQY9YGeqyFd?=
 =?iso-8859-1?Q?XombbW0ZxvstFP4Y6IKff5+uJgNc7TdxJvdCdZX7oLmr0YYy4oX1PgTxrg?=
 =?iso-8859-1?Q?QHA60Z5Fy4KROvRkdJvoqyWDb1p/XpzDFZLKEohy1yoyU5NTNFigDpK4y0?=
 =?iso-8859-1?Q?qL6bZb8Q9/dbfmgaeu//2kIQC0WyyeNmSQGftVbvzM22CiABLYWdExmZ8L?=
 =?iso-8859-1?Q?Ya29zyeJhrC+gYHsMSQj01cAebRIuE1weLP2XTzTHz4RYluasxbawF6nfl?=
 =?iso-8859-1?Q?EhBEYJ80QCzm8nP8DhbJNF7lkT4GoPzOG8qfZFtb48bgKo8DGHY/bDJteB?=
 =?iso-8859-1?Q?o8SEG/hgzksKqImrgR7R0gSDw5a8bIe1wCOf7ovyVZjy5tO4hFCvWN1/x6?=
 =?iso-8859-1?Q?N0cBq/QUsgnmjzrFAJL/4EiAwR7fZZSAgAi/CxVsCe+2lpZ1EP8fAOo2dL?=
 =?iso-8859-1?Q?FRVZ+4VmeIF2GqMEytQeS7uegmL57ioMwMHI3JVV7oqY4ihIwgZlhwRf2F?=
 =?iso-8859-1?Q?6hUi+os2+u0LWxDf8wKYfviZM6MNX3oABBvydVIAHMdZjMMWeJT1kq7eUr?=
 =?iso-8859-1?Q?f/F3yQgDCaFE9ZvytcyCvkINcFOxvAyx1ZNUk+IFoHX78AXCJJr4SorKjN?=
 =?iso-8859-1?Q?xfEPcNgK7XRidRJtm7HlkISNp2fM8NHG1t3SWnpCIcjHZI5juF3ZVevOcS?=
 =?iso-8859-1?Q?kuaZr9K3wmzKAU0jg0vu5uWgtdYqp4eQGIFrvmliznocXIkLlXKR+PIanv?=
 =?iso-8859-1?Q?lW7J/VBFR1dR4rNXLdexuZKxTDW0fCP+t+0NUJ4I/Wn3pr2ModKSI15xQZ?=
 =?iso-8859-1?Q?rZ/FDKNtfsyZhFZbZxxm3kpmXvVJV9jYEPK5RkX9owK7KTQZ972ny2PPyk?=
 =?iso-8859-1?Q?85VdhNkyrNuM6Oo50lVIPMcbS6y6OnVw5JMdPhQaNavCGnUgEWY+EqOwP3?=
 =?iso-8859-1?Q?h/Y+RKtteYpZZI0GLiEyg8Vq54LVcXbruSrDPN2qguWhOgss7JwUVoMupX?=
 =?iso-8859-1?Q?QVe7N0sHcN0GsTx3ov/FuHAMmBLyFxQP2WaNNHuJTQiJnY3s6OjKe21thH?=
 =?iso-8859-1?Q?ZsIFgLa9v/U7cNEblYPbzm8nOSrBbkHdb9z/ArkLp0RE71pUzckYJmffpB?=
 =?iso-8859-1?Q?bk8e7RyOCegszmMuQqXGJEfvAszaPAufx+/cSGHAJYHDYDF/mbvbOnPifn?=
 =?iso-8859-1?Q?jzFZq3FfNynuDBS9iGRUCeLqSV8yVMh7t9TuH7tE0VQNFM08tYBUloGlKf?=
 =?iso-8859-1?Q?5bJatpblPQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: OMtGj2wCU9FgG0BoNf4OmnZASrOtiGYUKiVGA+CLJPH3YZ+LPrPc6VcZ8hoDhxsGEYWnMcHdHNCj1uejHoyllyyvyt2iJgaAVqLstFimBIdH3FZRgrcvzEvTPHAxaA+uTfjgb+6yd5JBoo/7So0uy8CXt/vzeBkcvhpemXz29Ba8F9PiVfuBVqW8vPlmRc7adEWMMZ2NKPtAJ2ywg2IsxxA1EJr2gO5hpUivt8tkEvgxfvtpUulScFYV7Cq9+J1R4EDuxKtx80BEIVwE1ud2ncG0eJ0Eh76Bww9z9sYDDyvcr46m7l3mTD6c4CEhv93PQEH/nY9k1HM1eqS1QuLC0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffea263-8269-4ea6-3d6a-08df3ac1dddb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:20:43.6364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPoqeTfwYyRAhOtWBBqZIOVePpj6BJMc7T/JLOzn4QR3C0AxHn8+/S6A1jrv5LOYIl9h594N76C4qDvsG7eH7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6749
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

On Wed, Nov 04, 2026 at 10:15:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] drm/xe: premature xe_device_assert_dma_pages_zero() before ttm_device_fini()
> - [Low] drm/xe: duplicate dma_map_account callbacks in xe_svm.c and xe_userptr.c
> --
> 
> commit d97316f4a4863b594d6196037dc27dd4e278bdd0
> Author: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> drm/xe: Add debugfs stats for DMA-mapped pages per order
> 
> This commit adds per-order DMA-mapped system page counters for TTM buffer
> objects and GPU SVM / userptr ranges, exposes them via debugfs at
> dma_mapped_pages, and asserts that all counters return to zero during device
> teardown.
> 
> > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> > index 273e2c45fea9b..c40bb8f7c697a 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -377,12 +377,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
> [ ... ]
> >  static void xe_device_destroy(struct drm_device *dev, void *dummy)
> >  {
> >  	struct xe_device *xe = to_xe_device(dev);
> >  
> >  	xe_bo_dev_fini(&xe->bo_device);
> >  
> > +	/*
> > +	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
> > +	 * has flushed the async BO-free worker: BOs pending async free still
> > +	 * hold their DMA mappings (and counts) until the worker runs, so
> > +	 * asserting before the flush could trip a false positive.
> > +	 */
> > +	xe_device_assert_dma_pages_zero(xe);
> > +
> >  	if (xe->preempt_fence_wq)
> >  		destroy_workqueue(xe->preempt_fence_wq);
> >  
> >  	if (xe->ordered_wq)
> >  		destroy_workqueue(xe->ordered_wq);
> >  
> >  	if (xe->unordered_wq)
> >  		destroy_workqueue(xe->unordered_wq);
> >  
> >  	if (xe->destroy_wq)
> >  		destroy_workqueue(xe->destroy_wq);
> >  
> >  	ttm_device_fini(&xe->ttm);
> 
> [Severity: Medium]
> Can xe_device_assert_dma_pages_zero() trigger a false-positive assertion here
> because it runs before ttm_device_fini(&xe->ttm)?
> 
> When BOs with a populated ttm_tt and DMA-mapped xe_tt->sg are released via
> ttm_bo_put() -> ttm_bo_release(), TTM defers cleanup to bdev->wq
> (xe->ttm.wq) whenever want_init_on_free() is active or reservation fences or
> locks are busy:
> 
> drivers/gpu/drm/ttm/ttm_bo.c:ttm_bo_release()
> 	if (!dma_resv_test_signaled(&bo->base._resv,
> 				    DMA_RESV_USAGE_BOOKKEEP) ||
> 	    (want_init_on_free() && (bo->ttm != NULL)) ||
> 	    bo->type == ttm_bo_type_sg ||
> 	    !dma_resv_trylock(bo->base.resv)) {
> 		...
> 		INIT_WORK(&bo->delayed_delete, ttm_bo_delayed_delete);
> 		...
> 		queue_work_node(bdev->pool.nid, bdev->wq, &bo->delayed_delete);
> 		return;
> 	}
> 
> In that case, the DMA unmap and counter decrement via:
> 
>   ttm_bo_delayed_delete()
>     -> ttm_bo_cleanup_memtype_use()
>       -> ttm_bo_tt_destroy()
>         -> ttm_tt_unpopulate()
>           -> xe_ttm_tt_unpopulate()
>             -> xe_tt_unmap_sg()
>               -> xe_tt_account_dma_pages(xe, xe_tt, -1)
> 
> will not complete until ttm_device_fini() drains bdev->wq. Should
> xe_device_assert_dma_pages_zero(xe) be called after ttm_device_fini(&xe->ttm)
> instead?
> 

Yes, I can fix this when merging.

Matt

> > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > index 909a602d091ea..7a49882897495 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -845,10 +845,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
> >  }
> >  #endif
> >  
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +/*
> > + * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> > + * @gpusvm: The GPU SVM the mapping belongs to
> > + * @addr: The address descriptor of the chunk being (un)mapped
> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> > + *
> > + * Maintain per-order counts of the system-memory pages that the full SVM
> > + * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped for GPU
> > + * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
> > + * exposed through debugfs, so the callback is only registered when
> > + * CONFIG_DEBUG_FS is enabled.
> > + */
> > +static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
> > +				   const struct drm_pagemap_addr *addr,
> > +				   int sign)
> > +{
> > +	struct xe_device *xe = gpusvm_to_vm(gpusvm)->xe;
> > +	unsigned int order = addr->order;
> > +
> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
> > +		return;
> > +
> > +	/*
> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> > +	 * so the per-order counters stay balanced.
> > +	 */
> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> > +
> > +	atomic_long_add((long)(1UL << addr->order) * sign,
> > +			&xe->mem.dma_mapped_pages_svm[order]);
> > +}
> > +#endif
> > +
> >  static const struct drm_gpusvm_ops gpusvm_ops = {
> >  	.range_alloc = xe_svm_range_alloc,
> >  	.range_free = xe_svm_range_free,
> >  	.invalidate = xe_svm_invalidate,
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	.dma_map_account = xe_svm_dma_map_account,
> > +#endif
> >  };
> [ ... ]
> > diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> > index 9c1dac0fce6f1..40f97bd4751dd 100644
> > --- a/drivers/gpu/drm/xe/xe_userptr.c
> > +++ b/drivers/gpu/drm/xe/xe_userptr.c
> > @@ -8,9 +8,72 @@
> >  
> >  #include <linux/mm.h>
> >  
> > +#include <drm/drm_pagemap.h>
> > +
> >  #include "xe_tlb_inval.h"
> >  #include "xe_trace_bo.h"
> >  
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +/*
> > + * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> > + * @gpusvm: The GPU SVM the mapping belongs to
> > + * @addr: The address descriptor of the chunk being (un)mapped
> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> > + *
> > + * Account, per page order, the system-memory pages DMA-mapped for GPU access
> > + * through the drm_gpusvm_pages instance shared by userptr (and, in fault mode,
> > + * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
> > + * exposed through debugfs, so the callback is only registered when
> > + * CONFIG_DEBUG_FS is enabled.
> > + */
> > +static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
> > +				       const struct drm_pagemap_addr *addr,
> > +				       int sign)
> > +{
> > +	struct xe_vm *vm = container_of(gpusvm, struct xe_vm, svm.gpusvm);
> > +	unsigned int order = addr->order;
> > +
> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
> > +		return;
> > +
> > +	/*
> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> > +	 * so the per-order counters stay balanced.
> > +	 */
> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> > +
> > +	atomic_long_add((long)(1UL << addr->order) * sign,
> > +			&vm->xe->mem.dma_mapped_pages_svm[order]);
> > +}
> 
> [Severity: Low]
> This isn't a bug, but the commit message and comment state that the
> dma_map_account callback is shared between the fault-mode SVM instance and the
> simple userptr instance, whereas xe_svm_dma_map_account() in
> drivers/gpu/drm/xe/xe_svm.c and xe_userptr_dma_map_account() in
> drivers/gpu/drm/xe/xe_userptr.c duplicate the same implementation.
> 
> Since CONFIG_DRM_XE_GPUSVM selects CONFIG_DRM_GPUSVM, could
> xe_userptr_dma_map_account() be exposed and reused in gpusvm_ops instead of
> defining two identical callbacks?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261104215228.1533692-1-matthew.brost@intel.com?part=2
