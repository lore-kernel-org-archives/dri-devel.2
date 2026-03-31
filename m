Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385A110F92E9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C79A10EA9B;
	Tue, 31 Mar 2026 18:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FeHF9btr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2SDZoox";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F223010EA6E
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:29:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VHWxjS3103857
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=sqccXtNxMUDUewBaqU0CTK7kGLsJIPlUppOXDkrqdQs=; b=Fe
 HF9btrHUbi6HB8KI/sqrH9ChzRFBtCMnhEUFnnGLQtDFqvxxvKMtqWlHETpqKj16
 YrNEtx5GTKNLic23vrLIz+WnSIPdlzX8SVHPTWKfDrQ0GCftaGj1yoocb8CcbpRA
 U5floaOPZqSxnU/4FksljjWTT6jGnnZGRUMPJ84YkMGQHjnoQEHLHMjwHmQQTdyr
 BdKQ57FRVHNgQu1NMgNGBvnecbiKcaTkqNy4bkJJhnIjp1sUASCYnTl4CXFQDAhN
 FpxFhR9/4OstPLVEPnkRaw3CdwJnh8A94ZSb31UnxoJCiVpWt7yhxHJPrpD43xf0
 AUN827+qxMrRgxNvhaCA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js20a2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:29:04 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-46713069242so6669574b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 11:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774981743; cv=none;
 d=google.com; s=arc-20240605;
 b=SGcC1cNPPvLCRRuikNciy+QggNizz8JnQiMiaeNjA/ZhKtyvLOas0GPI2+OQvZvZyp
 sMWs12RieHZkFETJhrOhjs8GD/jzuzRKToBZ4ijMzIB+Stx/veJ4CuZbUodJuTp5ANKd
 CX2ylsuT33lHLeoImi9h4L4xRBIK2rXzjEXCyeEc6+bdcqTr68XXOQhKJ6zz996PLd+Z
 KyWF4Iru2a/JsCNY5uJDWSWsc23NYtvnNkbmZFEbAkn0Ew121GSpjpbc1gguB7Ek8kdr
 ah8SOi+fqcUrtjFxezGDVikVpgu/zns3J6pYwqz/ffgPqvRpzgUhs6ddBsJEwp2BsVEq
 hDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=sqccXtNxMUDUewBaqU0CTK7kGLsJIPlUppOXDkrqdQs=;
 fh=mdvUx6Gi+bJ/wLR3Bf5WKoEJ5rHQJ2sPlzAytWg6tFA=;
 b=DOCQpvrUx07vyTvMLYM9tpUzbq5K4iuFmF+lqK7DjF5k7Y70PY8O6DcxpNoij9dWJ9
 edt89IGeA6gIoc7nGzzALfyYVvCaAPykOZbAU2hEgTNV/lABSGcyb4euSiQpdk+kafq6
 O0QZjrNT3HAifFL1RzRzSOZk+M4vUqSUj7YWPAnns1yX8EvaY4Yz3AQJL+RgmenVmv+/
 tYY2kXZkwSPz5bk0Vby2IIm44X7aAi6y+/xY+03onwkfq/Ni9V27yQBnjYr8Ki829kK8
 SwUemQxlkFctgi9pqEMk89MDmCX3cx1wBSOGYFTRs8Y/S9xCoxEsFgZzLoQsirTrkAXQ
 E2Jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774981743; x=1775586543;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sqccXtNxMUDUewBaqU0CTK7kGLsJIPlUppOXDkrqdQs=;
 b=X2SDZooxaB71jKpytWemXeRbTzOY7kWf25uG1/aTp/HEeVnZDUA22EJyFax6MVRod3
 +PR9stdfWohGiC1WamIzowQKmgLX9SDg1cJb4OGTf7WYIsY+9B799FMiUXzzWfZ0gEe8
 b9bDXXqnWqiFn5yHocnVsq7kvqidXiluh89oJTRTXWctuHJ5XJj94NpCHSRwqix7kjup
 zjMreVNquCGthC8ySTtMJwFrOEwwDErlhlfYecyTNY0vGrcNT47QwsyvydMqeseW0Zub
 wyXgaH2SmQwpjt9YxkU8o45qYLxHIguFxXwdYdLA60JvlaNMd0oOADiCfIRxdQ9BLQgm
 LKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774981743; x=1775586543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sqccXtNxMUDUewBaqU0CTK7kGLsJIPlUppOXDkrqdQs=;
 b=Ef9kJNTU9YTMXcEsETpTShlFnbl5svdt4Nu0qx0pGRTFsXYYYnrBEh9FxE6DHTYzZG
 egF61X9K6q0fW20qQuy2CZd0clKx1mJOJUL+U/q9YNBO581YLp4oWofW5XSe7qe7YEvn
 BbtjHn1NGYnh5BH6Qw1Sh4O9LS+mlg30bbgi682eY1Q5sTFMsE2Mg3ShHxjFfZtB2u5q
 9c3c8/SekPeGQcBdsWkbDSCH9wS5CxG/Rzhqo8rpXqylMOWvFyoxbOVVM9eTdNo77Lj/
 uNZcAWtXC6dCWmDUB9JO0vM3PR0cHvgePudTtU39HYwPtmdAakwoqHj/Q2m/EZvxZhi7
 owIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjT+FOAqv+CZq1f96cpj8a7zTgTFesk1HJRrQ+0wz6zjmI8S6Avk9GfXxh0DSTI5QUA06Giui+YDk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTJ6F4G+ntgLoNedC81DmLcSDciG7xJUIL/hWHQAJ31VHubb3B
 Nd9CVVRWqXSihz4Z3ZdToXTaU/YYxXjtGemhTRh8GxGUtxEXBa20ae7uEhwdugSbmPW1Vcz5bKi
 5V8w+RS8BZSd/g2Euo0zYAYq9C1XhP0pNiibksMou1Kn9rL0d6oP3aZlk6HvRVx4RtUP3+Tsg8V
 zkvyM4v6YQBuhJYhZHc+lgMR80LWU/0izLhjq+wnHM/1ClXA==
X-Gm-Gg: ATEYQzynfTFwTbbYuSkEmIXRtAiqZY68p+AFetIgZhf3HAdsD8wjH+PRBfUwmvNUyMQ
 w4kDB8Jav2e8Ej30NoImhLcssJZm+Nunk+Fvg28EUQY93tPNnkgmINj7Od/4xDdQRcoGbTRqvaJ
 RS3fOkaMDF0jaKCDWBpCr6695f4o0s/IGnYa7XAdjNYbBVHODjKy3sGlq++aov1huAwgXKsp9zL
 9gBT1N4iGg9WG2jQHg8rIzy+b6CJK+Luhv87A==
X-Received: by 2002:a05:6808:1b0e:b0:467:4939:9656 with SMTP id
 5614622812f47-46ae022479bmr312783b6e.37.1774981743583; 
 Tue, 31 Mar 2026 11:29:03 -0700 (PDT)
X-Received: by 2002:a05:6808:1b0e:b0:467:4939:9656 with SMTP id
 5614622812f47-46ae022479bmr312759b6e.37.1774981743161; Tue, 31 Mar 2026
 11:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
 <CACSVV01RxTce4qEkt=vPb8AmPSuTLVTh5DR5gCAP2n3U3vkDqw@mail.gmail.com>
 <720bf565-342c-45b1-b797-3e27a7e9bb56@oss.qualcomm.com>
In-Reply-To: <720bf565-342c-45b1-b797-3e27a7e9bb56@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 11:28:52 -0700
X-Gm-Features: AQROBzDtrqI3f2JoaAPt5nnKoxW2Eymn4fBESv7H27PzGlJQ90cjFmRLoj1lafA
Message-ID: <CACSVV00qWGtHFOeEwTVw5=2XV1yvvi2TfTBFDjG8tQRg4eHzhQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] drm/msm/adreno: Coredump on GPU/GMU init failures
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JI_4yrYU4p9xSS0K4BHs5Fcs5ql-bkIE
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cc1270 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=Ex9mMNGI-Umtw2ziQKAA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE3NyBTYWx0ZWRfX9evIK43gBLPl
 90CkefF/zwKDzQqUpJWBB9SXvSH7VRRwjRAmMLXmNxqD40w5PnANTmqJdpqU0vUFMbXhmkvT0+c
 mpc5J+xtPL2S1zK0adZYG17TSz0OL2/cQazXWvW6mhvvOl9Z9bRqNhEsAlRwqNML0gF9+d03kcu
 VA8GGHOPmmN75C/yEloHmXrKZalHfKb50Rb7W44LDPYFun6I2jCc3Mv0T1XqQeDzIvTKXaUMrLq
 nkSWYT3UcpZKysGUnH5kNw8g7qmHc3fmJTq8zksfq5bG/9bM9jlYF+l5WqlaSz3jUSQvFK+xb4M
 gRCgvraPzKSgGEiHdbV7IUDucvdRx6/dKvF+1vYkFPJHDAX5EkTy/sLC0PY5yibB1oN+2VN4ceN
 Bjt8WDEJtbxCu+SexbVicSz1GyxUxPY34STX+0tk/Mlci4GTSaYdBQT8+f/RSi6OfT1gEv1aB5F
 dTh4wPSDgg5JcyH6YFQ==
X-Proofpoint-GUID: JI_4yrYU4p9xSS0K4BHs5Fcs5ql-bkIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310177
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

On Tue, Mar 31, 2026 at 11:05=E2=80=AFAM Akhil P Oommen
<akhilpo@oss.qualcomm.com> wrote:
>
> On 3/31/2026 1:21 AM, Rob Clark wrote:
> > On Thu, Mar 26, 2026 at 5:15=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qua=
lcomm.com> wrote:
> >>
> >> Capture coredump on GPU or GMU errors during initialization to help in
> >> debugging the issues. To be consistent with the locks while calling
> >> msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
> >> msm_gpu->lock.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 1 +
> >>  drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++--
> >>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 5 ++++-
> >>  drivers/gpu/drm/msm/msm_gpu.c              | 5 +++--
> >>  drivers/gpu/drm/msm/msm_gpu.h              | 2 ++
> >>  5 files changed, 13 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/m=
sm/adreno/a6xx_gmu.c
> >> index 1b44b9e21ad8..916c5d99c4d1 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> >> @@ -1335,6 +1335,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >>
> >>  disable_irq:
> >>         disable_irq(gmu->gmu_irq);
> >> +       msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
> >>         a6xx_rpmh_stop(gmu);
> >>  disable_clk:
> >>         clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/=
drm/msm/adreno/adreno_device.c
> >> index 4edfe80c5be7..ca5f96e16870 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> @@ -105,6 +105,8 @@ struct msm_gpu *adreno_load_gpu(struct drm_device =
*dev)
> >>          */
> >>         pm_runtime_enable(&pdev->dev);
> >>
> >> +       guard(mutex)(&gpu->lock);
> >
> > so, I am a fan of guard(), but I realized this means we are holding
> > gpu->lock across the debugfs_init() (only a5xx).. which I suspect will
> > anger lockdep, although I don't have a good way to test that atm.
>
> Shall we drop this patch for now? I will send a respin later.

I think I might, esp since the db820/a5xx ci runners seem to be down atm

BR,
-R

> -Akhil.
>
> >
> > BR,
> > -R
> >
> >> +
> >>         ret =3D pm_runtime_get_sync(&pdev->dev);
> >>         if (ret < 0) {
> >>                 pm_runtime_put_noidle(&pdev->dev);
> >> @@ -112,10 +114,9 @@ struct msm_gpu *adreno_load_gpu(struct drm_device=
 *dev)
> >>                 goto err_disable_rpm;
> >>         }
> >>
> >> -       mutex_lock(&gpu->lock);
> >>         ret =3D msm_gpu_hw_init(gpu);
> >> -       mutex_unlock(&gpu->lock);
> >>         if (ret) {
> >> +               msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL=
);
> >>                 DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", re=
t);
> >>                 goto err_put_rpm;
> >>         }
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm=
/msm/adreno/adreno_gpu.c
> >> index 785e99fb5bd5..8475802fdde2 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> >> @@ -391,10 +391,13 @@ int adreno_get_param(struct msm_gpu *gpu, struct=
 msm_context *ctx,
> >>                 return 0;
> >>         case MSM_PARAM_TIMESTAMP:
> >>                 if (adreno_gpu->funcs->get_timestamp) {
> >> +                       mutex_lock(&gpu->lock);
> >>                         pm_runtime_get_sync(&gpu->pdev->dev);
> >> +
> >>                         *value =3D adreno_gpu->funcs->get_timestamp(gp=
u);
> >> -                       pm_runtime_put_autosuspend(&gpu->pdev->dev);
> >>
> >> +                       pm_runtime_put_autosuspend(&gpu->pdev->dev);
> >> +                       mutex_unlock(&gpu->lock);
> >>                         return 0;
> >>                 }
> >>                 return -EINVAL;
> >> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_g=
pu.c
> >> index 995549d0bbbc..472db2c916f9 100644
> >> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >> @@ -361,7 +361,7 @@ static void crashstate_get_vm_logs(struct msm_gpu_=
state *state, struct msm_gem_v
> >>         mutex_unlock(&vm->mmu_lock);
> >>  }
> >>
> >> -static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
> >> +void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
> >>                 struct msm_gem_submit *submit, struct msm_gpu_fault_in=
fo *fault_info,
> >>                 char *comm, char *cmd)
> >>  {
> >> @@ -886,7 +886,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct ms=
m_gem_submit *submit)
> >>
> >>         pm_runtime_get_sync(&gpu->pdev->dev);
> >>
> >> -       msm_gpu_hw_init(gpu);
> >> +       if (msm_gpu_hw_init(gpu))
> >> +               msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL=
);
> >>
> >>         submit->seqno =3D submit->hw_fence->seqno;
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_g=
pu.h
> >> index 666cf499b7ec..eb5b3a7b81f9 100644
> >> --- a/drivers/gpu/drm/msm/msm_gpu.h
> >> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> >> @@ -747,6 +747,8 @@ static inline void msm_gpu_crashstate_put(struct m=
sm_gpu *gpu)
> >>  }
> >>
> >>  void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm=
_gpu_fault_info *fault_info);
> >> +void msm_gpu_crashstate_capture(struct msm_gpu *gpu, struct msm_gem_s=
ubmit *submit,
> >> +               struct msm_gpu_fault_info *fault_info, char *comm, cha=
r *cmd);
> >>
> >>  /*
> >>   * Simple macro to semi-cleanly add the MAP_PRIV flag for targets tha=
t can
> >>
> >> --
> >> 2.51.0
> >>
>
