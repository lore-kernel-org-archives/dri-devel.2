Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F92606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=B2N7s7+E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C750610E348;
	Thu, 29 Oct 2026 21:57:54 +0000 (UTC)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E7C10E348
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:57:48 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so29537a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311068; x=1793915868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P2A9YuqVRwZG5vPvb90/8FnAEKZY4a8UvPrcVp6QTk8=;
 b=nFzS7bYiq5fZGJQFJndlVtDVPIfJGncZqF9ig8aYMCuxfjGLyiLUTAg6lDn/wqMKTq
 5WGtUYiyz9XeB82HPyeZrNR3Xfta4xSGak04qAfjulYSguqZhUh9HKWtZHT3shXr90MQ
 casMlJBJ+CsHVR1K77Ow0n62PRhz8zKVH89xTj26Dk4jwdbDkeQpR7NgqvNGI6NmWzrv
 9whh5ym9jY8tsZEXLJSC1c8rl81+yjM0A54MRfuf10cM274jWSG1TFAg82VHghnw7v2A
 Qrfvet7KeU4oDzrwDAJPxNReOA95C/zX+RR8u3kwSoHdU5b6D9LTtfHDBrjafFspW/DL
 ZZiw==
X-Gm-Message-State: AFq9FYJLocn9AxjDNx6uQrjtKkRvnY7al8Ei8a8Knbb3zFhmmTBI2l1O
 a9O9AaBaFOVAShL/1/8f4s5ai1wmG+ggcOsGmlO0SEWHtQDxFW/QnMUqJ9h62eV64ptmLtnk4aZ
 rhGXQqHYXaM98G6aTj51TQBpKcWF3L1WlhaKvQ0JMHP6hvdyliqRSIKHtwoO6n/7QL93lxqH/4J
 KZIUO5655bq2tUDSz4UxFmD42Qb69LkDvXm168pegt7CJ3s/SN/0Yew3BuJZaovUd/LE/jTsxj5
 Zmuh56Rczm2/lFvcyf2
X-Gm-Gg: AYBFou31lXKni+vjcpxrkwMzOAL4v6iGtzmbyuY6LPSJ5E+Wtmh5gpkcVRipBY6a5Ql
 cP/haNRytu6gqY+BJIg/g/Nmve4QLWvZhARnWfPIW1Vwd69ZOIf6LxheZRfHYWJWOxFkBxevLhP
 xK1/9Yr4Tuyn9eaBiJP9ksYVytKg+q5pDy1rG3UTvCelVsJ01mnH1F6FmxKqLcgS1R2/lOZF12z
 EfdZADbaltsaM+M+WrCF7Z5eENc5B5obACPo0sf7b3MhWBlRREckVwoTL/+cCHNzzdeoFuQPGh6
 J0acakNTGx/g1aDy1aPWQoGdc+anrxECQrd9/8VJ0cTt+P7bUkvhCGnwf8kZ9c+A6j03BKB1LN6
 qSt81dP2ZW+Gw+3LvioIIiWF6FUd5FKIpJr0Kg8FQDmK4cW9BQ+SItOFCcuSx7IyJZ5Qkc7L1z+
 ld2I7cYSLcJT18oC5OSBEWzrIKT7D95pnk
X-Received: by 2002:a17:90b:2d90:b0:3ac:9e76:aa9b with SMTP id
 98e67ed59e1d1-3ae8957cca9mr204820a91.7.1793311067922; 
 Thu, 29 Oct 2026 14:57:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae845baad9sm655023a91.5.2026.10.29.14.57.47
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 14:57:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14373747468so37423c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793311066; x=1793915866;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P2A9YuqVRwZG5vPvb90/8FnAEKZY4a8UvPrcVp6QTk8=;
 b=B2N7s7+EXPgJMZbS9ogSJyjLm5gbOpK/9FEjmebdSS665zlx0uAgQJil6gu+o7EqQG
 ykk1SwVfKn9IHnZ1Vm+kehdsYdNwRqGvvmuFz+TkNtXbiaV2DNiPIB6N9tyiDWY8foZW
 S5eJIaPrpoUCzYLjJoy5QsFj+k/3sfAZsdbJ0=
X-Received: by 2002:a05:701b:4186:10b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-1ac4f91ee96mr587374c88.0.1793311066173; 
 Thu, 29 Oct 2026 14:57:46 -0700 (PDT)
X-Received: by 2002:a05:701b:4186:10b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-1ac4f91ee96mr587316c88.0.1793311065272; 
 Thu, 29 Oct 2026 14:57:45 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a136537sm1341988c88.18.2026.10.29.14.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:57:44 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, Zack Rusin <zack.rusin@broadcom.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/vmwgfx: avoid underflow when stripping short
 GuestInfo replies
Date: Thu, 29 Oct 2026 17:57:37 -0400
Message-ID: <20261029215738.3010276-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_host_get_guestinfo subtracts the two-byte reply prefix using
max(reply_len - 2, (size_t)0). Since reply_len is unsigned, a one-byte
reply wraps to SIZE_MAX instead of being clamped to zero. The subsequent
copy can read past the host reply allocation.

Theoretically malformed host reply can reach this path when the driver
queries the GuestInfo parameter used to enable VKMS.

Check the reply length before subtracting the prefix so short replies
produce an empty payload and cannot cause an out-of-bounds read.

Sashiko reported this while reviewing the i386 hypercall changes.

Fixes: 89da76fde68d ("drm/vmwgfx: Add VMWare host messaging capability")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin%40broadcom.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..49e04a50c6ed 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -431,7 +431,7 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
 		/* Remove reply code, which are the first 2 characters of
 		 * the reply
 		 */
-		reply_len = max(reply_len - 2, (size_t) 0);
+		reply_len = reply_len > 2 ? reply_len - 2 : 0;
 		reply_len = min(reply_len, *length);
 
 		if (reply_len > 0)
-- 
2.53.0

