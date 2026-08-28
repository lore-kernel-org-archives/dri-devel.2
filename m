Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D15C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4290D10E374;
	Fri, 28 Aug 2026 05:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gLFLsgGF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C11110E374
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:43:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5749740268;
 Fri, 28 Aug 2026 05:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038DB1F00A3A;
 Fri, 28 Aug 2026 05:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787895830;
 bh=YQAQduljJuLpiRxcHku0baqXESPYtYDmnunofxs81O4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gLFLsgGF1hIMqYC6076KB8k5jZJ4cN+h5MQi5GBEEvRXrppx/DY0cGf648/DEqkID
 k2e69YEZfgRmzzteQancqjrpDInRw+pJHayiiDaqBF66c1spSd4fo5XrjvCwqzqT3r
 pA0a6rUk5srQ1HoOftemVDUw6Mykz9RUHz4isP2exm68p/KvGyBEM4xlO+WdBm1BnX
 34u1IKW8Mgev2Jh1Yun8WDsgEn82v3F6880o4mR6UlauGnRZljXhWoUt+QvSg/dwH2
 HCSiNEVRWkccEP6zQS/IvwNsRdB4BMP7WVwfflMLMtwZqERkzbxcf6/VuoJ+eZDXqm
 kP0u0h7+muAbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: use kernel lossless integer
 conversion module
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 05:43:49 +0000
Message-Id: <20260828054350.038DB1F00A3A@smtp.kernel.org>
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
- [High] A TOCTOU double-fetch vulnerability in GSP message parsing allows =
compromised or malicious GSP firmware to corrupt the CPU's message queue re=
ad pointer, causing desynchronization and potential denial of service.
--

commit eaaa0723c196a2c00643733ca548b4c1354725ff
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: use kernel lossless integer conversion module

The kernel crate now features a replacement for our lossless integer
conversion routines. Switch to the kernel version and remove our own.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 6da728201281b..f85fde09aa6e3 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -162,7 +162,7 @@ fn read(
>  #[repr(C, align(0x1000))]
>  #[derive(Debug)]
>  struct MsgqData {
> -    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
> +    data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing cmdq.rs, I
noticed a pre-existing double-fetch issue that could allow a compromised GSP
firmware to desynchronize the message queue.

Could the GSP modify the message length in DMA memory after it has been
validated, causing the host to corrupt its CPU read pointer?

In CmdqInner::wait_for_msg(), the message length is fetched from DMA memory
and validated against the available buffer size to ensure it is safe:

CmdqInner::wait_for_msg() {
    ...
    let payload_length =3D header.payload_length();

    // Check that the driver read area is large enough for the message.
    if slice_1.len() + slice_2.len() < payload_length {
        return Err(EIO);
    }
    ...
}

However, upon returning to CmdqInner::receive_msg(), the length is fetched
a second time directly from the shared memory when advancing the queue read
pointer:

CmdqInner::receive_msg() {
    ...
    let message =3D self.wait_for_msg(timeout)?;
    ...
    // Advance the read pointer past this message.
    self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
        message.header.length().div_ceil(GSP_PAGE_SIZE),
    )?);
    ...
}

Because message.header is a reference into DMA memory, this second fetch
uses an unvalidated value. If the GSP modifies the length field in DMA
memory between these two reads, the kernel will advance its read pointer by
an unvalidated amount. This could cause the kernel to misinterpret queue
memory, fail subsequent validations, and lose communication with the GSP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-nova_num-v=
1-0-e21f17ba4127@nvidia.com?part=3D1
