Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5DFCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BD610E20E;
	Wed, 30 Sep 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SNgaujhr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F50C10E20E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:12:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6862560239;
 Wed, 30 Sep 2026 15:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C0B1F00893;
 Wed, 30 Sep 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790781161;
 bh=flka+is39zX93jXZy+QnirmWxmLDppS0KvN39KT0GoE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SNgaujhr4C9QXyAUEpomzkgvUyRSDQwoSOxHStAVWFmB39zcm3vk9R9qKJB7AWrBC
 +XMSAAmvYkkzEkT9BoqOR20x6mVF6O5s6bcnCG56Y0CHjs9SQGtFF7GeNmAXWGfLfX
 Zb7IplgvkEM3kEMttTEzvWkAa2TWZtZGN8+dqtTp/GpWfaPKw4u7AJ/ivqXgXxd/gc
 zX3isn6Duix+giK0A+MpgEdfvVrh068sgElWadEOdPQThR4jLYvTUt1QpDGQVDOt56
 MkhWNXU3BjSlX19v6Xtj41Ix7w88YcXGn2wVbE+biakAXIssyFnOzsqLTfU44ZkZT5
 AvrM8FzDWvs1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, gary@garyguo.net
In-Reply-To: <20260930-cmdq-rpc-v3-1-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-1-91613f06520b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:12:40 +0000
Message-Id: <20260930151240.B7C0B1F00893@smtp.kernel.org>
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
- [High] gpu: nova-core: TOCTOU race in GSP message checksum validation all=
ows bypassing integrity checks
--

commit 7f9f9f297ff07c9a2fc40d814e38057d895893f1
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: validate checksum earlier on receive

The checksum validation error message of wait_for_msg() prints the
message's sequence number before validating the checksum. But the
checksum is part of the transport layer, and it not validating indicates
a corruption. Thus, this commit moves the checksum validation before
we start looking at the message header, and drops the sequence number
from the error message.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index a5595da23407b..d293d28b09674 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -768,6 +768,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gsp=
Message<'_>> {
>          // Extract the `GspMsgElement`.
>          let (header, slice_1) =3D GspMsgElement::from_bytes_prefix(slice=
_1).ok_or(EIO)?;
> =20
> +        // Validate checksum after truncating the message to its exact l=
ength.
> +        if Cmdq::calculate_checksum(
> +            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2=
]).take(header.length()),

[Severity: High]
Does this regression create a TOCTOU race condition in wait_for_msg()?
header appears to map directly to DMA memory, and header.length() is
read here for the first time to determine the boundaries for the checksum
validation.

If the GSP (or a hardware glitch) modifies the length field in DMA to a
larger value after this checksum passes, it is read again further down in
wait_for_msg():

        let payload_length =3D header.payload_length();

        // Check that the driver read area is large enough for the message.
        if slice_1.len() + slice_2.len() < payload_length {
            return Err(EIO);
        }

Could this secondary read use the modified length, causing the slices to be
truncated using the corrupted length and bypassing the integrity check for
the unverified data passed to the RPC handler?

> +        ) !=3D 0
> +        {
> +            dev_err!(&self.dev, "GSP receive: bad checksum\n");
> +            return Err(EIO);
> +        }
> +
>          dev_dbg!(

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-cmdq-rpc-v=
3-0-91613f06520b@nvidia.com?part=3D1
