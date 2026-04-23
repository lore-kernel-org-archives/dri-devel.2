Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0054AF589B0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842A10F101;
	Thu, 23 Apr 2026 12:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8XGKi48";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CF810F101
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:46:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FB376013B;
 Thu, 23 Apr 2026 12:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745F6C2BCAF;
 Thu, 23 Apr 2026 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776948415;
 bh=Z1SRFOf8ubpizkQwR1RGL7K+h3/4bmk5BcIeruO4Q8g=;
 h=From:To:Cc:Subject:Date:From;
 b=Q8XGKi48kss+LCHntNINl8LxIgrncU8OZrspY/J8V/RkUksKaabwOiB6V7sQ7Wk5u
 Ez0wd3fyLGQatktl7KAsqbLdGe2ou9Xe9rc9JLkTmaxCA8dH5CTzuXmu4piQn72fFd
 7a3i3ssf9+YhlA18+B/8uE0H23LwbYaywVo3FOPp9hdXv6bZnPKUXBqHh/by+d2DJU
 NhCpI+2vDD+WSOGbq16AZRBXvkIdfG4LeptfGEETHzN2dIOiuLMGT8PRkblJm4MIsc
 9d/etLp98QZbJsShggB6XOFdZjPqaxzSV3GCritK3tyZ76+0QRkTImBztyd3WE203w
 GVzMwUHENbATQ==
From: Danilo Krummrich <dakr@kernel.org>
To: acourbot@nvidia.com, jhubbard@nvidia.com, ecourtney@nvidia.com,
 joelagnelf@nvidia.com, apopple@nvidia.com, ttabi@nvidia.com,
 zhiw@nvidia.com, airlied@gmail.com, simona@ffwll.ch, aliceryhl@google.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] MAINTAINERS: nova: update mailing list
Date: Thu, 23 Apr 2026 14:46:35 +0200
Message-ID: <20260423124649.38793-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

The nouveau mailing list has some issues (e.g. with stripping Cc entries
from replies when using notmuch + b4 based workflows).

Besides that, having a separate mailing list for nova also helps to
better distinguish nova from nouveau and makes it easier to track
nova-specific discussions.

Replace the nouveau mailing list with the new nova-gpu@lists.linux.dev
mailing list for both nova-core and nova-drm, and remove the patchwork
entries, since those are bound to the nouveau mailing list and not used
by nova anyway.

Link: https://lore.kernel.org/all/bc2517c2-6772-4cbd-8fd7-6dbdcdd13eab@nvidia.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9b7b6f9828e..f44955f177a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8207,10 +8207,9 @@ F:	include/uapi/drm/nouveau_drm.h
 CORE DRIVER FOR NVIDIA GPUS [RUST]
 M:	Danilo Krummrich <dakr@kernel.org>
 M:	Alexandre Courbot <acourbot@nvidia.com>
-L:	nouveau@lists.freedesktop.org
+L:	nova-gpu@lists.linux.dev
 S:	Supported
 W:	https://rust-for-linux.com/nova-gpu-driver
-Q:	https://patchwork.freedesktop.org/project/nouveau/
 B:	https://gitlab.freedesktop.org/drm/nova/-/issues
 C:	irc://irc.oftc.net/nouveau
 T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git drm-rust-next
@@ -8219,10 +8218,9 @@ F:	drivers/gpu/nova-core/
 
 DRM DRIVER FOR NVIDIA GPUS [RUST]
 M:	Danilo Krummrich <dakr@kernel.org>
-L:	nouveau@lists.freedesktop.org
+L:	nova-gpu@lists.linux.dev
 S:	Supported
 W:	https://rust-for-linux.com/nova-gpu-driver
-Q:	https://patchwork.freedesktop.org/project/nouveau/
 B:	https://gitlab.freedesktop.org/drm/nova/-/issues
 C:	irc://irc.oftc.net/nouveau
 T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git drm-rust-next

base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
-- 
2.54.0

