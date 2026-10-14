Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F45CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16AA10FC5B;
	Wed, 14 Oct 2026 09:35:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF8F10FC8B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:35:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A00A941A3E;
 Wed, 14 Oct 2026 09:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599251F00898;
 Wed, 14 Oct 2026 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791970517;
 bh=ihMrK05lLCPM4fV/n6MP2ep+Vl4w2hABHIdfcnciJSI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QqAVTTQJAjNVFChIui+vGGEm1jEOXK8u3O2jSoD58KJFZuC/Q0LSB/43ZbASk39u0
 BPlbUYqAkO5A2n/sDntfv+aV5zKmu6ZY1jRWkbHpvpw+SPnwlabC58WC6NoJ7I2ZIS
 /Yiyq7xkvlPP9W5/uqP9739UaJXqM83nuVw1yR2qrzan68M5qoTPlYRfLTSiCSU4WM
 Lm411IcPXoqtFBkZoH1LZ5W9UGBlnWAdkPzsbUJIx+pjnwXw6Sfo2UDnQd5CVdjnaP
 IR3HVezY7JCADkzoMSG5S60ts958cBEALTwVas8GtrxEthevHFnxZf8eb8+8QvKCBW
 srRtjqSHF8lPQ==
Message-ID: <sashiko-outbox-171079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fbcon: Rebuild rotated font buffer on font change
To: "Yao Yiqi" <yaoyiqi3@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014085102.497789-1-yaoyiqi3@huawei.com>
References: <20261014085102.497789-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 09:35:16 +0000
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
- [High] fbcon: dangling pointer in par->rotated.fontdata causes ABA vulner=
ability
- [High] fbcon: OOB read and UAF in fbcon_do_set_font error path
--

commit 40ac874a29ca63690bb8c7dfaad9a195bb52891d
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Rebuild rotated font buffer on font change

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. This commit fixes a slab-out-of-bounds read in
fbcon when changing the console font by explicitly rebuilding the
rotated font buffer before the redraw is triggered.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 615fa596b7cce..caad4e06944ea 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2431,6 +2431,17 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  	else if (!vc->vc_hi_font_mask && charcount =3D=3D 512)
>  		set_vc_hi_font(vc, true);
> =20
> +	/*
> +	 * The rotated font buffer is sized from the new font's width, height
> +	 * and charcount. Rebuild it for the visible console before the redraw
> +	 * below, as fbcon_switch() and fbcon_modechanged() already do. The
> +	 * redraw reaches the rotated bitops through hide_cursor(), and those
> +	 * index the buffer with the new cell size and character codes, so a
> +	 * stale, too-small buffer is read out of bounds.
> +	 */
> +	if (con_is_visible(vc) && par->bitops->rotate_font)
> +		par->bitops->rotate_font(info, vc);
> +

[Severity: High]
If vc_resize() fails below this point (e.g., due to -ENOMEM from screen buf=
fer
allocation), the err_out path reverts the console font metrics but leaves t=
he
rotated buffer and pointer out of sync.

Could this leave par->rotated.buf sized for the new font, while the font
metrics are restored to the old font? If a subsequent call uses a smaller f=
ont,
the buffer could be allocated exactly to the smaller size. If vc_resize() t=
hen
fails, the metrics are restored to the larger font, which could cause a
slab-out-of-bounds read during subsequent redraws (such as cursor blink).

Furthermore, the err_out path drops the new font's refcount via
font_data_put(data), and the memory is subsequently freed by the caller.

Does this leave par->rotated.fontdata as a dangling pointer to this freed
memory?=20

If a future font allocation reuses this exact slab address, the ABA logic in
fbcon_rotate_font():

	if (par->p->fontdata =3D=3D par->rotated.fontdata &&
	    par->rotate =3D=3D par->rotated.buf_rotate)
		return 0;

would incorrectly assume the font hasn't changed and skip rebuilding the
buffer, perpetuating the metric mismatch and leading to further out-of-boun=
ds
accesses.

>  	if (resize) {
>  		int cols, rows;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014085102.4977=
89-1-yaoyiqi3@huawei.com?part=3D1
