Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E2606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N5W8DIl9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dTbBh4HJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8987910ED61;
	Mon, 26 Oct 2026 09:55:07 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6F310ED66
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:54:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q8xJQj1912036
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4lGKfZVXFhhfUcscOMxly8EEWx0e5wo0QpCfadLOD5M=; b=N5W8DIl905zdUdEn
 qMbz2L9XzB/oJuADjsf4cZE/bvkhvRd6uu0G+9TTTul28/E1lSfrBHA8Z6IMaFil
 NQA+jkFNNyZOQrnEw+gHIPcOlukQCh+GN60GQt+X+9wcnO5qtqtYN1SxTfYyj6eL
 vh8RD/RSU6vuoMIPqtDyQH1IRWH6cSeb9fsSDvZ8nW28e7fQ0bGnrS4XFjh+D2kQ
 AbVS4p2bpszlELjTh01WbWgrM6/UJCEMTdZH+TGVA7lkr4Eeh13R+s/bUlXeyKwB
 Lak2AUheOJNar1ZjP1ZDuJbRv3RZsjx/vyW3+K3bf6bPqDYONHlpzpowFz0jfipj
 MiDRig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u606jk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:54:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53630cded29so11227811cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008495; x=1793613295;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4lGKfZVXFhhfUcscOMxly8EEWx0e5wo0QpCfadLOD5M=;
 b=dTbBh4HJ/NAVHysBT22O8kYD6B4aOwCqo1Fdjx++hpyE7tKtpG6bMLnM/5DRiAdjAZ
 R2SvbhAPO2nffp1wdmARnabhNFqsHQ78OWnGj7dRhI2S+f4cAGaF9rSu9/rFwjHgbGzO
 oUNPhG/HikhZyDMt76+pS85jUAhSyGpKdK6MTCuctPKaACqywWo+ltDylhmMbR0CgiXX
 kBpMkM8FiPcxsB17NShgwp88GSYLv2XyOxeEqJPB3sUmzbZvLhPLNQOM3fdj+TiEQqmt
 xDtYO+Ak9A2MDUxQPhsWSpZsikfpyqWxLb6/BgSZ317WyZik+VXLsRbCc+GIkZQwMYhc
 t/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008495; x=1793613295;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4lGKfZVXFhhfUcscOMxly8EEWx0e5wo0QpCfadLOD5M=;
 b=nYaLZDDoQzKYlQxH/BcM7AjVvpI3F80lWZsBdrYHVW7HUoW9QHwCcj7psi8nAun1Ue
 Ms1W3uyM9AlP3M4ZBvccS6Q9WwztxgYpaA5eu+vmZLJ8KbjAc9ZWtytyvxl8XGQ9cVkE
 6rJAbUDi9HwWQvrbISl23aQDfV4VSZ36uA66TlY+ul7mS8XpfNtmvbddp5dHaSu0BfWc
 FNyNYtNAi+DJ4W1hLE850k0WQ8o58V3WmP3h/6ZcDBqyVb+G5/doz75jpABf/QWFnAXI
 HgX8jdPm7gu0hl2I1aEPLDkFDGXlz8TOC68a2a0vGS40IJUpbhyap3aby6F8loKzRYQP
 7R8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByGt0rlPRf762MPenfwm4ifDh3CCAbYJysALehBedksoyccOyacY5uMNBSQ7aLuC8xUNMJB5klwQek=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLIE4ro19ueVGWMDGaygtauwpMCFeT5OSKziWc1aE4sXZXi4Bk/
 K9Umi7IStIAIXu+Rp8FPW7580hcjgdfX15jeslXQoCOaTrZ1szX9p+EyyJUIFRd4WUbQoVhfjlU
 DFnWK2LsBkp1gZSGeJPnktk6s5RaLSLFq6dRzR1yykijgvw/iFhokyw39F0qe6T+tjNVqV50=
X-Gm-Gg: AYBFou2RaaT7Xb+1JQD8/PXQjgxBZsy5cPzYclwpdrkPK/Vsr/Lq6HODUBSBJDxjBwY
 Ej/5x6bgGqFqkmg3zrDVaRaZr89URqmN2KIENerUxF436Z6wnMBI4AHRDv6iFBVxD0bjTPbWPsG
 0R2KZH9EwvpEG4sdSP180UqmHuyVlChuR2y7QtPud3FeZBuUtmX6sT4K2t0Jg5QsUnhs3GOlSr7
 U5+w8GkA0QK7A+B7LmEUELVfyjk58EgliDcQ77aoVcAZjj6JiKdJwPfy9FsPWP2yPNRIEtmqgSc
 89lCjsi7ZIcVsedA/iqku5MoK5FU38uc47Q45LRc0Ku9BvkcHAph3BOuxiuNqlzrNwRsowS2e7l
 P9j5px5VSBTNYst1mLwRhzw==
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-940ef672271mr925540985a.0.1793008494882; 
 Mon, 26 Oct 2026 02:54:54 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-940ef672271mr925538585a.0.1793008494426; 
 Mon, 26 Oct 2026 02:54:54 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm309870266b.35.2026.10.26.02.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:54:53 -0700 (PDT)
Message-ID: <370ec92a-2c33-42c0-8579-495e8bb4ae8c@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:54:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/msm/a6xx: Request CLX enable from secure world
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-7-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-7-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1bbyp2frj6C8OldSsa_hXUYbWxmuArsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXzv+JtFHbor1h
 1gUVB1qefkJONSfj6qMm/hQBJ+/7IKTGcgA8kUuVqrtRcVLk4kEoyM6D19R9l1D25YmXciXO2tO
 QmWxVURsQbZt9N2clt7oNBtH6o+WtpMf4CwFHYITg2xAZyrDa3DteHveU5v7qGbCAT0VKo0XI41
 RUg4JV8yRTorc7SVn/a8hC3AjURjBQ7cDaju/j0JlYYIhJFO8Fr7Y53U2ElcNXmx76VInwUKXh7
 3rShv+RDzu4PWM1S0pF6OZumwaIYm+NGnyc9if5Vyc3Zaj1YkruhBsmOqs32OgF22gIQnGTxMxn
 +428sDt3n7JwXEqVCVYrryGRkznf75i3hmfzFKtzOYIRim7kuQ5vcO92D7eiQ6/cpP7luL9j7Wv
 AsWWYWf1/Bm7Q9x85HViCC/5AOkfDZWwYe4KqBMaeCjsUxXBw+OJ+FJh2NvkVpu5XazU4/gpRW/
 /piWezNdXWbAsFLRTnw==
X-Proofpoint-ORIG-GUID: 1bbyp2frj6C8OldSsa_hXUYbWxmuArsw
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf2370 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=UCowTn2RA8sYE9T27pYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX6CZnQA0Ww1M/
 c82h5unSdvot0RcjZw1vzdNhLyiG8D+tONNku5a27CM9Cov4VxfIICBG1t7YJ5ig6eWkC2OJXX6
 9CVxUWV5pt1AN51b3n2caO414plF2oE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> The CLX (Current Limit Extension) feature also requires the secure
> world to enable it via the GPU init regs SCM call. Without the
> QCOM_SCM_GPU_CLX_EN_REQ flag, the CLX tables sent to the GMU over HFI
> are not effective.
> 
> Set QCOM_SCM_GPU_CLX_EN_REQ in the SCM request on GPUs that have a CLX
> table in their catalog entry.
> 
> Fixes: 967e62fbeecc ("drm/msm/a6xx: Add HFI support for CLX feature")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 991db3c9cd96..a1561ca41a5b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1247,8 +1247,12 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
>  			goto done;
>  		}
>  
> -		ret = qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
> -					     QCOM_SCM_GPU_TSENSE_EN_REQ);
> +		u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ | QCOM_SCM_GPU_TSENSE_EN_REQ;

Preferably any local variables would be defined at the beginning of
the scope

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
