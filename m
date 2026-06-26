Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF109C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BD010F5D4;
	Fri, 26 Jun 2026 15:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jvu7kOGM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A248E10F5D4
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:00:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26683600DC;
 Fri, 26 Jun 2026 15:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85821F00A3E;
 Fri, 26 Jun 2026 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486000;
 bh=KlgSE5z5Eql/AnHmC6HqkP0aIfvAuYOWMm1HbYthlV0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jvu7kOGMx1KFhnl/5ZT0kpIIPkfNlQ4hmf/ZZ22d866ih3bPapuvkuun0N3tLjeGO
 BwO5TK1vnHaw2ooOeHduVHu8BShrfiA5aC9W7iN5ghJXz3b4K9rmgK79ejMVu0L730
 foFQZLLjKJexLWWG5kEpkpbf5PRfrAXg+wEgcpDAIOnZizbt+Iuvj1CccnLDQji15G
 2wFW2ruRR1kpzYjx4cIDay9I+NDVMMk9VnESpHfNunfOkmMXNzw4FFrzSVKQNqYu7C
 AQmNR351WefNr0DeSOOGmlTH1ozduEr/gqrnnXKHnS5gMRFkI3inthqN/aT1Dy73+d
 PSHRXEo/RV38Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-16-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-16-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:59:59 +0000
Message-Id: <20260626145959.D85821F00A3E@smtp.kernel.org>
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

> Provide `read_val` and `write_val` that allow I/O views to be accessed wh=
en
> they're narrowed down to just views of primitives.
>=20
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that wo=
rk
> for all types that implement `Io`.
>=20
> Note though `io_read!` and `io_write!` only works if backend implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple instructions
> to access parts and re-assemble, even if they could be combined to a sing=
le
> instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better served
> with copying primitives (e.g. memcpy_{from,to}io).
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D16

