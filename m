Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D42CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDF410E7C5;
	Tue, 13 Oct 2026 12:01:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABD810E7C5
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791892890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTh6w3t1LI7cFHlFOA6EXonuQhJfRF96d/zfPpAsgQU=;
 b=DUD9q0GfeEevB0qFd8rXngFMHHznRVfPH8kyL9sOVnNGDnCwdy7Lykt3CWnpD7JDlAcqek
 oU1+2WM4TJd3PyaeCRTK+ZHLfe//J7dNiKdae6kpjUYg8OOmjY4M5gXARUeHoZd9mUI+hi
 bPp8rbm0CW6s1io9U47BG7uku2kGkT4=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-B4Q7ii-SMcOJpPNE2ZMWjw-1; Tue, 13 Oct 2026 12:01:07 +0000
X-MC-Unique: B4Q7ii-SMcOJpPNE2ZMWjw-1
X-Mimecast-MFC-AGG-ID: B4Q7ii-SMcOJpPNE2ZMWjw_1791892860
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-677ed839276so1611599d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892860; x=1792497660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTh6w3t1LI7cFHlFOA6EXonuQhJfRF96d/zfPpAsgQU=;
 b=u176iCWF/gpsKlX1rbPWp9KU1ByifP22y5xRcuROIgx5YTEn0LcJBSxkkCFcMPiwIM
 Ef8EyheKGEvVQxguONLTWBckk6+e/u+/YPwAj8AAxihzVshYYXjTIkKm5rRjiolG2g0J
 /ySr/ttjp3g+JOjEpwXy/E921BjhkKPxG0i1s77WzDBESXkdhlh2O3jLbHsUuf6F0EtO
 4KpLQ7Oe+qwZVvgT4tzEyJQ08oUzVCj7uUFOXJfzAzMRNRM8M/z0UYiHiBCbAbhJZB9L
 5CP/o1IMaFQr448CpTFVlP0Sv6dkYbjpTG/xD2HWXt+ERKP4nLCWcAcm96/By9BbHRJG
 iV0w==
X-Forwarded-Encrypted: i=1;
 AKwUvByyoDfMLFK85bK3DhktByUbo/a2DmkE3JlW64U5V4wFj3+O01QBm+5l+KwgCSu0O9J+8h0DrPq9HmE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrt1vpHqXNV72YuagnqJX+EOzDHYEXftGX0EiT76K+uDkcneqo
 +QNZ8PRCxEnnhNJbu3hQcR1rtYcbuz3AnT6wb1Gur8DGk83GHEy43f1MuxvsW1VcWn7u6e45y+f
 P05TzQxVi4dUAuIlYNph5w4+n2DeuixTPy8BK5yCz8ujZRicC/BpAVUITiEDc3efEtnCh4fzakg
 uQOyBe/x865CBFesTf3VI56fDAt5LOAvDh+bGbf7XinU99
X-Gm-Gg: AYBFou1wEkihWmBKpQdDKc+w30P0f4dBYhlXFp+f5X0SbhO+FVRZg8z0moyoj9iNobP
 nOpRA6YeEsXRFLV7Nf493xJvsTt9WST535UZGUvhIJG3iD8gb2CpWydXm0A0Hgn/ocPAIlRt9ME
 4Y+K12HkmQuQH/5O7zDZppXk/B/f6ia8Q70O++GlPwjqlB1e3NIP3LEg==
X-Received: by 2002:a05:690e:13cb:b0:677:d4b0:47fd with SMTP id
 956f58d0204a3-67936270e69mr5009549d50.23.1791892859807; 
 Tue, 13 Oct 2026 05:00:59 -0700 (PDT)
X-Received: by 2002:a05:690e:13cb:b0:677:d4b0:47fd with SMTP id
 956f58d0204a3-67936270e69mr5009396d50.23.1791892855071; Tue, 13 Oct 2026
 05:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
In-Reply-To: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 13 Oct 2026 14:00:44 +0200
X-Gm-Features: AclHuK_UoITZRIQAG7eVGfp71MDQ0WSmjY7r-ItFN0NvYj_P9B_KTR-tMkVwVj0
Message-ID: <CADSE00JuXFx3vBiUty1A69K8ONuL2DMjCREGmDsW4MxobemVtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PJAtkwKCMAAhcWvop8DeDiiw4ktLRPIgUlrXjcBnFxE_1791892860
X-Mimecast-Originator: redhat.com
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

On Tue, Oct 13, 2026 at 1:58=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
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
> Previous version failed with specific configuration combination
> (KUNIT=3Dy, DRM_AMD_DC_KUNIT_TEST=3Dn). Fixed by changing header
> declaration guards from CONFIG_DRM_AMD_DC_KUNIT_TEST to
> CONFIG_KUNIT to match VISIBLE_IF_KUNIT.
>
> Tested with:
>     # Full test run (KUNIT=3Dy, DRM_AMD_DC_KUNIT_TEST=3Dy):
>     ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
>       --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests \
>       --kconfig_add CONFIG_GCOV=3Dn
>
>     # Build-only, tests disabled (KUNIT=3Dy, DRM_AMD_DC_KUNIT_TEST=3Dn):
>     ./tools/testing/kunit/kunit.py build --arch=3Dx86_64 \
>       --kconfig_add CONFIG_KUNIT=3Dy \
>       --kconfig_add CONFIG_PCI=3Dy \
>       --kconfig_add CONFIG_DRM=3Dy \
>       --kconfig_add CONFIG_DRM_AMDGPU=3Dy \
>       --kconfig_add CONFIG_DRM_AMD_DC=3Dy \
>       --kconfig_add CONFIG_WERROR=3Dy
>
> (CONFIG_GCOV omitted; it is not available on x86_64.)
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>

I have accidentally dropped all Acked-by trailers from Maxime from the
previous version :(

>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
> Changes in v2:
> - Fix build when CONFIG_KUNIT=3Dy and CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn
> - Fix two missed EXPORT_IF_KUNIT in amdgpu_dm_irq.c
> - Rebased to v7.3-rc7
> - Link to v1: https://lore.kernel.org/r/20260907-visibility-unification-v=
1-0-6a962e5b3351@redhat.com
>
> ---
> Albert Esteve (3):
>       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
>       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNI=
T
>       drm/amd/display: drop INLINE_IFN_KUNIT
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-----=
------
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |   4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |   4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 150 ++++++++-------=
-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |   2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |   2 +-
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
>  70 files changed, 771 insertions(+), 751 deletions(-)
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20260907-visibility-unification-fd358c580447
>
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>
>

