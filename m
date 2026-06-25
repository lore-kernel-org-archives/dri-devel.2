Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFCCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFC510F46C;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CpO89/+q";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D204510F2CD
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:12:44 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so381125b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782396764; x=1783001564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1agOcM108mYien5bPYKqYcmwOSbFBw2SAS45aRrQL3c=;
 b=CpO89/+q37Aa+urU+B/w0QXuxVyPrWSzAFBYk1rI7khCzMVzdP7u9dSBFKfLLbkr1R
 8f/tQD2LUysKKMa9edjzKTrmueLeQ/XSlNKf/FqUbbpsVLLJz7BkS7tgD0M/8488FIn8
 yUGnPE53l9MC5CDdxTW0j/3rnVbxR1xy9TVyX0KFVxTr3Hhtcg1ccQTrpu32jB8ZUldg
 J7B7rFVNhUbZPH2kxSm8ryxlcU1WBHGbXxIjanh2Z0S6oXe8rFDfG9LZneMj77YZDc0Z
 t5pxXXFXXkubYtEjcsexug4GuTXM2VBzOAJwlEfJX70E0wFa5tbFD4f/FHRohHQeKGIx
 Sc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782396764; x=1783001564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1agOcM108mYien5bPYKqYcmwOSbFBw2SAS45aRrQL3c=;
 b=am01q1Mg3FRoBZOpzEJzAjCP6V+WmoY0SyGT4JXyKqNTRFqgPLQcgL45oNbx/i6D0A
 wXgAGqV3el5DexH6Gm7T7gcspx2XgmLLqP7bLe5KaaEgVAMY6QxNu57mQiH4hXh00oCy
 EoeCIwDET/yQMHifgYeHgTd2gwdgJzGR29LDNvmIfRcvTtxQNXpokrX3C5zRSa3crSvw
 NV3/rH1zKCOAByMOrbgssYyRnPvlRHt891LrF6r9TFykCtntpkzLwdSmjX5y/gCU5T+s
 UwP5w6PYMuEkyAVuZERUAKX3PenVJMNYQQhV+HaTgFAoSJ3HQCzJcj15q8gWjs+1Q9HK
 eokw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SWWR9vAqno5Nt3JcIE1zbYVmkyTAUCW3iBWugxIqy+2cBhx9ghevFI/waXxM3jMBLzXBW+CWOOmk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJvkVV3Gy1LQOrSHRMlb2SY4UrQxsl6UEssJ5mL/5YmpMj2Hma
 a+zcO2Pmez45Ua1KcJWgGPZkNotqU5h/K4z/8LPrGtCDu++i3x2HoMNx
X-Gm-Gg: AfdE7cm6HMlSG/CUYInlCWO8EuKlnJt7xAzdt0C7v78AZtRsWx3xce/znE6DhDgdeEh
 R1Gk1spANMBVsxGMw2Sh9Ptofj1OjGqhapsspwX0eDvEHJdLpNpDZ9GAa1a4AvDauAWKLfYnegE
 5EzvcUoIXbYwdHonvorQtC+qbC09tliCq+iRDQiXpIMwOb+RPxMYQMcAJmxJzU04EDq5tggCO1U
 Isc/p2bYFn7zeusE6T0N8dvB+o5eEYz5OzDxJXho+jtBvizwXucq9ou+OCszd9wGEaAEFoXe1Mu
 2hE6f7pNi3ySHNgWQRckQ5/FPwnDg+aJXRSypnXkYZYsexCm/JfH9UfHs/Hb1eNBNlgR/aWs6GK
 PbqP2gpPh38HLdyM9lChoVm3qAsCmTmTIIafbVeMqc4I0Fbb0+76Y/cWmr74MVOVBOD6WLXQpnV
 vNNJuUd8t0uLGll4WA02I1YxiP7jlf
X-Received: by 2002:a05:6a00:10c7:b0:83f:250d:5a5 with SMTP id
 d2e1a72fcca58-845b44eb213mr2676677b3a.16.1782396764267; 
 Thu, 25 Jun 2026 07:12:44 -0700 (PDT)
Received: from localhost.localdomain ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40d23d7sm4838015b3a.30.2026.06.25.07.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:12:43 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner <phasta@kernel.org>,
 Akash Goel <akash.goel@arm.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH] dma-fence: Fix dma_fence_timeline_name() to call
 get_timeline_name()
Date: Thu, 25 Jun 2026 22:12:27 +0800
Message-Id: <20260625141227.38931-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

dma_fence_timeline_name() incorrectly invokes ops->get_driver_name()
instead of ops->get_timeline_name(), so every caller receives the
driver name where the timeline name was expected.

This is a copy-paste regression that has resurfaced twice. It was
originally introduced by commit 62918542b7bf ("dma-fence: Fix sparse
warnings due __rcu annotations") when adding the __rcu casts, fixed
by commit 033559473dd3 ("dma-fence: Fix safe access wrapper to call
timeline name method"), and then accidentally reintroduced by commit
e58b4dea9054 ("dma-buf/dma-fence: Add dma_fence_test_signaled_flag()")
when both wrappers were refactored to use the new helper.

Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index b3bfa6943a8e..5292d714419b 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)ops->get_driver_name(fence);
+		return (const char __rcu *)ops->get_timeline_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";
 }
-- 
2.34.1

