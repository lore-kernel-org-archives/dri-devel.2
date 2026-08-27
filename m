Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AC1C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FE510F0A9;
	Thu, 27 Aug 2026 14:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B4hhhJzD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9915C10F0A9
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:34:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3CE1600D2;
 Thu, 27 Aug 2026 14:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F1C1F00A3F;
 Thu, 27 Aug 2026 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787841272;
 bh=0sCr1lNGeYTpyIoUlvRGeUMCKERonYUVv9XgYtZuLYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B4hhhJzDHaaHzZl+9jxY/hUmBvRfaAYCmfwNtoEvv4M3GmX4eJDCT/eJWKyBdza0K
 PPDoi19h6XDGPW1lZxicOJciNNIEFMwlR/HUuW6i8OWprTZWx5vxCSHO+p+kZaa7P6
 0aC0HXQ7UKDwvszkNzzyvXcww6Aj4u3/Qkzbl/NCvDfll+TxYfvx8Asaxa3tX1oMnL
 uoKw4sep2XACTOwQLJrPrb0wOSXMmGG4yOr71BtWTQHHBoawkpZQUgDQl2WDtRo7SJ
 z7H1diXNbKNEZ/0AbZ+cLc/v1RNEwwEM0Q5GBIob+mULyWeW2xmrWfkKhdkTVIP0VW
 2dDjqN5cegIjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:34:31 +0000
Message-Id: <20260827143432.42F1C1F00A3F@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect vertical import alphabetical sorting for `nvkv_decode` an=
d `nvkv_encode`.
--

commit 70350e378f301f73e838aa27ff2017d800f88a22
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV GSP_INIT schemas

This commit introduces the first user of NVKV encode/decode for the GSP init
request and response schemas. It implements the associated structures and
exercises them via unit tests.

> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs

[ ... ]

> @@ -19,6 +21,19 @@
>      num::IntoSafeCast, //
>  };
> =20
> +use crate::gsp::nvkv::{
> +    nvkv_decode,
> +    nvkv_encode,
> +    Accumulated,
> +    Array,
> +    DecoderValue,
> +    Encodable,
> +    Encoder,
> +    Key,
> +    KeyId,
> +    Required, //
> +};

[Severity: Low]
This isn't a bug, but does this import block in commands.rs miss the Rust
kernel coding guidelines for vertical import sorting?

The items nvkv_decode and nvkv_encode are placed at the top of the list, but
alphabetically they should come after the capitalized items like Accumulate=
d,
Array, and DecoderValue. Should these be relocated to their proper
alphabetical position at the bottom of this import block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-b4-nvkv-v2=
-0-0de9d5c8658c@nvidia.com?part=3D8
