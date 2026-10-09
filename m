Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E984CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0FE10E1A3;
	Fri,  9 Oct 2026 12:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hQOvgx8m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142D210E1A3
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:13:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43B4760534;
 Fri,  9 Oct 2026 12:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1BD1F000FF;
 Fri,  9 Oct 2026 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791548022;
 bh=d+4jQLoOWYKWjwGY8UoeQ5MkFKTJmUwuPyuzNht4Fk8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hQOvgx8mfV0gISL0A6CKS753bbrdcSpvvK5GKqJAIv2EC9GCn+yd+oqcdaLPW51bs
 sQvUSMknoycBKOIKdUZh+WaBXDc8EVPw9mKjmz4ND2kbtPYwzQUzHp84HMNILglwfT
 sPWKPt8lGvY3WFZwKz9O/qKsxmwrWokB3bEueIsvbNSNAcANYs4AagigXYY/KUM8XO
 URRIbo0sr+P7P7nVakv96GeWRhFJDIn3Cecq6i2kO5yon4xT5u0NBTXTu0G/TKInLH
 +uX5DinTbpb31bl81OcmJ6xzjqW3WCUU5Xiaza8gHVSMpYSzeYEmz4WQ5O/rPxVA29
 eJHZmoyvLoX6w==
Message-ID: <sashiko-outbox-165496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, gary@garyguo.net
In-Reply-To: <20261009-cmdq-rpc-v4-7-c9ab8de1d3f2@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-7-c9ab8de1d3f2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:13:41 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] gsp: cmdq: drain() wedges queue on malformed RPC message
- [High] gpu: nova-core: ring buffer desynchronization on malformed GSP mes=
sages
- [Low] cmdq: stale comment regarding read pointer advancement on early ret=
urn
--

commit a033b6d3e9c45eced0baaf0fa5456db1072ad255
Author: Alexandre Courbot <acourbot@nvidia.com>
Subject: gpu: nova-core: gsp: cmdq: split the transport part of the receive=
 path

This patch separates the transport and RPC layers in the GSP command queue
receive path by introducing a MessageElement trait. It replaces receive_msg
with a transport-agnostic consume_element which parses messages via the tra=
it
and advances the read pointer.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index a059ce74ba2da..65e1a0b6bb444 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -233,45 +233,45 @@
> +impl<M> MessageElement for RpcMessageElement<M>
> +where
> +    M: MessageFromGsp,
> +    Error: From<M::InitError>,
> +{
> +    fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Sel=
f> {
> +        let rpc_message =3D RpcMessage::parse(dev, message)?;
> +        let function =3D rpc_message.header.function();
> +
> +        // An early return here would leave the read pointer on this mes=
sage.
> +        let result =3D if matches!(function, Ok(f) if f =3D=3D M::FUNCTI=
ON) {

[Severity: Low]
Is this comment still accurate under the new architecture?

Under the new abstraction, CmdqInner::consume_element() executes M::read(),
captures the result, and unconditionally advances the read pointer before
returning the result:

CmdqInner::consume_element() {
    ...
    let result =3D M::read(self.dev, message);
    self.gsp_mem.advance_cpu_read_ptr(elem_count);
    result
}

An early return inside RpcMessageElement::read() no longer leaves the read
pointer on the message, making this comment misleading.

[ ... ]
> @@ -933,53 +981,19 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
pMessage<'_>> {
> [ ... ]
> -    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Resu=
lt<M>
> -    where
> -        // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
> -        Error: From<M::InitError>,
> -    {
> +    fn consume_element<M: MessageElement>(&mut self, timeout: Delta) -> =
Result<M> {
>          let message =3D self.wait_for_msg(timeout)?;
>          let elem_count =3D u32::try_from(message.header.msg_length().div=
_ceil(GSP_PAGE_SIZE))?;
> -        let rpc_message =3D RpcMessage::parse(self.dev, message)?;
> -        let function =3D rpc_message.header.function();
> -
> -        // An early return here would leave the read pointer on this mes=
sage.
> -        let result =3D if matches!(function, Ok(f) if f =3D=3D M::FUNCTI=
ON) {
> -            let (cmd, contents_1) =3D
> -                M::Message::from_bytes_prefix(rpc_message.contents.0).ok=
_or(EIO)?;
> [ ... ]
> +        let result =3D M::read(self.dev, message);
> =20
>          // Advance the read pointer past this message.
> +        self.gsp_mem.advance_cpu_read_ptr(elem_count);
> =20
>          result
>      }

[Severity: High]
Does this code introduce a regression where malformed GSP messages can
desynchronize the ring buffer?

The read pointer is unconditionally advanced by an unvalidated elem_count
calculated from message.header.msg_length().

If the GSP sends a message with an rpc_length exceeding the queue's capacit=
y,
M::read() (via RpcMessage::parse()) correctly returns an error because the
message is physically too large.

However, because advance_cpu_read_ptr() is executed regardless of the error,
the read pointer is advanced by the oversized, corrupted elem_count.

Can this cause the read pointer to wrap around arbitrarily, permanently
desynchronizing the ring buffer and breaking all further GSP communication?

The previous code correctly bubbled up the error from RpcMessage::parse()
before advancing the pointer.

[ ... ]
> @@ -1044,14 +1044,14 @@ fn drain(&mut self) -> Result {
>          while !self.gsp_mem.driver_read_area().0.is_empty() {
>              // A message is available, so this returns without waiting.
>              let msg =3D self.wait_for_msg(Delta::ZERO)?;
> =20
>              let pages =3D
> -                u32::try_from(msg.header.length().div_ceil(GSP_PAGE_SIZE=
)).map_err(|_| {
> +                u32::try_from(msg.header.msg_length().div_ceil(GSP_PAGE_=
SIZE)).map_err(|_| {
>                      dev_err!(&self.dev, "GSP drain: message length overf=
low\n");
>                      EIO
>                  })?;
> -            let function =3D msg.header.function();
> -            let seq =3D msg.header.sequence();
> +
> +            RpcMessage::parse(self.dev, msg)?.log(self.dev);
> =20
>              self.gsp_mem.advance_cpu_read_ptr(pages);
> -            self.log_event(function, seq);
>          }

[Severity: High]
Can this code permanently wedge the queue if RpcMessage::parse() fails?

The commit message states that messages with unexpected sizes are consumed
instead of remaining on the queue.

However, if RpcMessage::parse() returns an error for a malformed message,
the ? operator causes an early return from drain().

This skips self.gsp_mem.advance_cpu_read_ptr(pages), leaving the malformed
message on the queue.

Any subsequent calls to drain() would repeatedly fail on the same message,
permanently wedging the queue.

Verification at the series end commit (37073815d78fabf6293f38e4abb8f78d887d=
7841)
confirms this issue is not fixed by subsequent patches.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-cmdq-rpc-v=
4-0-c9ab8de1d3f2@nvidia.com?part=3D7
