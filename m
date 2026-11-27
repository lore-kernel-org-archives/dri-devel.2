Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7AB606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eEHU8kzb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE69112CCD;
	Fri, 27 Nov 2026 17:59:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1193112CB7;
 Fri, 27 Nov 2026 17:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802382; x=1827338382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=8rdg1mGZ8GAoPA47AWsxdJLArXgsYwPvslGIwl2Khb0=;
 b=eEHU8kzbGQPXoxbbejhy4VmvBCyhVcMAG98p3txmH/R3s+TQmetDhZtp
 NJzrXrU/YVKc1rcx2WGhW7DcVnWdbwxRcZNGdArLnPEmH3ZM9rXVE2U9+
 gAGc56LFoTW7fIA3kBPQa4gJtgSm8UiBITE95ZZlKLftFb/6Sf5KXcZgR
 4m10UTG8fgyr1HSVyotL9yt1v1sPchwoiuDNvC/QKITRrjCk5eYBVSO4l
 qvBwiTOSk1p/jo/6BXcTk0RyrK7ALiPV7us/tmxRi91vOn0V2alepL2IX
 eGf+hNDh4yJQSGaJjoLQQ2W4D7FzPsjn0vGoopUvMLy72n1Mcj7QD1p0x w==;
X-CSE-ConnectionGUID: bY2w6nI1TvWr1IthbNx0lg==
X-CSE-MsgGUID: ZXzLJFn0QtiZDuxlfrHInA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4678105"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4678105"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:42 -0800
X-CSE-ConnectionGUID: C+EFti5SR+mNzsmygfsItg==
X-CSE-MsgGUID: eR8XX+qXQm6AJYh2ttBSpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12789928"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:40 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6EgvQPcX3oWEF73fxk0DsX1GNPnh7gdmzSJWDsi6veN4ql4iY7coP/GRbBlEH7MiFFvxDA8TQa7PaIv6HX93VkMBpTEWHclA8oJHi18SEJIVj/JLMqLgWdI3A8TpphY6x/ORvR/h1TM1BQh7L58uPXYADDS7xsNm+ne8ps1kCEAspq2qtqxspcobVZ79RSlkOQgLvFwTYp+t62NaYwd9F/DVQSlXoyVpCLbEXNa8GV6Aaj99umbz6ewM2APQNTucKQAJP5X93C7yeML1Wl9gayvTDA0Ke6BtiuvEfsjlTEFkMAqFMbxh3BG97PR3bE7dISE/xVn/wyhgkltUcG4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXdQ4Xq1qyaBKeZyhpVbHWcJNTdbdFmb69k6lKiGweo=;
 b=KmefUMquL7JUlgGcz9xeBt7jIvkU8O7JtL5W0JRxv19rBApYr5ZKA8ZH5AU8tNKjsB/f/E+Zodm1mO64UOcqgQ+QFOEH5isatj4AYpHvRGS7kFHEVCYTSORhg9DkNN39oqw1Ikr9ictRAz4a9exMX2KvfsILuvkyoDDAzNNdU26O1eSF8CAW0G3qXJpb85hfS2lk1x3/2UJpdPXpY5JJukEncHOqTEWYx7bAhR99GpisUx1HAnXiHyNO5c3KqdEJH4xW+ZvKpc6Ru8hnOkK88jZIdSsSDGXIOzx954on9boVpwIIunzOTftvE6jEwJ+nNWfeBNSWQ8m/p5UiE5hzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:38 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:38 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH i-g-t 8/9] tools/drm_ras: Show retired pages
Date: Fri, 27 Nov 2026 12:59:19 -0500
Message-ID: <20261127175914.784751-17-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ea413a-53a5-4404-a592-08df4cb03441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261021123027099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Y8RrxmCXypxer+G5qWnbsw5TeFHChn96NmvD44cpwN2xbiAzofN1jJRT5EJPySltYnrkeFMPot1C6BcaN/mTD/qTlOwSN/qmFQ7xKWNajQ36wQDG7jaiU6mNIT1eykesdmViZU3NXa4IJoht/omW2K9EjMirdFrI1OzRhu4HnWEd16oE2pkpyqUIQ4PMZp0nSmpJy+7I1XnGNLUoSvyeExLpgmzNLBmAbbUOPKqcP2JDMFxoCECJZZjPtXPxnP5kLWXIFezNMszIqOommmo26dETS5WPtPHo+9ltxY/NtsmEL8Tlu3DsVylItAjaEo2Xnst3XyZadYdiYfBPFjvbgykPlrXxYMlJ5n5L19FQLI97hOt0Nq6lODZ0YAoK6Uz16zxhy/WPXXMbl/9ccHyIaQWnuScqQfOpCFPnhY7i0pL3kZdnrmphJaBZ/pY5eRgyb16bP0/7tZ51uQIS10WYdydZarMNbbzUshWtIfUMXB6/L1kNfYa3Pg70FO9l+6WHaceCC5yGmimMqlhZCHz0ltTo76ufY+8FKDyGf7gTzTBpVbnHwr7QkOm6AL6R1ScTGi+gUFAXYJIvvDAdVlrR2ZVjFBBORKlY+qEc/eNFuovCTm2CaoNrm7vGwPTE3i1z8XmwCCdfc3WNatHULJDalDpvxfP1gx/K/v/Chg3QSdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ndrEvh22HqbE8vGKHVyy4CsZf1XHI0i/yQxs5dW+E+D+qJ/A5945QjCDOPIV?=
 =?us-ascii?Q?2T7jITl0w2URUv2vHNdWrnpTgSr2UIehLg0sDWROeRgnpjBzbNGZLYuxlZBR?=
 =?us-ascii?Q?oqhQBlAIuNdhwhV1th0r07uTSIwh7owHi4lz2HTwG038IoRM24xdJLgMq30K?=
 =?us-ascii?Q?tC1+HoottxvojyWQZAx6S4/MftTAlm35po1PdEOJnZ2SUErZXDvMzuhr0YcN?=
 =?us-ascii?Q?mbz7ACp3Urx49/WBnGjvfTi0v/CTE4pr3ScFyyIYCAKRsf2tQc24gDl1917+?=
 =?us-ascii?Q?q6xIIQjnbe//ouZ2GKMTa+hcU4x8AcXvTe26Lr/SZeTifqjUOAk9imtlIDo9?=
 =?us-ascii?Q?iRLKnrVl7KkDVFSYkimRS06SeXdcpIJufq3FmPFcLjuDt0Wnt56wY7y0q722?=
 =?us-ascii?Q?0vPcNnFvuu6USmeWpxQUXky/QW+eFsQqz2I84XHVNIG4Y4pY1uoPGOnfB5yH?=
 =?us-ascii?Q?sk34YgMulFdpMCXJTMuuGCvVnPc5vF+7HG2Ik8vy/QFLGvF9+rtrou/5pr6D?=
 =?us-ascii?Q?HF1wUR+tY6zkbIdbvFmPaQxOSkEdbafKJMJBj8tAep+GP+agvjP8M+VMLxMO?=
 =?us-ascii?Q?D9DvSYIITncuw+4F8XJ4dAqjR6SKSRE2tHwMnDzpfFkHp3hLc+Pf7gL/XGtB?=
 =?us-ascii?Q?GXXlygtrffiIgYCP5QmJUyAOTgm5Lb1rtn8eYn/T8nwMLKgAK0DpnqDR6Vfm?=
 =?us-ascii?Q?OBkSR7fhxcMVBAi4ZurUyn9RzFCFY1fbM15PHNA8YUENw1fKdZTMNJ9y2L21?=
 =?us-ascii?Q?ZmcRhVXTp1vIzVozt39PzBPkpDAaKIynKhVdTZFvep9z3W/8j4k8rDt8Mbdv?=
 =?us-ascii?Q?A1u3fhoF7G6Npo9b6WGwfnTeDFsKBQPiBd3Uguyaf+cuTuE7M85lmyyTH51r?=
 =?us-ascii?Q?PWtdoYa88H141ZibMMI5Y/d3bcPpzpUJ8THZzsrz9kTUj4nJhRJAkMGKIUr0?=
 =?us-ascii?Q?m3vetG1E8wqiTs2FNrVQz/E46W5NFTUpN1dT7oyNEjPhA2s/ZkgNXp0Sdjhk?=
 =?us-ascii?Q?3m9TN6XdTnirU7K4/vpybC940H0tJhEQe1RBMrnyFi3/mhsUCTMl8tvVp3gU?=
 =?us-ascii?Q?yPsUp7W1s+SDcniFXJ1ujSGHj7IHsvdw6zsVPWutSy+by9S3WX8aavckVqjP?=
 =?us-ascii?Q?f9gPCBhWePhGd4y5gLR3/wKbQrOfT2zEvPcBsXcztGjjH6NHnvOjH7cjtkz1?=
 =?us-ascii?Q?aiktUhYX8Bo54+tzutVAljj3COoiNSYk2Ap7I9P/yS6k0+F1R2V1sIxgL9kr?=
 =?us-ascii?Q?5Gda1A/BsN0+oLKHmIwBCSPx54uB8aaBMI3puWKsvkTCY+B/woz//hE8wVc9?=
 =?us-ascii?Q?w2LBhJZ4+5RTc/kgwkDpwlAWHk/1rPGK9MQUCA4sbYbHGq+rkXCXuIcBtEuM?=
 =?us-ascii?Q?v1o6KVPNw3DJlqV+osCRzvYytQ08AMNzu9XyRDdlzESK4j67Iah/InfREKwy?=
 =?us-ascii?Q?OcSiOikffWXIjzC7vXLf5+YeyS+7mtwQez/BfsPHMhdmSeWx4ypTRB47W5jn?=
 =?us-ascii?Q?bHcOFyILJjI3VKeFVeAF7eS8Fbk8ryv50NmT+BYXZ8VeDFdNz4DLiqhTK4u5?=
 =?us-ascii?Q?Fd0gTcWIAMzDiYDwoLFKbC5gnT6ah3ZiRhaHW4wSw1zAMqaxw5kL6Z37h6D5?=
 =?us-ascii?Q?vfSi+eTraSFd4k+SJ1IbbntnsxXTj8qWwtua39yYEsNSBs14co/rvU7mDIWi?=
 =?us-ascii?Q?GldUGFdk/g6bapw6UrvACuy6G4hW1Po2Wy9KIuu2PW5nAVefiKtjB92C9PpN?=
 =?us-ascii?Q?wybMYE3xdw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Xo6MtkW3esL4B0iW+NOXObUJOoexAJ1cDqKMJ7rvhivmwnYCOu7J8JodzZAHtA4sWbMtf7IDxuTm90bDiWcYxmgJuQus53fc33vS1IlhV5R+qkl5uRAH8G4h86hVgV8agNtwNi3Fbl+fOCqspHeuc+YOzGQxjJuZIzd633OVTR4flYeYUtxJjKaIWrT/M9QMP6Hm8vnhF//Q1NtPAWgRGLoIreq8V6GcPCK1p02kG9OLPKM4OtKVmdHqtcYnZFpU7fPdkJ036cjinWtJtD6XSbwOCO5F5nTB3PdEMtajRO+i7eWFfn1RjnINl3nF/XK1hVOx1PouXwJ3dRpCVphc1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ea413a-53a5-4404-a592-08df4cb03441
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:38.6379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87NWkdTVcb0fao2tCF/r36ijKW5YqUti6EnWHr+YwNdeffVaPx8VvpbHCkJq+kwBlu6lX+KJX1fk4eyBSbsujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

For retired-pages nodes, show the maximum number of pages that can be
retired and one line per retired page with its address, size and
status:

  # drm_ras -n 2
  max-pages: 64
  0x00000002fb5bb000	0x1000	retired

Tested on BMG with simulated retired pages.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 tools/drm_ras.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/drm_ras.c b/tools/drm_ras.c
index aae92f99a..7d200df76 100644
--- a/tools/drm_ras.c
+++ b/tools/drm_ras.c
@@ -16,6 +16,13 @@
 static const char * const node_types[] = {
 	[DRM_RAS_NODE_TYPE_ERROR_COUNTER] = "error-counter",
 	[DRM_RAS_NODE_TYPE_TELEMETRY] = "telemetry",
+	[DRM_RAS_NODE_TYPE_RETIRED_PAGES] = "retired-pages",
+};
+
+static const char * const page_status[] = {
+	[DRM_RAS_RETIRED_PAGE_STATUS_RETIRED] = "retired",
+	[DRM_RAS_RETIRED_PAGE_STATUS_PENDING] = "pending",
+	[DRM_RAS_RETIRED_PAGE_STATUS_FAILED] = "failed",
 };
 
 #define name_of(names, i) \
@@ -40,6 +47,26 @@ static void print_error_counter(const struct igt_drm_ras_error_counter *counter,
 	printf("%u\t%s\t%u\n", counter->id, counter->name, counter->value);
 }
 
+static void print_retired_page(const struct igt_drm_ras_retired_page *page, void *data)
+{
+	printf("0x%016" PRIx64 "\t0x%" PRIx64 "\t%s\n", page->address, page->size,
+	       name_of(page_status, page->status));
+}
+
+static int show_retired_pages(struct igt_drm_ras_nl_context *ctx, uint32_t id)
+{
+	uint64_t max_pages;
+	int ret;
+
+	ret = igt_drm_ras_nl_get_retired_pages_info(ctx, id, &max_pages);
+	if (!ret)
+		printf("max-pages: %" PRIu64 "\n", max_pages);
+	else if (ret != -EOPNOTSUPP)
+		return ret;
+
+	return igt_drm_ras_nl_list_retired_pages(ctx, id, print_retired_page, NULL);
+}
+
 struct telemetry_fields {
 	struct igt_drm_ras_telemetry_field *field;
 	int count;
@@ -151,6 +178,8 @@ static int show_node(struct igt_drm_ras_nl_context *ctx, uint32_t id)
 		return igt_drm_ras_nl_list_error_counters(ctx, id, print_error_counter, NULL);
 	case DRM_RAS_NODE_TYPE_TELEMETRY:
 		return show_telemetry(ctx, id);
+	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
+		return show_retired_pages(ctx, id);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -160,8 +189,8 @@ static void usage(const char *name)
 {
 	printf("Usage: %s [-n <node-id> [-s <field>=<value>]]\n"
 	       "List the DRM RAS nodes, or show the content of one node.\n"
-	       "  -n, --node <node-id>         show the error counters or telemetry fields\n"
-	       "                               of a node\n"
+	       "  -n, --node <node-id>         show the error counters, telemetry fields or\n"
+	       "                               retired pages of a node\n"
 	       "  -s, --set <field>=<value>    write a telemetry field of the node\n"
 	       "  -h, --help                   show this help\n", name);
 }
-- 
2.56.0

