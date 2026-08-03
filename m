Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0C0C55838
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EE910E726;
	Mon,  3 Aug 2026 16:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b76Ugon1";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DC110E723
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:34 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so12668975e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773493; x=1786378293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2K51/FwVv7xc1HWMtJnTlI6NfH3sfU8zC/PFmRYZpYI=;
 b=b76Ugon1a0Oji221DtykvZ2GkO4udyCWYwbf1mmIgvT7ZnBF19nFJEsfbmWM+K2kvQ
 0CkYgB2DusS9Zjr16u+4XNZh2fJmhWdao57fmVOkwAW4MMiCqpA/Ie8lsV/tx0q8Lcss
 Zxlx61rVDu87H+Ya5tcsvIAXI4jkLVgJNBOeFZ5sHlMGjvivRJ0RWyAT6q6P4ylxQ7o+
 6Q97d/jqm5ktNOUgUGPkbI0oaT/DGItmgg8qML/rLH8O4BBvd2NOnmnX/seIGNU4NTMm
 TnqY5oQZMq9LOrBY44A6shbxzuYO48nkVTJXzxFNRb2HTLGq1avBrcS5H0ieG6CaLXnk
 fDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773493; x=1786378293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2K51/FwVv7xc1HWMtJnTlI6NfH3sfU8zC/PFmRYZpYI=;
 b=M85uzVv7/EgNILzNkWx72WHyHoCtU4nkMnvDYY2WPmWnT1lgRWdUEfZp2ht44sBlpN
 FAXDfUCES1gHyLhG0CmJU2lJEuaJpZ2PYQyDSGBDoDvVPz/zA/UubPNEEiTSz4wi2vC0
 vcAPRl49RWtnkc+rKPeZAghCJbbKkjBe3utp1ccR7VcZqj75gl8u1186/sAlukTOicB0
 Su/r9wJYyiXDXBNU1PyXVnr2EADhw6yEKukykWZEmaZPSU3KB8W6hALWwYKU2YqrplUa
 66PFpNhbG8vBsJwaJYRVmcdfdFQ+TUDPE335PDm/esBqzwICDZCe5wQovQQ3FO6Asfj2
 gOWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKZmFBeCKlejrkQy2Blvriz9e4m0YkuudfJV5W8qvlcrOkqZkuWNi2vwfDyLyBMm+0Nhxw5PbSoOI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz04nQFriKZDS0d7V2r89xdFW9zxaj0QVgVw5aQtt6U3Kmeib8
 Zgv1TqZZWpyL2HwF3UzNYvtb8s4h4XVANmW0uqet8y+3JsNKAM0GewjL
X-Gm-Gg: AR+sD10wBw0NqNUAN3Hc/TzJhSrVIAXk6ZYZf/yxAAfV2m70oh7UF0UBTq3frFUVHKG
 +vv3aK/yL6ViQb1WfxK1YX6Y8ocfww1u5dyDg3tYAmcjYNTXiQ+yA+QlewRbp2ZGWn0Aj+IdBCn
 ReQZ5CwD6SEgjAjlwr19WyqzuI8tyz1MHzfuD3HGOUOO2fFSyyGz8KLSGmUd67Xs0QgFkDgpEa0
 WckQG5cWQFSlTuT2R8VEEkHXPcKSaQW9Y4XI9M4+4AJTm1I49iMQ0JOqMJkqiHKReHn7O783MBH
 zz1ksl4tX2JMRNQWSw5uOAakS2uybi5JWrC30r14zSQqu4Z6uluvtkh2pYd8H/N4NtDt3GXC2UE
 4+KFLNeBcc7wUXDqnYMttEET8lfL+o0nqyC7Eh8nxPxcsQlHektkS0zuFNiZuP8olfbqjiMnmEf
 rcSaZ4GQaNK0b17JKS0y1RVQb3Mis4f/wmDP/am9KYmVceCQQwANVk3AaFxRMI6i7YXHMPJy1i5
 rZ3E7g88DaWGvpy40CAAkF6GX8+qkkpEFaJSTbFJhxoHsxerMQzZIODbkBi6xn9sMo8m2HXOU8j
 3PPgWvkcVhQXCuDZtE/QrxdYnu0Z5rJBoEMfHsJBhZSYqEKUJWS4MjFSiS+sYBLnKEg3+95wPiR
 h+lM9I/qU8AhHdeBj3QV4yjCImTDngTIkGi1ZfpHKf9SiswALP1AkCx0CXqeN8xvkARsuR5shmh
 qBeQ==
X-Received: by 2002:a05:600c:4444:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-4980c645e1amr227533685e9.7.1785773492549; 
 Mon, 03 Aug 2026 09:11:32 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:32 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 08/13] drm/sun4i: crtc: Propagate layer initialization error
Date: Mon,  3 Aug 2026 18:10:46 +0200
Message-ID: <b26a0d427d9dfae9c82e3ca90a67d24d8ece5a28.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

sun4i_crtc_init() returns plain NULL when layer initialization fails,
while all its other error paths return an error pointer. The only
caller, sun4i_tcon_bind(), checks the result with IS_ERR() and happily
continues with tcon->crtc set to NULL. sun4i_rgb_init() and
sun4i_lvds_init() then dereference it in drm_crtc_mask(), which
oopses.

Return the error pointer instead.

Fixes: dcd215801b02 ("drm/sun4i: Drop primary layer pointer from sun4i_drv")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index c2f7f69baf75..3fa1f4fda0f0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -208,7 +208,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
 	planes = sunxi_engine_layers_init(drm, engine);
 	if (IS_ERR(planes)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
-		return NULL;
+		return ERR_CAST(planes);
 	}
 
 	/* find primary and cursor planes for drm_crtc_init_with_planes */
-- 
2.43.0

