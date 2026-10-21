Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0B606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dnASCy/7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NgVu7kP/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7EA10E32A;
	Wed, 21 Oct 2026 16:59:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449E110E144
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:59:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LGSbS91689352
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kvpaENdKCnnkQmf53UEghOPi
 myZ9+7YOOkdrXXfDg88=; b=dnASCy/7EH0UDeGsa0W7Ssi91Z3ZvpExgD2rNKUR
 I0RbWjFoJgqR6Bogy6MgisEdQTYfTplJhVR9M+o3ggRfQEHqg/29sHPQdpirdN8V
 wImMxzTTWfcsxwMqsn7+au6uM+taaAPXPAumj9+97Bw8cT02VvgKtMq0y+VLlU/j
 cygHY4qBl4uxsitNV3j2tRz5d99UMlJbMB0vOjegHpjAaRvzSAJr/qyZdh9QGg6H
 VuAuHo7MhJyaOZDGDjqBPSXhXh6YinFLskGJ44c4rRyekLV+GS7RuDcoZPrDpr1b
 m3TVEgGwlbSHoxXP+rLt7AJa2h0TCuOkU4fEx1NqyiVvTw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v885bb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:59:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so204611785a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792601975; x=1793206775;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kvpaENdKCnnkQmf53UEghOPimyZ9+7YOOkdrXXfDg88=;
 b=NgVu7kP/UpgoC9e8lik1djwT3Y0Qx8noFngiylxxnlAvlmJKGkA75/QiKCK/M1CHTW
 KzwOi/UJS7g3OEZbqMJur8me/lStQsWskX4AjaUVbwqEsy9IdobQpi+BQOYSq/NjoqM8
 +E/WBmdqWG+vWUCiD6lLUevRwxDKKu0yUrNFxg0k6okzrlYGQKTCnrt1W7g6YJ+tOF6x
 Gww4crHa+yawCHGPOZ+vBdU/LOXAl+d9IMsJKUh8V504VuSzqjOBIijV5+08JITmyzHw
 xCAt6b4ATJcDrCJhELgHKpgNjcrvGpYvwreIQEz0qiGCPkIE48OkFEMTDo5pGRGgv8v2
 gT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792601975; x=1793206775;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kvpaENdKCnnkQmf53UEghOPimyZ9+7YOOkdrXXfDg88=;
 b=FRLIN7dO4jBRC2F23r7NWXL0zOn0Pyrn4Gsnccw2Mc9nyVJut7jIRO6tR3/KU3i0qd
 VJxx4BUZ8fdU+CRo0XFWvX76WlGHYlfzxHC8mo5PldOujfu9fCslQTfGAAQKRdye/Tx+
 N6KCcnFOqmzBbGAgAZTKoKJCm8Fa4mYmFoYvnlD3bbebeAH0LKtUhBD84X1thsBphF1G
 xaEBgKar0FZJY4IVfbTWSWF3CYSDYMNSqKClUePixK9MoLkbkBOd9TKHq2KNfcq/192B
 yuv+lTZgTDx9qxPa6X1bFgaorM0YRelrYfya1F0ope2jJAM1ZP1/Pf082gr/9hfUYClT
 BWOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2nOAKfBuZr+XkItVB1TqhLAC1be2Sf4/ucCU0sgeW3Oxv4QkXOzMSFmR5GJGHW7cpaYcbM0N5OSk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL9ohywUIggkPLDKS7t2ovv9cp48hhyOLMA2DbFtfA25ViU05h/
 78vBGZyo0zbxTae8q7Rhi5Hdelwta20cCeIWJ2y6D/FdQfB1rASpXgVw8R102gDJs2R29o4Bjsg
 fZiLZjHjh1U0uK8NOhEWMhzSHKFqPffPA9eMb/suPqskEiOKJJ4Wm+6739MFT1VVkXALQXNk=
X-Gm-Gg: AYBFou3qlYkjLI2PLgQ+TYi/gsf4QWHnIjsMUa9zWVUWB7cutA6UUJV19n9ZMdgb4mZ
 YvcPqf8rtd2huUr2JCPQtsADM/jLQIuPonojCbuSlaeBmlqA5gJOChcCki3rGwBpHX8QUGpWhPQ
 /KDagJE+Tq8ql/78SU++d6Prr/nvERsxZfRR6IituAh3txgcW4REuPc2rUopYpEgZwBdgk0ylFI
 Ugs4iUf+3uKuogUVI1FFre2PR2U8IUZRxO/xq4NdR4Kejgn0XqJADiKNHj/sN83KuP3vz9XfPof
 dHt8tnVzHANmWwI4bh2KTdCvQlpTSt7ZnQW6ya/2lA0gxG+/PMoEazsVlRI3Ckp6KSOZIW3LLOk
 +XQbUkdXeYnoaNDe8sxqQacx6zq6UV5IiGs2Pm/SFsSpquDBFaLa+L0a/jYa8kF48te1FSrTWUl
 oFn8X++0hImXlv
X-Received: by 2002:a05:620a:4443:b0:93e:a51e:7ffb with SMTP id
 af79cd13be357-93f57f06a3emr520455585a.2.1792601975223; 
 Wed, 21 Oct 2026 09:59:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4443:b0:93e:a51e:7ffb with SMTP id
 af79cd13be357-93f57f06a3emr520451485a.2.1792601974583; 
 Wed, 21 Oct 2026 09:59:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa1233f91sm627678e87.72.2026.10.21.09.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:59:33 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:59:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>
Subject: Re: [PATCH v2 1/3] drm/msm/a5xx: Reset the GPU when resuming it
Message-ID: <rbbosxqd6dverme4gr4lzcsj3cjbrxioxxrrkjbn27gj6a6ag4@7ajznwvses2h>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad8ef77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=Gbw9aFdXAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0XkAg80coZZ_RUxBgWAA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfXzuRGx6372yh8
 huVKDnl1k0rj5CobA79xwt7elUlF6belszrM37tqE+qkMEOQnrrmPi811BHNKoWLVwHrTURPqcQ
 yJpvwBWdPJ06cOPP5wm96vTx1NnuzlM=
X-Proofpoint-GUID: m1e0qS4-cKemYB81FvnUwoL1zC-AIDdj
X-Proofpoint-ORIG-GUID: m1e0qS4-cKemYB81FvnUwoL1zC-AIDdj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfXzJ733hC2oDPj
 w9Ob7sJoqzBu8ufSkZEg2rPKJqe4TVvnVICMEXNbAnQ41nsFyAwwMl0iuywBJ9kOgW56EOXNjfD
 I2MWzosZjPp6znRIhTxsb7ojY26Ye7cvzBAF/fzQ5mnWneBWc/TIQbA+YmGFN5Vtpv6SqikKpGS
 QTcLiEnjZ4LIxEXuJY7HcB23WqlWNpBRSDv3tYXNzh8AMCgvJGfM1qSPimlbm/SdxlT8QmYjPxi
 YIn1dbQC/ftRxGpF3y24cSQbP35g89E4Hja6XbEk7H3uGCMOmBVgurQhZn9QPIrSAEN0b3Y4oWT
 0nrfhvK6BEV4Hlj8nQ9uAU5Vq/7SSWj9NvSMPLo49qAeDWuc8nlMT9GlKk+wfY4Av/xSOZ+6Jft
 WU9H4golQ4h/HtAhgQh2nVw4qV5Ws61P55xeg87hyl7rOUX436MScScTjnY67hIOXhUSjJjZzKp
 WxoaQo1bOSE6SukVPGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210067
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:05:08PM -0300, Fabricio Akio wrote:
> On SDM630, SDM660 and MSM8998 the GPU's GX power domain belongs to its
> SMMU, not to the GPU, so GX switches off only once the SMMU suspends as
> well. A GPU resumed with GX still on keeps its state, and the CP keeps
> its ringbuffer read pointer. a5xx_hw_init() then rewinds the ringbuffer
> and writes CP_ME_INIT at its start, while the CP goes on from its old
> position, executes stale ringbuffer contents and hangs:
> 
>   timeout waiting to drain ringbuffer 0 rptr/wptr = 23/C
> 
> Soft reset the GPU in a5xx_pm_resume() once it is powered, so that
> every resume starts from the reset state. The downstream driver resets
> only when it finds the GPU's power left on; resetting a GPU that was
> powered off changes nothing, and on A508 the reset takes about 2 us of
> a resume of about 1.5 ms, so do it every time.
> 
> The reset also clears the busy counter, which msm_gpu_pm_resume() has
> just sampled as devfreq's baseline. Take the baseline again after the
> reset, or the next devfreq poll subtracts the old count from the new
> one, wraps, and sets the GPU to its top frequency.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> Changes in v2:
> - Take devfreq's busy-cycle baseline again after the reset, which
>   clears the busy counter (Sashiko)
> 
> Tested on A508 only; the reset runs on every A5xx.
> 
> A stall with the same signature, the CP's read pointer past the write
> pointer just after CP_ME_INIT, was reported on an A509:
> https://lore.kernel.org/linux-arm-msm/20260308-adreno-ringbuffer-drain-timeout-recovery-v1-1-985a33faf108@postmarketos.org/
> This may be the root cause of the A509 stall Paul Sajna reported there.
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 15 +++++++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h         |  1 +
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 17 +++++++++++++++++
>  3 files changed, 33 insertions(+)
> 

This matches the issue I had on MSM8998. For now it's:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I'll update this with the T-B once the board is free from the previous
set of tests.

-- 
With best wishes
Dmitry
