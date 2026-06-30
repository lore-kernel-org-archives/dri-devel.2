Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C34C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557B110EC8A;
	Tue, 30 Jun 2026 13:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWKlSxEF";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E37410EC8A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:33:27 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-137dd497007so247200c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782826406; cv=none;
 d=google.com; s=arc-20260327;
 b=S6ule07y6ntYBNBEL10HeA6k7iCbH4+9iNw6egUIKkdvwhuHYP3IoNmRzgLOEgqakg
 Iko6ZBeIg9lihi8f4qVH0gXxNcWw1ut7BmJzndrCtqOoaKggNLWl8dQAgE42laLZ6q/v
 sTBKep5q0z0V+jW758pPCE6t82/WKEVksSzYLyAyLgMM3fNuTXALxBFl8L763GNNiXMO
 dMqpeVpJ4lJmYu8mZtOIjVOZBqlmHdqRTWzbzykUI6niiRyF34q6AmT6dfjR9e8Owjht
 5HvqkWirEC1bLc/dxXQXIFZhjknGb1T2qHA1EyWghSSbpMpHKJcZ1dnxDm+8t7tWFkLH
 DCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MxO8NQTZB9THcSU9sWEewow4jOxEhdvT7ds9pL/iUyg=;
 fh=9qYPo86GaNwMQjqlPQuIQVb6c6PBVjG4Zwpd1Ejf+Ik=;
 b=bs4Zw0rADEaYjTAfjW5+PPFI0EXde9U6IVZ/d8Hl7EPF1MXJ3BwAzjDgkEUyPyTTLU
 2pE4Qn7iq8eU2FmS6avWlAkmDz/j8CXYeEDk2v9Axdoo/forKOvNLu90O4kA2UyYIU7n
 pzJIV0qs6/NneJTzOPsyWJKfjPYvTsgqFt9kRtzWMEQfCVhutFj+UTcC0yMENRpTQ/tz
 PukgkGfcZraPMhUzp+CiF9QzkiYxnhoXuuez/XSc7ayBcoQPgv8UhCfQ8gg9d6ss+SfG
 1nZNl00UNn2efaJQXzFVl57idaI3EsUm+yVkOP9Xi2kjDdp95Zs3Iw5uPU9Md7yYh5na
 YhDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782826406; x=1783431206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MxO8NQTZB9THcSU9sWEewow4jOxEhdvT7ds9pL/iUyg=;
 b=FWKlSxEFv2SLBqsMn4dzT73OSJa42L98HtmLa3WBclAoe14NF5v1a0YoJSVP1Qfwc8
 1NxXu2rQmVTY6MrEcEOvupg4DvVg6ulZ8THQpsgY//SIig3c4QZvkVCT6Bz+sJo4zjQW
 OuXwsqEZb/+Okv/FyJmpVc84hsC3vJH01xM4kO/VXtG/oChNYC5SjdEe3ZCKCFpCQYeJ
 v27JIlPT5OXP/aZYk3kLBEYJXAG6kFPVuEBC/i3mK1IPvVv9hd2zx+qTE0Fm6sDh4I/d
 aJJVnNDRXgzT7PiwtS9g2nX1J0WDMy0hOcC4YzwB9Ewb3iJbVhZm6s710NYNd1Xd95/u
 /N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826406; x=1783431206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MxO8NQTZB9THcSU9sWEewow4jOxEhdvT7ds9pL/iUyg=;
 b=KcxPBnyXO/qzsqUR02Bgse4rm014hrmlY73r4guWNnrR64s4QItA2V/u/mBZEwRxYY
 NNmLcEJWlwUPaajmeiyZg2q9R5enr+QaPOmZKICRVXVXXbu0FbCiMpc8F6CFfqOcmEal
 IWrrinEEAugYVoydddOOjPQiz66iFQoEEBZXQjOP6Vvf6DlgLNtzouHDVkr/yDM2XDgV
 eUgHdowLHbBxDx7ARr4aId/vnfyR1W3dSKtQbeJfNQvurj/E3H27x1HaDxeeb/jf5lc7
 Qg2Kuy/Bfv6Apq2WNGbtOSeJYLIpHADvJcBG4mwWuOnzakK7ZyqGhq7lG6uiP7U6cKzg
 gJwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gBFiF4h1ZVhyYhKyPnJnRfc62So9C38v+pAiPW591mY0JX/Etpe53pbQn0t9ua5tkc2i+LQCVMX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSaQhTgxJfE7ztsNkV7Vv2ipMlr9P1WbDquGgITIe1/gqKVxSo
 zMnozLxpnPLO/wYzoVEW68U0+ZTKo22JHdV5JPb/HD0koFVDzOLlfRsZOioaWm0VDJrLUI6Gz8e
 kJvbVGrkFFXjxuiEFPVLm25yF5hBV/g648A==
X-Gm-Gg: AfdE7cnd1gMLmu/yrLaztkKTvdlz5TyM+cWBhhgFXS4Tb3b8GnQrEu1vlkmvwk2VMsZ
 BGT99B7P/weOP/o30RWz2T3/44vmnkkrVifuoEoN1PAK9RP/lfWcQ85kyC7MeO8jPiu5F9RT8pd
 3KxMJXlT3+MU8UQxnYEJzEs7+MDPHlamdgJ78d2sITp9X1L2S09HzVMYWqLZnF+mZ7d8DvQ3RnA
 u4FGy47pI+ciyJTX6oCCH74iHnMnW5uBCjYPsOhn1oe4QCdCNJL0Cz7/KyyD1AVesbeL0rCcTHh
 lgeIYGS/bjD9vKp51XMGPMX35+FNlpAZtlgRigZgEpYW7QMiLPfPCzaFOkk=
X-Received: by 2002:a05:7022:ef0b:b0:139:ed59:8745 with SMTP id
 a92af1059eb24-13b2a1bcf85mr1062085c88.8.1782826406221; Tue, 30 Jun 2026
 06:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260630072838.67086-1-ke.zhao.kernel@gmail.com>
In-Reply-To: <20260630072838.67086-1-ke.zhao.kernel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Jun 2026 09:33:13 -0400
X-Gm-Features: AVVi8CdM88QkmqoCNLlwZsB6fAv5X0TzxYB4d_ZM8E9TNR3nyDqVPkCBZr0u2y8
Message-ID: <CADnq5_PjWYebXd3-MBik0mOvEXheRckZo3KeD4T5G=LS5D0Szg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typo in comment
To: Ke Zhao <ke.zhao.kernel@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, pierre-eric.pelloux-prayer@amd.com, lijo.lazar@amd.com, 
 felix.kuehling@amd.com, srinivasan.shanmugam@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
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

Applied.  thanks!

Alex

On Tue, Jun 30, 2026 at 9:24=E2=80=AFAM Ke Zhao <ke.zhao.kernel@gmail.com> =
wrote:
>
> It should be doorbell.
>
> Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 16c060badaee..b7be28d74e83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2187,7 +2187,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> -       /* Create a boorbell page for kernel usages */
> +       /* Create a doorbell page for kernel usages */
>         r =3D amdgpu_doorbell_create_kernel_doorbells(adev);
>         if (r) {
>                 dev_err(adev->dev, "Failed to initialize kernel doorbells=
.\n");
> --
> 2.43.0
>
