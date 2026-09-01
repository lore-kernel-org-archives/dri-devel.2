Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BAC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567ED10EDA7;
	Tue,  1 Sep 2026 16:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ImNtKedZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4617C10EDA7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:56:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EC2041AB9;
 Tue,  1 Sep 2026 16:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D781F000E9;
 Tue,  1 Sep 2026 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281810;
 bh=i+hC59F/gkOdcy0T83rPtC4oxmdeqJwoY6Tt6VtMYKg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ImNtKedZdUXGf1m1uvIletHP6AVtL31SJMZq30ImuRnduEjKZmxTOhLNA/gbI3A8f
 SASfb0KBvjCZqx6mKeigrjAUMmlAbsv8D+rYqMQOpyJPN4Ue2Ibm7Bc9zGNegReoIG
 e/lmCpbR/FeaNol47/q22zWyvB7vss92bBLRS2PriZvL7dOxv0u3z/sHd5ZI7ShhZH
 dR5yjH/YCdz7WjknBLKnTyS/zF75snFAgoAC9XBfJua9txnPyIC56+Ir+05ztnWKt3
 utqVMj3sNngbjGDbChKdftDgeYDbqOTwdHHKTGElSPjqgyiFT4AmMpL2pz6JMJVTf9
 WS3diwCc+1uRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/16] rust: io: register: reimplement as proc macro
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:49 +0000
Message-Id: <20260901165649.B2D781F000E9@smtp.kernel.org>
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

> The existing `register!` macro is implemented as a declarative macro.
> Reimplement it as proc macro instead, with no functional changes intended.
>=20
> The old implementation produces unhelpful diagnostics when things go wron=
g.
> For example, for code like
>=20
>     register! {
>         pub(crate) TESTREG(u32) {
>             31:0    data;
>         }
>     }
>=20
> which misses out the "@ offset" part of the specification, and the
> following error is produced:
>=20
> [ ... ]
>=20
> possible; declarative macro will reject this as `@` is not in the
> follow-set of "ty" metavariable kind.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D1

