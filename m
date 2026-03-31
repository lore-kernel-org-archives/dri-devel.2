Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E37109B492
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D602610EB5C;
	Tue, 31 Mar 2026 15:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIEKCuKD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SxN14XZM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B49910EB5C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:16 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VEh5kb842937
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=AorZKexh9awIlN41NVRQim
 rdv64tOibZaKooFtqlyts=; b=iIEKCuKDRN87Gzr+/jDzieICY90CNWvxu4i+VY
 Cba9CUUqirEG8oMlA5gCvi6ncn759Z/Q7iz2KZhxZhKEquVPFEIf7ojy6KiFa0Wm
 6sg502kViD2DypWd8Mg3nCO/JXhHLxFUAlOTL9ORbZf8lxcdykYO8WuCOKyl4A1J
 zvqyBlY8o7s9HHk0NuCDQvj9/Gd5zBl7bsyjMRV+S43Wqr978I2FVZ5oCnY/wfCc
 TBGfRBqqRd/L/CkAlDUaN99zvifA5pr3J/ixQDgAlp9YRg+0Ozv6rmLXmfvinSKe
 GPh1ElQ+VMk19/QXdq0x6eH6S5E8HZ2gtFpSM9QtM+KkLazA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d86ntb2mq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4987c698so707491cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971853; x=1775576653;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AorZKexh9awIlN41NVRQimrdv64tOibZaKooFtqlyts=;
 b=SxN14XZMcdxKtwg7Xxpaw8aiEXVWWmZcsFWt3VI3ZOfoxQkA5+dH6bTdWpekkFxDN+
 c/Jel+rscMTJSm7SIC90XlYQ+N4mUQuotg/GoDBYrDMtA59d09qm1osL6hB0K98cDDMY
 Sy4KtP2aITnIIi6B0afnolaRLPuCjir9Zj//3g6A+2ecab9eeT5LFZ3ycFl3rZ2PAad8
 UDp5aOke/zu0NMieWY8SVAzhIS7lA2a7l8LZoDQOVEUEVlb8b/8TejPt2r/xz/Ad+BN9
 owB2CbtFWEmUyM5tUb/+l4SYbQYybZJTcMAyasno3++amTL17d644LXKyGsVt841a8iM
 rVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971853; x=1775576653;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AorZKexh9awIlN41NVRQimrdv64tOibZaKooFtqlyts=;
 b=T+xWQT1WtsXWTVixSzCUOdMvWvga982LfhKsCnFyIrBrmh9WkM4yhLRlb/tRVNaUzz
 isDRXCHcfX35TB5KkV5kwKb/db0VJHTyJ+Jw2jDr7UGYQnwxr5X0vv39exMsdbtqqSEQ
 ernpsk+n3YR2c6Kbi4uoUwNJ27p/SzmkexsgjGcvrs/XgII/ShS3g0R1T6A1S/ndJq5e
 kE9T1hrZ+IQw4PT7GCtI1gCpuPzGng8HNKVQoR/b8cP/isnayRqgtDdgEZ5tkfYADsrW
 YuiOkZNJDZKgEzDBkk55dGhPAvLWqZTwAv85jLicMiF31f9bZpeOrNFgVO78TPHyW+rx
 uVJQ==
X-Gm-Message-State: AOJu0Yz6tLuoPsf/yKuz4BL7twt9FfXn516pLq7eB/v1u5MfQBohxY6w
 RQ2hjKvRuEHqbM4qO+jPDDItPfZj2YCkcQkDNDZDarOPPXw8ag1bitd2jpK3/48hmc277k0GruE
 LjMdmLC5V2//EapEmIUId2jHDMC7NG+c1Q98Kq5vxt8elt3Meg1hgncTdTgi3Zg5euxwrJe8=
X-Gm-Gg: ATEYQzx9ffXeWWXVeN18yA4dGRC2Ugs7njkMxCv9yxIyiFZMLeFE0kyQEBLoUxm46PA
 kPWa8na3TCCA1YEBbX285cBlVBqyxchO/8ejmPbX6rVEdrl/yE/1FmLD1uk4pDbg3mNoYXtfv0A
 ou7yD4oOZMzYAhVGKfp/VfEHQp5cKClqNlvmLT0fLTX4Cb5C71kH6vvGqdL1n87y2RpBlA1L2Yx
 +dTtqBR3kdsx4B/HuysbLMAvOlA8kJOvPWchQooI53EIBFkFWVrWFuNg4tQBAQfljGKQOjyVeVo
 3HUoacTKO7UjyAb9cr/u1GAwTu0dv52YJ+jS5x3Qytm/AfIELNFzbLWriRLKXisk3T8lnXImsFS
 H4aHN05ILJCBhHuBU2LRBqen2m85mwxPAiTG62dAUzpIrNEFbHfokcVZEtRG7bJ1qNK2LR7Z/ti
 pv1IU8AiILzYlXiex9K6Bu9/nP/2YkjojXwxE=
X-Received: by 2002:a05:622a:181d:b0:509:e46:84ea with SMTP id
 d75a77b69052e-50d2c9552f1mr51540671cf.34.1774971853419; 
 Tue, 31 Mar 2026 08:44:13 -0700 (PDT)
X-Received: by 2002:a05:622a:181d:b0:509:e46:84ea with SMTP id
 d75a77b69052e-50d2c9552f1mr51539941cf.34.1774971852840; 
 Tue, 31 Mar 2026 08:44:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838931b9sm25387461fa.23.2026.03.31.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:44:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/4] drm/panel: simple: add Waveshare LCD panels
Date: Tue, 31 Mar 2026 18:44:09 +0300
Message-Id: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnry2kC/2WNyw6CMBREf4XctSWlBXys/A/Dolyq1ADVXqga0
 n+3xaWbSU5yZmYF0s5oglO2gtPekLFTBLHLAHs13TQzXWQQXNRcSs5exAbsWFtXyCVWCos9RPn
 h9NW8t6FL82Na2rvGObWT0RuarftsT75I3t+oLxhnkh8PslSljAdnS5Q/FzWgHcc8BjQhhC+2v
 jfDtQAAAA==
X-Change-ID: 20260330-ws-lcd-b65c03c5ac17
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IWNKBHL94YpYEj2u2AsL1FWmBebCDkOGR5hvIzCIpq0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpy+vK8tE/ObFPuqxKYAiuAUUJmYF/YXc4214nk
 mAnSBg88DuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacvrygAKCRCLPIo+Aiko
 1V5fB/98V9lwylQa8zzgj3fwt4JQ3LfGXW+UD+eXJG7HuIGAdiVEyieiT57jVXa87YK9ayxCLYA
 Sr6N92wFC02eVMdaIt8w18zowVUd2cmXcn0jlsmmRzHy/hl9skw1aH4/czOjKc+zvHVTQGxLscQ
 2JN3ypmsPcP2gxWqxPtquVgxXp/vmr238uXMwBckAL9t6WXaTWEdZnVDSqHhhDwIEB1imjnc89Z
 dhXk9IRSneITFL8FY1R0HbYTvoG+0RsPbntfrqO6wgqqiLUC40fk/hBA2rw8asVfEZKw4O99qF1
 pY7VztUV8RS78+9Bh1aCpFVu48qLgjMzKXMPsHwzpw5gg9IW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: w9T54kAQfIw3Ya_M6LEkI4RXA39ixZEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfXwrySUrW2HNhH
 msRMw89IpJWulqAJgFn9FOGILXPoJT02cvz/oIz/uob8e3nTMUKHBBhysAF1lRKRbshjzcUwaa2
 +th7+UB2pjwCD0hdy0qcaOEQz01/8U1U3ysiuYk4kRntv9Sc+pIoZo2+jyfosjzPDKg1djFg13j
 0Q45oNyJCOf7s0wgkaeWsQwjFdMIGOBieZmfVDLJnW1kKrBoHUJmwlK1Jg19J5eBDY1Hn93/xr3
 6A5WHA8SrHsc9VU+aGUB2THF9gXa7V4wYtO0tk6CkPd5FXudzm6uX+AVa2jan4wA/oXw9xHqET5
 we/+SLS1qLszDGfNSQYt9k8ibRHjwEGcJvDa4KvKxbT26IsN2q/ILeb0mheGppvHuhTBcQlQYHf
 ABNh2HXIVU0VKUG62KSE7YQGVLgorTy2bmnJ2WsneTVmZVU9mTeU9qg2ibcIlljEgHR7oDKBXo3
 NRamwcvU3DZ6EoyKu7g==
X-Authority-Analysis: v=2.4 cv=IswTsb/g c=1 sm=1 tr=0 ts=69cbebcf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=Lb5j-gmOE-iAMMu9PAMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: w9T54kAQfIw3Ya_M6LEkI4RXA39ixZEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310151
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

Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
("dt-bindings: display: panel: Add waveshare DPI panel support")
described two of them in the bindings and commit 46be11b678e0
("drm/panel: simple: Add Waveshare 13.3" panel support") added
definitions for one of those panels. Add support for the rest of them.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Updated waveshare,dsi2dpi schema to implicitly mention LVDS
  (Krzysztof)
- Updated commit message to explain why the ICN6202 / ICN6211 bridges
  are not a part of the DT bindings.
- Link to v1: https://patch.msgid.link/20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com

---
Dmitry Baryshkov (4):
      dt-bindings: display: waveshare,dsp2dpi: describe DSI2LVDS setup
      drm/bridge: waveshare-dsi: support DSI LCD kits with LVDS panels
      dt-bindings: display: panel: add Waveshare LCD panels
      drm/panel: simple: add Waveshare LCD panels

 .../bindings/display/bridge/waveshare,dsi2dpi.yaml |   9 +-
 .../bindings/display/panel/panel-simple.yaml       |  28 ++
 drivers/gpu/drm/bridge/waveshare-dsi.c             |   5 +-
 drivers/gpu/drm/panel/panel-simple.c               | 381 +++++++++++++++++++++
 4 files changed, 418 insertions(+), 5 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260330-ws-lcd-b65c03c5ac17

Best regards,
--  
With best wishes
Dmitry

