Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5B606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKmqL2a0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0510710EF93;
	Mon, 26 Oct 2026 15:25:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7852210EF8B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:24:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E2764091F;
 Mon, 26 Oct 2026 15:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5DB1F01825;
 Mon, 26 Oct 2026 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793028294;
 bh=ZE8szWsQmnbHxdEtK5XCjl8lo6q8ldHbAIM3oGikHXk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kKmqL2a05iET41XbSDRoF/dMlJT1GaTB3fgyzSgRWGAU5ou+G3cOpXK99Xzt93Oxj
 o8UAT8HDnPTTxQsdffw6ckx3jVxM9d0npalEL25wrtrFikyCDLz+pwMgjDsSgw0zqZ
 S6GF3k10W6m6i5u1dSdC/Xxv44bLmvcYWXRc/yA59mlp1IGVnLYoXZpt3Fxa7uJ1E0
 blZoF2U3WJ2OYyX/wmSsMPOVBMdGETsMI+mO6OhLajiAaOqIC+9HwyWyoFeWeUS6EC
 GLH9m5/IhsqUaCDVCVg+3VvMfxT4D7MVy5ObZAN1V4Zci7aQR3MPuCcaE/oONOpuzU
 jNbrIhGl9lBeg==
Message-ID: <sashiko-outbox-185435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbcon: Avoid cancel_delayed_work_sync() in atomic context
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026145916.414396-1-yyaqia@gmail.com>
References: <20261026145916.414396-1-yyaqia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:24:54 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] fbcon: fbcon_del_cursor_work() still sleeps in atomic context on P=
REEMPT_RT
- [Medium] fbcon: fb_flashcursor() re-queues cursor_work after cancel_delay=
ed_work()
--

commit 81badb044cb0837eebe19d72924931a878fcf8e9
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Avoid cancel_delayed_work_sync() in atomic context

This commit updates fbcon_del_cursor_work() to use cancel_delayed_work()
instead of cancel_delayed_work_sync() when in_interrupt() or irqs_disabled()
is true, avoiding sleeping when fbcon_cursor() is called from the console
printing path with interrupts disabled.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 7720dfc80c165..14611be17cb19 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c

[ ... ]

> @@ -441,7 +444,14 @@ static void fbcon_del_cursor_work(struct fb_info *in=
fo)
>  {
>  	struct fbcon_par *par =3D info->fbcon_par;
> =20
> -	cancel_delayed_work_sync(&par->cursor_work);
> +	/*
> +	 * fbcon_cursor() can be reached from the console printing path with=20
> +	 * interrupts disabled. Only synchronize when sleeping is allowed.
> +	 */
> +	if (in_interrupt() || irqs_disabled())
> +		cancel_delayed_work(&par->cursor_work);
> +	else
> +		cancel_delayed_work_sync(&par->cursor_work);
>  }

[Severity: High]
Can fbcon_del_cursor_work() still call cancel_delayed_work_sync() from an
atomic context when hardware interrupts are enabled?

On CONFIG_PREEMPT_RT, force_legacy_kthread() is true, so
console_emit_next_record() invokes con->write() (vt_console_print()) in task
context without disabling interrupts:

kernel/printk/printk.c:console_emit_next_record() {
    ...
	if (force_legacy_kthread() && !panic_in_progress()) {
		con->write(con, outbuf, pmsg.outbuf_len);
		con->seq =3D pmsg.seq + 1;
	}
    ...
}

Inside vt_console_print(), spin_trylock(&printing_lock) calls
__rt_spin_trylock(), which acquires printing_lock (an LD_WAIT_CONFIG lock),
enters rcu_read_lock(), and calls migrate_disable() while leaving hardware
interrupts enabled:

drivers/tty/vt/vt.c:vt_console_print() {
    ...
	if (!spin_trylock(&printing_lock))
		return;
    ...
	if (con_is_fg(vc))
		hide_cursor(vc);
    ...
}

When vc->vc_cursor_type & CUR_SW is set, hide_cursor(), lf() -> con_scroll(=
) ->
fbcon_scroll(), and set_cursor() call into fbcon_cursor() ->
fbcon_del_cursor_work(). Because both in_interrupt() and irqs_disabled() are
false, fbcon_del_cursor_work() still calls cancel_delayed_work_sync() ->
__cancel_work_sync() while holding printing_lock and rcu_read_lock().

Similarly, in_interrupt() is marked deprecated in include/linux/preempt.h a=
nd
only checks irq_count(), so it does not detect preempt_disable(), spin_lock=
(),
or rcu_read_lock() critical sections (for example during an oops via
bust_spinlocks(0) -> console_unblank() -> do_unblank_screen() ->
fbcon_cursor()).

Since fbcon_cursor() only stops cursor blinking and does not free par, while
teardown paths such as fbcon_release() and fbcon_deinit() need synchronous
draining, should fbcon_cursor() use a non-synchronizing cancel directly ins=
tead
of checking in_interrupt() || irqs_disabled()?

[Severity: Medium]
Also, when fbcon_del_cursor_work() uses cancel_delayed_work() instead of
cancel_delayed_work_sync(), can an in-flight fb_flashcursor() work item
immediately re-arm par->cursor_work after it was canceled?

In fb_flashcursor(), queue_delayed_work() is called outside console_lock and
without checking whether CUR_SW is set or whether the work was canceled:

drivers/video/fbdev/core/fbcon.c:fb_flashcursor() {
    ...
	par->bitops->cursor(vc, info, enable,
			    get_fg_color(vc, info, c),
			    get_bg_color(vc, info, c));
	console_unlock();

	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
			   par->cur_blink_jiffies);
}

If par->cursor_work was armed (for instance via fbcon_startup(),
fbcon_switch(), fbcon_unblank(), cursor_blink_store(), or when switching to
CUR_SW with CUR_NONE) and fb_flashcursor() is running, vt_console_print() ->
hide_cursor() / set_cursor() -> fbcon_cursor() -> fbcon_del_cursor_work() c=
an
run during or right after fb_flashcursor()'s console_unlock() call.

Because cancel_delayed_work() does not wait for the running fb_flashcursor()
callback to finish, fb_flashcursor() will proceed to queue_delayed_work() a=
nd
re-arm par->cursor_work indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026145916.4143=
96-1-yyaqia@gmail.com?part=3D1
