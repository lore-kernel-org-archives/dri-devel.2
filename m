Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA6C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475EC10EBC3;
	Tue, 22 Sep 2026 06:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YfDA3CJP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3BE10EBBC
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:48:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7867C42A57;
 Tue, 22 Sep 2026 06:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2651D1F000FF;
 Tue, 22 Sep 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790059694;
 bh=DFZ4AH8NrD9uS7BzuKBlUQTFfMHVHBHZfW2TghtrT5c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YfDA3CJPtfEsyMVSUuK3BObRIN6DiY+rON8aWNCzRgVdJNy/d0Jcnk1dc29QbjE/p
 h3+m70YLeNi9qVBaMa6tDw7rZF2I7dvCO5LeN3OCKLpDN/Yq6aj/WuA/1UGp/1DZu6
 9glAiiVfETwyU8Nj8KfgqGK3yJXBlxhYrYiYItSD8z+6mzGOM6b6kN4GFs1HFsL4rJ
 TxDNJYUk/EEFkoV7yBWvoxS4Cxf4T3bGu+Y+7uLcN5qpvcnctlDqlec5BOV/RqksNd
 QIyUIh5LvtoVajqPwplwd9L8lmJqHYyQKBem93ybw+o4XKLO5qvP0aJvXng6oq4P89
 /lzPqYIwkGmuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the
 decode callback
To: "Dave Airlie" <airlied@gmail.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260922064111.2468741-1-airlied@gmail.com>
References: <20260922064111.2468741-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:48:13 +0000
Message-Id: <20260922064814.2651D1F000FF@smtp.kernel.org>
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
- [Low] drm/loongson: missed vga_client_register API conversion breaks build
--

commit 53a905b209a5cf4aa1aeb17a42069c191d47a151
Author: Dave Airlie <airlied@redhat.com>

pci/vgaarb: pass a data pointer to be used in the decode callback

This commit updates the vga_client_register() API to accept a void *data
pointer, which is then passed to the decode callback. It also updates
various DRM drivers and VFIO to pass and use this new private data pointer.

[ ... ]

> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 97129a1bbb7df..71a364669eaf8 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -33,7 +33,8 @@ struct pci_dev *vga_default_device(void);
>  void vga_set_default_device(struct pci_dev *pdev);
>  int vga_remove_vgacon(struct pci_dev *pdev);
>  int vga_client_register(struct pci_dev *pdev,
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
> +		unsigned int (*set_decode)(void *data, bool state),
> +		void *data);

[Severity: Low]
Does this API change break the build for the loongson DRM driver?

It looks like the conversion of vga_client_register() missed lsdc_pci_probe=
()
in drivers/gpu/drm/loongson/lsdc_drv.c:

drivers/gpu/drm/loongson/lsdc_drv.c:lsdc_pci_probe() {
    ...
	vga_client_register(pdev, lsdc_vga_set_decode);
    ...
}

The callback lsdc_vga_set_decode() also still expects a struct pci_dev *
rather than void *data.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064111.2468=
741-1-airlied@gmail.com?part=3D1
