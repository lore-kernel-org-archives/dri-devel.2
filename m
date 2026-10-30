Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i8Fgptog
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D5B112856;
	Fri, 30 Oct 2026 14:43:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E493A10E387
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:43:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23B421576;
 Fri, 30 Oct 2026 07:43:12 -0700 (PDT)
Received: from e142607 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A180D3F673;
 Fri, 30 Oct 2026 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793371395; bh=dLtAOHIrhb+jZsvJV1kIt1cJHp/Oe4aKSNgWe1XTIzM=;
 h=From:To:Cc:Subject:Date:From;
 b=i8FgptogBX7jKcj0YP9efSP9VNkQJ0EbH2Gvzhy9SWpVVVjrW/pGgdcwKvSi2+MG4
 IqOkvuxMM6t03Ad2ih+IEKy2oRkfA3yOyRtXsiimvQ0FtiOlBvy45PXPQK/c64K2vS
 XQtuGVar2KstguWWZbf+tEdeiDjwtZFtSqPHnP4s=
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Florent Tomasin <florent.tomasin@arm.com>,
 Daniel Stone <daniels@collabora.com>
Subject: [PATCH] drm/panthor: Add more reviewers
Date: Fri, 30 Oct 2026 14:43:05 +0000
Message-ID: <20261030144305.666845-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We now have more people that can do reviews and contribute patches
to Panthor, so add their names to the list.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89ea35a35c680..2f75078b970c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2321,6 +2321,9 @@ ARM MALI PANTHOR DRM DRIVER
 M:	Boris Brezillon <boris.brezillon@collabora.com>
 M:	Steven Price <steven.price@arm.com>
 M:	Liviu Dudau <liviu.dudau@arm.com>
+R:	Akash Goel <akash.goel@arm.com>
+R:	Karunika Choo <karunika.choo@arm.com>
+R:	Lukas Zapolskas <lukas.zapolskas@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.56.0

