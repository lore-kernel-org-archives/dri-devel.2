Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C833BF4613F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 23:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B42610E1A0;
	Mon, 23 Mar 2026 23:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AK9DUsJb";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C512810E1A0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 23:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774308450; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h+dO8cWgKhEWwHUk+6Ypnh0HcW/icCMQf8cp1oYr813yB1jdtEj12X0aA4r4G+EM/wstm7ez01JSIsRv+nxVwH2kNtS+ufTHgKoJS3SCCUstCLd1LRgu6dr7sDDDwlIK6asnDrHRpN+JBxE2MIGSurOROaP2EQegFf4PVrRXvHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774308450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YrJBAP7z3Eve6M8Okky7j2Nvy/tTyRXC5sGNXnJ/Bzw=; 
 b=OaZ09Xz+oPCnLBV98T9SwdrskySKp/b4DsFSiB/ZvrTbhlM7iWWh7NfbTx0I+v6Mo6IY4QJ6rzXm/iQB7xIxvoLgG/+Ued46yxzIcH7kNnt7z7pg8GefFSmROUvAc7a+S4JC/l4OTuHvPVC0DeUF3AO/61acAz5zBbAzGx6ssY4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774308450; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=YrJBAP7z3Eve6M8Okky7j2Nvy/tTyRXC5sGNXnJ/Bzw=;
 b=AK9DUsJbZcCr6r7ix9NRZSjiGn503pgxSxzbZC0GHV+dpLZHIMGAmVyZUopzNpiM
 oCcWYiEcLhgEEdJfcpFrYX1GVZoU7ePUVTJG624Fs5m1+PtT1ih83SBh77QOuuJYa89
 vjX8+FZ3aStXRfLS6IgNmwxAeAnWvk9pl64hl2Rk=
Received: by mx.zohomail.com with SMTPS id 1774308448556785.1866483968992;
 Mon, 23 Mar 2026 16:27:28 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v3 0/4] rust: Add ARef support for work items
Date: Mon, 23 Mar 2026 20:26:58 -0300
Message-Id: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ6CMBCF4auYrq2ZDlTBlfcwLtoylUagpiVVQ
 7i7hY0Jict/Ju+bWKTgKLLzbmKBkovODzmK/Y6ZVg134q7JzRDwCEJIrgJZ/vLh4UbqOVh5otL
 qShjF8uaZv+69etdb7tbF0YfPyiexXP9JSXDgdVUVBGBBQn0xvuuU9kEdjO/ZoiX8CQjlVsAsa
 DIoNQhsUG2FeZ6/1QpYBvAAAAA=
X-Change-ID: 20260115-aref-workitem-0f57e4fb81ca
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.3
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

This series adds ARef<T> support for both regular and delayed work items.

- Patches 1 and 3 actually implement the support in workqueue.rs
- Patches 2 and 4 adds a corresponding implementation in drm::Device that
  dispatches the calls to the underlying T::Data.

This was tested on Tyr, and is actually needed in order to obtain a
&drm::Device when handling work items. This is then needed in order to
allocate GEM objects inside the work handler that processes the tiler OOM
(out of memory) events. The current series sets the stage so that the above
is possible in the future.

---
Changes in v3:
- Rebase on rust-drm
- Pick up tags
- Fix import style for drm/device.rs changes
- Link to v2: https://lore.kernel.org/r/20260204-aref-workitem-v2-0-bec25b012d2a@collabora.com

Changes in v2:
- Rebased on v6.19-rc8
- Cc workqueue maintainers
- Patch 2 kept the old import style, since drm/device.rs is not yet
  converted.
- Link to v1: https://lore.kernel.org/r/20260115-aref-workitem-v1-0-9883e00f0509@collabora.com

---
Daniel Almeida (4):
      rust: workqueue: add support for ARef<T>
      rust: drm: dispatch work items to the private data
      rust: workqueue: add delayed work support for ARef<T>
      rust: drm: dispatch delayed work items to the private data

 rust/kernel/drm/device.rs | 69 ++++++++++++++++++++++++++++++++--
 rust/kernel/workqueue.rs  | 96 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 156 insertions(+), 9 deletions(-)
---
base-commit: 55fd681cdd8599edc82013674cbf87c2f22d58f8
change-id: 20260115-aref-workitem-0f57e4fb81ca

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>

