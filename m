Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16268C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3856710E0F5;
	Sun, 13 Sep 2026 22:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+K4L2CS";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1822B10E0F5
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:22:10 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-93910ad2273so163790585a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338129; x=1789942929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4As30AnVCPBZbgyBnVugtueaVrIX9a2Icgy2bIVOu0Q=;
 b=Z+K4L2CSu3G3O/Inn0LV8FSVJkZOI+4W6KN9pA6J1cr6/VbvEJ+lzzPzLTiVCmahKW
 WQ8yageoPGIfaIVyuC9v/PWosnlqoCZX97h7U1IIsaKIuaRrEDBcEPGzmAGp1cFeSo0U
 IA3/weBmk/UyYLkTa115VYNQygYeyix9Xy3hZviGdRaPJWb/9bVc80+Qetn4zkfPdU/j
 s1X6DrO6/gAz7eG8wr6jNwE6M3w5LIp4SW11ZFiIjH8KZV1aL4BJM7AXfiiAPBKpZHic
 qPfpBVVU3MYxhP3wL73agBr1ZWE74rl5oJG93Xvj9p0PhU/Kmr7R75x1BbVn8D/piGXw
 2URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338129; x=1789942929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4As30AnVCPBZbgyBnVugtueaVrIX9a2Icgy2bIVOu0Q=;
 b=pAqTjM2rJI+4jNkFYwxenduVZdZgr3ZW/YZhJKu/LxptSP+E/w6CbavIGDh+MNRnhP
 0lKBbnE+40rE4r/wnb541R58RvIbBWfl8oQFQJKJTDfae/RDLhGvBOf0r/bAkSimkuCC
 yVcuuxwAsFEJpQm1k9FtUYhd0s3km7YGPHL54b/yQ5cK5HIxS8avX4QqPk2CAyqD5mGg
 mcSCQe0bkyQlIc5xnZtIXAZthg63KVLiwAdpVc8niA+fB3ULLQ522fR2QV1API/C3ps1
 m9MboVVAaEUJlF4U/AZmTpcGEUbd4ePtyevze1K+m67goUiWxO74Bi0esi7dBwg1Jl9J
 UTFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+wtI0M/CqvgfnAaLVpzWcK2DDR+oeRidz80vgVN6o0QX827jC2OrpVgEnc9S3NR5xWI2qmmcfujs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mSyw1yeUDZ98JJnhvC5hSaaEwy3EJbbC4bD0RUm3A6a22yREZy
 4s//Z8XhB31hbwACuTybwzwVWLGyE3b/WZ4TBsOi/HjRf7+G7cXG8PU=
X-Gm-Gg: AYBFou3+Q0KcIWct1Kd0HvCcdgXvBep3RZ65QJmND6h3m0Dn61NpXdbH6pbDHRm2DPC
 yEPVHtZ9D3tBvch/uqE7OsKYvh4EPKpw6WBee4GNrFLOHEc/DmcEWAud2s3uiBs9kF7/GRr6K3n
 iKb7JhxktsqJcjKonMxr5H2Gj3o/dTRRjITN6I6zPIJ41L0/Ei3Nhas5HeLKEn8QE3EyufWgTOl
 w1R2pPl8ObeEhDzJ7ja+p9FCehFtoY3IbVg6Hn5iz9D13t3zr6vh1KHnhmNSQjrHZG3wt7Ve1yb
 vM2Us3QFFhcb3l/XpUOyg3BS1snAv+9mbAbPJCYNGZ43Vp+jAXY+OV/A1HMyphpDmFSELvRKDzz
 qfvakh4x+iYIqtihPXZPp5YI3dMKrwJCNC97bmSJvsbcTZZEBtGgmQumNkKFiRTvfknkyLJpf2U
 pq+EPE30AiWwEIjspD/DmMO+BOqH+axHt3YgCyFU9syz7IRzBq7BkroYNh7kyG9Exh5Bsq0iOEd
 OA/eFmYfNkLyJGxv1WBT/2Kbl7rUDSGvFUhyMcTHyMvt6+KKosv76GvdowfKyX4nz6gKluTUBmn
 25ozw8hWIa88cU3DVpM5SwjE6bxJ6DUVOpE=
X-Received: by 2002:a05:620a:17a5:b0:939:761d:f948 with SMTP id
 af79cd13be357-93a29a13a93mr13504685a.34.1789338128728; 
 Sun, 13 Sep 2026 15:22:08 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939fd0ebaf6sm592293185a.35.2026.09.13.15.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 13 Sep 2026 15:22:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/bridge: anx6345: Power off the bridge on removal
Date: Sun, 13 Sep 2026 18:22:00 -0400
Message-ID: <20260913222200.86645-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

The probe callback powers on the bridge to read its chip ID and leaves it
powered on when the ID check succeeds. This enables both regulators and
prepares the optional panel. If the device is removed before the bridge
disable callback runs, these resources remain active after removal.

Power off the bridge in the remove callback before unregistering its I2C
dummy clients. Check the powered flag first to avoid disabling regulators
again when the bridge disable callback has already powered it off.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime or active-display unbind testing was performed.

 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 407834a03b638991a5a7a4c64dbe3263bfd0d8a9..43c02f312a46593bfe4a0c46f06940006ee566b6 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -775,6 +775,9 @@ static void anx6345_i2c_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&anx6345->bridge);
 
+	if (anx6345->powered)
+		anx6345_poweroff(anx6345);
+
 	unregister_i2c_dummy_clients(anx6345);
 
 	drm_edid_free(anx6345->drm_edid);
