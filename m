Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C24C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3216310EDEA;
	Wed, 19 Aug 2026 11:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nH+DX5RW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D0E10EDEA
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:17:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8663C60A59;
 Wed, 19 Aug 2026 11:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A4C1F000E9;
 Wed, 19 Aug 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138230;
 bh=fhamI47DjOVMmSx/5k34N5XYPsQYnZNXFMijhumIo0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nH+DX5RWEj7qkMJRLhfgmikrweoAnGAIsYzho0V8iQxUZTwXDfjuw0KmeUKsrBarP
 xOHWEGcV+JvJ7I4V377t/OVDeCMMPfcFUp52Iv9eopH4FD6ZMesgS5C7R3UMAAof/z
 K5mr1gBl338HVjZL2jfdxGGvDEza0gFCTx1mnVyp0khcE1L3ZZ9foZrHL71PXguTM6
 YYVOltK1GcwAK0NzsTsYe387912aObxs6aUvirwA2kDuk1UtAKkYaMnLHd3uJT/S8D
 0hfJ/mZNXGFy/0PVXJ5ZtiJtIhUUTnQlrTApqhTFbbR7RNrnx4/8lvwYp/JDtlXTSh
 cy/x5X/XEZihA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] rust: io: register: support fixed offset
 register without bitfield
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:17:09 +0000
Message-Id: <20260819111709.F2A4C1F000E9@smtp.kernel.org>
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

> Add a rule to allow creating `IoLoc` in `register!()` using an existing
> type and not create a bitfield. Add an example to demonstrate this for FI=
FO
> registers.
>=20
> This rule is also going to be used to create subregions for registers; the
> example of doing so will be added later when relative registers are
> removed.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D11

