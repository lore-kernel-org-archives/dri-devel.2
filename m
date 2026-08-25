Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2006DC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6269510E891;
	Tue, 25 Aug 2026 00:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZz79kho";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD7D10E891
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:15:55 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1994932f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616954; x=1788221754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JixCBqFO+kIVniOqxJ7x/wZ1qVN5j6ydynDyZHBtUY4=;
 b=FZz79khoDfVPTT7l77Vzbsw1V0md9D0YQ1cRPhz4A1fSMXiNHCadAHjQL0uOtrAfcN
 0OJ6Bz6NIINekl0ChxGyw/ZbSgmUt4N+SlgpUsOqEwOsAhXwh4th6xnAzIdb30zCQoWm
 AWFxDh1X0NUHURK8YLG1EpbvlcbrvUmotxD0iej/uepvF5hGdEABR4n2SgXzj0YHJnIn
 m9xAnO01q1mObG9Y0wX4io0gKFZ3vtr5QxB/SKuBTQvk/bqcGZeWUaqeKCeBgoV0SsNN
 i5wVP9TKAe3MxEuAVS5mzqVjERRF+1P11hHmpZAWHlqo2atJs9Rndt+aPkiW8u7peOyO
 vRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616954; x=1788221754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JixCBqFO+kIVniOqxJ7x/wZ1qVN5j6ydynDyZHBtUY4=;
 b=DT8vllzXa3MbG7OWclus0dWSrpzeYLCNI9OD2mWthzAPReTuxeNxu5dB2zekJ8MERU
 wwOsOgAf+C2UQM4jSCey/VeiMYzOCZ7PJ8T8rUK67MUhVN0FuN8nTXn1IYqXcli/jwex
 H26hleLesYgyN8RjwnpPsOntcaehU+vaJgQHoMXpk+7tkySpnBgPacPdj1sYPXCkeJyu
 5hvmg9PTlX73kCrv7N3GCWg0CJPeBK1L+/z/0IYfMxWscxn8Raa/QCctk2n/fqFpe4XJ
 B1FcBBnlot6jJOQn3DWQuDV6dQS7vRHdsXPO2QxH3e2mBHz02T3d98x7Isgx5/ZzBbHf
 loaw==
X-Gm-Message-State: AFuF++mQgglFJdF6FqjvhXHg62fDJVufRALVpKK4vZ0Ds9MkQiTxjWjl
 khjf6ZMBbnOAGyEdn8ycEbSlRmNFxUSQc1RRZ4MuXOmHL0IJt2D5N4l/
X-Gm-Gg: AR+sD11KHoJf+/Xkjx5RLmIJK5umXTJd1e0ZiYcFAaISUT3vl/i5kcxYuxcavc1UcDp
 dzao202ZmUCdI0B83Q1Ql7kJ2yE+k+sqzI6ayFphiNUw7n4va/YSkqmKiFDks6zwByVuqldC8J2
 0v5MbfJOiIl9q5Tw80qwpD90tvt8VFHs764gOJ9fLJbUvhk4O39YBeesJR+qLVpYZ84LB5rpSyw
 DRm0F6dfLq0zjFg73/VApD52ltdsx1PQsXFohy6x1jmgeF+FVBLC8jc9OLcqeSddWOk6Q2FiXC+
 9HYpnIlVjGnBVXcxMg6kvi7FJ+lR0ArZP4rGGtZHix+rDkl6Kioey6sWz0MGL9z4aZp1P6hEJ47
 c627lDstBL7YoBaIfNfr6GGml8AurtpHaoo11HXNp2RpnpJCdbVrjRauAnmMXXeuKP1FL/S0Zft
 YHexEb5pOGemvmhmnv2ZAfN346ygWjjJs6iaIHPd2CvnpTcD8CohqHMpyhm/9fkI9Kj30hm0NOB
 5P7bQ==
X-Received: by 2002:a05:6000:310f:b0:47f:9662:85fe with SMTP id
 ffacd0b85a97d-482d9f613b0mr2484359f8f.16.1787616953826; 
 Mon, 24 Aug 2026 17:15:53 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:15:52 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v3 10/10] drm/nouveau: honor HF-EEODB EDIDs by converting to
 struct drm_edid
Date: Tue, 25 Aug 2026 04:14:08 +0400
Message-ID: <20260825001408.14219-11-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

HDMI 2.1 sinks ship HF-EEODB EDIDs. Byte 126 deliberately claims one
extension block for legacy sources, and the true count lives in the CTA
block's first data block. Their high-refresh timings sit in DisplayID
extension blocks 2+.

The kernel already reads these EDIDs whole, and on GSP boards RM returns
the full EDID with its true size. However, nouveau then hands the buffer
to the legacy API which sizes the EDID from byte 126 so the DisplayID
blocks are not parsed/exposed and the sysfs blob truncates to 256 bytes.
The mode list then tops out at the CTA VICs.

Convert to the struct drm_edid API, which carries the real size.
Read via drm_edid_read_ddc()/drm_edid_read_switcheroo() where an
adapter exists, and serve RM's buffer through drm_edid_read_custom()
with a block-reading callback where not, which also routes the GSP
path through drm's block validation and the debugfs EDID override.

A failed RM read now takes the same "no EDID" path as an empty DDC read
which stops it from leaking the runtime-PM reference detect() holds. The
property, display_info, and mode list go through
drm_edid_connector_update()/_add_modes() and every EDID source is
funneled through nouveau_connector_set_edid() so all of them reach the
property that drm_edid_connector_add_modes() reads from.

nouveau_acpi_edid() now returns a drm_edid sized from the EDID's
extension count but never past the length _DDC actually returned, so
padded buffers pass and truncated ones are rejected, and every
firmware-provided EDID (OF, ACPI, VBIOS-embedded) is validated with
drm_edid_valid(). An invalid one is treated as no EDID. get_modes()
re-syncs the property from the connector's copy when the probe helper
has cleared it for a forced-off connector, before adding modes.

The few raw EDID readers are converted along with it, so no raw struct
edid pointer is kept. Ownership and freeing move to the drm_edid. MST
connectors keep their separate legacy path.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv04/dfp.c      |   5 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |   4 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c      |  32 ++++-
 drivers/gpu/drm/nouveau/nouveau_acpi.h      |  10 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 148 +++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_connector.h |  12 +-
 6 files changed, 163 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
index c9f96ec8455d..00eb2aacbe93 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
@@ -344,9 +344,8 @@ static void nv04_dfp_mode_set(struct drm_encoder *encoder,
 		regp->fp_control |= (2 << 24);
 	if (nv_encoder->dcb->type == DCB_OUTPUT_LVDS) {
 		bool duallink = false, dummy;
-		if (nv_connector->edid &&
-		    nv_connector->type == DCB_CONNECTOR_LVDS_SPWG) {
-			duallink = (((u8 *)nv_connector->edid)[121] == 2);
+		if (nv_connector->spwg_links) {
+			duallink = nv_connector->spwg_links == 2;
 		} else {
 			nouveau_bios_parse_lvds_table(dev, output_mode->clock,
 						      &duallink, &dummy);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 2c66e480b511..add19d479ebe 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1803,8 +1803,8 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 			lvds_dual = bios->fp.dual_link;
 			lvds_8bpc = bios->fp.if_is_24bit;
 		} else {
-			if (nv_connector->type == DCB_CONNECTOR_LVDS_SPWG) {
-				if (((u8 *)nv_connector->edid)[121] == 2)
+			if (nv_connector->spwg_links) {
+				if (nv_connector->spwg_links == 2)
 					lvds_dual = true;
 			} else
 			if (mode->clock >= bios->fp.duallink_transition_clk) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 21b56cc7605c..9e6906490db5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -360,9 +360,10 @@ void nouveau_unregister_dsm_handler(void) {}
 void nouveau_switcheroo_optimus_dsm(void) {}
 #endif
 
-void *
+const struct drm_edid *
 nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 {
+	const struct drm_edid *drm_edid;
 	struct acpi_device *acpidev;
 	int type, ret;
 	void *edid;
@@ -384,7 +385,34 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 	if (ret < 0)
 		return NULL;
 
-	return edid;
+	/* Take what _DDC returned as-is first as its length is the only one that
+	 * can describe an HF-EEODB EDID, whose block count is not the byte 126
+	 * one. Only if that does not validate fall back to trimming the buffer
+	 * to the byte 126 size, which is what the padding some firmware appends
+	 * needs.
+	 */
+	drm_edid = drm_edid_alloc(edid, ret);
+	if (drm_edid && !drm_edid_valid(drm_edid)) {
+		drm_edid_free(drm_edid);
+		drm_edid = NULL;
+
+		if (ret > EDID_LENGTH) {
+			int trimmed = EDID_LENGTH *
+				      (1 + ((const struct edid *)edid)->extensions);
+
+			if (trimmed < ret)
+				drm_edid = drm_edid_alloc(edid, trimmed);
+			if (drm_edid && !drm_edid_valid(drm_edid)) {
+				drm_edid_free(drm_edid);
+				drm_edid = NULL;
+			}
+		}
+	}
+	kfree(edid);
+
+	if (!drm_edid)
+		drm_dbg_kms(dev, "Invalid EDID from ACPI _DDC\n");
+	return drm_edid;
 }
 
 bool nouveau_acpi_video_backlight_use_native(void)
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.h b/drivers/gpu/drm/nouveau/nouveau_acpi.h
index e39dd8b94b8b..bc3ccca7b338 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.h
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.h
@@ -4,13 +4,15 @@
 
 #define ROM_BIOS_PAGE 4096
 
+struct drm_edid;
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_X86)
 bool nouveau_is_optimus(void);
 bool nouveau_is_v1_dsm(void);
 void nouveau_register_dsm_handler(void);
 void nouveau_unregister_dsm_handler(void);
 void nouveau_switcheroo_optimus_dsm(void);
-void *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
+const struct drm_edid *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
 bool nouveau_acpi_video_backlight_use_native(void);
 void nouveau_acpi_video_register_backlight(void);
 #else
@@ -19,7 +21,11 @@ static inline bool nouveau_is_v1_dsm(void) { return false; };
 static inline void nouveau_register_dsm_handler(void) {}
 static inline void nouveau_unregister_dsm_handler(void) {}
 static inline void nouveau_switcheroo_optimus_dsm(void) {}
-static inline void *nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector) { return NULL; }
+static inline const struct drm_edid *
+nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
+{
+	return NULL;
+}
 static inline bool nouveau_acpi_video_backlight_use_native(void) { return true; }
 static inline void nouveau_acpi_video_register_backlight(void) {}
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b0b0ad9a0c24..3738c23215c5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -397,7 +397,7 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	nvif_event_dtor(&nv_connector->irq);
 	nvif_event_dtor(&nv_connector->hpd);
-	kfree(nv_connector->edid);
+	drm_edid_free(nv_connector->drm_edid);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 	if (nv_connector->aux.transfer)
@@ -469,6 +469,36 @@ nouveau_connector_ddc_detect(struct drm_connector *connector)
 	return found;
 }
 
+static void
+nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
+			   const struct drm_edid *drm_edid)
+{
+	if (nv_connector->drm_edid == drm_edid)
+		return;
+
+	/* Updates the EDID property and display_info with HF-EEODB-aware
+	 * sizing. The legacy helpers truncate both to what EDID byte 126
+	 * admits, hiding the DisplayID extension blocks that carry the
+	 * high-refresh timings.
+	 */
+	drm_edid_connector_update(&nv_connector->base, drm_edid);
+
+	drm_edid_free(nv_connector->drm_edid);
+	nv_connector->drm_edid = drm_edid;
+
+	/* The SPWG link-count byte lives in a vendor descriptor drm has no
+	 * accessor for. Peek at it once here so nothing else needs the raw
+	 * EDID.
+	 */
+	nv_connector->spwg_links = 0;
+	if (nv_connector->type == DCB_CONNECTOR_LVDS_SPWG) {
+		const u8 *raw = (const u8 *)drm_edid_raw(drm_edid);
+
+		if (raw)
+			nv_connector->spwg_links = raw[121] == 2 ? 2 : 1;
+	}
+}
+
 static struct nouveau_encoder *
 nouveau_connector_of_detect(struct drm_connector *connector)
 {
@@ -490,8 +520,17 @@ nouveau_connector_of_detect(struct drm_connector *connector)
 		int idx = name ? name[strlen(name) - 1] - 'A' : 0;
 
 		if (nv_encoder->dcb->i2c_index == idx && edid) {
-			nv_connector->edid =
-				kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+			const struct drm_edid *drm_edid =
+				drm_edid_alloc(edid, EDID_LENGTH);
+
+			/* Firmware-provided, so validate it like the DDC
+			 * readers would.
+			 */
+			if (drm_edid && !drm_edid_valid(drm_edid)) {
+				drm_edid_free(drm_edid);
+				drm_edid = NULL;
+			}
+			nouveau_connector_set_edid(nv_connector, drm_edid);
 			return nv_encoder;
 		}
 	}
@@ -546,17 +585,23 @@ nouveau_connector_set_encoder(struct drm_connector *connector,
 	}
 }
 
-static void
-nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
-			   struct edid *edid)
+struct nouveau_rm_edid {
+	u8 *data;
+	size_t size;
+};
+
+static int
+nouveau_connector_rm_edid_block(void *context, u8 *buf, unsigned int block,
+				size_t len)
 {
-	if (nv_connector->edid != edid) {
-		struct edid *old_edid = nv_connector->edid;
+	struct nouveau_rm_edid *rm = context;
+	size_t offset = (size_t)block * EDID_LENGTH;
 
-		drm_connector_update_edid_property(&nv_connector->base, edid);
-		kfree(old_edid);
-		nv_connector->edid = edid;
-	}
+	if (offset + len > rm->size)
+		return -EINVAL;
+
+	memcpy(buf, rm->data + offset, len);
+	return 0;
 }
 
 static enum drm_connector_status
@@ -590,22 +635,37 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
 	if (nv_encoder) {
-		struct edid *new_edid = NULL;
+		const struct drm_edid *new_edid = NULL;
 
 		if (nv_encoder->i2c) {
 			if ((vga_switcheroo_handler_flags() & VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
 			    nv_connector->type == DCB_CONNECTOR_LVDS)
-				new_edid = drm_get_edid_switcheroo(connector, nv_encoder->i2c);
+				new_edid = drm_edid_read_switcheroo(connector, nv_encoder->i2c);
 			else
-				new_edid = drm_get_edid(connector, nv_encoder->i2c);
+				new_edid = drm_edid_read_ddc(connector, nv_encoder->i2c);
 		} else {
-			ret = nvif_outp_edid_get(&nv_encoder->outp, (u8 **)&new_edid);
-			if (ret < 0)
-				return connector_status_disconnected;
+			struct nouveau_rm_edid rm = {};
+
+			/* RM (which owns the DDC pads on GSP boards) reads the
+			 * EDID whole and returns its true size, which for an
+			 * HF-EEODB EDID exceeds what byte 126 admits. Serve it
+			 * through drm's block reader so EEODB sizing, block
+			 * validation, and the debugfs EDID override all apply.
+			 * A failed read is treated like an empty DDC read,
+			 * which releases the runtime-PM reference.
+			 */
+			ret = nvif_outp_edid_get(&nv_encoder->outp, &rm.data);
+			if (ret >= 0) {
+				rm.size = ret;
+				new_edid = drm_edid_read_custom(connector,
+								nouveau_connector_rm_edid_block,
+								&rm);
+				kfree(rm.data);
+			}
 		}
 
 		nouveau_connector_set_edid(nv_connector, new_edid);
-		if (!nv_connector->edid) {
+		if (!nv_connector->drm_edid) {
 			NV_ERROR(drm, "DDC responded, but no EDID for %s\n",
 				 connector->name);
 			goto detect_analog;
@@ -626,7 +686,7 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 				    nv_partner->dcb->type == DCB_OUTPUT_TMDS) ||
 				   (nv_encoder->dcb->type == DCB_OUTPUT_TMDS &&
 				    nv_partner->dcb->type == DCB_OUTPUT_ANALOG))) {
-			if (nv_connector->edid->input & DRM_EDID_INPUT_DIGITAL)
+			if (drm_edid_is_digital(nv_connector->drm_edid))
 				type = DCB_OUTPUT_TMDS;
 			else
 				type = DCB_OUTPUT_ANALOG;
@@ -638,7 +698,8 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		conn_status = connector_status_connected;
 
 		if (nv_encoder->dcb->type == DCB_OUTPUT_DP)
-			drm_dp_cec_set_edid(&nv_connector->aux, nv_connector->edid);
+			drm_dp_cec_attach(&nv_connector->aux,
+					  connector->display_info.source_physical_address);
 
 		goto out;
 	} else {
@@ -670,7 +731,7 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 	}
 
  out:
-	if (!nv_connector->edid)
+	if (!nv_connector->drm_edid)
 		drm_dp_cec_unset_edid(&nv_connector->aux);
 
 	pm_runtime_mark_last_busy(dev->dev);
@@ -686,7 +747,7 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder = NULL;
-	struct edid *edid = NULL;
+	const struct drm_edid *edid = NULL;
 	enum drm_connector_status status = connector_status_disconnected;
 
 	nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
@@ -697,7 +758,7 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	if (!drm->vbios.fp_no_ddc) {
 		status = nouveau_connector_detect(connector, force);
 		if (status == connector_status_connected) {
-			edid = nv_connector->edid;
+			edid = nv_connector->drm_edid;
 			goto out;
 		}
 	}
@@ -733,11 +794,20 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * stored for the panel stored in them.
 	 */
 	if (!drm->vbios.fp_no_ddc) {
-		edid = (struct edid *)nouveau_bios_embedded_edid(dev);
-		if (edid) {
-			edid = kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+		const void *embedded = nouveau_bios_embedded_edid(dev);
+
+		if (embedded) {
+			edid = drm_edid_alloc(embedded, EDID_LENGTH);
+			/* The panel is there either way, so report it
+			 * connected and let the probe helper fall back to a
+			 * default mode if the EDID itself is unusable.
+			 */
 			if (edid)
 				status = connector_status_connected;
+			if (edid && !drm_edid_valid(edid)) {
+				drm_edid_free(edid);
+				edid = NULL;
+			}
 		}
 	}
 
@@ -886,7 +956,7 @@ nouveau_connector_detect_depth(struct drm_connector *connector)
 	bool duallink;
 
 	/* if the edid is feeling nice enough to provide this info, use it */
-	if (nv_connector->edid && connector->display_info.bpc)
+	if (nv_connector->drm_edid && connector->display_info.bpc)
 		return;
 
 	/* EDID 1.4 is *supposed* to be supported on eDP, but, Apple... */
@@ -913,9 +983,8 @@ nouveau_connector_detect_depth(struct drm_connector *connector)
 	/* LVDS: DDC panel, need to first determine the number of links to
 	 * know which if_is_24bit flag to check...
 	 */
-	if (nv_connector->edid &&
-	    nv_connector->type == DCB_CONNECTOR_LVDS_SPWG)
-		duallink = ((u8 *)nv_connector->edid)[121] == 2;
+	if (nv_connector->spwg_links)
+		duallink = nv_connector->spwg_links == 2;
 	else
 		duallink = mode->clock >= bios->fp.duallink_transition_clk;
 
@@ -973,12 +1042,17 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 		nv_connector->native_mode = NULL;
 	}
 
-	if (nv_connector->edid)
-		ret = drm_add_edid_modes(connector, nv_connector->edid);
-	else
-	if (nv_encoder->dcb->type == DCB_OUTPUT_LVDS &&
-	    (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||
-	     drm->vbios.fp_no_ddc) && nouveau_bios_fp_mode(dev, NULL)) {
+	if (nv_connector->drm_edid) {
+		/* The probe helper clears the property and display_info for
+		 * a forced-off connector without calling detect(). Re-sync
+		 * from our copy then, since add_modes() reads the property.
+		 */
+		if (!connector->edid_blob_ptr)
+			drm_edid_connector_update(connector, nv_connector->drm_edid);
+		ret = drm_edid_connector_add_modes(connector);
+	} else if (nv_encoder->dcb->type == DCB_OUTPUT_LVDS &&
+		   (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||
+		    drm->vbios.fp_no_ddc) && nouveau_bios_fp_mode(dev, NULL)) {
 		struct drm_display_mode mode;
 
 		nouveau_bios_fp_mode(dev, &mode);
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index 0608cabed058..eb292d2ba4bc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -43,7 +43,7 @@
 
 struct nvkm_i2c_port;
 struct dcb_output;
-struct edid;
+struct drm_edid;
 
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 struct nouveau_backlight {
@@ -121,6 +121,13 @@ struct nouveau_connector {
 	struct drm_connector base;
 	enum dcb_connector_type type;
 	u8 index;
+	/* LVDS_SPWG panels state their link count in EDID descriptor 4 (SPWG
+	 * byte 0x79), cached by nouveau_connector_set_edid() so nothing else
+	 * needs the raw EDID. 0 = unknown (not an SPWG panel, or no EDID) and
+	 * callers fall back to their transition-clock/VBIOS heuristics;
+	 * 1 = single link; 2 = dual link.
+	 */
+	u8 spwg_links;
 
 	struct nvif_conn conn;
 	u64 hpd_pending;
@@ -137,7 +144,8 @@ struct nouveau_connector {
 	int scaling_mode;
 
 	struct nouveau_encoder *detected_encoder;
-	struct edid *edid;
+	/* Owner of the sink's EDID, HF-EEODB-complete. */
+	const struct drm_edid *drm_edid;
 	struct drm_display_mode *native_mode;
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight;
-- 
2.55.0

