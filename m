Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B1606B603
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qb0TWN7l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlFVlh0H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8285210FFF8;
	Fri, 13 Nov 2026 08:29:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5711112081
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57f713120446
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XsuUo7jK22D/dCaflr7+ggdashOIplcmk4zE0IlhM40=; b=Qb0TWN7lI0YE3iZX
 DS6ipaJAgXiHQau9h5foS95yhCRXhGp5OjbhuM0RzxYkNfQ88oGJC6LgwOAiM2GV
 G6EXkzgXO5Vonc3Lr4DVtDrqO9q/ngxjWtQc05udJgIvnLTexrYS7kFYVUnkCFCN
 yQWeoFLDt5wKSRHSCE0SNkRWZYOqqh/+ZweaElROKLfInWU7NX9VcXvHmrhotu+/
 L1I311OSJLHhIaSUFP5P15XWe6FmxVGeag0ns8A9M6u8aAbS5XtMKJ4ghM9Aetus
 vQwHaNKMb5/pIDa7sf6ePdgYr0F5C6yz+Qe5Tvq1Nl+WMj1PTOhmzMcDZamBQb6v
 RRLb7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwa6n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-537548d4bc0so19384631cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794558568; x=1795163368;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XsuUo7jK22D/dCaflr7+ggdashOIplcmk4zE0IlhM40=;
 b=AlFVlh0H4vr68IUyl7TD1UyVuj0dGEKzd/acHPO02nDu/Nd8jY7RqjZt0EHd1yNz2M
 WXJl85g9niSti0DsxPMpWfGh9+vs4zOfsf1tGEhZai6fwvvXJVx5jp09uBJRhor/UMM2
 kW34hk9RyWiI2H61mzicq4N5ax9ha+3A3IrE/hc6JSh6oDLO7B9dB9WDaZUiGHgimdjL
 700zYc+1+BjkFPpIrouF9DjMLKKbAT2e/rBWFGnz6LpyONoebtP1BbOPnbkxkF7Rlx7u
 JbfxfcnlQo2o2M0/nFEldsKJqtwzZ1lEByEXSOBQ6CfUZQdlSpL3nKEBYIhczgKnMshw
 zmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794558568; x=1795163368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XsuUo7jK22D/dCaflr7+ggdashOIplcmk4zE0IlhM40=;
 b=J/MaydSzAcXan/zWhDrf8wDkTD9G3EUrX93xwt5WGeMeVmpnRprabECsQkYYXIsc7G
 kUtdLIH10zQpMGXF9C0oPmEQfhF7bRM378FOlwTzvorW2fhssJd7rRwcxO1A6YMEFRsH
 faAwew7nzu04YeoFZoaJnq/G3dPlR1ESIlv/FAzbGCU2bsck4IHZoiFLniYSMhrEA/yN
 /rvkPL4Ad10HSyl/UIvSTkfqXfkuKvVJcp7OetkIFdAC62Zfymtm6jfNBGeO+LQBXe4c
 5AsM0EkFvyX/FVCPPR3vucfIp6KCduUUf8AiWeAMMH2ox2Z7/622nHV/xIDbWtsSZ7lQ
 UHLA==
X-Forwarded-Encrypted: i=1;
 AL+hErFaTl+b/pM60/2k/YHZtDfTBRC+wEDrez+AeffRs01u5ZIw8+uz1IsO8xEi3zF+NDIGWuFFXD3G0Bg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tPKarRRbH1chuU6VDNaTlBnSYtsFAEFqpSgjX+bpRl/XzQSC2
 izZ6Atz++lKuIaSTpA3sr3k+H20pYzVRshtrZrIl39uE/yDGWam9s1eZjKa35uiFYij/F+9qLXr
 OgIZW/SziXQeVUiIJK7rBvXR0AWqVaZAehrok0lPoGoFwZBQPA85kEjF1zxx8fUhY56JjxjA=
X-Gm-Gg: AYBFou2jdKdrE7dwhRFIX9f+5j6wEbEEaJFUSfcZmBOvgONhA6CMWksC//3+rz6H8fh
 IPlwnhueQdXc0WMhzDH0eBPjxVIbSP3jyfA85w7Zm8NK/RDopP66sELXkMTDt78txZgUMSThJaR
 pgSi6LopnPkyNaHyCKCnSKnF17i/3XbapArah4NIwomaswZ0WjhPV9Mbn1+DKRT8QYe3GT0Kfi1
 T188FWKsI48jr41EBdB4ZfBmaJK7sSJsVnV1X07iwiqfkm1LoGU4NGFYchxsyWHCc1gNeVbSQCM
 FKRmHNf1B2gSdVsKVa5tEu4qryXqHh0E7FQAqO1quIuzmE/4p/to6Ri184F3ystmKbSOX8DNqrz
 hg7swzCpqqHv98vrlumdJYIXgsfuTJkwRF2e1g63Mr/yffvzfJHy+8akAppkxoLuGdS6hAdI0PS
 QeqYGs8iKQhUB8/sl4kiw47f7Z/3zC8y6M9235
X-Received: by 2002:a05:622a:480c:b0:559:af0d:a4e9 with SMTP id
 d75a77b69052e-55ac9e5d476mr29762281cf.51.1794558567960; 
 Fri, 13 Nov 2026 00:29:27 -0800 (PST)
X-Received: by 2002:a05:622a:480c:b0:559:af0d:a4e9 with SMTP id
 d75a77b69052e-55ac9e5d476mr29762021cf.51.1794558567469; 
 Fri, 13 Nov 2026 00:29:27 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ad1b13917sm13524491cf.29.2026.11.13.00.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:29:27 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:28:53 +0800
Subject: [PATCH v6 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-msm_gdsc2-v6-3-17adbce47220@oss.qualcomm.com>
References: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
In-Reply-To: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
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
 Konrad Dybcio <konradybcio@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Danila Tikhonov <danila@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794558532; l=1357;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ntfeu9W4Pq86Dg1wFbI85btVQtrszvihY+sSRkt7zsw=;
 b=viEa+abBe1P7T1jIRGcNa06s0sk5DJLazOJj04QJlPe6iF46uc3r41Uz+z2zoCOuLI6e0QiN1
 WsSla488KZlD+Yn4O9V14mhyggumuUXhyGoGaBgJjNnGnyRONjzLoRy
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af6ca68 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GwFvbCpr4qPuEswRa30A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: _ggB_z3DdfQPULqvujw5grwXaimjrL5Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX7bKFXE0d3mW9
 cMIjTb94su2AgYjP5rF9+qPYRZEP4zbpthepBTNf/4/Ii0Z7iY+2tr10ci30OqGmlUfd1qUwlxa
 ED2TRugBgWPYEtJh/OrBce8VVPfCcdxcl1wdClUkU31raG7A4ozDBPsNua3Oi1S1lK1PeZeKyLl
 Mo75ygQLaY5J+ZRNRvoZfXsYqT6kaa0e82qPBJgRVoFYSs7qasJtbcRjXnBMsKOLAQ5pPXcjLUc
 ER+7K/37eTVtvbwSv5mmCWllKT7qYKVmJpEb2AYygMZGl4t44f9IReJf1LtZ505CKGSCqiXJKao
 gR5BQY+RFou/iIH3V9nbZwVcXZFzImdlVb7/07iBUNDhEdyFa9HlfqvBV70LLU4xYKxVc/8Z7pP
 bFhIZ3jJeh+D7DvWhstG6URiBQhiwiKxyxdQbwC5ZWxpYr+ViXknoAi3y9zw3lfJ3zaeZLtsabZ
 ZDUhPCqa7bsVKcPpuKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX2sUOFuqpZOCk
 X0snZsScY4RxV9w+51lHpLXd+ENee7cNI+ty8ZCaIc7VZdIQbYzhMnqlm43vEpg2h0cZqYuPdWZ
 OvZrkxzS0Oqob2OI/tQ1YRN/jcDW4Wc=
X-Proofpoint-GUID: _ggB_z3DdfQPULqvujw5grwXaimjrL5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130033
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 9f04a5ad75f2..3706b89fcd0f 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3691,7 +3691,9 @@ mdss_mdp: display-controller@9801000 {
 
 				operating-points-v2 = <&mdp_opp_table>;
 
-				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>,
+						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+				power-domain-names = "core", "int2";
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.0

