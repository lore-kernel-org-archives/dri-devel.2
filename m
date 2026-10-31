Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F82606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=fqICt+o+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFFF10E9F9;
	Sun,  1 Nov 2026 11:58:18 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3C110E132;
 Sat, 31 Oct 2026 13:00:09 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jGyjy0mmJzMlqk;
 Sat, 31 Oct 2026 14:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793451606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jT45r9YYP9438je1Fz34QUPlvPoDds8l32UNqGrVklY=;
 b=fqICt+o+UiHqAK2+aGyr/LFeGn8WFhcF+1t1ok25jWxIt4QWz+44C4x1ODmv7VIS8u3YUI
 o0QQV+bPSPzk+s1+anXngvJ//w5eqINeo78gbVKTw/73zvlgL308G11J2sxHuK0Gkg/AIR
 Hv9ixnSRop5k+YouT8NKtzQASi2Ego9fFN9T0Mok4mZE2uPg7tXKLganEq2e+fdD8hXylf
 Pg9ndB76UI0Vfk0m7KKxnXOmQicOOVo9gerOIr0YgJsq0obRbdZk1sQeLxqoL0bIKvaoxk
 YTfZlRIAhJSZoMtfS1c3s3xmL91M9MAI8XsU3y8ty1N/aL5SFGXzAfwitV0AXw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: ray.wu@amd.com, Roman.Li@amd.com, nicholas.kazlauskas@amd.com,
 alex.hung@amd.com, bhawanpreet.lakha@amd.com, ivan.lipski@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Leave self-refresh before an ABM level update
Date: Sat, 31 Oct 2026 13:00:02 +0000
Message-ID: <20261031130002.2335615-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jGyjy0mmJzMlqk
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

Writing panel_power_savings while the eDP is in PSR hangs DMUB on a
Cezanne laptop (DCN 2.1)

An abm_level change on its own is a fast update, so the commit skips
amdgpu_dm_commit_streams() and the self-refresh pause in it. The ABM
level then reaches DMUB through amdgpu_dm_commit_planes(), or through the
connector update loop in amdgpu_dm_atomic_commit_tail(), with the panel
still in self-refresh

Raise the PSR and Replay hw_programming events before both updates. As
with a backlight change, the events stay set until the next plane commit
clears them in amdgpu_dm_enable_self_refresh()

Fixes: 8c322309e48e ("drm/amd/display: Enable PSR")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Tested on an ASUS ROG Flow X13 (GV301QH, Cezanne, DCN 2.1, PSR1 eDP)
with PSR turned on through amdgpu.dcfeaturemask=0xa and "drm/amd/display:
Don't require DMUB PSR caps before DCN 3.0" [1], which DCN 2.1 needs for
PSR to come up at all, but, as far as I can tell, the same bug would
manifest on other DMUB versions that use PSR and ABM

On 7.3 without this patch, writing 3 to panel_power_savings while
psr_state reads 6 makes DMUB fail within a second. The log fills with
"DMCUB error - collecting diagnostic data" and the panel shows vertical
lines. amdgpu doesn't attempt a GPU reset, and the errors go on until a
reboot

With the fix, I let psr_state reach 6 before each of these steps:

- turn ABM on, from level 0 to 3
- change the level, from 4 to 1
- turn ABM off, from 1 to 0, which takes the immediate disable path
- switch power-profiles-daemon to balanced and back to power-saver,
  which sets a new level each time

None of them logged a DMCUB error. Both kernels had [2] applied as well

Commit 8c322309e48e ("drm/amd/display: Enable PSR") only paused PSR for
full updates. The power module events used here came with commit
3c108046e1d6 ("drm/amd/display: Add power module on Linux"), so a
backport before that needs another way to leave PSR

An HDR static metadata change while HDR stays on is a fast update too,
and the connector loop sends the new infopacket with the panel in
self-refresh. I have no panel with HDR and PSR or Replay to try it on,
and the VRR and AVI infopackets already go out the same way. Does an
infoframe update in self-refresh need the same pause?

[1] https://lore.kernel.org/r/20261029171219.2842014-1-hugo@hsal.es
[2] https://lore.kernel.org/r/20261029165420.2255749-1-hugo@hsal.es

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfbc384fbbdb4..0b40e860734a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4224,6 +4224,19 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
 				replay_event_immediate_flip, true);
 		}
+		/*
+		 * An ABM change alone is a fast update, which skips the
+		 * self-refresh pause in amdgpu_dm_commit_streams(). As with a
+		 * backlight change, amdgpu_dm_enable_self_refresh() clears the
+		 * event
+		 */
+		if (bundle->stream_update.abm_level) {
+			dc_exit_ips_for_hw_access(dm->dc);
+			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
+				psr_event_hw_programming, true);
+			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
+				replay_event_hw_programming, true);
+		}
 		update_planes_and_stream_adapter(dm->dc,
 					 planes_count,
 					 acrtc_state->stream,
@@ -5280,6 +5293,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 		mutex_lock(&dm->dc_lock);
 		dc_exit_ips_for_hw_access(dm->dc);
+		if (abm_changed) {
+			amdgpu_dm_psr_set_event(dm, dm_new_crtc_state->stream, true,
+				psr_event_hw_programming, true);
+			amdgpu_dm_replay_set_event(dm, dm_new_crtc_state->stream, true,
+				replay_event_hw_programming, true);
+		}
 		dc_update_planes_and_stream(dm->dc,
 					    dummy_updates,
 					    status->plane_count,
-- 
2.56.0

