Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E641BC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3028B10E052;
	Fri, 28 Aug 2026 21:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h1vLKcB9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2698010E052
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:42:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DEE360216;
 Fri, 28 Aug 2026 21:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED281F000E9;
 Fri, 28 Aug 2026 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787953320;
 bh=oD3nkOqh4ywupTNOsqdrKkm7n+eP8YfB0T+MDYD9BYY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h1vLKcB9QIxMUwJbfQEp/56/AXu1RBw3mGJ6XRAJz1QEUy917fqo29KmlmGfO51v7
 dFFG4RXMiuTAWPP4hmUuWRhsQloQyd64MtcV9+GW0w4tAQhRAMCgXOmAfLICMAPHMT
 eQR1N7UKpCN/XO2xoU8jUbWnf0WllFhGLiiEKHqFs1lXQNdPGDvgJlSx4ws0vhn7ko
 wHADDk9yU6H5bXU1ZfH/Bjh6n6v4IxxVmZGdcCpmPtZkXo619YeLltwnXRAc5bClle
 wcjdbl4EIfLNUnzwYNRiu81+/nLFBloGEqAFuGpqZDOs8WFaCtvAzUKT0rSGkovmDM
 AR/aW29R7JwgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: fix double-free on mailbox channel stop
To: "Deniz Aydogan" <denizaydogan1902@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828212405.13124-1-denizaydogan1902@gmail.com>
References: <20260828212405.13124-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:42:00 +0000
Message-Id: <20260828214200.9ED281F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `xdna_mailbox_send_msg` by the DRM schedul=
er thread and the ioctl thread leads to hardware ring buffer corruption.
--

commit f00c302142d5de5c06245223cfbc1a367c1aef38
Author: Deniz Aydogan <denizaydogan1902@gmail.com>

accel/amdxdna: fix double-free on mailbox channel stop

This commit fixes a double-free issue when stopping a mailbox channel. The
previous implementation used two xarray iterators that could overlap and
release the same message twice. It replaces them with a single iterator to
ensure each message is freed exactly once.

> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdx=
dna/amdxdna_mailbox.c
> index cc8865f4e79c9..27161734753d0 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -556,9 +556,7 @@ void xdna_mailbox_stop_channel(struct mailbox_channel=
 *mb_chann)
>  	drain_workqueue(mb_chann->work_q);
> =20
>  	/* We can clean up and release resources */
> -	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_ms=
gid)
> -		mailbox_release_msg(mb_chann, mb_msg);
> -	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next=
_msgid - 1)
> +	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
>  		mailbox_release_msg(mb_chann, mb_msg);
>  	xa_destroy(&mb_chann->chan_xa);

[Severity: High]
This is a pre-existing issue, but while reviewing the mailbox channel code =
in
drivers/accel/amdxdna/amdxdna_mailbox.c, I noticed a potential data
corruption issue with concurrent messages.

Can concurrent execution of xdna_mailbox_send_msg() lead to hardware ring
buffer corruption?

The DRM scheduler thread can submit jobs without holding the device lock,
calling:
drivers/accel/amdxdna/aie2_message.c:aie2_execbuf() -> xdna_mailbox_send_ms=
g()

Concurrently, the ioctl thread can configure the same hardware context and
channel while holding the device lock, calling:
drivers/accel/amdxdna/aie2_message.c:aie2_config_cu() -> xdna_mailbox_send_=
msg()

Inside mailbox_send_msg() in drivers/accel/amdxdna/amdxdna_mailbox.c, the t=
ail
pointer is read locklessly:

    tail =3D mb_chann->x2i_tail;

And it is updated locklessly after the message is written:

    mailbox_set_tailptr(mb_chann, tail + mb_msg->pkg_size);

Since there is no common lock held between the DRM scheduler thread and the
ioctl thread for the mailbox channel, can they race to read the same tail
pointer, overwrite each other's messages in the ring buffer, and write
conflicting tail pointers to the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828212405.1312=
4-1-denizaydogan1902@gmail.com?part=3D1
