Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AA60A2604
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0p3ZHfR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z2JI1tDQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D8711247C;
	Thu, 22 Oct 2026 09:50:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1992112479
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M704F74110574
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=; b=R0p3ZHfR2m7NmqN9
 Hm27yZpt95uO8ImcPXzWKdjr79OxiD5ci/ctxpfMM2ZDwVciTAOOsMjAcwThbpgk
 TUnaZZM2s8fYTj+RJearPO9BaFDY382vkgQR9pb54d6cLU4aAirMMhToKUvskbao
 yFcCX1kQ01jWCRg3t8nm0P3R0EwNQlrSP6Ko0ZNVDgmbz1d9veAcyIPfHYRLumZB
 aK1/Y+Q1F3N7SHuoPnJO+poi7VbpsvJGHYOK+jGxiOAkTcTg3heIT0oB1yuvXPvc
 FX9i+yHgFUaR3UDHeVUugycDb5hNpy53+RbCvRTVphQUwQ9FNakP+iG/vtTbeOxl
 ghtZWw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93aht9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso6281592eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792662619; x=1793267419;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=;
 b=Z2JI1tDQdQgaXf6uU8rTPupC5ZO8zEg9MsFGVeXlRF1hAoTtOLwiS3YlIZ/9D5r4a2
 VTS/Xdofpn5OeeR9xGqQA+z0ETGoiEreBRkj2qenCSD6HPDvHYwaidxbplUg3k5AJ1pL
 FO0LQj6uj3uGn1aMGDdjkCzuBp6bMc7nAcFDlKAFEBUinXkety61NgyeQB3GvFkCgAuK
 7xnCk1RhM4PpQsGQtdlcN4glj4iJ01+oUDE+esmdGnwSSiH8qW4JSJ6adu5HHHD5TDS7
 zHOOfBcYGbEIvmPOdPjdBLT/kTUT6RKaBgh4mXfQELFtS3hSLKi7YLo3kzHdExpp+pdf
 pA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662619; x=1793267419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=;
 b=uKyLPGCffhMJcDDMVZdVr6Z2wbsNSbDxgYmjnEeZsCGdoWlsmrfJQSYBQMXJhU05ca
 PdFTgFBShvcOXS9ZKwI6YBnJBvL7PULGsWs0gr8Y8nG7RITRUux7zlBxhUYqE3P3veOU
 F7Qo6iM3gpVW1frL+4GzRqos4sh8Ns0AwZmTFVgX+cC53LRp0FuxD3Betz75g4+ZrIyv
 CMEDT01p0/lalB8/K3LzHCz+idK5Pl+kodU1BIiNv7vpSUNJIxJANB/jC3qDlEZNe/+O
 e4wbUV7MiO4gpgVcGlSsqEUd/EwniXpP9WyhZTN2X8LMSC/t2rCUkr5R7PGOvCGEWxAq
 u6XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMG+9VsxgpTAMP++UaSRUoLZeuD8IPcNAHjXq7IP+vymXFdNESh3Z2MaD2POBuYMF+/26YbzpkRAA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2tCpZpX/vKK6s3gsvbj+jRebpJCvK7xQGRhnakGB9RGkIfWNV
 7gim5DN0YT1aYJN74XMNgxtVrtf7N1SfzBExsl2J0TOPxb0EyF+BR33t+cEvwJDZZ1t4KgGWWSm
 mDSwCDDjuGaEzztuIKTxLAP4VJ/GEUdFjjQ5clCfoRMhmFYtmYWtJuRkNdMZavFpr+6E+DxI=
X-Gm-Gg: AYBFou01rSmHFHiFMzsejtm3grcEhk5u3qMTL92b7Sn33a5DPLpYBKNUOxV4zH+wtW5
 O6Q3aXykdPW99BM/e5deqMP7JElC1Z6GoUddQMXi3jvOZ/sd2gkm0QRWayASENHYsHP+wWFEbvA
 R/Y3uNw0gobe+MFkzUx/7X82FmiH+z678dSC/eYVkaE9iNuspdTE6P6BnpmxrInKcGdWfggfbxO
 x7ZilSu8DzzYvxJFvhnHMVen3L/0dLJTzB304PtXV5/MhOAl9+nj5cXIw3hhALk8CosoYUm7uiv
 hVSAUDzaacINA/hPS3C03kzWRUrUOQ7b6yxqyBaUDQbYUF9rRFmBgseaFI8jSxh/5FHRZw3QCQT
 To/sSpasM7UAa01d+mwOjq3JSRhDWSDBOjAo=
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id
 5a478bee46e88-3674e93db10mr6656112eec.29.1792662618635; 
 Thu, 22 Oct 2026 02:50:18 -0700 (PDT)
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id
 5a478bee46e88-3674e93db10mr6656063eec.29.1792662618102; 
 Thu, 22 Oct 2026 02:50:18 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367417a2fadsm14418035eec.21.2026.10.22.02.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:50:16 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:19:43 +0530
Subject: [PATCH v3 2/5] drm/msm/dp: Add DisplayPort controller for
 Kaanapali
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-kaanapali_dp-v3-2-b5ae8e6083c3@oss.qualcomm.com>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792662591; l=1543;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=ATHzw5/SdPmSlyNoH0Ua5Hf2It3tpnIynG+5Y/cT+DI=;
 b=AMPRGKKPL0AAlxTb/0kO2ZhkzoiigdpHLJ7uyGg7Oexm7OibvBQOxl9aAiSXGNgikkJ3mwclS
 FY73FHzjfpZAxSo5s5/4S14TNoUhecfT0LIfb6LJXTLk2Lskl5sT5Ef
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX6Y7eQieRMNGL
 gNoolT3E2wz6IvrlQr0G2XIkh/vD73XTfBaE0pOlFvfMezeq5xqKnBQ8gyMMIdk4iiEHfcOE3uU
 GejL3PJ7rpEPfFtEy83PpdR/u6wpZbL3BqWk8pdeosXwuayf03HRSW0uEw6BWZP8qU9LDYcITir
 p+FCDBzV2CxleD4cfimIYvmFdXqGIM2G+DZovUOZkqa5lzYvykCN1mQPg0d9+pMh7M4vqbLiH4A
 vT8R1mIdU9KYglJ5fivsCT1BgJHxmOMECD6B3TYIDym+hVLgXw3Sy/SU5AG4WlNdx+Ummk30RyF
 uiRsDLydz3cKWZMhWsu+WwGqYM+ZqE9vCqQmDjUG8/BCUmxBwgTL3Dh0Z1V6BKJqhTBPgIwT9hB
 gYFAUm0QsFU07utzfplW+MPva9/j1T6Izrcfq49lDIXn+XzhqbMJm0da5DU486PrtD7J3Mj/zpR
 1Qt8YUN2sLMo8FJQTBQ==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ad9dc5b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-Dt519yxSYS-YsuSjdkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: LcwOtZoxQJSxnzMlq0ScWno4xNnTeVCa
X-Proofpoint-GUID: LcwOtZoxQJSxnzMlq0ScWno4xNnTeVCa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX0XrxW+6icKqW
 7WpYFG6tFxaYDa7Z5iMFKokbiWhsBA9BZqloKIbGVWQxp3zX2P0BMLCYysWbDn08BUMoouCHbyg
 TVSG22aZmyPUDr07hyOYFDpFj1qYsyY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220039
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

The Qualcomm Kaanapali platform comes with a DisplayPort controller
with a different base offset than the previous SM8650 SoC, add support
for this in the DisplayPort driver.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9299ce616fdb..348eb6967abf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -158,6 +158,11 @@ static const struct msm_dp_desc msm_dp_desc_sm8650[] = {
 	{}
 };
 
+static const struct msm_dp_desc msm_dp_desc_kaanapali[] = {
+	{ .io_start = 0x09ad2000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{}
+};
+
 static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
@@ -168,6 +173,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 
 static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,glymur-dp", .data = &msm_dp_desc_glymur },
+	{ .compatible = "qcom,kaanapali-dp", .data = &msm_dp_desc_kaanapali },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1

