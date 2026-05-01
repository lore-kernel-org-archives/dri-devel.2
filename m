Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2E3CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 12:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C491410E539;
	Fri,  1 May 2026 12:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s3KKF08j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3195710E539
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 12:31:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A29660126;
 Fri,  1 May 2026 12:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BAAC2BCB4;
 Fri,  1 May 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777638677;
 bh=mOhShvj4gvpdrJdzhTY0clT/AUI1RfZaKhiI+R0e/hc=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=s3KKF08js6xdafptYe8LP6Aj/iGrtGXTPPSYErmwCYGNrT15Ycf5YGgw0Wqrt1Knu
 g1kx6CX99U6peS7MVnIoF82HsjmFd4jLYtoFS3GylX1xUl/mZWVbEHw5Utwv7fDGs5
 JMU3a7lCDQ+81BP+XyBGNahKNeRu19yDup1KIRO1YDW+5ZFk93q2V7H0TwGVRoFAHH
 2z3J06XMXrgrNnQVPGVmpbXFok3+YroGEOXTiteu22afbPcSvjXCx4JbB8jvhISxeK
 scGrY5yj1ugzllRtKjNQ9e8ibwMGkgDwLkZmAL1SpMvy8q+0pelo3/CAWEtSklmFld
 l+GOjHgm0Ij3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 14:31:11 +0200
Message-Id: <DI7CBG1A3DBE.GKX9UUYUBPV5@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/7] gpu: nova-core: rename module from nova_core to
 nova-core
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
 <20260430-nova-exports-v1-3-7ca31664e983@nvidia.com>
 <e0301888-940a-49a4-8a3a-47960162819f@nvidia.com>
 <DI70PV5V3W38.ZVD5ZE6027SD@nvidia.com>
In-Reply-To: <DI70PV5V3W38.ZVD5ZE6027SD@nvidia.com>
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

On Fri May 1, 2026 at 5:25 AM CEST, Alexandre Courbot wrote:
> Danilo, WDYT?

I think the patch is fine as is.

However, the commit message should say that it also changes nova_core.ko to
nova-core.ko, which is the reason I proposed this in [1] as well.

I.e. such that the module name (that we still need to change; I can send a =
patch
since I haven't heard back from Chou) matches the .ko file name.

I'm not a fan of generic names like lib.rs, mod.rs, main.rs, etc., as it me=
sses
with fuzzy finder tools.

If people feel strongly about this, we can probably rename it to
nova_core_main.rs, but I think it is not necessary.

- Danilo

[1] https://lore.kernel.org/all/DH56PG8GLW4X.2QMHJ91J9D29N@kernel.org/
