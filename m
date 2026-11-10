Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35F606A334
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SodkZsSv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECC310EE3E;
	Tue, 10 Nov 2026 21:05:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4482B10EE3E;
 Tue, 10 Nov 2026 21:05:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F37734471F;
 Tue, 10 Nov 2026 21:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DF21F008A1;
 Tue, 10 Nov 2026 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794344730;
 bh=0b2l1Y81eKOfXpUQOu6uV2zt7HAtkcBx7c0jPfJ0UKs=;
 h=From:Date:Subject:To:Cc;
 b=SodkZsSvJCYnJR+Bs/SVlQG9tkVuDLIRijnngKUiUG91XSqgSPukO4p4zg+8dRtwY
 UYMwavtyM+pnIm30QHsSXtuFhhtCHFkQg9Ix7UwVx3OsqShjExDrmUWoL5e8V3lsMj
 PFFrzJzUYPu2eEUfzcGw9ojSxugaGYOmKkJSdMEsMHwZCLd7jj6rdsLLYVwnpX8x+8
 zA9LsD0VRDiygeXC6eS5swjyY1t8t9WuDYvvspt2Xl8oNr99GKL2OA6JjS+HgKPCk7
 nmEgl60VwUJEKu6O42fymV/ObqsPiPi6lbo3XkBIxB5M/11RvoAxx9Ry2wmeVL6Xjl
 onqEyqylQ32hA==
From: Mario Limonciello <superm1@kernel.org>
Date: Tue, 10 Nov 2026 15:05:21 -0600
Subject: [PATCH v3] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-superm1-amdgpu-ddc-v3-1-9436b04d1e31@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6DIBAF4Ks0rIuBwdqflfdoXAiMSlvFgJI2x
 rsX7KaLpsuXefO9hXh0Bj257BbiMBhv7BCD2O+I6uqhRWp0zAQYFJwzoH4e0fWc1r1ux5lqrWg
 hGoaSM8UASHwcHTbmuaHX6pP9LG+opiSlRmf8ZN1rWw089f4OBE45PauDknmdNwXoMh4zZXuS+
 ADfgPgJQASOUmOhGcvFCco7ugEfmXUtqdZ1fQMFRMvyCAEAAA==
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
based on the link's transaction mode (link->aux_mode), as the EDID read
helpers already do: for native DP/eDP/MST sinks forward the transfer to
the AUX adapter, otherwise (DVI/HDMI, including DP++ with a passive
adapter) use the hw i2c engine as before.

Reported-by: simonit.orig@gmail.com
Closes: https://github.com/fwupd/fwupd/pull/11308
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v3:
- Select the transport with link->aux_mode instead of
  link->local_sink->sink_signal, matching the EDID read helpers in
  amdgpu_dm_helpers.c.  This drops the unlocked local_sink dereference
  that could race with link detection/hotplug (use-after-free), and it
  also covers MST links (local_sink is NULL there) and links with
  force_to_use_aux set.
- Check ddc_service->link for NULL before dereferencing it, so
  amdgpu_dm_i2c_xfer() still returns -EIO when there is no ddc_pin
  (fixes dm_test_i2c_xfer_no_ddc_pin()).
- Reword the commit message to describe the aux_mode selection.
- Link to v2: https://patch.msgid.link/20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org

Changes in v2:
- Check which i2c bus to use on the fly instead of changing static symlink to
  avoid regressing passive adapters.
- Link to v1: https://patch.msgid.link/20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index b498fc5fbb140..f80de9e7f850c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
+	if (!i2c->oem && ddc_service->link) {
+		struct dc_link *link = ddc_service->link;
+		struct amdgpu_dm_connector *aconnector = link->priv;
+
+		/*
+		 * DDC to a native DisplayPort sink (SST, MST or eDP) is
+		 * tunneled over the AUX channel; the physical i2c pins only
+		 * reach DVI/HDMI sinks (e.g. DP++ with a passive adapter).
+		 * Use the same aux_mode selection as the EDID read helpers so
+		 * the connector's single "ddc" bus works for either sink.
+		 */
+		if (aconnector && link->aux_mode &&
+		    aconnector->dm_dp_aux.aux.ddc.algo)
+			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
+	}
+
 	if (!ddc_service->ddc_pin)
 		return result;
 

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

