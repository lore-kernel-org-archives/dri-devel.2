Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45399CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2A7112C4E;
	Fri,  5 Jun 2026 22:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="U5yOxAmP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959E8112C4E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780699562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dV6PAZLoEmUptgQeuUHBOKnlcyuL3OCus7UUkvZbeZI=;
 b=U5yOxAmP9ENbh6coSbxLYbsX/qIufsMrGJ1O6Wy3JYjXWB7KZZ/Lh3nBdGUFKhB65Tlohm
 BHfpdunjjx9Fp5kECllRnBmEre2u4jAn/P7qdicRvW7AoWmAhJYQgQvsOGo6gDv3yFmYFi
 u6I+W9pmyvTxDR8ZdDlKFWaBzFpXM5I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Y3LOoH6OMsubveNhjd3_-A-1; Fri, 05 Jun 2026 18:45:57 -0400
X-MC-Unique: Y3LOoH6OMsubveNhjd3_-A-1
X-Mimecast-MFC-AGG-ID: Y3LOoH6OMsubveNhjd3_-A_1780699557
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ced08f46b0so68601316d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 15:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780699557; x=1781304357;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dV6PAZLoEmUptgQeuUHBOKnlcyuL3OCus7UUkvZbeZI=;
 b=REE8z1ddSQohlzqUbzKUgTYUKqZm1AghKziiaQ62BliYQ/dCcSxTLXjv52eRrlcls3
 Ks3N3b1I8nmVAHsehD5XUzoflEbDOxTNaqX/TArR5hWUN6X6PR1y2OPl5VTDtbdNdZ2X
 QKwJmBVgMMh76CwwEWrjoTGKEik8VnTOXU64F951HXQmm2WndgDpEBKI30QOXRB/r6Zj
 28gpDexUx00S5sAMj47kA3Qxu5ORm0AL1t+5pG1jbhmSPe4TqenpJgxWwqSAQRhjTBNa
 jbP3TGHWNNwbbsAIgwum+VM+FTWPYOXOKLdkZIRbb/K1c1CBoT6E9qiFkWO3rvV3WDZ+
 p1Ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yVlR1j3+9RabI+/8vwkB13ntGnbasfzwMekUy2okuLqoZU5TA9O8DI9+9uxbtAhMSGh7Mk1qlYns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzm7hN31bLeWi4aNpkJ2OL7CZjlpjh46SAFvpioN831cTeUGSBt
 nQCnqcK1xwGu8Pe6cLBfcJZQ7mJAqMu2qG9eZQwEt9+u4XBBqv/8dDM6VhX9r0acrw20DgeRDBO
 DM2jpGa12o5Lv8c/m4tBJszN/YYx7sJ6djK11ihdzAwET80kqrLrKLw1usbbtaA6OqWAVHA==
X-Gm-Gg: Acq92OHTMA7n0WOb5m2Qx/P3va2vcIXcKtl39Ml8X2c6kEHAphMwSg3m/apuNtjiqC0
 7WuzKO94Sab3mZofXNZsPJSSaREbHb1wdEFjZ91b6bFaaOXojy2HKgjqjabsJRynALsDOfUpEDA
 loSakVmWydI7mpnAJkuS9e7T7cZqAajDskXXi/8fjLq7nhobB4I+BmAAkaRd0yIU4yuQSxtd/+s
 Y0+qjOMYCzML1fa3dVd5YGL0cvWgUZkzQzPNLLYhw2IOCKjEUkLO0/I7Akrycn/H408iaje3PcN
 ofoPGJdfSx/ciw4tMuiu519SIss1R86csE11XIiDzh5nIuBPDoMwd+KErGI2GQyWTJoA9gCSn0q
 T3m4/sPRwtkcIvA/uzxhmtp5pW877kWLBRuhrqLWaoF74z6eweFmGGKRMlSiOg/vtJKpKuJ+uEW
 t0
X-Received: by 2002:a05:6214:45a0:b0:8ce:ab75:9d69 with SMTP id
 6a1803df08f44-8cee8c44538mr60333476d6.21.1780699556962; 
 Fri, 05 Jun 2026 15:45:56 -0700 (PDT)
X-Received: by 2002:a05:6214:45a0:b0:8ce:ab75:9d69 with SMTP id
 6a1803df08f44-8cee8c44538mr60332996d6.21.1780699556434; 
 Fri, 05 Jun 2026 15:45:56 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net.
 [100.17.21.205]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd06f5eesm94985466d6.37.2026.06.05.15.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 15:45:55 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Fri, 05 Jun 2026 18:44:55 -0400
Subject: [PATCH] cgroup/dmem: accept only one region per limit write
MIME-Version: 1.0
Message-Id: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NzQqDMBAGX0X27EIUEkhfpXio5jNdqFE29QfEd
 zd4nMPMnJShgkyv6iTFJlnmVKCpKxq+nxTBEgpTa1pnnLE8RJ3XhcOEiXeVPzhLij+wIhaXfT8
 a27vgvQ1UKotilOM5vLvrugFgY1X4cQAAAA==
X-Change-ID: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c8yx7n8wX00xFR0-WtEN-r2_qLLxpzSliwRHV9pE7ng_1780699557
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Accept only one "region value" pair entry for the dmem.max, dmem.min,
dmem.low files.

This changes the UAPI that otherwise accepted multiple lines for setting
multiple entries in one write. No existing user is known to rely on
writing multiple regions in a single write.

Processing multiple regions in dmemcg_limit_write() could quietly change
first limits before failing on a later one and returning an error to the
writer, with no indication some changes occurred.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Follow up from discussions on a previous thread[1].
If Albert's series[2] lands, I can cleanup and prepare some kunits for
these as well.
[1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
[2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
---
 kernel/cgroup/dmem.c | 70 +++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..113ee88e276296bccb4def546adf5cc175d7f0be 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -734,57 +734,39 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
-	int err = 0;
-
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
-
-		/* eat empty lines */
-		if (!options[0])
-			continue;
-
-		region_name = strsep(&options, " \t");
-		if (!region_name[0])
-			continue;
-
-		if (!options || !*options)
-			return -EINVAL;
+	struct dmem_cgroup_pool_state *pool;
+	struct dmem_cgroup_region *region;
+	char *region_name;
+	u64 new_limit;
+	int err;
 
-		rcu_read_lock();
-		region = dmemcg_get_region_by_name(region_name);
-		rcu_read_unlock();
+	buf = strstrip(buf);
+	region_name = strsep(&buf, " \t");
+	if (!region_name[0] || !buf)
+		return -EINVAL;
 
-		if (!region)
-			return -EINVAL;
+	rcu_read_lock();
+	region = dmemcg_get_region_by_name(region_name);
+	rcu_read_unlock();
+	if (!region)
+		return -EINVAL;
 
-		err = dmemcg_parse_limit(options, &new_limit);
-		if (err < 0)
-			goto out_put;
+	buf = strstrip(buf);
+	err = dmemcg_parse_limit(buf, &new_limit);
+	if (err < 0)
+		goto out_put;
 
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
+	apply(pool, new_limit);
+	dmemcg_pool_put(pool);
 
 out_put:
-		kref_put(&region->ref, dmemcg_free_region);
-	}
-
+	kref_put(&region->ref, dmemcg_free_region);
 
 	return err ?: nbytes;
 }

---
base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d

Best regards,
-- 
Eric Chanudet <echanude@redhat.com>

