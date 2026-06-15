Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C7ECD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8599910E4B2;
	Mon, 15 Jun 2026 17:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q90RLtpV";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7364010E5C4
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:50:07 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304dc707bfbso230305eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781545806; cv=none;
 d=google.com; s=arc-20240605;
 b=Y2q4cYTWqQqiFYkwe+VSUpsgpWf15zhg7uglUtLAQ75Ctv7SDJi20l6WzOhrLmVjGQ
 +qBvl+R+I7xNTsJnuzfTUtFaUH5IlS9RapEn+nQFp+O/nV1NoxZw+LVr41s91EiV/yvN
 oFuoqKQXHKaP0TrxzCq2FTqoDu/bjhjJsTmw2xz8rxx0Pm5yywrDmOnkE3HpqT1kWzry
 5dX+FE6FLouT4BWuMJJ/2PGHXTJA1ksmX1pzGxKa/g8F1TIBqMdil45ehTKnTnYsFlAc
 EujRyGAiSSlWceuF2PB0PEm+g8TChsR4FU0tEg5ryxoQOBpK2sJ/vVxu9hAsNjbJ6/ox
 Q2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QH6edDiZYrunzmCwgOfYr96OEZNPihGP8JCdMp4/enM=;
 fh=N9kH4MJaRK7JMmzqJrp9R1tSGqbMqv4Do83honOITjs=;
 b=G8bR1pbHhj4JojW63XYb9GAnfAUUB50UJ3Gzgt0nVrsRPpQFlFlQC9dABfQL2l3AGI
 uYUgjaEeI+hOQP9LUM/R3cwWTMnlnwWG0yYqBrGY51lg9jDe1mCGQppa2gaVSz9VegtM
 vCMAOl6LNthy7OXgrREWBizJYTIC1Kzqqk2SDNGarRx/VKKiB18AZ3VYAmSp1UnOohIM
 0bA7XB9KmgpnvFcxJylzLHOGS0CIsTOrtF7iaVyfw5Zo38j8CqGUt0FPpTXM05EzFojk
 84wGVZ/WwPD76uF0k9XL2zDvsq312ucGNfbawzR5K7DXFdTG8bDANKDKXegdQtJRj6Qo
 W+aA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781545806; x=1782150606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH6edDiZYrunzmCwgOfYr96OEZNPihGP8JCdMp4/enM=;
 b=q90RLtpVolusTw1dbX529iGvNtTi1QB4uiWZPxWyQd3z+e46GrKH/lb376qXqlzBYB
 f3D9wcF1v6krPolWKR04f9NlwfW7qQmuAzYxjzX3FpFW9wBMRjOveXAGiFc+hbVXwsrJ
 efyXp7Eo0wql0usmSiuctOSOaJhbrFOPUmJ7xbDx6uKJBSuFvMNQRuaZHvk3o1+VzVzm
 nQ3LfUD92XMxtY47vih4YiQAGOIts33jKHULFzeQTeGRiaP6e/P0YyQVoBvNLH3qGoUr
 pqEHFh4ZAGEG71QpgEJ/D+S4SCWllk25aoQYr6q7QWcG+UsPNNJM1M6Xy8E2rH8tud9F
 TuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545806; x=1782150606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QH6edDiZYrunzmCwgOfYr96OEZNPihGP8JCdMp4/enM=;
 b=AQzsuJn2UljrfO4ialrKmk8BSbLvpXw1vLcAeUKwVYjfGaNF+aLiVYS5EJckjVXIWU
 eNy8IxpN2adEiu4x99TiMI1EmDc9XTaP7qhp89O6E46qYDX5ImiemHnJ6d0LernIlpde
 gicavJ4244kQ4vOoqzFwRQ8L5RHBvFfiVHMLsOchMi4+JLTWfgVsntlZJcaJSrAEx3F7
 a4JN8fY5j1S2dWrSCfXbtOw66d9Lh29kOz15kb1TeAzaWl58g7JlLQNEPF1Q+9FueXbB
 j1b03TqZTTL830gp2iZ8fkhZRXYM05baPPQZnSkkFL2Xq6WBFC2VH2Zo/MeqeA0Rxy5P
 p1lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80KhD6IKbLHZ5/o3DK6WlaVcBPW7PK+qG0Uyek4etCK3UTM0bakwvSTh07xCVeWARJNZVYvkCot9A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNXMqv3bJWuDtCoSiWjyFF+TztyIJkmXfwwqelFMHjnysFveYZ
 nZgJ/wdqqNU1CiAJEymhZS72jITZmdSv6kY1eWl6X6Oj0iKQPxWfnlZTvmmn1uyAmEONdJBC7Ut
 xl+WBoR2RiO8qS1fmPIiuVPr8ZucJX/8=
X-Gm-Gg: Acq92OGgKgGyLeg2QDKJVrlhjt8GmlcwEDr/dHAyunHLOumAuCYvKI6yRxJlskC8q3r
 K2GicBKK8e4M5/yi7fyleybtXoZdVeTKg/c/qUPXuqZiq0ZWWF7JeHUqQJTL3MDKip4NIz3HtXL
 Q23MIwYZMcSavov5hYKXEUaX7XRFcPmoNnWJ1fRlb0hcgDPgBOXmUr1202VEjb8ZHpgJw2vN2Ms
 l9HbSm9u+hwQJZkQxkxYHb+183P+rXeZk8+Als/X2Z7xwu14Bwdz+9ydJE+WxsbblMcmV6JvL2z
 oL0/+Zi7FGwroCpDND44f1gJwjI/de/BSKMmaH9axWyD1WXXi0LfvOZ78ZgQh6MEbf3+Xw==
X-Received: by 2002:a05:7022:688a:b0:138:63d:e43e with SMTP id
 a92af1059eb24-1384bb7c5e9mr3340297c88.4.1781545806352; Mon, 15 Jun 2026
 10:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
 <e2023393-da68-4775-9f55-16363191328a@web.de>
In-Reply-To: <e2023393-da68-4775-9f55-16363191328a@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 13:49:54 -0400
X-Gm-Features: AVVi8CfMO9SzD3O4Xa5h3nVjisRImAqG6YrgxabGoNCulRONqwvNst645q0TcYo
Message-ID: <CADnq5_P6aSFKefO+f3aofhfNh7kELEQWxid4EWgwAUr2saEh8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/display: Simplify data output in
 psr_capability_show()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Jun 5, 2026 at 7:49=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 11:39:13 +0200
>
> Move the specification for a line break from a seq_puts() call
> to a seq_printf() call.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 4b09a740f205..6e6f391b640e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -1076,9 +1076,9 @@ static int psr_capability_show(struct seq_file *m, =
void *data)
>         seq_printf(m, "Sink support: %s", str_yes_no(link->dpcd_caps.psr_=
info.psr_version !=3D 0));
>         if (link->dpcd_caps.psr_info.psr_version)
>                 seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.psr_v=
ersion);
> -       seq_puts(m, "\n");

Why not just convert this to seq_putc() and drop the rest?  It seems
more logical from a code structure perspective.

Alex

>
> -       seq_printf(m, "Driver support: %s", str_yes_no(link->psr_settings=
.psr_feature_enabled));
> +       seq_printf(m, "\nDriver support: %s",
> +                  str_yes_no(link->psr_settings.psr_feature_enabled));
>         if (link->psr_settings.psr_version)
>                 seq_printf(m, " [0x%02x]", link->psr_settings.psr_version=
);
>         seq_puts(m, "\n");
> --
> 2.54.0
>
