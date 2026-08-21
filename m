Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880EC5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBF910E265;
	Fri, 21 Aug 2026 07:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HAS5WXyc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37B510E265
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:35:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD98042B02;
 Fri, 21 Aug 2026 07:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7017C1F000E9;
 Fri, 21 Aug 2026 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787297703;
 bh=OA/O71S72zOYPaVlWj0yBSyuq6+/qg9b7MezZmL8Leg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HAS5WXyc//rXx9PkbosBMAxXDzaj0566bkBH8/kQcO+D+T3YN1IEGaDkxK2Dafxg5
 k36dTgkx+mI2rllvxL3wk/BgSm0VxJnjGzG10O/fnzErDngC/JqDnTspt3oRSDsK1I
 jvXiyQNOM4F+iLaSdg+5RjxFd9HXFkbFY6FCZn22oHi2Dyjcn5uC28uZjHlO1DCuQl
 1fr1ua3yv53uUynatGPEVigYNJCk+KrqbhcdMnkW3LrofXloXKRXv335o8gWelhr6e
 vXxkQebNqEY9aXFnZrU0bcgBJEPvHlcEggtus+4+zOaInEYbgu6muX6MimunvJIj0v
 g+gHqOExalpYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel: habanalabs: pm: use DEFINE_SIMPLE_DEV_OPS for
 pm struct
To: "Li Jun" <lijun01@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821031959.288264-1-lijun01@kylinos.cn>
References: <20260821031959.288264-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 07:35:03 +0000
Message-Id: <20260821073503.7017C1F000E9@smtp.kernel.org>
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
- [High] Using `DEFINE_SIMPLE_DEV_PM_OPS` incorrectly maps the `.freeze` ca=
llback to the suspend function, causing the PCI device to be forced into D3=
hot during hibernation freeze.
--

--- Patch [1]: [PATCH v2] accel: habanalabs: pm: use DEFINE_SIMPLE_DEV_OPS =
for pm struct ---
commit 05b8c895a9d3a2cfea19ba9e2cdc13394fb870ce
Author: Li Jun <lijun01@kylinos.cn>

accel: habanalabs: pm: use DEFINE_SIMPLE_DEV_OPS for pm struct

This commit uses DEFINE_SIMPLE_DEV_PM_OPS to define hl_pm_ops and safely
handle PM callbacks without triggering compiler warnings when PM sleep is
disabled. It also implicitly adds callbacks for freeze, thaw, poweroff,
and restore.

> diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/a=
ccel/habanalabs/common/habanalabs_drv.c
> index 220954d730136..7ec5aa7905f06 100644
> --- a/drivers/accel/habanalabs/common/habanalabs_drv.c
> +++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
> @@ -1630,10 +1630,7 @@ static void hl_pci_reset_done(struct pci_dev *pdev)
>  	hl_device_reset(hdev, flags);
>  }
> =20
> -static const struct dev_pm_ops hl_pm_ops =3D {
> -	.suspend =3D hl_pmops_suspend,
> -	.resume =3D hl_pmops_resume,
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(hl_pm_ops, hl_pmops_suspend, hl_pmops_re=
sume);

[Severity: High]
Does this map the .freeze callback to hl_pmops_suspend, which forces the
device into D3hot?

DEFINE_SIMPLE_DEV_PM_OPS implicitly sets the .freeze callback to
hl_pmops_suspend. When the user initiates hibernation, this callback is
invoked and eventually puts the device into D3hot:

drivers/accel/habanalabs/common/device.c:hl_device_suspend() {
    ...
    pci_set_power_state(hdev->pdev, PCI_D3hot);
    ...
}

Will putting the PCI device into D3hot during the .freeze phase make its
configuration and memory space inaccessible, breaking the system-wide
hibernation image creation process?

>  static const struct pci_error_handlers hl_pci_err_handler =3D {
>  	.error_detected =3D hl_pci_err_detected,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821031959.2882=
64-1-lijun01@kylinos.cn?part=3D1
