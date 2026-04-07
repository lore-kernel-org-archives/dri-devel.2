Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C9FEEF49
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EB210E07B;
	Tue,  7 Apr 2026 14:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F6cs3Pgk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C57110E07B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:22:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BDA6600AC;
 Tue,  7 Apr 2026 14:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E392AC116C6;
 Tue,  7 Apr 2026 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775571729;
 bh=M4K6I43OBYzV+FMwGWYjjiE2PvKsU16zwhvg6x3f68o=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=F6cs3PgkvGLk4LZwR11KqoIMvtLJMDXlnXCH3wYh4IUHcT6kJqlJKoqTxRoBVHHYG
 fHijR5kWo7RK279fzh5WK94Bhy/gncjo208dMeaVhVVJPfC/bHjDP4aohjvl71o5SR
 hUSbiZnnl/3ON5rJ42mAGHmsAu10OzhjhJVyFL1f8mWXm5TBADsiiFkyKeJcqdlcPx
 hOhQ4rPRsHVhLTK0W1ke4Y+GArgvL9pQYL/rBW+XY3e9hQK6BX1nMd7HpspXF1BL0y
 fo7WGeoo1DOaYY0FbapmSumJNrfbfJzDNAaHeSsosBz3mLg+NrTlFFruJWgNfy1ouU
 6i66PP2StLWcA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 16:22:05 +0200
Message-Id: <DHMZN9TEXQT5.3FIWZRAQKUO9T@kernel.org>
Subject: Re: [PATCH v2] gpu: nova: require little endian
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
In-Reply-To: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
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

On Tue Apr 7, 2026 at 5:59 AM CEST, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
>
> Make this explicit in Kconfig.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
>
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.
> ---
> Changes in v2:
> - Also add to nova-drm (Thanks Danilo)
> - Did not take Reviewed-by + Acked-by because commit changed
>   substantively
> - Link to v1: https://patch.msgid.link/20260406-fix-kconfig-v1-1-8f634499=
f7f0@nvidia.com

Thanks for the new version -- I have one additional question in [1]. Otherw=
ise,
going to pick up once -rc1 is out.

[1] https://lore.kernel.org/all/DHMVA3S2MZWV.1JN7WUBZLRWLV@kernel.org/
