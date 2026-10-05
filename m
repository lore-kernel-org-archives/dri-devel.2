Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8343CCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72D510ED0E;
	Mon,  5 Oct 2026 13:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZBYeEWLe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A0210ED0E
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:39:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F15B60A75;
 Mon,  5 Oct 2026 13:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE601F00893;
 Mon,  5 Oct 2026 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207545;
 bh=/yfP0dlsjq/iF7eC9bG4u/aCL/iHecW5q4fRl0zB7AY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZBYeEWLeX2kP48tGD4iPlCsFbpMYXY8HsLAhkwaudqJa0qNm2lKG849X1+nYtJ96b
 MD3m3+5VRV+91D+OlGKt9eha/L5fRCiLPb5KiVqzspb6vGX3Sgjalri+vEtMtY0Y/m
 gmmrgmBYizp6bomhjlhJqarOB+yImnUgic4Jly8OGOsQ9L8zaDHda4uFwfb8JdhI9y
 bSM3FfaztoFj7PEI6zf34By7IzjcrHhxORjQ+6/KCIDmjVKrqEpY/JClbskz4WBIlu
 MGXwrM6E9YaEcn0tbTLkavX/12AazxZ7CJjZrQu5Oc+4qyC8pTy7UlJvcfKdCVUxmb
 X+frP0PhnFBKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] fbcon: Replace fbcon_fill_cursor_mask() with
 fbcon_cursor_glyph()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20261005133335.344302-6-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:39:05 +0000
Message-Id: <20261005133905.9FE601F00893@smtp.kernel.org>
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

> The kernel's font library provides font_glyph_cursor() to create cursor
> glyphs. Replace fbcon's fbcon_fill_cursor_mask() with a new helper that
> uses font_glyph_cursor().
>=20
> The cursor shapes remain mostly unchanged. The only exception is in
> underline cursors for fonts with a size larger than 10. The underlining
> dash is now one pixel closer to the font-glyph data, so that the cursor
> looks less detached. This follows the style used by vgacon.
>=20
> v4:
> - update for vc_cursor_valid_size()
> v2:
> - adapt to new VT interface
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D5

