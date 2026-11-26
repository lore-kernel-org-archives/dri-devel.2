Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B2606A330
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb+644KF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064871125E4;
	Thu, 26 Nov 2026 16:53:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D2A1125F8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:53:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EAB7E60CCC;
 Thu, 26 Nov 2026 16:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E051F000C6;
 Thu, 26 Nov 2026 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712012;
 bh=fzfE6WwTk/OVx148/Pqcks8z2sgXkmOT2Dk3A+zIPeY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vb+644KFTi0YZHWlJusIfQs1Zhoh4Ca5injiCQ+WBW24WLNZWAX3K+wBs4XD93Xik
 0sdXiE6C8+XGaKSSVFAFPngWe/pGoLhiIsjxFPDLAkcodQJmLVJcLhU5WnGjNOp+bw
 9Db8R5rWrMWfusatvtJQn/rzAkleNLCVRSztDL+2SRidzyQF8nIWA5GTC9w5SSgpi1
 ZEoyQM+GH+RB6+TBeOnofW7vb/Sk7oMwBSu4stVRmw4aCkP71ORFzw0meFieqyG/n8
 lnMZrP0iGyIQotfWZ7Fmu5TSrx89a3aLGgYMKOfBLNf5zfg8mtRqcO0xbfj87hM6y3
 1+Ty3vEbn1yGw==
Message-ID: <sashiko-outbox-235947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fbcon: Don't change shared blitting state for
 hidden consoles
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126163150.91355-2-tzimmermann@suse.de>
References: <20261126163150.91355-1-tzimmermann@suse.de>
 <20261126163150.91355-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:53:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] fbcon: use of shared par->rotate for hidden consoles in resize
  and font paths
- [High] fbcon: NULL par->bitops in fbcon_init() after set_con2fb_map()
  pre-allocation
- [High] fbcon: out-of-bounds write in fbcon_cursor() when called on a
  hidden console
- [Low] fbcon: missing Fixes trailer for console rotation bug in
  fbcon_init()
--

commit a2ce0347bbf7ab81f5e250720e0cef883fe6a77b
Author: Thomas Zimmermann <tzimmermann@suse.de>

> fbcon: Don't change shared blitting state for hidden consoles
>
> All consoles on a framebuffer share par->rotate and par->bitops.
> fbcon_init() calls set_blitting_type() for each new console, which
> resets both to the new console's rotation. If the visible console is
> rotated, it then keeps its rotated rows and columns but draws with
> unrotated bitops. The next cursor update or scroll writes beyond the
> framebuffer and oopses, e.g. at shutdown when plymouthd opens a new
> VT:
>
>   BUG: unable to handle page fault for address: ffffd2ce80bd5000
>   RIP: 0010:sys_imageblit+0x707/0x7e0
>    soft_cursor+0x1a4/0x250
>    bit_cursor+0x3ab/0x550
>    hide_cursor+0x27/0xb0
>
> Only call set_blitting_type() from fbcon_init() for the visible console
> or when the fbcon state was just created. Compute a new console's rows
> and columns from its own rotation instead of par->rotate, so that it
> doesn't inherit the visible console's geometry.
>
> Tested on QEMU with console 0 rotated by 90 degrees. Other rotations
> and rotate_all are untested.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

[Severity: Low]
Should this bug fix include a Fixes tag?

  Fixes: e4fc27618b75 ("[PATCH] fbcon: Console Rotation - Prepare fbcon for=
 console rotation")

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 21527d8496e33..7bd51b9f4fe13 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c

[ ... ]

> @@ -1128,9 +1140,11 @@ static void fbcon_init(struct vc_data *vc, bool in=
it)
>  	if (var_to_display(p, &info->var, info))
>  		return;
> =20
> -	if (!info->fbcon_par)
> +	if (!info->fbcon_par) {
>  		if (con2fb_acquire_newinfo(vc, info, vc->vc_num))
>  			return;
> +		new_par =3D true;
> +	}

[Severity: High]
Can par->bitops remain NULL here if an unallocated console was first
mapped to a secondary framebuffer via set_con2fb_map()?

When set_con2fb_map() maps an unallocated VT (vc =3D=3D NULL) to a new
framebuffer, con2fb_acquire_newinfo() allocates info->fbcon_par via
fbcon_open() without calling set_blitting_type().  When that background
VT is later allocated while another console is visible, fbcon_init() sees
info->fbcon_par !=3D NULL (so new_par is false) and !con_is_visible(vc),
skipping set_blitting_type() and leaving par->bitops NULL.  A subsequent
hide_cursor() on that hidden console (for example via KDFONTOP) then
dereferences NULL at par->bitops->cursor in fbcon_cursor().

Checking !par->bitops instead of tracking new_par would ensure the
blitting state is initialized whenever par->bitops has not been set yet.

[ ... ]

> @@ -1188,12 +1202,15 @@ static void fbcon_init(struct vc_data *vc, bool i=
nit)
>  	if (p->con_rotate =3D=3D -1)
>  		p->con_rotate =3D FB_ROTATE_UR;
> =20
> -	set_blitting_type(vc, info);
> +	if (new_par || con_is_visible(vc))
> +		set_blitting_type(vc, info);
> =20
>  	cols =3D vc->vc_cols;
>  	rows =3D vc->vc_rows;
> -	new_cols =3D FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
> -	new_rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
> +	/* Use the console's own rotation; par->rotate belongs to the visible o=
ne. */
> +	rotate =3D fbcon_display_rotation(info, p);
> +	new_cols =3D FBCON_SWAP(rotate, info->var.xres, info->var.yres);
> +	new_rows =3D FBCON_SWAP(rotate, info->var.yres, info->var.xres);
>  	new_cols /=3D vc->vc_font.width;
>  	new_rows /=3D vc->vc_font.height;

[Severity: High]
What happens in the resize and font paths for a hidden console now that
par->rotate stays set to the visible console's rotation?

When fbcon_init() is called with init =3D=3D false and runs
vc_resize(vc, new_cols, new_rows) (or when TIOCSWINSZ resizes a hidden
console), fbcon_resize() and updatescrollmode() still use
FBCON_SWAP(par->rotate, ...) instead of fbcon_display_rotation(info, p).
If the visible console is rotated 90 or 270 degrees relative to the
hidden console on a non-square display, fbcon_resize() checks new_cols
and new_rows against swapped axes and fails with -EINVAL.

Similarly, changing font dimensions on a hidden console in
fbcon_do_set_font() skips set_blitting_type() when !con_is_visible(vc)
but computes cols and rows from FBCON_SWAP(par->rotate, ...):

drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font() {
    ...
	if (resize) {
		int cols, rows;

		cols =3D FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
		rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
		cols /=3D w;
		rows /=3D h;
		ret =3D vc_resize(vc, cols, rows);
    ...
}

That resizes the hidden console to the visible console's rotated geometry
while its own p->con_rotate stays unrotated.  Switching to that console
later calls set_blitting_type() in fbcon_switch() without resizing
vc_cols/vc_rows, leaving rotated dimensions with unrotated bitops and
causing sys_imageblit() to write past info->screen_base.

[Severity: High]
Can calling hide_cursor() on a hidden console also write out of bounds in
fbcon_cursor()?

With this change, a hidden console has vc_cols and vc_rows sized for its
own rotation while par->bitops holds the visible console's rotated
bitops.  Because neither hide_cursor() nor fbcon_cursor() checks
con_is_visible(vc), operations on a background VT that call
hide_cursor(vc) (such as con_font_set() or writing cursor coordinates to
/dev/vcsaN) invoke par->bitops->cursor() with the hidden console's
vc->state.x and vc->state.y.  When the visible console is rotated 90 or
270 degrees and the hidden console's cursor position exceeds the rotated
axis limit, cw_cursor() or ccw_cursor() computes an out-of-bounds (or
wrapped negative) dy and calls soft_cursor() -> sys_imageblit(), writing
past info->screen_base.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126163150.9135=
5-1-tzimmermann@suse.de?part=3D1
