Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6829C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D223010F1F8;
	Tue, 15 Sep 2026 12:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="auiywy+H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A71E10F1F8
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:40:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 633C440E2D;
 Tue, 15 Sep 2026 12:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1195D1F000FF;
 Tue, 15 Sep 2026 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789476021;
 bh=9A/Pt1tNaOnKcBIM88Q53TNuiSpIVnWS86+FC12DOZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=auiywy+HFoPxprf95hwXKdbo9uyOmRvoHbQn4HtreZXCnnBTQg300xtHhMrmU7X35
 b9prrfQpcMo1DoYYRxGgQT4jFmW0AukalLVmPHyyLET9WFYRHQ3235XqEgc9MstFtx
 xe+glkr8I6uYN6UGBe7/zwr7gjobH6m1Cw5WDTVUi0qwRpn0LEJQnTAFcRFA75IX1q
 eexrGvPw4SVMwX6bbmLKeGnw1StAqrN0/QFT0f4lM9YMOqDZmkaROo/SV2yeTCgbpB
 Ma2yGaxS47bok1dcLEwdwHeScgMMc1qd350SW7N42OJTrXI7pHOju7krD0pC1/ujbT
 dYwFQJ+dlu9QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] lib/fonts: Add font_glyph_cursor() helper
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-5-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:40:20 +0000
Message-Id: <20260915124021.1195D1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D4

