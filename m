Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9895CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3717410F132;
	Tue,  2 Jun 2026 13:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="x1Qs5+oX";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2185210F132
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:44:09 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-68b2229b48eso9224769a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 06:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407848; cv=none;
 d=google.com; s=arc-20240605;
 b=ZY81pGerHqiCeHPEscwBFDZ6NX0luVpGWDtAW3mreOMX0R3Azi1plO1Z0F2UK3jGnK
 U2x+pjM+oOuLzudEuM0nQiXbIJHcK4qkTLeT7yMrqG88RRH/wldOeNboXWAUeZTcBWjv
 4JDhhGXm03iujvGACPM4zzmxjVCG9Qf3OjJfLuTldfMCL6MTrpYkm2/h6140KrRLpNK2
 5BQAlKf1tZ5LUK3YDjbCZMpZ6Lpzmh5UTQIYTFVjCEvmvOe2nOWjIVQEHPSn5OwT60fz
 6sZ+7kGenVPJSqBwdHRkvFSGZ+B1zcGJJFgErhugw3QElvvD+fEn4wOVVF73LCiOR19m
 liPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=82dEe/gKwhXZVRLk9OdQ2RS4d20ckRZa2yqh09EPZPE=;
 fh=8waUu9cmunMTuEIwzVnE748+aHWLriQy0T74cIHGHes=;
 b=NsaoZa78RiuKu9vGp2WrWDshR5ZyabfdZi+4cNQmVkUKdR24Y89yaButriSC4xhMho
 NvRGGUfCIjcJo6RSkilhgx9F8jUEo43TNV/k7DXELw4q5xOOv8Az/H1J12EIupSEOVP6
 tCH4c6Kdx1YV9KN5JJ6vD1CsezFeEZwI550zUhbokQ0I4eeIEhGRKDu+BYydqLwBe4lz
 i1NuwpgIaVfPPryUueATwDSbbIASQC7wscQjPoHe5+V0Pvd3u9z6QuOFPPmZq8AxoFXY
 fbEDZrxFzy5rohmVxFe8MA+2r8qMv4cuclh5dimwkwkG6eQtzciBe9/t7kc4e/RXR01k
 wbLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1780407848; x=1781012648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82dEe/gKwhXZVRLk9OdQ2RS4d20ckRZa2yqh09EPZPE=;
 b=x1Qs5+oXvzHsQrFTwhH892GFPI5RD5c+G+2ofea0/EjEbfaIjJw0YDitvjl4t7zdTl
 kBGJRCsrP2V9x2d90a9B7lKyG3lLRBfC6vqWoCemAst0Gec9aTE5umqPOFb1eUKOKo+A
 +zy5rs2Ee0oAp9ws9OQXZ7rUzygreSsxmChKYd/oiiciUm2G2XlHyIABWxaX3EVYUIhm
 AWVYQos0nJcWNkyHYPkQ7cbAt0R+SFckJ01KAG1fLvsBdV+JyTaox3Dhd8mi0Pr+sdAX
 KEAhZF/tgIi7RvpTy31tp4fufRE8RNvfJFIqYJqGJxPZ6EKkpstCeaNPCqA90dYneQZE
 IZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780407848; x=1781012648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=82dEe/gKwhXZVRLk9OdQ2RS4d20ckRZa2yqh09EPZPE=;
 b=otr8TxHOae7sq0HFHf2sxG3dnJ0NsqO2v4w7s9EtwpsVCKsfgKQ90nX08gY9USaHA9
 jJ6/y604yrPq+3P69L554dGMBzXHfrQENp1MW6UQAvOTg40tUD/OLiAxs3BRLjh1V8GY
 DUWVFrg1qSJap2TPrudU8tAuhw59yhEU3a20Hq6zjc9EmwEeEiGke9ZUljyW5muC/FmY
 J2vxaUNSh12PbGnU8Q/YVhoF5pfeSYxIaiiaiRZ24PUqAC22vxAKt9nmr/0P9WGOhMCO
 zxQU/ZoJzHKY/MryN3InOEbhAzb+/G7+e8NqWSdHFxAw7rlvPGT0OeRLel6Yi8Q0xJUP
 6tZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Pw9THr7G/sP5If8mneL6hJsjjW9vVUt1L951ObeWrB1KnAD6Khai3CO3DFiwDSX29QDwZPkIXgno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7afamEAOaPObL/gpdTDlTyBgsPqSR2fiSA69AwbgW5NpR/gF4
 5djUEEaxspWt9/NsmbsgKgfDkj9Ya1Tfj3fMlwqajGJmmdjRq9GD1CCD986wFen89PlsBduhsvA
 mz7UqTf7YplaO6SeOlUMEacMffPGIJYJ8ooarINhGhA==
X-Gm-Gg: Acq92OGdkCwYKB7GBqU+/kosUHEeFIsxMZ1Runu4ldRZK1CARiPpizd8rXYNrmPcq53
 e2o6GvJm1Ud1vq3pohYtNlSrIDqQFKX+sAZiiITeliCbQlAPGjqQMEXb3k4DmhxsNTCk2UcI7/1
 T3gxNPmoNFLi+OLo0VyXUT7KqrTgEwn1kDFxrvOJT1Wy7OJLSdz4TBxxtf9117U2RvhYwr59P7s
 CYoi0vhRqs7DKpKFkG+v4wlNm6t/5I3jLhwaRU1HsLaCnFn5F7UozrYLOPv+Yc4qG0vUmk4Jlz9
 3qEtv6b6+dVEy3DbwG09fOvxRTjoyqd5ggn4+EyWvN9E/nuxaJZuVYbhVF9JEkPuLbNdrMcIboX
 BiXINUDRSRN3EW3ieLtvfnpz3BSMpbVli5y3ztoeEcXRgZi4=
X-Received: by 2002:a05:6402:a50e:b0:67f:9124:8815 with SMTP id
 4fb4d7f45d1cf-68c8cc29ecfmr4897371a12.17.1780407848188; Tue, 02 Jun 2026
 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260512190019.228440-1-guilherme.bozi@usp.br>
In-Reply-To: <20260512190019.228440-1-guilherme.bozi@usp.br>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 2 Jun 2026 10:43:56 -0300
X-Gm-Features: AVHnY4KfJ5TFV44CTzJXc_Y5_RuCxlXUjuKa27M2A4_OGavaoTMNEMI_WfjiQ1Y
Message-ID: <CAJgF-xu=wPXkdSD-HwjDheSWXvokcCg9nZ3_ku12=0N9i96yaA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/amd/display: convert GPIO translation logic to
 lookup tables
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

Gentle ping on this series. Thanks.

Kind regards,
Guilherme Ivo

On Tue, May 12, 2026 at 4:00=E2=80=AFPM Guilherme Ivo Bozi
<guilherme.bozi@usp.br> wrote:
>
> This series converts the GPIO HW translation logic used by
> multiple DCN generations from large switch statements to
> static lookup tables with shared helper functions.
>
> The new implementation reduces duplicated translation logic
> across generations and makes the GPIO mappings easier to
> maintain and extend.
>
> The series introduces generic GPIO translation helpers first,
> followed by per-generation conversions.
>
> The following generations were converted:
>
>   - dcn10
>   - dcn20
>   - dcn21
>   - dcn30
>   - dcn315
>   - dcn32
>   - dcn401
>   - dcn42
>
> The dce60, dce80, dce110 and dce120 implementations were
> left unchanged for now.
>
> dce60 and dce80 contain special switch-case handling paths
> that currently do not map cleanly to the new table-based
> representation, so they were intentionally excluded from
> this refactor.
>
> No functional changes intended.
>
> Guilherme Ivo Bozi (9):
>   drm/amd/display: add GPIO HW translation helpers
>   drm/amd/display: convert dcn10 GPIO translation to lookup tables
>   drm/amd/display: convert dcn20 GPIO translation to lookup tables
>   drm/amd/display: convert dcn21 GPIO translation to lookup tables
>   drm/amd/display: convert dcn30 GPIO translation to lookup tables
>   drm/amd/display: convert dcn315 GPIO translation to lookup tables
>   drm/amd/display: convert dcn32 GPIO translation to lookup tables
>   drm/amd/display: convert dcn401 GPIO translation to lookup tables
>   drm/amd/display: convert dcn42 GPIO translation to lookup tables
>
>  .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
>  .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
>  .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
>  .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
>  .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
>  .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
>  .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
>  .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
>  .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
>  .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
>  .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
>  11 files changed, 1274 insertions(+), 2035 deletions(-)
>
> --
> 2.47.3
>
