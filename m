Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3405C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F066710EF38;
	Wed,  5 Aug 2026 16:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NEONJF6S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE97310EF38
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:41:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD92B60A5A;
 Wed,  5 Aug 2026 16:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5EA1F00A3A;
 Wed,  5 Aug 2026 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948108;
 bh=yFp5WNzl2/dKTZxUV7aGN8xz2+UL0u25qQ9ptHT17GA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NEONJF6SVrcgHyYM+5lDHQIOcg3Qyu8/X9mQ7JHPjxtpWXklJoR6sXDdNrWae+AUi
 3IYatbHAbIfxlB39ZxiNV7aSA8tIBWvvr/IUddwU1HVFKZ5h2peeEUZc0HPVQQLqbC
 g8CuXKqW5G9/s49UVpgkK6zwwHEo5rWREQelrw2KJ1//Dbb55Aw5+UDEJ39MWDaVe6
 5o/AWz41mT7yMkzrf9mXDHAD5g/RFm5Xmo3mEbjdH2xRXmgfYS+2Lp9RnkUb+IN2QH
 UHBPRHmsdE5ruRkkNPhzVCzEhKH1yo6IV2fngGyUocPWpQsNQyyBRuTn7u1D9V+10N
 8nVuv+tNtT28A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/16] samples: rust: pci: specify base type for
 registers
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-9-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-9-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:41:47 +0000
Message-Id: <20260805164148.2C5EA1F00A3A@smtp.kernel.org>
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

> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D9

