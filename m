Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B50606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BTBY2ZI5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F68010F77A;
	Tue, 17 Nov 2026 14:20:04 +0000 (UTC)
Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284DF10F77A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:19:56 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=jpoUrqEhZGtO1voo/V91CLK+zaKFJAgHFOTKKalt7GE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794925195; v=1; x=1795529995;
 b=BTBY2ZI5MqtapREnrmOO9d5EU3PgXaLjvspbG3UiNjxfZ2cV2lq2qA4gofBpodRIvWh4sjpl
 8ECTZtpZULbyIrBnRMBpyg3/wQR2apPv4kPwGmzXOVC6Py8NGvj2HpWGRcvHyTn2jvNl1P8wlz8
 oV4tUlgDr6sU9Qqkpd97AyqE=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 2adbb1d648220a4f;
 Tue, 17 Nov 2026 14:19:55 +0000
X-Mizu-Trace-ID: 2adbb1d648220a4f
X-Migadu-Flow: FLOW_OUT
From: Ruben Wauters <ruben.wauters@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <ruben.wauters@linux.dev>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gud: fix potential divide error due to optimisation
Date: Tue, 17 Nov 2026 14:17:51 +0000
Message-ID: <20261117141943.10540-1-ruben.wauters@linux.dev>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Compilers can potentially optmise the read of gdrm->stats_actual_length
to two separate reads. As flagged by sashiko, when the rect is flushed
the stats_actual_length can reset to zero. If this was to occur between
the two reads, the divide error can still be triggered (albeit rarely).

Fix this by adding a READ_ONCE around the gdrm->stats_actual_length

Fixes: 431c2dffd2b7 ("drm/gud: avoid divide error in gud_stats_debugfs")
Signed-off-by: Ruben Wauters <ruben.wauters@linux.dev>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index cec5d64e152b..4854b30ea5ba 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -329,7 +329,7 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 	seq_puts(m, "\n");
 
 	if (gdrm->compression) {
-		u64 actual_length = gdrm->stats_actual_length;
+		u64 actual_length = READ_ONCE(gdrm->stats_actual_length);
 		u64 remainder;
 		u64 ratio, ratio_frac;
 
-- 
2.56.1

