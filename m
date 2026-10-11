Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442F1CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5F310E07E;
	Sun, 11 Oct 2026 20:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YXZzLRf7";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A115110E07E
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 20:18:40 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a168355946so9567965e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791749919; x=1792354719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4r0SiIrdQL6I+if2NfEB+Q+sc22abdmSIZUKGGUGERQ=;
 b=YXZzLRf7msYJQn2opPnGpqwrQ5bV0c3T2Vnx+l0enrXFcQdQBX1Y892M6OvofWwi+X
 3yWU//cfKCNZGedb/IklBGHbBHvmvd/gqeB2rPPQ3jvngGEXEtWrSpWbj6LOD7Qzzq+g
 5A2LJ+KOtOUxOI1lyURvXDk7LXbBoVqBNSV7vxHb7u/JEuQEimKmIInfF7pa5MwEGzRR
 ZpFMxa9WjgY5mD7VLJA2ZKNofRhZX31G1gP/olIwwBEJEpT6O/qtJBFUGFtCRmkd8Twq
 hPPLkJTPZQi+QMyrMrMCeCk67xwCVYHaIm1mKdS+qFLcIPVF3P15AhGHvB4Zu1nOndkI
 BbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791749919; x=1792354719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4r0SiIrdQL6I+if2NfEB+Q+sc22abdmSIZUKGGUGERQ=;
 b=oXbi4ufi1sinSDNq9MHtDqCEKo4EwOIO9s7G8/s4C57FAkEa0iMl/658eNY98AZTWN
 Pj03vXCgnLfkmSGUVWDcz0cZ6Us2/pKqLwJFYM9wqQYUseSS1N6u18DCx4zL/vlApM0F
 vDf0Tx3DlRz648SeGACtEp/HrJ7Xel6gkxK87J58y2U56CONwCcTGP8IMeGOoLwqrZ4X
 ZbafQxgZKYc3oGT7f946Be8Wo9KJS1Ku6eU3m6yCUDEXpilNj9bdFmq7l1ShYSlelRtB
 i8lsHIoqAAQdwIqR7yIui59ED1vH0Vi2iAONk76GCugGnASs4K69E7yu6jN2Wk+O+q77
 R9zw==
X-Forwarded-Encrypted: i=1;
 AKwUvByEkv8Gcc7lapRUee0JRqQaWHcEDp4beif2yVI7gXd5n9b3XbiKt/Qnr6tPmjexycSHjQ5BEgvLJ4k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3On9PB0yeoiJ+/nG48TRIAKCy1TIugFz8BEUgJGi+bTh5VNKY
 rhAyeCc8RezOK5lhZaa2FArANsMD9kAOZwMLp1g8f/px3j/yKJflk1aQ
X-Gm-Gg: AYBFou2pIqHjE0PDGGMahLH+d851424fBsQ+Yljn6ubFDkIwpHqFxVX1NxZc1Dk9pPz
 W9l2CqR8akab+aF0CdG2fnOVz8ZeZNdLv9Ttub6AcHT2qJRQvqcKwUDJ1v0VrsHh9MfcguE78ro
 q93uSytIDjrnWw6utsO0t5gvppYbfJBfvUG0VsXaEs/iw1WdvKHfG00XQtcpbvg94nW/YbO9Wai
 Pf9/8xiCj+Vmocdfblqtz2w8zWjWARS+eZlmaVLU3eXSCCVnY/tBw7zQBJFTfEnJs7/XFHjNu+v
 zPzeIyMKeVelOX9O5uyvJ6JXIh/1fzEIaCafj37ob260O00h47Zwl+b7egcB2oJLkYP5C7iutg3
 URUdqEMcbz1cL6UPGqt3zs2EBwPmhBcU3dNQoV7G2L80i+QO9skTfqomlFFfWRaV1NbpgLIqutp
 ye5ITwpmogKXwv9fUtbnD6vwKjRH6HWNJDAsQ4yqsOAhxdicHSgT27Q60S3oRzpQFdRHSU3BO7C
 hpBhmi6Y/9maHow638wMXqeikPcoKUPJcwHcqz5q/R3eOX1ZHtC01PiGcD2hBMltCgVeqY=
X-Received: by 2002:a05:600c:3e8d:b0:4a1:7701:f863 with SMTP id
 5b1f17b1804b1-4a18e4aeae4mr132796155e9.15.1791749918639; 
 Sun, 11 Oct 2026 13:18:38 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf1358asm237348495e9.4.2026.10.11.13.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 13:18:37 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption
 on DCN32 at 120 Hz since a637a140ab86
Date: Mon, 12 Oct 2026 01:18:33 +0500
Message-ID: <20261011201833.853907-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260919200820.799243-1-mikhail.v.gavrilov@gmail.com>
References: <20260919200820.799243-1-mikhail.v.gavrilov@gmail.com>
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

The band appears while DC switches the memory clock through
sub-viewport (SubVP).  When SubVP is not in use, a kernel that contains
a637a140ab86 shows the same low rate as that commit's parent.  On my
display, whether SubVP is used at 120 Hz is decided by a TV setting,
which also gives affected users a workaround.

Two runs on the same kernel (7.3-rc6), the same TV setting and ordinary
desktop use, differing only in the refresh rate.  SubVP state and the
memory clock were read once a minute from amdgpu_dm_capabilities and
pp_dpm_mclk.  SubVP never changed state within a run; the memory clock
stayed at 1249 MHz for the whole 120 Hz run and moved through all four
levels at 100 Hz:

  mode     SubVP  memory clock    events   eligible  per 1000 (95%)
  4K@120   no     1249 MHz            5   1,582,072  0.0032 (0.0010-0.0074)
  4K@100   yes    96..1249 MHz      139     712,333  0.195  (0.164-0.230)

138 of the 139 events at 100 Hz carry CRC triples that occur nowhere
else in the capture; the remaining one recurs seven times.  All twenty
DTN snapshots taken after events show watermark set A at the register
maximum and a calculated DCFCLK of 400 MHz: the SubVP override in
dcn20_optimize_bandwidth() and MIN_SUBVP_DCFCLK_KHZ.

With SubVP in use the commit matters.  The parent/commit pair I
reported earlier ran at 120 Hz in HDMI VRR mode, where DC uses SubVP
(the revert kernel's DTN snapshots carry the same two values), and
measured 0.0023 against 0.0807 per 1000.  Without SubVP, the kernel
with the commit is at 0.0032.


Why a TV setting decides it
---------------------------

The LG OLED42C3 offers "VRR & G-Sync" (HDMI Forum VRR) and "AMD FreeSync
Premium".  With the first, the EDID carries the HF-VSDB VRR range 40-120
Hz and no AMD VSDB; with the second, the HF-VSDB VRR range is zero and
an AMD VSDB v2 with 40-120 Hz appears.  amdgpu_dm_update_freesync_caps()
takes FreeSync on HDMI only from the AMD VSDB, so:

  - HDMI VRR mode: the stream has allow_freesync = false, and
    dcn32_allow_subvp_high_refresh_rate() permits SubVP for a single
    display at 120 Hz.  amdgpu_dm_capabilities reports sub-viewport
    enabled at 120 and 100 Hz; visual confirm 16 draws red at 120 Hz.

  - FreeSync mode: SubVP is not permitted at 120 Hz.  DC finds no
    p-state method (watermark set A p-state 0, no visual confirm colour)
    and keeps UCLK at its maximum, which pp_dpm_mclk showed for six
    hours.  At 100 Hz, below the 120 Hz threshold in
    dcn32_assign_subvp_pipe(), SubVP is used in this mode too.

  - 60 Hz, either mode: the switch happens in vactive without DMUB
    (visual confirm 16: magenta).  My 60 Hz runs measured between 0
    and 0.025 per 1000, one of them 0 in 1,290,588 eligible frames.

All my earlier measurements were taken in HDMI VRR mode.  The line
"FreeSync: enabled, range 40-120" in my original report was wrong: in
that mode amdgpu does not enable FreeSync.

For affected users with such a TV, selecting FreeSync instead of HDMI
VRR avoids SubVP at 120 Hz, at the cost of the memory clock staying at
its maximum.  I have not tried amdgpu.dcdebugmask=0x20000
(DC_DISABLE_SUBVP_FAMS) in HDMI VRR mode; I can if that would help.


The question
------------

SubVP is carried out by the DMUB firmware, and DC budgets the
firmware's reaction time when it sizes the phantom pipe's MALL region:
subvp_fw_processing_delay_us = 15 and subvp_pstate_allow_width_us = 20
in dcn32_resource.c, used in dcn32_fpu.c.  a637a140ab86 moves every DMUB
window -- instruction constants, stack, BSS data, mailbox, firmware
state and the rest -- from VRAM to GTT.  Is the firmware's SubVP timing
sensitive to where its memory lives?  Asking, not claiming.

DMCUB firmware here is 0x07003300 (7.0.51).


Also
----

A second user reports the same on an RX 7900 XT with two TVs over HDMI
at 120 Hz and above: from 7.3 on, not on a DisplayPort monitor, and gone
when he locks the GPU clocks.  If the lock includes the memory clock, it
stops memory clock switching, which fits the above; I have asked which
VRR mode his TVs use:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5714#note_3692576

Two more corrections to my original report.  The DTN "CALCULATED
Clocks" line prints DC's calculated requirements, not the clocks the SMU
is running at, so it says nothing about clock transitions.  And a
snapshot taken seconds after an event cannot exclude what the firmware
does around a switch: with SubVP it lowers watermark set A when the
switch starts, so "the watermark sets are configuration, not
instantaneous state" was wrong as well.

The GitLab issue has the same data:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5714

-- 
Thanks,
Mikhail
