Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E2606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=WYrx19jn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 167DD10FA7A;
	Wed, 11 Nov 2026 10:15:39 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0717210E9E7
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1794391671; x=1794650871;
 bh=YeX7nxnzoiug76CLEvqV8toUAsSHur5IcXgBBibQZw0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=WYrx19jnMFiZZEJXDTwIdZY68t/mki1lmlJXKtLV7uFjodBwxl7MqOf9xDtGsV/no
 DH7KiCD8CM5Hw+5XqiB4I3m1fzX3nXV3IL5j9nZrmbVCl5w3D3BcGUWcUFEEB8AMrB
 P7vyIz4tYEKWLW7Cw1SMWxwW1r1PRP3cZJrJswBmBnmOBEHmX5GZh6ijbDMXSqc4lw
 zU9ygDJcwxzYWP2ZlmCg/a0/0SjTXL8ZZurckHd3mMQN/g0vUnerInHCjJmGPhZte7
 tdj3znZz6lMO7Ueo7EVjF8PMfZcZC9P6jfFlZXZbFij9qL7y3HPfviPX9c+ID2Cv62
 euImfCqWdIiFA==
X-Pm-Submission-Id: 4jPfN422zNz1DDrn
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v7 0/3] drm/tyr: GPU reset infrastructure
Date: Wed, 11 Nov 2026 13:07:41 +0300
Message-ID: <20261111100745.3929894-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <70AFEE33-C637-4D49-88F1-9DF3A9BBF097@collabora.com>
References: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
 <70AFEE33-C637-4D49-88F1-9DF3A9BBF097@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 23 Sep 2026 10:56:48 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> =0D
> =0D
> > On 12 Sep 2026, at 07:39, Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > =0D
> > Add support for scheduling GPU resets on a dedicated workqueue. Track=0D
> > the reset state to avoid queueing another reset while one is already=0D
> > pending or in progress.=0D
> > =0D
> > Use an SRCU based gate with mutex-protected reader admission to block=0D
> > hardware accesses while reset work runs and wait for current users=0D
> > before resetting.=0D
> > =0D
> > Stop new reset requests during teardown and drain any queued or running=
=0D
> > reset work before releasing the device resources.=0D
> > =0D
> > This is the initial reset infrastructure only. It is not wired to a res=
et=0D
> > source yet as those will follow in separate work.=0D
> > =0D
> > Based on 'commit 53441a9cae3c ("drm/tyr: program CSF global interface")=
'=0D
> > from tyr-for-upstream with the following patch series on the ML:=0D
> >  - rust: add SRCU abstraction [1]=0D
> >  - rust: workqueue: add cancel_sync support [2]=0D
> > =0D
> > TODOs:=0D
> >  - On reset failure, we don't do anything for now. We should unplug=0D
> >    the GPU.=0D
> >  - In schedule(), similar to panthor_device_schedule_reset(), we should=
=0D
> >    have a PM check but similar to the note above, we don't have the=0D
> >    infrastructure for that yet.=0D
> > =0D
> > Changes since v6:=0D
> >  - Acquire the hardware gate once per address-space operation and pass=
=0D
> >    the guarded iomem reference to helpers to avoid deadlocks.=0D
> >  - Clone the gate Arc before acquiring a guard so mutating address-spac=
e=0D
> >    helpers can retain their &mut self receivers as suggested by Daniel.=
=0D
> > =0D
> > Link: https://lore.kernel.org/all/20260613065348.96750-1-work@onurozkan=
.dev [1]=0D
> > Link: https://lore.kernel.org/all/20260807165252.3849875-1-dakr@kernel.=
org [2]=0D
> > Link: https://lore.kernel.org/all/20260708114358.957305-1-work@onurozka=
n.dev=0D
> > Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28=0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > ---=0D
> > Onur =C3=96zkan (3):=0D
> >      drm/tyr: clear stale IRQ state before soft reset=0D
> >      drm/tyr: add GPU reset infrastructure=0D
> >      drm/tyr: put iomem behind the hardware gate=0D
> > =0D
> > drivers/gpu/drm/tyr/driver.rs            |  65 ++++-----=0D
> > drivers/gpu/drm/tyr/fw.rs                |  16 +-=0D
> > drivers/gpu/drm/tyr/mmu.rs               |   9 +-=0D
> > drivers/gpu/drm/tyr/mmu/address_space.rs |  90 +++++++-----=0D
> > drivers/gpu/drm/tyr/reset.rs             | 242 ++++++++++++++++++++++++=
+++++++=0D
> > drivers/gpu/drm/tyr/reset/hw_gate.rs     | 106 ++++++++++++++=0D
> > drivers/gpu/drm/tyr/tyr.rs               |   1 +=0D
> > 7 files changed, 436 insertions(+), 93 deletions(-)=0D
> > ---=0D
> > base-commit: 53441a9cae3c4be552fa8aefa6e61b0f1bceb8a5=0D
> > change-id: 20260813-tyr-reset-impl-93e951f996b4=0D
> > prerequisite-message-id: <20260807165252.3849875-1-dakr@kernel.org>=0D
> > prerequisite-patch-id: 4275f7d6e3cf96d61221d47f2398ebfb896db0c7=0D
> > prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78=0D
> > prerequisite-patch-id: 0bf6ae4abcef7090d0e48921d6ec627a59dc6a7a=0D
> > prerequisite-patch-id: 8dc24064e858240a6bb5411a261a987a7eae3fad=0D
> > prerequisite-patch-id: eefbd4a72ed6da0083e20811882738cc3b05604f=0D
> > prerequisite-patch-id: 7502236d334b13c547a8b47f0be9bf7171b5ca6b=0D
> > prerequisite-message-id: <20260613065348.96750-1-work@onurozkan.dev>=0D
> > prerequisite-patch-id: 9e1efee190d212ba1b01cd0acb5a4357e0b4da42=0D
> > prerequisite-patch-id: 26aba035f4d1e212fa6ea7078095febefff5c5ba=0D
> > prerequisite-patch-id: ffa25d5aadec4c04589af2bdd59a9c022f0fc9b0=0D
> > prerequisite-patch-id: c2e05a4ac9d665d331952b291a622df6be673e41=0D
> > prerequisite-patch-id: c14a4bd8a68b045356d61f7fa94690bd037ad08b=0D
> > =0D
> > --  =0D
> > =0D
> =0D
> =0D
> Alice, if you are ok with this series, feel free to merge. At least from =
my side it looks ok.=0D
> =0D
> =E2=80=94 Daniel=0D
> =0D
=0D
Any updates on this? I am preparing v2 of the GPU unplug series [1] which=0D
depends on this series. The reset patches need rebasing against current=0D
drm-rust-next.=0D
=0D
Would you prefer me to send a rebased v8 and base unplug v2 on it or are=0D
you planning to pick up v7 and handle the rebase?=0D
=0D
Thanks,=0D
Onur=0D
=0D
[1]: https://lore.kernel.org/all/20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c7=
85@onurozkan.dev=0D
=0D
