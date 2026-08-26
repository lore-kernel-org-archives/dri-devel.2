Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72EBC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FFB10EF61;
	Thu, 27 Aug 2026 09:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tMdfO2AW";
	dkim-atps=neutral
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D4410E241
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 04:46:19 +0000 (UTC)
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-38f25802c19so157607a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 21:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787719579; x=1788324379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Y7De7ARri1xphmS54uZC/QqgzV63JLdS9IYgu5HWyo=;
 b=tMdfO2AWRRwF+t7TKVwre7ii0e4xnVkLyrk2JI9SbclMYHxCATG+RpYU3X6uS1wtY7
 OKLjMBxHPDFpqV3wiMxRjo07nqQyjZ9neNxTvD7sdzk5Rc5a0IxsPyh1cJCr9VxoEZ/c
 UAeiuap/Yy/ERkrltuNP25o7w1a10xzclWKg0arsglruPLNu9VCXXJaeyfmOqu8NrAwQ
 RbJUEsuxtkwZQUXskvlk687gsAI5f5WyRm4y9q9QHfAPgCX/UbQmqDSVpTdvR0Ea8mY0
 GoYu670K/J+XPT0y6JO+BTlykouGMzMToSs9I1HP6fdSWwNhzFLu9PnTjIIcS6ppW7vV
 m2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787719579; x=1788324379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Y7De7ARri1xphmS54uZC/QqgzV63JLdS9IYgu5HWyo=;
 b=YLxYo1kEWlNbLC8QUvL//yL40mF+SgVFRzjkZpMfxE51c1TxjkzBEW8C0mKeChjGga
 v8n/QeEl9bmRjbt0shBRwRF5v/03kZwGbZSXDWffNdVFB5is7nFR5QCAtu0Af5DaYves
 fxTV7FdgP5wqspixTyXSaDaP8RcqXHkCcn2pFsNAJamqNZ/4acLs6L77k3os8XiQ6YwC
 HSRvenf/G709Rxw3rrU6pItT843jDwOHpCinKgiRQxKvKafa4m4o9afT4Ysu9iEO87BY
 P2i4EOudmLT//sTfzC//bSjQ+U6M/aUlv4w7WmmN0r/33yUBzsmLgvpSXtDn4smYp/sb
 dTuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOkPJbWq3yLQnpD4M/alews3C2Nup1TW7Fe5eD70ufaTkRzTc02Srf+2ZMYHnyKhqWeHeEPc9u2Jo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++no+Ibn1FoMPOFyX9eLjm4jDR8W+sZFyzZeEHvXuxjYOWBpA62B
 iG/EDCCGCGEa29A68eF0mqMAlKSTxfc6VArzMMSWLwP+QxrxGFnrl9/Q
X-Gm-Gg: AR+sD13z8Ofvf+wm1+V9Iq3TT5YUbisPkPKa3dkR1eGBMWPLEIUjxfS9DYZ6kJ40kD4
 uX9xCZVxIrPvLIj0H/FdK+AS++EARwxsHrBC5NGnLinCOMZUq34Q6h8NNiW21dSxmGRtpFmIHaG
 8/1duYjSp7JlXpA4baNBQRkBp0WrFULbEwCsanxLikgjgXz8kMMX3E9tx5p3bV3xlVFUg0A7963
 MR0Gr3noP9re68BUmYXTfZn+n/grzuKwPA+ypwD85Qa/HlirCDvIm+/Wf3g/bDJDrqAMXqiE8XE
 o0/raxLgXq5Pn6Xh4YDOKaEl30/AjssBnbesVexd8fjoW0WQuvP49a/+qArIb4IlNX0wl/K4UGu
 HVC35818Gm80vzl14FoOIu3LSXQSKpqh7XCMpXi0gFQbm9HfjLwl8YdXzgNDDHznc+GGeYtbh4M
 BxhW94KFoKqAFQRi6jXw8DQPoI0L74mDJ6VsKdhQQwrkfahUOhBWZc2t/ctEhncq3gWAaxjKhpc
 +qSS82Q9M0n0iksulgSLA==
X-Received: by 2002:a17:90b:5543:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-3966d13eb75mr9224027a91.3.1787719578654; 
 Tue, 25 Aug 2026 21:46:18 -0700 (PDT)
Received: from DESKTOP-BDFNLNM.localdomain ([27.63.245.244])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283fa89e8fsm5398718eec.8.2026.08.25.21.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 21:46:18 -0700 (PDT)
From: tarund18303@gmail.com
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tarun-tarun143 <tarund18303@gmail.com>
Subject: [PATCH] drm/i915/dp: remove redundant link state check
Date: Wed, 26 Aug 2026 04:45:33 +0000
Message-ID: <20260826044533.9292-1-tarund18303@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: tarun-tarun143 <tarund18303@gmail.com>

The DP link state is now checked and recovered after link training,
including after modesets. The same recovery path is also used from
the hotplug and HPD IRQ paths.

The link state check from intel_dp_detect() is therefore redundant.
Remove it and rely on the existing link recovery paths.

Signed-off-by: tarun-tarun143 <tarund18303@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 113d767e62e9..ffd39206b958 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6379,18 +6379,6 @@ intel_dp_detect(struct drm_connector *_connector,
 		status = connector_status_disconnected;
 		goto out_unset_edid;
 	}
-
-	/*
-	 * Some external monitors do not signal loss of link synchronization
-	 * with an IRQ_HPD, so force a link status check.
-	 *
-	 * TODO: this probably became redundant, so remove it: the link state
-	 * is rechecked/recovered now after modesets, where the loss of
-	 * synchronization tends to occur.
-	 */
-	if (!intel_dp_is_edp(intel_dp))
-		intel_dp_check_link_state(intel_dp);
-
 	/*
 	 * Clearing NACK and defer counts to get their exact values
 	 * while reading EDID which are required by Compliance tests
-- 
2.43.0

