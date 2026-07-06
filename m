Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B4EC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E2610E970;
	Mon,  6 Jul 2026 12:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VPt/TvY5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC9A10E970
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:53:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 337BB43954;
 Mon,  6 Jul 2026 12:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB52B1F00A3A;
 Mon,  6 Jul 2026 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342411;
 bh=kqPfdoQL3aLX9bpfzPt+4+mrGjAKeGVe23iF4eebkyM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VPt/TvY5ghEDqeNBgOkvGfAZtXn3Tk7RPEk5bRb90BichhFn1o4L+xnT/819mQNJq
 zgwuNY5rAGMb3Td3A2NaEf/9kV1iD8F1e3a18DIlbSGDy3Qbc9QS/Ox3rWLpp48TXu
 YbmztEAIRdj7YRgFmYtNUkqbloaE12lPQ5Rjq5fVVhX7TuSn3KdjwXbo5uac8G9XfI
 i0kJIBkhrP2gEOmwHFH4mKsoF+l2G4HJCI797GQsMaGF3hvcD01aDmz5X6pFVEN/MW
 2ibLHceOYdwQqxhHiliGgYJFi0GPsNhpYp41uAKzi8vNj7KCy2OopX1iq/J00LjsV/
 wfM9ai1CAjvnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/20] rust: io: implement `Io` on reference types
 instead
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:53:29 +0000
Message-Id: <20260706125330.BB52B1F00A3A@smtp.kernel.org>
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

> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
> going to change with I/O projections, as then `Io` needs to work both for
> owned objects and views of them. Views are themselves reference-like
> (however they obviously cannot be references, because they belong to a
> different address space).
>=20
> To facilitate the change, change `Io` to be implemented on reference types
> for the owned I/O objects, and make methods take `self` instead of `&self=
`.
> When I/O views are implemented, we can then naturally implement `Io` for
> these objects.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D4

