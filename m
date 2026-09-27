Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7D3C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEE510E58F;
	Sun, 27 Sep 2026 11:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZB0mE3AT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FAE10E58F
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:25:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21CC54360A;
 Sun, 27 Sep 2026 11:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C334F1F000FF;
 Sun, 27 Sep 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790508318;
 bh=tYTGFZA3/Wl5cWMuKGwrlp7CrbE/MyHumn6NgjJK6v8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZB0mE3ATDCsCJa/rY0cDLLuzQUUz46WvbsGJZj2/c9VXEZ6bzSytr6yhgvjiXLdWB
 0f8IEWYr2ZIIkV98Jngfy2Ncw2u/PwCw7cx3O5o+765WkVejx4RVoZJ7XcVf2ZyyV3
 +qFU16CHxYjdtvzMGNd2PqeAfRW+r4d1K+1CBZbj4ywnfp5102M1X1w/N2GtNJfiVO
 xbRpD9IYJazQ7WzL6wQhBXafqKbQoIR/vqrEdEpou9DhXxwtDzIKF9ABm/53Hf8/Lm
 hN35mK8pKd5no3x8k9AO1itATbXwaXSghzF1BxDYHjSgI1Rf1M/JuTN3UXKnepSAFe
 XnFk97ATejqXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, gary@garyguo.net,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260927-cmdq-rpc-v1-3-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
 <20260927-cmdq-rpc-v1-3-822db5af910e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:25:17 +0000
Message-Id: <20260927112517.C334F1F000FF@smtp.kernel.org>
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
- [High] gsp: spurious checksum failures due to untruncated message buffers
--

commit 1576576bd4ef9c21c59c6b207630d4431a81e34d
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type

This commit untangles the GSP command queue transport and message layer code
by making the RPC message header more explicit. It introduces the
RpcMessageHeader wrapping type to replace GspMsgElement for querying
RPC header data. The initialization of the RPC header is now handled
separately by the command queue code.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
[ ... ]
> @@ -768,16 +774,28 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
pMessage<'_>> {
>          // Extract the `GspMsgElement`.
>          let (header, slice_1) =3D GspMsgElement::from_bytes_prefix(slice=
_1).ok_or(EIO)?;
> =20
> +        // Validate checksum.
> +        if Cmdq::calculate_checksum(SBufferIter::new_reader([
> +            header.as_bytes(),
> +            slice_1,
> +            slice_2,
> +        ])) !=3D 0
> +        {
> +            dev_err!(&self.dev, "GSP receive: bad checksum\n");
> +            return Err(EIO);
> +        }
> +

[Severity: High]
Does this code compute the checksum over the entire untruncated message buf=
fers?

By moving Cmdq::calculate_checksum() to run before slice_1 and slice_2 are
truncated to payload_length, it appears to process uninitialized page paddi=
ng
and any subsequent messages present in the ring buffer.

The previous code correctly computed the checksum over the exact message si=
ze
after truncating the slices:

        // Cut the message slices down to the actual length of the message.
        let (slice_1, slice_2) =3D if slice_1.len() > payload_length {
            ...
        };

        // Validate checksum.
        if Cmdq::calculate_checksum( ... ) !=3D 0

Could this result in the driver dropping valid GSP messages due to spurious
checksum failures, stalling the command queue and preventing GPU initializa=
tion?

It appears this flaw persists in the final commit of the series
(41ab580cce9e4df6dca3c50983301c4f117e6a64). Even though the code is refacto=
red
into wait_for_element() and wait_for_rpc_msg(), wait_for_element() still ca=
lls
calculate_checksum() on the untruncated slices before returning the message=
 to
wait_for_rpc_msg() where the size truncation finally happens.

> +        let rpc_header =3D header.rpc_header();
> +        let payload_length =3D rpc_header.length();
> +
>          dev_dbg!(
>              &self.dev,
>              "GSP RPC: receive: seq# {}, function=3D{:?}, length=3D0x{:x}=
\n",
> -            header.sequence(),
> -            header.function(),
> -            header.length(),
> +            rpc_header.sequence(),
> +            rpc_header.function(),
> +            payload_length,
>          );
> =20
> -        let payload_length =3D header.payload_length();
> -
>          // Check that the driver read area is large enough for the messa=
ge.
>          if slice_1.len() + slice_2.len() < payload_length {
>              return Err(EIO);
> @@ -796,21 +814,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gsp=
Message<'_>> {
>              )
>          };
> =20
> -        // Validate checksum.
> -        if Cmdq::calculate_checksum(SBufferIter::new_reader([
> -            header.as_bytes(),
> -            slice_1,
> -            slice_2,
> -        ])) !=3D 0
> -        {
> -            dev_err!(
> -                &self.dev,
> -                "GSP RPC: receive: Call {} - bad checksum\n",
> -                header.sequence()
> -            );
> -            return Err(EIO);
> -        }
> -
>          Ok(GspMessage {
>              header,
>              contents: (slice_1, slice_2),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-cmdq-rpc-v=
1-0-822db5af910e@nvidia.com?part=3D3
