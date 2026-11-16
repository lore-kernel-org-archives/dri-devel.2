Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073D606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baryla.org header.i=@baryla.org header.a=rsa-sha256 header.s=dkim header.b=uwbzef0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4533610F13D;
	Mon, 16 Nov 2026 13:12:07 +0000 (UTC)
Received: from mail.baryla.org (mail.baryla.org [217.182.77.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3611210EF74;
 Mon, 16 Nov 2026 11:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BEDF7746115; Mon, 16 Nov 2026 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baryla.org; s=dkim;
 t=1794827261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AuuueUIiwkc93LDarBEsBhq5sGdDfFqHHtz9HVXcZqw=;
 b=uwbzef0g2QXZyA3dVr90FFkjATPM75oti5Tjmajl52uOBOvCMsc9zK00rDHMc3f2qTx//0
 nHMXvV8LWVlxQ8LOxYabolNEvQFpGLSwl3qq4foW0knZMA0EEv0LiZAQko6M3Fty/c64ZB
 +W1xHieJw+2WGs3i/eX3MzQjiXg3y8/IRwIXlSKir1IRuT2pzy7J+D99MjOmuL8mxflmjT
 P92Ob3gW5AmmBSYGN3vxq3kjmx/CVrXHLdPPXO4lsnGg3g/ChnAsn1FYguD7dAhefcJ8Ht
 PCfrIW3W41adMtfBLrgGzJ/6KYhKqwcQGImcfJaOzxh5lwKFWac73zLd5kSPBw==
From: =?utf-8?q?Karol_Bary=C5=82a?= <git@baryla.org>
Date: Mon, 16 Nov 2026 12:07:32 +0100
Subject: [PATCH 1/2] drm/amd/display: Skip the MST last link check for
 logical ports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-mst-logical-port-v1-1-6b446ebe75e7@baryla.org>
References: <20261116-mst-logical-port-v1-0-6b446ebe75e7@baryla.org>
In-Reply-To: <20261116-mst-logical-port-v1-0-6b446ebe75e7@baryla.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Zaeem Mohamed <zaeem.mohamed@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
 Jerry Zuo <jerry.zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Karol_Bary=C5=82a?= <git@baryla.org>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:12:05 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
For MST DSC without passthrough, dm_dp_mst_is_port_support_mode() reads
DP_LINK_BW_SET/DP_LANE_COUNT_SET of the output port and rejects modes
whose uncompressed rate exceeds that "last link". The value is read once
and cached on the connector.

A logical port (port number 8 and above) is the branch device's own
internal sink, such as the panel of a monitor with a built-in MST hub.
No DP link follows it, so its link configuration registers do not
describe one. A Dell U3225QE behind a USB4 DP tunnel reports its
internal link in DP_LINK_BW_SET/DP_LANE_COUNT_SET while that link is
still training: right after a hotplug the read returns RBR x1
(1257120 kbps), which prunes every 3840x2160@120 mode (28512000 kbps
uncompressed, DSC required). After a monitor power cycle the same read
happens before the channel coding is set, gives 0, and the modes are
offered. Which of the two happens depends on timing. Once training
completes the registers show HBR3 x4 (25142400 kbps), which is still
below the uncompressed rate, so re-reading instead of caching would not
help.

Since commit 0b0ff65d3ca1 ("drm/amd/display: Refactor stream
validation"), a mode rejected by this check is retried as YCbCr 4:2:2,
which fits without DSC. So instead of disappearing, the mode is offered
as 4:2:2. Every atomic check then tries RGB first, fails, and logs
"Mode Validation Warning: Viewport size failed validation."

[How]
Skip the last link check for logical ports. Physical ports keep it
unchanged.

Fixes: fa57924c76d9 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6142
Signed-off-by: Karol Baryła <git@baryla.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5697645ef7cc..b9ff0880d150 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -2066,9 +2066,16 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			struct drm_dp_mst_port *immediate_upstream_port = NULL;
 			uint32_t end_link_bw = 0;
 
-			/*Get last DP link BW capability. Mode shall be supported by Legacy peer*/
-			if (aconnector->mst_output_port->pdt != DP_PEER_DEVICE_DP_LEGACY_CONV &&
-				aconnector->mst_output_port->pdt != DP_PEER_DEVICE_NONE) {
+			/*
+			 * Get last DP link BW capability. Mode shall be supported by Legacy peer.
+			 *
+			 * Skip logical ports: they are the branch device's own internal sink,
+			 * so no DP link follows them and their link configuration registers
+			 * do not describe one.
+			 */
+			if (!drm_dp_mst_port_is_logical(aconnector->mst_output_port) &&
+			    aconnector->mst_output_port->pdt != DP_PEER_DEVICE_DP_LEGACY_CONV &&
+			    aconnector->mst_output_port->pdt != DP_PEER_DEVICE_NONE) {
 				if (aconnector->vc_full_pbn != aconnector->mst_output_port->full_pbn) {
 					dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw);
 					aconnector->vc_full_pbn = aconnector->mst_output_port->full_pbn;

-- 
2.56.1

