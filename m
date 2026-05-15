Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E2ECD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 22:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4B110F624;
	Fri, 15 May 2026 22:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcbOdW4I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gYMpZFU+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22FA10E181
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:22:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJek6Z3076666
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FUhQPzpeTqHUfVcim/+MklcBBi2uunm5wIH6HIt0Drg=; b=XcbOdW4IdXKTwfdf
 UCWRWzVz6g1qaoyITQQlJWNBy7JxyIuOcCyzTIivs04p1MedtYdzH5r6ywMPp669
 3hpR4IugI+hLnRgUO6cVCGHPr+OhCTPASDcZr23X7UM3L4AgZruaQfq4f94JMetg
 BqrlT1ZIeKT4oZcjsrK0FaM3oRMF29Tlyf0VfeefmLZb+bjVWJaONKLB5sk5JQBr
 aojENqCau8cKNlOCS5kVX9/2ChWmzKppz+bBq/h1SZ5RwCBfQ/hVe/tkXBhlF60T
 vLd8nqyRg3m+t7DOIxuL5UBtssn06XyBM+40ZIFjDDxi3QVZXBjIOUesKZt/dkq0
 jT2F8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e68g2rpa9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:22:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba268cb5e6so3231745ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778883740; x=1779488540;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FUhQPzpeTqHUfVcim/+MklcBBi2uunm5wIH6HIt0Drg=;
 b=gYMpZFU+yS0zagYxMG4HYGN0huNmDZMdPaEQ8P4xFYYDOxL0qqnuUaSelmonoLDT1L
 T/O7JLJwx17wIM/DVVd52AWEJ+L0d4XGVYXDEA/7NCCvSLqvlQRsP6zaG40q3Uzkks5u
 w794A88Kt2JbAvKTUo3ZNSqqaiXTX7cGN8NEzai4+Nxbby8B32F5IktK0heNemREPrMI
 MnCYuwG0YJwwPIoNvG5txzEDQyIuQlBKfVToPZpK97Bz1O9EZqIxGJhJaqiNTMI/U5Wf
 X6rjJMAewJ7s+6eGa2FyDU4mJhR/xldDr0XQE5V/OAAMdfeBKej6dOQsMIIroGgUEia0
 7slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778883740; x=1779488540;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FUhQPzpeTqHUfVcim/+MklcBBi2uunm5wIH6HIt0Drg=;
 b=hSWvq10O9Sric/6oQDjKgvQSEUPqLXSSeZy3hfBgdPb50yhcsE0tgSAAluZUQgexjE
 iZIcZ8x4nhyIIvUMy0LzZqNFM5i3JggnqQtwfMGDaYJWQNSoyjVhqTUT3Mvz8/FAXEwY
 LcTlfcsA4HWbvokSnZvPizxO/WCwiCKv9WxyYz/KmmGIQlE1v1xih8c8sKxyHYairGjx
 5uwUlqJj8zb+dBe+SpeR0EFZJYT7lbvQj8/YCY61NI0zGirZo+c9a4xIolG7Oo0VFdwV
 yfqSv1n6GZADImOyYyyxFPXlEatYlox9wwJzV/wHf2CVr74p1HYNHAaTNNev5CRXyE8D
 lE5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yh1pYQ4mk4d0xaePrC+vAwCnrT+TCm2/Tvh/OsVE/RREVxbDDEc425e+5aKe1/GX8ed+gGb+1lSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqY3wrghhjeUhuKU9WDapzOjQns3ZBRek0O+HWcliZlJA1wv3M
 d3UBcRQaFHRSa6ivTxN8xCI0VVb1VUFovW/90KSzYHUaMazrv9fyslFQQ+sLG2NksnLDClwrfiX
 eURDXfKq5T4lcrm5nUeA8j9rSnL26hGi0pS2Gbg7DtdHZZiVL8CvA0FnkKJcXJh0l6J85a+Y=
X-Gm-Gg: Acq92OFe1QSaB6FCkAJ3/8cD1CVJefsNECikETxxuxgQX8TOEyRIXFfWJfiwsaAz/eY
 KOYlOK97GuEacVoZ+NdTXjOh2H4oUKenngMT89Q7XsL85GotGtSrMH3SLadqk4cpwfVM56ljPmX
 BiGtIIQPjGgY2DjCKQa6l/ADeftX46NkCbKxA+8xjzvKZH8M6cN5NJ07dcrYsZEqKoWPs6p0FLM
 /Z7H528IEQgfx6E+vQ/a/EOdCDR/71ky1QdTzBkQGFzuEd3wSiqw5Vvw6U7QttQ51emeRJ9od88
 8P4LggUGuzO2KlsWL6DmLOPPMI3ddeB/rL8EwYAZOr/iLt90+wgvyJB2BftSo9T90xztVRHgVat
 icUMhxEaMzmTqomqiGUxy38MS2tACys0jkoc3twwfmM4=
X-Received: by 2002:a17:903:2ecb:b0:2bd:936c:8155 with SMTP id
 d9443c01a7336-2bd936c85b3mr32869385ad.13.1778883739313; 
 Fri, 15 May 2026 15:22:19 -0700 (PDT)
X-Received: by 2002:a17:903:2ecb:b0:2bd:936c:8155 with SMTP id
 d9443c01a7336-2bd936c85b3mr32869195ad.13.1778883738842; 
 Fri, 15 May 2026 15:22:18 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0fd384sm72133065ad.65.2026.05.15.15.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 15:22:18 -0700 (PDT)
Message-ID: <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
Date: Sat, 16 May 2026 03:52:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 0/7] Add support for Adreno 810 GPU
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BchqfRXBQJi7CfBgWSQ323RCU46__hk4
X-Authority-Analysis: v=2.4 cv=EJ82FVZC c=1 sm=1 tr=0 ts=6a079c9c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=i76A9G0zAiINRuBm_vQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIyMyBTYWx0ZWRfX7GNuAUZPQQEC
 NpkmSlL90f57X48oPJZt0KZVfWvOp4qBC/191iKx2QGFNAQbyOnaAHMY/FziNVFD8QmsmwkR3Dc
 v/1dqwLqbNoUiZLwzOYZeFnQ06jLpc/nKVKAQyEUkl9OiekimndFkXaKG2OChj03id3guSsziKK
 VIB/9oycAO2lmvxpnGYVmrsHP9rMzg7AuGMY1i/KzNecMYnGlGyQoD3qP1yZa7DJNqeq39kuX61
 zMKUvBCbDihMxPG0U0G7Oawpocr+DP90F450UgGJsUS3WlpYnYzttzfFzp4hdexVWwreU0GDnlm
 ucShIOnHUTJ1rmnXbm8XzgNK87M8kME7FXkhxlnYSVn+OW1X774MPzkF+W4aJUa4EegJOThMSD1
 m49kB6M6cYpyPpVlXBygsekZQREBTBsHZdSlrd9/DigAAAHhBCapzkyg8bQXrXB4TGodIAsl65+
 vVG45Ks3GFBCcLUaK4g==
X-Proofpoint-ORIG-GUID: BchqfRXBQJi7CfBgWSQ323RCU46__hk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150223
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

On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
> the A8x family.
> 
> This series is marked as RFC because it depends on a few other in review
> series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
> support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
> 
> Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
> review and has been applied.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
> [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
> [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
> [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

For the rest of the patches that doesn't have my R-b tag in this series.

-Akhil

> ---
> Changes in v6:
> - Re-jigged the register ranges for GPU/GMU to match Glymur
> - Depend on RSCC offset fix
> - Fix bindings to add constraints for reg list
> - Link to v5: https://lore.kernel.org/r/20260502-adreno-810-v5-0-bc9fd2bb788d@pm.me
> 
> Changes in v5:
> - Sync with latest kgsl
> - Link to v4: https://lore.kernel.org/r/20260416-adreno-810-v4-0-61676e073f8a@pm.me
> 
> Changes in v4:
> - Add 1150MHz speedbin
> - Rebase on next-20260415
> - Add dep on efuse patchset
> - Link to v3: https://lore.kernel.org/r/20260407-adreno-810-v3-0-30cb7f196ed4@pm.me
> 
> Changes in v3:
> - Drop DEMET from GMU clocks (not required on A810)
> - Document qcom,adreno-44010000 compatible (regex is gone in 7.0+)
> - Drop zeroed out CP_PROTECT_REG[46, 62] range, not required
> - Add a810_protect to __build_asserts
> - Add UCHE_CCHE_TRAP_BASE_[LO|HI] and UCHE_CCHE_WRITE_THRU_BASE_[LO|HI] to a810_pwrup_reglist_regs
> - Move TPL1 registers to a810_pwrup_reglist_regs
> - Include all protect registers in a810_ifpc_reglist_regs
> - Revert pipe reg comment, just copied it from downstream but original also works
> - Link to v2: https://lore.kernel.org/r/20260402-adreno-810-v2-0-ce337ca87a9e@pm.me
> 
> Changes in v2:
> - Mark as RFC due to dependency on in-review changes
> - Explain in DTS commit why qcom,kaanapali-gxclkctl.h and not qcom,milos-gxclkctl.h
> - cx_mmio -> cx_misc_mmio
> - Sync a810_nonctxt_regs with GRAPHICS.LA.14.0.r5-03100-lanai.0
> - Link to v1: https://lore.kernel.org/r/20260331-adreno-810-v1-0-725801dbb12b@pm.me
> 
> ---
> Alexander Koskovich (7):
>       dt-bindings: display/msm/gmu: Document Adreno 810 GMU
>       dt-bindings: display/msm/gpu: Document Adreno 810 GPU
>       drm/msm/adreno: rename llc_mmio to cx_misc_mmio
>       drm/msm/adreno: set cx_misc_mmio regardless of if platform has LLCC
>       drm/msm/a8xx: use pipe protect slot 15 for last-span-unbound feature
>       drm/msm/adreno: add Adreno 810 GPU support
>       arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU nodes
> 
>  .../devicetree/bindings/display/msm/gmu.yaml       |  30 +++
>  .../devicetree/bindings/display/msm/gpu.yaml       |   5 +-
>  arch/arm64/boot/dts/qcom/milos.dtsi                | 165 ++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 298 +++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   8 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  44 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  14 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   6 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
>  9 files changed, 536 insertions(+), 39 deletions(-)
> ---
> base-commit: 2ca0470eca8b4cee27aeeb39bd93c1f4c96b7e7b
> change-id: 20260330-adreno-810-5a47525522cd
> 
> Best regards,

