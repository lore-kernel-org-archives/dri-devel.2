Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DD0C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1877110E989;
	Sun, 13 Sep 2026 18:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XskOZtlg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C78510E989
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:48:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 940A560F86;
 Sun, 13 Sep 2026 18:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13A51F000FF;
 Sun, 13 Sep 2026 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789325280;
 bh=MKMZzI4Nc4DI9/fRGOMqAvrYvUaAxhnC+5abzqlJR/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XskOZtlg8evU6ybPDNYKtKwf8Za0Rty9jfd5C7pYZKOju9yABiBJ7N/vCoT6kYStf
 R4wSRsR+JqiOCTOTUd7883aVkNgtbtP6wSmPXARmyMOoZMjvz9uMObmW/BBRkiZk2Z
 LCXXmidPp2VVHHei4XfNcGQdnZCQGriLx7vPhBEKPrXmfa702eV0acPVipm82Yxubo
 x/tcq3biGfo0mFwroreDcZUaSnLMUzHom4/07rkxHIZ3juGVGe3VVxdVIZl4hMz+P8
 tzEvCNKeOEK4kDLwvQXneq8zi/RlwwYAqWKtHQ4LxwFFPNjjY3D9K3qAVe81Yn6xpR
 9OcekGDDMKaug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] gpu: nova-core: gsp: retain the GSP-RM log
 buffers after unbind
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260913183734.134307-3-vladazaharova2018@gmail.com>
References: <20260913183734.134307-1-vladazaharova2018@gmail.com>
 <20260913183734.134307-3-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 18:47:59 +0000
Message-Id: <20260913184759.E13A51F000FF@smtp.kernel.org>
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
- [Medium] The `dma_mb(Read)` memory barrier does not protect against data =
races because the snapshot relies on the `put` pointer re-read by the unord=
ered `copy_to_slice()`.
--

commit cb68e0aae9b03cb04a10d2043892acfc8a1fe581
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind

Adds a module parameter to retain GSP-RM log buffers after unbind, making
them available through debugfs. This copies the contents into module-owned
memory since the original buffers are DMA allocations that do not outlive
the device.

> diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-co=
re/gsp/logbuffer.rs
> new file mode 100644
> index 0000000000000..890aa2f9e38e7
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
[ ... ]
> +    fn snapshot(&self) -> Result<VVec<u8>> {
> +        // Offset 0 holds the "put" pointer, which the GSP advances as i=
t appends entries. It is
> +        // still zero if nothing was ever logged, which is all that is t=
ested here: a buffer that
> +        // was written to is copied whole, and making sense of "put" is =
left to the decoder.
> +        let put =3D io_project!(self.0, [build: ..size_of::<u64>()]).try=
_cast::<u64>()?;
> +        if put.read_val() =3D=3D 0 {
> +            return Ok(VVec::new());
> +        }
> +
> +        // ORDERING: LOAD->LOAD ordering needed to order the "put" read =
before the data read. The
> +        // GSP has normally been stopped by the time this runs, but a bo=
ot that timed out can leave
> +        // it still appending.
> +        dma_mb(Read);
> +
> +        let mut snapshot =3D VVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
> +        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);

[Severity: Medium]
Does the unordered copy_to_slice() at the end of this function negate the
effect of dma_mb(Read)?

If a boot times out, the GSP may still be appending logs when
LogBuffer::snapshot() is called. The safely ordered "put" value is dropped
here, and the snapshot relies on the "put" pointer being re-read by the
unordered copy_to_slice() operation.

This means copy_to_slice() can read the log payload before reading the "put"
pointer at offset 0. If the GSP concurrently writes new logs and updates the
"put" pointer, the snapshot could capture the updated "put" pointer but sta=
le
log payload data, causing the user-space decoder to parse garbage data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913183734.1343=
07-1-vladazaharova2018@gmail.com?part=3D2
