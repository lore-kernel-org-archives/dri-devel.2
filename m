Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C98606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m+Ubxc6e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Oi5zvBww
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75191112848;
	Sat, 14 Nov 2026 02:00:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173C710ED0C;
 Sat, 14 Nov 2026 01:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794621589; x=1826157589;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=cTT2FtYYLWYHUM1TiOol4Rw5BMCB50lstK9cV18zjiE=;
 b=m+Ubxc6eHYUanaBd+EedZeD1fjF8Jw9AhGC75DpUfboJ2l4MG8WRsk2g
 Ri+XXJF8T33phsLc6KMxn9oQeuEemaaJoYmH2hKnuM7uaprwJqlHKHlAc
 7mxQU7hWy4zUNqn3y8d7XZR7UBN1SsnCQu2stAm3FE8nWVAsSI+6K9t08
 MQSgGolEStuk5NI4lneYIKlF5942+ADuy5Ez34AjxGqEJpi3HAtCKsU3G
 AqPpBTEwTA5X3EEWWXAHXgQqU4S9+bfbyXxdD/4liE+h5+pFp1QOTXSGA
 MDtkuX+nSyxUYWi8UV6BtOmcLKdAeKFgQemVGafhUO3kC96bZ8NElBCle A==;
X-CSE-ConnectionGUID: tNEBVvhDRD2pQeVnDgD5Gw==
X-CSE-MsgGUID: 4Yn9OYMTQQ6HnKkLe77nAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3326664"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3326664"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:59:49 -0800
X-CSE-ConnectionGUID: JKyAdVZJQQKAvj+C5kvo6g==
X-CSE-MsgGUID: 0ArLy7BZQ0WMxzvkryHG/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="10972411"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:59:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 17:59:48 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 17:59:48 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 17:59:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQh9fsWOR+CwMOwBirnF6LY71TMSVQ0MQOGjkynKgWMzHlS94A3vG3VZTffB1MgLxtTSX7tQ45fxRyl2Fun2DkhlinnwC9kYaS3nZu8z4RFxGr8EvpqAGUXdZInovRgx/Vw4i4fuBUhmJgE1RmoHL0AM/Y08WlWYUSQCSf5ZDKSPfdEzrhqpxB8IXd7QJ5DD8v6cHLkJ4yFfvhyt7USKV4P6nC21YVwJQw1cyLM1ieWnYXg2DlarlVW1xOIVB1EDiTxsZDVKbfQf4235HS+0T0ROvrMOuhCjOAG4ZRCSAtfyDT/cPM1px+QU1xMdo3uCvngvp2/XJIFkRgCewWcoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STM7tsdPNPMCg6l67xUav9C96AgoAi3PBMYpvyyebmo=;
 b=KSLSsvM125i+pjbO21vn8SqK/wGK+3UepDhhk/SYwTecVTRpUhYQOhtLfmlWffyUZfctsmqS4VNJVQlT9MYNEo78UDQGX/Lh1ZzbUFqgwAjUwMaZKY6TFo7x5auIz+0ro7zRY4QFvKMexHpN29z4S3El/8z1U9adrsjabe1kA936uj+9mAmd2tCyFmwFT+hRlLoDFO/XoFKn3ahZf238PG/XS7TbU2XkfyBw6Lf5vKseGbdr2NQFRsQl06bd7PAp0yXh3sKYtmZr4qqxV0IHVUx2L5H4THGu1ZpQKw/eDxTl+uT3sKyBAQYN1fY+19jXD5XUJTWsK4P7EPtAm6LdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STM7tsdPNPMCg6l67xUav9C96AgoAi3PBMYpvyyebmo=;
 b=Oi5zvBwwdDI3j7JfVqtgjIG4AlNRJrrtpXp38knYxyjrAWPlccooSZV5n5ljqukNgP6SUWHrjv1ExRyoezMMrALNy0LbRY+iLc7WA0oqAgLYTmbIpOjm/5Eos/r3ehjHXW4HetSZCPWWeU+YzTcPjYBnyg3Fjg8OBhB+q16vkfs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 01:57:42 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 01:57:42 +0000
Date: Fri, 13 Nov 2026 17:57:40 -0800
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
Subject: Re: [PATCH v3 31/33] drm/xe: Blit src-natural to dst-packed for
 defrag-IOVA copies
Message-ID: <avfAFMt0eQysdiq7@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-32-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-32-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0f2e67-3ec0-4efc-0ede-08df41f2ab6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261022105027099003|261021123027099003|261026140227099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: io2PZ37HV09t7r/sCEnyomc6TOWkFJcrkbio+piLnEMhOUqa2sB2VTU9v0vN0k8vm573xK6TQZFVkz/4UwLHb1N6KeRxAqiM72BPbiVTY36m7w/7Jgu3xPLxkyf1SNy8CYKXMVp/Nw4dWejpZ5LdruN9rrYqx954NGxfWzLj1j7mACeoBY5xwEQz2+fHoBDFjFzl1Rq7nhhVBj2BzXmbS5BJighGrAW4itJ3Uf3/J567BS0vuRZqqps07PgNaS3hsyOmRDdI5NgyFo1wHm+N8PrUZmHdl9lwdbh+n16cpwprikX5VuUG7jxp/+7GcEIQ1DR8VF9+AHB9ltcW4Cl91fpDdrWAX1NbKVWqxOrkTnX980NSNI9grw3weoV0GBDzwmjyBTcp6zgyZOkHGgeYT46GP85BnePdxfEXdz+mGMOYSdO3BFU6r3TwLJF3Ad49/vi3c9yTXXIIlN+K9HifiMg/NCatwtNwrxB3s6grEzdkO/pfeLkRUzGWCKBYF1HLoAa+ulIFvu8YHc8ka0qNh5+lBrhLYyNEfistFqOTL3Eo7pLMmpdMpY7oO3pbLIUsKYb2UVbnvQ3E5jb6BOp3606UeSnfMpeeREl40WJWwZOolUoccND0WTZu4neQ+KEbMbSbcyV6VHQaIR16dTMeIHu3tQUFR9ZwppFhre5fvzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261021123027099003)(261026140227099003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZZTpSwWZSVz6IHTa2zMgXMa19dMWwNE7eOQ+TVZiWK/ZFTSVuPg+FbmTmj?=
 =?iso-8859-1?Q?Op0MKJKBUkaWuEWM1mZUwP0xpOKKxGYzlP9eBBWO5TcKsBuh0V8O8gkCsc?=
 =?iso-8859-1?Q?I3GMKlXxjjSRZ+mNcFHI1rhlBUzTRwKAkp7lO+5tLO1o/vmAmnKfyPfHgv?=
 =?iso-8859-1?Q?sZ28zF7ce+zoWxXH6DcNUyeiFoza2GzFNT8MlhcFyshUOYs+yaSZkk7Fx7?=
 =?iso-8859-1?Q?JIGKJH03u71PmFSeQhxRFpCgfMSV4heue150StD+qv2jtNvshaWqKggkkJ?=
 =?iso-8859-1?Q?IeyDGnTWmBbzNyzW1atSAq0s5D1I9BndOHQf62mRM30TAIN7KPTYnZzl5y?=
 =?iso-8859-1?Q?cd8vv9Rmdv/hkDjuTQh1FMF2cBvtxtUim3ewEO0StcksleMY2SJ3Nky4Tk?=
 =?iso-8859-1?Q?Ip1/aoQgkABORVxiVWPLkj1+v/UB6qUnp4vs0HdwZdsaM+B275UHmBAyHa?=
 =?iso-8859-1?Q?N06eudyR9MP5oJB5C96+PYQ+SUGkW+HPK59iOSRsf1B2HiSVfLDvS7EZJC?=
 =?iso-8859-1?Q?Ek4mkNM5/a9V19Ks0XY1IvBSW2dDQTc9jRVfm/bXlZxyaWW5LO+m+IAVPD?=
 =?iso-8859-1?Q?UQMzWCjKbFuDAT1jK6GAYANDEyGNzi/U0qyOdHX6LgtXhY7YFIG9nxHyL1?=
 =?iso-8859-1?Q?r2RzFIKD5Zen8vlDBuVBKjoukOeUQa83URAY8X+J7PFUMMyacWxxJdMo2X?=
 =?iso-8859-1?Q?8Hy5sNanYOxNhdA/16jvo4S2354ysp1yr2uf0XSXfGS03qCVJnzfVjn+Zs?=
 =?iso-8859-1?Q?MKoFGYyQZbjeTRYzGArbx0ivPGl41Qdp8EFT9z/O639w4P9decD6hjnoNO?=
 =?iso-8859-1?Q?3K8SVdKpzkEd7XokoRITFajgjamBZFtORYxOmau9QqiaMYyi3MZYIKTizv?=
 =?iso-8859-1?Q?+lOY7VU76AKWed0vSCQ7/V/ryzMVz+jnEpfC+0FaMJENhsydl+IrAJAfvP?=
 =?iso-8859-1?Q?xJF3ukQModj4SdttbmbXpuZN/3vFeYLgV9cCwVGiXBi3cGE+yRzJLfcUrf?=
 =?iso-8859-1?Q?JewIMmcZCxksLg6qmHoUqA3rI0wYOweDrxI2Nmi9P4vUb+67Pv1oyK/8nw?=
 =?iso-8859-1?Q?uh5DC/HmDlq6wrUv+mapCP4PZISwUi5N061x1pwTvNDdb74RzgWTqnIGV1?=
 =?iso-8859-1?Q?CU8gNnle4mV/dJoQPAo5/cKjlXsMYVqV0+CXtMMhv3wX5hGoqjxmahtgVv?=
 =?iso-8859-1?Q?hjDKWahBa2CCXiVeKTJdsSYAfMSdJA44FC4DABwIIdLzhxa7YPhJrgRoaA?=
 =?iso-8859-1?Q?IbIM81dodJOu2O6FdmDojQ/jzfPnib7UlQXFPyY9y6WgudrzrnSZnnNM5W?=
 =?iso-8859-1?Q?/qmbvixLPcnQRutfFWV2u/Y6aJ24ZpoCh7jXJIAZUM4XiUXbn0bApJzmFS?=
 =?iso-8859-1?Q?JvtRWBgL9RFEwZquRIMkCCtNpZ9vf52aa54tQMO6UbM1cPQSsxX+4N9Kae?=
 =?iso-8859-1?Q?L83wS3DMD7Ps+2aYMnjXBrKYHhTghBdTCDkD1qGfTA3AZOHe7iHYeG3n8f?=
 =?iso-8859-1?Q?3GQDJ6ocHoIkuN2zhPw5ly8YGvLXWnIQZDh+GScbgjTtHWT8e7N5h6ApqE?=
 =?iso-8859-1?Q?o2xOikPisrDjmp2Aq4Pp/MTmTuRM/9yvj0nlNO89fgCTiKAvNoMUt/iiTI?=
 =?iso-8859-1?Q?j8Bo/umGCKRfs5Q6SrmESfQeu9hrg3HB2qJBKC943zmoU2gv99L6pI65df?=
 =?iso-8859-1?Q?6T5k/3/qgN0++AzDy0lGTqMKlDUQbKwqCD7v2JsAERd8B1djc+Cu2SVBuT?=
 =?iso-8859-1?Q?B+bpcG51i6xFnR9GH9yIB8PZv35MUb9O8RXzRMRLBsEUv5Ai6Gv5U7LIY1?=
 =?iso-8859-1?Q?CZaomX2NEzr7XxwKt4FnFoZCOm7bEx5+vL7it3EgouX4UU+4hArG?=
X-Exchange-RoutingPolicyChecked: Km3z3SVgY9VdY7RcApA6j32zwEfX7DrQfgl9cKF+dFNtoZt/I9NbtOtGRls9JbKpjlp2vVnsE/GD94IuKC/X8JA0J90Q+te2VRmjJlN++ok1MQDtcNflBN3uyWvJOW87WHyl/y8nDZz3RpF8dnSLhsmapaMv8yrGtfgqc/NY7FpBXZqFRLDfKxShgcramaB5K3fr4zxxY5mQi7lPyEkCZH+cy+lYJxhV+F9SBRHxZb0vqZA1wsaX814p4ixkl1BuxOx/MCYlIz0HXQw7momwUIeI3KH3jXPGR6u3Kiok0VxfX9/oeoDIw7OjAGzqbeeSLhmCkk/JuaNBqIqHLQhCpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0f2e67-3ec0-4efc-0ede-08df41f2ab6e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 01:57:42.5896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmQvOWqYpuMLih9txwJQcId4TJTE+VHrvspjsj/6krm0CwP1Bn8C1+wBivq5prFbiObPkfx1Meb6ITpTWYpJknkAwEABZMr+bVPoXZKYeAbu3BcMJRBUrMLiax9Qr738
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
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

On Fri, Jul 10, 2026 at 07:56:17PM -0700, Matthew Brost wrote:
>A defrag move with IOVA enabled only DMA-maps the changed (non-borrowed)
>pages of the new tt, packed contiguously into the front of its IOVA
>reservation (xe_tt_map_iova_copy()). The GPU copy therefore has an
>asymmetric geometry: the source is read from the old tt at its natural
>page offsets (via the old tt's full IOVA), while the destination only
>exposes the changed pages, packed.
>
>Teach __xe_migrate_copy() about this packed-destination mode:
>
>- Add a @dst_packed_pages argument. When non-zero the destination tt
>  cursor walks just that many packed pages and the source (not the
>  destination) drives the chunk size, so the smaller packed prefix never
>  clamps the source walk.
>
>- Size the destination PTE update for each chunk from the changed-page
>  count (xe_migrate_count_changed_pages()) rather than the full chunk,
>  and skip the destination PTEs entirely for an all-borrowed chunk.
>
>- Extend emit_copy_chunks() with a @pack_dst flag so each emitted run is
>  blitted from its natural source offset into a running packed
>  destination offset that only advances for changed runs. The
>  all-borrowed skip leaves the packed destination cursor untouched.
>
>Expose this via xe_migrate_copy_defrag_iova(). It is only valid when the
>BO needs no CCS pass, since the separate CCS pass migrates aux state for
>all pages and would require the full destination mapping. The existing
>xe_migrate_copy_defrag() (full destination mapping) remains the path for
>CCS BOs and the non-IOVA fallback.
>
>No users yet; xe_bo_move() is wired to this path in a later patch.
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
> drivers/gpu/drm/xe/xe_migrate.c | 307 ++++++++++++++++++++++++++++++--
> drivers/gpu/drm/xe/xe_migrate.h |   8 +
> 2 files changed, 296 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>index 666c715a9067..e1dc2fb5c5cb 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/xe_migrate.c
>@@ -811,6 +811,64 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
> 		emit_xy_fast_copy(gt, bb, src_ofs, dst_ofs, size, pitch);
> }
>
>+/*
>+ * xe_migrate_count_changed_pages() - Count non-borrowed pages in a defrag chunk.
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ * @npages: Number of pages in the L0 chunk.
>+ *
>+ * A defragmentation move may harvest already beneficial-order chunks from the
>+ * old tt, so the new tt references (borrows) some of the same physical pages.
>+ * Count the pages that actually differ (src page != dst page) within the chunk.
>+ *
>+ * Return: The number of non-borrowed (changed) pages.
>+ */
>+static u32 xe_migrate_count_changed_pages(struct ttm_tt *src_tt,
>+					  struct ttm_tt *dst_tt,
>+					  pgoff_t start_page, u32 npages)
>+{
>+	u32 i, nchg = 0;
>+
>+	for (i = 0; i < npages; i++)
>+		if (src_tt->pages[start_page + i] !=
>+		    dst_tt->pages[start_page + i])
>+			nchg++;
>+
>+	return nchg;
>+}
>+
>+/*
>+ * xe_migrate_leading_borrowed_pages() - Count the run of borrowed pages at the
>+ * head of the remaining copy.
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of the next page to copy within the tt page arrays.
>+ * @max_pages: Pages left to copy.
>+ *
>+ * A defragmentation move borrows the already beneficial-order chunks from the
>+ * old tt, so the new tt references (borrows) the same physical pages for the
>+ * unchanged majority of a large object. Those pages alias on both the source
>+ * and destination GPU mappings and need no copy. Count how many consecutive
>+ * pages starting at @start_page are borrowed so the caller can advance past the
>+ * whole run at once instead of rediscovering it one L0 chunk at a time.
>+ *
>+ * Return: The number of leading borrowed (src page == dst page) pages, capped
>+ * at @max_pages.
>+ */
>+static u32 xe_migrate_leading_borrowed_pages(struct ttm_tt *src_tt,
>+					     struct ttm_tt *dst_tt,
>+					     pgoff_t start_page, u32 max_pages)
>+{
>+	u32 n = 0;
>+
>+	while (n < max_pages &&
>+	       src_tt->pages[start_page + n] == dst_tt->pages[start_page + n])
>+		n++;
>+
>+	return n;
>+}
>+
> /*
>  * emit_copy_chunks() - Emit the data blits for one defrag L0 chunk, skipping
>  * borrowed pages.
>@@ -822,6 +880,9 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
>  * @src_tt: Source (old) tt providing the page pointers.
>  * @dst_tt: Destination (new) tt providing the page pointers.
>  * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ * @pack_dst: If true the destination only maps the changed pages packed
>+ *	      contiguously, so the destination offset advances by changed-page
>+ *	      runs instead of tracking the source page index.
>  *
>  * A defragmentation move may harvest already beneficial-order chunks from the
>  * old tt, so the new tt references (borrows) some of the same physical pages.
>@@ -830,16 +891,21 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
>  * only blit runs of pages that actually differ (src page != dst page),
>  * coalescing contiguous to-copy pages into a single blit.
>  *
>+ * When @pack_dst is set the source pages are read from their natural offsets
>+ * (@src_L0_ofs + page index) while the destination pages were packed into a
>+ * contiguous prefix, so the destination offset is a running counter that only
>+ * advances for emitted (changed) runs.
>+ *
>  * Return: The number of blits emitted (or that would be emitted when @bb is
>  * NULL).
>  */
> static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
> 			    u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
> 			    struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
>-			    pgoff_t start_page)
>+			    pgoff_t start_page, bool pack_dst)
> {
> 	u32 npages = src_L0 >> PAGE_SHIFT;
>-	u32 i = 0, nblits = 0;
>+	u32 i = 0, pack = 0, nblits = 0;
>
> 	while (i < npages) {
> 		u32 run = 0;
>@@ -859,9 +925,71 @@ static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
>
> 		if (bb)
> 			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
>-				  dst_L0_ofs + (u64)i * PAGE_SIZE,
>+				  dst_L0_ofs +
>+				  (u64)(pack_dst ? pack : i) * PAGE_SIZE,
> 				  run * PAGE_SIZE, XE_PAGE_SIZE);
> 		nblits++;
>+		pack += run;
>+		i += run;
>+	}
>+
>+	return nblits;
>+}
>+
>+/*
>+ * emit_ccs_copy_chunks() - Emit the indirect CCS aux copies for one packed
>+ * defrag L0 chunk, skipping borrowed pages.
>+ * @gt: The GT.
>+ * @bb: The batch buffer to emit into, or NULL to only count the copies needed.
>+ * @src_L0_ofs: GPU offset of the source pages mapped (comp PAT) for this chunk.
>+ * @dst_L0_ofs: GPU offset of the destination pages mapped (comp PAT) for this
>+ *	        chunk (the packed changed-page prefix).
>+ * @src_L0: Byte size of the L0 chunk (page aligned).
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ *
>+ * Companion to emit_copy_chunks() for the packed defrag CCS pass. The flat-CCS
>+ * aux state is migrated indirectly through the data-page mappings, so it
>+ * follows the physical page regardless of the (packed) GPU VA layout. Borrowed
>+ * pages alias the same physical page on both sides, so their aux is already
>+ * identical and is skipped; only the changed runs are copied, from the source
>+ * at its natural offset to the destination at its packed offset.
>+ *
>+ * Return: The number of CCS copies emitted (or that would be emitted when @bb
>+ * is NULL).
>+ */
>+static u32 emit_ccs_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
>+				u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
>+				struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
>+				pgoff_t start_page)
>+{
>+	u32 npages = src_L0 >> PAGE_SHIFT;
>+	u32 i = 0, pack = 0, nblits = 0;
>+
>+	while (i < npages) {
>+		u32 run = 0;
>+
>+		/* Skip a run of borrowed pages (src and dst alias). */
>+		if (src_tt->pages[start_page + i] ==
>+		    dst_tt->pages[start_page + i]) {
>+			i++;
>+			continue;
>+		}
>+
>+		/* Coalesce a run of pages whose aux must be migrated. */
>+		while (i + run < npages &&
>+		       src_tt->pages[start_page + i + run] !=
>+		       dst_tt->pages[start_page + i + run])
>+			run++;
>+
>+		if (bb)
>+			emit_copy_ccs(gt, bb,
>+				      dst_L0_ofs + (u64)pack * PAGE_SIZE, true,
>+				      src_L0_ofs + (u64)i * PAGE_SIZE, true,
>+				      run * PAGE_SIZE);
>+		nblits++;
>+		pack += run;
> 		i += run;
> 	}
>
>@@ -949,6 +1077,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 					   struct ttm_resource *src,
> 					   struct ttm_resource *dst,
> 					   struct ttm_tt *src_tt,
>+					   pgoff_t dst_packed_pages,
> 					   struct xe_migrate_copy_flags flags)
> {
> 	struct xe_gt *gt = m->tile->primary_gt;
>@@ -981,6 +1110,23 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 	 */
> 	struct ttm_tt *dst_tt = dst_bo->ttm.ttm;
> 	bool skip_borrowed = flags.defrag_copy && src_tt && dst_tt;
>+	/*
>+	 * Defrag-IOVA copy: the destination tt only maps the changed
>+	 * (non-borrowed) pages, packed contiguously into the first
>+	 * @dst_packed_pages pages of its IOVA. The source is read from the old
>+	 * tt at natural offsets and each changed run is blitted into the packed
>+	 * destination prefix.
>+	 */
>+	bool pack_dst = dst_packed_pages != 0;
>+	/*
>+	 * Packed defrag CCS pass: migrate the flat-CCS aux state of the changed
>+	 * pages only, from the source at its natural offset to the destination
>+	 * packed prefix. Borrowed pages share the physical page (and thus its
>+	 * aux) on both sides, so they are skipped exactly like the data pass.
>+	 */
>+	bool ccs_pack = flags.defrag_ccs && pack_dst && src_tt && dst_tt;
>+	/* Per-run, borrowed-skipping defrag emission (data or packed CCS). */
>+	bool defrag_runs = skip_borrowed || ccs_pack;
>
> 	/*
> 	 * For decompression operation, always use the compression PAT index.
>@@ -1009,7 +1155,9 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 	else
> 		xe_res_first(src, 0, size, &src_it);
> 	if (!dst_is_vram)
>-		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
>+		xe_res_first_tt(dst_bo->ttm.ttm, 0,
>+				pack_dst ? (u64)dst_packed_pages << PAGE_SHIFT :
>+				size, &dst_it);
> 	else
> 		xe_res_first(dst, 0, size, &dst_it);
>
>@@ -1030,29 +1178,86 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		u32 pte_flags;
> 		pgoff_t start_page = (xe_bo_size(src_bo) - size) >> PAGE_SHIFT;
> 		u32 ndata_blits = 1;
>+		u32 nchg = 0;
>+		u64 dst_size;
>
> 		bool usm = xe->info.has_usm;
> 		u32 avail_pts = max_mem_transfer_per_pass(xe) / LEVEL0_PAGE_TABLE_ENCODE_SIZE;
>
>+		/*
>+		 * Defrag fast-forward: the new (destination) tt borrows the
>+		 * unchanged beneficial-order chunks from the old tt, so for a
>+		 * large object the bulk of the copy is borrowed pages that alias
>+		 * the same memory on both sides. Skip the entire leading
>+		 * borrowed run in a single cursor stride rather than discovering
>+		 * it one (8 MB) L0 chunk at a time - each such pass would
>+		 * otherwise pay xe_migrate_res_sizes() + pte_update_size() + a
>+		 * full chunk walk only to copy nothing. The non-vram tt cursors
>+		 * are normally advanced by emit_pte(); replicate that with
>+		 * xe_res_next(). In pack_dst mode the destination only maps the
>+		 * changed pages, so its cursor must not advance for borrowed
>+		 * pages.
>+		 */
>+		if (defrag_runs) {
>+			u32 brun = xe_migrate_leading_borrowed_pages(src_tt,
>+								     dst_tt,
>+								     start_page,
>+								     size >> PAGE_SHIFT);
>+
>+			if (brun) {
>+				u64 brun_bytes = (u64)brun << PAGE_SHIFT;
>+
>+				xe_res_next(&src_it, brun_bytes);
>+				if (!pack_dst)
>+					xe_res_next(&dst_it, brun_bytes);
>+				size -= brun_bytes;
>+				continue;
>+			}
>+		}
>+
> 		src_L0 = xe_migrate_res_sizes(m, &src_it);
> 		dst_L0 = xe_migrate_res_sizes(m, &dst_it);
>
> 		drm_dbg(&xe->drm, "Pass %u, sizes: %llu & %llu\n",
> 			pass++, src_L0, dst_L0);
>

Assisted-by: LLM

With above 'continue', this drm_dbg never gets printed, is that fine?

>-		src_L0 = min(src_L0, dst_L0);
>+		/*
>+		 * In pack_dst mode the destination is the (smaller) packed
>+		 * prefix, so it must not clamp the source chunk size; the
>+		 * source drives the walk and the destination is sized
>+		 * independently from the changed-page count below.
>+		 */
>+		if (!pack_dst)
>+			src_L0 = min(src_L0, dst_L0);
>
> 		pte_flags = src_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> 		pte_flags |= use_comp_pat ? PTE_UPDATE_FLAG_IS_COMP_PTE : 0;
> 		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
> 					      &src_L0_ofs, &src_L0_pt, 0, 0,
> 					      avail_pts);
>+		/*
>+		 * The source chunk size may have been clamped above, so derive
>+		 * the packed destination size from the changed-page count of
>+		 * the final chunk.
>+		 */
>+		if (pack_dst) {
>+			nchg = xe_migrate_count_changed_pages(src_tt, dst_tt,
>+							      start_page,
>+							      src_L0 >> PAGE_SHIFT);
>+			dst_size = (u64)nchg << PAGE_SHIFT;
>+		} else {
>+			dst_size = src_L0;
>+		}
> 		if (flags.copy_only_ccs) {
> 			dst_L0_ofs = src_L0_ofs;
>+		} else if (pack_dst && !nchg) {
>+			/* All borrowed: no destination PTEs for this chunk. */
>+			dst_L0_ofs = 0;
>+			dst_L0_pt = 0;
> 		} else {
> 			pte_flags = dst_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> 			batch_size += pte_update_size(m, pte_flags, dst,
>-						      &dst_it, &src_L0,
>+						      &dst_it, &dst_size,
> 						      &dst_L0_ofs, &dst_L0_pt,
> 						      0, avail_pts, avail_pts);
> 		}
>@@ -1072,26 +1277,31 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		 * is split into one command per run of non-borrowed pages, so
> 		 * size for the number of runs actually needed.
> 		 */
>-		if (skip_borrowed)
>+		if (defrag_runs)
> 			ndata_blits = emit_copy_chunks(gt, NULL, 0, 0, src_L0,
>-						       src_tt, dst_tt, start_page);
>+						       src_tt, dst_tt, start_page,
>+						       pack_dst);
>
> 		/*
> 		 * If every page in this chunk was borrowed there is nothing to
> 		 * copy: don't build a batch or issue any GPU commands, just
> 		 * advance the cursors past the chunk. The non-vram tt cursors
>-		 * would otherwise be advanced by emit_pte().
>+		 * would otherwise be advanced by emit_pte(). In pack_dst mode
>+		 * the destination consumed no packed pages, so leave its cursor
>+		 * untouched.
> 		 */
>-		if (skip_borrowed && !ndata_blits) {
>+		if (defrag_runs && !ndata_blits) {

LLM says this 'if' clause is dead code now as defrag_runs will
always have non-zero ndata_blits.

> 			xe_res_next(&src_it, src_L0);
>-			xe_res_next(&dst_it, src_L0);
>+			if (!pack_dst)
>+				xe_res_next(&dst_it, src_L0);
> 			size -= src_L0;
> 			continue;
> 		}
>
> 		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
> 			       ndata_blits * emit_copy_cmd_len(xe)) +
>-			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
>+			(ccs_pack ? ndata_blits * EMIT_COPY_CCS_DW :
>+			 (needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));

We are using ndata_blits returned from emit_copy_chunks to find calculate
the batch size for ccs part. Though it might work, shouldn't we be getting
that from emit_ccs_copy_chunks() with 'bb' set to NULL?

Niranjana

>
> 		bb = xe_bb_new(gt, batch_size, usm);
> 		if (IS_ERR(bb)) {
>@@ -1111,7 +1321,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		else if (!flags.copy_only_ccs)
> 			emit_pte(m, bb, dst_L0_pt, dst_is_vram,
> 				 copy_system_ccs || flags.defrag_ccs,
>-				 &dst_it, src_L0, dst);
>+				 &dst_it, dst_size, dst);
>
> 		if (copy_system_ccs)
> 			emit_pte(m, bb, ccs_pt, false, false, &ccs_it, ccs_size, src);
>@@ -1121,16 +1331,22 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>
> 		if (skip_borrowed)
> 			emit_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0,
>-					 src_tt, dst_tt, start_page);
>+					 src_tt, dst_tt, start_page, pack_dst);
> 		else if (!flags.copy_only_ccs && !flags.defrag_ccs)
> 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
>
>-		if (needs_ccs_emit)
>+		if (ccs_pack) {
>+			if (emit_ccs_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs,
>+						 src_L0, src_tt, dst_tt,
>+						 start_page))
>+				flush_flags = MI_FLUSH_DW_CCS;
>+		} else if (needs_ccs_emit) {
> 			flush_flags = xe_migrate_ccs_copy(m, bb, src_L0_ofs,
> 							  IS_DGFX(xe) ? src_is_vram : src_is_pltt,
> 							  dst_L0_ofs,
> 							  IS_DGFX(xe) ? dst_is_vram : dst_is_pltt,
> 							  src_L0, ccs_ofs, copy_ccs);
>+		}
>
> 		job = xe_bb_create_migration_job(m->q, bb,
> 						 xe_migrate_batch_base(m, usm),
>@@ -1218,7 +1434,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> 				  struct ttm_resource *dst,
> 				  bool copy_only_ccs)
> {
>-	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL,
>+	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL, 0,
> 				 (struct xe_migrate_copy_flags) {
> 					 .copy_only_ccs = copy_only_ccs,
> 				 });
>@@ -1267,7 +1483,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 					 bool need_ccs)
> {
> 	struct dma_fence *fence2, *fence =
>-		__xe_migrate_copy(m, bo, bo, src, dst, src_tt,
>+		__xe_migrate_copy(m, bo, bo, src, dst, src_tt, 0,
> 				  (struct xe_migrate_copy_flags) {
> 					 .defrag_copy = true,
> 					 });
>@@ -1275,7 +1491,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 	if (IS_ERR(fence) || !need_ccs)
> 		return fence;
>
>-	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
>+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt, 0,
> 				   (struct xe_migrate_copy_flags) {
> 				   .defrag_ccs = true,
> 				   });
>@@ -1286,6 +1502,59 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 	return fence2;
> }
>
>+/**
>+ * xe_migrate_copy_defrag_iova() - Copy a defrag move into a packed IOVA dst.
>+ * @m: The migration context.
>+ * @bo: The buffer object being defragmented.
>+ * @src: The source (old) TTM resource.
>+ * @dst: The destination (new) TTM resource.
>+ * @src_tt: The stashed source (old) tt providing the page pointers, fully
>+ *	    IOVA-mapped at natural offsets.
>+ * @dst_packed_pages: Number of changed pages packed into the destination tt's
>+ *	    IOVA prefix by xe_tt_map_iova_copy().
>+ * @need_ccs: Whether the BO has flat-CCS aux state that must be migrated too.
>+ *
>+ * Defrag copy variant for IOVA-mapped BOs where the destination only maps the
>+ * changed (non-borrowed) pages, packed contiguously into the first
>+ * @dst_packed_pages of its IOVA. The source is read from the old tt at its
>+ * natural offsets and each changed run is blitted into the packed destination
>+ * prefix. When @need_ccs is set a second pass migrates the flat-CCS aux state
>+ * of the same changed pages indirectly through their (packed) data mappings;
>+ * borrowed pages share the physical page and its aux, so only the changed runs
>+ * are touched.
>+ *
>+ * Return: Pointer to a dma_fence representing the last copy batch, or an error
>+ * pointer on failure.
>+ */
>+struct dma_fence *xe_migrate_copy_defrag_iova(struct xe_migrate *m,
>+					      struct xe_bo *bo,
>+					      struct ttm_resource *src,
>+					      struct ttm_resource *dst,
>+					      struct ttm_tt *src_tt,
>+					      pgoff_t dst_packed_pages,
>+					      bool need_ccs)
>+{
>+	struct dma_fence *fence2, *fence =
>+		__xe_migrate_copy(m, bo, bo, src, dst, src_tt, dst_packed_pages,
>+				  (struct xe_migrate_copy_flags) {
>+					 .defrag_copy = true,
>+				 });
>+
>+	if (IS_ERR(fence) || !need_ccs)
>+		return fence;
>+
>+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
>+				   dst_packed_pages,
>+				   (struct xe_migrate_copy_flags) {
>+					 .defrag_ccs = true,
>+				   });
>+	if (IS_ERR(fence2))
>+		dma_fence_wait(fence, false);
>+	dma_fence_put(fence);
>+
>+	return fence2;
>+}
>+
> /**
>  * xe_migrate_resolve() - Resolve and decompress a buffer object if required.
>  * @m: The migrate context
>@@ -1301,7 +1570,7 @@ struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> 				     struct xe_bo *bo,
> 				     struct ttm_resource *res)
> {
>-	return __xe_migrate_copy(m, bo, bo, res, res, NULL,
>+	return __xe_migrate_copy(m, bo, bo, res, res, NULL, 0,
> 				 (struct xe_migrate_copy_flags) {
> 					 .is_vram_resolve = true,
> 				 });
>diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
>index 4094ea1c19c1..da066cdf01bf 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.h
>+++ b/drivers/gpu/drm/xe/xe_migrate.h
>@@ -141,6 +141,14 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 					 struct ttm_tt *src_tt,
> 					 bool need_ccs);
>
>+struct dma_fence *xe_migrate_copy_defrag_iova(struct xe_migrate *m,
>+					      struct xe_bo *bo,
>+					      struct ttm_resource *src,
>+					      struct ttm_resource *dst,
>+					      struct ttm_tt *src_tt,
>+					      pgoff_t dst_packed_pages,
>+					      bool need_ccs);
>+
> struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> 				     struct xe_bo *bo,
> 				     struct ttm_resource *res);
>-- 
>2.34.1
>
