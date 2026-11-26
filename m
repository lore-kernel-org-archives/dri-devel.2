Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D71606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEoWqBjz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA6310F528;
	Thu, 26 Nov 2026 13:41:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502FC10F528
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:40:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7152E62546;
 Thu, 26 Nov 2026 13:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3E21F000CA;
 Thu, 26 Nov 2026 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700453;
 bh=AH2ilCr3J3a/zRMZGWprYbbA+QudQ99cHn7A3yoKUVo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eEoWqBjz5cdJ16hrgizAOL3fV63L3gb41KC35N1AVnJbXvIjqD9xZ76tulpDOlH9t
 yNhV1y4VHG5oZJRefEiBirW75bkRtLF3yQ/V3Cz17QJ1OHh99ee7hXyTBfWt9QkXLF
 Iz8u00tQEFot6c6dn78fTDDaGQ+7yYT5vuu6DNhPwBzjnZ/uZDU+gWalJL6+7KaHQa
 OpqUnQnMC7OdX8WW7LsWFtkEvTBliJ/EQLD2Wu06jiKO3kT6ZRQqzwi/eQfSuvcim+
 ByIXLB07JfYb7sBU4spXboab1+Jb3dRrctwTzWxNcl9uEXz6ArYZE50Wqx6cNHEIBJ
 kBE93f/2HzlGg==
Message-ID: <sashiko-outbox-235633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: ssd1307fb: release PWM if panel initialization
 fails
To: "Yige Jiang" <yigejiang86@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <rc-b1-20261110-vc-112-b07bbe936b75@gmail.com>
References: <rc-b1-20261110-vc-112-b07bbe936b75@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:40:52 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] fbdev: ssd1307fb: invalid virtual address passed to
  __free_pages() [1]
--

commit 0007b36f0bb513d1789d67a9c3b80f87e05fe107
Author: Yige Jiang <yigejiang86@gmail.com>

fbdev: ssd1307fb: release PWM if panel initialization fails

This commit updates ssd1307fb_probe() to jump to panel_init_error when
ssd1307fb_init() fails so that any requested PWM is disabled and released,
and clears par->pwm on pwm_get() failure.

Link: https://sashiko.dev/#/patchset/20260926-fix-fbdefio-error-handling-v1=
-0-a94810b6e263%40kernel.org

> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index ef4bb920c6ff6..dbe5dc67e0442 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c

[ ... ]

> @@ -823,7 +825,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  panel_init_error:
>  	pwm_disable(par->pwm);
>  	pwm_put(par->pwm);
> -regulator_enable_error:
>  	if (par->vbat_reg)
>  		regulator_disable(par->vbat_reg);
>  reset_oled_error:

[Severity: Critical]
This problem wasn't introduced by this patch, but in this error path (and
in ssd1307fb_remove()), does fb_defio_error corrupt memory by passing a
virtual address to __free_pages() [1]?

vmem is allocated with __get_free_pages(), which returns a virtual address
stored as void *:

drivers/video/fbdev/ssd1307fb.c:ssd1307fb_probe() {
	...
	vmem =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
					get_order(vmem_size));
	...
fb_defio_error:
	__free_pages(vmem, get_order(vmem_size));
}

__free_pages() expects a struct page *, whereas free_pages() takes a
virtual address.  Because vmem and __va(info->fix.smem_start) are void *,
they convert implicitly to struct page *, causing __free_pages() to treat
the framebuffer buffer itself as a struct page descriptor on probe failure
or module unload.

[1] https://sashiko.dev/#/bug/linux-2cc48a80-14a7-42fb-ac37-6c2eebc04a6d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rc-b1-20261110-vc-1=
12-b07bbe936b75@gmail.com?part=3D1
