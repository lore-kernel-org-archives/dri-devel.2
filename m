Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B78CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0627110E5A2;
	Fri,  5 Jun 2026 10:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICYn+N7m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVQQauMv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4FC10E5A2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:19:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65584s9M021677
 for <dri-devel@lists.freedesktop.org>; Fri, 5 Jun 2026 10:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V5YZKQX2ZQaazK+ofLFvgf66g1BJkSfhht9kOwrmms0=; b=ICYn+N7myKnXgswH
 bQo/8lg0kxpiIsoldDGC/gCBvv93FgpFUDsZiqWxEW5IyZI9xSmOtpZ4LIwn+UzD
 YD86S2Oh7R5qvswSwd9/vySzJkbatdiifBNHWj+VyWU+lFp5rh3jyoNMKl6+k92b
 Bo0uVS2dDPj1s7IrkaKU8MNvuhBDlbW8mzjGJtXvhtS7RM4WeWUVey8f8JKF0BNo
 HVP4MSj79zvTpbS2ZAmCVQM5pBT35uE1OmPx17Fs6KQgzvNvzJjpyo6GBLIgAC1o
 jSy5twHm6Kq3/QkqqSVuBPtfaRUZdTns0JQnGWdoTxyagp5KZ3XwGtO+63ujvoM5
 gF/90w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ektmf8hdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 10:19:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf1dece2ecso18216615ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780654772; x=1781259572;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V5YZKQX2ZQaazK+ofLFvgf66g1BJkSfhht9kOwrmms0=;
 b=OVQQauMv9+9NISAEqaxHKI+BUw/rpHAZm0Hdne80p11lY3ECIr6jJKhFNMCu0aS0Ct
 uUizb1j6BrL1xFXBpRpr9Su8YbEcZVtw3KJf/JuDUeK06AY7x9dliMIBvpV+9AVtGUxk
 63c/DQwhJz1W3FtnORhnFPjfinBAO/bTG6EQG7sVrjNrb47cRr3W22ezFnIE5Hx4qBxX
 a2EzCaXqZ3nLcM/n/uVJ4QRZgFafpT82SWj17IZOV8c5MDtDXOeYjk9fBVsuX5ltHqVi
 mnSsFyMc4HHiekobVksZS9MDBsE+3JX1KSndAk54me8ywuUovKUZWwAz9c7tKoIjoJmF
 MSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780654772; x=1781259572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V5YZKQX2ZQaazK+ofLFvgf66g1BJkSfhht9kOwrmms0=;
 b=s6V9xAJjFxrGKV8RoAvC0I8qxKCPqZ6bqKAkiFDYjvMdykBnVr/BQptcrvrOX2znh0
 q0S1AaeORX9mMGGH9qgKtlmwRkraZ7zd8sDUY0S8b3v6NNzYkl+vpKcK7XuEip/DJ+bg
 dTCnwe1P244byipN+7MPxx3Is1ibyujzgEn2RQPi7gY425en/xZtDr/XpKWzWm8s2hT8
 sjqaUNCPPoU7LLf84CmTXQkOtTyQQ4eo+CDjPUZN4CKJ+O9z8j8yfEMZuQjPNGlwmAbi
 ZM+bQ6vtsFMeOIcPx73CWCTo3ATr4DjwxSgbpwingPES4HliAZvjx54ftrI+/mkDIPqM
 yVuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XMIOyFsqfW6Z9e4EG8qV019cDCuGCHSkvNcJdd9iIz/Y8ykWQqWMYlAc0qwH3MTorHMz674rzAW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeUx7XOZ+oOmLP1thGqi6w92n6eTCk+UlOLC7RZYbFdkmgetaL
 /ZVc3bccVJMzcf8wIt/S9Eh4H81wkr6jv5CMsfGo8AlRKxzLXSKNZJgor6YtOfZRqarj/sTcSVF
 Pgrt4WHiTHkU3FP+kHjcouMwhxkX2RTYrUyLO5leO5FwdScUC1lBuJzHvFSgrviWhPMXmWz8=
X-Gm-Gg: Acq92OFvM9Y6fKjbemtCb3YrUDzENo+GLty8UN0pZi7F4wo8Bqm910Hhuk8tS4X+Wb5
 poU92fgYhtRywYVz52zsCA0OL2mt85Es/ZJArtGwYP78YqCZw366KvWf1rsEQQvrg59QnavGIwH
 zvkXNkhahltLGUDG8PMsTEIzmg3sbZGn/LkqvzuuXLXcXxe4NeApo8BUm+7yh1hHheZ2wXR7EI7
 ykQ4ok9N5enwno7qH3CAimr6t1EpRI65E57tgfJ74itFFiRUtc/IqEmXJC72ZkH7EMS/XBB88CI
 BotHgPp/d40sjvJ1udp+NY2227sZ/aHMbx4D/HBi/U36HrAhmrcG8OhR7IwIZdUpNPLTapu66Oi
 j4WdBsRqvQDWxAZBZJSpc4NrpmGaNohwHR0764xN/8+hvvmWQz3S/97A0vQM=
X-Received: by 2002:a17:903:1b47:b0:2b2:5491:e32f with SMTP id
 d9443c01a7336-2c1e8344ef4mr31586175ad.16.1780654771921; 
 Fri, 05 Jun 2026 03:19:31 -0700 (PDT)
X-Received: by 2002:a17:903:1b47:b0:2b2:5491:e32f with SMTP id
 d9443c01a7336-2c1e8344ef4mr31585795ad.16.1780654771441; 
 Fri, 05 Jun 2026 03:19:31 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:19:31 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 15:48:52 +0530
Subject: [PATCH v3 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-display-v3-2-9846ba5fe635@oss.qualcomm.com>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=775;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=b3y/Ri3dF5pPUhVma/VEkqg6XXHRERmZ3NYb/UDlu8k=;
 b=HHM3jKlqb5X26mBRFsD9fw5P1MjZUiGWDaoGxngkOUjuZ5dFNTpjD798rKw8GJ45ZtvnSvf0d
 90SFK/4Eb5ICuvRht1mtLZquyu5ms+kCPxWy6f9+XSOw5aD7GeN5o8L
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: Hdo1eUPxk8Lb-Yo6xn4vAlLrn9FEOk2k
X-Authority-Analysis: v=2.4 cv=GolyPE1C c=1 sm=1 tr=0 ts=6a22a2b4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=aMhaXRkMA95IrCOZcTgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Hdo1eUPxk8Lb-Yo6xn4vAlLrn9FEOk2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfXzFf1+uk+TWFt
 U0dRHceu3G2kwhLIws7FNjDkdN69aHsC4KxucSrPntvdXiyG9zHXefM8KOS+lijTePHbFHBXi/w
 88kZy3UbxWWHrQcgJj4hekzTxegaIaJYlh4eTOjO3vq5FnINxm+IzsmLNjjTg3H0jC+Mng8h2Vl
 iy/P6OIDVMh1zKDxUM1MUmcDWLSd8xu8unm9/XugsjN1J776DF0dYHfwzQOjXPIW/lnXa2/OOLZ
 uhbP1TeXgnAPxtHUjYF8EKN5LxXZKIqjw4gtpf1BD5EjhbH42FlY2HP40pSSWDr5u8OmD/klK5f
 wWzyvOgENDEHtCQ8snnL7RDY4jms7kIZK3uVXXUj6pzZQP23IZ3b0XnJo04sr2w5TIXzmI9J27x
 LR4bykD0TOgPV37ESE9oRDKtDbgaO3c05AgMHgQBgIc23ZQS3xl+Z+GjDMzLwye329352uihJgp
 /Zytmd8XGjKBNRknsag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050099
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

Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
used on the Shikra CQM EVK board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 909f3c188e75..a6d72ff63e57 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1005,6 +1005,7 @@ CONFIG_DRM_MXSFB=m
 CONFIG_DRM_IMX_LCDIF=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
+CONFIG_DRM_PANEL_ILITEK_ILI7807S=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_HIMAX_HX8279=m
 CONFIG_DRM_PANEL_HIMAX_HX83112A=m

-- 
2.34.1

