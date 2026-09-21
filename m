Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A84BC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A04710E933;
	Mon, 21 Sep 2026 15:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SqzMjGGz";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F103C10E943;
 Mon, 21 Sep 2026 15:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005945; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ljSNHs+y51ZZ4z/4x1pAepFaDbtFfHOtzS1eiQpDlDrLHxu0AKYd63k6/1MeeuoiNUQ2t/KSAUMhoedmb7ZoMJ2g3Px1KUD+7FVG/tRqQuR3FIY/uA5HJZpXpgMY+SA9pvvQRq9QMeY/urRpAzxgdB+Qne3cfdpJqmOE4L8T6ME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005945;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DiwDpN9riDDJQcO6V+hK0OwAgWXYH5bbcn0W29vlIso=; 
 b=BMXp3pZ6gKVvowjbqMV9mALWOTrErIUMJZZbGQnfHRueiBNQXy4wcfJPl+PGBfDo4XJ2Pc6lrGGaixVBLHCXyuJ/Z1d0M9HryzRPcG78oqcpZ0GULkFX/fGch3sXdcB8rCNfqsJPk1mYYJX5kbHWyU0+YGYbeirqi+fdzXqRk0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005945; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=DiwDpN9riDDJQcO6V+hK0OwAgWXYH5bbcn0W29vlIso=;
 b=SqzMjGGzJwUZ+VXI+7o8MgXBG1T1uWWFdvKtVqJPV1dDBuFmhnaNntTU9ggZGT+8
 2Ds2KflAFHbrlmAnMeD67vFy9mlTbU228CCkIe62ZYILaYuREeGgHZ49Nsq1vsSJJGt
 YEA5V0xGGS1wLD+a2fxY39D/E7enNUtjIcWTcpZI=
Received: by smtp.zohomail.com with SMTPS id 179000594398149.12293130246803;
 Mon, 21 Sep 2026 08:52:23 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:30 +0200
Subject: [PATCH RFC 04/25] video/hdmi: Add VTEM EMP packing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-4-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

From: Derek Foreman <derek.foreman@collabora.com>

VTEM EMPs are a type of infoframe that is required for Variable Refresh
Rate. Add code to pack them.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/video/hdmi.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/hdmi.h | 19 ++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 45b42f14a750..ed9abc7ad228 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -983,6 +983,10 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame,
 		length = hdmi_vendor_any_infoframe_pack(&frame->vendor,
 							buffer, size);
 		break;
+	case HDMI_INFOFRAME_TYPE_EMP:
+		length = hdmi_emp_infoframe_vtem_pack(&frame->vtem,
+						      buffer, size);
+		break;
 	default:
 		WARN(1, "Bad infoframe type %d\n", frame->any.type);
 		length = -EINVAL;
@@ -994,9 +998,11 @@ EXPORT_SYMBOL(hdmi_infoframe_pack);
 
 static const char *hdmi_infoframe_type_get_name(enum hdmi_infoframe_type type)
 {
-	if (type < 0x80 || type > 0x9f)
+	if (type < 0x7F || type > 0x9f)
 		return "Invalid";
 	switch (type) {
+	case HDMI_INFOFRAME_TYPE_EMP:
+		return "EMP";
 	case HDMI_INFOFRAME_TYPE_VENDOR:
 		return "Vendor";
 	case HDMI_INFOFRAME_TYPE_AVI:
@@ -1516,6 +1522,29 @@ hdmi_vendor_any_infoframe_log(const char *level,
 	}
 }
 
+static void
+hdmi_emp_infoframe_vtem_log(const char *level,
+			    struct device *dev,
+			    const struct hdmi_emp_infoframe_vtem *frame)
+{
+	hdmi_infoframe_log_header(level, dev,
+				  (const struct hdmi_any_infoframe *)frame);
+
+	hdmi_log("    game vrr enabled: %u\n", frame->game_vrr_en);
+	hdmi_log("    fva factor minus 1: %u\n", frame->fva_factor_m1);
+	hdmi_log("    m_const: %u\n", frame->m_const);
+	hdmi_log("    base vertical front porch: %u\n", frame->base_vfront);
+	hdmi_log("    base refresh rate: %u\n", frame->base_refresh_rate);
+}
+
+static void
+hdmi_emp_infoframe_log(const char *level,
+		       struct device *dev,
+		       const union hdmi_infoframe *frame)
+{
+	/* Only support VTEM for now */
+	hdmi_emp_infoframe_vtem_log(level, dev, &frame->vtem);
+}
 /**
  * hdmi_infoframe_log() - log info of HDMI infoframe
  * @level: logging level
@@ -1542,6 +1571,9 @@ void hdmi_infoframe_log(const char *level,
 	case HDMI_INFOFRAME_TYPE_DRM:
 		hdmi_drm_infoframe_log(level, dev, &frame->drm);
 		break;
+	case HDMI_INFOFRAME_TYPE_EMP:
+		hdmi_emp_infoframe_log(level, dev, frame);
+		break;
 	}
 }
 EXPORT_SYMBOL(hdmi_infoframe_log);
@@ -1919,3 +1951,66 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame,
 	return ret;
 }
 EXPORT_SYMBOL(hdmi_infoframe_unpack);
+
+/**
+ * hdmi_emp_infoframe_vtem_init() - initialize an HDMI VTEM EMP
+ * @emp: HDMI VTEM EMP
+ */
+void hdmi_emp_infoframe_vtem_init(struct hdmi_emp_infoframe_vtem *emp)
+{
+	memset(emp, 0, sizeof(*emp));
+	emp->type = HDMI_INFOFRAME_TYPE_EMP;
+}
+EXPORT_SYMBOL(hdmi_emp_infoframe_vtem_init);
+
+/**
+ * hdmi_emp_infoframe_vtem_pack() - pack a vtem into a binary buffer
+ * @vtem: pointer to &struct hdmi_emp_infoframe_vtem to pack
+ * @buffer: pointer to pre-allocated output buffer
+ * @size: maximum size in bytes of @buffer
+ *
+ * Pack a VTEM infoframe struct into a binary buffer in a way that's suitable
+ * to be sent out over the wire.
+ *
+ * Returns the number of bytes packed into the binary buffer or a negative
+ * error code on failure.
+ */
+ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vtem,
+				     void *buffer, size_t size)
+{
+	u8 *ptr = buffer;
+
+	if (size < HDMI_INFOFRAME_SIZE(VTEM))
+		return -EINVAL;
+
+	/* 4 bits max */
+	if (vtem->fva_factor_m1 > 0xF)
+		return -EINVAL;
+
+	memset(buffer, 0, size);
+
+	/* Header Data */
+	ptr[0] = vtem->type;
+	ptr[1] = BIT(7) | BIT(6);
+	ptr[2] = 0;
+
+	ptr[3] = BIT(7) | BIT(2);
+
+	ptr[4] = 0;
+	ptr[5] = 1;
+	ptr[6] = 0;
+	ptr[7] = 1;
+	ptr[8] = 0;
+	ptr[9] = 4;
+
+	/* This is where the VTEM part starts */
+	ptr[10] = (vtem->fva_factor_m1 << 4) |
+		  (vtem->m_const ? BIT(1) : 0) |
+		  (vtem->game_vrr_en ? BIT(0) : 0);
+	ptr[11] = vtem->base_vfront;
+	ptr[12] = vtem->base_refresh_rate >> 8 & 0x3;
+	ptr[13] = vtem->base_refresh_rate & 0xFF;
+
+	return 14;
+}
+EXPORT_SYMBOL(hdmi_emp_infoframe_vtem_pack);
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index b80a5ee63bb2..71e2b36896af 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -55,6 +55,7 @@ enum hdmi_packet_type {
 };
 
 enum hdmi_infoframe_type {
+	HDMI_INFOFRAME_TYPE_EMP = 0x7F,
 	HDMI_INFOFRAME_TYPE_VENDOR = 0x81,
 	HDMI_INFOFRAME_TYPE_AVI = 0x82,
 	HDMI_INFOFRAME_TYPE_SPD = 0x83,
@@ -76,6 +77,7 @@ enum hdmi_infoframe_type {
 #define HDMI_AUDIO_INFOFRAME_SIZE  10
 #define HDMI_DRM_INFOFRAME_SIZE    26
 #define HDMI_VENDOR_INFOFRAME_SIZE  4
+#define HDMI_VTEM_INFOFRAME_SIZE   10
 
 /*
  * HDMI 1.3a table 5-14 states that the largest InfoFrame_length is 27,
@@ -235,6 +237,18 @@ struct hdmi_drm_infoframe {
 	u16 max_fall;
 };
 
+struct hdmi_emp_infoframe_vtem {
+	enum hdmi_infoframe_type type;
+	unsigned char version;
+	unsigned char length;
+
+	bool game_vrr_en;
+	bool m_const;
+	unsigned char fva_factor_m1;
+	unsigned char base_vfront;
+	u16 base_refresh_rate;
+};
+
 void hdmi_avi_infoframe_init(struct hdmi_avi_infoframe *frame);
 ssize_t hdmi_avi_infoframe_pack(struct hdmi_avi_infoframe *frame, void *buffer,
 				size_t size);
@@ -249,6 +263,10 @@ ssize_t hdmi_drm_infoframe_pack_only(const struct hdmi_drm_infoframe *frame,
 int hdmi_drm_infoframe_check(struct hdmi_drm_infoframe *frame);
 int hdmi_drm_infoframe_unpack_only(struct hdmi_drm_infoframe *frame,
 				   const void *buffer, size_t size);
+void hdmi_emp_infoframe_vtem_init(struct hdmi_emp_infoframe_vtem *frame);
+ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *frame,
+				     void *buffer,
+				     size_t size);
 
 enum hdmi_spd_sdi {
 	HDMI_SPD_SDI_UNKNOWN,
@@ -457,6 +475,7 @@ union hdmi_infoframe {
 	union hdmi_vendor_any_infoframe vendor;
 	struct hdmi_audio_infoframe audio;
 	struct hdmi_drm_infoframe drm;
+	struct hdmi_emp_infoframe_vtem vtem;
 };
 
 ssize_t hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer,

-- 
2.55.0

