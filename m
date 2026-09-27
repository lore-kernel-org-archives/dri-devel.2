Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01445C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DD010E57F;
	Sun, 27 Sep 2026 11:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P870lIfO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A75C10E57F
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:22:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C636E41443;
 Sun, 27 Sep 2026 11:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC11F000FF;
 Sun, 27 Sep 2026 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790508145;
 bh=JrpJ6wGQk4MmIgnOuY1E3EpbAWqu8Y33KuGdfk0UT/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P870lIfOWoUx/lno9rQnnq70dYvGg9YEQSaQbo11mT8Bvh5DVAE0zM9su8GRgbk8m
 X3sQ3Xz9acq/QTCahuOLowF+QWyrkJ6eOZaXeP6OEQGLnUImVvyNs91Gq8aKfYcyzY
 qz0BLewgCx9gRAq+H6f3IeRE89jsYZtTf8242CGxfNBHtEHKljeRfhZiWNboGF/TWw
 AGHoKgYMcDAoAgQ93x7XmFmyO3nan6ax9pdu1PZC2Vnpn5MbwBQ7Nl8o+oh7RRELBb
 RrHWvTYznUlY8dYjd91u/e1kMXBONaypVrWEMSRqbi6pe3D3KN2uxvlEinFHKiYQhG
 +TGpTZhzruAqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, gary@garyguo.net, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260927-cmdq-rpc-v1-10-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
 <20260927-cmdq-rpc-v1-10-822db5af910e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:22:24 +0000
Message-Id: <20260927112225.48AC11F000FF@smtp.kernel.org>
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
- [Low] rust: broken rustdoc intra-doc links after method renaming
--

commit 41ab580cce9e4df6dca3c50983301c4f117e6a64
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

Since we are going to introduce a second type of message, add `rpc` to
the names of the relevant command queue methods so we can distinguish
between the two.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-cor=
e/gsp/cmdq/rpc.rs
> index 335f94c4d2aac..81f8c79b1bb53 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
[ ... ]
> @@ -216,7 +216,7 @@ fn send_command<M>(&mut self, command: M) -> Result
>          }
>      }
> =20
> -    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
> +    fn wait_for_rpc_msg(&self, timeout: Delta) -> Result<GspMessage<'_>>=
 {
>          let GspMessage {

[Severity: Low]
Are there stale rustdoc links in drivers/gpu/nova-core/gsp/cmdq.rs after
this rename?

drivers/gpu/nova-core/gsp/cmdq.rs:
/// This is the type returned by [`CmdqInner::wait_for_msg`].
struct GspMessage<'a> {

>              header,
>              contents: (slice_1, slice_2),
[ ... ]
> @@ -275,12 +275,12 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
pMessage<'_>> {
>      /// - `ERANGE` if the message had a recognized but non-matching func=
tion code.
>      ///
>      /// Error codes returned by [`MessageFromGsp::read`] are propagated =
as-is.
> -    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Resu=
lt<M>
> +    fn receive_rpc_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> =
Result<M>

[Severity: Low]
Could this method rename break the intra-doc link for MessageFromGsp in
this same file?

drivers/gpu/nova-core/gsp/cmdq/rpc.rs:
/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type =
of message.
pub(crate) trait MessageFromGsp: Sized {

>      where
>          // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
>          Error: From<M::InitError>,
>      {
> -        let message =3D self.wait_for_msg(timeout)?;
> +        let message =3D self.wait_for_rpc_msg(timeout)?;
[ ... ]
> @@ -357,22 +357,22 @@ pub(crate) fn send_command<M>(&self, command: M) ->=
 Result<M::Reply>
>      ///   written to by its [`CommandToGsp::init_variable_payload`] meth=
od.
>      ///
>      /// Error codes returned by the command initializers are propagated =
as-is.
> -    pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
> +    pub(crate) fn send_rpc_command_no_wait<M>(&self, command: M) -> Resu=
lt

[Severity: Low]
Will this change leave a broken rustdoc link in drivers/gpu/nova-core/gsp/c=
mdq.rs?

drivers/gpu/nova-core/gsp/cmdq.rs:
/// Marker type representing the absence of a reply for a command. Commands=
 using this as their
/// reply type are sent using [`Cmdq::send_command_no_wait`].
pub(crate) struct NoReply;

>      where
>          M: CommandToGsp<Reply =3D NoReply>,
>          Error: From<M::InitError>,
>      {
> -        self.inner.lock().send_command(command)
> +        self.inner.lock().send_rpc_command(command)
>      }
> =20
>      /// Receive a message from the GSP.
>      ///
>      /// See [`CmdqInner::receive_msg`] for details.
> -    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) =
-> Result<M>
> +    pub(crate) fn receive_rpc_msg<M: MessageFromGsp>(&self, timeout: Del=
ta) -> Result<M>

[Severity: Low]
It looks like this method rename might have missed its own doc comment right
above it:

    /// See [`CmdqInner::receive_msg`] for details.

>      where
>          // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
>          Error: From<M::InitError>,
>      {
> -        self.inner.lock().receive_msg(timeout)
> +        self.inner.lock().receive_rpc_msg(timeout)
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-cmdq-rpc-v=
1-0-822db5af910e@nvidia.com?part=3D10
