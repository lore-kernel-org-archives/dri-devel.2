Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639BECA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E34310F837;
	Fri,  2 Oct 2026 13:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3cWyX6I";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF8D10E5F4
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:34:46 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-32be7127c64so928088eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 06:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790948086; cv=none;
 d=google.com; s=arc-20260327;
 b=oOkmRg8qzjy3dvB7LegaRjZ+DWZWewasETgBNUrIaqBb+yDfvAV+o2iA9Pvw4npC4w
 /PFmACUmWwL0laOSBkrYiccAg+Z693kHg1gB8hX6pEQc0aSBYiCGsOKUv+wOsIk3Sn20
 6j0PZQmcViP1FZX/TNxL9Sc0JoVGs0YTC3louJNFg4tOWr3Sw+H3LvYXc/tQ7OUVKWe9
 uR1gW8SY4Tkva/6hx0ls+ZufiQQIsgQsP6VP9Oc+spA35pbWfXLMEe5YT3oFPYAf4vnY
 99Cj5Y+uLu/vpOMmwpBVYWQYygZ6t4MyTcRzxZnQWud3hM7IVRLkaUCjlu66zhYxAD/v
 5K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yx6G1AW+nvvITgzsA9b25EAkpoWe5JEuWuaZEwVI7YQ=;
 fh=M3EYB1lR/zZXDuvTvFHYtvwXptxcX6JGFvBuck46kDg=;
 b=IlaEswjJF0C6LinVpuA6V2blDpJ9pt2/VgI2Sqkc7NiCkP5NNUVMSs+rFhl5CP28Cu
 AHhWNAqynF1oHoAQhlCel82ohkpy3pcOwPazEJUGsGkbn1BClENQbfrLVeJ4FQn/diU2
 npRs9NBb0ktuS4dqk4R2Ko3zJyWNbr15xezM/jNUwyj2DILDxuOIvW3ZV4wz/eOsQKty
 aNWyHgy22tb04bQH2LQR4g8OwqAt6MbE1bDpuas++/nVAvJsKdzOepH3RDey+G/HvCVq
 jja+d3ArFAorXqkJ0ebicBPpQdV6m8CC6VVLPrelRgmSGKn9nxZKZkP3K6hkxF8JfxlV
 1ALA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948086; x=1791552886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yx6G1AW+nvvITgzsA9b25EAkpoWe5JEuWuaZEwVI7YQ=;
 b=D3cWyX6IHokLUUTeeSIuKSOOFVAFlYNeY+YTDtnSWxDZCYJ8eoJywdjT6qI1+WKUVe
 pgFv9Vs5l3y4QcmmqMtGannA36FkwbS1GcGau74i4Bsrp1xsVfQnb+O6Rl0gF1SZBxVC
 QxM1LOGwbTsneMHza0oUQoI1TOkC5G/nnBKa6eVr3qLuN5HneCVx7s4JAUOtk+CxBuYl
 eb/zK5KjKReRlgiKXHyVrirF+1Vv9Li7CJeIGIoCvMykXQAYcjONUGji6+LCc0FyF/54
 j+e2utunDQ3A97JwU5DGLZhEPr6+QHaDk6QFqveJllGrqkxrWBkzpDNk69ZN7FTM/U8h
 lIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948086; x=1791552886;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yx6G1AW+nvvITgzsA9b25EAkpoWe5JEuWuaZEwVI7YQ=;
 b=Zyok8xTlXafnKGG8AW+0ZTPlKkiap4Bc0FCOEW0pn97cOzEI2VZbBXGbjfAay3HA4M
 CzSyM4gtgqQ01SXjnK4IlMNZlNVEkrPAvKLTfi1u4lHUh+oc4AJl4vztR2ev9IAdYIDS
 OB9wPdSc4xWOsyLrNJ0F9/8rAGeTgvJQwkg0bQVGKPTQ3s/R3X7w/BbHwDVTgvKuMidU
 3gMvf9JO3Nx5W949ohgTmXhe5Hz0MMCjJkgOefRxvyo7nzGj4nxaVKK3DRSoYZOFHHri
 UXyOJIVBipY8KV+Kuqlx5euxwbtLmbU6nSdM7YpkJqyi6Hnyosenq62dt44CmL2vqgxK
 NYYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0jVBNosDv8W63C5iwxgCL6CGaSm+PNQwFD5wl/o5EHo77+fD3KVgQ1r8vUvWoroNirsQFdERY5+g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++npFngDa/fpZcfQJAG/pwGqBW4DVcY1lnb9gSS8bAGpOju4diQt
 XfwUkpdWO1GEFZW+JypQqYvcy2ZIS0a+CYhHm8MG5qnKvBjmQPsI/X1GKTkpRg5EYjti7vjbSg+
 729PXSz0RTSwcryrfuxdKANOUFPDVhng=
X-Gm-Gg: AYBFou1BxFjnrevkGv/+yX5QmRu/zThGDQcAoc1iHzg9Km0UY8HDdh9nQi5tQrcDnED
 XwHmI8VuuTINCGEHg+0ZAAES9gTWPUouY5WIzU7tPRHr/KGXaaraKnHo1cDwV+xioE6iYVivTkM
 8V+u/kuetabFPrK8+a0P89QRu0pxReL1mwoNoYukmEkOicSBLQi1/3le1fJvZEhcp+2grrFG4fV
 Ihfz/zi9ky0uGRd5UMC5xcSFbvMpRnYiEMYSVBtQGo5hnQaH7VoHYCNkWD6DV+c8r4fgbBLC9Dj
 mEC5fHjEZmu2LVfznKJ0lnzv9Fo4/N5qHqEjc0V921efgsYiXt3HnqIEVpArCUBnrBdslFB3h9d
 Pc5uPDwtnAghf+PLDMJK+6/EVeF9sEkcZD3q6ix8jNYz/Qgn0/HJf
X-Received: by 2002:a05:701b:424d:20b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-14f5aa4188fmr4688728c88.1.1790948085630; Fri, 02 Oct 2026
 06:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
In-Reply-To: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 09:34:33 -0400
X-Gm-Features: AclHuK_TcjLVEROGMJB5lyBOvzPZSfQv2eIf90DD5P5QCDVjEATvEIscfiIQFpg
Message-ID: <CADnq5_MZZje5XGfYgJ1v4Ts_k+ZyyBtSrSqB5upTEt+AqBi9Yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
To: Albert Esteve <aesteve@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
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

On Mon, Sep 7, 2026 at 9:45=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> series switches the KUnit helpers over to the common API.
>
> VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
> KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
> EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
> that namespace with MODULE_IMPORT_NS().
>
> INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
> on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
> and is unnecessary for tests in another translation unit.
>
> Tested with:
>   ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
>     --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests
>
> (CONFIG_GCOV omitted; it is not available on x86_64.)
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

I've reverted this series.  It breaks the build when CONFIG_KUNIT=3Dy and
CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn. When CONFIG_KUNIT=3Dy,
the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn,
they should be, resulting in build errors.

Alex

> ---
> Albert Esteve (3):
>       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
>       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNI=
T
>       drm/amd/display: drop INLINE_IFN_KUNIT
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-----=
------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++--------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 146 ++++++++-------=
-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
>  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
>  drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
>  tools/lib/python/kdoc/xforms_lists.py              |   3 +-
>  51 files changed, 748 insertions(+), 728 deletions(-)
> ---
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> change-id: 20260907-visibility-unification-fd358c580447
>
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>
>
