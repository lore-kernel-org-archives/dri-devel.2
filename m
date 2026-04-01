Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77148D35179
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC67510EF4F;
	Wed,  1 Apr 2026 12:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cNc4Unp+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AD310EF4F;
 Wed,  1 Apr 2026 12:29:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5683440426;
 Wed,  1 Apr 2026 12:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C95C2BCB2;
 Wed,  1 Apr 2026 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775046558;
 bh=LI9WhSdEEdZ3tG3mKql7VBDkTBXQLZ/gbuOGi0yNUv8=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=cNc4Unp+PRYooUmgGFFye5pDT1W9gMHh2kYwCyjV+QfNlITpPwQ/dJuvgfcNRQ2RU
 OLAaelo2Y0M4WDZzhqq4RFZXh9vweX3G+C/5TXnNYfixFZeSPwJ1TncBCwnYdhO4+N
 iUJBSVjzKvnbJsWNKBdcqSDoCCVgRcPImXqZXrY2LM7yFKn2M2coddn/epy+7pRRuJ
 7kjR5sUlRh74ki1EVprakY7r7VdQLjXSDpn81irF7Wy3aK4ONAC6bsjxvO3qaEeF2y
 Ih/6O0he7vcr4VTXsIepdeDgBSoaXWc/+n1c+XHcoTMZbv3F14pd5Q4viy/bXvnp97
 pRV5GgtSPhWxA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 14:29:08 +0200
Message-Id: <DHHTHIT2GZIG.P942QFSTQ32M@kernel.org>
Cc: "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier"
 <nsc@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <christian@brauner.io>, "Carlos
 Llamas" <cmllamas@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam
 R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki"
 <urezki@gmail.com>, <linux-block@vger.kernel.org>, "moderated for
 non-subscribers" <linux-arm-kernel@lists.infradead.org>, "Alexandre Ghiti"
 <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Rae
 Moar" <raemoar63@gmail.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, <llvm@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 21/33] gpu: nova-core: bindings: remove unneeded `cfg_attr`
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-22-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-22-ojeda@kernel.org>
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

On Wed Apr 1, 2026 at 1:45 PM CEST, Miguel Ojeda wrote:
> These were likely copied from the `bindings` and `uapi` crates, but are
> unneeded since there are no `cfg(test)`s in the bindings.
>
> In addition, the issue that triggered the addition in those crates
> originally is also fixed in `bindgen` (please see the previous commit).
>
> Thus remove them.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Danilo Krummrich <dakr@kernel.org>
