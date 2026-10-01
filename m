Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0749CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1468C10F6BF;
	Thu,  1 Oct 2026 14:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dzb5Ywyd";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E09A10F6BF
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:02:59 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso441666266b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790863377; cv=none;
 d=google.com; s=arc-20260327;
 b=Ec6iPGug0IFjM729/o4ZYp+HkHqhXtX9dU3wTbS32hEueCdJFGThIRyi7PfAhO/YQP
 bcMKzNj4oUowqsTXzg37pLIwNppRYxyhen+q1iUxv4KQ3Qwhe4Gs6VOaNPDSQWue2LSQ
 JdiLciKLhy7a/yO/Cu7ockiqWdVWaKd1o3NDELLqfqqD+/aSAJB0aYmSPwoxpkCDHNuV
 vBjvHefW9NTW4OD7HGA1EK8f/T2aRTTtDzXchFyeZILFQsOGRUuoWzWjuhZZfdSPNkvU
 LMiKXMI1YNJboeLUGtbxqhRQAM/2mSCaX5VXZKKw9mSqgUN5p2vGF6Xbv4lre+s9fvVV
 UqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N8/7CE4ZuKqaD2pkivrDjqtKal/kq71Tiz2qeo/N8RI=;
 fh=GtZkIAydsnAdlU1mGXJPUjNLiNR+8ZehgTjRASVkO2s=;
 b=Th42zvyVtjX7RdATrUAJJuuOFULDH/EPvi506vp08531muDy4ARKM9oYgEHrOYIKMx
 h6qy/xUdancsMQqcS79p+AecNKwjRuAKKMAXqWRH1lOaWnTMDsqOWnkQ2qqOEfxiT4s1
 CVVZcO//qvTr/fSR3jlY761VMczUBDXHJRD8GKVYqkHIlr9cXg7LBobvXja6CNIQjVfH
 3gkO9ei7QnjsEDiLiT+5y4+HvlEE7fsubiwJQqRNOM+q80laIyeP4PD53pogWbzJsC8v
 yDrys4m4Gxl98RIw0hUKDuw7fFqhCoxzuO3p0D+bggpTy+F+uPIVGfapanBGVbhdCSmC
 4z3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790863377; x=1791468177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N8/7CE4ZuKqaD2pkivrDjqtKal/kq71Tiz2qeo/N8RI=;
 b=Dzb5Ywyd+gFChhbydMiVJoFxYgVX6TYOWDW/aGuIb1CsajtxruKc2FXgGpGcjdHKmY
 ilf9VMykumX/FMGGK9m8fkhm+UT2mcQbOrhCjJEw0YYlw42OAyu3IGjzA/PltVFvSkG1
 W0pL8/IFIIYsvqvRiMdWYHmMdxppWxNQDUouxnADqQC58haUnsupDLdK499FFfF+aEos
 9oJZRBQIyoD2WPfPFBfj3CZ+jKFLGY02Z3fdsI2qV6ymRfZfK3cVmCCzVLNj5WEFbz1T
 P/ZlHqjRZg3QcU0cYhaI33W7bg4fhSlfwITpO65f8UvboDYHsvRkhRq0GveBa/aJTcnl
 7gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790863377; x=1791468177;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N8/7CE4ZuKqaD2pkivrDjqtKal/kq71Tiz2qeo/N8RI=;
 b=tqdn278G67Je22rmD/IsK6VcMhuJ7o/gf2FTd1hOXEp+9H3oyPBCKjxZCRy1Wl0/Wa
 YvccIcA1Zzo9KAYA8s/nEjHYyICX7drghw5UApM+d5M5k5ammFggZ9PFS7SeJNa6gqf+
 klNg944yyZFh99rLd9pufBr2YvDN63NwQHFFqOObUOkhV2ckkb5z50iDhhpDs/9/LrKX
 EGNgHiMdKf2UwRxZZvLqMlk09CAKVKBa/r60PasIID8ierJ/0Eg54pb20z2gmFjllpZP
 rLJVu4lPCv+vSfQJyqe+tYnijmtff1QfRj3KluUUe3stKpDE9HyW2WiOkaiLo3y2Q6V9
 GKng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPFU+htZfo+VDxLdANJNjswxL9PydMxHEhC/Iy3cokJYXpv9WwypGQRzuBNISiXDXZHBNXCqD7NO8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ncNRxf1UpyleK3zmQ1NBs3sFH+5TDiEXWFuryxlJ5ySIV7PZRj
 7aXmFMqVtt79o/oW4VE5irX/CIjmU4NqWemFTd7fZC0BMtb9NxBl3NE+oXm6o7VgB0gdiQ4ubNT
 kj5DV9LJczEO58Qpv6lzmpVhQXukqb/s=
X-Gm-Gg: AYBFou1b1dkYIFL7W90cxJQNt/ovq3sN4JxT3+MH/TnL73iv3Gva0hwC7HpsAq6pSsM
 r9yK3GHrYvKE2RflKVgKBLoHsUmnkiJCdgqT03ulW7Yh97r17/zYp1NwjHmHQ32RwZrQOoVgNlI
 vj4zsluIVaKx+KXdMHQYmd6rSXsN6fltQAurSsNJHAW0R4anpeVBTWCHmOqa60jFonYjH/o112N
 ISgY1tfb0BLYxCkZezRxbOgbkWet1wDeHYr1K3yPetyxSl4bkzl7PNekGxrQDirtLYY3SmaVWjO
 lYKI53gSayVpYYHZAbKEQKZko95hGLPOAQST6zv8klsnA55kVGRXPHW8nbcV90tQYUPLDzsN9UG
 nvPqAZw9CWUto/URFiB7d4mafKZdKtqNMnW+Re/rW4ZDwhrWw35ZtQnUdAcsA3ZLUoC5uKhBFrK
 a402c6C2HI5igO+sidBTYIjEz68+X5nV43ON65+ciZ
X-Received: by 2002:a17:907:9625:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c2e33fa28d3mr242508666b.19.1790863377337; Thu, 01 Oct 2026
 07:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Oct 2026 17:02:20 +0300
X-Gm-Features: AclHuK-Ck5Qo38vd623LvGwdR2qBOOVXPJ98wewQWMKyHiuuGCBfZRXpFz9rHO4
Message-ID: <CAHp75Ve1-LhMaLczyOyLYhXaHzhRVOTsG4Wi6c-KPT1VQJ-nKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct drm_simple_display_pipe
 and helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com, 
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 sashiko-reviews@lists.linux.dev
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

On Thu, Oct 1, 2026 at 4:38=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.
>
> The idea behind struct drm_simple_display_pipe was to provide an
> easier way for writing DRM drivers besides regular atomic helpers.
> It turned out to be more complicated. With all drivers being updated
> to use atomic helpers, it's time to remove simple-pipe. Also clean
> up the related TODO items.

...

> +++ b/drivers/staging/fbtft/TODO
> @@ -1,3 +1,3 @@
> -* convert all these over to drm_simple_display_pipe and submit for inclu=
sion
> -  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any =
new
> -  drivers anymore.
> +* convert all these over to DRM and submit thme for inclusion into

them

(spell checking?)

> +  the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any
> +  new drivers anymore.

--=20
With Best Regards,
Andy Shevchenko
