Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFB60A2621
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NE/4JsED
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6928A10F6D8;
	Tue, 10 Nov 2026 13:15:51 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3C110F6D3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:15:35 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b596569640so3180210a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316534; x=1794921334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oh2e2vjuLv+CFo3ixnoCrqgK7d1srk0NoRqmzsamSCw=;
 b=NE/4JsED4gmlB0Mq2YMZq3ODu3elhX0GCEN1cLVL7HHElpwNfMYhiiGAgyaV5LosL0
 JxMJhFxgrxKeq9yu1n8YYWtSZCFs+f0PA8rOHjFgDClTBT9xJ1ZQc1AdmAf4qhjgOvig
 yb8gvVK2/FFWr0aiy73ULi2buPqMhAVpA+EiAcSmruvhoUses5vsyeUrBQZvPq3ikn9I
 sMQJLMIXsagyKnyXDbHpbCgcg8Unm+F2rgeex63mJLJoMbmbdSjiWD2oUZH7QUOOQofF
 5M3mvpggAb4K4Rkb4pFeoJuYYAC1SUk6MsUL/3xhiw109nY3IgYTHR0ru+V9TeIChk/n
 LopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316534; x=1794921334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oh2e2vjuLv+CFo3ixnoCrqgK7d1srk0NoRqmzsamSCw=;
 b=SBb2DLkLyG38fnG64I+RqjLGE2VelPuqJMGROtIF3oZ/qjgEMSyrBiZvGZu+WLWjT6
 J3RrPGUwweKmFVQYktHyd9MpW55isELMnH2t6KWTaZTavNcvmtR2A8htdKVRJm9gk1FJ
 VTr+V7JoKprGNTK62Ys0FchdBXdKExBD5NBMrXpHcDos7Tbm+KN2nn/UZGKX1ZJZnRiC
 w0VAUzS+3SsDIeskQ3UNzWsUPrxSui2tYYbm9DPWaYkZhsLo7z639KVz24MY7fwfhSjv
 xdjBnwQYEqc9jJ2qXd0rVyMLnqWDjduDUbhrnX1UAzWsh3KSJzGnJY8USFjatnQYNjTJ
 qH6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEyJn3uT88KYMI12X/Gw+pzBvanNN8u1FakU4qEhOSUaTaXwOpO227gR7Xz8H2dvw5tlQOp7UWqAok=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+NYpMqHLzSQVYZEKvfnzxC6bXzbvoPkDZz1EhkXnPTMM+gjCvd
 SsHBlFC8+3dl3Bhlh7O1AA/1IAarC4uBjwLkoaWkm64fIL09SUnqoSTF
X-Gm-Gg: AYBFou30yEoM0wHQ7cJZ3DMYxyrKqpKezbczgmlEo+3Yz1uAP6ex4aRjfQX9lnzeBGb
 u6HA4PeCohIZVckSUitKFnhRWLErvPURDY2pLTeGyBXIp8X99UzXzXyuE2xe1R6kgfdd25I2BMm
 jy5c4rskvjIP/Vsfb8QYsYWl/zYtb3Gw9omBy7Kqx2pqR3y2vJRphmZKxrnhWwARNFv9FynNPou
 ua0iU/tpfDT+R/Mnt3NsqEpMJTXZkgNlaA40AJW9ndmiSI4qMvpvBamkAzRccE2m8KMfpQPKFMy
 IW642YRkAvNRftbQw9tcQ/dkY4rdAOr0it0PQXzGuBdqrqKC5r81CX3neqyWu4HKo+zTu4DgXuy
 lrERD6//L/+ehmBXL2XluoGWJC8WJ4vhMGtrCacouyKCtDqSYTRXt2m2WWjTU04xMxpZ24eBNIi
 hY0u5lW55Lni+5IolagEX22xf/ulReo5je/iT7I+kve0BdWLzVPxmL0YsxR6esEisadtuL4yLnM
 YVFWQanPleCNvQmzlM270n+naO+9CgRnCxmAEgH7b+B9VVSXUFMYVm54xXMVbFU2N2uUc+5AWIv
 WJ6ezSU78y99geP6r0rRYjtDBRuTeKKB9ZCTqNYl71ZSlSWPYexKNAHKI+pR7/WTDakUg/taiDd
 K
X-Received: by 2002:aa7:c6d5:0:b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6b7571c10acmr1542857a12.3.1794316533631; 
 Tue, 10 Nov 2026 05:15:33 -0800 (PST)
Received: from desktop.home ([46.205.207.69]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790353asm1126372a12.31.2026.11.10.05.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:15:33 -0800 (PST)
From: =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>,
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: Wait up to 1 s for slow sinks in FRL
 link training
Date: Tue, 10 Nov 2026 14:09:55 +0100
Message-ID: <20261110130956.160024-3-andrzej.piatyszek@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LTS:3 gives the sink 220 ms (320 ms at 16 Gbps and above) to answer an
LTP request before the driver gives up on the rate. A Samsung QE65Q80T
(2020) sometimes answers at 10 Gbps x 4 only after 225 to 967 ms, so
link verification falls back to 6 Gbps x 3.

Wait up to 1 s at every rate. Sinks that answer within the old limit
are unaffected; a sink that never answers costs up to 1 s per rate in
the polling loop instead of 220 ms.

Fixes: cbb8e2044b9e ("drm/amd/display: Add DC link support for FRL")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Andrzej Piątyszek <andrzej.piatyszek@gmail.com>
---
 .../drm/amd/display/dc/link/protocols/link_hdmi_frl.c    | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 78e62bfec..97b2b9b74 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -612,10 +612,13 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 		FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
 		/*LTS:3: Start Link Training*/
-		/*Start FLT Timer = 200 ms, or 300ms if link rate >= 16Gbps*/
+		/*
+		 * Start FLT Timer. Some sinks need longer than the nominal 200 ms
+		 * (300 ms at 16 Gbps and above) to answer an LTP request, so wait
+		 * up to 1 s before giving up on this rate.
+		 */
 		num_polls = 0;
-		if (link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_16GBPS)
-			poll_timeout_ns = 320 * 1000 * 1000;
+		poll_timeout_ns = 1000 * 1000 * 1000;
 
 		flt_poll_start = dm_get_timestamp(ddc_service->ctx);
 		uint8_t prev_flt_update = 0;
-- 
2.56.0

