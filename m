Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9EEE8536F
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 13:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9283B10E336;
	Fri,  3 Apr 2026 13:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eA0faHic";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3CB10E4C0
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 13:58:39 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2cb19ddda43so144261eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 06:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775224719; cv=none;
 d=google.com; s=arc-20240605;
 b=fQb0y+hiEZithm4GAG4Z8JogLWr8kBv/Uyivuq5TMHWB/9Vvhiq0tTbokaq+ygHZSr
 aP6xkv974yshRpQdAuh8n4nDHq+pGFJ18b3bmGIsKAKr4Df2V31idfeUtPxvOoNsUqBP
 gj+CHvAnGmtXNyEtiyY0yLaUQEgG00BPjJoeK/aR39a5P7eHybBSELi5WfqIY3IbElVa
 OjvVsMJ6iUpwStzMNEPsgQ8uIcsODfR6/YFZKPgC4Yq7PAqOEwiziRX/rkt2X/X7saBx
 cn4kE4y5bh9H1RvFQNA7FNxLXhO9r6At+SfVfW4iI2l44reOsXlLlhaPykWEpATpqfCG
 t+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E/8MLjB597InPhhmW9JbLbwR8LfCAxtR7ZWCpA3gxaY=;
 fh=xMzErR+qemB7eeeoUo4mfX+Z9G0ZjXcGXkN+AHkhVFg=;
 b=hxrW13m5yzY5yJI2OsBckfpQsrH9RrdM5DYg/5mf60p77NYOnVivnxQB9cS/KRXI47
 1RO3RaG59FeNizP4mtewyKNsYbVwTkRIUoMhbBdG2QOUnPOOxjAhO8NFllEHZgoX3WTh
 JPjdDMLLBqb1Dj8gKkdFs86F+H5jWJ9CDNHD/OWdVp76C/KMmqCfKnkjvyQQfaKs4lt2
 KNTYlGzXePqtUuFrUKyzUn+2Rk7DpJsljAitywirkoppBnrrFY/BT86kdfBKU7Z3u1B+
 VumBjytGrEhAM5HlOHllxC+q6WbGzCvy4d0uFW1VfkBryidIC8pC85mTAldiOuc68Axg
 ykGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224719; x=1775829519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/8MLjB597InPhhmW9JbLbwR8LfCAxtR7ZWCpA3gxaY=;
 b=eA0faHic0JBL4DRSNvoHSXH2r7SgPznK7xa3bW7pDy6Vi8lqm4yHlYIgroTYuXVZ4L
 580FvF8EyVShq08W06okh4l5jdYabSlmEqCSJFoU3fieP/I4XfV8t3bEIidFW6NholpP
 NvbBYzOS1VozbHpzZim/Xqms/fGYv3D2ePlxzro0M94Unu0hQ0KtECjTfVgw+5dxX3gz
 H4I4CbQngcw9ISIHnmaVSDMU2vZwKC5hdN+zYYNCJi/iBMxlMYOr756pFPu+Xf9Siypd
 OfxGLZMDUF2yw+bDvfZwrRT5/E92kFVM21SeOYDeWMkIqQbMMDiBe1e92RpwKIsgeJ/A
 6P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224719; x=1775829519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E/8MLjB597InPhhmW9JbLbwR8LfCAxtR7ZWCpA3gxaY=;
 b=Hyoka/dWQpFzHLC2wLsp2DlMOMz66mkJWzVEQBn4VHN50XAVLT+orX0s/TQjwlkkLL
 V+G9gjw5bf1ADIVidg6rEzZVEe4/DRPiqwfxuLedKzFANVWS4sSo2mKjoBjIryHCMagD
 W+jrjG17oxdWS0YzrStGhITamUt1LHSze1gVkiTwUozXt0/HetuguA4KaM3sWrcJHYYb
 HFtaxd4mieJhNSOES0dehBHXUzadIRjY8vEOf3YhfdD89jH8YvTRlEB0A68gnjKIpSn3
 u3V/nSw5eHveoQCy3X9u++VoXmribmL6Ce9gwMkHlMbjhttnM4YqdWfYEXJakz/jrEbG
 PAjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYWA/bV7GtH265yDPYNvM1FrpvwiNbSeXhPgxo1U4HBFA465qFJzmHXIazSVrbjYRg8xpFgnBYUlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyI4SpgqBkrGFNAi8z1NSEN0ZDHIwoSSz986QGc4DKnArdmY4R
 S3w80R84955wWirHMIw17hAtT9rXsvkpVE+NOiKqyY+9y/knITiqS4PXYUZIIfwPmZV4W3zfIhk
 3FUtcDfXN22WFfE9aFaV6Jbul4c5hpBw=
X-Gm-Gg: ATEYQzwuYMz4Hn1Hh8s/RYXbzy383jNj2DVHmCTkGKUKbLp11so91oJxjvMl5sEz+fE
 Eqf7TL8vj1iNSzSR49v/XAczjWyO0TstAOvGSrjjizbDexrWlinhEtO8f5exAssQ/DhV2bypV9C
 zOoaoVnVxCuDR9LhTmKVvhmiMAqrnEmDHMsQffWItcOQvRPH0Scl1qriG1bMRehl8zwakntNMGO
 aILaHRyytfuY6pQtA7M18AEsewx/ike5U80YnRUx6vu4eneVN7Mjn9MbR9FVTBAomPaN162HB8I
 0erhE3jcppMjsWQ3gce6qVdFtHnSAzasIAE1PSVNIflbf0Z47e8UlntdKbwycvE5wE2lqObkXCX
 D7fDi
X-Received: by 2002:a05:7022:90e:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-12bfb6e47a0mr628241c88.1.1775224718662; Fri, 03 Apr 2026
 06:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260403082207.1533450-1-linus.probert@gmail.com>
 <20260403082207.1533450-3-linus.probert@gmail.com>
In-Reply-To: <20260403082207.1533450-3-linus.probert@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 09:58:25 -0400
X-Gm-Features: AQROBzD4l2RuNXAWnyj10hqszozqRGOPyGhrLSo3OBrCysDjTXcQaYtTn5jK3PM
Message-ID: <CADnq5_NQPhgfuuawBQ+ZQY-aFxx7jFu16szgNE50+bbKHNx+bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Remove unused NUM_ELEMENTS macros
To: Linus Probert <linus.probert@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Robert P. J. Day" <rpjday@crashcourse.ca>
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

Applied the series.  Thanks!

On Fri, Apr 3, 2026 at 5:29=E2=80=AFAM Linus Probert <linus.probert@gmail.c=
om> wrote:
>
> Removes unused NUM_ELEMENTS macros. Discovered while removing cases
> where ARRAY_SIZE from the header <linus/array_size.h> can be used.
> This also aligns with the array_size.cocci coccinelle check.
>
> Suggested-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Linus Probert <linus.probert@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   | 3 ---
>  drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 3 ---
>  drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c      | 2 --
>  drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c      | 4 ----
>  4 files changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/dr=
ivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
> index f8f6019d8304..2bdd063cc1e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
> @@ -49,9 +49,6 @@
>  #define FN(reg_name, field_name) \
>         dpp->tf_shift->field_name, dpp->tf_mask->field_name
>
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
> -
>  enum dcn10_coef_filter_type_sel {
>         SCL_COEF_LUMA_VERT_FILTER =3D 0,
>         SCL_COEF_LUMA_HORZ_FILTER =3D 1,
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/=
drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> index 62bf7cea21d8..7b7a0c660d47 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> @@ -49,9 +49,6 @@
>  #define FN(reg_name, field_name) \
>         dpp->tf_shift->field_name, dpp->tf_mask->field_name
>
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
> -
>  enum dcn401_coef_filter_type_sel {
>         SCL_COEF_LUMA_VERT_FILTER =3D 0,
>         SCL_COEF_LUMA_HORZ_FILTER =3D 1,
> diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c b/drive=
rs/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
> index ea73473b970a..fa600593f4c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
> @@ -43,8 +43,6 @@
>  #define FN(reg_name, field_name) \
>         mpc20->mpc_shift->field_name, mpc20->mpc_mask->field_name
>
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
>  void mpc2_update_blending(
>         struct mpc *mpc,
>         struct mpcc_blnd_cfg *blnd_cfg,
> diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drive=
rs/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
> index 6bfd2c1294e5..ec2181d9f20b 100644
> --- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
> @@ -40,10 +40,6 @@
>  #define FN(reg_name, field_name) \
>         mpc30->mpc_shift->field_name, mpc30->mpc_mask->field_name
>
> -
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
> -
>  void mpc3_mpc_init(struct mpc *mpc)
>  {
>         struct dcn30_mpc *mpc30 =3D TO_DCN30_MPC(mpc);
> --
> 2.53.0
>
