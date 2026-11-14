Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006D606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg6k+3qH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1123A10E81E;
	Sat, 14 Nov 2026 16:09:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF9710E8A6;
 Sat, 14 Nov 2026 16:09:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 357F26125A;
 Sat, 14 Nov 2026 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823BE1F000C4;
 Sat, 14 Nov 2026 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794672562;
 bh=g2mwoviM3gWZDsBgYq6cZVNpjcLJdB0d4Fk6H1RcDHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bg6k+3qHXBlLMrYh4GUg3XfgETcgAtGlji0dQqvLgA6j3n5MFqgfVDEP+n5bD/EJk
 8V8feVaVyqAMNBde/Hl0keLqm2WtO/yqfxAjNbgtGV6CUutaPwVBOrz2bAdxD158f1
 UOzxUuwdDRyYBpLv1dhQcAKeURpFwCXJ6oa10GG0kGJAW1Tby9vRNNQ6DfUc60mHJ8
 7H/lOKluSRBaFzh5oLKJ29wrlGRyAq6MsWk8ca7pfSoMJvAubSJVxsDJe1TgE5t5gM
 r80zeltItkwuqHKMASZEOTKS28d0jge440Jlwnxz215llHPiOwyS3i/i9E1KZe4XIQ
 ofDy67AOvWqGA==
Message-ID: <sashiko-outbox-214737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] overflow: Add offsetofend() variant of
 struct_offset()
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261113-offsetof-v3-1-714df7053893@arm.com>
References: <20261113-offsetof-v3-0-714df7053893@arm.com>
 <20261113-offsetof-v3-1-714df7053893@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:09:22 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] coccinelle: struct_offsetof.cocci lacks virtual mode
  declarations and guards
- [Low] coccinelle: struct_offsetof.cocci lacks tools/ and overflow.h
  exclusions
--

commit c626ce371da764dd2d49c4588f1e87be178e9327
Author: Bence Csokas <bence.csokas@arm.com>

overflow: Add offsetofend() variant of struct_offset()

This commit adds a struct_offsetofend() helper macro to
include/linux/overflow.h and a Coccinelle semantic patch to convert
offsetof() and offsetofend() calls using typeof(*ptr).

> diff --git a/scripts/coccinelle/api/struct_offsetof.cocci b/scripts/cocci=
nelle/api/struct_offsetof.cocci
> new file mode 100644
> index 0000000000000..6cbc5596d673d
> --- /dev/null
> +++ b/scripts/coccinelle/api/struct_offsetof.cocci
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use struct_offsetof() family of macros
> +///
> +// Confidence: High
> +@@
> +expression ptr, member;
> +@@
> +- offsetof(typeof(*ptr), member)
> ++ struct_offset(ptr, member)

[Severity: Low]
Does struct_offsetof.cocci need virtual mode declarations and mode guards
on its rules?

scripts/coccicheck checks each script for "virtual $MODE" before running
spatch, so without declarations such as "virtual patch", make coccicheck
skips this file with a warning in every mode.  When invoked directly with
COCCI=3Dscripts/coccinelle/api/struct_offsetof.cocci, the unguarded patch
rules also produce no output in the default report mode and emit raw
replacement diffs in context mode.

> +@@
> +expression ptr, member;
> +@@
> +- offsetofend(typeof(*ptr), member)
> ++ struct_offsetofend(ptr, member)

[Severity: Low]
Will applying these rules across the tree break builds under tools/ or
rewrite the macro definitions in include/linux/overflow.h?

tools/include/linux/overflow.h does not define struct_offset() or
struct_offsetofend(), so converting matches in files such as
tools/perf/util/header.c and
tools/testing/selftests/bpf/progs/test_cls_redirect.c introduces calls to
undeclared macros unless tools/ and samples/ are excluded via rule
dependencies like other scripts in scripts/coccinelle/api/.  Running spatch
with --include-headers or on include/linux/overflow.h also rewrites the
struct_offset() and struct_offsetofend() definitions themselves into
recursive self-references.

In addition, matching typeof(*ptr) instead of typeof(*(ptr)) leaves
redundant parentheses on parenthesized expressions such as
offsetof(typeof(*(reg)), iobase_addr) in drivers/scsi/qla2xxx/qla_tmpl.c,
and the "///" header comment names a nonexistent struct_offsetof() macro.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-offsetof-v=
3-0-714df7053893@arm.com?part=3D1
