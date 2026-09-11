Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33A4C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A517C10E32B;
	Fri, 11 Sep 2026 09:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RWoH0qGg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DBD10E32B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:46:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB1F7601EF;
 Fri, 11 Sep 2026 09:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394521F000FF;
 Fri, 11 Sep 2026 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789120010;
 bh=0uyAjL+n/B5xkxFrjnWVY/7ig2tPXTs4hqw0V18ZP/0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RWoH0qGgc8F1a2Y5nE8MxUStp6K1tOKG9nWdU92Rq9YK4YYnSn4r/vJmbMNyQ+5SH
 AsY8AfGoX/EO+8XWPFOLclSNrutokY/D4i6FA1LC4sbxYX9Wa2gKgQmX1ftN7bYu3m
 aFedDVxnIR5BSDGPY63S758VtkSGB3MRm/LEfmrWJzKjialKw5fLr3PDPlPYNbmFbV
 0lZfPeGSuf40DNzfRlziRMlBzEskwcpo/MnUQ7+VUpxSzra3uyO/mrmeTjJySZ1jnT
 OQUENvIfOjBQJUE1gc/qVPV6NEkjxdiIL8p2SAW5i1hyJNn+cKi+zOwjF93TTPWLFb
 GQsxM5G0xqrEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] vgacon: Remove trailing whitespaces
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911094518.78093-3-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:46:49 +0000
Message-Id: <20260911094650.394521F000FF@smtp.kernel.org>
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

> Fix coding style.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D2

