Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B250606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK7uPiZ3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AC610ECFA;
	Wed, 18 Nov 2026 23:37:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9508010ECFA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:37:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA2AE642C3;
 Wed, 18 Nov 2026 23:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B451F000C7;
 Wed, 18 Nov 2026 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045072;
 bh=AkAg6L5zEzM+0zn2rA3ANMwlJH9j/CQ/7JKe3RPzwQk=;
 h=From:To:Cc:Subject:Date;
 b=WK7uPiZ38zHXjJLnXwa6kLb44zKfNlzRwSU22q7AE80VUDPbot1ZJE6AtSqzfkbA8
 jDYibcwMk6qX4W6jT/VlxDEpZkIJr5I4OlKFfw5OWrI2tSRrCFUgQUBOve19Bz8kx6
 JO4ZjdIIaGYF4bBbxDVtfox8Pq9OdoztGvJkByjX3GdCTIoJYkeX9Jj1/hcg4X9VRn
 kRG1RH37y5GWbj86eQrNjI+6Fiob+UWpt+KdpTYzNPz93sGtdDmssy0b9xK84snunL
 enKN73QgrpMfSWAL47vfuPveXTdS0K5gudI7ukXeC7s3wyUK4eQqv6hqBC0jm2XSLR
 +h803z6KNAKRQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/tyr: use pin-init self-referential support
Date: Thu, 19 Nov 2026 00:37:01 +0100
Message-ID: <20261118233727.3147222-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series uses pin-init's self-referential support to replace Arcs for
resources whose lifetimes are bounded by their owners.

It also cleans up lifetime names, fixes a Clippy warning in generated pin-init
code, and simplifies firmware loading cleanup with ScopeGuard.

Danilo Krummrich (4):
  drm/tyr: name resource lifetimes after their types
  rust: pin-init: internal: suppress multiple_bound_locations
  drm/tyr: use pin-init self-referential support
  drm/tyr: use ScopeGuard for firmware loading cleanup

 drivers/gpu/drm/tyr/driver.rs            |  38 +++---
 drivers/gpu/drm/tyr/fw.rs                | 151 ++++++++++++-----------
 drivers/gpu/drm/tyr/gem.rs               |  15 +--
 drivers/gpu/drm/tyr/mmu.rs               |  56 ++++-----
 drivers/gpu/drm/tyr/mmu/address_space.rs |  40 +++---
 drivers/gpu/drm/tyr/vm.rs                | 119 +++++++++---------
 rust/pin-init/internal/src/pin_data.rs   |   3 +-
 7 files changed, 209 insertions(+), 213 deletions(-)


base-commit: e55a991e09e3b44f0b0d8206bb523dc57c086341
-- 
2.56.1

