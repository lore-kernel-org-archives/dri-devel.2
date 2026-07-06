Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B5EC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF0610EA82;
	Mon,  6 Jul 2026 19:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="T6AUbiql";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E208310EA82
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ykrx/AD1Q5nUVeRD7hiOmEvyCIM5rJDE3m3h8U4cAAU=; b=T6AUbiqlieMPuSa0vqwCucltfO
 BZ/7NcwOhSsEXD/JL21wFQS/X2kH3+RdVD0PO7bibGZuX8jdlgKKwm1l5BM5JlpP755HHbCxPFaSt
 DyqjcLNjt7nUoaACcC4XNtddzlCvFPgl520SheGqlWy3DAwfSYliXaWCi46YX0OAVNaC2Kmvogjoq
 TRNEt8N1sfIdKmexEvZTn2sQT4XFTlnvtSPomvLZPpVrMAnWJB3f/R0AcvRCYogK2cLtzkvj4MPFl
 4g4WVOHep1qbPfvGo57e174eAF3UedJoQkF5CMwyxxk+19j7NRlYuUTNUHE7WGqs98haSVDpTiKY+
 J5Wy003Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ross Cawston <ross@r-sc.ca>, Ross Cawston <ross@r-sc.ca>
Subject: Re: [PATCH 0/5] accel/rocket: Support standalone DPU/PPU tasks and
 pipelined workloads
Date: Mon, 06 Jul 2026 21:27:34 +0200
Message-ID: <11972621.MucGe3eQFb@diego>
In-Reply-To: <20260217-accel-rocket-clean-base-v1-0-d72354325a25@r-sc.ca>
References: <20260217-accel-rocket-clean-base-v1-0-d72354325a25@r-sc.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Ross,

Am Dienstag, 17. Februar 2026, 22:39:48 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Ross Cawston:
> The Rocket NPU supports multiple workload types beyond convolutional jobs:
> - Standalone post-processing (PPU) tasks (pooling, element-wise ops, etc.)
> - Pipelined DPU=E2=86=92PPU workloads
>=20
> The current driver has limitations preventing these from working correctl=
y:
> - CNA/Core S_POINTER registers are always written, re-arming stale state
> - Interrupt handling is hard-coded to DPU only, causing PPU timeouts
> - Ping-pong mode is always enabled
>=20
> This series fixes these while preserving backward compatibility.
>=20
> Patch breakdown:
> 1/5 Fix error path in BO creation (cleanup/fix)
> 2/5 Enable ping-pong mode only for multi-task jobs (optimization)
> 3/5 Add per-task int_mask and flags to UAPI/kernel (new knobs)
> 4/5 Skip CNA/Core S_POINTER init for standalone tasks
> 5/5 Use per-task interrupt mask and handle PPU completions
>=20
> Derived from vendor BSP behavior.
>=20
> Tested on OrangePi 5 Ultra and Radxa Rock 5B (RK3588).
>=20
> Thanks for review!

Extending Rocket's range sounds really cool.

Curious me wants to know how to test these new parts.
I was assuming some mesa thing, but didn't find a PR for it, so it
must be something else?

Thanks a lot
Heiko


> Signed-off-by: Ross Cawston <ross@r-sc.ca>
> ---
> Ross Cawston (5):
>       accel/rocket: Fix error path in BO creation
>       accel/rocket: Enable ping-pong mode only for multi-task jobs
>       accel/rocket: Add per-task flags and interrupt mask to UAPI and ker=
nel
>       accel/rocket: Skip CNA/Core S_POINTER initialization for standalone=
 tasks
>       accel/rocket: Use per-task interrupt mask and handle PPU completion=
 interrupts
>=20
>  drivers/accel/rocket/rocket_gem.c |  2 +
>  drivers/accel/rocket/rocket_job.c | 80 ++++++++++++++++++++++++++++++---=
=2D-----
>  drivers/accel/rocket/rocket_job.h |  2 +
>  include/uapi/drm/rocket_accel.h   | 25 ++++++++++++
>  4 files changed, 92 insertions(+), 17 deletions(-)
> ---
> base-commit: 17f8d2009367c3da82882f70ccbdca9f8c7b5f20
> change-id: 20260217-accel-rocket-clean-base-57c0e88651e6
>=20
> Best regards,
>=20




