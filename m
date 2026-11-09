Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B37606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oh47ALlj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CEB10E7FC;
	Tue, 10 Nov 2026 08:33:31 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E0510E25C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:23:45 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1b3a05f8b5bso1978515c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794255825; x=1794860625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vZMlVuQCvzOzr707YkUZUysa5i36WCxjcozSPzEKGmM=;
 b=Oh47ALljgQLnDCqR5gi+bxvgnHzMKFNnZf12g5UrwEIW/XZMs2lUsGkrbSPGGDRknP
 J1/n/qw6ebicUTW5noFeOhAxes0rHf6xm7qwrFdPjw2SdY+bPVWYal32F6jmg1nIMVZK
 BADD7o9ZFTkxBr0I8SJ+FzU1xW2sdk1x27ypfok5JK5VAEh7vYF43p/qkg6p3V06th+7
 pX6y1bDyXfK2f62ir2S+hh1hzElRvPE7ldxmDZTqyxO5kpVN0DIKFXbSCBHsz+vbWxNz
 eNxgEJfERwFsjkvBMEQ19Hb3uEdoU0ftbihLV1Fp2JB+WZKovQ2tNsTpMFU8CTgCcV7I
 FW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255825; x=1794860625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vZMlVuQCvzOzr707YkUZUysa5i36WCxjcozSPzEKGmM=;
 b=hub7LCGi6Q3JVe4GiNshXO8eFgvsmKXvCovvtrqX89TazSd+wJZ+Za75QZqIRdkk0P
 3irIolxvam8xD1lVJN6jbMxLiFsizvE06pYd7lClrvAHMLvKUDplejRvNxej0Xl83Psg
 mB7raBjo/1m4yJ1b9GbhquL4eVpnfsw5aasA0t6jXhk750mtJ5PAdYMoOA1oeN8cIrYM
 g6WQ7MYMElLqyYqBXrhpKEvdhNVf8yqHfKQjfuz4bZdMuYD18QazPI/AcT0caN2acqEU
 +Ks1oKeeI7V3wNs8USKCRgnT/WbFXb7unRTs5+kTkcq69SVyt8RqadYP4gEkHIConK8A
 G7kw==
X-Forwarded-Encrypted: i=1;
 AL+hErFapHE2umKZBdvyW7x+njI749utfMMn3J9Py01CQp4dcfzwAt0/b0qrYk1oCwPPFOZazrCk6k8uEEA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8xz0xN9rGuKnqRvC11e1YxB/nSXLgtYmn3BjHTQz/47EWmbNxn
 naCwcT9v64NplzMCZZku0Q+3qpR3BkvFyCM644BtYf2zsqFKdli0ynXM
X-Gm-Gg: AYBFou0eWV7xrh3dpTgw4tq6LmBfys/9AteSYewhHVA6EQuYaBqXU3O2f6ja1Qmy23h
 lwxkrWHR1dvmkkCsW9kNwbldw0JDfjbOksTiUlhquCudbxUrySHUnlQOsBzpMCgjqUpq4EPZOm7
 ZzbsKirEgWJe0Ze0K+6D1ahLdHkl98bb6bbTDDFLfO8lZdqqK2IdLRSVsWQb9MAqJ/VCBbV2THr
 R5YuGLcyMsxVb2135t3P0R/UnXtvgI4gzXijRwWt2N6bZjxHKcHNl94pL+koTZUIPUd4Y+DD0ne
 0qKxm9cueS31w+2+bBpuoUIE8Cs0iy4a20uhPrfgpNUfsDLC5WptZ+YWyrur7Sx01PoLDetd5FU
 9NuJSMSaAU8Kuuf9aGFKK2iEFtrS8+MvDodRnIHGxMYxYu75g+fgj72ZByzotalyS5eqCOWtaCN
 ZrZv1z4b4jvKaHwqR4St33skEadJo8tjawj1yjbrX3K9n3i7omVnqFKD7DsOG0XvokKbbkrL3fD
 w4hRzhWMTidYPYSOS0nPy1RVXV7EiekyfPjnAaxwt9lJXklJYiJe2/bK36x6vuHdYRu7FGb8SH9
 5eQr3re8x4SkeVpbkpZvJtUeaR4b42QtHj7sObteDxouDpky9b5aYw==
X-Received: by 2002:a05:7022:b052:20b0:191:ac4:55a7 with SMTP id
 a92af1059eb24-1b3b6025b98mr747973c88.23.1794255824624; 
 Mon, 09 Nov 2026 12:23:44 -0800 (PST)
Received: from DESKTOP-6A237H8.localdomain ([106.219.176.229])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890584sm1520455c88.3.2026.11.09.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:23:44 -0800 (PST)
From: kaii-k <harshicon28@gmail.com>
To: nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com
Cc: ckoenig@amd.com, thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 Harsh Parmar <kaii02ctf@gmail.com>
Subject: [PATCH 3/3] drm/ttm: check for NULL resource in
 ttm_bo_vm_fault_reserved()
Date: Tue, 10 Nov 2026 01:53:30 +0530
Message-ID: <20261109202330.1816799-3-harshicon28@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202330.1816799-1-harshicon28@gmail.com>
References: <20261109202330.1816799-1-harshicon28@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harsh Parmar <kaii02ctf@gmail.com>

A buffer object can legitimately have no backing store: a driver may
call ttm_bo_init_reserved() with zero placements, which leaves
bo->resource NULL. It can also become NULL after the backing store has
been released.

ttm_bo_vm_fault_reserved() passes bo->resource to ttm_mem_io_reserve()
and dereferences it, causing a NULL pointer dereference when a fault hits
a buffer with no backing store.

Return VM_FAULT_SIGBUS if the buffer has no backing store.

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Signed-off-by: Harsh Parmar <kaii02ctf@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 872bf44..69dd6bd 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -205,6 +205,9 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	if (unlikely(ret != 0))
 		return ret;
 
+	if (unlikely(!bo->resource))
+		return VM_FAULT_SIGBUS;
+
 	err = ttm_mem_io_reserve(bo->bdev, bo->resource);
 	if (unlikely(err != 0))
 		return VM_FAULT_SIGBUS;
-- 
2.53.0

