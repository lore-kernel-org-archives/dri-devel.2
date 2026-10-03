Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA60CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEC810EB01;
	Sun,  4 Oct 2026 17:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pyYsVUtv";
	dkim-atps=neutral
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3BE10E405
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 09:00:16 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 d9443c01a7336-2cf5e516e67so906425ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791018016; x=1791622816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XiAtNXBcVho7+bPRrrdtDPhvWeEZ2yz41dniWV/stxY=;
 b=pyYsVUtvjiToTLUrxxtLvqIJLn2XsDkNSXA3ddfBMPZm1sd7TaOKsRVBtvzs+F8T26
 3KDLb9p6+OT3/1bxnT9gjJb7vHaQIjpYbR48BKvLh+pNhGeiDM3x6heeSoMdLzv25P9k
 ggUeRfJQjbh7xxS9OSPSsxFh/6BaoxDTW/BL7jOwW9F0CCYOINaBM4bF1xoRVhG7q9nX
 CYsUf5VN/hkQJUZfwerHj2vz2LyUK63Zb7yOfxengQPU+w0fpV3BDWHBdigNNtou1E1m
 bRBPcWJ29oGpHI9y9ruBj8LbtPhZ4hbRFjdBjdNRS30zd6gdv+C6xq+yKVF2rvcjosHW
 cIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791018016; x=1791622816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XiAtNXBcVho7+bPRrrdtDPhvWeEZ2yz41dniWV/stxY=;
 b=S6scEaj8frcWweMP9ZgBOZIlpWkKAVyT3xF+WmLFBUqGb/k3qKjWF/aVnUYySL2zck
 fvYTtAK+QNJpDaUfo8kE0/rlM1kd9onmfgC+qXKiv6lBBnEBMAm0/rozCgMJDzfTAx5+
 58MwRy5I1B7EWEstT26ts7bP5srYfx6sjVhp3RV/kfgi4KbSqSBbmBU+LbMbMJP/eDvd
 D7yckSpFMAXtcMORS7EpgldJwdBQE/GXZrq3bOwkVBJVlQowuKB6dlCmcEfDJobmmI8N
 0wt1flA+v08Nmmg4I9IQV8B7SHP6sVadcOrlv1xm0ZbscJmfsxdlI1x4r5m5UhOiDiBt
 f8AA==
X-Gm-Message-State: AFq9FYJ/hvEN5bF4qr3aVz3/kqQEyfEyJO6ACS7yuOeFqj7gRA79ouUV
 YBSoDksVNn4bKTFBpZ17jfrMyhfXkIqHPZEXHix6FtIMZJYOafS/9D6dw1ZiEP2A42navoVB
X-Gm-Gg: AYBFou3tH1PuvKDstNWg5fYrpGNvrZ54M6URHgkr3+Ezvq9T/YSkDg6tmhxe74hIYMp
 2IBb80PFmXBubveqs2KzkHSyDvi3Vx5RR4cc2eaAGZSUs4PSX+lF9IuO4DqTzl/djKdhpEWPehw
 m0yPoYcTLohpAXXMlaZno6YRCm4TEo+RunlEu5g7ipjcVhJR5ACW5JdMyLsGpoqQZ3hsGhL62T5
 EDJ/vK6kaT7t06ZvYwZotniHtHk4mSJilpvLO4iX4z8eA8kwWuxHuX2IqaD274O8ddnqG6ojw4n
 cbd8pMhhrJikaIu15cfzrK4Abtmu37PIqN8d+DSKVcvf9xzEcu0KCEPMnv/ysZKmdm48TUUW7PZ
 /0LgoxAwYFLy5lcIYP7YGW2/J1dSBiw9omqp3WqEekypYJnEruMkKqymN2yKFd4PwFCalVzyRz/
 D4fzN139eoxhNn41EpbKcXcgM5zVggF1zvv2Q5arQ3jm750Abc5AmY7xUFt8JWAxfOaA==
X-Received: by 2002:a17:90a:ec8c:b0:3a4:dc2c:be9e with SMTP id
 98e67ed59e1d1-3a6ce82e436mr4223235a91.51.1791018015805; 
 Sat, 03 Oct 2026 02:00:15 -0700 (PDT)
Received: from localhost ([2602:ffe4:806:2289:21fe:8574:7a8d:1dce])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e48c38bsm2314877a91.9.2026.10.03.02.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 02:00:15 -0700 (PDT)
From: Evanshenf <archwse@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Sui Jingfeng <suijingfeng@loongson.cn>, kernel test robot <lkp@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/loongson: Fix framebuffer selection in async cursor
 updates
Date: Sat,  3 Oct 2026 09:00:13 +0000
Message-ID: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

An asynchronous cursor update swaps the new framebuffer into the live
plane state. However, the driver reads both old_fb and new_fb from the
live state before this swap. When an enabled cursor changes buffers, the
address-update condition is therefore false and the hardware continues
scanning the previous buffer.

Read new_fb from the new plane state before swapping the framebuffer
references. This updates the hardware address when the framebuffer
changes while retaining the existing behavior for cursor movement.

Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64 legacy
cursor updates. Callback counters and read-only register observations
confirmed the asynchronous path, the stale address before the change,
and the new address afterward. Same-framebuffer movement and cursor
disable/re-enable also passed, with the primary framebuffer and mode
unchanged.

AI assistance was used to investigate the existing report, prepare the
fix and test tools, run the build and hardware comparison, and draft
this message.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Evanshenf <archwse@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
index bcc0ffa..7b9c65c 100644
--- a/drivers/gpu/drm/loongson/lsdc_plane.c
+++ b/drivers/gpu/drm/loongson/lsdc_plane.c
@@ -230,7 +230,7 @@ static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
 
 	new_state = drm_atomic_get_new_plane_state(state, plane);
 
-	new_fb = plane->state->fb;
+	new_fb = new_state->fb;
 
 	plane->state->crtc_x = new_state->crtc_x;
 	plane->state->crtc_y = new_state->crtc_y;

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.43.0

