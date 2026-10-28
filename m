Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E5606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVrCRFtP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6F611204E;
	Thu, 29 Oct 2026 07:59:11 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0251C10E105
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:26:55 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-536717a4d83so14284061cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793219214; x=1793824014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
 b=FVrCRFtP5Cvg8zhONA7RaLKnajol1nvJUKzlqjMD+o9OZI4/ZbQp9otJyQIBqgnsdI
 tLVyA6qAMueawiKpcw03mdXw77Vsxl1Arg3Qmv47yN4lezyrE4l245tHShuEvABCR29e
 D/uH8XxQtF81Wb4uLIo5WqCzxUv5T7EQVMGlBL0edbtzXOafMS+eBmfGLweQOXvPN8cG
 uoAW3WoZOMWku2yuehx+JA+NUqWI0G7Wui06kk9NDMsUWgKT7PjNkBeRTs143FeWPJX9
 1oVf8G7rw2RE6iNlf7tgi7qD+vd0oMD5Ae1P3yhnttAWtjlFdp+nltCetS6QDqJfXbQW
 QDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219214; x=1793824014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
 b=zxDYTy/Qei5OGSQLfQwUmDfrlRlecAiFHzYhABE0QEznd+a4gWIxGX3effSEAfueaW
 l7LU+cswjao0y6OLVDktgGj/t6VdIics2n2Wrgk/dR/csxdR2OOwcBlGXi7f0/jmuqdB
 h7v5p8DKWFh7lSzMF2PpELAQqrk4h/8Fr9hrhM2C9pu4XHPqxAQIlJiCsQg7pzG6AofE
 Vuoj6+n75dTMk6ipXFiOeeHVJ6cQ7JCfskRz5SCPNGW86zk3xPa881trQL3Jkm/vZjFA
 o0Oi0+VudLruIxKJgeNCsWXdeKxaoCWe4xqlVlml3kroq5koCb2Z8BCB/vprsiPH7jqC
 4UOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxjRJYbYtjuVy22AjskS4ZA6k2A54H46BoGzKoxbOcS64RSBZMYHmqpiEfudjUm/1Y67smvNUfyCk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKdlSTmHI7jSb879uNe+V3ZcsL9Rs1nnUWz8pA2xBmZBVGdK2Qi
 L4ZlTizBlPRlTb8MTtI2F88FPBlxvQnMSWl38E4uR0t7sXCtlZFSuPIX
X-Gm-Gg: AYBFou3M2pFRC8G3sGwO0wEU8FxJ7f1+61vpkBU8281OpIMr75qxYmTa2pNxj5jIg1W
 htd1gNh+43F3cUL8oysZBUzXoRm6+1z/OFD3fAKCJ7ostWRrj8j3AviShjmQkzcGl+9Ynck3Dw0
 CpypdX0QZW0npbOJ2RSyF08KFwpn+k2U7qhVCOkhkmDEnqkPliRa+ATXaqXOcRWnu8HfD7JC7jk
 mNhRd4/qS1hnyAxR2UQGX1sTeOb8PnJVdZ5+2V3De+PigFAuPhn5NU3J0d5M+1Fp5q1TdDSIZR5
 Lmjo2Ch2XF2L8WqWVtt6RLC1G3taL2MZH3mUswDy6ChvG6rdpoPsKpN6j2/G3b7/jqH972JMcZB
 DuizH+FZmCN99FDXcl7teL/bHBGlVL/Z1NKJCbWj+lEyfotXDybEEsZOL+qKPVvTMUI4L0LGnXt
 3LL+jYvC5X+UNUABtDcNrqANqo1+lZ6jV+JCYc3yLhJVkQkcRn7SOr4jw5JtOkUxaRDv8UXADUy
 E1RVJ0mxJ2opD8ksQL4YujdxC+QAJtC+iWK0CT/UhmdhmdDZ/qeF1T5xaFskyKC7AJpb2W8crZX
 jKUvFjzti+dLg0ill9p8pl+Lu0S9BjBbzvA=
X-Received: by 2002:a05:622a:90b:b0:535:cc6:659 with SMTP id
 d75a77b69052e-53fcb7fb52emr58748511cf.37.1793219213813; 
 Wed, 28 Oct 2026 13:26:53 -0700 (PDT)
Received: from falcon.baltimore.nuwat.tech ([2601:14d:5284:47e0::1262])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c8d5ee885sm10190956d6.41.2026.10.28.13.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:26:53 -0700 (PDT)
From: Abdulla Bubshait <darkstego@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, dominik.kaszewski@amd.com,
 dri-devel@lists.freedesktop.org, Abdulla Bubshait <darkstego@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Abort DPMS ON when enabling the link fails
Date: Wed, 28 Oct 2026 16:26:41 -0400
Message-ID: <20261028202641.549955-1-darkstego@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 843049bac7c0 ("drm/amd/display: Split DPMS ON into
parts"), link_set_dpms_on_enable_link() returns
DC_DPMS_FAILED_HANDSHAKE when enable_link() fails and the stream
enable has to be aborted: any failure other than link training, or a
link training failure on DP MST. The link has already been disabled at
that point. The step loop in link_set_dpms_on() treats
DC_DPMS_FAILED_HANDSHAKE like DC_DPMS_SUCCESS and goes on to
link_set_dpms_on_post_enable_link().

Before the split, this path returned right after disable_link(),
because MST displays can't proceed without link training. Now, for
failed MST handshakes MST slots are still allocated.  When the link
trains again later, the new payload starts after the leaked slots so
ACT never completes, and the display stays black until
reboot. Replugging or power-cycling the monitor does not recover it.

Seen on Navi 33 (DCN 3.2.1) with a DP 2.1 MST monitor (Odyssey Neo G9)
at UHBR10 x4 with DSC. Link training sometimes fails on DPMS
wake. With this change, the failed attempt leaves no payload behind,
and the next modeset after the sink reconnects bring the monito back
up.

Return early on DC_DPMS_FAILED_HANDSHAKE, as for
DC_DPMS_SKIPPED_HANDSHAKE. This restores the pre-split behaviour. Link
training failures on non-MST signals still return DC_DPMS_SUCCESS and
continue as before.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6047
Fixes: 843049bac7c0 ("drm/amd/display: Split DPMS ON into parts")
Cc: stable@vger.kernel.org # 7.3
Signed-off-by: Abdulla Bubshait <darkstego@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 75e232ebffe8..b355e29b178d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2813,11 +2813,11 @@ enum dc_status link_set_dpms_on(
 
 		switch (step_result) {
 		case DC_DPMS_SUCCESS:
-		case DC_DPMS_FAILED_HANDSHAKE:
 			// Enum is ordered from "best" to "worst" results
 			result = max(result, step_result);
 			break;
 
+		case DC_DPMS_FAILED_HANDSHAKE:
 		case DC_DPMS_SKIPPED_HANDSHAKE:
 			return step_result;
 
-- 
2.56.0

