Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EA5C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5AA10E975;
	Mon,  6 Jul 2026 13:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJq+6w8l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478F510E1B6
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:00:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 168C943A12;
 Mon,  6 Jul 2026 13:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6BE1F000E9;
 Mon,  6 Jul 2026 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342816;
 bh=TjrQuxlr+lST6uIJUlZYxtFRA0Cu9iDe66YoZ4B14p4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GJq+6w8lcbOducaYYxMDpYAw27YBuEqTHTybgNK/tBoWhVdtcdG+s1IN1uQ8BLxm6
 4m37hGIKxWD9+wPE0Q3C9oBzHWrcnL6ESPbTsImIv1V/YClciTTymS2GyiA6rknS2E
 HLAD41ia793gedRwz2Buk04xk8gaER5GmfyKzlymJSXSIjCL1/AZ+flBBUhqCzIerb
 eNpwFgvFkqhKuoW79rw89uwBWMJkhw/ZtV2kxdEQUqsfB9UqJIz28HAFwa32zv49Zn
 K0QdRvIsItgFgSBT2X30YagcjmsJ+zvNIrYLf2EBBpLn3g1oauwhgDwQXK8P6m5MUe
 I2Q41nbDnDbcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:00:15 +0000
Message-Id: <20260706130015.9E6BE1F000E9@smtp.kernel.org>
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
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D2

