Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A119606A321
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q9WUmSr/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CC310E46D;
	Sun,  8 Nov 2026 22:40:06 +0000 (UTC)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0C210EB30
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:40:00 +0000 (UTC)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6dd94f8fa25so264252eaf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794177599; x=1794782399;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cDMmI2UqRAqSDkjhtwDc5ZRUeFfMooMTF2CHO0kKXno=;
 b=Q9WUmSr/HRopRILEBNmRZ5oJZ5X/fzqNYmBl6pqU2tLC0ADXzoTafN3iPW6H7r9bOI
 eSQtcpyqzMiARaEgUxUnosOUxGaew59I8zaaG37shr9NgEum05EINSPmOJE18eRt5x52
 xy2ZvIQarHrTdEnZcH34IcPs/fbNW3HBkQxsGHWLnlzcBcgo3kXQPEo2d/EXut/9CMDe
 6OxvDxM88iALpfEgLqeuVcEgYTi7bi/j+ItOPUNkXpH0pPZWasSEkxqDTKFFsyS1oz61
 A2YoobnkGL9GmjnirBRepfJ7TrhhfI/Sam2lKqmBcafeH/aeOaf0SGlEw847TgU689ct
 IniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794177599; x=1794782399;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cDMmI2UqRAqSDkjhtwDc5ZRUeFfMooMTF2CHO0kKXno=;
 b=GBjQK8hcleHUZZ9+gzpCdQN8JtYPrk07mLJ4yDIC5SkfAqJC2lgS9KRJKDzHWtFLD0
 NmHESJcE31gb7QJpWXj64xHQPnUE/J+0/Ggc5SNLKNoQ6YkbhuzKqrnc/QLSHePbfwUI
 NEmWp1yTywlJa9R3dPGHwEp48ypiV2vd8ilVQgl1l51DveSA3X9u/vvtQ8lnM/6pTs/f
 pWF/PXKiCnwQ3p8d/gfE4oFCw3jII+22nQ+se/o0NUukLrGLg9vKHxt0Z8xD0m+DaYI2
 AL5u1vjPrHmeHVMW8NmHLw6DC2xGvwBV0dRmAtw003soSRA0F/cnf3HHeHlcz/pjEQTU
 GNBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHx57GPRc2XaynNA9LRUvK5iJL2uCDyG8QvNYn5afYKkymLei6QrFXG5tuT6LDDTygJRsnG/tsq8/c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4Tglc/pNRJ/HKR/sJwFW8L0zX3A8D0tmvWYsZjmvAUMco0uW4
 llcFkAyQKPc5YSq7hYpeidVKSqWynIIm4/QVC0gg94Bvae454dIO43ZL9bg0XtDsr4UX3v3wjjU
 V4oUC/0raOg==
X-Received: from jabkb9.prod.google.com ([2002:a05:6638:a489:b0:5fe:2546:25c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:c0c3:10b0:6f6:b13f:5d2d
 with SMTP id 006d021491bc7-7170f1b1402mr914772eaf.12.1794177598756; Sun, 08
 Nov 2026 14:39:58 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:13 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-10-irogers@google.com>
Subject: [PATCH v3 9/9] kobject: Require explicit initialization of struct
 kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
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

Documentation/core-api/kobject.rst states:

  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code
  is flawed. Note that the kernel will warn you if you forget to provide
  a release() method. Do not try to get rid of this warning by providing
  an \"empty\" release function."

Annotate struct kobj_type::release with __must_init so the compiler
diagnoses any struct kobj_type initializer that omits .release.

For the remaining legacy struct kobj_type definitions where the kobject
is static, per-CPU, a permanent firmware structure, or embedded inside a
devm- or parent-managed allocation rather than freed by kobject_put(),
explicitly initialize .release = NULL with a comment documenting why no
release callback is provided.

Many of these legacy sites are not safe with CONFIG_DEBUG_KOBJECT_RELEASE
(for example when backing memory is freed, zeroed, or unmapped on module
unload while delayed kobject cleanup is still pending). Fixing those
lifetimes is left to follow-up patches; this change does not alter their
behavior.

Link: https://lpc.events/event/20/contributions/2392/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/arm64/kernel/cpuinfo.c                   |  5 +++++
 drivers/acpi/sysfs.c                          |  2 ++
 drivers/dma/ioat/sysfs.c                      |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 10 +++++++++
 drivers/infiniband/hw/hfi1/sysfs.c            |  5 +++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  5 +++++
 drivers/parisc/pdc_stable.c                   |  5 +++++
 drivers/power/supply/ab8500_fg.c              |  5 +++++
 drivers/s390/char/sclp_mem.c                  |  2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 21 +++++++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  8 +++++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  8 +++++++
 fs/erofs/sysfs.c                              | 10 +++++++++
 fs/f2fs/sysfs.c                               | 15 +++++++++++++
 fs/ocfs2/cluster/masklog.c                    |  5 +++++
 include/linux/kobject.h                       |  2 +-
 18 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 94e6cd211d70..7a4ac8dd0b86 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -295,6 +295,11 @@ const struct seq_operations cpuinfo_op = {
 
 
 static const struct kobj_type cpuregs_kobj_type = {
+	/*
+	 * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
+	 * cpuid_cpu_offline() only calls kobject_del().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a4534b3e3cfb..a10f14524dd9 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -975,6 +975,8 @@ static struct attribute *hotplug_profile_attrs[] = {
 ATTRIBUTE_GROUPS(hotplug_profile);
 
 static const struct kobj_type acpi_hotplug_profile_ktype = {
+	/* Pre-existing: hotplug->kobj is embedded in static struct acpi_scan_hotplug objects. */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index 976134df8108..b9af60e198ef 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -167,6 +167,13 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
+	/*
+	 * Pre-existing: ioatdma_chan is freed by release_ioatdma(), not
+	 * by kobject_put(). With CONFIG_DEBUG_KOBJECT_RELEASE the delayed
+	 * kobject cleanup queued by ioat_kobject_del() may run after
+	 * that kfree(), a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7e82..a2a027e4b118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -892,6 +892,11 @@ static const struct attribute_group ualink_xcp_info_group = {
 };
 
 static const struct kobj_type ualink_xcp_info_ktype = {
+	/*
+	 * Pre-existing: xcp->ualink.kobj is embedded in struct amdgpu_xcp_mgr
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index ab14079d1c42..0847134a1391 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
 };
 
 static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	/*
+	 * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
 	.default_groups = xcp_cfg_res_sysfs_groups,
 };
@@ -1061,6 +1066,11 @@ static const struct attribute_group amdgpu_xcp_attrs_group = {
 };
 
 static const struct kobj_type xcp_sysfs_ktype = {
+	/*
+	 * Pre-existing: xcp is embedded in struct amdgpu_xcp_mgr
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 372cfd13dc61..5a1aca06b542 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -608,6 +608,11 @@ static const struct sysfs_ops sde_sysfs_ops = {
 };
 
 static struct kobj_type sde_ktype = {
+	/*
+	 * Pre-existing: sdma_engine is embedded in dd->per_sdma array
+	 * rather than freed by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &sde_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..0c9dbf93a0e9 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -245,6 +245,11 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
+	/*
+	 * Pre-existing: qp_grp->kobj is embedded in RDMA core-managed
+	 * struct usnic_ib_qp_grp rather than freed by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
 	.default_groups = usnic_ib_qpn_default_groups,
 };
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 6b567a74fc2c..2f530e8c6757 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -484,6 +484,11 @@ ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static const struct kobj_type ktype_pdcspath = {
+	/*
+	 * Pre-existing: pdcspath_entry instances are static; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &pdcspath_attr_ops,
 	.default_groups = paths_subsys_groups,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 069e7fee1d16..f71630d92231 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2539,6 +2539,11 @@ static struct attribute *ab8500_fg_attrs[] = {
 ATTRIBUTE_GROUPS(ab8500_fg);
 
 static const struct kobj_type ab8500_fg_ktype = {
+	/*
+	 * Pre-existing: fg_kobject is embedded in devm-allocated struct
+	 * ab8500_fg; ab8500_fg_sysfs_exit() only calls kobject_del().
+	 */
+	.release = NULL,
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..2fb7271dce36 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -305,6 +305,8 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 }
 
 static const struct kobj_type ktype = {
+	/* Pre-existing: permanent firmware kobjects, never freed */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0cc2953d59a5..da7a64c95058 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1038,6 +1038,13 @@ static struct attribute *hccs_port_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_port_default);
 
 static const struct kobj_type hccs_port_type = {
+	/*
+	 * Pre-existing: hccs_port_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_port_default_groups,
 };
@@ -1110,6 +1117,13 @@ static struct attribute *hccs_die_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_die_default);
 
 static const struct kobj_type hccs_die_type = {
+	/*
+	 * Pre-existing: hccs_die_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_die_default_groups,
 };
@@ -1213,6 +1227,13 @@ static struct attribute *hccs_chip_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_chip_default);
 
 static const struct kobj_type hccs_chip_type = {
+	/*
+	 * Pre-existing: hccs_chip_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_chip_default_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..452920a4e2a9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -304,6 +304,13 @@ static const struct sysfs_ops display_sysfs_ops = {
 };
 
 static struct kobj_type display_ktype = {
+	/*
+	 * Pre-existing: dssdev->kobj is embedded in struct omap_dss_device
+	 * and zeroed in display_uninit_sysfs() right after kobject_put().
+	 * With CONFIG_DEBUG_KOBJECT_RELEASE that memset() clobbers the
+	 * pending delayed kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &display_sysfs_ops,
 	.default_groups = display_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..c343c33199af 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -496,6 +496,14 @@ static const struct sysfs_ops manager_sysfs_ops = {
 };
 
 static struct kobj_type manager_ktype = {
+	/*
+	 * Pre-existing: mgr->kobj is embedded in dynamically allocated
+	 * managers[], zeroed in dss_manager_kobj_uninit() right after
+	 * kobject_put(), and freed in dss_uninit_overlay_managers(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE that clobbers and frees the pending
+	 * delayed kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &manager_sysfs_ops,
 	.default_groups = manager_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 1da4fb1c77b4..5c14446af9b3 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -429,6 +429,14 @@ static const struct sysfs_ops overlay_sysfs_ops = {
 };
 
 static struct kobj_type overlay_ktype = {
+	/*
+	 * Pre-existing: ovl->kobj is embedded in dynamically allocated
+	 * overlays[] and freed in dss_uninit_overlays() right after
+	 * dss_overlay_kobj_uninit() calls kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after kfree(overlays), a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &overlay_sysfs_ops,
 	.default_groups = overlay_sysfs_groups,
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dfcec9376cd5..2ea6773cd98f 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -238,6 +238,11 @@ static const struct kobj_type erofs_sb_ktype = {
 static const struct kobj_type erofs_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * Pre-existing: erofs_root is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kset erofs_root = {
@@ -247,6 +252,11 @@ static struct kset erofs_root = {
 static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * Pre-existing: erofs_feat is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject erofs_feat = {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 430356e500af..6e15695cb75f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1683,6 +1683,11 @@ static const struct kobj_type f2fs_sb_ktype = {
 
 static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
+	/*
+	 * Pre-existing: f2fs_kset is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kset f2fs_kset = {
@@ -1697,6 +1702,11 @@ static const struct sysfs_ops f2fs_feat_attr_ops = {
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_feat_attr_ops,
+	/*
+	 * Pre-existing: f2fs_feat is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_feat = {
@@ -1711,6 +1721,11 @@ static const struct sysfs_ops f2fs_tune_attr_ops = {
 static const struct kobj_type f2fs_tune_ktype = {
 	.default_groups = f2fs_tune_groups,
 	.sysfs_ops	= &f2fs_tune_attr_ops,
+	/*
+	 * Pre-existing: f2fs_tune is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_tune = {
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..ff8a1cf51e72 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -147,6 +147,11 @@ static const struct sysfs_ops mlog_attr_ops = {
 static struct kobj_type mlog_ktype = {
 	.default_groups = mlog_default_groups,
 	.sysfs_ops      = &mlog_attr_ops,
+	/*
+	 * Pre-existing: mlog_kset is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release        = NULL,
 };
 
 static struct kset mlog_kset = {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..8a1332030884 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -114,7 +114,7 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
-	void (*release)(struct kobject *kobj);
+	void (*release)(struct kobject *kobj) __must_init;
 	const struct sysfs_ops *sysfs_ops;
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
-- 
2.56.0.455.g6c5a503b38-goog

