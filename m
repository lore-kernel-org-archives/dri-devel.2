Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952AAC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E542810EB6A;
	Tue, 18 Aug 2026 13:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EvUo45RQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEEAB10EB66;
 Tue, 18 Aug 2026 13:09:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90AAA42B5B;
 Tue, 18 Aug 2026 13:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA891F00A3A;
 Tue, 18 Aug 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787058555;
 bh=bMAnq4SO5mA0VSJI+iAtYcx551ZV62pGsXo7RbeeqvE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EvUo45RQdxNr2cr9Wc1rWbcD4098WRKRjEwhl3W14/z8HFFp24ZD11aTVUKXqch1A
 TTIY+lHXqds2ssYQqJ7A6DupQuBIXiC+desCvGdqFaKp0IFMPsyYwbFvE9mgErOP6n
 SLIfhnoxrwBc/DU7VQq791Cqbwk4b9hQ8GSK/yTjrbqAXDQUSzKXESA98V/j35P4N1
 KmsH008e5IIFtOZyQa/tPhGA1W3cxM4CbvWxa9UqpbKCdJg+yo87MqvDqbijmXpHKM
 sGmcpCDGDe3WxidALRPdfRBtZm7w75ZiHzOFKpjG1Od4p6NTlHc2OYxtU2QQwfwzgB
 FjzvQzbob+nIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 Frank.Li@kernel.org, intel-xe@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260818125012.468092-2-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:09:14 +0000
Message-Id: <20260818130914.EEA891F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but using the `CONFI=
G_DRM_PANIC_SCREEN_QR_CODE_URL` Kconfig macro directly as part of the forma=
t string in `snprintf` creates a format string vulnerability. If the config=
ured URL contains URL-encoded characters that form valid format specifiers =
(e.g., `?reason=3Dkernel%20panic`, where `%20p` is a format specifier for a=
 padded pointer), `snprintf` will consume unintended arguments. This shifts=
 the argument mapping for the explicit `%s` specifiers, causing them to rea=
d and dereference uninitialized stack memory, leading to a nested kernel oo=
ps during a panic.
--

--- Patch [1]: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically=
 ---
commit 8f4057e44664878e84dd3de301552d418b19254c
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Allocate QR-code buffers statically
   =20
Declare qrbuf1 and qrbuf2 as static arrays so that the module loader
allocates them for us. Avoids the kmalloc later on. Access the arrays
once with memset, so that the physical pages are available on a panic.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c

[ ... ]

> @@ -656,13 +655,17 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>  	char url[256];
>  	size_t kmsg_len, max_kmsg_size;
>  	char *kmsg;
> -	int max_qr_data_size, url_len;
> +	int ret;
> +	size_t max_qr_data_size, url_len;
> =20
> -	url_len =3D snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_=
URL "?a=3D%s&v=3D%s&z=3D",
> -			   utsname()->machine, utsname()->release);
> +	ret =3D snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL =
"?a=3D%s&v=3D%s&z=3D",
> +		       utsname()->machine, utsname()->release);

[Severity: High]
This isn't a bug introduced by this patch, but does constructing the
format string directly from CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL create
a format string vulnerability in drm_panic_get_qr_code_url()?

If a system builder configures the url string with standard url-encoded
characters that happen to match valid format specifiers (such as %20p=20
or %20d), snprintf() will try to consume unintended arguments.

Could this shift the argument mapping for the explicit %s specifiers,
causing them to dereference uninitialized stack memory and trigger a
nested oops that prevents the panic screen from displaying?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D1
