Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0AF483FB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5578D10E3EA;
	Mon, 23 Mar 2026 20:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7fj8rLv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VNBddHUy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F4C10E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:45:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHr0ND618735
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=bNj1iPSQR5++rIXMtXYMWNLEicRX9e/nU1RQDEWyQwY=; b=E7
 fj8rLvakvV8On6nETPNgnnKgHwDTGEBulNMP8rkCrL7guoltEHVqNQcB7jd1uQJr
 3WUkVzcXmVdpgitU2S2L9TDfkpbfa2JlqWR21O3OU/xWUyDYsRUz9zbVnGBYkyTN
 XFEO1atCCCzRvjR3+smpJvNysZ5cJvBh4ofW4RV8u5tG/Ia0WhVf6iQA6YONGUh+
 N93PXFA+nydzL7k3xBv99YWd72kQFSbYeJS8c3K0npHH7FdrdRI3Is/R3lSqRO2v
 z6/LSwidAJZHBFN3dg7wm/5i9LIb/OtC2QExc7X7D7gDc5sAKeHIu+grHOVm2B29
 IOBcEigKVKnT/8pFFUjA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jgjpg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:45:28 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-67df391509fso8996357eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774298728; cv=none;
 d=google.com; s=arc-20240605;
 b=dkFzUhzyJyek9BgN8PNkiNjNUf5VlRygg7ZlUgZVyYfpWNb7fr/ffFcpoHpic8ZoV9
 7CVlxL9UonSIT/nvuooVFjtXuoNdFWrm2LW+wEEtAPCKx8XpK1PWH5ajxqNXu2dqf7Wy
 0LiNzbDOEtExCd0h9uAJAKPNQ8Jr0FKTRXRZfYBB9RhC8gu31L1h/1h5Ot69fEjLhx6h
 08q1wB7X4DFtqqqkA1mBeFwZTtIwbg3nHczPF2qBg978sXznKtvnPvKFtst+cjcVmP3z
 HxuwXU3Zed5xtIMDb1USXldubVzBUbjY2TJ1bfaZDw09ahXryY9eVMgrQMdg6GlFsjQ/
 TWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=bNj1iPSQR5++rIXMtXYMWNLEicRX9e/nU1RQDEWyQwY=;
 fh=du2uP0KhQBHf1W56sV4VZ6RSnucbCb0yv+4jz5ZH5t4=;
 b=WdLwKtOYYoqiSGI2SkB0XPcQGNiD/oYuhXcKRrmrBzesRm0q4MyI3D4UD1yLPdzw/R
 p5nbZ6Xa5tHtA98vm1Y/eM3W3m3e6vf2mLsdCV1YybAvYjJydrzE+5SgNuWKaP1wXBSO
 TV+aE2wwXvoy8NG3m95HMWYNZOmxuM2kD7cEBH5lL1J3LOYbg7zm1gAsRpwh2wNqPSdT
 NFYTCtqmbrsjgKhCFyeuDQtPrkhqkxXmElDFYWsVtrxSNC+1r/28ziqN68wrxMn/8wwr
 Ho90M5xe5XVbBIA7Iq86IQXMdBI9/k0vUlWgTxgfS2BeEF3YqC1utR5Nx2gD3rEpmLN4
 OYvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774298728; x=1774903528;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bNj1iPSQR5++rIXMtXYMWNLEicRX9e/nU1RQDEWyQwY=;
 b=VNBddHUyN35fRax4D+8Z3K54l4YljUOugpk6YBIOD7U5t/uVZXjZK+KPgmOCYQLEgP
 8rIb/eTfIQbdPH+ZifhjFt5HjgDOsqClBXcv2BtikLaWgoXDNXmCbSB99lLfvfK/ZCLs
 1ZyivtbFRMi/n9QmG13YDEpoVy0N1CcR7+w1bXhHSxjt03UqcHMW1CIWGy2KOcZfvj6V
 suhpjTGENlyi7a4gXIC1KqJXj3U+/gufRag+wttpoJA1zumRgKo49kUEz3vOBCY6GDJA
 ClZ4q6VvK2UkEgPsfnoVB7GOM3MlynlnbredVfDLlgFLLj5Iv8YTFTfHvLDUnkh3Y60h
 GAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774298728; x=1774903528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bNj1iPSQR5++rIXMtXYMWNLEicRX9e/nU1RQDEWyQwY=;
 b=qj7E+bAD7m+JtXYtM+suRxG+9OmFckdmclYfy78osLgL33wyKL/DNHTJzoZj31WUhB
 /uRvI4Y1fYbbTkyXvvRPGEiDpAXRLmFOCh0zdChss1N28MKwaUcEriyXs0u9Di2vOQiL
 j2cDRWjvoezvu1y65Ay1IqthUuSlpFMHOkt0VZhN+/8K6ah4AHvu8fGGAWseFBz+iLot
 FWKX+3vKh4w6CBYRU+2AMn7vF/SeDcFhis9+kavaCdOB58zaZjMplk9a0k+U782Qlq5K
 IvusZLSuO1sAlMjE1sfECdyP3e1RZk8LigWxTgItz81zR45pgv3ilXJPO+UQSqKI3ffL
 e2pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQfertb6ilF8uyoYjrdvbATl1TKojaNA565V7+boXZGETQBQGuBwtP9/8j+ikF2aBwDycrYusQVww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywmue+6a5hYIc9ayuHnQZXWxHnh3Rea5FgnOPL8asQcGO16IzAQ
 9MTW+GRmjR/QKQlPVFMySndo8gcCRPohhgPxVkg+ICPGOrLbq7GL2CZZgGITUvujXf5HKURPAig
 kW/IkfCsbzsB9y/OsRF67ECNdnVHPhhi/QK1D37IzfV0gSY6A3VePD+Uygbh6/wAXXMWUNKQLiG
 +bdWHu9uMgQ1n6Z74PVXHH0/MZ22IIiF6BfDkSUYw90Uspyg==
X-Gm-Gg: ATEYQzz1v9voPU+jNQdlvgEpH0FoP5+098CimNTsDtr2EpieeM+UKS7BVJ+G7BpVm7g
 kiokDeVo460/dIc4jvSn+Qr2Ve2YphLnWJchqDFbvdzcHQPZjKDvGyukI5dS9lK1c05xWCGCL94
 B/i+T8+G7Vl90H5Ub6/JHH9NItSZET8/QfEdV+MSopyt+ZSfpU1WnixvpDKlgcO3sob7BOYhMHs
 lC5ISGH8fkfixALJTF/OV0gMj1d+MA+5325iQ==
X-Received: by 2002:a05:6820:138b:b0:67b:b01c:5899 with SMTP id
 006d021491bc7-67c22f90a00mr10907276eaf.56.1774298728133; 
 Mon, 23 Mar 2026 13:45:28 -0700 (PDT)
X-Received: by 2002:a05:6820:138b:b0:67b:b01c:5899 with SMTP id
 006d021491bc7-67c22f90a00mr10907258eaf.56.1774298727715; Mon, 23 Mar 2026
 13:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-6-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-6-fc95b8d9c017@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 13:45:16 -0700
X-Gm-Features: AaiRm51DPUriZJa4xwXTFaW0t808zMAtRVIV2EXrdcYsElEvW_klRHWZS6FmivU
Message-ID: <CACSVV02XkyT-om4LQJA_Xa-4Z+B5aKOPU_3uxtwHCa1nMXVUKg@mail.gmail.com>
Subject: Re: [PATCH 06/16] drm/msm/a6xx: Use barriers while updating HFI Q
 headers
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
X-Proofpoint-GUID: vLBpsFlNu7euWmsMIlQn6NSEOk6ddxpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE1NCBTYWx0ZWRfX1ACYdPsCeAYI
 zZHDJ9SSptMIdQNW+fgKFTx08ZHBBDcZnnnw9t3YkLeYM4Bz/1dMJeLcZLaipnbzkpmxVExViBp
 DPOVdnNvWzzE+NzOa9YQNEVNunfvJcQoTaE/61FnxxWDINi8jwoQy1kp2/NZB9xD7Kt6HvvvnDK
 +YHxNY/4VZJx83zy8LXsn2Huf8Do9Nhm0zTKO0g95xBH6E+NSmqw8XlkYiD5cVZuOqqdR5zi28B
 bhB4cPBOXtpdGBN2SZRrPkNImDSfr68FSNkDiEjnStqijeXyoNwHuGBb9RORGjoiqwQJZSm+5Mf
 wdSztHV5aaL5vZyShicT21BTwb/cfqVTJ32uxoez9Lv0YvoGD8fNY4rERtz8H2o8HMnnBW+PoH2
 amd/QjiFG+zLb9QKmqz9z9y8AzXI5y3ZqPB19/nTBmT46Dy7tZ+23aDzj5ekFbiheUUEYhRCp1Y
 zWZDa5tO5wUjnsOMbhQ==
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=69c1a668 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=EN7PASqqd2GOn1YqBuoA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: vLBpsFlNu7euWmsMIlQn6NSEOk6ddxpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230154
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
> To avoid harmful compiler optimizations and IO reordering in the HW, use
> barriers and READ/WRITE_ONCE helpers as necessary while accessing the HFI
> queue index variables.

This feels a bit like it should have Fixes: ?

> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/=
adreno/a6xx_hfi.c
> index 2daaa340366d..aef00c2dd137 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -34,7 +34,7 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
>         struct a6xx_hfi_queue_header *header =3D queue->header;
>         u32 i, hdr, index =3D header->read_index;
>
> -       if (header->read_index =3D=3D header->write_index) {
> +       if (header->read_index =3D=3D READ_ONCE(header->write_index)) {
>                 header->rx_request =3D 1;
>                 return 0;
>         }
> @@ -62,7 +62,10 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
>         if (!gmu->legacy)
>                 index =3D ALIGN(index, 4) % header->size;
>
> -       header->read_index =3D index;
> +       /*  Ensure all memory operations are complete before updating the=
 read index */
> +       dma_mb();
> +
> +       WRITE_ONCE(header->read_index, index);
>         return HFI_HEADER_SIZE(hdr);
>  }
>
> @@ -74,7 +77,7 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
>
>         spin_lock(&queue->lock);
>
> -       space =3D CIRC_SPACE(header->write_index, header->read_index,
> +       space =3D CIRC_SPACE(header->write_index, READ_ONCE(header->read_=
index),
>                 header->size);
>         if (space < dwords) {
>                 header->dropped++;
> @@ -95,7 +98,10 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
>                         queue->data[index] =3D 0xfafafafa;
>         }
>
> -       header->write_index =3D index;
> +       /*  Ensure all memory operations are complete before updating the=
 write index */
> +       dma_mb();
> +
> +       WRITE_ONCE(header->write_index, index);
>         spin_unlock(&queue->lock);
>
>         gmu_write(gmu, REG_A6XX_GMU_HOST2GMU_INTR_SET, 0x01);
>
> --
> 2.51.0
>
