Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A96C44502
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A8710E2D8;
	Sun,  5 Jul 2026 19:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FzVGPR+n";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B0D10E320
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:33 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47dc6e04367so79385f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278871; x=1783883671; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zjiz7ZnbyxVfBfvfi0uSyQjszdJNoTxi1eUy+vx48jY=;
 b=FzVGPR+nDSy3XyTQjzqSJofwPYFYfN+tLpYWYBmc9+iR0ec+fJiwByQbmxUsY/wCsG
 cpISCGMJSXqxGjdTWDiolbkGSsMFD1dmsG2qLJ7mWV2oGQbs21O4v4/vinZw1MTjADLi
 r+xMtyCRINSN/IgGtyB8T4ltDiJQXKy+mmcxht65F17VRGD9JHM+vB8LLxpwBGZ0znzt
 T24HOlJb0TQlD4dE2ugqDBbs6h9nhkHgPX27vnLxCOVT5ynXsvl7uZWxErOrWwy5tJow
 wfYHKEymTzIW9hmRpKMnGqIs0TIyS+T4AKvOOGhZiEuJx568Z+MazEeSdnAbTGxImkYD
 Nd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278871; x=1783883671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zjiz7ZnbyxVfBfvfi0uSyQjszdJNoTxi1eUy+vx48jY=;
 b=igchzCJ8NIp6hELRKcj8hWyn5jRYSFB7r7P5Y8JqKyBovjQ7/BulQ2Y7r5mSlj/pyw
 uhQpFhsnhnRg7kgaenQMo0dy/ctj7O7MXW+puD3kszFGtuVQa7Kb3QVD2DbkaruASQoO
 KAD2ahNqFDVIjzr0JBLrdOt3Y919E8A695VEYojOp4ewe8uvgQo3A13rFPCGHBmMOQJc
 +O4SpekX9D9O/NZ9x6xabZZ550s5B0SbqN1eq76SPEKWro6RI00w2dS2COcvTC08T90G
 lTJjmer6LoqfRX+CqV3mL9IxCRQTbiQbqwDpbTSA5aV/ZQNmSy/ocpfIk03ABYOlxoe/
 Vz/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RptIzUiyGAvTN40ijLV6gRfudBH9LOTc3rKnSZ5udR5af+Ef8rrAKFtDP2hB8Phh/aIOQiqMKxVihQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYP9LuXKW2cwctlN7Y74nptlm5yVefWcaoCspMJ9ksBeMMRzlf
 ib/SmOyNr0GB3T+JLnxmtEB7cS5XQYwplWoAec1hquYM56wku3odD/M=
X-Gm-Gg: AfdE7ckLDBWDGfINSZWlTpC1gGwM0H53aaf/PLz1Loue9T+gaUB8ilYKI8toRlrsgNU
 zU1ZjZBaBRzO38k0Enxxi/aU0ZkB7TV3Pnxd61LovDYoFumSLCe+3VXNFtSAG6qAhrbDZgLNMSC
 VArzXeLT5GgrezyvYNldjPuPalJSlGFsJIXYgJDvo9InPnFEPBnVmBstcUe1daENfXWuiacagcR
 E0Axi4OMdURhIsPBFtPw2gweauGh0ENnyTN++6dB0EynnvY5Ph1M0to3UVeUtoK4KyvBqqR3Ztx
 4fKiYabashNbnZdSndKyJvDej003XtJ7DVneb9KgKXyTBTBN2yeePYMCZFTp8RrveiohiQLcmwB
 0mFxTgEYBW83MpPoosIdw4LBv+o+RBZ4ugTTuPaU9SYlnpfSCQuYY/Y4RxtIlmbuiDqUfStuAe+
 cFwOUSXj6bSd73OQhWkS2UueJ1pmXlYg==
X-Received: by 2002:a05:6000:2c05:b0:47d:df96:c9f4 with SMTP id
 ffacd0b85a97d-47ddf96cc37mr2857980f8f.10.1783278871226; 
 Sun, 05 Jul 2026 12:14:31 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:30 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:43 +0200
Subject: [PATCH RFC 09/13] temp: add LPAC regs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-9-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=3442;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=gKbn7DxHBfW8SLIM+L0EECSMebRwKa2NPKVJkQ/QPPw=;
 b=kVEoEECsDH8lgKuRlOjhb0NLej7gAlbXc+I8b7Z8Y6BmwMTjsJI23i+SxwgE0fdda9uz24tEH
 NoA9v8TbOQcCAGwLTW9/mUY/YNUbybJ8jacr99G3tWrk2UifXc4ttFe
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39416

should we merged and we should sync to mesa instead

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index 3349c01646e1..bb49f6a61a9a 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -276,6 +276,11 @@ by a particular renderpass/blit.
 		<bitfield pos="1" name="ACCESS_FAULT_ON_VIOL_EN" type="boolean"/>
 		<bitfield pos="0" name="ACCESS_PROT_EN" type="boolean"/>
 	</bitset>
+	<reg32 offset="0x0B09" name="CP_LPAC_PROTECT_CNTL">
+		<bitfield pos="3" name="LAST_SPAN_INF_RANGE" type="boolean"/>
+		<bitfield pos="1" name="ACCESS_FAULT_ON_VIOL_EN" type="boolean"/>
+		<bitfield pos="0" name="ACCESS_PROT_EN" type="boolean"/>
+	</reg32>
 
 	<reg32 offset="0x084f" name="CP_PROTECT_CNTL" type="a6xx_cp_protect_cntl" variants="A6XX-A7XX"/>
 	<bitset name="a8xx_cp_protect_cntl" inline="yes">
@@ -333,6 +338,11 @@ by a particular renderpass/blit.
 	<reg32 offset="0x0845" name="CP_CRASH_DUMP_STATUS" variants="A8XX-"/>
 	<reg32 offset="0x0908" name="CP_SQE_STAT_ADDR" variants="A6XX-A7XX"/>
 	<reg32 offset="0x0909" name="CP_SQE_STAT_DATA" variants="A6XX-A7XX"/>
+	<reg64 offset="0x0b00" name="CP_LPAC_RB_BASE" variants="A7XX-"/>
+	<reg32 offset="0x0b02" name="CP_LPAC_RB_CNTL" variants="A7XX-"/>
+	<reg64 offset="0x0b04" name="CP_LPAC_RB_RPTR_ADDR" variants="A7XX-"/>
+	<reg32 offset="0x0b06" name="CP_LPAC_RB_RPTR" variants="A7XX-"/>
+	<reg32 offset="0x0b07" name="CP_LPAC_RB_WPTR" variants="A7XX-"/>
 	<reg32 offset="0x090a" name="CP_DRAW_STATE_ADDR" variants="A6XX-A7XX"/>
 	<reg32 offset="0x090b" name="CP_DRAW_STATE_DATA" variants="A6XX-A7XX"/>
 	<reg32 offset="0x090c" name="CP_ROQ_DBG_ADDR" variants="A6XX-A7XX"/>
@@ -521,6 +531,7 @@ by a particular renderpass/blit.
 	<reg32 offset="0x0b29" name="CP_SQE_AC_STAT_ADDR" variants="A7XX"/>
 	<reg32 offset="0x0b2a" name="CP_SQE_AC_STAT_DATA" variants="A7XX"/>
 
+	<reg32 offset="0x0b30" name="CP_LPAC_CHICKEN_DBG" variants="A7XX-"/>
 	<reg32 offset="0x0b31" name="CP_LPAC_APRIV_CNTL" variants="A7XX"/>
 	<reg32 offset="0x0b34" name="CP_LPAC_PROG_FIFO_SIZE" variants="A7XX"/>
 	<reg32 offset="0x0b35" name="CP_LPAC_ROQ_DBG_DATA" variants="A7XX"/>
@@ -1207,6 +1218,7 @@ by a particular renderpass/blit.
 	<reg64 offset="0x0E08" name="UCHE_TRAP_BASE" variants="A8XX-"/>
 	<reg64 offset="0x0E0B" name="UCHE_GMEM_RANGE_MIN" variants="A6XX-A7XX"/>
 	<reg64 offset="0x0E0D" name="UCHE_GMEM_RANGE_MAX" variants="A6XX-A7XX"/>
+	<reg32 offset="0x0E12" name="UCHE_DEBUG_CNTL_1" usage="cmd"/>
 	<reg32 offset="0x0e17" name="UCHE_CACHE_WAYS" variants="A6XX-A7XX" usage="init"/>
 	<reg32 offset="0x0e04" name="UCHE_CACHE_WAYS" variants="A8XX-"/>
 	<reg32 offset="0x0E18" name="UCHE_FILTER_CNTL"/>
@@ -4406,6 +4418,8 @@ by a particular renderpass/blit.
 
 	<array offset="0xaec0" name="SP_PERFCTR_HLSQ_SEL_2" stride="1" length="6" variants="A7XX-"/>
 
+	<reg32 offset="0xaf84" name="SP_LPAC_CHICKEN_BITS_2" variants="A7XX-" usage="cmd"/>
+
 	<!--
 	The downstream kernel calls the debug cluster of registers
 	"a6xx_sp_ps_tp_cluster" but this actually specifies the border

-- 
2.54.0

