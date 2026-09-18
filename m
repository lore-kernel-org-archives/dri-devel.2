Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27445C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D4910E941;
	Fri, 18 Sep 2026 16:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="OtJPPd0y";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A671910E936
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:02:18 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso5664535e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789747337; x=1790352137;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dFhy4My3gTfz46T+pP1ejh2aEiiK+pEn+gpbRz8FajE=;
 b=OtJPPd0yJgCyqiDHdt40bgCjUKZWPfb/aCtY0FL3eBYdzvVsdmn/xrdDphD/C5c+Dc
 IrpNJttr59akcmK4Lk38EkwgqFKYYVN1lUQyrSRKBY73YZiCOScVm3uAkXq9B06R1lci
 VJpl/zXpnWbyDtplE125+FR/rZZkgpc1eJER/+W8q6GlLHo07Q5E4wf3rVaKm+JdQm1K
 2GksreNn9MDdCWqbMMtKYGEJdXXr4oa6iuHTsX0MNRxx9CDxUazfcMDeTmSU5/E6h69h
 1vPh3AKLGtHT7eo9+tOptplk4/A8QuD/0CSjHSDFtqdXNbvSmaKP78/1zC0I2UZd3QnC
 0dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789747337; x=1790352137;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dFhy4My3gTfz46T+pP1ejh2aEiiK+pEn+gpbRz8FajE=;
 b=im+nOZYo5DyREFgkf18rJ6v4/kfrTN0HfmcdBBg/7uRy3DUlta5u4p2NMsx0PkVI3P
 mU43dMK4QZxZcm+ebtatK9qSFlyjEdWoyZHY4KY9QlsUe8acwQ7F7Kfjhh/eE5XD7CGY
 bew4bGEwsKxG8P9p0HIo4Qp/xNpWz1XRkIz2xLjDjE9M/jdFsCLYsD6MnrZM6kAVbSEo
 c+cfbuW79JaxGeJFx7yUrlkeU3sF9d6SaZTpMzMC2mgZn6DSDG+FAHU2nYWpqfuxqqAf
 tofLno7z7wnRHCb6Zhj3q9zdNYz6WGKsobUkUQEdIUZ2TFJI3ebovMettJR30XQ1QApX
 /+FQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBgwdQjKfykwvOamGVIWHIW+swaAuURFh8JsUJm+gk1xOcNRWZEnmFfIs6352jDRYmIwcn30QtWxM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lGDswuRYdRxjKhHfjUBrC8fCSabQqC4mvN3N0DnZ+B+6KRW+ol
 A1SqhRDXVZYlP8JDGQsMn2UeRihSO2BCwNJrEgxlNdjqcckIYK5dn1fsslRfiyQDs14=
X-Gm-Gg: AYBFou3Idoq+RIUu1fBRT68QW3CwoTNEQQsjEJtoYiPVQlCRoOU1GChO7R7E3vrd12v
 x29QJcir/OjZM+6uM0qdrxErgF5aXhNzWqpwALFXKIDY048xyZJhwIL44L5Z3R24ja9404SI080
 V/Pm6BaSTs9W8I+/LQje4CML4wfuDedGivz1bj8abl/cAQx+xtzPE9w3FhUzSGEQJ6i6mSd2+p6
 lWhk6lwfw6kG+ToOVCYZOe9HffjfqalluAiRl4KOSAM/Xf89y3flnwPInVWSWuYAUzQaleq5KMK
 rTxxSPHsBGFmudhWe+9aO629u4zroVUfF6zP7o2OAD4N25rfpn9n+kY7F3t7y8AlhiSkVZhgAyF
 3CPqyHZgxeDERTSvmLL/d1jSaAzwgeASRO/USFjD9Buqq/EaOcInw77JZvtnpvf7EwyRe11SQA3
 ZhUzVvGzimlR2s/l0zfoZGdlEx3VOKloJw7jQgJmNLh2H0XdHE3As42vv+Gr6kY/XRhRFlnYObk
 P4YGleSvJsyaSphDnJuIDlxwQInQtaPYVDI4OiCZ64jSD0WUQ8uvGrX0UioAw==
X-Received: by 2002:a05:600c:6298:b0:49e:73e7:888c with SMTP id
 5b1f17b1804b1-49fc5687acfmr41014655e9.4.1789747336842; 
 Fri, 18 Sep 2026 09:02:16 -0700 (PDT)
Received: from localhost
 (p200300f65f19a90444c8989fe13f5be4.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:44c8:989f:e13f:5be4])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fc59286b6sm53740535e9.4.2026.09.18.09.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 09:02:15 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:02:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Adam Azuddin <azuddinadam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, 
 tzimmermann@suse.de, jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tiny: Add RAiO RA8875 display controller driver
Message-ID: <aq1f-jvrptlrgNO7@monoceros>
References: <20260916175942.3186804-1-azuddinadam@gmail.com>
 <20260916180410.3188922-1-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wmm5bprmcbrsaq7g"
Content-Disposition: inline
In-Reply-To: <20260916180410.3188922-1-azuddinadam@gmail.com>
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


--wmm5bprmcbrsaq7g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] drm/tiny: Add RAiO RA8875 display controller driver
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 02:04:10AM +0800, Adam Azuddin wrote:
> +#include <linux/mod_devicetable.h>

Please don't include <linux/mod_devicetable.h>. Both of_device_id and
spi_device_id are provided by <linux/spi/spi.h> already without pulling
in definitions for completely unrelated busses as dependency for your
driver.

Best regards
Uwe

--wmm5bprmcbrsaq7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqtYIMACgkQj4D7WH0S
/k6OKwgAo93p+YA+UUSlkto/NDiCvLUIcuiQ2j4Zy1SQo6yvwOwKtQhS0a9xRd70
PJkLsOWZjvAvH9/VGKVv4rF+q4G/xoItjAtduwtvOjP2KYbO18leBThT6nYH+Jty
dFY4f2Ojeh+KZ5S5RP1D1RNKDzDShLkMjyijFAAH1I8AT+ffQ+CWUSUKHuOQzj3V
o0JibztPyaqUaMKdBJlGWrKBjs1H2fb8MzjqJMDyFoebhG1Y5TAToybnB1NaqS/I
8oXtqsbZm4smXEbFtgSOGvjDxsnGIG9hsct26ZSFWIohO63PdRrRq1kmJ0YbyFbs
vRBd3aUl/paAmNz3GgpU69S9MTyy3g==
=yOZu
-----END PGP SIGNATURE-----

--wmm5bprmcbrsaq7g--
