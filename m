Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ADFC624CE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44D910E382;
	Tue,  1 Sep 2026 12:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S95syg64";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB69F10E382
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:08:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7BBF6013A;
 Tue,  1 Sep 2026 12:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD911F000E9;
 Tue,  1 Sep 2026 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788264500;
 bh=Llg7QcWIPgTplFLORBBn891bkqDtu0qDH1wLGHRh6VE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S95syg64r3H2sMTirmlbobhOQbI3y078WeGpQ8ZZEjp1seWowlIH8ESSRDw/3UDk+
 ZXacVWY5fs7ZxaisPzPEs+0anhTvWTMT4vqsvkW0MT4uj96yD5OKzaZQMkwqfsXHCh
 e1SRbKgBmucM7N2PMj9KvW3cOmAoJPXFiOv5UxkQ2rPrWOScU4DpAYJalYz4BYRXhz
 1aeLnm/MWub3P6pm9bCUm43AUqWD0wg2mc6+c7MvlUd/DjAi6cq8tc3Np9aNv9SvbS
 XkasucQhJ7mwYTAflfUhMV4bZLgGnAZQ8ipVr0VDlNat83TdNetk5Ny6JO8+TkU/Dj
 bP4vT3a57RVyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 2/2] drm/tiny: sharp-memory: avoid transmitting
 stale TX buffer data
To: "Tobias Johansson" <tobias.johansson@axis.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-flickering-v1-2-eaf7bbf9c000@axis.com>
References: <20260901-flickering-v1-0-eaf7bbf9c000@axis.com>
 <20260901-flickering-v1-2-eaf7bbf9c000@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 12:08:19 +0000
Message-Id: <20260901120820.5AD911F000E9@smtp.kernel.org>
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
- [High] Missing error check for kthread_run() and failure to stop kthread =
on probe error paths leads to crashes and Use-After-Free.
--

commit 2cf47adb5e86fa285b44ad0bec11eb5287e32f73
Author: Tobias Johansson <tobias.johansson@axis.com>

drm/tiny: sharp-memory: avoid transmitting stale TX buffer data

When only a subset of lines is dirty, the TX buffer sent to the panel conta=
ins
stale line data from previous updates, resulting in visible flickering. This
commit fixes sharp_memory_update_display() to transmit only the buffer
entries populated by the current update.

> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/s=
harp-memory.c
> index 595926ed660e5..e7521fc6a0104 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
[ ... ]

This isn't a bug introduced by this patch, but I noticed a pre-existing
issue in sharp_memory_probe():

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe() {
    ...
		smd->sw_vcom_signal =3D kthread_run(sharp_memory_sw_vcom_signal_thread,
						  smd, "sw_vcom_signal");
    ...
	ret =3D drm_dev_register(drm, 0);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
    ...
}

[Severity: High]
Can this lead to a use-after-free if the probe function fails?

If drm_dev_register() fails, the function returns an error without stopping
the running kthread. Devres automatically frees the smd structure, but the
kthread continues executing and may access freed memory.

Additionally, if kthread_run() fails, an ERR_PTR is stored. Will this ERR_P=
TR
be dereferenced by kthread_stop() during module removal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-flickering=
-v1-0-eaf7bbf9c000@axis.com?part=3D2
