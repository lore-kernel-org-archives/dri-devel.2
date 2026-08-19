Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441FFC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BB910EDEF;
	Wed, 19 Aug 2026 11:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="If+8TRl9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6508B10EDEF
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:21:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48EB4402B1;
 Wed, 19 Aug 2026 11:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6921F000E9;
 Wed, 19 Aug 2026 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138462;
 bh=5v9aCr6UOwTja2NOou3O3WvFffmOzimBJvCNoGx72V0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=If+8TRl985wSroRRPlL9Uaip0CCxUlbGeyXyeIPVfvPPWusxs5GwiyT+0UzfNYDAv
 GLJKC2TvAPOGijDelJ4xFwIAn1Y1yizUC6ZGcpRTfV6bAjv2QwDdqL8Wt7iBpf5DsD
 NMqPqS6ErGDsE31/+47xE3/wGeJxOABb8yw/nDY5jBQhiZf/jvkjqW2OAikJTT6UUz
 BWqcAjxeVI8plyxbpZKrUzyKcressLrKSY18TSgEMtcXLZ8HVnE9w2r+oqgSy0oeA1
 HARMXE5J7mnbaUYcywTpsqmZLcinZthlDtVDsiU2XLsZlIC0itPxLbOCorZi0y9ElU
 uhEBlvI4R3CbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org
In-Reply-To: <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:21:01 +0000
Message-Id: <20260819112101.DC6921F000E9@smtp.kernel.org>
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

> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D15

