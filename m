Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC8BCCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A371129CC;
	Fri, 16 Oct 2026 20:44:38 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA631129D6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792183465; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EZREJ6kgt2bdfNT6PdIWbjX4EjZjPSFXAmOgsk8Ram4d1Y8EjOICJbmp9fJKgw3cJRJHIG+aW3aVIMoKlOvMKETAvxNS0cE4twHH4lHxb7PZOGwVimh5IIzCN3xNH2aG8b6TvLdDzMj6wu6lvkR+o7RKv2yYDy+uVsvSgTZZIao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792183465;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HbKEi7ISZYZXhJNW8VJgY93KLj1zenEqwESNR1eollU=; 
 b=cCqp3xaTmz52NNPklgIPGG7PJOr+KYBSJttTa8kcmanotpWE0lGiq80vV9TzVfFH1lPQy8JrBgtc61IJ/1GC+CpvzWYscc9frZxeVJmVsty+9PbOHSDzZ5d4N9J+aXdLhbgl/hbC9hsTmvhnHTF4r0eSI73yetxxrzG5qwn8lFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792183465; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=HbKEi7ISZYZXhJNW8VJgY93KLj1zenEqwESNR1eollU=;
 b=kOanLhrxsbg/dtfaNrOBlqEb9HpxKVx/d7HX6x+ZAUXY79yFWpbE5GfXi0pxtWOl
 DHt+0EFc/eVQjFIYaTVeEUIICR2vDrYqHekPXx65touRLdJ3lX8GhbjrUlyS1wKBadg
 ZQBkROVpqQAE0aTBhtn8NfkDbIpnnTzVEOjl1oWo=
Received: by smtp.zohomail.com with SMTPS id 1792183463309421.0668362086856;
 Fri, 16 Oct 2026 13:44:23 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v3 0/2] drm/tyr: allow mismatched buffers for dev_query
Date: Fri, 16 Oct 2026 13:44:19 -0700
Message-Id: <20261016-b4-dev_query_fixes-v3-0-f8071cda3515@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQrCMBAF0KuUrI1MpmmlrryHSEnS0QZqo4kGS
 8ndTbsSEZf/D//NzAJ5S4Hti5l5ijZYN+ZQbgpmejVeiNsuZ4aAtQAhuZa8o9jen+Sn9mxfFLg
 kUBpQYiMVy8Obp/WQd8dTzr0ND+en9UcUS/uXi4IDbxBkKQC03OHBuGFQ2nm1Ne7KFjLiJ1P9Z
 DAzVFLdYQUVGP3NpJTeDlPvk/8AAAA=
X-Change-ID: 20261014-b4-dev_query_fixes-4e0ab024294a
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=kFT4NF//LSmUCweo9QjRiRugC7PHPBQASljM8FU2LYs=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmXepYlvjq1T55f8Iy+R9G9A+uYJL90Ws3ymTDdxyTzn
 /vqqtcGHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAEzkkDUjQ+ep/uJ+uelRigav
 1j9/GSq/PqhxQ8C1bl+GgEjBEPeIpwz/DJgb16duXNnM5938fcfyOVfe+D7982jRusduczI2zBd
 pYAMA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Panthor UAPI for DRM_IOCTL_TYR_DEV_QUERY allows userspace to provide
a smaller or larger buffer than the kernel needs. Revise Tyr's
implementation to match the expected UAPI behaviour.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v3:
- replace "as" cast with lossless u32_as_usize()
- Link to v2: https://lore.kernel.org/r/20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com

Changes in v2:
- Added #[inline] to UserSliceWriter::clear()
- Link to v1: https://lore.kernel.org/r/20261014-b4-dev_query_fixes-v1-0-92043100b472@collabora.com

---
Deborah Brouwer (2):
      rust: uaccess: add UserSliceWriter::clear()
      drm/tyr: allow userspace buffers to be mismatched

 drivers/gpu/drm/tyr/file.rs | 47 +++++++++++++++++++++++++++++++++++++--------
 rust/helpers/uaccess.c      |  6 ++++++
 rust/kernel/uaccess.rs      | 24 +++++++++++++++++++++++
 3 files changed, 69 insertions(+), 8 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20261014-b4-dev_query_fixes-4e0ab024294a

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

