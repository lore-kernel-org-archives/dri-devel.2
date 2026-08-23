Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542CFC5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCD110E02E;
	Sun, 23 Aug 2026 12:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CU9j5ghS";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0599710E02E
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:29:13 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a59ec8f530so55157a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787488151; x=1788092951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gQbaM/nV7s8rQwS5hxI6vhWiwkwOmBmwl7dlesgVmd0=;
 b=CU9j5ghSnryulJnivmzQG32P09kcfyLCrCxvlPLv/6XmXsR2Phu7dTdyeM3VXEii/A
 5DL0W7SbOH96Vzqy9t80tUAwJugaxL5kpFZRmd+Bz0EnoAJOlAPMiZTc4GOIKUegDnmB
 22FYLHI+yac/jTOHDsjZB0HGZh+qQ4jSLmY9/CqYIv0K/snWzCgczgM1/WrX5dYwDjfu
 2kLH+061F2HEyUiuGWxuf5FzXjcJRrFTwrtUG6ez1ppR14fttk2zybTLRWWb76Tn7adq
 jrMR9imcaAZoDE3O1W1FdoUVr4vTKrR8DspMr/aPayO4dN4rErkekf8H41W6+I1vEIMD
 dD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787488151; x=1788092951;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gQbaM/nV7s8rQwS5hxI6vhWiwkwOmBmwl7dlesgVmd0=;
 b=mXjdEJlQ9cpC65qP2BeUsapNXiGhHM5v7ghw3mDwybHE5v9xToyNRMXKYUrLFEgQlg
 RUM0nDld+uFep3Ee0xg2h8XsIwjgANIflXblsOLci8s/b1p9vll0e3GTa3KE653R+TWn
 NpDcYO/VXxBL7SBpiqWQRGvdpPdiR0LBFrMen+TwaOzB4OWVVqvZhOa+9nkfVh9fcD/T
 SEEFNIABQLhAxNucM3C7yPJaSMoaFa11uPE5zu97QG7qahqNR8Y1fvNGegtUK1cgDQsT
 pbjE8f3NqKoo0s1LkSTU9rOjxYJvzw16BSSqaMhtboMU9v0ysJofCd9Ya2d+5w860x3w
 80Bg==
X-Forwarded-Encrypted: i=1;
 AHgh+Row+CmpL5uOz60p4INxE/f8zDztCOJ0YuPAEieFSOsyT5YifR0G6KG2dk3RB3fr9P6zpSW9g+XRpiM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZ+7kki27v0Jn3vYqCe8adSiefg+4dEgPeN/mkXKlfSewjVww5
 r2zS/+8Cod/ch1isOEA1ak3r1OxXs5RDiZLOkYizQHXkU+tz6zgxAKwe
X-Gm-Gg: AR+sD12brVbmiBCBxUxU2yOcksgHOjkmpP9GudnlnVajmNDOeNtDSsL9ytq88aKrGRW
 QeReC3TICiOohkDh9UFx/931nUIaVO44UQITpGLhOHRqoOKNhkHlVI+mSlVs4RM/lzr5NkCemxJ
 T+vUkGWDaipOfA2SA0ih3uaY++GiL5lu5o99fKJ8tqqaJ/xZj4Wu3epQKNja1C2WkdNbjRXvQpI
 lKt9U9zxWZBYkFRzRCjtxqSCfyxNe3VCq7pTCXLj7y1BcingA5xweis7zs00v8yoJURzWd/jLWn
 Rpkm2QLRGEjPS6lYDro1TaMGmbQOT23uJufN2+hfu7VkrSTi0MO9uDze8TXPciSRJmdAwLgoJ9W
 49M+jcBnr7cjcaYHhlT0OpiCXmhBKQW4bkp5XSJZqjJMo4zQmTwy7hqaDp1q8kNoq9a5I0lhdaR
 rnvW+l0J+6cgLCHfrBqf5ktFxeneFRE7Ah7OWFH98Ni2KSK0rLkiXxy4A3/mBN5OiSkeGdq+Uu5
 2FGmfDB4jwB6OJxsNHLGvlp7J8=
X-Received: by 2002:a17:907:1c26:b0:c21:8555:5f55 with SMTP id
 a640c23a62f3a-c246a65eda7mr1238908466b.2.1787488150919; 
 Sun, 23 Aug 2026 05:29:10 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9c9fsm738037566b.39.2026.08.23.05.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 05:29:10 -0700 (PDT)
Message-ID: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
Date: Sun, 23 Aug 2026 14:29:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1] drm: rockchip: add drm_plane_create_blend_mode_property
To: heiko@sntech.de
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

A validate_blend_mode_for_alpha_formats() function was added that
fills the kernel log with warnings for Rockchip VOP version 1 SoCs.
Add a drm_plane_create_blend_mode_property() function as fix.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

https://lore.kernel.org/all/20260526181700.25310-3-leandro.ribeiro@collabora.com/
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0090d8ff0c79..0bc5b606f021 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1850,6 +1850,8 @@ static void vop_plane_add_properties(struct drm_plane *plane,
 	if (flags)
 		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
 						   DRM_MODE_ROTATE_0 | flags);
+	drm_plane_create_blend_mode_property(plane,
+					     BIT(DRM_MODE_BLEND_PIXEL_NONE));
 }
 
 static int vop_create_crtc(struct vop *vop)
-- 
2.39.5

