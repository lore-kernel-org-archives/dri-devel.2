Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F7F3380C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C8310E4F3;
	Tue, 17 Mar 2026 08:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aC4KBnJ2";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBB810E598
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:43:36 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-38a41026318so40525371fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773675815; x=1774280615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jR0mZwx1CUBh145iaxjHuZaYgzh6NU6OLeScv/p5yO8=;
 b=aC4KBnJ2xwe4SCwlTFOUBm98UqH19kI+QNq22/DslKBLQY3o5D9DPIqRhm/GfhjqN0
 gKL5pT9Srs4BCZbP9eyRB5YwvSAqAin1I8noLcWgVLcuZoL9NY51vqjxNghChRLkrMI+
 Cm2A9gb7IWmgaxh5uEZvBwESCf0kvCYjcckHbvVoYhRkAB2MsAbO1ILgyzdVj+56lXyx
 FejzLWZXZXyOhYnd8dWZ+HjU2V4uvhvmv1xNAII/nSCNTF42QYEiCAIDKoOUQNPe8dFx
 Nzl63TSM7iAOR9QVUzjDTOF/CVl2z2A+u5uFZr8ms+/gVrLL/ueWYY8TcYtKMvtWB+F/
 jSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675815; x=1774280615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jR0mZwx1CUBh145iaxjHuZaYgzh6NU6OLeScv/p5yO8=;
 b=Ugfy6OK3BwZu5kMmBq6rBN4T1h6WKQ2xyBa0pUF0RLHVrfC37xVygdRJVAxxbRsJMs
 74ptlrP5Hq4E8M/03u8YFhvQhospHdDtLNA/xBSlcpv0F16SNuyIU1fl//YEJlBO6u2a
 iLDiy6UAjNLC3Xcdk5EADaes/YnREb/xL0cvwFG7kmNryrycBkglqZJazjJfXUFRf/oW
 m//vVQdSNzkiC5FWWMZqtL/2Mwn+1vQOmAx+7jNi7msPR0zSnFmcyRebM3teFqKA3Zgn
 8axecAOGyC0IekoXJwYL8F0PQoi+aVYa1pl3RXEfK6yQefF6QDf0R+vIq/vcy/sUDlbI
 2uRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs5qzUGlThCP1clMJqzangOMJ/ckJYkelcwZZ2IqURx9N5wKkxdeyoeYhA6eiAWderDW2rZU5S/hg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyyx+ZqW+WdOyZSwoL+gVAP8JxU8AKM5VbIEPu3+o/lZQX/wNZh
 AJ/L/Brb7nO2ebRKd9JL0MlfS0X8mCK6z3Y9galI0aJnGgFfU4VYVb7O
X-Gm-Gg: ATEYQzzmkI4wlJRZXOAbjfKXu7d9JDJ/jpGCXfrkS9HKe4St4t4rfKNlP2Q8vMUPegb
 kTc7qrVWSX7jD0+93MsomeCRtfYXMnkqZMX4b2ioULinjd6BPdk8Djv04t+tdD4FIBsMOy5Ktsg
 BLKKiQfIzAg9S0VczH1YlxDxDpQLzX/rT2VjVpfUbiYdgLoFxvSYsBBrNumN7v+P2Kjj18ry1YY
 8N0uI0/CTkH6ijvvqR4bk4K4HKYU42dqvR3F45cscPJBXbEV7QLJ8klW+PIAK030My16dNhJyMx
 j9P5XijB4q7xJvEycVxK58XfrxJUn0t520BN9JrQxYxqPr91pj84ddXto+h4cUUndD8OFGxqv1R
 6w4/zoe8jUfbaMinMjaS7b4kqCpDejYNOJOZQ1ckUTbrSZfkTgoNd+SNKYyrPPd1xfjAFapr4zT
 fy5SFT56gr5H/5KJEirnf337yvBIkwzEupjxHYVQgwiVylbBpa3Gr6rYD9jKQd6aQQEz86UPtCJ
 fFeCwNspSoRw5THVc2I4C1Nex0vP5oFXX9Jwkg=
X-Received: by 2002:ac2:5b52:0:b0:5a1:2c43:79be with SMTP id
 2adb3069b0e04-5a162b32696mr3402250e87.39.1773675814241; 
 Mon, 16 Mar 2026 08:43:34 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it
 (host-82-51-8-214.retail.telecomitalia.it. [82.51.8.214])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636a96bsm3600435e87.79.2026.03.16.08.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:43:33 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com
Cc: alexander.deucher@amd.com, siqueira@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>
Subject: [PATCH] drm/amd/display: fix double 'the' typo in dcn4_calcs
Date: Mon, 16 Mar 2026 16:42:55 +0100
Message-ID: <20260316154255.18637-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Fix a redundant "the" in the prefetch schedule calculation comments.

Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ca5ac3c0d..15f19891c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5625,7 +5625,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 			// vs the latency based number
 
 			// prefetch_bw1: VM + 2*R0 + SW
-			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the the worst-case latency based time to fetch the data)
+			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the worst-case latency based time to fetch the data)
 			// here is to make sure equ bw wont be more agressive than the latency-based requirement.
 			// check vm time >= vm_trips
 			// check r0 time >= r0_trips
-- 
2.47.3

