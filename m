Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69D606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdoyXUWE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9689910E61A;
	Fri, 23 Oct 2026 10:02:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BDA10E61A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:02:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C981602BA;
 Fri, 23 Oct 2026 10:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156751F01828;
 Fri, 23 Oct 2026 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792749757;
 bh=ju9NrhjKwyqGjCfeoGNQvWm8BL5cBqSNVtogiWWf/Cs=;
 h=From:To:Cc:Subject:Date;
 b=RdoyXUWEfYR1PzfkVanoXIFYtMcEQ1VZXDUbjztJ/vrs4SaA42khRGBO4uqvxFBzs
 NhJ0kerRuI9mNTahCq5kBvmjt0Fv6DsU6KPHbDovLZ2aduxtDnln5VznAjIDAd86Bg
 A3ukEcjLIpH2+RSgzYMj0wlKtHXwCRQomeLQYwU0WoDh8OoHngd4iE4/QfimhokpcO
 +61/abTDt5Vc7EK/jm78+e/msCHJsqlMYPrmC8mG5IB//6P02lAGvNfveFifSMpmOI
 KfanhF+69NHyatdPQJdIRHZFenUIV+SnjJifwE5J5l5YPT3SMVsGoAY1T1aoG2/X/j
 l2rK+LYhBg+mw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] dma-buf/dma-fence: Document why signaled-bit is set early
Date: Fri, 23 Oct 2026 12:00:49 +0200
Message-ID: <20261023100047.2589846-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There have been repeated discussions about why the signaled-bit is set
before a fence is actually done signaling. Repeatedly, people try to
change that.

As long as the bit can be read locklessly, for example by
dma_fence_is_signaled(), the bit cannot be set at any other place.

Document that to reduce further noise about the topic.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
I thought that if people repeatedly try to make a change, and it
repeatedly gets rejected, then we can all save ourselves time and work
by quickly documenting it :-)

This way, we also remember in 5 years *why* something was or wasn't
done.

Philipp
---
 drivers/dma-buf/dma-fence.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..a71e18a9e346 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -359,6 +359,16 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	dma_fence_assert_held(fence);
 
+	/*
+	 * It would be better to set the bit after the callbacks ran so that the
+	 * fast-path-check in dma_fence_is_signaled() cannot return true while
+	 * they are running.
+	 *
+	 * That is, however, impossible because many parties now check for the
+	 * signaled-state of a fence in their callbacks (or in the work_items
+	 * kicked by them). So we have to keep setting it here as long as the
+	 * signaled-bit is read locklessly by anyone.
+	 */
 	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
 				      &fence->flags)))
 		return;

base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
-- 
2.56.0

