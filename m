Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE641C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054C710E06E;
	Mon,  3 Aug 2026 19:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DceCvKWE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC8510E06E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 19:03:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76AC242E2B;
 Mon,  3 Aug 2026 19:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3931F000E9;
 Mon,  3 Aug 2026 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785783809;
 bh=cTtWDaHnAm+aYzRTO/lzVU5kkY8dARhS6h+icsGcDN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DceCvKWEKXRycvx0KfD8gJsU4GMQ3IfeFcw37tHODnjjN8KJFvg4Y9y3UaEYu/mjM
 9MWaN8SqyWwnZut2WUDYAhdrV/8KREuD3QJY12CE1dvB93BZsH5LZskli80fs4U3r8
 6wc2gHiQ8nQJw1IOld98q4GY73AzMpYkIFHRbncEpOklJBJ85oy5eaBNVpqz/bkrSd
 uV0eR+UKbfN+BPRtd0aHJJjkuL9HPcQLvSmEMORJqOdO9KC1gk5yLunCNpmUkWX/p8
 rURIyEcG94xvXbx1GVdrdGobKyZ+cItWhbNHwM7wykdjdXpqd8xhxo0PW0757ZYZNd
 p3lS4KAIUzkOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: ssd1307fb: defer I2C transfers from damage
 callbacks
To: sh_def@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803183957.3481000-1-sh_def@163.com>
References: <20260803183957.3481000-1-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 19:03:28 +0000
Message-Id: <20260803190329.3C3931F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Concurrent writes during device removal schedule deferred work=
 after cleanup, leading to a NULL pointer dereference in the workqueue.

Pre-existing issues:
- [Critical] The framebuffer screen memory is freed prematurely in the remo=
ve path, allowing concurrent writes to corrupt freed pages.
--

--- Patch [1]: [PATCH] fbdev: ssd1307fb: defer I2C transfers from damage ca=
llbacks ---
commit 34ea34fa043e51cd59d74662902a40b400c4fb97
Author: Hui Su <sh_def@163.com>

fbdev: ssd1307fb: defer I2C transfers from damage callbacks

This commit tracks damage in the driver's private data and merges multiple
updates into a bounding rectangle. It queues the deferred I/O work
immediately for damage reported by fbdev drawing and write helpers to avoid
entering the sleeping I2C transfer path from atomic context.

> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 644b8d97b3811..c4fdecafd8560 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
[ ... ]
> @@ -302,19 +310,49 @@ static int ssd1307fb_blank(int blank_mode, struct f=
b_info *info)
>  		return ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
>  }
> =20
> +static void ssd1307fb_schedule_damage(struct fb_info *info, u32 x, u32 y,
> +				      u32 width, u32 height)
> +{
> +	struct ssd1307fb_par *par =3D info->par;
> +	unsigned long flags;
> +	u32 x2, y2;
[ ... ]
> +	spin_unlock_irqrestore(&par->damage_lock, flags);
> +
> +	/* Advance an already-pending mmap update as well. */
> +	mod_delayed_work(system_wq, &info->deferred_work, 0);

[Severity: Critical]
Could this introduce a regression by unconditionally queuing the deferred
work after the driver's remove function has already cleaned it up?

If a userspace program is executing a write() that blocks in fb_sys_write()
during copy_from_user(), and the driver is concurrently unbound:

ssd1307fb_remove()
  unregister_framebuffer()
  fb_deferred_io_cleanup()
    info->fbdefio_state =3D NULL;

When the blocked write() resumes and completes, the driver wrapper invokes
ssd1307fb_schedule_damage(), calling mod_delayed_work() here. When the
work executes, fb_deferred_io_work() will attempt to lock the NULL
fbdefio_state, leading to a crash.

> +}

[ ... ]

While reviewing the above, I also noticed a related issue in the remove pat=
h:

> static void ssd1307fb_remove(struct i2c_client *client)
> {
[ ... ]
> 	fb_deferred_io_cleanup(info);
> 	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));

[Severity: Critical]
This is a pre-existing issue, but can this lead to a use-after-free of the
screen memory?

If a concurrent write() is blocked in fb_sys_write() during copy_from_user(=
),
ssd1307fb_remove() frees the screen buffer pages here without waiting for
active file operations to conclude.

When the blocked write() resumes, copy_from_user() would write the
user-provided data directly into the newly freed physical pages. Should
this resource cleanup be deferred to an .fb_destroy() callback instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803183957.3481=
000-1-sh_def@163.com?part=3D1
