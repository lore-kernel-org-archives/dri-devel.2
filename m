Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFC606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HVKefm99;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=clExDWde
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED5C10ED59;
	Mon, 26 Oct 2026 09:43:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135C510ED31
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:42:08 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aSJg1708639
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EPtH13VTn4R7Yb2sy+8OKOvdDZ5ZAvbReyMqod1w9Ds=; b=HVKefm99672kmLwm
 g95SEjJpFBWotCATx/LSN0mCzjCoZ+VneujD1PYIVRclmxKqeCKxKxalyWNzviNw
 lp1b9NIRgsHsj4HoIVlZEh5oBwZ9gBLiGRBG7OfareMEZbODh8h0SM2BsqfJ78Ax
 T488IxfRurhRCt1xDtJgmiBgwUsFKvQSWoQ+w55OtCctFYmKSCkNwRICrS6PNDxR
 kdGV560SNtQazwYwYQk31E8ABO2bSLnWOVmYnz+HxlrWKbEY2AGmjsLP61yfJFh/
 01DzUwpIGrmE8RatdkGUFnUQEpTJDxnAxvy3Vt1vkz6ghbmjdBieg6qUX85HaL6v
 5cdEhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9tgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:42:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536708d1a3eso11948901cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007726; x=1793612526;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EPtH13VTn4R7Yb2sy+8OKOvdDZ5ZAvbReyMqod1w9Ds=;
 b=clExDWde2KN4JiQ/xtC8ylg4osCG0usUQuR87S8nlZskdFSPrGC1J4jVc8JRATkhrM
 MNCRExNEEXuNPkoEosIqGckILvxEqJhmRmfZJM8t+yF/bfCG/nKVzXDCf2GgnqaHm20P
 eV+4XlIlYu9tEVFMrRB0QmzAsoZVOFL4vYtbI699992p0HatG/BYyEUij1VVOgXHIb5s
 qtKdpnvGEFrbVz1n5qCSW+zU9z1emf9FfkJWbaqQS/oo9hVE/ZQjYA1FMa8TyYZwxCmR
 dhcOZ67qjxl57MP5tYT+Nhp4+sb/YCfvdlhDiaNmY610gnpB7l69l3NMd+NmPfYAqvoS
 0I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007726; x=1793612526;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPtH13VTn4R7Yb2sy+8OKOvdDZ5ZAvbReyMqod1w9Ds=;
 b=J/v2FHSDWxj9oXU/Er2dpqDZKYMLVWbinNl7WcwT5tkTSXqZhfpsuwmzjlvPXE7JQb
 po0Lwt/Pg3If57rwwtSzGqZevtOsCU3b/j4eDxqAFYlzmB5ANZyc+0u3wwKvpI4DHi8R
 sxliwGSz/Wku8oLL6DRTjUi6GQoFK8y1H6aBCsOg4SpNQNftKSYo/55oJBpNWIkiTNmA
 05L5AnuaxwJg+dsbKi/q/zBZrwHgnehPJAg6FVZ0761CPrcAE5bkj/s6nuOzcmdSvjMd
 a4v5ObC9Xe+maBa5ILfewiVWe9OIXJcP/cAacL+jTk2rEWDcaARWodAqf+Zhl3DvAExU
 mRDA==
X-Forwarded-Encrypted: i=1;
 AKwUvByqilFb95cHQPvhDdIu5E8clGn0WfumKoDvTPhJLTOO1e+GSrJh0zsBrGzZAUJLnp9nECbtQT7ccbE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIaI4NjzT+XJEOHCbujvIEeEKVr/G6kGy2rkl0zMPde1kRfQINA
 IbHM894rlKRpPGaF7m+vK3+4pppNU+Jatio6732b5XBYpRJgVsEPHxzXtQDRVISFHh4xcOPRl1V
 A1b6p3e9XgGMbTxTM0EFwee2VZbXIRZuJ68Da3G2RWLAS3xEWq82BUGY+tYKhBkFm57kUubw=
X-Gm-Gg: AYBFou1gisnq5RMhnvvXJgNfzwH8sIagHcEbtQTCFXuLNQT4HD/cnaGlg/R/BWCde5k
 WzLDI7DlnZQc77/J5DUZOQqmGAZNXRY0jBhyDUmR4skRQkcKl8dBxwt0nQkxvINugKb4TcMV+Y8
 n50rWIE/xvmeKJqq+rcemcxGTCkhQsutKeV16uWjBIjYG3bq/JO84/RosXr5FMUyZP1IakbSKVo
 pX1IdT5St688MuvxPeAKLJ0pqTkOagQ5n9XwOMbhWWz0yG5eWnOJUn4zsZeZ5iWkbdLTxEqtZRs
 mzDaVik8ENooM3gYFTv7Q7sIMUfS6I3xFqRIEDvRS5dNae2IO9IrslI/i7kVwWkjk7xZLYV3ntG
 KVZDgdtAr+p1xs0xlYQQarw==
X-Received: by 2002:a05:620a:4918:b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-940ef7e9992mr977928385a.2.1793007726377; 
 Mon, 26 Oct 2026 02:42:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4918:b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-940ef7e9992mr977924785a.2.1793007725804; 
 Mon, 26 Oct 2026 02:42:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm308924866b.51.2026.10.26.02.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:42:04 -0700 (PDT)
Message-ID: <8825300d-4ba5-4a42-a27f-1378132470d7@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:42:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] drm/msm/dpu: clean up the self-refresh helpers
 on teardown
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-11-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-11-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6Pbq_JgW70JqtLVO4HDm_tmXO9tzujTu
X-Proofpoint-GUID: 6Pbq_JgW70JqtLVO4HDm_tmXO9tzujTu
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf206f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_fTQ-MXv4NwHnn4YafAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX72Yyru/XWjMo
 mnj0RueIQHKjkzVlMudcF0c5eFaHtyHlyc4yuZIrHRrJ4jhnp4S7X28NOetzEQdqyAnVSwyVtO4
 7LKo2Q9Oc7VW2BE28AGcSzR08JiFx+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX5XBR8ycHyhV6
 V7/ekJ1k+RtjcdLM1891GmlFj4pl+G9nACgyZ2iJHQYaUSnOzoXZ585wcRo0WJGiYWzIseoZO7m
 P+diV31rrKP9U6vUZ2YR+MxEHDS9WUBd0mBLwnk98jpXR0Vb+Z2AhPbFcFQkGq4a72pfaSYmBBV
 7rzxOFMp+pIhZ38CF7M0OpI+jLVAsFC1Ia6Z622fToUNpT2BKXD89JHUhmzxNOaucudgbZbi7Nf
 VODzdLlYV4F/edPmfXx0EX61+it7Ot8aOFp0tfjaNvFamb6duJC+ClHw8tZ7Z+9xeKvxRi2GqJC
 Ml+MUXc9/rM0x3tVqwkh+2DcLkUbYDopgs913XXxCw2VeNNLzYM9nQRu6PAn9lPVb23ASdy53sZ
 h90Yd5a6q339SMCMG147zXOpNMIy0lEaq7llEhTbRdopSOLZMjtyRXixTaRw8C8I9InpvT6Esk4
 r4qwPlGwQ7AW0Zqbu/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038
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

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> Unbinding the display driver on MSM8996 with DPU oopses about a second
> later:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000870
>   pc : drm_atomic_commit_alloc+0x10/0x9c
>   lr : drm_self_refresh_helper_entry_work+0x5c/0x1dc
> 
> dpu_crtc_init() sets up the self-refresh helper for each CRTC, but
> nothing ever calls drm_self_refresh_helper_cleanup(). Every modeset
> commit, including the one which shuts the display down on unbind, queues
> the delayed entry work of the helper, which then runs after the CRTC
> and the DRM device have been freed, and its data is leaked.
> 
> Clean the helpers up when tearing down the DPU hardware, which cancels
> the pending work while the KMS is still intact. Doing it from a managed
> action instead would not be enough: the DRM device, and its managed
> resources with it, outlives the unbind as long as userspace holds it
> open.
> 
> Fixes: 1122697810e5 ("drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
