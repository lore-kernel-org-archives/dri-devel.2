Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41179CD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 10:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CA710E02A;
	Sat, 23 May 2026 10:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Wgm6cAX9";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C7A10E02A
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779532889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pT8v3hF/VFBRVBAg3PSZ9coo0WzRTJvMx+U4Hk0v1g=;
 b=Wgm6cAX93fs6UW9cMcjZABPA7UPTa9Vdda4IPZAVBVBeotPUdZATOfUVn4AbguOctDtVr7
 rvsuINlxHVZgm0kbX8vVr795bqIwe2Biqj+0Oo9oV/SljDQ6bJcMbNalJN1R027ThszCb+
 IPd1t0rLD+NwQoBFOYXpoNnWqQ+bpnc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-KFo7CFRhPEGDQpqB-OZ0Fw-1; Sat, 23 May 2026 06:41:28 -0400
X-MC-Unique: KFo7CFRhPEGDQpqB-OZ0Fw-1
X-Mimecast-MFC-AGG-ID: KFo7CFRhPEGDQpqB-OZ0Fw_1779532887
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fdb2b0cb8so47842725e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779532887; x=1780137687;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pT8v3hF/VFBRVBAg3PSZ9coo0WzRTJvMx+U4Hk0v1g=;
 b=DRHu3ES7vwoBVDANeXzeSk+ZvtGt3DkKFJZbFU8grJY7+kh5V1xwPiU9MZ5W20mscV
 xBc8nc+iGRcEf06TGXCjJ+EgIOWCV9CQnymXoAZgG93iP3Pl/lhAvovo5NJFqWFXWgs1
 ELlV8OQMfABqaSkYu4TeQ0NyPZOruOh0gXgfcU+N8mnR0b4DSpcxWRFsAT7Y136cLHn4
 to8Pt4umWLYQgwxiBnd+RHoQo98M+mx3XTRz/tyXmeq2xMAalrvTHduwbyOTamDmFHq7
 RVY5H1BKK95gjR2nVuZzMb9sXNgKAu3qDVqcKGmYw6MYyg162nqWyrnH62z1+l+verL5
 LWtw==
X-Gm-Message-State: AOJu0YwXMfzw5LlcehhCuShui5XKAdXH9qZwMQZx8J2LA+7iW6QME2MJ
 WZixRlBv743D/F2E7tjvB14+m3D0KDE5Nw2LVtejvbXSG8cDzzok+S6wsnJvEtduihVXdAAtjt0
 GDuMoeeJRH4oykmJzHGbx2J8D4CMwFG4d0qiRnubHIlVBvllZc+1cDfNlQapWPWuYxqXAYQ==
X-Gm-Gg: Acq92OHTqxY/wVoP9m/oryF/RKTz3Vb7oMyv3avZMarb5g95G9rQHUh4eKo3bdlrGNB
 FlPKO7JLehEK6bxJZjvLL9Go/86NGjJ+VV0khoS4YyM7f5zcyDrUurW/0l93BPZzGevBqwnamkj
 hxgEEgEwjrsYzs6mSULwWqcBZo5vIiuMv3WRGzY78QXTXxY4lg0EGCVtZPpSWyfVVN27Xtv7L1q
 5Z5A7eXDdBoOKeVTsJLLdQB/SiqmF3pxsFSUTw6VFJFHOuunVSRqIIgo1qkPjIYX/bCG/yXtXCF
 EfRDG0eNQMWQZL+32/CI7YNLLwmFUIKQHYjDkOoxcKMgBvAD/MCSb2PEIgGbu/fUrm5sY4SURA5
 jHqR/U2wzQUbiUbw=
X-Received: by 2002:a05:600d:640f:10b0:490:3d45:48d7 with SMTP id
 5b1f17b1804b1-4904248d296mr82497905e9.6.1779532886632; 
 Sat, 23 May 2026 03:41:26 -0700 (PDT)
X-Received: by 2002:a05:600d:640f:10b0:490:3d45:48d7 with SMTP id
 5b1f17b1804b1-4904248d296mr82497575e9.6.1779532886159; 
 Sat, 23 May 2026 03:41:26 -0700 (PDT)
Received: from localhost ([90.167.87.79]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042cde62csm36329945e9.32.2026.05.23.03.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 03:41:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 0/3] drm/bridge: ite-it66121: Switch to HDMI helpers and
 fix DVI output
Date: Sat, 23 May 2026 12:40:57 +0200
Message-Id: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJuadSvRIfKrfbQAw0JpH9PO
 g7MTILAXjhAVyTwHCXIeWQwZQHzNh4ro7jMQIqsMlSh3NZq0rjIgy4K7qdjjAbZ1VRT21g9TpD
 ry3NW/nM/vO8Hg0TIFGkAAAA=
X-Change-ID: 20260523-it66121-fix-dvi-mode-v5-ed42429761ab
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Phong LE <ple@baylibre.com>, Sen Wang <sen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787; i=javierm@redhat.com;
 h=from:subject:message-id; bh=5uT/i+VK4xlxtoKfvPnY9UvyP/R+IrvVzbfsRtr1os0=;
 b=owEBbQKS/ZANAwAKAcdR5ZDWPz1pAcsmYgBqEYRSbFkneaCePZyli7xFAg20IqC0Hugurhreu
 2e8/134mLKJAjMEAAEKAB0WIQTXXteqJOUM1kXG9FfHUeWQ1j89aQUCahGEUgAKCRDHUeWQ1j89
 ad5JD/9ivC9+9MNIXGTmjGbK3oC6Dskd3oZFmGGOWQBnIuuhmBmsqVGPyIIaC7XC9Y1btTgttXD
 U4iy+VA55tW0qnYpFEbpW+nx5HgqXfaHS4ZyG1jWY02W3tB+G2qr5SdoIXx2i5zj9JN1gxB3u7V
 Cq5ZSH1iFw/9k+W1xdzy3S1qQF1e1N5PmH3VsmgQrb5wmwdPd/M4XTlOVCxbEhRh2xelct7vfPK
 yTcI6NcgGjDWNM0P6zgvhPHVqeO558LbOA5oBtq8O/wlQweLoLufYuw9NHJtA1Q7bjc2bl9UKiA
 /iqQOsjHHh1kQdK0PO0sT/XUKkIg01p9WyfrpdeDubW2BVx0wxpJGSEF464bzR1Hj+pvRUCdsh7
 e3CaG00quJEavhih90J007+CsWZqSULgqELVdY9ZxeK2kBNQZVP0UjBffTRfnLBs9SQ/KLvdbDP
 lODDvy5NwwBvVQ6gR99YPKw9gJ/HkeiWfm+4SFddjDtyM3rMgcARgdm1gzoCY5BN2zkd6ilxK0C
 scSfZrUlefwvBexp49rdlDwIFZrvSfUzD2aF30Khis5KXIfKreDHhzs1kCUpOkCsjJbTHkvltu3
 mdR5H5rM/rk5aSWrzZ+CqlmVJeTZ97FE0wi/0aiOfjTChnb2yOCPAd7mBnwZ9111n9u6Zsw2Nra
 7bJu8mpHkVrNVxQ==
X-Developer-Key: i=javierm@redhat.com; a=openpgp;
 fpr=D75ED7AA24E50CD645C6F457C751E590D63F3D69
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V5GpJfTJzF0khMGG_dR-4RsW5q3g5kXx4tKLrTuRh8k_1779532887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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

Display output does not work when connecting an AM625 BeaglePlay board
to a DVI monitor, because the DRM it66121 bridge driver assumes that
the sink type is always HDMI. This patch series fixes the issue.
    
Patch #1 reworks the driver to use the HDMI helpers instead of open
coding the AVI infoframes buffer management. It also implements the
needed callbacks to send HDMI Vendor Specific and Audio Infoframes.
    
Patch #2 moves the .mode_set logic to the .atomic_enable handler.
    
Patch #3 finally fixes the mentioned issue by using the display
information to determine whether HDMI or DVI mode should be set.
    
This is a v5 of the series, which addresses issues pointed out by
Maxime Ripard.
    
The patches were tested on both DVI and an HDMI monitors.

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Phong LE <ple@baylibre.com>
To: Sen Wang <sen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

Changes in v5:
- Implement Audio InfoFrame packet support.
- Implement HDMI VSIF via Null Packet registers (Maxime Ripard).
- Use tmds_rate instead of mode->clock (Maxime Ripard).
- Drop ctx->connector, pass connector as argument (Maxime Ripard).
- Add WARN_ON for NULL connector and state checks (Maxime Ripard).
- Use ternary operator for TX mode in regmap_write (Maxime Ripard).
    
Changes in v4:
- Convert the driver to use the HDMI helpers (Maxime Ripard).
- Move .mode_set logic to .atomic_enable (Maxime Ripard).
    
Changes in v3:
- Move the HDMI/DVI mode set to .atomic_enable (Maxime Ripard).
    
Changes in v2:
- Don't store the sink type in a bridge state (Maxime Ripard).

---
Javier Martinez Canillas (3):
      drm/bridge: ite-it66121: Switch to the HDMI connector helpers
      drm/bridge: ite-it66121: Move .mode_set logic to .atomic_enable
      drm/bridge: ite-it66121: Select HDMI or DVI mode based on sink type

 drivers/gpu/drm/bridge/Kconfig       |   2 +
 drivers/gpu/drm/bridge/ite-it66121.c | 284 +++++++++++++++++++++++++----------
 2 files changed, 207 insertions(+), 79 deletions(-)
---
base-commit: 213c92ac9717e4951f052a499f91c89302889813
change-id: 20260523-it66121-fix-dvi-mode-v5-ed42429761ab

Best regards,
-- 
Javier Martinez Canillas <javierm@redhat.com>

