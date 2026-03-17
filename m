Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EE9FED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B9610E6DF;
	Tue, 17 Mar 2026 16:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0e2P8hzF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A4710E6DD;
 Tue, 17 Mar 2026 16:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGqVFheaJb3sOaXxtGb3xEBUijJI04V3k6JLAEQmk5UwSoloMc91iLpgFbt+SwrRCbZY6bTZbFfiCyv4WkU9WHUjskjuLyVjyZrhFirYDciRPgN7z41iwmcnfe9+AB211jRzNa60suJ8ZSkMVweaI7KucLG3JlPk88Z1+MTE5n0Fw3zZpnQcpC67HzAkhelVjEFrAyFMZR26Ni5rQa7ZdZDUqcpkObi1UN9SroIDoR/nXz/Z17Je0lnoUtmPcH4Qb1hRTYtHjpuBMajDwp8wpUhMBVfa08B52JtvBy2eaeroOmni6HZKYkBjZG9haHSO9AHpOghgI7to+HwavPAqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDpkMz9fhg7O10XnIOKdfjcoXuiA+yeGc21aO46sESc=;
 b=LZP72DxVwZYI65oEYv7UizaOtX2euVTRWH4R2iMh1nvtgHbBwf+ncWRRJCYR6MklTrQVY0SkS7RimzZGW5Kty7Ch+LzHR/q93p7iEe+weAVSnGyIDKdh2ZAHTPaALpAbUk5shJlYlY35d31M96qW/8h5fNn3mjLF1aK6NJgkZvaUnvr6S+MoeCu39CEyTOMyFZOx2IvCOcOR9DNsXL6bvfOHLn9RuO1IbaguKnYbR+qB3x/kmayeVXi5/+1s7H0f5Dw/CFJPTFGrCPp7OF1rzwuogzK0UanpWOzqy/sN5huMF48LFrYybokd4icvrlDZeEmQYNmg+IV6p2+2sgp1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDpkMz9fhg7O10XnIOKdfjcoXuiA+yeGc21aO46sESc=;
 b=0e2P8hzFdQ76wlRhitxzkcm2YSzaLnT1dvtU5p2EiCMkJ+fOKd/0kVA709Sab/eMopxmcrCd5nv86fyW9imC1+rm87jQVdGC7V6v4T0gwcZxL1d1Ns63CMYfmrIOBGm+VD0y5F0VgfelP3nSBygvsTofvRLdixU1Jxxswg4F1VI=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 16:04:03 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::64) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Tue,
 17 Mar 2026 16:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:02 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:02 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 03/10] drm/atomic: Add CSC colorop state handling
Date: Tue, 17 Mar 2026 12:03:43 -0400
Message-ID: <20260317160350.229028-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9e815f-ee3d-4471-439e-08de843ecee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: f5+iCQ5N3Z8gP0lE0uD228cNfnhdcQjj2nUfhFtyqYmFG444dTILDFLilAHmGiyk1Nx3TUXkQJxUVs1O2P+ctE2eHgq3OsGIaopphAXA0yGn3Wh5VyUP0OJxTIDaVkDtDA+ULXS542tCel1NinFjbnMNlNf7PjhQx3vVPrpibUme0pfx7EG9qgZ3hlarr3UB8KvTlSzk1zATbdKk6c9w82EkmZx/EG59SyluMl5f/hv8l+/vRccQF00+JMw/A0G4CPKZ4TS2cK3LjBVNMVNm8MeKCgQnXtWyFsnYHy3YTPFpFpvornDuFVj0oJZi08/IPkNKlG1OXJbvFy10C+zhCK63XAaJY5LOOu3csLiLOKCA1z1Fl4zzWvXedOAvrElzUWvLRUeCvuAH9R4lWZvtBtaS/MAUBmPaWHH/GE46j4mq6Auw5LcYj4HWXPldMt+6XTpTVfyA5eM1nydI1tQKRZ6oT8lWUDV1kvQeVT7fqIApNWC/GTNPqQhDll5jfGu9qJmU9YLBCi1iIuD/U/3lcs6QXt0iTkhJHrJXra7cS1G8epEMZ3d1tt++HQuXwPKQozBJ1bOc5EljbVTjsxLfX/jnpuTkhSVMuQJSRMm6qhwrHDUG5U2ID8+SKZ1Byyx797lgCXQAd4B1mAyoenHOABzwOamT2lJU83xootzf+r+kNM8Jd2gwQBRuXry4/qEf7L75Pjn8KOoRx4/yAQzIwMhYI7BlenOM7yfeJ7NyomXVWeppwN+56mnuIFruvPeHPz5bi2+QkIG/GHpzFC8kbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aEBwhrC6EUHiVL9VuOVmffw4xT5AdAJ51MwyssWJx1vzyOJ9W2WUSUyu/oKD6x98+hgAAtUT58kbHjzYVUESPZBmiJGZZlLdyF8FllH+kZ3kdL/dH1PKzqBwpILa/mqtO5CZNsQ7glfkFhgSAhBIs9uQB6JjrHIW2/t1cR4fLULvP2bYomP8pBYoVkTyKA/fRTkRGIjtk393e49Y5oCxNuhggCOT+sWAf6IQ1GXCEcMGHSGa3ve5Z39wm/PZZjvA1cs4osmAdcyj4/E6C3N7bOlH0DK9KSi/cyLDVo/ge+JhMHgWYVe1fxoFCX2oF26G8JQU/uieeKcfc90whkGMbNRyRKXfqS7MOatJmLZ+qBeCciGk+LUBCmTr7k8+qgGYoXBv+YGEydyGmNnzAqxsulkkA/vBDHCThEkh82LbD/xkxks1luyMDr3i4neA35KH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:02.6232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9e815f-ee3d-4471-439e-08de843ecee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

Add atomic state property handling for CSC colorop's COLOR_ENCODING
and COLOR_RANGE properties in both set and get paths.

Also add state printing support to display the current color encoding
and range settings when dumping atomic state.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c      | 6 ++++++
 drivers/gpu/drm/drm_atomic_uapi.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 04925166df98..2a7963c9676d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -844,6 +844,12 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 			   drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
 		drm_printf(p, "\tdata blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
+	case DRM_COLOROP_CSC:
+		drm_printf(p, "\tcolor-encoding=%s\n",
+			drm_get_color_encoding_name(state->color_encoding));
+		drm_printf(p, "\tcolor-range=%s\n",
+			drm_get_color_range_name(state->color_range));
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 87de41fb4459..b760d753573c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -754,6 +754,10 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 		state->multiplier = val;
 	} else if (property == colorop->lut3d_interpolation_property) {
 		colorop->lut3d_interpolation = val;
+	} else if (property == colorop->color_encoding_property) {
+		state->color_encoding = val;
+	} else if (property == colorop->color_range_property) {
+		state->color_range = val;
 	} else if (property == colorop->data_property) {
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val);
@@ -787,6 +791,10 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 		*val = colorop->size;
 	else if (property == colorop->lut3d_interpolation_property)
 		*val = colorop->lut3d_interpolation;
+	else if (property == colorop->color_encoding_property)
+		*val = state->color_encoding;
+	else if (property == colorop->color_range_property)
+		*val = state->color_range;
 	else if (property == colorop->data_property)
 		*val = (state->data) ? state->data->base.id : 0;
 	else
-- 
2.53.0

