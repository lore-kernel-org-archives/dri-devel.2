Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC33C88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9EC10E4B8;
	Sat, 12 Sep 2026 21:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="aEYJEbMV";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4948410E4B8
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789249764; x=1789854564; i=deller@gmx.de;
 bh=RJmn8M0PIaLPkKUq19qI3Z0tk/JrWUfPZEiUPI8X6Q0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aEYJEbMVvylCO+6Ynd+sXLFdjy0BhK7X8kDs7Un6oggOzLFN9w3/NpA2jZ16OvWi
 Ck3SzTGPgnPicPioUGpO11XLknsY5J6UDIFppvgYzLPBzfmteds5EIE/dDfLh/i6B
 4jbPWvke/fbwX/8mgALlMnLd5xDgNZCY92O7PHV398TO89QBur4FSO0ScKT9jEVDu
 OBjF87AVU31A3cZ1G/eKVSsZdVQNBis1qila8tUJ7D2ulxmtMWwt8z05c9+6Qb/Gz
 YNFWY8fAhrZR8/JhcsHtMrCza7GxBMuWzPUCwCQ79vokTnZ7kk7tbJkXvthCgXhH4
 hElQtBKZ/qtoBIf33Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1xJF5d2xVK-00UBI9; Sat, 12
 Sep 2026 23:49:23 +0200
Message-ID: <0c19c7f7-c0d9-41c7-8ef8-1daf5581b378@gmx.de>
Date: Sat, 12 Sep 2026 23:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: don't rebuild the mode list while the
 framebuffer is in use
To: Xiang Mei <xmei5@asu.edu>, bernie@plugable.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: gregkh@linuxfoundation.org, co+ed9902f2e44184d9@bugs.sh
References: <20260912211512.2049147-1-xmei5@asu.edu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260912211512.2049147-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tjw/VstX6lysF4NUIRegETpOMksGLZaokzhpYWPaw5n0f3XBsGA
 j/Sm4Wwo2n2GKB1iUzOgoTvX6LOhjFcs6JlZACJJa69TansFBQEdP98BIBElxOlwFDZG3h8
 6npprmedEzDLZcRhkMCpKiFhAW9AFantGLsRXeLH3lEUhPaPVgtC4iFBm3hffIA+gGoy4nP
 rodBldLqCu1N+E1wOvdkA==
UI-OutboundReport: notjunk:1;M01:P0:8knEx8cJqDQ=;NGIUf7yGsMzzX1ybuFN7w959DL1
 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
 /ldX45g+AIbQP
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/12/26 23:15, Xiang Mei wrote:
> dlfb_setup_modes() frees info->modelist with fb_destroy_modelist() and
> rebuilds it, but fbcon holds raw pointers into that list in
> fb_display[i].mode and nothing un-publishes them the way
> do_unregister_framebuffer() and store_modes() do with
> fbcon_delete_modelist(). The function does refuse to install a new mode
> while the framebuffer has users (dlfb->fb_count !=3D 0), but only after =
the
> list is already destroyed. Reached from the 0666 "edid" sysfs attribute,
> an unprivileged write to /sys/class/graphics/fb0/edid therefore fails wi=
th
> -EINVAL and still leaves every fb_display[i].mode dangling; the next
> console switch reads the freed fb_videomode in fb_videomode_to_var().
>=20
> Test fb_count before touching the list. fbcon takes a reference through
> fbcon_open(), so that condition covers exactly the states in which
> fb_display[] points into the list, and the errno returned to userspace i=
s
> unchanged.
>=20
>    BUG: KASAN: slab-use-after-free in fb_videomode_to_var (drivers/video=
/fbdev/core/modedb.c:905)
>    Read of size 4 at addr ffff8880107b449c by task kworker/1:1/47
>    Workqueue: events console_callback
>    Call Trace:
>     fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
>     display_to_var (drivers/video/fbdev/core/fbcon.c:998)
>     fbcon_switch (drivers/video/fbdev/core/fbcon.c:2182)
>     redraw_screen (drivers/tty/vt/vt.c:994)
>     complete_change_console (drivers/tty/vt/vt_ioctl.c:1141)
>     console_callback (drivers/tty/vt/vt.c:3358)
>     process_one_work (kernel/workqueue.c:3396)
>     worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
>     kthread (kernel/kthread.c:436)
>     ret_from_fork (arch/x86/kernel/process.c:158)
>     ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>    ...
>    The buggy address is located 28 bytes inside of
>     freed 96-byte region [ffff8880107b4480, ffff8880107b44e0)
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7d9485e2c53c ("Staging: udlfb: Add functions to expose sysfs metr=
ics and controls")
> Reported-by: co+ed9902f2e44184d9@bugs.sh
> Closes: https://lore.kernel.org/all/1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp=
%40bugs.sh/
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   drivers/video/fbdev/udlfb.c | 5 +++++
>   1 file changed, 5 insertions(+)

Looks good.
Applied.

Thanks!
Helge
