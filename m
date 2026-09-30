Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9597FCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44D410F47B;
	Wed, 30 Sep 2026 15:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CBvpbfkq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763FB10F474
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:15:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 188AF437C1;
 Wed, 30 Sep 2026 15:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F4C1F0089A;
 Wed, 30 Sep 2026 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790781308;
 bh=up1jricRXtZ8EcLurURCpqCAifZjC7HhCGixLxH15oo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CBvpbfkq8QAOHGq4TyowL78QnHnO27ejRMe94TqqbxmlybnG7ZVR7rkQDlHaniGN4
 yultw3wMj4EEWPquZDuhR8jYBnAO9FfBmd/QVzkckv7WkUcCCo56jtmNfSsIHH6XDg
 zp4eEDcL2VOIxjrM3xZ1hm5wHOFfzzjch2isLY/jUsculfe6D7v3F/YTPc1QFuS3AX
 g3dB8ob9h1hn/5LUGJ/73ByudMmM4/RnAWLehS3yGTefmmgnwJtQNbkUzm0qwAtMkk
 MpQ6jU23lbM3merYd8QipQPK6ydi/qzxMa5qa6N/65Pnfd7EyuWo+lfc+bdbJ0FzLp
 R4Lmv5pkcWCcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, gary@garyguo.net,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-cmdq-rpc-v3-6-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-6-91613f06520b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:15:07 +0000
Message-Id: <20260930151507.98F4C1F0089A@smtp.kernel.org>
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
- [High] nova-core: ring buffer desynchronization via unvalidated element c=
ount
--

commit 1b11098df54520332b501e33775803bd797ce2f8
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: split the transport part of the receive path

wait_for_msg mixes two layers: the transport layer which polls the
queue, extracts the element header and validates the checksum, and the
RPC layer which reads the RPC header and trims the payload slices to the
length advertised by the RPC header.

Move the transport layer into wait_for_element, and introduce
consume_element, a transport-level method which reads the message's
contents using an implementation of the MessageElement trait before
advancing the CPU read pointer past it, and parse_rpc_message, which
validates the RPC layer. This sets things up for moving the RPC code
into its own module, leaving the transport agnostic of the message type.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index b8a9e02b76fe5..07036972dbecf 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -805,7 +905,7 @@ fn send_command<M>(&mut self, command: M) -> Result
>      ///   message queue.
>      ///
>      /// Error codes returned by the message constructor are propagated a=
s-is.
> -    fn wait_for_msg(&self, timeout: Delta) -> Result<RpcMessage<'_>> {
> +    fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>>=
 {
>          // Wait for a message to arrive from the GSP.
>          let (slice_1, slice_2) =3D read_poll_timeout(
>              || Ok(self.gsp_mem.driver_read_area()),
> @@ -827,108 +927,27 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<R=
pcMessage<'_>> {
>              return Err(EIO);
>          }
> =20
> -        self.parse_rpc_message(GspMessage {
> +        Ok(GspMessage {
>              header,
>              contents: (slice_1, slice_2),
>          })
>      }

[Severity: High]
Does this code allow a message with a maliciously large length to pass
validation?

Looking at wait_for_element() which validates the checksum using .take():

nova-core/gsp/cmdq.rs:wait_for_element() {
    ...
    // Validate checksum after truncating the message to its exact length.
    if Cmdq::calculate_checksum(
        SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take=
(header.length()),
    ) !=3D 0
    ...
}

Because .take() silently stops when the iterator is exhausted, this allows
a message with a maliciously large length to pass validation if the
truncated checksum matches.

Since the RPC bounds check has been moved out of wait_for_element() and
into M::read(), the length check is deferred until it is too late to
prevent pointer advancement in consume_element().

[ ... ]

> -    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Resu=
lt<M>
> -    where
> -        // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
> -        Error: From<M::InitError>,
> -    {
> -        let message =3D self.wait_for_msg(timeout)?;
> -        let function =3D message.header.function().map_err(|_| EINVAL)?;
> -
> -        // Extract the message. Store the result as we want to advance t=
he read pointer even in
> -        // case of failure.
> -        let result =3D if function =3D=3D M::FUNCTION {
> -            let (cmd, contents_1) =3D M::Message::from_bytes_prefix(mess=
age.contents.0).ok_or(EIO)?;
> -            let mut sbuffer =3D SBufferIter::new_reader([contents_1, mes=
sage.contents.1]);
> -
> -            M::read(cmd, &mut sbuffer)
> -                .map_err(|e| e.into())
> -                .inspect(|_| {
> -                    if !sbuffer.is_empty() {
> -                        dev_warn!(
> -                            &self.dev,
> -                            "GSP message {:?} has unprocessed data\n",
> -                            function
> -                        );
> -                    }
> -                })
> -        } else {
> -            Err(ERANGE)
> -        };
> +    /// Errors from [`Self::wait_for_element`] and from [`MessageElement=
::read`] are propagated
> +    /// as-is.
> +    fn consume_element<M: MessageElement>(&mut self, timeout: Delta) -> =
Result<M> {
> +        let message =3D self.wait_for_element(timeout)?;
> +        let elem_count =3D u32::try_from(message.header.length().div_cei=
l(GSP_PAGE_SIZE))?;
> +        let result =3D M::read(self.dev, message);
> =20
> -        // Advance the read pointer past this message.
> -        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
> -            message.header.length().div_ceil(GSP_PAGE_SIZE),
> -        )?);
> +        self.gsp_mem.advance_cpu_read_ptr(elem_count);

[Severity: High]
Can this corrupt the ring buffer state by advancing the read pointer even if
M::read() fails bounds checking?

In consume_element(), the driver computes the queue advancement elem_count
using message.header.length() (which retrieves the length from the
unvalidated RPC header).

If the GSP firmware sends a massive or padded length, M::read() correctly
bounds-checks and rejects it, but consume_element() temporarily ignores
this failure and unconditionally advances the CPU read pointer by the
unvalidated, potentially massive elem_count.

Recomputing elem_count via div_ceil instead of using the firmware-provided
transport field message.header.element_count() guarantees desynchronization
if the GSP ever pads messages.

Can this be exploited by a malfunctioning or compromised GSP firmware
to irrevocably corrupt the shared queue?

> =20
>          result
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-cmdq-rpc-v=
3-0-91613f06520b@nvidia.com?part=3D6
