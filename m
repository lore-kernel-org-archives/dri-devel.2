Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4EECA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD0910E595;
	Mon,  5 Oct 2026 13:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ozfvfL87";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C8810E595
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:38:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF81460A64;
 Mon,  5 Oct 2026 13:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D61F000FF;
 Mon,  5 Oct 2026 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207534;
 bh=Vo5+jA11ELJ9v10uKkjpaHTklzrf0pHu/DD5BUfuEUM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ozfvfL870lPTMDwc+n4puO441HKZmPpzxf13eCuxzlgy/23LOMIcMuyaSYjPTJBlS
 GVUTgyGTOxUmGghriACgPGa/Cws2TbuzkVYgFnTXX2/2QDiNvfJyoh21HYm5XCJkax
 Qgk61tdlLA/IGo2MNdYhRYv6CxpPJl7Hw6j+m6arx1vPWJj1y4z6VxgQnb4vM/2oiT
 f9ZNXCQK2z+ZmcveWEiA63xl0xNxu4GXDBhtJ5X2pgVcVGgkitzrwFyBq0gelRP/P9
 9l7gyc7HJPYoNLp3DptWej/N59/aw0t0S8ja24OcjRdAsMmy8JgHQ9Ovyk1o8spvnR
 QWDgyvvuAkOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] vgacon: Use vt_cursor_{start,end}()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261005133335.344302-4-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:38:54 +0000
Message-Id: <20261005133854.6B3D61F000FF@smtp.kernel.org>
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

> Replace vgacon's custom cursor metrics with the shared helpers
> vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
> function returns the index of the scanline below the cursor, while
> VGA hardware expects the cursor's final scanline. Hence vgacon
> subtracts 1 from the end value.
>=20
> The cursor shapes remain mostly unchanged, except that non-underline
> cursors now also use the glyph's top-most and bottom-most scanline.
> This follows the style used by fbcon.
>=20
> v4:
> - disable if CUR_DEF maps to CUR_NONE
> v2:
> - restore use of vc_cell_height (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D3

