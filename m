Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18794606A69D
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RNOvDu4R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=diHpWsS+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D1510E1C0;
	Sat, 21 Nov 2026 05:03:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D2C10E0DD;
 Sat, 21 Nov 2026 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795237423; x=1826773423;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nHn25WWB4qKlQ3h50kVswvREyLbuzQGukim+ClU7kpU=;
 b=RNOvDu4RiaxvzCL+reAq3NSA/xfDt3fkxFkO44V7pNniZuuRQK0vu8dL
 msU3ROMuZG2HTP5gWYlV7NDTqSriQJyoUQtTUbHp4Wr6z1s+OOZuBfB/C
 hgAUvh6kqQ9b7g4FfsPOxYPvCpTZIUtPIDa2slx68mks/J3ALqH2QUgOV
 WFSbbRjDrdKiay6I2hI8KrphPECY9V2ade5VyLX2U0Zb3araDG4sn43tv
 JzE5JKA9HCCLHfUjBsaPwm3+dfl/pkbG7tRGNWrrsYG9ejxcLdN+TVWvZ
 HazWBmnCFYcn66JZ8DI3LTVs5w+GjEeM0dBjmm7jv5/P0FR7MSOoVgjeh Q==;
X-CSE-ConnectionGUID: hV1MeST7QeSfWHIDIzxFIw==
X-CSE-MsgGUID: Jq6x/yeXQtKvp/toj/loxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4161497"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4161497"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 21:03:41 -0800
X-CSE-ConnectionGUID: klLLZBBoQvWC1ne9h4YBVg==
X-CSE-MsgGUID: igfofPugSl6wtDBtMn8v0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10981161"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 21:03:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 21:03:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 21:03:36 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 21:03:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRtCOVzy1eOg8KAURAQk8TeObyfgTYBTm5vT86/EIsKyJp6EMmUjX0WpCRmx3Ot4RR+0ELwb1SfmB8Y3Hz1QiXcB2Vwdy6LCXwnKO3o/dhOWT/6UkByQqLRMxHkl19IOr6+OmUjUd3MyZ1ffTZJGTI8HvfgTNWo7OIhIO/vvgRBBFAoZ2zdFfJX0gH3mkcqPHgMVMH0LCVtRA3JOCfrfcIGyLGm7IyFkOeF0DOrX6kNnaIzCAKGNZVIv6/yFwkNS4NJzpQzABek742UlCSWM/w0DFQx9T0B7uCaxhHLEno0m7WaqAcFtHPR3wwgl9OK++BfV6AKlkYOej9TOF/VS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwvIwsPZBUc0mWb8M/Rd/BPtnY5EDOVUJ31iBxOmLsE=;
 b=jPxdyP4Ms/OBYzJaqpjgaZ+cQrkdhrtZ/qltsHkrsBbyCluY9IcZp9QRyjyoxh8Y/IOW5lQM5uP1C7kh4HYDMHT3l9vvvtgGAD85wmp6QhXrgJTYSnldW0m1VnOtSgoWSVEPzvDD/tPl5T7LjiC4doHMG3zQXK9vzNAEOj6SUIevyolneQj0OOnSTZ499TXWEcxu6J7eSsK4RYKlVK1EzE26/zKrS+LnLsOciRNCVoDGToEzLNbF0mRtOU1Wk/Bb8HaQddPURKpGhDCFZj8zMlrF6xr3YxgmnEdVm+alDBB4yks3X7M27r63GYYbUbug0rib2YCCx9CIz7WyDsxr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwvIwsPZBUc0mWb8M/Rd/BPtnY5EDOVUJ31iBxOmLsE=;
 b=diHpWsS+IwWILbGy0eSYkNbPNDZc7FCjxeiSnFBO92Fki90kafexzkgv5JgREOqRvnC/5gtF6fs9lsLeY7Tstgn1aIC5AcQRZx4taGyTnqxLSAZnsZOPDuwKaqCwtu04Pm42duOZi2GGGTIXpL/Jrt4sXP5jFj5WGXkD7xDiuCU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by IA6PR11MB797045.namprd11.prod.outlook.com (2603:10b6:208:5eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 05:03:25 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 05:03:24 +0000
Date: Fri, 20 Nov 2026 21:03:22 -0800
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
Subject: Re: [PATCH v3 10/33] drm/ttm: Add full out-of-lock preallocation for
 ttm_pool_alloc()
Message-ID: <awEmGqzlcitPQtIv@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-11-matthew.brost@intel.com>
 <avQZ6cCNt2H8vBtG@nvishwa1-desk>
 <av/fJ28fT1/3FtD1@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av/fJ28fT1/3FtD1@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BYAPR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:a03:54::32) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|IA6PR11MB797045:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bff2f4-3b16-469f-4fea-08df478cc59f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|18002099003|22082099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|4143699003|56012099006|10067099003|261102123227099003|261102130727099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: GEDrxz6EkcHq9cd0FwdfMwqUQWX0rUEYmQcP2egyH7Hcj/3hfpopR/PGabf1pnV2MJYXtRHMP5ra5bTlHIh9UumdG3uq/pvdZvSWrDhhaoCr6uk9ryYQhmhllOdOHmA0IVeVznNQPxdyD8PGlW0B+5UKiwLwEyKzK/A6eZ0VPOF7j6Xq8+Oa6L80nSXS5sF4ownbPi+T6EEATUo4uTL019/1f3xuzU6VyW1riUWn203qUd4i26D8SPRwjmRc6+p2cAhnUc333GaOL4+KoNR2rLltaB/ona1EqmA+QkCysJNYkWfcDRMuGO7rFdU8qf0R1xzh+S/9laR87BwZuIgK08LazlA1aSMlbWknR93r7PQgwlw5fxVefTicgG9He1s6cO1sb06CPw+LWL2TFFoMJrz8qLXsrvJjm8AwXF19mOt467VMUszZqzT+vpvvYhPI6EPV0sL+E0skz7+fO4ZPloXeUqAKcSJ289WtDzaGZpP52LDe4978pEu2cF2XuTwGW+KV0EB3H3j64gnuKZxEinlx9SFFeF3PrgpsGsVmKSWTmM3MJqrEn6Fe6SZERrTmR8zId5X/K/f7oVcIuWrRnt8NiZ0AV7Ww5L5SnMsF5ypB6RrwjNLVSSJC6ySrNQ3AG1fi/lkeew9lMYoQcG/6yHIL6FY5adPDr+KPt0yajyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4dGvZoa9OlDMmSYnp/zQvbsLGeT1IpPiukp08jih8dXd9zm7kl4dWVG/sF?=
 =?iso-8859-1?Q?JY22q0dvFjxnM0heH/T3I9RImFf+l0XsdY7vqMiIRVaN/nkU2sgEp9diBH?=
 =?iso-8859-1?Q?iI1Y/femRL24bCpaTXVGiYgdnx+CfrGSJH+o1J4olmMuoO1c698Upcm7op?=
 =?iso-8859-1?Q?CvWjCSy4a2PgcdZUW++bKn0plfPhcsKmrkU3wxcbF3ZDh4GbTZ2hJFCWs9?=
 =?iso-8859-1?Q?fNLZa+lo11dHbP9xz41tJ/7MZrmBWraOhGkoc2hlvGFtT3chWGb+GbF0D7?=
 =?iso-8859-1?Q?KeKlN8+wcIKk/jZh2fE1iw3DgQ28/T5mfmXGNOyH1HQdchZMX56IL+87Wr?=
 =?iso-8859-1?Q?WwZhaJic2Dm1Pec9qZLlhXPccLTrVbED1Ex0tFsi/iqmvysmqQ8e+IHmzQ?=
 =?iso-8859-1?Q?3N8jmZkz0QXc3+BT2fT9MS9PBGGGBQSjcGHBZzEhIEFB37smTT2yXBrJS+?=
 =?iso-8859-1?Q?zWwuOABrH8XHcdB30Er7bRQopgbxhAbmtU7kDwIBvnyZxtzRr9BPeDJUDk?=
 =?iso-8859-1?Q?WXaHMPRXyDwmbyyDq4ToxyJUyv41qSjTPFHL8YGu3oDyFDilz5uoroL78z?=
 =?iso-8859-1?Q?xZJ2ONjcpMfrrIBbq/IwiGoB/vcnmeqFGKdL2BnWD3R/G+CD0/xKNoxxit?=
 =?iso-8859-1?Q?dsw5wEokWn9edohWjKM9vK0rq8+6o1nJtRhuOG70MOrjQX5Ua3OshdcyxV?=
 =?iso-8859-1?Q?ivYuU4yDQxxZH9bGXSoLg/aAX+hg4VPcKxdAtgjljwtx4gH8Lubj7g1ck3?=
 =?iso-8859-1?Q?Wzsy/ACAVTKw2mVZRjZ4h1kR6espMBfNLD2ViA+pZCJgC9ECCHwlVTU3j1?=
 =?iso-8859-1?Q?O+Yb5Z0IJL47mIJBRbhM5jkUq8CRf+xgQeO58xFJv2KWD15ocuaEwdt126?=
 =?iso-8859-1?Q?JamDlAdpPDwW0HhbqhCcBwgH7qQTDET28/WyGRrA9ic+iT7ujk15ycghnv?=
 =?iso-8859-1?Q?6sSqbLFgrKr85WkNOL6lzdk7iugCJbWzswSKwlL0b/khH5hCkedqpIYXqU?=
 =?iso-8859-1?Q?c1qO0FC1fmgO7sVe+5FBO+khLKydnPRgV7cnbOWD8JbIWmWWcu3qGktUUl?=
 =?iso-8859-1?Q?jiKbTZR4JEAv/kM8E7A0dJubGGRAMNkXsAqR5Vhj50a1iJ1AiDIDLR3rv2?=
 =?iso-8859-1?Q?nK6kqdzqcaKIoVKJIIXtJpiicegibizJBJlTxFr+29z7T9FQY2Pq30nvn3?=
 =?iso-8859-1?Q?Fjptkl++1rVbQ+lEQ4z/ULJX1ZDlz7rcw2aikLsIijpfFhSRoyW/lbEtE4?=
 =?iso-8859-1?Q?wEjNGzxG53E8+bpGB4XrDmFjgFHYRRmjOhUyC9g+CJDv7wlYS9eNh9Ey87?=
 =?iso-8859-1?Q?JUnDCotkHYDEfdnLZF3Ya44QEMwD4rcO/n7KXLsAaNNPeU6UbCcvN4kgfF?=
 =?iso-8859-1?Q?18OZyfIwxiLuJzMg82cYEK4HA1ItVUqIktp7w860efuvLrfkDhnFMKNbFP?=
 =?iso-8859-1?Q?ncATY84bJaSUlhD4SccdKD9JYDj59XrxArwDSs57eK/mu7axarChZVR1fD?=
 =?iso-8859-1?Q?AQsn/cPmWL3iQtGL6AHzsv41OyOsE8AztzalW09c/LXazBjPdszQei/0lN?=
 =?iso-8859-1?Q?hQHILiiQx5zyi4XU2ZvwnS/ksN7lFq3cUfgHToGl1a33yrOEo1OBPMniZS?=
 =?iso-8859-1?Q?Sr804Fj7NUz2VtpoQLeCLYjaC7Zlev9Af0nuH7h+smcunSFmVd4yjKHQrX?=
 =?iso-8859-1?Q?0PYXgyXq5biaAttnNrfI45LzDNzWCJb+isXYw0Hd2+iUlaAph9QyDpTKME?=
 =?iso-8859-1?Q?EJlCa4WreQNNVUKVb2JDH+Rj3xpazKbzeLOjuXo//1gMdgLxJIwo18pPya?=
 =?iso-8859-1?Q?lm4+sxKyXgB7aoyhyygoTjpxZE2lkZjLLzOvm8T1e7l86NtLHKGI?=
X-Exchange-RoutingPolicyChecked: BMwLKPppqLi5B0k8SL2Ll7I68ZifIqKOWWBfbKDPR8HiZIADj48fyg19qiYMAn0W+mdVTPMh0Q8089caykCGVizQpifFIF5eQXQAHX0NhuPxkPdb8SAbDdPtnfBB1JI0panHuDGNDFtJvS2cPxhGHupBMWh8jHaVivlhJ4tyjgDg3y1ZcKzfBm4qwBpEn7b2I5jRnS+iwBzMN/rbtg/k6r/jj4q8rAeTtI9NuCqkmnjjO0xQblj5ucB3x2PQbs/S+kj9RgxNPQQw8v6zOuQI7GQAqhW0aVVpwNospKxNrZoH8lnZ+jmUoaFIP44QtKHyvPJL/tiwRM/CqR/uXe12RQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bff2f4-3b16-469f-4fea-08df478cc59f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 05:03:24.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRRCSc+JvXeUCfhbE9JzBxFSXX/BzOa6euLVlAd0H+/rGnY1OmM9Y/OrIeapf43lzvsvarUYzRYybo/InQBFxl52hLOwDHCLmPIUBeHuNZT+Q3TCWiTELC8m3Lf+FxL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB797045
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

On Thu, Nov 19, 2026 at 09:48:23PM -0800, Matthew Brost wrote:
>On Tue, Nov 10, 2026 at 11:31:53PM -0800, Niranjana Vishwanathapura wrote:
>> On Fri, Jul 10, 2026 at 07:55:56PM -0700, Matthew Brost wrote:
>> > ttm_pool_prealloc_fill() lets a driver preallocate beneficial-order pages
>> > outside the dma-resv lock for a defragmentation move, so the high-order
>> > allocations that may stall in reclaim/compaction happen off the critical
>> > section.  That bag is deliberately partial: it holds only interchangeable
>> > beneficial-order chunks and the allocator consumes it opportunistically,
>> > falling back to in-line allocation for everything else.
>> >
>> > An ordinary populate of a system-memory buffer object has the same
>> > problem - the whole backing is allocated under the dma-resv lock - but no
>> > way to move it out of the critical section, because the existing bag does
>> > not cover sub-beneficial orders and does not describe a full tt.
>> >
>> > Add a "full" flavour of the same preallocation mechanism:
>> >
>> >  - struct ttm_pool_prealloc gains a @full flag.  In full mode the bag is
>> >    an ordered tiling of an entire tt at mixed orders (pool pages
>> >    included), rather than a set of interchangeable beneficial-order
>> >    chunks.  The per-chunk order is recorded on the page itself and read
>> >    back at consume time, so no parallel order array is needed.
>> >
>> >  - ttm_pool_prealloc_fill_full() allocates the whole backing for a tt of
>> >    @num_pages pages up front, mirroring the in-line allocator's order
>> >    walk (highest order first, capped by the remaining page count).  It
>> >    reuses the existing unlocked helpers (ttm_pool_prealloc_gfp(),
>> >    ttm_pool_set_caching()) via a new ttm_pool_take_page() helper that
>> >    tries a same-order pool page before a fresh system allocation.
>> >
>> >  - ttm_pool_prealloc_fini() frees any unconsumed tail at each chunk's own
>> >    order when @full.
>> >
>> >  - ttm_pool_prealloc_fill_full() takes a @beneficial_reclaim_backoff
>> >    argument, plumbed to ttm_pool_alloc_page(), that lets the caller
>> >    allocate higher-order chunks without aggressive reclaim/compaction.
>> >    This suits a driver that upgrades suboptimal pages to beneficial order
>> >    in place later (e.g. via a background defragmenter) and so has no need
>> >    to stall the user context reclaiming for contiguity up front.
>> >
>> >  - __ttm_pool_alloc() consumes a full bag with a single early branch in
>> >    ttm_pool_iter_acquire_page(): install the next chunk as-is (order
>> >    taken from the page) and return; once the best-effort bag is drained
>> >    the loop falls through to normal in-line allocation.  The defrag
>> >    harvest and reuse-old phases are inert here as there is no
>> >    defrag_old_tt.
>> >
>> > Like the defrag bag, this is best-effort: a short fill is fine (the pool
>> > allocates the shortfall in-line) and DMA-alloc pools are unsupported
>> > (caching is applied on the kernel mapping).  No functional change for
>> > existing users; the new fill routine has no in-tree caller yet.
>> >
>> > Cc: Carlos Santa <carlos.santa@intel.com>
>> > Cc: Ryan Neph <ryanneph@google.com>
>> > Cc: Christian Koenig <christian.koenig@amd.com>
>> > Cc: Huang Rui <ray.huang@amd.com>
>> > Cc: Matthew Auld <matthew.auld@intel.com>
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Cc: Maxime Ripard <mripard@kernel.org>
>> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> > Cc: David Airlie <airlied@gmail.com>
>> > Cc: Simona Vetter <simona@ffwll.ch>
>> > Cc: dri-devel@lists.freedesktop.org
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> > Assisted-by: GitHub_Copilot:claude-opus-4.8
>> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> > ---
>> > drivers/gpu/drm/ttm/ttm_pool.c | 232 ++++++++++++++++++++++++++++++++-
>> > include/drm/ttm/ttm_bo.h       |  19 +--
>> > include/drm/ttm/ttm_pool.h     |  27 +++-
>> > 3 files changed, 258 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>> > index da7d132c8297..4746f5d8cd7e 100644
>> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> > @@ -1046,6 +1046,7 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
>> > 	pp->caching = tt_caching;
>> > 	pp->count = 0;
>> > 	pp->used = 0;
>> > +	pp->full = false;
>> >
>> > 	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
>> > 	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
>> > @@ -1102,6 +1103,187 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
>> > }
>> > EXPORT_SYMBOL(ttm_pool_prealloc_fill);
>> >
>> > +/*
>> > + * Acquire a single *@order chunk, trying a same-order pool page first (already
>> > + * carries @caching) then a fresh system allocation (write-back). Runs unlocked.
>> > + * When @beneficial_reclaim_backoff is set, higher-order system allocations skip
>> > + * aggressive reclaim/compaction (see ttm_pool_alloc_page()).
>> > + *
>> > + * A fresh system page is write-back and needs the tt's caching applied later in
>> > + * bulk; *@need_caching is set true for it and false for a (pre-cached) pool
>> > + * page.
>> > + *
>> > + * On a genuine failure *@order is left untouched (the caller lowers it by one
>> > + * and retries). Fault injection instead pretends allocation at (or above) the
>> > + * beneficial order failed and lowers *@order to the beneficial order, so the
>> > + * caller's next attempt lands below it - mirroring the in-line acquire path's
>> > + * fail_beneficial jump and exercising the beneficial_order_failed tracking
>> > + * without driving the system into real fragmentation.
>> > + *
>> > + * Returns NULL if no page of *@order could be obtained.
>> > + */
>> > +static struct page *ttm_pool_take_page(struct ttm_pool *pool,
>> > +				       enum ttm_caching caching,
>> > +				       unsigned int *order, gfp_t gfp,
>> > +				       bool *need_caching,
>> > +				       bool beneficial_reclaim_backoff)
>> > +{
>> > +	unsigned int beneficial = ttm_pool_beneficial_order(pool);
>> > +	struct ttm_pool_type *pt;
>> > +	struct page *p;
>> > +
>> > +	*need_caching = false;
>> > +
>> > +	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && beneficial &&
>> > +	    *order >= beneficial &&
>> > +	    should_fail(&beneficial_order_fault_inject, 1)) {
>> > +		*order = beneficial;
>> > +		return NULL;
>> > +	}
>> > +
>> > +	pt = ttm_pool_select_type(pool, caching, *order);
>> > +	if (pt) {
>> > +		p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
>> > +		if (p)
>> > +			return p;	/* pool page already carries @caching */
>> > +	}
>> > +
>> > +	p = ttm_pool_alloc_page(pool, gfp, *order, beneficial_reclaim_backoff);
>> > +	if (!p)
>> > +		return NULL;
>> > +
>> > +	/* Fresh system page is write-back; caller applies @caching in bulk. */
>> > +	*need_caching = true;
>> > +	return p;
>> > +}
>> > +
>> > +/**
>> > + * ttm_pool_prealloc_fill_full() - Preallocate a whole tt's backing outside any
>> > + * lock
>> > + * @pool: The pool to allocate from.
>> > + * @tt_caching: The requested cpu-caching for the pages allocated.
>> > + * @pp: Prealloc bag to fill; marked @full and tiled with mixed-order chunks.
>> > + * @num_pages: Number of 4K pages the tt needs backed.
>> > + *
>> > + * Unlike ttm_pool_prealloc_fill() (which parks a bag of interchangeable
>> > + * beneficial-order defrag chunks), this allocates the ENTIRE backing for a tt
>> > + * of @num_pages pages up front, at whatever mix of orders is available (pool
>> > + * pages included), so that the subsequent __ttm_pool_alloc() under the dma-resv
>> > + * lock merely installs the pages without stalling in reclaim/compaction. The
>> > + * chunk orders mirror the in-line allocator's order walk; each chunk's order is
>> > + * recorded on the page itself and read back at consume time.
>> > + *
>> > + * May sleep/reclaim freely as it runs unlocked. When
>> > + * @beneficial_reclaim_backoff is set, higher-order chunks are taken without
>> > + * aggressive reclaim/compaction: the caller relies on a background
>> > + * defragmenter to upgrade to beneficial-order pages in place later, so there
>> > + * is no need to stall the user context reclaiming for contiguity here. A short
>> > + * fill is fine: the pool falls back to in-line allocation for the shortfall.
>> > + * DMA-alloc pools are not supported (the bag stays empty). Returns 0 (release
>> > + * with ttm_pool_prealloc_fini()).
>> > + */
>> > +int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
>> > +				enum ttm_caching tt_caching,
>> > +				struct ttm_pool_prealloc *pp,
>> > +				unsigned int num_pages,
>> > +				bool beneficial_reclaim_backoff)
>> > +{
>> > +	gfp_t gfp = ttm_pool_prealloc_gfp(pool) | __GFP_ZERO |
>> > +		__GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>>
>> Assisted-by: LLM
>>
>
>Yes.
>
>> __GFP_RETRY_MAYFAIL is bit confusing here as as ttm_pool_alloc_page()
>> is expected to suppy it (patch 1). I see that only applies to
>> beneficial order, but here we have mixed-order and hence it is set
>> here. May be add some documentation to clarify it?
>>
>
>Ye, this is a bit confusing. ttm_pool_alloc_page will change these flags
>based beneficial_reclaim_backoff / beneficial_order. In general I chose
>to set __GFP_RETRY_MAYFAIL here as a default to avoid the prealloc to
>avoid any chance of triggering OOM - i.e., if prealloc fails for
>whatever reason we fall back the traditional TTM alloc path which I
>think is correct.
>
>So maybe '__GFP_RETRY_MAYFAIL is set to never trigger OOM on prealloc'.
>

Sounds good.

>> > +	unsigned int highest = MAX_PAGE_ORDER;
>> > +	unsigned int remaining = num_pages;
>> > +	struct page **cpages = NULL;
>> > +	unsigned int ncpages = 0;
>> > +	int r;
>> > +
>> > +	pp->pages = NULL;
>> > +	pp->order = 0;
>> > +	pp->caching = tt_caching;
>> > +	pp->count = 0;
>> > +	pp->used = 0;
>> > +	pp->full = true;
>> > +
>> > +	/* Caching is applied on the kernel mapping, so DMA-alloc is unsupported. */
>> > +	if (!num_pages || ttm_pool_uses_dma_alloc(pool))
>> > +		return 0;
>> > +
>> > +	/* Worst case is one order-0 chunk per page. */
>> > +	pp->pages = kvzalloc_objs(*pp->pages, num_pages);
>> > +	if (!pp->pages)
>> > +		return 0;
>> > +
>> > +	/*
>> > +	 * Fresh write-back chunks get their caching changed in a single
>> > +	 * set_pages_array_*() after the fill; collect their constituent pages
>> > +	 * into an unpacked scratch array (one entry per 4K page) since the
>> > +	 * packed bag holds mixed-order chunks. Cached tts and pool pages need
>> > +	 * no change (and non-x86 handles caching at map time).
>> > +	 */
>> > +	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
>> > +		cpages = kvzalloc_objs(*cpages, num_pages);
>>
>> Same comment as in patch 9.
>> cpages is tansient memory and unlike patch 9, it is not bounded by 'budget' here.
>
>It is not bounded by any budget rather by the number pages in the BO
>size.
>

I mean in defragment case, it is bounded by XE_BO_DEFRAG_SIZE_LIMIT, but
in gem_create ioctl, it is not. So, for a 1GB BO, the required memory for
this array is 2MB.

>> may be it can be avoided altogether by using a one static 4k page in the
>> pool and flush it with set_pages_array*() as and when it fills up?
>>
>
>I think that is the wrong trade. set_pages_array on x86 does some
>hardware interaction which is rather expensive, thus the entire reason
>TTM pool exist to avoid calling set_pages_array on every alloc / free.
>i.e., more tansient memory vs 1 hardware interaction is the right trade.
>

I meant batched set_pages_array*() call with fixed batch size (not for
every page). But I agree, we shouldn't complicate it unless it is really
required. So, code is fine as is.

>> > +		if (!cpages) {
>> > +			kvfree(pp->pages);
>> > +			pp->pages = NULL;
>> > +			return 0;
>> > +		}
>> > +	}
>> > +
>> > +	while (remaining) {
>> > +		unsigned int order = min_t(unsigned int, highest,
>> > +					   __fls(remaining));
>> > +		bool need_caching;
>> > +		struct page *p;
>> > +
>> > +		for (;;) {
>> > +			p = ttm_pool_take_page(pool, tt_caching, &order, gfp,
>> > +					       &need_caching,
>> > +					       beneficial_reclaim_backoff);
>> > +			if (p)
>> > +				break;
>> > +			if (!order)
>> > +				goto apply_caching;	/* short fill */
>> > +			/*
>> > +			 * Genuine failure: retry one order down. A fault
>> > +			 * injection lowered @order to the beneficial order
>> > +			 * above, so this drops it below - landing on a
>> > +			 * sub-optimal (defrag-worthy) chunk.
>> > +			 */
>> > +			order--;
>> > +		}
>> > +
>> > +		pp->pages[pp->count++] = p;
>> > +		if (cpages && need_caching)
>> > +			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
>> > +							order);
>> > +		remaining -= 1u << order;
>> > +		highest = order;
>> > +	}
>> > +
>> > +apply_caching:
>> > +	/*
>> > +	 * Apply the requested caching to every collected page in one shot. On
>> > +	 * failure the pages' caching is indeterminate, so drop the whole bag
>> > +	 * (freeing restores write-back) and let the consumer allocate in-line.
>> > +	 */
>> > +	r = ttm_pool_prealloc_apply_caching(tt_caching, cpages, ncpages);
>> > +	kvfree(cpages);
>> > +	if (r) {
>> > +		unsigned int i;
>> > +
>> > +		for (i = 0; i < pp->count; i++) {
>> > +			struct page *p = pp->pages[i];
>> > +
>> > +			ttm_pool_free_page(pool, tt_caching,
>> > +					   ttm_pool_page_order_nodma(p), p,
>> > +					   false);
>> > +		}
>> > +		pp->count = 0;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL(ttm_pool_prealloc_fill_full);
>>
>> It has lot of code common with ttm_pool_prealloc_fill(). May be extract common
>> code to separate function/s?
>
>I see what you mean, but the algorithms are different. One tries to
>obtain N beneficially ordered pages, while the other fills an array with
>any set of pages regardless of order.
>
>I'm hesitant to force the code into helpers or create a single unified
>function with conditionals just to save 70 lines of code. In my opinion,
>the abstraction is already at the right level.
>

Ok

>>
>> > +
>> > /**
>> >  * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
>> >  * @pool: The pool the pages came from.
>> > @@ -1111,9 +1293,13 @@ void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
>> > {
>> > 	unsigned int i;
>> >
>> > -	for (i = pp->used; i < pp->count; ++i)
>> > -		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
>> > -				   false);
>> > +	for (i = pp->used; i < pp->count; ++i) {
>> > +		struct page *p = pp->pages[i];
>> > +		unsigned int order = pp->full ?
>> > +			ttm_pool_page_order_nodma(p) : pp->order;
>> > +
>> > +		ttm_pool_free_page(pool, pp->caching, order, p, false);
>> > +	}
>> > 	kvfree(pp->pages);
>> > 	pp->pages = NULL;
>> > 	pp->count = 0;
>> > @@ -1251,9 +1437,10 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
>> >
>> > /*
>> >  * Acquire a single page for the current order, leaving it in @it->p (NULL on
>> > - * failure). Tries, in order: a beneficial-order page preallocated outside the
>> > - * dma-resv lock (defrag), a same-order pool page, then a fresh system
>> > - * allocation. Fault injection can force the beneficial-order paths to "fail".
>> > + * failure). Tries, in order: a chunk from a full out-of-lock prealloc (populate
>> > + * of the whole tt), a beneficial-order page preallocated outside the dma-resv
>> > + * lock (defrag), a same-order pool page, then a fresh system allocation. Fault
>> > + * injection can force the beneficial-order paths to "fail".
>> >  */
>> > static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
>> > {
>> > @@ -1262,6 +1449,39 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
>> >
>> > 	it->p = NULL;
>> >
>> > +	/*
>> > +	 * Full prealloc: the entire backing was allocated (pool + system, at
>> > +	 * mixed orders) outside the dma-resv lock. Install the next chunk as-is,
>> > +	 * taking its order from the page. Falls through to in-line allocation
>> > +	 * once the best-effort bag is drained.
>> > +	 */
>> > +	if (pp && pp->full && pp->used < pp->count) {
>> > +		it->fail_beneficial = false;
>> > +		it->p = pp->pages[pp->used++];
>> > +		it->order = ttm_pool_page_order_nodma(it->p);
>> > +		it->page_caching = it->tt->caching;
>>
>> Same comment as in 23.
>> We should ensure caching has not changed here after prefill
>> (ie., pp->caching == it->tt->caching). Though it is not expected to change
>> in gem_create_ioctl call (unlike defragmentation case of patch 23),
>> probably it is still better to check to ensure TTM prealloc() and
>> pool_alloc_page() interfaces work correctly together?
>>
>
>We don't have formalized assert framework in TTM like we do in Xe but
>perhaps we should - I'd like add one in a follow up as there as so many
>undocumented invarients in TTM...
>
>So...
>
>/* TODO: formalize invarients in a common TTM assert framework */
>WARN_ON(it->tt->caching != pp->pp->caching)?
>

In gem_create ioctl case (which is the case here), the tt->caching is not
expected to change between prefill and allocation (whereas in defragmentation
case of patch 23, it can). So, yes a WARN_ON should be good here.
But given it is ttm code, may be in both cases (gem_create ioctl and
defragmentation), we should probably fall back to regular allocation
and free the preallocated pages?

Niranjana

>Matt
>
>> > +
>> > +		/*
>> > +		 * The full prealloc tiles at whatever orders were available
>> > +		 * without stalling in reclaim. A sub-beneficial chunk only
>> > +		 * means a sub-optimal backing (defrag-worthy) when it sits in a
>> > +		 * beneficial-order aligned region that fully fits in the tt -
>> > +		 * that region could have been a beneficial-order page. A low
>> > +		 * order in the unaligned trailing tail is expected and must not
>> > +		 * flag the tt (mirrors ttm_pool_harvest_remaining()).
>> > +		 */
>> > +		if (it->beneficial_order && it->order < it->beneficial_order) {
>> > +			pgoff_t bnr = 1UL << it->beneficial_order;
>> > +			pgoff_t off = it->tt->num_pages -
>> > +				      it->alloc->remaining_pages;
>> > +
>> > +			if (round_down(off, bnr) + bnr <= it->tt->num_pages)
>> > +				it->tt->page_flags |=
>> > +					TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>> > +		}
>> > +		return;
>> > +	}
>> > +
>> > 	/*
>> > 	 * Fault injection: pretend allocation at (or above) the device's
>> > 	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
>> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>> > index a80304f179ba..52ec7e5c0d2d 100644
>> > --- a/include/drm/ttm/ttm_bo.h
>> > +++ b/include/drm/ttm/ttm_bo.h
>> > @@ -238,14 +238,17 @@ struct ttm_operation_ctx {
>> > 	 */
>> > 	s64 defrag_bytes_remaining;
>> > 	/**
>> > -	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
>> > -	 * move. The pool allocator consumes these instead of allocating fresh
>> > -	 * beneficial-order pages under the lock, moving the (potentially
>> > -	 * reclaim/compaction stalling) high-order allocations out of the
>> > -	 * critical section. NULL means allocate in-line as usual. The pool
>> > -	 * silently falls back to in-line allocation for any shortfall. The
>> > -	 * allocator consumes it for beneficial-order chunks of any populate;
>> > -	 * drivers only set it for a defrag move.
>> > +	 * @prealloc: Pages preallocated outside the dma-resv lock. The pool
>> > +	 * allocator consumes these instead of allocating under the lock, moving
>> > +	 * the (potentially reclaim/compaction stalling) allocations out of the
>> > +	 * critical section. NULL means allocate in-line as usual. Two flavours,
>> > +	 * distinguished by ttm_pool_prealloc::full:
>> > +	 *   - defrag bag (full=false): a bag of interchangeable beneficial-order
>> > +	 *     chunks consumed only for beneficial-order chunks of a defrag move.
>> > +	 *   - full tiling (full=true): the entire backing of the tt, at mixed
>> > +	 *     orders, consumed for every chunk of an ordinary populate.
>> > +	 * The allocator silently falls back to in-line allocation for any
>> > +	 * shortfall.
>> > 	 */
>> > 	struct ttm_pool_prealloc *prealloc;
>> > 	/**
>> > diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
>> > index 71670350eb15..777d5aa08f6a 100644
>> > --- a/include/drm/ttm/ttm_pool.h
>> > +++ b/include/drm/ttm/ttm_pool.h
>> > @@ -83,18 +83,27 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
>> >
>> > /**
>> >  * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
>> > - * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
>> > - *         short); each entry is the head page of a 1 << @order chunk.
>> > - * @order: Page order of every preallocated chunk.
>> > + * @pages: Array of @count preallocated chunks; each entry is the head page of a
>> > + *         chunk. In defrag mode every chunk is @order pages; in @full mode the
>> > + *         chunks tile a whole tt at mixed orders and the per-chunk order is read
>> > + *         back from the page itself.
>> > + * @order: Page order of every preallocated chunk (defrag mode only; 0 in @full
>> > + *         mode where each chunk carries its own order).
>> >  * @caching: CPU caching applied to the pages, so leftovers can be restored
>> >  *           to write-back before being freed.
>> >  * @count: Number of valid entries in @pages.
>> >  * @used: Number of entries already consumed by the pool allocator.
>> > + * @full: When set the bag holds a full, mixed-order tiling of an entire tt
>> > + *        (produced by ttm_pool_prealloc_fill_full()) rather than a bag of
>> > + *        interchangeable beneficial-order defrag chunks. The pool allocator
>> > + *        then drains the bag in order for every populate, taking each chunk's
>> > + *        order from the page, and falls back to in-line allocation only for any
>> > + *        shortfall.
>> >  *
>> >  * Defrag pages are interchangeable, so only a count of beneficial-order chunks
>> > - * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
>> > - * __ttm_pool_alloc() drains it; any unused tail is released by
>> > - * ttm_pool_prealloc_fini().
>> > + * is needed. ttm_pool_prealloc_fill() / ttm_pool_prealloc_fill_full() populate
>> > + * this outside the lock and __ttm_pool_alloc() drains it; any unused tail is
>> > + * released by ttm_pool_prealloc_fini().
>> >  */
>> > struct ttm_pool_prealloc {
>> > 	struct page **pages;
>> > @@ -102,10 +111,16 @@ struct ttm_pool_prealloc {
>> > 	enum ttm_caching caching;
>> > 	unsigned int count;
>> > 	unsigned int used;
>> > +	bool full;
>> > };
>> >
>> > int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
>> > 			   struct ttm_pool_prealloc *pp, unsigned int count);
>> > +int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
>> > +				enum ttm_caching tt_caching,
>> > +				struct ttm_pool_prealloc *pp,
>> > +				unsigned int num_pages,
>> > +				bool beneficial_reclaim_backoff);
>> > void ttm_pool_prealloc_fini(struct ttm_pool *pool,
>> > 			    struct ttm_pool_prealloc *pp);
>> > unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
>> > --
>> > 2.34.1
>> >
