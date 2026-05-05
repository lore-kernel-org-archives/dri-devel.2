Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA48CD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A6710EA57;
	Tue,  5 May 2026 10:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MrkBoILX";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F2710EA5E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:19:33 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-834da62e52dso2415203b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777976373; cv=none;
 d=google.com; s=arc-20240605;
 b=VLVFHjEnyN/51CRFvvCJKg5HxMhZ5xCLpJh95bai+TqqeHAWsPlZuq3n4hsl7uP579
 9KifAVJj+2EtuhK2OXWTsYjftJiGyLTlQcZkLiR6VzJcGCM07yl+YJBeoVwg93PGRMWZ
 a95pUcMZ/Xl+q0s14uzaG9Kb9CK8CzfQKu3ZJiWMGFxmDwSfzjDniT/QnPqXIVyLwpST
 gS745+sS50qEs2MuOZ4JI9E+KExSMuMhGqNLq7bx4vmTqTWEvHox6CoT4qs2QzwneWmW
 C9EFgHOWhDoq15j/Y+4YKTN+4jxqJ5PSngnG2m6193IeW1+7e/QrkkU99Bd0MqYr/T0E
 4OMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8JlOH3AnXsv8zCj3JKynCL7GH8Oym+OmPIIHWYj93HI=;
 fh=VpEuz/VRwrfY53MTKnfYPLQqfqw7Pmf/rl5RdS/ukYM=;
 b=j2r0YRw7OUtuvS9hS7iZUBQ27elXTJ7Rls7wOeon0jfyID2HbrWU+BorE3BdwAb+Cd
 EHaL52nwh939Uwx8Q+PZp9RgMIu4Xz0KAJDn5/b7wfVkcbbYGhHcVZkHexigIjHQDfRj
 utevv0qRtOXVcpLeL/ZtJmbHfiN1nHtLRAy5OPBbyWzzvFrhJs5fWe+PRYgZ7eEQtgDu
 MKqAjLEl2trB4Yn5WmqWYRqVq3b+CU/izssaENKxQJBzwRJ9GGyeIs3n0FUXPmvvo9x4
 lar3mdJ8sXxCw4/yU2xWONXv1i6CJr+Q5vqWlNZJ0FJ2SrztJ1+jLfeeXPZfKGlsJ6s/
 2nLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777976373; x=1778581173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JlOH3AnXsv8zCj3JKynCL7GH8Oym+OmPIIHWYj93HI=;
 b=MrkBoILXhlIiCreQMraeVH6IFRW9cjN4qeBCQ4lLMB9YaApocto4qbTu05X6LRH6nr
 tji44fGI06dnQpt8C/eY4Xkh7M2+Js9UkB2yD4LZh2qCglCkWStpBOty0czkKyMCUDGD
 McLnZ6LkxVKbwfSPbb82jINv1R7H86rhtq27OVU03JOubnkyFWc685dFv2aOoMx5mfaL
 QdztFdXbsboJE4imnr/b2N4CVy4BVImeJyqLmvENYRZjyVfItyX6fH8dn9HjNj32BCIl
 /mB2zD/CvQsfd2eEqQENqsAwHbzZ3gw9qIk5PI5m5PoiivCp3wjNbPO2+o+E15yJJf6W
 npLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777976373; x=1778581173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8JlOH3AnXsv8zCj3JKynCL7GH8Oym+OmPIIHWYj93HI=;
 b=Nkt/i3lIXv8p7ycLUpOqm5tdejnbERC2OBtUk8uUYdILgHZDqZg34zQ8PDCy1DhsAV
 0d2Kp8EiPvzkRSk5Zng6yRzgaUKn/OGWRP7GrJG9/Ll6ekVY7+MQORW90V4lVuVLDUF+
 A12HcFllQKnk+y/gd9l0B3g6Qq83R55UbIC58UeYVLp+w0RkipVZR2HdgVREaRT8yemN
 39UPZ/aiAhlE8w9mVDZ+dOArOfjO1Nx6AkG+qLWnHKSru1V/DWDWenFRYhm8ZTRM9/zI
 3D33rnlQHzAOhlHMCYerDyeJa5q3F82DUMO6xvTmumpWyzLLRCxZvtaZl9hV/Nj57KEg
 b4lw==
X-Gm-Message-State: AOJu0Yy911dH8vYHFIzKinfA3pi50h0f8r2ZCwLxcLt5kqm9mJerig1r
 tNvZKCk+UAt7Ib+sbw7VJ9SRG7hO8zVI5bIWkqz8mpvKjkQLlqS8+pHA04sjviWuEJcUsAtotsQ
 cEfz8ScbTqkDspZAaJE0SkTXQwNO0O+I=
X-Gm-Gg: AeBDiet6ggBImDFUmg4W4cnKC2FmeTNt6W/GvDmIiNFh0YE2Ontq25lbsT9uSADtKv8
 DtfYG0/Z/VqyzjKYfbrOA4uRIQvrWNyuQAdHmNJ0opsHA7vTIxepRV/doV09RGcaiioiVrtJuxD
 3eiuiYAApsyfnj8v1yHgVx1/LGcKSzZyXPJmzngtXIpV05SD8pj5mW9hjpK/dtINoI26r0Fz3st
 I0wBKWp5BLQYh6YXq/HMR4i5TbOc/gQ4AGPfymrZChMG42v9MHV+xtIVqVFhujpVrtk7ID5coIA
 kWBMMx4jc8AwlXQXFHskvh4n2Swb0wJuIRG5P4xA9i/unnDF
X-Received: by 2002:a05:6a20:a107:b0:3a3:17f8:bedd with SMTP id
 adf61e73a8af0-3aa3b42682amr2901722637.17.1777976372798; Tue, 05 May 2026
 03:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260320010757.32158-1-rosenp@gmail.com>
In-Reply-To: <20260320010757.32158-1-rosenp@gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 5 May 2026 12:19:19 +0200
X-Gm-Features: AVHnY4LrSdA-TVd0rOf78tt1qEgtyjaB-8s2ysBkKThqZkZIY7rx-9HrQrJ2k5o
Message-ID: <CAH9NwWfcpyEGGG_=h4xKVw0xcLVn1hPWKrZo-rQ9x9rQio4r8w@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "moderated list:DRM DRIVERS FOR VIVANTE GPU IP"
 <etnaviv@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
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

Hi

Am Fr., 20. M=C3=A4rz 2026 um 02:08 Uhr schrieb Rosen Penev <rosenp@gmail.c=
om>:
>
> A local helper was developed previously for struct_size.
>
> kzalloc_flex can be used now.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 12 ------------
>  drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  3 +--
>  2 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etna=
viv/etnaviv_drv.h
> index 20dad16fd554..55a9e745604d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -93,18 +93,6 @@ void etnaviv_gem_describe_objects(struct etnaviv_drm_p=
rivate *priv,
>  #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
>  #define VERB(fmt, ...) if (0) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
>
> -/*
> - * Return the storage size of a structure with a variable length array.
> - * The array is nelem elements of elem_size, where the base structure
> - * is defined by base.  If the size overflows size_t, return zero.
> - */
> -static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t=
 base)
> -{
> -       if (elem_size && nelem > (SIZE_MAX - base) / elem_size)
> -               return 0;
> -       return base + nelem * elem_size;
> -}
> -
>  /*
>   * Etnaviv timeouts are specified wrt CLOCK_MONOTONIC, not jiffies.
>   * We need to calculate the timeout in terms of number of jiffies
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/d=
rm/etnaviv/etnaviv_gem_submit.c
> index fbf693addd74..1a77a09b3377 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> @@ -32,9 +32,8 @@ static struct etnaviv_gem_submit *submit_create(struct =
drm_device *dev,
>                 struct etnaviv_gpu *gpu, size_t nr_bos, size_t nr_pmrs)
>  {
>         struct etnaviv_gem_submit *submit;
> -       size_t sz =3D size_vstruct(nr_bos, sizeof(submit->bos[0]), sizeof=
(*submit));
>
> -       submit =3D kzalloc(sz, GFP_KERNEL);
> +       submit =3D kzalloc_flex(*submit, bos, nr_bos);
>         if (!submit)
>                 return NULL;
>
> --
> 2.53.0
>

Thanks for the patch - applied to drm-misc-next.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
