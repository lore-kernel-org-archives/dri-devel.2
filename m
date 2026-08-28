Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6C4C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC2510F3CA;
	Fri, 28 Aug 2026 14:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgfnRBLO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBm+EQw6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFCC10F3C6
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:34 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkeqh3545313
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SijLPEyLEnAofFIXZf7zUa2hkI9h99tMoUcsgWGJx4U=; b=mgfnRBLO7+xtH49F
 uQrk2QC6D0rt/5dVeKPRy/DmH+pa88OO8C9ikkle5PujDNSOWr+ncp/TaZfxF0MW
 kAILn0v2fT77VqEkeNlxTQKzOnQ1Er+3tbblX3dh294Vlas3HUGqCiXxRpjuz83y
 jGnebV9LW5jQyJngOtI+sFo47kJpO6RowGCs6nXQxTR1MaFj8yve8B9hmyq9XJt1
 mKdBVDtYW8fIJXh7N9PsDyBrXuxgOHhADfrpJakoDHy2qbY5MHooOPaYPhHTzMPY
 z0dsFrGbRlh+UrF9jXSjbydb8O+nC8aYNTOjOc13JmCPDwVMCJUInYG5leUmSTaB
 pl11FQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb47n1xmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5276aa86d00so13262531cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925932; x=1788530732;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SijLPEyLEnAofFIXZf7zUa2hkI9h99tMoUcsgWGJx4U=;
 b=kBm+EQw6yz79xrYAEY1o0mIXsrpIrpsYOMGQptfFgkUX9NyCC821uXx31ZnSsMXus9
 izHARbYzcBfd0LPXQCpUrxO/VqF+RWNwgWAx2k3jdfbM/rGBM1vxTqZdlruvinvFhVxY
 xXSHhObVrq2bXy2V0E2XSnxz56XbGXzhOjch+G9TbtP3MVT5qrST3VgLeEpy1tCyj3gY
 86Rza0SGXIgdPzxKr1wEhwRi14LXmA7YempUU1PMPpiGXfFUHB6abTsjp7kNUx3QyTAV
 TQ77Y/e9yMhl9BxfJDfVyhxUFBI3Jiac4va8xIWNEr4qKeSDkbe9uuLksINGe9PM+2fe
 8lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925932; x=1788530732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SijLPEyLEnAofFIXZf7zUa2hkI9h99tMoUcsgWGJx4U=;
 b=lUerUp6/skWJ9Jt9z2Nj/ejbamOz2/wZTFsy0n/9/4sMSNPSHzD1UFxsyNWrSW3DIe
 0m1160a3PVaMx5bytJxnZphUKfG5oTDHS8tDRFCW+zhYW16dxmlCHuyo1hWTjICYGLYX
 9DntHU5BpHEbkJDq8f7OTeMU0yZa/etlQq04S5KFS65pgeBd7edflimuTttz/0CBlnGT
 +pTn9060mieirSULkir08ocfNtDkWEh4maZr0o4/k8GRpZ9KHTmFeQd4PJliEnIOCBtk
 s7mbODnOOzgyGrWVYic80/RiQd5/70zmyRgtE1rkJdFMf1lkoU7EEXiC7cvRvOngdQCa
 4nag==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1A/NpcHd+c5WM7N3yp1b6srKMKdh3L+R3TOGiwC/5xlMGBbuHGMN60Y/BlV1UcFiXJKW9djZipjc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0SH8kE7+BgmdhGfbVLCWY1+drWbSmSHZj3TrregDD5lw5TfHR
 VsUKvReTserbDDssAs39/uO0wz9+eOcL9TrTmpnCj6wPaYsBOfFUYht+TuMTHuWXE8Ovslf5PrE
 gxdj4Dpvsh5MONDOZM2rH2pZe/iwp/z/phEa/Zo+LlAPmSht1iO+1YzD7Bfm342oOTpp9wJU=
X-Gm-Gg: AR+sD12PXnts7P7HKMpq+fEh1bAUnazoCU8OV/ewsaJtm9I7K1jWMleJUhNbJOI532b
 c6PT8umVq/E82NdZbl0wChqCqe66bcbWmud36gxOqPoVNMqpiFfWugcWC0c68fx8LCHu4bkHbv3
 5XI/aPhky49KPutpp/SYABjFHht4EDIC6RKTOZgpiLl44XHym7TM+bRrExAe2kWmlK0G2fKNJX3
 zl4d3T3Z7S3g+yJvwc4KXlXkfKXQaSdaOv1jq8rKqxktV7ONx+U3PFd87OcBOY/htwPTU5++Lai
 kzWdFL2PB+Z82gvbWkL6+ixJdw7ux8vBNCNLSDkg3zmaa7m1DI69Ebdf9RNmZJRBJlzp2jqi9aA
 gfAiF17YpLl2kDJdVtPyCfuE=
X-Received: by 2002:ac8:7f11:0:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52fb94aef37mr78760331cf.9.1787925932542; 
 Fri, 28 Aug 2026 07:05:32 -0700 (PDT)
X-Received: by 2002:ac8:7f11:0:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52fb94aef37mr78758401cf.9.1787925931811; 
 Fri, 28 Aug 2026 07:05:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:00 +0200
Subject: [PATCH RFC/DO NOT MERGE 02/12] drm/msm: Properly handle
 msm_ioremap() without name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-2-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Xtl694D0DgWPJxP23Arvi4tkW3Ki0aks6uVKllA5u8c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWZqLsb4jv2eWG6WOsapWn81xKcReH32cGg8
 b8f2ZeSuxWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVmQAKCRDBN2bmhouD
 1y+CD/9MFWW20kWIW0usKkurL+trqzNP9TIAiBL1sxgQCfzfMzVh6USS1UWvFJjQD2Lpb2cRPUY
 zueE7v2zYP9txYiJg6btT/ijXKexAVRb0dCTAkaBwQmnXACWpieJurgtwp9Os5drwTu0LE21x/Q
 jSMaIZmvxzwL0m1YI/bAP0yj5CzRps2vOR8q2lQ7Nhx82fEKoaGcpVyXejgpg6oV1ZERZmEOQ/8
 /yo8+D2RfcgytxDu3qYnVmhvrb+n0YFMWbqpC0QEsjdT4zeu57rEs9NOLaaKvdO3S/VMbx8nMfK
 AmezuU6D8jMVsXDtfQGmSLvnj3b4Dwn/NQcmYoZl01swFhxSW3vXlA//RanOjXhSRJLvfajPkTd
 COeNEq3ncHYWh1z2iJrhl+5sZupEuVllbtl71ZUDS/gkrwAgVeV9kvSNsO0CcKYs536hEf1i3GV
 S9rAxzF0bBxTPg9TBEMHA6tz9ydenWhocPGKJLbEU8lPrsWmJZuymriUSHLRlfEK6g6hgqCCXCn
 M+Qs90q6T+9NnNhwnmPBDuNxtijSfOHwwgARf2IAjw2VhDgs1gqKejOqzzpkGq28CEmk6w3o6VG
 1EWfI3eQStM5WvJCcRbQCZudG83EAADcQkruZ1PcZM4CdJ28ANeG8o3/S8rzUiS8/+2ERJgd+aE
 ZSEHRDQ786rt4vg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=a8YAM0SF c=1 sm=1 tr=0 ts=6a9195ad cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=or9nyMeYumr6D7LEzWYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: fZwcJSPJfJi1hm25iAf21ccSUDktzHTI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX/+07M5HVibzT
 Mn3rb4ZLXpiNfFJ04T4mECYccq+/JtOJ2URou9vAli/cZA9Uy00lP1Xlt4KrPTGiIPpDmDe7feo
 42DJiGC/nABRu3Mgx9k068By9snGh4w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX30d4g6CesEx7
 Jp9YNw10GEonhO2ydg3gmNMBgLw3MSqj9la6IiVW5JmVzrQL9pchQlUNxkORhvC44ZpL8sV4pQd
 ho9uextLKl/rgpts7WJ9NYanbmLeh8ygr8SOtSDUteJPpOz6NtcgS6/iLtdNl2gFxiwbPn32Ve0
 8pxz4+Eq1Ygo9VG1CMR8HUEM9AT+1HSQUwGsebdVS2nDnL66C8sUKKZx8Q+VVGXKtQVjCc+Se8G
 +5DcGvvn++UJENKG3wmGwPDqJDW28b3ifsALd32yUy8Z8iTaW0/F2vg+4uyFJmVs0SPDJe7e0s5
 UB8fQhUrEyjaHSnxmD1LwCisPe6uVx+l05+XxPkn/CmDkIjRudBVd8irKt5oVycjR9d8Pz2ZhIr
 emnDPLm0YhQ8g6AfEsGZXuYvEfFhpGwTcejRPADVji9q7Mfn/UsBjFxD8ZImT1AtZeKLR+a0aSK
 0jcq+T2+AOvPmEwxpow==
X-Proofpoint-GUID: fZwcJSPJfJi1hm25iAf21ccSUDktzHTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

msm_ioremap() accepts being called without name of the region to map and
in such case maps by index 0.  However error paths still use the name in
error message.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
index a6efe1eac271..93b94e330cb8 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 
 	if (!res) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
+				      (name ? name : "#0"));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -86,7 +87,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 	ptr = devm_ioremap(&pdev->dev, res->start, size);
 	if (!ptr) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n",
+				      (name ? name : "#0"));
 		return ERR_PTR(-ENOMEM);
 	}
 

-- 
2.53.0

