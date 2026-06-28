Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD092C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A967A10E651;
	Sun, 28 Jun 2026 17:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m38pG426";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC9F10E651
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 17:22:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27A5B42D8B;
 Sun, 28 Jun 2026 17:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B116D1F000E9;
 Sun, 28 Jun 2026 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782667321;
 bh=xLvMyRYaCmAp+9jukXYDzQAFm7wL9led5V2oWb6edHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m38pG426YWcjuArSks6sD50WxanmRuQFDTrQr7GdM8Z6zwZjCDWp0R5rCl6MxYj9i
 ZvREHuG4sOJVeQQF3+YI7RwrGLYtFamxEtsW8rYnBAQBjFjMs2FPdrqEWb8bNPpNCv
 OgxbcBhpGXQ/3nYgq1uMYrf/QSJPLHiBmBE36GgklxZLA/13LwMn81PEDsNNArXfgk
 qStDlpYB2OrU0CyiMDnVgFOw/SgyMsuwBhYBKwKp6XCgK7CWL4PV8hgj6/BLM/4oWy
 ruf2ZsTf0mlIxfcdJ/PqYWt1P7yCyNVX+FmTNdIBCQqlAeH/LMQRRd9VgmKcs9dv9o
 3asG2gxcPPyOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] gpu: nova-core: gsp: convert GspMem to zerocopy
 via the transmute bridge
To: "SeungJong Ha via B4 Relay" <devnull+engineer.jjhama.gmail.com@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260628-dma-zerocopy-bridge-v1-4-9a2895ebe30d@gmail.com>
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <20260628-dma-zerocopy-bridge-v1-4-9a2895ebe30d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 17:22:00 +0000
Message-Id: <20260628172200.B116D1F000E9@smtp.kernel.org>
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
- [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability parsing messag=
e queue headers from coherent DMA memory.
--

commit e9f51c49f1590127c704379d2f179c17f740df94
Author: SeungJong Ha <engineer.jjhama@gmail.com>

gpu: nova-core: gsp: convert GspMem to zerocopy via the transmute bridge

This commit converts GspMem and related structures to use zerocopy for safe
transmutations by adding explicit padding and deriving FromBytes and IntoBy=
tes.
It replaces the manual unsafe transmute implementations.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 070de0731e950..d9929d24d3165 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
[ ... ]
> @@ -169,6 +169,7 @@ struct MsgqData {
>  /// read pointer of `rx` actually refers to the `Msgq` owned by the othe=
r side.
>  /// This design ensures that only the driver or GSP ever writes to a giv=
en instance of this struct.
>  #[repr(C)]
> +#[derive(FromBytes, IntoBytes, Immutable)]
>  // There is no struct defined for this in the open-gpu-kernel-source hea=
ders.
>  // Instead it is defined by code in `GspMsgQueuesInit()`.
>  // TODO: Revert to private once `IoView` projections replace the `gsp_me=
m` module.

[Severity: High]
This isn't a bug introduced by this patch, but could this coherent shared m=
emory
lead to a time-of-check to time-of-use vulnerability?

The driver validates lengths and checksums by reading fields like length fr=
om
GspMsgElement, which is mapped directly into shared memory. For instance,
in wait_for_msg():

wait_for_msg()
    let (header, slice_1) =3D GspMsgElement::from_bytes_prefix(slice_1).ok_=
or(EIO)?;

However, receive_msg() seems to re-read the header fields directly from sha=
red
memory to advance the ring buffer pointer:

receive_msg()
    self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
        message.header.length().div_ceil(GSP_PAGE_SIZE),
    )?);

Can a compromised hardware component modify the message length concurrently
after the initial validation but before pointer advancement, potentially
corrupting the host read pointer?

Similarly, send_single_command() initializes a message header in shared mem=
ory
and then reads its element_count to advance the write pointer:

send_single_command()
    let elem_count =3D dst.header.element_count();
    self.seq +=3D 1;
    self.gsp_mem.advance_cpu_write_ptr(elem_count);

Does this allow the device to race and corrupt the host write pointer by
modifying element_count before it is read back?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-dma-zeroco=
py-bridge-v1-0-9a2895ebe30d@gmail.com?part=3D4
