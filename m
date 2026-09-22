Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D6C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFEB10E6A3;
	Tue, 22 Sep 2026 09:45:14 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D2410E6AD
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:45:11 +0000 (UTC)
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
 by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4hpwDf0XgwzBDqc2;
 Tue, 22 Sep 2026 17:44:50 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.46;
 Tue, 22 Sep 2026 17:45:03 +0800
From: shechenglong <shechenglong@xfusion.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Thomas Zimmermann
 <tzimmermann@suse.de>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
 <chenjialong@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [PATCH] drm/virtio: expose GEM memory statistics through fdinfo
Date: Tue, 22 Sep 2026 17:44:55 +0800
Message-ID: <20260922094455.1799-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.82.130.100]
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)
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

virtio-gpu does not expose per-client GEM memory usage through DRM=0D
fdinfo, leaving monitoring tools unable to account for buffers owned by a=0D
client.=0D
=0D
Wire up the DRM fdinfo helpers and use drm_show_memory_stats() to report=0D
the standard drm-total-memory, drm-shared-memory and drm-active-memory=0D
fields for GEM objects referenced by each DRM file.=0D
=0D
Tested on a QEMU/KVM guest with virtio-gpu. After running:=0D
=0D
  modetest -M virtio_gpu -s 40:1024x768=0D
=0D
the DRM file descriptor of the modetest process shows the following in=0D
/proc/<pid>/fdinfo/<fd>:=0D
=0D
  drm-driver:         virtio_gpu=0D
  drm-client-id:      8=0D
  drm-pdev:           0000:00:02.0=0D
  drm-total-memory:   3 MiB=0D
  drm-shared-memory:  3 MiB=0D
=0D
Signed-off-by: shechenglong <shechenglong@xfusion.com>=0D
---=0D
 drivers/gpu/drm/virtio/virtgpu_drv.c | 13 ++++++++++++-=0D
 1 file changed, 12 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c=0D
index 2aaa7cb0808..d43d7ddac60 100644=0D
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c=0D
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c=0D
@@ -323,7 +323,17 @@ MODULE_AUTHOR("Dave Airlie <airlied@redhat.com>");=0D
 MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");=0D
 MODULE_AUTHOR("Alon Levy");=0D
=0D
-DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);=0D
+static void virtio_gpu_show_fdinfo(struct drm_printer *p,=0D
+                                  struct drm_file *file)=0D
+{=0D
+       drm_show_memory_stats(p, file);=0D
+}=0D
+=0D
+static const struct file_operations virtio_gpu_driver_fops =3D {=0D
+       .owner =3D THIS_MODULE,=0D
+       DRM_GEM_FOPS,=0D
+       .show_fdinfo =3D drm_show_fdinfo,=0D
+};=0D
=0D
 static const struct drm_driver driver =3D {=0D
        /*=0D
@@ -347,6 +357,7 @@ static const struct drm_driver driver =3D {=0D
=0D
        .gem_create_object =3D virtio_gpu_create_object,=0D
        .fops =3D &virtio_gpu_driver_fops,=0D
+       .show_fdinfo =3D virtio_gpu_show_fdinfo,=0D
=0D
        .ioctls =3D virtio_gpu_ioctls,=0D
        .num_ioctls =3D DRM_VIRTIO_NUM_IOCTLS,=0D
--=0D
2.43.0=0D
