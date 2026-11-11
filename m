Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57C606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTT3MpEs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F551120F3;
	Thu, 12 Nov 2026 12:57:01 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD21310E9BE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:42:06 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-37605faade6so58837eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794400926; x=1795005726; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OQ16sdEJf1gdJkohVqyloM5KBnz2C1+nxajXYYSElQA=;
 b=XTT3MpEsgi7KvvKPIQuNWcGIVEmFelWyflchYRpnl/oyjFqXbPEDR4uJe7nCiNwY+7
 F5owo7oSZqwpRi9tpRUAMnJpET8djpU42l+EVN12M5OIgLuOxEU72EuQkDUs/Rtnq0NQ
 u8gO9bVxnKbw4HIwd6MzIM91SDosM8o9mo2xstqMSOHAoOHvdJDFwRPDt5meTKunfkAv
 Jsm1gzDrWdZGK5HTqCI1+0OCSHNyrzIh/ru+O6UUVdLSr4ubPZnQNz4IbOkyJYx7by+t
 ijLGlWZGcGftYXvWioHNZ9f7xe8nySToERDR7oyBbxvjkHW0U4Ir3kKexK4i7b4SXLFo
 PKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794400926; x=1795005726;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OQ16sdEJf1gdJkohVqyloM5KBnz2C1+nxajXYYSElQA=;
 b=f2rnMc+8458oxedinj6pVflygtb8lBM/ZtqEmHUAOn4zo9WnfinHgBB/x6vHgw98cN
 oB7LDN6H7WKycGWJtuyTGIA61dDo1CoBbJ5U6QN0ywIKCy9XY9yRpAzeqg1kFiS5opUk
 Bs6JJINzOdXO+5bykr7gPDzpYcWL1aOxPHRnMEJFIP0tskbZ4Jg4SB9XOiUkGZAAJZ4b
 PEGqPeRddFyGey1GFbDi3+v10/hNvnbCpwr4mPaRL8DD4d8LLIfYvKvSkvpgt03cZ3h4
 0IEcprlZb0ax4UtKqtGY9yWndh6Xfbh1NItIJK7ZqQ8j+vJDn80q7o0pi/QnUZX+Ml9g
 qZ+A==
X-Forwarded-Encrypted: i=1;
 AL+hErH1C4iPQxF/Qed05n+w8AO/fzpRzvZhegn/VHck3sBcDsXWhjPkp9uGAqO48WApfA6HhhKx66jzxtE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+hqsTqQFKL6D03fmo41OBKQVidAqSZT0TSRIeaysziAXmoKMZV
 fZ22ywyUd6UGThXB/ydABCnKAeA1Nu8USaVbyPqDDO6KuPPsI5ZVh823
X-Gm-Gg: AYBFou15X3b9ZMOP25DxVH9c4ncz8T5Yl5fqZGI7T3DqiCUCX+03whGSOTFDbGP1fZz
 ztcHzGXoL6q4YCprlyTlZvCepfvsruFhSz0uqtMkPcGlW+M9NJZLj336SiSLOQICxje45qaUzMi
 DTk2A+TfJ92ApFFg5RZzucxdhxHCRgJbKKadBn93Ptsdbr0Hq/jLz8/HWZmSNovL8nhiIbIbbdK
 58wq64AjSWHka1uu7LLTQcfnTPh1EOlcMObaIEnQ/JgTb5YXE5fBwUF8YxN5TMDG1brn01wOQNl
 R5/dd26jnpjqLip1s4RIZwGr9zwsv0iD1IJHdyd3LT6QWV3RMGkQ/fHULg6SPYkuOKjKODPapiP
 eZ5RGkPx/nI4/pzJBko7jBpfcc4K+lTSYUbOfySX/lRJOqDHKcRc0f9v/eRU7Cu7b2SdS1nJsXP
 S0o7lhmR6uRfKVoaVXSvy0yeEd/KKwHUGUek54Q/ohAd9bHLuH0HsSX3agAgbX5LXmc03sqN8pt
 +ujUfsmGDpx9U6e9i5VfakSR9TAl3U351rZrKEvpFwfdTtDvJBhtCTkSCj/cLlnBSLbbyhgX3qh
 iLHvPTnjETe0klgf9w/b4gDZ2JMn4v4CVo2ivv/IXIu6MtUZMSog93942vJPtDikVkI=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b3c01600d4mr3616454c88.0.1794400925446; 
 Wed, 11 Nov 2026 04:42:05 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b4efc2sm13462032c88.15.2026.11.11.04.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 04:42:04 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Date: Wed, 11 Nov 2026 20:41:26 +0800
Subject: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHVi9GoC/3WO2wrCMBBEf6Xk2dUmxlZ98j9EZJNs20jbSFKLF
 /rvNhWhCD7OMOcwLxbIWwpsn7yYp94G69oxrBcJ0xW2JYE1Y2YiFRnnaQbP0GBdO30OHXZAY2u
 k0VzkGRuZq6fC3iff8fTJ4aYupLsoiQuFgUB5bHUVKyUhNquvFox3V4juOK5s6Jx/TO96HqX/j
 vQcOKhNLguZc4mmOJQN2nqpXcPikV7M6d0vLSAFjUSSZ1uJCuf0MAxvI0pZ6ycBAAA=
X-Change-ID: 20261106-zsmalloc_stat-e261d4dc1276
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>, 
 Xueyuan Chen <xueyuan.chen21@gmail.com>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:57:00 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
counters are updated regardless of this option.

Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
debugfs is unavailable.

Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
documentation to match, and clarify the pool name in the debugfs path.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional. The
option only controls the debugfs interface, while the class counters are
updated unconditionally. Removing it simplifies the code.

Following Nhat's suggestion, remove CONFIG_ZSMALLOC_STAT and rely on
the existing debugfs API stubs when CONFIG_DEBUG_FS=n.
---
Changes in v3:
- Squash the three patches into one (Nhat, Sergey).
- Add Nhat's Reviewed-by.
- Update the documentation wording.
- Link to v2: https://patch.msgid.link/20261109-zsmalloc_stat-v2-0-caee41684aba@gmail.com

Changes in v2:
- Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional.
- Update configuration files and documentation.
- Link to v1: https://patch.msgid.link/20261106-zsmalloc_stat-v1-1-b574f4714adf@gmail.com
---
 Documentation/mm/zsmalloc.rst                    |  4 +--
 Documentation/translations/zh_CN/mm/zsmalloc.rst |  2 +-
 arch/s390/configs/debug_defconfig                |  2 +-
 arch/s390/configs/defconfig                      |  2 +-
 drivers/gpu/drm/ci/arm.config                    |  2 +-
 drivers/gpu/drm/ci/arm64.config                  |  2 +-
 drivers/gpu/drm/ci/x86_64.config                 |  2 +-
 mm/Kconfig                                       |  9 -------
 mm/zsmalloc.c                                    | 33 ++----------------------
 9 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index d2bbecd78e14..4c0786378dc3 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -33,8 +33,8 @@ proper handle-based APIs.
 stat
 ====
 
-With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
-``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
+With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
+``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::
 
  # cat /sys/kernel/debug/zsmalloc/zram0/classes
 
diff --git a/Documentation/translations/zh_CN/mm/zsmalloc.rst b/Documentation/translations/zh_CN/mm/zsmalloc.rst
index 4c8c9b1006a9..b555a07ac871 100644
--- a/Documentation/translations/zh_CN/mm/zsmalloc.rst
+++ b/Documentation/translations/zh_CN/mm/zsmalloc.rst
@@ -32,7 +32,7 @@ zs_unmap_object()解除映射。
 stat
 ====
 
-通过CONFIG_ZSMALLOC_STAT，我们可以通过 ``/sys/kernel/debug/zsmalloc/<user name>``
+启用CONFIG_DEBUG_FS，我们可以通过 ``/sys/kernel/debug/zsmalloc/<pool-name>``
 看到zsmalloc内部信息。下面是一个统计输出的例子。::
 
  # cat /sys/kernel/debug/zsmalloc/zram0/classes
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index d44674b63715..83193ef8efb9 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -100,7 +100,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 CONFIG_SLAB_BUCKETS=y
 CONFIG_SLUB_STATS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index e00e252d4694..694a309377d5 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 CONFIG_SLAB_BUCKETS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/drivers/gpu/drm/ci/arm.config b/drivers/gpu/drm/ci/arm.config
index d7c51670da2f..fc0a8a4bfb18 100644
--- a/drivers/gpu/drm/ci/arm.config
+++ b/drivers/gpu/drm/ci/arm.config
@@ -5,7 +5,7 @@ CONFIG_CRYPTO_ZSTD=y
 CONFIG_ZRAM_MEMORY_TRACKING=y
 CONFIG_ZRAM_WRITEBACK=y
 CONFIG_ZRAM=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
 CONFIG_BLK_DEV_INITRD=n
diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index c46125c1f80f..10b01b55a66d 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -5,7 +5,7 @@ CONFIG_CRYPTO_ZSTD=y
 CONFIG_ZRAM_MEMORY_TRACKING=y
 CONFIG_ZRAM_WRITEBACK=y
 CONFIG_ZRAM=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
 CONFIG_BLK_DEV_INITRD=n
diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
index 7ac98a78691e..8225b806dad8 100644
--- a/drivers/gpu/drm/ci/x86_64.config
+++ b/drivers/gpu/drm/ci/x86_64.config
@@ -5,7 +5,7 @@ CONFIG_CRYPTO_ZSTD=y
 CONFIG_ZRAM_MEMORY_TRACKING=y
 CONFIG_ZRAM_WRITEBACK=y
 CONFIG_ZRAM=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 
 CONFIG_PWM=y
 CONFIG_PM_DEVFREQ=y
diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..4a77cda7f1d7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -130,15 +130,6 @@ menu "Zsmalloc allocator options"
 
 comment "Zsmalloc is a common backend allocator for zswap & zram"
 
-config ZSMALLOC_STAT
-	bool "Export zsmalloc statistics"
-	select DEBUG_FS
-	help
-	  This option enables code in the zsmalloc to collect various
-	  statistics about what's happening in zsmalloc and exports that
-	  information to userspace via debugfs.
-	  If unsure, say N.
-
 config ZSMALLOC_CHAIN_SIZE
 	int "Maximum number of physical pages per-zspage"
 	default 8
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7ef80e0da626..104ccf3aa170 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -222,9 +222,7 @@ struct zs_size_stat {
 	unsigned long objs[NR_CLASS_STAT_TYPES];
 };
 
-#ifdef CONFIG_ZSMALLOC_STAT
 static struct dentry *zs_stat_root;
-#endif
 
 static size_t huge_class_size;
 
@@ -279,9 +277,7 @@ struct zs_pool {
 	/* Compact classes */
 	struct shrinker *shrinker;
 
-#ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
-#endif
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
@@ -565,14 +561,10 @@ static inline unsigned long class_stat_read(struct size_class *class, int type)
 	return class->stats.objs[type];
 }
 
-#ifdef CONFIG_ZSMALLOC_STAT
-
 static void __init zs_stat_init(void)
 {
-	if (!debugfs_initialized()) {
-		pr_warn("debugfs not available, stat dir not created\n");
+	if (!debugfs_initialized())
 		return;
-	}
 
 	zs_stat_root = debugfs_create_dir("zsmalloc", NULL);
 }
@@ -650,10 +642,8 @@ DEFINE_SHOW_ATTRIBUTE(zs_stats_size);
 
 static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
 {
-	if (!zs_stat_root) {
-		pr_warn("no root stat dir, not creating <%s> stat dir\n", name);
+	if (IS_ERR_OR_NULL(zs_stat_root))
 		return;
-	}
 
 	pool->stat_dentry = debugfs_create_dir(name, zs_stat_root);
 
@@ -666,25 +656,6 @@ static void zs_pool_stat_destroy(struct zs_pool *pool)
 	debugfs_remove_recursive(pool->stat_dentry);
 }
 
-#else /* CONFIG_ZSMALLOC_STAT */
-static void __init zs_stat_init(void)
-{
-}
-
-static void __exit zs_stat_exit(void)
-{
-}
-
-static inline void zs_pool_stat_create(struct zs_pool *pool, const char *name)
-{
-}
-
-static inline void zs_pool_stat_destroy(struct zs_pool *pool)
-{
-}
-#endif
-
-
 /*
  * For each size class, zspages are divided into different groups
  * depending on their usage ratio. This function returns fullness

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd

--  
Best regards,
Xueyuan

