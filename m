Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6355CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD5B10E133;
	Sun, 14 Jun 2026 21:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvRqqshj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CcXI+f9w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4165A10E132
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ELFB8R2695779
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BBa5VYXjVh+mQki1BQtkfNYs/iy5UlWU9hRfZC/T0lc=; b=DvRqqshjKbCq8JJR
 uAHv4S0lD8FL1S9l1b7TWhWXv17tLh/8B+qHSh8JZWbu0pyAzRp23j7et3hhdVKL
 DA1UNHk7x4U+HjMNW2a7Gc4KsyD/CzGGstSnFCN2nSeCikLD7SWuZTzGgXP8Lszu
 6vTbc5BAXVITLbnJQ8zmEUSiYiqG/4nrW80H7HmghacLSyY/zJ5ZMViHNE+RpJKR
 TNfnHFFNAlqMbRzJtcI+Rqmo4q9y9qj9i+svytzIfXFqfULH83eRhZlT53Xfxfv9
 nMAF8TbDHAjRKkHik2ywQLMGBMhr/2TX5thbyG0XtQJytOeo8aMZVzUgUneq0Kt8
 p5eFVg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gvmfe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c2d0a8b5beso27638465ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781472806; x=1782077606;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BBa5VYXjVh+mQki1BQtkfNYs/iy5UlWU9hRfZC/T0lc=;
 b=CcXI+f9wbD2TwbY0wyrC7D+75jGTC3WhpQEKNKQjY8gTZ27R2J+dFd/ELCP4VSI5j0
 +3jYJCfQuhplwOqHDgcpIA4uZjXTCndZ4EX9b5JThfXoHwIRGMCxXidaJUq2KHAE/0q4
 p1SoiQqDi9DQwGuxQAY+9dfHTryzKnHxvWod9SbVBkl8zJerYrsTxuadNXcGf2vu7Wj6
 OzEykIfXjwFmsdlx+X8A6Is9d9W3OVcVM//4ODf65cCsFsvFjteBVMtak9VHJFPR+F/p
 4fpsZ1VZmg2UxrF6EhxVKZ7r4Q0zCd0WRYG2PvhrS3dwtK748FRMTcfIFWzeUuqGPXBJ
 pFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781472806; x=1782077606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BBa5VYXjVh+mQki1BQtkfNYs/iy5UlWU9hRfZC/T0lc=;
 b=FSVFZdvNm+MM6N1nwuKDj1uVp/vvixcRacYm0AiG1f4bLl/bGXfWy79Ti3Qh9V1krd
 U3h9ORYFQQ69PDvZZGnRg/9b2MMHQw+zNyqM1VG/Ptd5kn44WJmt21V5U42EaqnKIILu
 SWQ4IrF9qhflgniyD3kP9579IWI2HHmVhgjKEWvECijJP7L3S6X84Uu6XKlFIUY8h9S4
 T+RglMMd7vAaEU/5eXlF2WAQIwvgpkAz5vMjMZLZr8xQoquAbpL0190r8HC/8n87UygL
 B0DLr51SdarirFSiJjKU7rkw14eE6aI03euo6V1liQZ671N599ocKaP7Ls7AopUfXS6b
 FdBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bVMvQbQzOcOkRscgSk7x8dojdN3wvepHoHs5js7DQjDVTBJ1bWAYkwRG1057M1rHsXB5wWUowu1Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfK/kONrnkkmYEBN0c46goH2rFE+o1rbr7t49FbZp0JUqknXOa
 o4kQAU6MH2ri7m4OB+AhNTO4qLIXS005Goy7zeErrZUupZCjJYzCCeTypnchM4o9lQ+D2xnuw1/
 EluWxxvfHZ6ovtTHlkE/OhJbmLgA5/QgRCOZnDrn2SzS3+MTvGmZX+bs0gbzY15wXP3qnyOSQOo
 gjy1s=
X-Gm-Gg: Acq92OGzHBMBtcjlDvODqPf7JLNs7gUPZONdMXyPBYjeM52sOuderV55Wfm3ApB2Vee
 PKRKrweAv8FS83M6ejcsQLAk5ch1fltj5amii6jLaw0vFRdl0Y7ulljZgdZQcZGPKx4dNfWIja+
 oPltNo2aL1F3xk2DzSLTQTZIefibSRFS0p6xqC8OzY/u/VXu00EaXIccmO2thFKraKCRXuv+63D
 +NXMZgJwuNr21T1n3pFwzzByq46cNxpu7wSpJzPlQHpht3xweu2SBVzIYdUHZoV7KukNTqb727P
 CxO+LiwRckOv3sGUcZgrgs+UdetA72KiR8wII+F2trZMNddmhPQ2gd0zEt7eb+lKYc6S+Wy7LVr
 QUN/aCfup8aY23mI5IVbdasVx12cQdZ3A8VaOdasTypAs2w==
X-Received: by 2002:a17:903:944:b0:2bf:23c3:34ba with SMTP id
 d9443c01a7336-2c41216d384mr127693805ad.28.1781472806135; 
 Sun, 14 Jun 2026 14:33:26 -0700 (PDT)
X-Received: by 2002:a17:903:944:b0:2bf:23c3:34ba with SMTP id
 d9443c01a7336-2c41216d384mr127693605ad.28.1781472805748; 
 Sun, 14 Jun 2026 14:33:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 14:33:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 03:02:58 +0530
Subject: [PATCH v2 2/3] drm/msm/adreno: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-gpu-v2-2-2f2d1347c3fb@oss.qualcomm.com>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=1143;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=R79xKmL+sZwSyzKrrAiP2VZ/Wn0sPCCgxYAlwy7UjP4=;
 b=yglw6Mgw5GWhrR/ZbfN4m9aEdZT4bjZDfQ92ZeoxePei8sXC4tz6Dq7Wn02eKzL+XQBxkhzli
 l0y5fuC/0UiCE8iWe7/3pfwwu104Dj9hZAY684jfSys8jDndsDHCPsx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOSBTYWx0ZWRfXzjG0MRCnZK3R
 j9Y48YWvhXAbmfg9QbWp78Lw2MgB6eX88VOgPod4GxOB5QoYNOGtAXT43VS6EGarNUFRzU8rxTE
 rd0NXovayBR9vsXYgUDBHnxHkcsypXo=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2f1e27 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOSBTYWx0ZWRfX66QvkV7W1aRH
 TwDzvq+kSU8kaOu07PDbOv+Cwd4QMxhX3EqKRgUdsAvwjI/VmeyUFjDoYhfGOxjMqs71I0tgFg6
 zsh9gUuI/uNMw653D5pwILehZB0YXwV+NaGh4ZVi9MkTJatmV28bHXURGkGLrnX1kCYrdzE4mHE
 XOEpZvyC91jSxO/T+9WhTyAAagJUfi9RqjrZgXWJFrQGjUUwZJ0B6ky1lqtu781fVcANc9wdAQM
 wqaEvRE9phjfpUtJIcIMyN/JzQk6kyugu391xxpQOqBKCAQQS8a36L3JwpGal/TmqZaF5xr1X7a
 9IcDyoBxQlNnxQoEq5k+JSjsPHYuBpd8lK4oe99zqqbZhgYCDZNsVflQOPZaz4VycIpS4hA5bWS
 LU/2UFWf/UvlNMAUNQKeFepYPuyp1vwUAxOIrKuRvJqf3E/LBBkT5ggsYbETiOELGFF6KJzjpFb
 gZF69bH/mjvpTJanuYA==
X-Proofpoint-GUID: 0FjbCYsgNbD1x1DNVV0_K3YY2wZqCXoW
X-Proofpoint-ORIG-GUID: 0FjbCYsgNbD1x1DNVV0_K3YY2wZqCXoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140229
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.51.0

