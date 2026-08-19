Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDE5C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F2F10EEA8;
	Wed, 19 Aug 2026 19:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jTG5Zo45";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2728F10E02D
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:30:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3077960DC0;
 Wed, 19 Aug 2026 19:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F5B1F000E9;
 Wed, 19 Aug 2026 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787167838;
 bh=24at7HFbDE+yEDQR1EP2CkvONdx2YwE2kRtmcPQt600=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jTG5Zo45iRcqaeycYYch45IjwJp/T9b09NQFG+UOomaUatVWQfUaF8KapjVcM65v9
 UsFIlPrTakPHHkXt1SEH21mbzKFOwmXaAla4+F5qVwolXbm1JQ9de43Hi2jHD3NST9
 Yb7uu0ZqZzTkX+WYBZKlBJV5/PVmBMTCymI6VoRcHehJ1BbuHnXCWALCK6/oXL5/wg
 WkpPkJGAu8JxGR4c0r+MnvrLVJbkMdgIIirwdAMkT5BeO9IiwPIcHth154YVQ+6lYA
 77wjcBA2q4ZNpI4o4ULvA9/ERVDt5RkSxsJtBO8kpS45iU5/hY3sQpwrkdJoovfymF
 ysss/+d0tS/Tw==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] KASAN: vmalloc-out-of-bounds Write in fillrect
To: "Jaeyoung Chung" <jjy600901@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819191849.46929-1-jjy600901@snu.ac.kr>
References: <20260819191849.46929-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:30:38 +0000
Message-Id: <20260819193038.C7F5B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The proposed patch contains fuzzer-specific debugging delays based=
 on process names, which is unsuitable for mainline and introduces potentia=
l DoS.
- [Medium] The patch introduces data races on global tracking variables use=
d for debugging.
- [Medium] The commit message promises a crash log and C reproducer, but th=
ey are missing from the commit.

Pre-existing issues:
- [Critical] Pre-existing vmalloc out-of-bounds write caused by mismatched =
virtual console and framebuffer dimensions when `vc_resize` fails.
- [High] fbcon_set_disp() silently returns early if var_to_display() fails,=
 leaving the virtual console partially configured.
- [High] Framebuffer geometry reconfiguration races with console drawing op=
erations.
--

--- Patch [1]: [BUG] KASAN: vmalloc-out-of-bounds Write in fillrect ---
commit 9b426af657fe7eb031d119fdffbef9574baa163d
Author: Jaeyoung Chung <jjy600901@snu.ac.kr>

KASAN: vmalloc-out-of-bounds Write in fillrect

This commit reports a vmalloc out-of-bounds write in fillrect discovered
by a race fuzzer. It provides a patch adding artificial delays to help
reproduce the race reliably.

> KASAN: vmalloc-out-of-bounds Write in fillrect
>
> Hello,
>
> We found a "KASAN: vmalloc-out-of-bounds Write in fillrect" on Linux v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root=
 cause,
> so we do not have a proposed fix to offer.
>
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all included
> below.

[Severity: Medium]
The commit message indicates that a crash log and C reproducer are included
below, but they appear to be missing from the commit text. Can these be
provided to help with the analysis?

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8f467b22b799e..bf68bba39b559 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -3287,6 +3289,10 @@ static int do_con_write(struct tty_struct *tty, co=
nst u8 *buf, int count)
>  	if (in_interrupt())
>  		return count;
> =20
> +	if (syz_dcw_hits < 256 && strncmp(current->comm, "syzrepro2", 9) =3D=3D=
 0) {
> +		syz_dcw_hits++;
> +		mdelay(5);
> +	}

[Severity: High]
Is this debugging logic intended for upstream? Introducing an unbounded
delay based on user-controlled process names (current->comm) might allow
an unprivileged local user to stall the console subsystem indefinitely.

[Severity: Medium]
Can this unsynchronized increment of syz_dcw_hits lead to data races?
Concurrent execution of console output could cause undefined behavior
and incorrect hit counts.

>  	guard(console_lock)();

[Severity: High]
This is a pre-existing issue, but does console drawing race with
framebuffer geometry reconfiguration?

Looking at do_con_write(), it executes under console_lock but does not
take info->lock. Framebuffer reconfiguration, such as via fb_set_var(),
modifies info->var and reallocates memory under info->lock.=20

This could lead to data races or out-of-bounds writes on the framebuffer
memory if ioctl(FBIOPUT_VSCREENINFO) and console writes happen concurrently.

> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
> index 39f44258d793f..f2cb909c8e5bd 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
[ ... ]
> @@ -69,6 +73,10 @@ static void bit_clear(struct vc_data *vc, struct fb_in=
fo *info, int sy,
>  	region.height =3D height * vc->vc_font.height;
>  	region.rop =3D ROP_COPY;
> =20
> +	if (syz_bc_hits < 96 && strncmp(current->comm, "syzrepro", 8) =3D=3D 0)=
 {
> +		syz_bc_hits++;
> +		mdelay(5);
> +	}
>  	info->fbops->fb_fillrect(info, &region);
>  }

[Severity: Critical]
This is a pre-existing issue, but could the region calculation lead to a
vmalloc out-of-bounds write?

In bit_clear(), the region dimensions are calculated using vc->vc_font
geometry:

    region.dx =3D sx * vc->vc_font.width;

If vc_resize() fails during fbcon_set_disp() but leaves vc_cols and
vc_rows at their previous sizes, the mismatched virtual console and
framebuffer dimensions can cause bit_clear() to write outside the
bounds of the framebuffer.

[Severity: Medium]
Does this code introduce data races due to the unsynchronized increment
of syz_bc_hits?

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 23b3c536d53d1..75a14ee4ca131 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -1492,6 +1493,9 @@ static void fbcon_set_disp(struct fb_info *info, st=
ruct fb_var_screeninfo *var,
>  	rows /=3D vc->vc_font.height;
>  	ret =3D vc_resize(vc, cols, rows);

[Severity: Critical]
This is a pre-existing issue, but does ignoring the vc_resize() error
leave the console bound with desynced dimensions?

In fbcon_set_disp(), if vc_resize() fails due to a memory allocation
failure or invalid dimensions, it returns an error. However, this error
is only used to skip update_screen():

    if (con_is_visible(vc) && !ret)
        update_screen(vc);

This ignores the error and leaves vc_cols and vc_rows at their previous
sizes, which can later cause the out-of-bounds writes in bit_clear()
mentioned above.

[Severity: High]
This is a pre-existing issue, but does fbcon_set_disp() silently ignore
failures from var_to_display()?

fbcon_set_disp() contains an early return that aborts configuration without
propagating the error:

    if (var_to_display(p, var, info))
        return;

Could this leave the console state inconsistent with the framebuffer state
and lead to further memory safety issues?

> +	if (strncmp(current->comm, "syzrepro", 8) =3D=3D 0) {
> +		mdelay(10);
> +	}

[Severity: High]
Does this code introduce an unbounded delay conditional on user-controlled
input, potentially leading to a denial of service?

>  	if (con_is_visible(vc) && !ret)
>  		update_screen(vc);
>  }
[ ... ]
> @@ -2091,6 +2096,10 @@ static int fbcon_resize(struct vc_data *vc, unsign=
ed int width,
>  	struct fb_var_screeninfo var =3D info->var;
>  	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
> =20
> +	if (syz_fr_hits < 32 && strncmp(current->comm, "syzrepro", 8) =3D=3D 0)=
 {
> +		syz_fr_hits++;
> +		mdelay(5);
> +	}

[Severity: Medium]
Can this unsynchronized increment of syz_fr_hits lead to data races?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819191849.4692=
9-1-jjy600901@snu.ac.kr?part=3D1
