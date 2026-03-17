Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D904FD7077
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F5810E1ED;
	Tue, 17 Mar 2026 10:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GEuFQVpp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDBB10E1ED;
 Tue, 17 Mar 2026 10:49:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB66560008;
 Tue, 17 Mar 2026 10:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6534BC4CEF7;
 Tue, 17 Mar 2026 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773744596;
 bh=zIXYt4MiSYtrZ/ljb1b2PTErSHLZeJRlzjd8rOa85Wg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=GEuFQVppox1B2Wla3Jmq+DSI1wc+jSic+ZFpjguH/c0Y6jc/xEAAvM9W9lDReDO6n
 NaV0/NQZVi9MTci/Pas8fUNCManAhUactuZSJn6qPbaKpymRdyOWbpzNUdXfheg5hv
 9ZF9ntagjKViTR70j5YWJQtq0UqriEHQtEz5+vKMeId9wLJuY9k2TBMI6YanzhhfmR
 C7c6VfHqh1S64pcT6Po9NoiUAV/pnh+lKhWzJUgR3gdpqxOFG+U/sZs5iHf5eeZjLO
 L/FMR3W68MDybsNM7j7aF5sUZKn4pkpcmg7UwTD+xfZ5D4kCH7c2/jemFHvP/JDsen
 VEcw+34dTequA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 11:49:53 +0100
Message-Id: <DH4ZZD12V0R6.2G7IIL87QTK0S@kernel.org>
Subject: Re: [PATCH 6/9] gpu: nova-core: generalize `flush_into_kvec` to
 `flush_into_vec`
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-6-86648e4869f9@nvidia.com>
 <093ca23e-7081-42db-a202-0a42c51741a3@kernel.org>
 <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
 <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
 <DH47AVPEKN06.3BERUSJIB4M1R@kernel.org>
 <DH4OM17DJ47V.3NJG7G02O7P1L@nvidia.com>
In-Reply-To: <DH4OM17DJ47V.3NJG7G02O7P1L@nvidia.com>
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

On Tue Mar 17, 2026 at 2:55 AM CET, Alexandre Courbot wrote:
> We shouldn't be doing that - I think we are limited by the current
> CoherentAllocation API though. But IIUC this is something that I/O
> projections will allow us to handle properly?

Why do we need projections to avoid UB here? driver_read_area() already eve=
n
peeks into the firmware abstraction layer, which is where MsgqData technica=
lly
belongs into (despite being trivial).

	let gsp_mem =3D &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
	let data =3D &gsp_mem.gspq.msgq.data;

Why do we need I/O projections to do raw pointer arithmetic where creating =
a
reference is UB?

(Eventually, we want to use IoView of course, as this is a textbook example=
 of
what I proposed IoSlice for.)

Another option in the meantime would be / have been to use dma_read!() and
extract (copy) the data right away in driver_read_area(), which I'd probabl=
y
prefer over raw pointer arithmetic.

But in any case, this can (and should) be fixed even without IoView.

Besides that, nothing prevents us doing the same thing I did for gsp_write_=
ptr()
in the meantime to not break out of the firmware abstraction layer.

> This is guaranteed by the inability to update the CPU read pointer for
> as long as the slices exists.

Fair enough.

> Unless we decide to not trust the GSP, but that would be opening a whole
> new can of worms.

I thought about this as well, and I think it's fine. The safety comment wit=
hin
the function has to justify why the device won't access the memory. If the
device does so regardless, it's simply a bug.

>> I don't want to merge any code that builds on top of this before we have=
 sorted
>> this out.
>
> If what I have written above is correct, then the fix should simply be
> to use I/O projections to create properly-bounded references.

I still don't think we need I/O projections for a reasonable fix and I also
don't agree that we should keep UB until new features land.
