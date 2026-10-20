Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D27606A321
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H77DKLIt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A8910F4A0;
	Tue, 20 Oct 2026 10:15:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2E610F4A0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:15:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A47D0406C1;
 Tue, 20 Oct 2026 10:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3AC1F000C5;
 Tue, 20 Oct 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792491324;
 bh=Z8aoSraZUw7RtHVjQIDean+kwFhgokmYkufOMl94zx0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H77DKLItotKQo1hjJlX/JDuu0BxrtBptt6R65FoLj3Te2xrpFQ9xL7lNCT34V+YQJ
 2dPvJ2nyNAY4rY0KFicfyLySTVYToA+PrKxcX7BPnNVf7GmOum6AEFLJ5X6N7QGNLH
 UXZwHfZyfoBH5mY1rb/jZpDWB+oER2mELUKYqgMOHwCZFHVJ8XUYA5JNt9KxeEagwl
 7FtQCRW2J37uz6BsK8zuEDgSrjQRSlifi45gIbEqRSfUSfNPXkSnZ6Cydj9jLs9etg
 oAiSGcjE3orBL1OiJuMMP8wR/Ub8UHCKAxcxslQanwENTkkIlEM8vF05N6vqhOtc5b
 9RAuaR7GqUjjA==
Message-ID: <sashiko-outbox-178817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/14] gpu: nova-core: gsp: cmdq: move the RPC code
 into a sub-module
To: "Alexandre Courbot" <acourbot@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20261020-cmdq-rpc-v5-12-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-12-dceeb8f360ec@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:15:23 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] gpu: nova-core: split kernel::time import block in cmdq.rs
--

commit 33237ce05e59a6a327898e33f27b96ad56cf0c7f
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module

This commit moves the RPC command and message types and methods from
drivers/gpu/nova-core/gsp/cmdq.rs into a new rpc sub-module.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 54e87fd7158cd..c5a2f08cda94a 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -28,8 +29,8 @@
>          },
>          Mutex, //
>      },
> +    time::Delta,
>      time::{
> -        Delta,
>          Instant,
>          Monotonic, //
>      },

[Severity: Low]
This isn't a bug, but in the use kernel declaration in
drivers/gpu/nova-core/gsp/cmdq.rs, Delta was moved out of the time::{ ... }
group into a separate time::Delta entry above time::{ Instant, Monotonic }.
Should Delta remain grouped inside the single time::{ ... } block to follow
the kernel vertical import style?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-cmdq-rpc-v=
5-0-dceeb8f360ec@nvidia.com?part=3D12
