Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE9C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E853510E142;
	Mon, 24 Aug 2026 15:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEeRMA7M";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F82610E578
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:35:48 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c160420289bso534448566b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787585747; x=1788190547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7BQk+VaXHqbBwCEiciR9Pe8CWGZKMc/0gaA8PUIi/5A=;
 b=TEeRMA7MXFozA/4bwYz05ZO2CW6Lq7oys1xU/mjFIM8LcP3oYgMjr2jcDVLujFZhJP
 ik7aCSE4OK9DA2N6Paxw5o152a6wpCIw/K6kkdO/O/G7B3XaK/Ib4InWiEiwfIiM+j9p
 w7TZmjEsRJWbvmTgIxhZR5rZAq0QzRqJqtVDU5hA/ZXytDZyxliKXMSqSDi6LRfJte/W
 WzSWzCiIUF5C7YrieZOaAZOAWcXI/rOHJY+gJTvfLBQDnMz41nSUYPP+vrAS4CshPrFT
 6uiaiGLePBl9XlegFkc0MCKHoWQPv+Cbyjx5op4imoN0m+taE5oQq28mt6GOQhXJFE0/
 Rnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585747; x=1788190547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BQk+VaXHqbBwCEiciR9Pe8CWGZKMc/0gaA8PUIi/5A=;
 b=mDhxClrfuaT58nIC5L56Et+dyJU5mWZHl08gWZyzHNfS2eH6L6aiGDWom2zEWyIX7L
 ksEGj0H1xD35iR1ovyXJjs4UD9l+Q9ShGe9yjqBwqCvfwNxq6lAP/EUrKvxcY7Klb+52
 jPZB4O+nPPEQRwIYpaltBcS4RWKiDCJs2aYbx65FFeZ3gGIxR4N3eIEsUk6cltDFG2Ya
 8I9mnq8kXvdOD/6QJjmgiTUTvi2cw/EeAQvMTx6YhR9HK36qPyaMPqMuDWVF1NyCdTYG
 i38J308xPD02EkC3VLSaM53SoCJEEQ56W4ZPg6amAnGmzjwnzBHf3LM8xOWHI1/ZEbRh
 2eAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZOPzzKbMBurouwvPjnsMmQae0YVTO85KBBTBK6NZO2CbTa4K4RtMeuBPy9rbDHmnt7nY/2fDPeXI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/YtHYuMTQZfYjKMjgBKq7rrhre5qBEwQPMTUvYvMtHSzs9GEt
 AFzXavFdT0SDLFHTsgnbllc6opp9eXnvNCD1dFN2SDIG9Oc6PSECivPu
X-Gm-Gg: AR+sD12EEDLjpsSMXZvt6GllMpIhRx6Cc7W0ubXFFZYfYq6ce88ANWRtGal2K50y0jx
 UrtV9vHJdkvfbADfweyi/QYfRA4YHYW5VhjjT7BezdeLQswDXtgMdkRQvNamweLuZ5sTrs33gQD
 L7os8qfsZ7ZowjOAtNc37gHo2PRZ4+RIkfI6t5VuOjE++f8jyMfGY8ZC/ol3iO7UOR33HgiuJ6p
 R/voTTbUS3c3ycgOW0GNkQBd/EfmwrjkxzsRkMvARbsvV/1rBxDctzn85pYCPhQKOLwD9b+yIj5
 NcmMz74g0dwrU/NkzA/7bffoB7+21OT51Y7I6IQoh3sEP/ZSv9a+NW4v7hR7ceM2Dd56Chs69Rm
 kDsFDzJ4K4LQX8J2U4G1mr7ClD88awEjwD77tN1giwpbf5esp6/Tton4SWlD1nFEue/cYKw1prS
 gc6jtx79z+FAbpQwJf9yn+R3qMtp27BIsGqKbR2xIi8lSaQc4YwvDeFUfonhWHaSai77QdWn2Zr
 a3LZ0wDdDCCNlx/PD/ujhzeHvXp1Qq6ryPOFKglOM2l+/gmq7GWLcvw5pjR719OJsK2ZBU5pddB
 kuETUtv9UABCm+JYZYzs2m4KbRAaLzc=
X-Received: by 2002:a17:907:3d0a:b0:c20:74db:50c7 with SMTP id
 a640c23a62f3a-c246a697ac4mr3198662366b.13.1787585746578; 
 Mon, 24 Aug 2026 08:35:46 -0700 (PDT)
Received: from horsehead.monster-haddock.ts.net
 (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1298978666b.6.2026.08.24.08.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:35:45 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
Date: Mon, 24 Aug 2026 17:35:41 +0200
Message-ID: <20260824153542.491012-1-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
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

Hi,

v3 addresses the two findings from the sashiko-bot review of v2.
Failure data and trigger isolation are unchanged (bugzilla 219492):
S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
80-140/hour for 9+ hours with sched.ready true throughout; holding
GFXOFF off across the S4 cycle produces zero errors.

1. [High] "VFs and interrupt contexts silently drop TLB flushes once
   the threshold is reached" - correct, and fixed. In v3 the latch
   only reroutes bare metal process context to MMIO. VFs and IRQ
   contexts keep submitting to KIQ exactly as before this patch, with
   per-failure logging, because they have no MMIO alternative; there
   is no longer any code path that drops a flush without attempting
   and logging.

2. [High] "KIQ and MMIO race on the same invalidation engine if KIQ
   recovers" - this remains the documented open question; no code
   change in v3. Our analysis: once latched, this path submits no new
   KIQ commands, so the exposure is limited to already-queued stale
   commands and the recovery transition window. The engine serializes
   requests internally, so the realistic worst case is a lost flush
   request caught by the existing ACK timeout ("Timeout waiting for VM
   flush ACK!"), not silent state corruption. If maintainers consider
   a fence necessary (or a dedicated invalidate engine for the MMIO
   path), guidance on the preferred mechanism would be welcome.

Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hold,
per-instance counter, irqsave, VF/IRQ restrictions, MES error
propagation) - all from bot review; v3 (this one) fixes the VF/IRQ
drop regression the bot found in v2.

Also still open from the cover letters: the alternative direction of
fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead of a
runtime fallback. Happy to run tracing on the affected hardware.

Patch 1/1 follows.

Denis Pisarev

Denis Pisarev (1):
  drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
    unresponsive

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++-----
 5 files changed, 114 insertions(+), 33 deletions(-)

-- 
2.55.0

