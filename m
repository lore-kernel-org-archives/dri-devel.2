Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC26C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411FE10E175;
	Sat, 26 Sep 2026 18:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTVklCbL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GLqHBN3D";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B2310E276
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:40:40 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxUji4013973
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=YDMsqZuuxwsgxKD8S0rjlnvTctu70wqMTJY40/NHwEE=; b=gT
 VklCbLGlsR8PPgLyl9EewSUX+gASolwObCNZrmi2lje0j7Wsezgk9/3vYoPbR2tr
 WYTvbP4Pvl6AOrTnmwSWuIyEvUAIqGUHC2uBzwAssVg1Tczc21eLWUrhTQEj/LvJ
 ijNtU+D+Q4u2SmHcaAXm7Bpjj6aoM/gf/9fYmqN1X+nRYoPn5NI3JE9tGM7i1dFS
 uv/AcW7t1WXQS5tk5ts0XB/YLBRjGpCaE1+4E1B5bGPSykVyxIiI56FsX6PK4r8O
 zmrOwgFb4vW+A1w60cX8fU5awfqi+S6kKtUuHvEBlWhjfrtCsbZdgtdjYJXgmnwj
 rw4PO3AUGXOg8tTY3X1w==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tehe6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:40:39 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-463ddb3b4f7so2230986fac.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790448039; cv=none;
 d=google.com; s=arc-20260327;
 b=QLXlmjLYoiWN9byTJKmKroh4Iw2jTu5/sRduHWUeVy49wBLH/Hj3DN7wWpgvAWKZ1I
 1RH5u7cpsprBeEMqGyaBF61/FY9bRJvVCW5MrLE6QR8dlOb5oNsG9X66rKBaYS44L8XH
 NR/vtTaZVK6cQH8LvxZVoB4iTqgY+qHAEkhPYYpUOKtg4am6+UmL1kEQ7PZGc6bFEHeD
 TNQFVLdRePMz1HKl4dcKPXsRgYF0lMpK689A6dPEo4DiIs9IzTRG7VU4rua/6PCsbFG6
 kLlrgor325A7iwhF19ljWiByFAMde0pUTn0vq3Odu6TmF4kcMZPlADnP2obUZtettFnf
 1fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=YDMsqZuuxwsgxKD8S0rjlnvTctu70wqMTJY40/NHwEE=;
 fh=6zOPmbmzPsFs52Gp307e8MBsqDEyRG84195Vu3wqV+U=;
 b=CXAoeLEPQNKHbpDDZ0AsrZD4s8D8flClb/ZxRvJ3VIw62hPeh1A/JeXWtu99Zb4lKJ
 MGV9H+t+cf7zextr0auSq3A8Sy5VTB2rwD75t12car+qrXuLGrlSOh5tSMO59YoZdbMU
 kD2Cv+KjaQM6QotuEcpsv6DBHqMQS2CM2mTq1gcFTvKXUF497Zedy2btY4AdiGy3r2sJ
 kppz3Kg2hDlFqzNaD9jH0+Eg87L33SNw6zW7y3T0AiHC+busLUg236zZ0By1k3jVjcni
 7ScMF8BNvkNle+LM8qegcnw+1PzDC7anv4QJ2bFpG4RQ4KYyUME+xfLxgbRuxmdFZkrG
 uIow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790448039; x=1791052839;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YDMsqZuuxwsgxKD8S0rjlnvTctu70wqMTJY40/NHwEE=;
 b=GLqHBN3DKiZJ+BgTN5Ymp9Eks4sYA5yxXsgVKM/zyAnkfzaYLulTjEkhpbFdyGO2RM
 aRfbVm50E33amtBX6qziWbOVZ8rOlBpf+e4jFAT9dtkyYidN38EnZrHREEPoGtf7UAKN
 AnBcOaTTbbSFg508ALu2kYZwcaCmLNs1glfrMO4/a8xVYSyzGQIYyW6SlgbqG0XPJ8g3
 OA7sJHVT67j0/cGetKhR9iGlMSm9qtNyz+5jjbA+Xip8WcI+CCcDCpPPT30ycRSUCoA0
 x3YHYi2kY35mnM3KVc+5oTVb2qrZmmSH8taYO8gb9UECnYYQmBTHVomIk/lsrIAViZgR
 aqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790448039; x=1791052839;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YDMsqZuuxwsgxKD8S0rjlnvTctu70wqMTJY40/NHwEE=;
 b=o/A+Koq/ICYOA03yEpQbO7ZQOWy+YGUaOHwC2H9m4y/cP+RC6bID9/scNbZdivpal1
 cQnUSNPIUuqES73jdHLqEtA392rP+mAqRrL3PX7f2D7612dvVzaJFQNgYnf4RkTMplLP
 VPNCoEUZMyNnEknqcA8zArzRomWLsxDVD9JO8Vdl5PetwnhELT3bRUoO7Rt+1wE1ZU/R
 wGOYgS6HQar/vKd+COo0B2hJ/qBw+d/m+qhWKVFd21ajDLamdko+IxgrmxbMuTy2go5D
 X79KaUwEGwJqOMmBf/7GsVFiPaOg0yZ25z3DjBurMz5Lt42Ob1bSW8Ic3d8zDyXqj0sk
 B9YA==
X-Gm-Message-State: AFq9FYKlRcDix1mZdsDzwM5JTD0yxITNljKDY94tLfeCh9En++eXN1ei
 sFNlTyIESYSvqnjf9+KMKGXDAm5m08rYSk6juiHItC14VIm44FTnVGBQy1f7qaROq8EOxOZ0j++
 V8INjnwbuAtxiB+jZjRQ8B4GX0SGj+DqMrMU7vxWqKO7rdjnYkVpojLCf/D02G51CVMeaAWO0ze
 heZ73QvVDXuaKUaL1rUBgNStUvFg00GWa4PAzl9wmdHrO15w==
X-Gm-Gg: AYBFou0pVIqDYLruCxBfapyyoYf8jtGLYK3b3b91oDFk0ETY5ipTEcLDT94PyBnzNU/
 H5qMTvmGXlm67DYhQU07O5KwMw6GHC3t7lHe/3yXU7qcpeXePA779WUBRlHWWhOxh3EDa+nb16B
 CNR9j/X+G1SxLLQ9ih/tRVq6wvrGJkCBebdGQHWVBWdBGLunwY27+wp8t0
X-Received: by 2002:a05:6870:658f:b0:490:ccdf:1931 with SMTP id
 586e51a60fabf-491e79675e6mr7629119fac.55.1790448038833; 
 Sat, 26 Sep 2026 11:40:38 -0700 (PDT)
X-Received: by 2002:a05:6870:658f:b0:490:ccdf:1931 with SMTP id
 586e51a60fabf-491e79675e6mr7629097fac.55.1790448038374; Sat, 26 Sep 2026
 11:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260926022026.10539-1-liujianfeng1994@gmail.com>
In-Reply-To: <20260926022026.10539-1-liujianfeng1994@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:40:27 -0700
X-Gm-Features: AclHuK8ym8-acg312rqWr-pMv-9ORiLGe39RqXxyk_EMaZQOc4Be3_B5fffQ3PQ
Message-ID: <CACSVV00iE210xVONVT+XpuqmCn6E_RBrtBW2KkAB5YRP5DuZiA@mail.gmail.com>
Subject: Re: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "Bryan O'Donoghue" <bod.linux@nxsw.ie>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NCBTYWx0ZWRfX1R3Sq6g1eaH2
 amfPPyNb1Ru5frZe/+q3hSlz7/A+2x383PHUOKTCW3WTntwWmFlcDy1RUrkKJq6lyIqEh5iCH8l
 VUj79pMQzP5QkRba7z0FNHu803Xq4qZ8S0NyZIuD6wREFU2kH7LusBZ1f9LTTDlEaMn+KKEwFzV
 nWhusQBDsf9r3aeebkqK2E6akh1iVkamtCw5XprLk3yQPEony8kQ6r1N07vfhGwDMT5FrP4ZvAH
 Ob/zLrjQ/u+q46k/sMN6UOKn8V6bgtirJpj438iPkW4EWyh/rJfyl+y83LQ+56XM2mJu+GAlo8C
 eHFPui0DGlq2bGHUeLPd3l9rYmlSSJ35gKQkZbTgURe7IH7WzVKwIiQ5gF7QgO86/nBKVsZajnR
 AgeW7ORzaTEq7aY37SHftVTdkkNAtpTOY6UBcNg+p9UZFC71e74D4wn2mtkilQkYLz2APDGkrQ1
 oHZH6RRq1n+6rDhK38g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NCBTYWx0ZWRfX11Qtm2Tdl8Kk
 VX7lkpzUBoftIh7469gp3GcomCrpv5YzuPVLDxjf8Q8JzTHB051eZna0QHgc0PvInzqpp6XYiev
 o4o+amYGUVzqt+CAe6RNjblP5xK+/m4=
X-Proofpoint-ORIG-GUID: gZgVrGRV-B8iHocR5MKB6ImZ83QkKOqF
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab811a7 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=tFjpUJO89rSOa1QXy2UA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gZgVrGRV-B8iHocR5MKB6ImZ83QkKOqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260074
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

On Fri, Sep 25, 2026 at 7:20=E2=80=AFPM Jianfeng Liu <liujianfeng1994@gmail=
.com> wrote:
>
> This reverts commit 143755bdabaa96776c24f878014608e9cb44f930.
>
> That commit fixed a dangling reference in the DMABUF_DEBUG default
> and thereby enabled the option - and with it the page-stripping
> sg_table wrapper that dma_buf_map_attachment() hands to importers -
> on every kernel with DEBUG_KERNEL=3Dy, i.e. virtually every distro
> kernel.
>
> drm/msm is broken by the wrapper.  Both of msm's map paths consume
> sg->length and sg_phys() of the attachment sg_table:
> msm_iommu_pagetable_map() for the per-process GPU pagetables, and
> iommu_map_sg() (via iommu_map_sgtable()) for scanout.  The wrapper
> zeroes sg->length and strips the page pointers, so mappings of
> imported dma-bufs silently map nothing, and userspace observes
> arm-smmu translation faults from UCHE, e.g. during hardware video
> decode (clapper, chromium) on Adreno systems:
>
>   gpu fault: ttbr0=3D000000088a889000 iova=3D000000010741c000 dir=3DREAD
>   type=3DTRANSLATION source=3DUCHE
>
> Bisected on a Snapdragon X1E78100 laptop as v7.3-rc3 good,
> v7.3-rc4 bad, culprit 143755bdabaa9.
>
> Switching msm to sg_dma_address()/sg_dma_len() is not a trivial fix
> either: those fields are only valid for sg_tables that msm has
> dma-mapped itself, which native non-MSM_BO_WC objects' sg_tables
> are not, so the conversion needs more work.  The msm maintainer has
> therefore requested restoring the previous default for v7.3, to be
> revisited once msm no longer consumes struct page and sg->length of
> imported sg_tables.

I sent a series[1] to remove the remaining (direct) use of pages for
imported dma-bufs, and remove use of drm_prime_sg_to_page_array() (so
one less caller of the deprecated function).

This on its own won't solve the problems with CONFIG_DMABUF_DEBUG.
There is still the indirect dependency on pages when mapping sgt's.  I
won't have time to work on that until after XDC, so it won't be a v7.3
thing, and _probably_ won't be a v7.4 thing at this point.  But
hopefully I can come up with something for v7.5.  Until then, please
apply this revert.

BR,
-R

[1] https://patchwork.freedesktop.org/series/175045/

> Link: https://lore.kernel.org/linux-arm-msm/20260923074256.9357-1-liujian=
feng1994@gmail.com/
> Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Karl Mehltretter <kmehltretter@gmail.com>
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
>
>  drivers/dma-buf/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index e4f078a326a41..7efc0f0d07126 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -43,7 +43,7 @@ config UDMABUF
>  config DMABUF_DEBUG
>         bool "DMA-BUF debug checks"
>         depends on DMA_SHARED_BUFFER
> -       default y if DEBUG_KERNEL
> +       default y if DEBUG
>         help
>           This option enables additional checks for DMA-BUF importers and
>           exporters. Specifically it validates that importers do not peek=
 at the
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> branch: revert-dmabuf-debug-for-7.3
>
> --
> 2.47.3
>
