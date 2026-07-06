Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC72C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5164010E84E;
	Mon,  6 Jul 2026 09:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZI3y3sFS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B87F10E84E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:44:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 561AD4174A;
 Mon,  6 Jul 2026 09:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1774E1F00A3D;
 Mon,  6 Jul 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783331077;
 bh=V+3KxL72fASSUvvKCraWobVJLGgJpKrydja47FWHdMI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZI3y3sFSxTvsoQlSI99XVj46t2VpP0fsCEj5Fea3EqObWBlhZqx9DvSpuuU3uJ3Ug
 hpNac7ElpghqD2vD4qhxkbyq0ZJISnRCKJmaVjl3evAaqYkpWkC8+F3XZUMaojAp31
 UgQPy1XbDQca7MDHu0/lCW6cXxaUq6HyC8mIddVU5C/gzgkjfZY5VHiWLaHo8gNR8g
 1QA0Az2Qn2vEAgeafsu7Lsdz3mBWsVuLeGFwatlSj6Zb16CD2DM3knZJjO85tM8OqA
 pKD+Dj2Jq/Dv0dEWdn5v+SOAxE8s+ospFqKhwduHHmlnMd+Vny8vbpKnmoG+5nck3m
 wGnq90kfg02wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: udlfb: validate vendor descriptor items
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706093038.80131-1-pengpeng@iscas.ac.cn>
References: <20260706093038.80131-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:44:36 +0000
Message-Id: <20260706094437.1774E1F00A3D@smtp.kernel.org>
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
- [High] Out-of-bounds read in `dev_info` using `%11ph` format specifier, p=
otentially causing a kernel panic.
--

commit 8284c1b4f9c66a4ef2393d5e8aa1741e7ef14d8a
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

fbdev: udlfb: validate vendor descriptor items

This commit validates key-length-value items inside the DisplayLink vendor
descriptor in dlfb_parse_vendor_descriptor(). It ensures each item contains
its key, length, and declared value bytes before reading item-specific fiel=
ds.

> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index fdbb8671a810c..e78d6f95c9c5c 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1586,19 +1586,29 @@ static int dlfb_parse_vendor_descriptor(struct dl=
fb_data *dlfb,

[Severity: High]
This isn't a bug introduced by this patch, but earlier in
dlfb_parse_vendor_descriptor(), there is a potential out-of-bounds read:

	if (total_len > 5) {
		dev_info(&intf->dev,
			 "vendor descriptor length: %d data: %11ph\n",
			 total_len, desc);

Can this unconditionally read 11 bytes even if total_len is as small as 6?

If a malicious USB device stalls the initial control request for the vendor
descriptor, and instead provides it as a 6-byte extra descriptor within the
configuration descriptor blob, desc will point directly into the USB core's
rawdescriptors allocation, and total_len will be 6.

Because the %11ph format specifier unconditionally reads exactly 11 bytes,
would this read 5 bytes out of bounds, potentially causing a kernel panic if
the buffer ends at a page boundary?

>  		desc +=3D 5; /* the fixed header we've already parsed */
> =20
>  		while (desc < desc_end) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706093038.8013=
1-1-pengpeng@iscas.ac.cn?part=3D1
