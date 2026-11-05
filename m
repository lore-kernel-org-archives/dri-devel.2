Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EBB606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ul3wcDfo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A1E112C48;
	Fri,  6 Nov 2026 09:18:49 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFCA10E939
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 06:04:41 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b083afebe4so194022a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 22:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793858681; x=1794463481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPu8h0jDpjB4vijwFawJAErayo8SO8CuvsZ0ZVqanQU=;
 b=Ul3wcDfosVBqlZGOSZ5rcHsDD3MMJEld+jrjdyGYCIadOqQd0Mj6N/pctWIXOhXZ0+
 jVi57lqrhb7G0aQq1WCw7AHHXWRWkfxHte20PQnT5ams4alcFcKOT1GE0/0V6KbZWWpu
 oejLWIxHC2qGzUAxom1fYnnSbLv0XQIROpge6+zGGQRyKCi/6ltvOYlsjgL5mbf6O0sg
 hfcUpmhW+ruCmO6FliHyNFqbzFTOBJIc0ewX3kNV2FkIORMrs5JwYfk1nOZxe6ak8IVo
 +PszgmOFVdy6CX333iksuNllECHtm3we23TgX/IkiaeDsIwJQc3lQFuvAH/O2N1PCkGo
 5PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793858681; x=1794463481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YPu8h0jDpjB4vijwFawJAErayo8SO8CuvsZ0ZVqanQU=;
 b=P3eRj+9KAbUCv0FC58bAiI3OI7Hp2umFwXYcf9PDjbxt4N7Nt23Et2nrK6ZTo9k1MH
 mr1NYjlfB0GcZQ6ETnHFtSPYqkPW5hest45rdBr+Q+2C39si7xoGkoGGnxVY/hXh3skn
 J8RvMpffqQTSfFVezy2R0NGPIVuBN0QrhCWEvkyx5gCEA97A25bJwIeQSw4mdu313hzh
 ZoNHOEFBwOaXLA390hnJREnwXbjHnBWm9xsQereuYa7komF/BTNX1wD88N0cIR+jMWaj
 RARzwatZ9E+imSicTTy5c0THaTJ7pXEt1GLVK+JbDX5Q9Oux7pz9FJmh8H4zVX27hMCx
 aaxw==
X-Gm-Message-State: APuU4Z8lE1uvFwwQMcUJPdxQ3F2zX31Vb8oHLa6VO3NDwJu/zw/c9437
 cX8vuFI6jUhu6izueW5Yshn4XEGje0RMcDK0nF7ZMRvl0D1NMB/zpCvC
X-Gm-Gg: AYBFou2SQNcmUS4jVJUst3s1mO+YhVQHLXvRoTuIDgzY3ByKZeFzoHAAHlDRIXq/wff
 DORzvF66HCZEeD9Et5Q03B13/ogiLelfML7jgnu9qjgxSHkQEWXp7AB/kQ8TW/ZtmECj1aggJFO
 neMeoZ0iWI4250rMGdgx3nHg5zlOywHXGG7WY23Qk6s+HHL82dZw2Ksf97RF4snDoqf2cdqQHj9
 PEf0Ce1KM/qf4CWbdQEm/nwDD2i9aC/xVWsNs+IP3Y6DiiBlGStDVsWL3RHhS+CtJ0dqJFaC8Sv
 bRlOSCqdR+JXyn1kDoLGv1vr55JTsF/iYe9ZUuYKdu50GExIoBdHtYDHPcD8/5MzYYDCjufKBXH
 cnO0KKJBI1zfJnUypVql5HcdBowT8cWSO1oRSGaW+yA0MG8DeRkEd8XOb7Euv+Qci50vkHSrr0E
 +1sR6GY5ljjDgObj8s3TMgc6THX1qzDDtr2tiHgvY/xv+yoOt3j2+NmSunYVR1XShGC8IuV/oe0
 bPvhqEVfm4In5x+xXBRGOkF5kEje1Us/EZ+kfFipOs4wRdGIg3qY0w5STKeQI9ACiVu9/k43zR0
 CSVufqvVSaWYj5bMinxUcJLkGf439T8QY0Rqmq5aYw==
X-Received: by 2002:a17:90b:1652:b0:3ac:a7ee:6785 with SMTP id
 98e67ed59e1d1-3ae895a0406mr26169727a91.1.1793858680988; 
 Wed, 04 Nov 2026 22:04:40 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c0dcsm2093100a91.1.2026.11.04.22.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 22:04:40 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2 1/2] i915/gt: don't store ERR_PTR into ppgtt->base.pd on
 allocation failure
Date: Thu,  5 Nov 2026 14:04:21 +0800
Message-Id: <20261105060422.51848-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105060422.51848-1-lui2012qwq@gmail.com>
References: <20261105060422.51848-1-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() directly
into ppgtt->base.pd, and on failure the ERR_PTR stays in the field.
i915_vm_put() runs vm->cleanup = gen6_ppgtt_cleanup(), where
gen6_ppgtt_free_pd() dereferences pd via gen6_for_all_pdes() - with an
ERR_PTR that is an invalid dereference and a crash (in the async
release worker).

Assign to a local first and store into the field only after it is
validated, so the field never holds an error pointer; on the failure
path it stays NULL, and gen6_ppgtt_free_pd() now bails out on a NULL
pd.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 438cd4724ac4..f747ee1f96d7 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
 	struct i915_page_table *pt;
 	u32 pde;
 
+	if (!pd)
+		return;
+
 	gen6_for_all_pdes(pt, pd, pde)
 		if (pt)
 			free_pt(&ppgtt->base.vm, pt);
@@ -427,6 +430,7 @@ void gen6_ppgtt_unpin(struct i915_ppgtt *base)
 
 struct i915_ppgtt *gen6_ppgtt_create(struct intel_gt *gt)
 {
+	struct i915_page_directory *pd;
 	struct i915_ggtt * const ggtt = gt->ggtt;
 	struct gen6_ppgtt *ppgtt;
 	int err;
@@ -455,11 +459,12 @@ struct i915_ppgtt *gen6_ppgtt_create(struct intel_gt *gt)
 	if (err)
 		goto err_put;
 
-	ppgtt->base.pd = gen6_alloc_top_pd(ppgtt);
-	if (IS_ERR(ppgtt->base.pd)) {
-		err = PTR_ERR(ppgtt->base.pd);
+	pd = gen6_alloc_top_pd(ppgtt);
+	if (IS_ERR(pd)) {
+		err = PTR_ERR(pd);
 		goto err_put;
 	}
+	ppgtt->base.pd = pd;
 
 	return &ppgtt->base;
 
-- 
2.25.1

