Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2830CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1748310F9F6;
	Tue, 13 Oct 2026 22:40:37 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE9410E959
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 22:40:25 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso6716199eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791931225; x=1792536025;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wbjJdHqZPRkvVZnH2yPkFa6V1wQ6/MdT39yYoogCQX4=;
 b=DqgnhSKp6FaugyXjSikPxlts5SWI68lgVjmnhmE9KlTqOcJhijgwIE8A5kyBGns1G7
 XsOD03UfPwO5ygFLbTyEnE4g0osp1X2xd/Cz+4qJLRLQfi4EDRJCUEB68uOv9g6unCxo
 wyj/E2+mmGFpHuwXyQV9dof49BZ6s3qRRH33RUlt+THQMI27RIsKuWt4FksTUWvgffKN
 PIK7+ZvnhA0ZY6WgrsEex5k3u0KNE2tpUeb1tyyoKDBBi7smybFi2Hr/vrQrFc+khuav
 ZEXou27kH/DFSnXzmQ9qCIsUXWk1o0ugnM0OvPb5iQeolovemUMQHmxkFPh80qJqOmZL
 ioeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791931225; x=1792536025;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbjJdHqZPRkvVZnH2yPkFa6V1wQ6/MdT39yYoogCQX4=;
 b=yAIUof1UtTB1BLYmRnz/I2uSB29EKe9WB3lfLMKL1YydMx+lSYzrl/LyQ/h/lxui2C
 e75amyWMqzZv77iDdBIyp/0lMPsZ0GSuVTbMugLhhJdXWemsllh58eTsn6io2jWTWotV
 qx9ysRO5azWKJJlaaqZl2KiPNzlzgZ4B8smZZewAUBdevha+vcxaU281WiUNRRnX5xP/
 Eg8/aYutrWfIp+0P/nb23hKT+qsSABgFy91Mc/euCx2ykcDa86jgBa6L5r5sUx3TZm0a
 Gvz3cVKTMPlRvRO9wCs0zSOXbvalIjuOkhMdj3lt3nQnDR3OVKW7r3fSOTpA4g47Dv03
 s1PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwUnzqemWBLCYNcfO+CmZ8crD2CWyOL9j3UETZV4I7bW/0Du2BI9wX1R+dXkVWV0/Wxb+h5hm+6yY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAfkUpnjkRlh+Er9ERmaS3M48DBarACoJB2M/oBaPwZGlI2q34
 pFcpDS4kv7cyB/odKqj+VU+c017l3fU/7SedSqL6zzDFoCvU0wSjbKC+GmtJOuzUv/NTIUrI05J
 XhEkO8s90wQ==
X-Received: from dyr27.prod.google.com ([2002:a05:693c:401b:b0:359:e5f1:14fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:470e:b0:35c:73ca:a1e0
 with SMTP id 5a478bee46e88-35c73caae65mr4317399eec.15.1791931223446; Tue, 13
 Oct 2026 15:40:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:40 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-6-irogers@google.com>
Subject: [PATCH 05/11] ACPI: CPPC: Free cpc_desc in kobject release callback
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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

cpc_desc_ptr embeds a struct kobject that is registered in sysfs via
kobject_init_and_add(), but cppc_ktype lacked a .release callback and
acpi_cppc_processor_exit() freed cpc_ptr immediately after kobject_put().
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free when
kobject_delayed_cleanup() runs on freed memory.

Move the sys_mem_vaddr unmapping and kfree(cpc_ptr) into a new
cppc_release() callback on cppc_ktype, and initialize the kobject on
allocation so kobject_put() handles cleanup in all paths.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/acpi/cppc_acpi.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b7..2a80404f85d3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -297,7 +297,22 @@ static struct attribute *cppc_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cppc);
 
+static void cppc_release(struct kobject *kobj)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	unsigned int i;
+
+	for (i = 2; i < cpc_ptr->num_entries; i++) {
+		void __iomem *addr = cpc_ptr->cpc_regs[i - 2].sys_mem_vaddr;
+
+		if (addr)
+			iounmap(addr);
+	}
+	kfree(cpc_ptr);
+}
+
 static const struct kobj_type cppc_ktype = {
+	.release = cppc_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = cppc_groups,
 };
@@ -799,6 +814,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		ret = -ENOMEM;
 		goto out_buf_free;
 	}
+	kobject_init(&cpc_ptr->kobj, &cppc_ktype);
 
 	/* First entry is NumEntries. */
 	cpc_obj = &out_obj->package.elements[0];
@@ -1001,11 +1017,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* Plug PSD data into this CPU's CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
 
-	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
-			"acpi_cppc");
+	ret = kobject_add(&cpc_ptr->kobj, &cpu_dev->kobj, "acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
-		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
 
@@ -1013,14 +1027,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	return 0;
 
 out_free:
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-
-		if (addr)
-			iounmap(addr);
-	}
-	kfree(cpc_ptr);
+	kobject_put(&cpc_ptr->kobj);
 
 out_buf_free:
 	kfree(output.pointer);
@@ -1037,8 +1044,6 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
 void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
-	unsigned int i;
-	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
 	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
@@ -1056,15 +1061,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	if (!cpc_ptr)
 		return;
 
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-		if (addr)
-			iounmap(addr);
-	}
-
 	kobject_put(&cpc_ptr->kobj);
-	kfree(cpc_ptr);
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
-- 
2.56.0.385.gd3acb90ef8-goog

