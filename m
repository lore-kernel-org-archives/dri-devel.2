Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69505606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G4iInmTl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N7OVpDeT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C3210EEA5;
	Mon,  2 Nov 2026 14:06:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDF110EEC2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:05:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpNhJ4062014
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 14:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=QdycHGg0fUIiKpM46/IUqKDZojkpKRQQ9ApR9IX6+0I=; b=G4
 iInmTl27oP0kQNjx9r3lTd36qOUwWh73ZLrrqYbvjtyt1xTO5ANqWItkUMg7Khm0
 +jRyGqqGngtZJBSVNIEfxp3ZjTboIBfryV56FjOQRhABM5OyomY22Ofpz/51JZGQ
 /2JxB2HWrqYrQT5RSdIAcr7N2AIzKpQs8rguNWV+aU7TLSGUGxa/10hgh0khWsI9
 xLFNAN+7ggvB3tSGQ5W85XYDtfsNC5klA9YWXxj3Outc1p6m3P/pw2RSJ0WcT/fY
 LJbwIE8XWn0rycZgRJWo+AakWciCMsqUQALH9cgzta582AxQgGsk7HB9YfXSkYcw
 YUdhGmlLM+9OtktS0O/Q==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmeskyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:05:48 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-70b97cf79cdso3237018eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 06:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793628347; cv=none;
 d=google.com; s=arc-20260327;
 b=VYVZBsw+tI+eIMVRKZLmPTOosH+sNZ83FW4gyg/TsYRLj2nT5hNkWOaKeTqKtdEn4V
 WYWwsjdIsbJ5zyo7ha7oBhV0k14Nikb1r+zKW//cTQmSwygro829nX25KKEK7a6aGxi2
 UWbCPgvzW/t0VYkH76TRzYlQxF9nzlxkxFaMZIPYaWSGwdolP6mcM/sM0XPjSmMgngyf
 P12EcElOfURRu+mQg5TbwcHjQXYgSYeAyq5Oh4Kws8sUdKNPa9Kf9qWqEb8wLtGNWE5z
 JZm91AkjgEwvZA+o7InrpTYTEhWldJrNpJ6JuwLkWiKX9kAhc0SF4dR9d9HK4Jfdg7Bm
 xR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=QdycHGg0fUIiKpM46/IUqKDZojkpKRQQ9ApR9IX6+0I=;
 fh=79cZDhjqqEnIorzsr40o/+t3QEK7Gj3kYbAlMYotbUU=;
 b=sF4ElIt3jlJ+3kX7qQZNvqXpsAGPw+Mn+pG2Gx6v20VVemi7xQA79zwYYbr1aS0pjd
 twFkJznlp3kMCm4a2EG/gZJzJqRKrKTg1p9e/nUt3069Oi20vuJwHmd4ytIadIcQb/os
 5rXKx/tv1grOdqSe6+4CAGxJM44g8nGs2zubbT6Mxi0K7J7w4MDI4Ww80gV5IfulGh62
 kWFzU4jE5Nz4qAV2muL10hz6n4Q4Re2YCzV+Q6CE07Y1sN3n4THXBIJJvoIuP77kW6Dd
 1a3oPrU3eLN+yaRaAJ21ECjhZD8mHrfiZj0rGVov63j/eEnZ5XUNydEkhBiliY/lBLIB
 XEPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793628347; x=1794233147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QdycHGg0fUIiKpM46/IUqKDZojkpKRQQ9ApR9IX6+0I=;
 b=N7OVpDeTNXh6ltd6N4jJw0ROpUESqlocFHxmu4pxfj1nucZM/LOTVKtArfOYXYWCCT
 xSMiFiSSpmTJY51qk/RxyjKnKMgPdOBOIb+Vzh9vhGVEg8OSqmyC8GnI8GPnzMJ1574O
 o/Quc89WCDptgILMY5xNKyqWz0yyWocZj3m5Gfik0Vk75A2pWsYB2CQKYYAKO8TQUoCB
 /17QH9mVDn0fP/roVW+7AufpbzDveZJc4fMORilOFqipOyfbcVmvQyESqFWaTxBUKjF4
 hLS/G+2G3sBHPUUqD/WCscVM3lfPPb8EuQri7BTeq3WdnEdbjWCRhSrFNOUxIEmu9AXZ
 otPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793628347; x=1794233147;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QdycHGg0fUIiKpM46/IUqKDZojkpKRQQ9ApR9IX6+0I=;
 b=vP56r6iNqbBFMpm8svHaN7xxruMZ4l35MicTFhAk6oTTFNbqWucJyVd3fWWxEJjJxr
 AiTq79lPieVc7DJIUycmmlEPVD0htLyElIPoJtYAU/QU1s3753td49kLNQjQKUDbE4Va
 SQbEcTNESjKVwtPsrC65ILws1rbmDpyypBTqNU1aOzmqwQmpIVeiEV80cqDw4u8Qj3kC
 wfpPVk42QFbNCvV8hqprlLhx+ryVS8Ja6K0z9kLFz/cBL5k1giqXFV64hOH6XeGkdDCJ
 9TyXQnZGmcgKBXzBy9LRnEbPWnNo7KEla04iET+dFFu2xnfylbyL5hu9A0uINxP5XMWS
 WUWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1xJ7EeLhCfsJkFneLh3yoAG3RWHAZHcvR9M5FcS9gnIee8YTXyUoI+OnLUG75XGI5KfNfpilBVU8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJM9x0ZtNlx8hxs0lIJkvdlT8SghvPwNODQrTuqcgH6v3v8vvY2
 TmWF47zNKTkeyl9+8SibxHKzRc6TrM1EDBfwQDxPACZwEW5kVnoSTTaxqNiW7WRIoDXhGijKNXx
 mZ1Rw7G3Bjd2tGwiXCxbvaIJbFeikv5/kS+liSzzYpjsI6gnRi98aOan6w/C1Lal4YKwqbrtCgj
 q8+0hlQkJ1KBrIdGKRT3WSQ5IceWD1PrGTxNBOCig1unPO2qi1gdVwVMpj
X-Gm-Gg: AYBFou1hmFMyjeS5wEEAQ5iO1M3mqkJzQ5ckcB94I6CNwhXUpYJSXka16BLXw1DWEIS
 2Fx9w225Purd5HC37ZCjRunObGOIyPM85h4soZlKLNBHIpOM9oNT1hmfH9TYiANN1CAnyra7E1K
 DnPfigfwIb4mHLbLoLRIM2Pp6uG7wEOYWlHZHm/Zg9E0AafqaVz/BYIiGXrg==
X-Received: by 2002:a05:6820:708c:10b0:6da:453d:7cdf with SMTP id
 006d021491bc7-714f2a30724mr3699764eaf.57.1793628347168; 
 Mon, 02 Nov 2026 06:05:47 -0800 (PST)
X-Received: by 2002:a05:6820:708c:10b0:6da:453d:7cdf with SMTP id
 006d021491bc7-714f2a30724mr3699745eaf.57.1793628346684; Mon, 02 Nov 2026
 06:05:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
 <20261101180508.66598-1-nicoangelodelacruz@gmail.com>
In-Reply-To: <20261101180508.66598-1-nicoangelodelacruz@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 06:05:35 -0800
X-Gm-Features: AclHuK_tAlZOM671p6g-xOcfl-LxahyVIOmGtH-YZjrNdgYN2eW-woSkdRiVpCs
Message-ID: <CACSVV00Gv8V=V-gdwMqsvaE63Wxmw29aTS0wpX1jjegzJU6mhQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/msm/a8xx: add a memory-only GPU crash state
To: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae898bc cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8
 a=dnCqE_r5BN6qDrZ5i3wA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX6iKDf+qXnUWK
 FhL7lN637XWN00iD83HRGdozzy9Rrrk3IM27dFSynvd/B7PWLEYJ1JMagUxCEqxK0nCNPXxOAjF
 cg1HVuIcNomo7S43JndebUfLHhvjtEU9CizKLNjAPwUh69Z67JSMQUf1GHMBUiylW6VOE+lZ5Tj
 pN8+dAA/pXZLT4lMfOVvmanYWoFI+JaYKCOEbgKmTbvz63OKJF7OdSZ7oDpvmfg85Rah6HaSnSV
 qCAgAOtf1nDIq/9AomKc8lC2VECogKTBqpTO1ZDedYvT23Jt7bHrl/Q5vQxoMnDL8OuCBYznhdz
 6ueqRxqM6cnibrVMrLbygbUbXid5DBNlwp2rw8abRQgamW/yWiXRoUPDsPtuStYbJbeAHiznV+b
 jr5Vnz3i4ZdFM9fj1aKkUafNcOOJW/f1hIyT/X1HHTLCzoqCp0AB5B/ph+aNMRUvtJjbcNT1Tvm
 s0441SBc8pEzgWQ4YxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfXwEgeAzHLZf+e
 Lx8ZFNCicgiSGt6TpK2ZO8qVYwS+OrPINcAM/i5MQSlEunx9X8iwg4VRJbPYASYxHSzZzPnjo2o
 bXfTw3ZpAZfnjXcy+a7Rh8LvJb8CVRI=
X-Proofpoint-ORIG-GUID: O_emu7OZJcyddBW9EDAcmhEDDJ0geTMx
X-Proofpoint-GUID: O_emu7OZJcyddBW9EDAcmhEDDJ0geTMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020056
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 10:05=E2=80=AFAM Nico Angelo Dela Cruz
<nicoangelodelacruz@gmail.com> wrote:
>
> a8xx had no gpu_state_get callback, so no devcoredump was ever
> produced when the GPU hung or faulted.
>
> Add a8xx_gpu_state_get(), a memory-only snapshot: the generic Adreno
> state from adreno_gpu_state_get() (ring buffer contents and fences,
> with rptr read from the hw_apriv shadow rather than a register), the
> GMU log/HFI/debug buffers and the HFI queue history. No register is
> read, because the GMU may be wedged and GX powered off when this runs
> from the recover worker or the SMMU fault path. As a result a8xx
> dumps always report "gpu-initialized: 0", as a6xx/a7xx dumps do when
> GX is off.
>
> The shared part moves out of a6xx_gpu_state_get() into
> a6xx_gpu_state_get_gmu(), which also runs adreno_gpu_state_get().
> It is a pure move except for a new gmu_regs parameter that gates
> a6xx_get_gmu_registers(); a6xx/a7xx pass true, so their output is
> unchanged. Reviewed with git diff --color-moved=3Ddimmed-zebra: apart
> from the moved lines, the new code is the helper's signature, the
> "if (gmu_regs)" check, the locals the helper needs, and the call.
>
> Tested on an Adreno 830: IGT msm_recovery gpu-fault (6 of 6 runs) and
> natural GPU hangs produce dumps with the ringbuffer, gmu-log, gmu-hfi
> and queue-history sections; capture takes 1.1 to 4.0 ms.
>
> a6xx/a7xx: build and pure-move review only, Tested-by welcome.

If you are interested in a8xx gpu devcoredump support, may I suggest:

   https://patchwork.freedesktop.org/series/176505/

I'm still looking for someone who has a830 who can test it

BR,
-R

> Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  7 +++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 47 ++++++++++++++++-----
>  3 files changed, 45 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb..0f4b0af0a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2918,9 +2918,16 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs =3D {
>                 .active_ring =3D a6xx_active_ring,
>                 .irq =3D a8xx_irq,
>                 .destroy =3D a6xx_destroy,
> +#if defined(CONFIG_DRM_MSM_GPU_STATE)
> +               .show =3D a6xx_show,
> +#endif
>                 .gpu_busy =3D a8xx_gpu_busy,
>                 .gpu_get_freq =3D a6xx_gmu_get_freq,
>                 .gpu_set_freq =3D a6xx_gpu_set_freq,
> +#if defined(CONFIG_DRM_MSM_GPU_STATE)
> +               .gpu_state_get =3D a8xx_gpu_state_get,
> +               .gpu_state_put =3D a6xx_gpu_state_put,
> +#endif
>                 .create_vm =3D a6xx_create_vm,
>                 .create_private_vm =3D a6xx_create_private_vm,
>                 .get_rptr =3D a6xx_get_rptr,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 79912a33e..03432abf9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -338,6 +338,7 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_st=
ate *state,
>                 struct drm_printer *p);
>
>  struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu);
> +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu);
>  int a6xx_gpu_state_put(struct msm_gpu_state *state);
>
>  void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, =
bool gx_off);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/dr=
m/msm/adreno/a6xx_gpu_state.c
> index 26c17861c..a3751358a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -1629,25 +1629,19 @@ static void a7xx_get_indexed_registers(struct msm=
_gpu *gpu,
>         return;
>  }
>
> -struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
> +static void a6xx_gpu_state_get_gmu(struct msm_gpu *gpu,
> +                                  struct a6xx_gpu_state *a6xx_state, boo=
l gmu_regs)
>  {
> -       struct a6xx_crashdumper _dumper =3D { 0 }, *dumper =3D NULL;
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>         struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> -       struct a6xx_gpu_state *a6xx_state =3D kzalloc_obj(*a6xx_state);
> -       bool stalled;
> -
> -       if (!a6xx_state)
> -               return ERR_PTR(-ENOMEM);
> -
> -       INIT_LIST_HEAD(&a6xx_state->objs);
>
>         /* Get the generic state from the adreno core */
>         adreno_gpu_state_get(gpu, &a6xx_state->base);
>
>         if (!adreno_has_gmu_wrapper(adreno_gpu) &&
>             !adreno_has_rgmu(adreno_gpu)) {
> -               a6xx_get_gmu_registers(gpu, a6xx_state);
> +               if (gmu_regs)
> +                       a6xx_get_gmu_registers(gpu, a6xx_state);
>
>                 a6xx_state->gmu_log =3D a6xx_snapshot_gmu_bo(a6xx_state, =
&a6xx_gpu->gmu.log);
>                 a6xx_state->gmu_hfi =3D a6xx_snapshot_gmu_bo(a6xx_state, =
&a6xx_gpu->gmu.hfi);
> @@ -1655,6 +1649,21 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct ms=
m_gpu *gpu)
>
>                 a6xx_snapshot_gmu_hfi_history(gpu, a6xx_state);
>         }
> +}
> +
> +struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
> +{
> +       struct a6xx_crashdumper _dumper =3D { 0 }, *dumper =3D NULL;
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu_state *a6xx_state =3D kzalloc_obj(*a6xx_state);
> +       bool stalled;
> +
> +       if (!a6xx_state)
> +               return ERR_PTR(-ENOMEM);
> +
> +       INIT_LIST_HEAD(&a6xx_state->objs);
> +
> +       a6xx_gpu_state_get_gmu(gpu, a6xx_state, true);
>
>         /* If GX isn't on the rest of the data isn't going to be accessib=
le */
>         if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
> @@ -1714,6 +1723,24 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct ms=
m_gpu *gpu)
>         return  &a6xx_state->base;
>  }
>
> +/*
> + * Memory-only snapshot for a8xx: no register is read, as the GMU may be
> + * wedged and GX powered off by the time this runs.
> + */
> +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
> +{
> +       struct a6xx_gpu_state *a6xx_state =3D kzalloc_obj(*a6xx_state);
> +
> +       if (!a6xx_state)
> +               return ERR_PTR(-ENOMEM);
> +
> +       INIT_LIST_HEAD(&a6xx_state->objs);
> +
> +       a6xx_gpu_state_get_gmu(gpu, a6xx_state, false);
> +
> +       return &a6xx_state->base;
> +}
> +
>  static void a6xx_gpu_state_destroy(struct kref *kref)
>  {
>         struct a6xx_state_memobj *obj, *tmp;
> --
> 2.53.0
>
