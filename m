Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5661073CB6
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB7C10E650;
	Wed,  8 Apr 2026 13:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OjJz7Xrq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEAE10E650;
 Wed,  8 Apr 2026 13:08:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 71E7360132;
 Wed,  8 Apr 2026 13:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5E4C19421;
 Wed,  8 Apr 2026 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775653681;
 bh=4CpiPtf5D36I7jFhu50adHqTpfS787u7f31ALg7azJY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=OjJz7XrqoCnUCHrcCllQdiRrgBd4TXxVFrWAfZ82vhsjGrUO/3Bsq5RcqqRRCvexd
 AW1m0QNHlKX02pLEjx9Ub/h6fF5XAVDeqKqWYaLrqSWigp0bQSTvQNjeBi2ee6lOiP
 FQuZWfzYe9clXSMp4AEKGz8NLc4ktTD+l4DLHoXI=
Subject: Patch "drm/amd/display: Disable scaling on DCE6 for now" has been
 added to the 6.12-stable tree
To: Eric.Yang2@amd.com, Mario.Limonciello@amd.com, Rodrigo.Siqueira@amd.com,
 Roman.Li@amd.com, Tony.Cheng@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 alex.hung@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, harry.wentland@amd.com, issor.oruam@gmail.com,
 ray.wu@amd.com, rosenp@gmail.com, simona@ffwll.ch, sunpeng.li@amd.com,
 timur.kristof@gmail.com, wayne.lin@amd.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:07:40 +0200
In-Reply-To: <20260401003908.3438-9-rosenp@gmail.com>
Message-ID: <2026040840-bubble-delegator-979f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/amd/display: Disable scaling on DCE6 for now

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-display-disable-scaling-on-dce6-for-now.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-232626-greg=kroah.com@vger.kernel.org Wed Apr  1 02:45:16 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 31 Mar 2026 17:39:06 -0700
Subject: drm/amd/display: Disable scaling on DCE6 for now
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Xinhui Pan" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <wayne.lin@amd.com>, "Mario Limonciello" <Mario.Limonciello@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Eric Yang" <Eric.Yang2@amd.com>, "Tony Cheng" <Tony.Cheng@amd.com>, "Mauro Rossi" <issor.oruam@gmail.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260401003908.3438-9-rosenp@gmail.com>

From: Timur KristÃ³f <timur.kristof@gmail.com>

[ Upstream commit 0e190a0446ec517666dab4691b296a9b758e590f ]

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur KristÃ³f <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_c
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}


Patches currently in stable-queue which might be from rosenp@gmail.com are

queue-6.12/drm-amd-amdgpu-decouple-aspm-with-pcie-dpm.patch
queue-6.12/drm-amd-display-reject-modes-with-too-high-pixel-clock-on-dce6-10.patch
queue-6.12/drm-amd-display-fix-dce-6.0-and-6.4-pll-programming.patch
queue-6.12/drm-amd-display-disable-scaling-on-dce6-for-now.patch
queue-6.12/drm-amd-display-disable-fastboot-on-dce-6-too.patch
queue-6.12/drm-amd-display-correct-logic-check-error-for-fastboot.patch
queue-6.12/drm-amd-amdgpu-disable-aspm-in-some-situations.patch
queue-6.12/drm-amd-display-keep-pll0-running-on-dce-6.0-and-6.4.patch
queue-6.12/drm-amd-display-adjust-dce-8-10-clock-don-t-overclock-by-15.patch
queue-6.12/drm-amd-disable-aspm-on-si.patch
