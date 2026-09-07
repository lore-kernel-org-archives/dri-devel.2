Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5355BC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847D510E837;
	Mon,  7 Sep 2026 13:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1/ded7L";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED0D10E831
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:31:17 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aa8e6bbso84637d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788787877; x=1789392677; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eWEcZDJ0d/jLVDHWzL+8bGu4JgK8yNHYL2NxU1NtGM8=;
 b=P1/ded7Lv81WopsO0Z80bZ4LmiD6Yfw4g+TluJcjPi6BOh8heZgZPgVr32auoAFwaZ
 rscvH7k/ruWDvI3m7BnhaznPejNHmM1z8ljJ80aEdXRSdS4Yu+khV9b3MOANT5pjbco4
 dkoCYiYt27JyvuHRheNIx/1fBA5l8LNcFpI16tyGw0fvahGjGqUmGtnXfPBXdBGpZpzW
 3lVYJY1t3k+X9C+WMqSEde9f+V4CZGoXbL1utNFcc7un6usItKmEanycu0z814hNHWJq
 YL6ouEeu5Z1lbbPDLPu+9mv+yTBPKZSBUM8/0yNJbrDzQDXhDq/LS+p3SU5YHxnpxIuK
 ve0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787877; x=1789392677;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eWEcZDJ0d/jLVDHWzL+8bGu4JgK8yNHYL2NxU1NtGM8=;
 b=LJPeg+gxqxM/ONowlqAtHHYTJ5gM1ifLFVvlUGXXXOx/4ufwoVjrrlpxAl2EQxywWE
 PUs3y4xLbTvJ0wQSYDe8TuH2OUZRhgodVfx2OR8szDZNU8y5drZUQIgoV/BS7IJGFwVY
 WJ2sMVJERpmKW+2Vxr6JmccAxharnsWWp1aZRU61c4j6ktL6axWQ2mB1s5HMy6Z5t75m
 hIe3jJPg0Azd/3lgouABox6mjuOZkQ2ogEqZpCzc6anaHbfqH3o9qYqmJeCuvMLeP2eu
 pG2WgoFDR4OL0i0taq9LDZPJWO4uSFu6CaJW7zQbS3vSZTeU7omqOpFOuaDs9DhW6Zew
 f2GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7k55S4WA86g+T/kA7w9oBL0VjwSqqn6YUoB9NXKDs0ylQgZUtr+qoaMQbOOUtkgFJ77zk3sQ2/Iw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/p+Y+FaZBx3GohqLg2fLKUnXX/rh8LqAoAs9PG2slCyu0Qe6l
 TdWl8PL6J4D77vi4xVed1y8cC+C7tNjc4MRraC5KBcaneL90lm+xUkM=
X-Gm-Gg: AYBFou3B7hxTXZFBcSVBdRj4UfqM7Cox0OCTNHR/kQbdNfzdEtk7aafQl5C3cdfG52o
 /snN2urX8WKvmYdMkdU1R5+ZZQcZks05/D9cPHLNZuSKrdyPG0iQn+k/BiPRWGV/Q6LZqurFhwb
 jmV/gMwd7HXVeK5li/KojkzXzwHeKevYJoKSKihY/G5x/Xh1SbEI0qTv/peQlTU2I04b4i/Mrz1
 NtfqyDrC5B+I1jPHMxUK8yiemo3vTOwzqaWfUht8M+8Rr609zchvVr3YHFj7z2H9CwWdH5kgH5b
 otOPLU1woInQ3CLXe0nuL4VpQnwTNunA6iEFkQNePE/QfYdOH9NxCVra6vGB5kQa/o37AKliy3Q
 sj9Pyy1LeGBabp09mYX62u141VfbuU0Xu3al09d8WpNHktEj7XqdjRiTm9ytzk4TooXgWgPULIo
 qXiFxObVESjcZDaPx7gwB76C3y1342PnXcUU9DscOvcD2hKVCmu+AebmrvGEYjFuakFXBf4dv8c
 kn0CAUyhvK/VND4PzLee/s=
X-Received: by 2002:a05:690e:1288:b0:66f:a6e9:764c with SMTP id
 956f58d0204a3-670f494fd90mr258149d50.22.1788787876678; 
 Mon, 07 Sep 2026 06:31:16 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66fb48b374bsm8237629d50.3.2026.09.07.06.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:31:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 10:31:10 -0300
Message-Id: <DL94DN6MH6UD.2XPV905D3FQ5Q@gmail.com>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>
Cc: "Brigham Campbell" <me@brighamcampbell.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/mipi-dsi: docs: Mark mipi_dsi_compression_mode() as
 deprecated
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260702194223.290763-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260702194223.290763-1-nico.antinori.7@gmail.com>
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

Hello,

On Thu Jul 2, 2026 at 4:42 PM -03, Nicol=C3=A1s Antinori wrote:
> The mipi_dsi_compression_mode() function is a thin wrapper around
> mipi_dsi_compression_mode_ext(), which is already marked as deprecated.
> Additionally, the non-deprecated mipi_dsi_compression_mode_multi()
> alternative exists.
>
> Document this deprecation to encourage developers to use the multi varian=
t.
>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 3ac1dd5ad640..9e20818f2de0 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -699,6 +699,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode_ext);
>   * Enable or disable Display Stream Compression on the peripheral using =
the
>   * default Picture Parameter Set and VESA DSC 1.1 algorithm.
>   *
> + * This function is deprecated. Use mipi_dsi_compression_mode_multi() in=
stead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> --
> 2.47.3

Following up on this patch fixing the documentation comment. Just wanted
to check if there are any feedback or updates required on this.

Thanks,
Nicol=C3=A1s
