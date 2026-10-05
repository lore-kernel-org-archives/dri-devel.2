Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2267CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1005110ED10;
	Mon,  5 Oct 2026 13:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XLGHq2LX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D155B10ED10
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:39:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87F1D42D7E;
 Mon,  5 Oct 2026 13:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C8D1F000FF;
 Mon,  5 Oct 2026 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207551;
 bh=nUIc+37affsky57nZc3dwmQYZNxio4Szojhmgj4S1mk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XLGHq2LXDVAsojGEFZ4CUi8YJ0Fa3DHpptM0kMsr4/yiVAg6FHgra/ZVshW5Z9i0k
 4g2cjvQU4JhLnLa1PRiIQVWaC0lfykTj/6Tob4ekElaAJ3+DorfYq5QrfeOdez2itu
 tA3r+H7Lbjp7qx86Q6Yc17Nm2Fy4kDWF6g706zq9LZEKY9ohdVMj6Q+pINQsJ+HwFr
 /5dnR1d2lzezf4Ph7tRtzXEKm+72KM+UgDshmOawn66XD54tAp0MiD+d5pjNOQoINp
 b3NURM0HkYCibupzc2yYfr4KKAFrnfoORRfuZ9nJKRL/CTW05etCRT5PnyfSJnh0te
 jbtBycjhsjPYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] vt: Add cursor-size helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261005133335.344302-2-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:39:10 +0000
Message-Id: <20261005133911.41C8D1F000FF@smtp.kernel.org>
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

> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware.
>=20
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
>=20
> Users control the cursor size with the vt module's parameter cur_default
> or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
> case of an invalid setting, the new helpers fall back to cur_default and
> then underline cursors; in this order.
> [ ... ]
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D1

