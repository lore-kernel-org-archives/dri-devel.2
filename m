Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E19606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkJ7uyVs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791F010E529;
	Mon,  2 Nov 2026 07:41:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A6310E529
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7CF843C85;
 Mon,  2 Nov 2026 07:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2F51F00A1A;
 Mon,  2 Nov 2026 07:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793605266;
 bh=ukrPmVOAQ8DZOcVfZKaWrajjMps3VSh1wOgrDN0bF68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EkJ7uyVsIdiwzEEXR62sH2p440oF3fyK79zvTxoeS69yydN7n5vJxzubhVjB6ZL3j
 FxIrMRZAOZRXDzIjVDqP6Np4r+gT2LvugOi/A6heJpvIwcm+5nojeuyrM9NZaiSGjP
 4vKhWGdhLwPfDe5T+cp8QLtFcSTlS7j7uMXnqllBuMt6N8fZ8Z5n3/MeUUWhadNmWd
 ZKOpXT+PVdnVll3C7Ln7wNgpr92pXxtq2i3emxPn0t53T6mzLNCv9K/hX2Vx8J9+IX
 kMseN0p6Z9/k/vnEfBZR25ciQ6mpAIx6fE7bBfDqroK0lJTKs0qP5dNpEmBZrxXnl8
 BpJq8+HBp5LQg==
Message-ID: <sashiko-outbox-193036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: smscufx: bail out of ufx_set_vid_mode() when the
 device is gone
To: "YuanZhe Liu" <25031212351@stu.xidian.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102072120.3022-1-25031212351@stu.xidian.edu.cn>
References: <20261102072120.3022-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:41:06 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] fbdev: smscufx: unsynchronized usb_active check in ufx_set_vid=
_mode()
--

commit 3a768d75a894178fec634e82fca9f1ca2c1f5f21
Author: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

fbdev: smscufx: bail out of ufx_set_vid_mode() when the device is gone

This commit adds an atomic_read(&dev->usb_active) check at the start of
ufx_set_vid_mode() so that mode sets and blank requests return -ENODEV
after ufx_usb_disconnect() has cleared usb_active, avoiding control
transfers through a stale dev->udev pointer.

> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
> index 34d8abd5b3544..a199e6d03f06b 100644
> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -661,8 +661,12 @@ static int ufx_set_vid_mode(struct ufx_data *dev, st=
ruct fb_var_screeninfo *var)
>  	u32 temp;
>  	u16 h_total, h_active, h_blank_start, h_blank_end, h_sync_start, h_sync=
_end;
>  	u16 v_total, v_active, v_blank_start, v_blank_end, v_sync_start, v_sync=
_end;
> +	int status;
> +
> +	if (!atomic_read(&dev->usb_active))
> +		return -ENODEV;
> =20
> -	int status =3D ufx_reg_write(dev, 0x8028, 0);
> +	status =3D ufx_reg_write(dev, 0x8028, 0);

[Severity: Critical]
Can ufx_set_vid_mode() still race with ufx_usb_disconnect() and dereference
a freed dev->udev after passing this initial atomic_read(&dev->usb_active)
check?

Neither ufx_set_vid_mode() nor its callers (ufx_ops_set_par() and
ufx_ops_blank()) acquire disconnect_mutex, and ufx_usb_disconnect() does
not acquire info->lock. After passing the check at entry, ufx_set_vid_mode()
performs around 30 synchronous USB control transfers via ufx_reg_write()
and ufx_reg_read() across ufx_blank(), ufx_disable(), ufx_config_pix_clk(),
ufx_enable(), and ufx_unblank(), including two msleep(1) delays inside
ufx_config_pix_clk():

drivers/video/fbdev/smscufx.c:ufx_config_pix_clk() {
	...
	status =3D ufx_reg_clear_bits(dev, 0x7000, 0x00000005);
	check_warn_return(status,
		"error clearing PLL0 bypass bits in 0x7000");
	msleep(1);

	status =3D ufx_reg_clear_bits(dev, 0x7000, 0x0000000A);
	check_warn_return(status,
		"error clearing PLL1 bypass bits in 0x7000");
	msleep(1);
	...
}

When a userspace task invokes ufx_ops_set_par() or ufx_ops_blank() via
do_fb_ioctl() (FBIOPUT_VSCREENINFO or FBIOBLANK) on an open /dev/fbX file
descriptor, ufx_usb_disconnect() can run concurrently after
ufx_set_vid_mode() has already passed the usb_active check:

drivers/video/fbdev/smscufx.c:ufx_usb_disconnect() {
	...
	atomic_set(&dev->usb_active, 0);

	usb_set_intfdata(interface, NULL);

	/* if clients still have us open, will be freed on last close */
	if (dev->fb_count =3D=3D 0)
		ufx_free_framebuffer(dev);

	/* this function will wait for all in-flight urbs to complete */
	if (dev->urbs.count > 0)
		ufx_free_urb_list(dev);

	pr_debug("freeing ufx_data %p", dev);

	unregister_framebuffer(info);
	...
}

Here ufx_free_urb_list() only waits on dev->urbs.limit_sem for the
pre-allocated bulk URBs in dev->urbs, not for synchronous control URBs
allocated inside usb_control_msg() or for an in-flight ufx_set_vid_mode()
call. Moreover, when dev->fb_count > 0 and CONFIG_FRAMEBUFFER_CONSOLE is
disabled, unregister_framebuffer() does not take info->lock or
console_lock() and returns without waiting for the in-progress ioctl.

Because ufx_usb_probe() stores dev->udev =3D usbdev without taking a
reference via usb_get_dev(), ufx_usb_disconnect() can finish and allow the
USB core to release struct usb_device while ufx_set_vid_mode() is sleeping
in msleep(1) or between control transfers, causing subsequent
ufx_reg_write() and ufx_reg_read() calls to dereference a freed dev->udev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102072120.3022=
-1-25031212351@stu.xidian.edu.cn?part=3D1
