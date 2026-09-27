Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE0C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49C110E593;
	Sun, 27 Sep 2026 11:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NmBgy/wZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D24310E593
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:27:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09030404EF;
 Sun, 27 Sep 2026 11:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E91F000FF;
 Sun, 27 Sep 2026 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790508464;
 bh=pMqKucmWWoBKiao3KWyJg9C/vAKWZEZYQBcGADSqI7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NmBgy/wZ9FV/nBUeqNqUprWfvcnh5WMhsxawPbkk4PQdnO5d8ns/p7JYJxuUeKVTc
 X3tpJsB82+Smw3JugwEYJI05abqFCU430yEQhAClfZ1IxfDxbzSQ1XSC0AqEHKK+ds
 kJ259uhUj8gJuYyQtk8G0YI89NCSuv6tWhva/FxovRXQcl+Cf+gS1/5QyocyF9Y+Jp
 zAA77frsklajnjtP20NQVGeQL4k+pdkVlR3YAXm+ko3U72IfZqaiHO94F3F7pk4O0n
 KGAtuOfDwsDtoHU9g5CqL6B1GlqDWYe5QHVrsTHrujj3TvbnDyJWPG41dvZqJ5aKPK
 +6DwYpQ6z/Eag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, gary@garyguo.net,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260927-cmdq-rpc-v1-7-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
 <20260927-cmdq-rpc-v1-7-822db5af910e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:27:44 +0000
Message-Id: <20260927112744.921E91F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] gpu/nova-core: checksum validation fails on untrimmed queue buffer=
 slices
- [High] gpu/nova-core: unvalidated element_count from GSP allows arbitrary=
 read pointer manipulation
--

commit 4799dd94b859632b92a2a5821daacb47098f5faa
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: split the transport part of the receive path

This commit splits wait_for_msg into wait_for_element and wait_for_msg. The
transport layer is moved into wait_for_element, while the RPC layer that
trims the payload slices remains in wait_for_msg. This prepares the code
for moving the RPC layer into its own module.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index a5595da23407b..d50a2a594f828 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -755,7 +584,7 @@ fn send_command<M>(&mut self, command: M) -> Result
>      ///   message queue.
>      ///
>      /// Error codes returned by the message constructor are propagated a=
s-is.
> -    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
> +    fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>>=
 {
>          // Wait for a message to arrive from the GSP.
>          let (slice_1, slice_2) =3D read_poll_timeout(
>              || Ok(self.gsp_mem.driver_read_area()),
> @@ -768,15 +597,41 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
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
> +        Ok(GspMessage {
> +            header,
> +            contents: (slice_1, slice_2),
> +        })
> +    }

[Severity: High]
Does this code calculate the checksum over the entire available read area,
including trailing padding or queued messages?

In the original wait_for_msg(), slice_1 and slice_2 were trimmed to the
message payload_length before the checksum calculation. Since
wait_for_element() performs validation before trimming, won't valid messages
fail the checksum if there's extra data in the buffer?

[ ... ]

> @@ -863,9 +703,8 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout:=
 Delta) -> Result<M>
>          };
> =20
>          // Advance the read pointer past this message.
> -        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
> -            message.header.length().div_ceil(GSP_PAGE_SIZE),
> -        )?);
> +        self.gsp_mem
> +            .advance_cpu_read_ptr(message.header.element_count());
> =20
>          result
>      }

[Severity: High]
Does this code allow an untrusted GSP to arbitrarily manipulate the host's
ring buffer read pointer?

The element_count() value comes directly from the GSP message header and
is never validated against the available read area or queue capacity, unlike
payload_length.

Can a malicious GSP send a small payload but a huge element_count to force
the kernel to process uninitialized memory or stale data?

(Note: In the final state of the patch series, this logic ends up in
receive_rpc_msg(), but the vulnerability is introduced here).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-cmdq-rpc-v=
1-0-822db5af910e@nvidia.com?part=3D7
