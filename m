Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D7C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7179810E6B6;
	Tue, 14 Jul 2026 12:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bKY24GR3";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02DD10E6B6
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:14:23 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so27211515e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784031262; x=1784636062;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5JJ4kTtQhf+mxJB8QH4xv+X07dhaoQyWUqwyzTRdFrg=;
 b=bKY24GR3mgfw6D3h/NF8VvT4UZAF/5WRuUSKUrSjeCXbbj0d48Ktm/BE6I1pDIynmz
 Uo7GmTB851CXLQCTurpVuUMLz9Mn9R/kQQDvkLIwTy40pmln1xsi0LVYuu5REzubllmr
 bck/Qmy4L2usnrDirOGLJO/uKtlhT972/WTBFDWgSAgJrPqz23Dsk5eanfpJNsacrYF3
 5dc8i1KG0GeRV0CKqLea+XNluujYevCuQhPYQY0z1bOPC+Uy2/dGe8d5Wx1i0XR9gHJm
 UiKIKb18vaBDFm4CyuZpsG/1VrNJ4b3rSSlH88fYXOW3bf2SKnqrIhRpFLjuDVUFoibx
 g0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031262; x=1784636062;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5JJ4kTtQhf+mxJB8QH4xv+X07dhaoQyWUqwyzTRdFrg=;
 b=QrXtqfLj5u3n79JGpQvCI6YD4wffSaXGUMnaxx1nyAjrh74GP1/VgIBHp8DYT6UH7y
 Do7WLrYYRy2wshJui5Kpb1yJ1kDeLw9PiZND5bHCHNg0OrMj30MMaS8sXq/FVkEQB7JA
 JAXbOzDezwa0P6jMlI0cRy4iwERBl3f49bia4xp55pqI2XyTPDmKap2cS1YSQslaS/WU
 OcD7atrdomWDrQozpQcxZsyoCZHZshLAj3BRaMfuDUzuS7Aq9mLfrf6YXBJgT2o1UaNZ
 CW3w1O6Z7Z6fkccOvYSAQ9SMVgjHtrLCyYU5SnnieQqCy8aDZeLibVOuDrvBx12Wz5zj
 5jdw==
X-Gm-Message-State: AOJu0YwuXjdqg+6GfaBofA7Zrzskkvtqal02F5PgE5mVlRBel3qyEnKH
 3yZGEXsVdUiyKS8ERM1qYIuZvJhbkP/U0qvuIm7r2MutzV68wZMFceeKIhXgMiNhGuI=
X-Gm-Gg: AfdE7clzWQJXstMF6/2fZZYktQTcVYgvIFCIu5Ud8Om6SVMc1CUjt/zC2GsRwFbKcXZ
 FXRPt3nE7mBt1C1IG4Ziq18cmPlBXIuSxwt4v6yNhWh77yK6muwpwvs8xw07fc5BeilPpMrwIoO
 a/l+sMkLM+W0YDm/YjPXxS/fgAlZittkVKkrg1mUCLOXAG/fWNiOUwONEIMZ9AzPtnPnCB6hx+q
 1NW5SdrgD2tdkW4dQQFORu7nmrb0a2iQnLGvgJnzCbDabSID4tUskCUUqB7aN6bGJeh5FLkSgB+
 boVpNr/jyrPF6jL6Nq5HEvnXTwYWnjHA0PITcvmMx1zN359oKcUo+wAs1GUT23FQyX9B+5RWkjY
 F5gZzyv7zoxx8h3KOfRtlQQK+Gyi/svVKx734QKrnUAN1P1OfTH61oWusk4JpLofY+s+n/0Itnv
 o/SW72kbourWMZujGFQh802k9wr3/oFZlIBY++D6g1kvWGCBuEOm44P3hbgPrVLoATfkBoC5oqp
 Lc1
X-Received: by 2002:a05:600c:310f:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-493f87d6196mr131633285e9.5.1784031261675; 
 Tue, 14 Jul 2026 05:14:21 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:b44a:8042:1173:aa03])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49508727f7dsm72931045e9.4.2026.07.14.05.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:14:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:14:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Leander Kieweg <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org
Subject: Re: [RFC PATCH 2/3] drm/glanda: Add initial DRM driver for GlandaGPU
Message-ID: <alYnPYdzBRUHBCIR@monoceros>
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-3-kieweg.leander@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vomlj32cvkk2bmdr"
Content-Disposition: inline
In-Reply-To: <20260714101146.200416-3-kieweg.leander@gmail.com>
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


--vomlj32cvkk2bmdr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC PATCH 2/3] drm/glanda: Add initial DRM driver for GlandaGPU
MIME-Version: 1.0

Hello,

On Tue, Jul 14, 2026 at 12:11:44PM +0200, Leander Kieweg wrote:
> +#include <linux/mod_devicetable.h>	/* Device Tree parsing */

Don't include this header, I plan to get rid of it soon. of_device_id is
provided by <linux/of.h>, so you can just drop this #include.

> +/* Device Tree match table. */
> +static const struct of_device_id glanda_of_match[] = {
> +	{.compatible = "glanda,gpu-1.0", },

Make this:

	{ .compatible = "glanda,gpu-1.0" },

please. (That is, a space after the opening { and no comma before the closing }).

Thanks
Uwe

--vomlj32cvkk2bmdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWKBkACgkQj4D7WH0S
/k5+ZAf+PCrH1KEIEe5DEhx79yvrlJF2wcvN6MSddreJROzzmTkLNFRMKEE+/Obf
MGsYDEskqaj8nzNTf8/v31DKVdOC1nYy3wZEJjBib4TJz70Tyy16xPMaJn9Aj9dx
bthrR7oNOkQQL51gGcNVTVJblZX71D5G8w7JUvtXeD9fjP9yyiZA7W0WlXLyt4fw
A7CkhG/rtjKRA8YR5/FYE5u7U7WZ6jG9iJkk2z2TE3KD8g0Q4tCHcRYwHB+P/xuI
YlzkCQ2FuSfOqiDJgYmz6ytFZEWoVhr3OOo3SPlT6DBw2l9g8AWrTVAaDt/7rNO1
TwijzResdCME0fHMgYOLkpRabjtKHQ==
=0Gj4
-----END PGP SIGNATURE-----

--vomlj32cvkk2bmdr--
