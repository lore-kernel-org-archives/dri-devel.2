Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E3C4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A0A10E79D;
	Mon, 20 Jul 2026 07:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K21jrmYL";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B50810E05B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 00:17:28 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49557167508so10054485e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784506646; x=1785111446; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z7xLnfi81E94XOTjhrRO5u8WajiRrKp9FwtCDFfPEec=;
 b=K21jrmYLtEfdf8iH09y34OzVsB6iPR9cl0O4fGc63TmRjIJjN7KVhbC1oHW4TM6myh
 9JQRL1rX0jYsKL9GOCLuxJoxXK3K92HqyDSBR6YCbL7GFIaJ4y3LzPjwsYwszZkKWrBz
 Ce+lztZbu0MgG4P844+PPnDW+2p0VLsWgbhE6q7ry9PKRclomAfCLoF485Z6rRHm5hFR
 +StWMweEXv8Ca7BYYorKNnt7/7XjoDrAYwEPdFSKSI3f9cfOnq2yU706vrd3EbJhdhHv
 La2zTPsi6F7HssIY97n9mJvQU/eMHwzvTXLFlen3Hm+jsHK8/Gy6gGxJpoepLdzNfjZ3
 HASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784506646; x=1785111446;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z7xLnfi81E94XOTjhrRO5u8WajiRrKp9FwtCDFfPEec=;
 b=hxtERVp4rJSac5kRfNJE2AlVFJ7UB4GFtv/nUy60VryfNSA+z4he4P9NAozV2dXAbV
 vMy+w71ywy0BWTAHmn3f2lAn+y+Y4GzuAcnhOod/D6VGf4RRzbZ0P//Rh7zReRmnBXOc
 Evs+KEDQklzGMOf3xP+n0typsQayhuGFRwGP96p58dHvgb8XS8gpXpBkjusxrqCeAPR3
 Qw3JmJfQ5UZ+hN6VagzaiGKZcqewca7DGPK6XRX1lgwMDjq2I+4cq/CccZ2eJIb+LeBy
 HQpUZPaSPj2hiBa7C177uxM+KqcpGdywQqyYDykr/adWU2z8XUN/wPYvNuv08CS7yamr
 MyRA==
X-Gm-Message-State: AOJu0Ywo2K5LCubLVoGeLyM1nDc95qBy2Hw0M4oHTBcx3mWJBQXrf70X
 rmb9d7t47AxHrlT76uby3hu1depsNXg9gYK/jb9BNgTvdCMcEACgCCIm
X-Gm-Gg: AfdE7cn9J/NbQZkhu+U95pMrb39FD6HzzynY3aQq7kWiRjHq8Y8d0kblKpxlV5O2u4I
 UUVvjHJiC0mRyasv7eGw0u4k5q1kRrk2ibdfmjZDYydgr7nyyFLqVfg8aPHu8zMtjECx5AQlI2N
 Kdi+r5Y5G4rssyTMC1fyiDi2Q91gXLAGDPu5yjpfA4WvPh5Hqv3hps4Ndcn3DUtdtCr9zy5HI15
 ZPW9DsS5QBk103//A1pLcIee6DQfTp6ubJaKn0hWuCPVnTGH/GLOk15qwGRjx5ozxMmMB29sMIZ
 Gac9Vs8bYbKXKRg9zk1O0Ws94rmh8J6MgyF81S/UYthWmTVL68bj9ehzHaQIcwCoruC71dirzzz
 kzItXV4vKD+J7uv2aFgEwk3pL9vtsVbWKd/qFotRX6mVPnV4/P18QnSdEE+y6/driDnLqA94mSA
 Z7w983CQLS9HM1ye9iLyeEeqdDOlCFQPq+NgBishas5UmSkTvp
X-Received: by 2002:a05:600c:3586:b0:493:e504:cbef with SMTP id
 5b1f17b1804b1-4954a38def9mr130131255e9.0.1784506646247; 
 Sun, 19 Jul 2026 17:17:26 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955fc42db7sm16191785e9.3.2026.07.19.17.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 17:17:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:17:22 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: louis.chauvet@bootlin.com, simona@ffwll.ch, melissa.srw@gmail.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 hamohammed.sa@gmail.com, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] drm/vkms: Advertise PREMULTI blend mode
Message-ID: <al1pElMQZsDfpAYI@michalis-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Since we only support pre-multiplied alpha blend mode,
advertise that, otherwise validate_blend_mode_for_alpha_formats()
will throw a WARN.

Reported-by: syzbot+6245cb95ae707991bffa@syzkaller.appspotmail.com
Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---

syzbot link: https://syzkaller.appspot.com/bug?extid=6245cb95ae707991bffa

 drivers/gpu/drm/vkms/vkms_plane.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 68cb2a3335e6..a2e5ebee729a 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -246,6 +246,12 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					  DRM_COLOR_YCBCR_BT601,
 					  DRM_COLOR_YCBCR_FULL_RANGE);
 
+	/* Since our composer only supports pre-multiplied alpha,
+	 * advertise only the PREMULTI blend mode.
+	 */
+	drm_plane_create_blend_mode_property(&plane->base,
+					BIT(DRM_MODE_BLEND_PREMULTI));
+
 	if (vkms_config_plane_get_default_pipeline(plane_cfg))
 		vkms_initialize_colorops(&plane->base);
 
-- 
2.43.0

