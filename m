Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862C8C98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8019910F786;
	Thu, 24 Sep 2026 20:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRnE85Ug";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891F010F77D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 20:08:44 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a4fbc5586so25036566b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790280523; cv=none;
 d=google.com; s=arc-20260327;
 b=NWKcD2xCcjXHzyDkr54Ez0G/BaMC7eRFOWpzCJgTjmX5rPghCJRwx6VwDqw1/SbUcr
 IkOpmyId9QM6njpAQbm3nL1p8FV5rPpsVLedeB7kArKvZOgiXQnVx8VyE2HyXB73NPQD
 yAIvndxPbk9lLUK3B6+3mwfDko/9gUNFMKaa4gF8fgDfNOFYTzA5+pnLT5p2XBeEQqQK
 dDt6ChoeuevDlTkvHAaIrV40qte/OA8ZQUKdhrGUgV7vR7YY9gZV598JdWgd9D6ZPd0g
 U0Q70XF/r3nb+/LL7+ONpFdX8HrgwcRx4EXTwJ3YrrXDhHknQdj/syMa7q4GLwga22t4
 npeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
 fh=o+Z9/lVCpplU1vnDNCdpgyEU1FRNn3Zdl/CSgqXIhfY=;
 b=DXQu4eXpjhzVNvJFEvy3KBInfAg/iQuUrBGIzZtibY0o63Dud/v2Olh608EGLB+g0W
 Ium4FQXZ0bf44O2eFz/BTSJOKFFNZ5vl/XJAPNGPf7eG7LzaXjzrcm7hZTiD2XRTS/tj
 EMNd0SHiaIokYKdRckLj3lFhvRXNInGzjb4kzKaa1JsPeZtjphvkBmeHrOPrXKKN16kV
 yalN+u2PcKKYJSq750dZ245gaDL3Z3AXr8IlHdqQPGPN0agrE79RZG336W5IVNhvAims
 4sQ7QIJ+Qna5kYYUcDHzq5JjY24xxrUabDqgVitiOpQLOqEGLxZWPDiHeBaPcCdZSgLF
 VFSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790280523; x=1790885323; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
 b=QRnE85Ug/vparI2Z2X93ESE78A19qTDK101kgSk5P+OBhg6N8GXnQLEiTWOG6omW4I
 KodWqcyBJwSsMYRJ9+63QCgx3yzXduCcaoExGvHB2yuQoX0+tFHz3a+NwkI0VrVBqDib
 bWbvCKrsnvAxR2lAIURIuZusYqG6dvmGtbNAhcROEcCVOoNXKcm39vEbqxxwdWT1Pxyo
 vOGnXr8y13/jvR7GCHUg9FImAt0fB5fiy6ONJ2lZ637zjPnbClw3ZiahLzpoE+oo4K/n
 L68SBW505JFWDYOabhRM0bYjd7DWvOz+KkTkb57Hbju6msNS7BBG1qr0uS4BCzEfIFqp
 EO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790280523; x=1790885323;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
 b=ufCH3VAwOpOVJcmUAaydCeWS40MgUCs5kmJyv+CUNtovGpdMayvEeahgqRCUxEnWvF
 wn8+VPb2edyWaDBNIXcZRXSMTLRBEm9W7XOLE5t0/MR0PAI9wXTNywYIHTkHrMzeudbB
 xnNNaWbM/AXJTO9+LlYXmxanvF3y22R6x3eE6GETStgQ2fPgEM6WiQ6gn4cTeTYg8hnW
 D7Cdj8QiCfO+3S+drJtFjr+Y5OMeYQS0Brfh+obJ89A6NvouTX+gJC6QGqISxjts3Eai
 8tK/36BzqmeoENd5EpeuQlzDgM0iqIZ/2ZF1H/yviM1l8Jvv+A4QAGba4yDFsW5O6nVw
 Kl9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBze5oTr6pk6GxDYuTgqK5Ge+YkRTgZS+j/Bj/n5RK/Eenp4CrSamje7ScD9hiYzE40HdxaFLGcMde4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1RZO1ho8gmoaMqlMeOCdiOSAob/sekmwBFwzKp5hS5HX0o6x7
 IvMGrYuYPoyqG8H+Ebus3GBFjF3oLaOF4Nen9kCmUtpE09ybwQG/QgGYqWz0SikBtxiCwQBkZ8K
 aynqeSw8Qb0QGxOp+eDdnqJ9O+Km+hL0=
X-Gm-Gg: AYBFou3zUfvjB9jrxDwxQuf+VVtxKhK9zwli85ja0a94KwkIP0e0PwIucCh6w35kGSp
 hnaKW0B2DCNnReGfqwsHXJDo3aWVA5DoZi2vaiJ8wqRZfWgieW1Ew9JcbR6QGsNoSoszbdFrpO8
 OeEtKHsFlj1+Rgo+Vwgnp9dLwa93gMKn5VhCTFA6ioVu/x1ScaeAQf1uKGa2I7kRftyHmHoohTB
 aHx0XKRn8rYOWY8ttBy45qQMGsl+AINkidRjkINF+JctnTObxo45bBkZBnX4aK+qkZtQeQMXn79
 1flu9ZwIHjgcH0ELMN1M7rHY47tdOiag7R1c37jMjB7aqm51KjmZmHihXlR0w8lEelWFlAQgLXm
 1sLZN6GS0PZYAoFCa5xB/+9BuT6D5TESYhaM6jFBfeRmK4fsvgQ==
X-Received: by 2002:a17:906:8d8d:b0:c29:c213:1ec9 with SMTP id
 a640c23a62f3a-c2ac20ab8ecmr322667666b.9.1790280522730; Thu, 24 Sep 2026
 13:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260919191524.268810-1-meatuni001@gmail.com>
 <3aaa9d04-6bf4-46a4-80d7-9828405b7468@linaro.org>
In-Reply-To: <3aaa9d04-6bf4-46a4-80d7-9828405b7468@linaro.org>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Fri, 25 Sep 2026 01:08:31 +0500
X-Gm-Features: AclHuK-fj4Cn0W_vYW46Cg7xkxnoo5u25tZsTVZNPJ2G3OF9fblSULPtGigaufI
Message-ID: <CADqcGBkdFjoKF5Oa=zVshe92ay87CFUu8KzZHARB8WV6ajVXbw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 sam@ravnborg.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Neil,

Thanks, I've switched this to devm_mipi_dsi_attach() in v2.[1]

[1] https://lore.kernel.org/all/20260924195512.336690-1-meatuni001@gmail.com/

Regards,
Muhammad
