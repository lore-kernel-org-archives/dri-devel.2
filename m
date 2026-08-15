Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A4DC5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 10:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5C410E1B2;
	Sat, 15 Aug 2026 10:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="DsTeuPGs";
	dkim-atps=neutral
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F6E10E1B2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1786790115; x=1787049315;
 bh=PVGSPdDnUjSi6CJoIcbyz8J0YkONwU7GxlusMmnt26M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=DsTeuPGssJrfxoLWmD+E1M6LbTy5iL5HJvCXRaz+i+MqgdrMqibQn2tSUqH2SmmW2
 0tWHh+YQa03I6jI5LS98HviqlRs2cn34+g8Sk7gMvIgMxlLThKuMlcgUE3otQYkMWs
 qYDBrs8VoVfxCwcGOmTAOwkiH3fOIL52mbaW7Iwe+vzWJHGvZ44EuotJZMFyvij0tq
 D1l46OFpUF9GMVUcBQtQTNuTBduzBdZHbcA9KHfxRgipeE2jK2EvrUC6CQgGTIp0Dz
 j7JY7SWWZujs3SCogrQpBzSmgmJkarIuKnfwQTdVm4FjwzO4cPhtIhAJ0A1HW2SBdk
 RqCSNrveu0q7Q==
X-Pm-Submission-Id: 4hMb8K0SgVz1DFFQ
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v4 0/4] drm/tyr: GPU reset infrastructure
Date: Sat, 15 Aug 2026 13:34:40 +0300
Message-ID: <20260815103511.238176-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
References: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
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

On Sat, 15 Aug 2026 13:23:56 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> Add support for scheduling GPU resets on a dedicated workqueue. Track=0D
> the reset state to avoid queueing another reset while one is already=0D
> pending or in progress.=0D
> =0D
> Use an SRCU based gate with mutex-protected reader admission to block=0D
> hardware accesses while reset work runs and wait for current users=0D
> before resetting.=0D
> =0D
> Stop new reset requests during teardown and drain any queued or running=0D
> reset work before releasing the device resources.=0D
> =0D
> This is the initial reset infrastructure only. It is not wired to a reset=
=0D
> source yet as those will follow in separate work.=0D
> =0D
> Based on 'commit 53441a9cae3c ("drm/tyr: program CSF global interface")'=
=0D
> from tyr-for-upstream with the following patch series on the ML:=0D
>   - rust: workqueue: add cancel_sync support [1]=0D
>   - rust: add SRCU abstraction [2]=0D
>   - rust: workqueue: add ScopedQueue for lifetime bound items [3]=0D
>   - Creation of workqueues in Rust [4]=0D
> =0D
> TODOs:=0D
>   - On reset failure, we don't do anything for now. We should unplug=0D
> 	  the GPU (that's what Panthor does) but we don't have the infrastructur=
e=0D
>     for that yet [5].=0D
>   - In schedule(), similar to panthor_device_schedule_reset(), we should=
=0D
>   	have a PM check but similar to the note above, we don't have the=0D
>     infrastructure for that yet.=0D
> =0D
> Changes since v4:=0D
>   - Moved iomem behind the HwGate.=0D
>   - Renamed the guard names in hw_gate (after the iomem patch, I realized=
=0D
>     the old names were confusing).=0D
> =0D
> Changes since v3:=0D
>   - Dropped Resettable, ActiveHwState, pre/post-reset hooks and typestate=
.=0D
>   - Removed ResetState::Enqueueing and teardown spinning.=0D
>   - Replaced fail-fast try_access() and epoch tracking with a blocking=0D
>     hardware-access gate.=0D
>   - Used b4 for the prerequisites.=0D
> =0D
> Changes since v2:=0D
>   - Replaced Work::disable_sync with Work::cancel_sync.=0D
>   - Used type state pattern for reset stages.=0D
>   - Using ScopedQueue with device lifetime instead of a static workqueue.=
=0D
>   - Removed SRCU patch from this series.=0D
> =0D
> Changes since v1:=0D
>   - Removed OrderedQueue and using Alice's workqueue implementation [1]=0D
>     instead.=0D
>   - Added Resettable trait with pre_reset and post_reset hooks to be=0D
>     implemented by reset-managed hardwares.=0D
>   - Added SRCU abstraction and used it to synchronize the reset work and=
=0D
>     hardware access.=0D
> =0D
> v1: https://lore.kernel.org/rust-for-linux/20260313091646.16938-1-work@on=
urozkan.dev=0D
> v2: https://lore.kernel.org/rust-for-linux/20260416171728.205141-1-work@o=
nurozkan.dev=0D
> v3: https://lore.kernel.org/all/20260708114358.957305-1-work@onurozkan.de=
v=0D
> v4: https://lore.kernel.org/all/20260813-tyr-reset-impl-v4-0-b36fcd0805b2=
@onurozkan.dev=0D
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
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> ---=0D
> Onur =C3=96zkan (4):=0D
>       rust: workqueue: impl Send and Sync for OwnedQueue=0D
>       drm/tyr: clear stale IRQ state before soft reset=0D
>       drm/tyr: add GPU reset infrastructure=0D
>       drm/tyr: put iomem behind the hardware gate=0D
> =0D
>  drivers/gpu/drm/tyr/driver.rs            |  61 +++-----=0D
>  drivers/gpu/drm/tyr/fw.rs                |  16 +-=0D
>  drivers/gpu/drm/tyr/mmu.rs               |   9 +-=0D
>  drivers/gpu/drm/tyr/mmu/address_space.rs |  49 +++---=0D
>  drivers/gpu/drm/tyr/reset.rs             | 252 +++++++++++++++++++++++++=
++++++=0D
>  drivers/gpu/drm/tyr/reset/hw_gate.rs     | 102 +++++++++++++=0D
>  drivers/gpu/drm/tyr/tyr.rs               |   1 +=0D
>  rust/kernel/workqueue/mod.rs             |   8 +=0D
>  8 files changed, 421 insertions(+), 77 deletions(-)=0D
> ---=0D
> base-commit: 53441a9cae3c4be552fa8aefa6e61b0f1bceb8a5=0D
> change-id: 20260813-tyr-reset-impl-93e951f996b4=0D
> prerequisite-message-id: <20260312-create-workqueue-v4-0-ea39c351c38f@goo=
gle.com>=0D
> prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78=0D
> prerequisite-patch-id: 0bf6ae4abcef7090d0e48921d6ec627a59dc6a7a=0D
> prerequisite-patch-id: f2bd17b7ba9f4626ddec56fec8e108872ddc6af1=0D
> prerequisite-message-id: <20260617144645.253444-1-work@onurozkan.dev>=0D
> prerequisite-patch-id: 5b966d09cfd455dd09fb0911d174b123efa02a16=0D
> prerequisite-message-id: <20260613065348.96750-1-work@onurozkan.dev>=0D
> prerequisite-patch-id: 9e1efee190d212ba1b01cd0acb5a4357e0b4da42=0D
> prerequisite-patch-id: 26aba035f4d1e212fa6ea7078095febefff5c5ba=0D
> prerequisite-patch-id: ffa25d5aadec4c04589af2bdd59a9c022f0fc9b0=0D
> prerequisite-patch-id: c2e05a4ac9d665d331952b291a622df6be673e41=0D
> prerequisite-patch-id: c14a4bd8a68b045356d61f7fa94690bd037ad08b=0D
> prerequisite-message-id: <20260617131731.145337-1-work@onurozkan.dev>=0D
> prerequisite-patch-id: b40e7a218c4e0467933e83c45b09eb78c7ebace2=0D
> =0D
=0D
The version prefix is wrong on this series. It's not V4; it's V5. I am=0D
not sure if I should re-send the whole series with the correct prefix.=0D
=0D
Sorry,=0D
Onur=0D
