Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEF4C5DF67
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 06:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7434210E151;
	Sat, 15 Aug 2026 06:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IOomPtrM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EFE10E151
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 06:37:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B134F60A92;
 Sat, 15 Aug 2026 06:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3CBC2BCC7;
 Sat, 15 Aug 2026 06:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786775835;
 bh=9T77PimmZzMHSJlCsZUQkkkVxlGA/4YGsi6l6j74tiY=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=IOomPtrMNDPPp53vAXQbOGNGLBrlqX0s7E+Lp2dQCDYaebYb+v62dkXEo9wMY0Nfs
 Bv6JqsuYEThgjj4EaiwpBUAAgv2vxH89F7xBPF8LhnP8MqAgPAlzyeuYzwR4s5Xpp7
 c5dSHITMLrA0WFV+yf0uxUm2Ydss8nJ8XC9M75O3zJbICruV/QZA9V7GYnjReDWJK5
 lX2Wybn7I3+xvs5eamC7ury3scjRk7P+ArSEqmMy1XhzzxXv/zMPFPJ8sS0Q9PP+vc
 eppjKbRMBSJsrAOhNDhzMFbYRNd+facWIdVbhniE/+xaPCYX1YdntmYpuSgWVAVhJW
 gE9n+0yqo31cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3677BC5AD5A;
 Sat, 15 Aug 2026 06:37:15 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 15 Aug 2026 14:37:08 +0800
Subject: [PATCH] drm: check for NULL master in drm_getunique() and
 drm_getmagic()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-drm-accel-null-master-v1-1-93bdd3ba52f1@outlook.com>
X-B4-Tracking: v=1; b=H4sIABMJgGoC/x3MQQqAIBBA0avErBtQqYiuEi1Mpxowi7EiiO6et
 HyL/x9IJEwJuuIBoYsTbzFDlwW4xcaZkH02GGUa1eoavaxonaOA8QwBV5sOElTe1NRoUyk7Qm5
 3oYnv/9sP7/sBoCUOC2cAAAA=
X-Change-ID: 20260815-drm-accel-null-master-0d25e61240ab
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Melissa Wen <mwen@igalia.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=14Xmewi+giltRJel9Gjr6ymfbKDBgR2rRdumGxnoDdQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrAZOqUOeDpPN7Pz9l2+SO3q5OeDTruefTzwPf/LY6
 ZuA7fLQ6uMdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBFfJkaGl3PW9f0Pn6O1
 4cQG7wWnzQ3eMz3nmLtm7rXIl/ptsn/L7BgZri59ujdx2WNLpQdRbSulfvv77rly723cwdN7N87
 Njw//xAAAUWlPag==
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

From: Junrui Luo <moonafterrain@outlook.com>

drm_getunique() and drm_getmagic() dereference file_priv->master without
checking it, and both ioctls are registered with flags of 0.
drm_open_helper() only calls drm_master_open() for primary clients, so a
drm_file opened on a non-primary minor keeps master == NULL. Render
clients are already rejected by the DRM_RENDER_ALLOW test in
drm_ioctl_permit(), so before commit 2c204f3d5321 ("accel: add dedicated
minor for accelerator devices") every drm_file reaching these ioctls had
a master.

DRM_MINOR_ACCEL is neither primary nor render: it gets no master in
drm_open_helper() and is not covered by drm_is_render_client(). Issuing
DRM_IOCTL_GET_UNIQUE or DRM_IOCTL_GET_MAGIC on /dev/accel/accel* leads
to a NULL pointer dereference, in drm_getunique() with dev->master_mutex
held. The compat entry point reaches drm_getunique() through
drm_ioctl_kernel() with flags of 0 as well.

Return -EINVAL when master is NULL, matching drm_setmaster_ioctl().

Fixes: 2c204f3d5321 ("accel: add dedicated minor for accelerator devices")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/drm_auth.c  | 3 +++
 drivers/gpu/drm/drm_ioctl.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index e5013b870ba0..cb9e02c486f0 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -97,6 +97,9 @@ int drm_getmagic(struct drm_device *dev, void *data, struct drm_file *file_priv)
 	int ret = 0;
 
 	guard(mutex)(&dev->master_mutex);
+	if (!file_priv->master)
+		return -EINVAL;
+
 	if (!file_priv->magic) {
 		ret = idr_alloc(&file_priv->master->magic_map, file_priv,
 				1, 0, GFP_KERNEL);
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 9039a39c4324..083722d8dd44 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -120,6 +120,11 @@ int drm_getunique(struct drm_device *dev, void *data,
 
 	mutex_lock(&dev->master_mutex);
 	master = file_priv->master;
+	if (!master) {
+		mutex_unlock(&dev->master_mutex);
+		return -EINVAL;
+	}
+
 	if (u->unique_len >= master->unique_len) {
 		if (copy_to_user(u->unique, master->unique, master->unique_len)) {
 			mutex_unlock(&dev->master_mutex);

---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260815-drm-accel-null-master-0d25e61240ab

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


