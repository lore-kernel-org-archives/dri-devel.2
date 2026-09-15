Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2FCC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7474D10E243;
	Tue, 15 Sep 2026 12:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OCPuzT+x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745F310E243
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:40:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1DF9602A8;
 Tue, 15 Sep 2026 12:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA611F000FF;
 Tue, 15 Sep 2026 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789476015;
 bh=R0CkVzHy1zDNnuSbzEVvhJ9r9+u1n/AcXLLJBx3kR10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OCPuzT+xDttPPVzAhPzCFPhmZp8klBZpEWoH271EZOOwWY+zhUnplkBuzzr5xAqDl
 HuLToXA66XN8l5erRWA2cG2tiKLipcz36q1fX3CNnDP3N4bbFaARN48U9nMRcU4KOn
 K1SvrK3jiCMTimAHQ4//J1wG/QnKnzCTG95cJ9Lzq7TK7wE+gfPCbXR7+0V9MXS1p/
 4beNBeN+64YA53ztFsDVubaOvnSD2gJPpbtDk0mwlkrDkPfNpAwwUndhI4o0Y6vAy9
 lv2TTe/v8R3cUifAESPmGh7zNWRq+k48vLMDyTgjK7WUrXxGAHZgFekYPPFXqBXWyU
 n71SSnBrikxBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] vt: Add cursor-size helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-2-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:40:14 +0000
Message-Id: <20260915124015.5CA611F000FF@smtp.kernel.org>
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
> ends. This is compatible with VGA hardware
>=20
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
>=20
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. The new helper fall back to cur_default and
> then underline cursors; in this order.
>=20
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D1

