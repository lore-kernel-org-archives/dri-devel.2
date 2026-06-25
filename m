Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C258BCDE00E
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099F410F382;
	Thu, 25 Jun 2026 21:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dw85ZKgR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AD610F382
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 21:04:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4484C60098;
 Thu, 25 Jun 2026 21:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7121F000E9;
 Thu, 25 Jun 2026 21:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782421491;
 bh=X9LiEddNTvggHDlS2AvbVpK23go9qHLDOFOQnwIU41o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dw85ZKgRopCLxDZN12HsESQYICddV3ncyh6qY7tS6dhfVf/uWYP+ioflljmdczk4x
 72hH7cP6yy2iuJhwPwIEPg5rVg/8QtxD5bdENn6wSQ/PMjIMHcwANcJCSAbrhEuT+b
 RRyMvLdyfWAiDkm7H2qQNwxSHrNGfJB7fyjm6ipjuGmvZWDt0gwCGt1Dy+VmNb/LlP
 ve4C7vhyOXq7cAv3rxZ8Ox0YbceH2B3g/nGyzCFhlVX0g842KdOgcwyFeNlISS13Jr
 okGC5kL1yGVRcv4IrFbp2Mm5J2+pJkEIWjQiEumHisWvoOguZH6nri1SCLrS5YEUd5
 sTL3Xig+DjFfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/nova: remove unused trait in commands.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260625205146.5047-8-niyudi.honda@usp.br>
References: <20260625205146.5047-1-niyudi.honda@usp.br>
 <20260625205146.5047-8-niyudi.honda@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 21:04:50 +0000
Message-Id: <20260625210450.9A7121F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The import modification violates the Rust vertical import style gui=
deline by omitting a trailing comma.

Pre-existing issues:
- [High] The size field of the GSP registry table is incorrectly initialize=
d, missing the base structure's size.
--

commit 6004d87646aa24143dd922fea1595d59bd5bbcb7
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: remove unused trait in commands.rs

This commit removes the unused transmute::FromBytes implementation and its
import in drivers/gpu/nova-core/gsp/commands.rs.

> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index f84de9f4f0450..a3c0b7fa3b9ed 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -12,10 +12,7 @@
>      device,
>      pci,
>      prelude::*,
> -    transmute::{
> -        AsBytes,
> -        FromBytes, //
> -    }, //
> +    transmute::AsBytes//

[Severity: Low]
Does this modification violate the Rust vertical import style guideline by
omitting a trailing comma?

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
SetRegistry::init() in this same file:

drivers/gpu/nova-core/gsp/commands.rs:SetRegistry::init() {
    ...
    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
        Self::Command::init(Self::NUM_ENTRIES as u32, self.variable_payload=
_len() as u32)
    }
    ...
}

[Severity: High]
Is the size field of the GSP registry table incorrectly initialized here by
omitting the base structure's size?=20

Since the table size provided to the GSP firmware only accounts for the
variable payload and omits the table's header size, the string offsets
computed for the registry keys will mathematically exceed the declared table
size.=20

Will the firmware reject the command due to an apparent out-of-bounds acces=
s,
potentially causing driver bring-up to fail entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625205146.5047=
-1-niyudi.honda@usp.br?part=3D7
