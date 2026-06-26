Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C94FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE2710F5D9;
	Fri, 26 Jun 2026 15:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YNKHu4Lj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9BB10F5D9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:00:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71B03600DB;
 Fri, 26 Jun 2026 15:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE091F000E9;
 Fri, 26 Jun 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486050;
 bh=bmxsOB9f9njIDVopkZnvPuzQA1EedkdM1yk6u/sSckM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YNKHu4LjQAqkP4tLwej/p2GSvLnS2eE1eF6cHL31YbfEc89u+XDjh5sp3vpjAyoyf
 gpsQq3HJbObPdk+Yi2WfQPMh3pIrA/nHEaSZKgFlaCxPO3OoFHBr9TCtkiVcZYLu88
 h5+CtdNkgILZHIRHF4SWhWH/OudsdMY85vhgCEZ1zfHwqxbGcFSu9UpIP192Uq7QG/
 6SUuqZilppy2z2YpUamT0bD0MGj9WeHxoQHbQrUp0sgiYdd++HuoiQKZrvXtpqAcnY
 t+t7k9g96IIxHbuxbhKM4UGyekV31q8KKbOTsi/FYe0hOzNyODeUDWVpEjtRvMQiox
 9ecOQl9JOCrHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/20] rust: io: add projection macro and methods
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:00:48 +0000
Message-Id: <20260626150048.EFE091F000E9@smtp.kernel.org>
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

> Add an `io_project!()` macro allows projection from `Io` to a subview of
> it, using the pointer projection mechanism to perform compile-time checks.
>=20
> For cases where type-casting is required, the `try_cast()` function may be
> used where the size and alignment checks are performed at runtime.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D13

