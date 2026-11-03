Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C65606A33E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=mbRvEgyo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A7710F526;
	Tue,  3 Nov 2026 11:36:06 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4116210F51C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:00 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 003CD1F37;
 Tue,  3 Nov 2026 12:33:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793705621;
 bh=GYgjpXl2KPS6tl9HCXSe+l1hlCq+cTCfu96zrs1c7ic=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mbRvEgyowleKWitEVlzYy7aMCIScMSP6SSSsHWi2VHxW1y3rs3UhaUfGK4iDV9Vh2
 fqNXzdQ2knplWsMDCNgjuwe1z7aMemSPFhkojswfVtqsiSqYH5F1jm//QrQ5SxY4WA
 0t3HH3l6cAfrjt/Do1TcTBli3z7O5dkxZ/5QQURU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 03 Nov 2026 13:34:22 +0200
Subject: [PATCH v5 02/15] drm/tidss: Add helper to identify the AM65x OLDI
 video port
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-beagley-ai-display-v5-2-f1c8d0e52bb4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=GYgjpXl2KPS6tl9HCXSe+l1hlCq+cTCfu96zrs1c7ic=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq6ccWjJkYtFf8AwfRAzUviDW60UcpVCNwa0ZjO
 +7GckPVGVSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaunHFgAKCRD6PaqMvJYe
 9RJ5D/9akc83uWOXUeER0tEGahJD1BqQ1EGsqI4PkWVNJs8/8Tsb3em4jtgEm1SXfWKWQqaFvUq
 g6DQK04ijHDlUtlUJuPrzLsQVeMeJsS2z56Iv8WDxnzKv7CCAi5URagdUt0uJaD49gnC3YBP74m
 0flxQnEpyn+R4yZ6chiwEvGt4Ao8KYS1w+jrxgCtFvEM7pwgPbQw6niVddKHtfUI18N2L2WIkpn
 9ZyFBpg6YidyGFlr5GoblJUH4fjDRfxEUuCZCm8HCDq7vr1BIpdXPb73mr2Pjm/U9ghqpuxqr4J
 ZUqZAJb91kLvYrdGWOjdGIRPM0f+BcgOt7UHN1ZqwQrEBg1Ob3rwbI0nkKGjN/obfvwmCsLzpYL
 BhFgf3D3mJGS/PI8fobtF1swvRu+Hes0W2UTUZnpA0130oiHiYLytgGDn7wIRprK08hPHUqfj5e
 uZzAbndVhL7M1nt78k+vycBVMOmiRRJ1o7MPAfD7o09yuxrdu6O574satL7b1KpF3clLRHPjyNI
 m+4Bs+bnkJrKmAdCL5MNxf7qVCoA5m3rpRu/Z2nBfoxSfZQXmy1b7kguBxAxEJRinKw6S1MHEsS
 TRe3S6AEA7b1VSmbjPIFGFo8VMqE7JyJx8VriSZe6E3Iqd560x1Y8V7tHmaW1zkrz3bJNAGd23M
 qaTrFtJtvuj90PA==
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

On AM65x the OLDI TX is modeled as a part of the DSS, not as a separate
bridge as the newer SoCs do, and is fed by the first video port. To
handle the AM65x OLDI, we check for it in multiple places using the
feat's vp_bus_type.

However, vp_bus_type is problematic concept and should be removed, so
this commit adds a helper function to check for the AM65x OLDI by
looking at the DSS subrevision and videoport number.

No functional change.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
 drivers/gpu/drm/tidss/tidss_dispc.h | 7 +++++++
 drivers/gpu/drm/tidss/tidss_kms.c   | 2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index e516f493d6d9..efdabf046d64 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1034,7 +1034,7 @@ int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
 		return -EINVAL;
 	}
 
-	if (dispc->feat->vp_bus_type[hw_videoport] != DISPC_VP_OLDI_AM65X &&
+	if (!dispc_vp_is_am65x_oldi(dispc->feat, hw_videoport) &&
 	    fmt->is_oldi_fmt) {
 		drm_dbg(dev, "%s: %s is not OLDI-port\n",
 			__func__, dispc->feat->vp_name[hw_videoport]);
@@ -1143,7 +1143,7 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 	if (WARN_ON(!fmt))
 		return;
 
-	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
+	if (dispc_vp_is_am65x_oldi(dispc->feat, hw_videoport)) {
 		dispc_am65x_oldi_tx_power(dispc, true);
 
 		dispc_enable_am65x_oldi(dispc, hw_videoport, fmt);
@@ -1186,7 +1186,7 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 	align = true;
 
 	/* always use DE_HIGH for OLDI */
-	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X)
+	if (dispc_vp_is_am65x_oldi(dispc->feat, hw_videoport))
 		ieo = false;
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_POL_FREQ,
@@ -1229,7 +1229,7 @@ void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
 		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
 			       DISPC_VP_CONTROL_DPIENABLE_MASK);
 
-	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
+	if (dispc_vp_is_am65x_oldi(dispc->feat, hw_videoport)) {
 		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
 
 		dispc_am65x_oldi_tx_power(dispc, false);
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index df3daccf3f31..3dff391d3fec 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -96,6 +96,13 @@ struct dispc_features {
 	bool has_vp_control_dpienable;
 };
 
+/* On AM65x the OLDI TX is a part of the DSS, on the first video port */
+static inline bool dispc_vp_is_am65x_oldi(const struct dispc_features *feat,
+					  u32 hw_videoport)
+{
+	return feat->subrev == DISPC_AM65X && hw_videoport == 0;
+}
+
 extern const struct dispc_features dispc_k2g_feats;
 extern const struct dispc_features dispc_am625_feats;
 extern const struct dispc_features dispc_am62a7_feats;
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index eefe2221bdde..e55e7532e2f7 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -175,7 +175,7 @@ static bool tidss_is_dpi_output(struct tidss_device *tidss, u32 hw_videoport,
 	 * for the OLDI TX on AM65x, we cannot detect this from the DT data, and
 	 * have to special-case it here.
 	 */
-	if (tidss->feat->subrev == DISPC_AM65X && hw_videoport == 0)
+	if (dispc_vp_is_am65x_oldi(tidss->feat, hw_videoport))
 		return false;
 
 	if (!bridge)

-- 
2.43.0

