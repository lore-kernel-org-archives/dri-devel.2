Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E49C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D8710E67B;
	Wed, 26 Aug 2026 21:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HXHXVcFi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5940410E67B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:43:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 573FB6020E;
 Wed, 26 Aug 2026 21:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91581F000E9;
 Wed, 26 Aug 2026 21:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780594;
 bh=a1yTWDHTAh9/wRhApJzdbs1bjsFkP/+ZFGlWbqaWac0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HXHXVcFiyM19nzqqk8DkNqDVGfDW4qgXyhBpowPg4doHEoDhQo4150KKy1JDz4Jee
 y3ABvFgDEhZCvoGURgqgOb6UHaymZ4pcqjTPQv1RR8/4h3a56xZ+Vm5iGpyLhrMY6G
 wZNSbOuL88rqJaoDU0BRQbPPGXOLCQavQSXNfCs/uDLHfkT/hGoiR2qqWSf8D6Jc/v
 erbW/LtIFXn9msS6dSI5OGBzSlY52LsNk6AMZ2cVdvPBE7IvNIjJqnnNH3OaZpvoqM
 XFxqFrZ9c/mN7gVGyZ70pLUCqN3RGBPn+ihHRGvkDpaVcEArydM3ZFIYojDKe1w8Rn
 f/E6bnGpY5yKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/amdxdna: Bound the page count of a user
 supplied buffer
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826212825.408846-1-taimuraz@kaitmazov.com>
References: <f1cbc1bf-2904-e0cf-8fc6-07ce41dad2a2@amd.com>
 <20260826212825.408846-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:43:13 +0000
Message-Id: <20260826214313.D91581F000E9@smtp.kernel.org>
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
- [High] Unrestricted userspace-controlled allocation size for `va_ent` can=
 trigger the OOM killer.
--

commit 9b9a5c5cd1330d0aae0aea71c45dc018b59ee7e1
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: Bound the page count of a user supplied buffer

This patch fixes an issue where amdxdna_get_ubuf() could truncate a per-ent=
ry
page count derived from a 64-bit length into a 32-bit integer. It adds
validation to ensure the total page count fits within an integer, preventing
invalid memory accesses. It also explicitly rejects zero-length buffer
entries.

> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna=
/amdxdna_ubuf.c
> index 0e0cd69cd1fbf..bf1e4dd7bbc30 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -111,8 +111,9 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *d=
ev,
> =20
>  	for (i =3D 0, exp_info.size =3D 0; i < num_entries; i++) {

[Severity: High]
This is a pre-existing issue, but is it possible for num_entries to be a
massive value here?

Looking at amdxdna_gem_create_ubuf_object() in
drivers/accel/amdxdna/amdxdna_gem.c, it appears that va_tbl.num_entries
from userspace is passed directly to amdxdna_get_ubuf() without any bounds
checking.

Earlier in amdxdna_get_ubuf(), we allocate memory based on this value:

	va_ent =3D kvzalloc_objs(*va_ent, num_entries);

If an unprivileged user with a non-zero RLIMIT_MEMLOCK sets num_entries to a
huge value like U32_MAX, can this allocate an unrestricted amount of memory
and trigger the OOM killer before we even reach the bounds checks on nr_pag=
es
added in this patch?

>  		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
> -		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
> -			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
> +		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE) ||
> +		    !va_ent[i].len) {
> +			XDNA_DBG(xdna, "Invalid address or len %llx, %llx",
>  				 va_ent[i].vaddr, va_ent[i].len);
>  			ret =3D -EINVAL;
>  			goto free_ent;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826212825.4088=
46-1-taimuraz@kaitmazov.com?part=3D1
