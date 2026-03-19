Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9EA1091916
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036F410E7D8;
	Thu, 19 Mar 2026 21:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="o8Vby54P";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48AD10E496
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8/R6yZAGEx2BsCN9a2u1A7i8vpkAxC4xE8k2euMEcN8=; b=o8Vby54Pe9SvVlZ8SQmoO/mgOg
 KqDIt0YXczetkiG5y+RBhf4sW2uKbo13EOV0/gGbZN6Bm9C5rklWjBYverjCVQO/E8aS252SPqiXW
 STumDJd7HqjXZMuKc2zudV68SfgtYC3lVGUaQEBeVoCX5yRTnrWDybdD2XUzipp3Tlkp4uxHJSHs6
 wTBYv0eOHCu4IRNLW2MFrztTl4i75unPHF+4c522r6lWjXn0jlWYcMykY+Z2SsEk35Td9vMEuM9T6
 XMWwzZctrvdgO/rYg2PnjIZt6mQBR7o7ctmlJRkaeXSk2Mp1up1RGWPAxPtVlvQfryjM3PTKvnwoZ
 OIoEq7+Q==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w3KpW-003VvC-0f; Thu, 19 Mar 2026 22:22:58 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Date: Thu, 19 Mar 2026 18:22:41 -0300
Message-Id: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACJpvGkC/3XMyw6CMBCF4Vchs7aGabmoK9/DENLCFCaxYFptI
 IR3t7J3+Z/kfBsE8kwBbtkGniIHnqcU8pRBN+ppIMF9apC5rHKFF9E7cq3TS0vmE1ZhbK9UWRV
 WdgrS6eXJ8nKAjyb1yOE9+/XwI/7Wv1REgcLUVFSIZW3k9c6DfrI+d7ODZt/3L/G8uJetAAAA
X-Change-ID: 20260318-dmem_max_ebusy-bfd33564f2c3
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.14.2
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

When writing to dmem.max, it was noticed that some writes did not take
effect, even though the write was successful.

It turns out that page_counter_set_max checks if the new max value is above
the current usage and returns -EBUSY in case it is, which was being ignored
by dmemcg_limit_write.

It was also noticed that when setting limits for multiple regions in a
single write, while setting one region's limit may fail, others might have
succeeded before. Tejun Heo brought up that this breaks atomicity.

Maarten Lankhorst and Michal Koutný have brought up that instead of
failing, setting max below the current usage should behave like memcg and
start eviction until usage goes below the new max.

However, since there is no current mechanism to evict a given region, they
suggest that setting the new max will at least prevent further allocations.

v1 kept the multiple region support when writing to limit files, while
returning -EBUSY as soon as setting a region's max was above the usage.

This version (v2) only allows setting a single region limit per write,
while allowing any new max to be set.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v2:
- Remove support for setting multiple regions' limits.
- Allow any new max limit to be set.
- Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com

---
Thadeu Lima de Souza Cascardo (3):
      cgroup/dmem: remove region parameter from dmemcg_parse_limit
      cgroup/dmem: accept a single region when writing to attributes
      cgroup/dmem: allow max to be set below current usage

 kernel/cgroup/dmem.c | 74 +++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dmem_max_ebusy-bfd33564f2c3

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

