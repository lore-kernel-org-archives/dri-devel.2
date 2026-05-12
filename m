Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654DBCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC5B10EB02;
	Tue, 12 May 2026 13:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YYAPDmki";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEE710E0A3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778592162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fGSZiTHuZJ9sQ24k4PVV7Pvk4Nit0MnWWd13gX9epo4=;
 b=YYAPDmkimIVq5A09Lj0qn2d9IH/xExl4XzKbWfkxbCurJ3X5ij0XlDmNgUN6yYKMbYHd76
 fkWJvXHo3xZUgx60YX3kJwcpdkLI+GvcIV5lY9FL9c1itiMm7LingkxGtOBWg8hmWwjwvt
 y/dwbbCRmqAwSRi4P2YDl1JPlcWmkVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-F-D6HM6ZPB23BCKDhFchsg-1; Tue, 12 May 2026 09:22:40 -0400
X-MC-Unique: F-D6HM6ZPB23BCKDhFchsg-1
X-Mimecast-MFC-AGG-ID: F-D6HM6ZPB23BCKDhFchsg_1778592159
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d7a5b9678so3702792f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778592159; x=1779196959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGSZiTHuZJ9sQ24k4PVV7Pvk4Nit0MnWWd13gX9epo4=;
 b=sRa0mJ9UykBCCKABUB6A81uju0U12dRaTgaf5ifY1H3AHL1SAJNjdjGlgAffdmyVZW
 v6B7qlWUfvoSHzGgq/c6s3empmAtqpzwI+8X4iNeJbIycSkCVd4HiL2cw2cL9QYxuFEW
 V4+XiqjGs2j6kVscrnVuXTN0iRCeosaGgPYZmkqJ1PR3QecZw2UM/2mqgK0uF6UPKkj7
 xHp4OmVTCSzWo9HNB2W3+CWIr1ympXJQ4cjUr9EHMCoAgP3J82GD7vPi69loqB8XTGVG
 Vxh7m8ptZ/Ka06W1JlPWe7kQT9HA9GiWEXjSdK0y0L92CdU3a5M7GI7dI/lcqR514PK5
 XFow==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GzNVNIEKVD6nsvHGwBvkovHqZA9bYhtVkcWqVxu61Ymis70eSpF/N/p2zl8IohnV7UA9fj9NRFUA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsSWwQC9hyPzPuU0DVBmvDmvPGrj4EdyTizapu+5O87PJ6zqIW
 rhJpLWDHNrnywTMNG2EZXBC7/DX6re/tDzza3QFuZyYSGefd0BVuHaGsjwY895raj2lCYgn9GBB
 afG/W4cRohe7DNM35KLqeDF5f6U19CPPFdffN7XpkPwTB5EIdC3YndBtZqvh0D1QFHtYAJA==
X-Gm-Gg: Acq92OGSkfYQ42disB5NVLCH5Ja+8XqWPlaUh9uQETzbwOUbz+HNZJVKPWyA0W8ZUv7
 +HoNf7fhuObJtruWbswXPHKmX+xxI5uhRWhiJpMvQ0B4C78gsuwpQ9ihT/1b5GrG3lnuuXPP749
 9es6R6c6ugnvQ28YnMzmqs5RkOSMKxwDdzdMlcRW5LO45YbkvKPMvOVC9QOCpz/GYug9c4OkNH6
 3HgZaFLaBlFqCt9rk3CjVyYAi+EOL7rYKnOmalnR8Gd10PMwdt6Vgvkt1GgYzV8x9fPwKDzXZrF
 Ek1vMTaSA89vGLdtsSPI/3KnZJ5MKcnBsRGrFm2Sdw5CTkCD9uILHaSOUwZmtfqPw9A9DCGdfCZ
 lrmCd850DGfdPMhXNILlGqLhF/3eoMv5Nx9/DW77nNVweIdk=
X-Received: by 2002:a05:6000:2902:b0:43f:dbbf:6d93 with SMTP id
 ffacd0b85a97d-4568c19b2b1mr20613819f8f.27.1778592159241; 
 Tue, 12 May 2026 06:22:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2902:b0:43f:dbbf:6d93 with SMTP id
 ffacd0b85a97d-4568c19b2b1mr20613761f8f.27.1778592158716; 
 Tue, 12 May 2026 06:22:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491da03a7sm33155548f8f.33.2026.05.12.06.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:22:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/2] drm/bridge: it66121: Fix display output on DVI monitors
Date: Tue, 12 May 2026 15:22:14 +0200
Message-ID: <20260512132232.333654-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zijl6gA2kcA2XA2XJr7rtUtwum1DIiZQiZDzgQMVhRg_1778592159
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Display output does not work when connecting a AM625 BeaglePlay board to a
DVI monitor, because the it66121 bridge driver assumes that the sink type
is always HDMI. This patch series fixes the issue.

Patch #1 moves the transmission mode and AVI infoframes enablement to the
.atomic_enable handler, because currently this logic is in the .mode_set
handler but that is called before .atomic_enable that is where the query
of the connector is done (that contains the display sink type).

Patch #2 then queries the display information to determine whether HDMI
or DVI mode should be set.

This is a v3 of the series, that addresses issues pointed out by Maxime.

Changes in v3:
- Move the HDMI/DVI mode set to the .atomic_enable handler (Maxime Ripard).

Changes in v2:
- Don't store the sink type in a per-commit bridge state (Maxime Ripard).

Javier Martinez Canillas (2):
  drm/bridge: ite-it66121: Set TX mode in the .atomic_enable callback
  drm/bridge: ite-it66121: Select HDMI or DVI mode based on sink type

 drivers/gpu/drm/bridge/ite-it66121.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.54.0

base-commit: 19d584a634fe999786acfb0ac5289710cc84a5f6
branch: it66121-fix-dvi-mode-v3

