Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAA606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h/GONwBS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17433112CF1;
	Fri, 27 Nov 2026 18:18:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3298112CD9;
 Fri, 27 Nov 2026 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795803486; x=1827339486;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=TdUjlpYdldSbH9dT1xLtfjPP20o+7L8EDQ+h/ZYedBg=;
 b=h/GONwBSR0RQIV92sF/N2oizwTsrYan8xuPy5M30ov2fDSlYOZtO5dEB
 G4pmCJFrE+HwcPCWfyte4uK7yUHUN2o7wADvUo9ng4FLlG53KOjWKBTIp
 no4ApwXTeeXV130aUWjEob4hpYFmI6AEaYjxJiK7sog6OFL5LGH469LIK
 /8pZn9gFyJA71sbwizzOEakht22+zAL/Qs3J9W45cMST9HT1MJROxMbc1
 565pTGDD7xXQtaEdVuzmrH5ptDydbF2k4FZq3Rr56ptWhQQH5OmOmyI7S
 L11Ww9zbepOv7ij6rj8F5HyYjQKaM6Z2XPt7rIJw3WunXNKku57nwwte7 Q==;
X-CSE-ConnectionGUID: w6WZgVBnREKJfPVJkEHa0w==
X-CSE-MsgGUID: vVU2B2BRRWG+TC8gEkjk+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4571726"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4571726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:18:05 -0800
X-CSE-ConnectionGUID: z1CN4bKWRnmo2ethcf3fMw==
X-CSE-MsgGUID: KlLmIGXNQKGM/KnM/84aPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12231134"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:18:05 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:18:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:18:04 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:18:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFG9ExuOShxhioMdlPtQYKBHo/TLPQQb9n833qnoQ4fm5Jr9Nna+OXFykIMXMhgZepqRAvvBlqcAvEK8/YZs/HoBgPnYXTmK7OpN+9VaV7G+dtFSJdk09WHZUyCu/qMtP9eUh8Q8ZNxVcEiOD3QGKGYgrIzB1C/Ihag/0M1WkqqX3vbCMprbdCplfb6jTQauUPUKhAmPtnnAY+bwFc4R1D2W3ef4xdt+QOxeFxhIdQoE+QHl0wqoynF7HfCc6tvUgsUfs3ZbKTUvje5JZmmKxwiM3638yuinsYMT1y6PWZXsImhBcHmrv9CfAZ9eTeh8rWEI0FqkfIpJcbOrKEHGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DetxPl0XYT8OCQ96b4wBOket0icoNv+rnpir5qywBsA=;
 b=JSAFl+P6GFvsGgiEFSGJF9oavS3PB+qWiXQJTqQvtan0GX103MVde/2FNeeGMVd8Rfa4aW4aoiveoLiWFP+X+hRmp0xcf+qp5/ZAsy80mXgvWE/E4gLb2jbnxbQt/sVc73bl31Xu5nhPzOXyg5Qmbvw2MukBvbPQivaogkH3I/3AeKkWi9CVjWFQKdv+w4pGd2+9ntfWcfgWGrwJrYsSdXV4c/7z9GsBXVdVn7XCzxzubJ/6QWWCBEh+w9u3GHcx2QkJppISyPwhWUzaeaY78ExPCSo8lxffLHPNPsCcU5nLFz1YxN8s6rKqNFQLkwJlACpw+XN5F4PIsllJ0dU6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:18:02 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:18:01 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "Riana Tauro" <riana.tauro@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v6 2/3] drm/ras: Add retired-pages node type
Date: Fri, 27 Nov 2026 13:17:53 -0500
Message-ID: <20261127181750.806528-7-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127181750.806528-5-rodrigo.vivi@intel.com>
References: <20261127181750.806528-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::8) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2c4629-9a03-40f7-0686-08df4cb2c5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261102130727099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Bn2kyJonaE0qbWkRJaqkUhicqGeVS9L4s6aQQJbvirAJIukFrdLVJDKi6NxNI0hO9RJfYWQTg6/u7u94Fodohuj2AoXH9boEZJmMy+nfuwpESbcUT4tZsxXuq9TBeAqOQutV6PgYZv+LTr5o/XW1Yoymt1Y0kF9pouQlkI5Bt8GH0yiRn5XzmjetfDH91b8xEEe9MtKC0PQE2BWem+LlkCgHlSkYnYllwHazJ0xVCQ1tyjTbJ0VWYjVs0IDESdUtjO4F/aiuRl42/38jJukkElFR3Bo5RD4lYTN7ah58JPD+G9/f2Dlb/DrOvvViHXzDHjuEi8n7ZV+AxlUIRIbmJErM3RL3Lnmwmg+cQRX6Vw26fzS8iGSsJvdw8X+1hAzQ3vFDB6XJ5GYbviRAPcmnESyt/HgYrxyim34ycJsz6D7ay9ogqA+ux69g691YMx1UmGIQtzRIr1NCC90DvfkuhslEOutGOpYspAK0qb53wJWx8KgcugDncVt+TiWNCHBDxTJj0vPA989Q2n380HpVEnuuCdw/PNmXnYgWFA71Xp70jVJ0UF6ywZBoyEeMHJ8A73RmBjb1oUVfMmlUeosu4JARghYJ8YyJmg5aTbZy2Y9LDULXg9sv0u53xpM47AioYN5691NYQPzzbpxKZuavYA5/S0w0d5tPDiw5xfZmdCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102130727099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plXwWR+IA6bvXZa4Mrj3tZ0SlF6p2OsKRhWaFCaEzyLzrNCKLsylmACbnxAL?=
 =?us-ascii?Q?8HYmv1EGwobDd6Sr8ZMLI6dPzDW6+ZB53rSUYig+dGxVrGWi/SKI68PKXbXv?=
 =?us-ascii?Q?d01Iz8v/Rs07iI6fS2Q4ga+/Pg8d/EXIIDL1u8AGai2TQeC278PX7MDvFbG8?=
 =?us-ascii?Q?pk7GroAeGjhByKTxIBofnGQDLjopKw5mieDq3i4Q57ig6+weZ/yCqqM2O050?=
 =?us-ascii?Q?XNY5iMO03Iud61eaisVCSkckKf+EP6hH87kwDOuRea6gWvElvAcDiX2C6SJI?=
 =?us-ascii?Q?iILHyMETCd2WTDl1QF9EJTuFEYmijgzZuhpi/0U8Ao7HqxMJKukAelpFHnYO?=
 =?us-ascii?Q?oEpyHxMGIwTDqUMLEGW2+2qP7U4cI2gY6ZwUKeXmTYZ7QAyDqmcjUPYHBS14?=
 =?us-ascii?Q?cNy77NhcRdua53DweN150y/6N1TOVMVU2vN6oM22Ufpq8fSSmrrjAUt8rb3c?=
 =?us-ascii?Q?dnexighbbgGlJrUHJ2nKhRS82NZp8Jnno1H4dHhhvOLfk4jLbdWr+ZI/5biY?=
 =?us-ascii?Q?YukNHFXsEL4filTes5cBs3qPbxqfbZA5r3F8DxEr+QrIKSoeImHacGpNxSD1?=
 =?us-ascii?Q?OWdAyFRalpsPar5VJfyvMTmD52k+KK9O6eJINO3L6o9XlO21cwXA6Bh3he+B?=
 =?us-ascii?Q?D2Suq74zNK4x8E1s1jUZ9jIprcqEOX7KMwalRhTMOY/F4s322LletXKbHPrC?=
 =?us-ascii?Q?SuWrczfZgBIVto1VEYkMsFuPPd9LjtzgI5lR7Xelt6UisBdz5NX5t2ttH3di?=
 =?us-ascii?Q?9xDz8xpxB+LHrYZjMujR+vMuUpWDjJ3luFexfMSmlIwXnlnkpJvtQRjiLxwK?=
 =?us-ascii?Q?M72y1ZylzNmqbmAiKK0pKOL/jVur/h3HZyPoAgsfxwB4Xlm8mU+dw2S5tGZj?=
 =?us-ascii?Q?NRBzBRzT32zWNOj/+6IX9LnM9LK51v5mIkshu9CWUzHE6bZZzAPuc6DzvHs6?=
 =?us-ascii?Q?2sf1HIYevyQ7zKfqE9di6Algl7fEIdd7bWeqF52DGEyy29Ch9umA4oxQ5pbT?=
 =?us-ascii?Q?iNAEPuABJq2kVaV9l08iSpLKClGIgOlWPiHiYtww2TmNHMijP7XP79AQeHBF?=
 =?us-ascii?Q?Z0fZltfNNZtqOZ86TJeSqBzNgS9U2jAUpHVP6imFmhWjRVA3cbegsnEs5/Fy?=
 =?us-ascii?Q?iU04HhyR77PnyCMCvfc6jU/t+mmZCm2Jti8F6Mo86w31wMI51ykJD9pT/EZa?=
 =?us-ascii?Q?LG6EZjfg/x7ttHwFA5oTSnrtVYN1TI2yX2zpfVjv+7NgxWdE50bkUqrQTv01?=
 =?us-ascii?Q?UUTBdfFV2KlFurihQn+DWUYFALD+P2TfOLmIXCOw3hgfhbrgCanMjcPtip69?=
 =?us-ascii?Q?rT1d9FoY4tiaS4/ns65xieNDNeoUIwm2ioVciZMMM4hR2SkmoryIsmir3qYs?=
 =?us-ascii?Q?ap33jSYGwVPfVQoFnvXywoqP6BG/z45vR6Wvobhw5oXTsiiN238nPQj6f3km?=
 =?us-ascii?Q?H77bLmU2HkZxGCV4Qf2aeFa/GnTNXXHEbVBBivGSScrINOWolrNXVYwnB6Tz?=
 =?us-ascii?Q?g6FwgKcw1rTRtnr2BIzNXBEQTAko50XM7PT++DXCmGfg7+9EzoN2YKEOq8kO?=
 =?us-ascii?Q?Qe4PkXK7gWPhhdAiT5KAOfEgsESuVmbkw8Bh2Zm5c08NQAS4gMh6nyW5LMzU?=
 =?us-ascii?Q?kwdDVENFBLlnciM1sAXXrGLH1bl0yREWLsB82jlVlyckRcMgh9B2Fsz93kqZ?=
 =?us-ascii?Q?ivWhlQvGHAQDIm8Hzcc+iMIFrbztPfW8cDTCRYRDJ0POgqapuDTUaagaNK5D?=
 =?us-ascii?Q?9KaVV218qQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: lQSlMGtaheijR4Gwwcia7DOZ58n49xOVpsJx5vTB6GuqJfQM2qUP3pBtWAcA+05bKHx5HFa5+Z3irKK9Fhkb81vPYsKM/mPa+MN9gEHJPD9GWc4ivs6WHgQrjkQSjfHJBMHUOVltunTn9TVSZBsfdZyNEzGB0Y0+7MFSKmv5c/smLmiHsv4ry9cTMxPLCTC4HQ8FJYCY72gqHxaRsDXYhpp+KuUL1BCTQD5byX2Cyf25+hsLyWRKkDN1AnkGAoGPNWT6CZJIl6FUdTFlCj6lhQ23giTgVevFVyBikOimDjyuKxhEZ4gaLF8EqfvPdIB8cT+SY4gtuZNiVx3nWzt1pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2c4629-9a03-40f7-0686-08df4cb2c5b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:18:01.8525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAzwQRsjnFxRlVbE1arN9hEi1AmAPJM7Te730D4rg9E3fnP3z5ZEPLW81hJjTvI7GUZwh9iC+4Okzxv9QY5Dog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Add a retired-pages node type to drm-ras so drivers can report the
memory pages they have taken out of service, with two operations:

 - get-retired-pages: dump one entry per page with its address, size
   and status (retired, pending or failed). The list is read once, when
   the dump starts.
 - get-retired-pages-info: return the maximum number of pages that can
   be retired.

v3 (Rodrigo+LLM):
 - Split the drm-ras core from the xe user.
 - Flatten the page attributes and name the node type retired-pages
   instead of retired-resources, avoiding the over-wrapping
   anti-pattern pointed out by Jakub: the type-specific nest and the
   resource-type enum are gone.
 - Use uint for address, size and max-pages, no pad (Jakub).
 - Start the status enum at 1.
 - Move max-pages to its own do operation instead of a leading dump
   entry.
 - Set NLM_F_DUMP_INTR from a driver generation counter.
 - Report unknown node IDs with NL_SET_BAD_ATTR.
 - Removed deprecated Assisted-by tag.

v4 (Rodrigo+LLM):
 - Check the dump consistency once a page message is filled (Sashiko),
   and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
   not lost.
 - Make the error-counter operations reject other node types (Sashiko).
 - Hold a node reference in the new handlers (local Sashiko).
 - Rebase on the telemetry node type, moving the type check of its
   handlers into drm_ras_node_get().

v5 (Rodrigo+LLM):
 - Split the node and callback checks in the clear-error-counter doit,
   and write the new handlers like the error-counter ones, with
   put_node labels and an inline dump loop, for consistency (Riana).
 - Drop node-id from the dump entries (Riana).

v6 (Rodrigo+LLM):
 - Take a snapshot of the retired pages when the dump starts, instead of
   asking the driver for each page, so large lists are dumped in linear
   time. The snapshot is consistent, so NLM_F_DUMP_INTR and the
   generation counter are gone (Riana).
 - Move the type check of drm_ras_node_get() to its own patch (Riana).
 - Let drm-ras own the snapshot array, which drivers fill with
   drm_ras_retired_pages_add(), and do not sort it (Riana).
 - Pass the info to the driver in a struct, so it can grow, and drop
   node-id from the get-retired-pages-info reply (Riana).
 - Document each retired-page-status value, which also documents them
   in the uAPI header, and reword the max-pages and info docs (Riana).
 - Name the dump hooks pre/post like the other drm-ras ones, and use
   struct nlattr for the message headers (Riana).

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  78 ++++++-
 drivers/gpu/drm/drm_ras.c                | 252 ++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  26 +++
 drivers/gpu/drm/drm_ras_nl.h             |   6 +
 include/drm/drm_ras.h                    |  68 ++++++
 include/uapi/drm/drm_ras.h               |  34 ++-
 6 files changed, 454 insertions(+), 10 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 0f1ceb705d3d..7cab42685568 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,16 +16,33 @@ definitions:
     type: enum
     name: node-type
     value-start: 1
-    entries: [error-counter, telemetry]
+    entries: [error-counter, telemetry, retired-pages]
     doc: >-
          Type of the node. The error-counter nodes expose reliability counters
-         for a hardware/software component, and telemetry nodes expose an
-         interface for reading and writing telemetry values to a device.
+         for a hardware/software component, telemetry nodes expose an
+         interface for reading and writing telemetry values to a device, and
+         retired-pages nodes list the memory pages that have been taken out
+         of service.
   -
     type: flags
     name: telemetry-field-mode
     entries: [read, write]
     doc: Bitmask of access modes supported by a telemetry field.
+  -
+    type: enum
+    name: retired-page-status
+    value-start: 1
+    doc: Status of a retired page.
+    entries:
+      -
+        name: retired
+        doc: The page is reserved and out of service.
+      -
+        name: pending
+        doc: The retirement is queued, but the reservation is not complete yet.
+      -
+        name: failed
+        doc: The reservation failed, and the page may still be in use.
 
 attribute-sets:
   -
@@ -140,6 +157,30 @@ attribute-sets:
         doc: >-
              Bitmask of access modes (read/write) supported by the
              telemetry field.
+  -
+    name: retired-page-attrs
+    attributes:
+      -
+        name: node-id
+        type: u32
+        doc: Node ID targeted by this retired pages operation.
+      -
+        name: address
+        type: uint
+        doc: Device address of the retired page.
+      -
+        name: size
+        type: uint
+        doc: Size of the retired page in bytes.
+      -
+        name: status
+        type: u32
+        doc: Retirement status of the page.
+        enum: retired-page-status
+      -
+        name: max-pages
+        type: uint
+        doc: Maximum number of pages that can be retired.
 
 operations:
   list:
@@ -287,6 +328,37 @@ operations:
             - field
             - field-name
             - mode
+    -
+      name: get-retired-pages
+      doc: >-
+           Retrieve the pages retired on a retired-pages node, one entry per
+           page. The list is read once, when the dump starts.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      dump:
+        pre: drm-ras-nl-pre-retired-pages
+        post: drm-ras-nl-post-retired-pages
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - address
+            - size
+            - status
+    -
+      name: get-retired-pages-info
+      doc: >-
+           Retrieve the retired pages info of a retired-pages node.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - max-pages
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 5ae6d0a3b751..618b6a44c95b 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -69,6 +69,14 @@
  *     Each field contains the uAPI defined enum string, its numerical value,
  *     and its mode bitmask, which encodes read/write capabilities.
  *
+ * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
+ *     Userspace must provide Node ID.
+ *     Returns one entry per page with its address, size and status.
+ *
+ * 12. GET_RETIRED_PAGES_INFO: Get the retired pages info of a given node.
+ *     Userspace must provide Node ID.
+ *     Returns the maximum number of pages that can be retired.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -121,6 +129,13 @@
  *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
  *       to enforce permissions checks on telemetry operations.
  *
+ * - RETIRED_PAGES:
+ *     + The driver must implement the query_retired_pages() callback, adding
+ *       each retired page of the node to the snapshot of the dump with
+ *       drm_ras_retired_pages_add().
+ *     + The driver can implement query_retired_pages_info() to report the
+ *       maximum number of pages that can be retired.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -147,10 +162,26 @@
  * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
  *   dumpit operation, enumerating all telemetry fields and their supported
  *   access modes for a telemetry node.
+ * - drm_ras_nl_pre_retired_pages(): GET_RETIRED_PAGES dump start operation,
+ *   taking a snapshot of the retired pages of a specific node.
+ * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
+ *   operation, listing the retired pages of the snapshot.
+ * - drm_ras_nl_post_retired_pages(): GET_RETIRED_PAGES dump done operation,
+ *   freeing the snapshot.
+ * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
+ *   doit operation, fetching the retired pages info of a specific node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
 
+/* State of a GET_RETIRED_PAGES dump */
+struct drm_ras_retired_pages_ctx {
+	/* Snapshot of the retired pages, taken when the dump starts */
+	struct drm_ras_retired_pages snapshot;
+	/* Index of the next page of @snapshot to dump */
+	u32 next;
+};
+
 /*
  * Per-command netlink context. Overlaid on the callback storage (cb->ctx) for
  * dumps and on genl_info (info->ctx) for doits. @node pins the node targeted by
@@ -162,6 +193,8 @@ struct drm_ras_ctx {
 	unsigned long restart;
 	/* Node targeted by a telemetry get/set doit */
 	struct drm_ras_node *node;
+	/* State of a retired pages dump */
+	struct drm_ras_retired_pages_ctx retired;
 };
 
 static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
@@ -704,19 +737,23 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
 	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
-	if (!node || !node->clear_error_counter) {
-		drm_ras_node_put(node);
+	if (!node)
 		return -ENOENT;
+
+	if (!node->clear_error_counter) {
+		ret = -ENOENT;
+		goto put_node;
 	}
 
 	if (error_id < node->error_counter_range.first ||
 	    error_id > node->error_counter_range.last) {
-		drm_ras_node_put(node);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_node;
 	}
 
 	ret = node->clear_error_counter(node, error_id);
 
+put_node:
 	drm_ras_node_put(node);
 
 	return ret;
@@ -785,6 +822,208 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	return ret;
 }
 
+static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
+{
+	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
+	struct drm_ras_node *node;
+
+	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
+	if (!node)
+		NL_SET_BAD_ATTR(info->extack, attr);
+
+	return node;
+}
+
+static int msg_put_retired_page(struct sk_buff *msg,
+				const struct drm_ras_retired_page *page)
+{
+	int ret;
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
+	if (ret)
+		return ret;
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
+}
+
+/**
+ * drm_ras_retired_pages_add() - Add a page to a retired pages snapshot
+ * @list: Snapshot passed to the query_retired_pages() callback
+ * @page: Retired page to add
+ *
+ * Return: 0 on success, or -ENOMEM if @list cannot grow.
+ */
+int drm_ras_retired_pages_add(struct drm_ras_retired_pages *list,
+			      const struct drm_ras_retired_page *page)
+{
+	struct drm_ras_retired_page *pages;
+	u32 capacity;
+
+	if (list->count == list->capacity) {
+		capacity = max(16U, 2 * list->capacity);
+		pages = kvrealloc(list->pages, array_size(capacity, sizeof(*pages)), GFP_KERNEL);
+		if (!pages)
+			return -ENOMEM;
+
+		list->pages = pages;
+		list->capacity = capacity;
+	}
+
+	list->pages[list->count++] = *page;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_ras_retired_pages_add);
+
+/**
+ * drm_ras_nl_pre_retired_pages() - Take a snapshot of the retired pages
+ * @cb: Callback context for multi-part dumps
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int drm_ras_nl_pre_retired_pages(struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+	struct drm_ras_node *node;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	ret = node->query_retired_pages(node, &ctx->retired.snapshot);
+	drm_ras_node_put(node);
+	if (ret)
+		kvfree(ctx->retired.snapshot.pages);
+
+	return ret;
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Appends one message per retired page of the snapshot. The dump resumes from
+ * the next page after a buffer overflow.
+ *
+ * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
+ *         (requires multi-part continuation), or a negative error code on
+ *         failure.
+ */
+int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+	struct nlattr *hdr;
+	int ret = 0;
+
+	for (; ctx->retired.next < ctx->retired.snapshot.count; ctx->retired.next++) {
+		hdr = genlmsg_iput(skb, info);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+
+		ret = msg_put_retired_page(skb, &ctx->retired.snapshot.pages[ctx->retired.next]);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+
+		genlmsg_end(skb, hdr);
+	}
+
+	return ret;
+}
+
+/**
+ * drm_ras_nl_post_retired_pages() - Free the retired pages snapshot
+ * @cb: Callback context for multi-part dumps
+ *
+ * Return: 0.
+ */
+int drm_ras_nl_post_retired_pages(struct netlink_callback *cb)
+{
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+
+	kvfree(ctx->retired.snapshot.pages);
+
+	return 0;
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_info_doit() - Query the retired pages info of a node
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info)
+{
+	struct drm_ras_retired_pages_info pages_info = {};
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	if (!node->query_retired_pages_info) {
+		ret = -EOPNOTSUPP;
+		goto put_node;
+	}
+
+	ret = node->query_retired_pages_info(node, &pages_info);
+	if (ret)
+		goto put_node;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, pages_info.max_pages);
+	if (ret)
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	drm_ras_node_put(node);
+
+	return genlmsg_reply(msg, info);
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+put_node:
+	drm_ras_node_put(node);
+	return ret;
+}
+
 /**
  * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
  * @ops: Generic netlink operations
@@ -1102,7 +1341,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	if (!node->device_name || !node->node_name)
 		return -EINVAL;
 
-	/* Currently, only Error Counter and Telemetry endpoints are supported */
 	switch (node->type) {
 	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
 		/* Mandatory entries for Error Counter Node */
@@ -1114,6 +1352,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
 		if (!node->telemetry_get || !node->telemetry_fields)
 			return -EINVAL;
 		break;
+	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
+		if (!node->query_retired_pages)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 589c6445eff7..3fadd8742760 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
 	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
+static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
+static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -126,6 +136,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
+		.start		= drm_ras_nl_pre_retired_pages,
+		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
+		.done		= drm_ras_nl_post_retired_pages,
+		.policy		= drm_ras_get_retired_pages_nl_policy,
+		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
+		.doit		= drm_ras_nl_get_retired_pages_info_doit,
+		.policy		= drm_ras_get_retired_pages_info_nl_policy,
+		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 7a1cba70fd50..9d6c43279eb1 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -17,6 +17,8 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
 void
 drm_ras_nl_post_telemetry(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info);
+int drm_ras_nl_pre_retired_pages(struct netlink_callback *cb);
+int drm_ras_nl_post_retired_pages(struct netlink_callback *cb);
 
 int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb);
@@ -34,6 +36,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
 int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
 int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
 					    struct netlink_callback *cb);
+int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info);
 
 enum {
 	DRM_RAS_NLGRP_ERROR_REPORT,
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 76bdcc6f96a5..26bc9006f0d7 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -28,6 +28,41 @@ struct drm_ras_telemetry_field {
 	u32 mode;
 };
 
+/**
+ * struct drm_ras_retired_page - A retired page reported by a driver
+ */
+struct drm_ras_retired_page {
+	/** @address: Device address of the page. */
+	u64 address;
+	/** @size: Size of the page in bytes. */
+	u64 size;
+	/** @status: Retirement status (enum drm_ras_retired_page_status). */
+	enum drm_ras_retired_page_status status;
+};
+
+/**
+ * struct drm_ras_retired_pages - A snapshot of the retired pages of a node
+ *
+ * Owned by drm-ras. Drivers only add pages to it with
+ * drm_ras_retired_pages_add().
+ */
+struct drm_ras_retired_pages {
+	/** @pages: Array of the retired pages. */
+	struct drm_ras_retired_page *pages;
+	/** @count: Number of pages in @pages. */
+	u32 count;
+	/** @capacity: Number of pages @pages can hold. */
+	u32 capacity;
+};
+
+/**
+ * struct drm_ras_retired_pages_info - Retired pages info of a node
+ */
+struct drm_ras_retired_pages_info {
+	/** @max_pages: Maximum number of pages that can be retired. */
+	u64 max_pages;
+};
+
 /**
  * struct drm_ras_node - A DRM RAS Node
  */
@@ -184,6 +219,34 @@ struct drm_ras_node {
 	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
 			     s64 *status);
 
+	/* Retired-Pages Related Callbacks */
+
+	/**
+	 * @query_retired_pages:
+	 *
+	 * This callback is used by drm-ras to take a snapshot of the retired
+	 * pages of a node. It must add each retired page of the node to @list
+	 * with drm_ras_retired_pages_add().
+	 *
+	 * The @query_retired_pages is a mandatory callback for
+	 * retired_pages_node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_retired_pages)(struct drm_ras_node *node,
+				   struct drm_ras_retired_pages *list);
+
+	/**
+	 * @query_retired_pages_info:
+	 *
+	 * This callback is used by drm-ras to query the retired pages info of a
+	 * node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_retired_pages_info)(struct drm_ras_node *node,
+					struct drm_ras_retired_pages_info *info);
+
 	/** @priv: Driver private data */
 	void *priv;
 
@@ -209,12 +272,17 @@ int drm_ras_node_register(struct drm_ras_node *node);
 void drm_ras_node_unregister(struct drm_ras_node *node);
 int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
 			   u32 value);
+int drm_ras_retired_pages_add(struct drm_ras_retired_pages *list,
+			      const struct drm_ras_retired_page *page);
 #else
 static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
 static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
 static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
 					 const char *error_name, u32 value)
 { return 0; }
+static inline int drm_ras_retired_pages_add(struct drm_ras_retired_pages *list,
+					    const struct drm_ras_retired_page *page)
+{ return 0; }
 #endif
 
 #endif
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 56e0588af5d5..834741da2459 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -12,12 +12,14 @@
 
 /*
  * Type of the node. The error-counter nodes expose reliability counters for a
- * hardware/software component, and telemetry nodes expose an interface for
- * reading and writing telemetry values to a device.
+ * hardware/software component, telemetry nodes expose an interface for reading
+ * and writing telemetry values to a device, and retired-pages nodes list the
+ * memory pages that have been taken out of service.
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
 	DRM_RAS_NODE_TYPE_TELEMETRY,
+	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
 };
 
 /*
@@ -28,6 +30,21 @@ enum drm_ras_telemetry_field_mode {
 	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
 };
 
+/**
+ * enum drm_ras_retired_page_status - Status of a retired page.
+ * @DRM_RAS_RETIRED_PAGE_STATUS_RETIRED: The page is reserved and out of
+ *   service.
+ * @DRM_RAS_RETIRED_PAGE_STATUS_PENDING: The retirement is queued, but the
+ *   reservation is not complete yet.
+ * @DRM_RAS_RETIRED_PAGE_STATUS_FAILED: The reservation failed, and the page
+ *   may still be in use.
+ */
+enum drm_ras_retired_page_status {
+	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
+	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
+	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
+};
+
 enum {
 	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
 	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
@@ -73,6 +90,17 @@ enum {
 	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
+
+	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -83,6 +111,8 @@ enum {
 	DRM_RAS_CMD_TELEMETRY_GET,
 	DRM_RAS_CMD_TELEMETRY_SET,
 	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
+	DRM_RAS_CMD_GET_RETIRED_PAGES,
+	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.56.0

