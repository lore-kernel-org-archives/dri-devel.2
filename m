Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB6BC5DF9D
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827BA10E5E2;
	Mon, 24 Aug 2026 18:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5WggGcj";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5458310E585
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 18:31:46 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so497808a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787596306; cv=none;
 d=google.com; s=arc-20260327;
 b=Zcdli2+boeuw5XVvhqJPNUnzBmmpzshn28oUUIGzGaxlgJRuw/FP8+BSTz7zTHtun7
 txDGX+ggIA47pnlXmQrsqPEzY8FtOFQKW+iLN1SeScREPr9K64Qh82Ukj84ostidr9il
 prVHXYpZArlE7c/9k7Rx7T0DgcHu43Y37mSZW1AfGWmafzJ1jRS4Sg89xtnOcu9HjZV6
 Ctuzn674hOjXeRPxiPzie4R7g3uDdTI2LuL8VXQ9UmAsYOigD9NcPutl+g5XSs3FwOj3
 FlD0bzXLYLfIMkRnlBsQaX9gjrHBK9jF5xP1YgIHUyNRbkHeZ23ysdZARKorwIEGnyM5
 0eHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJtoyxpAuKAFerPlGSQxOgsaspj02cFCH/n6OuEN4+I=;
 fh=91aHnUN5mjJkVsSIPBJ6rxU8PngIRUskUHqb+3uSS0M=;
 b=Qa5OU6eUF3lWF4jKicZROxzTUMpNztVs7pBSyv6lwCDSWLuHAssSQ4OQL8yxz1I1lH
 9jNYAPBlOCMfJUrPrKWwT1SdbVaSR9Z6RjhXt+vFIyxXjWTIOB5zvX1R25EqLz0BliJH
 0dJo4HR7g02ZsCVj3JEkZUAOLuYt739eUu2cmkMm2/XGUdLsdvVWUa7tL+GRTsy3vKcr
 XjBr3VvKvZz1G1vcrTSzm1eBk9i2gX4NNa2HbqHsCxUL9N0niFn/ea3zHOC/VcYMrZrb
 t26Iyj3t6sjteZPTfBRXNGlU00FawotuALezBmZS4Co2Yf84y0H1Eq2b+TCDUEndMbhm
 ciRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596306; x=1788201106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vJtoyxpAuKAFerPlGSQxOgsaspj02cFCH/n6OuEN4+I=;
 b=H5WggGcjFVfRvT5zh344lOA+bNJcVyvjZFVqr5o6ZlJGW3AsrXtDovba+RyyxmFY89
 0Zv5NCvdauE2ehUXzHP3G5eojgkBK+3/QRxk6T/BR/w6qnAWJXU7ka4yn9FQU+VWW+uL
 +2iJXFxDYu9iSEJq/btRdwnJpPDPVRmlOrutrAg3v64NOoCfUgbxEaOWU1A+qC2TGZdL
 g5fPlIJIhp9Z8sBKy/aAuu8Qn4ZnOX7hozrCGp3AjKXGI3Vv5Fy26tyQdFarK0VeSms/
 uFrM8wpKyBl2MaDbgUGrWRqLPwxUgMbAEGS4oo8AYlXdxl27SoLUVVs/aS+dhRewThTM
 JZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596306; x=1788201106;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vJtoyxpAuKAFerPlGSQxOgsaspj02cFCH/n6OuEN4+I=;
 b=pfH9Z+SZicWNRdOLZaJQqmS41szjNvkYv1RAQApzO1prhlami3MIkKuo3FYf0LH52r
 dQ9o3+fJwwtjxD675EMjk+NJOPeTPmFY4/D8sGFo2OmN6ShvBrOy2zvWFdgfBdaqVwtl
 Vqlqjxd94AGzho1MVEY/bRqgSwwWBoIQfGS1TxtDqs7ny+B0ITk7b2fh/WgcAOfVW/Og
 oZ4yUpykYfhk2MBMw7d1oxd9yvUQQoqjygkSLSOos1YnNkP815w8U+4CNbPr7lD8B/AB
 t7eBmPyf32QtzkrjC6n+cJ/1Teml+NMSwo/Jlm5VVBL2db/47BdxluaZpHbieT+9snNL
 qKCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK1ilkzVM1XZeX8S8Wj2Y+K7zVYg2UpPKp2gGtm6FkL2Xo8yUiAeFwt3DlpcosnTR6XDNmepzZfH8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kn5LGSmmUVa7dJd+m8uxtoXr3ncmWrVljamNgDbZqG3Rbu93rR
 hHJLzZofcr3WPou/sVAMSzFWccifftcPN68eZuWFLp+NC2QZeA0MoJN8Ip/UgSCouLi5VjPXOVl
 SIxj/K/qqSmENfuBg0b/8IMQGSOBkpL8=
X-Gm-Gg: AR+sD11yXWTibjv1N3vIFvQaZzkS35xw0cGdxPxH2ot+6hjv223vnWPCypcsSSVZZmn
 dmDBRMCAScsIaDKVZuegGLsOnjmf9fZDStTe8/jL3bb6nj9k+L439mj4AtW9V5fdrlIuDPLOoDL
 +S4ca10CUgy4fj9YzYpNrW6mlw0AWgJkXldU8CSfhunawUWpVuQ+qUuhgqXW9qrh3iH/QL4bG4F
 hEy1hSnlymI1YkdG0YAajqplbAkl0FwJvuBpPz5Vx0q5JUbsxMEThF/reaa1bvCrdeJiMeuaXYO
 OR9lsiUQ8vywle95DUId1VRTP6j3X6D+kFPe3w8uRNnq5amTJUk3y1AIxjjKHbfFhKvlPCa/w1N
 kJu3+zsyZQomu83RBHjVslVRBiTQkvcI71JnGV0VoGg==
X-Received: by 2002:a17:90b:1642:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-395c33b86bcmr22444305a91.1.1787596305560; Mon, 24 Aug 2026
 11:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260824153542.491012-1-pisarevden@gmail.com>
In-Reply-To: <20260824153542.491012-1-pisarevden@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2026 14:31:33 -0400
X-Gm-Features: AcwNN1UPHsH6u8MQ3-dz-R7n3llHB8rXojPRmivVrINOZe7FEthOUqaTO0ipPmQ
Message-ID: <CADnq5_MEb72btY3NtbEVgZm=H_7OV6k1xC_t5YXVM_ONrZ2b3A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback
 when KIQ is wedged after S4 resume
To: Denis Pisarev <pisarevden@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, mario.limonciello@amd.com, ionut_n2001@yahoo.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 24, 2026 at 12:30=E2=80=AFPM Denis Pisarev <pisarevden@gmail.co=
m> wrote:
>
> Hi,
>
> v3 addresses the two findings from the sashiko-bot review of v2.
> Failure data and trigger isolation are unchanged (bugzilla 219492):
> S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
> 80-140/hour for 9+ hours with sched.ready true throughout; holding
> GFXOFF off across the S4 cycle produces zero errors.
>
> 1. [High] "VFs and interrupt contexts silently drop TLB flushes once
>    the threshold is reached" - correct, and fixed. In v3 the latch
>    only reroutes bare metal process context to MMIO. VFs and IRQ
>    contexts keep submitting to KIQ exactly as before this patch, with
>    per-failure logging, because they have no MMIO alternative; there
>    is no longer any code path that drops a flush without attempting
>    and logging.
>
> 2. [High] "KIQ and MMIO race on the same invalidation engine if KIQ
>    recovers" - this remains the documented open question; no code
>    change in v3. Our analysis: once latched, this path submits no new
>    KIQ commands, so the exposure is limited to already-queued stale
>    commands and the recovery transition window. The engine serializes
>    requests internally, so the realistic worst case is a lost flush
>    request caught by the existing ACK timeout ("Timeout waiting for VM
>    flush ACK!"), not silent state corruption. If maintainers consider
>    a fence necessary (or a dedicated invalidate engine for the MMIO
>    path), guidance on the preferred mechanism would be welcome.
>
> Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hold,
> per-instance counter, irqsave, VF/IRQ restrictions, MES error
> propagation) - all from bot review; v3 (this one) fixes the VF/IRQ
> drop regression the bot found in v2.
>
> Also still open from the cover letters: the alternative direction of
> fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead of a
> runtime fallback. Happy to run tracing on the affected hardware.
>

If that's a problem, that should be fixed.  That said, did you have
any success with the branch I proposed?

Alex

> Patch 1/1 follows.
>
> Denis Pisarev
>
> Denis Pisarev (1):
>   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
>     unresponsive
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++-----
>  5 files changed, 114 insertions(+), 33 deletions(-)
>
> --
> 2.55.0
>
