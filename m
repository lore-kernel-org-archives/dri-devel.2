Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CF606A33F
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=q+UMHwju
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D8710E1E4;
	Mon,  9 Nov 2026 16:00:17 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id BF0D210E1E4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:00:10 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id A0ABB20B7169; Mon,  9 Nov 2026 08:00:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0ABB20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794240008;
 bh=cs2lqF11RzOrHVpmwFStyy5G5LKigZcq3ui+D4iT+2E=;
 h=From:To:Cc:Subject:Date:From;
 b=q+UMHwjuxbOZmJqPztrqfb3K03CpCctIFwk9zSysiHW2ktSHzuFaeqwM7x94DrtDb
 pEC9fP1tTzVz4/VpkcIFqFNWXBPe8VT40v6+LrVG9g65ib7Fv1wDymPERrAUX/GSdV
 y6jjktuneaUdU4iT86vyr+itST8/OOfBUWUhFARU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH] MAINTAINERS: add myself as a maintainer for the Hyper-V DRM
 driver
Date: Mon,  9 Nov 2026 11:00:04 -0500
Message-ID: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have been informally co-maintaining the driver for some time now,
so make it official.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c10342aa32f3..63b70f3da896 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8359,6 +8359,7 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
 
 DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
 M:	Dexuan Cui <decui@microsoft.com>
+M:	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
 M:	Saurabh Sengar <ssengar@linux.microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
-- 
2.56.0

