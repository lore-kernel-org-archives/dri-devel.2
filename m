Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E15606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mwisdeFY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kVExAJ2X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CCA10F0D4;
	Mon,  9 Nov 2026 08:36:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BC810E883
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:36:48 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A969wH02668063
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 08:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uOzLF8eLJwbDK4JWDPkveO
 iofSVzTZ67nNELT64ujSw=; b=mwisdeFYZ3VpAKZaSQkU8o6V7IrJP/+j12zvkk
 xHCXqoF1J3VRCOEL3HHyBv62ai+Ym1fK5xjf2OUGuNPip7IaPEt+TUc32Xx4+g28
 r6fqOmvN2h+o2xoqmJQmYv02jgGldWV6MRG9K04S42DSpn9PmvjXlkKfolD3rph4
 AaCVOUoib426xLhTtv0TYKzhx5Opj4XNCqUtWPlyKCLTHcrY0zyjuT+v8NBlonw/
 b3wdYMxV0FcZjppuuDIE8oUetLY4c7RULCDk9GxW8r4hvqqJiVQrKTQVAzCHrCoH
 Hpp7a/p+sbe1eeXFLOiOuodkOwXA/xMq7SAxN8iHqmfNJfrA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99n8f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:36:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so59043985a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 00:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794213407; x=1794818207;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uOzLF8eLJwbDK4JWDPkveOiofSVzTZ67nNELT64ujSw=;
 b=kVExAJ2Xi9B1VvxJA+1wVXsMWM+4BlH7RYvNHflR8HixzeCL2Iap/M+37QGzorTe20
 HIGcQnCsxpaRn3wg1YimM1jva07H96n7ZpsMqd5BWRWmywDKM6JzW8kjHa75d5Zwa6S9
 dzW5zjU8akgJQ5ijp/6nd08GAmuJLKflN2mznmdqsHujHqyHUQU8o1j8kk10gZg7KB0P
 t8FowBq8JUGkAgDxAUxeuBdpFDkB0thrnzyuwBDQ0WZLDhxZSWJCT6D7E2KbL3mDwJ9d
 KS4/0wRVzm2DGbLk4/42F7ibZ0AJ0vz/S1n5gCmpImCsruyLumcGFhQ3xWY+sZ0ivczv
 jkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213407; x=1794818207;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uOzLF8eLJwbDK4JWDPkveOiofSVzTZ67nNELT64ujSw=;
 b=VytuG/uvKS58gWTbkdxCu0x7sSqM8JhAZN/dMNCAObA6zb1GDnn1YPQsngufiZG3zg
 AQjYPBIYvWDdNm/qTUNcA18Rr4cSSzxh6ZNSrUWBWF6yJei5A/FxWjxs3lg8r/1DmZnh
 P73KvjUKJJFFUaPieRZnAB5tjjDQXa2kt1yYQe+W/k9LpXk0WXdeKPQiNJV+GX0Oz6N2
 f0IVgoTBE7ICrE3VbzhXQjKjrxEt3tbGAFQw/SNrTMUG/KX5W4gyOuEYf658ojXDP4Sy
 Y9hQIa/c1T11OdnAAEugY9WY3jlH03p6OYrzJHYfvSjIQrllCcolLuHYFujA2d/8sOAQ
 XTOg==
X-Forwarded-Encrypted: i=1;
 AL+hErEKqVFjCq2zKv49hv13ruGAv9xLwsPxLhEr4G1fnjtAbeQ/mX4dk+vxM+iFmQmgRuh/HRAxwZQYbsA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NuoW2wJ+pm5IechK1fsyeuJGd1Qp7VYIw7T0GpMY2/BBfml9k
 KPcMTcfAb++5tnVC4cm/EeM4gKr8Oplc00lOGncy7cCkjkDgN2lma7qhgyXYRW79JvcqyhFDKri
 mOKi3LJT59zaANY6YJYAaXLJlbmZ+J0fzrV2Hur0bgzInApOmZgs59PeaGfbvlNd8VsagaTY=
X-Gm-Gg: AYBFou0YbbYP/Z724blbU2nQYCrJbTPC+RPQa1atRUFSmGkn+HxN0j6GWSGC1VtpyPc
 LQ4oWih5GWYHClYCpnuBZGTF5I2qDfjxtngNnjzPjNq0ipTkQv4aSAxpmeXbITsonTma+7KEV3K
 TX5fOW853oQFZjml23QZh62Ac0Mu20elA/xzfQCV1nN21BqB1xmBXkFrv/YH8auji7bAleQGb6X
 WuRr+ckJV1IPrtDZ2psj2HoqlcIz+fq+mw3SUkdQ1fzaZAX23tHdrsKakrUqac1E5bXj+483aPT
 ou4xGFc/lncYKrA3KGW+Yyj/Uq5v5ERLcVJB2BpmS+bBb/MvQXdz8hmSJsWbWG177NbV/ExJnnV
 IPrsB9m3QJC+vnuXxw6jZo9CxIeeFwIFjoeijdUfced3d0wyoxAGziF3sjN5TXPDWbc1m6jehhr
 mzxkAI4o34/gLjgKHl3w6ZEtvCIpoKm96QfCg=
X-Received: by 2002:a05:620a:3188:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-9478424cf8fmr541944685a.47.1794213407063; 
 Mon, 09 Nov 2026 00:36:47 -0800 (PST)
X-Received: by 2002:a05:620a:3188:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-9478424cf8fmr541940785a.47.1794213406477; 
 Mon, 09 Nov 2026 00:36:46 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782dc37e5sm418223385a.34.2026.11.09.00.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:36:46 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v5 0/3] drm/msm/dpu: Add INT2 GDSC power domain support for
 Kaanapali
Date: Mon, 09 Nov 2026 16:36:34 +0800
Message-Id: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABKG8WoC/3XPzWrDMAwH8FcpPs9Flj/T095jjGFbTmtYmjVOw
 0bJu89JYcuhvRj+kvhJvrGShpwKO+xubEhTLrk/16Bfdiye/PmYeKaaGQIasAi8K93HkUpEHkO
 DEgCtR2J1/mtIbf5erbf3ex7S5VrJ8V5kwZfEY991eTzsiNqkRQAPrabYJCV0jBidJ0dBWC2RS
 KEJbLFOuYz98LOeOYkVe3DRJDhwZZx1xpCJAV77UvaXq/9clu7rs2IT/gON0FsAK1BLFqUNTjp
 8Asg/QIBQW0BWoBWJTFMbSpgngNoAKLeAWr4AwXgrSCXZPgDmef4F/U8KvLgBAAA=
X-Change-ID: 20260720-msm_gdsc2-cb9230027a2d
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
 Joonhoe Kim <26rote@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794213397; l=3262;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8pqsefRv58up0CB5hfDBMDlXVCBA9MTDI8e9At11oCI=;
 b=N/GRBrc36YIjEbo+kUgkWNMws3DqmS3uLiQiPv9kHTIpVEuPBsx9WVt48drQi2PuyGAjmVmnN
 7oqKN4rq9blAXEvRiPHV7GbnMesopQTvzuTLU7XEVY/3WiD23d2Z4W+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: -x9qr9X79k6-OzSzfnsjShIsrVijw3R8
X-Proofpoint-GUID: -x9qr9X79k6-OzSzfnsjShIsrVijw3R8
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af18620 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=d2OlSeRB4JJFOaS-wp4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX8gmxxSm5a0Z+
 3jH2wNl2WgYnc0QzFgkHY4ILmhxt4BoDNxPda+hupY2Pzy/I3MmhiVvheqy6of9+r1dUq0izrGZ
 OKhQjG9eekTLMVIPPpQxOBEhlE4URL98Ka6u0SPTET3fQ+ilTCiA3Ms6Dv2YrJNkUfoOddebeEv
 ZrIuNNJzrmneUch7Q58o4tHA+VZeN99UIBHu9np+l/nFexLwM1n8089UssBPqXNiGsAAiO8cM7t
 79W/OI4BHUrjOij4TsvBVY8pS3LgRlx+ROJXPv7SrdmRLhdhWCHO/vfeNUBNoFq4WouASbhmpQP
 qsgMB0L+1PBgR/0SrgEv1ElSUASume1E27eqNft2YSt/27IVlGmxcFs0g1MQkLLUO1ZRtWfQ8G1
 /5n62kdxvRR+zJm26psopjzznuFGrL9v2wMmQB2JyZBL97PjqTrtaXpOeovPCVdyJgVDyxQyypK
 b8KPr24hoo7M6YU7P8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX+w+b6PrXhblL
 jbaU4Eaggzj7lLjPH8Vt9zfUVUEDGOEONirW+EDLZeS2b33LxxUdLqeUuhHNmOtoO4R6ciZo5OT
 g8tHMki1UUYl7ceolz7ZbxUyq20opyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090034
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

Kaanapali (SM8850) has an additional INT2 GDSC that powers a
subset of DPU source pipes (VIG2/VIG3/DMA5). Without enabling
it, those pipes remain inaccessible.

This series describes CORE and INT2 as the DPU power domains,
updates the DT bindings accordingly, and explicitly attaches both
domains in the DPU driver. DPU performance-state votes on CORE
are propagated through the genpd hierarchy to MMCX.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v5:
- Use 'contains:' for compatible matching in the if-condition (Krzysztof)
- Move power-domain-names items to top-level properties; only constrain
  minItems in then-block (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com

Changes in v4:
- Keep the widest power-domain constraint in the common schema (Krzysztof)
- Link to v3: https://lore.kernel.org/r/20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com

Changes in v3:
- Replaced MMCX with CORE as the DPU power domain, keeping INT2 as the second domain
  (Dmitry)
- Used generic "core" and "int2" power-domain names (Dmitry)
- Propagated DPU OPP votes from CORE to its parent MMCX domain
- Updated the Kaanapali MDSS example and fixed issues reported by dt_binding_check
- Link to v2: https://lore.kernel.org/r/20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com

Changes in v2:
- Moved INT2 GDSC from MDSS to DPU, as it only powers DPU-local source pipes (Dmitry)
- Dropped Glymur — only Kaanapali actually needs INT2 GDSC
- Used if/then in DT binding to restrict second power domain to Kaanapali compatible only (Dmitry, Krzysztof)
- Dropped PD_FLAG_NO_DEV_LINK, let device link auto-attach handle INT2 as runtime-PM supplier (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com

---
Yongxing Mou (3):
      dt-bindings: display: msm: Add INT2 GDSC to Kaanapali DPU
      drm/msm/dpu: Attach CORE and INT2 power domains on Kaanapali
      arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU

 .../bindings/display/msm/dpu-common.yaml           |  3 +-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
 .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 34 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 32 ++++++++++++++++++++
 15 files changed, 104 insertions(+), 3 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20260720-msm_gdsc2-cb9230027a2d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

