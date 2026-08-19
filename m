Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A910C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E97610E1B7;
	Wed, 19 Aug 2026 12:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YdJw+V7d";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2EF10E1B7
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:51:37 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-754ac74c495so388040137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143896; cv=none;
 d=google.com; s=arc-20260327;
 b=etyWzG4RkXkJrEtDDqnQ1V0MfPcRZ5ASEP7eVfqtlkcKX1fXAwrVpZMcMzbg+hiwpY
 +Ow18TO508POyBG67d1GcVufv1+9GPieZWo58NzblStjypq2tLIBCmgbUcYAW2zhIPU2
 no1lPX7K+tNbIUIqLdfIa+AoShYw9OKspZ++pVtALeLEejo+Qpb0K2gva0M0eLHQO2o5
 Hp/jMcctlPg5u2dkVvhHgeXHlFSd6xBZ26/MStz8+btuemg6CPE7w6+eNXmUNwWJuTbS
 dZTkq4fmtw6wDbKVt+pObkXq07pUHfc4+nNW+zSmSUJBW16XoHky18hsHD9mca1JG/L/
 QofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b89xWKguxhb5kJiAHzj3EgRzZ5QR0sQtBsj6gohCrzw=;
 fh=+EGRWsQfq54zJhBrYcAVMlWtfvWI23ia/weP7Fu09BU=;
 b=cGxAm9fSZbRPngHg+3r2I9vjW2rSZB4cTiwrL9TBh2DsOWc67ma5RdGZb6sRohX93J
 PDiaNsHVPCLTESGfDyttfNDiMTLFUWjk9Acs8CwiUlM2uTVc5JIIztf6++SSoaX7zxPK
 f37eVtNieZnLU8pdhc3rjAoDdoWX8Usz0uX1Wjl7w1TZaKOjWnh6pGRR7X7dHvMU0wG4
 mDN1M+0z53CgNvYb4I/VK3sAH22w22mdTqO450HXNDYcuRDBjmAWqoJcXhK36ab5ieiy
 iT7YUqssDhIHXnJ+wDRQc+18MOMi5VP6nCEHi9Ds7OatG2dN2rPx9J3yRGd+mazQ9LjU
 MGSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787143896; x=1787748696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b89xWKguxhb5kJiAHzj3EgRzZ5QR0sQtBsj6gohCrzw=;
 b=YdJw+V7dSrVNPHJnz1H0Tws3rHOYCqu0Y8D/1FuYxfmG80FHvIjtxC9CY8S1Gf7e0C
 zsfnPTNNXLRdHnkI4SJAPRMxTWm9sYOb3hDjSHCSegmlaXuPSkUx699tUUb9gZ+8EtAA
 1kSqrcZB59AmfMBxNu7SWW0f5BJ1D6MEnm5dTj1L2Tw0+L2IqF7YOvP8fF59/nr8luvp
 9wECJC94ZhHnKDYaPEqWmlvdCRzeAv2szfjidKPqbCjTvhjeQBtURgl8h+qFtacnZkM5
 88szb5VwCjAqsXVlL6FkC8dz/7Qbt3dwgvpjW9AC4uusNt+kzGZ2mw8MPdk8jcKTEb1g
 3K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787143896; x=1787748696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b89xWKguxhb5kJiAHzj3EgRzZ5QR0sQtBsj6gohCrzw=;
 b=mYNyDEHyf3g61g+UGIzfEutjhMvQeX9WhagLOYjQOWcad1Xo5pwjzR7q4lwHKr0Uth
 h5F25aWaFU3LOFebgPwZxBk0qyvEV5OMrmGdixPHVGL7DfvLHU6ev5mWTmaU9sS2iywI
 +PWwrvlvBQNbal+hIhLBLotndDhuEtDUgm5fIaAqFiYwLD1dVnNJCzYyAlhOc2IY8BzW
 WQs8OLSp9qT2HzkP3FQsI7JKjI6f+RbVYmd4a9d2D0qD6N2OELSu3o7O8K0MQOK5d27f
 81mxejeQj2gUZnMDZE2pZG52UzIKrKIydaMlZVoYHTuifuCVM9OYiJB63dA59GFBLUG1
 QdZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rod3Gbz926ajU9qSimKijiT/Oe2/mZObgrYsz6PcpGbB4JmWgSiRbla9EQXalrcvLFY9f45i3QH4Mo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3zOhFEOzHI86EGv28GAvESqDwLEczeHVWA3iYkFzG3xe9Bbwf
 r6bfSiF+EFJdMlzbq5LXyX/CRELFCBp8DgHdAK4J1CzSmfLG4tAh1MTJr9qHlYw1X3mJp9fnd84
 kIUiWup/d7cYJd6n0zzRX+IhiHcjvNaU=
X-Gm-Gg: AR+sD12hOaFbaIke7cjGbz2B09OjEJWYQOZ5zaK9CheUv4ibz6tUlb1BOk83E3Qyty2
 J0IrJXhMoo48suh6o+I5PFhIzSOSKc/EC7cGKCKZwAsm9JEx1VHt+dM5r8My93Oi0Vl3kzwYKbx
 CfaSmJQcUgBHxUsjwGtYfqEHOHRbADrfs8Zk9jvOsaXG63ENDuKdWkuKZ2nFpQ4hk4GhA0I+KFJ
 2x08aQ7iYa29peMO8HDkqD5P820u993n67se+Dtjd/JDDfBVAWv72KJtFapBhYE3p4jusxuaBQx
 djBry/kTjr4Fyz/ARyq7g8L7jT2kOz+6R1FBg0VUeB2L7gCCbikaBh3XgZM7Twq9ufzS+9XHidQ
 =
X-Received: by 2002:a05:6102:e0c:b0:778:5369:763d with SMTP id
 ada2fe7eead31-778536977cfmr777017137.1.1787143896490; Wed, 19 Aug 2026
 05:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260705110221.153481-1-mdshahid03@gmail.com>
In-Reply-To: <20260705110221.153481-1-mdshahid03@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Wed, 19 Aug 2026 21:50:57 +0900
X-Gm-Features: AcwNN1WZpgbj7Xmht22CXRTxKba8QfE40w5PRb6wQWHMVVHwKvxFfX4oKRnrA9U
Message-ID: <CAAQKjZMKWDqbq+onK9JHejecie0Nh33WQ+rUBa=_0pc50FZU1w@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: vidi: use memdup_user() instead of kmalloc()
 and copy_from_user()
To: mdshahid03@gmail.com
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
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

Sorry for being late.

2026=EB=85=84 7=EC=9B=94 5=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 8:02, <m=
dshahid03@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> Use memdup_user() to replace the open-coded kmalloc() and
> copy_from_user() sequence.
>
> This simplifies the code while preserving the existing behavior.
>
> This issue was reported by memdup_user.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/e=
xynos/exynos_drm_vidi.c
> index 67bbf9b8bc0e..183671de711e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -273,14 +273,9 @@ int vidi_connection_ioctl(struct drm_device *drm_dev=
, void *data,
>
>                 size =3D (hdr.extensions + 1) * EDID_LENGTH;
>
> -               edid_buf =3D kmalloc(size, GFP_KERNEL);
> -               if (!edid_buf)
> -                       return -ENOMEM;
> -
> -               if (copy_from_user(edid_buf, edid_userptr, size)) {
> -                       kfree(edid_buf);
> -                       return -EFAULT;
> -               }
> +               edid_buf =3D memdup_user(edid_userptr, size);
> +               if (IS_ERR(edid_buf))
> +                       return PTR_ERR(edid_buf);

exynos_drm_vidi.c does not include <linux/string.h>, where
memdup_user() is declared. It only builds today because the header is
pulled in transitively. You would add the include explicitly.

This is a trivial thing so I can handle it.

 Merged. Thanks,
Inki Dae

>
>                 drm_edid =3D drm_edid_alloc(edid_buf, size);
>                 kfree(edid_buf);
> --
> 2.43.0
>
>
