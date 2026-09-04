Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C88C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DC910E2AC;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ijxZE6L1";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB1B10FB09
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:01:28 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7f3f52143cdso773687a34.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523288; x=1789128088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PztQilMA+BwP/POObtzo6WFSzqT8y4xtj9P3CJDfmGw=;
 b=ijxZE6L1T6mTRny1/l4jpUQ24MDxUQO/FhfRaVYYcXX16C8aqpQvFWL6o4Ye/USWrH
 Y1WnBHvWEht+qy2Q2zC/2tCpfaD92aPbo1Mwf0weOynKGUllgouJ8gaKonym9AeN4faI
 JcRs8RgFnpdRhqdTnvANiZt0r07sgg1aMytWF4WqDfLQYLJlquqFRCAtbUl58jk7pmd8
 OQ1ppvXRmcH/6NV0OJ60SJ/4q+JoSModz6yNs9MIFrhy9KQ4tp7MUvXcNl6/S16+nV0j
 v8KK4Fa/o5BgLeZLV2YVdHz8tPQS6jxfX8+RQmggfG1BTQIO9s9xVAI5mKPFV00upLwO
 uZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523288; x=1789128088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PztQilMA+BwP/POObtzo6WFSzqT8y4xtj9P3CJDfmGw=;
 b=e1SXjsPko3terPEQxP7d4rt+XFJ7T+D0QFXe7A4JMFJt+4L04bN1xLPeodOPxHKnEU
 qsKEREhnpzqUcL+P8qviEJV7Xf0IuhtcC4Ypu/zu2PVKvp0ETRYtUT+p98IrqLiJNEPD
 34Zlr8K7+lLUainkNdG8iNAQJIfxJSSoVkF0KRiXlGgOimuWO9YLekjKGFCGFfmK36RG
 kq/JNagjEvqgnzNTQATd+yL9gUire6l/2DhgEj5JwJocgQ6IWVQehzPBVukhg+dirV1M
 d84i4xbUcoLV7HjrqhqN/WcSVVMmhPR4tsgc/J0mMPGzBi2NExi6DAX/Ls0criWw1Jvd
 i7Fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVwx23abE1sn48DUDqV18R+0rYjp5OqJnM6u/f7rBpH9K1hLfYMkhwG4aljU0Pfh5CUnTp7sWtPgU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nW2KFdaDaMFdXumEJGFBpN3wcj9a552fbj54U28fDgN7qwKq73
 F0cMCNUSqObjGo9Wdksw2kVKnQf3NqN28JvMKzv3LHwzXrQMXvfeIQ9P
X-Gm-Gg: AYBFou1satRhNBfGE88mBgLQlAxyMb3Z8xxULRSB1Xe7TmY6DXhkkT9uF+wMkZYBkQ/
 rHmdR5/i93+9RbfwKHDr3YDtj7nh9zwGYkWdt4s1etn44xFybi64M0lG9BW+Egar+SqgX6/ughB
 GZ3ND+Bl1eBJPDUFFiTvf+XkIb2ahuLJU42hk8TebEhVAfHGC00XtHb8XLoHaOcXRQzi00f2y8m
 BbC8y3X+XqctAEEOXX74p1Mt4PV+Km1T/ZhsFtA5+97PfqQoqn3wQsDpoUg2DsA2l4fRw5Ipj0j
 R2czGZ7BxWyukw9YOhLqPWWqXTEbRxmx925O+rtZqvf6flvqgiiry8/WKjfD0MX6E005eYb98xX
 hD+X8AB7U4wtKwaN7BA9ies5DxiRgNH0CF06Vsj4/QRkScla4VZ47/y5y9Zdfnxu2vW33b3DRMB
 Laq7XfUEUinH8Cw7bdgLBIMKPSnLnr+t34Ak8L3j3KHoRB0ge1eNHJ4sxsIxF+f+sx+AoKOH3dp
 2lwk9+s/Fl7KJ4=
X-Received: by 2002:a05:6820:810a:b0:6b1:bdd9:453 with SMTP id
 006d021491bc7-6b6faee1fa2mr4454361eaf.12.1788523286102; 
 Fri, 04 Sep 2026 05:01:26 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm10164241c88.4.2026.09.04.05.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:01:25 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm: fix typos in comments
Date: Fri,  4 Sep 2026 17:30:07 +0530
Message-ID: <20260904120044.14303-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120044.14303-1-hemanth.selam@gmail.com>
References: <20260904120044.14303-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  4 +-
 drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  2 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  2 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  8 +--
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |  4 +-
 .../amd/display/dc/dce/dce_stream_encoder.c   |  4 +-
 .../dc/dce110/dce110_timing_generator.c       |  2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c |  2 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.h |  2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  2 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 +-
 .../dc/dml2_0/display_mode_core_structs.h     |  2 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |  2 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |  2 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 10 ++--
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |  6 +-
 .../dml2_core_dcn5_calcs_dsc_latency.c        |  6 +-
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c |  2 +-
 .../alternate_pstate_shared_lib.c             |  2 +-
 .../dml21/src/dml2_top/dml2_top_soc15.c       |  4 +-
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.c  |  2 +-
 .../src/inc/dml2_internal_shared_types.h      |  2 +-
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |  2 +-
 .../dc/gpio/dcn315/hw_factory_dcn315.c        |  2 +-
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  |  2 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  8 +--
 .../dc/link/protocols/link_dp_capability.c    |  4 +-
 .../link/protocols/link_edp_panel_control.c   |  4 +-
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |  2 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  2 +-
 .../dc/resource/dcn302/dcn302_resource.c      |  2 +-
 .../dc/resource/dcn303/dcn303_resource.c      |  2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  4 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +-
 .../dc/resource/dcn60/dcn60_resource.c        |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 +-
 .../display/include/grph_object_ctrl_defs.h   |  2 +-
 drivers/gpu/drm/amd/include/atombios.h        | 56 +++++++++----------
 drivers/gpu/drm/amd/include/atomfirmware.h    |  2 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  2 +-
 drivers/gpu/drm/amd/include/pptable.h         |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 16 +++---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  2 +-
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  4 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  2 +-
 .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  2 +-
 .../pm/powerplay/smumgr/polaris10_smumgr.c    |  2 +-
 .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c |  4 +-
 .../amd/pm/powerplay/smumgr/tonga_smumgr.c    |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  4 +-
 .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  4 +-
 .../inc/pmfw_if/smu15_driver_if_v15_0_8.h     |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
 drivers/gpu/drm/radeon/atombios.h             | 34 +++++------
 drivers/gpu/drm/radeon/cik.c                  | 14 ++---
 drivers/gpu/drm/radeon/evergreen.c            |  4 +-
 drivers/gpu/drm/radeon/pptable.h              |  2 +-
 drivers/gpu/drm/radeon/r600.c                 |  6 +-
 drivers/gpu/drm/radeon/r600_dpm.c             |  2 +-
 drivers/gpu/drm/radeon/radeon.h               |  2 +-
 drivers/gpu/drm/radeon/radeon_cs.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_device.c        | 16 +++---
 drivers/gpu/drm/radeon/radeon_display.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_drv.c           |  2 +-
 drivers/gpu/drm/radeon/radeon_fence.c         |  4 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  2 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c   |  4 +-
 drivers/gpu/drm/radeon/radeon_uvd.c           |  2 +-
 drivers/gpu/drm/radeon/radeon_vm.c            |  2 +-
 drivers/gpu/drm/radeon/rs690.c                |  4 +-
 drivers/gpu/drm/radeon/rs780_dpm.c            |  2 +-
 drivers/gpu/drm/radeon/rv770.c                |  2 +-
 drivers/gpu/drm/radeon/si.c                   |  2 +-
 drivers/gpu/drm/radeon/uvd_v1_0.c             |  4 +-
 158 files changed, 274 insertions(+), 274 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 27c0dc8f6137..21cbcdc6d2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1903,7 +1903,7 @@ void amdgpu_atombios_fini(struct amdgpu_device *adev)
  *
  * Initializes the driver info and register access callbacks for the
  * ATOM interpreter (r4xx+).
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  * Called at driver startup.
  */
 int amdgpu_atombios_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d53259a5b82f..0a09cef0603d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -532,7 +532,7 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 	out->state.flags = 0x0;
 	out->state.hangs = 0x0;
 
-	/* determine if a GPU reset has occured since the last call */
+	/* determine if a GPU reset has occurred since the last call */
 	reset_counter = atomic_read(&adev->gpu_reset_counter);
 	/* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
 	if (ctx->reset_counter_query == reset_counter)
@@ -922,7 +922,7 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
 	/*
 	 * This is a little bit racy because it can be that a ctx or a fence are
 	 * destroyed just in the moment we try to account them. But that is ok
-	 * since exactly that case is explicitely allowed by the interface.
+	 * since exactly that case is explicitly allowed by the interface.
 	 */
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..d23500d645bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -70,7 +70,7 @@
  * Allocate the dummy page used by the driver (all asics).
  * This dummy page is used by the driver as a filler for gart entries
  * when pages are taken out of the GART
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  */
 static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..fb6ec289155c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2425,7 +2425,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	 */
 	if (!num_hung && queue_input && !ring) {
 		/* MES suspend_all is successful means this bad queue is
-		 * preempted successfuly. Remove it before resume all so it
+		 * preempted successfully. Remove it before resume all so it
 		 * doesn't get mapped back
 		 */
 		if (!down_read_trylock(&adev->reset_domain->sem)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3dc8faa091d7..a4314fda6be7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -297,7 +297,7 @@ void amdgpu_gmc_set_gart_size(struct amdgpu_device *adev, u64 default_size)
  * @gart_placement: GART placement policy with respect to VRAM
  *
  * Function will try to place GART before or after VRAM.
- * If GART size is bigger than space left then we ajust GART size.
+ * If GART size is bigger than space left then we adjust GART size.
  * Thus function will never fails.
  */
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8a2d64f0ebc3..f8be73e5fec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -228,12 +228,12 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
  */
 
 /**
- * amdgpu_vmid_had_gpu_reset - check if reset occured since last use
+ * amdgpu_vmid_had_gpu_reset - check if reset occurred since last use
  *
  * @adev: amdgpu_device pointer
  * @id: VMID structure
  *
- * Check if GPU reset occured since last use of the VMID.
+ * Check if GPU reset occurred since last use of the VMID.
  */
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index c2a10b41804a..edc3f559f6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -203,7 +203,7 @@ int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @ih: ih ring to process
  *
- * Interrupt hander (VI), walk the IH ring.
+ * Interrupt handler (VI), walk the IH ring.
  * Returns irq process return code.
  */
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 44fe40f9e8df..57bd34981be0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -31,7 +31,7 @@
 #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
 /* bit set means preamble IB is first presented in belonging context */
 #define AMDGPU_PREAMBLE_IB_PRESENT_FIRST    (1 << 1)
-/* bit set means context switch occured */
+/* bit set means context switch occurred */
 #define AMDGPU_HAVE_CTX_SWITCH              (1 << 2)
 /* bit set means IB is preempted */
 #define AMDGPU_IB_PREEMPTED                 (1 << 3)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
index 675aa138ea11..166d0f56c1d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
@@ -105,7 +105,7 @@ static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev, unsigned int n
 }
 
 /**
- * amdgpu_pll_compute - compute PLL paramaters
+ * amdgpu_pll_compute - compute PLL parameters
  *
  * @adev: amdgpu_device pointer
  * @pll: information about the PLL
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04f6ebf31cca..d8fa408343c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3670,8 +3670,8 @@ static int psp_load_fw(struct amdgpu_device *adev)
 failed:
 	/*
 	 * all cleanup jobs (xgmi terminate, ras terminate,
-	 * ring destroy, cmd/fence/fw buffers destory,
-	 * psp->cmd destory) are delayed to psp_hw_fini
+	 * ring destroy, cmd/fence/fw buffers destroy,
+	 * psp->cmd destroy) are delayed to psp_hw_fini
 	 */
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
index bacf888735db..773f0e0d2dd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -64,7 +64,7 @@ static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
 		return ret;
 	}
 
-	/* make sure gfx core is on, RAP TA cann't handle
+	/* make sure gfx core is on, RAP TA can't handle
 	 * GFX OFF case currently.
 	 */
 	amdgpu_gfx_off_ctrl(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35eb87591740..7c98af76c4b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1627,7 +1627,7 @@ static int amdgpu_ras_query_error_count_helper(struct amdgpu_device *adev,
 	*ue_count += query_info->ue_count;
 
 	/* some hardware/IP supports read to clear
-	 * no need to explictly reset the err status after the query call */
+	 * no need to explicitly reset the err status after the query call */
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 2) &&
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 4)) {
 		if (amdgpu_ras_reset_error_status(adev, query_info->head.block))
@@ -3419,7 +3419,7 @@ static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
 
 /*
  * check hardware's ras ability which will be saved in hw_supported.
- * if hardware does not support ras, we can skip some ras initializtion and
+ * if hardware does not support ras, we can skip some ras initialization and
  * forbid some ras operations from IP.
  * if software itself, say boot parameter, limit the ras ability. We still
  * need allow IP do some limited operations, like disable. In such case,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 428c3cbc4a40..b706bc99467d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -44,7 +44,7 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	/* VCN FW shared region is in frambuffer, there are some flags
+	/* VCN FW shared region is in framebuffer, there are some flags
 	 * initialized in that region during sw_init. Make sure the region is
 	 * backed up.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index b2a3db60d231..eac53ee7afd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -105,7 +105,7 @@ struct amdgpu_umc {
 	/* Total number of umc node instance including harvest one */
 	uint32_t node_inst_num;
 
-	/* UMC regiser per channel offset */
+	/* UMC register per channel offset */
 	uint32_t channel_offs;
 	/* how many pages are retired in one UE */
 	uint32_t retire_unit;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index e037c08c8547..6bac41b1f38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1032,7 +1032,7 @@ static bool cik_read_bios_from_rom(struct amdgpu_device *adev,
 	/* set rom index to 0 */
 	WREG32(mmSMC_IND_INDEX_0, ixROM_INDEX);
 	WREG32(mmSMC_IND_DATA_0, 0);
-	/* set index to data for continous read */
+	/* set index to data for continuous read */
 	WREG32(mmSMC_IND_INDEX_0, ixROM_DATA);
 	for (i = 0; i < length_dw; i++)
 		dw_ptr[i] = RREG32(mmSMC_IND_DATA_0);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index b951328d94cf..14df3796c43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -213,7 +213,7 @@ static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  * cik_sdma_ring_emit_ib - Schedule an IB on the DMA engine
  *
  * @ring: amdgpu ring pointer
- * @job: job to retrive vmid from
+ * @job: job to retrieve vmid from
  * @ib: IB object to schedule
  * @flags: unused
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 69776dbe188d..6dd92bde803c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6221,7 +6221,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 
 	/*
 	 * The logic here isn't easy to understand because we need to keep state
-	 * accross multiple executions of the function as well as between the
+	 * across multiple executions of the function as well as between the
 	 * CPU and GPU. The general idea is that the newly written GPU command
 	 * has a condition on the previous one and only executed if really
 	 * necessary.
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5fc19fefca81..8ddd3ab880d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2342,7 +2342,7 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
  * ME - Micro Engine
  * CE - Constant Engine
  * The PFP and ME make up what is considered the Drawing Engine (DE).
- * The CE is an asynchronous engine used for updating buffer desciptors
+ * The CE is an asynchronous engine used for updating buffer descriptors
  * used by the DE so that they can be loaded into cache in parallel
  * while the DE is processing state update packets.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..b256ce102610 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -356,7 +356,7 @@ static int gfxhub_v11_5_0_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..a6711f638d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -361,7 +361,7 @@ static int gfxhub_v12_0_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 30b90d35abd0..4b52d54964d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -358,7 +358,7 @@ static int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..8e8ecb65f51d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -353,7 +353,7 @@ static int gfxhub_v3_0_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 98db62cc8718..4c4acc93635d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -330,7 +330,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		u32 tmp;
 		int chansize, numchan;
 
-		/* Get VRAM informations */
+		/* Get VRAM information */
 		tmp = RREG32(mmMC_ARB_RAMCFG);
 		if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE))
 			chansize = 64;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 64ebedc595b5..e12748f9e479 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -478,7 +478,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	if (!adev->gmc.vram_width) {
 		int chansize, numchan;
 
-		/* Get VRAM informations */
+		/* Get VRAM information */
 		tmp = RREG32(mmMC_ARB_RAMCFG);
 		if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE))
 			chansize = 64;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 333e9c30c091..becdfcd3c964 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -366,7 +366,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL, tmp);
 
 	/* GC/MMHUB UTCL2 page fault interrupts are configured as
-	 * MSI storm capable interrupts by deafult. The delay is
+	 * MSI storm capable interrupts by default. The delay is
 	 * used to avoid ISR being called too frequently
 	 * when page fault happens on several continuous page
 	 * and thus avoid MSI storm */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 699c274d357e..367babe35c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -337,7 +337,7 @@ static int ih_v6_1_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL, tmp);
 
 	/* GC/MMHUB UTCL2 page fault interrupts are configured as
-	 * MSI storm capable interrupts by deafult. The delay is
+	 * MSI storm capable interrupts by default. The delay is
 	 * used to avoid ISR being called too frequently
 	 * when page fault happens on several continuous page
 	 * and thus avoid MSI storm */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 6de9e87e04e1..eaf36b0ca344 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -360,7 +360,7 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL, tmp);
 
 	/* GC/MMHUB UTCL2 page fault interrupts are configured as
-	 * MSI storm capable interrupts by deafult. The delay is
+	 * MSI storm capable interrupts by default. The delay is
 	 * used to avoid ISR being called too frequently
 	 * when page fault happens on several continuous page
 	 * and thus avoid MSI storm */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c57bcb9a98b1..c204ea41b65b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1350,7 +1350,7 @@ static int mes_v11_0_load_microcode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
 		     upper_32_bits(ucode_addr));
 
-	/* set ucode fimrware address */
+	/* set ucode firmware address */
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_LO,
 		     lower_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_HI,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d..994d2d6eedde 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1421,7 +1421,7 @@ static int mes_v12_0_load_microcode(struct amdgpu_device *adev,
 
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_CNTL, 0);
 
-	/* set ucode fimrware address */
+	/* set ucode firmware address */
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_LO,
 		     lower_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_HI,
@@ -1585,7 +1585,7 @@ static int mes_v12_0_mqd_init(struct amdgpu_ring *ring)
 	/*
 	 * Set CP_HQD_GFX_CONTROL.DB_UPDATED_MSG_EN[15] to enable unmapped
 	 * doorbell handling. This is a reserved CP internal register can
-	 * not be accesss by others
+	 * not be access by others
 	 */
 	mqd->reserved_184 = BIT(15);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f1098118d5c0..38f2bc01ef8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1176,7 +1176,7 @@ static int mes_v12_1_load_microcode(struct amdgpu_device *adev,
 
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_IC_BASE_CNTL, 0);
 
-	/* set ucode fimrware address */
+	/* set ucode firmware address */
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_IC_BASE_LO,
 		     lower_32_bits(adev->mes.ucode_fw_gpu_addr[inst]));
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_IC_BASE_HI,
@@ -1361,7 +1361,7 @@ static int mes_v12_1_mqd_init(struct amdgpu_ring *ring)
 	/*
 	 * Set CP_HQD_GFX_CONTROL.DB_UPDATED_MSG_EN[15] to enable unmapped
 	 * doorbell handling. This is a reserved CP internal register can
-	 * not be accesss by others
+	 * not be access by others
 	 */
 	mqd->cp_hqd_gfx_control = BIT(15);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 243eabda0607..5d208c4b3c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -363,7 +363,7 @@ static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 31c479d76c42..bc6f942c3427 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -338,7 +338,7 @@ static int mmhub_v2_3_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
-		 * MMMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * MMMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fec08f235b92..0ac22036b6da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -45,7 +45,7 @@ static void xgpu_ai_mailbox_set_valid(struct amdgpu_device *adev, bool val)
 }
 
 /*
- * this peek_msg could *only* be called in IRQ routine becuase in IRQ routine
+ * this peek_msg could *only* be called in IRQ routine because in IRQ routine
  * RCV_MSG_VALID filed of BIF_BX_PF0_MAILBOX_CONTROL must already be set to 1
  * by host.
  *
@@ -126,7 +126,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 	 * clear TRN_MSG_VALID valid to clear host's RCV_MSG_ACK
 	 * and with host's RCV_MSG_ACK cleared hw automatically clear host's RCV_MSG_ACK
 	 * which lead to VF's TRN_MSG_ACK cleared, otherwise below xgpu_ai_poll_ack()
-	 * will return immediatly
+	 * will return immediately
 	 */
 	do {
 		xgpu_ai_mailbox_set_valid(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index eb537b2ae685..fb6cf534ed21 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -44,7 +44,7 @@ static void xgpu_nv_mailbox_set_valid(struct amdgpu_device *adev, bool val)
 }
 
 /*
- * this peek_msg could *only* be called in IRQ routine becuase in IRQ routine
+ * this peek_msg could *only* be called in IRQ routine because in IRQ routine
  * RCV_MSG_VALID filed of BIF_BX_PF_MAILBOX_CONTROL must already be set to 1
  * by host.
  *
@@ -146,7 +146,7 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 	 * clear TRN_MSG_VALID valid to clear host's RCV_MSG_ACK
 	 * and with host's RCV_MSG_ACK cleared hw automatically clear host's RCV_MSG_ACK
 	 * which lead to VF's TRN_MSG_ACK cleared, otherwise below xgpu_nv_poll_ack()
-	 * will return immediatly
+	 * will return immediately
 	 */
 	do {
 		xgpu_nv_mailbox_set_valid(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index ad618b78685f..95394910d264 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -98,7 +98,7 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_DESTROY_VMR        = 0x0000000A,   /* destroy VMR region */
     GFX_CMD_ID_PROG_REG           = 0x0000000B,   /* program regs */
     GFX_CMD_ID_GET_FW_ATTESTATION = 0x0000000F,   /* Query GPUVA of the Fw Attestation DB */
-    /* IDs upto 0x1F are reserved for older programs (Raven, Vega 10/12/20) */
+    /* IDs up to 0x1F are reserved for older programs (Raven, Vega 10/12/20) */
     GFX_CMD_ID_LOAD_TOC           = 0x00000020,   /* Load TOC and obtain TMR size */
     GFX_CMD_ID_AUTOLOAD_RLC       = 0x00000021,   /* Indicates all graphics fw loaded, start RLC autoload */
     GFX_CMD_ID_BOOT_CFG           = 0x00000022,   /* Boot Config */
@@ -505,7 +505,7 @@ struct psp_gfx_rb_frame
     uint32_t    sid_lo;             /* +24 bits [31:0] of SID value (used only for RBI frames) */
     uint32_t    sid_hi;             /* +28 bits [63:32] of SID value (used only for RBI frames) */
     uint8_t     vmid;               /* +32 VMID value used for mapping of all addresses for this frame */
-    uint8_t     frame_type;         /* +33 1: destory context frame, 0: all other frames; used only for RBI frames */
+    uint8_t     frame_type;         /* +33 1: destroy context frame, 0: all other frames; used only for RBI frames */
     uint8_t     reserved1[2];       /* +34 reserved, must be 0 */
     uint32_t    reserved2[7];       /* +36 reserved, must be 0 */
                 /* total 64 bytes */
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
index d5748032674e..e8fcd22f08d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
@@ -167,7 +167,7 @@ struct ta_xgmi_shared_memory {
 	 * the second set
 	 */
 	uint8_t				flag_extend_link_record;
-	/* bit0: port_num info support flag for GET_EXTEND_PEER_LINKS commmand */
+	/* bit0: port_num info support flag for GET_EXTEND_PEER_LINKS command */
 	uint8_t				caps_flag;
 	uint8_t				reserved[2];
 	union ta_xgmi_cmd_input		xgmi_in_message;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
index 50c632eb4cc6..55bcb6c591b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
@@ -34,7 +34,7 @@
 #define UMC_V6_1_UMC_INSTANCE_NUM		8
 /* total channel instances in one umc block */
 #define UMC_V6_1_TOTAL_CHANNEL_NUM	(UMC_V6_1_CHANNEL_INSTANCE_NUM * UMC_V6_1_UMC_INSTANCE_NUM)
-/* UMC regiser per channel offset */
+/* UMC register per channel offset */
 #define UMC_V6_1_PER_CHANNEL_OFFSET_VG20	0x800
 #define UMC_V6_1_PER_CHANNEL_OFFSET_ARCT	0x400
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index a3ee3c4c650f..60a6c06c29b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -50,7 +50,7 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 	uint32_t index = umc_inst * adev->umc.channel_inst_num + ch_inst;
 
 	/* adjust umc and channel index offset,
-	 * the register address is not linear on each umc instace */
+	 * the register address is not linear on each umc instance */
 	umc_inst = index / 4;
 	ch_inst = index % 4;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 105245d5b6e5..59e8e64743a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -51,7 +51,7 @@
 #define UMC_V6_7_PA_C2_BIT	17
 /* The R14 bit in SOC physical address */
 #define UMC_V6_7_PA_R14_BIT	34
-/* UMC regiser per channel offset */
+/* UMC register per channel offset */
 #define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
 
 /* XOR bit 20, 25, 34 of PA into CH4 bit (bit 12 of PA),
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
index dc12e0af5451..4b2045a82ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -36,7 +36,7 @@
 	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * \
 	(adev)->gmc.num_umc - hweight32((adev)->gmc.m_half_use) * 2)
 
-/* UMC regiser per channel offset */
+/* UMC register per channel offset */
 #define UMC_V8_10_PER_CHANNEL_OFFSET	0x400
 
 /* EccErrCnt max value */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
index dd4993f5f78f..071087747ea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
@@ -34,7 +34,7 @@
 #define UMC_V8_7_UMC_INSTANCE_NUM		8
 /* total channel instances in one umc block */
 #define UMC_V8_7_TOTAL_CHANNEL_NUM	(UMC_V8_7_CHANNEL_INSTANCE_NUM * UMC_V8_7_UMC_INSTANCE_NUM)
-/* UMC regiser per channel offset */
+/* UMC register per channel offset */
 #define UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA	0x400
 
 /* EccErrCnt max value */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 8a9ba2276275..f9525cb6eac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -373,7 +373,7 @@ static int uvd_v4_2_start(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* enable interupt */
+	/* enable interrupt */
 	WREG32_P(mmUVD_MASTINT_EN, 3<<1, ~(3 << 1));
 
 	WREG32_P(mmUVD_STATUS, 0, ~(1<<2));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 454f109cbb2e..5dcca4f6fdf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -333,7 +333,7 @@ static int uvd_v5_0_start(struct amdgpu_device *adev)
 
 	uvd_v5_0_mc_resume(adev);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_P(mmUVD_MASTINT_EN, 0, ~(1 << 1));
 
 	/* stall UMC and register bus before resetting VCPU */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index bbd0e05d39e5..c2602b968d3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -742,7 +742,7 @@ static int uvd_v6_0_start(struct amdgpu_device *adev)
 
 	uvd_v6_0_mc_resume(adev);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_FIELD(UVD_MASTINT_EN, VCPU_EN, 0);
 
 	/* stall UMC and register bus before resetting VCPU */
@@ -1045,7 +1045,7 @@ static void uvd_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
  * uvd_v6_0_enc_ring_emit_ib - enc execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
- * @job: job to retrive vmid from
+ * @job: job to retrieve vmid from
  * @ib: indirect buffer to execute
  * @flags: unused
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 46222fc30be6..de957bcd7456 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -870,7 +870,7 @@ static int uvd_v7_0_sriov_start(struct amdgpu_device *adev)
 			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_CGC_CTRL),
 							   ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK, 0);
 
-			/* disable interupt */
+			/* disable interrupt */
 			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_MASTINT_EN),
 							   ~UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
@@ -983,7 +983,7 @@ static int uvd_v7_0_start(struct amdgpu_device *adev)
 		WREG32_P(SOC15_REG_OFFSET(UVD, k, mmUVD_CGC_CTRL), 0,
 				~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK);
 
-		/* disable interupt */
+		/* disable interrupt */
 		WREG32_P(SOC15_REG_OFFSET(UVD, k, mmUVD_MASTINT_EN), 0,
 				~UVD_MASTINT_EN__VCPU_EN_MASK);
 
@@ -1347,7 +1347,7 @@ static void uvd_v7_0_ring_emit_ib(struct amdgpu_ring *ring,
  * uvd_v7_0_enc_ring_emit_ib - enc execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
- * @job: job to retrive vmid from
+ * @job: job to retrieve vmid from
  * @ib: indirect buffer to execute
  * @flags: unused
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 93253db5e2de..44654babd179 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -537,7 +537,7 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  * Ensure that the VCPU BO has a 32-bit GPU address,
  * or return an error code when that isn't possible.
  *
- * To accomodate that, we put GART to the LOW address range
+ * To accommodate that, we put GART to the LOW address range
  * and reserve some GART pages where we map the VCPU BO,
  * so that it gets a 32-bit address.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e9d790914761..8729528de23d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -856,7 +856,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable clock gating */
 	vcn_v1_0_disable_clock_gating(vinst);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_MASTINT_EN), 0,
 			~UVD_MASTINT_EN__VCPU_EN_MASK);
 
@@ -1044,7 +1044,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CNTL, tmp, 0xFFFFFFFF, 0);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
 			0, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
@@ -1742,7 +1742,7 @@ static void vcn_v1_0_enc_ring_insert_end(struct amdgpu_ring *ring)
  * vcn_v1_0_enc_ring_emit_ib - enc execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
- * @job: job to retrive vmid from
+ * @job: job to retrieve vmid from
  * @ib: indirect buffer to execute
  * @flags: unused
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0442bfcfd384..b10aaddab01e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -879,7 +879,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
-	/* disable master interupt */
+	/* disable master interrupt */
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
@@ -1740,7 +1740,7 @@ void vcn_v2_0_enc_ring_insert_end(struct amdgpu_ring *ring)
  * vcn_v2_0_enc_ring_emit_ib - enc execute indirect buffer
  *
  * @ring: amdgpu_ring pointer
- * @job: job to retrive vmid from
+ * @job: job to retrieve vmid from
  * @ib: indirect buffer to execute
  * @flags: unused
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0d8a3cea63ee..92a19360ecdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1025,7 +1025,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
-	/* disable master interupt */
+	/* disable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 00d8f35846f2..f5a5fd0edd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1056,7 +1056,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
-	/* disable master interupt */
+	/* disable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c2ddf3cb368f..1bed8a6e901d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1023,7 +1023,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_VCPU_CNTL), tmp, 0, indirect);
 
-	/* disable master interupt */
+	/* disable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_MASTINT_EN), 0, 0, indirect);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 352c27103305..9b64e6437baa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -654,7 +654,7 @@ static bool vi_read_bios_from_rom(struct amdgpu_device *adev,
 	/* set rom index to 0 */
 	WREG32(mmSMC_IND_INDEX_11, ixROM_INDEX);
 	WREG32(mmSMC_IND_DATA_11, 0);
-	/* set index to data for continous read */
+	/* set index to data for continuous read */
 	WREG32(mmSMC_IND_INDEX_11, ixROM_DATA);
 	for (i = 0; i < length_dw; i++)
 		dw_ptr[i] = RREG32(mmSMC_IND_DATA_11);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..4345d87ef20a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3630,7 +3630,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	/*
 	 * Versions of docker shipped in Ubuntu 18.xx and 20.xx do not support
 	 * CAP_CHECKPOINT_RESTORE, so we also allow access if CAP_SYS_ADMIN as CAP_SYS_ADMIN is a
-	 * more priviledged access.
+	 * more privileged access.
 	 */
 	if (unlikely(ioctl->flags & KFD_IOC_FLAG_CHECKPOINT_RESTORE)) {
 		if (!capable(CAP_CHECKPOINT_RESTORE) &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ec483276d753..c497efa65984 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2314,7 +2314,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 /*
  * In this architecture, the association
  * connector -> encoder -> crtc
- * id not really requried. The crtc and connector will hold the
+ * id not really required. The crtc and connector will hold the
  * display_index as an abstraction to use with DAL component
  *
  * Returns 0 on success
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 4c200a9614a7..cb0fb49c78ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -63,7 +63,7 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev);
  *
  * @adev: AMD DRM device
  * @int_params: parameters for the irq
- * @ih: pointer to the irq hander function
+ * @ih: pointer to the irq handler function
  * @handler_args: arguments which will be passed to ih
  *
  * Returns:
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index b5378344d2bc..3cf304d1bb7c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -270,7 +270,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 
 	/*
 	 * since fractional part is only 16 bit in register definition but is 32 bit
-	 * in our fix point definiton, need to shift left by 16 to obtain correct value
+	 * in our fix point definition, need to shift left by 16 to obtain correct value
 	 */
 	pll_req.value |= fbmult_frac_val << 16;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index e40bbc495fc4..11aad6dbca9c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -202,7 +202,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 
 	/*
 	 * since fractional part is only 16 bit in register definition but is 32 bit
-	 * in our fix point definiton, need to shift left by 16 to obtain correct value
+	 * in our fix point definition, need to shift left by 16 to obtain correct value
 	 */
 	pll_req.value |= fbmult_frac_val << 16;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index ff47af3854b6..4b2631eb2837 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -277,7 +277,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 
 	/*
 	 * since fractional part is only 16 bit in register definition but is 32 bit
-	 * in our fix point definiton, need to shift left by 16 to obtain correct value
+	 * in our fix point definition, need to shift left by 16 to obtain correct value
 	 */
 	pll_req.value |= fbmult_frac_val << 16;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 24f6304011ae..a8d59b5ee080 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -356,7 +356,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 
 	/*
 	 * since fractional part is only 16 bit in register definition but is 32 bit
-	 * in our fix point definiton, need to shift left by 16 to obtain correct value
+	 * in our fix point definition, need to shift left by 16 to obtain correct value
 	 */
 	pll_req.value |= fbmult_frac_val << 16;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index a69824e1eb26..db1799ed0443 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -568,7 +568,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 
 	/*
 	 * since fractional part is only 16 bit in register definition but is 32 bit
-	 * in our fix point definiton, need to shift left by 16 to obtain correct value
+	 * in our fix point definition, need to shift left by 16 to obtain correct value
 	 */
 	pll_req.value |= fbmult_frac_val << 16;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7eaaf38cd9ab..3b27ebc62955 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4682,7 +4682,7 @@ enum dc_status dc_validate_with_context(struct dc *dc,
  * @dsc_padding_params: Pointer to the DSC padding parameters structure.
  *
  * This function updated the pix_clk for dsc with padding stored in pipe_ctx
- * such that the OTG h_active time fits withing the expected compressed active
+ * such that the OTG h_active time fits within the expected compressed active
  * time calculated according to HDMI spec. H_total is then increased to
  * maintain the same OTG line time as before the increased pix_clk.
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 705c500ad711..73b7fe92e59a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3027,7 +3027,7 @@ bool dc_link_get_pr_state(const struct dc_link *link, uint64_t *state);
  */
 bool dc_link_wait_for_t12(struct dc_link *link);
 
-/* Determine if dp trace has been initialized to reflect upto date result *
+/* Determine if dp trace has been initialized to reflect up to date result *
  * return - true if trace is initialized and has valid data. False dp trace
  * doesn't have valid result.
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 47fa3d4265e0..043d328c133c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1054,7 +1054,7 @@ static void dc_build_cursor_update_payload0(
 	}
 
 	/* Payload: Cursor Rect is built from position & attribute
-	 * x & y are obtained from postion
+	 * x & y are obtained from position
 	 */
 	payload->cursor_rect.x = hubp->cur_rect.x;
 	payload->cursor_rect.y = hubp->cur_rect.y;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 7da673111ed9..498793a796d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -276,7 +276,7 @@ struct dc_mode_flags {
 enum dc_timing_source {
 	TIMING_SOURCE_UNDEFINED,
 
-	/* explicitly specifed by user, most important*/
+	/* explicitly specified by user, most important*/
 	TIMING_SOURCE_USER_FORCED,
 	TIMING_SOURCE_USER_OVERRIDE,
 	TIMING_SOURCE_CUSTOM,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 17820a4ecd9c..c09040a79495 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -185,7 +185,7 @@ static void check_audio_bandwidth_hdmi(
 
 	/* @todo do it after deep color is implemented
 	 * 8xx - deep color bandwidth scaling
-	 * Extra bandwidth is avaliable in deep color b/c link runs faster than
+	 * Extra bandwidth is available in deep color b/c link runs faster than
 	 * pixel rate. This has the effect of allowing more tmds characters to
 	 * be transmitted during blank
 	 */
@@ -1188,9 +1188,9 @@ void dce_aud_hw_init(
 	if (audio->inst != 0)
 		return;
 
-	/* Suport R5 - 32khz
-	 * Suport R6 - 44.1khz
-	 * Suport R7 - 48khz
+	/* Support R5 - 32khz
+	 * Support R6 - 44.1khz
+	 * Support R7 - 48khz
 	 */
 	/*disable clock gating before write to endpoint register*/
 	value = AZ_REG_READ(AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 25ebd8a52ae4..662205c2ce21 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -390,7 +390,7 @@ static bool dcn10_dmcu_init(struct dmcu *dmcu)
 
 	PERF_TRACE();
 	/*  Definition of DC_DMCU_SCRATCH
-	 *  0 : firmare not loaded
+	 *  0 : firmware not loaded
 	 *  1 : PSP load DMCU FW but not initialized
 	 *  2 : Firmware already initialized
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 8841000361fb..adffac7a4c69 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -229,7 +229,7 @@ bool dce110_link_encoder_validate_output_with_stream(
 
 /****************** HW programming ************************/
 
-/* initialize HW */  /* why do we initialze aux in here? */
+/* initialize HW */  /* why do we initialize aux in here? */
 void dce110_link_encoder_hw_init(struct link_encoder *enc);
 
 void dce110_link_encoder_destroy(struct link_encoder **enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 61d478cfca6d..8f23e812bf3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -357,7 +357,7 @@ static void set_temporal_dither(
  *		1 for 8 bpc
  *		2 for 10 bpc
  *		3 for 12 bpc
- *		7 for programable
+ *		7 for programmable
  *	2) Enable clamp if Limited range requested
  */
 void dce110_opp_set_clamping(
@@ -417,7 +417,7 @@ void dce110_opp_set_clamping(
  *		1 for 8 bpc
  *		2 for 10 bpc
  *		3 for 12 bpc
- *		7 for programable
+ *		7 for programmable
  *	2) Enable clamp if Limited range requested
  */
 static void dce60_opp_set_clamping(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 2c3a20d35fe9..8bac738b6f51 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -475,7 +475,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		h_back_porch = h_blank - hw_crtc_timing.h_front_porch -
 				hw_crtc_timing.h_sync_width;
 
-		/* start at begining of left border */
+		/* start at beginning of left border */
 		h_active_start = hw_crtc_timing.h_sync_width + h_back_porch;
 
 
@@ -484,7 +484,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				hw_crtc_timing.v_front_porch;
 
 
-		/* start at begining of left border */
+		/* start at beginning of left border */
 		if (REG(DP_MSA_TIMING_PARAM2))
 			REG_SET_2(DP_MSA_TIMING_PARAM2, 0,
 				DP_MSA_HSTART, h_active_start,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index b015b27cd1c6..ac0a542997f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -2070,7 +2070,7 @@ void dce110_tg_set_colors(struct timing_generator *tg,
 }
 
 /* Gets first line of blank region of the display timing for CRTC
- * and programms is as a trigger to fire vertical interrupt
+ * and programs is as a trigger to fire vertical interrupt
  */
 bool dce110_arm_vert_intr(struct timing_generator *tg, uint8_t width)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
index 5bc3bc60a2ac..ebbe7900205e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
@@ -46,7 +46,7 @@ static void dcn20_wait_for_vmid_ready(struct dcn20_vmid *vmid)
 	/* According the hardware spec, we need to poll for the lowest
 	 * bit of PAGE_TABLE_BASE_ADDR_LO32 = 1 any time a GPUVM
 	 * context is updated. We can't use REG_WAIT here since we
-	 * don't have a seperate field to wait on.
+	 * don't have a separate field to wait on.
 	 *
 	 * TODO: Confirm timeout / poll interval with hardware team
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
index a99879c58027..479161d19619 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
@@ -584,7 +584,7 @@ bool dcn10_link_encoder_validate_output_with_stream(
 
 /****************** HW programming ************************/
 
-/* initialize HW */  /* why do we initialze aux in here? */
+/* initialize HW */  /* why do we initialize aux in here? */
 void dcn10_link_encoder_hw_init(struct link_encoder *enc);
 
 void dcn10_link_encoder_destroy(struct link_encoder **enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 2ad4a2635683..e5b21bc5a018 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -342,7 +342,7 @@ static void pipe_ctx_to_e2e_pipe_params (
 	input->src.viewport_height     = pipe->plane_res.scl_data.viewport.height;
 	input->src.data_pitch          = pipe->plane_res.scl_data.viewport.width;
 	input->src.data_pitch_c        = pipe->plane_res.scl_data.viewport.width;
-	input->src.cur0_src_width      = 128; /* TODO: Cursor calcs, not curently stored */
+	input->src.cur0_src_width      = 128; /* TODO: Cursor calcs, not currently stored */
 	input->src.cur0_bpp            = 32;
 
 	input->src.macro_tile_size = swizzle_mode_to_macro_tile_size(pipe->plane_state->tiling_info.gfx9.swizzle);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 33b5136f7ce3..75bdad22bf69 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1805,7 +1805,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	v->DISPCLKWithRamping = 0;
 	v->DISPCLKWithoutRamping = 0;
 	v->GlobalDPPCLK = 0.0;
-	/* DAL custom code: need to update ReturnBW in case min dcfclk is overriden */
+	/* DAL custom code: need to update ReturnBW in case min dcfclk is overridden */
 	v->IdealSDPPortBandwidthPerState[v->VoltageLevel][v->maxMpcComb] = dml_min3(
 			v->ReturnBusWidth * v->DCFCLK,
 			v->DRAMSpeedPerState[v->VoltageLevel] * v->NumberOfChannels * v->DRAMChannelWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 8064c4b3fd25..8c872d4cf537 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -50,7 +50,7 @@
 // For DML-C changes that hasn't been propagated to VBA yet
 //#define __DML_VBA_ALLOW_DELTA__
 
-// Move these to ip paramaters/constant
+// Move these to ip parameters/constant
 
 // At which vstartup the DML start to try if the mode can be supported
 #define __DML_VBA_MIN_VSTARTUP__    9
@@ -2045,7 +2045,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	v->DISPCLKWithRamping = 0;
 	v->DISPCLKWithoutRamping = 0;
 	v->GlobalDPPCLK = 0.0;
-	/* DAL custom code: need to update ReturnBW in case min dcfclk is overriden */
+	/* DAL custom code: need to update ReturnBW in case min dcfclk is overridden */
 	{
 	double IdealFabricAndSDPPortBandwidthPerState = dml_min(
 			v->ReturnBusWidth * v->DCFCLKState[v->VoltageLevel][v->maxMpcComb],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b5bd1358fdfd..88f08ad69621 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1076,7 +1076,7 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 		// Static schedulability check for SubVP + SubVP case
 		schedulable = subvp_subvp_admissable(dc, context) && subvp_subvp_schedulable(dc, context);
 	} else if (subvp_count == 1 && non_subvp_pipes == 0) {
-		// Single SubVP configs will be supported by default as long as it's suppported by DML
+		// Single SubVP configs will be supported by default as long as it's supported by DML
 		schedulable = true;
 	} else if (subvp_count == 1 && non_subvp_pipes == 1) {
 		if (dcn32_subvp_drr_admissable(dc, context))
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h
index 5b40dcdc4406..be32f2a8d104 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h
@@ -519,7 +519,7 @@ struct SOCParametersList {
 	dml_float_t SMNLatency;
 };
 
-/// @brief Struct that represent Plane configration of a display cfg
+/// @brief Struct that represent Plane configuration of a display cfg
 struct dml_plane_cfg_st {
 	//
 	// Pipe/Surface Parameters
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 1b0d55e2d7b0..1c9a3fe0f64c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -977,7 +977,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 
 void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state *context)
 {
-	/* TODO these should be the max of active, svp prefetch and idle should be tracked seperately */
+	/* TODO these should be the max of active, svp prefetch and idle should be tracked separately */
 	context->bw_ctx.bw.dcn.clk.dispclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dispclk_khz;
 	context->bw_ctx.bw.dcn.clk.dcfclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.dcfclk_khz;
 	context->bw_ctx.bw.dcn.clk.dramclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.uclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
index c4813c51251b..e950a57cf6a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
@@ -54,7 +54,7 @@ struct dc_mcache_params {
 	unsigned int num_mcaches_plane1;
 	/*
 	* Generally, plane0/1 slices must use a disjoint set of caches
-	* but in some cases the final segement of the two planes can
+	* but in some cases the final segment of the two planes can
 	* use the same cache. If plane0_plane1 is set, then this is
 	* allowed.
 	*
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index bf71f4e1a451..e420bd7d5712 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -187,7 +187,7 @@ struct dml2_mcache_surface_allocation {
 
 	/*
 	* Generally, plane0/1 slices must use a disjoint set of caches
-	* but in some cases the final segement of the two planes can
+	* but in some cases the final segment of the two planes can
 	* use the same cache. If plane0_plane1 is set, then this is
 	* allowed.
 	*
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 72acf12e9251..802d060a03ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -1495,7 +1495,7 @@ static unsigned int dscceComputeDelay(
 		cycles_per_group = 6;
 	else
 		cycles_per_group = 3;
-	//delay of the bit stream contruction layer in pixels is the sum of:
+	//delay of the bit stream construction layer in pixels is the sum of:
 	//1. number of pixel containers in a slice line multipled by the number of lines required to reach initial transmit delay multipled by number of slices to the left of the last horizontal slice
 	//2. number of pixel containers required to reach initial transmit delay (specifically, in the last horizontal slice)
 	//3. additional group of delay if initial transmit delay is reached exactly in a group
@@ -1757,7 +1757,7 @@ static unsigned int CalculateVMAndRowBytes(struct dml2_core_shared_calculate_vm_
 		*p->vmpg_height = *p->PixelPTEReqHeight;
 		*p->vmpg_width = *p->PixelPTEReqWidth;
 	} else {
-		// default for rest of calculation to go through, when vm is disable, the calulated pte related values shouldnt be used anyways
+		// default for rest of calculation to go through, when vm is disable, the calulated pte related values shouldn't be used anyways
 		*p->PixelPTEReqHeight = p->MacroTileHeight;
 		*p->PixelPTEReqWidth = 8 * 1024 * p->GPUVMMinPageSizeKBytes / (p->MacroTileHeight * p->BytePerPixel);
 		*p->PTERequestSize = 64;
@@ -2827,7 +2827,7 @@ static noinline_for_stack void calculate_bandwidth_available(
 	DML_LOG_VERBOSE("DML::%s: fclk_mhz = %f\n", __func__, fclk_mhz);
 	DML_LOG_VERBOSE("DML::%s: dram_bw_mbps = %f\n", __func__, dram_bw_mbps);
 
-	// Calculate all the bandwidth availabe
+	// Calculate all the bandwidth available
 	for (m = 0; m < dml2_core_internal_soc_state_max; m++) {
 		for (n = 0; n < dml2_core_internal_bw_max; n++) {
 			avg_bandwidth_available[m][n] = dml_get_return_bandwidth_available(soc,
@@ -3199,7 +3199,7 @@ static void CalculateVMRowAndSwath(struct dml2_core_internal_scratch *scratch,
 		p->dpte_row_bytes_per_row_l[k] = s->PixelPTEBytesPerRowY[k];
 		p->dpte_row_bytes_per_row_c[k] = s->PixelPTEBytesPerRowC[k];
 
-		// if one row of dPTEs is meant to span the entire frame, then for these calculations, we will pretend like that one big row is fetched in two halfs
+		// if one row of dPTEs is meant to span the entire frame, then for these calculations, we will pretend like that one big row is fetched in two halves
 		if (p->use_one_row_for_frame[k])
 			p->PixelPTEBytesPerRow[k] = p->PixelPTEBytesPerRow[k] / 2;
 
@@ -11030,7 +11030,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			s->num_active_planes);
 	}
 
-	// Calculate all the bandwidth availabe
+	// Calculate all the bandwidth available
 	calculate_bandwidth_available(
 		mode_lib->mp.avg_bandwidth_available_min,
 		mode_lib->mp.avg_bandwidth_available,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 38ccf9dab31f..fea336d3953d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -1222,7 +1222,7 @@ unsigned int dcn5_calculate_vm_and_row_bytes(struct dml2_core_shared_calculate_v
 		*p->vmpg_height = *p->PixelPTEReqHeight;
 		*p->vmpg_width = *p->PixelPTEReqWidth;
 	} else {
-		// default for rest of calculation to go through, when vm is disable, the calulated pte related values shouldnt be used anyways
+		// default for rest of calculation to go through, when vm is disable, the calulated pte related values shouldn't be used anyways
 		*p->PixelPTEReqHeight = p->MacroTileHeight;
 		*p->PixelPTEReqWidth = 8 * 1024 * p->GPUVMMinPageSizeKBytes / (p->MacroTileHeight * p->BytePerPixel);
 		*p->PTERequestSize = 64;
@@ -1586,7 +1586,7 @@ void dcn5_calculate_vm_row_and_swath(struct dml2_core_internal_scratch *scratch,
 		p->dpte_row_bytes_per_row_l[k] = s->PixelPTEBytesPerRowY[k];
 		p->dpte_row_bytes_per_row_c[k] = s->PixelPTEBytesPerRowC[k];
 
-		// if one row of dPTEs is meant to span the entire frame, then for these calculations, we will pretend like that one big row is fetched in two halfs
+		// if one row of dPTEs is meant to span the entire frame, then for these calculations, we will pretend like that one big row is fetched in two halves
 		if (p->use_one_row_for_frame[k])
 			p->PixelPTEBytesPerRow[k] = p->PixelPTEBytesPerRow[k] / 2;
 
@@ -3079,7 +3079,7 @@ bool dcn5_calculate_prefetch_schedule(struct dml2_core_internal_scratch *scratch
 	// Tpre_rounded is Tpre rounding to 2-bit fraction
 	// Tvm_trips_rounded is Tvm_trips ceiling to 1/4 line time
 	// Tr0_trips_rounded is Tr0_trips ceiling to 1/4 line time
-	// So that means prefetch bw calculated can be higher since the total time availabe for prefetch is less
+	// So that means prefetch bw calculated can be higher since the total time available for prefetch is less
 	bool min_Lsw_equ_ok = *p->Tpre_rounded >= s->Tvm_trips_rounded + 2.0*s->Tr0_trips_rounded + s->min_Lsw_equ*s->LineTime;
 
 	if (s->dst_y_prefetch_equ > 1 && min_Lsw_equ_ok) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
index d4201b019850..84eac364222f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
@@ -162,7 +162,7 @@ static void dscc_bcl_compute_delay(latency_t *p, int bpc, float bpp, int slice_w
 	//number of syntax elements per group is 4 in N422 or 3 in all other pixel formats
 	syntax_elements_per_group = (pixel_format == dml2_n422) ? 4 : 3;
 
-	//delay of the bit stream contruction layer in pixels is the sum of:
+	//delay of the bit stream construction layer in pixels is the sum of:
 	//1. number of pixel containers in a slice line multiplied by the number of lines required to reach initial transmit delay multiplied by number of slices to the left of the last horizontal slice
 	group_delay  = (lines_to_reach_ixd_adjusted * slice_width_groups * (num_slices - 1));
 
@@ -302,7 +302,7 @@ static delay_uncertainty_t legacy_dsc_compute_output_pixel_delay(enum dml2_outpu
 	  if (pixel_format == dml2_420 || pixel_format == dml2_n422) {
 		delay += 2;
 	  }
-	} else { //greater than 1 slice configration has two slice streams, 6 cycles to accumulate 2 groups
+	} else { //greater than 1 slice configuration has two slice streams, 6 cycles to accumulate 2 groups
 	//no need to multiply by pixels per container as first half of first slice line is output faster by dscc_if as
 	//the second slice stream has no started yet so we do not need to wait for those pixels to appear at the input
 	  delay += 6;
@@ -373,7 +373,7 @@ static delay_uncertainty_t dsc_compute_output_pixel_delay(enum dml2_output_forma
 	  if (pixel_format == dml2_420 || pixel_format == dml2_n422) {
 		delay += 2;
 	  }
-	} else { //greater than 1 slice configration has two slice streams, 6 cycles to accumulate 2 groups
+	} else { //greater than 1 slice configuration has two slice streams, 6 cycles to accumulate 2 groups
 	//no need to multiply by pixels per container as first half of first slice line is output faster by dscc_if as
 	//the second slice stream has no started yet so we do not need to wait for those pixels to appear at the input
 	  //it takes 12 cycles for 6 pairs to arrive
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
index eab13e1c96fd..9c910ed4bc1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
@@ -66,7 +66,7 @@ static bool build_min_clk_table_fine_grained(const struct dml2_soc_bb *soc_bb, s
 	}
 	min_table->dram_bw_table.num_entries = soc_bb->clk_table.uclk.num_clk_values;
 
-	// To create the minium table, effectively shift "up" all the dcfclk/fclk entries by 1, and then replace the lowest entry with min fclk/dcfclk
+	// To create the minimum table, effectively shift "up" all the dcfclk/fclk entries by 1, and then replace the lowest entry with min fclk/dcfclk
 	for (i = min_table->dram_bw_table.num_entries - 1; i > 0; i--) {
 		prev_100 = min_table->dram_bw_table.entries[i - 1].min_fclk_khz;
 		cur_50 = min_table->dram_bw_table.entries[i].min_fclk_khz / 2;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
index 53ead9f687ac..42af0cbf9516 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
@@ -981,7 +981,7 @@ static void populate_lsdma(
 		out->width[1][pipe_idx]  = out->width[0][pipe_idx];
 		out->height[1][pipe_idx] = end_line_next - out->src_y[1][pipe_idx];
 
-		/* Note: If odd_req_width == true (not divisable by 256), then dst_pitch must be rounded up such that
+		/* Note: If odd_req_width == true (not divisible by 256), then dst_pitch must be rounded up such that
 		the total bytes (pitch * bytes_per_element) is divisible by 128 but not 256.
 		Otherwise it must be rounded up such that it is divisible by 256.
 		If out.dst_pitch already meets this requirement on assigning out.dst_pitch = out.width[0],
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
index e6c49c27035c..02fe05e9dfbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
@@ -666,7 +666,7 @@ void dml2_top_mcache_assign_global_mcache_ids(struct top_mcache_assign_global_mc
 			params->allocations[i].global_mcache_ids_plane1[j] = next_unused_cache_id++;
 		}
 
-		// The "psuedo-last" slice is always wrapped around
+		// The "pseudo-last" slice is always wrapped around
 		params->allocations[i].global_mcache_ids_plane0[params->allocations[i].num_mcaches_plane0] =
 			params->allocations[i].global_mcache_ids_plane0[0];
 		params->allocations[i].global_mcache_ids_plane1[params->allocations[i].num_mcaches_plane1] =
@@ -681,7 +681,7 @@ void dml2_top_mcache_assign_global_mcache_ids(struct top_mcache_assign_global_mc
 				params->allocations[i].global_mcache_ids_mall_plane1[j] = next_unused_cache_id++;
 			}
 
-			// The "psuedo-last" slice is always wrapped around
+			// The "pseudo-last" slice is always wrapped around
 			params->allocations[i].global_mcache_ids_mall_plane0[params->allocations[i].num_mcaches_plane0] =
 				params->allocations[i].global_mcache_ids_mall_plane0[0];
 			params->allocations[i].global_mcache_ids_mall_plane1[params->allocations[i].num_mcaches_plane1] =
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
index ab9cadaf5a60..dbec14dba39c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
@@ -76,7 +76,7 @@ static enum dml2_status dml2_top_perform_stage_optimization(struct dml2_instance
 	 * means the stage optimizer no longer needs to attempt further optimization. The current worksheet should be
 	 * left unmodified. When the interface returns true, it means the stage optimizer applied new optimization to
 	 * the worksheet. DML top will need to validate and test permissibility again. The worksheet passed in is based
-	 * off the optimization decision from last attempt. It may or may not be validated or permissible. It is upto
+	 * off the optimization decision from last attempt. It may or may not be validated or permissible. It is up to
 	 * DML top to keep track of the last valid permissible worksheet. This interface is also responsible to clear
 	 * corresponding valid bits in worksheet's validation result based on what optimization it gets applied. When
 	 * the valid bits are cleared, it will be revalidated by top. Otherwise, DML top will assume it is safe to skip
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index a18f067fe53f..07e4fb7cfa13 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -725,7 +725,7 @@ struct dml2_pmo_stage_optimizer {
 	 * means the stage optimizer no longer needs to attempt further optimization. The current worksheet should be
 	 * left unmodified. When the interface returns true, it means the stage optimizer applied new optimization to
 	 * the worksheet. DML top will need to validate and test permissibility again. The worksheet passed in is based
-	 * off the optimization decision from last attempt. It may or may not be validated or permissible. It is upto
+	 * off the optimization decision from last attempt. It may or may not be validated or permissible. It is up to
 	 * DML top to keep track of the last valid permissible worksheet. This interface is also responsible to clear
 	 * corresponding valid bits in worksheet's validation result based on what optimization it gets applied. When
 	 * the valid bits are cleared, it will be revalidated by top. Otherwise, DML top will assume it is safe to skip
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index 4543a60a0683..93b409290dff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -815,7 +815,7 @@ static void add_phantom_pipes_for_main_pipe(struct dml2_context *ctx, struct dc_
 	struct dc_stream_state *phantom_stream = NULL;
 	unsigned int i;
 
-	// The index of the DC pipe passed into this function is guarenteed to
+	// The index of the DC pipe passed into this function is guaranteed to
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = enable_phantom_stream(ctx, state, main_pipe_idx, svp_height, vstartup);
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
index 5feebb3b95ca..bee7f283c383 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
@@ -223,7 +223,7 @@ static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
 }
 
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = dal_hw_generic_init,
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
index 985f10b39750..14492bce4410 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
@@ -235,7 +235,7 @@ static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
 }
 
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = dal_hw_generic_init,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index a2e0bafb711a..367284dedcda 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -818,7 +818,7 @@ void hubp401_cursor_set_position(
 	uint32_t x_hotspot_clamped = pos->x_hotspot;
 	hubp->curs_pos = *pos;
 	/* Recout is zero for pipes if the entire dst_rect is contained
-	 * within preceeding ODM slices.
+	 * within preceding ODM slices.
 	 */
 	if (param->recout.width) {
 		x_pos_viewport = pos->x * param->viewport.width / param->recout.width;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index d863f4bdccad..32ff8763facf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -820,7 +820,7 @@ struct mpc_funcs {
 	*
 	* Return:
 	*
-	* bool - wheter DWB is idle or not
+	* bool - whether DWB is idle or not
 	*/
 	bool (*is_dwb_idle)(
 		struct mpc *mpc,
@@ -878,7 +878,7 @@ struct mpc_funcs {
 	* - [in] params - curve parameters for the LUT configuration
 	* - [in] rmu_idx
 	*
-	* bool - wheter LUT was set (set with given parameters) or not (params is NULL and LUT is disabled).
+	* bool - whether LUT was set (set with given parameters) or not (params is NULL and LUT is disabled).
 	*/
 	bool (*program_1dlut)(
 			struct mpc *mpc,
@@ -897,7 +897,7 @@ struct mpc_funcs {
 	*
 	* Return:
 	*
-	* bool - wheter shaper was set (set with given parameters) or not (params is NULL and LUT is disabled).
+	* bool - whether shaper was set (set with given parameters) or not (params is NULL and LUT is disabled).
 	*/
 	bool (*program_shaper)(
 			struct mpc *mpc,
@@ -930,7 +930,7 @@ struct mpc_funcs {
 	* - [in] params - tetrahedral parameters for the LUT configuration
 	* - [in] rmu_idx
 	*
-	* bool - wheter LUT was set (set with given parameters) or not (params is NULL and LUT is disabled).
+	* bool - whether LUT was set (set with given parameters) or not (params is NULL and LUT is disabled).
 	*/
 	bool (*program_3dlut)(
 			struct mpc *mpc,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 24e3bbec15ff..61146328db91 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -580,7 +580,7 @@ static enum dc_link_rate increase_link_rate(struct dc_link *link,
 	case LINK_RATE_HIGH3:
 		return LINK_RATE_UHBR10;
 	case LINK_RATE_UHBR10:
-		/* upto DP2.x specs UHBR13.5 is the only link rate that could be
+		/* up to DP2.x specs UHBR13.5 is the only link rate that could be
 		 * not supported by DPRX when higher link rate is supported.
 		 * so we treat it as a special case for code simplicity. When we
 		 * have new specs with more link rates like this, we should
@@ -642,7 +642,7 @@ static bool decide_fallback_link_setting_max_bw_policy(
 			next_idx++;
 		else if (dp_lt_fallbacks[next_idx].link_rate == LINK_RATE_UHBR13_5 &&
 				link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR13_5 == 0)
-			/* upto DP2.x specs UHBR13.5 is the only link rate that
+			/* up to DP2.x specs UHBR13.5 is the only link rate that
 			 * could be not supported by DPRX when higher link rate
 			 * is supported. so we treat it as a special case for
 			 * code simplicity. When we have new specs with more
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 16951a9550f2..d3fe6e024891 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -108,7 +108,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 			/* alternate scrambler reset is required for Travis
 			 * for the case when external chip does not
 			 * provide sink device id, alternate scrambler
-			 * scheme will  be overriden later by querying
+			 * scheme will  be overridden later by querying
 			 * Encoder features
 			 */
 			if (strncmp(
@@ -124,7 +124,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 			/* alternate scrambler reset is required for NUTMEG
 			 * for the case when external chip does not provide
 			 * sink device id, alternate scrambler scheme will
-			 * be overriden later by querying Encoder feature
+			 * be overridden later by querying Encoder feature
 			 */
 			if (strncmp(link->dpcd_caps.branch_dev_name,
 				DP_VGA_LVDS_CONVERTER_ID_3,
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
index 98335a53ca52..bd24a6bdae66 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
@@ -200,7 +200,7 @@ static void opp1_set_pixel_encoding(
  *		1 for 8 bpc
  *		2 for 10 bpc
  *		3 for 12 bpc
- *		7 for programable
+ *		7 for programmable
  *	2) Enable clamp if Limited range requested
  *
  * @oppn10: output_pixel_processor struct instance for dcn10.
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 5fcdd74eb4a0..ea3758ed1000 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -33,7 +33,7 @@
  * current OPTC by setting the bit with offset associated with the desired
  * memory instance to 1 in the current OPTC memory map register.
  *
- * It is upto software to decide how to allocate the shared memory resources
+ * It is up to software to decide how to allocate the shared memory resources
  * across different OPTC instances. Driver understands that the total number
  * of memory available is always 2 times the max number of OPP pipes. So each
  * OPP pipe can be mapped 2 pieces of memory. However there exists cases such as
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 996fce26941f..309bfc780b2e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -741,7 +741,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
 		.performance_trace = false,
-		.max_downscale_src_width = 5120,/*upto 5K*/
+		.max_downscale_src_width = 5120,/*up to 5K*/
 		.disable_pplib_wm_range = false,
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index dbb8bb7fc20d..db4a5be39d31 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -763,7 +763,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 7680,/*up to 8K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 29113f518c53..1d4b64a8016e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -696,7 +696,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 88dcf8166378..00252bdba6e7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -94,7 +94,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
 		.performance_trace = false,
-		.max_downscale_src_width = 7680,/*upto 8K*/
+		.max_downscale_src_width = 7680,/*up to 8K*/
 		.disable_pplib_wm_range = false,
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 50b7c7b85fac..934c9dd83b18 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -94,7 +94,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
 		.performance_trace = false,
-		.max_downscale_src_width = 7680,/*upto 8K*/
+		.max_downscale_src_width = 7680,/*up to 8K*/
 		.disable_pplib_wm_range = false,
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index db56e30cf259..795792be6da9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -925,7 +925,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4K*/
+	.max_downscale_src_width = 4096,/*up to true 4K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 63f92e9da6d8..fd4cb5b11ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -945,7 +945,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 15c1615c5f45..647a9d2b2544 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -925,7 +925,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
@@ -1911,7 +1911,7 @@ static int dcn315_populate_dml_pipes_from_context(
 			if (!pipe->stream)
 				continue;
 
-			/* Do not use asymetric crb if not enough for pstate support */
+			/* Do not use asymmetric crb if not enough for pstate support */
 			if (remaining_det_segs < 0) {
 				pipes[pipe_cnt].pipe.src.det_size_override = 0;
 				pipe_cnt++;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index a5ea35e45791..413733f37643 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -920,7 +920,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 7c2a79015f4e..6d8adef2c707 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -755,7 +755,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 7680,/*up to 8K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
@@ -1887,7 +1887,7 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
 	struct dc_stream_state *phantom_stream = NULL;
 	unsigned int i;
 
-	// The index of the DC pipe passed into this function is guarenteed to
+	// The index of the DC pipe passed into this function is guaranteed to
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = dcn32_enable_phantom_stream(dc, context, pipes, pipe_cnt, index);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 5ee9a5a8ec3c..93dae069a4bf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -745,7 +745,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 7680,/*up to 8K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 52826e96c184..7550ea2f45f9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -777,7 +777,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e3fc71307c91..6a1b54586bb5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -757,7 +757,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index c019a657005d..ee369a716663 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -764,7 +764,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 4096,/*upto true 4k*/
+	.max_downscale_src_width = 4096,/*up to true 4k*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index aced8ff657bf..cf3a326d8fce 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -758,7 +758,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 7680,/*up to 8K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 4b7668abf4dc..f7c8bc884fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -626,7 +626,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 7680,/*upto 8K*/
+	.max_downscale_src_width = 7680,/*up to 8K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
@@ -751,7 +751,7 @@ static void assign_global_mcache_ids(struct dc_state *context, const struct dc_m
 			mcache_allocations[plane_idx].global_mcache_ids_plane1[i] = next_unused_cache_id++;
 		}
 
-		// The "psuedo-last" slice is always wrapped around
+		// The "pseudo-last" slice is always wrapped around
 		mcache_allocations[plane_idx].global_mcache_ids_plane0[mcache_params[plane_idx].num_mcaches_plane0] =
 			mcache_allocations[plane_idx].global_mcache_ids_plane0[0];
 		mcache_allocations[plane_idx].global_mcache_ids_plane1[mcache_params[plane_idx].num_mcaches_plane1] =
@@ -766,7 +766,7 @@ static void assign_global_mcache_ids(struct dc_state *context, const struct dc_m
 				mcache_allocations[plane_idx].global_mcache_ids_mall_plane1[i] = next_unused_cache_id++;
 			}
 
-			// The "psuedo-last" slice is always wrapped around
+			// The "pseudo-last" slice is always wrapped around
 			mcache_allocations[plane_idx].global_mcache_ids_mall_plane0[mcache_params[plane_idx].num_mcaches_plane0] =
 				mcache_allocations[plane_idx].global_mcache_ids_mall_plane0[0];
 			mcache_allocations[plane_idx].global_mcache_ids_mall_plane1[mcache_params[plane_idx].num_mcaches_plane1] =
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 204375f1eff8..62e02b2538d4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -584,7 +584,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		return false;
 	}
 
-	/* set default inbox type if not overriden */
+	/* set default inbox type if not overridden */
 	if (dmub->inbox_type == DMUB_CMD_INTERFACE_DEFAULT) {
 		if (default_inbox_type != DMUB_CMD_INTERFACE_DEFAULT) {
 			/* use default inbox type as specified by DCN rev */
@@ -882,7 +882,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	cw4.region.top = cw4.region.base + mail_fb->size;
 
 	/**
-	 * Doubled the mailbox region to accomodate inbox and outbox.
+	 * Doubled the mailbox region to accommodate inbox and outbox.
 	 * Note: Currently, currently total mailbox size is 16KB. It is split
 	 * equally into 8KB between inbox and outbox. If this config is
 	 * changed, then uncached base address configuration of outbox1
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index 3e4e8d55dd0f..18ab9582554c 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -214,7 +214,7 @@ struct spread_spectrum_info {
 
 	union {
 		struct step_and_delay_info step_and_delay_info;
-		/* For mem/engine/uvd, Clock Out frequence (VCO ),
+		/* For mem/engine/uvd, Clock Out frequency (VCO ),
 		in unit of kHz. For TMDS/HDMI/LVDS, it is pixel clock,
 		for DP, it is link clock ( 270000 or 162000 ) */
 		uint32_t target_clock_range; /* in KHz */
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index b344acefc606..0ce01fdf7192 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -2199,12 +2199,12 @@ typedef struct _GET_ENGINE_CLOCK_PARAMETERS
 /****************************************************************************/
 // Following Structures and constant may be obsolete
 /****************************************************************************/
-//Maxium 8 bytes,the data read in will be placed in the parameter space.
-//Read operaion successeful when the paramter space is non-zero, otherwise read operation failed
+//Maximum 8 bytes,the data read in will be placed in the parameter space.
+//Read operaion successeful when the parameter space is non-zero, otherwise read operation failed
 typedef struct _READ_EDID_FROM_HW_I2C_DATA_PARAMETERS
 {
   USHORT    usPrescale;         //Ratio between Engine clock and I2C clock
-  USHORT    usVRAMAddress;      //Adress in Frame Buffer where to pace raw EDID
+  USHORT    usVRAMAddress;      //Address in Frame Buffer where to pace raw EDID
   USHORT    usStatus;           //When use output: lower byte EDID checksum, high byte hardware status
                                 //WHen use input:  lower byte as 'byte to read':currently limited to 128byte or 1byte
   UCHAR     ucSlaveAddr;        //Read from which slave
@@ -2420,7 +2420,7 @@ typedef struct _LVDS_ENCODER_CONTROL_PARAMETERS
 typedef struct _LVDS_ENCODER_CONTROL_PARAMETERS_V2
 {
   USHORT usPixelClock;  // in 10KHz; for bios convenient
-  UCHAR  ucMisc;        // see PANEL_ENCODER_MISC_xx defintions below
+  UCHAR  ucMisc;        // see PANEL_ENCODER_MISC_xx definitions below
   UCHAR  ucAction;      // 0: turn off encoder
                         // 1: setup and turn on encoder
   UCHAR  ucTruncate;    // bit0=0: Disable truncate
@@ -2645,10 +2645,10 @@ typedef struct   _SET_VOLTAGE_PARAMETERS_V1_3
 #define ATOM_INIT_VOLTAGE_REGULATOR          3        //Init Regulator
 #define ATOM_SET_VOLTAGE_PHASE               4        //Set Vregulator Phase, only for SVID/PVID regulator
 #define ATOM_GET_MAX_VOLTAGE                 6        //Get Max Voltage, not used from SetVoltageTable v1.3
-#define ATOM_GET_VOLTAGE_LEVEL               6        //Get Voltage level from vitual voltage ID, not used for SetVoltage v1.4
+#define ATOM_GET_VOLTAGE_LEVEL               6        //Get Voltage level from virtual voltage ID, not used for SetVoltage v1.4
 #define ATOM_GET_LEAKAGE_ID                  8        //Get Leakage Voltage Id ( starting from SMU7x IP ), SetVoltage v1.4
 
-// define vitual voltage id in usVoltageLevel
+// define virtual voltage id in usVoltageLevel
 #define ATOM_VIRTUAL_VOLTAGE_ID0             0xff01
 #define ATOM_VIRTUAL_VOLTAGE_ID1             0xff02
 #define ATOM_VIRTUAL_VOLTAGE_ID2             0xff03
@@ -2815,7 +2815,7 @@ typedef struct _ATOM_MASTER_LIST_OF_DATA_TABLES
   USHORT        IntegratedSystemInfo;     // Shared by various SW components
   USHORT        ASIC_ProfilingInfo;       // New table name from R600, used to be called "ASIC_VDDCI_Info" for pre-R600
   USHORT        VoltageObjectInfo;        // Shared by various SW components, latest version 1.1
-  USHORT        PowerSourceInfo;          // Shared by various SW components, latest versoin 1.1
+  USHORT        PowerSourceInfo;          // Shared by various SW components, latest version 1.1
   USHORT        ServiceInfo;
 }ATOM_MASTER_LIST_OF_DATA_TABLES;
 
@@ -4090,7 +4090,7 @@ typedef struct  _ATOM_LCD_RTS_RECORD
   UCHAR     ucRTSValue;
 }ATOM_LCD_RTS_RECORD;
 
-//!! If the record below exits, it shoud always be the first record for easy use in command table!!!
+//!! If the record below exits, it should always be the first record for easy use in command table!!!
 // The record below is only used when LVDS_Info is present. From ATOM_LVDS_INFO_V12, use ucLCDPanel_SpecialHandlingCap instead.
 typedef struct  _ATOM_LCD_MODE_CONTROL_CAP
 {
@@ -4168,7 +4168,7 @@ typedef struct _ATOM_SPREAD_SPECTRUM_INFO
 /****************************************************************************/
 // Structure used in AnalogTV_InfoTable (Top level)
 /****************************************************************************/
-//ucTVBootUpDefaultStd definiton:
+//ucTVBootUpDefaultStd definition:
 
 //ATOM_TV_NTSC                1
 //ATOM_TV_NTSCJ               2
@@ -4213,7 +4213,7 @@ typedef struct _ATOM_DPCD_INFO
 #define ATOM_DPCD_MAX_LANE_MASK    0x1F
 
 /**************************************************************************/
-// VRAM usage and their defintions
+// VRAM usage and their definitions
 
 // One chunk of VRAM used by Bios are for HWICON surfaces,EDID data.
 // Current Mode timing and Dail Timing and/or STD timing data EACH device. They can be broken down as below.
@@ -5115,7 +5115,7 @@ typedef struct _ATOM_VOLTAGE_OBJECT_HEADER_V3{
 
 // ATOM_VOLTAGE_OBJECT_HEADER_V3.ucVoltageMode
 #define VOLTAGE_OBJ_GPIO_LUT                 0        //VOLTAGE and GPIO Lookup table ->ATOM_GPIO_VOLTAGE_OBJECT_V3
-#define VOLTAGE_OBJ_VR_I2C_INIT_SEQ          3        //VOLTAGE REGULATOR INIT sequece through I2C -> ATOM_I2C_VOLTAGE_OBJECT_V3
+#define VOLTAGE_OBJ_VR_I2C_INIT_SEQ          3        //VOLTAGE REGULATOR INIT sequence through I2C -> ATOM_I2C_VOLTAGE_OBJECT_V3
 #define VOLTAGE_OBJ_PHASE_LUT                4        //Set Vregulator Phase lookup table ->ATOM_GPIO_VOLTAGE_OBJECT_V3
 #define VOLTAGE_OBJ_SVID2                    7        //Indicate voltage control by SVID2 ->ATOM_SVID2_VOLTAGE_OBJECT_V3
 #define VOLTAGE_OBJ_EVV                      8
@@ -5157,7 +5157,7 @@ typedef struct  _ATOM_GPIO_VOLTAGE_OBJECT_V3
 {
    ATOM_VOLTAGE_OBJECT_HEADER_V3 sHeader;    // voltage mode = VOLTAGE_OBJ_GPIO_LUT or VOLTAGE_OBJ_PHASE_LUT
    UCHAR  ucVoltageGpioCntlId;               // default is 0 which indicate control through CG VID mode
-   UCHAR  ucGpioEntryNum;                    // indiate the entry numbers of Votlage/Gpio value Look up table
+   UCHAR  ucGpioEntryNum;                    // indicate the entry numbers of Votlage/Gpio value Look up table
    UCHAR  ucPhaseDelay;                      // phase delay in unit of micro second
    UCHAR  ucReserved;
    ULONG  ulGpioMaskVal;                     // GPIO Mask value
@@ -5871,7 +5871,7 @@ ucUMAChannelNumber:                 System memory channel numbers.
 ulCSR_M3_ARB_CNTL_DEFAULT[10]:    Arrays with values for CSR M3 arbiter for default
 ulCSR_M3_ARB_CNTL_UVD[10]:        Arrays with values for CSR M3 arbiter for UVD playback.
 ulCSR_M3_ARB_CNTL_FS3D[10]:       Arrays with values for CSR M3 arbiter for Full Screen 3D applications.
-sAvail_SCLK[5]:                   Arrays to provide availabe list of SLCK and corresponding voltage, order from low to high
+sAvail_SCLK[5]:                   Arrays to provide available list of SLCK and corresponding voltage, order from low to high
 ulGMCRestoreResetTime:            GMC power restore and GMC reset time to calculate data reconnection latency. Unit in ns.
 ulMinimumNClk:                    Minimum NCLK speed among all NB-Pstates to calcualte data reconnection latency. Unit in 10kHz.
 ulIdleNClk:                       NCLK speed while memory runs in self-refresh state. Unit in 10kHz.
@@ -6102,7 +6102,7 @@ ucUMAChannelNumber:                 System memory channel numbers.
 ulCSR_M3_ARB_CNTL_DEFAULT[10]:    Arrays with values for CSR M3 arbiter for default
 ulCSR_M3_ARB_CNTL_UVD[10]:        Arrays with values for CSR M3 arbiter for UVD playback.
 ulCSR_M3_ARB_CNTL_FS3D[10]:       Arrays with values for CSR M3 arbiter for Full Screen 3D applications.
-sAvail_SCLK[5]:                   Arrays to provide availabe list of SLCK and corresponding voltage, order from low to high
+sAvail_SCLK[5]:                   Arrays to provide available list of SLCK and corresponding voltage, order from low to high
 ulGMCRestoreResetTime:            GMC power restore and GMC reset time to calculate data reconnection latency. Unit in ns.
 ulMinimumNClk:                    Minimum NCLK speed among all NB-Pstates to calcualte data reconnection latency. Unit in 10kHz.
 ulIdleNClk:                       NCLK speed while memory runs in self-refresh state. Unit in 10kHz.
@@ -6302,7 +6302,7 @@ ucUMAChannelNumber:                 System memory channel numbers.
 
 strVBIOSMsg[40]:                  VBIOS boot up customized message string
 
-sAvail_SCLK[5]:                   Arrays to provide availabe list of SLCK and corresponding voltage, order from low to high
+sAvail_SCLK[5]:                   Arrays to provide available list of SLCK and corresponding voltage, order from low to high
 
 ulGMCRestoreResetTime:            GMC power restore and GMC reset time to calculate data reconnection latency. Unit in ns.
 ulIdleNClk:                       NCLK speed while memory runs in self-refresh state, used to calculate self-refresh latency. Unit in 10kHz.
@@ -6628,7 +6628,7 @@ typedef struct  _ATOM_ASIC_MVDD_INFO
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT
 {
-   ULONG                        ulTargetClockRange;                  //Clock Out frequence (VCO ), in unit of 10Khz
+   ULONG                        ulTargetClockRange;                  //Clock Out frequency (VCO ), in unit of 10Khz
   USHORT              usSpreadSpectrumPercentage;      //in unit of 0.01%
    USHORT                     usSpreadRateInKhz;                  //in unit of kHz, modulation freq
   UCHAR               ucClockIndication;                 //Indicate which clock source needs SS
@@ -6636,7 +6636,7 @@ typedef struct _ATOM_ASIC_SS_ASSIGNMENT
    UCHAR                        ucReserved[2];
 }ATOM_ASIC_SS_ASSIGNMENT;
 
-//Define ucClockIndication, SW uses the IDs below to search if the SS is requried/enabled on a clock branch/signal type.
+//Define ucClockIndication, SW uses the IDs below to search if the SS is required/enabled on a clock branch/signal type.
 //SS is not required or enabled if a match is not found.
 #define ASIC_INTERNAL_MEMORY_SS            1
 #define ASIC_INTERNAL_ENGINE_SS            2
@@ -6653,7 +6653,7 @@ typedef struct _ATOM_ASIC_SS_ASSIGNMENT
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V2
 {
-   ULONG                        ulTargetClockRange;                  //For mem/engine/uvd, Clock Out frequence (VCO ), in unit of 10Khz
+   ULONG                        ulTargetClockRange;                  //For mem/engine/uvd, Clock Out frequency (VCO ), in unit of 10Khz
                                                     //For TMDS/HDMI/LVDS, it is pixel clock , for DP, it is link clock ( 27000 or 16200 )
   USHORT              usSpreadSpectrumPercentage;      //in unit of 0.01%
    USHORT                     usSpreadRateIn10Hz;                  //in unit of 10Hz, modulation freq
@@ -6684,7 +6684,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V2
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3
 {
-   ULONG                        ulTargetClockRange;                  //For mem/engine/uvd, Clock Out frequence (VCO ), in unit of 10Khz
+   ULONG                        ulTargetClockRange;                  //For mem/engine/uvd, Clock Out frequency (VCO ), in unit of 10Khz
                                                     //For TMDS/HDMI/LVDS, it is pixel clock , for DP, it is link clock ( 27000 or 16200 )
   USHORT              usSpreadSpectrumPercentage;      //in unit of 0.01% or 0.001%, decided by ucSpreadSpectrumMode bit4
    USHORT                     usSpreadRateIn10Hz;                  //in unit of 10Hz, modulation freq
@@ -6771,7 +6771,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 #define ATOM_S0_SYSTEM_POWER_STATE_VALUE_LITEAC 3
 #define ATOM_S0_SYSTEM_POWER_STATE_VALUE_LIT2AC 4
 
-//Byte aligned defintion for BIOS usage
+//Byte aligned definition for BIOS usage
 #define ATOM_S0_CRT1_MONOb0             0x01
 #define ATOM_S0_CRT1_COLORb0            0x02
 #define ATOM_S0_CRT1_MASKb0             (ATOM_S0_CRT1_MONOb0+ATOM_S0_CRT1_COLORb0)
@@ -6837,7 +6837,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 #define ATOM_S2_DISPLAY_ROTATION_ANGLE_MASK   0xC0000000L
 
 
-//Byte aligned defintion for BIOS usage
+//Byte aligned definition for BIOS usage
 #define ATOM_S2_TV1_STANDARD_MASKb0     0x0F
 #define ATOM_S2_CURRENT_BL_LEVEL_MASKb1 0xFF
 #define ATOM_S2_DEVICE_DPMS_STATEb2     0x01
@@ -6889,7 +6889,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 
 
 
-//Byte aligned defintion for BIOS usage
+//Byte aligned definition for BIOS usage
 #define ATOM_S3_CRT1_ACTIVEb0           0x01
 #define ATOM_S3_LCD1_ACTIVEb0           0x02
 #define ATOM_S3_TV1_ACTIVEb0            0x04
@@ -6928,7 +6928,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 #define ATOM_S4_LCD1_REFRESH_MASK       0x0000FF00L
 #define ATOM_S4_LCD1_REFRESH_SHIFT      8
 
-//Byte aligned defintion for BIOS usage
+//Byte aligned definition for BIOS usage
 #define ATOM_S4_LCD1_PANEL_ID_MASKb0    0x0FF
 #define ATOM_S4_LCD1_REFRESH_MASKb1     ATOM_S4_LCD1_PANEL_ID_MASKb0
 #define ATOM_S4_VRAM_INFO_MASKb2        ATOM_S4_LCD1_PANEL_ID_MASKb0
@@ -7007,7 +7007,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
 #define ATOM_S6_VRI_BRIGHTNESS_CHANGE       0x40000000L
 #define ATOM_S6_CONFIG_DISPLAY_CHANGE_MASK  0x80000000L
 
-//Byte aligned defintion for BIOS usage
+//Byte aligned definition for BIOS usage
 #define ATOM_S6_DEVICE_CHANGEb0         0x01
 #define ATOM_S6_SCALER_CHANGEb0         0x02
 #define ATOM_S6_LID_CHANGEb0            0x04
@@ -7270,7 +7270,7 @@ typedef struct _ENABLE_GRAPH_SURFACE_PS_ALLOCATION
 
 typedef struct _MEMORY_CLEAN_UP_PARAMETERS
 {
-  USHORT  usMemoryStart;                //in 8Kb boundry, offset from memory base address
+  USHORT  usMemoryStart;                //in 8Kb boundary, offset from memory base address
   USHORT  usMemorySize;                 //8Kb blocks aligned
 }MEMORY_CLEAN_UP_PARAMETERS;
 
@@ -9092,7 +9092,7 @@ typedef struct  _ATOM_POWERPLAY_INFO_V3
 /**************************************************************************/
 
 
-// Following definitions are for compatiblity issue in different SW components.
+// Following definitions are for compatibility issue in different SW components.
 #define ATOM_MASTER_DATA_TABLE_REVISION   0x01
 #define Object_Info                       Object_Header
 #define AdjustARB_SEQ                     MC_InitParameter
@@ -9272,8 +9272,8 @@ typedef struct {
 typedef struct {
   AMD_ACPI_DESCRIPTION_HEADER SHeader;
   UCHAR TableUUID[16];    //0x24
-  ULONG VBIOSImageOffset; //0x34. Offset to the first GOP_VBIOS_CONTENT block from the beginning of the stucture.
-  ULONG Lib1ImageOffset;  //0x38. Offset to the first GOP_LIB1_CONTENT block from the beginning of the stucture.
+  ULONG VBIOSImageOffset; //0x34. Offset to the first GOP_VBIOS_CONTENT block from the beginning of the structure.
+  ULONG Lib1ImageOffset;  //0x38. Offset to the first GOP_LIB1_CONTENT block from the beginning of the structure.
   ULONG Reserved[4];      //0x3C
 }UEFI_ACPI_VFCT;
 
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 62f7ed0b2066..fccbb3fb4f65 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -742,7 +742,7 @@ struct atom_gpio_pin_lut_v2_1
 /*
  * VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write
  * access that region. driver can allocate their own reservation region as long as it does not
- * overlap firwmare's reservation region.
+ * overlap firmware's reservation region.
  * if (pre-NV1X) atom data table firmwareInfoTable version < 3.3:
  * in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
  *   if VBIOS/UEFI GOP is posted:
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index a8e6ccc7817c..84d74efefadf 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -530,7 +530,7 @@ enum { QUERY_MES_MAX_SIZE_IN_DWORDS = 20 };
 
 /**
  * Obsolete
- * to be removed once KMD stopped refering to it.
+ * to be removed once KMD stopped referring to it.
  * use MES_API_QUERY_MES__CAPS instead
 */
 struct MES_API_QUERY_MES__CTX_ARRAY_SIZE {
diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index f83ace2d7ec3..2055c9269206 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -442,7 +442,7 @@ typedef struct _ATOM_PPLIB_SUMO_CLOCK_INFO{
       UCHAR  ucEngineClockHigh; //clockfrequency >> 16. 
       UCHAR  vddcIndex;         //2-bit vddc index;
       USHORT tdpLimit;
-      //please initalize to 0
+      //please initialize to 0
       USHORT rsv1;
       //please initialize to 0s
       ULONG rsv2[2];
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c0e677328af5..c46177357f55 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -907,7 +907,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
  * features to be enabled. The file pp_features is used for this. And
  * this is only available for Vega10 and later dGPUs.
  *
- * Reading back the file will show you the followings:
+ * Reading back the file will show you the following:
  * - Current ppfeature masks
  * - List of the all supported powerplay features with their naming,
  *   bitmasks and enablement status('Y'/'N' means "enabled"/"disabled").
@@ -4044,7 +4044,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
  *
  * Reading back the file shows you the current settings(temperature in Celsius
  * degree and fan speed in pwm) applied to every anchor point of the curve line
- * and their permitted ranges if changable.
+ * and their permitted ranges if changeable.
  *
  * Writing a desired string(with the format like "anchor_point_index temperature
  * fan_speed_in_pwm") to the file, change the settings for the specific anchor
@@ -4107,7 +4107,7 @@ static umode_t fan_curve_visible(struct amdgpu_device *adev)
  * acoustic limit in RPM for fan control.
  *
  * Reading back the file shows you the current setting and the permitted
- * ranges if changable.
+ * ranges if changeable.
  *
  * Writing an integer to the file, change the setting accordingly.
  *
@@ -4165,7 +4165,7 @@ static umode_t acoustic_limit_threshold_visible(struct amdgpu_device *adev)
  * acoustic target in RPM for fan control.
  *
  * Reading back the file shows you the current setting and the permitted
- * ranges if changable.
+ * ranges if changeable.
  *
  * Writing an integer to the file, change the setting accordingly.
  *
@@ -4225,7 +4225,7 @@ static umode_t acoustic_target_threshold_visible(struct amdgpu_device *adev)
  * target tempeature in Celsius degree for fan control.
  *
  * Reading back the file shows you the current setting and the permitted
- * ranges if changable.
+ * ranges if changeable.
  *
  * Writing an integer to the file, change the setting accordingly.
  *
@@ -4286,7 +4286,7 @@ static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
  * minimum fan speed in PWM.
  *
  * Reading back the file shows you the current setting and the permitted
- * ranges if changable.
+ * ranges if changeable.
  *
  * Writing an integer to the file, change the setting accordingly.
  *
@@ -4345,7 +4345,7 @@ static umode_t fan_minimum_pwm_visible(struct amdgpu_device *adev)
  * zero RPM feature.
  *
  * Reading back the file shows you the current setting and the permitted
- * ranges if changable.
+ * ranges if changeable.
  *
  * Writing an integer to the file, change the setting accordingly.
  *
@@ -4399,7 +4399,7 @@ static umode_t fan_zero_rpm_enable_visible(struct amdgpu_device *adev)
  * zero RPM stop temperature feature.
  *
  * Reading back the file shows you the current setting and the permitted
- * ranges if changable.
+ * ranges if changeable.
  *
  * Writing an integer to the file, change the setting accordingly.
  *
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 6362a14b1a6e..bd516c6150b2 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -237,7 +237,7 @@ int amdgpu_parse_extended_power_table(struct amdgpu_device *adev)
 		}
 	}
 
-	/* clock dependancy tables, shedding tables */
+	/* clock dependency tables, shedding tables */
 	if (le16_to_cpu(power_info->pplib.usTableSize) >=
 	    sizeof(struct _ATOM_PPLIB_POWERPLAYTABLE4)) {
 		if (power_info->pplib4.usVddcDependencyOnSCLKOffset) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 72c2d3b69a03..b6d35528f299 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -217,7 +217,7 @@ int phm_register_irq_handlers(struct pp_hwmgr *hwmgr)
  * phm_start_thermal_controller - Initializes the thermal controller subsystem.
  *
  * @hwmgr:   the address of the powerplay hardware manager.
- * Exception PP_Result_Failed if any of the paramters is NULL, otherwise the return value from the dispatcher.
+ * Exception PP_Result_Failed if any of the parameters is NULL, otherwise the return value from the dispatcher.
  */
 int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 {
@@ -360,7 +360,7 @@ int phm_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_power_s
  * @state: the address of the Power State structure.
  * @pclock_info: the address of PP_ClockInfo structure where the result will be returned.
  * @designation: PHM performance level designation
- * Exception PP_Result_Failed if any of the paramters is NULL, otherwise the return value from the back-end.
+ * Exception PP_Result_Failed if any of the parameters is NULL, otherwise the return value from the back-end.
  */
 int phm_get_clock_info(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *state, struct pp_clock_info *pclock_info,
 			PHM_PerformanceLevelDesignation designation)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index e9c194056e32..311cb70f3289 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4447,7 +4447,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.get_mclk_od = vega20_get_mclk_od,
 	.set_mclk_od = vega20_set_mclk_od,
 	.odn_edit_dpm_table = vega20_odn_edit_dpm_table,
-	/* for sysfs to retrive/set gfxclk/memclk */
+	/* for sysfs to retrieve/set gfxclk/memclk */
 	.force_clock_level = vega20_force_clock_level,
 	.emit_clock_levels = vega20_emit_clock_levels,
 	.read_sensor = vega20_read_sensor,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 3650e7beeb67..7636ae03ddd8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -153,7 +153,7 @@ static int ci_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_addre
 		extra_shift = 8 * (4 - byte_count);
 
 		while (byte_count > 0) {
-			/* Bytes are written into the SMC addres space with the MSB first. */
+			/* Bytes are written into the SMC address space with the MSB first. */
 			data = (0x100 * data) + *src++;
 			byte_count--;
 		}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index e59b87238e76..dcdb24144e31 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -159,7 +159,7 @@ static int polaris10_setup_graphics_level_structure(struct pp_hwmgr *hwmgr)
 				"[AVFS][Polaris10_SetupGfxLvlStruct] Copying of MCLK DPM table failed!",
 			return -1);
 
-	/* MVDD Boot value - neccessary for getting rid of the hang that occurs during Mclk DPM enablement */
+	/* MVDD Boot value - necessary for getting rid of the hang that occurs during Mclk DPM enablement */
 
 	graphics_level_address = dpm_table_start + offsetof(SMU74_Discrete_DpmTable, BootMVdd);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index 45504ac3a31d..b0c3609572cd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -61,7 +61,7 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 	addr = smc_start_address;
 
 	while (byte_count >= 4) {
-	/* Bytes are written into the SMC addres space with the MSB first. */
+	/* Bytes are written into the SMC address space with the MSB first. */
 		data = src[0] * 0x1000000 + src[1] * 0x10000 + src[2] * 0x100 + src[3];
 
 		result = smu7_set_smc_sram_address(hwmgr, addr, limit);
@@ -91,7 +91,7 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 		extra_shift = 8 * (4 - byte_count);
 
 		while (byte_count > 0) {
-			/* Bytes are written into the SMC addres space with the MSB first. */
+			/* Bytes are written into the SMC address space with the MSB first. */
 			data = (0x100 * data) + *src++;
 			byte_count--;
 		}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 28fe988c2262..33c23532e29c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -1750,7 +1750,7 @@ static int tonga_populate_vr_config(struct pp_hwmgr *hwmgr,
 	uint16_t config;
 
 	if (SMU7_VOLTAGE_CONTROL_BY_SVID2 == data->vdd_gfx_control) {
-		/*  Splitted mode */
+		/*  Split mode */
 		config = VR_SVI2_PLANE_1;
 		table->VRConfig |= (config<<VRCONF_VDDGFX_SHIFT);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cca32f74abf0..4bc2852a9a9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3303,7 +3303,7 @@ static int smu_set_power_profile_mode(void *handle,
 
 	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
 		custom = true;
-		/* clear frontend mask so custom changes propogate */
+		/* clear frontend mask so custom changes propagate */
 		smu->workload_mask = 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3ec65630ab99..35202f627ac7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1073,7 +1073,7 @@ struct pptable_funcs {
 
 	/**
 	 * @update_pcie_parameters: Update and upload the system's PCIe
-	 *                          capabilites to the SMU.
+	 *                          capabilities to the SMU.
 	 * &pcie_gen_cap: Maximum allowed PCIe generation.
 	 * &pcie_width_cap: Maximum allowed PCIe width.
 	 */
@@ -1148,7 +1148,7 @@ struct pptable_funcs {
 	int (*check_fw_status)(struct smu_context *smu);
 
 	/**
-	 * @set_mp1_state: put SMU into a correct state for comming
+	 * @set_mp1_state: put SMU into a correct state for coming
 	 *                 resume from runpm or gpu reset.
 	 */
 	int (*set_mp1_state)(struct smu_context *smu,
@@ -1348,7 +1348,7 @@ struct pptable_funcs {
 	u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t *residency);
 
 	/**
-	 * @register_irq_handler: Register interupt request handlers.
+	 * @register_irq_handler: Register interrupt request handlers.
 	 */
 	int (*register_irq_handler)(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b114d14fc053..fc502fd5ade7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1108,8 +1108,8 @@ typedef struct {
 
   uint8_t         FoptEnabled;
   uint8_t         DcsSpare2[3];
-  uint32_t        DcsFoptM;             //Tuning paramters to shift Fopt calculation
-  uint32_t        DcsFoptB;             //Tuning paramters to shift Fopt calculation
+  uint32_t        DcsFoptM;             //Tuning parameters to shift Fopt calculation
+  uint32_t        DcsFoptB;             //Tuning parameters to shift Fopt calculation
 
   uint32_t        DcsSpare[11];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
index c2fd0a4a13e5..5368651d6334 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
@@ -1208,8 +1208,8 @@ typedef struct {
 
   uint8_t       FoptEnabled;
   uint8_t       DcsSpare2[3];
-  uint32_t      DcsFoptM;             //Tuning paramters to shift Fopt calculation, IEEE754 float
-  uint32_t      DcsFoptB;             //Tuning paramters to shift Fopt calculation, IEEE754 float
+  uint32_t      DcsFoptM;             //Tuning parameters to shift Fopt calculation, IEEE754 float
+  uint32_t      DcsFoptB;             //Tuning parameters to shift Fopt calculation, IEEE754 float
   uint32_t      DcsSpare[9];
 
   // UCLK section
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
index 6993d866183d..034de7c28199 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
@@ -277,7 +277,7 @@ typedef struct {
 #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
 #define IH_INTERRUPT_VFFLR_INT                      0xA
 
-/* thermal over-temp mask defines for IH interrup to host */
+/* thermal over-temp mask defines for IH interrupt to host */
 #define THROTTLER_PROCHOT_BIT           0
 #define THROTTLER_RESERVED              1
 /* AID, XCD, CCD throttling */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0ec17c1054c0..4ca32dcdbe71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -522,7 +522,7 @@ static int renoir_emit_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		/* retirve table returned paramters unit is MHz */
+		/* retirve table returned parameters unit is MHz */
 		cur_value = metrics.ClockFrequency[CLOCK_GFXCLK];
 		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6e741ec4a71e..d878916ee807 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1903,7 +1903,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		 * The member below instructs PMFW the settings focused in
 		 * this single operation.
 		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
+		 * It does not contain actual information about user's custom
 		 * settings. Thus we do not cache it.
 		 */
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 84c02e6d9673..ffac1894aa8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2977,7 +2977,7 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 
 	/* Certain platforms have switches which assign virtual BAR values to
 	 * devices. OS uses the virtual BAR values and device behind the switch
-	 * is assgined another BAR value. When device's config space registers
+	 * is assigned another BAR value. When device's config space registers
 	 * are queried, switch returns the virtual BAR values. When mode-2 reset
 	 * is performed, switch is unaware of it, and will continue to return
 	 * the same virtual values to the OS.This affects
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b94ae43586df..bf4f9fd990d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1913,7 +1913,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		 * The member below instructs PMFW the settings focused in
 		 * this single operation.
 		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
+		 * It does not contain actual information about user's custom
 		 * settings. Thus we do not cache it.
 		 */
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 56a5c11bc196..1001fd831ba5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2767,7 +2767,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		 * The member below instructs PMFW the settings focused in
 		 * this single operation.
 		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
+		 * It does not contain actual information about user's custom
 		 * settings. Thus we do not cache it.
 		 */
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index 1afa70566985..02c2ff4f82d1 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -1711,9 +1711,9 @@ typedef struct _PIXEL_CLOCK_PARAMETERS_V6
 #define PIXEL_CLOCK_V6_MISC_HDMI_BPP_MASK           0x0c
 #define PIXEL_CLOCK_V6_MISC_HDMI_24BPP              0x00
 #define PIXEL_CLOCK_V6_MISC_HDMI_36BPP              0x04
-#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct defintion for 36bpp should be 2 for 36bpp(2:1)
+#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct definition for 36bpp should be 2 for 36bpp(2:1)
 #define PIXEL_CLOCK_V6_MISC_HDMI_30BPP              0x08
-#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct defintion for 30bpp should be 1 for 36bpp(5:4)
+#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct definition for 30bpp should be 1 for 36bpp(5:4)
 #define PIXEL_CLOCK_V6_MISC_HDMI_48BPP              0x0c
 #define PIXEL_CLOCK_V6_MISC_REF_DIV_SRC             0x10
 #define PIXEL_CLOCK_V6_MISC_GEN_DPREFCLK            0x40
@@ -1826,8 +1826,8 @@ typedef struct _GET_ENGINE_CLOCK_PARAMETERS
 /****************************************************************************/	
 // Following Structures and constant may be obsolete
 /****************************************************************************/	
-//Maxium 8 bytes,the data read in will be placed in the parameter space.
-//Read operaion successeful when the paramter space is non-zero, otherwise read operation failed
+//Maximum 8 bytes,the data read in will be placed in the parameter space.
+//Read operaion successeful when the parameter space is non-zero, otherwise read operation failed
 typedef struct _READ_EDID_FROM_HW_I2C_DATA_PARAMETERS
 {
   USHORT    usPrescale;         //Ratio between Engine clock and I2C clock
@@ -2036,7 +2036,7 @@ typedef struct _LVDS_ENCODER_CONTROL_PARAMETERS
 typedef struct _LVDS_ENCODER_CONTROL_PARAMETERS_V2
 {
   USHORT usPixelClock;  // in 10KHz; for bios convenient
-  UCHAR  ucMisc;        // see PANEL_ENCODER_MISC_xx defintions below
+  UCHAR  ucMisc;        // see PANEL_ENCODER_MISC_xx definitions below
   UCHAR  ucAction;      // 0: turn off encoder
                         // 1: setup and turn on encoder
   UCHAR  ucTruncate;    // bit0=0: Disable truncate
@@ -2244,10 +2244,10 @@ typedef struct	_SET_VOLTAGE_PARAMETERS_V1_3
 #define ATOM_INIT_VOLTAGE_REGULATOR          3        //Init Regulator
 #define ATOM_SET_VOLTAGE_PHASE               4        //Set Vregulator Phase, only for SVID/PVID regulator
 #define ATOM_GET_MAX_VOLTAGE                 6        //Get Max Voltage, not used from SetVoltageTable v1.3
-#define ATOM_GET_VOLTAGE_LEVEL               6        //Get Voltage level from vitual voltage ID, not used for SetVoltage v1.4
+#define ATOM_GET_VOLTAGE_LEVEL               6        //Get Voltage level from virtual voltage ID, not used for SetVoltage v1.4
 #define ATOM_GET_LEAKAGE_ID                  8        //Get Leakage Voltage Id ( starting from SMU7x IP ), SetVoltage v1.4 
 
-// define vitual voltage id in usVoltageLevel
+// define virtual voltage id in usVoltageLevel
 #define ATOM_VIRTUAL_VOLTAGE_ID0             0xff01
 #define ATOM_VIRTUAL_VOLTAGE_ID1             0xff02
 #define ATOM_VIRTUAL_VOLTAGE_ID2             0xff03
@@ -2379,7 +2379,7 @@ typedef struct _ATOM_MASTER_LIST_OF_DATA_TABLES
   USHORT        IntegratedSystemInfo;			// Shared by various SW components
   USHORT        ASIC_ProfilingInfo;				// New table name from R600, used to be called "ASIC_VDDCI_Info" for pre-R600
   USHORT        VoltageObjectInfo;				// Shared by various SW components, latest version 1.1
-	USHORT				PowerSourceInfo;					// Shared by various SW components, latest versoin 1.1
+	USHORT				PowerSourceInfo;					// Shared by various SW components, latest version 1.1
 }ATOM_MASTER_LIST_OF_DATA_TABLES;
 
 typedef struct _ATOM_MASTER_DATA_TABLE
@@ -3732,7 +3732,7 @@ typedef struct _ATOM_DPCD_INFO
 #define ATOM_DPCD_MAX_LANE_MASK    0x1F
 
 /**************************************************************************/
-// VRAM usage and their defintions
+// VRAM usage and their definitions
 
 // One chunk of VRAM used by Bios are for HWICON surfaces,EDID data.
 // Current Mode timing and Dail Timing and/or STD timing data EACH device. They can be broken down as below.
@@ -4570,7 +4570,7 @@ typedef struct _ATOM_VOLTAGE_OBJECT_HEADER_V3{
 
 // ATOM_VOLTAGE_OBJECT_HEADER_V3.ucVoltageMode
 #define VOLTAGE_OBJ_GPIO_LUT                 0        //VOLTAGE and GPIO Lookup table ->ATOM_GPIO_VOLTAGE_OBJECT_V3
-#define VOLTAGE_OBJ_VR_I2C_INIT_SEQ          3        //VOLTAGE REGULATOR INIT sequece through I2C -> ATOM_I2C_VOLTAGE_OBJECT_V3
+#define VOLTAGE_OBJ_VR_I2C_INIT_SEQ          3        //VOLTAGE REGULATOR INIT sequence through I2C -> ATOM_I2C_VOLTAGE_OBJECT_V3
 #define VOLTAGE_OBJ_PHASE_LUT                4        //Set Vregulator Phase lookup table ->ATOM_GPIO_VOLTAGE_OBJECT_V3
 #define VOLTAGE_OBJ_SVID2                    7        //Indicate voltage control by SVID2 ->ATOM_SVID2_VOLTAGE_OBJECT_V3
 #define VOLTAGE_OBJ_EVV                      8 
@@ -4610,7 +4610,7 @@ typedef struct  _ATOM_GPIO_VOLTAGE_OBJECT_V3
 {
    ATOM_VOLTAGE_OBJECT_HEADER_V3 sHeader;   // voltage mode = VOLTAGE_OBJ_GPIO_LUT or VOLTAGE_OBJ_PHASE_LUT
    UCHAR    ucVoltageGpioCntlId;         // default is 0 which indicate control through CG VID mode 
-   UCHAR    ucGpioEntryNum;              // indiate the entry numbers of Votlage/Gpio value Look up table
+   UCHAR    ucGpioEntryNum;              // indicate the entry numbers of Votlage/Gpio value Look up table
    UCHAR    ucPhaseDelay;                // phase delay in unit of micro second
    UCHAR    ucReserved;   
    ULONG    ulGpioMaskVal;               // GPIO Mask value
@@ -4925,7 +4925,7 @@ ucUMAChannelNumber:      	        System memory channel numbers.
 ulCSR_M3_ARB_CNTL_DEFAULT[10]:    Arrays with values for CSR M3 arbiter for default
 ulCSR_M3_ARB_CNTL_UVD[10]:        Arrays with values for CSR M3 arbiter for UVD playback.
 ulCSR_M3_ARB_CNTL_FS3D[10]:       Arrays with values for CSR M3 arbiter for Full Screen 3D applications.
-sAvail_SCLK[5]:                   Arrays to provide availabe list of SLCK and corresponding voltage, order from low to high  
+sAvail_SCLK[5]:                   Arrays to provide available list of SLCK and corresponding voltage, order from low to high  
 ulGMCRestoreResetTime:            GMC power restore and GMC reset time to calculate data reconnection latency. Unit in ns. 
 ulMinimumNClk:                    Minimum NCLK speed among all NB-Pstates to calcualte data reconnection latency. Unit in 10kHz. 
 ulIdleNClk:                       NCLK speed while memory runs in self-refresh state. Unit in 10kHz.
@@ -5151,7 +5151,7 @@ ucUMAChannelNumber:      	        System memory channel numbers.
 ulCSR_M3_ARB_CNTL_DEFAULT[10]:    Arrays with values for CSR M3 arbiter for default
 ulCSR_M3_ARB_CNTL_UVD[10]:        Arrays with values for CSR M3 arbiter for UVD playback.
 ulCSR_M3_ARB_CNTL_FS3D[10]:       Arrays with values for CSR M3 arbiter for Full Screen 3D applications.
-sAvail_SCLK[5]:                   Arrays to provide availabe list of SLCK and corresponding voltage, order from low to high  
+sAvail_SCLK[5]:                   Arrays to provide available list of SLCK and corresponding voltage, order from low to high  
 ulGMCRestoreResetTime:            GMC power restore and GMC reset time to calculate data reconnection latency. Unit in ns. 
 ulMinimumNClk:                    Minimum NCLK speed among all NB-Pstates to calcualte data reconnection latency. Unit in 10kHz. 
 ulIdleNClk:                       NCLK speed while memory runs in self-refresh state. Unit in 10kHz.
@@ -5350,7 +5350,7 @@ ucUMAChannelNumber:      	        System memory channel numbers.
 
 strVBIOSMsg[40]:                  VBIOS boot up customized message string 
 
-sAvail_SCLK[5]:                   Arrays to provide availabe list of SLCK and corresponding voltage, order from low to high  
+sAvail_SCLK[5]:                   Arrays to provide available list of SLCK and corresponding voltage, order from low to high  
 
 ulGMCRestoreResetTime:            GMC power restore and GMC reset time to calculate data reconnection latency. Unit in ns. 
 ulIdleNClk:                       NCLK speed while memory runs in self-refresh state, used to calculate self-refresh latency. Unit in 10kHz.
@@ -5468,7 +5468,7 @@ typedef struct  _ATOM_ASIC_MVDD_INFO
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT
 {
-	ULONG								ulTargetClockRange;						//Clock Out frequence (VCO ), in unit of 10Khz
+	ULONG								ulTargetClockRange;						//Clock Out frequency (VCO ), in unit of 10Khz
   USHORT              usSpreadSpectrumPercentage;		//in unit of 0.01%
 	USHORT							usSpreadRateInKhz;						//in unit of kHz, modulation freq
   UCHAR               ucClockIndication;					  //Indicate which clock source needs SS
@@ -5493,7 +5493,7 @@ typedef struct _ATOM_ASIC_SS_ASSIGNMENT
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V2
 {
-	ULONG								ulTargetClockRange;						//For mem/engine/uvd, Clock Out frequence (VCO ), in unit of 10Khz
+	ULONG								ulTargetClockRange;						//For mem/engine/uvd, Clock Out frequency (VCO ), in unit of 10Khz
                                                     //For TMDS/HDMI/LVDS, it is pixel clock , for DP, it is link clock ( 27000 or 16200 )
   USHORT              usSpreadSpectrumPercentage;		//in unit of 0.01% or 0.001%, decided by ucSpreadSpectrumMode bit4
 	USHORT							usSpreadRateIn10Hz;						//in unit of 10Hz, modulation freq
@@ -5524,7 +5524,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V2
 
 typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3
 {
-	ULONG								ulTargetClockRange;						//For mem/engine/uvd, Clock Out frequence (VCO ), in unit of 10Khz
+	ULONG								ulTargetClockRange;						//For mem/engine/uvd, Clock Out frequency (VCO ), in unit of 10Khz
                                                     //For TMDS/HDMI/LVDS, it is pixel clock , for DP, it is link clock ( 27000 or 16200 )
   USHORT              usSpreadSpectrumPercentage;		//in unit of 0.01%
 	USHORT							usSpreadRateIn10Hz;						//in unit of 10Hz, modulation freq
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index a13635443833..c738efe1e2a6 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3415,7 +3415,7 @@ static void cik_gpu_init(struct radeon_device *rdev)
  * @rdev: radeon_device pointer
  *
  * Set up the number and offset of the CP scratch registers.
- * NOTE: use of CP scratch registers is a legacy inferface and
+ * NOTE: use of CP scratch registers is a legacy interface and
  * is not used by default on newer asics (r6xx+).  On newer asics,
  * memory buffers are used for fences rather than scratch regs.
  */
@@ -3831,7 +3831,7 @@ int cik_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 
 /*
  * CP.
- * On CIK, gfx and compute now have independant command processors.
+ * On CIK, gfx and compute now have independent command processors.
  *
  * GFX
  * Gfx consists of a single ring and can process both gfx jobs and
@@ -3840,7 +3840,7 @@ int cik_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
  * ME - Micro Engine
  * CE - Constant Engine
  * The PFP and ME make up what is considered the Drawing Engine (DE).
- * The CE is an asynchronous engine used for updating buffer desciptors
+ * The CE is an asynchronous engine used for updating buffer descriptors
  * used by the DE so that they can be loaded into cache in parallel
  * while the DE is processing state update packets.
  *
@@ -4078,7 +4078,7 @@ static int cik_cp_gfx_resume(struct radeon_device *rdev)
 	ring->wptr = 0;
 	WREG32(CP_RB0_WPTR, ring->wptr);
 
-	/* set the wb address wether it's enabled or not */
+	/* set the wb address whether it's enabled or not */
 	WREG32(CP_RB0_RPTR_ADDR, (rdev->wb.gpu_addr + RADEON_WB_CP_RPTR_OFFSET) & 0xFFFFFFFC);
 	WREG32(CP_RB0_RPTR_ADDR_HI, upper_32_bits(rdev->wb.gpu_addr + RADEON_WB_CP_RPTR_OFFSET) & 0xFF);
 
@@ -4683,7 +4683,7 @@ static int cik_cp_compute_resume(struct radeon_device *rdev)
 		WREG32(CP_HQD_PQ_WPTR_POLL_ADDR_HI,
 		       mqd->queue_state.cp_hqd_pq_wptr_poll_addr_hi);
 
-		/* set the wb address wether it's enabled or not */
+		/* set the wb address whether it's enabled or not */
 		if (i == 0)
 			wb_gpu_addr = rdev->wb.gpu_addr + RADEON_WB_CP1_RPTR_OFFSET;
 		else
@@ -5330,7 +5330,7 @@ static int cik_mc_init(struct radeon_device *rdev)
 	u32 tmp;
 	int chansize, numchan;
 
-	/* Get VRAM informations */
+	/* Get VRAM information */
 	rdev->mc.vram_is_ddr = true;
 	tmp = RREG32(MC_ARB_RAMCFG);
 	if (tmp & CHANSIZE_MASK) {
@@ -7530,7 +7530,7 @@ static inline u32 cik_get_ih_wptr(struct radeon_device *rdev)
  *
  * @rdev: radeon_device pointer
  *
- * Interrupt hander (CIK).  Walk the IH ring,
+ * Interrupt handler (CIK).  Walk the IH ring,
  * ack interrupts and schedule work to handle
  * interrupt events.
  * Returns irq process return code.
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 3cbc6eedbf66..4a48ab94909a 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -1283,7 +1283,7 @@ void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev)
 	readrq = pcie_get_readrq(rdev->pdev);
 	v = ffs(readrq) - 8;
 	/* if bios or OS sets MAX_READ_REQUEST_SIZE to an invalid value, fix it
-	 * to avoid hangs or perfomance issues
+	 * to avoid hangs or performance issues
 	 */
 	if ((v == 0) || (v == 6) || (v == 7))
 		pcie_set_readrq(rdev->pdev, 512);
@@ -3716,7 +3716,7 @@ int evergreen_mc_init(struct radeon_device *rdev)
 	u32 tmp;
 	int chansize, numchan;
 
-	/* Get VRAM informations */
+	/* Get VRAM information */
 	rdev->mc.vram_is_ddr = true;
 	if ((rdev->family == CHIP_PALM) ||
 	    (rdev->family == CHIP_SUMO) ||
diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index f4e71046dc91..56b00ed0a3e9 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -415,7 +415,7 @@ typedef struct _ATOM_PPLIB_SUMO_CLOCK_INFO{
       UCHAR  ucEngineClockHigh; //clockfrequency >> 16. 
       UCHAR  vddcIndex;         //2-bit vddc index;
       USHORT tdpLimit;
-      //please initalize to 0
+      //please initialize to 0
       USHORT rsv1;
       //please initialize to 0s
       ULONG rsv2[2];
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 8b62f7faa5b9..80ec9ceefa3d 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -1367,8 +1367,8 @@ static void r600_mc_program(struct radeon_device *rdev)
 
 /**
  * r600_vram_gtt_location - try to find VRAM & GTT location
- * @rdev: radeon device structure holding all necessary informations
- * @mc: memory controller structure holding memory informations
+ * @rdev: radeon device structure holding all necessary information
+ * @mc: memory controller structure holding memory information
  *
  * Function will place try to place VRAM at same place as in CPU (PCI)
  * address space as some GPU seems to have issue when we reprogram at
@@ -1437,7 +1437,7 @@ static int r600_mc_init(struct radeon_device *rdev)
 	uint32_t h_addr, l_addr;
 	unsigned long long k8_addr;
 
-	/* Get VRAM informations */
+	/* Get VRAM information */
 	rdev->mc.vram_is_ddr = true;
 	tmp = RREG32(RAMCFG);
 	if (tmp & CHANSIZE_OVERRIDE) {
diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r600_dpm.c
index 9755e717ca8b..c9d3049ca514 100644
--- a/drivers/gpu/drm/radeon/r600_dpm.c
+++ b/drivers/gpu/drm/radeon/r600_dpm.c
@@ -913,7 +913,7 @@ int r600_parse_extended_power_table(struct radeon_device *rdev)
 		}
 	}
 
-	/* clock dependancy tables, shedding tables */
+	/* clock dependency tables, shedding tables */
 	if (le16_to_cpu(power_info->pplib.usTableSize) >=
 	    sizeof(struct _ATOM_PPLIB_POWERPLAYTABLE4)) {
 		if (power_info->pplib4.usVddcDependencyOnSCLKOffset) {
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 527b9d19d730..e65aa4fe805c 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1157,7 +1157,7 @@ struct radeon_wb {
  * @needed_bandwidth:   current bandwidth needs
  *
  * It keeps track of various data needed to take powermanagement decision.
- * Bandwidth need is used to determine minimun clock of the GPU and memory.
+ * Bandwidth need is used to determine minimum clock of the GPU and memory.
  * Equation between gpu/memory clock and available bandwidth is hw dependent
  * (type of memory, bus size, efficiency, ...)
  */
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 2db819ab85d2..8813144f6184 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -839,7 +839,7 @@ void radeon_cs_dump_packet(struct radeon_cs_parser *p,
 /**
  * radeon_cs_packet_next_reloc() - parse next (should be reloc) packet
  * @p:			parser structure holding parsing context.
- * @cs_reloc:		reloc informations
+ * @cs_reloc:		reloc information
  * @nomm:		no memory management for debugging
  *
  * Check if next packet is relocation packet3, do bo validation and compute
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fcf9e..e4edbe0ca9fe 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -526,8 +526,8 @@ int radeon_wb_init(struct radeon_device *rdev)
 
 /**
  * radeon_vram_location - try to find VRAM location
- * @rdev: radeon device structure holding all necessary informations
- * @mc: memory controller structure holding memory informations
+ * @rdev: radeon device structure holding all necessary information
+ * @mc: memory controller structure holding memory information
  * @base: base address at which to put VRAM
  *
  * Function will try to place VRAM at base address provided
@@ -591,12 +591,12 @@ void radeon_vram_location(struct radeon_device *rdev, struct radeon_mc *mc, u64
 
 /**
  * radeon_gtt_location - try to find GTT location
- * @rdev: radeon device structure holding all necessary informations
- * @mc: memory controller structure holding memory informations
+ * @rdev: radeon device structure holding all necessary information
+ * @mc: memory controller structure holding memory information
  *
  * Function will try to place GTT before or after VRAM.
  *
- * If GTT size is bigger than space left then we ajust GTT size.
+ * If GTT size is bigger than space left then we adjust GTT size.
  * Thus function will never fails.
  *
  * FIXME: when reducing GTT size align new size on power of 2.
@@ -777,7 +777,7 @@ bool radeon_boot_test_post_card(struct radeon_device *rdev)
  * Allocate the dummy page used by the driver (all asics).
  * This dummy page is used by the driver as a filler for gart entries
  * when pages are taken out of the GART
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  */
 int radeon_dummy_page_init(struct radeon_device *rdev)
 {
@@ -969,7 +969,7 @@ static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
  *
  * Initializes the driver info and register access callbacks for the
  * ATOM interpreter (r4xx+).
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  * Called at driver startup.
  */
 int radeon_atombios_init(struct radeon_device *rdev)
@@ -1045,7 +1045,7 @@ void radeon_atombios_fini(struct radeon_device *rdev)
  * @rdev: radeon_device pointer
  *
  * Initializes the driver info for combios (r1xx-r3xx).
- * Returns 0 on sucess.
+ * Returns 0 on success.
  * Called at driver startup.
  */
 int radeon_combios_init(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aac6733ddd82..bcc7e408a4e6 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -951,7 +951,7 @@ static void avivo_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_div,
 }
 
 /**
- * radeon_compute_pll_avivo - compute PLL paramaters
+ * radeon_compute_pll_avivo - compute PLL parameters
  *
  * @pll: information about the PLL
  * @freq: target frequency
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 53d06053dec8..078c880d35a4 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -71,7 +71,7 @@
  *   2.11.0 - backend map, initial compute support for the CS checker
  *   2.12.0 - RADEON_CS_KEEP_TILING_FLAGS
  *   2.13.0 - virtual memory support, streamout
- *   2.14.0 - add evergreen tiling informations
+ *   2.14.0 - add evergreen tiling information
  *   2.15.0 - add max_pipes query
  *   2.16.0 - fix evergreen 2D tiled surface calculation
  *   2.17.0 - add STRMOUT_BASE_UPDATE for r7xx
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 299865569252..8e9402b8811b 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -191,7 +191,7 @@ static int radeon_fence_check_signaled(wait_queue_entry_t *wait,
  * @ring: ring index the fence is associated with
  *
  * Checks the current fence value and calculates the last
- * signalled fence value. Returns true if activity occured
+ * signalled fence value. Returns true if activity occurred
  * on the ring, and the fence_queue should be waken up.
  */
 static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
@@ -262,7 +262,7 @@ static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
  * @work: delayed work item
  *
  * Checks for fence activity and if there is none probe
- * the hardware if a lockup occured.
+ * the hardware if a lockup occurred.
  */
 static void radeon_fence_check_lockup(struct work_struct *work)
 {
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 8ce180e22d1d..e0fb29643769 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -681,7 +681,7 @@ int radeon_gem_va_ioctl(struct drm_device *dev, void *data,
 	/* !! DONT REMOVE !!
 	 * We don't support vm_id yet, to be sure we don't have broken
 	 * userspace, reject anyone trying to use non 0 value thus moving
-	 * forward we can use those fields without breaking existant userspace
+	 * forward we can use those fields without breaking existent userspace
 	 */
 	if (args->vm_id) {
 		args->operation = RADEON_VA_RESULT_ERROR;
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
index a1054c8094d4..0d774bf1706f 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
@@ -76,7 +76,7 @@ static void radeon_legacy_rmx_mode_set(struct drm_crtc *crtc,
 	if ((rdev->family == CHIP_RS100) ||
 	    (rdev->family == CHIP_RS200)) {
 		/* This is to workaround the asic bug for RMX, some versions
-		   of BIOS dosen't have this register initialized correctly. */
+		   of BIOS doesn't have this register initialized correctly. */
 		crtc_more_cntl |= RADEON_CRTC_H_CUTOFF_ACTIVE_EN;
 	}
 
@@ -410,7 +410,7 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
 		return false;
 	}
 
-	/* Pin framebuffer & get tilling informations */
+	/* Pin framebuffer & get tilling information */
 	obj = target_fb->obj[0];
 	rbo = gem_to_radeon_bo(obj);
 retry:
diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index ded5747a58d1..4d7f652e986e 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -835,7 +835,7 @@ int radeon_uvd_get_destroy_msg(struct radeon_device *rdev, int ring,
  * @sd: number of SD streams
  * @hd: number of HD streams
  *
- * Count the number of open SD/HD streams as a hint for power mangement
+ * Count the number of open SD/HD streams as a hint for power management
  */
 static void radeon_uvd_count_handles(struct radeon_device *rdev,
 				     unsigned *sd, unsigned *hd)
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 45207310048b..06856d88b2c7 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -604,7 +604,7 @@ uint64_t radeon_vm_map_gart(struct radeon_device *rdev, uint64_t addr)
 /**
  * radeon_vm_page_flags - translate page flags to what the hw uses
  *
- * @flags: flags comming from userspace
+ * @flags: flags coming from userspace
  *
  * Translate the flags the userspace ABI uses to hw flags.
  */
diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
index 016eb4992803..6ccc525436f0 100644
--- a/drivers/gpu/drm/radeon/rs690.c
+++ b/drivers/gpu/drm/radeon/rs690.c
@@ -75,7 +75,7 @@ void rs690_pm_info(struct radeon_device *rdev)
 				   &frev, &crev, &data_offset)) {
 		info = (union igp_info *)(rdev->mode_info.atom_context->bios + data_offset);
 
-		/* Get various system informations from bios */
+		/* Get various system information from bios */
 		switch (crev) {
 		case 1:
 			tmp.full = dfixed_const(100);
@@ -361,7 +361,7 @@ static void rs690_crtc_bandwidth_compute(struct radeon_device *rdev,
 	wm->active_time.full = dfixed_mul(line_time, b);
 	wm->active_time.full = dfixed_div(wm->active_time, a);
 
-	/* Maximun bandwidth is the minimun bandwidth of all component */
+	/* Maximum bandwidth is the minimum bandwidth of all component */
 	max_bandwidth = core_bandwidth;
 	if (rdev->mc.igp_sideport_enabled) {
 		if (max_bandwidth.full > rdev->pm.sideport_bandwidth.full &&
diff --git a/drivers/gpu/drm/radeon/rs780_dpm.c b/drivers/gpu/drm/radeon/rs780_dpm.c
index 64bb4cafb8b5..75256d4b5fcc 100644
--- a/drivers/gpu/drm/radeon/rs780_dpm.c
+++ b/drivers/gpu/drm/radeon/rs780_dpm.c
@@ -872,7 +872,7 @@ int rs780_dpm_init(struct radeon_device *rdev)
 				   &frev, &crev, &data_offset)) {
 		info = (union igp_info *)(rdev->mode_info.atom_context->bios + data_offset);
 
-		/* Get various system informations from bios */
+		/* Get various system information from bios */
 		switch (crev) {
 		case 1:
 			pi->num_of_cycles_in_period =
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 7d4b0bf59109..68fc8e5c73c3 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -1644,7 +1644,7 @@ static int rv770_mc_init(struct radeon_device *rdev)
 	u32 tmp;
 	int chansize, numchan;
 
-	/* Get VRAM informations */
+	/* Get VRAM information */
 	rdev->mc.vram_is_ddr = true;
 	tmp = RREG32(MC_ARB_RAMCFG);
 	if (tmp & CHANSIZE_OVERRIDE) {
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 4681ff28630a..5b66a6732d05 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -4188,7 +4188,7 @@ static int si_mc_init(struct radeon_device *rdev)
 	u32 tmp;
 	int chansize, numchan;
 
-	/* Get VRAM informations */
+	/* Get VRAM information */
 	rdev->mc.vram_is_ddr = true;
 	tmp = RREG32(MC_ARB_RAMCFG);
 	if (tmp & CHANSIZE_OVERRIDE) {
diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c b/drivers/gpu/drm/radeon/uvd_v1_0.c
index 5e6607e16244..1f7d772c38dd 100644
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -273,7 +273,7 @@ int uvd_v1_0_start(struct radeon_device *rdev)
 	/* disable clock gating */
 	WREG32(UVD_CGC_GATE, 0);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_P(UVD_MASTINT_EN, 0, ~(1 << 1));
 
 	/* Stall UMC and register bus before resetting VCPU */
@@ -351,7 +351,7 @@ int uvd_v1_0_start(struct radeon_device *rdev)
 		return r;
 	}
 
-	/* enable interupt */
+	/* enable interrupt */
 	WREG32_P(UVD_MASTINT_EN, 3<<1, ~(3 << 1));
 
 	/* force RBC into idle state */
-- 
2.48.1

