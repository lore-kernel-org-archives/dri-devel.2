Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE06C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C309110E521;
	Tue, 28 Jul 2026 18:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZUtoqQRH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE8410E521
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:52:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D85460A5E;
 Tue, 28 Jul 2026 18:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828AC1F00A3A;
 Tue, 28 Jul 2026 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264757;
 bh=SEx8+LsndwXFKy+SmXygh1VRbbaQ/mWsT30cZ4CAY6Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZUtoqQRHVv3nuz9R3wIRqL5rjSEcStFsdTm4K3FhogwLdG2aunQKmq78trn1QHo/Y
 1JQ5oSa7bpz8XWafsTDbbifpigIWdJQYRCiGcW74MDx1IRY0UCAPkwfCtjtXnC96Cv
 N+N5ywPCKvm4i8Hr5NdWBvX9lpL5zfY39lpDaf7qrW+cwXKj8ffsvEtEYsp7q/V/i0
 OomRjw/HWbnHh1mtFGGkEvmy/lndj/S/aMPqfximhYyHBM8ik6vng/C6IPogjCiAEj
 4OCnRdQsZfXN3ELpjUTvTyyQ4SMVvSnfurDaFM/bYZNBt67P8ysWbUwRyvhe4ciTw0
 7W840P6db6EvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/7] drm/tyr: add Memory Management Unit (MMU) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-fw-boot-b4-v10-3-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-3-9187aefa3f2f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:52:37 +0000
Message-Id: <20260728185237.828AC1F00A3A@smtp.kernel.org>
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
- [High] Missing MmuCommand::Unlock in as_end_update() leaves the address s=
pace locked.
--

--- Patch [3]: [PATCH v10 3/7] drm/tyr: add Memory Management Unit (MMU) su=
pport ---
commit 4673c22526eac7702f0e2418212a28a74a5e56d8
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add Memory Management Unit (MMU) support
   =20
Add Memory Management Unit (MMU) support in Tyr, which wraps a SlotManager
instance to allocate MMU address-space slots for virtual memory. This inclu=
des
an AddressSpaceManager for MMU hardware register operations such as locking
and flushing address spaces.

> diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/t=
yr/mmu/address_space.rs
> new file mode 100644
> index 0000000000000..76e3d2df6afd4
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu/address_space.rs

[ ... ]

> +    /// Locks a region of the translation tables for an atomic update.
> +    ///
> +    /// Programs the MMU LOCKADDR register for the given address space a=
nd issues
> +    /// the lock command. The hardware rounds the requested range up to a
> +    /// power-of-two region aligned to its size.
> +    ///
> +    /// Returns an error if the slot is invalid or if register writes/co=
mmands fail.
> +    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> =
Result {

[ ... ]

> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::Lock)
> +    }
> +
> +    /// Completes an atomic translation table update.
> +    ///
> +    /// Returns an error if the slot is invalid or if the flush command =
fails.
> +    fn as_end_update(&mut self, as_nr: usize) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushPt)?;

[Severity: High]
Does this function also need to send MmuCommand::Unlock to release the lock=
ed
region?

The start of the update sequence in as_start_update() locks the region by
sending MmuCommand::Lock, but as_end_update() currently only sends
MmuCommand::FlushPt and omits the unlock command.=20

If the address space remains locked, GPU accesses to the updated virtual
memory region could be permanently blocked. This might lead to GPU hangs or
command timeouts when userspace triggers VM mapping or unmapping operations.

> +        Ok(())
> +    }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-fw-boot-b4=
-v10-0-9187aefa3f2f@collabora.com?part=3D3
