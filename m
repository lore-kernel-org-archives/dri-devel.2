Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7031FC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F7B10EAC2;
	Tue, 21 Jul 2026 16:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AhPWTuXY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBAE10EAC2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:58:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81717408CF;
 Tue, 21 Jul 2026 16:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF51F000E9;
 Tue, 21 Jul 2026 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653104;
 bh=gq6vg13GJqf8zhAbZd8/FHgF5n4EzcvKVwTI9BJ6tYY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AhPWTuXYeNND83V4VMVsvxYTM4xw+276b0EEbTEmlGPsxSVrMSW2kJzpJo4Tlmwz3
 Y25YpFoN2ARx/LHdzVKqeixvAkX16I0NbSG2jc8avWnJ4ZIoj9mq9Ai1419L/WkFNe
 Y0kbxd1XXPqGcuvC1hb2CqJQVnTRXp711KZPvY50i3ROBl7s0uMH1vgxY7OZt2WIYd
 uFYfO3BMP9BbEzQNBm3QVyEg6bbgJcDyHZFIr7F//xoMyym9e9qY1gRF+TJeLO0Wcv
 HhEnY0deOo2fHTB4fQYY0YsghhU3ZbbSiV+6hptV99IQbx1G/O0EP0xmXDnAcvPdMH
 QecgtfCVVgkXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:58:23 +0000
Message-Id: <20260721165824.16DF51F000E9@smtp.kernel.org>
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

> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>=20
> All users of the `register!` macro know what type it will be operating on,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>=20
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D1

