Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FAACA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D899210E4E0;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from mail-qk2-f10.google.com (mail-qk2-f10.google.com
 [74.125.230.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3FC10E0CD
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:43:06 +0000 (UTC)
Received: by mail-qk2-f10.google.com with SMTP id
 af79cd13be357-930f59d1dc6so59594685a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679385; x=1792284185; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/oAaJptKR3nQekIsHSFFz9kgi+8N/4Ku6bTVc5nJSg=;
 b=dQ5krt44doQC76u+OyJOJkT5dAwlHAu7MxUEscHeqXnUQ0LJwCW6sbYcu4pmWgu96N
 3kOLdcxG7WS62DL4XKLqhjH0jMFeAnwCx/ECYI72Ir/fOwHdnGWG74/3GZc/rue3X3qa
 cZPDzX04LE/TjeePFlXOYFndx7F4vHYgTjxD7W0+0zQh07yMBtlmWOFPwZGpChK8nPje
 ykqY875N5PIb4ZF5InOuy8lTQympdCOB8aNKQonWTE6eSZkJzin/evhUJPlEKftEUeJ8
 ZZOUCkDokz/MBE4UYdJ6twM5G4wuSc/hB1OpwLJ0GASiN3LuY1VPGE3BNr74lnxS7U/Y
 d2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679385; x=1792284185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w/oAaJptKR3nQekIsHSFFz9kgi+8N/4Ku6bTVc5nJSg=;
 b=Q+IK3QlcbQYVDC2dwIi5aWvOqNv6WXLqtOYkDxZaZ8WXXouudPnLAGLBNjJK68EOkZ
 trGxNQNBnt4wcaKpYhL8fE4bdyd7OnEmGu19h6LvaYjAFd5Ss0UaqBUlS/eTgY4P5Erp
 A5fk22xtm+DBoHmRLoRLHZbHcS5z6o+a0zs2uR74dq8u8nwpG5gMlxSt0CurKlJwOFQn
 pghinSP+bhwfQ5wGCXvU2CHe8+fHyg51CIR0VwRQn+ZJ1q+x2tybxXncCdpJd6XOnl7D
 okRsPWyfGop77yPFuj7Tcb0bS9Q3duNyVIXXb7cp8gz1t23y3UftCPR3xCi34aAnIkR4
 0dZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy+soQ/n/kvBUZ5/Q/zm0d1hldXeynRbvTLXVaHLLnCqjRnowFdHa0g4Fo4o7VlZcO3iZklwh6H2M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIKKa32xOowdOHXTVSQsIvSCv/vWLo4K0QKEM+T0TKL9SSXJrL/
 g+l+JmLXZYwQYfzUnyJPn+5WC0vn9SK5gLAjSye3w30Fj21VeExqwA02
X-Gm-Gg: AYBFou2t0DJy+UUL83v/kDclA7e60Q1H12bvgsuQas1BCLhvnPA4XiRDAxsw7IpqQ1n
 vO0jK4qJ/o2YOAdHZ9/0tweMsLUw4gCfy0emipVgrQ94gRLhn3kBrtEwDWUsMo2EBVt1npFfIcc
 sk5ZZnHIxb64263rKWLYO4ZQonJT3J7Xku9Ty/7kd8+xEm9aUUBV4nJ5DxWrpXlqOGtO3LVdcen
 Dw52ovErhr10SHGUh1uqEyPV5ECbi592I7FDvk2HMfLcakP2dgIuI8qpHybbjFwQkeJq9STMi0T
 4Iyvk0LRHLd8NnaAnK/TCpCp39aZxIE5GS+nVL4QmybU4yYz87ETMw9Vjd12X2VX0HVVLOssIxh
 iW1KIXzT28RQ4FZVu9dvc45MNYzBU2XxtjBbmMzbsnKQTuyOnZcusoZHhIifZgW+pcOe0MfNxZU
 oolZH80TsuFxrwW96NrxbLJWT1u1Ggr8lRCne3FCm1NfenKJMZHVba9P3N7ndUAr8MRFbv21XN6
 BGdwA==
X-Received: by 2002:a05:620a:c53:b0:93c:677c:778d with SMTP id
 af79cd13be357-93ebd29275cmr999021285a.59.1791679384961; 
 Sat, 10 Oct 2026 17:43:04 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9848702sm532320085a.12.2026.10.10.17.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:43:04 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jason-JH Lin <jason-jh.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Nancy Lin <nancy.lin@mediatek.com>, Nathan Lu <nathan.lu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/mediatek: mtk_crtc: Skip the empty connector route
 slot in destroy
Date: Sat, 10 Oct 2026 20:42:47 -0400
Message-ID: <20261011004248.1117649-3-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011004248.1117649-1-agentzoan@gmail.com>
References: <20261011004248.1117649-1-agentzoan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

A CRTC created with connector routes gets one extra ddp_comp[] slot for
its output component, and ddp_comp_nr counts it, but the slot stays
NULL until mtk_crtc_update_output() fills it in the first atomic
enable.

mtk_crtc_destroy() walks all ddp_comp_nr slots and passes each one to
mtk_ddp_comp_unregister_vblank_cb(), which dereferences it. Tearing
down a CRTC that was never enabled therefore dereferences NULL: unbinding
or removing mediatek-drm while that display path was never used, or
an error in mtk_drm_kms_init() after the CRTC was created.

Skip the empty slot. Nothing was registered for it anyway: the routed
components (DSI, DPI, DP_INTF, ...) have no vblank callback.

Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
Assisted-by: LLM
Signed-off-by: zoan37 <agentzoan@gmail.com>
---

Notes:
    Testing: found by reading the code; not reproduced. The same check runs
    on the MT8189 Chromebook described in patch 1 (boot, HDMI/DP hotplug,
    suspend/resume), but that does not exercise the destroy path (the
    driver is built in and was not unbound). Compile-tested (W=1) on
    next-20261008.

 drivers/gpu/drm/mediatek/mtk_crtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index b54f8565d2fa..704931b369b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -145,6 +145,10 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
 		struct mtk_ddp_comp *comp;
 
 		comp = mtk_crtc->ddp_comp[i];
+		/* The connector route slot is empty until the first enable */
+		if (!comp)
+			continue;
+
 		mtk_ddp_comp_unregister_vblank_cb(comp);
 	}
 
-- 
2.43.0

