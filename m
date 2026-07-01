Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382F310EFFF;
	Wed,  1 Jul 2026 23:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lkV2fQl5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E7410EFFF
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:54:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78827600AF;
 Wed,  1 Jul 2026 23:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018891F000E9;
 Wed,  1 Jul 2026 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782950089;
 bh=5D/xHDvSnKBaNLZcV2OCYRMrnZhWCJHmaO6KEaQuTJw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lkV2fQl5ZqPk4ybj7nILCqU1ZZs5h4k7vXEr2MRxQogaLNAAx+wvK8gOWtW6hVX8s
 IHHF6JcqFviCX35JQrldIezWaMZz0gY02DN5/9QV5SbfumipYn9PTMmkEC/2ZbJ651
 XHtlEWhburZ2EgIlvQF+DEJgdDlo6bicI2PCrCIS3PCffkYmukOF1Ei3/wDR7ooz/U
 ArgLxLIrLy4MwIShEkUy3KT/SS3JWs8YT9DdkN0yOUf+7z9tluQMKYjs3pIUDjloHJ
 9kmOLNA1V1p9KuYfmHP+fQPc4xP1iIQOpY+zFTP78O/+S0P/vu1IFB0fCbGuivI9bR
 mxR1bw87A4APQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] fbdev: bound mode sysfs output to the sysfs buffer
To: "Melbin K Mathew" <mlbnkm1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701234248.236023-2-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
 <20260701234248.236023-2-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 23:54:48 +0000
Message-Id: <20260701235449.018891F000E9@smtp.kernel.org>
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
- [High] Unprotected value copy of large `fb_info->var` struct leads to tor=
n reads and state corruption in sysfs store functions.
--

commit 03248859e392cd00678961d93e5c27717ac23498
Author: Melbin K Mathew <mlbnkm1@gmail.com>

fbdev: bound mode sysfs output to the sysfs buffer

This commit updates mode_string() to take a size parameter and use scnprint=
f()
to prevent buffer overruns when generating sysfs output. It also modifies
show_modes() to stop accumulating mode strings once the sysfs buffer is ful=
l.

> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/cor=
e/fbsysfs.c
> index ea196603c7a87..af21dc5052df3 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
[ ... ]
> @@ -64,7 +67,7 @@ static ssize_t store_mode(struct device *device, struct=
 device_attribute *attr,
> =20
>  	list_for_each_entry(modelist, &fb_info->modelist, list) {
>  		mode =3D &modelist->mode;
> -		i =3D mode_string(mstr, 0, mode);
> +		i =3D mode_string(mstr, sizeof(mstr), 0, mode);
>  		if (strncmp(mstr, buf, max(count, i)) =3D=3D 0) {
> =20
>  			var =3D fb_info->var;

[Severity: High]
This is a pre-existing issue, but seeing the struct copy here prompted a
question about other sysfs store functions in this file.

In store_mode(), var =3D fb_info->var; is protected by lock_fb_info(fb_info)
acquired earlier in the function. However, other store functions in this fi=
le
perform this same large struct copy locklessly before acquiring the lock:

drivers/video/fbdev/core/fbsysfs.c:store_bpp() {
    ...
    var =3D fb_info->var;
    ...
}

Similar unprotected copies occur in store_rotate(), store_virtual(), and
store_pan().

Can these unprotected copies lead to torn reads if executed concurrently wi=
th
an ioctl or another sysfs write that modifies the display state?

If a torn read occurs and a single field is updated before passing the torn
structure to activate(), could this commit corrupted state back to the
hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701231706.2347=
15-1-mlbnkm1@gmail.com?part=3D1
