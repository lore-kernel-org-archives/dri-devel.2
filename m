Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C80C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592C910F182;
	Thu, 27 Aug 2026 19:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E/jB0R2v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FAD10F182
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BBC441AEE;
 Thu, 27 Aug 2026 19:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0341F000E9;
 Thu, 27 Aug 2026 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787858079;
 bh=2JUzywhNaxq6ibgTry/TixZ6Tep+1QTVbqSk42ZWtfw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E/jB0R2vdTqOkjsldH1EHtmV3hokXju5K9FNNKaVCituQXxMcXc4eJB3I0o7LHR3t
 iFQshD2sqHzEkrCKaLcefeORMYnMM60s7xsbGOmWPvp/hWlCeZv9FGCVF3MI38+yUL
 m1tVCr0sMTpjWw1JcxIy1wN7LODsIuHstxymEOH6MKUPxWDrCqHhjC0gSVQOYHPJTn
 6RxuYJSi+WC0pf/CgNLADQvgKZ51rMDdzGMh/NFhpwH6x+4+Ke+XiEqG8gdEE1mu4X
 5GAJroHZAoE8G9f0tJzUcBNOBZyV2eSxOq2g5XVvS92h5iOVVYePVqNfAhKM3aQ6AE
 bIwe7SqI2taXA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 7/9]: vt: Handle up to 2^21 glyphs, rather than 256/512
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCH8Pt7qdDjUWuW@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCH8Pt7qdDjUWuW@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:14:38 +0000
Message-Id: <20260827191439.4A0341F000E9@smtp.kernel.org>
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
- [High] The intended support for large 21-bit fonts is functionally broken=
, and allocations near the 4MB boundary trigger a kernel warning.
--

commit 0f8b2aafff067c8299c320bab75fcb965a117b84
Author: Alan Mackenzie <acm@muc.de>

vt: Handle up to 2^21 glyphs, rather than 256/512

This commit increases the maximum number of font glyphs supported by the
vt subsystem to 2^21 to supplement tests with full Unicode limits.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9208970f731e0..baf7c98429e9c 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -5015,17 +5016,23 @@ static int con_font_set(struct vc_data *vc, const=
 struct console_font_op *op)
[ ... ]
>  	size =3D DIV_ROUND_UP(op->width, 8) * vpitch * op->charcount;
> +#ifndef CONFIG_FB_GLYPH_21BIT
>  	if (size > max_font_size)
>  		return -ENOSPC;
> -
> +#endif
>  	void *font_data __free(kfree) =3D font.data =3D memdup_user(op->data, s=
ize);

[Severity: High]
Will memdup_user() reliably handle the newly permitted size allocations?

Because memdup_user() relies on kmalloc(), it is bounded to allocations
up to 4MB (MAX_PAGE_ORDER). If a user requests a font with 2^21 glyphs, the
size could easily exceed this limit, causing the allocation to silently fail
with -ENOMEM.=20

Would it be better to use vmemdup_user() here to fully support the larger
21-bit limit?

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 576be479d9286..a610071c89f53 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -2525,10 +2531,18 @@ static int fbcon_set_font(struct vc_data *vc, con=
st struct console_font *font,
>  	int i, ret;
>  	font_data_t *new_data;
> =20
> -	/* Is there a reason why fbconsole couldn't handle any charcount >256?
> -	 * If not this check should be changed to charcount < 256 */
> +#ifdef CONFIG_FB_GLYPH_21BIT
> +	if (charcount < 256)
> +		return -EINVAL;

[Severity: High]
Does this relaxed limit expose a kernel warning crash vector in the page
allocator?

By allowing charcount to reach 2^21, font allocations can approach or exact=
ly
hit the 4MB limit. When font_data_import() is called later in this function
with these parameters, it does the following:

lib/fonts/fonts.c:font_data_import() {
    ...
    alloc_size =3D size + sizeof(*font_data);
    font_data =3D kmalloc(alloc_size, GFP_USER);
    ...
}

If a user with CAP_SYS_TTY_CONFIG configures a font where the requested size
is exactly 4MB (which passes the memdup_user() check in con_font_set()), the
addition of sizeof(*font_data) will push the alloc_size slightly over 4MB.=
=20

Since this kmalloc() lacks the __GFP_NOWARN flag and requires an order 11
allocation, it will trigger a WARN_ON_ONCE in the page allocator. This could
crash systems configured with panic_on_warn.

> +#else
> +	/* There is no longer any reason why fbconsole can't handle
> +	 * any charcount >256, when CONFIG_FB_GLYPH_21BIT is #defined.
> +	 * Hence this check has been changed to charcount < 256
> +	 * above.
> +	 */
>  	if (charcount !=3D 256 && charcount !=3D 512)
>  		return -EINVAL;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D7
