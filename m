Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D8606A331
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NULVhEWK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jd2bH3mu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BA7112126;
	Thu, 26 Nov 2026 08:11:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74B8112123
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:10:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7AvFu2594845
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0oVx9fVa/Ez2JCk7hDN3JGdH21S3GTSikiE4w5uLcxw=; b=NULVhEWK+n351rO9
 hK/XaDd1CtJHafsb2Dfzg6zjEsKxtiInis3B12nCQivv0UIs0mp5HRmEqokAhz76
 qUKy/zNvgYcPvN3cdzUN08MnVJSA+QCoyzMC7MIjhQChhVIfOUHvDD+ZVR+rVrvW
 uaOjcv10GTDZS1nLlzbt9GvOkVJkw8rppbFy37XskcRKJt0vDjK2f62uMhL6pNWW
 JmwvCEc+vqjt/c94uyevhCLwqvRqMBYrZDKQE6TU+UpHwJnBYLsqMwEe9JpgtmSC
 lG5S60Ir6h4sBciyHsSFR9VraknEkRhYeorTMcbOi9ByMTWQs1Lq0T7f6Ye7U4Yl
 ewuwkw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662sa456-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:10:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a0522cdaf3so4702241b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 00:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795680638; x=1796285438;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0oVx9fVa/Ez2JCk7hDN3JGdH21S3GTSikiE4w5uLcxw=;
 b=jd2bH3muBfX4PRT6Vf6MqPljXw66+iQ4N8GGKdWH2ewi7DcJPQyALOZ58gLcEzhDs3
 UsGsirSdqj+cXh2b18a7GWnHlqEJPstb3ujBaTJHxxqaYJ64Wf4CEdme9JXFZT5+mlSy
 w8GM/LP81vHAbVyEW3eyJHjO21l/CUry7A1S2q1xTHOn69bTrnM6LCDxmhZFYE5Twi2x
 n6IuDh4PiO7oXlMLQjpy1pR4GbIG7GKuFxYrAFD6V+KuFtkJP2aycx12NuElElng77xn
 V4/wSe4+GeXj66UOXYtQyQBE4ldgqRkfnAvCMyHpQvgrXUTqcpDSovtLVSWvr7EO4cEn
 lY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795680638; x=1796285438;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0oVx9fVa/Ez2JCk7hDN3JGdH21S3GTSikiE4w5uLcxw=;
 b=DtQtth6AHcASyvKQetOB1qXKs+w4+zgme+AmZaZZeJOnhEsD6rqBnfNMRWtipG5Tr1
 QyXbfPfooyjQueJg4rgsP7w1j450D6VEEMAHBA2dLAb4MyvORLIVDU2A2Zjs42+OXXDG
 knNvbP7sNcPi7/VlL5Q2ch1/CLHK/fejkgp7injr1BKGXJ6SO68M1g2sp+whQk0mHI5u
 I/UqPCX0zFBZbaEnNLj0AkutliS+8RvxZKQn3bXmKAGiZJPDc6nVbafosZtfNRZmyUqO
 oFlkNHe9pMFTxa0PECpEqmhNpcpxGSSWe2+dkEj1EUYkP6T3++AV9DAO/dUWcGEGfE5N
 3G+g==
X-Forwarded-Encrypted: i=1;
 AL+hErGh7KSwLmQUvIYmtrYz0oKY/srmzWhHql/7B/ybE69PQvHgOvEjCv9+E85Cyzpc9VGyvYNH4UHBkB4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QW2hUa4hNbq/tMlSI8mPIMHqr6D7kwKo1OA0PT7beOLScIe8Y
 tvKDKi0gbnUq/PbBFgi1gdx1j0AdJThnXcpjFLALyuVr6bSjQ0YTijjybIeKIGcgMrnt+CjYCTl
 KcbfbDeSTzPviJsh8x3etb1BkP0IF+JIZOumsOxjtu20ScqDEOptczJ7IJSd6XwZ0+NLCZzI=
X-Gm-Gg: AZFdTZccBgBrUsHkGZmVQicvVX+TS7TxUEcoMDk4PydUx47gh9ImkBpl/lY6QYWBU1X
 uymYvTuHpAmvU28czBwazEso95N0seHqf1hIzFpBVVUYBd9E1ytN44OM6F+fL0fIYTNvCVOojNe
 tZ9Ze+Ist37zef/YP0yR/upScETqZesZVq5MtGzMkhAYL0ZdxIwIYRCQAdMZL4nrcWWgV/CHby8
 bE3qr6dxlYr1Gfv1kujMl6Ltf35rJmUgS5yf8sHyC/eKaLqPGB/FWjk94GXHHQJh/+9Hgo+l7xZ
 ciJ/Pag412FpC4FZiO0rueHOMekOScEV6aIMXeb+Ths1fZunSonWN1Rj6sgO3M/78HROUIDxaek
 xN+kaNasElCYDKt3LM6aVAyjp8OnFpRKzZm5Nm2GbdJkzK1eeTxQIKA2Inst32yfi4re7YQnMpo
 /p
X-Received: by 2002:a05:6a00:610f:b0:886:a737:e0fe with SMTP id
 d2e1a72fcca58-8cd9fe59529mr7520563b3a.23.1795680637699; 
 Thu, 26 Nov 2026 00:10:37 -0800 (PST)
X-Received: by 2002:a05:6a00:610f:b0:886:a737:e0fe with SMTP id
 d2e1a72fcca58-8cd9fe59529mr7520535b3a.23.1795680637227; 
 Thu, 26 Nov 2026 00:10:37 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077fe3fsm10675771b3a.4.2026.11.26.00.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 00:10:36 -0800 (PST)
Message-ID: <1c294545-91a1-4cd8-866e-49989343b01a@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:10:25 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] drm/msm/dpu: Add INT2 GDSC power domain support
 for Kaanapali
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Danila Tikhonov <danila@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b07e97e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ipgrnOdMhYEg8ZrmRaMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: yM4Cihauhqmc1kc3ju9jLlaSgWsDtZqn
X-Proofpoint-ORIG-GUID: yM4Cihauhqmc1kc3ju9jLlaSgWsDtZqn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMSBTYWx0ZWRfX/ifMemadyTI0
 pT042Nz+bOqwHhy/Yc4G4vwu6NBjiKCRO3ognHoknuhQ7gNFsD8kBBJTWOTO/FO8RQzDFOUjyJ9
 lba2qjusETIND5BbOWXcGF8YLvs+mSDO4vY4/OGV04LwWlNXhy0rYn/qWwOAa15w45xdPpJOQPw
 Rl0+S++D2CdpcEXyVZxBomm2FLkQc6DF6D1XXjJIFG/v4+qVs1v6MwSve1HDuET+6G73PmOntwO
 ngLdPCwE3fraFTs+RuXiaKhlKh8BVvDpok5W/KryOFg25X77YcNmUQYHhOrj5Hy12g+JGf37X2p
 pi/EgGS1o5064dNLDMBDRRcn3CTekcQ3RLUpD7hny2KoG1yuf4K/SvGUnzlra8hhVOKm8O3Nyhv
 pCJOFZtsTAIFitcW37oXrMRkXwWMLHoyJFAvrzJ0kHl2z4hGbpHilRrkcTa+0uAKLEaaPlo6tVU
 Z2YtFprz+d1zCoK9Tnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMSBTYWx0ZWRfXztkE5l38qZgz
 nNwYJTGMQUWBaaVwWp6651EEVG1eFi67DAmbfmg7kpDf/nAwziSekqXzdIuI3WXZ5hktjD2GaG6
 3F7PUO99NiokRBGDQtG675tS/lOoUkc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260031
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/13/2026 4:28 PM, Yongxing Mou wrote:
> Kaanapali (SM8850) has an additional INT2 GDSC that powers a
> subset of DPU source pipes (VIG2/VIG3/DMA5). Without enabling
> it, those pipes remain inaccessible.
> 
> This series describes CORE and INT2 as the DPU power domains,
> updates the DT bindings accordingly, and explicitly attaches both
> domains in the DPU driver. DPU performance-state votes on CORE
> are propagated through the genpd hierarchy to MMCX.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Changes in v6:
> - Drop Tested-by tags (Krzysztof)
> - Move power-domain-names to dpu-common.yaml and drop the redundant
>    'required: compatible' (Krzysztof)
> - Link to v5: https://lore.kernel.org/r/20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com
> 
> Changes in v5:
> - Use 'contains:' for compatible matching in the if-condition (Krzysztof)
> - Move power-domain-names items to top-level properties; only constrain
>    minItems in then-block (Krzysztof)
> - Link to v4: https://lore.kernel.org/r/20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com
> 
> Changes in v4:
> - Keep the widest power-domain constraint in the common schema (Krzysztof)
> - Link to v3: https://lore.kernel.org/r/20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com
> 
> Changes in v3:
> - Replaced MMCX with CORE as the DPU power domain, keeping INT2 as the second domain
>    (Dmitry)
> - Used generic "core" and "int2" power-domain names (Dmitry)
> - Propagated DPU OPP votes from CORE to its parent MMCX domain
> - Updated the Kaanapali MDSS example and fixed issues reported by dt_binding_check
> - Link to v2: https://lore.kernel.org/r/20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com
> 
> Changes in v2:
> - Moved INT2 GDSC from MDSS to DPU, as it only powers DPU-local source pipes (Dmitry)
> - Dropped Glymur — only Kaanapali actually needs INT2 GDSC
> - Used if/then in DT binding to restrict second power domain to Kaanapali compatible only (Dmitry, Krzysztof)
> - Dropped PD_FLAG_NO_DEV_LINK, let device link auto-attach handle INT2 as runtime-PM supplier (Dmitry)
> - Link to v1: https://lore.kernel.org/r/20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com
> 
> ---
> Yongxing Mou (3):
>        dt-bindings: display: msm: Add INT2 GDSC to Kaanapali DPU
>        drm/msm/dpu: Attach CORE and INT2 power domains on Kaanapali
>        arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
> 
>   .../bindings/display/msm/dpu-common.yaml           |  9 +++++-
>   .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
>   .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 ++
>   .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 ++
>   .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 ++
>   .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 ++
>   .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++
>   arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 32 ++++++++++++++++++++++
>   15 files changed, 99 insertions(+), 3 deletions(-)
> ---
> base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
> change-id: 20260720-msm_gdsc2-cb9230027a2d
> 
> Best regards,
Gentle ping. Is there anything else needed for this series, or could it 
be picked up for the next cycle?
