Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A803CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA3910EAE2;
	Mon, 12 Oct 2026 13:33:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BD210EAE2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxtvL1404744
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eiucA+wtjzHIfQz9RvwaXxBQzP8Dhf3ByqiqoY+aurM=; b=iZvxhZ/2MXPWUIP5
 MtEdc6lZPHqkI/pQ2Tj6ef3weoMZbdUF4TJiw3SA3uvS6XtgzgIhV+ToKI1TL01L
 5AIOtTnxMqVRPolIBO8oHAI9sO/vJNlNxsZoT1J4TASQ+D6ckh7qdPD2Od+rdsf6
 GrVgU2xqv38fnzahVjuN9+UvVC2i5PdvHakUQRY66oiypMFQAgOf4P5FuDrwPHC/
 XpVGDptOM+dno7M/QuvPeLWN7Xgq3/QvM5BbgNIY9bRj46sH47bx27ldJndG3tLu
 rcl9L0CqrW0ImOFy//XeM+TGHXgvcJ9Gqq4N9uFQf5IBhKgKZf80xC3FphB8nwg8
 uvEI7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ks9wn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso3349805eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812003; x=1792416803;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eiucA+wtjzHIfQz9RvwaXxBQzP8Dhf3ByqiqoY+aurM=;
 b=Vp5EivO3FTspLHFDEvRpIbcrSfKq4pFlArF/mPPt32w3JaNxRQYQPvY0fXLp0ARt9B
 pi9uo8qfs74OaKAJiuuieXGZAi99fgic3oI1t8mCYjsLEk4r/fCjPmwOrhedPJk/sozk
 9BdBHoz1llZrXdKXADbgM0IPxGzbvq4NOPfC8MjQUyNGEgJa5lkEB2Qpo0ooLjbcbezP
 Nfa5sVBcLaE1rsQ5DKn+vTQguLIoHXUF5hLphmIRAf2vBQVQ3pYGT9WryohsApYvE5vJ
 YJh3KdxweVJBwIxGh28tB0lXoZ6l5DnZxr8BwEsiumbbhAKfk16Vz6wSTXMCMpEvRbzj
 yHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812003; x=1792416803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eiucA+wtjzHIfQz9RvwaXxBQzP8Dhf3ByqiqoY+aurM=;
 b=AUrfTDsO14wc5KUlyC2H8Y5VaAvyW2p8zUnwdP3fvW3idLmsB8FORVQq7fY/tWHb0W
 /FCpTifvihef+VAK3DrJt5HKObOBVNMyd1iTc2Ims06JtlKhzqzyC6nfs766OCKdDrGB
 Q3hTUcS20kDFQ33uB4PmXbgemOleih1BFjIo0AH5c+IJkFP5lZHHmktNNEoN6d2mc7EE
 at0I3WvvRmjO+F2v9RIHgvg+yf88sNj3j/HnDZOCzxRX8ScHvpXYskg4ATRWOd2NNURQ
 PmOyABRE2BJcTKklwcUu1oxtugnwhmaEo8XTUv4S/k4QI/wmVelmafrJiKKgTiOtmwjj
 Z1sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPPiBIRcLxeMci5riCPEHST9AbH3IoSck2rbCJYLr914hN4oZWorwd3c4BSFB+KRGJj/UkDDY5iwk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMJvSE6C+iEgtXXWWgUfsys2+C0Mt0QGVpAlnVMajBv+EnKpkN
 CpUTfaazvHJa5kukx6KzEUo6zrJ1ANB1XSiUSsbkWs0uesBGKviCDoRvl+snsHyd7uFHVooNtAB
 kwStbZlTWOTz+/mYJ/q9qwTochqGSoAWEhZgw3eKkLeP85EF+I62I0u2ST+KEgKYGBDzUqDI=
X-Gm-Gg: AYBFou0N14w1BuyMZxPM1QPBVTA2AvhaXpiwpmTonP9hHDZmXmK1j//0KHl0Y5Nf5Bs
 nkFj05tQQzmtmSMAhuN3Yt2s7pxKurGaeNScJu9IapPQbPP9DUK8pETeDZ+Y1JuTfXw+lCtqNTo
 CsgrfHS3I8syTgi//IuHAz4p471X3uAzLspufDstG2Nt45EZaTWx6gIp83ovQV/sndE25iGMFyo
 H2Fu4VCNt/bGYRVgI3vWQ2353rf0bEjNS2YjjbsLitbDzYtJAUhB80+JIXdOt//Grw6Md18BWxt
 f/oXVewm+GRKvUyn0q8+gipvkTZRNwZtBJS8J/lg7fBpe1TYTqHfxsG4cmO8VYN8aTHNDn+nGoy
 UtpLdxbNBaMiLBs5DlGUiwoOOZFg=
X-Received: by 2002:a05:693c:88dc:10b0:35a:60d6:8c09 with SMTP id
 5a478bee46e88-35a60d6b499mr4823872eec.1.1791812002565; 
 Mon, 12 Oct 2026 06:33:22 -0700 (PDT)
X-Received: by 2002:a05:693c:88dc:10b0:35a:60d6:8c09 with SMTP id
 5a478bee46e88-35a60d6b499mr4823825eec.1.1791812001787; 
 Mon, 12 Oct 2026 06:33:21 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:21 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:15 +0530
Subject: [PATCH v2 05/13] drm/msm: mdss: Add support for MDSS on Nord
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-5-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=978;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=cUv9ygkqVGKsKi0AqbVOUesQJiSTwCdwgeTcXPt+zc0=;
 b=8YJL9G8DTZYEfNm8VXZm1uKJy9LZZzb1+TO8eXus0vwYp4yGL7I4sSgLs9/5Lathnfe2tO+16
 iROM3kvT4CIAuf4ym5oR7OWLL0iGPGYZIJ8+7zujLY74xGAU4ipu3pR
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX8iTWvL2MffZQ
 O+wlJm4tGU2IdJ61yRhZpW9iS/ftrctaLP0I3JTHlGYwTWb2gRAtN8ksG1bJDAJmTTa5OKjcbay
 Z44BhzmBcaCGxZMwkyK3czHlAZbAVQ4wubtWSJp8sDESFmbwJXlfAb1L637aK1WMKa5w7U9O4m7
 p8TEvGcUVlL6ft/7lTUDw1Dugt6fXTtvapO/PJQTUh9duh8cWGXOb86qeEWx4mglZK9N8+RZuXD
 zOE/hYyTCXvh/53xfaAUUvm4eGm+N8iegXknaAQ1P36+fDrOn74hCb0PO9xxrxz1+gUffXoVspr
 3mLPpZkuFTSusvJ2Udf5UYaaee0BBENOoTw2sKhdFGFaChxhBIogpH8fOVgoc9w4r0L5fhR+2Cy
 1UfY0plG0KB/Q9oQBnVWR4we9qymgxye4cApZnwzaEoCLZN25U7M3W5ts/Sl4r4BBQd9p2NcHv9
 ymxdw2CXJgdfgF0EBtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX7wlpCswgdmWW
 QHOw9NWam/b1XmQyHp90f5WQ8PtT7pOupHV+9ACTmeTdz5/OZTBPRF6rKkkdnrArawwO/8PvjSx
 q8ZamoE6MpKbljm/iRGSaJxOScKBuaA=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acce1a3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ikCT10dxFQO67KJDykEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 9Z2ad7NPwU_GFcNb9uMLKmbNS67HCBST
X-Proofpoint-ORIG-GUID: 9Z2ad7NPwU_GFcNb9uMLKmbNS67HCBST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120053
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add Mobile Display Subsystem (MDSS) support for the Nord
platform.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..90bcc8c28dc2 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -531,6 +531,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
 	{ .compatible = "qcom,milos-mdss", .data = &data_14k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,nord-mdss", .data = &data_57k },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },

-- 
2.34.1

