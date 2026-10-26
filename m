Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76C60A261C
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXNr++7J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC9210E37C;
	Mon, 26 Oct 2026 19:17:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F22F10E25D;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 422FF440B2;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793042238;
 b=nBFqff44Ud0ivssFb1irMIOBJrKzVc5S2IBJSZX9NFYTRBaKYMteUN/9YTbnkug8mIak
 MgsbiRIK48i4v5XF8OSwLBsxyIH5/ckZsGhf9axlegSS83u+myZeXBzayjNGJ4cvLt9tl
 Kltdc6Vj/FNMHZJyv3ZFw1HclxQLfnETFWGdnATgYCiV/EkI5Ziw44etVIf1CWAfZByEX
 59SkwmjZe8qL0/PQdm2je84M4EcH+9vBAH8aaIdq6jKmcxx+HLcdKi99R3w/lwLcuYWIx
 2esxIQh1c75KsY1snCTFGLhhj8jLKhwSzPr5Jc5VFhYk4C6N5RAfAbT5QtJLh0j4R9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042238;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=BFNR2zEuFWUHNEKMapOFEv7Vd6aMGzRgK3IoZeYR9FQ=;
 b=XA690yw6qSlefLE2K3Ti04z81ai/OoOibgkJBGOWWNq8uVbbDjDXsrFXnJTyzt1P5Hzl
 ib9+RGTB8oqyCOBPWgPUo2hsHeeTxep12lyFqfAXFA010lIsaeBcf447CQ8h8ovjJeNBg
 tgDfciSgAo2T9GyglECU0cJ5IqtixgS5tuAiuo1B373+ChtsVU3S9EdoImNhleYT+Hk23
 UYGN9+zo0aqxcEeNHM/SeH2POG/NyiOV1kRjVLW96edTf38S419Dg0B6n7VZGyTgqKQ2P
 F+5kA5o4Kp3zfxbySMZS6wPo/pCpXdJSD05XJbV4QS9v15U1xN+r6epQkE3FJ78sRyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 413451F031E2;
 Mon, 26 Oct 2026 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042238;
 bh=BFNR2zEuFWUHNEKMapOFEv7Vd6aMGzRgK3IoZeYR9FQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=AXNr++7JYkoaLWBp9wdez6fAE+uzxmg77AU/HRPB7Z09SZ+stJrt5jMruZcdDejoc
 P5Tl1mjJCh+lKJ4z94EmugZ2Zh9NhENgZ4zlc3Gx0Za1Ie3jYEhamh/7esw4aczC4w
 xiW+xXs06UXeQyWetnbXweCoXvXZfJKOgO1f+rC5EU+P+3lLvuTFRnOnI0xkJzfyC/
 KvwqafcXQlp6G6OQiiMQe7+E8c/t4KwqM0dB+Yx1Mp+8beySkT+b0bnndWSPKNuIY8
 8bRSKsyXZVY4EEED+UK9RjdqNoJu6SCeQCL5hWzUUNFS8xpQcjg0QzHxpzyKz0VKO/
 Cc8Kzy0PuO+Kw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 95F3144E44;
 Mon, 26 Oct 2026 19:17:16 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Subject: [PATCH 0/8] drm/msm/dpu: various dpu resource allocation/release
 mismatch fix
Date: Mon, 26 Oct 2026 16:16:48 -0300
Message-Id: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINbNLc7VTSko1S1KLdZNzklNzNNNMzQ3MDE0MDMxNU5TAuorKEpNy6w
 AmxkdC+EXlyZlpSaXgAxSqq0FANyDXEd1AAAA
X-Change-ID: 20261026-msm-dpu-res-clean-f1704106453f
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Xi Zhang <xz.ca.cn@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793042236; l=2550;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=2/d8EjRzSoHnBXV69zMC8k8JvAq0euVt9rPufF4ekUk=;
 b=tvvfgQt/49+WodVm0S42JjyPwwc8dvflO44G5lU42tTV1BsYKYjcRhW818+MdktdvZlgpqz5g
 baRO9hlmGxHBs6CTqblKd9jO76mCXw/oCXrD1pca4RImCz0tYtDleHD
X-Developer-Key: i=xz.ca.cn@gmail.com; a=ed25519;
 pk=aRUll5L3eJbwG8Y4BO9uySKGzm+Uy+Ccei9prnRVZRs=
X-Endpoint-Received: by B4 Relay for xz.ca.cn@gmail.com/20261026 with
 auth_id=1328
X-Original-From: Xi Zhang <xz.ca.cn@gmail.com>
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
Reply-To: xz.ca.cn@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes various resource de-allocation issues in DPU
resource cleanup code. Aim is more reliable mode set, in particular
when multiple displays/encoders are connected, to avoid blue screen
or snowy dsc displays.

Tested with v7.3 + msm-next, on Ayaneo Pocket DS (SM8550 Kalama).
Changes are not device/chip specific.

Some of the changes has lived in ROCKNIX distro for a few months.
https://github.com/ROCKNIX/distribution/pull/2716

Note: The first patch in that PR was problematic: uninitialized pointer
variable field access (since fixed), and I did not understand drm
atomic state tracking, so it wasn't doing anything at all and
is not included in this series.

The third patch linked above has more changes than what's included in
this series. The extra change did not do anything that's needed.

The following 2 commits are new and are not in ROCKNIX:

[Patch 6/8] ("drm/msm/dpu: workaround res re-assignment issues by pairing enc/crtc")
[Patch 7/8] ("drm/msm: force mode_changed on color_mgmt_changed, not just ctm")

[Patch 7/8] would fix, from my testing:
https://lore.kernel.org/all/33424a9d-10a6-4479-bba6-12f8ce60da1a@packett.cool/
See original report by Stephan Gerhold:
https://gitlab.freedesktop.org/drm/msm/-/work_items/102

Note: I'm not part of the ROCKNIX team, just contributed a few patches
there.

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
Xi Zhang (8):
      drm/msm/dpu: reset unassigned resource slots to NULL on topology update
      drm/msm/dpu: save LMs in encoder mode_set for cleanup use later
      drm/msm/dpu: use common helper cleanup function in cmd mode disable
      drm/msm/dpu: Match setup_dither cleanup to the way it was set up
      drm/msm/dpu: use cached PINGPONGs from mode set in cwb setup
      drm/msm/dpu: workaround res re-assignment issues by pairing enc/crtc
      drm/msm: force mode_changed on color_mgmt_changed, not just ctm
      drm/msm/dpu: reset DSC_CMN_MAIN_CNF in dsc disable

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 115 ++++++++++-----------
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  15 ++-
 drivers/gpu/drm/msm/msm_atomic.c                   |   3 +-
 5 files changed, 70 insertions(+), 74 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20261026-msm-dpu-res-clean-f1704106453f

Best regards,
--  
Xi Zhang <xz.ca.cn@gmail.com>


