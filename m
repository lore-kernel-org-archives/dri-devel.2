Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6B606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPWT20Gu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E331122EB;
	Thu, 29 Oct 2026 13:38:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD231122CC
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:37:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87AEC435D9;
 Thu, 29 Oct 2026 13:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3211B1F01825;
 Thu, 29 Oct 2026 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281020;
 bh=Ps5AXVGEkzhFdZfDreBUAkliDLIoFCykB99Kc4r+tnU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SPWT20GuXnP07sNiBsq4tRjfLR7XL6oQOUtA3wPDRkrh0WdhWS4kllqgLkejw94Na
 NG3CwEropcqzDrPDJ4UqHy8/XByQPC6+o4r0ic4AFtyh6xGkCR20Lyo1UqRpNqOZwI
 KZLRjs2pyyjbrUwY8Sxe03UQub7NtXedug/xnDT/zF9vwW4NLgjOX8/yLVcwe37oeB
 u09yI/4zzvjlGRHn336Yd4QMvYj9dS8xjsVaxZ+0WsHbtE536Dg7mZNBgoxNbLUlWw
 L4FZ42dtIeQ/2RSlZadoA60XLDApGlrbvdE80RgXvseOH6dCWxR5n9Jtz4YpL2Pi6E
 nvTRktXDBkBTw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:16 -0500
Subject: [PATCH v4 29/31] accel: ethosu: Ensure cmd stream is multiple of 4
 bytes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-29-4aa25e22578e@kernel.org>
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

The command-stream validator consumes 32-bit words, so reject empty or
unaligned streams at that boundary. This also prevents QSIZE from
receiving an unvalidated trailing byte.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 0b227664afc7..1935440fb815 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -965,6 +965,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 
 	if (!info)
 		return -ENOMEM;
+	if (!size || size & 3)
+		return -EINVAL;
 	info->cmd_size = size;
 
 	cmd_state_init(&st);

-- 
2.53.0

