Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2060F46101
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B20110E3F0;
	Mon, 23 Mar 2026 13:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YC4aICda";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9629410E3E9;
 Mon, 23 Mar 2026 13:04:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1756A60132;
 Mon, 23 Mar 2026 13:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3496C2BCB4;
 Mon, 23 Mar 2026 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774271054;
 bh=OvyV8JR2aEGGQ081tRpfHW5qKaTekubyv5ln+z7tMrI=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=YC4aICdapp4QW8nnrhFrKV/ydhBP1lZ2wIAXXGhQSk+bkRyOpXn5PNVfXUxXFw8Kf
 HEMocgVglzgSevrsl9lQulDn26F1KEyIrlzYF/gjJ2KUqR9ylpaekx4ctUTThQqFaK
 qoo59ahxyVMT6ozNgsYuGOoZrfL2YMfgpVnnC8G4=
Subject: Patch "drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()" has been added to the 6.1-stable tree
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
Date: Mon, 23 Mar 2026 14:03:40 +0100
In-Reply-To: <20260321054453.19683-2-rosenp@gmail.com>
Message-ID: <2026032340-unblessed-remark-3d7d@gregkh>
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

    drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdgpu-use-proper-dc-check-in-amdgpu_display_supported_domains.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From rosenp@gmail.com Sat Mar 21 06:45:14 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 22:44:50 -0700
Subject: drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Evan Quan" <evan.quan@amd.com>, "Mario Limonciello" <mario.limonciello@amd.com>, "Sasha Levin" <sashal@kernel.org>, "Rosen Penev" <rosenp@gmail.com>, "Lijo Lazar" <lijo.lazar@amd.com>, "Ma Jun" <Jun.Ma2@amd.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Zhigang Luo" <Zhigang.Luo@amd.com>, "Bert Karwatzki" <spasswolf@web.de>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <Wayne.Lin@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Hersen Wu" <hersenxs.wu@amd.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, decce6 <decce6@proton.me>, "Went
 ao Liang" <vulab@iscas.ac.cn>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260321054453.19683-2-rosenp@gmail.com>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 96ce96f8773da4814622fd97e5226915a2c30706 ]

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Acked-by: Christian KÃ¶nig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domain
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif


Patches currently in stable-queue which might be from rosenp@gmail.com are

queue-6.1/drm-amdgpu-clarify-dc-checks.patch
queue-6.1/drm-amd-pm-use-pm_display_cfg-in-legacy-dpm-v2.patch
queue-6.1/drm-amdgpu-use-proper-dc-check-in-amdgpu_display_supported_domains.patch
queue-6.1/drm-amd-display-add-pixel_clock-to-amd_pp_display_configuration.patch
