Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4ADCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F73B10F639;
	Fri, 19 Jun 2026 14:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cM11AzmB";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C3910F639
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781879874; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F+PN0RLc/6abFg3Ldn0puQh/N1ZXkz6FnXBoYmrLHHYqtK1yHuMAfhKtuxwyUfCqF1YNb2jzzaAxxDJRn0DNZ6ve4Vb64RO0fTyWaGeVoh8/xTb0C+M+3T0UCeSnoNje9mdemq2IusUN4tR0aJJ012kq3KHj26U2s0+qKorhJcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781879874;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Do5Syhpln/UU9vuuYQYYXqawi9NS/p1ZIzn8/K3GuT4=; 
 b=HJP4g1eUvpqJvn/IrQVs62EPcBZ/LdkqOCYZVeY9BdAWtBxQbXZRj12KXoBSxj2nGbClO0nwMlmcV6rOcTevtQkjzBCRxaeKz807DdaYblloR6Yi7odz1+x0R/AydYAk3jfApCAq8hr+3QZPFsZYbr4b7pz5dRqQ+gYiNb20Qhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781879873; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Do5Syhpln/UU9vuuYQYYXqawi9NS/p1ZIzn8/K3GuT4=;
 b=cM11AzmBCIDe+JwnzkL1NJy8Wh7lWEU5nnmgDeN5Z68b0vcl/t7AUnBtyKMjkwcn
 pxV7F9FiA/shzdfAO+vEX4De8GYY+l56E7OKIVvONSX4nmozDFGrlTPo6YCnX7btv0b
 ZYQRQ0EER5gZoCO8V13s+R+a4SfiizC6wqzEP/RU=
Received: by mx.zohomail.com with SMTPS id 178187987133542.33763294839014;
 Fri, 19 Jun 2026 07:37:51 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 19 Jun 2026 16:37:31 +0200
Subject: [PATCH v3 1/2] drm/display: hdmi: Only allow BPC values of 8, 10,
 12 and 16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-hdmi-max-bpc-fix-v3-1-ba83e5361eb0@collabora.com>
References: <20260619-hdmi-max-bpc-fix-v3-0-ba83e5361eb0@collabora.com>
In-Reply-To: <20260619-hdmi-max-bpc-fix-v3-0-ba83e5361eb0@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

As per the comment in sink_supports_format_bpc(), CTA-861-F defines that
only bits-per-channel values of 8, 10, 12 and 16 are allowed for HDMI.
Allowing more than this has surprising consequences for the atomic check
phase. The HDMI state helpers may accidentally conclude that a sink
supports 11bpc if a caller asks for it.

Fix this by exiting early if the bpc value doesn't match one of those
given in the standard.

Fixes: 26ff1c38fc29 ("drm/connector: hdmi: Compute bpc and format automatically")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce17eeefc2da..6d02cf85f7c9 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -405,6 +405,17 @@ sink_supports_format_bpc(const struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	u8 vic = drm_match_cea_mode(mode);
 
+	switch (bpc) {
+	case 8:
+	case 10:
+	case 12:
+	case 16:
+		break;
+	default:
+		drm_dbg_kms(dev, "bpc of %u is not supported by standard\n", bpc);
+		return false;
+	}
+
 	/*
 	 * CTA-861-F, section 5.4 - Color Coding & Quantization states
 	 * that the bpc must be 8, 10, 12 or 16 except for the default

-- 
2.54.0

