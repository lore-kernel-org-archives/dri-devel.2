Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2928606A8A9
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFIq4R84
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B82210F20B;
	Mon, 16 Nov 2026 14:01:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBFF10F200;
 Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A0DC62C41;
 Mon, 16 Nov 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794837668;
 b=NNLEcgjabX2eqwDtnjBKTSYpwO+SzjYv+x8yN7908y4jal5RfkRvpNDnpO5zk+k3nrP1
 REwRrxqz37lLtiT6Smrb5hZuIRsanLoEi+Qwy+B8JxiZ5GgFQzYHMKUyH5Mib/kyEGWf6
 osy78vqqueqKO0bYVdXxUkUY0h+zCoZ6E6sEus9LioFZ33OCeIKXeWBYGwDnQRSvjrnDq
 YUHMLKqwe6AEqgmkb4i5B4KFVec2gDVNy3IOP6QITOxBtKro5RK1yadBnzbbS0tUHt9pq
 5tuzdvv/E5GXS9U/LkMYpn7emVbdU3/7w1MppTKbt9+gwwqtE2jBUrt05BZiORpEBvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794837668;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=kcHezJuhx6nMG5FQREdfYfPWtGjzRQB4kn3JrXnJa88=;
 b=mHacP51W/OqdqQh59ocaj+CblVMlZrUAAHEe55D8MWs2AaWnFcRIjrqEy8gAPdlBcsBe
 XVa7NmWs4mWpXH1/pxDUHlBU284j11Cwvt1AihSY1ogBBSjesL0NoB9VrrF518/M51qM0
 YcLkCD5NmC0ZUYi9FRJihu8x+EBBP5ZH8cjxTVDhAgCXYlcLyRNAQhdVFbm3BwxH/UKMH
 MJt7ueGJcU50yznKbhH7GbvKiixb0HNW61B5FXrTlTbYeJYQinXtXcd2lTAu1sr5F4InB
 YU9LvgfNlM/oI+gyRgPnUxkQFEHHrAi3OXtQdbGUi4A79bngLkhqI6eBMyAZ2ATWEgg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1FAF11F000CD;
 Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837668;
 bh=kcHezJuhx6nMG5FQREdfYfPWtGjzRQB4kn3JrXnJa88=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=IFIq4R84WB1LQ/o/OzPQly00aYwRGIxykmnvFSKUgUWxYtcSqRNFNRBvpwrhUX4hR
 Z3RDMnL6nxvF7nb/PbKyddbXWcP4bPk+puzkwBJMkvBvCBgWFs3UlyyIM+bQ1tGLs0
 lkpPXak+DEhC0TvYNtAj9KhEUrjIIDBJlcLmLCOd5eOxz9Mf/TboHnT3NhVLkWVGao
 PB9OjYYGGWw2DrnhEY/f4kAtHPq+Ecl7KcEl1S7jY1tltBl6ZNdTiLKscnPFz7T7S4
 syQsEOPjUSFwuT5QsjcDEtXKui4Q88FLdsQd4Bk2RhmiYc3KLCfBX43wIQ983Os/xm
 Vk+P4yffT4Icw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9B1E14A4A7;
 Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Mon, 16 Nov 2026 14:01:04 +0000
Subject: [PATCH v3 2/6] drm/amd/display: Add the CRTC's planes when the ABM
 level changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-abm-sysfs-commit-v3-2-7a3d84a5328e@hsal.es>
References: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
In-Reply-To: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Alex Hung <alex.hung@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 David Weber <weber.aulendorf@gmail.com>, 
 Shivam Kalra <shivamkalra98@zohomail.in>, 
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=qEE0S9PbkvyPum4bGl1VMgQGUMbMKntSfo2X6VR25RU=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn7zzL8b2R3Z9DqkuuSfSMa5K2p3l/+ZnPRA/IiV2
 r2VpZ+jVPU6SlkYxLgYZMUUWXRveDKwTJw8M6fo+RKYOaxMIEMYuDgFYCKXbBn+qSzicZ//LPpJ
 4mvPFcek79awlLNnLf2vPUG+3q2NQ3DRNkaGyZYTS1uOlXW63Jr/jkVzhe+fi9MUrj6eWxVgqLa
 p32QXKwA1Lkup
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

An upcoming patch stops a change of the connector's ABM level from
forcing a modeset. The modeset adds every plane on the CRTC to the
commit. Without it, a commit that changes only the level carries the
planes the CRTC check pulls in, which with VRR active is the primary
plane alone. DC then updates the stream with that one surface and drops
an active overlay plane until the next flip

Add the CRTC's planes when the level changes, as atomic check already
does for color management and VRR changes

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
This was reported on v2 [1]. On my laptop (GV301QH, DCN 2.1), with v2
and VRR active, a panel_power_savings write took the overlay off the
screen. The DTN log went from four pipes, primary and overlay each split
over two, to the two primary ones, and a flip of both planes brought the
overlay back. With VRR off, the overlay stayed. With this patch, it
stayed with VRR on too, and all four pipes were still there after the
write

This only covers commits that change the ABM level. From my reading,
other commits that add the CRTC but no planes, like a change of the HDR
metadata, can drop an overlay the same way while VRR is active. That
needs a fix in the CRTC check that pulls in only the primary plane, which
I'll send as a separate series

[1] https://lore.kernel.org/all/sashiko-outbox-213691@kernel.org/
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfbc384fbbdb4..cf75450066451 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6307,6 +6307,20 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
 		    dm_old_con_state->scaling != dm_new_con_state->scaling)
 			new_crtc_state->connectors_changed = true;
+
+		/*
+		 * With VRR active, the CRTC check adds only the primary plane,
+		 * and DC would drop any other plane from the stream
+		 */
+		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level) {
+			ret = drm_atomic_add_affected_planes(state, new_con_state->crtc);
+			if (ret) {
+				drm_dbg_atomic(dev,
+					       "drm_atomic_add_affected_planes() failed: %pe\n",
+					       ERR_PTR(ret));
+				goto fail;
+			}
+		}
 	}
 
 	if (dc_resource_is_dsc_encoding_supported(dc)) {

-- 
2.56.0


