Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D45F46103
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B5910E3DA;
	Mon, 23 Mar 2026 13:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RuQ9pHtj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8E110E3DA;
 Mon, 23 Mar 2026 13:04:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 25AD7444F0;
 Mon, 23 Mar 2026 13:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74659C4CEF7;
 Mon, 23 Mar 2026 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774271045;
 bh=w34m24tQgIZi+3zHGzmbpJ9scCfQ3MPw1ejuYPEz5+s=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=RuQ9pHtjfRD7Lsj/vxqrYmhjdbRGeDOetrRV2GE1LU6CVye3WDINB7Re3mXxsIaar
 7t77eQ7Tw0k6q9xGJA0zJP87Exq3ccI3lYgvBTTW5HCXnwJ861zbp58mfsZrXshPka
 eqej9t+hyRBRMpc2BuPElXvWTKom9R3McZZheh2U=
Subject: Patch "drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration" has been added to the 6.1-stable tree
To: Jun.Ma2@amd.com, Rodrigo.Siqueira@amd.com, Roman.Li@amd.com,
 Wayne.Lin@amd.com, Xinhui.Pan@amd.com, Zhigang.Luo@amd.com, airlied@gmail.com,
 alex.hung@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, daniel@ffwll.ch, decce6@proton.me,
 dri-devel@lists.freedesktop.org, evan.quan@amd.com, gregkh@linuxfoundation.org,
 harry.wentland@amd.com, hersenxs.wu@amd.com, lijo.lazar@amd.com,
 mario.limonciello@amd.com, ray.wu@amd.com, rosenp@gmail.com, sashal@kernel.org,
 spasswolf@web.de, srinivasan.shanmugam@amd.com, sunpeng.li@amd.com,
 superm1@kernel.org, timur.kristof@gmail.com, vulab@iscas.ac.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Mar 2026 14:03:37 +0100
In-Reply-To: <20260321054453.19683-4-rosenp@gmail.com>
Message-ID: <2026032336-ahead-overuse-5fd1@gregkh>
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

    drm/amd/display: Add pixel_clock to amd_pp_display_configuration

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-display-add-pixel_clock-to-amd_pp_display_configuration.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From rosenp@gmail.com Sat Mar 21 06:45:19 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 22:44:52 -0700
Subject: drm/amd/display: Add pixel_clock to amd_pp_display_configuration
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Evan Quan" <evan.quan@amd.com>, "Mario Limonciello" <mario.limonciello@amd.com>, "Sasha Levin" <sashal@kernel.org>, "Rosen Penev" <rosenp@gmail.com>, "Lijo Lazar" <lijo.lazar@amd.com>, "Ma Jun" <Jun.Ma2@amd.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Zhigang Luo" <Zhigang.Luo@amd.com>, "Bert Karwatzki" <spasswolf@web.de>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <Wayne.Lin@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Hersen Wu" <hersenxs.wu@amd.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, decce6 <decce6@proton.me>, "Went
 ao Liang" <vulab@iscas.ac.cn>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260321054453.19683-4-rosenp@gmail.com>

From: Timur KristÃ³f <timur.kristof@gmail.com>

[ Upstream commit b515dcb0dc4e85d8254f5459cfb32fce88dacbfb ]

This commit adds the pixel_clock field to the display config
struct so that power management (DPM) can use it.

We currently don't have a proper bandwidth calculation on old
GPUs with DCE 6-10 because dce_calcs only supports DCE 11+.
So the power management (DPM) on these GPUs may need to make
ad-hoc decisions for display based on the pixel clock.

Also rename sym_clock to pixel_clock in dm_pp_single_disp_config
to avoid confusion with other code where the sym_clock refers to
the DisplayPort symbol clock.

Signed-off-by: Timur KristÃ³f <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       |    1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h             |    2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h                  |    1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -97,6 +97,7 @@ bool dm_pp_apply_display_requirements(
 			const struct dm_pp_single_disp_config *dc_cfg =
 						&pp_display_cfg->disp_configs[i];
 			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
+			adev->pm.pm_display_cfg.displays[i].pixel_clock = dc_cfg->pixel_clock;
 		}
 
 		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -164,7 +164,7 @@ void dce110_fill_display_configs(
 			stream->link->cur_link_settings.link_rate;
 		cfg->link_settings.link_spread =
 			stream->link->cur_link_settings.link_spread;
-		cfg->sym_clock = stream->phy_pix_clk;
+		cfg->pixel_clock = stream->phy_pix_clk;
 		/* Round v_refresh*/
 		cfg->v_refresh = stream->timing.pix_clk_100hz * 100;
 		cfg->v_refresh /= stream->timing.h_total;
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -127,7 +127,7 @@ struct dm_pp_single_disp_config {
 	uint32_t src_height;
 	uint32_t src_width;
 	uint32_t v_refresh;
-	uint32_t sym_clock; /* HDMI only */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 	struct dc_link_settings link_settings; /* DP only */
 };
 
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -66,6 +66,7 @@ struct single_display_configuration
 	uint32_t view_resolution_cy;
 	enum amd_pp_display_config_type displayconfigtype;
 	uint32_t vertical_refresh; /* for active display */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 };
 
 #define MAX_NUM_DISPLAY 32


Patches currently in stable-queue which might be from rosenp@gmail.com are

queue-6.1/drm-amdgpu-clarify-dc-checks.patch
queue-6.1/drm-amd-pm-use-pm_display_cfg-in-legacy-dpm-v2.patch
queue-6.1/drm-amdgpu-use-proper-dc-check-in-amdgpu_display_supported_domains.patch
queue-6.1/drm-amd-display-add-pixel_clock-to-amd_pp_display_configuration.patch
