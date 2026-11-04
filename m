Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC52606EE8B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkT1Vx+C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E3C10FDE5;
	Wed,  4 Nov 2026 18:40:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB7210FDE5
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:40:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9658642E3B;
 Wed,  4 Nov 2026 18:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D21F0093A;
 Wed,  4 Nov 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793817616;
 bh=0ahLYAFU+clP2QENSRM7LilInaXH9CwvLAvnJgnkbwA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SkT1Vx+Cp6MB03+7BN8eBEoe0Ft40UTU6swhn0LECT8KdLw3rlG+i/+PSrLrOYKbn
 GmP6Wc0XMlHAkgXuTCql01ROTGIEdS2u7QV26B6yklRZn1wNn1Q+RvqPj5Q/YXjF9n
 Z0K4WwHnJosYGsBsioGBc9aTvaflmGHDkcsldz/WE9QNE0N6jOlOwICbb5zBo0kZ5I
 zXnd0tGJYgfqf4iI5WNarx5MThiJdeYIaETfMcC/RgtFlhQ2LF+/mBHw9FamRn4I7G
 IMBCbOXls7tiWh2hhBskNhOaJFOFoabylwJB4nuvhzlMM/wJ66RTSV5m1Ngpf9ZYhP
 9UMvclpxXE9rw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 5/6] backlight: qcom-wled: Check for auto-detection callback
 in wled_ovp_irq_handler()
Date: Wed,  4 Nov 2026 18:39:06 +0000
Message-ID: <20261104183935.1214630-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104183935.1214630-1-lee@kernel.org>
References: <20261104183935.1214630-1-lee@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wled_auto_detection_required callback is only populated for WLED4
and WLED5 hardware, remaining NULL on WLED3 (where automatic string
detection is not supported).

However, wled_configure_ovp_irq() still registers wled_ovp_irq_handler()
on WLED3 when an "ovp" interrupt is present in the Device Tree.  If an
OVP fault interrupt fires on WLED3, wled_ovp_irq_handler()
unconditionally invokes wled->wled_auto_detection_required(), causing a
NULL pointer dereference.

Verify that wled->wled_auto_detection_required is non-NULL before
invoking it in wled_ovp_irq_handler().

Fixes: f16899a6a7d4 ("backlight: qcom-wled: Add callback functions")
Closes: https://sashiko.dev/#/bug/linux-d3eba287-2af9-43fb-851f-78ab3df0f35b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

 drivers/video/backlight/qcom-wled.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 8d4d7fe5e84d..06300d403f8f 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -917,7 +917,8 @@ static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
 			int_sts, fault_sts);
 
 	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
-		if (wled->wled_auto_detection_required(wled)) {
+		if (wled->wled_auto_detection_required &&
+		    wled->wled_auto_detection_required(wled)) {
 			mutex_lock(&wled->lock);
 			wled_auto_string_detection(wled);
 			mutex_unlock(&wled->lock);
-- 
2.56.0.385.gac671c819a-goog

