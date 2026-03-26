Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC010A88C6
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45E010E2BA;
	Thu, 26 Mar 2026 15:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QZO+7ZZ+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142F010E2BA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PB0cZCa+SKJ+FVAYJfPEjxtHc/PtdAEF/6TChF1yelk=; b=QZO+7ZZ+ECwfLcHURjcQ04jmBi
 Cf5107gb0LMsIGPjA+kcPQYORULuu35xCzKovoQWEIZTtitslZgCFJp4ytUwZv5uJcZ9JmxG1jNwi
 R89mUBBLxgE+jxGiBks6hGCEps+w++D9wbzNUPVgjOgQa0lAWQknCtFXPHmhkGEnF5IgFSLxhvBUN
 sjkPYfW5Sn2afqvkoVLoJZ2oS/xSNkBPukUj0O+7xB3Qxhcl5lFE/xivfxWsOKMvK1t28FaOonZ7V
 y6f5yfN/bpEskCXWRVJpfx+lQaYvTrvR+iHyfdmk+W39iPjjHz6KftJU2je+xfBFUW5Jd0nODi4U7
 jq5n6LBQ==;
Received: from 179-125-71-253-dinamico.pombonet.net.br ([179.125.71.253]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w5mUy-006O5l-Ut; Thu, 26 Mar 2026 16:19:53 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 26 Mar 2026 12:18:17 -0300
Subject: [PATCH v3] cgroup/dmem: allow max to be set below current usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
X-B4-Tracking: v=1; b=H4sIADlOxWkC/3WM3QqCMBhAX0V23WI/bmZXvUeEbPNTP0iNrYYiv
 nvTqyK6PAfOWUgAjxDIOVuIh4gBxyGBPGTEdWZogWKdmAgmNJP8ROse+qo3UwX2FWZqm1pKpfN
 GOElS9PDQ4LQPr7fEHYbn6Of9H/lm/64ip5zaAnLNuSqsKC/Ymjuaoxt7sr2i+OzLn15QRq1yU
 BaCKaG/+3Vd3/viEHPtAAAA
X-Change-ID: 20260318-dmem_max_ebusy-bfd33564f2c3
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
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

page_counter_set_max may return -EBUSY in case the current usage is above
the new max. When writing to dmem.max, this error is ignored and the new
max is not set.

Instead of using page_counter_set_max when writing to dmem.max, atomically
update its value irrespective of the current usage.

Since there is no current mechanism to evict a given dmemcg pool, this will
at least prevent the current usage from growing any further.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
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

v2 only allows setting a single region limit per write, while allowing any
new max to be set.

This version (v3) still allows multiple regions to be set, and explains why
page_counter_set_max is not used anymore.

I am sending this version dropping the multiple region restriction for now,
as we continue to discuss whether it should be supported or not.
---
Changes in v3:
- Dropped first patch as it was already applied.
- Added comment explaining why page_counter_set_max is not used.
- Dropped patch restricting multiple regions to be set for now.
- Link to v2: https://lore.kernel.org/r/20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com

Changes in v2:
- Remove support for setting multiple regions' limits.
- Allow any new max limit to be set.
- Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com
---
 kernel/cgroup/dmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..c00aa06759967a8f8977aaf036dd7966ddb55718 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -159,7 +159,15 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	/*
+	 * page_counter_set_max will return -EBUSY in case the current
+	 * usage is above the new max.
+	 *
+	 * Since, there is no current eviction mechanism yet, setting max
+	 * irrespective of the current usage will prevent further
+	 * allocations.
+	 */
+	xchg(&pool->cnt.max, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)

---
base-commit: 6ffdb01db6d5d785e7278c6d98fd4ef8598b0fc5
change-id: 20260318-dmem_max_ebusy-bfd33564f2c3

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

