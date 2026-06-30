Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FFC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA6A10EC61;
	Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hvfq7PnE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2304210EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36C5C600BB;
 Tue, 30 Jun 2026 12:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689FA1F00A3A;
 Tue, 30 Jun 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823208;
 bh=qbLIPEp1f0KioW0gXIhoeCj4r5zV7yz64AxIyvN8+H8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hvfq7PnEa8IplybTjdAE9V/LzWqzUOqJ4lxd5h/39S/QohFhvuWoW4vTpizRIBLnS
 2vGNtQeE0pJdFSCaFghjHZ9OKL+hBM/jJ7mucrIo4K2F99RSgnaSIn0gsRe8jj9bWb
 mCGIyBoZ5QNnLFQsW5w9ffQC6PF5T38FU1gZbiyOz30InkzAnaJSKMOYU1u1EeD2wv
 XKx5PwTIsUAeX6ezs8Yv6yhRlFW19LVfpXybXaSXT4SRyYcWKwKpOB6d7PnpeD+7d5
 1QiF6trENVWXi+hZjyzR3QUSjLArJFEpvegf6LcchtLo2+/qPUuzCPt0HyVIePxsgN
 +od1pPL7JXW+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] rust: driver: simplify
 `IdArray::new_without_index`
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 conor+dt@kernel.org, ojeda@kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260629-id_info-v2-2-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-2-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:08 +0000
Message-Id: <20260630124008.689FA1F00A3A@smtp.kernel.org>
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

> This method can very easily construct the `IdArray` on its own without
> delegating to `Self::build`. Doing so also simplifies the phy device table
> macro because it does not need to construct tuples anymore.
>=20
> This also allows simplification of `new` and `build` which removes the
> `unsafe`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D2

