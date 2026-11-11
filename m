Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYKl5tOU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F1010FD09;
	Wed, 11 Nov 2026 17:19:38 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB55D10FD01
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:19:32 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-372cba0ecf9so86709eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417572; cv=none;
 d=google.com; s=arc-20260327;
 b=KF+8lKUE/TsGlA2fl2NLZocl3qRlFwNy3rE1zEiIPKIdg+IebQEIOn6P7es1D8Cgp+
 12SESBwGX45aKNP4ORRy7dicgmv7iS652muEY1bvFjNpYv1VuQHUrExMudvHzzAgV981
 coXbSqkwCEQpIq3sFJ/wvG5zq0nOJd1mkdV9jXi61GvbFOgBIh+NKgRkgCaxlSqZyS5g
 /KgrB7vcu4NXq+35Q94SoSr/IOItM0iqQ4H/s+XAGEVe6drEbcPwIKQJs6AvdoePm8HP
 f63N0VbTVVvlgHg64wI7yiw/rcslVALszVRKqmHWSrDkleuaBJCqPKlRZLL7H3U8He4p
 itMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KrAwE14sLjPV1wagWRb3nhUSBxA8ruoUwCfDea/0XLY=;
 fh=yy92Q6y1x8IARPUrNaTzHDCPqPrwShpb0WpNV/kzivM=;
 b=kyQjgl457tF6O/eubuKsO1Iag9cW3r1g5WeTWPu6ASbmZymgzEaiEWyqupskikZn+f
 ajEWM+uecwPoprCtZ7D7cFUW3B6HLBy2jOkD+sqQQx/+OtbTpgknppVbkQFp2gh5SLCR
 25dHWPb+25krw7EclZ97EyzXDDk4gO9o5ZGS890ZIyCtRnLAN1Bi4TNz7cLzirCak9+y
 6Mw5WpfXGP6EpW3C87dI6t3ykj4Xh7oCH8Ubb2rqODFUYa4zvCBn+g5nLT/MGB9VQVOz
 WtMvYOBxFmnPCR/lcgSER1hXLlV2tRQq4FUL8nEswC9rmsAXVmNIJmcYQx1Vhyt67dVy
 7pSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794417572; x=1795022372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KrAwE14sLjPV1wagWRb3nhUSBxA8ruoUwCfDea/0XLY=;
 b=PYKl5tOUE0BJabRDqvQv2Y/QIsGMiiIVqFIBOMdnnnrwqUaY03dHtP3ELPpzxDFI3i
 Pt0m6LMz+PJui5rXv3m6W1iYHm8b+bGp4AdXwJrl2Af0uR2DV8FrZ10P/Gsen0vQA3io
 ABc3/3xqHlE16commgyN2I3q7T1/r7ApluMEMuABwGJb66nDK1QSxH8zlp/lFUGz1mRn
 LS0gTMa4tCM5v0jFdJ021M3BkHCOoRfAlU9h6IQWAKetVkxRd96p8dzb1xB/vK+ab41z
 t0RJrP1g3nVRD5E8cVYTFgoqsExF/lv9pVTgryfckLMXN5aF/PDZ2jE3efrMUYWOYfQq
 NIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417572; x=1795022372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KrAwE14sLjPV1wagWRb3nhUSBxA8ruoUwCfDea/0XLY=;
 b=Kj3rXtEUnaobN3LFFzjvuL6QXjHrO1OGn/RgJTM0qpoE6bTqqGOEjm08ksSYsSMlG1
 ovHgg6SPFNvxA2GM+3+TKPWGy0aEhri3wRz454u5hw2fYJpx4LcCROPkmpeN5hm2gIl0
 CRtVrlIRhoVOI0ZJDhz/Nk5i8+7X1iNIBen4gt2UN2OxytdZdwn4GDX9QdAOS20Lx2Kt
 tHakBUjf1rN5rcU+tQjY3WkDXbqem9/aaumV4+B6qJwuyd7Z62N3muwK54ovq4j4j3Pn
 Dawz546fUWcAB7EOdjkf+NieWjw8MvSgA2YL/6GMtdZ5v4RLGEICyyKk+335qY0uxpII
 wnog==
X-Forwarded-Encrypted: i=1;
 AL+hErFZq1EN7yPdjUvaT++XAyPcELL4IKnmK04Fdbuxxau6gERQ4AbMIdUHl6yuTdZB4AIYXyirxNTXrb8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8FdRFMB/hFM/fblsjaY26yMaFtfKRNGyb7b5IEk3CVHLuYDP0R
 9mXkNfBGyRQSherkKM5iGw/XcNpEs8rAQ9HwGh81r7M4hLvaWnbvgNt4cla6aJ0aL+qRrT9JJrr
 F3xUNnXo3rsvj6EISthaUosarCKwEFH4=
X-Gm-Gg: AYBFou3X7ACKseMla4anf9brmRSYdRzWzrRRAHcdHKL56mWcJnfCH0UU9d6tdgMheqH
 b/G6pXuDwc7wDTLLIOmDQhkAIVdV0/5aPoELspt/Agy2nl10ZwvB0zhomUgr4t1nbFcPwUeZOpB
 ASi1piP9qU36XfwtkH4j/IX3DjPP0X+c7G0mJLSGm1IHNA4GWOlweW1xD/SqX0UnFmRr3kg3kLl
 Rord9px8xu62IHh5nUMuRAQF2CTp7I8INXurXEb5FRigviJ+LnYUTB1/x36uIoeInbLY5QI1EbT
 AMA1PF8PTecMkAy5eLM0TXwlTO83L1dJZFOAt8HH2KPpiCVb66DHd6Ak53YqFCgCb537HPjl0A9
 9f5Pz2pLlDfLcsXRN6NFZb6sa4TOplmLLmgB5aKwEr0KLMwxzS2QaT9gEVChXYh6czSQAQSaIZ6
 OLcdPtHs+YOF1b+iz1pOT008/0Mg7zEzVfY3nspHd7kJuIHwsVColmN9sKfkY=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b3c01600d4mr4568870c88.0.1794417571814; Wed, 11 Nov 2026
 09:19:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110215334.947250-1-colin.i.king@gmail.com>
In-Reply-To: <20261110215334.947250-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:19:19 -0500
X-Gm-Features: AclHuK9Ltzz1VkoOh3Aq7MLGRPgESiTW_dVehgDaxaFmKVDwtYC6QW68oRx-BvE
Message-ID: <CADnq5_PSk1mPj0t24ZjQfR5STAnVFvsB9wz-K6PqHjeWzoTS-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove extra trailing semicolon from a
 couple of statements
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dillon Varone <Dillon.Varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

On Tue, Nov 10, 2026 at 5:11=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There are a couple of statements that are terminated with ;; - fix this
> by removing the extra redundant semicolon.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/d=
ml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
> index 71d14fb8c830..5dd22003f165 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn6_funcs_mode_support.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn6_funcs_mode_support.c
> @@ -328,7 +328,7 @@ void dcn6_ms_calculate_writeback_bandwidth(
>                 }
>         }
>
> -       DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cf=
g->num_planes, DML2_MAX_WRITEBACK);;
> +       DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cf=
g->num_planes, DML2_MAX_WRITEBACK);
>         DML_LOG_FUNC_EXIT();
>  }
>
> @@ -4255,7 +4255,7 @@ enum dml2_status dml2_core_dcn6_funcs_validate_solu=
tion(struct dml2_core_instanc
>         enum dml2_status status =3D DML2_STATUS_OK;
>         struct dml2_core_calculate_ms_context *calc_ms_ctx =3D &core->scr=
atch.mode_support_locals.calc_ms_ctx;
>         struct dml2_calculate_mcache_allocation_in_out *calc_mcache_alloc=
ation_params =3D
> -                       &core->scratch.mode_support_locals.calc_mcache_al=
location_params;;
> +                       &core->scratch.mode_support_locals.calc_mcache_al=
location_params;
>         struct dml2_core_internal_display_mode_lib *mode_lib =3D &core->c=
lean_me_up.mode_lib;
>         unsigned int i;
>
> --
> 2.55.0
>
