Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA2606A324
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=amJsz3Kz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596DA10F0DE;
	Mon, 19 Oct 2026 23:26:21 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D567C10F0DE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792452363; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N1ayl3dIhfYqDRtJKbhikZsesTbA1zY0jWBovgB0PtdeyE/mlR6BtlDCAbefwmBtES7s1dcYp7rNrNbfVQNLCjOmE7IN5sf3E6yikdzni7KRNSzME6/vo+Abp91zyhpC7HqDMJeSFx0ax7BsQZeHaEqumvVsAcXNvG6h2T+nCwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792452363;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SCKr4R0YQW/JC0KzEfSj2X+T/HHOj484eMwAq1mbw4o=; 
 b=idP9MqFp5TD3tVlJ1YTef5UmuxaM3VxF5bkmj0gLx/QaP9J/lmHiZec01OZj0kuLjpohWezBtqWTpbJ5QWH3r2NCOzK0Su9Mle4vNLnqQlAHlTOVywyPF1M3LPcdtGgA0N6buKBSOkOYN4oSWoknZ2qRvK3hZTTeEBNOwKm451E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792452363; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=SCKr4R0YQW/JC0KzEfSj2X+T/HHOj484eMwAq1mbw4o=;
 b=amJsz3KznujtofXwTjgUkv75nXAKhf1rwfEo7WBDSpQ6s1HWoqA/U4gvootGIOU1
 rxNn6g377RhiM2K/i5l6lbIW2ugubiwSuRdwdMKKAJuEYNREonqGtc+qK2V8xAvEIRH
 SqwE96HV49M30VPTkBaoH4044WLIFI4/VMTDx13k=
Received: by smtp.zohomail.com with SMTPS id 1792452361432714.8129296866091;
 Mon, 19 Oct 2026 16:26:01 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v4 0/2] drm/tyr: safely write GpuInfo to userspace
Date: Mon, 19 Oct 2026 16:25:58 -0700
Message-Id: <20261019-b4-gpu_info_intobytes-v4-0-0bc04df46549@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNUQuCMBDA8a8Se26x22a5nvoeEeHmLQfmZDNJx
 O/e9Eki6eXgf3C/G0nE4DCS824kAXsXnW9SyP2OmKpoHkhdmZpwxo9McUG1pI/2dXeN9Wl0Xg8
 dRmp4KTPLlchMTtJtG9C69+Jeb6krFzsfhuVND/P2n9gDBao1h5OwChDgYnxdF9qH4mD8k8xqz
 9eS3JJ4kkCzDIUobV7IX5JYS9mWJCijCEobfQKVs/JbmqbpA0OnsexSAQAA
X-Change-ID: 20260923-b4-gpu_info_intobytes-c2d45f2935c8
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=uZl829yKYg5YevcpfHlgniaorxFo1PZUw8cpY3VJI98=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFnXlnO4eyzgNw8+k7/JRGrLl5VHH90QsBD/u8i/WOr3s
 3B9xViljlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACbyYyXDP+ujn9Zf3PvBtrW5
 sNHb3ljj/PnfLfITEiTWf1r4pbS+ZD7D/wrV179jPjlMCN1054FJYnLxhE9Xdx4xEo7ObUud58r
 jxQgA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series makes zerocopy and zerocopy_derive available to both the UAPI
and bindings crates.

It derives the zerocopy traits specifically for struct
drm_panthor_gpu_info, allowing Tyr to safely copy this struct byte-for-
byte into userspace memory.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v4:
- add zerocopy and zerocopy_derive to bindings crate
- move derivation for drm_panthor_gpu_info to tyr patch
- use kernel prelude to import IntoBytes
- pick up Reviewed-by tag
- Link to v3: https://lore.kernel.org/r/20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com

Changes in v3:
- split the commit into two to keep Tyr changes separate
- Link to v2: https://lore.kernel.org/r/20260924-b4-gpu_info_intobytes-v2-1-1b05e33df8a4@collabora.com

Changes in v2:
- use zerocopy_derive::most_traits
- Link to v1: https://lore.kernel.org/r/20260923-b4-gpu_info_intobytes-v1-1-bb2173f91e11@collabora.com

---
Deborah Brouwer (2):
      rust/Makefile: add zerocopy and zerocopy_derive
      drm/tyr: safely write GpuInfo to userspace

 drivers/gpu/drm/tyr/file.rs |  2 +-
 drivers/gpu/drm/tyr/gpu.rs  | 16 +++-------------
 rust/Makefile               | 24 ++++++++++++++++++------
 rust/bindgen_parameters     |  3 +++
 4 files changed, 25 insertions(+), 20 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20260923-b4-gpu_info_intobytes-c2d45f2935c8

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

