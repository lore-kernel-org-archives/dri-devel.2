Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43680C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 01:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B44D10E0FF;
	Sat, 12 Sep 2026 01:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAh9sZi9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CU5OFTc9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E4F10E5E5
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:55:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C1HnQW1167594
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=dO9Rlve2Ra13poOIPSmbNHYnX+XzabrihEjpiFcx0qw=; b=cA
 h9sZi9GAnqA+3YVu06UOVxEImSlcqa//a75kClq/YGD1fx2SpjurUSVSAUyUFmFn
 UqhPUaRQV8u34y5XCbszsUORzKCufgNJctRaMUbzWElByDEHe5lzXqIgwKK+QkSF
 kjr97UuO7swDPLBSk/8lr0ueerR0o446llBkkP1uJg+axkPdmFUjOnp3kxvRXbTF
 GJqBfPB1Mm6N1ks/uHuOTFcyIcMCBZrW+2lXBKx74YgqBPhMe1BVPuWVwl97bPS6
 +A6Vett/Dl7YUW9jq06qiAp4nAUVkBrZX5sgTNNKUINKFNUh0oocHBymixxNMeb8
 HvqLN3bSO2JcZNNecppQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmvwj02b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:54:59 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-8052a85c504so556910a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789178099; cv=none;
 d=google.com; s=arc-20260327;
 b=IoR4qKxnlIw58otzn+w2ZZRCHbhQ9AMe/ybkCpUR1AHySYmrwPY/KHsYrTowXQN5IB
 A8WvgztRiOHqTzTiEHL54GnRZyNOCN/UweIVYdZMjpGHvTs+DBelNTwsPTWgOB28F2Lm
 PfCpIa86JvoN62tJJV2AgEgVUr8jj0otka/2SEgRiho+Xyy2ge8PnFT1uXnsfUSsSQzO
 w5yvI1oCFzfocjnAa8+nkywCWwaxvIQTUBLAu5+U3Ry7qYAIOHCNzKja0CyuS0Mmikd9
 jzBYtgH+8uTRPgS35zsVfzac1xF6uYt2XgLnpLPEEFFNV178qO5DW/OWkL4Pdadlp1PM
 7tuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=dO9Rlve2Ra13poOIPSmbNHYnX+XzabrihEjpiFcx0qw=;
 fh=q95NBimmkwiqhYAI458+6aS8Wb1CdbTq0KDCy8e7sE8=;
 b=L4s12HXoVTYFKf/AIBKlEOQTivwqqJxSOMObVFypBEzGwM/o9EOfCOnrpSjUQFBYjD
 z+SJ/HUS/D2rx68ni9vntauwNk6LzFfjzIVba9p4y2oQcQMEpQq5pl8FblBvOXN9tWCq
 CtMAzsJY6IDP5toJDTm+PnnGzKzdU2DEHKu/Yf1A2gfRAwiOr6e3IZwQ+cwQGdmOCzcC
 gRTfhOD79hDTIhz7nYJ0akuLCO2MVuwtcPJWjJtuWrOD9FBP77vDuU2IQFKRz6dSkMIH
 OLlMZN+5PsSoKBI/T3k0GzCBsJBYGqZhsgq8U4h76AFXfuM69SjqaHv5fWyIEnzkg7pu
 npnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789178099; x=1789782899;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dO9Rlve2Ra13poOIPSmbNHYnX+XzabrihEjpiFcx0qw=;
 b=CU5OFTc9c5R3Yl+XpT2Fs0c8ntgaS9sK3UuS4zn/w8EUV70i0L83Wlgi0W0umxumcf
 C8OweeNRHStwEKtxzdmkNrEegNsOJosMDczO9/sGA52o49BNYu2fR5BqdzlX+fjU+qjY
 SpvqWGTvT7HnoaBI8byBAzihaXreK05Wd2elmu6ynl7HBp8qXl8EXm+EEiJzYuRpqnRR
 p1qItpaRtriAMf8hC8d/lB6sf0f9kn67Rq9k+IFyTmzSYwR3dF83pCHuLzWkbqNQt1Tw
 yTgT5YbfGl5g8BOH3QPJZtYVfv8anK9aqqCJ/ME3YXKFsMpaIUpxcaBuGwCoKiVR+Vp1
 TxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789178099; x=1789782899;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dO9Rlve2Ra13poOIPSmbNHYnX+XzabrihEjpiFcx0qw=;
 b=KxUY99ZqkS1kVJ7ihI0Qwks1ujnap5+UdpNbRZh4KuWvyDRIwrZ/UjyF/+KyxMI+9o
 JQXJUnyxyp8FrGXClHELLO9EOp3eJXJ5AaMvS5gkixyX408FqqqMrxEYw/R4ZCH3zSBG
 yaPQdvdWFN2bHJm1lFxnADKw1LOCO/0XfgR/VXRXXVEMRHtlfbYvAUnp0nlAXBuHrsPE
 KhynjVubpJChHDIxPkDwFW+VmivK+R76axWQioXjBuLo+liiKQ63KAqtXs2NsRmvY8n9
 njkexypEutyyc+EmTTOyk4IcAERhloCzTfLSXb19GdcVZD4pjKoir+FZWH0CV9uzsVdG
 hnhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgZNwBSV21XqtK53/vS8SYl+7hxxFf1wvnBD9ZxjfOsDNZEg48Ao3qO/cYYUFrwBPHOuvAdKgAdnU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lSy8rJTc3NiJ4oGjPIiL6FJlW1l1glOu3UZ6KGjCFIWxxiSX3B
 xZsp7OwqkezSrvb2nzyRviYhKZM2aKbul4q9F3iEuqEALhFJFXBCm7sgOUiKlyO6ZMMIeWFKa5w
 ecZFVmW4gqwC8EuSyfz+A3GTOIoZhQHSF49cJRLnEZEmOuDQBUsdqNpGpr3b9JuINfe1i8qiX7z
 7qioOAGNlguH6ejMEPJ/KMZMmxysrzgpLaCG7IMfHqBPa6aQ==
X-Gm-Gg: AYBFou2u8ZbuRukLgrOT7QYrQfdU9v5HDITCZTsctfKzq1s3Ac5thl8r0Tr+wbpqqMF
 S8utIA7eeO99zaj1ybJyK8C5u1GcwTVcPREvqMSt/fOnmIdxPhKo8A0ybYpUT3YBZbhJWoq7+Ay
 +f2RMfyh8i2ne7ONnkBCl/mDChAHY8HGvr7/IXX65HLaryqir5exitPx8q
X-Received: by 2002:a05:6820:2221:b0:6b1:5735:b88e with SMTP id
 006d021491bc7-6c24c6c8ce3mr771787eaf.6.1789178098712; 
 Fri, 11 Sep 2026 18:54:58 -0700 (PDT)
X-Received: by 2002:a05:6820:2221:b0:6b1:5735:b88e with SMTP id
 006d021491bc7-6c24c6c8ce3mr771774eaf.6.1789178098301; Fri, 11 Sep 2026
 18:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
In-Reply-To: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 18:54:47 -0700
X-Gm-Features: AcwNN1UgBK-qx_vC_r0dZSSzeObThSII9I-bgwOa6aSUrNw21aClLAt97iPASAo
Message-ID: <CACSVV02h=c8KQoUT+18uXBoL4nkTzefu6AiTX=y6-W0rUrSSYA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: check pm_runtime_resume_and_get() during
 resume
To: Roman Demidov <roman.demidov.nn@gmail.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=MZX5KJ/f c=1 sm=1 tr=0 ts=6aa4b0f3 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=HH5vDtPzAAAA:8
 a=E6Br8louk_51uBx8NIgA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: mgCaWgq8iF6lPrGKJ_1vLr-czy0IOqkZ
X-Proofpoint-GUID: mgCaWgq8iF6lPrGKJ_1vLr-czy0IOqkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDAyMyBTYWx0ZWRfXxsG0sVfU7xuI
 1UzaM7QDcKt9Utge2Z0vOCn2GjAaBzNgC74B7VIfSs5M/0hw7QSuVxYMz0QFHQkxkP94BTlCUm0
 tjjpWagX06aoGZv73KIdqzWNxEpMWt19j40lUQ04vdoaZS/o1nCofcrTGbHqwe+WMAilSA/P/ja
 i2s2kH3lSdZpfAokIHwWq9thxI25NC+rKs+S7pGAhIXmaBQsPW2/Ie2pK5wy05D/TabT7vWv2Q+
 Tluu9uffRj5ucpSDvs9zDRtdmnFi+rTLLynFtBbnuqK7c8TSS4BEMSKwsxCXqtkZ56R3dFjltIO
 6teX1OTCgUl5SdtqGDv2wWKz/LRcbbWmAUAbV7rtTonLrTkReNC15EB0EkRv5i/3T8vEaeUeht1
 LJbyoIxG1I519zNoMQTUA5qQgpX9D4kyVRrT4erh4kGuMzpySIgxMzaDrbjTRa6FTQrg9TjEF6W
 oVHEvozmf/83J6sd4Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDAyMyBTYWx0ZWRfX2wd4GujQOkxO
 WEL8sNKt/Kp7+NDtq5Aji6toCsw/FPc1JxHQTRv/OOos4Z+7/j4QgDPWiUGilJ2ELLmKwNSdEY3
 /t4R76FKDkqs7sdA81R42jCY0uyD94Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_01,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120023
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Sep 4, 2026 at 5:58=E2=80=AFAM Roman Demidov <roman.demidov.nn@gmai=
l.com> wrote:
>
> The return values of pm_runtime_resume_and_get() calls in a6xx_pm_resume(=
)
> are not checked, which can lead to hardware access on suspended devices
> and PM reference underflows.
>
> Fix this by checking the return value of each pm_runtime_resume_and_get()
> call and properly unwinding the previously acquired resources on failure.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 +++++++++++++++------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index f9de9329dee3..0cf205ea744b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2175,44 +2175,48 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
>         opp =3D dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
>         if (IS_ERR(opp)) {
>                 ret =3D PTR_ERR(opp);
> -               goto err_set_opp;
> +               goto err_unlock;
>         }
>         dev_pm_opp_put(opp);
>
>         /* Set the core clock and bus bw, having VDD scaling in mind */
>         dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
>
> -       pm_runtime_resume_and_get(gmu->dev);
> -       pm_runtime_resume_and_get(gmu->gxpd);
> +       ret =3D pm_runtime_resume_and_get(gmu->dev);
> +       if (ret < 0)
> +               goto err_opp_clear;
> +       ret =3D pm_runtime_resume_and_get(gmu->gxpd);
> +       if (ret < 0)
> +               goto err_put_dev;
>
>         ret =3D clk_bulk_prepare_enable(gpu->nr_clocks, gpu->grp_clks);
>         if (ret)
> -               goto err_bulk_clk;
> +               goto err_put_gxpd;
>
>         ret =3D clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
>         if (ret) {
>                 clk_bulk_disable_unprepare(gpu->nr_clocks, gpu->grp_clks)=
;
> -               goto err_bulk_clk;
> +               goto err_put_gxpd;
>         }
>
>         if (adreno_is_a619_holi(adreno_gpu))
>                 a6xx_sptprac_enable(gmu);
>
> -       /* If anything goes south, tear the GPU down piece by piece.. */
> -       if (ret) {
> -err_bulk_clk:
> -               pm_runtime_put(gmu->gxpd);
> -               pm_runtime_put(gmu->dev);
> -               dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> -       }
> -err_set_opp:
>         mutex_unlock(&a6xx_gpu->gmu.lock);
> +       msm_devfreq_resume(gpu);
> +       a6xx_llc_activate(a6xx_gpu);
>
> -       if (!ret) {
> -               msm_devfreq_resume(gpu);
> -               a6xx_llc_activate(a6xx_gpu);
> -       }
> +       return 0;
>
> +       /* If anything goes south, tear the GPU down piece by piece.. */
> +err_put_gxpd:
> +       pm_runtime_put(gmu->gxpd);
> +err_put_dev:
> +       pm_runtime_put(gmu->dev);
> +err_opp_clear:
> +       dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> +err_unlock:
> +       mutex_unlock(&a6xx_gpu->gmu.lock);

this does at least look a bit less terrifying than what came before...
but maybe

   guard(mutex)(&a6xx_gpu->gmu.lock);

to simplify the locking part of this.  And I think at least some of
the runpm stuff could also be handled w/ guard/cleanup stuff?

BR,
-R

>         return ret;
>  }
>
> --
> 2.53.0
>
