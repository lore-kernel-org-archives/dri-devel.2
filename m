Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4A1C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AF510FA89;
	Tue, 15 Sep 2026 07:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fPVPEsUY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8F310FA82
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:39:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 81AB9602A8;
 Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FE72C2BCFB;
 Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789457988;
 bh=X2czHbrSs18WUTeT1j+/DpL6IMrShozvKKb9NfGC9O0=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=fPVPEsUYtgGhSjoyqoCH5SypUQD2O+jtI/Dr/75hOOIvBvixu8X1intHt3G/Ri3Kc
 XNHoG1iSACVrswnzhZNRctrX/VsuYINncWAwkoSqO9K0dygA/AynktHxYY7t+D7PTK
 cuPh5piS6icVaiaaDPTx5STZRYIRfzbjZO58Ly0Z8zjlg3oIdJgYKSEp7jWCTaH+cX
 uInYBL1qJdpkGBazkjCaZ1g+19/MhOcpk1CjKGL7JGQBssWyb1j9ouxJnOk6r0ICTZ
 G6JvizFRWYYdd6jdjxnfptTTAifC7HxP9ZxR7PVB5jgeH69gj7evp5/Q27eZVUhhsq
 cXo3AGr4+2o7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 068BEC88E73;
 Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH v2 0/4] drm/virtio: fix GEM object leaks on error paths
Date: Tue, 15 Sep 2026 15:39:09 +0800
Message-Id: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB32qGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDS0NT3bTMitRiXYtkM0tD81RLAzMzUyWg2oKiVLAEUGl0bG0tAJP91iF
 XAAAA
X-Change-ID: 20260915-fixes-8c6917e90665
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=X2czHbrSs18WUTeT1j+/DpL6IMrShozvKKb9NfGC9O0=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBXfHN90179brFw37+qpt7Fmt+eoMjV+P7nk3s4JO
 nJyRscL4uo7SlkYxLgYZMUUWY4XXPpm4btFd4vPlmSYOaxMIEMYuDgFYCIJAQx/hdckFe99sNTx
 R8R8lSk5FV8WXbeZXcHwuKmgaN2O9coHnzIy3M0z/2R5xODBp9l/+FmXXbHK4nXaU5tveGFSX76
 ir+xpTgBXL07U
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

v1 fixed one drm_gem_object_release() misuse in virtio_gpu_gem_create().
Dmitry asked for the other occurrences the Sashiko bot pointed at [1], so
v2 turns it into a series.

Patches 1-3 replace drm_gem_object_release() with drm_gem_object_put() on
the GEM creation error paths. Patch 1 is unchanged from v1.

Patch 4 adds the missing drm_gem_object_release() before kfree(vram) in
virtio_gpu_vram_create().

Only compile-tested (x86_64, CONFIG_DRM_VIRTIO_GPU=m).

[1] https://lore.kernel.org/all/55240372-c265-4b38-be94-f29a58ddbb22@collabora.com/

Changes in v2:
- Add patches 2-4 covering the other occurrences reported by the bot
  (Dmitry Osipenko)
- Link to v1: https://lore.kernel.org/r/20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (4):
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

 drivers/gpu/drm/virtio/virtgpu_gem.c   |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 +++---
 drivers/gpu/drm/virtio/virtgpu_vram.c  | 17 +++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260915-fixes-8c6917e90665

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


