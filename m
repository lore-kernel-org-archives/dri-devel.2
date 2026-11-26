Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963EA606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p09hglIC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72835112836;
	Fri, 27 Nov 2026 08:29:20 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7064910E458
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 23:17:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2f020d0169eso37399255ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795735041; x=1796339841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sELqHiChtNn7m4IH7Gf25iIdBWe6nyu+Z7VJekXziME=;
 b=p09hglIC0VBaubeqOvy4V+IvBuODtu4SDg2YM/xPa7p0TNfhtyFCi38WowVssgAfGG
 flbDm7FpOxAd7DoZh68kwyiVvSB/v3ds9m5fosIxF9nnixbGGn/LyYHatVYddlhOTE26
 GmqXFq4g86egCrh7eWjGGjQybVGMXN/hLpnTzsR8oGa55q9OWH/YdqGcWWt9XNMNHC2s
 8gfACcn5P8wqRsTflKTDaRGF1Vt5H6kjFOYczZyosvoTClRpxCpv0vjeGIxRpSTUgDWd
 45p1Iqo9kuECX825SRMv7eVU26gWFSE4sY0AxPfk3eXhoXMpgZPUfa7/zohERfj9/dHS
 Oe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735041; x=1796339841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sELqHiChtNn7m4IH7Gf25iIdBWe6nyu+Z7VJekXziME=;
 b=IdHjRgwwuuY0l5n5ZGbZMT9XMwrBdUf2h5vimlWAj9UaJ3n005VHv082RMyLyJJbAH
 OcOuggcCbrfJtHE1cHRD3GbnPliB5z0ZZhysKSsN+BBiNQZjGMyN6tuRa+366vs5Kc+L
 2d+FGscOfbloaa6xCsIX7YJ9TVtc0tNTzIsphgTij90IczpSSEWN4c+odBE/1wVPAWHp
 naslL1u2egFFzpvy4te5a95hRAGEFeIYWeiGbLghKvSxv7ldcpFdujxbpY0rIMFciV2f
 xHHtnLnSpUEq6kfgw537HesmHUcb4AOatg+/5quaVkOztIt8wbqobWgjejto9JtkjROJ
 sJ1w==
X-Forwarded-Encrypted: i=1;
 AL+hErFxz5f2zXJAdm8cuBojfv3HrG/y7uLukCcLaPxRlYE7j4EyXYSrHrS3Dq/u6MKyFtWwa7mD4WD5ACA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lx+PmTtJ3lvu83+IVFwoVXzxyzbKAwl7ZAPwwrfDbWk8N38uk
 WI+Bk/ZKRTzOOckSVIkvSz+6vAi1jBi4pNiYKg0/9udvIsjED7FruuLq
X-Gm-Gg: AZFdTZfHLEq5vL+sH5YCmspMBJarHGIwDz9lTN3DJGnyiTrqEjoPmfxSOM9Q08VAGbE
 iGJlsOb1tN4Ei1nl6Rlbp72FdfhI8paL2OJbH5ns5ejJWQho62fgClye/NkVSZDx3QXYJ7/kFla
 wKHb2LFRQ6XCaaV6vhQ9bvz+p+/BOI28B3qOdD+dbVZ3aR5JYqEYr4Xp9g/70JN/hKwhXEQxRIr
 ku7w4LZ5TeWX5ULdj7o5yqjUXDnZg/0vT7DPJUWuCO2Bn3f9xlKPVl6FIfd1EDM12OlbuEugsih
 il7uR2R8d/cfyFHwYW49uoCRgeroo9Y8/exuA6HEMzzFN0cmcp2jVxzoZPE7ub1adYzflPfBBRR
 BhZi5s7/zn78H1mjHbtv5QfumU/qJUq1ijnUQnrKHsbZRvfwTGbdTI4keMnrhhshjIeIs8aizpb
 lJpbFoMVb20dAb4oUL54+aWqPNSXsHVLLzO1n47igyt/ICOgwoqtodKPbYtxZMMXoYzUMz4uYyN
 hbjwFJhM7RBIBhkCCTUeu9Uiwruf4nHLZ2VjcLfF+V/mMisK7IRsW6Dw8/8F0h6r5SfwWE04DFi
 lDLWE2hydci+Z44BjisbRBJMWKdxFlVUEVGcGGuRL0F1YHBBrA==
X-Received: by 2002:a17:902:ce82:b0:2ed:69b:9e76 with SMTP id
 d9443c01a7336-2f03f1a1aaemr232395345ad.28.1795735040782; 
 Thu, 26 Nov 2026 15:17:20 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f1276c5sm114418555ad.67.2026.11.26.15.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:17:20 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] drm/i915/selftests: add missing newlines to SLPC errors
Date: Thu, 26 Nov 2026 17:17:18 -0600
Message-ID: <20261126231718.65690-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

Terminate SLPC selftest error messages with newline characters
to ensure they are properly formatted in the kernel log.

No functional changes.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/gpu/drm/i915/gt/selftest_slpc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
index c3c918248989..083e472b2338 100644
--- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
@@ -57,13 +57,13 @@ static int slpc_set_freq(struct intel_gt *gt, u32 freq)
 
 	err = slpc_set_max_freq(slpc, freq);
 	if (err) {
-		pr_err("Unable to update max freq");
+		pr_err("Unable to update max freq\n");
 		return err;
 	}
 
 	err = slpc_set_min_freq(slpc, freq);
 	if (err) {
-		pr_err("Unable to update min freq");
+		pr_err("Unable to update min freq\n");
 		return err;
 	}
 
@@ -76,19 +76,19 @@ static int slpc_restore_freq(struct intel_guc_slpc *slpc, u32 min, u32 max)
 
 	err = slpc_set_max_freq(slpc, max);
 	if (err) {
-		pr_err("Unable to restore max freq");
+		pr_err("Unable to restore max freq\n");
 		return err;
 	}
 
 	err = slpc_set_min_freq(slpc, min);
 	if (err) {
-		pr_err("Unable to restore min freq");
+		pr_err("Unable to restore min freq\n");
 		return err;
 	}
 
 	err = intel_guc_slpc_set_ignore_eff_freq(slpc, false);
 	if (err) {
-		pr_err("Unable to restore efficient freq");
+		pr_err("Unable to restore efficient freq\n");
 		return err;
 	}
 
@@ -313,7 +313,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 	 */
 	err = slpc_set_min_freq(slpc, slpc->min_freq);
 	if (err) {
-		pr_err("Unable to update min freq!");
+		pr_err("Unable to update min freq!\n");
 		return err;
 	}
 
@@ -322,7 +322,7 @@ static int run_test(struct intel_gt *gt, int test_type)
 	 */
 	err = intel_guc_slpc_set_ignore_eff_freq(slpc, true);
 	if (err) {
-		pr_err("Unable to turn off efficient freq!");
+		pr_err("Unable to turn off efficient freq!\n");
 		return err;
 	}
 
-- 
2.56.1

