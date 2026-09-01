Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F38C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD5610EDC8;
	Tue,  1 Sep 2026 16:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YkS6KzAY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5595110EDC8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78C9E60261;
 Tue,  1 Sep 2026 16:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49291F00A3A;
 Tue,  1 Sep 2026 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281941;
 bh=ELvpO9TGO0jav2xemTL9Ytysgav0jAindTAbKa6pSDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YkS6KzAYhoSZWCyzJpS53NwM9kmU5k8YRkK/GoFuILGT6npcU989gUJimBDtNCHQh
 +S0kkmuGZtqBhN6wiWoNHl2fLHs5L5mB8uJd4udIRL1S4yjULHh+qL0rFU3Pxk6dzC
 cE2g+zjG40+JeRVrV32snEk5dOqLBBxIHitFgWSx1yDVLcz4absHbioRCbFZfoa2pZ
 3eCNnCYLEYlWu5Lfm7Ev1q5/iE1U2sGIK5aRfY6PfY06aT0Tvbu31H59W6ayQNQi0E
 FU2yRzGq7p7yCSe8JRP2A/zF6aDuPiFqn25zUhG8VSoHzK0ySlfG/YEur/CXEJYNSF
 KJ/qTNWCkjfWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:00 +0000
Message-Id: <20260901165900.C49291F00A3A@smtp.kernel.org>
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

> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
> update PFALCON and PFALCON2 registers to be fixed register on them and not
> relative registers on `NovaRegisters`.
>=20
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D12

