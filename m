Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13044C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B59110EDCA;
	Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ARL/K0re";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF2810EDCA
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AF5643587;
 Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E1F1F000E9;
 Tue,  1 Sep 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281942;
 bh=D7LNZnzxQGCwBhlPIfy65AC+FYx8L0aZeDTvSsJLJMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ARL/K0relCLNyHZyPyPhoByK9YHJ0D3KjdoVup8u9PdTs7XcN49yz/Id3WqVb7MEY
 exoVNWeoAI1fzt0rJLirCph42hZNgg+BIgXGq1N6efmTDcO8LkXNRtDKGUhmVp1kYB
 IXpIRqPQT33CT2oNxkSXaqlqSXnjM3ecJoGsrF/NDb7aV7mlqYnT/ZshFSyIaAjSBi
 70tJOVjY8h9l4JqVB04Vg8Sy1ecxYjrBVSBOfLD8M9/+J2xiFoXZeeO/uyXB4HS94b
 +XMyc4J+9Z45GJfJVy6UDcpKJHO/GSM08YSE8ssV7oUXBVOQW1pHsgknjGVcLlB4GB
 UuE8ecM+vqh1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/16] rust: io: support register projections
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-typed_register-v4-5-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-5-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:01 +0000
Message-Id: <20260901165901.B9E1F1F000E9@smtp.kernel.org>
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

> `IoLoc`s themselves just describe a projection from a region to a concrete
> register. Thus, support it in `io_project` macro too. Also, update methods
> that operate on `IoLoc` to use I/O projection.
>=20
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D5

