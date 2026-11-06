Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C56606A335
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oDzUxncx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xshqq/4s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548B210E0E9;
	Fri,  6 Nov 2026 14:37:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B31510E271
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:37:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6EQ9rF4164147
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 14:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=4HsyqapsxgGb3uQ6wsN6jzCK5d5H1eQhRuyR+l3gVi8=; b=oD
 zUxncxZqM9j4vcCOndXBF3iIc4/WR1NvKSLy+dBwaYOm4erSCtt7mQL+KFrwYI3z
 70bIWvfQbCccOyYxOcCoKpXLXqaVtbZ8+XgQBGNdyrGdw1450R4r7383q+QOGIR0
 kzNMuT7bcO7muQGmD59w4tTETIoglXoIE98yc4zvFoWh7vohmFc9NGopOXqNOAyA
 XHpkS/ORTc4ycLhJDjiatf4u19cSTI41hyx+6UzGHCreR0moT69Gfqp2yFA2JJuO
 kjGt/kQGHbViURKEabcJ8k8BA6JOzdNjtQ6ZkaD82H6uwGWijD/hVFqq5m6FSZMr
 0whNfEAoKReAM0Fjhgmg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa34s7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 14:37:17 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso1241773c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793975836; cv=none;
 d=google.com; s=arc-20260327;
 b=QX61hIXLaVeWA6DPwtJ66JDLg/7w1uvqFMyZVg+L/vum4Srzc8h8tirEKKWe73mjK+
 UIWjwkb3q5mP91ef02UVQly64fg1LMfF6otZFpbFAOygrPL3m3ctmnLUVP1oMgVI/ZV8
 5jNK1fa4MJwdbnfewLQvFNwLz3WzDRuQF/S7n4NkLjU/q4VEpWJKi7eZt5flVXWwb03P
 pbVMZtSXTyvBYgEvBGAZ6IT6ndKCX5dRn51He6D7DqXMWYr48pCwxXnYhCTYluT3EuTK
 r8uC89xpNin2yYRoooPVRImQeYQjsKVGF3l4OSXlDdDmmzgkFeHbeaoHfFtgWVK/5ywc
 MNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=4HsyqapsxgGb3uQ6wsN6jzCK5d5H1eQhRuyR+l3gVi8=;
 fh=5vW80q4ckH8WaC8qOQw2xoFvYxGLDq54xTaPAQmLc7g=;
 b=MXflc1aaCpeyve/zeJK0z9zrL6v1hIq7KXishTFHANL71Cn64WqyOGq+tLmDos67oA
 TMczyM+SiGjT0Cj5Wsf238e7DWMUHKhko2ar1ZaTIpR8uyFhJ4oBFZGI7cm69T5lESLG
 IGOrfCwTWbVxrsQSWG8A7t+IKKuHdzFNGqh1MvW/2ZUkZx7bfX6MiGZ7EVW0F2pcabBO
 0xWZRKlpXgkcUIwySEiwRnOY1UdivIp5F3swaDTBa+r0oiBbyJtv7FKX9fCjLKJtVIGJ
 tIYbS5ygunAvbfnKYAlS7R0YbHAjJLprHkVLSgqtRYq6FXTFdB673RgHfE69KSC2jbTY
 I7ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793975836; x=1794580636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4HsyqapsxgGb3uQ6wsN6jzCK5d5H1eQhRuyR+l3gVi8=;
 b=Xshqq/4s7SjdJpTh+/CH2nONzjdwU8EcUSkEma3O4OIoF7+2uQTUqNKMbhQ3uL5nJl
 LtCy6CNQXKEYtBeruIefgWhJvy14+EbMLHfZv6hIcXcVKzfExhI5cAf/QbfxxKdT9eCT
 9ec4Zwt71TMBaUa1q3il4BhUkb8RmcRphppG0JNn8rlJONbp2GW02BLmE9mV2gMAFZ/M
 B0xqzn9RPjYB9TLgm0SrxcaBjqSw9gkvLQdrzRp7xsAifw3Ktgos/Bon/uW1Nultf69o
 2IUr4jmt+TSzvenJjw9R8gzzVXk351F+WFEKI9al2pwpRXAAySjrtV0dqUORyL3ecND8
 zTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975836; x=1794580636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4HsyqapsxgGb3uQ6wsN6jzCK5d5H1eQhRuyR+l3gVi8=;
 b=oULANpR8Pcn1PckO7NLciN+XuWCWmHxYnV0CKxAG6NexuqbWh/HqgoOkTEqMl3/L4n
 VboDhUifgCWUw0VMDR7EGlRW+7ZM87y6dusZ/RzFDC29bdLEYou4SIzw9udCRmgvvb72
 MGk/g9UOdDrTXV7b5PwQKc5Ot5JvaM8yCcX2TYWLcAU8zE4pMdtlr+1yqpiaEMlLKQ0z
 3MkUCmmGLD/1IvyryN52XHM9NfRHnb54SDwJcsNBwwN84GgLMhf/NxxdmVChCNXkBXu8
 g35ZT0qoQ5GQ4bzlvteJBjBtswn2/+yKN4WhK3EFlpz6XcfAmzTuvJBNtOah1PbP+pLI
 FN0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6SEgFlg6rESXSw4qgYXcR5SaAhQBVtRLRJtFZrMswTvHW/kxsejV+mD6MUL4DPuCi/1b98X/7YkA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ea9hGUyasuW4+ALz48QJduXWSkOS+HOnrSzIN6e6NmHKKvpMs
 yQQ86l/wKS77F1PwFDAXAwu4IvC0JeSRjo/AAJquh4YziTroTJKHwx30Jan+WZSUhJkdcwd84PG
 6vvR8f2hNCjufnma8uDKtwTZm/smC3QSy86xjYhOnDxvgvCrSrseLuWsDBUgpkeuUr1kTkS9cW4
 1ur3UtIXCVnxC3rVJbHsDAE/E5iqGfcv1S+pU3aMBQ4E99KQ==
X-Gm-Gg: AYBFou008WqDsQO4KfitMTi2JiCYl91jgZHopdUfqvegRSQ40HTl3x6DoKU/6zPfx9v
 jqz8z/TDFWQn74vwTOmd6Plyt92V54gRvi6hEQipXNVmB0wL/QOUm/j8H1QEI3/n+ChtKkibD0W
 0JThQfi0IZQCDx5JO8TuPzFQSAmNtMwa2Fngg1MGmS7nsiBRY9XrAWSHq7U8SMySQ36fhn3++PS
 jV+jpZ/AJnfcGfvKoX51w==
X-Received: by 2002:a05:7022:1201:b0:144:fb42:52 with SMTP id
 a92af1059eb24-1b25d31e166mr2771657c88.28.1793975836121; 
 Fri, 06 Nov 2026 06:37:16 -0800 (PST)
X-Received: by 2002:a05:7022:1201:b0:144:fb42:52 with SMTP id
 a92af1059eb24-1b25d31e166mr2771610c88.28.1793975835251; Fri, 06 Nov 2026
 06:37:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
 <20261106-ubwc-format-docs-v2-2-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-2-82949f88f030@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 06:37:03 -0800
X-Gm-Features: AclHuK-nYIdYytSxiDZGvmJ75_P0qcwPygnczJxVB0uKsMZiJo7oTk6OLzODjmg
Message-ID: <CACSVV01xGvudO4yjFeWzp8zk6wtOaHsEj=sJ=0E_7=wvKfhcdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] drm/msm: separate compressed P010 and P030 (TP10)
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Bryan O'Donoghue" <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jordan Crouse <jordan@cosmicpenguin.net>,
 linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aede61d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=PWnpOtEoW80h80myw98A:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfX26Fdiu/Iw/j9
 iZBgITiicXzZwUmsjtDjn6NiIzIAs9mloJii0qBLL4KGUzvzIu08vqJYiFjLRQ5GvkfMdbx+O8A
 Rqcbsl7qSBpP7EJdiCpoFz0G/5epu3Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfXxW8u43Gd66ym
 1YEIg0l7WunsxTmtZPknts4WE9TurmyseN25xjR+7FUKhYDqEAdKxSdPQjK05UqLdBSLzc1AiKN
 EZRQZrob78Ff6Osu0CGWDEebI8r1d1Mc4EeIQ53mJSSQOQfbSBsqWpKy9LldrK+d+ojHW5YFPJ4
 9VLdlxZ/jQTsS4CaEtGnF9oVaxFxJnynLeNSb6iCU5KkCaCpks3EiWLXLDDLTffb1r2i/VdjaWd
 ppnCE+uhDGJzVN5fkz0tO2VQ3Rr0ZQvRvGvqsGiVuGA3crnICk41HDK60+SxMR35qqBbW3TkoTV
 wU2+mG+bz9jPr6skZ/Y43lnKR22tXIhUcnqjG2CE22uCswFR1Hb/H7IN2rJimw+CQdhDV5ZGu9e
 pBdTFDI2qDHIU653wp0uczvlkvig8u/eYNqGAAxWfxx71KYLlF/Wa2J/5hxFcZgSMx1X1DoEVRI
 5F8jQ3F2XIjvZBLXK3g==
X-Proofpoint-GUID: Q_CB58l2v45FwaYd6NRUxtIguzjBMvdT
X-Proofpoint-ORIG-GUID: Q_CB58l2v45FwaYd6NRUxtIguzjBMvdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060058
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

On Fri, Nov 6, 2026 at 5:44=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> The UBWC entry for DRM_FORMAT_P010 is set up for P030 (TP10), three
> 10-bit samples in each 32-bit word, the layout the video decoders
> produce for QC10C. It doesn't match P010: compressed P010, as the GPU
> writes it, keeps 16-bit samples and is scanned out as garbage.
>
> Use DRM_FORMAT_P030 for that entry, compressed only, as the SSPP can't
> fetch linear P030, and give P010 its own UBWC entry with 16-bit samples.
>
> This changes what compressed P010 means. Nothing is known to depend on
> the old meaning: Mesa and minigbm never allocate it, the vendor stack
> uses its own modifier bits, and the only user found is a draft
> GStreamer merge request.
>
> Fixes: f07c9946cc1a ("drm/msm/dpu: Add support for P010 format")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

This one, in particular, we should pick for -fixes

BR,
-R

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      |  4 +++-
>  drivers/gpu/drm/msm/disp/mdp_format.c          | 13 +++++++++----
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu=
/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 107150a8553f..f755c0d57abe 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -173,6 +173,7 @@ static const uint32_t plane_formats_yuv[] =3D {
>         DRM_FORMAT_BGRX4444,
>
>         DRM_FORMAT_P010,
> +       DRM_FORMAT_P030,
>         DRM_FORMAT_NV12,
>         DRM_FORMAT_NV21,
>         DRM_FORMAT_NV16,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/=
msm/disp/dpu1/dpu_plane.c
> index 1a471cdf767b..09146023d13e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -68,6 +68,7 @@ static const uint32_t qcom_compressed_supported_formats=
[] =3D {
>
>         DRM_FORMAT_NV12,
>         DRM_FORMAT_P010,
> +       DRM_FORMAT_P030,
>  };
>
>  /*
> @@ -1779,8 +1780,9 @@ static bool dpu_plane_format_mod_supported(struct d=
rm_plane *plane,
>         struct dpu_kms *dpu_kms =3D _dpu_plane_get_kms(plane);
>         bool has_no_ubwc =3D (dpu_kms->mdss->ubwc_enc_version =3D=3D 0);
>
> +       /* the SSPP can only fetch P030 compressed */
>         if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
> -               return true;
> +               return format !=3D DRM_FORMAT_P030;
>
>         if (modifier =3D=3D DRM_FORMAT_MOD_QCOM_COMPRESSED && !has_no_ubw=
c)
>                 return dpu_find_format(format, qcom_compressed_supported_=
formats,
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/=
disp/mdp_format.c
> index 33da569eae5e..2712a73e5783 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -298,8 +298,7 @@ static struct csc_cfg csc_convert[CSC_MAX] =3D {
>         .unpack_count =3D 2,                                             =
   \
>         .bpp =3D 2,                                                      =
   \
>         .fetch_mode =3D MDP_FETCH_UBWC,                                  =
   \
> -       .flags =3D MSM_FORMAT_FLAG_UNPACK_TIGHT |                        =
   \
> -                MSM_FORMAT_FLAG_YUV |                                   =
 \
> +       .flags =3D MSM_FORMAT_FLAG_YUV |                                 =
   \
>                  MSM_FORMAT_FLAG_COMPRESSED | flg,                       =
 \
>         .num_planes =3D 4,                                               =
   \
>         .tile_height =3D th                                              =
   \
> @@ -606,13 +605,19 @@ static const struct msm_format mdp_formats_ubwc[] =
=3D {
>         PSEUDO_YUV_FMT_TILED(NV12,
>                 BPC8, BPC8, BPC8,
>                 C1_B_Cb, C2_R_Cr,
> -               CHROMA_420, 0,
> +               CHROMA_420, MSM_FORMAT_FLAG_UNPACK_TIGHT,
>                 MDP_TILE_HEIGHT_NV12),
>
> +       PSEUDO_YUV_FMT_TILED(P030,
> +               BPC8, BPC8, BPC8,
> +               C1_B_Cb, C2_R_Cr,
> +               CHROMA_420, MSM_FORMAT_FLAG_UNPACK_TIGHT | MSM_FORMAT_FLA=
G_DX,
> +               MDP_TILE_HEIGHT_UBWC),
> +
>         PSEUDO_YUV_FMT_TILED(P010,
>                 BPC8, BPC8, BPC8,
>                 C1_B_Cb, C2_R_Cr,
> -               CHROMA_420, MSM_FORMAT_FLAG_DX,
> +               CHROMA_420, MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | MSM_FORMAT=
_FLAG_DX,
>                 MDP_TILE_HEIGHT_UBWC),
>  };
>
>
> --
> 2.47.3
>
