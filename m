Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3E606A335
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOEJ5o/+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D497F10E071;
	Sat, 14 Nov 2026 23:09:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A0910E071;
 Sat, 14 Nov 2026 23:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4EA2561AE5;
 Sat, 14 Nov 2026 23:09:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794697755;
 b=3oRDZUBCGNBzDOF2o7RvyTB1TuKnelipG4+DiV1VNWOo2Gb+G7IvIeW4HKi3zAMA6ScU
 y4zTmlxvE1gEuq+N8st8/9M5f7hBwUlbIzt7+VFJNcqhKtjoKnspCBgJpWBTG6xXVuXWq
 l+jcttyT/+OO+7ZPr+c5oWWRiNcn7+JnEzH6tFJjB3EANumD9+B+hK6fqsn93exroDz1v
 ezvoG+j6pLqZwxkVdNNUMiWj2rsaoAOIoiCHMAORZWWvs1A21XCqzlOECWTxP2O3E4O8M
 DPyBDPx/iXRZamUjwntn5vgRg5I7n/OQFnRxr6wo/0ExKS8GG043FHYZZtJNx/CoOPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794697755;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9owcnqrLh9HLkft/is54769ptdoYN16x/JjdXggMJiU=;
 b=WZeH1zBuCoPjXX+enMqeaGzMMetpCETp9o/fzAS6rT/Taa1w68prw0Lb9LFDWdKA17wh
 v0jZjciWleP4RwkwcjzhAWgCKhxeg1K3O6oqJ2J5VZqyXgmirV0UB0rUoLFO/Ft++e+39
 HqpoQKTdoBuUva6fa+74cI5ctr9jBvJ8weaKb5GrO0RSvAJyp+lsh0NZoFbwcW2YsLq8W
 AI5Lf/WCFD/c44kXu+vYjyVc0zM5iX26C/QTQy/KYR/TI1Gtnlma+Wzsuoj42ekwpYm93
 7faMg2HTnt13zvd4QcdJ4FuSFDFqkaGxw+HAMkmWL7PqN4EnuR4Nn2jrUuQE6/fOOPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 75DF51F000C4;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794697755;
 bh=9owcnqrLh9HLkft/is54769ptdoYN16x/JjdXggMJiU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=KOEJ5o/+tYAqpyNXfuHd9WWTQzoghHISu6hbQgfPdBIehNM2Tv4ZIyNJbkGjCrq5t
 okkRpDkPO2OgurThb67jzvj4A40OxItFUrhfjQFJSP+fibDrT0dSpyk6ZLRh42mCX5
 O6+E47144KM6FN0mtRffiggW9un36CcKcm20pacYl4c3aUfAlk3ZR6Pf7kZNYsfHD/
 EwwBTwPwiWNzR5YzH9DCCAmVclO9Xff5qcMqXZvGmenj0UO1leduKbShBEc1pXCgL7
 g+ph2PY2sok2r1hFggXJ6dXgNyn7l1FRPSAWEXBqKPW61jauM9nIFiyeALgWMMnqH2
 vi/HiDLc7XmIQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E6CE249EB4;
 Sat, 14 Nov 2026 23:09:13 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Sat, 14 Nov 2026 23:09:12 +0000
Subject: [PATCH 1/8] drm/amd/display: Drop the unadvertised mode check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-amdgpu-modes-four-v1-1-f11e2a6cd407@hsal.es>
References: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
In-Reply-To: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=lnT9nVoFlXidbyLYsCe0y4wiJYQVxKPy6EIUZH0LbBw=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn68kph8fspS4XBNK2Mrfn4Wv9g9Lq9ucfqa7KtmS
 bMV0iniKOgoZWEQ42KQFVNk0b3hycAycfLMnKLnS2DmsDKBDGHg4hSAicTFMTJsLn0svbRX0ulB
 xrzqTR9PVJnM/Trl1dTqWXoXf00pbTW+w8jQGyN5c/vy9NY3N9+Kf1T+IHxqtoCYfOieb69k1E1
 Fr9fyAgCaXEg9
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

Commit fa129ff3b6a7 ("drm/amd/display: warn on unadvertised modes
without scaling") made create_stream_for_sink() log "Unadvertised mode
... with RMX_OFF" when the requested mode isn't one the connector
advertises. Commit 828cfa384e23 ("drm/amd/display: Fix unadvertised mode
detection") made is_duplicate_mode() search connector->modes as well as
probed_modes

mode_config.mutex protects both lists, and atomic_check, where
create_stream_for_sink() runs, holds only the modeset locks. A probe on
another thread can free modes in connector->modes during the walk.
atomic_check can't take mode_config.mutex, since the probe takes it
before connection_mutex

The check's only effect is the debug message, so drop it.
is_duplicate_mode() stays for add_fs_modes()

Fixes: fa129ff3b6a7 ("drm/amd/display: warn on unadvertised modes without scaling")
Fixes: 828cfa384e23 ("drm/amd/display: Fix unadvertised mode detection")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Fangzhi, fa129ff3b6a7 says the message is there to advise users to pick
an advertised mode when they see a visual defect. Do you plan to build
more on it, like rejecting such modes or a warning userspace can see? If
you'd rather keep the message, I can do that instead. atomic_check would
take mode_config.mutex with mutex_trylock() and skip the check while a
probe holds it. The walk is then safe, and the message only goes missing
while a probe runs
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e8f050feb6e39..89f8427433af0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1495,7 +1495,6 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct drm_display_mode saved_mode;
 	struct drm_display_mode *freesync_mode = NULL;
 	bool recalculate_timing = false;
-	bool unadvertised_mode = false;
 	bool scale = dm_state->scaling != RMX_OFF;
 	int mode_refresh;
 	int preferred_refresh = 0;
@@ -1627,13 +1626,6 @@ create_stream_for_sink(struct drm_connector *connector,
 					&mode, preferred_mode, scale);
 
 			preferred_refresh = drm_mode_vrefresh(preferred_mode);
-			unadvertised_mode = !is_duplicate_mode(aconnector, drm_mode);
-
-			if (unadvertised_mode && dm_state->scaling == RMX_OFF)
-				drm_dbg_driver(dev,
-					       "Unadvertised mode %dx%d@%d with RMX_OFF\n",
-					       drm_mode->hdisplay, drm_mode->vdisplay,
-					       drm_mode_vrefresh(drm_mode));
 		}
 	}
 

-- 
2.56.0


