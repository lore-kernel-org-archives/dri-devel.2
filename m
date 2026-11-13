Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB8606A335
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JUQcF7Gc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A788110F056;
	Sat, 14 Nov 2026 16:25:41 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942A10EC77
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 19:54:41 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-9495f083657so99224885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1794599679; x=1795204479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IM+AY411aupxDfXW3rYEXZkT1F3AQsoQqb9ny080FQ8=;
 b=JUQcF7GcaorDL3mIi2wu4G7mtzkHbWJiBBDPcfdCDM8GpubtUhRVnyPAJV71Sn+llV
 cQrwNQFzBbCKA13zRbHj97Fqd3oyWU3KJ/BznZQFeJn1DS31piwBme7gk6uiTp0jGhR0
 5BwJYciyewa7g1ZZSYGA8hVXjCnutNxU00mkoBEKvFD6Wo3KKF1EpcURTlMhcnXnu0xW
 hF4VBiksSPc3R33DGwyupCZu4fwOmIBS1X8lMpEifi4BrJekhoQ5PIuX1Khh75CYCRwr
 bSdUV1cs22oh1b5Wmgy+5A8WaJQrKdkMIOc/3y/vnlvL6Wr+xlZZIC5qIKqNfsps/v7R
 4rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599679; x=1795204479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IM+AY411aupxDfXW3rYEXZkT1F3AQsoQqb9ny080FQ8=;
 b=kC7JRPQ8qXmcd+QcT3pFfDPNcI58B+8/HhV4yQucGzz7xcV304502SQFNWP6VrwO+w
 10waInRSTS7i6UhzCoc93gzZnosmrWCUy8eynhQUP60AhZvCxNLNCVh95lTvX/XUTOXc
 NLEv9B6NyW0Ib6i21NdHja+ZERBLJH0UzsgxUbZby5oxYaD8VNS4xPghVPUAS1tRS+zT
 ukQiuMIECc2rx5OFLykuntH1d+ZWnECn7T8S5AoscHZM+CcBjuqYLziXRKAM1OFoITOp
 am/uXxR4diUVb0rqdLiK0vZB/mpvKb5UqtqCqYmoik2HPYAL0/LDpUycz6szC8xut/SB
 HCZg==
X-Gm-Message-State: APuU4Z9yOjjDJus/d6uKRAO7TIKzM2er+5bLJ5C849cp4B7jnfdoO9pS
 BKHrQK7IgCl8a68K5ehS4x2hU3g0R40S2YuyJD8imqUvzHA5BQ839hWyJJYmxJ5hRQA=
X-Gm-Gg: AYBFou0/zc6FibVesEc9Y7+4/N5CkKGxjsUzS/B+TvKeCKCLRG5zYAn4ud8aL7x908D
 /SBTaCrvCh2hzdMjJoMx3KBpoy586XkYg+EXahq9/xF4EXpeyJ635YlDDIgNCBiMmtmZfoFpjvv
 8S17nioipFVB6k6/Y+FVeXIn21rKBg8fgroyvxQdvEjnH9xTziPVWiEbqtpZG/vb5xKpA/BE7Kz
 mTtojOsAhx3Qs13BIwtXrt1yUYxROxhBT8wOauzF5gRmqzVMeL/0CQjkwSplgHotCk46Ju5Fkdj
 2tY8MsLOX5Sc1ik4jg5ALyGT+y/vR1+i3RL5pNLXAqiChBAX+PUVwtUSabCHObJjHG24zybM31l
 fZVBgC9LYjQdMnXyHt5+MCd0IFOnr3OhFk9Jqp+TixHNV89RUNKOqSmLu5eK4Nl6slosWZHBrnC
 dp32C+4zkyw0sJtAiGzTj1FNlsvABgtEOtXrx8ZZXU+y95UgbB0R2AIpwNBZUjoiOoDguRAnIDK
 PzQiR649Ji/AXBiBlb/2ybQG8QJFkTIQGOAiTddX/85enMtmmYWRomwc6uxUmpQuYFnpCcTQTee
 49nlp5t5DgkyxfUcxs5+SM+3JqBke2cpbl/FAYIuA9jkq71iK4Y0nZwp9BiliogKoHDNujOGJL4
 x2d4wHgNswswYPl8=
X-Received: by 2002:a05:620a:414c:b0:947:84e7:f617 with SMTP id
 af79cd13be357-9494bbcc0f7mr614745985a.64.1794599679506; 
 Fri, 13 Nov 2026 11:54:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c870ad4sm252867985a.26.2026.11.13.11.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:54:39 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, lyude@redhat.com, dakr@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, balbirs@nvidia.com,
 akpm@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/dmem: free migration arrays on early fault returns
Date: Fri, 13 Nov 2026 14:54:36 -0500
Message-ID: <20261113195436.2659094-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:25:34 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nouveau_dmem_migrate_to_ram() leaks its source and destination PFN
arrays when migrate_vma_setup() fails or collects no migratable pages.

The arrays used to be local variables, but THP support changed them to
kcalloc() allocations without updating these returns.

Route both exits through the existing array cleanup. Preserve
VM_FAULT_SIGBUS for a setup error and zero for an empty migration.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index e74d7bb975a8..4cfc7b16d445 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -233,10 +233,12 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	 * than just one page on CPU fault. When such fault happens it is very
 	 * likely that more surrounding page will CPU fault too.
 	 */
-	if (migrate_vma_setup(&args) < 0)
-		return VM_FAULT_SIGBUS;
+	if (migrate_vma_setup(&args) < 0) {
+		ret = VM_FAULT_SIGBUS;
+		goto err;
+	}
 	if (!args.cpages)
-		return 0;
+		goto err;
 
 	if (order)
 		dpage = folio_page(vma_alloc_folio(GFP_HIGHUSER | __GFP_ZERO,
-- 
2.56.0

