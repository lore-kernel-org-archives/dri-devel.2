Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE360A2600
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6y6wpX8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31BD1122E7;
	Thu, 29 Oct 2026 13:37:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D3A1122C1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A229840DAD;
 Thu, 29 Oct 2026 13:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9AD1F031E3;
 Thu, 29 Oct 2026 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280981;
 bh=14Vm1MuZdODm8CbXSh0X1i4gRTiqjUX8wH9i415apec=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=n6y6wpX8Ua6yLzMo9Fv5wHGtcQEMXsqSNqSQoMKo8EbV7J5pqLLUCh5UdpLnq14yp
 VAvLVrmBXRMxv1z4z1OLizmXK1oC4yCOw47R5lTeMwnUUeHogkJNepxt+0dTmfSUzq
 lxHcPIrGKANCgd37LsRLFz9DJXPCsSFyDm3zO/BMrzquY1nAzFKKBkfPWIYuXgKeUO
 tMn2Qpo9n7GTc1IFF9dEzi765G+uvCiHHRWgIjVL7ewcyDzu7qR/9rwUA/m29XwDfP
 cydiY/d962QJLIASZwua9LRANSlUE0wVH6szLaYqwkwy3asp3CZaon67TjBC1QNwUv
 tiu6VxdssMnRA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:53 -0500
Subject: [PATCH v4 06/31] accel: ethosu: Fix runtime PM get error handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-6-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

pm_runtime_get_if_active() can return an error including for !CONFIG_PM.
Do not treat that as an active runtime-PM reference.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - new patch
---
 drivers/accel/ethosu/ethosu_perfmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
index 26f625374f9d..0ae2df3ceac8 100644
--- a/drivers/accel/ethosu/ethosu_perfmon.c
+++ b/drivers/accel/ethosu/ethosu_perfmon.c
@@ -71,7 +71,8 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
 
 	ncounters = perfmon->ncounters - 1;
 
-	if (!pm_runtime_get_if_active(ethosu->base.dev)) {
+	if (IS_ENABLED(CONFIG_PM) &&
+	    pm_runtime_get_if_active(ethosu->base.dev) <= 0) {
 		ethosu->perfmon_state.active = NULL;
 		return;
 	}

-- 
2.53.0

