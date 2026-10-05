Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C00CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C5110ED2A;
	Mon,  5 Oct 2026 13:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XcIi7jK+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF1B10ED20
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD88460A64;
 Mon,  5 Oct 2026 13:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1E1F000FF;
 Mon,  5 Oct 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207613;
 bh=qxSkt2toSMrZ8nqbkOoynppQDZQIepmbKUSPVoEmZ2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XcIi7jK+Gv9MoPtP3NTHwUa8UlfYJKxITEgomKbtYi2LpjJhLrEdGX8m3KykkqvtN
 UwrU4AhQVLGVKCjfkWHNScTbOBSgB6ouWuFvlHEi4vr8FxnA4dhi/d9sIRqIclJC/k
 A8pY97zzyK0nJcAl2YgFBTpEQXDNcfiInCdJkklgMtmtcTIr7qUzq8MJD0C34c91WV
 iFcJsGmM3o6Rc5Jjexti4FA4lXi8Ht79V/dCpaP0GBxJWXvMDy3WrkzScgXXbl50bq
 AqNYVm7dBwzgWE6l14O15oYThPebmiSIfSXx2UxWCQcDJXFUThmEiC1tE8sUhBe5m+
 3rbPNDfqL6HTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] lib/fonts: Add font_glyph_cursor() helper
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261005133335.344302-5-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:40:13 +0000
Message-Id: <20261005134013.61F1E1F000FF@smtp.kernel.org>
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

> The new helper font_glyph_cursor() fills a glyph with a cursor pattern.
> As with the font_glyph_rotate_*() helpers, the caller has to provide the
> output memory.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D4

