Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF461091923
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F215910E496;
	Thu, 19 Mar 2026 21:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oZAMIiDT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EA710E7D8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 21:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LqaSmuwy6pHyDiJ04DyLgwnky/pg3ari4nRAMo6yRdg=; b=oZAMIiDTni+k/UcrP/bfXGrUSy
 0GjwRHt7V99SL7NdvpruQ8bP1dEWarEj8onLhN3sx9QgNxUH7rS/Kh4aC61daUiMzFpZUT1Cv5Lse
 ob3rLbRrjLB3ZSHr1ezmpVP4kLrSneerzxIXmHSH6pNRXnIbyO6r3sRM/RyAMkzQC8Gi8bSis+amv
 Ij1PofzUmJ8Jl6z1wMp+wKculqnBXOx0Wlq2jzpT2hPO+V4pJRFga5NcN/6Qly3NQP/KoqQEkwT8j
 nbRxLYy56fCkaf75qlKgDyM4adToyvJH9xRCq0o6PTAPYEper4iPv1GX0snX8POSI8pG7klODVI/5
 n+lIA5ew==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w3Kpa-003VvC-0O; Thu, 19 Mar 2026 22:23:02 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 19 Mar 2026 18:22:42 -0300
Subject: [PATCH v2 1/3] cgroup/dmem: remove region parameter from
 dmemcg_parse_limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-dmem_max_ebusy-v2-1-b5ce97205269@igalia.com>
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

dmemcg_parse_limit does not use the region parameter. Remove it.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa09422274422313b63c25986596de..1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -707,8 +707,7 @@ static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
-			      u64 *new_limit)
+static int dmemcg_parse_limit(char *options, u64 *new_limit)
 {
 	char *end;
 
@@ -762,7 +761,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		if (!region)
 			return -EINVAL;
 
-		err = dmemcg_parse_limit(options, region, &new_limit);
+		err = dmemcg_parse_limit(options, &new_limit);
 		if (err < 0)
 			goto out_put;
 

-- 
2.47.3

