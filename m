Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A63ACD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6603510F181;
	Thu, 18 Jun 2026 06:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JFvkXMQI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD43310F19A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:49:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D32A600BB
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E931F000E9;
 Thu, 18 Jun 2026 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781765371;
 bh=SHfofpnFdKonlxJN8jHHNoALJ5jZ0VGxbwzMuqWp4Sw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JFvkXMQIBkQlM9fbWiWiBXplCsaZtJv8U2su/5Pf1W8vrub9QySnhscHwaNhEtVsA
 aO2BAGmdWlJLHk31dhHjgtC87irn/i6jQCuPyH5+tmO9+hV8KgMCa3NtWowdIevkNo
 uhLyssKF9N/eQH6G93oXXiPxyK6dy3V2RrWWwUVebajmmoLWik1Dt8VXizDCxsWryq
 BjU5HYZ232HHoYxYM99TBVifzra5H0Oo9//aQ7tpvn7Xci+go2o4h8BWn1MhF/oSvb
 Emo/fFZfB4ybypoQnf4HW48L/wEnA/3Kxm1zHomLQFp7YDb5hSuT90letYVhO0vqmt
 UBYoySq2F3/Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbcon: Avoid OOB font access if console rotation fails
To: "HAN Ruidong via B4 Relay" <devnull+rdhan.smu.edu.sg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-prep-base-v5-15-209-v1-1-cfcf596dca7a@smu.edu.sg>
References: <20260618-prep-base-v5-15-209-v1-1-cfcf596dca7a@smu.edu.sg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 06:49:31 +0000
Message-Id: <20260618064931.98E931F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Changing the console font while the console is rotated fails t=
o update the rotated font buffer, leading to out-of-bounds memory reads.
- [High] The error fallback to unrotated mode (FB_ROTATE_UR) when `fbcon_ro=
tate_font()` fails is overridden, leaving the console in a permanently blan=
ked state.
- [High] Cached state variables in `fbcon_rotate_font()` are updated before=
 attempting allocation, preventing recovery if the allocation fails.
--

commit bb8bca6b1feaf32fb858b99e293b0b6eee16a8cd
Author: HAN Ruidong <rdhan@smu.edu.sg>

fbcon: Avoid OOB font access if console rotation fails

This commit clears the font buffer and size if reallocation during
console rotation fails in fbcon_rotate_font(). This prevents the
rotated buffer implementations from overflowing when printing with
a high-enough character code on an undersized old buffer.

Link: https://elixir.bootlin.com/linux/v6.19/source/drivers/video/fbdev/cor=
e/fbcon_ccw.c#L144 # [1]

> diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbde=
v/core/fbcon_rotate.c
> index ec3c883400f7b..4a06e71ae4434 100644
> --- a/drivers/video/fbdev/core/fbcon_rotate.c
> +++ b/drivers/video/fbdev/core/fbcon_rotate.c
> @@ -46,6 +46,10 @@ static int fbcon_rotate_font(struct fb_info *info, str=
uct vc_data *vc)
>  		info->fbops->fb_sync(info);
> =20
>  	if (ops->fd_size < d_cellsize * len) {
> +		kfree(ops->fontbuffer);
> +		ops->fontbuffer =3D NULL;
> +		ops->fd_size =3D 0;
> +
>  		dst =3D kmalloc_array(len, d_cellsize, GFP_KERNEL);
> =20
>  		if (dst =3D=3D NULL) {

[Severity: High]
This is a pre-existing issue, but updating the cached state before the
allocation in fbcon_rotate_font() seems to prevent recovery if the
allocation fails.

Earlier in this function, the state is updated unconditionally:

    src =3D ops->fontdata =3D vc->vc_font.data;
    ops->cur_rotate =3D ops->p->con_rotate;

If kmalloc_array() fails here and returns -ENOMEM, the state variables
are not reverted.=20

If a subsequent retry occurs with the same font parameters, the cache
check at the top of the function evaluates to true:

    if (vc->vc_font.data =3D=3D ops->fontdata &&
        ops->p->con_rotate =3D=3D ops->cur_rotate)
            goto finished;

Will this bypass the allocation logic and return success prematurely,
leaving ops->fontbuffer as NULL indefinitely and the console blanked?

[Severity: Critical]
This is a pre-existing issue, but is there a missing call to
fbcon_rotate_font() when changing the console font while the console is
rotated?

In drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font(), the unrotated
font state is updated:

    vc->vc_font.width =3D w;
    vc->vc_font.height =3D h;
    vc->vc_font.charcount =3D charcount;

This triggers a screen redraw via update_screen(), but
fbcon_rotate_font() does not appear to be called to regenerate the
rotated font buffer.

When update_screen() invokes the rotated putcs functions, they compute
index offsets using the new font dimensions. Could this lead to reading
out of bounds from the stale, potentially undersized ops->fontbuffer
if the new font has a larger character count or dimensions?

[Severity: High]
This isn't a bug introduced by this patch, but does the fallback to
unrotated mode actually work when fbcon_rotate_font() fails?

If fbcon_rotate_font() returns an error, the callers (fbcon_init() and
fbcon_switch() in drivers/video/fbdev/core/fbcon.c) attempt to disable
rotation:

    if (ops->rotate_font && ops->rotate_font(info, vc)) {
            ops->rotate =3D FB_ROTATE_UR;
            set_blitting_type(vc, info);
    }

However, set_blitting_type() internally calls fbcon_set_rotation():

fbcon.c:fbcon_set_rotation() {
    ...
    if (!(info->flags & FBINFO_MISC_TILEBLITTING) &&
        ops->p->con_rotate < 4)
            ops->rotate =3D ops->p->con_rotate;
    else
            ops->rotate =3D 0;
}

Does this unconditionally overwrite ops->rotate back to the requested
rotation angle (ops->p->con_rotate)? If the fallback is reverted, the
rotated bitops are installed but ops->fontbuffer is NULL, which causes
them to abort and leaves the console permanently blanked.

> @@ -54,7 +58,6 @@ static int fbcon_rotate_font(struct fb_info *info, stru=
ct vc_data *vc)
>  		}
> =20
>  		ops->fd_size =3D d_cellsize * len;
> -		kfree(ops->fontbuffer);
>  		ops->fontbuffer =3D dst;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-prep-base-=
v5-15-209-v1-1-cfcf596dca7a@smu.edu.sg?part=3D1
