Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D212AC624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D667A10EEE6;
	Wed,  2 Sep 2026 07:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pjuT5mRy";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFD510EEE6
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:32:27 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c2533d83e3bso92365466b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788334346; x=1788939146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntYqCiUGvFKb34I7pd2sH6Ev2OxM+HRkEJ74Nxn2uc0=;
 b=pjuT5mRyVblcfyDCGoefaQ6sAS33OQl8wyElTftywWSVwjAyBVIOijRug+mcFp0TvB
 sfRCIvRXxIt5GRekD1ZWtWnoY9kab/8z+e5cYWHIMVA55/aPiqX5XtUT4nq51sqBqwKl
 /aJKe3yHqphq4bWNh/zDLueoCD4ANTQoYJbJb2a0fvxwhIPEO/4/auoqbNFTtWFf6A46
 VGTxW13iEi8HjgwEFe7v+R0MktK+s6VDkfYwB5Iwghu+JoCi1M0QtryGGk3q0A8hlZLx
 dxk4cRibn7qgmdJaN688/EID9DuaeCgSnGsvDAMPWx+ADcvBlFZBjmniwYNv4JZcWuTQ
 vfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788334346; x=1788939146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntYqCiUGvFKb34I7pd2sH6Ev2OxM+HRkEJ74Nxn2uc0=;
 b=Mz9gWHiPwWeS10S+afxcRC5NytHHPkCkWxT1Y9z26Kg57eReG6EIXByZG4zFQxa1yY
 oW/Xz5BAihUdbT2Ge0DnKoRL9sEi1cN+KEA+k8Lt8Sw4IJC1CiuZiVINp2luzFpQMvre
 AIdGO+GmLVy58b5yCU/1lGPDMlG4/5LlGgdFlLmlfPXpVaM6O55NzY30YfkHB6Rziv05
 4gRqG+gAqj1YV6tjpN318K/Divrku7cEBPc/WzJcmW+Dia5HZ0vP4pfotfMpyfj4R3xW
 gCdch82SEsmmdfUQ8Di/DX1AUyikjw2ubAm4g7YIUeulnxp+9KGh+uBdMcQv665LXJEX
 FHNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvqNp6MgP5ZvJ5jsQ33ZYwV+kakTYUTYD8AvqNnZ46YOmmJHvqb4+FSJQHs/sbpwq2Cv/RbHTVd1E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++la2bysJWKd3cBMxrZp1Q3prLQU5qynKTLJQUFYvPQQKgtbhJ9o
 y7YR9maaUfu74cU330R2+EVO4tb6G/L2OUuRKQttULlCTvt4Qg2tX/hW
X-Gm-Gg: AYBFou0j4lTnlowfdUsGMJUVGZBsdo4ozVRpfOC+jDHLTiJkKR6mJD/w+GuDdpVnznW
 kXaiAxmNvY6z7wLwgXO7FJUl7ENqE5UWaHjfv6ziqlXhp2/P2iS6eCdOcDXjE6Bw8Lp+kiMVkNJ
 C9Flz06MhQn0qgbHn8DsWQPHV/GdQ1gDh/uDIZCMGjmSZ8JQ2qZWR2NTlIojO5YqfKKjmj85HYl
 xfQpV0SWJvjY1GD1PR8HUADcXajtjLPD+rKgnlEgJqHaxjWC0giS9E069ofzfH6bbHTxciR+U3L
 vHGOBXOtIsLmXt7pBR8JZSkudytQ6nFje30KY8NptWXYaQF1sj3PpFEAm1gXe02qVYksYHwLPgd
 4d1TYUjrbaTu/xoCU2HN0x0qXxKCYFfJj/XXJXMTuM6rHq78EhimZALaqXi/FAv9eLTKR19ssu/
 MEQmu4wzMWowG52Mpd/ZoJYFvlQERSqO+olVoRlLHTozuj1rSmeKzTmInrdFVlqUZNUNzXTymiY
 KNneAkeASSnWugN0D0NSL6QRuCbn2NJ2+lJ1W8iSTDDbMmojzL0cZp4myBs
X-Received: by 2002:a17:906:6a03:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25d5474dfdmr140879566b.12.1788334345387; 
 Wed, 02 Sep 2026 00:32:25 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d041d286sm78078466b.55.2026.09.02.00.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 00:32:24 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption
 on DCN32 at 120 Hz since a637a140ab86
Date: Wed,  2 Sep 2026 12:32:22 +0500
Message-ID: <20260902073222.206801-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829010525.29935-1-mikhail.v.gavrilov@gmail.com>
References: <20260829010525.29935-1-mikhail.v.gavrilov@gmail.com>
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

I have to correct my own report.

The 90x figure I gave for a637a140ab86 does not hold up.  Since sending it
I have measured five more sessions, and the rate turns out to be controlled
by something other than the kernel.  Please do not spend time on the commit
on the strength of that number.

What the artefact actually does is sit in one of two states, and the state
changes during a session.  All figures are events per 1000 eligible frames,
where an eligible frame is one the detector could have judged - the method
is unchanged from my first mail.

  60 Hz                       0.0000   0.0045   0.0252
  120 Hz, quiet state         0.0308   0.0372   0.0400
  120 Hz, excited state       0.5208   0.5739   0.7115   1.3027   1.9153

The three groups are about a decade apart from each other, and the kernel
does not sort them.  0.0308 is the run on the kernel with a637a140ab86
reverted; 0.0372 and 0.0400 are runs on unreverted kernels in the quiet
state.  Those three are the same measurement.  My original pair simply
caught one kernel quiet and the other excited.

Worse, every kernel comparison I made began with a reboot, and a reboot
resets the state.  So the bisect was measuring how soon after boot I
happened to load the machine.  I no longer consider the attribution to
a637a140ab86 supported, and I cannot say from my data whether this is a
7.3 regression at all.


The two transitions
-------------------

I can now move the artefact in both directions, but only as bundles of
variables - I have not separated what inside each bundle does the work.

Excited by: a long session of a heavy 3D game (Dying Light: The Beast).
Measured twice on the same kernel and refresh rate: 0.0372 -> 1.3027 (35x)
and 0.0400 -> 0.5208 (13x).  The effect outlasts the game by hours and
decays gradually.  That bundle contains sustained shader load, large VRAM
allocation and eviction, GTT traffic, clock and power-state churn, heating,
and fullscreen presentation.

Calmed by: about three hours spent at 60 Hz, after which returning to
120 Hz gave 1.9153 -> 0.0400 (48x), on an unreverted kernel.  That bundle
contains two modesets, three hours of elapsed time, half the pixel clock,
a different pixel encoding (this display uses YCbCr 4:2:0 at 120 Hz and
4:4:4 at 60 Hz), different watermarks, and an idle GPU.

Also calmed by: a reboot.

Which single variable in each bundle matters, I do not know.  A short
120 -> 60 -> 120 toggle would separate "a modeset" from "time at 60 Hz",
and a compute-only load would separate "GPU busy" from "memory pressure".
I am happy to run whichever of those would be most useful.


What did survive
----------------

The dependency on frame rate is unchanged and now rests on four
independent sessions: 120 Hz and 100 Hz show the artefact, 60 Hz is at
least an order of magnitude below the quiet 120 Hz state.  Forcing YCbCr
4:2:0 at 60 Hz, so that the encoding matches 120 Hz, gave 0 events in
1,290,588 eligible frames, so this is frame rate and not chroma
subsampling or link bandwidth.

Swapping the HDMI cable made no difference.

And one negative result that may be the most useful thing in this mail:
DTN snapshots taken seconds after real events in the excited state are
byte-identical to snapshots taken in the quiet state - 195 lines against
195, differing only in the scanout buffer address.  Watermarks, dcfclk,
dispclk, dppclk, fclk, HUBP and OTG underflow, vtotal and the DRR select
bits, DSC, RQ, DLG and TTU are all the same in both states, at a fifty-fold
difference in artefact rate.

So whatever holds this state is not in anything DTN exposes.  Is there
something in DMCUB, in the memory path, or in link state that could persist
across a game, decay over hours, be cleared by a reboot, and leave every
register in the DTN dump identical?  That is the question I am stuck on.

Thorsten: the regzbot entry points at a637a140ab86 on the strength of the
bisect above, which I no longer trust.  I do not know yet whether there is
a regression here at all, so I would rather not close it as invalid; please
handle it however is appropriate for an entry whose attribution has fallen
apart.

The GitLab issue has been updated with the same correction:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5714

Sorry for the noise on the first pass.

-- 
Thanks,
Mikhail Gavrilov
