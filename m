Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA9BEDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D889E10E391;
	Tue,  7 Apr 2026 09:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbH9fGus";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hEpKWRiN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A7810E391
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:31:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63768Hdv2580030
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KK5gjgnaalniXHVQETjquADftfg1WO+N6PsIIlecERI=; b=bbH9fGusY9Nosdil
 zvPpKkdKOk9iwDUSH3MNOUa3h7rm0A4Fhyo2uKZX13wI+OXgkOy1jWXzo2tA5ZPG
 b/9mZ666FH44XDFmteP098d6D/ZDeKo5/KzP88OY/jVdpG82zifEKuLFw8ReDg5p
 8Ij7CvYQSU88KUC0nuF4ePeopRqF9eVzNWeFFTVduxHoH4L+mWCX9bGbhKHpX+2O
 oCdYri0USs5e2US8vLQH2vBLLIrzAABJ0DYjAu94IzZ0W+hQ0wrVqV/hGnqizYmU
 iA77W9tHgERWUg1BRUXG5t+8k79cn+Yh4v9XyOe79jmyPHBCGUDrQSjn3Ou+qm4O
 WPO0Vw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf22h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:31:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2454fc131so86437375ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554297; x=1776159097;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KK5gjgnaalniXHVQETjquADftfg1WO+N6PsIIlecERI=;
 b=hEpKWRiN9NneekXaV9Fw7PzDuGQ2/3A3QjfM1Zfmm5Umpoevg3wZsT9wSBj6Ba3BnF
 O/uIW6mZ2Di2yS3MUdZBa6IdL6PM/SKrEQjczokoqBacL1rZCjzXu482ED10ILnAZZgb
 ptxTCbpj+kOS03i3OhBfOj5UCnUFjMlL2p66f85EiSTTRiYHqh2sR+gbScWt7theP+gv
 j0Pla0kr833pIPmq8LvevPjLwHvJu+NVjDioISe7qFlUMAR+j+P3yHV6UUQcmQJXkl8m
 +Tbl9lhXqjuKiclF51tzZcxbXrMgucP97zl2fBqRqpW+sUV/RDDZJL6d2jbIcFmHBvi8
 bkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554297; x=1776159097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KK5gjgnaalniXHVQETjquADftfg1WO+N6PsIIlecERI=;
 b=XZr2BoViE51HJW07QyrFHbnsYI/D63Px70b8NUy9pHw4J4+UssZoNZrPHWf/C/POTo
 ZdnZgNDCSMd8hV9Phy11F7/+lIiSOX+g8Ug0CBe1q/WIPy0VUGtsxbk+fBccLaVo58s1
 sRA+lVtAwoV8LuzWxTyU7fdxAIJvRbzaStBVUupuzClng3VjmWgiFgilGBQpQf/1G4c7
 P5OrEq+WdEMYAZPziXJtWaEhBq4EeK8iHWBCDXj6oZGVzYwQOiK1wVEfuVY4+QRL7JaO
 6FV9VeXJN5Db1txmG7kWeArLSn6136zMyHfvULV2F4WFXIZq9KhB9pXL/FLoNohWfe9F
 7rnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVeY00XkOh4CgFVUztfhD14wdypzZt7PDP2Scy+M2adhZHED8UeJDa/SnZqYOeN9hQrAEW2afjEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQiMnfOXIu49xyAMQeVLHJRZAzNoIBHdMYQlNQfZ/E9e76rAla
 UYarOSU0Zp5Yy6Vk5AGeRZnrjWaSKg0roDD1rm2T5pQS0D1IYc1aeM75oXe1q/q6+JFbj4254Gx
 EWBHhPD5tSBB4q3YvGR+dEqakzZBO5zGvjtGZ268cf7nhZFRMSRRo8N5o620RWXLYvNveBUI=
X-Gm-Gg: AeBDieuQEj84tpJijC13tRjwcz128LU/yLZn6ZPDJvXPRFPWqGsubD1HC5F59La0htD
 BszX6TI7OXBtciP5OKskJJXm9rRJ40gQOz29ilEdEv2cEH/BqitTFWrDRtdT+A2l36wtR7G4ozN
 KJ7+s5/6UQSXGA9WimSm6v3Q3usu1PGzDs2ZPo+4PMnDH/qOxdLTouZzpUrOChmB06mTAr1M6iu
 411p18iCdwU75IlHrFVhdQcx+cbLcTxsCRjKjrtA/w8QmnCPsRHdjjqFwre8msQxV6+q4tOp8aX
 1d2hshL+eYWHlb7U5aazH+pHjDBQRjDC4SA2jKVi4K8Y426oN4uGCxFJdvyGBcOF8EJNNCQWCPH
 JUTuStO8Pnvqq0RGWQUGQrKFlbu3YboITA22yryZuaNJdcw==
X-Received: by 2002:a17:903:2c05:b0:2b0:6475:73d0 with SMTP id
 d9443c01a7336-2b281854f0fmr177278615ad.12.1775554296686; 
 Tue, 07 Apr 2026 02:31:36 -0700 (PDT)
X-Received: by 2002:a17:903:2c05:b0:2b0:6475:73d0 with SMTP id
 d9443c01a7336-2b281854f0fmr177278225ad.12.1775554296196; 
 Tue, 07 Apr 2026 02:31:36 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:31:35 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 15:00:52 +0530
Subject: [PATCH 2/6] clk: qcom: gxclkctl: Use custom disable callback for
 gx_gdsc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-gfx-clk-fixes-v1-2-4bb5583a5054@oss.qualcomm.com>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX0t6EsgDNwdQU
 GDvsI/QietYsWxN5aNkSGr5hJGqqisC3I8KiS4fkDD9V5OQ89u7/cnFKjmP07+XRbags44tOzUC
 HK6lf9G8UbpFTfzxqNeeMnOwj6UFLtu+BpA7Sh+AlxwQr3bQuKaukTAOES/ppAC/V+5c8jOovxr
 8AYRWM6yo616Nz20bAsxYyosTuZ/Ixv6bVC1CvfN5D3uEYIU3fC+EsSVnrYutvtlaVpjgDsnyol
 JBQt5+UaVDRE5EUpjyB532KoHmo63SEF35MC7382rAQVBiCECHubejPEGlGengn2vg/o3AzvWM9
 0QfrtYdymMd0GnaUUCVpgU4K6E00op5mjG8a3KK+ba23BlxESMeA+VdGyUk5GqGfTf0Pvj4JaFq
 37EaDAM2olxZSK2+ClVOJ3lGd/t3QJG4jDHAlNr0qHhbVItGaIpYx7347IypKcLIKKtnVPeO/N2
 OV23O80/AA3YIBxGYGA==
X-Proofpoint-ORIG-GUID: 3ehiiZEPYZVjXpfsW3923FDXalLKa7PR
X-Proofpoint-GUID: 3ehiiZEPYZVjXpfsW3923FDXalLKa7PR
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d4cef9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=r9sBLZ6K9uwiCka_ugMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070087
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

The GX GDSC represents a special GPU power domain that must not be
disabled during normal runtime PM flows. As per the GMU architecture,
GX GDSC should only be force-disabled during GMU/GPU recovery, where the
OS explicitly resets the GX power domain.

However, when managed by the generic GDSC runtime PM path, GX GDSC may be
disabled during GMU runtime suspend, resulting in warnings such as:

  gx_clkctl_gx_gdsc status stuck at 'on'

and failures in gdsc_toggle_logic() during rpm suspend.

Use the newly added custom disable callback for gx_gdsc to ensure the
GDSC is toggled only in recovery scenarios, while preventing unintended
disable attempts during normal GMU runtime PM operations.

Reported-by: Pengyu Luo <mitltlatltl@gmail.com>
Closes: https://lore.kernel.org/all/CAH2e8h4Vp9fJYAUUbOmoHSKB25wakPBvmpwa62BTRqgRQbMWuw@mail.gmail.com/
Reported-by: Alexander Koskovich <akoskovich@pm.me>
Closes: https://lore.kernel.org/all/gwVAH2mJerU4dBInw8pKmOs5aQK55Q7W6q_UQAlLFCsEgX6eyvSgXAWbNNMqAX4WmPlYCKUSMhfkr5Jry4Ps5EqnxYZqEEDd3Whwv7ZXGlc=@pm.me/
Fixes: 5af11acae660 ("clk: qcom: Add a driver for SM8750 GPU clocks")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gxclkctl-kaanapali.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gxclkctl-kaanapali.c b/drivers/clk/qcom/gxclkctl-kaanapali.c
index 40d856378a74aeb706c2f4a7a17a2c5602042af2..d7cf6834dd77c2a5320ffb8548cdb515be237bdc 100644
--- a/drivers/clk/qcom/gxclkctl-kaanapali.c
+++ b/drivers/clk/qcom/gxclkctl-kaanapali.c
@@ -26,6 +26,7 @@ static struct gdsc gx_clkctl_gx_gdsc = {
 	.pd = {
 		.name = "gx_clkctl_gx_gdsc",
 		.power_on = gdsc_gx_do_nothing_enable,
+		.power_off = gdsc_gx_disable,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,

-- 
2.34.1

