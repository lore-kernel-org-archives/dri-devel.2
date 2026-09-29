Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC0BCA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9AF10ED6D;
	Tue, 29 Sep 2026 08:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="dQdvlNYW";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E69310EC69
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:19:07 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34b4f2d90c4so132458eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651946; x=1791256746;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rChgDG4+9LHVh/7Fh95cpWNAythLuYoy13f8pIwvxIg=;
 b=dQdvlNYW2lS5AQC/jUjWPu6becawZRHWAtMkfSqH+trG8kpevCYQbnoLGLA5zQ3fTG
 hecA5jXu+spPRVUE3CJZNrhdjlJE4sy2MbkPgJN9Kdq5XsuAQDdhmJ83Wxvs+WhVOHLi
 4H9XtUPWo3jauCatLHt9Mftlkx+wu5QoLZhwMecbnaTkPIp0Mdk2G/ZA5CPBXOBy29gz
 xCdsMkjq5u7hvwt/X2P0jBVkdhS3hiSy0vSTV9IHHVKVZvmvp2JirYaaUV0Rd72zWGb1
 rEON00vGF2vCIB+VhVvgNsZ55VyAeaMrfCm5VkBOc+KrdUGQqloJVtTY2Su/ooaAFkjY
 0QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651946; x=1791256746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rChgDG4+9LHVh/7Fh95cpWNAythLuYoy13f8pIwvxIg=;
 b=EM42v/gm+yWUoUAeMWw4OhfW2JTZtv0MMKhzbrsDhApX/P5uf7HsCSEHU6FADmYfYF
 CqMB5+IDCp4KB6T7yo2h0q/BhooxVVnZA4fPoLoZa96k79UClwKZlfDbWyklWStd8Fpg
 xR31eQRPW9b6XwdFHi4e3M6Wd+ceJRHL8NgNCv2i+2GP6UIXFiCmTqiVnp9Wjbmx9Gva
 ysEsZHC3lPpyaF2g1RWc4YCC0anvjP78mVmpZ0JyBpQuJ/RC1jNxGFartCam/PfRHWpo
 l1wNZhyOHkMyA4U76EREYF0DNdQXEJ/UGEbPEhZQouiaEhznGT54Us/2YXW7fsJGK9hD
 8UBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5u10UP7obGWAsAbawjPmE2vwBrpmyUv16AOF7FvFfVEG05WmGvtOjcOvx6jxUZcy9Ajdm+Dx4FnE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNFZrl1vZmE4471Vn7Y1pJPgOvQWjnw7oXp7DMv1rbeR8BzKO/
 ZbZitjcu6gzRfzosco4YO1oGI/k3WLVl1eJ6ESmDjWD/PdSiZPle1vkGuLRcbGNcbh8=
X-Gm-Gg: AYBFou3mKzUGw4VOml47eGXSkmtKSE4BDMXsMyu9HEB+dUfzKnkDwh71CgvGuOwqssa
 ATuP7LsDmiFZsfqJKidbs3qobiwY/WdL6P+17CDZnMA4ITdd7GM75DfiTe61OcgQDgCXTyNbD2k
 KpMncXHQINrgKE+WGIqqKh7YqgpgS6B/EQls1qYtFuynlVNxabQmt7wfQAIpLIB8/voeAv2FYh3
 6XNX23QdmVOjaa99mY7oGRKXCJ7IXqEX+fGGpSNBq6Hc+6B7qi23lFxywgFlQVo7dOuBp0QYGfD
 7fjSDfUOFuqfKdr25+GPGs3CFWTIiP+iNJE19WTBZRqiemAhwAU57AFz2fLMLr6HN2nS4ZN+O5M
 xBK+G2bvSa93NJk+S+TlsrQvEPCFblxsQDCk4tJk2XHgDFMa7mvENQMu5GzV5WlvDarLIvJjZms
 8dSu1B37ZyjBZn53AxvkjcqBv0krHjVAOWdIjYNErTvPQ4F2ppLZXJwvmUQ+Tg8cpdD6rLQyxwm
 K/Odb79TG7OMBnxpEbxQdyScyWjssPOH8JOCQt5c1N++l3LFTo125T+/wu0sBHmWA==
X-Received: by 2002:a05:693c:62dc:b0:33b:ef1f:14b9 with SMTP id
 5a478bee46e88-34271a92cb8mr10274241eec.15.1790651946136; 
 Mon, 28 Sep 2026 20:19:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34141a4a00dsm33740601eec.1.2026.09.28.20.19.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:19:05 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona@ffwll.ch>, jason-jh.lin@mediatek.com
Subject: [PATCH 6.6.y] drm/mediatek: Fix potential NULL dereference in
 mtk_crtc_destroy()
Date: Mon, 28 Sep 2026 23:19:01 -0400
Message-ID: <20260929031902.88182-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 4018651ba5c409034149f297d3dd3328b91561fd ]

In mtk_crtc_create(), if the call to mbox_request_channel() fails then we
set the "mtk_crtc->cmdq_client.chan" pointer to NULL.  In that situation,
we do not call cmdq_pkt_create().

During the cleanup, we need to check if the "mtk_crtc->cmdq_client.chan"
is NULL first before calling cmdq_pkt_destroy().  Calling
cmdq_pkt_destroy() is unnecessary if we didn't call cmdq_pkt_create() and
it will result in a NULL pointer dereference.

[ Backport to 6.6.y: used the older Mediatek CRTC file and helper names. ]

Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/cc537bd6-837f-4c85-a37b-1a007e268310@stanley.mountain/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm mediatek maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-53056. It skips command-packet destruction when
channel setup failed before packet creation.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-53056
Upstream: 4018651ba5c409034149f297d3dd3328b91561fd

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 859dffe4513722..1e8052a0425ee5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -163,9 +163,8 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
 
 	mtk_mutex_put(mtk_crtc->mutex);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
-
 	if (mtk_crtc->cmdq_client.chan) {
+		mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
 		mbox_free_channel(mtk_crtc->cmdq_client.chan);
 		mtk_crtc->cmdq_client.chan = NULL;
 	}
-- 
2.39.5

