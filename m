Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06750CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 09:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4847D10E277;
	Wed, 27 May 2026 09:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUmAx508";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSycKJrK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384F510E23E
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:19 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mWmK4108478
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QuK3qwfNGYC
 uijsueLPi62zx8F1qyS/qihM/m1iNSKc=; b=YUmAx508oiQE58Wr96jUIzTLnif
 5DY90takuH4pF+50pErLzIvwpTW9rtHI8BK7MpA+xuB1fiKXuCRV7TfOWLrwDBNZ
 YU/JzuWwnJ+KgRuGx2/7pfToccnUTNht98RuD3tpXqBWkpimAYAS7VLIWAqDm3JN
 n9xRNy1vbV5guErXJbziZiwh5Ss+PutRfYN2b045cE6oJJ/NQGCO+YXGwOgKYadL
 SY9m8s0qUwUmME59emjKcyIwWG2H6bkq8ePwYmaXDIVm7/XeM51b/wXWKjnDTfmi
 bXBoalBJm/UYVDaW7wo3BOQD6qnwmQWmBrLWRJT7BTXbKrTIdN9/9QTZlhA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edefukkr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d4a9e852so87438761cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779875298; x=1780480098;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuK3qwfNGYCuijsueLPi62zx8F1qyS/qihM/m1iNSKc=;
 b=KSycKJrKXQSyP14InIYaH2CpVRhiFYwYVKxFVV4SJJh+3rDeWzihhK5LdjjBFNH9EF
 fSN0i7rOjSTZab6Z3dPFA0ZKrK7rLJh61mzUgG4aPuiovqfQnR4xNoXzYRdY3r5UTgfx
 fYJF5juXESKbj+nWRxcgqjHBs9yIoTPpldUirsTvofGd3tifv8aQaZiDXJl0yyM3Mdm/
 iKrerZs/6+5Mp6/AFLM1pKmYBAx0Ry57pagwVN8UZcnAcQ04QiDxRhaZ5iJ2Ls1H1Xt7
 pXr52hGyzH+A9XS7ujd0OD+C0bWBRYcJR6cKK7/kq+rakUj6Skpp7j3QOVp6DHSrWZ4U
 7P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875298; x=1780480098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QuK3qwfNGYCuijsueLPi62zx8F1qyS/qihM/m1iNSKc=;
 b=KA0UmB3f+MuzCoB2IvOdtDbBHwCZCM2QujTZrvEkiU1eK0dImo9nP8HNiM4zxpYvnB
 tT9D6wVYB25JxE+hY0oZKViK7UyeYjxYCoU4w3JSILnBTrU+uI/v/cIJnP6DVFR0rtmk
 zq0K6N/1toX7Z+oV0Yb48Lp9/9BQeg9C7gSg0ytG6gN+dPJ35/GmL1TyiX6PA4yiq0KP
 icPnf9rcNCmhGiZZYzXeCUlE5HrXnqKEUdaAJv+zCUTvQfkSpMhqXJ2G5PMhCSb3onCM
 gMxzEnI3KmhhBI8XU9GSQM+2OeBnHe69U0AusPT2FxrhynsDYv7SICRaT5PyMxp6hDBi
 XGfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aM1He1pk6IUXSOdoPE2wjJggnGiQrub7kshUrYv7EOW+VjEotDj4gFSGZq9vWid1aqRR9/s3zf34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9l7hGUEPWJcENqrgDlf9YuTwxt56RnEmEVMNbnBghPPcreNUG
 f4kXgdv2XJNn2E2xmAeNjx6lI3P7SNaueznjInmms4wNTXdMi7aoj96LsmOu9Z74duIP8Y3ij2/
 g7YympoiAdlmeD84j6q/VcM6nxv7aBIdj8nBH3oYMf0qFWwzvj/OFq6BKZfkIyWVL+J1vTtg=
X-Gm-Gg: Acq92OHGzXIWz4vfxEDsPl+P5R9fafE1NMqN6Ov35lWZynPHKxIXc7WCmMLGhDZ87tk
 +1+4LGoKCnJHdqUjvzneogdMQ1pzOtj5nw92d+XZ0LJBKdeBIsMoIh7/J2+G1BJ7lbfjXdVEhAb
 +zkS0D296XCyG7gD+2YSvI9+lWzLP8hqzyvpi21/R6Z7d7Us60vBBLhEn03czFthdFAhOLR7hTl
 4rXGnlB/PBQV5nuBzikjU5B4tnJYFAMwCqct4OM/COWi5qZqCa7dNnReSvv0ZHKFxsP0mX3Vx9M
 y5UGvjRETwD+l/nrQDTg4trJOUes9Kw9Dq7ndBnQBkuNPV0C/laEUr3UGPCFmnbBvH1nbAyj+kJ
 7RmRK8XvByTCAsao+WWCpj6l2oMm0rYJKDvJZHvr1zHzQHZQ5uww/9xu7pos51YA6ChNsO/R5Um
 y4lrIUDOMPuM35jg+5s7zx6HEiv1Bkrl7Iq2Gp
X-Received: by 2002:ac8:7dd1:0:b0:516:ddfa:23a2 with SMTP id
 d75a77b69052e-516ddfa2ca0mr263957281cf.43.1779875297555; 
 Wed, 27 May 2026 02:48:17 -0700 (PDT)
X-Received: by 2002:ac8:7dd1:0:b0:516:ddfa:23a2 with SMTP id
 d75a77b69052e-516ddfa2ca0mr263956961cf.43.1779875296998; 
 Wed, 27 May 2026 02:48:16 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6fb31611sm544001a12.22.2026.05.27.02.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:48:16 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/3] clk: Add __clk_disable_unprepare_counts_only() helper
Date: Wed, 27 May 2026 11:48:09 +0200
Message-ID: <20260527094811.116977-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA5NCBTYWx0ZWRfX0VBZGDkisk+I
 an2wWG8xyFrPgkHDbns83NdwBuOSfaEs7d1ughJUS8np9RLbcDvaJwQg6ifzyCc3dFwuchBoYn4
 +oWPPbVVEuNR5+93URhRlJuf+Jzknbm5cc5Uq60bYsof7z4Hbogf1oJ5efrhi4xplEbH51e3UeN
 sCXFAZ/d1vrBov5bARXG6kXXzND2b/nRfBJQJdRDglUZK56RYrva2n8bDQhjgeOIkhW3kFI41oi
 zJ9KiMW9xNV/eRAUedosqSNwC5CkRipT43DxG8TMTM59XbwJOWZhN1sKC6+hDeFJBjiqJ0otmxw
 Wh82MJWnSFPodd3jBOCuJRWB4kOLfMrolPjU2ftkYHPSUmg7Uq+RC1ONIEgHWIC3E1fz8yxs5Xc
 VMsUx8tYekLaWKLKUu1BRoXrXhAz0cEYL+trjLL9j9WX5qaI1k5MI1J7/kYPuOjVPUF2hbN9vlD
 pIZjRHOkU5Ob1Kg7aQg==
X-Proofpoint-GUID: r4mzi3JXXITqdJkQHXUjuBYBsLR0tbt0
X-Proofpoint-ORIG-GUID: r4mzi3JXXITqdJkQHXUjuBYBsLR0tbt0
X-Authority-Analysis: v=2.4 cv=cPnQdFeN c=1 sm=1 tr=0 ts=6a16bde2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=IzvHx6tSKKdpVn8xzKUA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270094
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

The device-tree simple-framebuffer device is special in that it does not
describe actual hardware, but it allows firmware (e.g. u-boot) to pass a
firmware initialized framebuffer to the OS to use as display during boot.

To avoid clocks used by the firmware framebuffer getting touched while in
use, the DT node contains a list of clocks and the simpledrm driver calls
clk_prepare_enable() on these clocks. When the real display driver loads
simpledrm gets unbound and calls clk_disable_unprepare().

The simple-framebuffer concept assumes that the order in which resources
are acquired does not matter since they are already on, so power-sequencing
is not an issue. But clk_disable_unprepare() actually turns the clock off,
messing with the hardware state before the real display driver loads,
without any knowledge of the proper power-off sequence for the display.

Sometimes this leaves the hardware in an undefined state e.g. on some
Qualcomm platforms turning off the DP clocks at simpledrm remove() results
in the following error when the msm display driver tries to re-enable them:

[    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
[    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+0xdc/0x100

Clocks from the simple-framebuffer DT node are not so much clocks which
the simpledrm driver should take full control of, but rather are clocks
which should not be touched as long as the firmware framebuffer is in use.
This includes not turning them off before handing over control to the real
display driver.

Add a new __clk_disable_unprepare_counts_only() helper which decrements the
enable, prepare and protect counts of the clock and its parents, so that
the real display can take control over the clocks, but which does not
actually disable any clocks.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/clk/clk.c   | 41 +++++++++++++++++++++++++++++------------
 include/linux/clk.h | 14 ++++++++++++++
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 47093cda9df3..8c92d3551556 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1037,7 +1037,7 @@ int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(devm_clk_rate_exclusive_get);
 
-static void clk_core_unprepare(struct clk_core *core)
+static void clk_core_unprepare(struct clk_core *core, bool call_unprepare_op)
 {
 	lockdep_assert_held(&prepare_lock);
 
@@ -1062,18 +1062,18 @@ static void clk_core_unprepare(struct clk_core *core)
 
 	trace_clk_unprepare(core);
 
-	if (core->ops->unprepare)
+	if (call_unprepare_op && core->ops->unprepare)
 		core->ops->unprepare(core->hw);
 
 	trace_clk_unprepare_complete(core);
-	clk_core_unprepare(core->parent);
+	clk_core_unprepare(core->parent, call_unprepare_op);
 	clk_pm_runtime_put(core);
 }
 
 static void clk_core_unprepare_lock(struct clk_core *core)
 {
 	clk_prepare_lock();
-	clk_core_unprepare(core);
+	clk_core_unprepare(core, true);
 	clk_prepare_unlock();
 }
 
@@ -1140,7 +1140,7 @@ static int clk_core_prepare(struct clk_core *core)
 
 	return 0;
 unprepare:
-	clk_core_unprepare(core->parent);
+	clk_core_unprepare(core->parent, true);
 runtime_put:
 	clk_pm_runtime_put(core);
 	return ret;
@@ -1178,7 +1178,7 @@ int clk_prepare(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_prepare);
 
-static void clk_core_disable(struct clk_core *core)
+static void clk_core_disable(struct clk_core *core, bool call_disable_op)
 {
 	lockdep_assert_held(&enable_lock);
 
@@ -1197,12 +1197,12 @@ static void clk_core_disable(struct clk_core *core)
 
 	trace_clk_disable(core);
 
-	if (core->ops->disable)
+	if (call_disable_op && core->ops->disable)
 		core->ops->disable(core->hw);
 
 	trace_clk_disable_complete(core);
 
-	clk_core_disable(core->parent);
+	clk_core_disable(core->parent, call_disable_op);
 }
 
 static void clk_core_disable_lock(struct clk_core *core)
@@ -1210,7 +1210,7 @@ static void clk_core_disable_lock(struct clk_core *core)
 	unsigned long flags;
 
 	flags = clk_enable_lock();
-	clk_core_disable(core);
+	clk_core_disable(core, true);
 	clk_enable_unlock(flags);
 }
 
@@ -1235,6 +1235,23 @@ void clk_disable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
+void __clk_disable_unprepare_counts_only(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(clk))
+		return;
+
+	flags = clk_enable_lock();
+	clk_core_disable(clk->core, false);
+	clk_enable_unlock(flags);
+
+	clk_prepare_lock();
+	clk_core_unprepare(clk->core, false);
+	clk_prepare_unlock();
+}
+EXPORT_SYMBOL_GPL(__clk_disable_unprepare_counts_only);
+
 static int clk_core_enable(struct clk_core *core)
 {
 	int ret = 0;
@@ -1262,7 +1279,7 @@ static int clk_core_enable(struct clk_core *core)
 		trace_clk_enable_complete(core);
 
 		if (ret) {
-			clk_core_disable(core->parent);
+			clk_core_disable(core->parent, true);
 			return ret;
 		}
 	}
@@ -2451,7 +2468,7 @@ static void clk_change_rate(struct clk_core *core)
 
 	if (core->flags & CLK_SET_RATE_UNGATE) {
 		clk_core_disable_lock(core);
-		clk_core_unprepare(core);
+		clk_core_unprepare(core, true);
 	}
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
@@ -4063,7 +4080,7 @@ static int __clk_core_init(struct clk_core *core)
 		if (ret) {
 			pr_warn("%s: critical clk '%s' failed to enable\n",
 			       __func__, core->name);
-			clk_core_unprepare(core);
+			clk_core_unprepare(core, true);
 			goto out;
 		}
 	}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 998ba3f261da..7dee0dbb9018 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -783,6 +783,19 @@ void clk_disable(struct clk *clk);
  */
 void clk_bulk_disable(int num_clks, const struct clk_bulk_data *clks);
 
+/**
+ * __clk_disable_unprepare_counts_only - Decrement enable and prepare counts
+ *
+ * Like clk_disable_unprepare() but then only decrement the enable, prepare and
+ * protect counts of the clock and its parents without actually disabling any
+ * clocks.
+ *
+ * This function should only be used in special case where the clocks should
+ * stay on while handing control over from an early-boot driver like simpledrm
+ * to a later more featureful driver. When in doubt do NOT use this function.
+ */
+void __clk_disable_unprepare_counts_only(struct clk *clk);
+
 /**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
@@ -1099,6 +1112,7 @@ static inline int __must_check clk_bulk_enable(int num_clks,
 
 static inline void clk_disable(struct clk *clk) {}
 
+static inline void __clk_disable_unprepare_counts_only(struct clk *clk) {}
 
 static inline void clk_bulk_disable(int num_clks,
 				    const struct clk_bulk_data *clks) {}
-- 
2.54.0

