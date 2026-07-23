Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63603C531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3C910F116;
	Thu, 23 Jul 2026 13:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="JU5vL2Fi";
	dkim-atps=neutral
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 08:26:18 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC1010E2FD
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1784795142;
 bh=zyZoSgcSvPZa4Lztf92xnmwggXjnsZ8IVuTRvt3SQnI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=JU5vL2Fi6InlRISIhDGfiI7RNJvk+wlIbfU0JuMWvg59ruRvP6LSyA1lNskCXZHEp
 W5Uhjks1SLKDG6h1GJB8PU17Frg0KaVafr29wJ44nX84Sa8JO8oXqR/FtVHrpeHB1E
 GGbDV0DC8WlKhz7Iu85JLVElln+2T8Oel/P9WOps=
X-QQ-mid: zesmtpip2t1784794708t1baceda8
X-QQ-Originating-IP: p0+WvO88PZWVCksv0PxY0bE07sYlxrtU4deG1JLaxR0=
Received: from localhost.localdomain ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Jul 2026 16:18:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8067794102828428792
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org,
 akpm@linux-foundation.org, ynorov@nvidia.com, namcao@linutronix.de,
 mkchauras@gmail.com, sshegde@linux.ibm.com, nilay@linux.ibm.com,
 kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: [PATCH 2/4] drm: remove dead WARN_ON NULL check after GFP_NOFAIL
 allocation
Date: Thu, 23 Jul 2026 16:18:11 +0800
Message-Id: <20260723081813.176792-3-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260723081813.176792-1-gouhao@uniontech.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: OZZSS56D9fAjckDqlfzJlu9LL6jBKKnBs3gN4vl4RgIFRz2rr4g8u2r/
 5oDA1kxi4D8m7gKqcKBytHZ37/d8kwxMNxytFpufJvo+1PoNJ2yCo9XGLog2QHCoZti7Cq1
 rTMvmRVNkwt1AFI5oZFmHCgnjf6m8vXKDWhIsjNMZ4THr/WZCvyubhK7V2yE2gqnBrUgNlT
 A8xpfIptvF/+QqPZheqkaPB7jDeTEai5zIxc/7O4LRdTu3qneA68tVNsjEcujdRXxZY7pM4
 T1/XjdgWKo8D95AZNJRxRRtc9IO0FFEVnOFAFJFcDlAh+V3vN/DCZA4wUmcYv3VrY3jrKAO
 88WVuBtRJtMfw2yIqF5WAd5hgS44ov50EVRAd5UqmQAwHDgwORRuDiSY8KLTJO5JkgU3zaV
 MvjF1GsPH5xzkoXO5e085ynR17nlBKBK5TbZDkm3qQc4mgi2uq4uHGVcxCE5fVOUApbf2F8
 fyEt1Y28wVIm44VveTYi7cvtwcGhX4PpZHYyHyyQ+7RtqwXMAOuS8jC2eLBoTXkxMTLiJkP
 0WaL6Hncyu/HHCPyxQoCiP9xgvhtCznehDios/nZV78b+Yeh4IVvA27OKlbhZ73PVaiuoBH
 sHOkDXp3Oh/xksbsWxJSsMFhUknNFvFkV8JqFIRHRV5tIVTVGapobfwc5Ck5Fqcupv4TopU
 DouW0oD02RaPDMhDNINyT7hUtmdQ0Qyp54o6kwaL01D6dW3rMkZpYBXAUvHEA4pBDeDigDb
 2EuQKWkiSkABXumCUexXAKqGA/chEtMcVio01Z2XT3lENWDz1zsTaiin4d9nY79gp0JTuBU
 alUC6kMwwcgF3O2AFlzlEWrbpTadhv0DNYmRGokf6fuv5NXra1KDvH6CFA3FgRkdqiKyb2a
 hYVeXKPMLUZTlEtqVvmxgBNQRepTc0mJJwAeyboK8eLn7/+SmXnSM4ZvvbThgNs4XcHd/Bi
 eiM+zPXJq5HgaAeofIGJ8WX6CZI7WIlgnlwaXYHIBlTiCJxNnRn17rZAV5lGwxOboazVfn1
 IwQr9vBNH8WooN6fdVNH5+HGpWmnzHJEkPgPrtVUN5qwimQtbvvfYhQZ12BQZJEpiacjbDN
 w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:28:03 +0000
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

kzalloc_obj with the __GFP_NOFAIL flag will never return NULL, so the
subsequent WARN_ON(!ctx) is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 2c806b0146d6..e14814c30d8c 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -149,11 +149,7 @@ void drm_modeset_lock_all(struct drm_device *dev)
 	int ret;
 
 	ctx = kzalloc_obj(*ctx, GFP_KERNEL | __GFP_NOFAIL);
-	if (WARN_ON(!ctx))
-		return;
-
 	mutex_lock(&config->mutex);
-
 	drm_modeset_acquire_init(ctx, 0);
 
 retry:
-- 
2.20.1

