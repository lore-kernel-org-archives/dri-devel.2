Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AA606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWOC2jz1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2FD310E126;
	Tue, 27 Oct 2026 03:47:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A3F10E126
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 03:47:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21CC043C06;
 Tue, 27 Oct 2026 03:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC851F01825;
 Tue, 27 Oct 2026 03:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793072820;
 bh=h1tidh/yIhqxpvkjGvySUHNRK44lMB4l4tHWk1Gq+a0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JWOC2jz1zLVfci40uq1GVADM4eWoPodNeFhQt2wsAHOloRC7CCTImfZgQHmFPwAIY
 YeX0/LKoxptR65NaWwOTXwJ3FYkKQzyg5z/GUA1zg6/xFr7DU/3IL8QZQp1BHoL0UR
 c+gDGs71bXU8yW/LE/tp2VkGRd4Wji09kFDQbwExOedrBmAeyd3sK4w9nF0J6R685V
 GKyg5lCbp139dmJCQUff1+rEo+/WfU2zi+DYeh/BZtORcRBdEZ82sWwW4fFfiLK1FX
 u1gG81N3oUPdNSznmGDx7RTxm5m5rVvxLgHyc8QQXXVPj3dCvWuzULB/SbqFDqAT2d
 8PxVLTjG53XNQ==
Message-ID: <sashiko-outbox-186057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbcon: Avoid cancel_delayed_work_sync() in atomic
 context
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027033422.585328-1-yyaqia@gmail.com>
References: <20261027033422.585328-1-yyaqia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 03:46:59 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] fbcon: race in fbcon_del_cursor_work() lets fb_flashcursor() re-=
arm work
--

commit e9056993ba6eca270987e2b77d6a3977beffec71
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Avoid cancel_delayed_work_sync() in atomic context

This commit replaces cancel_delayed_work_sync() with cancel_delayed_work() =
in
fbcon_del_cursor_work() to avoid sleeping in atomic console printing contex=
ts,
while adding fbcon_del_cursor_work_sync() for teardown in fbcon_release() a=
nd
moving the delayed work requeue in fb_flashcursor() inside console_lock.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 7720dfc80c165..066cd974ea3bb 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -422,10 +422,14 @@ static void fb_flashcursor(struct work_struct *work)
>  	par->bitops->cursor(vc, info, enable,
>  			    get_fg_color(vc, info, c),
>  			    get_bg_color(vc, info, c));
> -	console_unlock();
> =20
> +	/*
> +	 * Re-arm under console_lock so that a concurrent
> +	 * fbcon_del_cursor_work() cannot race with this requeue.
> +	 */
>  	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
>  			   par->cur_blink_jiffies);
> +	console_unlock();
>  }
> =20
>  static void fbcon_add_cursor_work(struct fb_info *info)
> @@ -437,10 +441,30 @@ static void fbcon_add_cursor_work(struct fb_info *i=
nfo)
>  				   par->cur_blink_jiffies);
>  }
> =20
> +/*
> + * Stop the cursor blink.
> + *
> + * Does not wait for a callback that is already running, so it is safe to
> + * call from any context.
> + *
> + * console_lock serializes this with the requeue in fb_flashcursor();
> + * otherwise a running callback could re-arm the work.
> + */
>  static void fbcon_del_cursor_work(struct fb_info *info)
>  {
>  	struct fbcon_par *par =3D info->fbcon_par;
> =20
> +	cancel_delayed_work(&par->cursor_work);
> +}

[Severity: Medium]
Can fb_flashcursor() still race with fbcon_del_cursor_work() and re-arm
par->cursor_work after blinking has been stopped?

When par->cursor_work expires, process_one_work() clears
WORK_STRUCT_PENDING_BIT before invoking fb_flashcursor(). If a caller holdi=
ng
console_lock (such as cursor_blink_store(), fbcon_blank(), fbcon_switch(),
fbcon_deinit(), or fbcon_cursor() with CUR_SW) runs fbcon_del_cursor_work()
after WORK_STRUCT_PENDING_BIT is cleared, but before the worker executes
console_trylock() in fb_flashcursor():

CPU0 (holding console_lock)          CPU1 (worker thread)
                                     process_one_work()
                                       /* clears WORK_STRUCT_PENDING_BIT */
                                       fb_flashcursor()
fbcon_del_cursor_work()
  cancel_delayed_work(&par->cursor_work)
  /* returns false without waiting */
console_unlock()
                                         ret =3D console_trylock();
                                         /* succeeds */

Because fb_flashcursor() only checks:

	if (!vc || !con_is_visible(vc) ||
	    fbcon_info_from_console(vc->vc_num) !=3D info ||
	    vc->vc_deccm !=3D 1) {
		console_unlock();
		return;
	}

and does not verify whether blinking is still supposed to be active (for
example fbcon_cursor_blink, vc->vc_cursor_type & CUR_SW,par->graphics /
KD_GRAPHICS, par->blank_state, or par->initialized), won't it draw the curs=
or
and call queue_delayed_work() to perpetually re-arm par->cursor_work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027033422.5853=
28-1-yyaqia@gmail.com?part=3D1
