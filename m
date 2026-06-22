Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31706CDE000
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE3A10E9DA;
	Tue, 23 Jun 2026 08:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZCAdJk1";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BECC10E7C9
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 18:08:39 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6976b0b2c79so2825018a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782151718; x=1782756518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KVnkwTahPPWJKUQNIlBRjB2hWDjO2XYmGROgpIVjB7E=;
 b=SZCAdJk1PQg4DJWlGl10Cilq3SlrfKOdmbZwJC9ah1i4Hm67bWOQuYOBw4ErQ2AZY+
 zxL1eewN/5zNoKDKFUGCtrFjhpu0baVB1Jid5lWiF7dfGL3lgq0f0RUyKQZgV5QVlHOD
 3/iR1poOHHr10D3vjS7rmQoD4d7p2ZgclXuHyUzk62jQC86WaBAKi2+E4rWuSdAOr7ow
 UID8gu7kBgbjdu+BaOD9mCRFPQp9kEWlOEg6GN/PhjteiownsO7T7P9Tt8s+IgrUdP2z
 GCzMZYlmkyzGHjyn5ddAzkidNxdTnFUon6B4fYgzXWrtFLrFfgceba9tfzqbLXsLZBTs
 QR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782151718; x=1782756518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVnkwTahPPWJKUQNIlBRjB2hWDjO2XYmGROgpIVjB7E=;
 b=KOJI/1MoRE+o8mQ8pw9AqfheZxFQ97NsF6aMmRlazje6ugOy2cEyMZR4TqO2C+bvnF
 p5VY1hH2IcRzO8v62LeaMNfHpOED7fJThymBfqDM49HeBObKseNNRiVfSF0trxjtuPUR
 r/l18CmD9olNPkJdO2YxiM3BuAD+x3po+opILoL033RNX+qLeZFh0rWVu3Z144gLhB/o
 tvQNXZ1ipxVr7maYPpqMp0RBysIfBoHdVGTFEgavo2+XCxnAX8wap1HtU5TV9br5tgXk
 a5LdE7/+9TBPIZSKJfRSxqNgef0lfNUO+s3OOVk4BcYIeYy69ivqsnO6S8oe4PbnJOnI
 wT/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zuxkakuneBda36RMxpc7Xab+xNy7e4j4trbsTkjQshezFFgXx1RxHc8FTBN6/tMvTJZ1/TM6oHxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvBYTyuH5bN+Y8GE031BpG8zRUYymOWGIIRO5R4NbmOwE1Qa1n
 qq0UTbMMoo5V34A8pnoZ+jVHLSN6+Oq2qL+kIN1OWti03h/CMORDQM4o
X-Gm-Gg: AfdE7clkNqo1JhrSEYn+nYDdhSDcfDqqauKyBup5nmX822HMNNEnBw95QuEwSy5K8aF
 htS/iweYH+aDExInmJZ6owSmBBJoRImSX9zyENJ+UdQ+zABGZp6DU2AQFMQVQ9n74M94remGvEY
 40kDM4umy6sRIid0HQwN89A8wUU6kfOo8hf2n2Q1UWXyTLkAPzy4XAfmb88sgk0+Vay2dIFNcMU
 W274wjM7OqOCGP0i8BjrA1BtUwytcuJVvR5TW/wIxJbf2oNiItNTjVYRu3WcpSZNOMBJfCuH/Sg
 UczUyjPBPQZL85tfsUNT7ihqk3N9pYADDR18RiCq+g5KpMV0HLLgNfF9FvTcyiCUqRqaFdJV61X
 1OvGBZswrtdptENXt2Uwqfw2mNVTPPXLuX8ujnM2KFY3iNhfC4Sq4S4ObwzMLsx3xEUjq4wIALe
 clOiitraalwW5ZfKUdcTcTAORnMexvt47WqSSB6MeLnl0N8w==
X-Received: by 2002:a17:907:398e:b0:c07:92e2:c9f7 with SMTP id
 a640c23a62f3a-c0b6144792fmr682067666b.19.1782151717260; 
 Mon, 22 Jun 2026 11:08:37 -0700 (PDT)
Received: from liam.home (233-51-98-95.ftth.glasoperator.nl. [95.98.51.233])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c610e5280sm403334466b.53.2026.06.22.11.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 11:08:36 -0700 (PDT)
From: Liam Zuiderhoek <zuiderhoekl@gmail.com>
To: tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Liam Zuiderhoek <zuiderhoekl@gmail.com>
Subject: [PATCH] GPU: drm: meson inline drm_simple_encoder_init()
Date: Mon, 22 Jun 2026 20:08:32 +0200
Message-ID: <20260622180832.28143-1-zuiderhoekl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

Inline the call to drm_simple_encoder_init() for meson,
as per the TODO list on docs.kernel.org/gpu/todo.html

Signed-off-by: Liam Zuiderhoek <zuiderhoekl@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 55c0601df3c6..48ca6874d4a0 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -407,8 +407,8 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	meson_encoder_hdmi->priv = priv;
 
 	/* Encoder */
-	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret) {
 		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
 		goto err_put_node;
-- 
2.43.0

