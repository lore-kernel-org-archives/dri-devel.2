Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BE1C44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE7010E2E8;
	Sat, 11 Jul 2026 06:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WbniBfay";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA0210E2E8
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 675EE4364F;
 Sat, 11 Jul 2026 06:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C091F000E9;
 Sat, 11 Jul 2026 06:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750778;
 bh=l0grfuKIsTMvbS8uTCzoVrty33M9dgrc7k+SKyobfJE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WbniBfaycZ/AgZ2+lEqbtChQz2/kTlypNABFrAgczNZFc/Tj/926phBLVRhzf6uXy
 IChZMsZRIBJQN5InQIMjW8Nsg50f2nmOxKNpAE1zS0LeAq+IxRsR7Q9kORNjdHnJWH
 NZUxBEyw+fgg/ApEimIfbhC3i5c3R6u+l2OHhFtfYHYZIdJtBPSNA4/j9BZYiMB1Wj
 lhB/LpmJcLw0gFdfApwNUfygooL1HfD3j+lU58ZoR+Zm3FvjoOJRhCr7UOeFPh04Ov
 LZJkywt2Fd3X9TDi6rmTFsUAPUYDd0+piRoBdFLfqN/1SFDGsUuNIKwR422DBFS+AW
 kh65xP96ZfnGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/16] arm: dts: omap3pandora: Populate DT data for the
 TWL4030's REGEN regulator
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: lee@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <d0b2a73c7c208f33784eae4219ff3981800ae6f9.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <d0b2a73c7c208f33784eae4219ff3981800ae6f9.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:19:37 +0000
Message-Id: <20260711061937.E4C091F000E9@smtp.kernel.org>
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

> From: Grond <grond66@riseup.net>
>=20
> On the Pandora, REGEN is used to enable TPS61029DRC external regulator
> which runs a 5V power rail. The 5ms startup delay is taken from Pandora's
> 3.2 kernel, where it is labeled as a "guess". So it may be possible to
> activate the regulator faster.
>=20
> On Pandora CC units, this regulator is used as the input to the LCD power
> supply. Therefore, problems are likely to arise if the regulator is ever
> disabled, so we add the regulator-always-on property to compensate.
>=20
> Signed-off-by: Grond <grond66@riseup.net>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D4

