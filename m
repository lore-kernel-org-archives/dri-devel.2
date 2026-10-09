Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A99CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B310310E038;
	Fri,  9 Oct 2026 12:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AZV/GHEL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F23810E038
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:06:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D6C460534;
 Fri,  9 Oct 2026 12:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7CD1F000FF;
 Fri,  9 Oct 2026 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791547583;
 bh=XoGZ5yWB502YFWVWaODrBXXuoD51zGAgrsoRbKanqvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AZV/GHEL9081GlHM5evY1ZUjb2258r2pffiyT4IRcJZBxuUBhS90cXDRfpOvW6VAf
 U9bVPWBGZbrsO0UCOTTx3k1cCc/QUoPwZrQdJm89uHR94dnAZxyZ1dkXeNnkjkb4gI
 GSUleZnVwBBfv0okb5GV0zYANNg4xCIOP8+aFTlhb8RLXwF4W1/yhXLqeppiPelZf/
 1W2TcyI95yZu45v2CxPPwI2C2c4xfwHBzzmahKEDAwhCAXZNFzQzrXOGDSbCZT9w59
 yIo3CaH5oqem8bGl2HuOzXliKUNba9hpr+k/OddIcjg/HkqqbgHRJNRrzq2kaUBARW
 LDIHhvJy854KA==
Message-ID: <sashiko-outbox-165477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261009-cmdq-rpc-v4-1-c9ab8de1d3f2@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-1-c9ab8de1d3f2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:06:22 +0000
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
- [High] gpu: nova-core: double fetch of message length allows queue desync=
hronization
--

commit 946fd7a5c2c75e7ae4c51655010ee1c1c0977129
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: validate checksum earlier on receive

This moves the checksum validation before accessing the RPC header to
avoid printing an unvalidated sequence number.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 1b2f346a237f0..b1d46d6d4d4ab 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -792,6 +792,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gsp=
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
> +        ) !=3D 0

[Severity: High]
Does this code introduce a double fetch regression? Because the GSP message
queue resides in DMA-coherent shared memory, the device can concurrently
modify header.length().

By using header.length() to bound the checksum calculation via take() here,
but later using header.payload_length() to slice the payload:

drivers/gpu/nova-core/gsp/cmdq.rs:wait_for_msg() {
...
        let payload_length =3D header.payload_length();
...
}

could the GSP modify the length field between these fetches, causing the
slices to cover unvalidated payload data and bypassing the checksum?

Furthermore, there is a third fetch of the length later in receive_msg():

drivers/gpu/nova-core/gsp/cmdq.rs:receive_msg() {
...
        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
            message.header.length().div_ceil(GSP_PAGE_SIZE),
        )?);
...
}

Could modifying the length before this fetch cause the CPU to advance the
pointer by an arbitrary amount, desynchronizing the command queue and
potentially processing arbitrary data as commands?

Do follow-up patches in this series retain this same structure in other are=
as,
such as consume_element and RpcMessage::parse?

> +        {
> +            dev_err!(&self.dev, "GSP receive: bad checksum\n");
> +            return Err(EIO);
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-cmdq-rpc-v=
4-0-c9ab8de1d3f2@nvidia.com?part=3D1
