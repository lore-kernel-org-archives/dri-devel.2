Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F20C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDD410F5D5;
	Fri, 26 Jun 2026 15:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/8/quWI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4363510F5D5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:00:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 079C742D8B;
 Fri, 26 Jun 2026 15:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7373C1F000E9;
 Fri, 26 Jun 2026 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486001;
 bh=02lsSfPBDNECpgNgJ/RqqGluA9eXFW05KmNtE4n7ypI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J/8/quWIZkid1pKBK4jc3IGf/fitziDFQvSJmdmljEVGxSrvRhyKoUEflPx2ln/t1
 WQWtsrNgyDhEHCd0lFNjPl/pjSICg4z/W27onxZit+GIaTkMnciheKZMxlPQdI+Bif
 gjZyDREOJ57av3bduhkS/mWH0RFwLoBO0BhCO+70gypRxwFiQmc3SlDZm0gNy0TQzJ
 OKup+0LMl0wWXfuC5mixM0FlWDdIyf5MVv09tAP0ifciuVddfZYvEDdqldSlsNbpnJ
 rYwPe3JWpavcAxAQIjvvhB0QOVyTu1IlL6vPmYEOfDl37HRBF4Oy+KBvlTwGmNtzXs
 WuLnx3/6gD7RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:00:00 +0000
Message-Id: <20260626150001.7373C1F000E9@smtp.kernel.org>
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

> The current safety comment on `io_read`/`io_write` does not cover the top=
ic
> about alignment. Add it so it can be relied on by implementor of
> `IoCapable`.
>=20
> Expand the check performed by `Io` by taking `self.addr()` into
> consideration when checking if `offset` is aligned. For the compile-time
> `io_addr_assert` check, check using the known minimum alignment of
> `Io::Target` and the accessed type.
>=20
> While at it, fix the alignment check to use `align_of` instead of
> `size_of`. The values match for all primitives (including u64, given that
> we do not provide u64 accessor on 32-bit platforms), but are not
> necessarily true for custom types.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D2

