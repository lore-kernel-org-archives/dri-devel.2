Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96468606A322
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYC/w3V4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79D010E53A;
	Thu, 29 Oct 2026 13:53:48 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF6F112310
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:23 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so18233655e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793282002; x=1793886802; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F6iyjptvh4HoJM36iNO76ddk9CmJXz5lBV2KpfdHPWQ=;
 b=rYC/w3V4oyOBVqwMsgCx1IP3ZDP9ujB+K2Hk4PUkLJ61b5tUf85MMoFnW30hyBLbwH
 83GGUq190iQbUTvk4nu96Pk+moQ3xzmb59aP1WrXQMLjH274rLrRqov+IU93u2ZRpkha
 jm9AlwBnKY7pepRHPGR3Zfrh1bUFaeP7Gl2PCqaKgl6GMhXiFrn+i8Pmgp2FnQFMKWSI
 6qy0Ly4WgCUMwVTYFY6jNaOx/GdIabR73vDCtXNseQiThoEKHaGoJYrZflGV1GJlpsWh
 XnIHOdwEDFmAb2snDDSrvi1diUtTDNDjzPFSkmTersYeKOWPJgOqHc/qJSRVGqr3Wn0y
 UnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282002; x=1793886802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F6iyjptvh4HoJM36iNO76ddk9CmJXz5lBV2KpfdHPWQ=;
 b=dkYz5JOJ4jxDUIwWp4YpzzZg72yh4HYA9C1CRMEaoticghY/sQ0gFklleN2uO1xf1m
 GN9KlOudozJRpX/CCgUWoAqlyWbSMKGxsohPIxAYQErw0a1FTGSCrjXCYQXICSHOsBdu
 muVbdibo55bO34HmX21ArzkYpY6fSq0cuKlPAMRKT00T1CxUxpKOIJaSdpBGrDn/Waod
 elggwmncMQJFI+iCD5ULM7sC6uvEP/iyjcIrTt8hwx5iYm2mZCpz17Vg4KJJaekl3vLu
 vAEw3azRX0F7ScQVNVun4ZIAhth96C/rAde4O/qk37c9kghd7xx0duW68nn+XkV3bDIl
 cieQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7InOeLoVCbdHvHMo15tEFmoL9pIf0ygdTTplERpNiPOSTSDy0ZdxVNc6cQCfj3xyPUpVDAxaEdEU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL57KHHTMVHqqDkdEvX0nHvRN3aOLMaUKM42COx4uMOvDzQo1H4
 lSED1cIuEOgJcFfOTUD/yeWhtKo7pUktCS2Crs4+aVklN/prz4E8dgg=
X-Gm-Gg: AYBFou2BlysUx8mEhPhr9PG2OqVAm4Kaf9WhC5ZAG4nIhiKnZ/m4iiZy1a5UrbhSjMX
 UIOiUJuknndg0Ch12QJI89J0yAulG3hrKCpHc55H0FvpvYZNzW8xgb9/ECzvinLHW+IHGtni/kj
 1zG6TaaXZlpTCUE0a+ug6/0whjQUmRueBiax6aqFS0tz8NhayDI/ooIJHQHVBIWSahB4I2Xcv0R
 0TlGhzS0TWzU6ecyZyKMOX6oAoAU7YEgV7TCx30TfbODL6PIzZnv0LwxpgM89iiTHXP4iyGBVwa
 5QLsir83ZpNQP/hGg2gzAT2FTkNEd5pGbxyTjupqkH5c9BK6dSuKNMEHPoO+1i7rk3laXcNE92B
 4NAtD2sLakVwdalmsuWzqcinei8zcgeNwAYI2ibLNwGixik32flAVb9z5v/vPzoAk1lV5y3Hikd
 qiGijuNW2DbQplglmcXZGkzqPQB9P6IAZ96V2pe+p6h0Sy3BvLjsGwpbaqBRiSy4FOa0LuaAFiv
 UEZ8TlUuHp76oPNqm91HP72f8STrxOxiacazh7cIWxCuPiX+K1kqtwKNo3oTfVs09i8kRY+HOhj
 s9D55HtXmULS3wHktcAX+YIU0zAgWQUHKC6DUdDYGncvog==
X-Received: by 2002:a05:600c:19c8:b0:4a2:150f:160f with SMTP id
 5b1f17b1804b1-4a967d96ed4mr130087105e9.25.1793282001580; 
 Thu, 29 Oct 2026 06:53:21 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:19 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:45 +0100
Subject: [PATCH RFC v2 08/14] temp: add LPAC regs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-8-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=3442;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=RZEFtq/LXNa59m6pbHJ662cjcscb6GjQIUaPl2ZCGCY=;
 b=Gg0EOPcUOgQpNZut9lNNaoRdNIuSBEJgfuo2weKWP2BE2uB9+coUCffV36k/9B33kt5L/B+7s
 HpwtMjcdQ9CCbIIPIywq4tqFWNV27VuvFgGbiHV02csNFC4O1QaG7Tn
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
2.56.0

