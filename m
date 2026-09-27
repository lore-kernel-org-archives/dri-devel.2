Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FF7C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012A010E587;
	Sun, 27 Sep 2026 11:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jvtuR1MB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B3410E587
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:23:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F6ED40C35;
 Sun, 27 Sep 2026 11:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BC91F000FF;
 Sun, 27 Sep 2026 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790508211;
 bh=6netCiyDZA5CA37P8HRTFW9nAeL18e17cdFOrafqqF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jvtuR1MBqkkg5B6A3qIMbG/1jrPLXK8Iltqr3X4+8SjYctCvsrFlnAhP7HSu6h/Ji
 OwETfMuUE+y1VZgCQtgCn0shmCV1PG6nCSsX58+aOzYLSvarj2zZ1Lggx6VyrnahRb
 zgP2a++cIoTRIqxSloEhq26Gom0OdEILe3elrdZZt1LIkDBMkGzp7yhvX2sq0oOxHU
 QNrTSgevcWp8ltRe8f6QxGM1N9gkkLH8MzSZAWurULMOLBEIwfUIH7PpHDHFV62nQI
 ZNqVzqXqsz/QlgCcDz6U6LzaRqkCLOcSVePAAzELtzbFW+Yt4WwdBJhcH94kZ3/oyr
 YnVwOjCrtOxCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: gary@garyguo.net, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-2-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
 <20260927-cmdq-rpc-v1-2-822db5af910e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:23:30 +0000
Message-Id: <20260927112331.32BC91F000FF@smtp.kernel.org>
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
- [High] gpu/nova: GSP message queue permanently wedges due to untruncated =
checksum calculation
--

commit 5dd9973126ada78a1c8fff2d08bacb19190898fd
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: validate checksum earlier on receive

This commit moves the checksum validation of received messages to occur
before the RPC message header is accessed.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 9285fd796f9d3..08a49450bca0f 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -768,6 +768,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gsp=
Message<'_>> {
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
Does this perform the checksum validation on slice_1 and slice_2 before
they have been truncated to the actual message length?

If the read area spans more bytes than the actual message length,
could the slices contain non-zero trailing data from subsequent
messages or old uninitialized data in the circular buffer page?

If the checksum is calculated over the entire un-truncated read area,
wait_for_msg() will return Err(EIO) without advancing the read pointer.

Could this cause the GSP message queue to wedge permanently, as
subsequent calls will repeatedly read the exact same bytes and fail
the checksum again?

> +            dev_err!(&self.dev, "GSP receive: bad checksum\n");
> +            return Err(EIO);
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-cmdq-rpc-v=
1-0-822db5af910e@nvidia.com?part=3D2
