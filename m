Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521A606A32A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKGxmDgm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBC410E75F;
	Sun,  8 Nov 2026 05:21:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EAD410E75F
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:21:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7AA326133B;
 Sun,  8 Nov 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794115308;
 b=fRX+VYuCHv/hBXPBznGyqMr2XmFW62uR63T/6Gg0DhSOYfIGPOucbmwWxjLs4hRXNBcZ
 mpjKhhwH6W8R9hNx8mmc8fLlK/9ykFqxvnwInOY6Ttfj6JB8bBI4334Qevjy5H9pnKRfV
 hR1Xv8NUg2D3ZfK1LiSCjZNJAsNA3TA+wZJYRiIHF1BxVEWfbMroQllgicqAe1+ulI+Xe
 C2/P+Ei74ayDswl0+jMnzlrOQYWpzex/ZrvBWU8ZqdtWTvtoVeGp3VJScHES0SpvVdgdn
 liYbIssnM1dALereC4XcYv00gx5mYnZlb0CD8lesT4UHio5tSTbG0/y0zufBl7R/6Fw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794115308;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=FEb8JHVtvimMLPLFAiZU0pzm5OR0krTrH2WFlIwv7os=;
 b=j17yisY3rzCJX1+7ib9bKElFZ9J3VsEVoAd05d4lLmHA6/iwYiqPYfavuDGuSv/dHkBH
 Qqgtv19ktISj28+4LjhuyWsRBpiqwy596wBX52h5dshmbk+lLP+aXARQJsR7ldaWDKN3q
 n9tMYRPscPbyKl7ZXkkWuWsQIXWqgwQrmzeysC3FBn/FDUeX/IWygL/ZU8+x/vYJkejZ+
 zwp5VYVCXL+aKHUkx00KGZM+8t8HO+Z4F3ieuAT/HRTSV8Ln+c8+L4Z2T/7zQMs4Xfmyh
 6cQ/8hDrixaoiVb2Eecf2DCyXILn0QwKOicMhGUy/kQQBX0EZiHEoAQktHyrdSxs2Zw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 429881F008A1;
 Sun,  8 Nov 2026 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794115308;
 bh=FEb8JHVtvimMLPLFAiZU0pzm5OR0krTrH2WFlIwv7os=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NKGxmDgmM24KQ4mg5HJ8UoQoldF9pqFNmSoBZq1HgiTT8hAkqjpsTbyZmNwY5o9M/
 6NZtn12LpwxtCkQ1f+vb6v3a3hdoIEShr9KwqMJxk2eG3FcD0vlgO7je7nY/AupqHH
 YfwkPnIe+RPUfcwybScp60KaZOUpGobNZbecCgkbQd7EN3xHFJ81eDROJrW9APdFt2
 t+btfWsZmHHuBHQtRXtb1NYDeNjVpi2+gb+6ukPRl4do5MK9+qcSFYiRy/7o59GrT1
 ZA5KTX0F6cUx14mWWsMaxK8tahmVyzAUUsWqSCr8VYEULn9cQpTdKS2EvLQGACo8rC
 4mRa/rWOSA3rQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A102947E16;
 Sun,  8 Nov 2026 05:21:46 +0000 (UTC)
From: DelaySystem via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Date: Sat, 07 Nov 2026 21:21:46 -0800
Subject: [PATCH RFC 1/2] gpu: host1x: add uninterruptible syncpoint wait
 variant
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-batch1-b1-host1x-wait-v1-1-8c8198adf600@tubot.lat>
References: <20261107-batch1-b1-host1x-wait-v1-0-8c8198adf600@tubot.lat>
In-Reply-To: <20261107-batch1-b1-host1x-wait-v1-0-8c8198adf600@tubot.lat>
To: mperttunen@nvidia.com, thierry.reding@kernel.org
Cc: DelaySystem <DelaySystem@tubot.lat>, dri-devel@lists.freedesktop.org, 
 luca.ceresoli@bootlin.com, gregkh@linuxfoundation.org, mchehab@kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 clamor95@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, 
 skomatineni@nvidia.com, linux-media@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4248;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=0A6QGb/AL7pj5kvHCFetL7bFYrncJD8MkYGrpSZhLV0=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDFkf2F4ZHJkuuW+B8QuxGyZJ9+Y4a591z9NRsrfIv9TD6
 bz5Y8imjlIWBjEOBlkxRRYxGZ739fd14qyt5pyAmcPKBDKEgYtTACYSXsXwP+D8P60Awb97bkVK
 SHBOmi/WXS3W89113sKp/ZO5Sn8Yv2P4Z2NtVFQTOEnSfq/lN72OuPWTcmc7JHnd7eVdW1raXBr
 ICwA=
X-Developer-Key: i=DelaySystem@tubot.lat; a=openpgp;
 fpr=161C0CEF7FDF2C5E3B3A9CC8E22333A79A058D4B
X-Endpoint-Received: by B4 Relay for DelaySystem@tubot.lat/default with
 auth_id=1447
X-Original-From: DelaySystem <DelaySystem@tubot.lat>
Content-Transfer-Encoding: 7bit
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
Reply-To: DelaySystem@tubot.lat
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: DelaySystem <DelaySystem@tubot.lat>

host1x_syncpt_wait() is unconditionally interruptible: any signal
aborts the wait with -ERESTARTSYS.  Kernel threads that wait on
syncpoints, such as the Tegra video capture threads, then need
retry loops to survive spurious wakeups.

Refactor the implementation into __host1x_syncpt_wait() with an
interruptible flag, keep host1x_syncpt_wait() behavior-identical for
its existing callers (including two DRM ioctls that must stay
interruptible), and add host1x_syncpt_wait_uninterruptible() for
in-kernel users that must not fail spuriously.  The wait stays
bounded by the caller's timeout in both cases.

Signed-off-by: DelaySystem <DelaySystem@tubot.lat>
---
 drivers/gpu/host1x/syncpt.c | 46 +++++++++++++++++++++++++++++++++++----------
 include/linux/host1x.h      |  2 ++
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index 5cc3cd46d321..393f50d3be33 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -215,15 +215,8 @@ int host1x_syncpt_incr(struct host1x_syncpt *sp)
 }
 EXPORT_SYMBOL(host1x_syncpt_incr);
 
-/**
- * host1x_syncpt_wait() - wait for a syncpoint to reach a given value
- * @sp: host1x syncpoint
- * @thresh: threshold
- * @timeout: maximum time to wait for the syncpoint to reach the given value
- * @value: return location for the syncpoint value
- */
-int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
-		       u32 *value)
+static int __host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh,
+				long timeout, u32 *value, bool intr)
 {
 	struct dma_fence *fence;
 	long wait_err;
@@ -246,7 +239,7 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 	if (IS_ERR(fence))
 		return PTR_ERR(fence);
 
-	wait_err = dma_fence_wait_timeout(fence, true, timeout);
+	wait_err = dma_fence_wait_timeout(fence, intr, timeout);
 	if (wait_err == 0)
 		host1x_fence_cancel(fence);
 	dma_fence_put(fence);
@@ -271,8 +264,41 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 		return 0;
 	}
 }
+
+/**
+ * host1x_syncpt_wait() - wait for a syncpoint to reach a given value
+ * @sp: host1x syncpoint
+ * @thresh: threshold
+ * @timeout: maximum time to wait for the syncpoint to reach the given value
+ * @value: return location for the syncpoint value
+ *
+ * The wait is interruptible: a signal aborts it with -ERESTARTSYS.
+ */
+int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
+		       u32 *value)
+{
+	return __host1x_syncpt_wait(sp, thresh, timeout, value, true);
+}
 EXPORT_SYMBOL(host1x_syncpt_wait);
 
+/**
+ * host1x_syncpt_wait_uninterruptible() - wait for a syncpoint, uninterruptibly
+ * @sp: host1x syncpoint
+ * @thresh: threshold
+ * @timeout: maximum time to wait for the syncpoint to reach the given value
+ * @value: return location for the syncpoint value
+ *
+ * Like host1x_syncpt_wait(), but signals do not abort the wait. For use by
+ * kernel threads that must not fail spuriously with -ERESTARTSYS, such as
+ * the Tegra video capture threads. The wait is still bounded by @timeout.
+ */
+int host1x_syncpt_wait_uninterruptible(struct host1x_syncpt *sp, u32 thresh,
+				       long timeout, u32 *value)
+{
+	return __host1x_syncpt_wait(sp, thresh, timeout, value, false);
+}
+EXPORT_SYMBOL(host1x_syncpt_wait_uninterruptible);
+
 /*
  * Returns true if syncpoint is expired, false if we may need to wait
  */
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e7ba601b2afb..40d4024ca04e 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -221,6 +221,8 @@ int host1x_syncpt_incr(struct host1x_syncpt *sp);
 u32 host1x_syncpt_incr_max(struct host1x_syncpt *sp, u32 incrs);
 int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 		       u32 *value);
+int host1x_syncpt_wait_uninterruptible(struct host1x_syncpt *sp, u32 thresh,
+				       long timeout, u32 *value);
 struct host1x_syncpt *host1x_syncpt_request(struct host1x_client *client,
 					    unsigned long flags);
 void host1x_syncpt_put(struct host1x_syncpt *sp);

-- 
2.34.1


