Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552A5F54AC6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911A010E681;
	Tue, 24 Mar 2026 14:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PsV9k8ae";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3590A10E681
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 14:45:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F39B343817;
 Tue, 24 Mar 2026 14:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4373CC2BC87;
 Tue, 24 Mar 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774363533;
 bh=uzmG4qKnl9xfs465wjDkiQEG+XgLbUrZelI4PwG/AWk=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=PsV9k8ae3a9bnrcjbN6HddkjuGfikN7b39ITMB36/LiiVdskVSkRNHBV/0rPWI5Rw
 Usul9NLbSek2FoOGSmx7y9J4E+WWntNtXZgdjPhHBy6UTTH084Z1PwAEZqwTO2U3Mr
 gttILdOYlX223jkvDsB/KkzL20HCNKvEHHUId9qTlaFjy+WFkqd+Epu8k1Ow9Cr2j0
 /FGBj6TX4kEnIEk1UdGp8EDYgLcmEh3yCDyx2wPWCsIv6md8vrb6TP30wlTHul1gTN
 EZ52SZtTBZm0VQOqQS/8Nzy1ywRcyEz69H/CzDsiCKhemlN8dEdPgy6H/n4o/5tb06
 2cK9MK8kKJdiw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 15:45:29 +0100
Message-Id: <DHB3DKHRDIZS.WXMYD9ISB0QU@kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
In-Reply-To: <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
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

On Tue Mar 24, 2026 at 3:44 PM CET, Alexandre Courbot wrote:
> Should we apply or drop this patch meanwhile? I/O projections are still
> undergoing review, but I'm fine with dropping it if Danilo thinks we can
> live a bit longer with that UB. It's not like the driver is actively
> doing anything useful yet anyway.

We should pick this up regardless, I/O projections won't we usable for drm-=
rust
this cycle.

Thanks,
Danilo
