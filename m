Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491C60A2602
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0HwuzVzr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF3410E2B7;
	Tue, 10 Nov 2026 10:16:16 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA03510E2B7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:References;
 bh=uRXUy8URMFJL42UsUUDEQakhlpG+sH9T+5dJoqYfuRs=; b=0HwuzVzrFlw4rhUtVs2kpNQEsL
 Qz2R91yxGkmikYXIzlq3/uDopppNQzO+ovydO0aqepYs4IW+TGhaydKscis69hg8WLyV+qVBtXZpv
 KOYsA+PqeciKzq1fseWzrPVaKgcvp27hTGOxsJ/8cddN/zzBSRvTc+dWvYv+Jz8qK2kZe6DjTq5u4
 PwyeJ0lntyDwDtC+V+bHoh+CCfS5h3cV/nJ88rr4sZUIDnL2Gs2AjMpde+0WoKzcReDCEmiZ083SA
 FtjMV5Edg9WVcxxXFh3EcBK7dGHzOyHkEUySfdv7bnoJjbxZrXkH2n8mjbwq+fy7t4719lX7rGEYA
 +LrG2LeQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, hjc@rock-chips.com, andyshrk@163.com,
 chaoyi.chen@rock-chips.com, damon.ding@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: [PATCH] MAINTAINERS: Add two reviewers to the Rockchip DRM entry
Date: Tue, 10 Nov 2026 11:15:53 +0100
Message-ID: <20261110101554.1809467-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Chaoyi Chen and Damon Ding volunteered to become reviewers for the
Rockchip DRM drivers, so add them to the MAINTAINERS entry.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..99142a911350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9139,6 +9139,8 @@ DRM DRIVERS FOR ROCKCHIP
 M:	Sandy Huang <hjc@rock-chips.com>
 M:	Heiko Stübner <heiko@sntech.de>
 M:	Andy Yan <andyshrk@163.com>
+R:	Chaoyi Chen <chaoyi.chen@rock-chips.com>
+R:	Damon Ding <damon.ding@rock-chips.com>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
-- 
2.47.3

