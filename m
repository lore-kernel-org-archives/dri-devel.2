Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA366C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C28910E592;
	Sun, 27 Sep 2026 11:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y82dT5eQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1476910E592
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:26:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43D2560AAE;
 Sun, 27 Sep 2026 11:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB71F000FF;
 Sun, 27 Sep 2026 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790508404;
 bh=9r3PoyOMJ+47A7HCgzEunN7ip0IMB3F17Wu22sTfcm4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y82dT5eQeXwh55GSgOoCH8wfuQ/jBBfobADBJXl/P3D3kWQ2yU8LdRwD2aCWNgx/B
 /ayoYP1O9RZrp7L6QcuH63q/+rGfe7oU8dv2QOwTI/82VvtXrRiHNiM5wJCg7ErUlH
 DwyN4eaf/ud8nkiCEcdPYjU5s6iwS02Nuq+NSj7kwJzibBSqZvSs2NzvO0M/y39O8k
 R9ckt3Yt8zAHqkzIlGZwVjSWeMQ9mwY0szMeTaJ3o3eeMgzjTpEf0Eo5i7uTxgiWJX
 FhDzxHU/gXJ/Co/MFfII2foQ7gZmLwTxcIKtNWY95dIN82CDh0xq15RwOozj3O2frv
 Fs5qd1U22yO7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260927-cmdq-rpc-v1-5-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
 <20260927-cmdq-rpc-v1-5-822db5af910e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:26:43 +0000
Message-Id: <20260927112643.95CB71F000FF@smtp.kernel.org>
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
- [High] gpu: nova-core: spurious checksum failure due to un-truncated slic=
es
- [High] gpu: nova-core: infinite loop via unvalidated element_count from G=
SP
--

commit 90b2987a6783eb2acf6f7b5e9bf5e7fbc3108e1d
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: split the transport part of the send path
   =20
Move the transport part of send_single_command into send_command_element.
The RPC part of send_single_command is passed as a closure to set up moving=
=20
the RPC code into its own sub-module. No functional change intended.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index a5595da23407b..602824236f64e 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -768,16 +807,28 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
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

[Severity: High]
Does this code spuriously fail the checksum validation when the GSP leaves
padding in the ring buffer or batches messages?

The patch moves the Cmdq::calculate_checksum call in wait_for_msg before
slice_1 and slice_2 are truncated to the actual payload_length. Because
calculate_checksum iterates and hashes all bytes in the slices, it will now
hash the entire available read area (including trailing ring buffer data)
instead of just the single message.

> +            dev_err!(&self.dev, "GSP receive: bad checksum\n");
> +            return Err(EIO);
> +        }

[ ... ]

> @@ -863,9 +899,8 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout:=
 Delta) -> Result<M>
>          };
> =20
>          // Advance the read pointer past this message.
> -        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
> -            message.header.length().div_ceil(GSP_PAGE_SIZE),
> -        )?);
> +        self.gsp_mem
> +            .advance_cpu_read_ptr(message.header.element_count());

[Severity: High]
Can an untrusted or erroneously crafted message header from the GSP cause an
infinite loop here?

The patch changes the read pointer advancement in receive_msg to use
message.header.element_count() (the raw elemCount field from the GSP) inste=
ad
of safely deriving it from the bounded payload length.

If the GSP firmware provides an elemCount of 0 (or a multiple of
MSGQ_NUM_PAGES, i.e., 63), advance_cpu_read_ptr adds 0 to the read pointer.
If the driver then encounters an unexpected function code and retries, it
will continuously re-read the exact same zero-advancing message, resulting
in a deadlock.

> =20
>          result
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-cmdq-rpc-v=
1-0-822db5af910e@nvidia.com?part=3D5
