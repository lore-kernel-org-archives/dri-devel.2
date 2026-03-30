Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B111061B19
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8784210E63D;
	Mon, 30 Mar 2026 17:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="f8apXmXS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E21D10E5BA
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98yit45LlnnrFnUVyc31XQvu0+hR9ALeqTGB813YZ28=; b=f8apXmXS/qXrR2GJUmRAp1DT6e
 UHSCvL7IFfMB+EuHcALXVEIsvSzQwycQdCeP0hMuhLKb2rnGCeO+jKrIIgXopZEDy9KOIks6oZ8ZR
 zU7eYKzWQJy+sAfk15NOikRduRiMZILIKNKAD/QS+JToTOxVk5Vx3S8e+nL++8b95SwlOqEMGNhSX
 SspSOSn9TyHtjFlHGNEERP84sNZZSGB3jIMjvYa5u0ZzmOzotowyyWKAFIHPL8XLaORC4OC07ZgXh
 uT9JuOnrUYyYgkZ02OUip8X5LbIWozbycd8nl0wOg07RXzr7C5+3DMax265Ggbj/xs9wlSAk4ET+r
 Y8B5m3AQ==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7GmO-00961G-Se; Mon, 30 Mar 2026 19:52:01 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 30 Mar 2026 14:51:43 -0300
Subject: [PATCH 1/6] drm/vc4: Release runtime PM reference after binding
 V3D
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-vc4-misc-fixes-v1-1-92defc940a29@igalia.com>
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ZWjTJhkWo+qDIINQiDnc4gW8JX78nQIkittg8w/O5CY=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDJmndljcDElo0uyI6FnneHw/f+21WUm3fq/PWGP/Mjno2
 mMdWWWWTkZjFgZGLgZZMUWWH09iaxnFytk1l5VfhBnEygQyhYGLUwAmslud/X8Uj+enLS78er4h
 bzqzI8INNQsVvyVGPbpyc4/TTqO7tscnLrGc+jzt2r1tR4s36nEG9XA88Km3qzn7xKpodSdzW/k
 qgduKvHUTtOdsy3jXx+ByOjHovMS/tuLgqFTjX4m6LcGm8r7XFCNjj2ovPLs77VBISm7dna0arZ
 MSdeb4HV6zlzsiVrUnW4ovukvHl/3J46UbLd2nVuYddV47818b7yeFc/tVTl44ZOB1Ym/6/qAVa
 idVXeV3f2pN9rxiz7T1W9OuPQx/H1fc2uyZJxJ9OJ21WftMg3ky0757lz7PqFx3VUro5JkifYVO
 a8UuM+WKh0XN6tyiZQsbJKMPTJJy4CrfnL5PbVb+hLndAA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The vc4_v3d_bind() function acquires a runtime PM reference via
pm_runtime_resume_and_get() to access V3D registers during setup.
However, this reference is never released after a successful bind.
This prevents the device from ever runtime suspending, since the
reference count never reaches zero.

Release the runtime PM reference by adding pm_runtime_put_autosuspend()
after autosuspend is configured, allowing the device to runtime suspend
after the delay.

Fixes: 266cff37d7fc ("drm/vc4: v3d: Rework the runtime_pm setup")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 3ffe09bc89d273c2ec598f391147425d9f6785bf..d31b906cb8e787517ba3ff72c236ffcf810522b1 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -481,6 +481,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 

-- 
2.53.0

