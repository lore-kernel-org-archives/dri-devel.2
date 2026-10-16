Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40CDCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2276A112613;
	Fri, 16 Oct 2026 07:43:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9155E112613
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:43:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1890B415C4;
 Fri, 16 Oct 2026 07:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47431F000C4;
 Fri, 16 Oct 2026 07:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792136618;
 bh=UTK9A+U3aVg2qSivQmmh//ICrdDIddEoIgyJ/9qxlS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wl7VuH6+alE6qNoO0Jj7Q8LKyCkS7FkdFDv8RS0bVwtwcOYJ/3Im+zJ/hwS8uvdDg
 BeWR9uqKWvaLq5Qd63y6tPs/v+W05fGmhG2UQL6gpfGFsKq3CPEhEIMntQpGwQD5QC
 IUG79CkPvFNvXziDFASIqC87UeWXTvWzTvzY2VjJe+L3cS5o63inzHZaJ0q6EiFyve
 IcDEuB+gPTMXUMIoj5X/SNiyofLcW2jEXYXGknqIOhwfDRBQVczjBb8q+K/j/d/O3m
 86OMD+ChOrwNw13e5m1BOVsg8H8g0+ke2i6znNojcnTKdl6ucRAhltDO0O7Q2H33FR
 qbNsniQ2SqWcg==
Message-ID: <sashiko-outbox-173957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016073023.490430-3-yyaqia@gmail.com>
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-3-yyaqia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:43:37 +0000
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
- [High] fbcon: UAF in panic handler due to dangling par->rotated.buf
--

commit e32477b2f73cd204764bac2654d00076bb8bd3ba
Author: Yao Yiqi <yaoyiqi3@huawei.com>

    fbcon: Rebuild rotated font buffer on font change
   =20
    fbcon_rotate_font() caches a rotated copy of the console font in
    par->rotated.buf. The buffer is sized from the font's width, height
    and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
    fbcon_modechanged(), but not in fbcon_do_set_font().

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 01715873ea49b..d90a2ad45053c 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2432,6 +2432,17 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  	else if (!vc->vc_hi_font_mask && charcount =3D=3D 512)
>  		set_vc_hi_font(vc, true);
> =20
> +	/*
> +	 * Select the console's blitting state and update par->rotated to
> +	 * match the new font, so that the rendering below does not use a
> +	 * cache that was built for the old font.
> +	 */
> +	if (con_is_visible(vc)) {
> +		set_blitting_type(vc, info);
> +		if (par->bitops->rotate_font)
> +			par->bitops->rotate_font(info, vc);

[Severity: High]
Does this code expose a race condition with console_flush_on_panic() that c=
ould
lead to a use-after-free?

When fbcon_rotate_font() is called, it passes par->rotated.buf to
font_data_rotate():

drivers/video/fbdev/core/fbcon_rotate.c:fbcon_rotate_font() {
    ...
	buf =3D font_data_rotate(par->rotated.fontdata, vc->vc_font.width,
			       vc->vc_font.height, vc->vc_font.charcount,
			       par->rotated.buf_rotate, par->rotated.buf,
			       &par->rotated.bufsize);
    ...
}

If a reallocation is needed, font_data_rotate() frees the old buffer before
returning the new one:

lib/fonts/font_rotate.c:font_data_rotate() {
    ...
		kfree(buf);
		buf =3D dst;
    ...
}

During this time, the global par->rotated.buf pointer remains dangling.
If a kernel panic occurs in this window, console_flush_on_panic() could
bypass the console lock and invoke fbcon write operations.

Rendering operations like ccw_putcs() check the pointer:

drivers/video/fbdev/core/fbcon_ccw.c:ccw_putcs() {
    ...
	if (!par->rotated.buf)
		return;
    ...
}

Because par->rotated.buf hasn't been set to NULL or updated to the new
buffer yet, this check would evaluate to false, leading to a read from freed
memory which could abort the panic handler and lose important debug logs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016073023.4904=
30-1-yyaqia@gmail.com?part=3D2
