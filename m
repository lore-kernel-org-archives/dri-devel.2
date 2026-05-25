Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AC9CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 18:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2FD10E3AA;
	Mon, 25 May 2026 18:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AYZvj8N4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D0110E3AA
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 18:38:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A2AF41B00;
 Mon, 25 May 2026 18:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDCA1F00A3A;
 Mon, 25 May 2026 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779734284;
 bh=mN2gvY76w7RYv5QRGp6IcLdPIf6m0X0H7GP8iD/hsJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AYZvj8N4aEzgzAiLq/OmKE/xx43jLGpcNgxcTRoF36Xjpi/h+rdmx2zMy6Q/Rtbqd
 3oy2QJpXNd/2sY8fNc+ILBzLFZHi/wU01BQ2syph6xy/VrJOugloDDXt0pFbOwDyix
 JDqBTXTITZTcCYvg7EzaMP3mn4O8L3B9AdVncWaN+M3OOAwOkBH+afh1Hdo2EN+iGu
 CE+dWFZFolfXvIqVVFACd6JUnHuETJ8Ay67PcvvRZbr/oI0XL4enR4HvER5uVMhVY9
 OWEOHdPJ9DZFZp+qI6GpR6WlOT4fuuXRY57nfflHIPyGeGQoHPYG/kG2DrWzrPLgwl
 L2M8UNVhNC5gw==
From: Danilo Krummrich <dakr@kernel.org>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v5 00/22] gpu: nova-core: vbios: harden various array
 accesses and refactor
Date: Mon, 25 May 2026 20:37:52 +0200
Message-ID: <20260525183752.99203-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 25 May 2026 22:57:18 +0900, Eliot Courtney wrote:
> [PATCH v5 00/22] gpu: nova-core: vbios: harden various array accesses and refactor

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/22] gpu: nova-core: vbios: stop scanning at BIOS_MAX_SCAN_LEN
      commit: fc7c1054b6f9
[2/22] gpu: nova-core: vbios: use checked arithmetic for bios image range end
      commit: 7a1d09e477b6
[3/22] gpu: nova-core: vbios: avoid reading too far in read_more_at_offset
      commit: 33f1402bcfa6
[4/22] gpu: nova-core: vbios: read BitToken using FromBytes
      commit: 237c252be0db
[5/22] gpu: nova-core: vbios: use checked ops and accesses in `FwSecBiosImage::ucode`
      commit: 7c62d0b00652
[6/22] gpu: nova-core: vbios: use checked access in `FwSecBiosImage::header`
      commit: 25ad950b4ee3
[7/22] gpu: nova-core: vbios: use checked accesses in `setup_falcon_data`
      commit: 051ae1b21ff7
[8/22] gpu: nova-core: vbios: drop unused falcon_data_offset from FwSecBiosBuilder
      commit: 56f7c0b3800e
[9/22] gpu: nova-core: vbios: keep PmuLookupTable local in setup_falcon_data
      commit: 8cf15cf2641b
[10/22] gpu: nova-core: vbios: compute FWSEC-relative Falcon data offset
      commit: b2a48fc068ea
[11/22] gpu: nova-core: vbios: simplify setup_falcon_data
      commit: 99e110a36885
[12/22] gpu: nova-core: vbios: read PMU lookup entries using FromBytes
      commit: c22095fddad7
[13/22] gpu: nova-core: vbios: store PMU lookup entries in a KVVec
      commit: 620e7ac19664
[14/22] gpu: nova-core: vbios: construct `FwSecBiosImage` directly from BIOS images
      commit: 7e545bed7b1a
[15/22] gpu: nova-core: vbios: use the first PCI-AT image
      commit: 433730a61f13
[16/22] gpu: nova-core: vbios: use single logical block for the FWSEC section
      commit: 43e7bef8c054
[17/22] gpu: nova-core: vbios: use let-else in Vbios::new
      commit: e8baefdffd4e
[18/22] gpu: nova-core: vbios: remove unnecessary fields in PciRomHeader
      commit: 84eb369da613
[19/22] gpu: nova-core: vbios: drop unused image wrappers
      commit: 91a8ec505e09
[20/22] gpu: nova-core: vbios: drop redundant TryFrom import
      commit: 16c41263240e
[21/22] gpu: nova-core: vbios: move constants and functions to be associated
      commit: c70fe8b2bacf
[22/22] gpu: nova-core: vbios: remove unused rom_header field
      commit: 2cf1840b0fa7

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
