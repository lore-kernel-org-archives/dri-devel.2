Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3E4C61DCB
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4D110E142;
	Sat, 29 Aug 2026 17:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Is85ltsN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A582B10E142;
 Sat, 29 Aug 2026 17:29:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DCB7E43EB2;
 Sat, 29 Aug 2026 17:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B57CCC2BCB9;
 Sat, 29 Aug 2026 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788024597;
 bh=LoQYd7VKaqre8qOks87R+wMsmKcrZeNVFtJmAw4spAk=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Is85ltsNVZ3Q+ZK8xjIZS5N+QTnEgMasgb0t//dUGqNw2OAAwVFsa73dsrEDTodeC
 QAHuz8YMQi9AK88U/SC4tON+5bnEuI+SnvPfWgeqDSDKDa/AHjN7XFZKbIUOZj5u68
 X9y50zArQ0pN7MaSIFcfm+0fNXwYMueZLCVXPze6OETM/CZyPvJVyym04dfpbBliB8
 V57GPhanCYODJmjlZbfWdd4w2YUfVu5zh6wEmVHN5wU1Wb9GKwjcm4stFuQohnc3+n
 4jba+BNGhlFOVxGj9xMLae+ENiBbU5k86+z6OwVfCXhvTK1GFsn11W1BHYKPNz0QFF
 F1jViE+EfICLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 91943C61DBE;
 Sat, 29 Aug 2026 17:29:57 +0000 (UTC)
From: Maximilian Passarello via B4 Relay <devnull+git.0xMax42.io@kernel.org>
Date: Sat, 29 Aug 2026 19:29:42 +0200
Subject: [PATCH] drm/amd/display: set remote MST sink power state on
 payload changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-mst-remote-sink-power-v1-1-b9eab331e0d5@0xMax42.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrB2IQWzjVcSF2kk7FBOZCSqE3
 L2hy7f4P4OSMCmMTQahk5VjqOjaBrbPEt6E/KoGa+xgntbhrgmF9pgIlcMXj3iR4LYY//B9tzr
 joLaHkOf7/53mUn63RxQXZwAAAA==
X-Change-ID: 20260829-mst-remote-sink-power-ca0f7f41b909
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maximilian Passarello <git@0xMax42.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=git@0xMax42.io;
 s=20251130; h=from:subject:message-id;
 bh=z7GIZHa6GjvkEEzvyXbXQn2iCrZf54tBoOQm4lCih+c=;
 b=owGbwMvMwCWWb8ayoV75uQzjabUkhqzJ4vz/IkqunV5o2zuhMGdJrLBU3wrFuSuC5RYI2RTmM
 EQkPg7sKGVhEONikBVTZOlsXTbvoRJj8/TOAG+YOaxMIEMYuDgFYCL/sxj+l3J9OtnD9EJ5WnmC
 3JLcQ683M5xwz15ekCDGyPtm06wTGQz/LLV/L8i4fuhr4cmg8EW+yget2q8wTUrQt2hkkz7jdzu
 VHwA=
X-Developer-Key: i=git@0xMax42.io; a=openpgp;
 fpr=BB652AF8176BC2EA82C83A5B025EF9E480AC8E43
X-Endpoint-Received: by B4 Relay for git@0xMax42.io/20251130 with auth_id=989
X-Original-From: Maximilian Passarello <git@0xMax42.io>
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
Reply-To: git@0xMax42.io
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Maximilian Passarello <git@0xMax42.io>

Some downstream MST displays keep their backlight on after DPMS off because
removing the MST payload does not update DP_SET_POWER on the remote sink.

Set the remote sink to D0 before allocating its payload and to D3 before
removing it. Log AUX errors without changing the existing payload flow.

Signed-off-by: Maximilian Passarello <git@0xMax42.io>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ab15ceec4daa..ce27024a9593 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -372,6 +372,7 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	struct drm_dp_mst_topology_state *mst_state;
 	struct drm_dp_mst_atomic_payload *target_payload, *new_payload, old_payload;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
+	int ret;
 
 	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 	/* Accessing the connector state is required for vcpi_slots allocation
@@ -388,11 +389,23 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
 
 	if (enable) {
+		ret = drm_dp_link_power_up(&aconnector->mst_output_port->aux,
+					   aconnector->mst_output_port->dpcd_rev);
+		if (ret < 0)
+			drm_dbg_dp(mst_mgr->dev,
+				   "Failed to power up remote MST sink: %d\n", ret);
+
 		target_payload = new_payload;
 
 		/* It's OK for this to fail */
 		drm_dp_add_payload_part1(mst_mgr, mst_state, new_payload);
 	} else {
+		ret = drm_dp_link_power_down(&aconnector->mst_output_port->aux,
+					     aconnector->mst_output_port->dpcd_rev);
+		if (ret < 0)
+			drm_dbg_dp(mst_mgr->dev,
+				   "Failed to power down remote MST sink: %d\n", ret);
+
 		/* construct old payload by VCPI*/
 		dm_helpers_construct_old_payload(mst_mgr, mst_state,
 						 new_payload, &old_payload);

---
base-commit: 75a5e1b6b3661c3f946885d01eebeb6b031035ef
change-id: 20260829-mst-remote-sink-power-ca0f7f41b909

Best regards,
-- 
Maximilian Passarello <git@0xMax42.io>


