Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0B7C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE55510EDE6;
	Wed, 19 Aug 2026 11:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CVGXGYkq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE4610EDE6
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D9BF60A59;
 Wed, 19 Aug 2026 11:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B211F000E9;
 Wed, 19 Aug 2026 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138092;
 bh=pghcZz6TJqFHCteOs9c5p1tFOKLB5wDU1cRCVf2djOo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CVGXGYkqVXeA+K26lBxb9XS90S16aBEnozvdEYvYhl2ofX9PDCx3k9e99FZfDse8p
 OqGAA9ql2zXFIM3GbVfC2sV7xblvoNsml06nYbJoF6xQQSJuIgte6GBMtPyBYnzw6s
 LQZWBqwk+SNb3vaLVkx5UPfcG57dq2ucI5WYRdcs9IJht4uJ/50hw3fJPh0hyaTR8a
 02cvnpS5AAtJmbmmRsbkbyVWY0FE/F5E5ewIlqrkPAhJn8Owg0qyH1wTiE29XWdQ7R
 uwQqfmmhLCtdpy8PtYXyZhwfIbMfNqQD5ldEi/7IOaMp6cl3C/ZUsKqH0eyBhKWMFA
 CeURvaA49q6lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/16] samples: rust: pci: specify base type for
 registers
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:14:51 +0000
Message-Id: <20260819111451.E6B211F000E9@smtp.kernel.org>
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

> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D9

