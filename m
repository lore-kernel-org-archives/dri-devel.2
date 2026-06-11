Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF64CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3585210E60E;
	Thu, 11 Jun 2026 17:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KQF8l7mM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F4B10E60E
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B7FA600AA;
 Thu, 11 Jun 2026 17:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA451F00893;
 Thu, 11 Jun 2026 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781200478;
 bh=Da/+XeWrfw2jIH5jv4uc6acrrte8hVk38amU2xgKWuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KQF8l7mMnjKFOAZXyXicM+mxJmq8DnBqWtnq7dVzCAniGUhwws+qmD9oNpZLbwqb8
 NR9v3ejpwVO5A6EjvxZjkoAHBR7RQBq3ldj42iBj9qQC6qDBeYEO8um9wbQ2Agd7tg
 TFBaD2XrrZntozHgIN3yRVHqG+SnrVElxoQ46wOmgeNm2MF1C8iO+T8ZlLOhj39aQN
 FRqjOtFun0QtbgfXbhSkA2I0ACmPAdg7+FnG8/dn0ma974tiSHIkvteTn6bzR6q55Y
 futR1P0MZQWiAkR97lVUKksdrbe5zVW9jq8als/Dym89QVwM6ZhP28/z2FLL752PhX
 17L7wKx4HJOIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/20] rust: io: remove `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-10-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-10-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:54:37 +0000
Message-Id: <20260611175438.0EA451F00893@smtp.kernel.org>
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
- [Low] Incorrect vertical import sorting in the `devres.rs` doc-comment.
--

commit 44ae5967f8fb0af22e020970c5e4e5cc392db95a
Author: Gary Guo <gary@garyguo.net>

Io trait is now very easy to implement. Thus, implement it on Bar and IoMem=
 directly and remove the MmioOwned struct.

This commit simplifies the Io trait usage by implementing it directly
on Bar and IoMem. It removes the intermediate MmioOwned struct and
updates the relevant device resource documentation and examples to
reflect these changes.

> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index aed0c994fd30..3545ffc5345d 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,8 +68,9 @@ struct Inner<T> {
>  ///     devres::Devres,
>  ///     io::{
>  ///         Io,
> -///         MmioOwned,
> +///         Mmio,
>  ///         MmioRaw,
> +///         MmioBackend,

[Severity: Low]
This isn't a bug, but the imports in this documentation block appear to be
out of alphabetical order. According to the Rust kernel coding guidelines
for vertical imports, shouldn't MmioBackend be placed before MmioRaw?

>  ///         PhysAddr,
>  ///         Region, //
>  ///     },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D10
