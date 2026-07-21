Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB84C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFF110E38F;
	Tue, 21 Jul 2026 17:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b2iTPe14";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DDC10E38F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:18:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD2CB405AC;
 Tue, 21 Jul 2026 17:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783851F000E9;
 Tue, 21 Jul 2026 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784654288;
 bh=FACeUECK4C6pRaOivUkcVl8IRxh7h/CYdrEQk57f+Zw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b2iTPe14Job6+Hg93SIWKntUTxACO4bC0NRFpvWz1k5utoXpC2LDR1hUXttgLQDMg
 xyVVMNjuQVD/8SDIqobnHnr4D3HNy23dbh5nfofDivK33lDumOHDDhlS8ycHdQo4DP
 dag4PHEpSUgYnyYzfPYsRgXYs6ioh9ZEWOKxQ9R0kaux2zoYja4LAvCny34gYv9+M8
 TEl4e1p8pTsG/COACyoRT0LE6B867Q5uVxu3HjBnh2Uri6+65x1Xak9XmL7Yd6VLEm
 vnwbjDM+Jv8O1KJ7L8zyifdaQjMvBLJhrXVzQ4I7HKn58jhtxuffYUkKErm0CqkQwN
 kWHh30CGQU4OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] gpu: nova-core: convert hshub0 from relative
 register to projection
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-9-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-9-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:18:07 +0000
Message-Id: <20260721171807.783851F000E9@smtp.kernel.org>
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

> Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
> can also be achieved cleanly with projection and a new base.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D9

