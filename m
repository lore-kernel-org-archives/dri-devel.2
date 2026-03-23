Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F096F483FB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96A610E45B;
	Mon, 23 Mar 2026 20:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxwgLxct";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uk3z1+3F";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E81B10E47F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:38:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqcLD3817779
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=qypMYrroSdezLsUd7cUleaPAQK3tXijyEbNi7LtRU4w=; b=Ox
 wgLxctj4OZzGKg4UwQp6tulnkF6VIN+56Tvl6n6ue0gG3jr7EZK/OFBbOCMmAiZH
 Qj/Gi/5n4AHKx3/0VfsxoHncAXuJIj6FCZtSUr3+k6rYuGobYXVoBXWehhTfNViV
 /fV372lMtVYI56THpgMEmZrSFiA2RT2Zp7S7N0BmlQ37QI7wWOUZ5lIIYe2qkpEp
 iN6xEDzmo7Tkr3rHO2h6K8Zou4jvSCwzBuEUh0/9Wi9yTcZvYD0G49UmhHwEt+zr
 8bYRoc9wLqvMcLrm4L4ZwPvP0yiPXBb0q26EZlvl50TC3HYeHFTi8cxTL4lNRlzN
 FtJEZw/SU3vOL3fLrL4g==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w1s8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:38:03 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-67dece24dbcso7953908eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774298283; cv=none;
 d=google.com; s=arc-20240605;
 b=T9rdiDS8Sc5C5r8iQ+G8zIbI3Zy0yeLKW6w8lGriLpBsfrH+FQV/CwrpAmUoY0wR6e
 Yq3mqqhGoS3IhFXXTaxe7QXrCOiah4+4zBHWcxcDbPvAELSxBQh75qeCJkDv4MD9mzy2
 1JslmrYlqq1aZReJ02ZT1ekPAJcuwi9DYVV7wPheV9k/sG9DyzoVbJGXMi+CaF9jK1Hp
 Xozrcz2zzwSbKpU+ceupTS/ZHvrxdQObAXU62eIA55D5UxjMWdq5OxkeMU0UwSpAYgrV
 a6bzYZQzw+1CgEVAy7hub3FL3kter/1RTWndE+pSP8woPhOJlIN+3/sjcSsr/2jwgAUD
 GObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qypMYrroSdezLsUd7cUleaPAQK3tXijyEbNi7LtRU4w=;
 fh=8EdqHdJoQRXQKdvG8VDKJ2+X+SzQ742nxiekNEshpg0=;
 b=hJNkR6S400fmoxA317zS3mh1kqmaqHT1gLjxq/hBK2cYGOPTrUU0baVRxdj8ORtaka
 El/tovD7pMrYnrh9lqsJpvlied83QoAEPqnBcAG8LMZD/5qmVKfwAyvtQHSvm4L02GIH
 SQgFKopCtNGWbWJBqXgd3CPoBuHLfTHhiJAvG8kOwZFLce5LQv5VGXEZMy1s9qghrO8F
 l+w/mVQnj5lF4xXBQimkkoufFDE/GpXmIcIoN5k7T1BZQIHB+78oBqdnAki/ZYZpqrBb
 1x1xi9AfCVVxWfHpNid0osNOJm+w8Xeegixpn6BN55w42EVtljhQYNmKzGXwSaO1HOsE
 2ukA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774298283; x=1774903083;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qypMYrroSdezLsUd7cUleaPAQK3tXijyEbNi7LtRU4w=;
 b=Uk3z1+3FnkgC+L22dpu7dx4lBFgiHYmR5JWtI8WKdPC93EON/ZZiubfLEQFgsy/VbV
 mqJoDgXXtnaT6FT+enGFBJMILNO7fEN5sZzi1fBQJCSWfUrpP5VYaGblIsyisekN78Sj
 IKAaOt8JFTMNlBcHtjpw5DUYeVgJqXHqpU5mR3uFBMOn/tBDiyrRteZNGMSIntdd00cw
 sd2x5rS7VNXDcnyI477doZBFysde8yRb7Zjnoch8oEKq7Mn9NJPfmSbn3pnnXhtwcTyu
 pjLKwuA99hGm4xDRpjPguaiWjC3mAS+Kmx+QmvaiK/FX+FOwM5lnn9Ye4a9Tb7fO1oqH
 t0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774298283; x=1774903083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qypMYrroSdezLsUd7cUleaPAQK3tXijyEbNi7LtRU4w=;
 b=k3IdQpXkAKp1HDXsY8LXvJFr4QWHqJhSWIZf7fOeHg84itG0FdmV/kmGEwlhczOeEO
 QUJg7bxLd614rydzkxAFzaQzCxj7qY2F+aNmHbRX9miHnRZWpV4/qYfX+FZfT8Xk7J7L
 MK4E0NFbknXIDCYzxcDiALliX/dVCqTp80gHjxS+Iv8epTBZFxPURY8hmuYCev4zB+0m
 m28aHXfFRmS+6bD5tm6WEeEvhkbsH4eVIReuDiwYhTTunYEDWD/ajr5xU5x/kZjT+7KQ
 D5F5lvww+pYUT0+/E7ysWIW0qAJb+TMOZvsCx5QPqjHkAd3tBzNGqp45fqqE8TQh6cKz
 HpmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpmmMzWuKUFlBSSnPKQXfpgVXOAUKquypyvzTQ5n9P0ed3yblGdK5KxLHtZWPNqx9BfPR9h47Pjck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMvVVeAFWagadO2+GT1jh6wof567AFrGLyUFDsPQvNV7QxozqS
 XPhipaMw2HBIoghy0hL7FNEsUJq3750oKW0L3a8AG/WTn93ziThLUFqLeiu9op7b1OdWIx6t9SY
 KRc1NgTwbs0njkfwtljzCOUTS96CuCQrn8kY5LAmDhmDPDOK/TVabQH9lOEwtLQfLLNnR2XyYyl
 2tdWLls1P71ShLeukAN4KEUzs8EBs7+iR3wsy9bsnP5MJYAw==
X-Gm-Gg: ATEYQzxwJLUBjuu07Pj1lqKKZALGErPqKCOBhe0tbNr4WXsATxtpcsMNWCM7bNodD6j
 q+ArHpbps8SJxQjRs9HgFSNH3oAdVyf040qbCf6YRPVPLc349i81Z/BF5byRkfld1Y97w4aQhre
 C+9OV+rLNT7mHtk53XkR93libtVAzjATzYRTph01X18ZYvifK6tvFSgQkPs1rg0cEP8HdP9iW3v
 CYzQxkvyD6v2YCulgvdZqOdob8kEPfi53FlEQ==
X-Received: by 2002:a05:6820:160b:b0:67d:ee3c:9ad4 with SMTP id
 006d021491bc7-67dee3cba9fmr2510234eaf.1.1774298282605; 
 Mon, 23 Mar 2026 13:38:02 -0700 (PDT)
X-Received: by 2002:a05:6820:160b:b0:67d:ee3c:9ad4 with SMTP id
 006d021491bc7-67dee3cba9fmr2510222eaf.1.1774298282085; Mon, 23 Mar 2026
 13:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 13:37:50 -0700
X-Gm-Features: AQROBzDynikIebC1QNf7dTP-npSQujbxNMJmxWjLbwDutWftcNbPlmn0jTGkAU0
Message-ID: <CACSVV03ciF890bDpqcqVhhHeLv0hx1whNgq0RUUKTyAfVopOWA@mail.gmail.com>
Subject: Re: [PATCH 12/16] drm/msm/a6xx: Add SKU detection support for X2-85
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
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c1a4ab cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=7z8P23FROURhuZ24mNkA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: 154_tEb776R1k3oHYgUoz2qjThyD5yUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE1MiBTYWx0ZWRfXxZq5ksYHeif4
 jU0MfjrYaC6mv1ygrqEEbMs9yFS7sTBVFEC9U1/M8FmflB3AJGEPZ1GzlpboJ9p0ahdTYNio1fm
 VqYJNmnPw/j0mAK71xG3j3g89Ai1LAgzgLNScGN6qic9ldp6gqBLjXA6uUfhZjOKflNnON5Oh9v
 HvdDA0mkQg1tTddR28TfWXWMOPiCt6q3WbcB7juoYb3FBpe03CgXY5vVsPxvY47SUO2z+Xd5eVz
 Y2GVbLAP8eRx1S+aCZ6AIZOxH2R2NbhKU1v8p3H9KCxOOcEduDAQwg48UT5NlpRWINYDFLgDRQP
 J3GfOYldyv9xfXsw1ANS5BXzR+u4zp9ySnHEtNpfGq/3tCJMEgFU0Vk8zSefhKRMP/xWtjvSzVB
 hlwxoM97dG1omHPWV+gRZazI1nRd0yf41A+4I1RtAxhzqwwRIw9YStJA4HuRzl2i71SML+tQmKE
 UsNyB9CAlOf+o4QEX0Q==
X-Proofpoint-GUID: 154_tEb776R1k3oHYgUoz2qjThyD5yUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230152
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

On Mon, Mar 23, 2026 at 1:13=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> Adreno X2-85 series present in Glymur chipset supports a new mechanism
> for SKU detection. A new CX_MISC register exposes the combined (or
> final) speedbin value from both HW fuse register and the Soft Fuse
> register.
>
> Implement this new SKU detection along with a new quirk to identify the
> GPUs that has SOFT SKU support. Also, enable this quirk for Adreno X2-85
> and add its SKU table to the catalog.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  6 ++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  9 +++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 41 +++++++++++++++++++++=
+-----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  1 +
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  4 +++
>  6 files changed, 53 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index 79a441e91fa1..d7ed3225f635 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1731,6 +1731,7 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_dev=
ice *dev)
>         struct adreno_gpu *adreno_gpu;
>         struct msm_gpu *gpu;
>         unsigned int nr_rings;
> +       u32 speedbin;
>         int ret;
>
>         a5xx_gpu =3D kzalloc(sizeof(*a5xx_gpu), GFP_KERNEL);
> @@ -1757,6 +1758,11 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_de=
vice *dev)
>                 return ERR_PTR(ret);
>         }
>
> +       /* Set the speedbin value that is passed to userspace */
> +       if (adreno_read_speedbin(&pdev->dev, &speedbin) || !speedbin)
> +               speedbin =3D 0xffff;
> +       adreno_gpu->speedbin =3D (uint16_t) (0xffff & speedbin);
> +

I will confess to not expecting to see a5xx changes in a patch adding
x2-85 sku detection :-)

Maybe split the code-motion out of adreno_gpu_init() into it's own commit?

BR,
-R

>         msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
>                                   a5xx_fault_handler);
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index f6b9792531a6..758bc7bd31f6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1902,7 +1902,8 @@ static const struct adreno_info a8xx_gpus[] =3D {
>                 .gmem =3D 21 * SZ_1M,
>                 .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
>                 .quirks =3D ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -                         ADRENO_QUIRK_HAS_HW_APRIV,
> +                         ADRENO_QUIRK_HAS_HW_APRIV |
> +                         ADRENO_QUIRK_SOFTFUSE,
>                 .funcs =3D &a8xx_gpu_funcs,
>                 .a6xx =3D &(const struct a6xx_info) {
>                         .protect =3D &x285_protect,
> @@ -1922,6 +1923,12 @@ static const struct adreno_info a8xx_gpus[] =3D {
>                                 { /* sentinel */ },
>                         },
>                 },
> +               .speedbins =3D ADRENO_SPEEDBINS(
> +                       { 0,   0 },
> +                       { 388, 1 },
> +                       { 357, 2 },
> +                       { 284, 3 },
> +               ),
>         }, {
>                 .chip_ids =3D ADRENO_CHIP_IDS(0x44050a01),
>                 .family =3D ADRENO_8XX_GEN2,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index cbc803d90673..0fe6d803e628 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2552,13 +2552,33 @@ static u32 fuse_to_supp_hw(const struct adreno_in=
fo *info, u32 fuse)
>         return UINT_MAX;
>  }
>
> -static int a6xx_set_supported_hw(struct device *dev, const struct adreno=
_info *info)
> +static int a6xx_read_speedbin(struct device *dev, struct a6xx_gpu *a6xx_=
gpu,
> +               const struct adreno_info *info, u32 *speedbin)
> +{
> +       int ret;
> +
> +       /* Use speedbin fuse if present. Otherwise, fallback to softfuse =
*/
> +       ret =3D adreno_read_speedbin(dev, speedbin);
> +       if (ret !=3D -ENOENT)
> +               return ret;
> +
> +       if (info->quirks & ADRENO_QUIRK_SOFTFUSE) {
> +               *speedbin =3D a6xx_llc_read(a6xx_gpu, REG_A8XX_CX_MISC_SW=
_FUSE_FREQ_LIMIT_STATUS);
> +               *speedbin =3D A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS_FINA=
LFREQLIMIT(*speedbin);
> +               return 0;
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6=
xx_gpu,
> +               const struct adreno_info *info)
>  {
>         u32 supp_hw;
>         u32 speedbin;
>         int ret;
>
> -       ret =3D adreno_read_speedbin(dev, &speedbin);
> +       ret =3D a6xx_read_speedbin(dev, a6xx_gpu, info, &speedbin);
>         /*
>          * -ENOENT means that the platform doesn't support speedbin which=
 is
>          * fine
> @@ -2592,11 +2612,13 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_d=
evice *dev)
>         struct msm_drm_private *priv =3D dev->dev_private;
>         struct platform_device *pdev =3D priv->gpu_pdev;
>         struct adreno_platform_config *config =3D pdev->dev.platform_data=
;
> +       const struct adreno_info *info =3D config->info;
>         struct device_node *node;
>         struct a6xx_gpu *a6xx_gpu;
>         struct adreno_gpu *adreno_gpu;
>         struct msm_gpu *gpu;
>         extern int enable_preemption;
> +       u32 speedbin;
>         bool is_a7xx;
>         int ret, nr_rings =3D 1;
>
> @@ -2619,14 +2641,14 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_d=
evice *dev)
>         adreno_gpu->gmu_is_wrapper =3D of_device_is_compatible(node, "qco=
m,adreno-gmu-wrapper");
>
>         adreno_gpu->base.hw_apriv =3D
> -               !!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> +               !!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
>
>         /* gpu->info only gets assigned in adreno_gpu_init(). A8x is incl=
uded intentionally */
> -       is_a7xx =3D config->info->family >=3D ADRENO_7XX_GEN1;
> +       is_a7xx =3D info->family >=3D ADRENO_7XX_GEN1;
>
>         a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>
> -       ret =3D a6xx_set_supported_hw(&pdev->dev, config->info);
> +       ret =3D a6xx_set_supported_hw(&pdev->dev, a6xx_gpu, info);
>         if (ret) {
>                 a6xx_llc_slices_destroy(a6xx_gpu);
>                 kfree(a6xx_gpu);
> @@ -2634,15 +2656,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_d=
evice *dev)
>         }
>
>         if ((enable_preemption =3D=3D 1) || (enable_preemption =3D=3D -1 =
&&
> -           (config->info->quirks & ADRENO_QUIRK_PREEMPTION)))
> +           (info->quirks & ADRENO_QUIRK_PREEMPTION)))
>                 nr_rings =3D 4;
>
> -       ret =3D adreno_gpu_init(dev, pdev, adreno_gpu, config->info->func=
s, nr_rings);
> +       ret =3D adreno_gpu_init(dev, pdev, adreno_gpu, info->funcs, nr_ri=
ngs);
>         if (ret) {
>                 a6xx_destroy(&(a6xx_gpu->base.base));
>                 return ERR_PTR(ret);
>         }
>
> +       /* Set the speedbin value that is passed to userspace */
> +       if (a6xx_read_speedbin(&pdev->dev, a6xx_gpu, info, &speedbin) || =
!speedbin)
> +               speedbin =3D 0xffff;
> +       adreno_gpu->speedbin =3D (uint16_t) (0xffff & speedbin);
> +
>         /*
>          * For now only clamp to idle freq for devices where this is know=
n not
>          * to cause power supply issues:
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 10d9e5f40640..826661cb7988 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1184,7 +1184,6 @@ int adreno_gpu_init(struct drm_device *drm, struct =
platform_device *pdev,
>         struct msm_gpu_config adreno_gpu_config  =3D { 0 };
>         struct msm_gpu *gpu =3D &adreno_gpu->base;
>         const char *gpu_name;
> -       u32 speedbin;
>         int ret;
>
>         adreno_gpu->funcs =3D funcs;
> @@ -1213,10 +1212,6 @@ int adreno_gpu_init(struct drm_device *drm, struct=
 platform_device *pdev,
>                         devm_pm_opp_set_clkname(dev, "core");
>         }
>
> -       if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> -               speedbin =3D 0xffff;
> -       adreno_gpu->speedbin =3D (uint16_t) (0xffff & speedbin);
> -
>         gpu_name =3D devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT=
,
>                         ADRENO_CHIPID_ARGS(config->chip_id));
>         if (!gpu_name)
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 29097e6b4253..044ed4d49aa7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -63,6 +63,7 @@ enum adreno_family {
>  #define ADRENO_QUIRK_PREEMPTION                        BIT(5)
>  #define ADRENO_QUIRK_4GB_VA                    BIT(6)
>  #define ADRENO_QUIRK_IFPC                      BIT(7)
> +#define ADRENO_QUIRK_SOFTFUSE                  BIT(8)
>
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/=
drm/msm/registers/adreno/a6xx.xml
> index 3941e7510754..2309870f5031 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> @@ -5016,6 +5016,10 @@ by a particular renderpass/blit.
>                 <bitfield pos=3D"1" name=3D"LPAC" type=3D"boolean"/>
>                 <bitfield pos=3D"2" name=3D"RAYTRACING" type=3D"boolean"/=
>
>         </reg32>
> +       <reg32 offset=3D"0x0405" name=3D"CX_MISC_SW_FUSE_FREQ_LIMIT_STATU=
S" variants=3D"A8XX-">
> +               <bitfield high=3D"8" low=3D"0" name=3D"FINALFREQLIMIT"/>
> +               <bitfield pos=3D"24" name=3D"SOFTSKUDISABLED" type=3D"boo=
lean"/>
> +       </reg32>
>  </domain>
>
>  </database>
>
> --
> 2.51.0
>
