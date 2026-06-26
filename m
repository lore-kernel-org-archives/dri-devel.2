Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDCAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EA610F6A5;
	Fri, 26 Jun 2026 15:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BDWpRwcS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58AE10F67C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:06:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28AF1600C8;
 Fri, 26 Jun 2026 15:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A111F00A3A;
 Fri, 26 Jun 2026 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486387;
 bh=nWdhka9vlxHskt8+WKq6JmVRC3RuOXuW2e3AQwKJTbU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BDWpRwcSSsnPL1I9mSjsGmZUrxnyEcNzjTiaJJR/QJz8kswphtz9J4FRolfT+tdIl
 6oIMcv2x3DQIk0u8nW4LS+dH8lkZl/F319BQ2PigSyHuFnqFbS1Vg8tENU9f2Jsjre
 LR/t7ENiZTYqAPcfWYjL9cvspKvgDN4pcWWNzWbmXQVU8dsLZadBz8shw+4GXDeR6A
 HnK+aoHaqANJgzFFifSKFhZ/QSP8hyaliwe5OoM5W1WZJh/oYjovCikX1Uz4H5JkI2
 QUAYGUMU/7uvYvvFgRMRd+FMSgzxHIhsJaJQTRNm4tQ14Wzt6KQ7nXq/4Lc4nE5Yvl
 0SxWwJs+dAGkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:06:26 +0000
Message-Id: <20260626150627.30A111F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Data corruption in GSP command queue due to missing memory barrier=
 before updating the ring buffer write pointer.
--

commit abd2f0cd14180222d86d47f37c313be60a30d773
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: use I/O projection for cleaner encapsulation

This commit refactors the nova-core GSP driver to use the io_project!,
io_read!, and io_write! macros for memory-mapped I/O access. It replaces
the previous dma_read! and dma_write! usage to enforce better encapsulation
for PTE arrays and message queues.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -438,12 +441,17 @@
>      // Informs the GSP that it can process `elem_count` new pages from t=
he command queue.
>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
> -        super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
> +        let tx =3D io_project!(self.0, .cpuq.tx);
> +        let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count=
) % MSGQ_NUM_PAGES;
> +        MsgqTxHeader::set_write_ptr(tx, wptr);
> +
> +        // Ensure all command data is visible before triggering the GSP =
read.
> +        fence(Ordering::SeqCst);

[Severity: High]
This is a pre-existing issue, but is it possible that the memory barrier is
placed too late in this function?

In advance_cpu_write_ptr(), the fence(Ordering::SeqCst) is placed after
updating the ring buffer's write pointer via set_write_ptr(). Since the
payload is written to coherent memory using normal memory stores while the
write pointer uses a volatile store, weakly-ordered CPUs might reorder the
operations.

If the GSP firmware polls the write pointer before the payload writes are
globally visible, could it read uninitialized or stale data? Should the
fence be placed before the set_write_ptr() call to prevent this race?

>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D17
