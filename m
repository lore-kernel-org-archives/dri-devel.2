Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB1606A6EF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CzRvPwca
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5522810E187;
	Fri, 20 Nov 2026 19:25:09 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E37010E25B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:25:03 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-383ec96a7deso1381415eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795202702; x=1795807502;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GM6kjUvXbDa10d4WZljkBFVBHg4IBJ7Pu0WqJwPjtL0=;
 b=CzRvPwcaQGt3XO3hzx0Y7/qVSeoDO4PYC3IHkJfLtfs6U1gcGNcbJF7Nm/fRhYU+ah
 pcg/iaaLGMOAg4B2R57C0IM7hPT0Qdnk3xXmwAPDn5B37o92+eUbFhkbCNdfma1hvkTj
 JxgN1aG2EvkKim9Jt5JEI7LzotLiHj+TT2gd374S5S77BBq4HfrYTOEZgi/CS1RngBWS
 zKNwq36qgzZos8NWvelLeQyhaSA73YvpCQebFNuhT+psC0MrUIXBft9yQeUCjs8fKxEk
 dL3ej+T4u9/LBRFDB8Sv0WBx44UMONMwW8wC0i/E2GSns9df4KNuGDNzL+F5kBRy8O2l
 TLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202702; x=1795807502;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GM6kjUvXbDa10d4WZljkBFVBHg4IBJ7Pu0WqJwPjtL0=;
 b=weJuygtUK8q/+3K/VDycNJDR6fN/x/CWc3cjIdAREtnEm6Y+FEjv58yiuCKDBH3ML+
 0vHGRjTgyL4ZPfw2N5pSuvjtgAZJ4TOIs3VUYEpde/6u1RonIOx5HaZ9aWsdAzFpj44D
 E/yWT/bkcCK7HinQ3ds7O4Qyq6M7Lla4Rg3Jz7VWCxGfdkg7OCXHXXC1IaJvGEmixhyQ
 +mALtcN/nE5crYJXLPwvmK/cpY9OmE8pDqeL9793Ic9bLLNAQdJ0Sl2Dk9tXnupNvdJe
 +CR0a00SmTYMRuqS9Ir1We0+t8gJ1O0k7wxT2C0ouAMPnM0I4kahmDZJSER1GVwnQT72
 4xwA==
X-Forwarded-Encrypted: i=1;
 AL+hErFOQT6/KUKvOHg5xNeUoIJAwHYxELN/bYWY8aLBrAJCgfEIoJ+eEw+ELYZnMigfbCRNcqmZcu7YilI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8yHzLIX4SUsstfcZn05dSmPFXwfyCgmenOsPUVXWzieRX1fgg/
 IjO0thWtvhWZesH+slkZv+jC+lMxRZ7k0mAOcflRbvL4aL1USJlFx6I0mtasZvcio2EExEJddgs
 FPw==
X-Received: from dlx4.prod.google.com ([2002:a05:7022:84:b0:1b2:63d2:5906])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2608:b0:15b:afce:62c2
 with SMTP id a92af1059eb24-1b55691337bmr3351862c88.41.1795202701742; Fri, 20
 Nov 2026 11:25:01 -0800 (PST)
Date: Fri, 20 Nov 2026 19:24:46 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120192446.2874087-1-elkin@google.com>
Subject: [PATCH] drm/msm/a6xx: fix error unwind in a6xx_gmu_wrapper_init()
From: Elkin Cruz <elkin@google.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

a6xx_gmu_wrapper_init() has three error-unwind bugs when initialization
fails before gmu->initialized = true:
1) When a6xx_gmu_get_mmio() returns an ERR_PTR, goto err_mmio passes
the error pointer directly to iounmap(gmu->mmio). Jump to err_clk
instead.
2) When dev_pm_domain_attach_by_name(gmu->dev, "gx") returns an ERR_PTR
(such as -EPROBE_DEFER), goto err_mmio skips detach_cxpd, leaking the
attached gmu->cxpd domain and its runtime PM device link. Jump to
detach_cxpd instead.
3) err_clk: drops the gmu->dev reference without calling
pm_runtime_disable(gmu->dev) to balance pm_runtime_enable(gmu->dev),
causing an unbalanced pm_runtime_enable() warning on the surviving
GMU platform device across -EPROBE_DEFER retries. Call
pm_runtime_disable(gmu->dev) at err_clk: before put_device(gmu->dev).

Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
Fixes: 15cc59ac954e ("drm/msm/a6xx: Add support for Adreno 612")
Signed-off-by: Elkin Cruz <elkin@google.com>
---
I am trying out a new Clang static analysis linter for ERR_PTR/NULL
handling, and it flagged this code as possibly buggy. The findings were triaged
and fixed with an AI coding assistant, then checked against linux-next (not
runtime-tested on hardware).

Thanks,
Elkin

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index a1561ca41a5b..7f6932d7200a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2290,7 +2290,7 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	gmu->mmio = a6xx_gmu_get_mmio(pdev, &start);
 	if (IS_ERR(gmu->mmio)) {
 		ret = PTR_ERR(gmu->mmio);
-		goto err_mmio;
+		goto err_clk;
 	}
 
 	res = platform_get_resource_byname(gpu->pdev, IORESOURCE_MEM, "kgsl_3d0_reg_memory");
@@ -2321,7 +2321,7 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	gmu->gxpd = dev_pm_domain_attach_by_name(gmu->dev, "gx");
 	if (IS_ERR(gmu->gxpd)) {
 		ret = PTR_ERR(gmu->gxpd);
-		goto err_mmio;
+		goto detach_cxpd;
 	}
 
 	gmu->initialized = true;
@@ -2335,6 +2335,7 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	iounmap(gmu->mmio);
 
 err_clk:
+	pm_runtime_disable(gmu->dev);
 	/* Drop reference taken in of_find_device_by_node */
 	put_device(gmu->dev);
 
-- 
2.56.1.750.gf70dc682cf-goog

