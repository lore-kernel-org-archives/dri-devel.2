Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90902CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DB610ED58;
	Mon,  8 Jun 2026 06:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XOuYTKdD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBfoOK4t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F9C10ED57
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:11:14 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580GlJp1933588
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zl/gOSwq/zJx2zMCoSWpfKLD
 oa29+U0nv8eXcgWpFDc=; b=XOuYTKdDQILkohl4FW7OdfjqMyyh201CrXzLPbby
 bIx0NgRKEC1GIerHteRUryoPmC9MLffwm6AXzvCdEJGB0UonbMGnZKLQwonkRq9C
 koCsPYjRSB45vMI51K+BW1c2P+4yJyBEPZMoikPkrz70XBvaLN1g+BTUa239rK60
 b4mBuRm0NQP4Gx9ZdkWC0SVOp9L5Lc026Wm7orpE334ycotsevx+mNTggrzFsOUo
 oueBTEPpBiVCy4dAPRk73RPVzQCYsNdrj6YZ8kNPF3yFAdDmLCcovl7fVhgA2Ro0
 slcqFisG0oLu3rxhd94j6TLNlDiHrEE09+dhCVoy4fmX7g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf6arc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:11:13 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963eeb6f2baso4182353241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780899073; x=1781503873;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zl/gOSwq/zJx2zMCoSWpfKLDoa29+U0nv8eXcgWpFDc=;
 b=OBfoOK4tstW73CDsGvBFjMWupHmzy5A7GbwJUTL6gzKW4xpxF1dL6AEjhDqZtdctcg
 CbDk9jOwnRfqoYfPuoU6e1fqHTO6+a4M2N2em06CpFITK5oE62vfRuE2SLiMmk+hLH/t
 a5iiJvvr0IVhN+UN/ab1EG6hzj3ZFh+rzqAT8cc8VLtgauL4huCGEPUdiFS7iqi3scGk
 /9jL3h2yStE6xe2dSbFsB0VJet/6L1tBFSbN11IBPujCOSncjlfVx9rZoT3zdrHY/hN5
 iBDzRNT5BeCH1/eeOmxJHVbLJDxUB0ei7AUbIZ6zj3lkFnLeZW5d9v+oMQ6VrWVfzqXZ
 Kqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780899073; x=1781503873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zl/gOSwq/zJx2zMCoSWpfKLDoa29+U0nv8eXcgWpFDc=;
 b=b3ifBSqmDFPSpsg8t3CbC1MxAe7xEsRKLWO9EDY3eLqJFYI9ANYnupYW/dFNANp/FT
 kgJZ7eqW5tkEcLwXfkKFQKE0u63oAuI+IuKatPnZcL2bHSZ9DPVxm/wB1aq69XDrSjyZ
 z0UOX/cNI+8xgO6iQK91yClQSzO3OMbzkXnpTNGEN8s69Nc2e14n26WUTmqtVQqPXytX
 tORWXkyCbUULY0m7DcqWxHBFOW8nRK7CrFT4WKa+fggC92g/i7gPErMzyA7VNe1GwF0P
 XhzlVmxkHwj6vvZyaQS5uraKgAr5zzRRKdgngFGY2ccOKzHRMpcMfa8y3aqi28HoER5/
 XvCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7IuoC2DaQun5XYkbjX9iTOpYkHxSicZO8YLvmmgmihR8ttPr+VsZs4MSXKGnDgcZegS/7EzuoOHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ3LM/pbZuWgketge+uVImLdxG0RdgGOyN7HgVsFwvOXhyf15D
 AbFDqxUwpNOjdy9lC2Zjc2M7p94ZdCsBF1P+ww9qvO5/C2ejeYdpbzsR9uxve8j/TN1TBDSRBG4
 ii7Ps0ASUxk/AK24ILdoYKyZBb4ctUhGGlUpkFMypzW8/NS3o9O/QZq+qh2feblUPC0i4QC0=
X-Gm-Gg: Acq92OFlJCyRCIPzMqEO3Nt2Ep3qEf8TSyBv197UdhlzLLNiZcu2jp+u0svDU/RWvQa
 aFQVdwuJuQ5+138DYN+QIPMT4lXLecx02FkRn9ndGxYJkIbnFAH16S5CUP/OM8+StueVpj3zQmp
 ULH52jlCqJPHlOHUzT1kZMitZF+ePC0ue5EiwCyFIis7kqU12JIUnwC8IzGWVOws/PQkK5FBSjW
 7rsz/m/g7mFDSEUjXBkndy+50BNGWgvThKBSFkddoY0LoI4jfm87s9D1r2q+tSM5oEVhsk0P/Dw
 gPJdpY13B5Y54eFWNNwDGDN9xjpjQgqhZd/xhU7eieATYYOJkXtnYI//JXgJcSGxo4bvVxYytW7
 fmKw3sI9+p6lL3YXOCvo3vhpSqYhTuaHsN6UWtCMEFyNmNfuOf/gH84Vbn0JAHqHIsyFO9sQilz
 lHbmGYn/3Loz1o0DAlVlXQdVzBcxU55maX0QB1bfenqIaJuw==
X-Received: by 2002:a05:6102:8001:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-6feff813ee1mr6808970137.10.1780899073255; 
 Sun, 07 Jun 2026 23:11:13 -0700 (PDT)
X-Received: by 2002:a05:6102:8001:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-6feff813ee1mr6808964137.10.1780899072865; 
 Sun, 07 Jun 2026 23:11:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8ed2adsm3559059e87.1.2026.06.07.23.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:11:11 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:11:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
Message-ID: <bcm2eufawifaq65i5qlqmbam4wtv2du5re6c54tiamdbynmras@lbfd44kjb6da>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-4-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071750.526-4-jianping.li@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a265d01 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=t-0ExjSqTYZ73aSqprYA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: IuSkeTIJY1gjnAkivwgdg51e_4kTTlXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1NCBTYWx0ZWRfXyj0prMjNSfbh
 J4xoFPOq5lRvIuTwdEjKhH/IbcqsQrbj+BHl5zT3/82QryGbGYPmnnC7zleOWVW19PpBj0jCkkw
 JKO/9sRH3Zkwz4KXsP/CYruE28RsEhkMIwvdhlPSODzjkVOavplu++L0ddlhQUfh25aAXmVDRVI
 ue3qerWbTD2KG/UX5fOWKWHTR02adShKvvgYKTp4Y+8rvLVlZSR3soX9YnuohdJFN7R0SFNL6IS
 3+DbSjnsWRLRISIWbiy5XYU3cqZY7C3lPGgy8GiH1ZTnQR+UvC5HkUCODipXFrIVNBiAcob+pPY
 PRXkjs5QY9qg8uKmwDua4/b/irp6sg5tysINn9dRf0GKv+ALylwiaSNz++tAYnc11/bm7GcnxA0
 p5aZXYR9Af4JComM+i3CO1P23gPuUWhuea9L46Po5hSmiG89zh/wz7O5K/6vSTTYpUFMAlARKRe
 G36AOPN9cm1JZJtHN4Q==
X-Proofpoint-GUID: IuSkeTIJY1gjnAkivwgdg51e_4kTTlXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080054
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

On Tue, Jun 02, 2026 at 03:17:48PM +0800, Jianping Li wrote:
> Audio PD static process creation assumes that a reserved-memory
> region is defined in DT and exposed via cctx->remote_heap.
> 
> If reserved-memory is missing or incomplete, the driver may pass
> invalid address/size information to the DSP, leading to undefined
> behavior or crashes.
> 
> Add explicit validation for remote_heap presence and size before
> sending the memory to DSP, and fail early if the configuration is
> invalid.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a8a58f889d07..f46a8f53970d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1354,6 +1354,13 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	} inbuf;
>  	u32 sc;
>  
> +	if (!fl->cctx->remote_heap ||
> +	    !fl->cctx->remote_heap->dma_addr ||
> +	    !fl->cctx->remote_heap->size) {
> +		err = -ENOMEM;
> +		dev_dbg(fl->sctx->dev, "remote heap memory region is not added\n");
> +		return err;
> +	}

Won't this check without the next commit break the kernel? I don't see
where else the remote heap is being allocated.

>  	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>  	if (!args)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
