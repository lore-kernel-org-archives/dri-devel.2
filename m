Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA351CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E2610E056;
	Wed, 30 Sep 2026 18:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZnYqD3A7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A0810E056
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0C28407D1;
 Wed, 30 Sep 2026 18:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1EF1F00898;
 Wed, 30 Sep 2026 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790792450;
 bh=iKB0Xr798o8BJ/ut3lm9p2YkMA5yP6qEFVA1Z1Go+O0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZnYqD3A7oykjQNYGXJK1Vx9gr4KPzsnjxa7+IC058q+p7gjS0Gi04R+9dr0Oz26Y8
 G6OclGLe+7e2ZGmDppUKwPvanz+aiesTF3pC9Z1nxKsyxyNAjeG/GZfiE3d6AUFQfn
 ESDIuK/Zj8HZTJwCKZM65bxLklrxW7CqUIgvNft1GFiEfg0yDq8y4Uj/bgsopQZ5VE
 n8itb6h/+OMlnk6cp/FDn1+jASJS9BhWpmBhcibpv3OoNdyBAQzrqLSCiCpgpGy9Wb
 P7Q3XZHYqeUwc5BV7K510bvK4qqLIEjwk5tCmF9S1Af/ClWhcabiFj/dU3sH4TT3f8
 OZrtdon53UWWw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Filipe Xavier <felipeaggger@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Filipe Xavier <felipe_life@live.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Filipe
 Xavier <felipeaggger@gmail.com>
Subject: Re: [PATCH v2] rust: impl_flags: add conversions for raw flag
 representations
In-Reply-To: <20260920-add-from-raw-conversions-v2-1-cef8e6e23ae2@gmail.com>
References: <20260920-add-from-raw-conversions-v2-1-cef8e6e23ae2@gmail.com>
Date: Wed, 30 Sep 2026 20:20:37 +0200
Message-ID: <875wzmbnyi.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Filipe Xavier <felipeaggger@gmail.com> writes:

> Extend the impl_flags! macro to support conversions between generated flag
> types and raw C/UAPI integers. Implement TryFrom<Repr> for individual flags
> (exact variant match) and flag sets (rejecting unknown bits), along with an
> unsafe from_raw() constructor for flag sets. Additionally, add BitOr and
> BitOrAssign implementations between the raw representation and flag types.
>
> Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>

I feel like I already sent a patch for at least part of this [1]. Please
go review that one and maybe use it as a dependency.

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/all/20260605-impl-flags-additions-v2-1-0d27242f460b@kernel.org/

