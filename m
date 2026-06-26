Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1755C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2BB10F68D;
	Fri, 26 Jun 2026 14:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FGAFGxoN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C821310F68D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:57:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DD12600D8;
 Fri, 26 Jun 2026 14:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D881F00A3D;
 Fri, 26 Jun 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485839;
 bh=vcj031Wc1kQS8ykJghfPG2WWW4TP7CPrY0uzc2LC1FQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FGAFGxoNJkxu7ZwaeV8ArNUmbt4/qqExGvc/dxUAVTOzB9j8QAReH4jGgBWBUqU5F
 a070NLAjbXjxdGYIq1MDv8P9DuoJxIBFg0sr8WSl5M+peT3zO4/u5Q/Md/UpgkRCBG
 f2hqX9qEtVpHrO8hBwgBouiMq+T+dS+SBQaDzU+s8Hm0YOhH3Q6Y+mxJPryLdnOTPp
 HpzquO8za+GTOaEgwmtmhDZTxXiLzpkKNzQEAZOIAJlx9qatjY2OSSv0XcmI3Rx2Fx
 lTiJIZdECv0+hezoz4eCLqGcg/LzUGrD97flqI9Qb/5haFBst1x8gGD5uWNTT1zAcn
 PBor9wsi3NqWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/20] rust: io: add I/O backend for system memory
 with volatile access
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:57:17 +0000
Message-Id: <20260626145718.96D881F00A3D@smtp.kernel.org>
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

> From: Laura Nao <laura.nao@collabora.com>
>=20
> Add `SysMem`, an `Io` trait implementation for kernel virtual address
> ranges. It uses volatile accessors to provide safe access to shared
> memory that may be concurrently accessed by external hardware. Implement
> `IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).
>=20
> This can be used for instead of `Coherent` for cases where a different
> layer takes care of mapping the system memory to the device (e.g. dma-buf
> or GPUVM).
>=20
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> [ Rebased and adapted on top of I/O rework. - Gary ]
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D14

