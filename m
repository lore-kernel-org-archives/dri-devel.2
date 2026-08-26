Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00CFC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D0510EC49;
	Wed, 26 Aug 2026 08:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VbpJBZE7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A0710EC49
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:39:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6742E60A5C;
 Wed, 26 Aug 2026 08:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19E51F000E9;
 Wed, 26 Aug 2026 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787733572;
 bh=UxJK8+Foae8ykARXQOFz3KahwcHGmojp5cshlNT0Qu0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VbpJBZE7DKZAIC52tGQC4cnNFKpER/dx0pFeyxjkoaxs67k7qjMTLJA0d1chIBgBq
 4NT3vIXJo3OGF0zyahqLrfC5CZZNoI9sB+zc7X/4S6X+c8w1vOk361TlwQEXqNVwYf
 CZJmXUDyJH4zbFewCTL9sYAxT8UXNNkjX1whuz9pSnRzkCFaF1PU9vWR6bcSqB7ZaM
 2+IB6X0kYChD/eEfwryNMlagHADQ3mddQ7m0d/7/OxzaugODGBCrmGLfTi1+MkoXCs
 pnl42ZvwLBzHVCDfGOBSHI96jO2JMjg8bohs0YD8cOGVqzirQ6ukL2Itrc5Nf6VVEg
 6cVXvUqJSxJUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] treewide: fix spelling of "overridden"
To: "Linlin Yang" <yanglinlin@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
 linux-hwmon@vger.kernel.org
In-Reply-To: <20260826083715.625136-1-yanglinlin@kylinos.cn>
References: <20260826083715.625136-1-yanglinlin@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 08:39:31 +0000
Message-Id: <20260826083931.D19E51F000E9@smtp.kernel.org>
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

> Fix misspelling of "overridden" (missing a 'd') in comments across
> multiple drivers.  The correct spelling "overridden" is already used
> 292 times in the same drivers/ directory.
>=20
> All occurrences are in comments only, no functional change.
>=20
> Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826083715.6251=
36-1-yanglinlin@kylinos.cn?part=3D1

