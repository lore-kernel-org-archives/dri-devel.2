Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39336CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BF610E2CE;
	Thu, 15 Oct 2026 12:39:30 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D775B10E2CE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792067961; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tjon6KLoMZGTD3gYcYFkxUTwF+kL/rEvtPXr/cLuEUe0xAJZEi4CaPX5SAOalGxj47gyaa7EUmOWssido+ThW29/sXeDlFM4k2lnvT5Wh2kUBslvTcUoOp3UumqasYY72nBCuqqKkyIAHS4U1E4B/efPA3B0+5GyJsE/aLw+qLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792067961;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b8QxlcXuE8fvWepGOYNbeyD9I1BGJwMpPeaLkpEcykM=; 
 b=Fpk+np0RBTlIkbUHRGiugJ20uaCXC0VsxEl2oFYM8i4oxQKATFX3oSlr4dGQKBN28JExT0xlke9QmFGWgUnDmBpOyIdlM2GKKHIQq9gBGu6GwyjCmzhVVgTo4IjLrGzv9CUDTtD/fTAYVjiEV7QC3rbX0L2x3tOoZMZnnpsZgnk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067961; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=b8QxlcXuE8fvWepGOYNbeyD9I1BGJwMpPeaLkpEcykM=;
 b=QdSJw4To7te5oLZBwuxM/5Rm1bpc3a31680SH4Uhs+gIggIWD/6BUt+jejrwcLiW
 9LH6cnMbzu/uzMhEaEtQb6R5kuIY1KWIw0N2xRl4/6vrQxvL2KMH7YpIbkwamL3e6fF
 yPlMA+B2TCNfJwyQRiScx8bSmHtRo6NkqtslmNLY=
Received: by smtp.zohomail.com with SMTPS id 1792067959377676.561264213707;
 Thu, 15 Oct 2026 05:39:19 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/7] rust: io: add read-only and write-only views and registers
Date: Thu, 15 Oct 2026 09:39:04 -0300
Message-Id: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g3MjFS0VyldxJhqhDoyURHEu
 3dsl2/x/wEmScXgURyQZFPTOGX4WwE80NQLapcNwYXKO39HjUjMYoaf2Imhb4hD64hCWUOu5iR
 v3X/H5+tvW9tReLk2cJ5fAraH63MAAAA=
X-Change-ID: 20261015-io-access-modes-19ac2b0aa238
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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

This series adds read-only and write-only I/O views, and the #[ro]
and #[wo] attributes to register!. An access in the wrong direction
then does not compile.

This is needed by Tyr, where the doorbell registers are write-only and
the CSF control and output blocks shared with the firmware must only be
read by the driver. Laura's CSF interface series [1] will be the second
user.

Patches 1 and 2 split IoCapable into IoReadable and IoWritable, and
IoCopyable into IoCopyReadable and IoCopyWritable.

Patch 3 adds the ReadOnly and WriteOnly views, returned by
Io::read_only() and Io::write_only(). They wrap any view, and the views
projected from them keep the restriction.

Patch 4 makes the primitive accessors (read32() and friends) project the
view directly instead of going through the generic read and write
methods.

Patch 5 lets an IoLoc carry an access mode, which is applied to the view
projected through it.

Patch 6 adds the #[ro] and #[wo] attributes to register!.

Patch 7 marks the read-only and write-only registers in Tyr. Where
regs.rs does not document a mode, it follows the register permissions
for v10 GPUs in Arm's kbase driver (r54p1).

This is based on drm-rust-next.

[1] https://lore.kernel.org/r/20260915-tyr-interfaces-v1-6-5d28f1f75aca@collabora.com

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Daniel Almeida (7):
      rust: io: split IoCapable into IoReadable and IoWritable
      rust: io: split IoCopyable into IoCopyReadable and IoCopyWritable
      rust: io: add read-only and write-only views
      rust: io: project primitive accessors directly
      rust: io: let I/O locations carry an access mode
      rust: io: register: add `#[ro]` and `#[wo]` attributes
      drm/tyr: mark read-only and write-only registers

 drivers/gpu/drm/tyr/regs.rs |  77 ++++++++
 rust/kernel/dma.rs          |  29 +--
 rust/kernel/io.rs           | 416 +++++++++++++++++++++++++++++++++-----------
 rust/kernel/io/access.rs    |  76 ++++++++
 rust/kernel/io/register.rs  |  71 +++++++-
 rust/kernel/pci/io.rs       |  10 +-
 rust/macros/io/register.rs  |  34 +++-
 7 files changed, 595 insertions(+), 118 deletions(-)
---
base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
change-id: 20261015-io-access-modes-19ac2b0aa238

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

