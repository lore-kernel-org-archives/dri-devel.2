Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD548606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Chx9T0PE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7F910E824;
	Tue,  3 Nov 2026 14:18:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA6910E11B;
 Tue,  3 Nov 2026 14:18:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3892440502;
 Tue,  3 Nov 2026 14:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF6E1F000C1;
 Tue,  3 Nov 2026 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793715525;
 bh=Afeb0cSq4vk7QoBPnCYCwA9oG4zpAG3kgvidB/omNng=;
 h=From:Date:Subject:To:Cc;
 b=Chx9T0PEiG7yIBB2sYpycnX2Ol2gdBJ6BAvxpV61GVoCVhWKsSI2l2mtUoHqHol5O
 Wm/O7n+rFiQoC60xp0X4eoa81Ux5MJ39plweiZpwJsPkT0kX3Il9XKhoq2/I+VAIWZ
 HsrPCV1e2hp9Xs/WSGV/9qhnV2p2I/nnY9IUehTV1OPoZ/8vJca4gJGQWVskRqC9JP
 WOBxyonLADMnb4uO+XMKevEMuuyLJNmEKaChHXPHdM4z/tQ1ML6gNgldvKmZKehSze
 1YkqaHYT/j5om4LnVxFd4tR2H/Jroxh5FhTBhgFXEY5CitouGbbz/d1lmXQj2U+wtX
 75Jr3J5aRPa6w==
From: Mario Limonciello <superm1@kernel.org>
Date: Tue, 03 Nov 2026 08:18:40 -0600
Subject: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jGdEUl05X8YFjAdoCY80lKiI
 fy7BfcuT+7jrBDUOw1wz1bwurjgxiEBnzKQrhpaRWcTAxsuiAxjiJP6nrDqbTtFtFawuDRGazJ
 imCENJ6+Nex+nz/LHIdYvlXl/2hudC/PoP4d1ob33V7AQEt7kKnVe5U3B9pHCs4w9lNu2fQG7p
 l99xAAAAA==
X-Change-ID: 20261102-superm1-amdgpu-ddc-63f0eb10c022
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: Richard Hughes <richard@hughsie.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, simonit.orig@gmail.com, 
 Mario Limonciello <superm1@kernel.org>
X-Mailer: b4 0.16.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DisplayPort and eDP connectors DDC is tunneled over the AUX channel,
but the connector's "ddc" adapter ("AMDGPU DM i2c hw bus N") always
drives the physical i2c pins, which don't reach a native DP sink.  The
AUX backed adapter ("AMDGPU DM aux hw bus N") does, so userspace such as
fwupd, which uses the "ddc" sysfs link for DDC/CI, has to work around
this.

Keep a single i2c bus per connector and pick the transport per transfer
based on the detected sink: if the sink is a native DP/eDP/MST sink,
forward the transfer to the AUX adapter, otherwise (DVI/HDMI, including
DP++ with a passive adapter) use the hw i2c engine as before.

Reported-by: simonit.orig@gmail.com
Closes: https://github.com/fwupd/fwupd/pull/11308
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v2:
- Check which i2c bus to use on the fly instead of changing static symlink to
  avoid regressing passive adapters.
- Link to v1: https://patch.msgid.link/20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index b498fc5fbb140..678caffa3d120 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
+	if (!i2c->oem) {
+		struct dc_link *link = ddc_service->link;
+		struct amdgpu_dm_connector *aconnector = link->priv;
+
+		/*
+		 * DDC to a native DisplayPort sink is tunneled over the AUX
+		 * channel; the physical i2c pins only reach DVI/HDMI sinks
+		 * (e.g. DP++ with a passive adapter).  Route accordingly so
+		 * the connector's single "ddc" bus works for either sink.
+		 */
+		if (aconnector && link->local_sink &&
+		    dc_is_dp_signal(link->local_sink->sink_signal) &&
+		    aconnector->dm_dp_aux.aux.ddc.algo)
+			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
+	}
+
 	if (!ddc_service->ddc_pin)
 		return result;
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

