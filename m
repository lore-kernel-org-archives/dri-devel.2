Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92471073CB0
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1674A10E653;
	Wed,  8 Apr 2026 13:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KlkRzznO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E07810E653;
 Wed,  8 Apr 2026 13:08:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7033744574;
 Wed,  8 Apr 2026 13:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068ABC2BCB1;
 Wed,  8 Apr 2026 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775653686;
 bh=qAWvd57xuzQN1BIcJOE21sD08yvlTid21TQqkmQWBkc=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=KlkRzznO4i4gOD/JPF0oP845Uybu+SLhZre+XixVZPWu1hM5JvPCoLs8aDp0Bydp+
 SgG8kNw/FIRAZKR0jBI25WkbzOGWVJf5JQYKWR8lQPLPIP+0ZAnjsIcz6rgE5CcgCa
 bX9G3JPz7iUXzhBwNNS46QkZqdkegw06TwySY0dU=
Subject: Patch "drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4" has
 been added to the 6.12-stable tree
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
In-Reply-To: <20260401003908.3438-6-rosenp@gmail.com>
Message-ID: <2026040840-litigator-feline-ac29@gregkh>
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

    drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-display-keep-pll0-running-on-dce-6.0-and-6.4.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-232624-greg=kroah.com@vger.kernel.org Wed Apr  1 02:44:15 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 31 Mar 2026 17:39:03 -0700
Subject: drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Xinhui Pan" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <wayne.lin@amd.com>, "Mario Limonciello" <Mario.Limonciello@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Eric Yang" <Eric.Yang2@amd.com>, "Tony Cheng" <Tony.Cheng@amd.com>, "Mauro Rossi" <issor.oruam@gmail.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260401003908.3438-6-rosenp@gmail.com>

From: Timur KristÃ³f <timur.kristof@gmail.com>

[ Upstream commit 0449726b58ea64ec96b95f95944f0a3650204059 ]

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur KristÃ³f <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -889,7 +889,16 @@ static bool dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
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
