Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CA606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=oqf0J9td
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C3B1121BC;
	Thu, 29 Oct 2026 10:19:27 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D821121BF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:16 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01E57C4A;
 Thu, 29 Oct 2026 11:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269021;
 bh=KTIXB27nV2CogfdCuFPaogEUe+KRWZ9o8/7dUF1G94I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oqf0J9tdCm4ZUOdAESn4YX7LKcnXqNXV3CUipoDP333o/0Mr/PjDO0x327/wLNYSz
 DwUyL8eo7tmGUAo0wEK5sc/51FVy5AfQOBpPfoIW/G3B9jEw4Vo8kX9Lh9ZKpDJTXu
 rIEtOpZaZ0EP8JQDGZUGmNNjWL8Ijv0ElVPYU4As=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:18:51 +0200
Subject: [PATCH v4 05/14] drm/tidss: Remove the unused vp_bus_type feat
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-5-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3432;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=KTIXB27nV2CogfdCuFPaogEUe+KRWZ9o8/7dUF1G94I=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2XEf8ivNkuiJveCq0pdDBohqKlTqYGkJxv6
 +G6AolREv2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdlwAKCRD6PaqMvJYe
 9SY3D/oCmh0YA1xqzjDpIEzJxurRNfvRtc5r/cFKtelMdyULN6GDNmm0KUtreKMFBg6/HObLuyC
 GY7pJ4Pw2RvWnrEq5bck+XVRPr0FOJ6j+xPssYoajyz1schpcAk0/xtGhfDhmIES/JEeApH4f5N
 wM4Wuj9PScGrQ6A+8BwlJovY0GHW4bstGWyngvoSasoOptTTwVviGMEBbI6Wo5J+Cy08IGvYk7z
 4otFGUqsERwbUjSxV71POoENnDI2PUYQ8miBVspNIXjf+OcX/Xvqe7hx3w1GKcGr2lufmptfadp
 w0lEULQNuQMsPkAPjxzJTZr5iF4PXz1yRElvVA3kPrNrdShi85uPeE+gOkn7QI1rcvQg2CWznii
 SsPG5Er+DVr3HeTwPtZrVR88lADDuj8W+dnhNv6A/pC3Y/0tXQWM8RTfOrTGcMjs01Y04yLJs72
 MVvyopn1OieZY3azoyJiy7y85fqZSD5kpOQfNMToNz8aWTkCONJgPD91v1+xPqDaALFykmMJIrs
 yYxIOJxcDbumbwBM521pXNGDSKzpxX4xnSCkCxIff9SubczHeBgeeGWfswr51x4x4B/zs0F2v3I
 cLK3ydm49d0c8hJ7B2Oe7iNUL6shvhx8KLWcHwch9ZHiSQUg2s+1aZyps1l7dl3tO6MX3x9oso/
 FhlGauVdJpCIIBg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing reads the 'vp_bus_type' feat any more, and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 9 ---------
 drivers/gpu/drm/tidss/tidss_dispc.h | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 8c537280faf5..028cf78df3fe 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -90,7 +90,6 @@ const struct dispc_features dispc_k2g_feats = {
 	.vp_name = { "vp1" },
 	.ovr_name = { "ovr1" },
 	.vpclk_name =  { "vp1" },
-	.vp_bus_type = { DISPC_VP_DPI },
 
 	.vp_feat = { .color = {
 			.has_ctm = true,
@@ -167,7 +166,6 @@ const struct dispc_features dispc_am65x_feats = {
 	.vp_name = { "vp1", "vp2" },
 	.ovr_name = { "ovr1", "ovr2" },
 	.vpclk_name =  { "vp1", "vp2" },
-	.vp_bus_type = { DISPC_VP_OLDI_AM65X, DISPC_VP_DPI },
 
 	.vp_feat = { .color = {
 			.has_ctm = true,
@@ -262,9 +260,6 @@ const struct dispc_features dispc_j721e_feats = {
 	.vp_name = { "vp1", "vp2", "vp3", "vp4" },
 	.ovr_name = { "ovr1", "ovr2", "ovr3", "ovr4" },
 	.vpclk_name = { "vp1", "vp2", "vp3", "vp4" },
-	/* Currently hard coded VP routing (see dispc_initial_config()) */
-	.vp_bus_type =	{ DISPC_VP_INTERNAL, DISPC_VP_DPI,
-			  DISPC_VP_INTERNAL, DISPC_VP_DPI, },
 	.vp_feat = { .color = {
 			.has_ctm = true,
 			.gamma_size = 1024,
@@ -328,7 +323,6 @@ const struct dispc_features dispc_am625_feats = {
 	.vp_name = { "vp1", "vp2" },
 	.ovr_name = { "ovr1", "ovr2" },
 	.vpclk_name =  { "vp1", "vp2" },
-	.vp_bus_type = { DISPC_VP_INTERNAL, DISPC_VP_DPI },
 
 	.vp_feat = { .color = {
 			.has_ctm = true,
@@ -384,8 +378,6 @@ const struct dispc_features dispc_am62a7_feats = {
 	.vp_name = { "vp1", "vp2" },
 	.ovr_name = { "ovr1", "ovr2" },
 	.vpclk_name =  { "vp1", "vp2" },
-	/* VP1 of the DSS in AM62A7 SoC is tied off internally */
-	.vp_bus_type = { DISPC_VP_TIED_OFF, DISPC_VP_DPI },
 
 	.vp_feat = { .color = {
 			.has_ctm = true,
@@ -422,7 +414,6 @@ const struct dispc_features dispc_am62l_feats = {
 	.vp_name = { "vp1" },
 	.ovr_name = { "ovr1" },
 	.vpclk_name =  { "vp1" },
-	.vp_bus_type = { DISPC_VP_DPI },
 
 	.vp_feat = { .color = {
 			.has_ctm = true,
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 3dff391d3fec..ebaf559d56e5 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -59,14 +59,6 @@ struct dispc_errata {
 	bool i2000; /* DSS Does Not Support YUV Pixel Data Formats */
 };
 
-enum dispc_vp_bus_type {
-	DISPC_VP_DPI,		/* DPI output */
-	DISPC_VP_OLDI_AM65X,	/* OLDI (LVDS) output for AM65x DSS */
-	DISPC_VP_INTERNAL,	/* SoC internal routing */
-	DISPC_VP_TIED_OFF,	/* Tied off / Unavailable */
-	DISPC_VP_MAX_BUS_TYPE,
-};
-
 enum dispc_dss_subrevision {
 	DISPC_K2G,
 	DISPC_AM625,
@@ -87,7 +79,6 @@ struct dispc_features {
 	const char *vp_name[TIDSS_MAX_PORTS]; /* Should match dt reg names */
 	const char *ovr_name[TIDSS_MAX_PORTS]; /* Should match dt reg names */
 	const char *vpclk_name[TIDSS_MAX_PORTS]; /* Should match dt clk names */
-	const enum dispc_vp_bus_type vp_bus_type[TIDSS_MAX_PORTS];
 	struct tidss_vp_feat vp_feat;
 	u32 num_vids;
 	struct dispc_vid_info vid_info[TIDSS_MAX_PLANES];

-- 
2.43.0

