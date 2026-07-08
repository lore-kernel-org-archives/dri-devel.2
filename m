Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A15C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6975410E59C;
	Wed,  8 Jul 2026 11:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="kG6BYU2Q";
	dkim-atps=neutral
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310F710E59C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1783511282; x=1783770482;
 bh=rF5rAFH02RLKZzDzZ1bLDCSO4XouJrP65OPOBDB1eqA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kG6BYU2Qh4TleeZMxp3veuK1btD7gnywZETI28yf3RYRflFME6m7d5NERm//kzIPx
 pbYOe5oMge2SY4FwF4Im4IY3eumySgLle4yz6Ohn95PKsZYDp1n6wS5PrvcAESTeO8
 DVYZi9+VxPFTsJholJ4v+yUH9FS3H0amLaGiTi96LD7xfzaXM+ahsHEIkga1RmVzFS
 isQgJeWHiHNbzkVpssyfrwSMvXHPBkI/6YMOc7eMQq2VkG1DC9mH9gndUOa2/9FKCz
 JxBgODnFRsmJFntO9G7/IjgwLI/H9WWhXYf2OMmRoqlbpRWEDVkzYJQKWMRSoMCbGK
 kRMaZ07UN6YZg==
X-Pm-Submission-Id: 4gwGYp3DMrz1DFTD
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v3 0/3] implement GPU reset API
Date: Wed,  8 Jul 2026 14:47:53 +0300
Message-ID: <20260708114756.963735-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260708114358.957305-1-work@onurozkan.dev>
References: <20260708114358.957305-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 08 Jul 2026 14:43:15 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> Add support for scheduling GPU resets on a dedicated workqueue. Track=0D
> the reset state to avoid queueing another reset while one is already=0D
> pending or in progress.=0D
> =0D
> Use an SRCU based gate to block new hardware access once a reset is=0D
> scheduled and wait for current users before starting it. Run the=0D
> pre_reset() and post_reset() hooks around the reset sequence so driver=0D
> components can prepare for a reset and restore their state afterwards.=0D
> =0D
> Model the reset stages with a typestate pattern where each operation=0D
> consumes the current state and returns the next one. This keeps the=0D
> pre_reset(), GPU reset and post_reset() calls in order and prevents=0D
> a stage from being called twice accidentally.=0D
> =0D
> Stop new reset requests during teardown and drain any queued or running=0D
> reset work before releasing the device resources.=0D
> =0D
> Also move the existing synchronous reset sequence into the reset module=0D
> and use it for both the initial reset and scheduled resets.=0D
> =0D
> This implementation is WIP and will be followed with more work later. It=
=0D
> should be safe to land this series as there's no hardware using this API=
=0D
> yet.=0D
> =0D
> Based on 'commit 53441a9cae3c ("drm/tyr: program CSF global interface")'=
=0D
> from tyr-for-upstream with the following patch series on the ML:=0D
> 	- rust: workqueue: add cancel_sync support [1]=0D
> 	- rust: add SRCU abstraction [2]=0D
> 	- rust: workqueue: add ScopedQueue for lifetime bound items [3]=0D
> 	- Creation of workqueues in Rust [4]=0D
> =0D
> TODOs:=0D
>   - On post_reset() failure, we don't do anything for now. We should=0D
> 	unplug the GPU (that's what Panthor does) but we don't have the=0D
> 	infrastructure for that yet [5].=0D
>   - In schedule(), similar to panthor_device_schedule_reset(), we should=
=0D
>   	have a PM check but similar to the note above, we don't have the=0D
> 	infrastructure for that yet.=0D
> =0D
> Changes since v2:=0D
> 	- Replaced Work::disable_sync with Work::cancel_sync.=0D
> 	- Used type state pattern for reset stages.=0D
> 	- Using ScopedQueue with device lifetime instead of a static workqueue.=
=0D
> 	- Removed SRCU patch from this series.=0D
> =0D
> Changes since v1:=0D
>   - Removed OrderedQueue and using Alice's workqueue implementation [1] i=
nstead.=0D
>   - Added Resettable trait with pre_reset and post_reset hooks to be impl=
emented by=0D
>     reset-managed hardwares.=0D
>   - Added SRCU abstraction and used it to synchronize the reset work and =
hardware access.=0D
> =0D
=0D
Seems like I messed up the indentation. Sorry about that.=0D
=0D
=E2=80=93 Onur=0D
=0D
> v1: https://lore.kernel.org/rust-for-linux/20260313091646.16938-1-work@on=
urozkan.dev=0D
> v2: https://lore.kernel.org/rust-for-linux/20260416171728.205141-1-work@o=
nurozkan.dev=0D
> =0D
> Link: https://lore.kernel.org/all/20260617131731.145337-1-work@onurozkan.=
dev [1]=0D
> Link: https://lore.kernel.org/all/20260613065348.96750-1-work@onurozkan.d=
ev [2]=0D
> Link: https://lore.kernel.org/all/20260617144645.253444-1-work@onurozkan.=
dev [3]=0D
> Link: https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351=
c38f@google.com [4]=0D
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/29#note_=
3391826 [5]=0D
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28=0D
> =0D
> Onur =C3=96zkan (3):=0D
>   rust: workqueue: impl Send and Sync for OwnedQueue=0D
>   drm/tyr: clear stale IRQ state before soft reset=0D
>   drm/tyr: add GPU reset infrastructure=0D
> =0D
>  drivers/gpu/drm/tyr/driver.rs        |  39 ++--=0D
>  drivers/gpu/drm/tyr/reset.rs         | 323 +++++++++++++++++++++++++++=0D
>  drivers/gpu/drm/tyr/reset/hw_gate.rs | 298 ++++++++++++++++++++++++=0D
>  drivers/gpu/drm/tyr/tyr.rs           |   1 +=0D
>  rust/kernel/workqueue/mod.rs         |   8 +=0D
>  5 files changed, 644 insertions(+), 25 deletions(-)=0D
>  create mode 100644 drivers/gpu/drm/tyr/reset.rs=0D
>  create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
