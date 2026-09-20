Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546A3C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E3410E46B;
	Mon, 21 Sep 2026 07:01:21 +0000 (UTC)
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch
 [217.26.49.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FD910E0E6
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:27:09 +0000 (UTC)
Received: from asmtp012.mail.hostpoint.internal ([10.4.1.185]
 helo=asmtp012.mail.hostpoint.ch)
 by mxout012.mail.hostpoint.ch with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.5 (FreeBSD)) (envelope-from <linux@sebastianvonarx.ch>)
 id 1x8MX9-00000000PZL-0xdw; Sun, 20 Sep 2026 20:45:03 +0200
Received: from [2a02:aa13:e47f:2280:d4b0:56c5:656d:f4f1] (helo=omarchy)
 by asmtp012.mail.hostpoint.ch with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.5 (FreeBSD)) (envelope-from <linux@sebastianvonarx.ch>)
 id 1x8MX8-00000000NQ9-49VF; Sun, 20 Sep 2026 20:45:03 +0200
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
Subject: [PATCH 0/2] drm/virtio: Open-code drm_simple_encoder_init()
Date: Sun, 20 Sep 2026 20:42:42 +0200
Message-ID: <20260920184244.464343-1-linux@sebastianvonarx.ch>
X-Mailer: git-send-email 2.55.0
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

Replace drm_simple_encoder_init() in the virtio GPU driver with
drm_encoder_init() and propagate initialization errors to the caller.

Sebastian von Arx (2):
  drm/virtio: Open-code drm_simple_encoder_init()
  drm/virtio: Propagate drm_encoder_init() errors

 drivers/gpu/drm/virtio/virtgpu_display.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.55.0

