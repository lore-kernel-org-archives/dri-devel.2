Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00860C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A553E897F6;
	Tue, 25 Aug 2026 14:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=xela.zone header.i=@xela.zone header.b="iw+VlExX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pqpccs6y";
	dkim-atps=neutral
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E75010E0FD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 22:38:32 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F327D7A0136;
 Mon, 24 Aug 2026 18:38:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 24 Aug 2026 18:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xela.zone; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1787611111; x=1787697511; bh=09VfrXSvxnRtX2nVWgaq5
 s0ocHWyaQDhYuZjiWctKPo=; b=iw+VlExXIYQigjUt27JHr+9jHS3sXLjT5hDwL
 0GTmClUFFGrH6CQd/t73F+ghkXNweCUwQ6bcXIgpzcUDvhMd1eDUMeIw5v2KuyMF
 z+fM14P4I29dQ/39pU8Zn8wAB/Qxu4TdxM5pzj9AEw4Y7j6dcXng5QyEKqQB8F6Z
 y2dWzU23zPTMTiLaKplN/EK4PjR4rbkfe4mb1McUOYWdmX4FyBe5ksCNZsO2LJnt
 FkxFOo90V0MixtNF+g70QafFpH4UFqJ+1QRKWeNqkJzwsdEEO3dGAQCyAWFcguFj
 RX4KBMhiFj73lE6VNAPRZrHfZ1sC4wBWmSQ86H8Hi8rGodonw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1787611111; x=1787697511; bh=09VfrXSvxnRtX2nVWgaq5s0ocHWyaQDhYuZ
 jiWctKPo=; b=Pqpccs6yp4ciDT4GlPzM+wo3ptbAi37Gnu0ogxBMfEFhjgycnc7
 cFdwQOeqyXpOlzrkFUO2zPXVuVLDZuA0gbTHmYVlaiNMmRRJnWZfUzJbGMsgDJ47
 sR/RI8G7LG8m5sBNpjFsNmaajS82b6AIoL2zOTzIejGlK2bGmuQfUkXpWY803OBM
 epKitVAfeXn3nDPR1qPN9dyIedxTaBdN7TC36RCQ1un8VSbKXr8mlKDQiNeBGd3s
 T9xOytfSta6nCINb/OQHMLgksV6cZJ/1X3k3SjeqJwZDMSpUqF+HFyuUMDKL/sp3
 vbq71FDpKTgeT1nMOP6NSAwv51EeHTOzoRw==
X-ME-Sender: <xms:58eMav2ruo9HjaNZpIWbwqdNehcytzGcRd5c064otJuFi2cdOPfXkA>
 <xme:58eMaug-3u1WL3Q9jPr5ClqTYMprL5OjxxYoFqw0wkEAlBcKJtL7_AglPhplT1nKV
 qYnqUE0CtLQGiTXw9WdY4Su0T9MBSarQkGf3jS0EU9ftUqC6ClYA1s>
X-ME-Received: <xmr:58eMagk1DOubJTYeyB30zLDGGmH6CGIHP7o-RaghmSA1vuPsxR_aV48HNm6tyMePshm-rLceipfYEcdp4b0AMwim3xM>
X-ME-Proxy-Cause: dmFkZTEzYTAVnlsXfMaTDasgaW9hr5dO1Ruh/zroW/uFMy24CyMcvhn6jOJuoo+H0OEuZ/
 u+o4saYJhsLvqKJgZCwnxHHcpfV+OxS3COpHiDxQuV1D9Sh6uDpB8xXR0TVqiOqXGdiOm4
 Hg1oc+4K9NkyQIoulyXtxnTnrlUAssJFmHpdKnMzo3FAmy8ct7rkeen+Y6037fOqYoYZuY
 nfBbrzc23NJgvIUbNtPQehZKo+LHmpZv1EFMFMf9EgzjYiJk3YpCsmuQfmLwxGQqEnlCzq
 U4IYL6TBeo6zRNcFIsG07It3TOouwmtRs9LQvyAdlKouvzLdWzjXnt3O/6zvl1MmNoj7gD
 9Gs5cP6TSzqg+b4A9KXTeF4JdaMbcDf5fLz9KfDH7HxtQ4ysh3xDGEvMJj8QxdKpy1YkVu
 xGD4RzrdtN7VCmbTjTkceKReww/ax/v09Co6l8V28OhMG2DcjMVcLBdJDCaYl5YSkkCpn+
 Jg85KCahcr0F2RG8k/8t+TwoIdYZOX+HdSaa6c8QbeOQHhTAYYluFOJQxOD0bz/zeW22nv
 yqluVpdvqGS02RSThmLykKPOyHp8+PF3phO0Fw4zPdi4wgXTefA4dpVioTl/ExG0rfYBDX
 Bs6EPc0CBBzhb4Im6XsRiQNPOsx9uD1WmMnghNfikyTBGJtWYFFDNjHMwe7w
X-ME-Proxy: <xmx:58eMasaR8DW0km-4bNtgqMmFXxIxcUehUrvAeAT6TxctzjCRD191Yg>
 <xmx:58eMajEulKQJjJqDNdUTrkjvihD5kD-dUMPdTNOf8K0MvCccS93Dbw>
 <xmx:58eMajayOHibtTUclswf5Q2mEcqIl1ZQhrcte6K9sUs4fxWgQIuXvQ>
 <xmx:58eMavw8JprDiARQ-LjnndpB6xu00ee-sWM5qcOVxquYWQXR1Fh8XQ>
 <xmx:58eMaruLEMalDnivSFp7lqKBRdcbTF-i7ii2CPqx-rDsjfwpntCOGqwl>
Feedback-ID: i039e48e0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 18:38:30 -0400 (EDT)
From: Xela <git@xela.zone>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Xela <git@xela.zone>
Subject: [PATCH v2] drm/edid: Add HDR Static Metadata Type 1 quirk for LG
 32GN600
Date: Mon, 24 Aug 2026 14:38:27 -0800
Message-ID: <20260824223827.259147-1-git@xela.zone>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

The LG 32GN600 monitor (PNP ID GSM 0x7766) advertises HDR support in
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
and register the LG 32GN600 (GSM 0x7766) in the EDID quirk table.

Signed-off-by: Xela <git@xela.zone>
---
v2:
 - Specify LG 32GN600 model in subject, commit description, and code comment.

 drivers/gpu/drm/drm_edid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 07970e5b5..b467a643a 100644
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
 
+	/* LG 32GN600 */
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

