Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542C2C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00B410E475;
	Sun,  2 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.srl header.i=@kernel.srl header.b="ViMEmTBl";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BABD10E435
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 17:06:59 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so8052135e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.srl; s=google; t=1785690418; x=1786295218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/VNyRxg25eQX1o5yblY5pzpZRITiV9Czj9RlgyEyn0w=;
 b=ViMEmTBl5iBNTy/NLY6vN3RTrODU1eM54zj7shf4yIqvNdGV7E+9HTtQSyE+Hs+YPO
 uRtoll1jrVpdVAw9uQfi1EU+I49HOeQxK85a8pyU14Ce4cXOIM0TMV7AnkuD+7t88y9l
 tvbUIWVGbHMTfSSM7JYuIoMH43/Bi+q1x8MeNvbhkb4ilDbFCiV81gxDRwXdYU2MyHL7
 GjgEm9zaKUrEdRYeWQio1VPeppG4ghsmsgShzU0aI08Q/kOb9/b67vubnSWDbjOgreyA
 4p5zbi6DtByMVmsJfR2ZSK2tKkKUZaVF5bPAWzfEZokOGGsCippj9FhSh3LVPZNjN+7/
 +mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785690418; x=1786295218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/VNyRxg25eQX1o5yblY5pzpZRITiV9Czj9RlgyEyn0w=;
 b=gzNjhs3XvcL8XEnYdRGjsPnJreq7tm3ikkICYEzHqEutfRFkiq0+btCiOKoM9wcHsM
 UYq0QLNsiOkz7Kj0D2XUxJBUUiDREhKUpfFtV6cpqFbSLZ8mMiLfjqgw2ufE7RUYwGPA
 KMYm8jJAqNLmWT9jTb2+FqOIYR0uKf3GrIx7VAhm8BQ0uQA2l3lZZFg9clMofiqdaVjI
 BCWXTXjFhZSisS7l3cEWTyRtXst8Gsy9wHSvLv3RmuJEW0H+kEohAkTHNEucKlzleyJ5
 jY3txEW6XS0V2UBuRgl8HAQuYXwtF3Y/PyHmJKBvEpXLdrV6sFGJEkAm6TsuobsJf4+u
 m30w==
X-Gm-Message-State: AOJu0YyqlHJxy2L//Nqm48WJ6rmnoDYR+lI7UIwnOYqK5Eosp++syNLq
 U5hyULSBKZlGgT/J/+TOU0QeriA17fe7cJ69vCKLYR6YXsG+Isz0TPwt6TZpVccODAg=
X-Gm-Gg: AR+sD13bVNbc8lShc7qhzxo8kmey+qOddZxPPPlkaXrLP2kQtwDQosJhN/XwB8407zm
 lJH9HrhQ4O01aJyXplDr/fOwmTehGHQ6eOClpKaX7I3AxkTBf/c2GlsWeTLj4+YJtEISiGXW9lH
 P84Hq+Mi7nFORSXIqXBmOAK6H2ihF688xfu448xZyqWnc16Vipt81B0K9MQIIgBVOYPRqY1vzjT
 ZlFWcnT2jZpRQl6heh3xPuzEElpv49fT3zjCH6vW8ujRpK2WH09o32Zzw1mCCDqs0DgKn96CwbL
 a2n2eeJ/67Ezxat9YTXs1+13FFnETDew3bOPqRm0WAilfVziuLWu0ip+Ns8ZzF4b7qnUJ6erAOQ
 jYnPck0WdGSQUDV3Kksffekf4BgcY2Rscob8nKD04h3RV6BKYnkDzmAb0+tSiUmcZDX//lxwHLK
 ryBls5fuaHtJ4FwHd1vB8tnQjPfZ05tuaBS91/UyFuJYg/Sbr7GEhOGI0x0qUFA0k7goKQ8i0sE
 MUJT+ssNHlynGZrP6KdYcuT1WUAelfuuCkQPnyIHLSfUQdxu8+xZSgeBA6eOrpXnRtXeiijqsYu
 ioh9wI8CWPpJHpz0ts6xCzBfvTmBoyCfIr6XPyyOzOuVlBVC65+RFhtxeFoUzmLsHdHetyeOJPQ
 8/88TmhJu/rkl/AmmP0g6w+DVOBT43zvkYE1JX2UG+yE5k4E4Pg==
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr144313965e9.11.1785690417802; 
 Sun, 02 Aug 2026 10:06:57 -0700 (PDT)
Received: from KITT.minareto (host-95-230-187-130.business.telecomitalia.it.
 [95.230.187.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b6745csm161687225e9.7.2026.08.02.10.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 10:06:56 -0700 (PDT)
From: Cristian La Spina <cristian.laspina@kernel.srl>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Cristian La Spina <cristian.laspina@kernel.srl>
Subject: [PATCH 1/2] drm/edid: read the luminance range from DisplayID 2.0
Date: Sun,  2 Aug 2026 19:06:46 +0200
Message-ID: <20260802170647.206880-2-cristian.laspina@kernel.srl>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260802170647.206880-1-cristian.laspina@kernel.srl>
References: <20260802170647.206880-1-cristian.laspina@kernel.srl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

Panels carrying CTA HDR static metadata get their luminance range
computed into display_info.luminance_range by
drm_calculate_luminance_range(). Panels publishing the same information
through the DisplayID 2.0 Display Parameters Data Block get nothing:
drm_displayid_parse_display_params() already reads that block, but only
for the device technology.

Such panels exist. The OLED panel in the Lenovo Yoga 9 2-in-1 14IPH11
(EDO EE00QBA63.E) carries two DisplayID 2.0 extension blocks and no CTA
extension at all, and declares:

  Native Maximum Luminance (Full Coverage): 500.000 cd/m^2
  Native Minimum Luminance:                   4.000 cd/m^2

Fill in the luminance range from those fields when the EDID has not
already provided one, so drivers doing nits based backlight control have
a real range to work with instead of a hardcoded guess. CTA HDR static
metadata is parsed first and keeps precedence, so panels providing both
go on behaving exactly as before.

DisplayID 2.0 encodes luminance as IEEE 754 binary16, an encoding the
core has not needed until now; add a small decoder for it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Cristian La Spina <cristian.laspina@kernel.srl>
---
 drivers/gpu/drm/drm_edid.c  | 47 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h |  3 ++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 07970e5b5..f4845d799 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6733,6 +6733,31 @@ static void drm_displayid_process_base_section_header(struct drm_connector *conn
 		info->non_desktop = true;
 }
 
+/*
+ * Convert an IEEE 754 binary16 value, the encoding DisplayID 2.0 uses for
+ * luminance, to nits rounded to nearest. Negative, zero, subnormal, infinite
+ * and NaN all report 0, meaning "no usable value".
+ */
+static u32 displayid_binary16_to_nits(u16 val)
+{
+	int exp = (val >> 10) & 0x1f;
+	u32 mant = (val & 0x3ff) | 0x400;
+	int shift;
+
+	if (val & 0x8000 || exp == 0 || exp == 0x1f)
+		return 0;
+
+	shift = exp - 25;
+	if (shift >= 0)
+		return shift > 15 ? 0 : mant << shift;
+
+	shift = -shift;
+	if (shift > 11)
+		return 0;
+
+	return (mant + (1 << (shift - 1))) >> shift;
+}
+
 static void
 drm_displayid_parse_display_params(struct drm_connector *connector,
 				   const struct displayid_block *block)
@@ -6740,6 +6765,7 @@ drm_displayid_parse_display_params(struct drm_connector *connector,
 	struct drm_display_info *info = &connector->display_info;
 	const struct displayid_display_params_block *params =
 		(const struct displayid_display_params_block *)block;
+	u32 max_luminance, min_luminance;
 	u8 tech;
 
 	if (block->num_bytes < sizeof(*params) - sizeof(params->base)) {
@@ -6770,6 +6796,27 @@ drm_displayid_parse_display_params(struct drm_connector *connector,
 	default:
 		break;
 	}
+
+	/*
+	 * CTA HDR static metadata is parsed before this and takes precedence,
+	 * so panels providing both keep the range they already have.
+	 */
+	if (info->luminance_range.max_luminance)
+		return;
+
+	max_luminance = displayid_binary16_to_nits(le16_to_cpu(params->max_luminance_full));
+	min_luminance = displayid_binary16_to_nits(le16_to_cpu(params->min_luminance));
+
+	if (!max_luminance || min_luminance >= max_luminance)
+		return;
+
+	info->luminance_range.max_luminance = max_luminance;
+	info->luminance_range.min_luminance = min_luminance;
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] DisplayID luminance range %u-%u nits\n",
+		    connector->base.id, connector->name,
+		    min_luminance, max_luminance);
 }
 
 static void update_displayid_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a0cf0268d..15176ae63 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -425,7 +425,8 @@ struct drm_monitor_range_info {
  * &drm_display_info. Calculated using data in EDID
  *
  * This struct is used to store a luminance range supported by panel
- * as calculated using data from EDID's static hdr metadata.
+ * as calculated using data from EDID's static hdr metadata, or as read
+ * from the DisplayID 2.0 Display Parameters Data Block.
  *
  * @min_luminance: This is the min supported luminance value
  *
-- 
2.52.0

