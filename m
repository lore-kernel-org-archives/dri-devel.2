Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDE606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oE47swOD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B76310E337;
	Sat, 24 Oct 2026 22:59:02 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421D310E15A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 18:39:17 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-9196d8543cbso11949666d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792780756; x=1793385556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EbTcPP7Zeb31nA00sj2sJMZP0sGFPUV33RO30j2J9fY=;
 b=oE47swODhxTAQDk0aHAOuFbFEk5mjSuMMPbwhcDZD3W1H4TvBs5Pm7S4+lPgVavWvY
 pR8rfRxJhlKiDKwmLECKIDfCGKVjems7TXVAFzL2BUmc3WUexccG8jEdPT3ayeRjUXmI
 QVxxXP0knjCvO+ElaAmFiHVI2pccwoUgV0+Tw+D9wf/OhvttwcTQTgwh1sqSWyHhR0Kx
 BVqmEL1NaWlItQFiN18hst5z4uwf2UIoDZODXuzQ0dZPhA11nxzxfDufSBu2vf5o7uIi
 V34xZmgoirRb51sUVs8HtPElh/E0Qxjo9dRoz/Aud51EFbPZAE+Z24i51PEbK+MMwkup
 9Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792780756; x=1793385556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EbTcPP7Zeb31nA00sj2sJMZP0sGFPUV33RO30j2J9fY=;
 b=O8UwOlxMPj1uNnR8rHiPylq6s64g8hWJFvI0lWkJZEKBhfQw7rkbSc0AxwVWdtHsfl
 k9xtvNfVvjHSPwwyQJVhlOMZ5TSljzQnyNGLUgsVsrLbhYYgiqZUllnywN0xSzU+jNh6
 h8mrzUmWLvbWe4n6k2N6nurtajyIGZBANYCv5L33IXdaU1+lhtPEZQmve4UCfTBOpWHu
 GcQVZJ1kZ1TTBeRXjXcyVrNj1omoG4aR9Q3q20vAWeBbHeVNd1/An/vOm6MpGQCBs308
 gmj0Ze9OeOvvVK+xvEpuqDNoQsDTsTjnYzraONYWNRUmSzq2b+LA14p2uD0VwWeM45pg
 hRNg==
X-Gm-Message-State: AFq9FYIa0jFFTedGMkzRNIs9JCABHadSsskH8x/w+D5tjbefj9zNvT3P
 whhMybR1urgL2r737UVcNvnvLtZT0ijOzXBAKdKOa6RS7N+rFH6OR3Dc5v2g3eOLJNk=
X-Gm-Gg: AYBFou0khkBCMND563jMHkcMArTe6RWIsMvn0aBdi7aNQ3Qoxl6GBv0mA2Havctn4LV
 nWc4dfJwRkTfpqbqkd3IpWtX+KRAmDryyD3ot8U9HjtwLRdh2zSqaCw09weaff15Mnofd+QrvOD
 hbmYxuu05C4m4ADS10/Waq1/qijv7RzwODJkP/avEzzECnhlwg74Kwb29SKZ01XfELCs79GIi3g
 j7R17Q9tVQFbz9FJOeKJWohAG0ap5vFC77lTOnwoQ4hpEDMBNCAC2sIthBZ7fmEGex+GJHOw0jn
 4+uvdUmjJ2FMpieWCKBTlS6E/h06g7ZQhEe6ltpjhBAR8hwd0AjxRxZE6VmhE7e9F/KlolUvIbk
 hekpMTKnxFKBJAlvkv/GIYZe1mu0q23K8bqBej6CZ4CygjxBrLPsQJSe1RQZ+SB+1cusdP4Z4ma
 3jIwKsl57vakHBlZUIcOahdICRA0s3saLsqGsx1IDtarMbmuHoh34HKsiDekaIA3lINez7q7WKB
 qCbkGYOA+GRZnQMvVi9fxCWiTDvpd8xTw6y8NM2hbVysLvpZ7Jk5PWFkk83BAqUbFfC7EBay95J
 7t5NGfO62tZnecouJQWI46ILR/4CBTLz
X-Received: by 2002:a05:6214:d65:b0:91b:5d3a:f127 with SMTP id
 6a1803df08f44-91c3aa06456mr43947506d6.50.1792780756045; 
 Fri, 23 Oct 2026 11:39:16 -0700 (PDT)
Received: from localhost (h159-112-31-107.euclwi.broadband.dynamic.tds.net.
 [159.112.31.107]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47cd9dcesm1497096d6.42.2026.10.23.11.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:39:15 -0700 (PDT)
From: Christian Cortner <ccortner@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Subject: [RFC] drm/msm/dpu: glymur (DPU 12.2) second DSC block at +0x84000?
Date: Fri, 23 Oct 2026 13:39:14 -0500
Message-ID: <20261023183914.6984-1-ccortner@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This is a question about DPU 12.2 (glymur / Snapdragon X2E) rather than a
patch. Short version: on the internal eDP panel, DSC over the DP interface
gets as far as the sink accepting the stream and displaying nothing, and the
vendor's shipping Windows driver suggests the DPU has a DSC register block
that dpu1 does not model. I would like to know whether that block exists,
and if so how it is clocked.

Platform -------- ASUS Zenbook A16 UX3607OA, glymur / X2E, DPU 12.2
(catalog/dpu_12_2_glymur.h). Panel: samsung,atna33xc20, 2880x1800, 10 bpc,
120 Hz, eDP. Link: 4 lanes, HBR3 (810000). DSC 1.2, 2 slices of 1440,
slice_chunk 1440, target 8 bpp. Tree: 7.3-rc based, with a local DP+DSC
implementation (upstream has no DP+DSC path).

What is verified, so it is not the DP layer
-------------------------------------------
  - PPS packed and written to 0x184..0x1fc, byte-identical to what the
  vendor Windows driver writes on the same machine (HB 0x7f1000, per-byte
  ECC parity, 22 PPS words, 7 parity words).
  - COMPRESSION_MODE_CTRL (link block +0x180) written; read-back matches
  the written value, so +0x180 is the right register on this silicon.
  - DTO programmed (count = pclk_per_line; ratios 1/3, 8/30 and 5/12 all
  tried).
  - Data width 480 / 960 / 1440 tried; common mode with and without
  MULTIPLEX.
  - Sink accepts: DPCD 0x160 reads back 0x01 after enable.
  - DPU side reports compression active: 2 DSC blocks, common_mode 0x7,
  bpc 10, bpp 8, CTL_DSC_ACTIVE set.
  - Panel stays dark; the compositor re-prepares DSC 148-264 times per
  boot (12 measured boots, median 169).

What the vendor driver does --------------------------- Target:
qcdxkm8480.sys, PE ARM64, sha256
cc4c7ff9d09bb3aabb46e24937a66a6d927f28d0189e7517d5f53afa9e98afe7 - the
display KMD shipped for this exact machine. Decompiled with Ghidra.

  Its DSC page writes (FUN_1401ce660, called from FUN_1401c2508):

      0x000  read-modify-write, mask 0xffffffc0, 6 bits  -> COMMON_MODE
      0x004  one enable bit                              -> ENC
      0x008  value selected BY LINK RATE                 -> PICTURE
             RBR 162000 -> 0x300, HBR 270000 -> 0x301,
             HBR2 540000 -> 0x202, HBR3 810000 -> 0x103
      0x00C  written                                     -> SLICE
      0x044, 0x074, 0x084                             -> RC thresh / QP

  That is the v1 map in dpu_hw_dsc.c (COMMON_MODE 0x00, ENC 0x04, PICTURE
  0x08, SLICE 0x0C, RC_BUF_THRESH 0x3C.., RANGE_MIN_QP 0x74). The vendor
  driver writes nothing at 0x30/0x34/0x38, which are DSC_MAIN_CONF /
  DSC_PICTURE_SIZE / DSC_SLICE_SIZE in the v1.2 map.

What we measured on our side ----------------------------
  - Our encoder binds dpu_hw_dsc_init_1_2 with the sm8750 sub-block
  layout: enc 0x100 / 0x200, ctl 0xF00 / 0xF80, CMN_MAIN_CNF at 0x000. At
  runtime both DSC blocks sit on MDP+0x80000 with enc sub-blocks 0x100 and
  0x200.
  - Writing 0x004 / 0x008 on that page and reading them back returns
  0x00000000: those offsets are holes on the page we program, so the
  registers the vendor driver writes are not on our DSC page.
  - MDP+0x84000 and +0x85000 are inside the mapped DPU window (mdp:
  0xae01000, size 0x93000) but no catalog entry, for any SoC in the tree,
  describes a block there; the DT declares only "mdp" and "vbif".
  - A read at MDP+0x84000 hangs the machine - no panic, no log, just a bus
  stall - which is the usual symptom of touching a block whose clock/power
  domain is off.
  - Neither our dispcc nor the vendor's dispcc-glymur has a DSC-specific
  clock, so gating would have to go through DISP_CC_MDSS_CORE_GDSC or an
  MDP power domain.

Questions ---------
  1. Does DPU 12.2 in glymur have a second DSC encoder (or a v1-style DSC
  register block) at MDP+0x84000 / +0x85000 that the "dce" blocks do not
  describe?
  2. If yes, what enables it (clock, GDSC, power domain) and what is its
  register layout?
  3. If no, is the v1.2 "dce" block the engine that actually feeds
  INTF_DP, and is there a documented block-to-pingpong pairing for DP that
  we are missing?

I can supply register dumps, the decompiled snippets above, or any logs, and
I am happy to test a patch that models the block if someone can tell me what
it is.

Thanks,
Christian
