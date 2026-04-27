Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093C8FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EDF10E269;
	Mon, 27 Apr 2026 06:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hSHs70Vd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YQYbBl5/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8146810E269
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:23 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R2jMIo2883937
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k9t2Skqy5JANgUESsWXa9v41qvVlWGnC0rrJSF/Em/Q=; b=hSHs70Vd+yUPJWyd
 gHC8XZXPfCL8oSQ/os1j7z1/ZUPcFBHGA/T7FnY0wCbXJ0PJhW+luAhrHwlZJ3k1
 t7fAS46HGGPaVCWs1vAZRKJH7KKGUTNQvSMB1ND540pEAuVtzQlv+Fstelt4ah/7
 0z4SCZpX//EP6aDBp4uuX/FxjaCRv3VIFuyIpQkigihekvxT+aWn/+Unl0ZWbi21
 XRgJ9BsvFuarm+0ZBTAf3liFbamz5tPXwhcZb/XCaVuqBwO+QJX/ew5MMmpdcqtI
 Hn1/Tsg8q6OdWhu6/aisW54TrbnWVnzhe9a+EIYjRAZZviateIXXwosiqAMSFkFn
 ErPJyg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya00n95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36472c6a7d8so1545634a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271962; x=1777876762;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k9t2Skqy5JANgUESsWXa9v41qvVlWGnC0rrJSF/Em/Q=;
 b=YQYbBl5/X8jpeok/gI1OkQDf4D1CQIOkyU5fHne9XNAjwuyw34bjyFPFwkwD25/2iB
 AO0Yp0I2R0IzkfI9+rvDDEn2ploBB2q1V7W/So0ACMQOebdS+kPp2cdXd9mg6lcsjOrx
 530WClwS3Crmtk5zF4aMJxlcW1fFu8zz4ypVwXKIe2A60lo5ow2e26dEvXb3QE4OV7nl
 SZy96iBDVkUin3sQeL1Xor7Bc/nYt42r4xkqg1v2ky+8YD2S4YOvRyjAFgqq+kOSvFdp
 /pZTcN8vNaNDNQiftepvAbR+zeI18TpdNsBkYyk5/Ghwb5II4huyF1sFU7G1BsGEOCxB
 9fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271962; x=1777876762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k9t2Skqy5JANgUESsWXa9v41qvVlWGnC0rrJSF/Em/Q=;
 b=Wi7P2T2Zdt7ANbIAXT6xG/+nAANGQ+pFPiqFC2PZ7JRIu4VpMozRwH5WQc4W/hempa
 oCR8GVhOLDAlHR6H90GwvCuVmDWPyGbvgGtI7+Z6Pb79Q0VkGRSZvJZgH6asN39/upKa
 OPWLhZ+YYi4WVERIZK7nmATCaKZOA6fRPCClKdRsw1EWR95rw6nRlCYTBP8oEqeOJumn
 C0A1NqavInH/upVqcI81j3nhOMV9DegEKrXgtm7yZYe2IcOrTYIS12NdNgcvKDB0K3IF
 YEp+pe17EqBE95oaWzDdg3p1Ls1OvehCDUrrhFzDdevzbIiZ4pNy7kXo2GVfH2UWalf/
 yASw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Eo9sJqzg5GTalY9J7sf7L8HG13JbDRnuejT2jb3zpjEDCBlIrxckDyBSqUhuvurzW2tGEN8NReRA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywJrIxRlWgUNsoY3/NcQoKGbd0q7+1AGWaGbCxuwAOTgU/ylsI
 PGGxNdm08rxgLtBZ/r3trksBGTom6rHx+xJ3Y2vb0p6xkEX8ZzPIC+qIvfFwcefsM7uOighc+7E
 AeQEllp5hJAMhHH8hIEGLBkSPurHehxTkjmUzTgqwD4AzP05O1WW79D4DY7lze/UubiyfFTQ=
X-Gm-Gg: AeBDiesAvxYyOr9hRJUSgNvdNZ18xRowefsM6cRBQxWEyVAfNoN6Fm/d6QaYrmEpYoV
 wC3S2Ms1OO1PeERNtp2PbP3gwRrthIGPPmyl1TPm0lTOD+zufphiQY4cGzvZ9Je82oMMIAFiAuk
 +u0IvNCTYzVoJ6QL3izadf9gfwksZXs6BJRoChaIZYuTME9Lsqqqev0+Mv2YBmVPvJ6pLbORHeK
 PPBOGOdjs6StLGgAQE0xEa38kWwMM3mIB2lbwqHG/abxmlpEhIZwUldqQBS/B9rSx4HzDEFBG6u
 PzqF6+Ldv1XNKr1U6AQ1UORmzdIJpNPiW0HciW/OU2UTlnNnfPgVFr6ShbUysy+Pb7TpujaKmO0
 KFUF4FvenpzNlUiNzhe4Z3BMScxWW9JaS7eNTNkpH3lr0iJq9MQXbRPUl
X-Received: by 2002:a17:90a:d50:b0:362:eaa6:a3a2 with SMTP id
 98e67ed59e1d1-362eaa6a580mr8394453a91.19.1777271961602; 
 Sun, 26 Apr 2026 23:39:21 -0700 (PDT)
X-Received: by 2002:a17:90a:d50:b0:362:eaa6:a3a2 with SMTP id
 98e67ed59e1d1-362eaa6a580mr8394436a91.19.1777271961165; 
 Sun, 26 Apr 2026 23:39:21 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:20 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:08:56 +0530
Subject: [PATCH v2 2/6] clk: qcom: gxclkctl: Use custom disable callback
 for gx_gdsc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gfx-clk-fixes-v2-2-797e54b3d464@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: 6Rbs3dNb7qc70ZenSY8MmLdRVoh9MjVd
X-Proofpoint-ORIG-GUID: 6Rbs3dNb7qc70ZenSY8MmLdRVoh9MjVd
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef049a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=r9sBLZ6K9uwiCka_ugMA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfX+MnxlElB+gIx
 lO7m4vYAMbAxHgqyRMMFfyrRSF1egUwvLY06QEPrhIrFRloY177RNqgI02G6qsHgmbt9HtufTGd
 FLreukCVtq3b/lBgSf2qd8t24SUzb86yoF02Y66JEZC9zlN0CKips1YDIEXc3Vutxk1FMsuJabo
 jSG0LkuWes+DAeYjpjEQ6aHvekepM2YzFZGwQbK1B0Kq19aPrBbCsVGcSTI3gpmcVLev1G1vMlf
 9n9lAcj3Cv/U5kamdqCclf0sRJllM7+tOlEi2d98hn6M37TRD+lQkPA9ufrw+UJX1Ji5WbudSfL
 dcVqPJtRfK52XPsX3CED+3NrFK/HPd2ZGzNI11dN5aG16OiJHo+IcvEQNVdIAgF99oZT8Q7m+6c
 11DUTL6oRWtbQNOATWlMNoPybKH/OqSFBkIWtwDd10OwEYahn8k3uOhd256navH3hSARhJoifzu
 GKwHai+pGsuhVqlJIJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270068
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

