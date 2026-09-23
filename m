Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E94CC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE64D10F06D;
	Wed, 23 Sep 2026 13:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kJC+rtPm";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4132C10F06D
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790171822; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=new2IeUfms7ocQDP7VRlh52saNi/+RdS4IdwsafB7RzjRIaTVXvOmJQQEgW341XfGQ3sDDgtgIDCCwCmJUU2b4/MydEkv2pvydwcxHbijR2WpBtMFSRu7l4a6tjH+nnYkoV9n77HgjH5XMoaxak+wPjydpjpoj7e+hROQxkMEBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790171822;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZCZBtkL2O2YQdBpYXU7IxaL83zFU6P8vJ4uvyW4n0Og=; 
 b=NLh8h1ZLqukbUxV6RHpif+1FXb7TOMVsLhSJE7ezYJVGw5QM9l0Ysw+xGYdUZxOBkC3tL2L5YreDsaE9F4FWnoiinRT9mmSWkIwnnuQSN/UGlGcF/YydOqYl65u0m1hVzGzhsRbep4bTNCQre4ecYWxFEW6H1XanDJ51//2zX3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790171822; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=ZCZBtkL2O2YQdBpYXU7IxaL83zFU6P8vJ4uvyW4n0Og=;
 b=kJC+rtPmc87WweOf8gsqwcs2gMhNZWMznZKSTUZJR9/f5M3pNL512pLrfcvjRwSk
 pQpRwApc4x4mBCTUzqpQisxFx09MB2rv5RRVSxZGI1DVjKjC79mWF022y/Lzp36L648
 fYHbbhemjIimdgTMhcvQNrh1/GNz06fa1pPQpG9o=
Received: by smtp.zohomail.com with SMTPS id 1790171822100855.2696120518375;
 Wed, 23 Sep 2026 06:57:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v7 0/3] drm/tyr: GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
Date: Wed, 23 Sep 2026 10:56:48 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <70AFEE33-C637-4D49-88F1-9DF3A9BBF097@collabora.com>
References: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-ZohoMailClient: External
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



> On 12 Sep 2026, at 07:39, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Add support for scheduling GPU resets on a dedicated workqueue. Track
> the reset state to avoid queueing another reset while one is already
> pending or in progress.
>=20
> Use an SRCU based gate with mutex-protected reader admission to block
> hardware accesses while reset work runs and wait for current users
> before resetting.
>=20
> Stop new reset requests during teardown and drain any queued or =
running
> reset work before releasing the device resources.
>=20
> This is the initial reset infrastructure only. It is not wired to a =
reset
> source yet as those will follow in separate work.
>=20
> Based on 'commit 53441a9cae3c ("drm/tyr: program CSF global =
interface")'
> from tyr-for-upstream with the following patch series on the ML:
>  - rust: add SRCU abstraction [1]
>  - rust: workqueue: add cancel_sync support [2]
>=20
> TODOs:
>  - On reset failure, we don't do anything for now. We should unplug
>    the GPU.
>  - In schedule(), similar to panthor_device_schedule_reset(), we =
should
>    have a PM check but similar to the note above, we don't have the
>    infrastructure for that yet.
>=20
> Changes since v6:
>  - Acquire the hardware gate once per address-space operation and pass
>    the guarded iomem reference to helpers to avoid deadlocks.
>  - Clone the gate Arc before acquiring a guard so mutating =
address-space
>    helpers can retain their &mut self receivers as suggested by =
Daniel.
>=20
> Link: =
https://lore.kernel.org/all/20260613065348.96750-1-work@onurozkan.dev =
[1]
> Link: =
https://lore.kernel.org/all/20260807165252.3849875-1-dakr@kernel.org [2]
> Link: =
https://lore.kernel.org/all/20260708114358.957305-1-work@onurozkan.dev
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> Onur =C3=96zkan (3):
>      drm/tyr: clear stale IRQ state before soft reset
>      drm/tyr: add GPU reset infrastructure
>      drm/tyr: put iomem behind the hardware gate
>=20
> drivers/gpu/drm/tyr/driver.rs            |  65 ++++-----
> drivers/gpu/drm/tyr/fw.rs                |  16 +-
> drivers/gpu/drm/tyr/mmu.rs               |   9 +-
> drivers/gpu/drm/tyr/mmu/address_space.rs |  90 +++++++-----
> drivers/gpu/drm/tyr/reset.rs             | 242 =
+++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/reset/hw_gate.rs     | 106 ++++++++++++++
> drivers/gpu/drm/tyr/tyr.rs               |   1 +
> 7 files changed, 436 insertions(+), 93 deletions(-)
> ---
> base-commit: 53441a9cae3c4be552fa8aefa6e61b0f1bceb8a5
> change-id: 20260813-tyr-reset-impl-93e951f996b4
> prerequisite-message-id: <20260807165252.3849875-1-dakr@kernel.org>
> prerequisite-patch-id: 4275f7d6e3cf96d61221d47f2398ebfb896db0c7
> prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78
> prerequisite-patch-id: 0bf6ae4abcef7090d0e48921d6ec627a59dc6a7a
> prerequisite-patch-id: 8dc24064e858240a6bb5411a261a987a7eae3fad
> prerequisite-patch-id: eefbd4a72ed6da0083e20811882738cc3b05604f
> prerequisite-patch-id: 7502236d334b13c547a8b47f0be9bf7171b5ca6b
> prerequisite-message-id: <20260613065348.96750-1-work@onurozkan.dev>
> prerequisite-patch-id: 9e1efee190d212ba1b01cd0acb5a4357e0b4da42
> prerequisite-patch-id: 26aba035f4d1e212fa6ea7078095febefff5c5ba
> prerequisite-patch-id: ffa25d5aadec4c04589af2bdd59a9c022f0fc9b0
> prerequisite-patch-id: c2e05a4ac9d665d331952b291a622df6be673e41
> prerequisite-patch-id: c14a4bd8a68b045356d61f7fa94690bd037ad08b
>=20
> -- =20
>=20


Alice, if you are ok with this series, feel free to merge. At least from =
my side it looks ok.

=E2=80=94 Daniel

