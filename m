Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCA606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YUvTF0iw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k0Mrnaf0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B8810E0CA;
	Wed, 25 Nov 2026 20:08:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2031810E012;
 Wed, 25 Nov 2026 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795637296; x=1827173296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=jL8/RafQuINZN6O5uYDDvq3A+Hb1vTruOmTxRcqIF8M=;
 b=YUvTF0iwcrSJwikX3H5cLs0zVh55c087UAUJTGOKAwd8SFRGuDCohFcM
 WJs/yvT3hBPk9QEereaMGZSQC/XXQwd9xsa3f9cqrluJjp01yA3EPk2oP
 nuMGY6GByOqGKayl6KE+1IyRIhx3TRFkZ/KrPM1qMxGGGudIbdI+Vt+h0
 C71LFHrX1Ia713UOLX/lBKLMHc+riqfPhTKF0FTHbGbrQqG7WUzHheMzG
 ID8BupgGpc+O2iP/DamNKJ/cUrweqaeqRSBRd7z00RtAN5cEN4WIztBj/
 oyRkVv0QOtGQ5zDAwFE+vD6TUJPaV5RBV6hsE56SkJyzGGaO4RNQAJ4zQ Q==;
X-CSE-ConnectionGUID: 5K0g+9sKTeeoTaomcYeVuQ==
X-CSE-MsgGUID: CGg+d05aQDuFFEFc1TFV9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4499538"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4499538"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 11:03:02 -0800
X-CSE-ConnectionGUID: GITwRggiRwK4yeYUEG8GQQ==
X-CSE-MsgGUID: Tk/ro8fCTeyiLYOyU35/vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="13981062"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 11:03:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 11:03:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 11:03:01 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 11:03:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d05miuuECon6Ljavr1LDEPEkBd2kWxKNj6Y8u/e2IJPnC3yAjVG2BBrA3qEbA0FQP6xU45cxvRkT5apN8ojC4ssoj4eCZz/dLtxy/9YvdkrHwKaLEC9olOtMBk+TC4PhmP97oB4YrXEQsCN3EbLiHI6uRpFXsxchgfJEMCu8sXR0IfmGW1GFEngNXvdProLHWkmZM8xduq4adcBC1KqeFAMEpiKnGv4ZOQRmKFgdGyGclGqEZc8dLYAJqjMTi7THPeKVMBvqorPouBrLcr3SbPNaU1SZDUQmaH1ZGCtmUPL4btyc6gCcWuG0DEdEMVVf70cYDlg0UNJhCQUxK8wYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtI7/To2LHFrhluKBnmFgs49458YaotP/QweTMxsWjA=;
 b=NdtbdmtBuOsQVA/6PIRXu/iDzpjTy/5mS1e+ULjmxUrXT5phkvFmGH9NdZxPqmliIcu1JK78XUUD434sfy1zuD2DzawTh+TcARge656caJiyIPa8eeoAZXwaKx7tGj8FDziVhKWpbFLM5ahFb4MuarZk9P3QhXyuIRaNmBVox8ZcW7RTVhsN3Y19zgjqizxGEpnDuJlQKbFmiFqVNLvcpvFxZiIQz8dan5l8lPsk53KbOXZl1DTbBLClBMVtC9V2YpBySjtVNyhk4lakmojphJxUZaUHD68FlCKAhG9DgYU/t618V7GwnUDGpqD/EEvz9XSu0zcyjPBJx56LSFORoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtI7/To2LHFrhluKBnmFgs49458YaotP/QweTMxsWjA=;
 b=k0Mrnaf0BUcInP54/aUsC3B/HMzdgzYHjNig0siPX5TmmrvgCT1fcYHstZ6wn2NEfRC+IEr2H/iHBd2F85Ie7WcLD11mW9fTiQQb8jYe1RCjOBmczb5G9t550XtxEkccy2jbqYADdiJaikzra2M2R2qXvwzVZH30MgrM5Z7r5uE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 19:02:58 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 19:02:58 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "Riana Tauro" <riana.tauro@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v5 1/2] drm/ras: Add retired-pages node type
Date: Wed, 25 Nov 2026 14:02:51 -0500
Message-ID: <20261125190249.156217-5-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125190249.156217-4-rodrigo.vivi@intel.com>
References: <20261125190249.156217-4-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bb31bf-1953-4a87-a80e-08df4b26b844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|261022075727099003|261022105027099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: iVLcAjhY1SEFrIEwsclY9vfZhz00hYuMNelg9jbG90IBwPGbPsyu4IaWqUAZBNbrIrCCbvCFnlsM9bVBSLrlrtTs7pNDi4y04H/vCwYmHUpAbSg/TjGp2AZD/affE7RZ44RkuEc83WppCSjbU9db/LubSQqU76ICwWk07urSngL/XCc+oe2CdduSrGV4ccKVe76v2CetCF/WQM4+p7NKUjipbhp7wEmUT2dorq/GQVcREiwH0xl5n1k7gX9wwpuGC/2LlYkQvnZhmabCRGoKy6tahgd6gbqZL5nTnX/wYw1M93ob2NFvjoyi2ALCWAMHi7iFy/xrfw/EYqPbudFiaVATPu8HeEGvp4p++cbfHH++4izcCTrgqK/BPDOuuazYOIcsUWczaUYr6W4dv7rFBzbOePcdOByWhLBNIrLxtiQgzIbLI7IGzi/lsBpbIdy6dtAr1er7F3pcxaCwgF5+5B2gc565omJdD0k8AtTzS51soglZgBJFtqM+lGRuv6bGFm51hUX9ayHSFHtj/MVfCXk0Tc55VKBq3Gl1RfVWg6azoaOq+U7TtERwNEjBfch3Nzystot9U6zf4OVEuM5aXeQIqpqg57aOCtynBxplkGANzRW4PLpbY9h64ER/zjTYefAMid5DbARRefZ5UXsizN19oLdTtYMY94hYiG2iSGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQfCwYUG/Y9H+eEJLKiXYo/PZ4RbAlBIgwgffiRpVFC1MtsAe8JFUn0sChRI?=
 =?us-ascii?Q?lyz0smOYbYNI3QWnNOOE+Xh3WABELAm3nBbsUFGVAhIfzxg6rwO6BuyJCbR4?=
 =?us-ascii?Q?xpB2GlEFB1GPwGHQFc2jenHuu+kN06d6YiGumBNv+pwCkWuEVdql2h9B0xZg?=
 =?us-ascii?Q?Zj95zpmxg3THJW6A2Jah+MvLBJtU6rwiyilNbgMUqMPtUb5NpNx1GKIqpg8s?=
 =?us-ascii?Q?mZsnqFPoNVVboxBhERW98Psc5xQyJXeFsXxXbBLS8B+uRIoAtthfzjikEc1/?=
 =?us-ascii?Q?mx+do+dXEb7RJujelXhrMKyQpYXEeP7kIEDBxbaMSiOR9HyTrmHbgOdtPOfI?=
 =?us-ascii?Q?PZ/KVXONECUQcQ4LLQOUqgu1fGePPdlgjnxCa1oWDHNSH21nWB23Fi4FY9CX?=
 =?us-ascii?Q?cY6U6g0P+qOjjnQCW/K1Qh6vmU6dHEpQHqRBcSJtwz3S/d26KSxywEXNDfPP?=
 =?us-ascii?Q?PDap+EnCuZIZtDXWjBwfXAjjYVfbaj44Q0/ruDNHYgtmE22ZLKOFEihd0133?=
 =?us-ascii?Q?01AAWP+VkeFomxcVcZeRR+/NwLpX68pCljHxJDzm5CPY2p//6JVDJF1zNvOV?=
 =?us-ascii?Q?/UwBFUXFXLM/225TEZ2gCSj/Py7ecFqYWYtJx7i0R7eTpKVi6SeLKxn2wzN0?=
 =?us-ascii?Q?bXalMKwMG34/G610mhlPoXmeOFE8ch1WtJmU0ZjV11NGMc85vrSK1MVS4sRC?=
 =?us-ascii?Q?4J4WjhMSCnZ4Tl41/RCdCMqJo7n3reAQ3/eDE6inQ7hSM84BBtZw9RyRa82L?=
 =?us-ascii?Q?6yTiF2F2BSw9j0sAVWEf4iqbll5cWf9oEQmqAQ0VGQ9toIYSrGR4/A44bnT7?=
 =?us-ascii?Q?l1KQxfAeda7hPbFDVmcYa9QhicH/2KxJ0nun+4yBhyw+D3iP/FemIawyz4yZ?=
 =?us-ascii?Q?n7ao2xvlFsH8aFTMaSJBGg/wXPebzU+C1BXl03kgzaXXbGjVXwm3tfWl2Ue5?=
 =?us-ascii?Q?dI5yDwha44Y3cEbjoYXaUPPgs47qVDdDtvVdSjGx27exER2gCxS92LJC7pAD?=
 =?us-ascii?Q?obCM9hf8j6J3C5hTtwWV3dBzFmgtpCKGj5uuvj0ikZomk7egOEs4R6byyHGN?=
 =?us-ascii?Q?cMux2wxTUYZzJl+Adw2eNVEzjLf95JCJvpCIezRMkDCIoAtlLV9NSntxSM9G?=
 =?us-ascii?Q?xOvLnigEjqJn+Snz3Yks9NdHEUxj6lfxO9mtqotSLll12LIP2bbW3gDPy0Gy?=
 =?us-ascii?Q?+Btf8PXcR8TwDG1Zk6NCsJdyfgu3/Oqberxny+NL1uvSZITwSN5tNAIh0cYf?=
 =?us-ascii?Q?ezGxnNaX2jPKzSs01s9hVjL/V3pweLmRYGUsKGP8Lur4jHpGRMUmg58YC/iP?=
 =?us-ascii?Q?N0S9qetLiidBYOFTb0e/cFLeKuCBNT15U96HxUZhQ7PXlB4sm7JCOGLfB3+y?=
 =?us-ascii?Q?uQl09fY97m5DeaZus3JY861CoSgC2NnMrUFf0B56qaaava9xUncv9C1Gzfjm?=
 =?us-ascii?Q?UJ2wPMn5SVCBEqjReqv4bTsUr2FnbYIcAmLDEHx41Yp/VpxgdP/sb26mZGZJ?=
 =?us-ascii?Q?AWwbEOJ196lbq236e29rT3SCnmEc0zOA9MXIiFa6E2DWo1xZHHHdJgAWpEzw?=
 =?us-ascii?Q?VEcRChyd+1hHjSmWcECBFvc371J8CHdrwp73/eemE5hnuThBCXdMYj2F8wol?=
 =?us-ascii?Q?Nb6X7h1mnxLtjQ4labb5quETBNQKoMmDy080H1wcy1JWY+DzhxAPxHaUj8f3?=
 =?us-ascii?Q?Kon0PqWwKasf4qQtYyduqqoEnjgL7EEIJzE+69B/gd36tWucQ98B0Mut7V12?=
 =?us-ascii?Q?CuUyW3jw/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: oyQ5R8sT5nxD0FbtECMzwZBvKRjEYaezFvgjQgf+xjTMkJwCuYJErx+DQU2NEmPkLRNwxcD2Npi616bI2/rFL8iwzZBvdt32g2JccHGWfsrVEBOsQ4VcZblNyRnarnhcrnzbSNblSxSVvXmWFx0xQGuAQz1drO6Ks7ZnOBwAbPJNFAbiqoZYuufrM6Ck71h6lyt/ZHJcD3Bi1EX+SqmiXb0pUq0EJ6Awj6WwsU9znLBpN/8FCg41YEiJIHcNz8qrwmrqJlHarkNXt/M+LDwsfX+ddtbNufRf6+ukANW+4g7YVuJ7WmyA4ZVgBLcdhuGCxlfoP8nwdI2D6Y3kJFFk5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bb31bf-1953-4a87-a80e-08df4b26b844
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:02:58.4954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBp7S2++kXMTZ+DllGcFxZZinckFhc6+T8LTFi7w3i4BXWQJzIfwKZYEvnkHh/pzAqoDBGFgjZRYAZJZgZO8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
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
   and status (retired, pending or failed). The dump is flagged with
   NLM_F_DUMP_INTR if the list changes while it is read.
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

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  73 +++++++-
 drivers/gpu/drm/drm_ras.c                | 228 +++++++++++++++++++++--
 drivers/gpu/drm/drm_ras_nl.c             |  24 +++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 include/drm/drm_ras.h                    |  49 +++++
 include/uapi/drm/drm_ras.h               |  31 ++-
 6 files changed, 385 insertions(+), 24 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 0f1ceb705d3d..c217e52197e6 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,16 +16,28 @@ definitions:
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
+    entries: [retired, pending, failed]
+    doc: >-
+         Status of a retired page. retired means the page is reserved and out
+         of service; pending means the retirement is queued but the
+         reservation is not complete yet; failed means the reservation failed
+         and the page may still be in use.
 
 attribute-sets:
   -
@@ -140,6 +152,30 @@ attribute-sets:
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
+        doc: Maximum number of pages that can be retired on this node.
 
 operations:
   list:
@@ -287,6 +323,37 @@ operations:
             - field
             - field-name
             - mode
+    -
+      name: get-retired-pages
+      doc: >-
+           Retrieve the pages retired on a retired-pages node, one entry per
+           page. The dump is flagged as interrupted if the list changes while
+           it is being read.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      dump:
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
+           Retrieve the retired page limits of a retired-pages node.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - node-id
+            - max-pages
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 82fcc766b84b..26505a7e4f0f 100644
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
+ * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
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
+ *     + The driver must implement the query_retired_page() callback, returning
+ *       the retired page with the lowest address at or above a cursor, and
+ *       -ENOENT when there is none.
+ *     + The driver can implement query_retired_pages_info() to report the
+ *       maximum number of pages that can be retired.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -147,6 +162,10 @@
  * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
  *   dumpit operation, enumerating all telemetry fields and their supported
  *   access modes for a telemetry node.
+ * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
+ *   operation, listing the retired pages of a specific node.
+ * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
+ *   doit operation, fetching the retired page limits of a specific node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -162,6 +181,8 @@ struct drm_ras_ctx {
 	unsigned long restart;
 	/* Node targeted by a telemetry get/set doit */
 	struct drm_ras_node *node;
+	/* Which retired page address to restart the dump from */
+	u64 cursor;
 };
 
 static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
@@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
 /**
  * drm_ras_node_get() - Look up a RAS node by ID and take a reference
  * @node_id: ID of the node to look up
+ * @type: Expected type of the node
  *
  * Looks the node up in the global xarray and, if found, takes a reference to
  * it so that it cannot be freed while the caller is using it. The lookup and
@@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
  *
  * The caller must drop the returned reference with drm_ras_node_put().
  *
- * Return: the referenced node, or NULL if no node with @node_id is registered.
+ * Return: the referenced node, or NULL if no node of @type with @node_id is
+ * registered.
  */
-static struct drm_ras_node *drm_ras_node_get(u32 node_id)
+static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
 {
 	struct drm_ras_node *node;
 
 	xa_lock(&drm_ras_xa);
 	node = xa_load(&drm_ras_xa, node_id);
-	if (node)
+	if (node && node->type == type)
 		refcount_inc(&node->ref);
+	else
+		node = NULL;
 	xa_unlock(&drm_ras_xa);
 
 	return node;
@@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	u32 value;
 	int ret;
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
 	u32 threshold;
 	int ret;
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -699,20 +724,24 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	node = drm_ras_node_get(node_id);
-	if (!node || !node->clear_error_counter) {
-		drm_ras_node_put(node);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
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
@@ -770,7 +799,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -781,6 +810,166 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
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
+ * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Appends one message per retired page, in increasing address order. The
+ * dump resumes from the next address after a buffer overflow, and is flagged
+ * with %NLM_F_DUMP_INTR if the list changed between messages.
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
+	struct drm_ras_retired_page page;
+	struct drm_ras_node *node;
+	void *hdr;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	for (;;) {
+		ret = node->query_retired_page(node, ctx->cursor, &page);
+		if (ret && ret != -ENOENT)
+			break;
+
+		/* Never zero, so the first message is checked as well */
+		cb->seq = page.generation + 1;
+		if (ret == -ENOENT) {
+			ret = 0;
+			break;
+		}
+
+		hdr = genlmsg_iput(skb, info);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+
+		ret = msg_put_retired_page(skb, &page);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+
+		genl_dump_check_consistent(cb, hdr);
+
+		genlmsg_end(skb, hdr);
+		ctx->cursor = page.address + 1;
+	}
+
+	drm_ras_node_put(node);
+
+	return ret;
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	u64 max_pages;
+	void *hdr;
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
+	ret = node->query_retired_pages_info(node, &max_pages);
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
+	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
+	if (ret)
+		goto cancel_msg;
+
+	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
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
@@ -808,10 +997,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
 		return -EINVAL;
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-	node = drm_ras_node_get(node_id);
-	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
+	if (!node) {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-		drm_ras_node_put(node);
 		return -ENOENT;
 	}
 
@@ -892,10 +1080,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
 
-	node = drm_ras_node_get(node_id);
-	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
+	if (!node) {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-		drm_ras_node_put(node);
 		return -ENOENT;
 	}
 
@@ -1100,7 +1287,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	if (!node->device_name || !node->node_name)
 		return -EINVAL;
 
-	/* Currently, only Error Counter and Telemetry endpoints are supported */
 	switch (node->type) {
 	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
 		/* Mandatory entries for Error Counter Node */
@@ -1112,6 +1298,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
 		if (!node->telemetry_get || !node->telemetry_fields)
 			return -EINVAL;
 		break;
+	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
+		if (!node->query_retired_page)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 589c6445eff7..c56220205876 100644
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
@@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
+		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
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
index 7a1cba70fd50..880b0c2befe3 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
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
index 76bdcc6f96a5..5c3900a53278 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
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
+	/**
+	 * @generation: Generation of the retired page list, changed by the
+	 * driver whenever a page is added, removed or changes status.
+	 */
+	u32 generation;
+};
+
 /**
  * struct drm_ras_node - A DRM RAS Node
  */
@@ -184,6 +201,38 @@ struct drm_ras_node {
 	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
 			     s64 *status);
 
+	/* Retired-Pages Related Callbacks */
+
+	/**
+	 * @query_retired_page:
+	 *
+	 * This callback is used by drm-ras to list the retired pages of a node.
+	 * It must fill @page with the retired page that has the lowest address
+	 * greater than or equal to @cursor. @page->generation must be set even
+	 * when no page is found.
+	 *
+	 * The @query_retired_page is a mandatory callback for
+	 * retired_pages_node.
+	 *
+	 * Returns: 0 on success,
+	 *          -ENOENT when no page is at or above @cursor, which ends the
+	 *                  list.
+	 *          Other negative values on errors that should terminate the
+	 *          netlink query.
+	 */
+	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
+				  struct drm_ras_retired_page *page);
+
+	/**
+	 * @query_retired_pages_info:
+	 *
+	 * This callback is used by drm-ras to query the maximum number of pages
+	 * that can be retired on a node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
+
 	/** @priv: Driver private data */
 	void *priv;
 
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 56e0588af5d5..e7f2da18cc4c 100644
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
@@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
 	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
 };
 
+/*
+ * Status of a retired page. retired means the page is reserved and out of
+ * service; pending means the retirement is queued but the reservation is not
+ * complete yet; failed means the reservation failed and the page may still be
+ * in use.
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
@@ -73,6 +87,17 @@ enum {
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
@@ -83,6 +108,8 @@ enum {
 	DRM_RAS_CMD_TELEMETRY_GET,
 	DRM_RAS_CMD_TELEMETRY_SET,
 	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
+	DRM_RAS_CMD_GET_RETIRED_PAGES,
+	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.56.0

