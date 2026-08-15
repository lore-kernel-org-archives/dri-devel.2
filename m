Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B46C5DF6A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 18:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BBB10E22A;
	Sat, 15 Aug 2026 18:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="pU37zViC";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECEF710E22A;
 Sat, 15 Aug 2026 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=oTrmRfuF4LFHnbDfi9z2KLYSR4yAXCBAI1LUpKxCdws=; b=pU37zViCbh9w42tP
 YtpZ7SJco+wWDS0Oj6bevH1qaOZ+98b/iX6Qbw1x060X5zvvY9C1TiF4KGMaaYxJo0wrbcgg5AnDl
 Kje9xrCzuEf7MS1Bd2j6mNtziPYuE/oSVITatBJJcMQeHFodZNLM7Y5Wi6nJYIwpN9KSX2Wn47NM6
 kZVadOT54bLTChiSYWjNJQ8nhasfpjQU1FJ+CH7k9RjBw3mzE8Aa60fKfIoBH271CX3uqatbfH0Ce
 8NuYcZ+xi8OPtfwfXLQpHZpqsa0WyCPTzS5yNEUmpBAvJTCiaBqDPv9HJEz1nwaV8Zu4QwwfURXPI
 ij0A5+dA4NmBAVgv9g==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <linux@treblig.org>) id 1wvIgW-00000002HFi-0VgB;
 Sat, 15 Aug 2026 18:00:44 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/4] drm/amdgpu: Remove is_idle method
Date: Sat, 15 Aug 2026 19:00:29 +0100
Message-ID: <20260815180033.8958-1-linux@treblig.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The is_idle method in amd_ip_funcs is never called, however
there are some functions assigned to it.

Remove the bindings to it, and if the functions aren't called
anywhere else remove the function as well.

Remove the kunit test hook for it.

In many cases the wait_for_idle code either calls the
function which was wired to is_idle or duplicates the
code (or curiously kind of duplicates it with changes).

Based on drm-next-7.3 0d710af8e4abdd1fa500bddbab7c0ee47fc98143.
Booted on my Ryzen with RX560.
(That is spewing some warnings of the form:
[    9.680879] [PLANE:44:plane-0] pixel format with alpha exposed but blend mode not setup
[    9.680881] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x3c2/0x4f0, CPU#4: (udev-worker)/538

but I don't *think* I've gone anywhere near anything to do with pixel
formats etc)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (4):
  drm/amdgpu: Remove is_idle test case
  drm/amdgpu: Remove is_idle (trivial cases)
  drm/amdgpu: Remove is_idle (non trivial functions)
  drm/amdgpu: Remove is_idle

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  6 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  6 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  6 -----
 drivers/gpu/drm/amd/amdgpu/cik.c              |  7 ------
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           | 12 ----------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            | 12 ----------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  6 -----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  6 -----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  6 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 12 ----------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 ----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 12 ----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 11 ---------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  7 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  7 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 13 -----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 ------
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       | 12 ----------
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |  7 ------
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |  7 ------
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |  7 ------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  2 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  7 ------
 drivers/gpu/drm/amd/amdgpu/nv.c               |  6 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 13 -----------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 13 -----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 16 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 16 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 16 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 16 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 16 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 16 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        | 16 -------------
 drivers/gpu/drm/amd/amdgpu/si.c               |  6 -----
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |  1 -
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  6 -----
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  6 -----
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  6 -----
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  6 -----
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 12 ----------
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  8 -------
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  8 -------
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  8 -------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 16 -------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 23 -------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 21 -----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 23 -------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 23 -------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       | 19 ---------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       | 19 ---------------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |  7 ------
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |  7 ------
 drivers/gpu/drm/amd/amdgpu/vi.c               |  6 -----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 -------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 10 --------
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  6 -----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  7 ------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  6 -----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 87 files changed, 639 deletions(-)

-- 
2.55.0

