Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E622606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PI0xYDhQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EipXOWGn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFFA112A1A;
	Fri, 23 Oct 2026 08:14:07 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259F1112A1A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F7wj3153902
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vdRIw8it8cCmifIaL+Ne4/v9Isf9Dn09v5JwPLmDqjs=; b=PI0xYDhQ4saNVgKA
 yA/jd9zqnE1sjB1euDP+1H9mg9nZaC21QRdCTZyvzTSWv1juXqVm2CXZEShk1Su2
 qXu21l+QZIq2RoJKEaJLt91vgJH0WFwBXodmouE83aKecv0z3rtsYa7euEpxDTNW
 B8qUamqPjmhEmL14DwiJrfMFBxxkxRRN5JIZ09tuR4XpEj0g8LeHDjp3f2qpheF0
 FwaGzfeFiZAfouj2rnkK3WQT5H1t1PL1tD44w09p9DTrpyrtQCWMzgY4akdc+bq6
 g+2vR7ihX0uK9b9KOL+YCVC9bYIGK3GhWcusXzOk0YIatC40ZnpMGLRamEtw5Poz
 9ni4VA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmraneb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f13c143c8so115411385a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743234; x=1793348034;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vdRIw8it8cCmifIaL+Ne4/v9Isf9Dn09v5JwPLmDqjs=;
 b=EipXOWGnYFTYVBvQHX6JPx3QjdVS+8zLR9DaAkQBA6NGYw2ysEsVyK6j/d3iUzSlMr
 zroGWsdcteRG5wrWrTQYyzSNXR/HYFUqZr5DHnzENSnLmFiK0uF7WwCtzUvhz/vYLdJY
 r7cmsK1fF8eIIpd0cra1Xuw+Gbm8G9QwAOzygxLIvYW0/asXpPe7lwRWRAORdjaw/t30
 JqH2SiXDCIDiWk/kFMW38sWBK/rGUoXy2hutPfUvVxoH1VZ6ijpjTBkdgi1B9G4jSfUq
 9Tci8cXEue8Ok9urmpBThDn5HkeMT08NpwdC2bQGHnrJdoeAWiITKfZCyeTxIYxVTGf6
 2FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743234; x=1793348034;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vdRIw8it8cCmifIaL+Ne4/v9Isf9Dn09v5JwPLmDqjs=;
 b=e6YUwyFvNciph+BfXlsoJovg/Q9tU4iygrQ1Sa3zd6J+8a9OScSsAXGaim/14TAi+R
 JcKxRCgI4Om5wsstNc3FuQ1aEgdt0eIfnYhg243ko5I+DD+AvEAgPhrMrzfJuZSL1iuf
 h/g+jZLBb8/sxJopi4Gyh3stN/YCQSFT4BvUlEiYgEVKjFi78HetikERqgawVGGeqC8O
 qBRvZHEbfHmFEq5cftt4JeMOkly8LVtxQsQKs90DVPXlY1zEtEyxwwwu2whpItMOUrlf
 15NLTswZRvR1I9eTbo8MB+RoqO9ohlx7ZogWsUMlNZQYeUs4fDsZ3Nd2pTPWFtx2vWek
 O4eQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxx1KAMcyrhHtcJ8zXFwoQNzGuqfTRe0/9OSIRYEStVsBoYbz4mx1Er12jBmf4y9ct81HUHNm5t14=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYQy9Qc2VMIHIduebuzYc3g5cdJZ51HyK+72vJGgzotr9+Xcat
 Uq9xGWTZQGoe32Bx1Te8s01Hi34rQbtu6yM+QVdCiGZdcgG+ASK8Cm3p87QxMY8ycplOU7Iwxr6
 Bt4o1ulLV75GWBmRRG0yAz/gb83FGX6MetjMbuh8ewSAJ2tilA8aEpz7mwtwVQySzWEMw16g=
X-Gm-Gg: AYBFou0fUjp1EoC3o3JLCF8TS0wqltx1NXSTj9LVRPNkW5JiNh0IB/VtlYw8F45ffNG
 a2VXBWpjd1Ou5trE19C4QRo2Tw4elGiNzKkZZK++XvhzIvOyh+DxH94Nnftyi8kcbwJ9gwC3L8A
 xAJceokCvf4DNlQapCfcBOQaopGyaYMNSwTuNfwsduCYgb3GACdoYQkpZWXJeTQruRVXqAuv6P7
 dYq/ojErjdcGFDh+YkQzjJpGMJNZuSwvKUFrc30kWThraksqCq7uLTGyvLiyegjh3fqcmWvdJQd
 VvQuB4ONwqWfAp4dERwswHl76GcR72Dh6Vk3QHcls5nBi+BfN2KbwIh/+61XNLxHKWo3ju7KCP9
 Kn9onTbW/XOBAHDR1HF0AxKLyUNkx6NaFxwHrQOsmKWpi2XBQNpbdAmiRTbTJxQ==
X-Received: by 2002:a05:620a:4483:b0:93f:2a95:a503 with SMTP id
 af79cd13be357-93f6f8a89a4mr288287085a.67.1792743234331; 
 Fri, 23 Oct 2026 01:13:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:93f:2a95:a503 with SMTP id
 af79cd13be357-93f6f8a89a4mr288284985a.67.1792743233908; 
 Fri, 23 Oct 2026 01:13:53 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c396af493sm14345626d6.9.2026.10.23.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:13:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:13:13 +0800
Subject: [PATCH v4 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm_gdsc2-v4-3-40b6a71d4e3f@oss.qualcomm.com>
References: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
In-Reply-To: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
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
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743200; l=1229;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0e3qRwa0eUGU6w/ynL5P+jJBBY2ZfPskYSfmy+rlycY=;
 b=tCI/OGTgkGp6W+rpS0APS7T/OQoO2IecXPOreqBc0ZRsu/DSgV429WyY+mj6uTd8rzy5KXdGM
 0ho7tGPSDrKDCqhc3hlXbGjqPj7b0WuzMT/94IQghTX/z3mRIiyaWpd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: EhNRPwzDxxRT79OaNvn3nlkCeBYf788f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX4ck6Htpsz8oK
 s5M/CzMzJiKpPnCcJc9EA0ETFqW3+9ji8ROb6IzyxJHyDy27ertg3tdV1j3HTgxZchSGnb7VoOz
 w0QVOrQGeUh3zztZZQTtBvt31Ja4YQo=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb1743 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GwFvbCpr4qPuEswRa30A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX4dNFMRtQw5kj
 ijbV4nrc2D4z2cvR/SkaaZnxy3FZgymxUIXN6SChKhsLvYaIkZuZfH+DhlFBbh2KhBD26i0Fo92
 6wFGVj3xXrUO44fLuvKb3k1PSEF+H095fBRjL5UXhX6lCenwY1e1ujAPL3EXaKbfVjgVuujVzXf
 OkhHE06inokpaghaSyTqE1AZ+DdSj8SVhNjRqOVQWCkLA+MhgYHHqQYB67uq3wHEY/7nt7tMUlg
 TAOXTmCKX6prpyVrsr+pS2pEtD3g7Aez1GSzDYaFkaf2IJf6FaXyORudKv3dak7KKEUYcp+a6/a
 wrn+LpnjnWJz8HbFRR9TLJaiPTpcBzwLRcG7XwWSo3cz/R9CmybUeZItxxSZcwOLcl+v4x432q+
 W/sxbz+WIV2lySHxrRiIQa/wJkYZ6Z+vS6IXQmj1oiBmsRGq3ViMTc4tgO7QeFdO0Q/fkH0OlTV
 dnnebWTnzOb/wFhJNfQ==
X-Proofpoint-ORIG-GUID: EhNRPwzDxxRT79OaNvn3nlkCeBYf788f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032
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

The INT2 GDSC on Kaanapali (SM8850) powers the VIG2, VIG3 and DMA5
source pipes. Without enabling it, these pipes remain inaccessible.

The DPU is supplied by both CORE and INT2, so describe both GDSCs as
its power domains rather than attaching the DPU directly to their
parent MMCX domain.

Keep CORE attached to the parent MDSS device because it also supplies
shared MDSS hardware outside the DPU.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index e48a179d0722..98d367b9dac7 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3674,7 +3674,9 @@ mdss_mdp: display-controller@9801000 {
 
 				operating-points-v2 = <&mdp_opp_table>;
 
-				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>,
+						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+				power-domain-names = "core", "int2";
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.0

