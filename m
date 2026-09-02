Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ED3C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F6D10E51E;
	Wed,  2 Sep 2026 20:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0sYz4CC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HcK9TzlX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4F010E51E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Hrtxq2731222
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9lDnpS9AG8B
 MnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=; b=a0sYz4CCAZERJ5cvQgZ067dKOaN
 q3zsMGdWtgW4siEJGM7JhH5S27ck/eEvpze57SsRdLn6TIb6EYfN4QDUd0EgoQ47
 hCyZGr6sDbJ7x0sKo2J5FjWKamDlSx8J1AfHtG13YKSYWtdxi8lr8kdNCA37Mrn7
 ffVtMIw9RXL7cpU0LXHWe8Y2v1Hng0Cw8YAniRAajGPRp4mAkHO15m2C94aUICNL
 VtHZwWDy3QkuVzs9vQCqcXewaaRtyixuRjgqgrCtOI+jCbl0UhLpkfLp1PykMbjL
 qokITfmOkJByT5TuP8bH+8444POICdhc+B1vucMlN5DsaaxXwT4RQuCrmzQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2t5t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc39363cc88so1328855a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380238; x=1788985038;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9lDnpS9AG8BMnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=;
 b=HcK9TzlXwQD7jdTP8bqFcPhlidvuzRMyhd931kDKKEhOGtxa1Tba3Zq3lnlvS0XXKU
 nkko3Tn1SDAzij0+qAR49+8aKwYuJuuaWTeaBZX1Z59sWwHx1KDreAN/2piT80Pl8ywQ
 PagUu95H79ikkwjfBznZAQ8nG1HJYSG/7UGuTI+rnFjKQlAqFW3vPwpzXPOK3Kggr1FK
 z1HtLl9FnZ8pjuRw/SXYXJ2HbkugLsxMviAcGAPfqK1OpyixR8+N6P3Y1AJRuSrCL12c
 t6K20ZIRqOpVr7MVprB+Iv2nCNAqrD5n7zwqXpOcbf1TbsueVWH+1PocdJqSeTZHpHBH
 ywjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380238; x=1788985038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9lDnpS9AG8BMnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=;
 b=h4usZMvZqDWTZ2k/diQU5VlnFbH/oqJagxi9Y3Jk8Kb53Wgcq+Qp8yfjsDyLpZBg0Z
 8gyGSThkH8mUO0gaJ5dPx/0gbFOOO86Gm7EgJUTPWgZPaYHhea/6jzn8ZHz2KRKNLrn1
 X4Ap4cVzCrUYgeGmFo5FwynXssamEQyw9UNF8neth/Zm9/bxLnDu/xHoQUDZppKKRWv/
 yRIE5o8yoymkFMdeg0YGmRmiZi974omeI7gPwLdyzE3rhjsEbbMroML6uOLT4WhFd5QL
 RlsxmXHZylAi+QuiCLnhtsk5+Qqsfxdj6MaunR/lN4Rf9GGEyFa9K2mv+RC2vu6W0Ywe
 chMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqLCABdNQd3ATke14sg7V15mdrz612JZzrumyaO0U5jz9o/UNwgCoCof1jkQvNNPLIaTJ32wehCdM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mRMBGXC37sGL0bMyrlGduUjegYwKjU9Xl8V8Jkgh9b14kJjfxp
 Ljh7XLLRKAQr4TRkwoc0vfWU5ZWf/mn1p5WG8wZGtcUdMxQOT3aQESUDPPN4avqPsUQSNtaOc5c
 My7RbZrJTh3JLfuf6yKQumszbpOsePHk+6S9j59OqxQpQN/3Up4di01ofHzKWffm6bz7+Q78=
X-Gm-Gg: AYBFou1w2MW7moLgUNVqiXCo3vasoWEvOjiIiiMd4DEM8otGYp5t0kYKDhal1wtvCQY
 rRWzz+EAudL0G41nbK0Z4YwbPsvLHNHNmdr/J8LieTNVeC7+fcv5pHDMs/ai3ythDGxKNCF5vc3
 PmmcSCPZGNSPmmoVOxDpGgrvXlYQLL6TDYH175XtdbpmYnrcibKfeMFT+uu6wwSjDgWaZDTtOXH
 bmuKXKrpeqzVs3z0AkV36w9JIqw6oz0ZvGmf9cM6bjOV6ImUDmKfltalUO6OHBiPmfwt23ft9tU
 0lPmyEN8z2f67UQORY2e6Mj3puNcW+ryVhj9N1N9K0Czn+UYHoYWiHrBf/Adwj+rUiV8SHPAT3r
 cmpRfErj4DUCWMLlli8XAVQQRYyM=
X-Received: by 2002:a17:90b:1dc9:b0:398:c794:ca26 with SMTP id
 98e67ed59e1d1-39aee17a0ecmr11378937a91.25.1788380237640; 
 Wed, 02 Sep 2026 13:17:17 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc9:b0:398:c794:ca26 with SMTP id
 98e67ed59e1d1-39aee17a0ecmr11378858a91.25.1788380237159; 
 Wed, 02 Sep 2026 13:17:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:16 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 3/11] drm: pl111: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:32 +0530
Message-ID: <20260902201640.2024648-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a98844f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=cxSrDiPXJhrM2elx99wA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: BGbM-vZ2eq3jyriQBRVhTexIlxbq7KC7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX8oTF02E0QDBi
 EHR5VZu/OYl3SnBmwdO2K7S/JXRs+T9ykaUIlcrG287pnsuXAM1A9Nfmu8mHdex/Nyg/eSnnNs/
 pO/dPJoEZabFNWPqK7zsvUWZtI8gkX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX6ru+k34a90fQ
 Ta5ONERmuoLWenw5QOG0U/6djNAEl73+PQYMiyZIthN3eGFrQ6vCMQ5Jd+g9DzSkwNam/cVbLKl
 LnQ5xIhSQ+eKBkYGNwsle/ESlKT9PJDdz5FrfZZCUdO67JOspUQ+oNldS7Tbk6GAlLWk6+14cMF
 /huu2MXTj0OWcQglquwyEmy/rsLceAsmKwfE/exBQdDCnfa3e+aNAgJm6kUEbcaQuVhkV/Vv9ct
 aD/JaQxpBYub8NUvKluYsp9oO2a0KGHVqmWgZJkll+2fi7reIDBca/+PkMpc2yFkmhz9D23p+IS
 ZSHjXCLeH5LhQI+TfUzybuZ2+KE4Y68QWw43elDy7oplXnSalllYh6BRES2xdXhEqNCcJh+OZKO
 UfOPpo/CFVM/FS/KsjNzwu+L8+lkoI072wbwoXFvXy8a9OxZ4bif92Lm1UsiVnclJjcT1yRrvc/
 MqXJCRNoNtwzYK6CMUw==
X-Proofpoint-ORIG-GUID: BGbM-vZ2eq3jyriQBRVhTexIlxbq7KC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179
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

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the explicit of_reserved_mem_device_release() calls in the
dev_put error path and pl111_amba_remove().

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 8ec659b3c08e..a07b17261961 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -255,7 +255,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (!ret) {
 		drm_info(drm, "using device-specific reserved memory\n");
 		priv->use_device_memory = true;
@@ -314,7 +314,6 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 dev_put:
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -330,7 +329,6 @@ static void pl111_amba_remove(struct amba_device *amba_dev)
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 }
 
 static void pl111_amba_shutdown(struct amba_device *amba_dev)
-- 
2.55.0

