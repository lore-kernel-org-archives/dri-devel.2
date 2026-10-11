Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121CCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD0B10E520;
	Mon, 12 Oct 2026 07:32:08 +0000 (UTC)
Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B4C10E0CD
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:43:04 +0000 (UTC)
Received: by mail-qk2-f3.google.com with SMTP id
 af79cd13be357-93cc1b028bcso84122185a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679383; x=1792284183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/9++rHuAww9Im2B2wfP7togskszZqup/CYoTLkYiciU=;
 b=O+hoEKScICHds4vPlZSwUU1GqPmMcMRK/+thr1tJdef2PSjQORHRiecmtRUEKPXjTS
 HRfiCMdJtSQAiM5DT1pSA4NIormMTalPW4fNU9ctYWVpEnQI8pR9BPsirkSolEoYnpJ8
 UIoQBbgqrhP5h+0qOMebDPz2K/AQG+J0dpuwWHJid0b+RdTsXEZmBEuQrLgU40X+z5L7
 3AZGvBUYrkLSdNbY+x1YYhPNMWvIHcSLX6fwlo/UwcZczDrESTKbHu1gUnjLePXP3aKi
 zTUQEJXsCJoqp6bLkZ28B7P+yi4K2iVsFarrT4eU/WDZk1GK32hhQGtvRGMKJk1jbdB0
 ibTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679383; x=1792284183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/9++rHuAww9Im2B2wfP7togskszZqup/CYoTLkYiciU=;
 b=oGvDMejKO+ouUoMEsssvdrSol9eaXKVPj19aEK5sok+ynw9Uk+QW+7nRKXUvT2FVKb
 eHL2xu2mZq9RVEdpvlKojko3ieVizX/SRx35/8Qx/2xol7g1EVHX7DW7ap79KLmPtEsk
 sLd+DyEUr1T2cDA62Oet19SSrxFY9I9SLaLMkaGndpUgy3e7Ax9UcaJ0a4SdYbvpVIni
 9snRF6PJFgV+elFH+B7AS1ZmLAUUzy4sE3gJAbdKUqVgBq05U36f93lFCNi7lQKM1V5P
 ZWtO+gKtHqbq6QoUFLhU+phq7WyvCU0qZ4ER2dAuschq35mcDl5TQsGma5iSYEOu5Y9V
 19fw==
X-Forwarded-Encrypted: i=1;
 AKwUvByo4Bf2jMkJ6Y/pTkMEHkTy/G0hfU+NLudydFPdH3fNBxRgTDh2fuZBlg2rfXj6A2o7xgqWaCRYKDI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKy6TrW7OUqItvjrHXu3WkmyG1SALpTWJzUXJbUjYfJ+spyvvJu
 XGkTsIwfTzuSgzsQPCwqpB6fnDOeEvyi8t2vfO53EOAAVM5Zi97LKfKA
X-Gm-Gg: AYBFou2wmJd9HwcO8Cerqdi+KUS//EeZ5KqtHHibU1EWDBn/HIAy1KfX8W3ElgTbjfA
 8y1OqQRlSuHLMLBROMEMrCZsLb1zkSlzfdG1hI4mbhA5htLC8oqBtiJNhX+oXzUDNxTOlo0n8zh
 B4KZdo7ywdI/JekKTl/LHCe8cOK81H1KfXS7SVHLXqSdLBE06r4vWgDwUkM7kHhsgx/4iBPlYqG
 Xp3sXl5LUPbe03khLd75kcZQ+Rxws8lN4poXia0Gl/iyiB6weVtKXQuD7zGd2rxgHWmfYSCX+96
 wsC6ZR0UXQVaXnAD6tIuswbpUZzN8f3GxUH8anjSkVa8z8g1xaIQSELmeJhGv1RIQvuuOlm6YkR
 e9vH1tYJqq64l5qBWkusDR3XhW60J3+l9cYsxLisouEH8w+rWMDGgdsDaN1fpe12Tl3ary5fxCP
 GBkVEQ9i7Jyz0g+EqptAL6HPM5l5WfiOCPxjU2nKrJFj37X1WhKpGEo5/jf47hxhH//Aw=
X-Received: by 2002:a05:620a:444a:b0:93e:c12c:f13d with SMTP id
 af79cd13be357-93ec12d05e2mr893634385a.71.1791679383533; 
 Sat, 10 Oct 2026 17:43:03 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9848702sm532320085a.12.2026.10.10.17.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:43:03 -0700 (PDT)
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
Subject: [PATCH 1/3] drm/mediatek: mtk_crtc: Look up connector routes in the
 CRTC's own mmsys
Date: Sat, 10 Oct 2026 20:42:46 -0400
Message-ID: <20261011004248.1117649-2-agentzoan@gmail.com>
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

mtk_crtc_update_output() finds the private data of the display
controller (mmsys) that a CRTC belongs to with

  priv->all_drm_private[drm_crtc_index(crtc)]

but all_drm_private[] has one entry per mmsys (mmsys_dev_num entries),
not one per CRTC. mtk_crtc_create() gets the right entry from its
priv_data_index argument, and the two only agree when every mmsys
drives exactly one CRTC and the CRTCs are created in mmsys order.

When a CRTC with connector routes sits on an mmsys that drives more
than one CRTC, the lookup reads past the end of all_drm_private[] (or
picks another mmsys' data), and the route component taken from that
data's ddp_comp[] array is bogus. On an MT8189 board with connector
routes on the external display path (CRTC 1 on the only mmsys), the
first HDMI hotplug oopsed in the compositor's atomic commit.

With the route tables currently in the tree (only MT8188 VDOSYS0, whose
main path is always CRTC 0 and all_drm_private[0]) the two indices
happen to match, so nothing in-tree hits this yet. It triggers as soon
as routes are used on a path that is not the first CRTC of the first
mmsys.

Remember the mmsys private data mtk_crtc_create() used for the CRTC and
use it in mtk_crtc_update_output().

Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
Assisted-by: LLM
Signed-off-by: zoan37 <agentzoan@gmail.com>
---

Notes:
    Testing: on an MT8189 Chromebook (Lenovo IdeaPad Slim 3 Chromebook,
    "quigon") running next-20261008 with the not yet merged MT8189 display
    support and a local change that puts the connector routes
    ({1, DVO1}, {1, DSI0}) on the external path. Without this patch the
    first HDMI hotplug oopsed in the compositor's commit; with a
    functionally identical patch (the field had another name), HDMI
    (DSI0 -> IT61620 bridge, 3840x2160@30) and USB-C DisplayPort (DVO1)
    both come up on CRTC 1. Not tested on MT8188, the only in-tree user of
    connector routes, where the looked-up entry does not change. This exact
    patch was compile-tested (W=1) on next-20261008.

 drivers/gpu/drm/mediatek/mtk_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 2920f3198ef6..b54f8565d2fa 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -59,6 +59,7 @@ struct mtk_crtc {
 #endif
 
 	struct device			*mmsys_dev;
+	struct mtk_drm_private		*mmsys_priv;
 	struct device			*dma_dev;
 	struct mtk_mutex		*mutex;
 	unsigned int			ddp_comp_nr;
@@ -696,7 +697,7 @@ static void mtk_crtc_update_output(struct drm_crtc *crtc,
 	if (!mtk_crtc->num_conn_routes)
 		return;
 
-	priv = ((struct mtk_drm_private *)crtc->dev->dev_private)->all_drm_private[crtc_index];
+	priv = mtk_crtc->mmsys_priv;
 	dev = priv->dev;
 
 	dev_dbg(dev, "connector change:%d, encoder mask:0x%x for crtc:%d\n",
@@ -1055,6 +1056,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 
 	mtk_crtc->ddp_comp_nr = path_len;
 	mtk_crtc->mmsys_dev = priv->mmsys_dev;
+	mtk_crtc->mmsys_priv = priv;
 
 	mtk_crtc->mutex = mtk_mutex_get(priv->mutex_dev);
 	if (IS_ERR(mtk_crtc->mutex)) {
-- 
2.43.0

