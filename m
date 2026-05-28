Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E3ACD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C869110F592;
	Thu, 28 May 2026 19:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TyIpD5Qb";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A51110F592
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:03:38 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304e86ecebfso15634eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779995017; cv=none;
 d=google.com; s=arc-20240605;
 b=gQAvlaMp4sgo3U0JaWCFI1MJCFpYnECtp13wa/5I10zZbsb9PpBkl0PnsQZqsQb5Cf
 0hNznaN1EZttvB3OqEvzwgQa5XB9u8PtpMQBS9JOqZCjIF2ZDtaqNd4VRe5dLHG832lD
 ngoOQ6OCQTygU2v4q7CrdyHesK2EsPgsMKNv10tAzq6zyzKfytYdDKHpSYku2FVxcJpS
 2M0vHs+PTMLBjBQpAcZBo7GmW8xRARAMFIOWHbQsRukw+dd6mIcuixtHqm0fGGbH5bZU
 1wbWAVksJf30yxIDUFj5qUIkIl0uVfSCfuJ5TnyH0c1x2xdOhcZjqOf44Ot/wpbEXmOj
 jlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8A2SN4X3OFcTcNOFQSoYJ/Kcbx3sV02TXx8ZftUXyl8=;
 fh=LA4U/sRJ5HJpMpyXizo9C1bfGHTiIt+hrJyC4csWVKc=;
 b=lC8l/1Jp6nGEefINPUpsonGkw6U54nISIqCO2JNvOBPNMOdV2e9BkYLPG48u+Wb7i2
 jJYDgQV94v94kDrsO+ASvIROKIXQlMFKloi5+OKmHjvKFbYIRkUa/WILPAmg1CnROYiq
 OPl2Ujt8UfTE9gtzQWhlpCnEuE9qmBho+eBTp6w/5PWtut0X637Ib0WzoWqmFCS6a9kD
 KvUfpj0xMIxTEEFM10jcEltAf2hd82gKZLgk1nqybhA7nDgjvFU+zns7Gfo8XbWTC/gx
 BSR99Jm3fdDWjlLYMQ109VONx9GKyGxBMfOyPcl+bVDGQEimV0aH/IRjjJA4IVAKNKzQ
 KXnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779995017; x=1780599817; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A2SN4X3OFcTcNOFQSoYJ/Kcbx3sV02TXx8ZftUXyl8=;
 b=TyIpD5QbVD5fCwY2iSrhayJl6wmpkUelg1xeaAJ5Iq28cgaoO6h6dQqp0wU7HE6LoP
 EJMjiLBgyXztCrSHygB+MF0JzYtRqUUy2aOaaj5PJI//xwfzReYVGJBpme4PatYhSneh
 G+QTY2sbcuFrfs4bq4IEKSBGHKfJCQTnWxIuWoNRqzMny9VkmpUZJRqtnuH9GtdzM9Nq
 zfw90a5jMYI4s2LcVNv/EbmutWQ7HOc+kxVB7AVTQfXJJjl/+J87gJFtyOwpwkBiOwR7
 MBdO3H5XddMAsQAad9wN3ukF2Moe1w6L+wi7/Xj/BJ5fNzuANdq+XfTj3q+QT5aZTrvh
 Mcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995017; x=1780599817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8A2SN4X3OFcTcNOFQSoYJ/Kcbx3sV02TXx8ZftUXyl8=;
 b=tRyvm9oyRRaE+JpXudfPhl2Og+/eP2fRX86ZjAq0sCDBcjmPz02RB/QVhZ6dTTAhLP
 zm5+ipQFD6Pvp8481h2G3dvU5p/7lHIPvD8evOx0da1A8RAAz7Hb+i0+O2xA/9Ey6Ldo
 ffFx4xaGEfAvI3pPYmjMCOfXIPU6/gcGzYKNu7Sw4cJSiJAfecF18wJyGjYLgxWSe7Sd
 dZCT+9Ph3AFA9Rb808/HKl8YQsAJ7Eqf2ig7gML/alE8e5RFbOVUzHxJGVQMIsUj62hk
 wUWAUxETnJsBmbRNBkUNJ0NInD0BpEtLU0L1NXrUvQ/sywBLLgu2+mbGtIcZL58ypf0H
 tMrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jepqFWT5VB5w/Y7/rxHulKLeZpNdfIVWZXCfwrEsTIy1u6H1V8Slal1cVvIJBTkUrJydpk3ZmRXk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiZr3+KdtKwuU0aG/u1MxHGG3yTawJfkEE3NK2QuPgdt9v8Zht
 uoZLcN0ptlFev61BDkCHUKqRabSdnzeq79lCaMLdgokTzzgT1ahwQa7yew5IgYK0YM3eCTFcOW0
 P9xPhV2j4N2xws8aW6LyDMyQ8i7xJDw0=
X-Gm-Gg: Acq92OHPh6m/Kv9CHOIvwE+znZ7dB8QBajwMGwYnb14FwkS9ljWSG45lhYunpxVs+uB
 3uS8vudLf6PQ8YrilIAMAPZxGjzqb286Lv49o0frtpvjFdRlj1ulWLXOgDP3uUBSXBvgZt+NA4s
 AhN43RY7upnCNXoJXJw7aj8pzVoG6MZt//oY5PNgHTuT2l9r5sG9YJhcr9ybNPyL4zGw9IvOAfx
 q4JdrGyUGqSljOL+uIY2eMKbzrUT7qPyXUGK3SghQuydV0KH8i355o0zJiJ7viJLKtTq/neB+8s
 tN5HBLjReLyWti8ITm7BGfS0J2G23Ogn4aH9PEe/h+U1vm48/hRYPtcGgeCtKFUPwyYpg08w9UM
 jLaXfnidRhRUQf+A=
X-Received: by 2002:a05:7022:ef18:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-137a81352b9mr35853c88.2.1779995017322; Thu, 28 May 2026
 12:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260528070016.14843-1-leorize+oss@disroot.org>
In-Reply-To: <20260528070016.14843-1-leorize+oss@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 15:03:25 -0400
X-Gm-Features: AVHnY4Kszkq6EwAjLYJ1z0b1-DnJpnDWRLuUmFay7LmjcRJeyh_qxMbDCX9ofIs
Message-ID: <CADnq5_OBaVum+jV3HBL3mqXfvrhqVOu+gcU9Y2QHdRryQDw8SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add missing CSC entries for BT.2020 for
 DCE IPs
To: Leorize <leorize+oss@disroot.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
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

On Thu, May 28, 2026 at 3:39=E2=80=AFAM Leorize <leorize+oss@disroot.org> w=
rote:
>
> DCE-based hardware does not have the CSC matrices for BT.2020, which
> causes the driver to fallback to the GPU built-in matrices. This does
> not appear to cause any issues for RGB sinks, but causes major color
> artifacts for YCbCr ones (e.g. black becomes green).
>
> This commit adds the missing CSC matrices (taken from DC common) to DCE
> CSC tables, resolving the issue.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3358
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5333
> Assisted-by: oh-my-pi:GPT-5.5
> Signed-off-by: Leorize <leorize+oss@disroot.org>

This looks reasonable to me.  @Wentland, Harry, @Leo (Sunpeng) Li any conce=
rns?

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c     | 10 +++++++++-
>  .../gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c   | 10 +++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers=
/gpu/drm/amd/display/dc/dce/dce_transform.c
> index b3640682fa60..12c85c3afd6a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> @@ -110,7 +110,15 @@ static const struct out_csc_color_matrix global_colo=
r_matrix[] =3D {
>  { COLOR_SPACE_YCBCR601_LIMITED, { 0xE00, 0xF447, 0xFDB9, 0x1000, 0x991,
>         0x12C9, 0x3A6, 0x200, 0xFB47, 0xF6B9, 0xE00, 0x1000} },
>  { COLOR_SPACE_YCBCR709_LIMITED, { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, =
0x16E3,
> -       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} }
> +       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
> +{ COLOR_SPACE_2020_RGB_FULLRANGE,
> +       { 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
> +{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
> +       { 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} =
},
> +{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x08=
68,
> +       0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
> +{ COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,=
 0x15B2,
> +       0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
>  };
>
>  static bool setup_scaling_configuration(
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/d=
rivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> index cf63fac82832..1ed018aaa4bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> @@ -88,7 +88,15 @@ static const struct out_csc_color_matrix global_color_=
matrix[] =3D {
>  { COLOR_SPACE_YCBCR601_LIMITED, { 0xE00, 0xF447, 0xFDB9, 0x1000, 0x991,
>         0x12C9, 0x3A6, 0x200, 0xFB47, 0xF6B9, 0xE00, 0x1000} },
>  { COLOR_SPACE_YCBCR709_LIMITED, { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, =
0x16E3,
> -       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} }
> +       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
> +{ COLOR_SPACE_2020_RGB_FULLRANGE,
> +       { 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
> +{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
> +       { 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} =
},
> +{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x08=
68,
> +       0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
> +{ COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,=
 0x15B2,
> +       0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
>  };
>
>  enum csc_color_mode {
> --
> 2.54.0
>
