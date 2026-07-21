Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F272C44520
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6789010E26E;
	Tue, 21 Jul 2026 02:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kxNxMw6a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E9F10E26E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 02:41:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77E7043C58;
 Tue, 21 Jul 2026 02:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEE71F000E9;
 Tue, 21 Jul 2026 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784601707;
 bh=327Yo6TOBFmgqoiGe+drydOj8lDGW5cMGRmO/yV3J8w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kxNxMw6ajXDB8ScSXTXirqZH3+Uaocx+LnmCB/sjOkCGX2ISV9T3o2YMT6aWJrlo8
 tcyMQvL4NOVLYI6iHPTtKbkZty2sXcKd8lzZcTkNkTq99/jmfTS6oTuvYNug6/D0sp
 c2pP4cwxLC2mgp6nwGBirXGkZH0FyKg8+k9IYRhgSKxJBNeFp+mSwuQkd49vuH6BX2
 8f0V7zhTKsERx33NCFq4a8kZqwLEns+nzdoEHi3JsCPuKe12ZwWRSkETzZc7NuaWFQ
 f4zOip2fYSudHNJHWdgUEH3jtTTifbfR6zZMm4kJLzXkEPkW74hXfcJTj0Nh+3UWGV
 hArRnhITF+G/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/bridge: it6505: cancel outstanding work
 before teardown in remove()
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <91b40322b07b967fcf286b3e4bd11e5f821bff1c.1784600387.git.daniel@makrotopia.org>
References: <cover.1784600387.git.daniel@makrotopia.org>
 <91b40322b07b967fcf286b3e4bd11e5f821bff1c.1784600387.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:41:46 +0000
Message-Id: <20260721024147.2FEE71F000E9@smtp.kernel.org>
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
- [Medium] Calling cancel_work_sync() on the potentially uninitialized extc=
on_wq triggers a WARN_ON(!work->func) kernel splat.

Pre-existing issues:
- [High] Canceling work items without first disabling their scheduling sour=
ces (IRQ and extcon notifier) leaves a race window where works can be reque=
ued, leading to a use-after-free.
--

--- Patch [1]: [PATCH v3 1/4] drm/bridge: it6505: cancel outstanding work b=
efore teardown in remove() ---
commit 06b35e4209da852ce0af8e4b1dd2aec2e9e172b4
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: cancel outstanding work before teardown in remove()

This commit adds calls to cancel_work_sync() and cancel_delayed_work_sync()
in it6505_i2c_remove() to ensure background works do not dereference freed
memory after the device is unbound. It notes that extcon_wq might not be
initialized, but claims a zero-allocated work_struct is safe to cancel.

> cancel_work_sync() on extcon_wq is safe even
> when it was never INIT_WORK()'d, since it6505 is zero-allocated and a
> zeroed work_struct is reported as not pending.

[Severity: Medium]
Is this description accurate?

Looking at __flush_work() in kernel/workqueue.c, the workqueue core asserts
WARN_ON(!work->func) when flushing a work item. If the DRM bridge was never
attached, extcon_wq remains zero-allocated.

During module removal, calling cancel_work_sync(&it6505->extcon_wq) will
unconditionally call __flush_work(work, true), which immediately triggers
the WARN_ON because the work function is NULL. On systems with panic_on_war=
n,
this leads to a kernel panic.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 8ecb43611dba8..2f349aefb7054 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3644,6 +3644,10 @@ static void it6505_i2c_remove(struct i2c_client *c=
lient)
>  {
>  	struct it6505 *it6505 =3D i2c_get_clientdata(client);
> =20
> +	cancel_work_sync(&it6505->link_works);
> +	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
> +	cancel_delayed_work_sync(&it6505->hdcp_work);
> +	cancel_work_sync(&it6505->extcon_wq);

[Severity: High]
This is a pre-existing issue, but does this leave a race window where these
work items could be requeued?

The driver uses devres for the IRQ and extcon notifier, which remain active
during these cancel_work_sync() calls. Furthermore, the hardware interrupt
is disabled after the works are cancelled.

If we look further down in it6505_i2c_remove():

	...
	drm_bridge_remove(&it6505->bridge);
	drm_dp_aux_unregister(&it6505->aux);
	it6505_debugfs_remove(it6505);
	it6505_poweroff(it6505);
	...

The interrupt is only disabled inside it6505_poweroff(it6505). If an
interrupt or extcon event fires immediately after the work is cancelled but
before it6505_poweroff() and devres cleanup, won't the handler run and
re-queue the work via schedule_work()?

This could lead to a use-after-free when devres frees the it6505 structure
while the re-queued work is still pending.

>  	drm_bridge_remove(&it6505->bridge);
>  	drm_dp_aux_unregister(&it6505->aux);
>  	it6505_debugfs_remove(it6505);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784600387.gi=
t.daniel@makrotopia.org?part=3D1
