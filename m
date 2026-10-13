Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B70CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6578A10F5CA;
	Tue, 13 Oct 2026 07:53:49 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 97F1B10E00C;
 Tue, 13 Oct 2026 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=7qFgjGaUkR
 ZudxR5rXzD5LEzR7NVO8WD+Q8LXfOl/7s=; b=YO+fu6rPfZTLYYRcKKFSy1ZxkM
 1rXIIrcdbEZr+6EVVa6VHGOG32qXeeBu+YlvoWEu4dXGdhV2ygvLeijTTJy/IFdy
 MFnDxo4jQwVXLASBVT6hQDXGMe4EiyuHZYIQa6quW4Jwc+i7lHY1j0XImunzF4J9
 fxEW4chx5a/6UN+Ko=
Received: from 5700g-x8664.ustc.edu.cn (unknown [114.214.192.228])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgCHbBOEec1qS7HcAQ--.928S2;
 Tue, 13 Oct 2026 08:21:24 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
Subject: [PATCH] drm/msm/dpu: add the missing GC block to the SM8750 DSPP
 catalog
Date: Tue, 13 Oct 2026 08:21:23 +0800
Message-ID: <20261013002124.332074-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgCHbBOEec1qS7HcAQ--.928S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1ftry8WF15GrykXF18Zrb_yoW8AF43pF
 17AFy5AFyDJa1SvFn7Cr1Dua13CF4vqrWxKr1qk3sIvr1Iyw1IyFZ8Aa9xCryDJry2yr1a
 qFsFkry3XF18XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
 W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JUL0edUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARETB2rNcIkC0AALsD
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

SM8750's DSPP sub-block description only lists PCC, but the hardware (and
the SM8650/SDM845 catalogs) also expose the gamma-correction block at
0x17c0.

dpu_crtc_create() only calls drm_crtc_enable_color_mgmt() when
dspp->sblk->gc.base is non-zero, so on SM8750 boards no CRTC advertised
GAMMA_LUT and userspace could not do night light/color temperature
adjustment, even though the hardware supports it.

Add the GC block to sm8750_dspp_sblk, matching the offset/version used by
the other DSPP catalogs.

Tested on Lenovo Legion Y700 Gen4 (TB322FC, SM8750P): GAMMA_LUT appears as
a CRTC property and changing it visibly shifts the color temperature.

Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 9a993cdfab..11dc08e4a4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -428,6 +428,13 @@ static const struct dpu_dspp_sub_blks sdm845_dspp_sblk = {
 static const struct dpu_dspp_sub_blks sm8750_dspp_sblk = {
 	.pcc = {.name = "pcc", .base = 0x1700,
 		.len = 0x90, .version = 0x60000},
+	/*
+	 * SM8750 has the same GC block as SM8650/SDM845.  Without it
+	 * dpu_crtc.c does not call drm_crtc_enable_color_mgmt(), so no
+	 * CRTC exposes GAMMA_LUT (night light/color temperature).
+	 */
+	.gc = {.name = "gc", .base = 0x17c0,
+		.len = 0x40, .version = 0x10008},
 };
 
 /*************************************************************
-- 
2.53.0

