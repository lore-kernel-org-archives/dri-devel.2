Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579C606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MpVQj+cU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GqsBO8Yw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A554110FFD2;
	Thu, 12 Nov 2026 10:16:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C3C10FFB1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC8s7Ox1475415
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GC7j+bLk9a7PYeEVPSKQ1oQw3cXefAOiXA8ZNTCvJwU=; b=MpVQj+cUWHnQLRRB
 M7ODXwD5/iVwvCTq+2+cdi+Wmk7DMSDlL3m9t38XikfXP7kUWvkvmRW9Du56HaJU
 ThyPlxdQ2/Zz7tdzJLVKOAFy9sQzUrHp0ogk9v8gRUGTMw1676lIqAxyHHiPUouh
 qKKNu0W4c9MmiGuu/10RSvaH1EAsH+DYOGBCJ4pQqRVHf36CgO1MghQ9HwQHa/o3
 vZ/cMHJHNeo+TX2rkt0kOv4tWVF0SihjHUYC5aPDdqULA1mBqQV7aBUqxK62Aq9Z
 o8yKX4s0H5IrhrRQiLqCtvGaL0Tqo3npZuuaZWWZE4vHrLGCOA9DUXLwEdF9+bfr
 xUkcSg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymuvm0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b647bbf87aso3643575b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794478568; x=1795083368;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GC7j+bLk9a7PYeEVPSKQ1oQw3cXefAOiXA8ZNTCvJwU=;
 b=GqsBO8YwN6Y1yTu8abBBT3xE0N3iimzBjDqxzz/B2SgvSzVIX5b766PBGmTj/Z/BzF
 q6N1X9WFF1g6kc4cYkc/UQD5uS9J44KZ4Cw/qLxn1WMz4Cu1U3dCQ2XaI+QlixzW4TPS
 cBogjIh3tZR9vK1xL/QstGS0U/L550KHPpcA07cHg9T64TyG2ScRcbq/WJkAqPvTTJEV
 tJYLarsspsNwlGbaCqscDlPPPkmw8jW2GoqwPOOOo9qgQn3eWWWspkJq3cCXLl4qQiTi
 lpeMVdDT3LQPqittp9kxaGwpjt8bnCTHfqNG42VOWyBIjGwfFS/KE7wK2oiSs067L2Pg
 iHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478568; x=1795083368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GC7j+bLk9a7PYeEVPSKQ1oQw3cXefAOiXA8ZNTCvJwU=;
 b=PNDRatruypaANpOPP0OPcSPH4zBhPDtedcRlHMSF9bVe+SNUSEAv3sN199CxmjtNqz
 IEBgspJy7YXFUiv2wjvtjx0ZILbldABjQsDGspLX6ZQOiKo3mmXb61qQlZb6F00WPDuo
 C373xZirrvN/gXeABdk5jdFvQAG+CkwbpUOf5493BVwRdlMBYUXSJnbySLP23mYc4/et
 5E/n/fsfyByKS67JFGoJ6yzBvASBRw/Nwtx3epFw3AoXD5GgMbnr5Sog2+X8ay5gGhU1
 +wPI7BWTkxbDywyuPf2GEbOUIXyA5mrHcH4Nom+PqpvcDB+pm7Zndu/MGMq7W/m70ZZD
 w7Iw==
X-Gm-Message-State: APuU4Z9hqfVB0iBF2Ebdhg9Kci0lNnxOydANiHUXz2Mg5XCGTg+Kj0VK
 EKMOsIC6++PjpcgbkWT96fmsDi2VzyXS0xG+Xt+xihhBWeGoeX20L0DCkdeKOlrSHVvqJPt0gAk
 mfHbN2OqzatBPxrK6Oo0eyjnhbYdW2w84pLBP3KsB5O0W5yRA19xMWuRB4haoUsohBihxU8o=
X-Gm-Gg: AYBFou0YKpDArZWOsfjaGB4+A3hddtOQX+pAUD32ViR3pfX7hHT2Q5vCIbDIHrcOIFj
 LUveYlgmNEuiWvSur7V90A/QgiyH7U/Snzug8c4aKmkxjoKGIiq8frDOcH0oLdol0tQyogr0GxM
 Ksojo6gf6iZ2bNQodj/gI+LctSMikopw6FBa5JuR0Fd68PBjNdHDjDr9ioFJfgHnBb5qytDA7gx
 PmINrMrw1ebZxxQi4kWgJBq1DuD4D/zHXNC6I56KcCTw47aGnj0qQvj8572tKG9xg7gM+d+BQZk
 28vn60VFHHhBMw1traKDlWEWSEeYjV2t4omwBO4H4COkxNzyMJgz6b/5zaaDwhN1H3KiLMk4O6c
 TCIg9r7DUD9qvyRKyaxlrWXY+0iEKttfENsK0x/4HhyxiB0fpWQCLJq7hKDe81Zqsm10125iMOg
 Ie
X-Received: by 2002:a05:6a00:18a1:b0:87a:3144:8c4c with SMTP id
 d2e1a72fcca58-8bc1ec7bd3dmr5363807b3a.59.1794478568166; 
 Thu, 12 Nov 2026 02:16:08 -0800 (PST)
X-Received: by 2002:a05:6a00:18a1:b0:87a:3144:8c4c with SMTP id
 d2e1a72fcca58-8bc1ec7bd3dmr5363785b3a.59.1794478567683; 
 Thu, 12 Nov 2026 02:16:07 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaae3e110sm3185872b3a.36.2026.11.12.02.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:16:07 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:45:36 +0530
Subject: [PATCH 3/4] arm64: defconfig: Enable the Parade PS195 bridge
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mahua-hdmi-v1-3-b463d7b1dd7e@oss.qualcomm.com>
References: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
In-Reply-To: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794478537; l=743;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=Op3gUFINVffD/rIMQugm4ViW6Z9HUJGr5mZ8N4cmk/0=;
 b=VFt2bDLQa1znRWwkyQjTJ6Itr1GLQr2wmVOMbafYoqo5llfO2tZtAICGK0DZFNw8vH2heK6Pt
 R1UPFH4ofI9C02vubBJ+HpSSnAxHk2NN/535QlUjIeWOuq0iWQ6SRXw
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: YTqKAOOFjIS_ChoDCtjddhVyoOVYzo-7
X-Proofpoint-ORIG-GUID: YTqKAOOFjIS_ChoDCtjddhVyoOVYzo-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX7yx5fTUnNAQw
 IPc8UH92M74W42/zaz0d0useOPEOwi/fFwScm9kD/YqRIlVGmfA+bQR8ENIcBeKGuKQe3ym5T0K
 Npy2fJaL02QD3/t+6v+mm3irB16vT0gpq+csBs3gqVOcGIMQcA/jl8KRwMLoPJ6jYXHmshfhyYF
 Yh5cdfjr3rCoUqXlxAFjfVBvNOgrVaWGUHJCuWXZHty2GI1r2fXB2/yFKrQ/ES/Sao9vTzjZhsb
 J0fr8nCubdkBR/z7LA5zybNL569RCmhloqJJ93aGxM25tBo4S4b7+PPsmPeqFwMErdH5InwIpTx
 j1h7KUxibZSVdAMCe3QtkwcQJelYfOmsNDqDkcv6Yjm/Ea82buguT8MHh6+NzmFNdC3gGRGw0yw
 47L3a27mPrKDaRBaBDlVffRxv84oVRMrwNHZ6vhi+GV5ICppsOfy51k27mEiA+votE8pkFkrwQ8
 1SMdirdZmnbxM0DocOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX/SZ2LDf9/bJI
 SVYHOpQ5xTWxolqQ2GcN22TY2frU2ALTh05qt3peJ+6vdNMZ0hvELNQKFyeUhuzIO8Ub4Egxb0W
 tvKISScxwCGiuPM28ypfFg4k2otADlY=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af591e9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9THlnupo0N1hDek0eNUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120040
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Enable the PS195 bridge driver as a module for HDMI output on Glymur,
Mahua and Kalambo CRDs.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21..69db247447c4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -984,6 +984,7 @@ CONFIG_DRM_LONTIUM_LT9611UXC=m
 CONFIG_DRM_LONTIUM_LT8713SX=m
 CONFIG_DRM_ITE_IT66121=m
 CONFIG_DRM_NWL_MIPI_DSI=m
+CONFIG_DRM_PARADE_PS195=m
 CONFIG_DRM_PARADE_PS8640=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_SIMPLE_BRIDGE=m

-- 
2.34.1

