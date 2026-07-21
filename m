Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E449C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0A010EAC3;
	Tue, 21 Jul 2026 16:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NrYxLE93";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A2A510E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:59:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60FE2600D8;
 Tue, 21 Jul 2026 16:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD33D1F000E9;
 Tue, 21 Jul 2026 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653176;
 bh=WJUS7PUh6rougI4oL7CS6wKyDqtM7/jvvxuBpuoCyKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NrYxLE93IaHik+vMvF43ES/Y1sSwthXOn1BW4A16AwPTuVd+rpmslVC9ECbHamDWL
 QPtE8TYJQi1qU1+uaXNg9yVv2dEszPnKmncQcg7fmXRLK+aS5SbZuvo8VmrBHx4H6h
 xoWnBnYN/RPucz56826FpZyarLqppQlVwH51Lj0fukiXwjWtGX796a2eZ2C1Vwx2oi
 eWLbdmyIYH3QgfuTpEZTe4M8/mjGgSkK7NqtiJkPxke/XANyQhRew0oYR5+h6mJj6q
 E7qGkbYdj+OK8k3meKJ01L9/4XZW/MhgW8ZVaT703/C541NuUZ2Wyo0v3aq/Sxv9Eb
 WjiSNI2uGUigg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] gpu: nova-core: specify base type for registers
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:59:35 +0000
Message-Id: <20260721165935.CD33D1F000E9@smtp.kernel.org>
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

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D2

