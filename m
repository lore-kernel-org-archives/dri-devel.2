Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311E606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ecdlukeG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2088B10EBCF;
	Mon,  2 Nov 2026 08:04:05 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710DA10E3B9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:00:20 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso12929715ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793556020; x=1794160820; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GKME2n5l9JpnC5UjER0UuCGrO/DweG8b5PbwFPOpgjA=;
 b=ecdlukeGuLNYLJoV2XBvdl7v2MVDeBhDc7N/sklHGnnOu//rwzdynuHNLl7JsbGrod
 6Yh0A0mE3gx3xptcEt7ttiOwm6RXEmyVUyqmCAavTtHIrbpNyZQwWy04cxrOcbqEJQgl
 dGgd45npFWjdSBxbtnQwDMx5wW3V5qz2pufzuoOYsSCyLswvSy672Rn0YYH1ldGFpiY9
 Dqf+oCX2KX2eOS+BQl70Mn5AFvLNb8KjkrLqLS75MGdC0teNWhZJXhbIbmIqN/6rlWEp
 68yzDlG+r7W/0Nuc4xI8JRAAfCsjN9/IluyvUrxNRmVwqBCHuNLoY2d577JYKiBxVLNo
 fHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793556020; x=1794160820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKME2n5l9JpnC5UjER0UuCGrO/DweG8b5PbwFPOpgjA=;
 b=Kz57usIAmlp6mKch1Lj07p3DqiaQPnxY590EBFIEVt/HMPTCTzJ9wZpArZHqqawgRr
 fMZr4olzQ5zQ8qkeyBJYXwgHXkigr/ECbLH8q9CSmwb/ahVWCWefQX65p9X+45KzTsnC
 zJxRkQCEKgbl/ZU/VOCOsXrIPPlaQp0/hLutYeedMGvnskALBdx3LPxC8iWPIeVMF3Cb
 oO2f8cqgW7/+BJMU7DFLcGPK0AOxPnlxfpVB9U9lWu2EVZANyxymybxTrJtt0hoNfpqU
 VtSzlLQxSJU9xPeAlTCiv7Rw+VVU3vKwDSdT1Ll9AMDZaIRNBq1KlkCov0Q4iAHUDItR
 41Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfKqmRUWDzSPwj70igSAq3mvvV0AIMCnuuxoerGxx8hPGFkT8TuTwQK4QMR3ZZTwRPfwVgYMOyPdY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8gp6WlhcOO8zswEs3Va7k9LzIv8QUdSlLx3A5pZE3Z+390pHFj
 D1uOyfROtRHBvSAH5dBGZRBREXRnFOc2Ix2KPVelCqbL6yTTkoqIFoWl
X-Gm-Gg: AYBFou0yU37RfpPpWxRXh9Pa4eZDS9ka4zqvYbOrUPUM6XisWNwe+EldtRQDqcx2m/M
 BxhmQZ0wJ3pRu1LA4BXmEYzYwSBCsbtxuY/0bRbdQhFhdrmhOtngz82vkwn+4/i9Wduds0I7mvk
 tsNgG+dFAMPz0b93FyMeaD2aWDQ6Spkzc1Jex7jn8VsM+0V4lDHSR4CtD2YyuYYXmrRsteuoU5l
 1h3DO1t1I4Tki5XMsQalCpBZXr/uugCuo7UhzlFsn1XdZKbRWP3a8hJMmnI3MDqc38noYyjP+tI
 M7DJJ5bPrd4riDpHV1eQmdGQGqBMKDR/d3QUm/N8qC7nKVOi8xbNMrUs0SY4ao5cRzrHZmtkfj4
 BZzyQasPsPKDslq7rmvA06pdHl6fZb1HFG8GPO72Y2+p9o08bbv8fY6ucXnUtHtXTOJnakOwrkC
 Doe0EUWN/rfOn24jXPd9OJlmCLjq1RtRb1mbSZu4k7vtncVXnkTlGIn7HVbS9LX2EYchx885I90
 eMURTWkxgEilBOx7RIIO9XsmlK9zeaiGnZAgWLlHeUn9oqr4AJMKi27ibbss0O1y/rNXlmJXxFw
 ITGXeM2X2FpCReP3lvbZcg==
X-Received: by 2002:a17:90b:52c6:b0:3ab:be66:ddc7 with SMTP id
 98e67ed59e1d1-3ae897ccab8mr7985472a91.10.1793556019773; 
 Sun, 01 Nov 2026 10:00:19 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e949077sm15194159a91.9.2026.11.01.10.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:00:18 -0800 (PST)
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Subject: [PATCH 0/4] drm/msm: fix GPU recovery deadlocks, add a8xx crash dumps
Date: Mon,  2 Nov 2026 01:55:49 +0800
Message-ID: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an Adreno 830 (SM8750, OnePlus Pad 3), GMU wedges sometimes left the
screen frozen until a reboot. The wedge itself is a separate, still open
issue; this series fixes the recovery side, which should clear a wedge
but could deadlock instead, and adds the crash dumps a8xx was missing.

Patch 1: if a CP page fault arrives while recover_worker() holds
gpu->lock, the fault handler reinitializes fault_coredump_done and then
waits for gpu->lock, while recovery's GMU waits (HFI and OOB) wait on
that completion forever. Recovery now skips the wait, and the fault
handler skips the capture, while recovery is running. On the A830,
3 of 3 recoveries that took such a fault hung before this; with it,
3 natural ones all completed.

Patch 2: when devcoredump is disabled or can't allocate,
dev_coredumpm() frees the dump synchronously, and msm's free callback
takes gpu->lock, which the capture path already holds. The put now runs
from a work item.

Patch 3: a8xx had no gpu_state_get, so it never produced a
devcoredump. It now takes a memory-only one (rings, GMU log/HFI/debug,
HFI history), without reading any register, since the GMU may be wedged
and GX off. The GMU part is a pure move shared with a6xx/a7xx.

Patch 4: adreno_show_object() ascii85-encodes buffers in place on first
show, without a lock, so two readers of one devcoredump can double-free
a buffer (free_large_kmalloc "Not a kmalloc allocation" warnings).
Rendering is now serialized.

Patches 1, 2 and 4 carry Fixes: tags and Cc: stable.

Testing, all on the A830 with the series on a 7.3-rc5 based tree. It
is based on msm-next, where drivers/gpu/drm/msm builds W=1-clean:
 - IGT msm_recovery gpu-fault: 6/6 recover, each with a complete
   devcoredump; with /sys/class/devcoredump/disabled set, it recovers
   instead of hanging.
 - Natural GMU wedges during Bluetooth audio playback: 8 in about
   47 minutes, 3 with a CP page fault during recovery, all recovered in
   about 0.15 s, no hung tasks, dumps saved.
 - Two concurrent devcoredump readers: 16 kvfree warnings in one boot
   before patch 4, none after.

a6xx/a7xx: build and pure-move review only for patch 3, I have no such
hardware. Tested-by welcome.

Not addressed here: msm never calls dev_coredump_put() on unbind, so a
devcoredump still registered then can call the free callback after the
GPU is gone. That predates this series.

The fault_coredump_done wait was introduced in the review at:
Link: https://lore.kernel.org/all/CACu1E7EApr6Ne3XxFv4cUa2JuwNW2kfo1c5wSsAUN78iWyQ2sg@mail.gmail.com/

Nico Angelo Dela Cruz (4):
  drm/msm: don't wait for a fault devcoredump during GPU recovery
  drm/msm: free the crash state asynchronously
  drm/msm/a8xx: add a memory-only GPU crash state
  drm/msm: serialize devcoredump reads of the crash state

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       |  7 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  7 +++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 47 ++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c       |  7 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  3 +-
 drivers/gpu/drm/msm/msm_gpu.c               | 33 ++++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.h               | 23 ++++++++++
 8 files changed, 112 insertions(+), 16 deletions(-)


base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
-- 
2.53.0

