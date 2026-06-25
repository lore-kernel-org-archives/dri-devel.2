Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8168CDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1575310E241;
	Thu, 25 Jun 2026 19:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jL0/ednT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC67A10E241
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:11:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F51B40644;
 Thu, 25 Jun 2026 19:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C221F000E9;
 Thu, 25 Jun 2026 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782414667;
 bh=jGIqx0R2fTVQ/3NhAF4BR8Vdtp16DQxVKnZHFgyUeNA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jL0/ednTOZB/NP8qswtAuYSkny3tgInhnvzuNLJ1DvxzhY9/d+riaNbJcnlnF0YYU
 tU5xmxzNcJipL6YX4/AxSHKhRTaA206h9PEvaFBlIyfT7fquGnxk4wYF+VfKo3ZThl
 WUFCyOfOdoXOOgpIft/NMkpywUrvBE6XLymHMRD4fHqOszLvyz/9jJSlFRCufcqBDD
 LUEqpq546dFWQbdfX17nB0tKxbqN41y/hWAeOgMH+8IRKMI5zdviJNh1/EtCHYKcf6
 Zz+o4SmC/5Nu1HL5Nuxa5GrU/r1N3fmNodBy5SEyowIccqn+I1iBSPqsdKMMYhVmB/
 oh2Zn8SkAsrXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/nova: remove unused trait in commands.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260625190553.7245-8-niyudi.honda@usp.br>
References: <20260625190553.7245-1-niyudi.honda@usp.br>
 <20260625190553.7245-8-niyudi.honda@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:11:06 +0000
Message-Id: <20260625191107.20C221F000E9@smtp.kernel.org>
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
- [Low] Missing trailing comma and space in the import block.
--

commit 24496bb80f7a04aa163bf36fdd55b1fa6b6ff3ac
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: remove unused trait in commands.rs

This commit removes an unused transmute::FromBytes implementation for
GspInitDone in the nova-core driver. It also cleans up the associated
imports in commands.rs.

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
This isn't a bug, but should this import retain the trailing comma and space
before the comment? Keeping the trailing comma (e.g., transmute::AsBytes, /=
/)
prevents noisier diffs when new imports are added later, and adding a space
matches typical formatting conventions for vertical import blocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625190553.7245=
-1-niyudi.honda@usp.br?part=3D7
