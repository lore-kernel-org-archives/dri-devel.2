Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF8E1091923
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AFF10E899;
	Thu, 19 Mar 2026 21:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LMpFtUUO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCFB10E899
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=41Uqa2RC7e8RnridV7NcZa89g+tR7DrEjBJo4ZJoKfg=; b=LMpFtUUOVWSRIZzlFDX2PsOh5v
 4FVXZUMoSWNgRFRRF++SE32KrZTjbHGsbKrg9D27SeDKJePa2miGCo2hfFhYfx4poAuA3V2w7Ksbq
 ZcjYmf+5jRkhR8wy2W/2qvoTQ2oeptzV/dHCME2uDG8vFOLJJrNVFjNri2SvfHjiKdW/gwfQmo+UJ
 WY6Nyu3oAuXNFc/jKV8fDrXlJUvYPGJpNhXyjCbFPxB0yRws9fTwfvlUXTyWYHv39Tr2IYA170fwe
 vu8CKXVLJgyFNQqMQXtZf8Fx6zeQL71E27ihGcK6IZL0I9j2A0HcArMBUbscjTmmi/dCrtdVfj9Ni
 kiDje2Ew==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w3Kpi-003VvC-J9; Thu, 19 Mar 2026 22:23:10 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 19 Mar 2026 18:22:44 -0300
Subject: [PATCH v2 3/3] cgroup/dmem: allow max to be set below current
 usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-dmem_max_ebusy-v2-3-b5ce97205269@igalia.com>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
In-Reply-To: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
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

page_counter_set_max may return -EBUSY in case the current usage is above
the new max. When writing to dmem.max, this error is ignored and the new
max is not set.

Instead of using page_counter_set_max when writing to dmem.max, atomically
update its value irrespective of the current usage.

Since there is no current mechanism to evict a given dmemcg pool, this will
at least prevent the current usage from growing any further.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 695d2b7516081256da030c80b54ec1c5fcd6ca16..bf9e0d11e46156a437196c77fdfde84250e65420 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -159,7 +159,7 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	xchg(&pool->cnt.max, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)

-- 
2.47.3

