Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E6ACD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C698914B;
	Tue,  9 Jun 2026 08:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F54IOZFj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13518914B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:15:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1734F601DC;
 Tue,  9 Jun 2026 08:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C61F00893;
 Tue,  9 Jun 2026 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780992926;
 bh=x3FmhfoNnSkf7BtHmbfVCyisBsU1XriDWXfWGLzZg4Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F54IOZFjoaLL5Eo5W8Y3vJzceL7MOi7vdFGWHwGzWVqLSc7tN7TGsjefL9jbdXJdW
 72mA9u6xWGvpUnDrMVMMlkFOT5w50Fn7VF7yadx409UVgxb0ZbplcwSF+pmgYfz/95
 f8TtmlDwGsFEC/sQe0fhOB+ysCq0iqzJN/SgpAirRGa50cwln/eI+yYgGc8oTROf59
 yPqMo81QPivrf+80hUdQhxsbnGoYz5b5VEGDkH7yAz6+Gn4b6IlS0vC4W8rSczJqmK
 sT9SUKwkq+4vAkHpBGcmb/kGSrc1cSfzg1kvl2CuHzY0vZn34PdV2CoMb2oMQR+ew3
 h+FWH6wVp01rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] gpu: nova-core: move GPU static information
 acquisition to a GSP method
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
References: <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:15:25 +0000
Message-Id: <20260609081526.794C61F00893@smtp.kernel.org>
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
- [High] Incorrect drop order in `Gpu` struct causes sysmem flush page to b=
e unregistered before GSP falcons are reset, leading to driver timeouts or =
hardware faults.
--

commit 70dc6b2e19cb0af3250719038111e9c9fcddf6e7
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: move GPU static information acquisition to a GSP method

The GSP static information is useful during regular driver runtime; however
it is currently obtained from Gsp::boot, with no elegant way to pass it back
to the caller. This moves the code acquiring it to a dedicated method of
Gsp that can be called as soon as the Gsp is booted.

> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 6b3e02c71dee1..a0cb36cdeeead 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
[ ... ]
> @@ -290,6 +291,8 @@ pub(crate) struct Gpu<'gpu> {
>      /// GSP and its resources.
>      #[pin]
>      gsp_resources: GspResources<'gpu>,

[Severity: High]
Does this struct layout result in an incorrect drop order?

In Rust, struct fields are dropped in their declaration order. Since
sysmem_flush is declared before gsp_resources in the Gpu struct, it will be
dropped first.

When sysmem_flush drops, its Drop implementation unregisters the memory flu=
sh
page by writing 0 to the hardware registers. Immediately after, gsp_resourc=
es
drops, which shuts down the GSP and resets the falcons.

However, the sysmem flush memory page must be registered before any falcon =
is
reset, because the reset handshake requires system memory writes. Dropping =
the
flush page too early means the subsequent falcon reset handshake will write
to address 0 or hang, potentially causing a driver timeout or IOMMU fault.

It appears the unload logic was moved to the GspResources subobject in this
patch series without reordering the struct fields, which causes the reset to
run after the flush page is already unregistered.

> +    /// Static GPU information as provided by the GSP.
> +    gsp_static_info: GetGspStaticInfoReply,
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-boot-vram-=
v1-0-d9382610507a@nvidia.com?part=3D2
