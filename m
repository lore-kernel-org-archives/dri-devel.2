Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE516073198
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ll7LIfR+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F29910F86C;
	Tue, 27 Oct 2026 22:39:32 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6214710F869
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 22:39:22 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so607978eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793140762; x=1793745562;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JWqYb4bGeUKpshpA/YjhKSWXxaEK2QVlfhqplD6YlhY=;
 b=Ll7LIfR+IbArGmm3735Y7ksWLcQOiaWFTJL21Lhyt9eAYMuXkt9JeHV0FkoPiqgnrG
 pspysCAkk+8H2Gt83u3ph9qgZhVlOTi3CbSR6ioBCeWnkOgLiSYsqk/GaUYkhnvA3EkZ
 ntnz1wwOZXa2mL6UpQQyfpUyESedUp4N//ZcUUB439MnD9+Bvq4+F/2u28QY9Doc1UOn
 QRNlMXj5Oe5AuSEAT0Raycq3smVsQs4AraOg869KveZsLanwsafuUN0iUETb+9M+J8od
 BNQqUk21MBlJcIWFrF2MA3YtiZ/3NWZsojwKfQjjFKGmzZGLT6PkFe1uRwVvnBFsVOya
 iwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793140762; x=1793745562;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JWqYb4bGeUKpshpA/YjhKSWXxaEK2QVlfhqplD6YlhY=;
 b=YrpFAqkmskekcRr9LdlipdcCcNGCs2SEcdAh/GszbH/3IdJNihbgxLcUYixSE/vO5G
 ZH3voYEe/5dePjCi/jI0tVkUpcMDkLz8r5QbXkNEIBdAaLGp4M1cQEFWT71o3gTGKavD
 egboPKn4F4HhwdlzYjX0uFBJVWKnM4VqncETKhYEFV8BuWMlcMqL3H85QnzmeYMmmXu8
 W4bU4YB9MoEJAt/cIM/X5pCn+ooROSp3eA4QSMFP7VLm41rdL2RIyafoJ91VW90qseQQ
 /UgEblPlADsEbr98AAyCMB18d+9rd5WB5dWbfO8fcO5mYZyA9TQSza1s7Dk9NhxioKj2
 uYQg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJzoQYEBpUWN5KXZ9I8ztmQntOawN8e+VQo5xHshQWRcrrNWeqOF3HMDK24do/SSr7D+UmT9qsps0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIhJA3nAZJntpLpI/t5aSOAOg6cMhvKD8SuC9SKyfrlG94dhyN5
 C9mvofI6gT/ik9iOK6YWXe5gv5oNFQsSWQG6E/r1YDLkuQYp2f8FtccW47Td2B0QADvL0n2rJgG
 rp2okmQNxCg==
X-Received: from dycna3.prod.google.com ([2002:a05:7300:ea83:b0:36a:1b4f:e8f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e9c8:10b0:365:d42a:f415
 with SMTP id 5a478bee46e88-36a2036d4d1mr1220304eec.12.1793140761297; Tue, 27
 Oct 2026 15:39:21 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:39 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-5-irogers@google.com>
Subject: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export cpufreq_dbs_data_release() and set .kobj_type.release statically
in the ondemand and conservative governors so their gov_attr_set
kobjects have a valid release callback statically initialized, matching
cpufreq_governor_dbs. Remove the redundant runtime assignment in
cpufreq_dbs_governor_init().

This prepares for annotating struct kobj_type::release with
__must_init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 4 ++--
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 02bfd46543e9..146a2353b1a2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_groups = cs_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = cs_groups,
+	},
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f3bd3dbe7c41..f8b5aca09b6b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
@@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 806d8fb4dff1..1026712bb79b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
 }
 
 /* Governor callback routines */
+void cpufreq_dbs_data_release(struct kobject *kobj);
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..7386d043c665 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -374,7 +374,10 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_groups = od_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = od_groups,
+	},
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.56.0.313.g2479322e68-goog

