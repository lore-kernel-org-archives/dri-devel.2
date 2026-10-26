Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA217606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J5aIRmgb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KDAWhkdy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF0F10ECE6;
	Mon, 26 Oct 2026 09:17:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BDB10E03D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:16:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4asXZ3303625
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/R1V8jcwmGSYG2QsWGibA1eheKnvmEoWMpRIpkWm5Q=; b=J5aIRmgb268pn19z
 DSO+mrBdgpsEyVvl6Rz7K/UO+z4ZD0c3wMI7EQE+cCpUAtNzXdmz2OKqMF54n9FI
 GmvDPOCtNZikgBawjr+e1vzEBxuWucEh6GGZPAPHgnAtfDe/Ek1Yodk0BPbi+Y+n
 UvD5JmMMgh5AcUY7Xs4fk7YqNaoLvUmXcVbkV4d3uEeEvU2C7zmNZmOgWB7StjAV
 Z03/v60mrkfZZ65MRj1MTJiWbUQ1eRKEBCk9r/eA2tKUVfPSGRPzSORodJY4eSPc
 BCv6WwYZZFDDGjthK+DoOeiTnm1T6dHDo9D7c95tf/efqHEBPWIOeAWROvTFrMTT
 /TkNeg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsdr03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:16:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e629c7b16so35318385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006216; x=1793611016;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S/R1V8jcwmGSYG2QsWGibA1eheKnvmEoWMpRIpkWm5Q=;
 b=KDAWhkdyMQ88sEqFDrLoREoq9JDKYncfuLao8p8ACXaWCKdHbG9gPUlx0juKmrVWcj
 F0cpjaFSIeTAz9iRbkNeGAzW0iaTCbaraCrpYbh2ihrrixzhK/cojThG6okMbAniqaHy
 9Ke1CYq4Sv9BTkdWRhpChFsL+uEQ2g+4XUyLhkJbmHcHehV4vvHPezWaEaSC1rtFyjm/
 FbJ6ic1QMM9Q6zwiWLTxzJE8rEEDZyeIkkrb1NsoysroLNQU5OyKSmvw37roddAnWIcS
 pAr1YTTm3VECTg02bwAVAkWiUoSLhn4C3AMt8wHNKMhWV6IGkCPeLlNLMh6Hk+pT/DPT
 yt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006216; x=1793611016;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S/R1V8jcwmGSYG2QsWGibA1eheKnvmEoWMpRIpkWm5Q=;
 b=ERVAnTtG5l/ukhKK5PeKwtCEBjuQApyzLWhi6LXpADZjX1WEAlAO9OfOZ6cINGAQf+
 RcDW72iFxinPYHOnETiEz9ZMxcuwveXZlM4AnDbKYbOsHVTcbJKAGjNmNIW6L3QohdZG
 XKE6tn9j2vkPwbkKPwEf9p9rTjP5XLvbXTPxLCTubGjM0eWu4f+Z44x/IpprRqCFO6OP
 O8SgZSfBGCQ3ecbfBMTk/2MeqlNsrywYPlqyKMyAKuI/usRuQZjsmOVL+vZwZRShCubx
 TbllHRVpGecux5BtZ5bdUwJSRT/SZ6LGBNUNevsKCpFcx6oSs/hXhbR7SU5J4DP1wjke
 XV2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKEHQK59AAA9gCS7JZpZmdEgFyjHqi2CzDZGZuWVqzYpT2yjzt2gckFeSqAo6FS/v8THSPxFgaC8A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLCTQUJXlMDLAXIfBWHvyJyBS4xd1Ff2+zGE1tXKaQC2Gs4ZDUw
 zaU+VarN+RojTw+Nt3PWUOXoij3PVm8kgglvMpnKBL+sLZA38+78BXNHLQjP6NoPwKk+MJpkOeg
 HOxwhxfb61TIVpyRxap26IHF94kDp1m5+TVrjmsSXge4OMV2cAo8Tum/um3Q2ddhIQvzjlqM=
X-Gm-Gg: AYBFou0Ch+TYhSWOq2pOBlsnYPBkLA+UetkTDg6i1OupLEbeJYgRWPEssc4PApXYnc4
 MJDNCKte9re9R3oFbNJF6jO3R8TGWoXAiTAupslpgUpgPz3+aRi12WTqFQhSEavZakFopG7rHN6
 4qbaIZ29SLHXxBxPnXsykbBxQItD3HTh80oaB2JEcbY2p3xuRXh7wMMsclkMI+H4Uzwtef4mLT6
 ZDeMcSlVPrC0O1fwLceA5xKvkWf4HtMjHq/r3ZXm0ScWp4ijzRKAx6S6xt0Tm61sftWUkMVcV2n
 6lg28Fq6panrCmsUpngW6oalGYh+dHG8gatLOVkY3Z083hploXZRbtQz76eM09nOwXDNalGER7u
 7sarKyoM59PjDZcQS/dcGpg==
X-Received: by 2002:a05:620a:6e9c:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-940ef81147amr890801285a.2.1793006216192; 
 Mon, 26 Oct 2026 02:16:56 -0700 (PDT)
X-Received: by 2002:a05:620a:6e9c:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-940ef81147amr890798685a.2.1793006215661; 
 Mon, 26 Oct 2026 02:16:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b44595e25fsm3373276a12.7.2026.10.26.02.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:16:54 -0700 (PDT)
Message-ID: <a1f0d3da-fe38-4ee9-b876-1884ee14d74a@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:16:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] drm/msm/dpu: clear the DSC blocks left by a
 previous reservation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-8-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-8-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9w_mGGALt21XGtyzG2gqGR7QYievUfYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX1CnqHcl/moKa
 9/83B9dNeAOEpee1OKt+Dt8JgkDgpfrLsGN09WIlT3xstMkS8mgOVJXXujosMUKbbOXDCCk3Lz2
 QweNwgCWRwaH6gzKbARRb01UN4LzJcGOVOEzTqBf0GlT8UN14mKK0iShiL9m/VAzhLdI8BmDbAK
 o9jGoY4HAtfKR6vPModaQU7I964gtEdlkMWh30y1kO2SsmNr7ZZsLq8AzculI4mESILkddjP6uQ
 4qwupE8SolgfdsqXDKDewGjMhs92+oG02ze7eWz2+qPJQ7ucDNZiBWkbZ/FpoGQzPwp7a6rOyId
 S5L8fkqO2yTacnajYdJkUpDqoVu9hLLThoISCPeLNyrRprdWHgSyBDGwd8tSV4ymKOil98aJMKb
 T4ooff9yWlcu1nYsX/ZOtbby61ytvHcOx5ADU4HRb0TCr1SeCV9SlqRFgOuYZtuYBpNiQdjEbDU
 kU1QPAVTqDnlBUEhZTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX9m3nfve8kdLt
 iZRGrRIHsJbVarhaHLeLvMzSgaJ25ZEBAP2VcdqzOqGa6mR501fcLEvjWmVMJxPOyeL+TzYFU3+
 W/5gpxw8ODioR/WSRGkbOoIHaZNIZjI=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adf1a89 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=201-j9D5Wx46gDUpQiAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 9w_mGGALt21XGtyzG2gqGR7QYievUfYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260036
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:25 AM, Dmitry Baryshkov wrote:
> dpu_encoder_virt_atomic_mode_set() fills dpu_enc->hw_dsc[] with the DSC
> blocks of the new reservation, but only the first num_dsc entries.  The
> array is never cleared, so an encoder which once drove two DSC blocks
> keeps pointing at the second one after it has been given a topology with
> a single DSC.
> 
> dpu_encoder_use_dsc_merge() counts the non-NULL entries of the whole
> array and compares them against the number of interfaces, so the leftover
> pointer makes it report DSC merge for a topology which has none, and
> dpu_encoder_prep_dsc() then programs DSC_MODE_MULTIPLEX into the only DSC
> block that is really used.
> 
> Assign NULL when the new reservation has no block for the slot.
> 
> Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
