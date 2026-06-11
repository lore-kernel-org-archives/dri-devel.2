Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD7CD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBD210E82D;
	Thu, 11 Jun 2026 18:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KLECK6Qa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D1510E82D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:00:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0457F438C0;
 Thu, 11 Jun 2026 18:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960851F00893;
 Thu, 11 Jun 2026 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781200850;
 bh=ycquyeVXr6bgIZr16uD8WlkI/eKF+zRgsiLiiWFk/vA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KLECK6QaPOWRjSm/O61FxDmvTmKYKbOH69a2wgHU96DcOtE29sWYvBtCbJ2U6CYJs
 HoxQqPXdFz3fIRHx4oLq6dzygkMhvBfvyVLTphVrMjTOubZPJNRHL4SU8S3Rr8Rk7d
 zAsxf0hhPWrezKKHXd3W9mMIHiVuoasjUAcCVt8pmEGCpu9UDUxO8T3yY+ZcC3WKz3
 Hd6yByFG0c2nQbloaD3xtXLvvo3e7JGhFrkhhDjwklmCEt+ihdHUJH5VdYnFsRshKx
 aTj5drYvKdvx4gwfDQqUbq6RNlHP2IzZMoJDD79HZsHnhTrNo7gF3nZLhv58dGS4Mn
 NSmwEYB72qQPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/20] rust: io: move `Io` methods to extension trait
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260611-io_projection-v4-11-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-11-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:00:50 +0000
Message-Id: <20260611180050.960851F00893@smtp.kernel.org>
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

> `Io` trait now has a single required methods with many more provided
> methods. Provided methods may want to rely on their implementations to not
> be arbitrarily overridden by implementers for correctness or soundness.
>=20
> Thus, extract these methods to a new trait and provide a blanket
> implementation. This pattern is used extensively in userspace Rust
> libraries e.g. `tokio` where `AsyncRead` has minimum methods and
> `AsyncReadExt` is what users mostly interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> A `size` method is added as an example of methods that users should not
> override.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D11

