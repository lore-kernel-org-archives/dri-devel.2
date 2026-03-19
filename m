Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02281091923
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D92410E8DB;
	Thu, 19 Mar 2026 21:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nowxwRTx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C485610E899
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SPSdVVjfXYlYXJdvMtjOrLqjwSNywcgu5lDpY2FUZA0=; b=nowxwRTxSjf5akurlgjLLCkOTY
 oVO2RWolPa8D1A0+s9ZW8XRAOzqmyno181GJME8GLWnR2UHgMBn2POKCpZHn0T9H9A8P32xVKGTwG
 9sZVwdg6hoQ1Gq/juJ/ETG5OcIRjdDz8cYjSJtuJcoAj328TeP+6kYzMpe/kRFYEmp22bEtRDOvR0
 sh57FFitMtLvtgiVC09kdEyISqHAUjfnZtrZkTjRL+Kmr+EFnXbKX5PIgNdYln+RA5wiegTowZpkf
 FtwtA6bfz87MCcpNejt+IiI1rIjDUi+fwke4ZQZFv+jlDFxTucRF1Y7+J3OZr5cGSC29kJdT8TmLL
 +D5Ucj2A==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w3Kpe-003VvC-JL; Thu, 19 Mar 2026 22:23:06 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 19 Mar 2026 18:22:43 -0300
Subject: [PATCH v2 2/3] cgroup/dmem: accept a single region when writing to
 attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-dmem_max_ebusy-v2-2-b5ce97205269@igalia.com>
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

When writing to dmem.{min,low,max}, if multiple lines are given, one of
them might succeed while the next one fails, but an error is returned. That
is, there is no atomicity where either all changes succeed or all of them
fail.

Only accept a single region instead of trying to parse multiple lines and
process multiple regions at the same write.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 69 +++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..695d2b7516081256da030c80b54ec1c5fcd6ca16 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -729,56 +729,47 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
 	int err = 0;
+	struct dmem_cgroup_pool_state *pool = NULL;
+	char *region_name;
+	struct dmem_cgroup_region *region;
+	u64 new_limit;
 
-	while (buf && !err) {
-		struct dmem_cgroup_pool_state *pool = NULL;
-		char *options, *region_name;
-		struct dmem_cgroup_region *region;
-		u64 new_limit;
-
-		options = buf;
-		buf = strchr(buf, '\n');
-		if (buf)
-			*buf++ = '\0';
-
-		options = strstrip(options);
+	buf = strstrip(buf);
+	if (!buf[0])
+		return -EINVAL;
 
-		/* eat empty lines */
-		if (!options[0])
-			continue;
+	region_name = strsep(&buf, " \t");
+	if (!region_name[0])
+		return -EINVAL;
 
-		region_name = strsep(&options, " \t");
-		if (!region_name[0])
-			continue;
+	if (!buf || !*buf)
+		return -EINVAL;
 
-		if (!options || !*options)
-			return -EINVAL;
+	buf = skip_spaces(buf);
 
-		rcu_read_lock();
-		region = dmemcg_get_region_by_name(region_name);
-		rcu_read_unlock();
+	err = dmemcg_parse_limit(buf, &new_limit);
+	if (err < 0)
+		return -EINVAL;
 
-		if (!region)
-			return -EINVAL;
+	rcu_read_lock();
+	region = dmemcg_get_region_by_name(region_name);
+	rcu_read_unlock();
 
-		err = dmemcg_parse_limit(options, &new_limit);
-		if (err < 0)
-			goto out_put;
+	if (!region)
+		return -EINVAL;
 
-		pool = get_cg_pool_unlocked(dmemcs, region);
-		if (IS_ERR(pool)) {
-			err = PTR_ERR(pool);
-			goto out_put;
-		}
+	pool = get_cg_pool_unlocked(dmemcs, region);
+	if (IS_ERR(pool)) {
+		err = PTR_ERR(pool);
+		goto out_put;
+	}
 
-		/* And commit */
-		apply(pool, new_limit);
-		dmemcg_pool_put(pool);
+	/* And commit */
+	apply(pool, new_limit);
+	dmemcg_pool_put(pool);
 
 out_put:
-		kref_put(&region->ref, dmemcg_free_region);
-	}
-
+	kref_put(&region->ref, dmemcg_free_region);
 
 	return err ?: nbytes;
 }

-- 
2.47.3

