Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1A606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmeJiWt6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6289310F278;
	Wed, 11 Nov 2026 16:15:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7DF10F278
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:14:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69EF743AA8;
 Wed, 11 Nov 2026 16:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1FE1F00A05;
 Wed, 11 Nov 2026 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794413694;
 bh=7a7tqsclPEZCFfU8WhBmK8dS+InQs7dM9sEBEXkkFgs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lmeJiWt698GaeYGgb9EHRzOmv2/Ws0JFUHEqNcJ41JZn6yIfb99JXO+xWZTUMYbfL
 ZIyQ4tYcXWHEiskEMhyPE9B+fzYmfp+A0Emd0XZY6RciGaK21ryv9cKaRWp3ptcaNH
 7ALgcKBiLsJJY20rCThVCzlTFJadj5T1pOYPfkCyno6Z2/IMxTNQKcLoKEJNuzy5zl
 cJLW8bGOdh/pUUXGt0aLk0xyCNUQoFfFm3y6UpmKOSyLrYsmynrfAPIp1C6BJVQboE
 s/YqKuphwJCJhY1G4szvAyH7FzAzdlyYeZJOd26bT5+CYJ8Y3FK34IwMdUyrsu4Yva
 faGshq5jB6iew==
Message-ID: <sashiko-outbox-209267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] video: fbdev: Request IO ports
To: "Daniel Matyas" <matyasdaniel006@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111150219.239706-1-matyasdaniel006@gmail.com>
References: <20261111150219.239706-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:14:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] fbdev: n411: devm_request_region() in n411_init() breaks
  hecubafb probing
- [Medium] fbdev: n411: leak of n411_device and I/O regions in
  n411_init() on error
--

commit 233a6d07f214976aca6e2d815559082f7aaf9dc7
Author: Daniel Matyas <matyasdaniel006@gmail.com>

video: fbdev: Request IO ports

This commit requests the I/O port regions used by the arcfb and n411
framebuffer drivers via devm_request_region().

> diff --git a/drivers/video/fbdev/n411.c b/drivers/video/fbdev/n411.c
> index a3677313396e2..ed0281939d37d 100644
> --- a/drivers/video/fbdev/n411.c
> +++ b/drivers/video/fbdev/n411.c
> @@ -165,6 +165,11 @@ static int __init n411_init(void)
>  	if (!n411_device)
>  		return -ENOMEM;
> =20
> +	if (!devm_request_region(&n411_device->dev, dio_addr, 1, "n411") ||
> +		!devm_request_region(&n411_device->dev, cio_addr, 1, "n411") ||
> +		!devm_request_region(&n411_device->dev, c2io_addr, 1, "n411"))

[Severity: High]
Does calling devm_request_region() on &n411_device->dev before
platform_device_add() prevent the hecubafb driver from binding to
n411_device?

Each devm_request_region() call adds an entry to
n411_device->dev.devres_head.  When platform_device_add(n411_device) later
attempts to bind the driver, really_probe() rejects any device that already
has devres entries:

drivers/base/dd.c:really_probe() {
	...
	if (!list_empty(&dev->devres_head)) {
		dev_crit(dev, "Resources present before probing\n");
		ret =3D -EBUSY;
		goto done;
	}
	...
}

As a result, probing always fails with -EBUSY and the display device remains
unbound.

> +		return -EBUSY;

[Severity: Medium]
Does returning -EBUSY directly here leak n411_device and any I/O port
regions already claimed by the preceding devm_request_region() calls?
Jumping to put_plat_device instead would call platform_device_put() and
release the allocated device and its managed resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111150219.2397=
06-1-matyasdaniel006@gmail.com?part=3D1
