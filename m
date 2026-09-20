Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E94C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A18A10E381;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Received: from mxout013.mail.hostpoint.ch (mxout013.mail.hostpoint.ch
 [217.26.49.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D69D10E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:04:40 +0000 (UTC)
Received: from asmtp012.mail.hostpoint.internal ([10.4.1.185]
 helo=asmtp012.mail.hostpoint.ch)
 by mxout013.mail.hostpoint.ch with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.5 (FreeBSD)) (envelope-from <linux@sebastianvonarx.ch>)
 id 1x8MXA-00000000G8V-0Xed; Sun, 20 Sep 2026 20:45:04 +0200
Received: from [2a02:aa13:e47f:2280:d4b0:56c5:656d:f4f1] (helo=omarchy)
 by asmtp012.mail.hostpoint.ch with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.5 (FreeBSD)) (envelope-from <linux@sebastianvonarx.ch>)
 id 1x8MX9-00000000NQ9-3uLY; Sun, 20 Sep 2026 20:45:04 +0200
X-Authenticated-Sender-Id: linux@sebastianvonarx.ch
From: Sebastian von Arx <linux@sebastianvonarx.ch>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Sebastian von Arx <linux@sebastianvonarx.ch>
Subject: [PATCH 2/2] drm/virtio: Propagate drm_encoder_init() errors
Date: Sun, 20 Sep 2026 20:42:44 +0200
Message-ID: <20260920184244.464343-3-linux@sebastianvonarx.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920184244.464343-1-linux@sebastianvonarx.ch>
References: <20260920184244.464343-1-linux@sebastianvonarx.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

vgdev_output_init() ignores errors from drm_encoder_init(), so output
setup continues even when encoder initialization fails, for example
because of an allocation failure.

Check the return value and propagate the error to the caller.

Assisted-by: LLM
Signed-off-by: Sebastian von Arx <linux@sebastianvonarx.ch>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index b01178027..1c790d6a6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -310,7 +310,11 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs, DRM_MODE_ENCODER_VIRTUAL, NULL);
+	ret = drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret)
+		return ret;
+
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.55.0

