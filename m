Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F2BCD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B4B10E417;
	Sun, 10 May 2026 10:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="FwIfTZ8q";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF17810E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=fIg7jH6l469fjJ3LU/wSfvIfeolPJim4znYYu484JlI=;
 b=FwIfTZ8qDxN8sJoicgyWnyIctN5s0yR8cQu3cxsmST0LVTZyOWlHc3r5VI8zkE
 wR/+6RKKYdbGvF9J7kE+fMOXSbqWrxfsxC5rVOyCXA4sHB8CHL9M9xJQcSTSE4D7
 E32NRifoFhJwnvqMqM0NlcQhaKVylsV8+6orgaQu/KXBM=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wB3LZNd8f5pUxZsAQ--.35506S2; 
 Sat, 09 May 2026 16:33:33 +0800 (CST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] drm/rockchip: Fix of_node reference leak in
 rockchip_drm_encoder_set_crtc_endpoint_id()
Message-ID: <177831561279.322716.8618557593387718298@163.com>
Date: Sat, 09 May 2026 16:33:32 +0800
In-Reply-To: <177831560568.322716.7926332149561323511@163.com>
References: <177831560568.322716.7926332149561323511@163.com>
X-CM-TRANSID: _____wB3LZNd8f5pUxZsAQ--.35506S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4UWr18Xry5ZFW3Zw17trb_yoW8Ar13pa
 n3Gr9Yvr48GrWfWr10yr47ArySkws2va17CF97C3W3Zan3ArnYyw1fKF1vgr15ArWxuFyj
 yrs7Ga4j9F17urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjnQUUUUUU=
X-Originating-IP: [42.63.126.112]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbC7x2tAWn+8V1hpgAA3i
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

The function rockchip_drm_encoder_set_crtc_endpoint_id() acquires device
tree node references via of_graph_get_endpoint_by_regs() and
of_graph_get_remote_endpoint(), but never releases them. This happens on
all exit paths, including the success path.

This leads to reference count leaks that accumulate during encoder probe.
In deferred probe scenarios or module reload, the leaked references can
cause of_node_get() to eventually return -ENOMEM, breaking subsequent
device tree parsing.

Fix by adding the corresponding of_node_put() calls for both 'en' and
'ren', and use a unified error path to avoid duplication.

Signed-off-by: Jiaqi <shijiaqi_develop@163.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 14 +++++++++----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 8afabe2118a9..1234567890ab 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -278,18 +278,22 @@ int rockchip_drm_encoder_set_crtc_endpoint_id(struct rockchip_encoder *rkencoder,
 {
 	struct of_endpoint ep;
 	struct device_node *en, *ren;
 	int ret;

 	en = of_graph_get_endpoint_by_regs(np, port, reg);
 	if (!en)
 		return -ENOENT;

 	ren = of_graph_get_remote_endpoint(en);
 	if (!ren)
-		return -ENOENT;
+		goto err_put_en;

 	ret = of_graph_parse_endpoint(ren, &ep);
 	if (ret)
-		return ret;
+		goto err_put_ren;

 	rkencoder->crtc_endpoint_id = ep.id;

-	return 0;
+err_put_ren:
+	of_node_put(ren);
+err_put_en:
+	of_node_put(en);
+	return ret;
 }

 /*
--
2.40.0

