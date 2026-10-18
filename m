Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52201CCF2C7
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 00:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71ABC10E4C1;
	Sun, 18 Oct 2026 00:48:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1558010E00C;
 Sun, 18 Oct 2026 00:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792284476; x=1823820476;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DLMKKdqQ3+PYn59wMhxdtIqr7C+TlMV9VIM+g58sMPs=;
 b=Z1g5wtvtr83SwYhkRkIX5oqxxGFLaJ8Ftat2tLKxcGWNmF9RKdrQOP8g
 J6/eK5m0W8roxOZRPNlGjrh95eLkUtJGZ7sStR0alaBOOteOeAn9YeugC
 dFvkZ/O6K9XapBuMuwGpq3or4OAXaSZY9IifJgufIJOXjMpOlkBRj22Tx
 xdRUJ8i6T+PrmPXM8uc8AfaDu0/SdCCGExDZCs/4ToRSkGimAf7K2yQGP
 D7fUJ/8qKFFtp7SCdvMJ7/kcIIJsv67AYAkKFWERl3kd1Ya6T1Kfkl5cX
 sL4YezFBwMEB6dLaddYxM0xOEjv1wocqbnJN3ZPLWhhmqaFDX6Htvqhzn A==;
X-CSE-ConnectionGUID: fprIeQZdToaQL4Uxeh2pBw==
X-CSE-MsgGUID: +vliPSc9RoOG0R5T/+lP0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="908960"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="908960"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 17:47:56 -0700
X-CSE-ConnectionGUID: 5jEVI9G0Tv+BDUAaF9qgug==
X-CSE-MsgGUID: PeJmPVV6TaiOu6HSvD/uNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2289992"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 17:47:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 17:47:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 17:47:54 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 17:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGPY/Q1keeXIddmktHYjlGHsLxyXaVLED1vTeKABqKcZv79btA75ASOOhf4C2H9XkA+nF/Udblnuz+OUHTy/tfEESnp4aY2ODZ1/smnJ/tM3GLtHfbUe6Pn7v504wYuLd5N11F6z48urMgQEHPLacvnc3GrfBsmhDLpLyocj8cdR+nY5aKlypF/jb6unOmOrMfPnf1BS2b6CS6uc0e1WHiM7g7ZACrn7LuCnkH5s5o9EsGDJnVt1GrhGwfa+4UsbuwlXCFcd5sg/LMYy/NDHTXWeBOlkKzSNmuPtwqBzF/no6zwi28GVTisLLdHg6G6H+6yRBMWua4O5jzPIGJdlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYpdoBz2Xr9otcyjWuBng+kQ/qyWyrfdZEV5OAUmT38=;
 b=uK8CFpfwIFhxjVmpnbvpT+D+AiUhyykXIVzQ82s6ysz3B9SmftIRDnQGvPptBjpUs5Wc3uQ9nS3b0pVzFn1VSHy10X8xtKSy1Y0y3+y1MmgILGfucKW0fZedCJZSAhOMaQN8KFz87bytiDUZ7KmLnW8GLtpFdELH4z+1lgDcqBjyqnb6sM3JczOlBuaToHSP/ef/4Ll55KvVA5F3xuYwn1lk476CQA6FW33q3sqwNihku9GRswqFPJSzuCCouhrUQMIkjzWmiNnf/O6IVi/HywaolCocagFn0bNxYGS5urS5UkstibR7d7YCQ+WkADoQTmiuNiBHMdseExIupTd5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sun, 18 Oct
 2026 00:47:48 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 00:47:48 +0000
Date: Sat, 17 Oct 2026 17:47:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Antonino Maniscalco
 <antomani103@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: (subset) [PATCH v3 0/8] drm/gpuvm: two pass locking for exec
Message-ID: <atQXMJxbahzKbQLr@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261017212357.99295-1-dakr@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261017212357.99295-1-dakr@kernel.org>
X-ClientProxiedBy: PH7P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::11) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|MN0PR11MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 67da5677-0e89-43b9-769a-08df2cb16e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Amwn2cUBxvZAUi0moiah0VvZt7HdYvVY5O8iAr9t8l3ksdNNyrOvzI4ns9xk7PfeqL6xUdIyZpVUPfJiC+nIFOl59luDle0lhWs/bwBdKaAoqxG+aWAVFhIABeoDistL/j0n8FC4kWrAXwXt73+nVMRnshpVXr1Zgx5zL58GBntbo1WKnY8puu3a3W9fD4ibXyoe4Nmplm2OQiaA6MjGHXqVndW/aONm56BmV0/AB/SMCQkJMX4Ol7WK0hOuBSjVJQi3b7lQkfoOR1vmlUmpdd6I/g7SvsrG4nmu2wslRsGYzZFvMEjXQEhxrvMydcJ0sTMsNFZ0oIK9AZVsgSV6//AWxxm3GHkNdLFkVd4Ix8p87c/H4P3q2EJbHYFFLr7TkQAnZ9mM5oBb5yUCsh5XTzK3AMoRCL60cDMGgyWHQ4JlOepWCxXqp+NBF5MZrrJvVh77ieIsmPUTg5o7dGPtHDADwKhsUcSEcD6eRqq4pM6vBWtvVBCoYaQFYo0cLfvPIBt/AqXePSI7hAAJV9a3WZ3acBTfmjbLOu2UIxBMv8aZo4D29HHy0DVPO8s244MKO9NX6QeYpGzZKy/yKCDXuKIDcdki0LXKB6120YmFOfHjK84Cxr33hIJYPsAlC26/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?heI4nLp3fLWdrj9qVksrZp8MuHukRpMIb0m60Z+6dVv7YAt4XPVVEpt5szZq?=
 =?us-ascii?Q?hCAXPuVr/DPhCjz2NiVKio3PYhph4tKrL3XhjCem94CYFDSMnhoaKZjOV6mc?=
 =?us-ascii?Q?GzuEXAEu8kcFkamVzKnzKyvtYU9C/lOk/w0TKAO9QJU+8GhXiolpI/w63pVa?=
 =?us-ascii?Q?vbBmA6gMx0VwHg6739RjkupXiRRCbfgruEW9yGxE5nP7+gD1zqef8k74EPaR?=
 =?us-ascii?Q?vovxTjZvBMFjMusbcYefamqY9t9dDC5tTR3hhqB9qPdN2rv2VcUARhptsPgL?=
 =?us-ascii?Q?dX81K2xhQ5ED33C538wDKiMGfnafvWVfNFr7BHxVbolgoonhZ2DD4EsRaE8G?=
 =?us-ascii?Q?wtb27aHu7XzgzrrD5MJMqPjdM6p9UGS7sKat7a1oNEGDIbZGmzcAP6Wf14a3?=
 =?us-ascii?Q?96Zn8rZ4yN48wYL4vkhcyO+p+MIyBiS9HTez2KsnIGwDPvzuKu7DJuA1RMLr?=
 =?us-ascii?Q?TdALlEnm1l26rWQN4Ci79aEnK9IeN8DMT+ndD6E1lACY6yotHXS9FKgHaDji?=
 =?us-ascii?Q?eOz3BO3pMiXp7cVkik+TikG2yk5l6lZ8F6Lw/T3IJAX2+6z7Q6xiZ/Xcfihu?=
 =?us-ascii?Q?Q5xyTVy4oCWVTh6cJFg2mwl0MPuAIYL8G4yo7LaOzLTItPcK7zSWIHgq5lM/?=
 =?us-ascii?Q?rBHbQ7xMWESRlDLMmph+VBXswPxkmsl2qyo6mF+eVDHwH8gONFyeDscWAHFS?=
 =?us-ascii?Q?i9Ih21Pe2h59FjXNJi6OnpAe4MY4oetjPc6fVctkHwcpdhap31v4HVQMqwR1?=
 =?us-ascii?Q?z7Osb0pvEBBp/IDo/6CgzMyx5qgGE2XDvtqlmfks8Q9XyBDHmYVcnOUBgsAN?=
 =?us-ascii?Q?Nia28PWjCFgKkCv+yyrAGXnKgAQVLQQbx+eU8ZlJ/Xp+gd7EbZJiWr9HOCyq?=
 =?us-ascii?Q?SLA72WuQAvY9vSM55jQq3TraMxcasZ2VxMrSGR16xNaCt0i3js9Woqorse4W?=
 =?us-ascii?Q?W3Z6oS2X5YD1f2Q9cabtMTgsfVRHpsnIlOFdGSwpS/Sy1ha2QyBSfYN00sGW?=
 =?us-ascii?Q?7UJy4ZNvNJVsvjqosb5NCb9zTboLD3lb4q6Ugjziit200hXkOaoJwLoJ5P1O?=
 =?us-ascii?Q?2hdoS6duGAdNm1+CU5CWk+z1SftY9PiNOEdfgGDDMMiLIDYtOnX2ZpRJj31t?=
 =?us-ascii?Q?VVZeTz8z+TKjU9s10lY8VNDkW6SWm4YiwxleJRkM9/zHTfUPhLhRW6tO9Z4F?=
 =?us-ascii?Q?YXWGe1gA4NIxV2F8EKV38h3tKbXLC7UlAXvGBD82yq8cgnqwZX/h/XPuInBL?=
 =?us-ascii?Q?B6wPhQjmflm+3yOSVgHdJ0trDEfXoqN2HXLSjIdRbQceJZhjHrFeQuCRLohE?=
 =?us-ascii?Q?ZtXwUs8V8WvQHbRKFoxqdZ551vyGzbxcbFD7CJZF0xo7Mp4jSx3qIKOO99nV?=
 =?us-ascii?Q?1R06hqxAocYMj8h2FNFmP0imk6piSet7NaKMi7czhPKW5Ybi4dj8ZGk3bW9i?=
 =?us-ascii?Q?AWO5AXTxhjW/Qzg75FY3NZqJZDyqROYgiAuO6klmzSRm3ZVAuXbyBiczEtqt?=
 =?us-ascii?Q?0cZsL+KnhNtltdUMFj4dlWdO7y8A+YJIk1v+Ms+v6oU21G/0XA4Oe7t98T0J?=
 =?us-ascii?Q?M4scADMo6ohhRCiJrOnO14YLSLFC+8vf9KD47BwuhfNbo6ZKi4kqWHEosd4v?=
 =?us-ascii?Q?akInwPqWxzcw/6/RLkkllx+IfeyaXlMitTwiKVXyPM6jpCe0NtSeZowf26uy?=
 =?us-ascii?Q?O13XO5xe/8N8JPNGzF5CCdamSXAanmB7TaDWP9jVUIf0bMoZJ/Ntp6gF9cg0?=
 =?us-ascii?Q?0uvwOjy/yA=3D=3D?=
X-Exchange-RoutingPolicyChecked: jw5jU4EX3Fgw6hMQ+QZOK47dOV+HQ9H0eyLTq7HfFh5HbxuRA1n5wXJiPPPxZsmHbvd1ZCwBaZht1x9ybobqvvOHYzgUJD3PAA2Sd6VvDIyhSSTdukuxIOzSYCn2ENPeupVQ7gWs3Wniins9CZpZCXEYsuRd15ANIV0mT5gKL4JVWyQJVikbcYQlgMG+M+tqJ+9xLDQa3rk+59Oo5FEWTr/Yma+qqFy4FLJl3lRC9PDfl//i8VFwHUbfmKH6jo1P6LPAKBz1O6tM6twFAwl6NyHkXHmRhNMKJqZ27sLoVxIezCbzKShKlZ7WoCOB07/rNw5K36goK9+j+jbdQ1Luag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67da5677-0e89-43b9-769a-08df2cb16e21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 00:47:48.4765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0LWSrLZVSjjdngUMeRTYvU6JZFIGat1cZ4QtxwbCqKkQ3KxGIL5YEWOpJsya9eIb7Kce/puNno0QnspEP4kVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
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

On Sat, Oct 17, 2026 at 11:23:57PM +0200, Danilo Krummrich wrote:
> On Thu,  1 Oct 2026 15:06:24 -0700, Matthew Brost wrote:
> > [PATCH v3 0/8] drm/gpuvm: two pass locking for exec
> 
> Applied, thanks!

Awesome - thank you.

Matt

> 
>   Branch: drm-misc-next
>   Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git
> 
> [1/8] drm/gpuvm: allow locking external objects in two passes
>       commit: bdb1dfac34bd
> [2/8] drm/xe: lock the resident BOs of an exec last
>       commit: d420ec95e4b8
> [3/8] drm/panthor: lock the resident BOs of a submit last
>       commit: 13b7dc3f89ca
> [4/8] drm/msm: reject a submit_bo table on VM_BIND contexts
>       commit: 222f78f461cb
> [5/8] drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
>       commit: 872403c67851
> [6/8] drm/msm: lock the resident BOs of a VM_BIND submit last
>       commit: f3473658eda3
> 
> The patches will appear in the next linux-next integration (typically within 24
> hours on weekdays).
> 
> The patches are queued up for the upcoming merge window for the next major
> kernel release.
