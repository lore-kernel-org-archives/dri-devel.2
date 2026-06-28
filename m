Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC65DC43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 13:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74A010E476;
	Sun, 28 Jun 2026 13:59:00 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367A310E609
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.74.7])
 by APP-05 (Coremail) with SMTP id zQCowAA3j9KZKEFqkmTHFQ--.45211S2;
 Sun, 28 Jun 2026 21:58:50 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: xinliang.liu@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: sumit.semwal@linaro.org, yongqin.liu@linaro.org, jstultz@google.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 WenTao Liang <vulab@iscas.ac.cn>, Greg KH <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/hisilicon: fix dangling pointer in kirin_drm_crtc_init
Date: Sun, 28 Jun 2026 21:57:00 +0800
Message-Id: <20260628135700.46645-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3j9KZKEFqkmTHFQ--.45211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4kKrWkZw18GF15CryUWrg_yoW8GrWUpr
 W3urWavry5AF4ftFyjkFy29rWjkanrtFyxur18Cw1avrs0qFyUJ3sIvryktF98ArWxJaya
 qr4kta1fXr18CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
 nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2pBJXEE3QAAsu
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

of_get_child_by_name acquires a reference on the port node, but
of_node_put is called before crtc->port is assigned. This releases the
reference while crtc->port still holds the pointer for later use by
drm_of_find_possible_crtcs. Fix by moving of_node_put after crtc->port
assignment.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 89a565dba1a0 ("drm: kirin: Move ade drm init to kirin drm drv")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 8a11c2df5b88..2fda894d482e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -53,8 +53,9 @@ static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
 		return -EINVAL;
 	}
-	of_node_put(port);
+
 	crtc->port = port;
+	of_node_put(port);
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
 					driver_data->crtc_funcs, NULL);
-- 
2.39.5 (Apple Git-154)

