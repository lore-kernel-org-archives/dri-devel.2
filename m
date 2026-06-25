Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2538CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3903B10F22E;
	Thu, 25 Jun 2026 10:25:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iJJMJrkT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C9410F22E
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D02760123
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3686F1F000E9;
 Thu, 25 Jun 2026 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782383143;
 bh=nwfhREsaeoMCVs34ExxN5XdHNIUIvpDO0RGXdUbaHkY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iJJMJrkTrhpWMalOjNkqBX2u9zCNQJNQ0Sdm/4OUgmMU7GW/k5ZYbO+i/ZLWC6jK/
 fZAag2B9gh87mOtoaU8y0QJjA/7Vupizylj+dqqIcTH7tqHazeS+F66JaKugywN2QI
 +BD/k0kGxw1nKGgsqj82nAP2f5yahBvtr/jERfqVMdVw2v2TmaoOmPtGxBLzxuPT63
 SOyEvd8rYBDXGiK52CknMK6bHwGHi2+9WnVg+tFgZzP5SGhRwvbc3JEmu1Z0kXhvEz
 GUgu/LgzqHLScXRvg9nytO2f9lj2Mo+qODPC8wzKuhbVbUIUPylvnQygYIKhgwngfU
 4lh+7hVyFnHMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 4/8] rust: page: convert to `Ownable`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260625-unique-ref-v18-4-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-4-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:25:42 +0000
Message-Id: <20260625102543.3686F1F000E9@smtp.kernel.org>
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

> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D4

