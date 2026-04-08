Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10951073CB4
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2985E10E655;
	Wed,  8 Apr 2026 13:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t8jHs4nY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE1610E656;
 Wed,  8 Apr 2026 13:08:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1396540295;
 Wed,  8 Apr 2026 13:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9990DC19424;
 Wed,  8 Apr 2026 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775653688;
 bh=1fnP9fhKM/LV4zTeBsDzpY2Z2mFeApCa4rbxutDwJC8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=t8jHs4nYT7M9y2qJLtkIY91pRhj79DIi6eSJ5/jHNY8p86ZHJy+cfYs7up91kOtJz
 EvFPfkswxILRPymiKudG2VStf57tU77eG+UfoNWSLT9ElOsw8gfolilZsTcPz6BgEC
 Dt9drF1V1s42zP+cJCpAY7KHoaEaVsJJOx1G3PS0=
Subject: Patch "drm/amd/display: Correct logic check error for fastboot" has
 been added to the 6.12-stable tree
To: Charlene.Liu@amd.com, Eric.Yang2@amd.com, Mario.Limonciello@amd.com,
 Rodrigo.Siqueira@amd.com, Roman.Li@amd.com, Tony.Cheng@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, alex.hung@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, daniel.wheeler@amd.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 harry.wentland@amd.com, issor.oruam@gmail.com, ovidiu.bunea@amd.com,
 ray.wu@amd.com, rosenp@gmail.com, simona@ffwll.ch, sunpeng.li@amd.com,
 timur.kristof@gmail.com, wayne.lin@amd.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:07:40 +0200
In-Reply-To: <20260401003908.3438-11-rosenp@gmail.com>
Message-ID: <2026040840-prior-repossess-034d@gregkh>
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

    drm/amd/display: Correct logic check error for fastboot

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-display-correct-logic-check-error-for-fastboot.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-232628-greg=kroah.com@vger.kernel.org Wed Apr  1 02:45:51 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 31 Mar 2026 17:39:08 -0700
Subject: drm/amd/display: Correct logic check error for fastboot
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Xinhui Pan" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <wayne.lin@amd.com>, "Mario Limonciello" <Mario.Limonciello@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Eric Yang" <Eric.Yang2@amd.com>, "Tony Cheng" <Tony.Cheng@amd.com>, "Mauro Rossi" <issor.oruam@gmail.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260401003908.3438-11-rosenp@gmail.com>

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit b6a65009e7ce3f0cc72da18f186adb60717b51a0 ]

[Why]
Fix fastboot broken in driver.
This is caused by an open source backport change 7495962c.

from the comment, the intended check is to disable fastboot
for pre-DCN10. but the logic check is reversed, and causes
fastboot to be disabled on all DCN10 and after.

fastboot is for driver trying to pick up bios used hw setting
and bypass reprogramming the hw if dc_validate_boot_timing()
condition meets.

Fixes: 7495962cbceb ("drm/amd/display: Disable fastboot on DCE 6 too")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,8 +1910,8 @@ void dce110_enable_accelerated_mode(stru
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
-	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
+	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)


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
