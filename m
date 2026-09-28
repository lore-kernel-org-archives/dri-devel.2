Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8469FC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB22910E88C;
	Mon, 28 Sep 2026 09:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSXQCfo3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2C910E914
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:16:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E582260120;
 Mon, 28 Sep 2026 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FD81F000FF;
 Mon, 28 Sep 2026 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790586961;
 bh=rnIk87VMHpiqbOwxetxCmMRk3S+iSynMmUNSvpU/uLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QSXQCfo3KD2kmiQnGro8Ittn2TIfPeNsMGvNIFQhtdz+5gQOD7LmLMUPEqS+4nO08
 liD7s5UjqpQpD29KKB3ZoNxt0GGFI2vlBKp1qb10LP/VRfqMh9Cp1krKxrHsCRotcH
 wDMoQTeqYajAxGQsynTu/spmWLRhWk03z1cQx3cuIW1+1rJ3qRiBwoCyqyudLHoCNf
 86EvMWM3HD+wLuGhLqhBSIP4IgJ/5SJRz/CuFtFJh/pd7PTJ2twQV2Fa9fL1YeC7sK
 YyLTXvg1m1sA914fZvwV+ADXOe4vucDmMyKCzX9hbewMJ7yg0+4a02p3qqosPNb1Rx
 XIiW2LXe4Nr2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] lib/fonts: Add font_glyph_cursor() helper
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260928085724.41660-5-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:16:00 +0000
Message-Id: <20260928091601.67FD81F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D4

