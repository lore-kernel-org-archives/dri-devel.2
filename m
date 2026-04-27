Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167A5FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B0610E59F;
	Mon, 27 Apr 2026 06:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kClnZSqe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoR/xQz7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6207010E5A5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63QGdHkQ2878398
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HSBQhnmXvYIy80xyS3AQSG288sQxr/HSk95H/lT9kno=; b=kClnZSqe3MNu7d0V
 N2PI9R93KmB/Ek0+xOoyR72UKrbETS2m4rUUo982josgQARcxk9dpWxxn8lVCtyj
 Quy2Nsq8Ab/mmlhbKsrXCuKSViAASGihNT0GdyFHydyel8YHfor8ojoQxO2R1SYW
 8IWII5d0ZeP+yjpphUL8fGJ3DT1tpDKzEeUorGaadIZ34VCBFCSdJTT2yPpyteZT
 Nw+SH6tHpwV4iM8JT/V32s176lph0KhVu83GCagtpS5fyslpDXzSJgLJV0YHvv0V
 YLzLKO7F0FL6EjapQiwwK/V4DG0wpsoou/vKbSkK6s8rsrK9IA0HcUq4v4A2EoRS
 D65iZw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpcdmpts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbb57764aso11628192a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271975; x=1777876775;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HSBQhnmXvYIy80xyS3AQSG288sQxr/HSk95H/lT9kno=;
 b=VoR/xQz7g6J3B/4Y54mUEE9K2vZdGPuDbI0BsUgR1tODsmZVGSges2ORhR/OabQF4I
 HiM66IMkDf78JjjzvFMF/T7csEKsfCE5XUQ84IFiXJl2ZmY07/w48gp1Wh7VXbSQggin
 rwsoWS5pJhoCDeZJvMZ04gvcSaRRuhWF8Rh7+3sWewOov9gFp/aX5tu7w7WVUpuHErlo
 +b+ShXwNQHhdmVRJzQUJ2oMrC5ewyrfXBWr05IeaTq1BlAqWanZkxx8UEzdVpUkiqFnD
 zv0EgprD1kosHJs+a226ea/6hMEm2/2zKZmcN2KFEqdBAwCkPnMT55L8+Ejk0b44UKnb
 s82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271975; x=1777876775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HSBQhnmXvYIy80xyS3AQSG288sQxr/HSk95H/lT9kno=;
 b=OGSaTfpF44u3uDS0Ffab5FLK7ps6CzNjF3StBCDLSMr3eFMw1VGlxkOh7tBCr/wedc
 GW+dDwiwvWvwqIewiQLGPVzl2NRmsGYRa/mpq+T9sxrNvs2bWoqoc0P3xIf5c63uMaq3
 ZC3LQBtP8aaoFzFCfPRTTR+5gmOVU5DSEVAknC971mJXn3dY4cQ1sbGkJOiim7vbN+cX
 BRYZxoLefikFKB6cA0Y3A0C2kvuvJKn6yzMp9DJ77Xtsoiyu571FGO/FMFBCbFosTIYU
 G4N/ndzxn7y4FNKja8ZyU0VY0Uv9o3Bj0kX3UhU54ONfqtHKCBfAetp+oP5PFH+I+Vvu
 ccuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v0p1bKT2ivpX3XHw8+wLQhD+8MicGVs1Q7NAnWgvhKVpGULAuWlgsm9xT4QBLPBAB10p5tK6YmNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylKgp5HBeWYZe4x8c+dBMhq83kJ4jMXrCie0UIfLXGFlcpkvAX
 6aUwwUt7hR+ixre4tz8IdmW06s9+Yy/2I4SX3vCmhZFX1rcHoDD7D3664jgYha+R3DRXt1+vhz9
 XD9JPJHOGVBawtssMezWkUJnyZMxO6luj1yjqQQVeuXvaOJkWLjsfLsuQHKkZm12KGSa1D1o=
X-Gm-Gg: AeBDies4tLrbw+oh+wplHQrhiN+LUHNS3MX4AhrsVdDeRdTyJO1eL+DPPNXHmHM8Mh+
 XwqWSoJgyrFr5AE96EV75O/bCy5vLysIesVxiQ1dfni0wHwHW7wI7gPRAhPxPgdToBltASGlkS+
 o25E8Lc84Gg+J92DTQrCIh2u/XRQFg8niRtVb+G7f8x7BCIlQTG/gLho90Gf3zClEBvo0+YNHcr
 YqFdJkbwb8Q9toS6ld0j1qkXn3PlJDgo0fZ2nCgMC63r1K+8imcw2Nqmeebdit762LnF58gIMKL
 EOyjvos6tYIl1pKUkNuN4BH3ozBZ1ux8TfEhevIDa9Hos97AtSsNU1k7JvRkFa6hgrHZDzv64DL
 7LYpjjV+pUpzyYEcOGz0LoVDV8FgkkMxRUmoB86eLnSca3Y8Fq3ySzI6S
X-Received: by 2002:a17:90b:558e:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-36140290941mr27724106a91.8.1777271975225; 
 Sun, 26 Apr 2026 23:39:35 -0700 (PDT)
X-Received: by 2002:a17:90b:558e:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-36140290941mr27724083a91.8.1777271974659; 
 Sun, 26 Apr 2026 23:39:34 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:34 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:08:58 +0530
Subject: [PATCH v2 4/6] clk: qcom: gxclkctl: Remove GX/GMxC rail votes to
 align with IFPC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gfx-clk-fixes-v2-4-797e54b3d464@oss.qualcomm.com>
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfX8IYsKxRZEtur
 98/7nWkhMIuOyw9Fv4Q7VfgIY9z2SN+VoAURm/AY7V7Ubz3fRSoivkhVDl1dnyWxvq7qLvoWzCn
 5zfyQNJ54WEbApfK6m6zIPlb02Pir8R+6BMFkWqKmmSl+5C9+hlGpNgl16y/zyegitqNJ+asVm8
 PlPc2MZyp5V7XmAgqWMRC3oKnbKV+lj+9BeFBpyXnybnRXFzQ5feCRZY+QbfFaNE47yPucKkmi5
 FP0Pgvfv2NRxyep+RYhESbhgmQV6907PQiUYqmpcExYCk+GSoKgbpQHosP58Gvft5loV3nfHWF5
 RA3Z/UvsIv1RvXd+zsvjDt9yaUm++Jq4n5AFLVB+l/09HpR8YOIADToP+kr1x3jkDh6ffv4CHWB
 HG1AmfvdRLCqY9/7eeZLy7imVN40ptlsQ6tGvfNsC0+WxsowpWSlL6tMLxAKm5zsGrCMPpvlyRH
 vgVN4c0wjtG3jlOgqjg==
X-Authority-Analysis: v=2.4 cv=N5IZ0W9B c=1 sm=1 tr=0 ts=69ef04a7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TmjMgu7cwLfWQ02JmboA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: YRW6LZKudz6el38eOD4683BP4CVDJPnT
X-Proofpoint-GUID: YRW6LZKudz6el38eOD4683BP4CVDJPnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270068
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

The GX GDSC control is handled through a dedicated clock controller,
and the enable/disable sequencing depends on correct rail voting.
The driver votes for the GX/GMxC rails and CX GDSC before toggling
the GX GDSC. Currently, during GMU runtime PM resume, rails remain
enabled due to upstream votes propagated via RPM-enabled devlinks
and explicit pm_runtime votes on GX GDSC.

This is not an expected behaviour of IFPC(Inter Frame Power Collapse)
requirements of GPU as GMU firmware is expected to control these rails,
except during the GPU/GMU recovery via the OS and that is where the GX
GDSC should be voting for the rails (GX/GMxC and CX GDSC) before
toggling the GX GDSC.

Thus, disable runtime PM after successfully registering the clock
controller.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gxclkctl-kaanapali.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gxclkctl-kaanapali.c b/drivers/clk/qcom/gxclkctl-kaanapali.c
index d7cf6834dd77c2a5320ffb8548cdb515be237bdc..d470ade11b0d11eb40843fe84c809e71646dce27 100644
--- a/drivers/clk/qcom/gxclkctl-kaanapali.c
+++ b/drivers/clk/qcom/gxclkctl-kaanapali.c
@@ -7,6 +7,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
@@ -61,7 +62,15 @@ MODULE_DEVICE_TABLE(of, gx_clkctl_kaanapali_match_table);
 
 static int gx_clkctl_kaanapali_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc);
+	int ret;
+
+	ret = qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gx_clkctl_kaanapali_driver = {

-- 
2.34.1

