Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5338BCCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3426410E071;
	Thu, 15 Oct 2026 18:35:41 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6DA10E071
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792089329; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ejuTDv9eSyDHz0tAzhdZKZ61+RclRZT2PlorYoHHIcgf8/0jWKoaFqkxH2wYVEVz4C4cOvCGBz0ZOMVkw9o68EbygKKp2tKZjpsjINOMsvJaj2VkISoZacPJfbNSXGODU+ygkd96wGYwdvBmM61cgHiYj1DVCjn/MrTt0NA9X5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792089329;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=djRhpTg8qGXZHhY6aa7WleNEISp6WlPBMF571Nk+QtM=; 
 b=i0994EBHI4pgfGZuzEAK6Zi9AjTJ/FCDipCcI5wA6q9vE/Hibs36VrZC8FP+kgqtWYMm3fZynzbMa29Kbb07mqiYGwA8YiG4gk0hIZ3zhukZORx0zSapzvoCixYEM5QGkJbhK1FW24pGTU8pd0ChJsrez1zV2oidwe7d/93o1UE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792089329; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=djRhpTg8qGXZHhY6aa7WleNEISp6WlPBMF571Nk+QtM=;
 b=cKUCMgmHX1EpvVCRdyWbH+gqK3GN1TXSob6ApShwbxsnPZAXHhFPFFp1wlfZdaWs
 nvXFRcHbJMf2ZcM9oN1kYsIbHEEsWReRnf9BdsRXQGRpPV3o1qtdvkBILRDnYBiVbx/
 ean1yVzquLly1iQb+T13rAiEqGIJwHjHxIaXX+nE=
Received: by smtp.zohomail.com with SMTPS id 1792089328304691.1107606086146;
 Thu, 15 Oct 2026 11:35:28 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v2 0/2] drm/tyr: allow mismatched buffers for dev_query
Date: Thu, 15 Oct 2026 11:35:19 -0700
Message-Id: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NUQrCMBBEr1L228hmXZT65T2klKRdbaA2NdFgK
 bm7sQfw883wZlaIEpxEOFcrBEkuOj8VoF0F3WCmuyjXFwZCOmrUrCyrXlL7fEtY2pv7SFQsaCw
 SU80GijgH2YriXZvCg4svH5btI+lf+ncuaYWqJuSDRrR8okvnx9FYH8y+8w9ocs5fVjLC87gAA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=981;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=9qaq04hOhMKcjXPCCXP9jfVDRqMYwjh3FRgdf9rDCqc=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkXZd6dFppSyqCSmr/u8Be7V/ZnPed2Xd2prvVo94lJt
 g13r/9K6ChlYRDjYpAVU2Q5a2/UI1713kh3/v9mmDmsTCBDGLg4BWAitlqMDJvuhE/nm8H8c92n
 j/47My7EOS268C+k5avog69S9+dKrK1gZLhdVjFx37YoqVUNyqdehMz7b+rwu8Jkw+JAmb4rS+7
 zq3MBAA==
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
Changes in v2:
- Added #[inline] to UserSliceWriter::clear()
- Link to v1: https://lore.kernel.org/r/20261014-b4-dev_query_fixes-v1-0-92043100b472@collabora.com

---
Deborah Brouwer (2):
      rust: uaccess: add UserSliceWriter::clear()
      drm/tyr: allow userspace buffers to be mismatched

 drivers/gpu/drm/tyr/file.rs | 45 +++++++++++++++++++++++++++++++++++++--------
 rust/helpers/uaccess.c      |  6 ++++++
 rust/kernel/uaccess.rs      | 24 ++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 8 deletions(-)
---
base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
change-id: 20261014-b4-dev_query_fixes-4e0ab024294a

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

