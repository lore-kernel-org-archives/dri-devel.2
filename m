Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D7C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E163710EBA6;
	Tue,  1 Sep 2026 07:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XNi6HZiX";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 01 Sep 2026 06:55:55 UTC
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A136810E981;
 Tue,  1 Sep 2026 06:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788245753; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Jb6xdPLG8EuYdMQ/gBekTiRiS+tQQXrON9lxGVmWOmU=;
 b=XNi6HZiXTIh5IqGFYCqrfNHNJK1aUhAgu//2WEKNFxf5k9zPvKDoFmxN80DmNImZKIa+yz5StUqB0TI+/xxVEizIoduGV3TnijJyC30DGO+qLxTdVtU1GQg52JD1H4r0INgci6Ncaq529fe0eopmHOgNObnGwLOJdITa+VZuKg8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=qinyuntan@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0XA4XWS6_1788245447; 
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com
 fp:SMTPD_---0XA4XWS6_1788245447 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 01 Sep 2026 14:50:49 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, airlied@redhat.com, jfalempe@redhat.com,
 kraxel@redhat.com, dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 0/4] drm: create blend mode property on alpha-capable planes
 of simple drivers
Date: Tue,  1 Sep 2026 14:50:41 +0800
Message-ID: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed"), drm_mode_config_validate() warns when a
plane exposes an alpha pixel format but does not create the "pixel
blend mode" property. Several simple/virtual drivers trip this on
driver load. I hit the ast one on an ASPEED AST2600 BMC:

  [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
  ...
  Call Trace:
   drm_dev_register+0x1ce/0x290 [drm]
   ast_pci_probe+0x19d/0x3f0 [ast]
   local_pci_probe+0x41/0x90

These four drivers share the same gap; this series covers ast, qxl,
virtio-gpu and vboxvideo.

These planes have always blended with pre-multiplied alpha: the
hardware (or host-side compositor for the virtual drivers) is fixed
function with no configurable blend mode, and userspace has
historically assumed pre-multiplied blending when the property is not
attached, which is also the documented default of the property. So
each patch simply exposes the "pixel blend mode" property advertising
only DRM_MODE_BLEND_PREMULTI, making the existing semantics explicit
and silencing the warning. No functional change.

This follows the same approach as the already-merged i915 and nouveau
fixes:

  67e955e073c6 ("drm/i915/display: expose blend mode on alpha-capable planes")
  df0311845915 ("drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for wndws")

The ast patch is verified on AST2600 hardware: the warning is gone and
the cursor plane now exposes the "pixel blend mode" property with
Pre-multiplied as the only and current value. The qxl, virtio and
vboxvideo patches follow the identical pattern and are compile-tested.

Qinyun Tan (4):
  drm/ast: create blend mode property on cursor plane
  drm/qxl: create blend mode property on primary and cursor planes
  drm/virtio: create blend mode property on cursor plane
  drm/vboxvideo: create blend mode property on planes

 drivers/gpu/drm/ast/ast_cursor.c       | 3 +++
 drivers/gpu/drm/qxl/qxl_display.c      | 4 ++++
 drivers/gpu/drm/vboxvideo/vbox_mode.c  | 4 ++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
 4 files changed, 15 insertions(+)

-- 
2.43.7

