Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C8606A333
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dTioYphf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=angkzzAN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB1A10EBCA;
	Tue, 17 Nov 2026 23:00:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2FE10F9AE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMesM22627369
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=09dYCF8rOk5krx8GfedSFP
 YP96z1DkZBbcqH44BbhkM=; b=dTioYphftzIms+x2W4bXJvQaCKzVJwgXpGBImA
 6WvFa8Z57secBPRMUQgDt2reo6JmnNFW/9FnOm34Ms4aM9UXxiOjP+NGY00y22el
 NMONzJMU6fbQhHOCtlHBYet1J3JMo+0+3wy/2M7PVqPxswY+IcO4OXp9bgZiBtci
 H5rAaTFsjJDNaQgEncbMc8IeVN25wfRZoPxAVVVRIv3kZkTo6TdAxcSXI+xKyqxS
 X45v6VuT9/E1BHGQbwO4d8mjeFaqoNo20eCZ4P4QNcxErwFTOLV9gEfCTg7gly08
 jse/tE+kbnEP9kIvmnNS9EsE5S8R37/Z4SkNmvVP0+OHmuiA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9g2ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1af203073e0so379459c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956432; x=1795561232;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=09dYCF8rOk5krx8GfedSFPYP96z1DkZBbcqH44BbhkM=;
 b=angkzzANtHyV865euAFPTDkP8Wn/aDabKZfHFLsZr16x34vecXOkNh3bcYbylwUzf+
 a9CsS96L+KBPXTpwPf49Sqcw+pBcOtT7lhP1prDssLSgvHYLBs1VmP5qg7PKX6NhyQia
 ecL2YhPfl4EshLT7ZJU2SHg0dC2niMsiSr1u6yGwGp2qrLJkv1aAxLHECAjFJ2Wp/ky9
 5piS2rcOnJDpC3KL2P1lggKNUIUBtDsBG5FQ+U7UsrBVnq3U4CH4ymHS8NMvp1XHDsAO
 G5bu+v9KOImHWXtSpUUKb1VcsfwUzO0YTF90KcOd0DJXi3nyj8jo2QsA9FHZ6SzF06Nb
 4+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956432; x=1795561232;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=09dYCF8rOk5krx8GfedSFPYP96z1DkZBbcqH44BbhkM=;
 b=WRq7jKNuW3dSGB0VbDFUoI4Zt7jMa2Wy4X6N+2qpcEFqua0THtizgvrTMjEdtuLDPt
 xVeMeipLBhoCAWB1nf4lGhWor6GRaJoMWQGmZsQV+29YLUGQYGvv2CMDMoKeXEdxDmcE
 9Qq0hAfQfdvKYiaPsdK3b9UklNWbFio9JMo2P9pVlVw6vyHCgtFkXu/XrXdqMCjZ7Apf
 T+RKes6zqbTtEUrs6swIICpj0186GPTdjibgEua3vp7iljj1xOFgtdaZzeqGYJlzMU0H
 YqFeMU1/OpC1gFJ61F+TEV396nZW+Vpw/fCrLY08HEK4iGJdwK8sdlN+xteIYa8HHZ8X
 IgGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEgzvfQjJRlgwub/NoXeLT1pHkrUWX7/wVP8I3do9w8kwQ1kkT2JJpybcDPQI951I0ookqHSypobVo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8kQAVttAM0E93Cs/qwDo582nQ3aliuhMfoGwOuHJT5zJNn9eBd
 5f+neh2JRh3fLrudt8GZ7DeXgQPYbfZBTpKBnPFznqrxgciPcdFPpsaKM8tbUEx6ogPiQbQJ1X8
 rvI6XDQdQF1PRqx9+O0jbtPKyMXZEkT7oEPEFvQMcy6h3uKtgOXYGXGJ9FdVeNknksk8q9hI=
X-Gm-Gg: AYBFou2/lUusOgUgjzbspygtGp82w1MLoL2AdNEpG9uu56Thy3ae5Ae1xcPe8oRdr2h
 laFFMcLr5fBi674d3JvdXoX3E9GfqlwttRUmU0JJbqeqgKMeZfPF3elZ4G3m3EK/tUepoRGooYf
 2SvKC3zNBFft2YW5XpgwPI1AdMXx0Yo7WNZV6CjA4TyitvIj/RsmoQoakHJ+bJChDnTsZjz3yPV
 /v80EhqICZm01FlQ88vlg6k7ef45cfsw9DYJUh10dIXzAhqfvR52en2HXIXj1vB2HV2fugY5ASF
 ERHvAlSdijJFHhQmPArPPd0M6hI3jj3LauMWd9xl+SjGt/kihdFFcC30/y8Tg7Wht4TPia4UzmN
 V87pxm0xdiM5CHpugOUBzQK1HzkdiqyrTwyCGRnBviHvG+YkBtMXfhAIkCjZ4YcMHO/560XXiWQ
 ==
X-Received: by 2002:a05:7022:7a1:b0:143:2719:f800 with SMTP id
 a92af1059eb24-1b543c0243fmr1084581c88.40.1794956431653; 
 Tue, 17 Nov 2026 15:00:31 -0800 (PST)
X-Received: by 2002:a05:7022:7a1:b0:143:2719:f800 with SMTP id
 a92af1059eb24-1b543c0243fmr1084555c88.40.1794956430920; 
 Tue, 17 Nov 2026 15:00:30 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5445eb29esm1380839c88.0.2026.11.17.15.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:00:30 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/5] drm/msm: Support for GPU in Nord
Date: Wed, 18 Nov 2026 04:30:03 +0530
Message-Id: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPc/GoC/02OMQ6DMAxFr4I81yihIimdeo+KIYALkUoCCSAqx
 N0bQoculp7l/7438OQ0ebgnGzhatNfWBMguCdSdMi2hbgJDxjLBGbuhsa7Bdpg5SpJcFVyRyK8
 Q7gdHL71G17M82dE4B+V0LqFSnrC2fa+ne2JonTBqORdwBDrtJ+s+8ZeFx8SvtvirXTgyVEwoU
 eeyakg+rPfpOKv3YU7DgHLf9y+eqFvU2gAAAA==
X-Change-ID: 20261008-nord-gpu1-7e71a91ae653
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794956423; l=2015;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=XNYDbe7JsC6Mxpz591wHG0DJ0ExB4SLBBC/CinHe9JQ=;
 b=qRU/MrT6YHgAh1gf/2YbESmKUXuSGsHWRcpYYPWAf7EfN/e1pLmsQbv9OEQf2qbEV2UcoQOGM
 +6uPaIyGylPCebV424W3V5xswE55jy2cyar6bWpeGGL3l/1gl3wZXYY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: rX6fHo2NeI9fyvl5UEE2T8H-Tc1cxyss
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX90PheQ1q/AFO
 QbJkWQWZWCnIMmGrPA6PiwvcDIw2C9dFhR4krAf/4VbM+fT9hbSbgQ6lqX8HiQuVeeWR7bOFPut
 FQPkyZtJeNiC/aYDnIhWg5ifn6KYIjg=
X-Proofpoint-ORIG-GUID: rX6fHo2NeI9fyvl5UEE2T8H-Tc1cxyss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX1JgQLCcgjzp8
 19gG0Fv058b5ZqAJQJR/uteluHHzqN1xtT0eI91sUtA8hpmuPvK7Xb1jV2E9vktFvW3eBMrHljC
 WEeTbijjnArJeknSDLjqiAcYtkL1LEn/C/aTHdL6zbgQvMlfxKCczwNwVTjU+xh/4iP5vmce4ti
 d/fuFOE0qb2s8qmLPxuEZR4bBX/o+11siCS76PJfQHlZMTRA4NNZpcwQSugvgHvdnr/HA4Goamt
 esFK5pOZHl8d0yWff9kIhFcA6Uvd65of6E7gQn3yiUtONIkIsqpefbAOfAk+dQN4kOk20c41kcd
 4Bk3yDffxEzm6sVt8ReMrMeH15L07avhHIXOzko7vdU9ULXRpFF44GHeFG1jd2szvcOJ5lCFAg3
 YDImkPCmZiZEyRTsMt2DTk0RMfBZ1Oaki9PFHhzlhpxSqm1Z9CfgyCjtiOur1TTnspssj7fDKN0
 ebQH6C9pS3wg9FyAMNA==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afcdc90 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eQK-ig326sWed8EMzPoA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
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

Nord is the first Snapdragon chipset with 2 integrated GPUs. It has
an Adreno 753 GPU which is very similar to the existing A750 (SM8650
chipset) and an Adreno A735 which is similar to the Adreno X1-45 GPU.
This series adds support for the A753 GPU. A735 support will come later
in a separate series.

The driver and dt-bindings patches are for Rob Clark and the devicetree
bits are for Bjorn to pick up.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Rebased on next-20261116
- Collect trailers
- Split the GPU and GMU nodes between nord.dtsi and nord-embedded.dtsi to
  match the existing Nord layout (Shawn)
- Moved the GPU cooling maps into nord.dtsi alongside the thermal zones (Shawn)
- Fixed the GMU OPP table to match the clock plan (Konrad)
- Link to v1: https://lore.kernel.org/r/20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com

---
Aastha Pandey (1):
      arm64: dts: qcom: nord: Add GPU cooling

Shivam Rawat (4):
      drm/msm/a6xx: Add Adreno 753 support
      dt-bindings: display/msm: Document Adreno 753 GPU/GMU
      arm64: dts: qcom: nord: Add GPU and GMU nodes
      arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU

 .../devicetree/bindings/display/msm/gmu.yaml       |  33 ++++
 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi        |  79 ++++++++
 arch/arm64/boot/dts/qcom/nord-rrd.dts              |  12 ++
 arch/arm64/boot/dts/qcom/nord.dtsi                 | 220 ++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   5 +-
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c          |  35 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 9 files changed, 361 insertions(+), 35 deletions(-)
---
base-commit: 38c8be16846f10f3a710351357e4f4ace7254c8e
change-id: 20261008-nord-gpu1-7e71a91ae653

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

