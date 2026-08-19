Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F8C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E116B10EDF4;
	Wed, 19 Aug 2026 11:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbIvVgYs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97BE010EDF0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:18:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D3E4400BF;
 Wed, 19 Aug 2026 11:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2123A1F000E9;
 Wed, 19 Aug 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138302;
 bh=FYzAx3q1HTOKJoYBfb7xnuKvqbSKOS59WcJe5qPWUrs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fbIvVgYsaaAXFkJVkNck0HMMApPMsObNrrB/ATfTguqlyHsF9/LCeR1puSJxu5PhK
 R8c2d0Ef4L/Bw0de4Xshi/e5oBRUsI7sHEwKv9CMWmBwA8WTsvSiKUBsoWwhPb3gj5
 m6FQzsmYJw2IaqQ7F3pI5ETzE8HxmCXyJ1YRkSfH4Q9n95NXhxNHQwCIEFsls2T1l3
 u45zmpjTjTHvu1SvUyEMgQaXlWFIU7AbguyKb1lDlL8yq6e1+tlAbZKprvPPM2+xii
 68RYmmC6cj+HvANg3jrLOBp1bZ/HRLW0E+kobkSJsLopzr5/5CIeOLk8m5sDbxck61
 aAVcXRVzNFOYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/16] rust: io: register: make register have a typed
 base
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:18:21 +0000
Message-Id: <20260819111822.2123A1F000E9@smtp.kernel.org>
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

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Also, add an `io_project!` example which is enabled by this change.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D10

