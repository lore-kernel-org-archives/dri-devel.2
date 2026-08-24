Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B593C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A6310E51F;
	Mon, 24 Aug 2026 07:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=xela.zone header.i=@xela.zone header.b="imRa6Ies";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LaYF0fEI";
	dkim-atps=neutral
X-Greylist: delayed 516 seconds by postgrey-1.36 at gabe;
 Mon, 24 Aug 2026 04:11:15 UTC
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8433610E01F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:11:15 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C06627A0025;
 Mon, 24 Aug 2026 00:02:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 24 Aug 2026 00:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xela.zone; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1787544157; x=1787630557; bh=r9zPbVxLrd+H4kEyGM2FQ
 SmTAICK3IpvRbAhMj/UjqU=; b=imRa6Ies6biNOBs3+tjcrXCtYsP+p8YpNwax9
 ET9M3mei6kIEslLRP4rX/L/1L7ySwPBdPoo+O7R7HudtbhUyZ8tR5VxvTJcB3pbn
 uvlKMU4xo4i8Q/IpkhPN3+v1HQ9F4r9Wp0Q/SItYt9aiBW8ITg7GVygcAT7r2Pxv
 ICZHb9KOYWzwTB8Y9iQumEqdCnGFtyRT7f92HQEABIk8IVClbLVijoFzGmWSSNM5
 mb1QELT7dN8EGkMlaO4HESpTElSj5sQRj74LvsBKypTH0VGNhfRAgjG8zbQdnkdq
 3dt/k1pxTrkeZ2lps/C81gdQuzB2QCOlfCCQaYOM5SzD+9lqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1787544157; x=1787630557; bh=r9zPbVxLrd+H4kEyGM2FQSmTAICK3IpvRbA
 hMj/UjqU=; b=LaYF0fEI7tzsY2+k/c+gYI6Ska8mk8gMSJ6dgoTZrJCSWvt/5Hc
 L1hZ26u7seTPFgYXC/JizCpgv5hF8MiQs/d2jUpUFRR7ifo3lTK7DOUIE8MXPTf+
 zf0cZPfpk0d0QDM0mpXag0dEy683tsw2xYXx+x7kvH4w89UyRgOw6x0PUlZnPsj6
 ZwLXdDMeWQtNaXofYkPVgYzU2PnAO0Io5rSDRzaDz08lHRup6Wt86PgB3ElP+VOS
 dy3uKCxHSf+aKamxDA746Wm0H0ZzG/g679h0GODu7o9/yqmVddBhYtJVRCzcm8h4
 v3/B3Fy7qHuouZ7552JOdqFPc5CBycBSSKw==
X-ME-Sender: <xms:XMKLatJfCMVL5UlSHPE3EnCXjrWyRFmuCmt8_UxnQbx9NcWP7JQtPw>
 <xme:XMKLapku4e2IyglTk6rqwb1HDkP4wqg7b2VCzZc1Kr1KT-8sWWXM-RCy480Kf6j4x
 O2S-YySjea1wp-plgBf7gvJEl6AZUQU4Rso0qw3cfXcXeDUIRUcz0wo>
X-ME-Received: <xmr:XMKLamZJ0QRcyCIFBhH-lcqLaXPMt4Adx8GmDbVlkxZQZMUwRakgMUEOtf4rG1JjVXz4rv5eZ_TluGq3nBf8IyaaH04>
X-ME-Proxy-Cause: dmFkZTG4WW0hVeFqxn7E6OO1a5MVdIfvyXgcOmMkTSUiYJEmfFtvgAPsnpBBZSOM4mZjyJ
 KVD8fqUmgtRO2AzAPiLq1tYs5PwqY12gC2GOFmwAb6C7hw4QVyYVJ4RFZqdC9x+AlreQlJ
 NBO+XKka97N+0wzQEW8s2ia/LfT93OAyPe6ElDSGS6dfJr2Kosk9szitUG1CoP7XHsPKnh
 mN7+ATwwSSa/l/u2+z8s/GilVcJ1P5WsmWKGszGWtr3bkwORorOY4Aoxax/0iQ8ZEBEpO4
 rm33J34i1BIpDY9mh2FVgjwVf7GdQpkm2g10QK1S9AGG5IFjklaBZpfA0BpRBhKqcIUlaC
 m3WwDnKv1FJEN923LInb73TI5bQRqbcjh879ElnUIGFP4B3+/HEOWa4TrGxoaWdZlQGuht
 z+JommR9TLC66rlc2M3qs51m/EjyLipXSAkRxzxpVtSy3emkfvA/e+e0IL92HjKdd/W/bF
 5o0TjoNetcZbjjSJr/Yl3LD7MHEZCSy/1ODaOeJ4ITRItHPzaBzmDbXaIIb9nj7Mz6IKmm
 aqNoCD1RUW6T7+qljAtvJ1UZqE+2/w5w8pyOv50EYE9aULsM7aEbV6qZbOeGT/JfZ1WtMW
 AVNuBlmMb9/U4tbM+3TRfgPLBT5GMt+VMYWY6/bbU8RhYasxy+14asK2eTZA
X-ME-Proxy: <xmx:XMKLal_L4aq8SL_oB99MQdg2r6f-YvityYtX2JFe16qZefAmk3ynTQ>
 <xmx:XMKLalYqFfD9A4PHDbkWBr2isxN8r2T6Y_yRA0DCMb6C9LjLZLwBiQ>
 <xmx:XMKLavdLyQiShGqHpstZ3qFBCXTPkgUDZO8WwcIj5OHGNCXIPdl2aA>
 <xmx:XMKLaikaxy1AIhhjxF0lRlipG7F-pII7RVOzILO2aBgASBvjbYdIxw>
 <xmx:XcKLamvYL1YWexvPOjt7HOIStVkI0QGSVWjXVqcU_CbfIQ17MGwyYqZo>
Feedback-ID: i039e48e0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 00:02:36 -0400 (EDT)
From: Xela <git@xela.zone>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Xela <git@xela.zone>
Subject: [PATCH] drm/edid: Add HDR Static Metadata Type 1 quirk for LG
 UltraGear
Date: Sun, 23 Aug 2026 20:02:09 -0800
Message-ID: <20260824040209.22517-1-git@xela.zone>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 07:42:29 +0000
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

The LG UltraGear monitor (PNP ID GSM 0x7766) advertises HDR support in
its CTA-861 Extension block with SMPTE ST 2084 (PQ) EOTF support
(byte 0x9e = 0x05) and valid desired content luminance descriptors
(351 cd/m^2 max CLL/FALL at bytes 0xa0-0xa2).

However, due to a factory firmware bug, the HDR Static Metadata Data
Block descriptor byte (byte 0x9f) is reported as 0x00 instead of 0x01,
omitting the Static Metadata Type 1 capability bit (bit 0).

Because of this omitted bit, drm_parse_hdr_metadata_block() sets
metadata_type to 0. Consequently, drm_calculate_luminance_range()
rejects the block, and userspace attempts to perform atomic KMS commits
configuring HDR output metadata fail with -EINVAL (Error 22), preventing
compositors (Plasma, Gamescope, MPV) from engaging HDR on this display.

Introduce EDID_QUIRK_FORCE_HDR_STATIC_METADATA_TYPE1 to force the Static
Metadata Type 1 descriptor bit for displays with this defective EDID block,
and register the LG UltraGear (GSM 0x7766) in the EDID quirk table.

Signed-off-by: Xela <git@xela.zone>
---
 drivers/gpu/drm/drm_edid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 07970e5b5..dd279fad1 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -96,6 +96,8 @@ enum drm_edid_internal_quirk {
 	EDID_QUIRK_NON_DESKTOP,
 	/* Cap the DSC target bitrate to 15bpp */
 	EDID_QUIRK_CAP_DSC_15BPP,
+	/* Force Static Metadata Type 1 for HDR Static Metadata Data Block */
+	EDID_QUIRK_FORCE_HDR_STATIC_METADATA_TYPE1,
 };
 
 #define MICROSOFT_IEEE_OUI	0xca125c
@@ -195,6 +197,9 @@ static const struct edid_quirk {
 	/* LG 27GN950 */
 	EDID_QUIRK('G', 'S', 'M', 0x5b9a, BIT(EDID_QUIRK_CAP_DSC_15BPP)),
 
+	/* LG UltraGear (GSM 0x7766) */
+	EDID_QUIRK('G', 'S', 'M', 0x7766, BIT(EDID_QUIRK_FORCE_HDR_STATIC_METADATA_TYPE1)),
+
 	/* LGD panel of HP zBook 17 G2, eDP 10 bpc, but reports unknown bpc */
 	EDID_QUIRK('L', 'G', 'D', 764, BIT(EDID_QUIRK_FORCE_10BPC)),
 
@@ -5498,6 +5503,10 @@ drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
 	hdr_metadata->eotf = eotf_supported(db);
 	hdr_metadata->metadata_type = hdr_metadata_type(db);
 
+	if (drm_edid_has_internal_quirk(connector,
+				       EDID_QUIRK_FORCE_HDR_STATIC_METADATA_TYPE1))
+		hdr_metadata->metadata_type |= BIT(HDMI_STATIC_METADATA_TYPE1);
+
 	if (len >= 4)
 		hdr_metadata->max_cll = db[4];
 	if (len >= 5)
-- 
2.54.0

