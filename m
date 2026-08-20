Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DCEC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C77D10E1F2;
	Thu, 20 Aug 2026 14:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ODOlkBWF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBA210E1F2;
 Thu, 20 Aug 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787236100; x=1818772100;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=8Jsbt+EGWDq494evucdV4TQESVKY+2hyAI7YylVrZf8=;
 b=ODOlkBWFPtoN0b5mcvd7/WwGfjATf5QRoU2o76S+P1cN6TG90uVBQfsy
 uOKw7DAVqOdSIzb013lQphM2eYPOQBbX7bgGm0lxsN2RscYn7LqqZdurB
 W8xRyPyCF12rqDvxKxuV9iXSzBEB4DS/pz2Cy4rIs50VXBst4dgXj+Yxe
 XlOlxL8IhyyAMocAUVluJCzCJW+ccFAHaMyiSTtAedTr6JVnxLRJ0g3Ya
 sj4jGLz6L+IboZqDBLKPExrYgQmUVYMDvN1XFz3YRCYX/zlufpsgYrsXf
 jta+mgpRAF/7yt26zmB2jw6T9YS8SVKeIGGKzidwgc/oQ4/qrYWFQYZdQ g==;
X-CSE-ConnectionGUID: Rg6aZ2BRSlqUNMbdT7gMBA==
X-CSE-MsgGUID: okEUFO1DTcic0/TJyK7xUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="86720455"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="86720455"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:28:20 -0700
X-CSE-ConnectionGUID: x7/5oewoRt2r6TK23VfE6g==
X-CSE-MsgGUID: W2Z11mNvREmE07hGYBBwQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="266669444"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:28:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 07:28:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 07:28:18 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 07:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2mJ1Se2bQCtXOkw7rDuWKl0BxhaPkcJpeOq9arhgCGTiplKAgG6MFFlfraXFIcrlxRpK6KQgGXMJvPO3hTeF5dDDTrFIIVMijxepqqAZW6XpAl31izEXeiMMMckbdlwsRnQyZJ/zB+LR2BGVMXfQCknfShMobT/FW5OFOtErP/UXvAKDehy+oePlXvsu24HrJP0wbhYXCg+bwsdFreLBPKWVZ7kHKsl9jklg5BDryjMajp6msxXaRkhvkyxJNiQb49OSSonW1vVDj+8o8agvwsAU5PIECHu8AkW7qwvjjRdd9ZpViY1/rWvQ1R6zdma2vgT25gXnl6/zFHWC9CF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH6DmAAFoGPcZR+9sH4OYnPT3JblHdg9dUpZ8CzQL0o=;
 b=yPJM+GJfphHkcgz7opkdDQ3CHumpbjIuJkZSegB6XUi+EZXxxJEJCNE6F90meL95KPGlZEn+eA16hfLUJ/4hj2/pHhIYByRx9xEDo9++Mo3mY/qSqSym2c7dc5ui/s9JYkFA/UiMj3MjjOfrsH0OciDRzE/CQHTDTzHJ+gd8lfdlY06N5rq5k8C3cpDKPW2vzZYc2P2KqNarFqr4MwafcqNVXaqavsRocHi7SFv+1Q7xLQHZ2myUrUnwXl/n3jdkpagZ7L+Vwefspny4qN5cd0XptAjrQ6RsN4clpQVmQZj1lHSqwLDPevWzUrhhafvgYQY09riwp0ix/wQzLGe7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by DM3PPF7D18F34A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:28:10 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:28:10 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Alex Huang <Alex.Huang2@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
Date: Thu, 20 Aug 2026 10:28:03 -0400
Message-ID: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|DM3PPF7D18F34A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a7e622-c4c9-42f4-83f4-08defec74245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: cBc8ER+26NRjOgXh+M01sl2F2OcdsHopCQDAQkL0Y9f3aIN46oOo+BwQ4tWnYw+f/YHUsJXniC9HwQe1p3a4Vzxc9Ipk9BbjQG/dR6s0hZzaXURwLy8YcboZP9YHALAQbk9WKSJ1XitMwulBQob1zA+ViFDVJxxmEUCLTwSP8+qAzzm/SKs/CY3dahahi1qBle6tMGG49jhQd+Ooe/0G8TJNYdGBU3V1JdY12Ef1/fcpXB2sXuxPyIQ5M1iKYWqjUhQH/rMvp4Vr02qGTN3BspdQU0UA6DRK+dHob0oju6hPdocLFY/8uDe1ctPeyOkuGRoj5dpaJjP7gGXvl7S9yrVQctxVV+JSedj7kGLfXG9Dq/TbA2gcCBhYMzrwSDHlg7KdYdIGlDonoY+gzsz8/DaMiSWQu2r1L/el75lLi2yM/lhqWN97fen4S16YzAKeAG0Dw4OzRZPF95vQwguYcjxAGc1Hd9+gEzjKfUethZywXWpDVMDl3AZ3tzcwY7l0/+10UsQF4jLKz41z8j7o2K1tVnuBQjAdHfihuS87WTOkbWO5LHCZAR8EQJCvOLei5ip77NOSNzGedaGZwlrRgmmqLZ/eJAVBxd1Dl0ZE5njqaKZUpZALT18c5SVldpq7XSKXY5K0RSW+0RbxRDiUJ1V8o3EoQEmlRothUu6wm0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7752.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DvQD+jl4MI1Tt4D2YL4rSeKCKU201ZxSWHRnc0hZh9E0etDzyRWshlJF7fw0?=
 =?us-ascii?Q?WMxC1RzveIV946Ba+uKah3uSp1j9J9viv04QHBojk3AYruAjAR6yxQQDfnEi?=
 =?us-ascii?Q?glaIT7kM9Na2yB7Apf6d1J1BEvUmaIynrLn2LLUbKcmN3dCHLN8Idakj3Y/K?=
 =?us-ascii?Q?bq17szcvCt7MPlCkBlM1TtHS38+ycIE89FVKdimJ/V8d5swXEAI6X9cwquCa?=
 =?us-ascii?Q?JgJp+uu+7F85hRroU3FEZ1gVnR1FB3YgZxmF9IvdcE0Ll8qEBxDTpTATb5xO?=
 =?us-ascii?Q?3ZYqPLTD4P5vVPucfSeUO7PtNOCCtyqT/iPtdRPIEtlwDcysSqFXIkiqbIP+?=
 =?us-ascii?Q?Mx6LpsenQdXYEBvLzIyAUiXsQCWS+cHsUFUt6AJRlX3KmIbIdqr2NqwJndFp?=
 =?us-ascii?Q?QCMk8vuoMO+YsKyELf7l78bWJJJzzBE4ilDyQcWDX6jPkVnrx+leCgpIk8x0?=
 =?us-ascii?Q?dugRomnt1nC3KC4QIVB9DBYHWLPjIIVrDtbWSH++hMBqVQVmORpMOa6TGFuQ?=
 =?us-ascii?Q?b4YrP2FhOhU7QZgP4LLBPjU8Tvg4Jceg2odGlv6q07ydM8JHq/Akg8x9rXCP?=
 =?us-ascii?Q?M4TmftH54vzxtWzk/nDD7+uzj2536WANO+B3IJvgJDLthEebxHupKtmB+i/B?=
 =?us-ascii?Q?o3Q8HbvWqsC0oNtXTlFY4W+Vn/BTuawoBfafU6sXax8mTScDmi8BX21/5YNg?=
 =?us-ascii?Q?bG+ijEzzqpeEKUhWi1S8LzvkC+6QZZtH9TDnD6Eol2CYQH++f+XeEkf5KtiP?=
 =?us-ascii?Q?f7qcNzgeFHyX2fMaWv1txR4Z7afAuzpN6cftpJSN+Z2/hUmgLxw/MSUwUGoY?=
 =?us-ascii?Q?u1YshMUNsWuIyrakfAM3CgL/64x8UiM6Db6S7mLWg0h2FYq/RvnoGXVHIwue?=
 =?us-ascii?Q?vlYmiSeAVZXiGpfxsQaNe1c3JJ4dvNbLCsmi+J98d9csCfuscqGOQkBZe1TR?=
 =?us-ascii?Q?tzqsEkteclTdtuu0X6sAEGxg81xt3X5d6wNxBzowGqEqrAf4ajGFSpZhSbaX?=
 =?us-ascii?Q?EuJ3a4me3/OnVmWQKkjI0E6Zz96JtMT3WsRKeEkCfOC5Zf5nBvjPGKRGGBir?=
 =?us-ascii?Q?KD/bhaF1u9F0ijuYXdJQBMi3NTrsFGE1hdNafGlgcfsrAKNveQaEOIXuGG6Z?=
 =?us-ascii?Q?i8dbLBe8OnIcqic+Eju++aYJSZV+9BjBkvX1BFUJUvQtGH0iLsSm6RApIzIl?=
 =?us-ascii?Q?PhEisptyrdR1VzczVIUrlM05o1P9EDnlMVf9zibFQxlBMS3SHAUTFTzgs173?=
 =?us-ascii?Q?zDvcsPRsMJ+n0pQnQkEEaGakTHgkwjXRP7K+eoD4bR2KbU5MXVTpBdp/lAQn?=
 =?us-ascii?Q?ty8X60bmc/GRUzlxjSTR7cub3RtmXJu/AXjxyooJbkXWTphD4Glo2JLH48vS?=
 =?us-ascii?Q?08QCyWRV2t8VEz5gfZEVjsraGelIUgTudn4bsMGIqCmbPHVvxI90SlIA6nSh?=
 =?us-ascii?Q?cNp+KHmpndxGYmZWLCmIyquy3/bvceI0nsmVQup11ujRaQrTJ5SnhIQAUk0a?=
 =?us-ascii?Q?enhTp4/TDITjWL/Q6GpDUn6dZsfcYCx7TBk5R2JQ3DCpXXgJvtl8ToP3PpeM?=
 =?us-ascii?Q?Vy+smp9nEt0qAptwDapzDttPRoHCrsWkN0m5fru/Cr8GjoKBQ2c0nbfgmRjL?=
 =?us-ascii?Q?p+rncJxAVABDvnxiRvlL/oI+CLgKESxXDOTbzsOTUNpj+A+jkFKCjticKvcv?=
 =?us-ascii?Q?cHVlkVXYyaJRw7u/Tfl8vsKc8fF3ShdhrmsPwh9j5lw3NPX6940J5CRWeSHD?=
 =?us-ascii?Q?vY3H5egUGw=3D=3D?=
X-Exchange-RoutingPolicyChecked: oOVUEpB4JHiLy+Q/INBFkGKEfEEuNV4LqSTI0TMIj+FH2bcu4pO+bN4bhZOESi+kTj1cCGNvgyqA2gEK+NO43nRQZQcCPpaDRlxL36UJV1MHKPSjBupk9iNtXqWSNTesVy4j01mcgTKAolNavBESAPrymmRerh/+ZxpOUGkxeRUxjrvlR3liV79D/1gyKEsMH4OiVpFHMk1B4HSGSHvbEFmXlHP2rMXlGys5pz4hzJdrDggSPLo2D4FkdEHXdef8F1ca/41G0D0/XC9UWStipam7MukkPz1s3WjG30MxSioUxMNzhiMaAs2mw+lWVR1UrEU5fwaP7ZfHcj5187BIGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a7e622-c4c9-42f4-83f4-08defec74245
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:28:09.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HM+Go76UOzbS17DyD/zFNm1F1dIu/8mNQ9k94g2PPWglulGAQHYN00xQkwdV5wqOWRxvnxSGFDKKRVM1N2g8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7D18F34A1
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

parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection moved to
the common EDID parser, but its declaration and KUnit tests remained,
breaking modpost:

  ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] undefined!

Remove the stale declaration and the three dead test cases.

Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from common EDID parser")
Cc: Alex Huang <Alex.Huang2@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Assisted-by: Copilot:Claude-Opus-5
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  3 -
 .../tests/amdgpu_dm_connector_test.c          | 73 -------------------
 2 files changed, 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 4e9eb3ff2c90..ce900844602e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -153,9 +153,6 @@ void parse_edid_displayid_vrr(struct drm_connector *connector,
 			      const struct edid *edid);
 int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		 struct amdgpu_hdmi_vsdb_info *vsdb_info);
-int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			const struct edid *edid,
-			struct amdgpu_hdmi_vsdb_info *vsdb_info);
 void amdgpu_dm_connector_funcs_force(struct drm_connector *connector);
 enum dc_status dm_validate_stream_and_context(struct dc *dc,
 					      struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index a54fd9529dc9..83d3be543202 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4874,75 +4874,6 @@ static void dm_test_get_amd_vsdb_supported(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, vsdb_info.replay_mode);
 }
 
-/**
- * dm_test_parse_hdmi_amd_vsdb_null_edid - Test NULL EDID returns -ENODEV
- * @test: The KUnit test context
- */
-static void dm_test_parse_hdmi_amd_vsdb_null_edid(struct kunit *test)
-{
-	struct amdgpu_dm_connector *aconnector;
-	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
-
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-
-	KUNIT_EXPECT_EQ(test,
-			parse_hdmi_amd_vsdb(aconnector, NULL, &vsdb_info),
-			-ENODEV);
-}
-
-/**
- * dm_test_parse_hdmi_amd_vsdb_no_extensions - Test EDID without extensions
- * @test: The KUnit test context
- *
- * An EDID that declares no extension blocks has no CEA block to parse.
- */
-static void dm_test_parse_hdmi_amd_vsdb_no_extensions(struct kunit *test)
-{
-	struct amdgpu_dm_connector *aconnector;
-	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
-	struct edid *edid;
-
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	edid = kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, edid);
-
-	edid->extensions = 0;
-
-	KUNIT_EXPECT_EQ(test,
-			parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info),
-			-ENODEV);
-}
-
-/**
- * dm_test_parse_hdmi_amd_vsdb_no_cea_ext - Test EDID with no CEA extension
- * @test: The KUnit test context
- *
- * An extension block that is not a CEA block leaves no VSDB to parse.
- */
-static void dm_test_parse_hdmi_amd_vsdb_no_cea_ext(struct kunit *test)
-{
-	struct amdgpu_dm_connector *aconnector;
-	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
-	struct edid *edid;
-	u8 *raw;
-
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-
-	/* Base block + one extension block that is NOT a CEA extension. */
-	raw = kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, raw);
-	edid = (struct edid *)raw;
-	edid->extensions = 1;
-	raw[EDID_LENGTH] = DM_TEST_DISPLAYID_EXT;
-
-	KUNIT_EXPECT_EQ(test,
-			parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info),
-			-ENODEV);
-}
-
 /**
  * dm_test_parse_displayid_vrr_null_edid - Test NULL EDID leaves range untouched
  * @test: The KUnit test context
@@ -5647,10 +5578,6 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_amd_vsdb */
 	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
 	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
-	/* parse_hdmi_amd_vsdb */
-	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_null_edid),
-	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_extensions),
-	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_cea_ext),
 	/* parse_edid_displayid_vrr */
 	KUNIT_CASE(dm_test_parse_displayid_vrr_null_edid),
 	KUNIT_CASE(dm_test_parse_displayid_vrr_no_displayid),
-- 
2.55.0

