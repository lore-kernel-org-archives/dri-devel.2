Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08A606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=efLf/fZZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F91B10F88C;
	Tue,  3 Nov 2026 21:38:20 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBCC10E1C6;
 Tue,  3 Nov 2026 21:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTc/7GEEHGtFYQC/GGSSRB1Uo3TSfROmcLRB2fdb4qat3VL7SWZK0PLYLNnKIOtwbnp6vUWZSDGenSMOOBr5AtE3ymdUVk5rTJ8aRHsQsWmweu+l5P8xLD4kFAbRpAj0/5/95gl/eWzOttaRHSzyZgZtPoVZt7DNiTTpEfKhQzLRt0fwk1Xp7agUyg1q8+VpoyqXdyI5VzIt6pRAGzC17yMWXcWqW2Pfl/Rj2I6ecnMD+VlxjHATNgOOI9O+8eC+qADrjCQu6tLkUX73JgaMs0RKpzxD+tuuo3vwOGe6RBw2GJVLg/86a4mBhgnjOD9qXLPHUyAWYabQyqPhoBA3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWgZpTt9xqCoJNwaGEsWZVFEXmZ5kFuE9cGpMWjTlrA=;
 b=WRD7C/km668rkCd2ySiqOZfB0htKqhYTDZ0VKHdGFrrvAyBmyeZAQpW2B1Lo5mn26Su4S4GU9ZpG02QIxoFUoBYjr3JD7aGIxjXCvmEpz+ih+tr4NrEjEopXPODdat+Rk+2g4lhZD8XaOY71862A+TRNngTKjs6k32VV5jo/l+lTni1fBrYjduyr+auq/8vx/UinjmmxfWrGv21fz/nAiKgu77rwVn9I9l6/v5JBWC0JH6kYq2GlzCSRJy93qTYI7n+bUzJWBPmDIHO4Ng5SnS8LqXgpqpDhllBO+x1Xf43ikYbR+q73iT++hoVHfPaILx3q3hyRX9VyjEiSTHJmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWgZpTt9xqCoJNwaGEsWZVFEXmZ5kFuE9cGpMWjTlrA=;
 b=efLf/fZZmHhn7ClvxYF0FMpOBUFMNkjHqoRrLbRtMkxeMzt2di3NQoiIH+HivE8GQppikojq5w89Ed7ZdpMn2gSZC4lWVMMrYfiDH27fe5J6U6XY10LiPkWCVibObEoFnc4bDGXlFlF1HbI8CpRyNgm0CPrNMFu7QocS6CvoLyw=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:09 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::13) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:05 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:05 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 04/13] drm/atomic: validate DMA 3D LUT colorop framebuffer
Date: Tue, 3 Nov 2026 16:37:47 -0500
Message-ID: <20261103213756.618024-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c0d779-119a-41fb-d554-08df39f2c001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261102123227099003|261102130727099003|5023799004|11063799006|261021121427099003|261009220027099003|261009223027099003|261022105027099003|261009221227099003|261028144727099003|261009223327099003|56012099006|261022075727099003|261009221727099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 5tvyy+F4zkegm7GhWUy2LeMQZasSeQ2pwMoVEe5cXSrhvsITZpzr9Eao5a3Wv5W9PyQsGfIfEIzRt86fpWRIFcPS1PfWUhVttEo72lkF/4WZ4EVpzYVk+NnfsWJ6U6yZwhQ542LvpAQhKJnRWQap0NbCEm18MtC1yaDqd4D8qRe6DY1BCUAkLG1PyDNf/xAe22a33hEEQcUpTEYjXYr4jtKWg2mtkcnYs0g1OlIxjRV4kdmYwidrhGMwr6X6+RNv9yrhK2ycYL8EH/Uf9e+fKvGmTGgrOawkGd16ID0ujwg6fyk2TdcKYNRz4CJ/vbrMFZOe0bp+ufqw1sO5+hlEm5xlQjiOfXSjLC5hyMm3qignB4iNNnNnbF4P3H9OH5cfpue+gBNTHscShXlM7WhoYfbR5wirPQxFGeD+deE4us5hSSycPKwqmbfVXtAlG6i/7vfDbDbEaZD7bhgJiiyjj4EVEzPSUk7hULo14fITUt5yr+Kl4rT9H6dhYerG0B0iIMHxA+YDmtMOPlVW/FzRbJO+hjlb+5PJdOYRgzlD49Cs/JKTbSql/ePF4XwigEDOUZLSN0wdt0PpiG5wy3PPDwa3gsOPqQDXfq/2IUkFyOTYd/UnyoLwc6v7e4FdqmMRZxgsAweG8JXXC5lP8kTOu4iqJk+49rX3l83bGjljvU26nkg47yFh7G8r62Gh/+jt2/rVaS2s8A1vpKGfgQKNsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261102123227099003)(261102130727099003)(5023799004)(11063799006)(261021121427099003)(261009220027099003)(261009223027099003)(261022105027099003)(261009221227099003)(261028144727099003)(261009223327099003)(56012099006)(261022075727099003)(261009221727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ReNbN3tCLL9f0Y7C6vyKVFDuqbQRF8fIlRnTcmUYWIY29KPlP3/tOxZl/EuSMLfOQtjAJAcR0hLdKYIJaK5zssItkGDegKgCxiDKoZd3u1vMXJC/YYwuvjabwYsJb+bEA0wG1UCDWsxWttWuEXgY01kjDbYxnB/XaTRXgTJl7kTblHGoCFGTc5ujDx93hri1WnhBk2JShjaRa8hTWJNG7740KGm2qTDr+/EwsFm+7Wvt1kAtglc6e07ugZjwUndZp8Vllk/+GP1e75C65nTSU8iJsyTo/bmxbR4G/L9KtY60NNlAFou4G9DjsUbfLING1/wDP7aABgQiI5ZQ7TLXBY8lrG3v0tcCRAeiMRPpjoTVTHUKhs746RuopY29lGxsgChTZk17Y6dzm7+FapXqXVQveGDHdPy4jLauI+4DKC2sWPTvS2YOQBYhj97l/3pb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:07.5669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c0d779-119a-41fb-d554-08df39f2c001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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

Add a core atomic check for DRM_COLOROP_3D_LUT_DMA colorops. When the
colorop is enabled (not bypassed), validate the selected LUT_3D_FORMAT
index and require a framebuffer whose fourcc, modifier, pitch and
dimensions match the advertised drm_mode_3dlut_mode entry: width equal to
the cube edge and height equal to lut_size^2 (due to the 2D flattening
of the cube). Driver-specific constraints are left to the driver's own
atomic_check.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 158f41eae76f..a6f1be7ce76c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1745,6 +1745,57 @@ drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
 }
 EXPORT_SYMBOL(drm_atomic_add_affected_colorops);
 
+static int drm_atomic_colorop_check(struct drm_colorop *colorop,
+				    struct drm_colorop_state *new_colorop_state)
+{
+	const struct drm_mode_3dlut_mode *modes, *mode;
+	struct drm_framebuffer *fb = new_colorop_state->fb;
+	u32 num_modes;
+
+	if (colorop->type != DRM_COLOROP_3D_LUT_DMA)
+		return 0;
+
+	/* Nothing to validate while the colorop is bypassed. */
+	if (colorop->bypass_property && new_colorop_state->bypass)
+		return 0;
+
+	if (!colorop->lut_3d_formats_blob)
+		return -EINVAL;
+
+	num_modes = colorop->lut_3d_formats_blob->length /
+		    sizeof(struct drm_mode_3dlut_mode);
+	if (new_colorop_state->lut_3d_format >= num_modes) {
+		drm_dbg_atomic(colorop->dev,
+			       "[COLOROP:%d] LUT_3D_FORMAT %u out of range (have %u)\n",
+			       colorop->base.id, new_colorop_state->lut_3d_format,
+			       num_modes);
+		return -EINVAL;
+	}
+
+	modes = colorop->lut_3d_formats_blob->data;
+	mode = &modes[new_colorop_state->lut_3d_format];
+
+	if (!fb) {
+		drm_dbg_atomic(colorop->dev,
+			       "[COLOROP:%d] enabled DMA 3D LUT without a framebuffer\n",
+			       colorop->base.id);
+		return -EINVAL;
+	}
+
+	if (fb->format->format != mode->format ||
+	    fb->modifier != mode->modifier ||
+	    fb->pitches[0] != mode->pitch ||
+	    fb->width != mode->lut_size ||
+	    fb->height != (u64)mode->lut_size * mode->lut_size) {
+		drm_dbg_atomic(colorop->dev,
+			       "[COLOROP:%d] framebuffer does not match LUT_3D_FORMAT %u\n",
+			       colorop->base.id, new_colorop_state->lut_3d_format);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_check_only - check whether a given config would work
  * @state: atomic configuration to check
@@ -1768,6 +1819,8 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_connector *conn;
 	struct drm_connector_state *conn_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	unsigned int requested_crtc = 0;
 	unsigned int affected_crtc = 0;
 	int i, ret = 0;
@@ -1806,6 +1859,15 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
 		}
 	}
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		ret = drm_atomic_colorop_check(colorop, new_colorop_state);
+		if (ret) {
+			drm_dbg_atomic(dev, "[COLOROP:%d] atomic core check failed\n",
+				       colorop->base.id);
+			return ret;
+		}
+	}
+
 	if (config->funcs->atomic_check) {
 		ret = config->funcs->atomic_check(state->dev, state);
 
-- 
2.56.0

