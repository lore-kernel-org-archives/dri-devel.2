Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB6EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87CE10F2D3;
	Wed,  8 Jul 2026 21:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LKskitui";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA1D10F2D3
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:54:20 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493bab44440so1981685e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783547659; x=1784152459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=864WgdCGKVvhVw+X58LxeAIhuiQbwracGrd3VXI+iDM=;
 b=LKskitui/ezk1ki4R+WnX82qb0UDD+YRyHyDpORQ0TO3aMfUhvncnxdqYfIx4hhXAz
 TUifXCvTV4XIpJr78XLvUsmAjanHEBsq7KOek02eePQ1fowzNxRKcKYyJDgLZZVlhV+o
 C+pN4nrY88JbPyyz0BN0FXgLf/Ovi0h630XpS1ucQ73c9EaglafhR8zrRmPHUxIlu86O
 Olsll0x37DJiStaoYqK3bM2SxLfPNDR6p+iVNoh3gp2SbBgVhoWfjvyNofYtDnuv2962
 Ita+dgRSTx/XlFRlAySRidelgRVjnEkskOnm7HxkP9WD7BHBx/9jSKPmjHeqp8dy5bKT
 +36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783547659; x=1784152459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=864WgdCGKVvhVw+X58LxeAIhuiQbwracGrd3VXI+iDM=;
 b=gl2Yxge+4DJoVji9eBv8Sio9BWT7nsvohdUYQ/zmSw+lksgKO/q9SD22oHBhgxcMhb
 ZByyGtupsOcHClVDLa/oOLKEbG0vfPxU4xHXv/ABP/AB8rfqxoLgwln8XF6WkG4Wd2+j
 LmEGUhX41CbC8y5Rcd6uJM3UUfEKxmlJWhMgvYpuOr7CYdBtt/+wNk582nedFQ57ThuD
 aNdecAA30NoySaRtH5Pc6/aOIRTgltatWgR6MviyiiGtS+dHKeLZXUqdQMGvWj6nWLRW
 upt84s60G6QWZEtFcpZzYsLpF9DpLx17Rhm0/+GFyhdI0wblHuK3MTTK6PgfzT+DxYSl
 Fj1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNWr041poEDBzFOcAfpawWWLzItVTjHXB7Lk/cSYEZRMpmcUW4lz0KuELlX+GOOBnAfeSCVkFD4dU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzsz+5kWyz+n0wVbKle2z8pHJZaVni8RwSt9j6FipLBqt7T8Kl1
 U1z2oOI90cbyO4wmyyak3v40ItdLeIFQmkUQkbtP141aM9eiEXE1CnGg
X-Gm-Gg: AfdE7cmzTiplfwKiq39aYu3mL+BKdatFAp44IIbLf5Civ/iaUBwmsN0TLVwz67Dm8Rw
 ZEEahVflXQ+4TLyCMvkDdcJxfUDaD3EF/kmf9Qd2aP4KevR8vPvUc/ioYv5K/isQHhapjLHc2hs
 iZ9+ipjrUBXbLRTKRD8vtT0aMPjapINFk88icFEtPXHexPTj4ZAnP2x24/Mf/ZE3YuVz24yJMbS
 k/1q6YdOyQETOxy4QccVVVNmlkxsQCB/f/Vqoc5IiNbNbfw8I2R1uPmMwVxJvWhSBlMiOpboAIu
 gbUhTOiEMdk9SZ96yClMDpnzkjN8BrHf/SPIN59bw56OBlDaYk+3fBgfGieeysiUetwDFknzpXI
 dl/KpJRV43bNio5s3EUMuL7VSOGkJzZGaG8DN1NZHs2PDm7lY8NqZpCputlcCFiY5WApg02Pv3Z
 zFvXKt9dZhzgl4hyjjZjdAVRaKEkMgkTi2NLua0v7ttXBCGVg/5w==
X-Received: by 2002:a05:600c:3421:b0:493:cbd4:8925 with SMTP id
 5b1f17b1804b1-493ec55d788mr490785e9.4.1783547658604; 
 Wed, 08 Jul 2026 14:54:18 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:7550:b182:7bdf:fbd0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47df6a31dd5sm1032704f8f.16.2026.07.08.14.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 14:54:18 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/imx: ipuv3: handle PRG channel configuration failure
Date: Wed,  8 Jul 2026 23:54:16 +0200
Message-ID: <20260708215416.147586-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ipu_prg_channel_configure() can fail when no PRE is available for the PRG
channel, but ipu_plane_atomic_update() ignores its return value.

Atomic check is expected to prevent this condition. If it still happens,
warn and abort the update instead of continuing with the original
framebuffer address after the PRG/PRE setup failed.

Fixes: 00514e859335 ("drm/imx: use PRG/PRE when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index d6806d1ae6e1..78a3ea0581c0 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -629,10 +629,14 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 	 */
 	if (ipu_state->use_pre) {
 		axi_id = ipu_chan_assign_axi_id(ipu_plane->dma);
-		ipu_prg_channel_configure(ipu_plane->ipu_ch, axi_id, width,
-					  height, fb->pitches[0],
-					  fb->format->format, fb->modifier,
-					  &eba);
+		if (WARN_ON_ONCE(ipu_prg_channel_configure(ipu_plane->ipu_ch,
+							   axi_id, width,
+							   height,
+							   fb->pitches[0],
+							   fb->format->format,
+							   fb->modifier,
+							   &eba)))
+			return;
 	}
 
 	if (!old_state->fb ||
-- 
2.43.0

