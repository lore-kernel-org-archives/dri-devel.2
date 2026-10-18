Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BACCCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 22:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C1210E735;
	Sun, 18 Oct 2026 22:39:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F18710E150
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 22:39:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1ddc7c9beso5443395e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792363152; x=1792967952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvsLpFGelrgwN9Cl66Kd9LpNf+fNDOOYoQY8p06psOA=;
 b=Gm1uKLYU6uYqMSTHZ3gUazu+HDDesRttFMWQ/RpdK3CPWAHUD6JOBEsNki7Nf0zdPQ
 dVcNcUxl+Vcj9DDLAYzhUrnFxjdg4IlH5EgkBhpZC3coL6ymyyRegHHH51ES4C9jqN3D
 n/4L6s3TP2scwOEQc2XxohO0MhjeyUOFeKn1Oo8ZdKWiMM93Ttxl6juKjLzuJbLrWsY0
 MUyQ36Wr50L5mOS9zgZyQQPzlb2q6MhhnHEmXPA9nEqK86wZ+PGoBi2i8wC44xyLZU48
 EwyfRDHon/68kzfwpO4CBDpQpu78mRZkhFj41cqaOuaKqLfOk1MO2lepPgErfZZOdupB
 askg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792363152; x=1792967952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvsLpFGelrgwN9Cl66Kd9LpNf+fNDOOYoQY8p06psOA=;
 b=D/4B0h5mAHybUt9rskoaG+x/iPZEBq2X6HF+zFB3Kybj/Iu0GwDB0+AXUotnwrkk9I
 zT4g6Nsw2QN3A6aNuh4bU4smYxdsD2MAF8PgK2Pas/aeDjiGN7ps64m4ICGlNo6SJ/dO
 JvgKdmdSsnYk46GAaLm8DlBQR+R99GfphAblkX4bN3ATpdvT64zvJX0BNaepGVA2RpMs
 cJqXbYv71q5PKlaIwChZldUTVHD1upN+GD8NhHX9ECUhcD9T+HovNnaUFJP1lt2kOWgF
 j10Dz0Ael65YBrhQHIjA2M9qqtJqIAauazPoBjR7siVnFS4eo1YjJBW6nagmgrKrfwsH
 VEmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8TkXPOW8R61HWEYBxOGltyt3EUMj/dBTiHw2kdgAq0Vr/LXgeWufO3KU1ydYZ7PnoPKnJXxlk3Mg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ5frLJ8yusN4ofPbe33iUKPMWtywVuWtTTQA9JH6CwASh8KN8l
 Ze/pS+8IGhKffLD6kfc5zTuF1Len3J/YUwz5uN5pq7gyVjL1JE+m/NU/
X-Gm-Gg: AYBFou1OlALxjdd99YfQXpvm3iedIGoTt3oanFhF+emLNwkJuq4bNP4zkjTrSLaGlp9
 T+5LTimx1CfJOFqU9YgjQtI4Bl8g1cgaQxdXUzyAr6PBbqTXmdC169dszwNV2gnejcsUlYZw0Qy
 81D4WimkMKLX4Da/myNcufu4UZH4wNsB71QKLHTGy6WC9pJFbWEIoGLj7UomKEOS8lAdvAnl/7x
 mGcVIFnLez76mspv6NmCFasaMbMSbQicw7a4yV/ARuhsMYG2WCfneYJBd1Uo8ySUOVAstjbAyJa
 s70yyJPKTNJ1AMgwyg91KNR8b70q6/6ice6qprM8q31bW1Q+/Vvk9VV+DeHQZsiQ4yfhVO+DqI7
 km8P7UNxqwPtULvUR6V/bt3G1KltQm+mtGsGj3+rC/WBzdSvZbM+hNTCR0YnMWKV3xAhHriXlmr
 H9lSYdiyK+itud7ORG7G/nLCIW+8qZIYtVbFMlbcYTmr2mcbgdI1/z0eQyaOAYsj0oE6Bxcnb1W
 LzpX9H+C1Usz9HZMkpOEnJztWvkWF+aXRfxoD90E0FOcBkXCsISW3fYypGUn0k4Qn1OPBg=
X-Received: by 2002:a05:600c:8b22:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a1d760d9fcmr130723785e9.31.1792363152485; 
 Sun, 18 Oct 2026 15:39:12 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm16359363f8f.3.2026.10.18.15.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 15:39:11 -0700 (PDT)
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
Date: Mon, 19 Oct 2026 03:39:05 +0500
Message-ID: <20261018223905.32324-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011201833.853907-1-mikhail.v.gavrilov@gmail.com>
References: <20261011201833.853907-1-mikhail.v.gavrilov@gmail.com>
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

The workaround from my previous mail does not survive a suspend.  After
resume from S3 the band was back (seen, not measured) with the TV still
in FreeSync mode, because DC had turned SubVP back on.

Snapshots of amdgpu_dm_capabilities, pp_dpm_mclk and the DTN log, all
at 3840x2160@120 with FreeSync enabled (vrr_range 40-120, the EDID
byte-identical in every snapshot):

  after boot                    sub-viewport disabled, UCLK at 1249 MHz
  20 s after rtcwake -m mem     sub-viewport enabled, UCLK switching,
                                watermark set A at the register maximum
  after toggling Night Light    sub-viewport disabled again

dcn32_allow_subvp_high_refresh_rate() keeps SubVP off a single FreeSync
display by reading stream->allow_freesync, but amdgpu_dm sets that
field only on the first flip after a commit, so the modeset forced on
resume is validated without it.  A gamma change makes DC validate the
state again, this time with the field set.  The patch:

  https://lore.kernel.org/all/20261018221726.27259-1-mikhail.v.gavrilov@gmail.com/

With it, SubVP stays disabled across rtcwake -m mem.  Until it is
merged, toggling Night Light after resume restores the workaround.

None of this changes the band itself: in HDMI VRR mode, and at 100 Hz
in either mode, DC uses SubVP anyway.

-- 
Thanks,
Mikhail
