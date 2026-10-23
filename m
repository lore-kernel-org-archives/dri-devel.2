Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70304606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TVHTs/IU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB13110E5D0;
	Fri, 23 Oct 2026 10:22:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0E81410E5D0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:22:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57065302D
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:22:13 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4CE0C3F7B4
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792750936; bh=VnaOaoCbZWtRveOiSDtrRS+aRrEZTeoetU0oSSXUGhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TVHTs/IUUVOdkXlaf024JVgN9kK+E04Juwnofomb+cx37blR4Pl4BcZTrb4nPEn5Q
 RM79tjBuaRUWAhe3O3L5WblytITi9/n4PMGNjb0UMiePFUr+WyiUvIb6LQTLt+zmOg
 S6ys7VdB2O5yjsBUYXwxuwvmy6v02fM9GYPTl9WM=
Date: Fri, 23 Oct 2026 11:21:48 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH v7 0/9] drm: writeback: clean up writeback connector
 initialization
Message-ID: <ats1PJqVhNR-RXAX@e142607>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 04:12:26PM +0300, Dmitry Baryshkov wrote:
> Drivers using drm_writeback_connector_init() / _with_encoder() don't
> perform cleanup in a manner similar to drmm_writeback_connector_init()
> (see drm_writeback_connector_cleanup()). Enough of the drivers don't use
> the encoder embedded into the drm_writeback connector.  In preparation
> to further rework of the WB connectors (as planned to enable WB for i915
> / xe drivers, which would move drm_writeback_connector to be a field
> inside drm_connector instead of subclassing it) remove the drm_encoder
> wrapped in struct drm_writeback_connector. Rename the
> drm_writeback_connector_init_with_encoder() to
> drm_writeback_connector_init()
> and copy drmm_writeback_connector_init() interface. Then, with the
> encoder being gone, handle proper cleanup of writeback data in
> drm_connector_cleanup().
> 
> ---
> Changes in v7:
> - Significantly reworked series, no longer insisting on using drmm.
> - Link to v6: https://patch.msgid.link/20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com
> 
> Changes in v6:
> - Dropped applied patch
> - Implemented suggestion by Alex to use drmm allocation for the
>   writeback connector.
> - Link to v5: https://patch.msgid.link/20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com
> 
> Changes in v5:
> - Rebased on top of drm-misc-next
> - Expanded commit message for msm patch, describing devm vs drmm issues (Laurent)
> - Expanded commit messages, describing why the drivers are converted to
>   drmm_writeback_connector_init() (Laurent)
> - Link to v4: https://lore.kernel.org/r/20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com
> 
> Changes in v4:
> - Rebase on top of drm-misc-next, dropping applied patch.
> - Added a note regarding memory leak in the AMDGPU driver.
> - Fixed a devm vs drmm issue in the msm/dpu driver.
> - Link to v3: https://lore.kernel.org/r/20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com
> 
> Changes in v3:
> - Fixed subject prefix for the rcar-du patch (Jessica Zhang)
> - Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com
> 
> Changes in v2:
> - Switched to drm_crtc_mask() where applicable (Louis Chauvet)
> - Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com
> 
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: John Harrison <John.Harrison@igalia.com>
> To: Harry Wentland <harry.wentland@amd.com>
> To: Leo Li <sunpeng.li@amd.com>
> To: Rodrigo Siqueira <siqueira@igalia.com>
> To: Alex Deucher <alexander.deucher@amd.com>
> To: Christian König <christian.koenig@amd.com>
> To: Liviu Dudau <liviu.dudau@arm.com>
> To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> To: Geert Uytterhoeven <geert+renesas@glider.be>
> To: Magnus Damm <magnus.damm@gmail.com>
> To: Dave Stevenson <dave.stevenson@raspberrypi.com>
> To: Maíra Canal <mcanal@igalia.com>
> To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> To: Louis Chauvet <louis.chauvet@bootlin.com>
> To: Mihail Atanassov <mihail.atanassov@arm.com>
> To: Eric Anholt <eric@anholt.net>
> To: Rob Clark <robin.clark@oss.qualcomm.com>
> To: Brian Starkey <brian.starkey@arm.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> 
> ---
> Dmitry Baryshkov (9):
>       drm/amd/display: embed the writeback encoder in amdgpu_dm_wb_connector
>       drm/komeda: embed the writeback encoder in komeda_wb_connector
>       drm/mali: embed the writeback encoder in malidp_drm
>       drm: renesas: rcar-du: embed the writeback encoder in rcar_du_crtc
>       drm: writeback: drop excess connector initialization functions
>       drm: writeback: rename drm_writeback_connector_init_with_encoder()
>       drm: writeback: don't destroy the shared writeback properties
>       drm: writeback: clean up writeback connectors in drm_connector_cleanup()
>       drm: writeback: drop the drmm writeback cleanup action
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  27 +++-
>  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   4 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   4 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |   3 +
>  .../drm/arm/display/komeda/komeda_wb_connector.c   |  24 +++-
>  drivers/gpu/drm/arm/malidp_drv.h                   |   1 +
>  drivers/gpu/drm/arm/malidp_mw.c                    |  25 +++-
>  drivers/gpu/drm/drm_connector.c                    |   3 +
>  drivers/gpu/drm/drm_crtc_internal.h                |   3 +
>  drivers/gpu/drm/drm_writeback.c                    | 147 +++++----------------
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |   2 +
>  .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |  29 +++-
>  drivers/gpu/drm/vc4/vc4_txp.c                      |   8 +-
>  include/drm/drm_writeback.h                        |  22 +--
>  16 files changed, 140 insertions(+), 165 deletions(-)

I still personally dislike the whole idea of removing a framework feature that was beneficial
to a lot of drivers in order to help one driver, but that is just my stance. The stats kind of
show that and if it wasn't for the massive delete in drm_writeback.c (partly of comments) you
would add more code with this change. The cleanup and fixes patches in this series also points
out that there are still issues with the concept and John and sashiko are also raising issues.

Anyway, as far as komeda and malidp drivers changes are concerned, I'm OK with them being applied
as long as the framework or the patch series solves any cleanup issues. So for those two patches
you can have my

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


> ---
> base-commit: 725953d4da85cfb97a4c309fad6346b72f8529e7
> change-id: 20250801-wb-drop-encoder-97a0c75bd5d7
> 
> Best regards,
> --  
> With best wishes
> Dmitry
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
