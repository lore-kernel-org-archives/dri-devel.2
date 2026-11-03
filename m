Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA26082BFE
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=oMms6RQF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44FB710F52E;
	Tue,  3 Nov 2026 11:36:14 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606A010F522
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:02 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F59C227A;
 Tue,  3 Nov 2026 12:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793705624;
 bh=0aVe2IheUet+lwru+DZezYT4mSteSH+CCdhQ6rpbnik=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oMms6RQFo4uqyKAlU6IsrpoUhFcTPm9uTaMc5joM9EymDPvSqk1QOA/Pe5u+4lmSf
 Fb/QFsjBRbAqTxqPykIsUugXZQMNjuMLi9JW8nkhV7Xt0DZetpEtBJYWTokQlW1NgQ
 zMUWcoAPVDzYcDPl8SnOLDvJaAAHagc9Fg/mgRTQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 03 Nov 2026 13:34:24 +0200
Subject: [PATCH v5 04/15] drm/tidss: Drop the tied off video port check
 from mode validation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-beagley-ai-display-v5-4-f1c8d0e52bb4@ideasonboard.com>
References: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
In-Reply-To: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=0aVe2IheUet+lwru+DZezYT4mSteSH+CCdhQ6rpbnik=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq6ccWGRxgpFyxDhWymlJkVQfH613vPohuHWAYn
 U/lrxFvfmKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaunHFgAKCRD6PaqMvJYe
 9U7WD/9Zn1VUhrx3mDBNjZzGKxt1lrv/ocb/usGlQkza9tXVvpipZXn3KQBcQ+RFJIEWw9X88MZ
 YdYbv6S46u8ACrd9SHAOpUN65bC87GV79Rfcfa8sZ0vz7y2+yttf1aeAfl5zAnZZd/IyIG0dUho
 9T76UZXFpnwdswrNP8qwdbPQiKOVSp7lYW78HAWRzBZedrYYlVRI6gv4mHd9yCX5MQgP83P2deI
 3QOMmAHapiv+MY3U945xk51fQx0VIpnDQI1Y6S3fjNq8UXnjBubx20Ol4BaSHEVsLaONtAkuaAN
 Bx32smTfctUrb092VL9PniO7jWE71ngoGWvI1v/lQjYSiGrBAC4tysCMisTThZafay6kE2Zt6CM
 /W44wwIj1ffHmk50Fu4umomvjs7VlkhW1HFXtkSqitJooAGuziORtl8qD9JzAAX+affIUnsQ5so
 MHpkIVM/Quwa7OkEqef0VLm166cUN5L4RudH7UKTSA2pne8QWce178kTe566L4ue2QvVF42t3hZ
 uZW1Js2VOZBL0kdzxFtQx7VaathAcKWKIGCnNxa42Vv1pxf+3Y2F7MfjBbyqXx5kgZCWVq1pnkJ
 YuX14edaoKq0tcIwK4KS7WevueaB8wop0zLs0B4IFjDObNl2LsnREl5TSNhn41MkVEBVOPAuHtu
 /PFPAbGlPLOCoqQ==
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

dispc_vp_mode_valid() WARNs and rejects every mode on a video port that
is marked as DISPC_VP_TIED_OFF in the 'vp_bus_type' feat.

The check is redundant, as nothing in the DT will be connected to the
tied off VP, and thus the driver can never do a mode_valid call for it.

Remove the check, and rely on the DT to be correct.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index efdabf046d64..8c537280faf5 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1342,12 +1342,6 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 const struct drm_display_mode *mode)
 {
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
-	enum dispc_vp_bus_type bus_type;
-
-	bus_type = dispc->feat->vp_bus_type[hw_videoport];
-
-	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
-		return MODE_BAD;
 
 	if (mode->hdisplay > 4096)
 		return MODE_BAD;

-- 
2.43.0

