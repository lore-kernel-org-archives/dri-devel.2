Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ADCCD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722F110E631;
	Sun, 10 May 2026 10:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="AyOJRuHr";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B11B10E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=bLfORmC5aPVuu+uW8Qajt0bwyQArv6YG/8T5MiSJpBQ=;
 b=AyOJRuHr9x9rK2iJAc+Q3FO94V2mWH/SQXravs9nPn9WHn8gQTGR4ovSTWW4LR
 1j2j++21sz71tmnR7XkA7poKLQCgfSKLSYScZ0vSX013onY/Je74w3EWJcuhC2JE
 i+PMrikt4+hUiD5BOPOhyWiVv/bCZhdhesSKofWbvy7/Y=
Received: from [127.0.1.1] (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgCXy7Fi8f5pRiRkDA--.52S2;
 Sat, 09 May 2026 16:33:40 +0800 (CST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] drm/rockchip: Fix dangling crtc->state in
 vop2_crtc_reset()
Message-ID: <177831561857.322716.12441367864582734767@163.com>
Date: Sat, 09 May 2026 16:33:38 +0800
In-Reply-To: <177831560568.322716.7926332149561323511@163.com>
References: <177831560568.322716.7926332149561323511@163.com>
X-CM-TRANSID: QCgvCgCXy7Fi8f5pRiRkDA--.52S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xGFykGw4kCF4DWF4rKrg_yoW8Jw4fpr
 s7Cryj9r4UKrWjqrnrJr1xursak3ZFyayxGr97Gw13u3Wjqwn8CrnI9ryqv3y7ArWfA3yj
 yrs7Jw45ZF4qyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USoGdUUUUU=
X-Originating-IP: [42.63.126.112]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbCzgWvA2n+8WUlVAAA3V
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

In vop2_crtc_reset(), if kzalloc() fails to allocate a new
rockchip_crtc_state, the function returns early without setting
crtc->state to NULL. However, the old state has already been destroyed
and freed by __drm_atomic_helper_crtc_destroy_state() and kfree().

This leaves crtc->state as a dangling pointer. Any subsequent access to
crtc->state (e.g., through to_rockchip_crtc_state()) will result in a
use-after-free or NULL pointer dereference, leading to a kernel crash.

Fix by setting crtc->state = NULL when kzalloc() fails, ensuring the
pointer is in a well-defined state.

Signed-off-by: Jiaqi <shijiaqi_develop@163.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 8afabe2118a9..1234567890ab 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2082,8 +2082,10 @@ static void vop2_crtc_reset(struct drm_crtc *crtc)
 	}

 	vcstate = kzalloc(sizeof(*vcstate), GFP_KERNEL);
-	if (!vcstate)
+	if (!vcstate) {
+		crtc->state = NULL;
 		return;
+	}

 	crtc->state = &vcstate->base;
 	crtc->state->crtc = crtc;
--
2.40.0

