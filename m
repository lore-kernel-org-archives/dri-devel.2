Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F713CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DDC11A5C1;
	Fri,  5 Jun 2026 08:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KHP50tYz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B5D10E51E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:45:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42300600AA;
 Fri,  5 Jun 2026 08:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38D61F00893;
 Fri,  5 Jun 2026 08:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780649104;
 bh=jNpcQX3kj8pOr86cv2TN7spn69B58V3B6TVkclmDQUM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KHP50tYzoo50AA1FyoZwv+yHgMOTtfuCoemK1+vRYmtBboLtTlXaaETky42oTwdGF
 01fAIgO0+oSSNHuGW8mLGsHrlGEGbKTBtWm6LOHTYnpkCYTE1bJwHZjRYLbUmQHk/z
 DEpq2y3mcimn0ESSwrtn2VqQgaubB+bSy2jdYexWBD0QAkSckCxY4mw8BuL/fgn/m6
 WhwqTb6NKKIZK90DL+Vc6HlBcSiHkVccdaxfx9ct+XUZOzJV7GMTNtRsnOGn2On8uq
 Hh4ncRTI1SWXANfblomZNI6cFQczu1etU44cV/27//Q/gwBrpRIyunU+iAxeyrmnG7
 XeH8fAveei8rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] gpu: nova-core: export Rust symbols for nova-drm
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260605-nova-exports-v4-3-e948c287407c@nvidia.com>
References: <20260605-nova-exports-v4-3-e948c287407c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:45:03 +0000
Message-Id: <20260605084503.B38D61F00893@smtp.kernel.org>
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
- [High] Exporting Rust symbols via `nova_core_exports.c` silently assigns =
identical `int`-based CRCs to all exported Rust symbols, defeating kernel m=
odule versioning (CONFIG_MODVERSIONS).
--

commit 7d9ae3e551194f16dfdfeaf200ba6d4a6e3969c0
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: export Rust symbols for nova-drm

This commit exports nova-core's Rust symbols so nova-drm can resolve refere=
nces
to it when loaded as a module. It generates declarations and
EXPORT_SYMBOL_RUST_GPL() calls for Rust global symbols using nm and compiles
them into the module as nova_core_exports.o.

> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 45e0941324fbf..2f9c6101e21c7 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
[ ... ]
> +$(obj)/nova-core/exports_nova_core_generated.h: $(obj)/nova-core/nova_co=
re.o FORCE
> +	$(call if_changed,exports)
> +
> +targets +=3D nova-core/exports_nova_core_generated.h
> +
> +$(obj)/nova-core/nova_core_exports.o: $(obj)/nova-core/exports_nova_core=
_generated.h
> +CFLAGS_nova-core/nova_core_exports.o :=3D -I $(objtree)/$(obj)/nova-core

[Severity: High]
Does this rule need to skip gendwarfksyms?=20

When CONFIG_MODVERSIONS and CONFIG_GENDWARFKSYMS are enabled, Kbuild comput=
es
symbol CRCs based on their DWARF type information. Since gendwarfksyms runs=
 on
nova_core_exports.o without skipping, it will generate CRCs based on the ty=
pes
defined in the generated C file rather than the actual Rust types.

To fix this, should nova_core_exports.o skip gendwarfksyms
($(obj)/nova-core/nova_core_exports.o: private skip_gendwarfksyms =3D 1) and
Kbuild support be added to run gendwarfksyms directly on the nova_core.o
Rust object, similar to how it is handled in rust/Makefile?

> diff --git a/drivers/gpu/nova-core/nova_core_exports.c b/drivers/gpu/nova=
-core/nova_core_exports.c
> new file mode 100644
> index 0000000000000..6e80ca9792ee5
> --- /dev/null
> +++ b/drivers/gpu/nova-core/nova_core_exports.c
[ ... ]
> +#include <linux/export.h>
> +
> +#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sy=
m)

[Severity: High]
Will this macro assign identical, unchanging CRCs to all exported Rust
symbols?

Because EXPORT_SYMBOL_RUST_GPL types all exported Rust symbols as extern int
sym, the resulting DWARF type for the symbols in the C object is simply int.

Consequently, gendwarfksyms calculates the CRC for the C int type and assig=
ns
it to all exported Rust symbols. Any subsequent ABI changes in the Rust
structs or functions that do not alter the mangled symbol name will not be
reflected in the CRC.

Could this silently allow incompatible, out-of-date dependent modules like
nova-drm to load and cause memory corruption?

> +
> +#include "exports_nova_core_generated.h"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-nova-expor=
ts-v4-0-e948c287407c@nvidia.com?part=3D3
