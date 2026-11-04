Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B8606D811
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFvglpZe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A884110FB3E;
	Wed,  4 Nov 2026 11:10:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123A910FB3E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 11:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793790618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DU48/ISwE6r+xagkghxQRRBnqZ11v07G3uahgQ4weqc=;
 b=QFvglpZehiVlXlbT8bSf0VcpTAcsDDPCb5Dq9YmH4WatVwfkU5eJa/kuvKHo9tATlNJVfw
 YQBFS648UW2oympf9Taw0qGww3+pahwBV+fKXxGnmSVdh1fBQrT+GKu/GWdBqQGrznyJgQ
 4p4pGhI5Q5zyEF5WNP0TXwF5cjMT4+A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-bafTYMDaMr--5_kfeMuadw-1; Wed,
 04 Nov 2026 06:10:13 -0500
X-MC-Unique: bafTYMDaMr--5_kfeMuadw-1
X-Mimecast-MFC-AGG-ID: bafTYMDaMr--5_kfeMuadw_1793790608
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCFDC18002C3; Wed,  4 Nov 2026 11:10:07 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84FA81956088; Wed,  4 Nov 2026 11:09:59 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 04 Nov 2026 12:09:14 +0100
Subject: [PATCH v4 5/8] security: dma-buf: Add dma_buf_charge_cgroup LSM hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261104-v2_20230123_tjmercier_google_com-v4-5-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793790554; l=4320;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=M2gzLVfeMYXG5SgIz3z8BJTK8aHnWCZgYqRzq4G9xoM=;
 b=GI8FqhRocym0ire0EwWWf1etkZE9k8lyBemdonWgvlRrZHnRFe420h4eoRVAOZKaKAyvt3yZx
 do8Y0zbDyFkApO24yfqo56x2/Z7dQWKBpTBXrHnpL1qWAvYFa5Zj4bV
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: uaupne_U2wpDvvn-qjfu6E0I0_9owell8xyalby_mwU_1793790608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Similar to how security_dma_buf_charge_task adds an
access-control point for pidfd for the charge_fd of a
DMA_HEAP_IOCTL_ALLOC ioctl, we need a new access-control
point for the case where charge_fd represents a cgroupfd.

Add security_dma_buf_charge_cgroup(), called in
mem_cgroup_get_from_fd() when charge_fd refers to a cgroup.
The hook receives the credentials of the requesting process (cred)
and the target cgroup to charge (cgrp), giving security modules
a controlled enforcement point for cross-cgroup dma-buf attribution
policy.

When CONFIG_SECURITY is not set the hook compiles to an inline
returning 0, adding no overhead to the fast path.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      | 11 +++++++++++
 mm/memcontrol.c               |  6 ++++++
 security/security.c           | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 0f1138e16dbe..fbf7f17127db 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -44,6 +44,9 @@ LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
 	 int cap, unsigned int opts)
 LSM_HOOK(int, 0, dma_buf_charge_task, const struct cred *from, const struct cred *to)
+#ifdef CONFIG_CGROUPS
+LSM_HOOK(int, 0, dma_buf_charge_cgroup, const struct cred *cred, struct cgroup *cgrp)
+#endif
 LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
 LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
diff --git a/include/linux/security.h b/include/linux/security.h
index 89a35eb07b8c..8fb1539156b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -351,6 +351,9 @@ int security_capable(const struct cred *cred,
 		       int cap,
 		       unsigned int opts);
 int security_dma_buf_charge_task(const struct cred *from, const struct cred *to);
+#ifdef CONFIG_CGROUPS
+int security_dma_buf_charge_cgroup(const struct cred *cred, struct cgroup *cgrp);
+#endif
 int security_quotactl(int cmds, int type, int id, const struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -708,6 +711,14 @@ static inline int security_dma_buf_charge_task(const struct cred *from,
 	return 0;
 }
 
+#ifdef CONFIG_CGROUPS
+static inline int security_dma_buf_charge_cgroup(const struct cred *cred,
+						 struct cgroup *cgrp)
+{
+	return 0;
+}
+#endif
+
 static inline int security_quotactl(int cmds, int type, int id,
 				     const struct super_block *sb)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dd276e1230cc..4c718c06c122 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5693,7 +5693,13 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
 
 		memcg = mem_cgroup_from_css(css);
 		rcu_read_unlock();
+
+		ret = security_dma_buf_charge_cgroup(current_cred(), cgrp);
 		cgroup_put(cgrp);
+		if (ret) {
+			mem_cgroup_put(memcg);
+			return ERR_PTR(ret);
+		}
 		return memcg;
 	}
 
diff --git a/security/security.c b/security/security.c
index 4a16e4076aab..a5dcf9dc4963 100644
--- a/security/security.c
+++ b/security/security.c
@@ -676,6 +676,24 @@ int security_dma_buf_charge_task(const struct cred *from, const struct cred *to)
 	return call_int_hook(dma_buf_charge_task, from, to);
 }
 
+#ifdef CONFIG_CGROUPS
+/**
+ * security_dma_buf_charge_cgroup() - Check if charging dma-buf memory to a cgroup is allowed
+ * @cred: credentials of the process requesting the charge
+ * @cgrp: target cgroup to charge
+ *
+ * Check whether the process with credentials @cred is allowed to charge
+ * dma-buf memory to @cgrp. Called when userspace passes a cgroupfd to
+ * identify the charge target instead of a pidfd.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_dma_buf_charge_cgroup(const struct cred *cred, struct cgroup *cgrp)
+{
+	return call_int_hook(dma_buf_charge_cgroup, cred, cgrp);
+}
+#endif
+
 /**
  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
  * @cmds: commands

-- 
2.55.0

