Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC960952AA
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cOpTf5Us
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B636A10FE9B;
	Wed,  4 Nov 2026 19:52:19 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E99110FE9B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793821927; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EXNvL60t7UEFw8OuXwv9q7cs4BDaDl4hxq5PcaxJv09OCkdlNfib+6NAQuFc0bkg+QyUh6dPiYFiBm6Ip3WVxr20WN1+Opr/ViaHNa7vwR3YbiFIRoTR1ZZMyAWMUO3wH5RCiu4jkr1ccoNhaE6YUW9KTO9zrT4P8zemIp+Cqas=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793821927;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ki/ozP3RoDXMuAAZKxiy5Y6Gp71eNHZ9dUt1D2IRKgQ=; 
 b=XfDQ+xshGD6NbUO35SWCMpYAtnWKGQ79KGTxUQVi3RboUHNFqCPyfuDeAuSC9x7z9avBANPsj0Z1QK+r/9RceG0n2y9OaOhaFpBbwgpAGGSN9XvfaaAL5850YbJvAz9tCYn40rtZA3wkDV6IA4jdQY/BzaSccVkuvBJL7pI69so=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=cOpTf5UsAqSKcScBlMrWWR01NwTBfMlfaW3LETKc7MGxoDtILTJuDobAFj9HFFkaWAgVnjLUTSFJVVxhBGnfmC7shPZtXsoOHfH4S4qVd4Mj9EwvndHScJLK9QSdrG92TrbZ9G0tuM1IbBggwgkoFvp9RbMN1esp/F4CsnX61R8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=Ki/ozP3RoDXMuAAZKxiy5Y6Gp71eNHZ9dUt1D2IRKgQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179382192565294.53060187105473;
 Wed, 4 Nov 2026 11:52:05 -0800 (PST)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v3 0/2] Two small perfcnt fixes for Panfrost
Date: Wed, 04 Nov 2026 19:51:52 +0000
Message-Id: <20261104-panfrost-reset-races-fixes-v3-0-09868a88c351@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBBFr9KwFgMUWuvKexgXQAeLqaWBSjRN7
 y7UGBMX3fzkZ/68N6MA3kJAx2JGHqIN1g2plLsC6U4OV8C2TR0xwipKKMejHIx3YcIeAqSUGgI
 29pmyMsIwLppWNwolwOhhPaT/8+XTw0PdQE+ZmBedDZPzr9Uead59RWJLFCkmWKmaa1ofKknUS
 bu+l8p5udfujrIssh+OknITxxKOC85IrWjLofzHLcvyBrg5ko4pAQAA
X-Change-ID: 20261014-panfrost-reset-races-fixes-6f5f2459dc9b
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Y0sDh9Vxfi6xKWYfSk0iWNZD/d7xGKBSB//bMaYYXo8=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq64zbAKNHKtGqcs/jwuntYpHec34HEx4c3xY/7
 UsI5lqjKwyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCauuM2wAKCRAOJn5M7lND
 PcECC/9cFbeqYvc2fVSH3VFenHfGRxeFS95TWW6ZcxiCbSUojX9gNinK39g7RbQ2P3/b48iY40y
 56sy2f+3yPEjEQH4wbWuYuUAr8leUSKC9I4piOFp4pqGdGqFoKHuFZ9meiFpDRhY/x71/ln2G7L
 Iu0zSpF9uRqCmIfku2ktCqGSQXvT2B+cEyilQ0SUwp4GHKDuHqJaLCeHtPv7S5XRdDtkZHgh7GY
 xqJanTNZ7qklKnF3qi+n7fnKiq7R3KxPzhZFy7SzepHgaRda5R8NkPeyiGDijXF3hlhQ4ZKYKg8
 YO3OOVRIhkOF3R8DifmqjTYmGyp+uHpDNvHq6Sqmxot3MRPeEjjzaIfBkhrIftV3R22HHWA638N
 7ZV3bYsycD9slcABYXodnFVYNIiSn+tdLdOpbVQ6n0iqZGoy89tCwQk+KtXB5+R9eBuYav4xheh
 /K4x57ZrsGQd6vi6N467+3KvZZl7/UKIy1qt0NuynzNgNiqflu9qHE0ViyCq0vUWoSs+E=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Steven Price <steven.price@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

First fix makes sure cycle counter is enabled when starting a new
session. This is required by some profiling frameworks like
Perfetto. Second fix deals with a recently-introduced race condition.

---
Changes in v3:
- Removed atomic-variable non-equality check altogether.
- Minor commitm messages changes and adding trailers.
- Link to v2: https://patch.msgid.link/20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com

Changes in v2:
- Added review trailers.
- Removed warning from cycle count reference check.
- Link to v1: https://patch.msgid.link/20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Steven Price <steven.price@arm.com>
To: Adrián Larumbe <adrian.larumbe@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Adrián Larumbe (1):
      drm/panfrost: Fix race when restoring reset state in perfcnt

Boris Brezillon (1):
      drm/panfrost: Enable cycle counting when perfcnt is enabled

 drivers/gpu/drm/panfrost/panfrost_gpu.c     |  7 +++----
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)
---
base-commit: 6f7098738fff3ec7393f924343188cb8e6ebc5d2
change-id: 20261014-panfrost-reset-races-fixes-6f5f2459dc9b

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

