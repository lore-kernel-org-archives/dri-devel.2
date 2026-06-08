Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E53ACD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B398F10F65C;
	Mon,  8 Jun 2026 15:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RC/5HAy4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6653210F647
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780934053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5eWzdVvtwrg/9Udw9VbeX3BPtsMxiS3OGz6xe4/WajU=;
 b=RC/5HAy4zkux0YUbWz+g+pQJkf1YAjvdPZKfEiRBzKp99kiahdG5vS0geIkTsKYJ7zCLh4
 0rHlHDiXdbov4Csqo5aJ2w20ZZZOSLgqE83Mh3NIBbidzxr12lheVFuXKwuqKfw9+hsbKG
 VVsQtldSwh7hWliPHz7Hgnqmq9Yn4P4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ABAj1NV7N4aXUHaHpeLVsA-1; Mon, 08 Jun 2026 11:54:11 -0400
X-MC-Unique: ABAj1NV7N4aXUHaHpeLVsA-1
X-Mimecast-MFC-AGG-ID: ABAj1NV7N4aXUHaHpeLVsA_1780934051
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915d3261c5cso254948985a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 08:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934051; x=1781538851;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eWzdVvtwrg/9Udw9VbeX3BPtsMxiS3OGz6xe4/WajU=;
 b=D6724z7rPG5Ei1U7By1t+y9TPqGjx98E/ceVO8qamimuqAH/YtiHsrTC5pUwoXJ217
 ynOk8EJ8T8O0ieNouJP8lbuNrjTbe2AvEBYL5xcrREV3i5KDZ9fCQf3DYUcwOHSbHxWY
 GWAF83PHw4Z/4RhDRQoBXjq7RUQCPsBf9HfUMWuyJrbhw9kqkUfmtyAwNwGaEa8Z5awx
 5s05AcqHEyBVzEiCn/tu//SzA/FiW0dXqbLvxVaj92r43zYHjAkGzu2sJ7CDZBW7MAxY
 KNnlEGxf+P7oV1SXTanJHpNx8/9lhfk7P6Z7PKjyHxmNUiPctGTNWNMsxqMVWpaoMTgs
 QyZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3XBbIIsb2BwM2EKvbZ1BonDOX2jDQwQuUH7h/kaHalOrwGdVZSGA4DcGE1+wZAD+4a1mLj3XGDb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0FMloRDEha50LGNqYEDGIMceq9tAXzHuXcjZer97BfvZj8jSQ
 TXDsoy8cKLyZ+Dqleu6nJ3u7qtuTm7zl/pGDdODR3z3mGNuGKnt6Q9UBsJfe3VrYlMXJITGgMOJ
 C8YSL6ucUwyNS9pGP4DKcCrMaTaKmP9k+G0boP0IpBHgUxsrapOlbCEtBcQjr/CFSgi3cpQ==
X-Gm-Gg: Acq92OGCxDU1FG8PuQmWFQbLAOYYMEglnlT3vBbl2ZHe4Gbr4x6bxu6fIkd4J0tunsh
 aFGcv6FlTl9ZxrOzvCQVmNm8yILKuDMb5xV5CWxOkdBoMMA30ojASCNH3LTXjktv+cTsiRvtyvd
 TbIRNSB+PvnVX+hntuUqO2SR2p0EHGitjnsdrev+USqfUNJjZNhHEdjuVpnqXizPPgVLcJq/zxX
 oB6oG077qiq0+26RUr5KMxRQY3r0BNiCdJw9fuAxjPY8RiBJ+NloZ+8UC9sEVzpk/+fZ+5MWIU5
 Q2ERn5AxfeLEkB4z/ZtYbEaPXVvMOvXlWrVY6PXB0mU8Te2cUhqxIntgMHV3HSiwJ8M5tjolvME
 L17Ghy2BLALP1z3cbFLD7oVlmqkmV7RdL/xv4GVQejHnI0oayRuD+kg9oYBeemuMbPOhg2JRuBL
 FC
X-Received: by 2002:a05:620a:270d:b0:914:b518:577a with SMTP id
 af79cd13be357-915a9c741bemr2489281785a.21.1780934051023; 
 Mon, 08 Jun 2026 08:54:11 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:914:b518:577a with SMTP id
 af79cd13be357-915a9c741bemr2489275885a.21.1780934050376; 
 Mon, 08 Jun 2026 08:54:10 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net.
 [100.17.17.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3bf5f9sm1802802485a.35.2026.06.08.08.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:54:09 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Mon, 08 Jun 2026 11:53:51 -0400
Subject: [PATCH v2] cgroup/dmem: accept only one region per limit write
MIME-Version: 1.0
Message-Id: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dkxb05K68h6GBbRDmUQomSJqC
 He3cgKX7yf/vU1kZMIsrtUmGFfKlKYC+lQJP7RTRKBQWGiprbTSgI+cnjOEEUd4MS0Imab4QGC
 M5Quu66XpbHDOBFEsM2NP76NwbwoPlJfEnyO4qt/6v3tVoMCpS91rZ03t/I0xDO1y9mkUzb7vX
 8q1ufbPAAAA
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
X-Mimecast-MFC-PROC-ID: 0qvRKbHYtHdgKqjp67NRDSXh-iwugfBL7VOrHWvgVU4_1780934051
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

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Follow up from discussions on a previous thread[1].
If Albert's series[2] lands, I can cleanup and prepare some kunits for
these as well.
[1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
[2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
---
Changes in v2:
- Handle buf == NULL by testing !buf first after strsep (Natalie)
- Don't allow extra spaces to separate key and value (Natalie)
  Other cgroup files don't (rdma, misc), so stay consistent.
- Link to v1: https://lore.kernel.org/r/20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com
---
 kernel/cgroup/dmem.c | 69 +++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..39930c59cb769a505a5852a5644a371fd5596f59 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -734,57 +734,38 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
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
+	if (!buf || !region_name[0])
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

