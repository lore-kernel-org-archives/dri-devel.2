Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F2606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RAOOMKhm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1654510F593;
	Tue, 24 Nov 2026 13:05:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE4B10F593
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795525504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHqrrJBOJPwHyma5saYtPMd/5tcAtG5XUpif2stsI6c=;
 b=RAOOMKhmHQlCgQrrZhYgQQ0Rr3SxXUEYkPgHVOmuh58ejWjQr3N36ihAcZCVVtXxk2wWyy
 v5qoFpV5mgTOWfktqqHT1fmYZYiyHoSvjx3qbex+X/ajHxG0kju3nCvOW9BoF730krdH2W
 +Hy0qPwNR8+OaJbU97+Nm5fU6sxezhY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-BuLl_dL3PCyUJAUnKT7uEg-1; Tue,
 24 Nov 2026 13:04:58 +0000
X-MC-Unique: BuLl_dL3PCyUJAUnKT7uEg-1
X-Mimecast-MFC-AGG-ID: BuLl_dL3PCyUJAUnKT7uEg_1795525492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757D51955D95; Tue, 24 Nov 2026 13:04:52 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 813331956087; Tue, 24 Nov 2026 13:04:43 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 24 Nov 2026 14:03:40 +0100
Subject: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
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
 Philipp Stanner <phasta@kernel.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, 
 echanude@redhat.com, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795525424; l=3935;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=YotIlLIQVfYmQv+JgAWzs3C/IOGV77S7HbDgbIH2No8=;
 b=A8ZhZL+LOltwrvn/pwh8qPMWB3/tqr5B+k52OMOYOOPUTvlBfStesFciDdy/y5QlDSbMqekrk
 BA9isnKzIXNDSV2bMjiKaCybQwGp4+Ojvq+S9lSmMQ7HkEnb7VZacH2
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ggcdreSE2dGjjxRg0p7v20TLZE4tJP4OOykrS7m-uJ4_1795525492
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

The security_current_memcg_charge_task() and
security_current_memcg_charge_cgroup() hooks allow security modules to
control which processes may charge or transfer memcg memory to another
process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
a cgroupfd, both passed in charge_fd. Without a policy implementation,
either hook is a no-op and the restriction is not enforced.

On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
domain that holds both dma-heap access (today's only exporter that
opts-in) and that capability, can charge memory to any cgroup outside
its own subtree. Since the capability is all-or-nothing, SELinux
policy cannot express which targets such a domain may charge to.

Implement both selinux_memcg_charge_task() and
selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
object class and a new charge_to permission. Both charge_fd flavours
ultimately charge a cgroup, so one permission covers them and the
target type keeps the distinction: for the pidfd path the target is
the referred task's SID, as there is no cgroup object to take a label
from; for the cgroupfd path it is the cgroup directory's inode SID,
which comes from the genfscon entry for cgroupfs unless the directory
is relabeled.

The checks run when the charge target is resolved, before the
CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
charge_fd target, including the caller's own subtree, so policy needs
a rule even for self-charging. Policy authors can then grant
cross-cgroup charging selectively, for example:

  allow allocator_app_t client_app_t:cgroup charge_to;
  allow allocator_app_t cgroup_t:cgroup charge_to;

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 security/selinux/hooks.c            | 19 +++++++++++++++++++
 security/selinux/include/classmap.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6c4c64d6e904..76a714107ae4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
 	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
 }
 
+static int selinux_memcg_charge_task(const struct cred *to)
+{
+	const struct cred *cred = current_cred();
+
+	return avc_has_perm(cred_sid(cred), cred_sid(to),
+			    SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
+}
+
+static int selinux_memcg_charge_cgroup(const struct file *file)
+{
+	const struct cred *cred = current_cred();
+	struct inode_security_struct *isec = inode_security(file_inode(file));
+
+	return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
+			    CGROUP__CHARGE_TO, NULL);
+}
+
 static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
@@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
+	LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
+	LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup),
 	LSM_HOOK_INIT(quotactl, selinux_quotactl),
 	LSM_HOOK_INIT(quota_on, selinux_quota_on),
 	LSM_HOOK_INIT(syslog, selinux_syslog),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 90cb61b16425..1f1f2fc4d35d 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "user_namespace", { "create", NULL } },
 	{ "memfd_file",
 	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
+	{ "cgroup", { "charge_to", NULL } },
 	/* last one */ { NULL, {} }
 };
 

-- 
2.55.0

