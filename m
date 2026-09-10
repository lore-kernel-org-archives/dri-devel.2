Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1DBC79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E6510E249;
	Thu, 10 Sep 2026 07:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7I/PT09";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FzHPkeHi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2BE10E249
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:27:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A5GscQ3520309
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 taZQwJTu7Xj2QDuBpgX98mgl88qdgGujFrGGLJjeO/Y=; b=R7I/PT09opctkmDP
 AtysNWExZ3Hw0+R+zBCwUyJ8Sn0N+LZ1p+JCqyJXtuKSJY1XwAeJwx/QwWWvv3oG
 e4f5kj3ra2K5GX3nwyrdemh7pdQRA2dkCO6dxjaknGFVceuypSuwYvIIr3UEZgKF
 witAiNhxaN5ePeNxct7pd6lpeiHLRHHCCWLfLQcNh9gSsxDcEWKj/vgrNgBFgcNh
 xSNDT6X9eBd34ghP8DpkY7qJkwn14h9MSFgXjt256gXtweedZkiTRFgGrDFQS/PE
 Y1GuxJiAfSRk/zdi9JqCqDxm5xmUw7znzIZij+yW7nQgtiYC5uVIS/ANxJvS1KEX
 E4U5Pw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfjq6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:27:16 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c70f4b830so7822048d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789025230; cv=none;
 d=google.com; s=arc-20260327;
 b=CR1OHwh6VYHLWHmbM7TdcLkf0G8Yz6kgQU3EiM+8c0MbJmDbYDr9hC99xB3/vsPjvo
 Si2pEkMH9go7O8JvhDEWVgT5Zgf3WGFOnAkJXUjsU0OuFOqai5UbqWn5o9FZgqHi6V+V
 pwVlHtwvEhW3ZSmGciPJUQGvYEYzWApSkN8J0MLbeHpPrWB+SOFgdzL3uNNsYoBg9AYV
 fAOnYB9ULgdxIpAX148Go8bYmob93w/BKnBpEIokoQxQlsydriqzTmN0nrP/xf8lkRea
 10iaLS3PnM/vKNQfTXY4YMlGcoVlLljsYQ7BZn8FWK5JBJx4wl9Wo/W4D8ncOjIVvagX
 R8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=taZQwJTu7Xj2QDuBpgX98mgl88qdgGujFrGGLJjeO/Y=;
 fh=Gf/FlIi+ZqttN3391krf7m1TE+IGeQE71TWwke84L8A=;
 b=RbOkH99bt2IHlGJQQRjFVlKhuTcmhFfvgWxK8jFr/FVk7bxgWDt+eaArfLq2EsrmHv
 wZimZkc4s4Uu4dTfPOWkoCMXly4gvNIShiWKQVnJQzqFNRRkSiY66WW0ZTpsztbsJQ+W
 QdXaH70F6Dds5A0I9pwPd7dPTpR+0JQnjm2w+Xv3pYvaRVBITDmQUp5F84MtxjdRiZmw
 DEutol9sdY5MiQFeVHEQ4/6lFItYqQns6GeQd+JWbuoerUDQPGH7ndWJ5/Ej80vxGeE5
 OHDtcOI0RjbcroLa19mvJdBCsWoTe72V8b5EJB0qVmAk4P/EB1tjSrWQW0Sf3f59b2eP
 uZ9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789025230; x=1789630030;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=taZQwJTu7Xj2QDuBpgX98mgl88qdgGujFrGGLJjeO/Y=;
 b=FzHPkeHih44/JoFz3+ITB02N3nwK1FewnXDbU0EcP5S8J//7RmoG2KmZlgR1t+q5hr
 pz58u5283k7j0/4NOG2mdoZnTbOWD4sZysFuyQRfmV46gcLxaLmlHm2gnGiHXqRbhRQw
 TaJebKEYpOVhDLP1k4jRxvO2f30FuP23W6jcZziBCTW6Fo4oJM2QqKdv1rAa2EGxlTcr
 MjESIA/kPGZYH7WFkaNnKdth3KPlCAY5VFJkMbSq7bQ7SYkaAUVbheX7wUJ+lEmktPJB
 A2xTCb0qgKXCobGCEfeVVWz6j+c3EcUIo52KF2QQVvEKXi8c9MZ9zSf/DyZrlb7v76/u
 tRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789025230; x=1789630030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=taZQwJTu7Xj2QDuBpgX98mgl88qdgGujFrGGLJjeO/Y=;
 b=eXRhFWnzEQx75l4mYeFhB7xbD5xhbG5xlA2AhensL5qKC6929sHuCWxSFntOXpCNWf
 lvw4J0F+ntYDLyluLg1Kv3W0ROL+KY72w4lmajLgSydMP0utPkoryyGV2/Y+n+lngMST
 owJ6yBGTugRG8q7tjk7IrUrNEabDVDEJgBUX4JWJVXUHu73mxh3/gsKcEb8gIus+uuXA
 vkUopQ2Aj5BwVftFpKXjZOftMTEQpnFEPfzrL0fqC8cDlAHJOEgtvMjwwZxGVaU30+6v
 nrNCi1eOxGrhn76DwZVPKPh0lp+nNBgphiuMPzatwvCDMJzBfqqeCkLVrrrka5kq7Ij2
 HQNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlNhE+nMhb47877CN/VHQSTPZkOtftaYFSfcAc6KuRevRdtPnAxS+vDc+BSi9iKbopUIImbjxGd/Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZA/eABf7RvIrf1KKCSvjuUFFUi1lOtcv3WVUpgU21eUdNpoV5
 91niAVfxxvhCNGhwtVs0nWs9+poY9rCztQh8TDLgMp/+mz0LULMYAZC2cBMztDD492ts5KpMgRd
 fr5BqGGhxgyljpxPWT95YyrGFdkkG1G+U1B0lqF8VtzH6j0xvmwucugGVdi3js2Byi9Ji0hfUyg
 MoX5dEiwCNeh4k+aLM3jrvdW7hh4KSUAsU5ou1Vr6EsovBew==
X-Gm-Gg: AYBFou3QE86GjzN9T8iwm1bMW0YAmvBtUwS2tokwhGF+oJgm73jz7yCgv6fZvTXyjFN
 UYL+3BE73JCgsOytexn/VI576uEWcPNMU3ogZYqxx31MAnTlpinRf3Ay4JcwMobWM0fz9r/T1aO
 taN0x4o4Y3qpPHGCjg3V+dWn0rhmr0odXueLtq/LvL9oJI80IaFPT2AD8KCQ==
X-Received: by 2002:a05:690e:4188:b0:666:396e:bf59 with SMTP id
 956f58d0204a3-6710feea457mr1891095d50.1.1789025229997; 
 Thu, 10 Sep 2026 00:27:09 -0700 (PDT)
X-Received: by 2002:a05:690e:4188:b0:666:396e:bf59 with SMTP id
 956f58d0204a3-6710feea457mr1891087d50.1.1789025229603; Thu, 10 Sep 2026
 00:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260821081325.89088-1-phollinsky@holtechnik.com>
In-Reply-To: <20260821081325.89088-1-phollinsky@holtechnik.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 12:56:57 +0530
X-Gm-Features: AcwNN1Vn6UxHVxU9O2c-HcaEnhmPjnjZ2yWHOjiTvHE8Ao96P_jBheKuiWTFEXE
Message-ID: <CAGptzHM1tuR+JPoT4CmA9fO77pheTq6d+14XnpxtNysrBW71jQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Only check for PAS when a zap shader is
 present
To: Paul Hollinsky <phollinsky@holtechnik.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Konrad Dybcio <konradybcio@gmail.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX5KVnh/0wYyv5
 0Qjq83+e6JhulOJaK6/p0l6iA/HteRBMNfysbIno5V5bqAe/qQF268TrZcyURF/Kk47S8Br/iyW
 DZ7dTVaKeN6KkvPHlHcsq4yzqvsR50k=
X-Proofpoint-ORIG-GUID: EIYx6J96hEeq72q4wgziZePu8-kvLP79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX4AU7cuJNkynk
 Dhyin8Qo9YUtXoxYDPe69I53OP16C4MRZRiWYpS1EZQc3/z4m/+zTu7U29Nt5wtfabOUXde4INd
 dv2zuJ2usseoY01MYMbSOj08LOUxa+ULf6fuwS5Aly2c6KOu56O1/rNXG+ALrCWchvrK/xZM/RT
 52Doox6m5tRvl770sx+AkRLO+tf0rtyDkwRGWXVPYeYPLwPaYfyANa/RY/Ge9n5cdPnWNHM1nHe
 W+MoQ9tbjXKLcEnv+YGEiX5xPHp20N9Hl+FIF5GJmNqIq701d4XOAosTEse9iHYpxi/Nk/+4jna
 aMGNt+sGilWsgwmFgWhVcFfbXiVXQ1d86J+nldj6igV6KyB2GhfIW9OwPqiUMZV5M4BQ2jmfbYP
 uzjxo6RnULQahdJec0+RdOTonluInFtrsEGISyFzgUyGmHdHrc7mj/wMGv4HCKov3xN3I1KodYr
 0+Qm6DajZlyvVW2HpLQ==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa25bd4 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=8dbcrQVTAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=L0M3gnoWJ22_1Ho6GyMA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=2958AbVqUNA9gn3SDOjC:22
X-Proofpoint-GUID: EIYx6J96hEeq72q4wgziZePu8-kvLP79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100080
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

On Fri, Aug 21, 2026 at 1:44=E2=80=AFPM Paul Hollinsky
<phollinsky@holtechnik.com> wrote:
>
> Commit 0be72be03ca7 ("drm/msm: Switch to generic PAS TZ APIs") replaced
> the qcom_scm_is_available() check in adreno_zap_shader_load() with
> qcom_pas_is_available(). These are not equivalent: the former reports
> whether the SCM transport is up, the latter whether the TrustZone
> firmware implements the peripheral authentication service.
>
> On SC7180 Chromebooks (trogdor) TZ does not implement PAS at all. SCM
> call-availability queries return 0 for every PAS command while other
> services answer normally:
>
>   svc 0x06 cmd 0x01 IS_CALL_AVAIL    -> 1
>   svc 0x02 cmd 0x01 PAS_INIT_IMAGE   -> 0
>   svc 0x02 cmd 0x05 PAS_AUTH_RESET   -> 0
>   svc 0x02 cmd 0x07 PAS_IS_SUPPORTED -> 0
>   svc 0x0c cmd 0x16 MP_ASSIGN        -> 1
>   svc 0x05 cmd 0x01 IO_READ          -> 1
>
> so qcom_scm_probe() never registers a PAS backend and
> qcom_pas_is_available() is false for the lifetime of the boot.
>
> That on its own need not matter, because sc7180-trogdor.dtsi does
> /delete-node/ &gpu_zap_shader;, and the intended path for such a board
> is for zap_shader_load_mdt() to find no zap-shader child, clear
> zap_available, return -ENODEV, and let the caller fall back to
> SECVID_TRUST_CNTL.
>
> The problem is the ordering. zap_available is a static initialised to
> true and is only ever cleared inside zap_shader_load_mdt(), but
> adreno_zap_shader_load() consults PAS before calling it. The discovery
> that decides whether a zap shader is needed at all can therefore never
> run, the flag is never cleared, and every call returns -EPROBE_DEFER:
>
>   adreno 5000000.gpu: [drm:adreno_zap_shader_load] *ERROR* PAS is not ava=
ilable
>   msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* gpu h=
w init failed: -517
>
> Nothing retries that deferral, either. adreno_zap_shader_load() is
> called from a6xx_hw_init() rather than from probe, so the -EPROBE_DEFER
> is not a probe return value: it propagates up until adreno_load_gpu()
> returns NULL. load_gpu() re-attempts on every DRM open while priv->gpu
> is NULL, each open fails identically, and PAS cannot become available in
> between - which is why the error repeats and userspace stays on
> llvmpipe.
>
> Move the availability check into zap_shader_load_mdt(), behind the
> zap-shader node lookup, so the driver only consults PAS once it knows it
> needs PAS. Boards with no zap-shader node take the intended -ENODEV
> fallback without ever asking, and boards that do have one keep the
> qcom_pas_is_available() gate.
>
> Fixes: 0be72be03ca7 ("drm/msm: Switch to generic PAS TZ APIs")
> Link: https://lore.kernel.org/r/20260808034716.58888-1-phollinsky@holtech=
nik.com
> Signed-off-by: Paul Hollinsky <phollinsky@holtechnik.com>
> ---
> Reported and analysed in:
> https://lore.kernel.org/linux-arm-msm/20260808034716.58888-1-phollinsky@h=
oltechnik.com/
> Konrad agreed with this shape in
> https://lore.kernel.org/linux-arm-msm/b63e93e4-2f4c-4cad-b726-e1b0565379d=
7@gmail.com/
>
> 0be72be03ca7 landed in mainline during the v7.3 merge window (via the
> soc-drivers-7.3 pull), so this is based on Linus' tree. Note that
> msm-fixes and msm-next both still predate it as I write this, so it
> needs a base that includes the merge window; happy to respin against
> whatever base you prefer, and it can equally go via the qcom tree the
> culprit came through.
>
> Tested on a Lenovo IdeaPad Duet 3 (sc7180-trogdor-wormdingler) on
> next-20260805, which carries the same code: with this applied the GPU
> initialises and logs "Zap shader not enabled - using SECVID_TRUST_CNTL
> instead", and userspace gets a6xx rather than llvmpipe.
>
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 489462065ea9..995161215ad5 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -52,6 +52,12 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, co=
nst char *fwname,
>                 return -ENODEV;
>         }
>
> +       /* We need PAS to be able to load the firmware */
> +       if (!qcom_pas_is_available()) {
> +               DRM_DEV_ERROR(dev, "PAS is not available\n");
> +               return -EPROBE_DEFER;
> +       }
> +
>         ret =3D of_reserved_mem_region_to_resource(np, 0, &r);
>         if (ret) {
>                 zap_available =3D false;
> @@ -170,18 +176,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu,=
 const char *fwname,
>  int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> -       struct platform_device *pdev =3D gpu->pdev;
>
>         /* Short cut if we determine the zap shader isn't available/neede=
d */
>         if (!zap_available)
>                 return -ENODEV;
>
> -       /* We need PAS to be able to load the firmware */
> -       if (!qcom_pas_is_available()) {
> -               DRM_DEV_ERROR(&pdev->dev, "PAS is not available\n");
> -               return -EPROBE_DEFER;
> -       }
> -
>         return zap_shader_load_mdt(gpu, adreno_gpu->info->zapfw, pasid);
>  }
>
>
> base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c
> --
> 2.55.0
>
