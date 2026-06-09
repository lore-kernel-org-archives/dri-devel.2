Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2988CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB8810E189;
	Tue,  9 Jun 2026 08:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PG41kRvJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2950C10E189
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:20:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2C8243D0A;
 Tue,  9 Jun 2026 08:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5E61F00893;
 Tue,  9 Jun 2026 08:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780993232;
 bh=kT6npkD7Wao9Ar/o3oYlCbuqQduusqcrboD/NOkmQ0w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PG41kRvJNdWUgnjUQmEEpc6crnRclcWkL9pd6qU0HHDxnntqX6d37Q5Pt8GSM9g1f
 t/uHrf0pIptSBj+SaphLnnWm1tRCq12INbO5XK3hFEhQjd6cPym+LIgJoLoFFUjcQE
 lKJGNYk1o9nwBDVnq0X7c+kRDMCOoyGepbySNIiAvBnBWTmGx2pH60D14aEVnAUPI0
 ZaH3sPQ1LWVxKtjzKj20PmEvmnHTdKiMg1zPtZVC2H82JLOW4AoL4Cpo6cQZj5PXAe
 FA3K0fxaJRZGZpfXGUBIs3XKVG+Ixgh8GDvMXU8k+0NvF78KspZiwcZR7qDT0KzWZR
 gCiD+4NcqrHhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] gpu: host1x: Avoid double device_add when clients
 already present
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-2-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-2-7c1131c0b3ad@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:20:32 +0000
Message-Id: <20260609082032.AF5E61F00893@smtp.kernel.org>
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
- [High] The patch prevents a double `device_add()` on the success path, bu=
t causes a forbidden second `device_add()` call if the first attempt fails.
--

commit ece8de02ea1a088261ec6c5d40e683d0804f1957
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Avoid double device_add when clients already present

This commit fixes an issue in host1x_device_add where device_add is called
twice if all subdevs are matched and moved to the active list. It prevents
the second call by checking a registered flag before invoking device_add at
the end of the function.

> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index f814eb4941c02..fe4af98e8fc68 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c

[ ... ]

> @@ -508,7 +508,7 @@ static int host1x_device_add(struct host1x *host1x,
>  	 * Add device even if there are no subdevs to ensure syncpoint function=
ality
>  	 * is available regardless of whether any engine subdevices are present
>  	 */
> -	if (list_empty(&device->subdevs)) {
> +	if (list_empty(&device->subdevs) && !device->registered) {

[Severity: High]
Does this cause a forbidden second device_add() call if the first attempt
fails during the subdevice registration flow?

If device_add() is called earlier during host1x_subdev_register() and fails,
device->registered remains false. The execution then continues to this final
block in host1x_device_add().=20

Since list_empty(&device->subdevs) could evaluate to true and=20
!device->registered is also true, won't this trigger an immediate second
device_add() on the identically failed structure?

>  		err =3D device_add(&device->dev);
>  		if (err < 0)
>  			dev_err(&device->dev, "failed to add device: %d\n", err);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-b4-host1x-=
small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com?part=3D2
