Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6188CCA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD2410E5EF;
	Fri,  2 Oct 2026 13:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+/Mq4Yc";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65C610E5C1
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:48:52 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-33bc6ff6cadso1142378eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 06:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790948932; cv=none;
 d=google.com; s=arc-20260327;
 b=s3AajE4oTdEA0PiUX+T/TZVgwD94kygKsDKPfvYGojxF1j/vVYNVb4BuQ3MUh9rWzv
 u7By+7AN3HNLNFj+pLt16a4yjta0h334vY/yEZtznKc6QtjfCwvT8pUZjv/Fsi75/ToP
 ELxdvYzZ/ZyR9WSVlqBX4tGyCrNWaukbGtFyS2H85mh8Xg+0pKyrfB4CvPN46F6jr8VU
 mbA4Jxxrh+FEFOzviNOvY9z1jKcRa1YAg3VBCYIRrj9bYT/wvaSwmE68wg/n/UR0XAR0
 KmmEtbHc4xaSZfixDEM2t4dNHUGNCk8VrB93pPxNJbHpnxssBeYcSHcMImvm4S9pK2Mb
 l1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J2DKjRlAzAFGq6y1KL+4ocbnmqLb/iUOft+MhA4fQgo=;
 fh=Nj7pI3dkBqQfCoRwkQSr2aTiZPAIXmDXXF/2qjMltFU=;
 b=bIKuahmenTCnLM2IOoQfg6JDojKqH+AqucBP9MT1tHuP5tzWFUs+Se1ryuBiZP+gmU
 n0ASW3AekBErp6m06ROqaJQu3NkemwWg3Menk/rH/iSVXOJe6hrL6LhFyv8YrrefbGAA
 TXQ7iGBMaMPoSkgoNDeqmeVURZxLCq7jGYDypPGl6A3TSh7OmyRUCZRUhf2YKnFakIaR
 sYQg+Kgotc9ugsSlSqBPgszpnlgOfrSJoc96wXkgg2H0Um/B2h53nLRDbftNL24RDk/V
 P64sN9AUXaxkPHeCM4a/1+ySzIREjKln3k7ZNbHC5IMtGkXhGPajQvdpg+7zZ5kVqa8i
 7zzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948932; x=1791553732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2DKjRlAzAFGq6y1KL+4ocbnmqLb/iUOft+MhA4fQgo=;
 b=m+/Mq4YcFSfRmHAiNVWAAFIRhGyBbxgPDTDB5sw8miQsonGsMD5H4UGzj2YF2V9SDn
 c8sH06scQqAOxB7VOcutAcpDuw1rGUwGc7xzJSaMRA5up5GQ7TBK6airG0uv7i8Ch+NB
 9CV87jd+4X+rfGKSUrcXcnqrUagQPOp2TmS/wpUqXaa+MTwhDqkjj/uE7H7c4DBZaL7P
 pNHxvz6AvYYMNo1cHqSTCO/6vlk6RtoUMoJ4jCc3wzRRCD7s4pCaiPAuYcHxjTh2+oVN
 6Bqjazy5HCcQoD7BOJaqmpjpfj5EH5uYibvVEmFdk5Hgz+wtLSZSXM75xGU+NFdCOcCw
 rxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948932; x=1791553732;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2DKjRlAzAFGq6y1KL+4ocbnmqLb/iUOft+MhA4fQgo=;
 b=q8ymILXTT1QGrqYa9mNAQbuMZQZddxPw6Gug/dkmQZi8Sj3jNx1uMCPSTo22foWl3r
 agX7JoyoQCk1zW3IBNoOQH18yOnlal0IHhp9MzAV2aV2NeMOVWeuhvCi8G4tTIbK/jVD
 Vav2rSjDID8OAzB3wTil7cyemuSX/uX9y7FBrXsWpSPuDacZHtedao9fvLIQCAsrjrwY
 VZnxY0UbuvHklQPYzaBIA+pqVFfuCPiUSDLNw2adlLYSDvD62ByJQaN9HThlenaAfFhb
 EiA2YMakCPu/q/iOUZduYLUACrzmHZMWnrIoY3l3eT5m1c0KrJaGI0ieqSO9b+Ct3o76
 dFxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjJVHoE0DkNBk4sPwhqXMO3IAqryvpKEkjudUOQzWVny6MONaZhMr2nj/X2WF+0Kyg7TJSNoh5/bM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPFv57eSCG56T7BAYJx2bfcorZg9X1+iaJgwsXqHPeCPtHdAJt
 MBnF8fnzc1kjnzBEoeP8HeCkXyLlmw98rCnng7E6kYwZKq9Z8WAdezxbbqMbzA43oAhRm7GKgNh
 03YEZvLw6qyBR/UXdkvD9CyoNxrLRFDc=
X-Gm-Gg: AYBFou1Y0IFI4/F8GXM3ciyoUwaVz8ICrt2klsfhr3yTpGtmebdxiW/4Mcukj8s7H+o
 4KoAN0LziZoShvChlHgovVCajV9F3UuAsF9O8YID88U3v93CgRMpIlk5RKyjP7papHYw0VuBet1
 aKjqtUXEdaBf76ZrLe1l/gWHwnmU6wuetmMP645nnuVT3IgjIhnFTPLtpkjc2eLY/iWqrpl0Z3W
 C9/xhowCsQ3VHKUW0h6+UKGkghljku4Jh2l/cX48mSbR96KkMtZ7NT2UpdQhqe3HS9EaaXAzIn1
 xexVjUeb7/oiJkwK+S3qd2PwADi9dbCakmyB9u08uW8UKNZ/tE5mwH4mh35thS3R8/9Oo5tiYvr
 ZIQ991o3YMPfwFvCEmhKYMtEcAq9gb9BPhKVcN6P6CgDK0SGoORpmFvyw3xllA2c=
X-Received: by 2002:a05:701b:4550:10b0:143:8212:a43 with SMTP id
 a92af1059eb24-14f5a93aa43mr4045234c88.1.1790948931622; Fri, 02 Oct 2026
 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
 <CADnq5_MZZje5XGfYgJ1v4Ts_k+ZyyBtSrSqB5upTEt+AqBi9Yg@mail.gmail.com>
 <CADSE00L=KGCXqpjm3aiOQ-JwzirXTrvVsd-mNXpb9QDggVs=pw@mail.gmail.com>
In-Reply-To: <CADSE00L=KGCXqpjm3aiOQ-JwzirXTrvVsd-mNXpb9QDggVs=pw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 09:48:39 -0400
X-Gm-Features: AclHuK9HlnwREQSprOE2OEafwiRXDdiofJf8sSV8e9OU00tSYzj35_B2cG2A_YM
Message-ID: <CADnq5_PEun0nB3in17GyBSy2qSF_fWf=40-m2csv=9f1rmr5XA@mail.gmail.com>
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

On Fri, Oct 2, 2026 at 9:46=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:34=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
> >
> > On Mon, Sep 7, 2026 at 9:45=E2=80=AFAM Albert Esteve <aesteve@redhat.co=
m> wrote:
> > >
> > > amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> > > INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> > > series switches the KUnit helpers over to the common API.
> > >
> > > VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> > > CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
> > > KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
> > > EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
> > > that namespace with MODULE_IMPORT_NS().
> > >
> > > INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
> > > on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
> > > and is unnecessary for tests in another translation unit.
> > >
> > > Tested with:
> > >   ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
> > >     --kunitconfig=3Ddrivers/gpu/drm/amd/display/amdgpu_dm/tests
> > >
> > > (CONFIG_GCOV omitted; it is not available on x86_64.)
> > >
> > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >
> > I've reverted this series.  It breaks the build when CONFIG_KUNIT=3Dy a=
nd
> > CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn. When CONFIG_KUNIT=3Dy,
> > the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dn=
,
> > they should be, resulting in build errors.
>
> Oops! I'm very sorry. What's the procedure now? I see you posted a
> series containing the revert. Can I send another version of this
> series after that lands to fix it?

Yes, that would be fine.

Alex

>
> BR,
> Albert.
>
> >
> > Alex
> >
> > > ---
> > > Albert Esteve (3):
> > >       drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
> > >       drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_=
KUNIT
> > >       drm/amd/display: drop INLINE_IFN_KUNIT
> > >
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++----=
----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-=
----------
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++-----=
-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++----=
----
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 146 ++++++++---=
-----
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-----=
--
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
> > >  .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
> > >  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
> > >  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
> > >  drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
> > >  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
> > >  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
> > >  tools/lib/python/kdoc/xforms_lists.py              |   3 +-
> > >  51 files changed, 748 insertions(+), 728 deletions(-)
> > > ---
> > > base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> > > change-id: 20260907-visibility-unification-fd358c580447
> > >
> > > Best regards,
> > > --
> > > Albert Esteve <aesteve@redhat.com>
> > >
> >
>
