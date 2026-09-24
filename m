Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18BBC98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4679E10F355;
	Thu, 24 Sep 2026 07:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jQBUq2aO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0E610F34E;
 Thu, 24 Sep 2026 07:11:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5A71601FF;
 Thu, 24 Sep 2026 07:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FA71F000FF;
 Thu, 24 Sep 2026 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790233876;
 bh=+YrfP9t8yw4kCZx/I//SLISSglkH98Ip7xQB3uLQ+78=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jQBUq2aO2+oRKGQc4Ul12SkhvjaXttb8SXIsR6cD1fh7XuPMYSqYNVJzC6OECyeYB
 1RxSVbOGWMiClfWnOl55xFqQ3pSYSdY4mN+ih2AAsoVlUqPaQN+1nMRFkUJOkOc3ij
 AsqiQdYkehqOtyYouTc348E4A7PJ4iaLzSMjgNlpX4ruIRWqe6xoFGTV5CbfWPJHSA
 toJtez73hNjaBcXbsgY/JLwu81xS94vrYhLLnWsmBczSJUKYzg8RaXEpYmyfOdRA6a
 Sl+vPqzb+VY8kTGe8XmUOLibT+dSlsl9MTwiq7eS5bi/ha+XQY6HMuQUCC8+1u/c9O
 N9p1Wjcqe3RWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/11] mm/Kconfig: changes for migrate on fault for
 device pages
To: mpenttil@redhat.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924065313.899730-2-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <20260924065313.899730-2-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:11:15 +0000
Message-Id: <20260924071116.60FA71F000FF@smtp.kernel.org>
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
- [Low] mm: DEVICE_MIGRATION selects HMM_MIRROR without depends on MMU cons=
traint
--

commit d98d7483ad3c2031ffcf056a41d08580cd84769d
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/Kconfig: changes for migrate on fault for device pages

This commit modifies the memory management Kconfig to have DEVICE_MIGRATION
explicitly select HMM_MIRROR. This ensures HMM is enabled for the unified
HMM and migrate_device page table walks.

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 604c58199acbf..b7a485beb9a78 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -687,6 +687,7 @@ config MIGRATION
> =20
>  config DEVICE_MIGRATION
>  	def_bool MIGRATION && ZONE_DEVICE
> +	select HMM_MIRROR

[Severity: Low]
Does selecting HMM_MIRROR under DEVICE_MIGRATION require an explicit
dependency on MMU?

When a Kconfig symbol uses select, it is expected to have dependencies
compatible with the selected symbol's dependencies. HMM_MIRROR explicitly
depends on MMU, but DEVICE_MIGRATION lacks an explicit depends on MMU or
depends on MIGRATION constraint.

While DEVICE_MIGRATION is currently only enabled via its default expression
which transitively requires MMU, a default value expression does not act as
a dependency constraint against a select operation. If a future patch were
to forcefully select DEVICE_MIGRATION on a non-MMU architecture, it would
bypass the def_bool and enable HMM_MIRROR without its required MMU
dependency.

Could this structural risk be avoided by adding an explicit depends on MMU
to DEVICE_MIGRATION?

>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	bool

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065313.8997=
30-1-mpenttil@redhat.com?part=3D1
