Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1403DC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3197110EA2B;
	Tue, 11 Aug 2026 01:56:40 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E973210EA2B
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:56:38 +0000 (UTC)
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
 by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4hJvmd1SQQzBL0v1;
 Tue, 11 Aug 2026 09:53:53 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Tue, 11 Aug 2026 09:56:32 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <airlied@redhat.com>, <kraxel@redhat.com>,
 <dmitry.osipenko@collabora.com>, <gurchetansingh@chromium.org>,
 <olvaffe@gmail.com>, <maarten.lankhorst@linux.intel.com>
CC: <mripard@kernel.org>, <tzimmermann@suse.de>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
 <chenjialong@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [RESEND PATCH] drm/virtio: check return value of vgdev_output_init()
Date: Tue, 11 Aug 2026 09:56:24 +0800
Message-ID: <20260811015624.830-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20260802101108.1595-1-shechenglong@xfusion.com>
References: <20260802101108.1595-1-shechenglong@xfusion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.82.130.100]
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
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

The return value of vgdev_output_init(), called by=0D
virtio_gpu_modeset_init(), is not checked. As a result, modeset=0D
initialization continues even if an output fails to initialize.=0D
=0D
check the return value and return the error to the caller.=0D
=0D
Signed-off-by: shechenglong <shechenglong@xfusion.com>=0D
---=0D
 drivers/gpu/drm/virtio/virtgpu_display.c | 7 +++++--=0D
 1 file changed, 5 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/vir=
tio/virtgpu_display.c=0D
index 44ffffec550f..f2b98d018c1e 100644=0D
--- a/drivers/gpu/drm/virtio/virtgpu_display.c=0D
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c=0D
@@ -378,8 +378,11 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *=
vgdev)=0D
=0D
    vgdev->ddev->mode_config.fb_modifiers_not_supported =3D true;=0D
=0D
-   for (i =3D 0 ; i < vgdev->num_scanouts; ++i)=0D
-       vgdev_output_init(vgdev, i);=0D
+   for (i =3D 0; i < vgdev->num_scanouts; ++i) {=0D
+       ret =3D vgdev_output_init(vgdev, i);=0D
+       if (ret)=0D
+           return ret;=0D
+   }=0D
=0D
    ret =3D drm_vblank_init(vgdev->ddev, vgdev->num_scanouts);=0D
    if (ret)=0D
--=0D
2.33.0=0D
=0D
