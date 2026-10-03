Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82737CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB5510E738;
	Sat,  3 Oct 2026 02:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b8Y+Lqas";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85E510E738
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:51:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 796D44346E;
 Sat,  3 Oct 2026 02:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323F41F000FF;
 Sat,  3 Oct 2026 02:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790995896;
 bh=hDiorZkpx0dN1X/60Z1pgAC2yt9+X3O7MCFBzlzS6vY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b8Y+LqasGRCiRAMJv8yJOgDfS5LmFb2LyZ3QHFLo8ReRjo38EYmUUg+qIWdWafS14
 OrMld2UxHlCb9YpvulhltpqKINYqeD5opOXYlvXEyH6EjnRAyQff49nzissR5hJ7Oj
 S0gJ4v8hPOd/KdTl/wZk7kO9235bGgGYN8GtvS8CUNmLTTVso2PV5kEAkF4b6LDnpi
 rrt/O/GIqaIK6HgV8eboSjqm1ZcPsCffXAK1R9CY3XcM/j55f9ugD9UziaMNtAkVNp
 a7GgBVQ+gRWy5aUnCve3JsVliG2SHeAVh6XdEmIoGP3JMLrZalflAS1aSWSQV9fIkL
 hfnnFu7r9uCNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] accel/qaic: Use reduced size allocation for FIFOs
To: "Carl Vanderlip" <carl.vanderlip@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003023818.1161666-7-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
 <20261003023818.1161666-7-carl.vanderlip@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:51:35 +0000
Message-Id: <20261003025136.323F41F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/qaic: job credits can exceed DRM scheduler credit limit
- [Medium] accel/qaic: missing __GFP_NOWARN in fallback allocation causes l=
og spam
--

commit 71c6cfc1950c4572f2fdf94ea37059d815f2f378
Author: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
Subject: accel/qaic: Use reduced size allocation for FIFOs

This commit modifies the allocation strategy for FIFOs in the qaic driver.
Instead of failing when a large DMA coherent pool allocation cannot be
fulfilled, it iteratively halves the requested size until the allocation
succeeds, allowing the DRM scheduler to break up submissions to fit availab=
le
memory.

[Severity: Medium]
In drivers/accel/qaic/qaic_control.c inside encode_activate around line 663,
there is a fallback allocation loop that calls dma_alloc_coherent with
GFP_KERNEL. Because the loop starts with a large allocation size and expects
it to potentially fail on fragmented systems before halving the size, will
this cause the page allocator to print stack traces and spam dmesg on each
expected failure?

Could the __GFP_NOWARN flag be added to the allocation request to prevent
this log spam when the higher order allocations predictably fail?

[Severity: High]
In drivers/accel/qaic/qaic_control.c inside encode_activate around line 671,
nelem is calculated based on the dynamically reduced size using the
QAIC_DBC_NELEM macro. This can result in a non-power-of-two queue size.

Later, in drivers/accel/qaic/qaic_sched.c inside set_dbc_scaling_ratio at
line 98, the credit_ratio is computed using DIV_ROUND_UP(QAIC_CREDITS, nele=
m).

If nelem is not a power of two, the rounding up means that a job requesting
the maximum number of elements in qaic_create_job (around line 156) will
calculate its total credits as (nelem - 1) multiplied by credit_ratio. Can
this total routinely exceed the QAIC_CREDITS limit and the DRM scheduler
maximum credit limit?

If a user submits a large execution request that triggers this, it appears
it would result in a dev_WARN and credit truncation within the DRM schedule=
r,
preventing the job from executing properly. How should this credit overflow
be prevented when dealing with non-power-of-two sizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003023818.1161=
666-1-carl.vanderlip@oss.qualcomm.com?part=3D6
