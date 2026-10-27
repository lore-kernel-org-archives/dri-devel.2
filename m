Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9087606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWz96JJC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD9410E276;
	Tue, 27 Oct 2026 04:00:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7056010E276
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:00:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31E5B414C0;
 Tue, 27 Oct 2026 04:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDF81F01825;
 Tue, 27 Oct 2026 04:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793073652;
 bh=1CIzTwhTdCUyjaoXFWvG8M4gkdIzBl02Vx5Fm7HhrBE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JWz96JJClKjUXzBFxBBPuwPqu6ceBq2MMT9WqByi+Evrm6VcBzg6M0FJ+yj7o8G2N
 QiPFHUH7UzKW5ngRpn1wZJ9kkVZqgqw87CnWZAVGqheRT6zZeX8TZ6EHp8Av3JYILO
 4Fii3bguqdeaCl3BAhSKFswEML2qdj5Y3w4hOyneLBTuPvMVzlU114wIXcZ0mGDk5e
 gf3B5Xy5Qmokxtc5MLUabxeYhkK0FLTSlIw5LLWqZigNskWm+0VDTKKIfxZqILMSIP
 4KdvTLAsJ6AXc1K2AqEqHK8+lxo+wDcbpr4ODOtzQ/YL0NwiWqXsWKZ39Z0/R2O3tW
 Pcyj2vIgpo7AQ==
Message-ID: <sashiko-outbox-186067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbcon: Avoid cancel_delayed_work_sync() in atomic
 context
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027034716.588174-1-yyaqia@gmail.com>
References: <20261027034716.588174-1-yyaqia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 04:00:51 +0000
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
- [Medium] fbcon: race between fbcon_del_cursor_work() and dequeued fb_flas=
hcursor()
--

commit 7fd3c01c297e05df19b561b8622916f2e7e0e858
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Avoid cancel_delayed_work_sync() in atomic context

This commit switches fbcon_del_cursor_work() to use cancel_delayed_work() so
it can be called safely from atomic console printing contexts, while adding
fbcon_del_cursor_work_sync() for teardown in fbcon_release(). It also moves
the queue_delayed_work() call in fb_flashcursor() inside the console_lock
critical section.

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

In kernel/workqueue.c, process_one_work() clears WORK_STRUCT_PENDING_BIT via
set_work_pool_and_clear_pending() before invoking the work callback, and
fb_flashcursor() does not acquire console_lock until it calls
console_trylock():

CPU 0 (workqueue)                     CPU 1 (holding console_lock)
-----------------                     ----------------------------
process_one_work()
  set_work_pool_and_clear_pending()
  fb_flashcursor()
                                      fbcon_del_cursor_work(info)
                                        cancel_delayed_work(&par->cursor_wo=
rk)
                                          /* returns false, not pending */
                                      console_unlock()
    console_trylock() /* succeeds */
    ...
    par->bitops->cursor(...)
    queue_delayed_work(..., &par->cursor_work, ...)
    console_unlock()

Once fb_flashcursor() acquires console_lock in drivers/video/fbdev/core/fbc=
on.c,
it only checks:

	if (!vc || !con_is_visible(vc) ||
	    fbcon_info_from_console(vc->vc_num) !=3D info ||
	    vc->vc_deccm !=3D 1) {
		console_unlock();
		return;
	}

It does not check whether cursor blinking was stopped by:

- cursor_blink_store() setting fbcon_cursor_blink =3D false before calling
  fbcon_del_cursor_work(info)
- fbcon_cursor() seeing (vc->vc_cursor_type & CUR_SW) and calling
  fbcon_del_cursor_work(info)
- fbcon_blank() or fbcon_switch() stopping the cursor when blanking or
  switching to KD_GRAPHICS mode

Because cancel_delayed_work() does not wait for or disable an already-deque=
ued
work item and fbcon_del_cursor_work() records no state under console_lock,
wouldn't fb_flashcursor() draw the cursor and re-arm par->cursor_work
indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027034716.5881=
74-1-yyaqia@gmail.com?part=3D1
