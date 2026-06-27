Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B37C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A58910F77E;
	Sat, 27 Jun 2026 03:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NCdA9Tw0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C753610F77E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:52:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E3F1600AA;
 Sat, 27 Jun 2026 03:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4971F000E9;
 Sat, 27 Jun 2026 03:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532337;
 bh=Sp6aBOK5hIIhX3sF7dvqhNvYTB3j7DSJ4vsGV4MUp/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NCdA9Tw00Y0tDfDQ3TwHg8l1+B2dLP12FAWEleqtC6XocgP8q+jD7N7UKF9lO5juO
 0R/EAviYRNd5ViE6TiO+GvwHbcGteMkdB36H1F+4dOWn48Ni+NT5uieh2KtfKstHaK
 pn5oHC9tKFHiibq92L+JQ3pavLsYTY1nOA2MTA/luMrvSmfTUIEnuv+Y9yP5Lu83vX
 rPfDk8YDUggD6trBHY3T2vC5YfoREFS1acw8g81+1BfLoUyIkNY4SNeDrKtXq5woEX
 iji8FsH4CwlJwL6bWDErANgtpch8/eGaq4H+pCk2WaV+BAwBHJgNo5qjdnS6lhBpGy
 mGkj97Sz1ZOnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drivers/video: __screen_info_pci_dev: leaked
 pci_dev references in pci_get_base_class loop
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627034428.59479-1-vulab@iscas.ac.cn>
References: <20260627034428.59479-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:52:17 +0000
Message-Id: <20260627035217.AA4971F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a kernel-hanging infinite loop and is bas=
ed on a fundamentally incorrect assumption about standard PCI iterators lea=
king memory.

Pre-existing issues:
- [High] A pre-existing memory leak of the `pdev` reference occurs when `vg=
a_is_firmware_default` checks for the firmware default device.
--

commit 5ad7d85025adc767e102b08f0b9fd9b693e4565f
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drivers/video: __screen_info_pci_dev: leaked pci_dev references in pci=
_get_base_class loop

This commit adds pci_dev_put(pdev) for non-matching devices before continui=
ng
the loop in __screen_info_pci_dev(). It aims to fix a perceived pci_dev
reference leak when iterating with pci_get_base_class().

> diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_=
pci.c
> index 8f34d8a74f098..c821101e93045 100644
> --- a/drivers/video/screen_info_pci.c
> +++ b/drivers/video/screen_info_pci.c
> @@ -123,6 +123,10 @@ static struct pci_dev *__screen_info_pci_dev(struct =
resource *res)
> =20
>  	while (!r && (pdev =3D pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)=
)) {
>  		r =3D pci_find_resource(pdev, res);
> +		if (!r) {
> +			pci_dev_put(pdev);
> +			pdev =3D NULL;
> +		}

[Severity: Critical]
Does this introduce an infinite loop?=20

By setting pdev =3D NULL, the iterator state for pci_get_base_class() is
destroyed. The next iteration will restart the search from NULL, retrieving
the identical non-matching device endlessly and leading to a kernel hang on
systems where the first PCI display device found does not contain the
targeted screen_info resource.

Is the original assumption of a memory leak correct?

Standard PCI iterators like pci_get_base_class() unconditionally drop the
reference to the previously visited device via pci_dev_put() on the 'from'
parameter.

>  	}
> =20
>  	return pdev;

[Severity: High]
This is a pre-existing issue, but does vga_is_firmware_default() leak a
pci_dev reference?

drivers/pci/vgaarb.c:vga_is_firmware_default() {
    ...
    return pdev =3D=3D screen_info_pci_dev(&sysfb_primary_display.screen);
}

The screen_info_pci_dev() function returns a pci_dev with an incremented
reference count, but the caller simply compares the returned pointer and
discards it without calling pci_dev_put() to release it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627034428.5947=
9-1-vulab@iscas.ac.cn?part=3D1
