Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF1606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWDFityt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F3B10E362;
	Mon, 26 Oct 2026 20:26:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692F210F130;
 Mon, 26 Oct 2026 20:26:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C254F601FE;
 Mon, 26 Oct 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793046366;
 b=N4BRJI5UeR34mq6dWbrtmB2LNC3IpARa/Qvphmqi71guVHSQbODNyo2rcd3/8iPxqyOv
 Xu37IEdQCU465D/lmxhr38Nmr4utWi7wFC/e87/lCywzD0uydXtiHof9cYb2sthBfr6nr
 mIdL+02kO4vtlfzXwFPzjrcs3uSAZTwMD1hhJDkRtJajMKoCaj+gxemP4um0tATjm3FLH
 oz0BKc3bEDjcH8XS6dyfjfqHEwrjzdYwUknX/DQP7heQz41eSOAsQBzkCXWUr0+ePjWow
 7ZvrV6oQ8HhPW+T0xrZjGn++2rDUQ6pXE/GGXPKNs0uVCo38WLZsXLy/xIrqQijWDDQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793046366;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=U02bIyx3BCfEu09yqQK9NYbBI6VqnDE3NRZhVK5rMik=;
 b=Li1SDCXipGOCWB2bCW+4/17gtOti8j/v/yoQ1wHaYS2FQI8M6NtHJcbtEnxV+krw6S+F
 jf6aDsorI5hitZd/XJz+uD7t8/4Li18H3iEk7HFMINUHUZMuvqPkzMaCcYgE1CL97vP1X
 HyqBm/sPLi1gHx4lGYAv3JvhA+e3+7JZe6Dy611SZBE3xpkdcEKDW1oaks9StikP+1gTU
 Uu5PS+nW2PxSNT75UYh25sI/sNceckKOREPtktd5eRb3pBJG65uJbnXoKbTMNXRjXFfYZ
 H+q8ijwewis3CUq0mWXmL17NWoWimm3AwXxCFWHI5vOfeD//we9FHR5dxUH67XFJ5Pw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6BE291F01828;
 Mon, 26 Oct 2026 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793046366;
 bh=U02bIyx3BCfEu09yqQK9NYbBI6VqnDE3NRZhVK5rMik=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=hWDFitytTvzqsub0C1t9st7Lm7QyCf9sltrg9X1I5O9mpsdCvKXpowG/B1QeUO27N
 jN4tuZ9BUyNxDf/S06mMQpY7Jdcat0z71Rkqcg0fDueTM9brWEsfYhval46PDLLbmH
 eE6rfcOJwhqDHqgyGzPl4MzWaSsMuP2K9SkB9Fk6evil1FxHXKGcEXnAm8fQ7XfcsS
 9dmtEHVeRwPXcXmd9nINLXZ1K8iaUqFOKIINWnIRC8+5+9NpjqKCBGAqqQCCVdOL3B
 JXuwP4wuilyq5oxaDBpz8utouLT3oFqbVpbSDYj+wYk8ufdEFbvg8RNFrq99+2Hw95
 FB6KNPgBMphcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B4D1944E8D;
 Mon, 26 Oct 2026 20:26:04 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Subject: [PATCH v2 0/6] drm/msm/dpu: various dpu resource
 allocation/release mismatch fix
Date: Mon, 26 Oct 2026 17:25:41 -0300
Message-Id: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TVdQDCe/A/DoZYt1FAgXSAaw
 r9b8O5hDi+ZebOCcHAscEtWCLw4cUMfIT0lYFrdN4yujgypSguKQS8e63HGwIKmY92jpVLlpIr
 8klmIuzGwde/D+ah+LPPzxWbaRXujdTIN4XOcLrT3/vkXQoU2LyhT+qpLKu+N1647m8FDtW3bF
 7V9J8LEAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793046364; l=2411;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=UVZ0FP0vB3+dqaosznwwckHsKb9132cEaz7lbbhZycE=;
 b=aAAOtE8VWiLHW047vwU7KeXFOCIn5E3D2gJPmPL46lWFaVplS6WdNri9jyWpA+OslCObFu7uD
 iwPJ0J2uJYZDgTSXljBPVAp57OVVM4MZBzlmLMHja8B29eXS+6ld+vE
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Sorry for the quick v2, this version fixes issue found by
sashiko bot (Good AI!).

This series fixes various resource de-allocation issues in DPU
resource cleanup code. Aim is more reliable mode set, in particular
when multiple displays/encoders are connected, to avoid blue screen
or snowy dsc displays.

Tested with v7.3 + msm-next, on Ayaneo Pocket DS (SM8550 Kalama).
Changes are not device/chip specific.

---
Changes in v2:
- Removed problematic patches as indicated by sashiko bot.
- - removed [PATCH 5/8] drm/msm/dpu: use cached PINGPONGs from mode set in cwb setup
- - removed [PATCH 6/8] drm/msm/dpu: workaround res re-assignment issues by pairing enc/crtc
- Fixed issues indicaed by sashiko bot
- - [PATCH 2/8] drm/msm/dpu: save LMs in encoder mode_set for cleanup use later
Re-add dpu_hw_ctl_setup_blendstage calls
- Link to v1: https://patch.msgid.link/20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>

---
Xi Zhang (6):
      drm/msm/dpu: reset unassigned resource slots to NULL on topology update
      drm/msm/dpu: save LMs in encoder mode_set for cleanup use later
      drm/msm/dpu: use common helper cleanup function in cmd mode disable
      drm/msm/dpu: Match setup_dither cleanup to the way it was set up
      drm/msm: force mode_changed on color_mgmt_changed, not just ctm
      drm/msm/dpu: reset DSC_CMN_MAIN_CNF in dsc disable

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 92 +++++++++++++---------
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   | 10 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     |  1 +
 drivers/gpu/drm/msm/msm_atomic.c                   |  3 +-
 4 files changed, 57 insertions(+), 49 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20261026-msm-dpu-res-clean-f1704106453f

Best regards,
--  
Xi Zhang <xz.ca.cn@gmail.com>


