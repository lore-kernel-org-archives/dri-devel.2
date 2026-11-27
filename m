Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED739606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XWzxpgb+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53EEC112CF4;
	Fri, 27 Nov 2026 18:19:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789CD112CF4;
 Fri, 27 Nov 2026 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795803584; x=1827339584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=SlvNa5vcA4UN835LYnPdnXf167zusISXxCjCwozk4/g=;
 b=XWzxpgb++tsI5nAaSktX3bMlcjqpL7EalFdySSqp4lmS9gDMbOLjXpP2
 Mo/DdAoXDL+SAv2kx9BeOXvJsE1vxjgK/nLj//zXkNdaBjp8MOQHascmB
 uSkFXs4H+38AzkfAruY1j9i7CrvDdm61sUPRfGtIodWhJ1XqfSBX9ptYS
 vM2iEflMcUQxdmSEgVeFl+nMAmASznZERrRyavXiFJmeHxRvLf14RQbKN
 tTxc8iF0De+PWhE0g1uIFl+ldrzrPKu974eluetvHpn3npN27kuOXuWwY
 gtYIZahdZ14eOygKX490X9JFsc49C3Vn7kAYu3y9CYwsARkN4manVAv3f A==;
X-CSE-ConnectionGUID: M+0y3MODQmuMAchCt+KWgA==
X-CSE-MsgGUID: Okect3EBQAeDh0cruBBu+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4611511"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4611511"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:19:44 -0800
X-CSE-ConnectionGUID: BR0T5F0zSES86reUCa7mhQ==
X-CSE-MsgGUID: jTEUFH3yQ++utEQilFWHPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12600626"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:19:44 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:19:43 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:19:43 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:19:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXrruAiZzJhwKWwzscG9X8UfGcGcue7ARdknua9qDPd3lZQatZW5dMU6bnCrixwAfJsZjErM9/GKyfhRfSJwuqDlFU5h2Noe+od++NtzdfReTAE7/6sr/bJSWFS8F0gts1ye9idq69NGqLJ6GmGLg1fHc0Y9Bx8t7IBk6jG9UvGsq/j+e+fxoSISLmPc63wGUIs+j9Gma+djMglPdb+CwIexNW/baujTyKq0kmYXr0H2JZ4CqpBjP6AWVLTrmIyHM1wit6KLd8EZ3AMDK4Hd667C00HMtLLItZ0TJjk79K1A9oCO1nbc3ms1XJk/cx6kUpvMitEMdrw2wlmTNF9/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mFmE7jW2F3QpP/6syp7c5cMEOiIMpC6VbCFu4SE0WI=;
 b=ZPM6sf93LhJ4v9HwcC1z8TYuX7hRcS8Ux9+jTWnTPMFCRu4fr1wSqa4OC5gWL18LjFR79YAEMWaDYXvP2K6GxSPu/uo3lhQTnmKQAFKDNKFSYfnk6a9m+M6ZgKz1ZCef9z7XCjm/rccVQp0cZaPWORxE6FM7pqbihu6E9VqtopoN687qZcEPUUT9xur5em1xpRFgKtcgLokWAp23ZOSAtXrHxTqqOvm5mupwiNYdPJ0B/nbaPtFJY3/cBLnzcnRT4IU8iX7MSK707cEsEIvwEbvmubT3mapWGtKI5qdlaiYVh8ZVq77Rq+jVkZ4imuj/Z+T708H5Iy2OTpeOdupHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:18:04 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:18:04 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v6 3/3] drm/xe: Expose retired VRAM pages via drm-ras
Date: Fri, 27 Nov 2026 13:17:54 -0500
Message-ID: <20261127181750.806528-8-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127181750.806528-5-rodrigo.vivi@intel.com>
References: <20261127181750.806528-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cad904-e6ff-4abe-4922-08df4cb2c77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|260925022911599003|260925021911599003|260925021311599003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 8Qb9JcKM7LTz9E3VtumfLqwhGWtTS7zAXFGo63r3tso+9y2gOS3tc/CRKb7xQb3KQSp3DVqNOhwXvFN2H7/KjHCy2CTdSqm60UG0dMQz1fNWPsJ27b0QXiqctmVwXMHRrWUNmC+ODb3nPLV2PHUyuuXJVm2WCVK0QqGWjAsEXKuMSqSeZZ/ftEOPlVjV3g0mZ7JGSC4/8QzkmftIxGxahuYd41IVvuf9spDtFZnFt0wEo5CzMnVlN1Hr5mnya0qiVx1ofAlPcS9PLcvHJXQrF12eo2g2btsExplFx+BkFfp0UtaPa2A6Qbz2xaBRUweWUlGcFeQsbyfcPWfeQK3Gb4An1yhLZdt+/7Njw/HysG9Y6sVQZI7lptYkEP7IfZ0p5g/Bb2i8bd4Hmvjk8jJg8YvgSaS+O/TAVPUQmq+8bk+HlnTzFCxj6lJf921EUKjrni4omMOsQQVIVJ+4z5vhHd20kmzXK4KQ7aDlvai52kXfboE8SKdH435ygHRf5cJVSMnRf9pWv0o4deK/peDs2E9CxUw7CtZ5U2qjo254AOwtLbXQOwfeHe7YSKfnMOGB5+QsMFMbxvxLg2Hwwkh17z7pKLOOfYpdE2WEkIHk5tL9alTt43wxDkIPnNGlZacCMyBJfkZcpwjMvWNXgVBZ64oSwCigk5DNhz+4zAs8510=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6l8xOmeOk3U5f6+CqXtDEo/JpS30b4wEJoVajlAWQOTwD9IqqBynMIxsx0Aa?=
 =?us-ascii?Q?WubM5gt6ymDWZI3QxyUMiJ2CvtJzYm5Zlkrdvp7WPwrFYULOcx8CdVHgPgsn?=
 =?us-ascii?Q?Fer19SChgVJcRPmd112N4xzohKm0axT8hvPqEPfyRoF1aR/qY7Skpsb0DGGH?=
 =?us-ascii?Q?nOHsEj8lQZPs+yLR/yc8aYVBTtEzn8BzSQAPvc0DYdZhNwbwASLxsshRQm/N?=
 =?us-ascii?Q?tcbuWlIquFOBIqu4+60l4fSmrPDlPr6xD12HTp12OOIjwYLKcdaobBDyrhRV?=
 =?us-ascii?Q?ofjab+rvmkzqpnMKR599Ri36U+ux1qrgdbxjEOO+L1RC+vpkD2oexYxXuplk?=
 =?us-ascii?Q?5IdyyvUXa/16XtlhL77VabmEmnRUYxnaYldUJ7lGuQheCFiHJqaK+191iOot?=
 =?us-ascii?Q?Bv1/cy/dXMK8hLFuPna3uofixjnzgDEHsacqiBQhgEMNTVMisS7v4vaXETS0?=
 =?us-ascii?Q?ffQ/nJtpajK6AQzQ478sZWR7Xp94Cqg+gLUnRaVJ4bSOZPcmiNLb7j7+lZ+b?=
 =?us-ascii?Q?UMmHX2oKg6BvmAQSoTZCraRiokep8oi6RyprhpKT4rcuVmMPpqKnFGIGAP3I?=
 =?us-ascii?Q?25rS1EHEmzZG8JQ+TwB86ibjdRS1A9YqXnPEu8jUT6SicKdc1BnHw54vEWwx?=
 =?us-ascii?Q?rK3PooEoJYqWAkTF59/1qv7GE1wIhk0x1kJ2a5q1ShnWzB8OlIFoKDvFwDeM?=
 =?us-ascii?Q?aItdTxYlctxlbrTapgvToMTMYLKDE55MtF9poSVTneTG3K5UN1DQzPU1u508?=
 =?us-ascii?Q?slACMC6QtRnxFkc302/fu0Rm41Cn/BS10u1fqO0jLe9DymAIIn7KFkH8Py46?=
 =?us-ascii?Q?lW8+akyea5dJ9XP6H9Md6abKalsGLuees/CeDsGY0SIiBB8/gRLI6dYkYGea?=
 =?us-ascii?Q?z42vuFlwzPGDoJZo2XW2t625Z441M5MG8mm2+AhPSyZ8/lHxtVIRiXTM8e5T?=
 =?us-ascii?Q?ydL2cDBLHk7J1kmXXVehCStE7yxq4yTXW7vTlxx1eZ2dParmQBn930Z6055J?=
 =?us-ascii?Q?BbLwbYBkVf1fjzoFkP7r84ReNaRMaAiR8h42Iji/bH8YE/vMG8v0AIEErebv?=
 =?us-ascii?Q?7fFFirx7UKH8mxNwnwAFTB7H6RETwwOnccgbpMsmcXBcJ/Z9q98+LelU/k2r?=
 =?us-ascii?Q?d+9jNz0I+LwCz8tBDlh8sSVsXeQk7egJT6ialAyOXz7xgqM9MXjkQt53LI3b?=
 =?us-ascii?Q?aa8pPh5z8n63MmxXIxEfUZ43jzb8JDe2Kxx++9iD5bVVNFTsAU7IWXgtnqmX?=
 =?us-ascii?Q?Z16IxbMoZ+ZCoJtl/MzQOblws5/M3XyOOdSVvkZ2JPQVA4+Qp4Xo8OrjJ1z2?=
 =?us-ascii?Q?ni/SeWxPobcLB0AvXG96f83p1hrUwa91+/JISzgc/MWECMJFfBFcm3mE0bFu?=
 =?us-ascii?Q?BUy+5HJI0DMR3nyEd1YC198UjxKBL+MeIRxXLZoA1hTCYnHKq6ohIPLJkqoW?=
 =?us-ascii?Q?UGeiDZYmuQV753V7e4UHensvk2Bz3iBzeqeTtmiafZD1tI8H35ITWs5KyX1G?=
 =?us-ascii?Q?naLaGQ6KBlVaVMyQr5svWc41IaE36v1xhI8eFVHJNpRj7f/Qq/q6DDn628ez?=
 =?us-ascii?Q?FrtuYwQnbBlMR2u2WucoINDK8qwY6RMhvQaNifOjtprxH4eIR3pDBnqZwgwo?=
 =?us-ascii?Q?WSgdzyCf7WiVuwxwkt1pfevNiL0z4DiwGE1JvkKIbDUXyy8e32BMMVwRqtxn?=
 =?us-ascii?Q?SUMF6edxaJHI3tPtmyzI/iiWkDK9+g0Te9WKfaEy9K0AAd0wcu65V/Xah9UG?=
 =?us-ascii?Q?Ej3Roxvm5Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: BxV++avs+jud2/DkOrMiILHpDu6cwva2n/DUT8qqmSqixxpoLYL//7b8QguUb8detXTZxKpD57/rfXX4oEH22sSkUB8iwIrQlHyDiEICse15TorYY5DuSpumbeKp+QHAAEYD8tzL09Gudhdt4FVMynETysB2EtJ+XOVeBwwoas4ffO24bVCEwtGQjV7CAmI4gZQwsEcVGrmKG1/Az+1LjChWYDcleG1tg1QtODilM1+KUTaUB/zWfBm+3mcuO2zI3UMUiLYBsw0eb9tjAuFsgFoP12SZqeEzbIRUgbqdTNxdRKpiMQOkDRAowzwWH012OansVhyXPme3t9mPveAToQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cad904-e6ff-4abe-4922-08df4cb2c77b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:18:04.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+Z4Mkxny/5tfLimgt13Ik4ntO2wkzZds5dq6ZX7biC0cWL3TRh478izhnGjehV4P/c4xXpj7wt+HFsOoxQ7Lw==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Retired VRAM pages are only visible through the vram_bad_pages debugfs
file today. Register a drm-ras retired-pages node so userspace gets
them, and the maximum number of pages that can be retired, through a
stable interface.

The snapshot of the dump is taken in one pass over the page lists of
each VRAM manager, under its lock.

v3 (Rodrigo+LLM):
 - Use the drm-ras retired-pages node type, which replaces the nested
   retired-resources layout (Jakub).
 - Walk the lists under mgr->lock instead of RCU, which they are not
   protected by, and stop reading the buddy blocks (Sashiko).
 - Add a generation counter for interrupted dumps.
 - Keep the vram_bad_pages debugfs file for now.
 - Remove deprecated Assisted-by tag.

v4 (Rodrigo+LLM):
 - Register the node at the end of xe_ras_init(), once the retired page
   lists are fetched. That point is only reached with a system
   controller, which replaces the XE_CRESCENTISLAND check and keeps the
   node off VFs (local Sashiko).
 - Report the list generation also when no page is left (local Sashiko).

v6 (Rodrigo+LLM):
 - Add the pages to the drm-ras snapshot in one pass over the page
   lists, instead of a walk per page, and drop the generation counter
   (Riana).
 - Do not read the pages of an unplugged device (Riana).
 - Return -EINVAL when firmware reports no max pages (Riana).
 - Do not register the node when page offlining is disabled, and do not
   fail probe if the registration fails (Riana).

Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c      | 78 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h      |  1 +
 drivers/gpu/drm/xe/xe_ras.c          |  2 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 58 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h |  2 +
 5 files changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 86c589437a9f..7490281095ae 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -13,6 +13,7 @@
 #include "xe_device_types.h"
 #include "xe_drm_ras.h"
 #include "xe_ras.h"
+#include "xe_ttm_vram_mgr.h"
 #include "xe_wedge.h"
 
 static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
@@ -272,6 +273,83 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+static int query_retired_pages(struct drm_ras_node *node, struct drm_ras_retired_pages *list)
+{
+	struct xe_device *xe = node->priv;
+	int idx, ret;
+
+	if (!drm_dev_enter(&xe->drm, &idx))
+		return -ENODEV;
+
+	ret = xe_ttm_vram_get_retired_pages(xe, list);
+
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+static int query_retired_pages_info(struct drm_ras_node *node,
+				    struct drm_ras_retired_pages_info *info)
+{
+	struct xe_device *xe = node->priv;
+	int idx, ret = 0;
+
+	if (!drm_dev_enter(&xe->drm, &idx))
+		return -ENODEV;
+
+	info->max_pages = xe_ras_get_max_pages(xe);
+	if (!info->max_pages)
+		ret = -EINVAL;
+
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+/**
+ * xe_drm_ras_register_retired_pages() - Register the retired VRAM pages node
+ * @xe: xe device instance
+ *
+ * Called once the retired page lists are populated.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int xe_drm_ras_register_retired_pages(struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct drm_ras_node *node;
+	int ret;
+
+	if (!xe->info.has_drm_ras || xe_ras_get_disable_vram_page_offline(xe))
+		return 0;
+
+	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
+				      pci_domain_nr(pdev->bus), pdev->bus->number,
+				      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!node->device_name)
+		return -ENOMEM;
+
+	node->node_name = "vram-retired-pages";
+	node->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
+	node->query_retired_pages = query_retired_pages;
+	node->query_retired_pages_info = query_retired_pages_info;
+	node->priv = xe;
+
+	ret = drm_ras_node_register(node);
+	if (ret) {
+		drm_err(&xe->drm, "Failed to register DRM RAS retired pages node (%pe)\n",
+			ERR_PTR(ret));
+		cleanup_node_param(node);
+		return ret;
+	}
+
+	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+}
+
 /**
  * xe_drm_ras_event() - Report drm-ras error event to userspace
  * @xe: xe device structure
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 723229b2cffb..a6fc2255986d 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -13,6 +13,7 @@ struct xe_device;
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+int xe_drm_ras_register_retired_pages(struct xe_device *xe);
 void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index d14ee40d0440..39895f6a040c 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -1519,6 +1519,8 @@ int xe_ras_init(struct xe_device *xe)
 	get_offline_list(xe);
 	get_offline_queue(xe);
 
+	xe_drm_ras_register_retired_pages(xe);
+
 	/*
 	 * During probe, process and log any errors detected by firmware while the driver was not
 	 * loaded. Critical errors such as Punit and CSC are reported through Pcode init failure,
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 36d47de8b11b..7658ce9f1bd9 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -10,6 +10,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_buddy.h>
+#include <drm/drm_ras.h>
 #include <uapi/drm/xe_drm.h>
 
 #include <drm/ttm/ttm_placement.h>
@@ -625,6 +626,63 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
 	return avail;
 }
 
+/**
+ * xe_ttm_vram_get_retired_pages - Get a snapshot of the retired VRAM pages
+ * @xe: xe device instance
+ * @list: drm-ras snapshot to add the retired pages to
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int xe_ttm_vram_get_retired_pages(struct xe_device *xe, struct drm_ras_retired_pages *list)
+{
+	struct xe_ttm_vram_offline_resource *pos;
+	struct drm_ras_retired_page page;
+	struct xe_tile *tile;
+	u8 id;
+	int ret;
+
+	for_each_tile(tile, xe, id) {
+		struct xe_vram_region *vr = tile->mem.vram;
+		struct ttm_resource_manager *man;
+		struct xe_ttm_vram_mgr *mgr;
+
+		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
+		if (!man || !vr)
+			continue;
+		mgr = to_xe_ttm_vram_mgr(man);
+
+		guard(mutex)(&mgr->lock);
+
+		list_for_each_entry(pos, &mgr->offlined_pages, offlined_link) {
+			page = (struct drm_ras_retired_page) {
+				.address = pos->addr + vr->dpa_base,
+				.size = PAGE_SIZE,
+				.status = DRM_RAS_RETIRED_PAGE_STATUS_RETIRED,
+			};
+
+			ret = drm_ras_retired_pages_add(list, &page);
+			if (ret)
+				return ret;
+		}
+
+		list_for_each_entry(pos, &mgr->queued_pages, queued_link) {
+			page = (struct drm_ras_retired_page) {
+				.address = pos->addr + vr->dpa_base,
+				.size = PAGE_SIZE,
+				.status = pos->status == XE_PAGE_RESERVE_FAIL ?
+					  DRM_RAS_RETIRED_PAGE_STATUS_FAILED :
+					  DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
+			};
+
+			ret = drm_ras_retired_pages_add(list, &page);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
 {
 	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
index d77f067d197b..7fdcd9836148 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
@@ -9,6 +9,7 @@
 #include "xe_ttm_vram_mgr_types.h"
 
 enum dma_data_direction;
+struct drm_ras_retired_pages;
 struct xe_device;
 struct xe_tile;
 struct xe_vram_region;
@@ -33,6 +34,7 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
 			  u64 *used, u64 *used_visible);
 int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
 int xe_ttm_vram_inject_fault(struct xe_device *xe);
+int xe_ttm_vram_get_retired_pages(struct xe_device *xe, struct drm_ras_retired_pages *list);
 
 static inline struct xe_ttm_vram_mgr_resource *
 to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
-- 
2.56.0

