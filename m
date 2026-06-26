Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D918CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4313F10E3B3;
	Fri, 26 Jun 2026 14:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R8eGf0sc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD2110F5FA
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5408600D9;
 Fri, 26 Jun 2026 14:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC7F1F00A3A;
 Fri, 26 Jun 2026 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485968;
 bh=rTh09xxTNUQ7wmzvVvJ3mY4veTFxbFJgPPII5D+9y0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R8eGf0scenIWNsNykhG3vkU+J//To3O6jd9YPAhIHza+5ITRp9hDO1yQkmtz0XL6/
 HTLSZpGatJl3BvaQ0Sk5jxKSSZzRrrucqk8kYBQB5OY9mPT0N2RZ/ckXyA2yxJNoBH
 Yoh9vi5GuvT0KuBXWgS8IIx+BLe/NVaZfXE2NPQ4Snx7/j78ChdkJCpE2HBnLMLo7B
 TU4oeZOtw7JHBSKZB+a5O6+1Boa+jrksGv12VpxEnZu++ni42pfOh2AS5GK0/fdf4n
 pKSdKq+nhoLZEi4G4N1BBaeOxfLulQ8/O2ThEFXKqhVYHQuaKp9T+F8QCOe+CyOTG1
 rCEcVvG/PUXQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/20] rust: io: implement `IoSysMap`
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:59:26 +0000
Message-Id: <20260626145927.1FC7F1F00A3A@smtp.kernel.org>
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

> Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
> purpose of `iosys_map`. Thanks to Rust's type system, all of projection a=
nd
> struct read/write can be handled by the generic I/O projection mechanism
> (i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no ne=
ed
> to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
> enum type also makes it very easy to construct or destruct.
>=20
> This could be made more generic by implementing on a general purpose sum
> type like `Either`; however this is kept specific unless a need arises th=
at
> warrants this to be generic over other I/O backends.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D20

