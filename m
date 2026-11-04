Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9E606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQsDjf/1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5D310F1BB;
	Wed,  4 Nov 2026 08:58:33 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF7910F9F8
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:33:25 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-36d499f6ab6so4846eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793777605; x=1794382405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XbaYXLldoLvnznmVKhXjejOBcwlPqhhTJlN1aaHsr8=;
 b=zQsDjf/1lCgvStMNl4TFc3jLWRBV0KCJuTnB3Pkxx49yCBELFxjFw37m4VfnfTKG7N
 Rcbscv/+SeQ0tysiMVyL1RvuxMx6A2stuEiXc+kZ+H9HI0RNTOf9vqu7eB6ClQnoalM/
 eWvVRiTuhfO+yIdYe3jJKTCFizvp++mmzMuSzh635srNzhAiFxolNVDq8P7t9GOLOGmx
 EXQHZpr0CU6ZLvDKNmMCOlgzCVp1skuYIKNdGyyT+G1umRn/wU2IGKr9S4FsWwKuNqog
 Vh/dIyOZBkX54UD2piJQssNLSjkYHl3gV2SLHwP5lcpuqCXZELbcN7vNYDQdao7OkRPT
 n4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777605; x=1794382405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XbaYXLldoLvnznmVKhXjejOBcwlPqhhTJlN1aaHsr8=;
 b=O1wUTwNtCUNbQmhDKZZoVbnHqUBvHYcKHvZo9aKgdhgJOgi+VIKIqP2R6GI7QPdUHG
 vMA3bmzNg42hUPnox5yGlY/9e7Hzqt5WV30TZz42yRNzM3DC4dNHJbQ/z02m6nhutvtq
 jPfp6k0QRIaRT3CuRyG15XthPFiYAppRV3R7VlK3pRumHuHY/Z/4MaNJpMduK2f/cOEG
 2hh2GY6E/VYAfjR0QhF7cXfwvoKf0YS10+lvPZYINBcWzjR8HaiaEIQJ+EO3ki/ikiF1
 Uv+27tYo+4YClkbqAUn3Ld/w/qfhTYmI6Ur3wQQwekjvxL4b4xHfmtUYaJmaRw0XqcZ+
 t6ew==
X-Gm-Message-State: APuU4Z+FBrvt50Xed8IGjamVHD7oR3glwEpPrv2ddLmhunyyTLw/h+AU
 y+I82z9VZQ+oyHAS0SGF+g/vpZ3/E/cme2dbRbJQowZmkkt9nlRifyyy
X-Gm-Gg: AYBFou0YxVyc8ZAPphTx3Toq+a1YKtgTz3kyA/gV8kjD9CYNEaxnlG8sU35pb4TqqET
 zamvOka6TXZ9RIOSU9SNLhwRhxMA2T/x31LTWdzZ1P6F5fAz/WaC+lADVU6QHT0exrSWuaCVMnP
 oeLFxx6rXIWgOkzeYn3cQ4MTeG1Lgabsa9XmwjJzCsfV1e3pD54l54O5QzGjWqgf7jJrbV+zmBz
 ngd5v4e/K3BghlnFQ1tBoLuxWHcWIdVBtfd3aWJmD5seyrXV+ULzkeXKoUhxrMcy7N22OmduEL8
 ulE0E57FRf42ywLUPmssozP7PbtG1cXZl1eAFBq1Kfxi0NXhjW6bhGz0fcPr4WQOarBgGkaYaRm
 yoc1zOtlLFtc0QJMFETPUhjb15aHzeBhmLCEmJzwL4whQUniqNT5TSCjZqopV3wgxkHZDEWbbng
 3N52egOSbcPdbsdFDbpSsosdTP8I9BLCmcNU2FMX/+pOAB0PJTB292cu++Zyn/UI1CaH+z9kvrN
 RmbMeqyYqcIeq6MRR90VaNqDIQoZgmZdR616BaVJiTS5BfKby/612Q8CjS4CCh+UBBQivZQUkf3
 vT3VJqdC4T+2mQQIe4vY7sZBxIjSENasHLWT7ntjbA==
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id
 5a478bee46e88-36a4231f8e3mr35132513eec.1.1793777604980; 
 Tue, 03 Nov 2026 23:33:24 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d3754sm6295359eec.14.2026.11.03.23.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:33:24 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, Chengyu Liu <lui2012qwq@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
Date: Wed,  4 Nov 2026 15:33:10 +0800
Message-Id: <20261104073311.1617823-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104073311.1617823-1-lui2012qwq@gmail.com>
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() into
ppgtt->base.pd and, on failure, jumps to err_put with the ERR_PTR still
in the field.  i915_vm_put() runs vm->cleanup = gen6_ppgtt_cleanup(),
which calls gen6_ppgtt_free_pd(), where gen6_for_all_pdes() immediately
dereferences pd - with an ERR_PTR that is an invalid dereference and a
crash (in the async release worker).  The free_pd() right after is only
guarded against NULL, not ERR_PTR.

Bail out of gen6_ppgtt_free_pd() for an invalid pd and skip free_pd()
likewise, so an allocation failure under memory pressure stays a plain
-ENOMEM instead of an oops.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 438cd4724a..72a9ad4642 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
 	struct i915_page_table *pt;
 	u32 pde;
 
+	if (IS_ERR_OR_NULL(pd))
+		return;
+
 	gen6_for_all_pdes(pt, pd, pde)
 		if (pt)
 			free_pt(&ppgtt->base.vm, pt);
@@ -271,7 +274,7 @@ static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
 	gen6_ppgtt_free_pd(ppgtt);
 	free_scratch(vm);
 
-	if (ppgtt->base.pd)
+	if (!IS_ERR_OR_NULL(ppgtt->base.pd))
 		free_pd(&ppgtt->base.vm, ppgtt->base.pd);
 
 	mutex_destroy(&ppgtt->flush);
-- 
2.25.1

