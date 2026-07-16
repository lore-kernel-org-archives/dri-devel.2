Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F7FC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6B810E3A4;
	Thu, 16 Jul 2026 17:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ni9G6ir7";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4104510E312;
 Thu, 16 Jul 2026 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784221779;
 bh=E/neM9q45oFk5vumCuNs3BlrBpr2PnvuUZbONFwRIKg=;
 h=From:Subject:Date:To:Cc:From;
 b=Ni9G6ir7X07AFt8GUroRRtE9hkhAZNVOrzMQepnCFH2BcL030i+v9bC1kxvm2nAcT
 nBbfHbVv/hBI75X0GZYJLl9tKUrCqPmSJWW3FIN5WIibKGxUoM65IQK9N0kdBRsDF1
 ZIUvhnPTAVAJ1lFO1jm81GcoprxerHFvc3XjcNzY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/6] configfs: Allow the registration of const struct
 configfs_attribute
Date: Thu, 16 Jul 2026 19:09:25 +0200
Message-Id: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWtSl1Z4FbHQmjIWJR1EIt5ds
 Tvf4vwXMAZChia5IOBBTIuPyNIE7NT7EQUN0ZDLXMsq08Iu3tHo+B28CdMzCl0rZWRZKC0NxOc
 a0NH5VdvuN+9mRru9KbjvB7LL58h3AAAA
X-Change-ID: 20260716-configfs-const-base-6955b043560b
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=1356;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=E/neM9q45oFk5vumCuNs3BlrBpr2PnvuUZbONFwRIKg=;
 b=W8B1eCdzBPF+vX/iGW+KJHE8xAceDD1at4gcqjxGEzdBiqCIOPZrlc1rI1Witb3eC2twB400h
 B8v+ldzTTnpAVplEdwuXCfW7epvpRYTFvlvmL1bey309UhnH5QkbVcJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
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

The attribute structure defined in driver code never need to be
modified. Allow them to be marked as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (6):
      rust: configfs: remove mutability from some field initializers
      configfs: Constify is_visible/is_visible_bin in configfs_group_operations
      configfs: Treat attribute structures as const internally
      configfs: Constify configfs_bin_attribute
      configfs: Allow the registration of const struct configfs_attribute
      samples: configfs: constify the configfs_attribute structures

 drivers/acpi/acpi_configfs.c       |  2 +-
 drivers/gpu/drm/xe/xe_configfs.c   |  4 +--
 drivers/virt/coco/guest/report.c   |  6 ++--
 fs/configfs/configfs_internal.h    | 10 +++---
 fs/configfs/dir.c                  | 10 +++---
 fs/configfs/file.c                 |  6 ++--
 fs/configfs/inode.c                |  2 +-
 include/linux/configfs.h           | 73 ++++++++++++++++++++------------------
 rust/kernel/configfs.rs            | 20 ++++++-----
 samples/configfs/configfs_sample.c | 16 ++++-----
 10 files changed, 78 insertions(+), 71 deletions(-)
---
base-commit: c8d07eca6270b3f41c0e528a470895f1bd42e2b7
change-id: 20260716-configfs-const-base-6955b043560b

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

