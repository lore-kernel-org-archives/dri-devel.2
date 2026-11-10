Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B660A263C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIko30H9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A1B10E92A;
	Tue, 10 Nov 2026 09:58:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9448110EF2A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:58:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D69E4708D;
 Tue, 10 Nov 2026 09:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFF01F008AB;
 Tue, 10 Nov 2026 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794304717;
 bh=LjLsTdbykZWYOu2Xqqak4ExujA0ehtqs8pmgzlzZOnw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hIko30H9sGqtkr1koKEYyU13EfXnIW4ETy/QPkoOEri+qhUvkqXP6tPjCaaKQjRQD
 vNON+qHaRuip2bi8ND9IEZFahDUAWQFkd0v3Id+h3ZlAdgoqIobKWO8yR7onvPksvQ
 sH3usHBcfqt7+ezyCaizlqwPvDFcK324D2NA7A+8+iMmO6Hp23RezAfm6Nd/hiH4Zx
 Qud6A9Lc/RMOCGdFP6ig+OFqZZroHKGL8CJU6P1LesEGBSwW1OSm96xwC9Kl6ABIlc
 0K8Mn1B8lJpf34wbTpDaYj7V0DstdQdIaiGAZB3Z0qVV8G98SZQhk8xibmX76x/cr2
 YBDyewSJohgJw==
Message-ID: <sashiko-outbox-206820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] LoongArch: video: Implement primary framebuffer
 device detection
To: wuqianhai@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name,
 tzimmermann@suse.de, deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261110092418.2647821-1-wuqianhai@loongson.cn>
References: <20261110090203.2631481-1-wuqianhai@loongson.cn>
 <20261110092418.2647821-1-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:58:36 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] LoongArch: video: missing linux/export.h include in
  video-common.c
--

commit 3e46d96932a555bf0346972f71660950e04f755d
Author: wuqianhai <wuqianhai@loongson.cn>

LoongArch: video: Implement primary framebuffer device detection

This commit implements video_is_primary_device() for LoongArch by checking
whether a PCI display device matches vga_default_device().

> diff --git a/arch/loongarch/video/video-common.c b/arch/loongarch/video/v=
ideo-common.c
> new file mode 100644
> index 0000000000000..6fea46661cb64
> --- /dev/null
> +++ b/arch/loongarch/video/video-common.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/vgaarb.h>
> +
> +#include <asm/video.h>
> +
> +bool video_is_primary_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	if (!pci_is_display(pdev))
> +		return false;
> +
> +	return pdev =3D=3D vga_default_device();
> +}
> +EXPORT_SYMBOL(video_is_primary_device);
> +
> +MODULE_DESCRIPTION("LoongArch video helpers");
> +MODULE_LICENSE("GPL");

[Severity: Low]
Should this file include <linux/export.h> instead of <linux/module.h>?

Using EXPORT_SYMBOL() without a direct #include <linux/export.h> triggers
a scripts/misc-check warning when building with W=3D2:

  arch/loongarch/video/video-common.c: warning: EXPORT_SYMBOL() is used, bu=
t #include <linux/export.h> is missing

Since CONFIG_VIDEO is a bool Kconfig symbol, video-common.o is only ever
built-in and does not need <linux/module.h>, MODULE_DESCRIPTION(), or
MODULE_LICENSE().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090203.2631=
481-1-wuqianhai@loongson.cn?part=3D4
