Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D7C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E4710E213;
	Sat, 19 Sep 2026 22:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T61nXCP/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2C410E213
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:48:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B4DB6025A;
 Sat, 19 Sep 2026 22:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB31F000FF;
 Sat, 19 Sep 2026 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858098;
 bh=diX1aCzw9gUiuF9Thv7PCxsn7YJCdtieKonad7/fSUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T61nXCP/qMzvq3UGvaoScH96oX+mn22PCYAom1vrdWy98BZQqCklUoTRWsALLJQA5
 gNipCjUMdlcza8LlJMauKpneVFoWgTNB5+ShRIn/3jOUg99/gll08EwECuyPoqxU69
 B8jleaRs6JyWUKRTadRX1d9q1Ut6L9IB9ugb0UIs6emHGJA7yubGmBPr4Zi8VJXRdX
 TkdN7GpfFDWEbR0ZTCCgzKy4NNUHG+mAQuPSfeGxy9bA82daoSt1aQvY8y+AYwqkU+
 5tCu5ZFJB6eGcwm7YdqBQEeITp2lD6ADyKMXZGestZwAVJCJJ79CGrdZpzMkg5qGI4
 Vk0SYBkeqO2aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/VGA: fix inverted vga_tryget() return check and
 clear removed pci_dev
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260919222629.3798073-1-benquike@gmail.com>
References: <20260919222629.3798073-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:48:17 +0000
Message-Id: <20260919224817.C6AB31F000FF@smtp.kernel.org>
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
- [Medium] commit message references incorrect functions for vga_tryget() f=
ix
--

commit 341d48fbd447d6890560b76963b8d28bd58bbe29
Author: Hui Peng <benquike@gmail.com>

PCI/VGA: fix inverted vga_tryget() return check and clear removed pci_dev

This commit fixes an inverted return check for vga_tryget() and clears open
references pointing to a removed pci_dev in vga_arbiter_del_pci_device()
to prevent dereferencing a freed pci_dev.

>     1. In vga_arb_device_init() / vga_arbiter_From_pci_dev(), vga_tryget()
>        returns 0 on success and a negative errno on failure, so checking =
if
>        (!vga_tryget(...)) is inverted and skips unlocking on success.

[Severity: Medium]
The commit message references incorrect functions for the vga_tryget() fix.

Reading the commit message suggests looking at vga_arb_device_init() or
vga_arbiter_From_pci_dev() for the vga_tryget() fix. However,
vga_arb_device_init() does not call vga_tryget(), and
vga_arbiter_From_pci_dev() does not exist in the codebase.

The actual code modified to fix the inverted return check is in
vga_arb_write().

Could the commit message be updated to accurately reflect the function
where the fix is applied?

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee78599..4f13e542505ad 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
[ ... ]
> @@ -1266,12 +1282,12 @@ static ssize_t vga_arb_write(struct file *file, c=
onst char __user *buf,
>  		 */
> =20
>  		pdev =3D priv->target;
> -		if (priv->target =3D=3D NULL) {
> +		if (priv->target =3D=3D NULL || priv->target =3D=3D PCI_INVALID_CARD) {
>  			ret_val =3D -ENODEV;
>  			goto done;
>  		}
> =20
> -		if (vga_tryget(pdev, io_state)) {
> +		if (vga_tryget(pdev, io_state) =3D=3D 0) {
>  			/* Update the client's locks lists... */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919222629.3798=
073-1-benquike@gmail.com?part=3D1
