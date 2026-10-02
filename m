Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7555CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B7910E5BC;
	Fri,  2 Oct 2026 13:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ux8CbnfT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4884810E5C1
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790948810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dEanQnOyXhk+suk32DBilMCW9SZjDiEbY5jKTMsnxY=;
 b=Ux8CbnfTUrAwmfo2c6J51p6tSP8CWkVhtft1ueF5HMNFpr4H/kCpLYFn0qLkp+oApwwprm
 Zo1cwHnlb945xS0l40yWKW3iIFIQt14d41Zk8DU5bUrbXgcQNRcRVzrkM3+yb1KRrO2s7b
 hd9pGgDzE7nH/4uhMSseimDGq5/fq2s=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-QhMeorAiMiSA2HqVETtoaw-1; Fri, 02 Oct 2026 09:46:47 -0400
X-MC-Unique: QhMeorAiMiSA2HqVETtoaw-1
X-Mimecast-MFC-AGG-ID: QhMeorAiMiSA2HqVETtoaw_1790948807
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66ce3040ea9so10092859d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 06:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948807; x=1791553607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6dEanQnOyXhk+suk32DBilMCW9SZjDiEbY5jKTMsnxY=;
 b=dNrx7R9433YBagWs26Mhve3l/dRBBYSAN7NL6ovwx+nBa3p5WRSOc/PlJzkzG+RHoL
 O9iwJ1YWbQYmDfvtbPWMWbk96Y6ZMAhgpViC3NgD703YPk2UaS9tPpF61HNpi6RPX8cd
 B7zWzxURJJqyM4n7AUogz/xJmjIrckqxn+2JDpaH3pZXNDBQNuh748L3g8BnncQe6QR+
 OfS60mbIsAOH9mP7AYH1jemorZ0TUvNDw/HJ8/F/a8lOnLLq/rywsBQYWmhU74VGJeXj
 40LMyNgn3TegDmBKbAgAo2G5dRHYJQaWD4AuOOrQNhzvKHqjrJQFri5oywq96fiRJ0tZ
 fVVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/Zr1I8Tcf7dkD9O1vbzd8utgF5zink7raiOfI62C7iHctUtWdCdljpVAMUrRHkajB6JptbB1L+c4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGIKOAPP4YP9x5diLxNOROEgu9nsqFMfMh7VBrnR5nIRHGuJSm
 ApQknp0VRTkHL+fhBoU4McH1m2QK+LmcW3ZxxGq1iXSivFmjrBhHAK8l4/+7UvLWvUT4ucuqKn1
 aeAZx8HaHJVqk2UbWJllfVZfUtQNqAmghffFUz02eY0wrShJ3pJHErSmB6ODBqAIxMIRoW2zufC
 ZKOAWy0JO1jjSC7aJhtWKqwO/cHFPZzfxdfVNKfnANjpep
X-Gm-Gg: AYBFou1jID5UKHXuRG0Lc+44J4OLiuNKxx4SL82ygsD8vmXJRzn8irNYPVCFEDUU4Q2
 LSQeGAxlfCSgIRGObOkomKhv1bchETmBOLRtl+jTYy2KOq7gWDvjwp7zQIDlakuEwyxlVmK1+aR
 da32RnHumwlbYTAYMzmPWUjKb5UUPzsEd51jRcH6SsNtvi1WaPpjDsZg==
X-Received: by 2002:a05:690e:168c:b0:677:ad61:2984 with SMTP id
 956f58d0204a3-677ad61357bmr927191d50.40.1790948806641; 
 Fri, 02 Oct 2026 06:46:46 -0700 (PDT)
X-Received: by 2002:a05:690e:168c:b0:677:ad61:2984 with SMTP id
 956f58d0204a3-677ad61357bmr927146d50.40.1790948806082; Fri, 02 Oct 2026
 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
 <CADnq5_MZZje5XGfYgJ1v4Ts_k+ZyyBtSrSqB5upTEt+AqBi9Yg@mail.gmail.com>
In-Reply-To: <CADnq5_MZZje5XGfYgJ1v4Ts_k+ZyyBtSrSqB5upTEt+AqBi9Yg@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 2 Oct 2026 15:46:33 +0200
X-Gm-Features: AclHuK9i1DaMDvJYQE2Z1NJPuLF2VanTJNwwCXcvdTlybffYDnKmDymLXiGYtmw
Message-ID: <CADSE00L=KGCXqpjm3aiOQ-JwzirXTrvVsd-mNXpb9QDggVs=pw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
To: Alex Deucher <alexdeucher@gmail.com>
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a55Z_Fel_IyC3E51PAAegoRWAJHDzOAa6sdI-AI2ONg_1790948807
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

On Fri, Oct 2, 2026 at 3:34=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Mon, Sep 7, 2026 at 9:45=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:
> >
> > amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> > INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> > series switches the KUnit helpers over to the common API.
> >
> > VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> > CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
> > KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
> > EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
> > that namespace with MODULE_IMPORT_NS().
> >
> > INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
> > on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
> > and is unnecessary for tests in another translation unit.
> >
> > Tested with:
> >   ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
> >     --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests
> >
> > (CONFIG_GCOV omitted; it is not available on x86_64.)
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> I've reverted this series.  It breaks the build when CONFIG_KUNIT=3Dy and
> CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn. When CONFIG_KUNIT=3Dy,
> the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn,
> they should be, resulting in build errors.

Oops! I'm very sorry. What's the procedure now? I see you posted a
series containing the revert. Can I send another version of this
series after that lands to fix it?

BR,
Albert.

>
> Alex
>
> > ---
> > Albert Esteve (3):
> >       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
> >       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KU=
NIT
> >       drm/amd/display: drop INLINE_IFN_KUNIT
> >
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
> >  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++------=
--
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
> >  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++---=
--------
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++------=
--
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 146 ++++++++-----=
---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
> >  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
> >  .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
> >  .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
> >  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
> >  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
> >  drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
> >  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
> >  tools/lib/python/kdoc/xforms_lists.py              |   3 +-
> >  51 files changed, 748 insertions(+), 728 deletions(-)
> > ---
> > base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> > change-id: 20260907-visibility-unification-fd358c580447
> >
> > Best regards,
> > --
> > Albert Esteve <aesteve@redhat.com>
> >
>

