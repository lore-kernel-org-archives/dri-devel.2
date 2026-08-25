Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6D3C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC29010E64A;
	Tue, 25 Aug 2026 21:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpvoEyg7";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3FC10E603
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 21:24:54 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so26887666b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787693093; x=1788297893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwy9tP+PnAQKttwIkPiCEGglGcdL28/hF8XnKtMukdw=;
 b=dpvoEyg7ld2K+sPl7vCbpEU+/8p/tx71Ny6wYkTeTKHNwt/f9YHlPyMSCrRGitHPWk
 k406kCBbpKtPe4tBs8S6d9BlZm5NG4KfaGtGP3UAY6dHoWfSpo+ZI9qAp05rG4Dx9L8J
 S9ny5RPZQlaW81amZ+cExFpBnQyyMEf1zvnOkuGSVN2+zBHvNFfrJFWDSzMxlP0kRnr3
 rsZxJrUEH42K2F1AwCk8lMugnzZPiQZGbB9JpZJrI9aDFBhoJCdFg0WNNpsUfvGb/kBR
 C/l59Dl4RtxUBruikU+ZUPpxBDy7gN1+Xg1Yzyvu5TnEkKysHA0eoMyTgjuMjEazfsaS
 YTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693093; x=1788297893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwy9tP+PnAQKttwIkPiCEGglGcdL28/hF8XnKtMukdw=;
 b=FLXVsTCU5IDTMlnphGbTIXdL/ieHStmzH248+iuKAivjMf57+S81CTmL/7MhgWLpPc
 C+nX8FV0PqfKldlAKO8AkTWdzmDdhXEGlJp8WBeMFl2B0CxDw5u/uQphuw3N5U4diISp
 AWKidSv8CtigjAtYOEET4ElVWAbEHFY/Uzk1CTUw2K0221sJNnJHkk2TUXl9hYDt3fpU
 hQ5I5r1wDyLkTNnVpQ0hd1YQz33bvHz5piBxxfwXx5xWRHeweLG2VXiBkod/g72fiEhZ
 ToAt+jxkungXjTIB1nt8NCKs7rPxvrK2bk2DpEEtE1xcP3Uxfl8m7MEtqFKakKoUAtHu
 ln2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8Q87dXoYZZbNhRGSm9xd65lP+zqZIX9AxzgU9Q6/PPASVYwOYgsmq9iTznGbtQaSobD4VEaBR50w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWUOGhP+rh47Cvk+goB6gyS/9nM1qy5IhBHABLiGZ5W6rF7Fs5
 tG0UV1kr6sG598ruXoT4bbr+GyvrU9gHBxRzanWl4URAM9cZpXZHV5YR
X-Gm-Gg: AR+sD10A/Kd1nz5RtrimfempBn57UJESdXAzB1+q1nHwRVo+YHVBRHXykGPUEzEjm6d
 d22ZZPlQYPqjiO4EG2lwWg9qIoQ/3ohJThl70gqRM7tOUsjPcQYcmiufWbsnjN8dF/1c4gJeuvR
 RbjEIZKWy8L+Xt2IT2sEIDidYf0WLDnUi+mMm4qi4g6b9i4EN3Hw70Zn+YkDto4wQN2OlUHYsno
 grF7298OgUusMt2vQljeU05aozenUKRE4t4f4tdj2FqBskMZH+TXiC55sqWty3EEoB/PAv95BR+
 LZn/dQ9uZ8dICLtABQh92tBDOenbUJzT7U3uw3QNeHbi0U/9R/GnrPKVYEdWtENJSDEoAhouzzJ
 +tVeRub2hbuHymf2czysZUVqG75AfiICSykTcbDSv6aYCe6Q8yZYoVW/TLLPVwSG/T8/7YKs1wg
 QES0Ruc3OZdCLKHVBsSZFop1F3wTY6D+2IEC3Q0ahCknidUXvHgBZdm9aqRiDrsCnuyXxBWs8jB
 88aupqCf+5TH8XskT3X91DmACVZlrPilCaSzwRZBXN0Hb70axZ3P9mfQlEV
X-Received: by 2002:a17:907:1b23:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c250c6751bamr144503066b.20.1787693092403; 
 Tue, 25 Aug 2026 14:24:52 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250bbc5c02sm85136366b.61.2026.08.25.14.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:24:51 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: mwen@igalia.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: alex.hung@amd.com, Daniel.Wheeler@amd.com, kernel-dev@igalia.com,
 lyude@redhat.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH v3 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
Date: Wed, 26 Aug 2026 02:24:49 +0500
Message-ID: <20260825212449.48288-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813143605.106104-1-mwen@igalia.com>
References: <20260813143605.106104-1-mwen@igalia.com>
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

On current mainline every boot on my machine produces this at amdgpu probe:

  [PLANE:44:plane-0] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0xa16/0x13b0

16 times per boot: 8 per GPU, on the 4 primary and 4 cursor planes of each of
the two cards in this box. I bisected it to 860e748bddcc ("drm: ensure blend
mode supported if pixel format with alpha exposed") and confirmed it by
reverting that commit, before I found this series.

With all three patches of this series applied the warnings are gone.

Base: 66498c75b4f8, kernel 7.2.0-66498c75b4f8+ #154, KASAN and lockdep enabled.
Hardware:
  0000:03:00.0 Navi 31 (0x1002:0x744C), DCN 3.2
  0000:0f:00.0 Raphael iGPU (0x1002:0x164E), DCN 3.1.5

After booting into a normal desktop session:
  dmesg | grep -c 'blend mode not setup'      -> 0
  dmesg | grep -c 'drm_mode_config_validate'  -> 0
  drm_info | grep -c 'pixel blend mode'       -> 20

i.e. all 10 planes on each GPU (4 primary, 2 overlay, 4 cursor) now expose the
property. No WARNING, no UBSAN and no lockdep report anywhere in the buffer.

What I did not cover: I have no DCE hardware, so patch 3/3 is untested; and
since PREMULTI is present in the blend caps of every plane here, the property
default lookup added by 1/3 resolves to the same value that was hardcoded
before, so that path is exercised only in its trivial case.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

One question about routing: 860e748bddcc landed in the 7.3 merge window, so
this is a merge-window regression - it was never in a release, and no stable
backport is involved. But the fix should still make 7.3 rather than wait for
the 7.4 merge window: right now every amdgpu machine on mainline hits this at
probe. 271e90eb5f9f ("drm: use drm_warn() in
validate_blend_mode_for_alpha_formats()") is already in drm-misc-next-fixes,
while this series is in neither linux-next nor amd-staging-drm-next. Could it
go the same way - drm-misc-next-fixes while the window is open, drm-fixes
after -rc1 - instead of through amd-staging-drm-next, which is aimed at 7.4
now? Splitting it looks wrong anyway: 3/3 gives DCE planes a property with
PIXEL_NONE only, which needs 1/3 to not end up with PREMULTI in the default
state.

-- 
Thanks,
Mikhail
