Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C386F43696
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 18:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B559110EA62;
	Fri, 17 Apr 2026 18:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QVR+d2ym";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BwE3K8cN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3754F10EA62
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:31:06 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4ZSo974928
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zJHWa2uZRpV/rmjTXEG/PvVZ
 8/IZn5LnPOQKv/Tfa3k=; b=QVR+d2ymTJhbZoPBWGqgcN+Xzmxckyz8lwnTEkFl
 YfZ2W1FGTraUKgN7h5WSkHrEXAPFCd66VsdtsKotSAcx1Ix9odFToiSmlK8tbfZ0
 4porw56HNVI30h2IqEcv5Atpf8HQEl8eqEsucs/lg4EEJskwp0I6YH6U+i/ZtOGp
 VnHRlZyBh0FtrEVT7Hx3Jx2bx/hT63kWGdTieeouc/pfi0bvoBc7WUEU6vX5I6RV
 CooIEKO6BirS5tjMe8frlR4oC0js+waHUggUmhK02uF0+B6z1G/3Fu0z9Jfk2kSn
 1MPajWUCvvB4m/1P5mlSouZ+XPx8HF3pm51ivuSF3qp83w==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg7rtf5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:31:05 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-472d903d34eso1582565b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776450664; x=1777055464;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zJHWa2uZRpV/rmjTXEG/PvVZ8/IZn5LnPOQKv/Tfa3k=;
 b=BwE3K8cNBW+2Z3t+tHuEIZGD96QSu+rqHKLMZokKceUu3k4SAl/8gFwGc5ZosS0PIs
 O+37fAnN/56y0aX1MuKvb5cPDcoIliotGObeVsTYQcWJJig3DkNccbIYfQIsCkwJhSXR
 goKW3jloN4GMTMd55Ozvy3ZzsxK+CCYWmNuZH13X9dorsmtuOUfbDvntlfh+T2REug7y
 1WAiCH0ispwF4o4uVfL/7nRsQ1olX4qzeviIO1hpmOlOsETJHwIgnHyl7RDqFh9ADFR8
 sALRpYbhOgalcY8eGWKuZFrZ53mRyAd4piv9Do71UwtZeCOCMQhQKDo0MIR6PFcE8qw+
 nfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776450664; x=1777055464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJHWa2uZRpV/rmjTXEG/PvVZ8/IZn5LnPOQKv/Tfa3k=;
 b=lmXjlzoWL6lLK0itQ186aDvw+9X2ykBhgiLggS51FBxzTxqFOILNWaCVVw0rDP3uIy
 VVhVYxmi3p+jAQ6b4xeQMVu8+fO63XU883Pm5nVradBHP284ZBO6GFH4F1k9DUNB3Hsi
 l8OKYtfAXL0IRpl2CeW/vhbtxFeNZ9lZDUgX7OZYAV2klxGEr8r19FFYBvX5Dl5xYXoG
 XzySYEk6CPPyb2lKozbs2IbFEFfrYPA1Z86Y+WNDsRbwRFhZ5/jebvAZrkrp6FJ+aUrv
 rMNdtQwiZh4Ci+tqPimD4rwQdZEF0suM6wzgYKvhRyUda79GCuDKRfia1vmLU89tAXog
 4ahA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jDLxh5zdTTEMcDupXiPctYamE2Ns2zRZrDOFOZ2Tnejf+ARAG3Zo5vNYJq7Y0we9B79oCadSzBHo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhexuCnDUySl+nK8h4JCUyRZZ7muDlMz9DfVzO4jKTlBWIfIzQ
 z/V1KbfubTwj8JGeU/rDFtZr+J4sk+tXBSw+X2uY4LKrfOzKeA4srPFHQJWOdrEQYndkaOWTtbI
 GEqz0/QPq2e/9BIDLbV9GHIn0epIu4hypwcYQOmjZoX4dIvnaISKD5hdMXx43SlkZ7FEU7io=
X-Gm-Gg: AeBDietsz3VRlRPPpib9Bj8dZgDaEXVpCUgVAaUuj6wUO3P0uH2PCQhpRYxLV48BmSs
 9sT2+X9im4ZhKLjyw4d7GMGZ4HEhA5Wu0dX2xoHwZVZpsCjTmEKpIEf5shV6+FNRVhRf839s8E9
 3ktj4XfKkSMw9Gke3WkgkyYi5f0ncGTDN6BJLQjbyIuU8Q1gcNajVJz9xNkmJsPHkH53ihTesUP
 Vn0EdN2667cE8o9p4oLuHBtYC/LXOzezyc7f/ZDqLhFVXcNd0le/M0PCbl4C7pvqrkmJPSK0zSS
 jPJa4xJ2cNtd6vnQ5D6ShBZNkw/Xst2ZAr9RyXDyWJVNzbcBS4nBzf2t08sZnKSHiGnLrTyvhs2
 IjwQx+jXe5uLE6OadaakrKbA+gQpJatYoYnHnnwAyXQ7IKQpd7+ts9/KJzHfn60kaiHhODUoJvu
 HxArJfq7PHwtsNpApEO4NTVoKfLqbK2fYntiaBg+ic3VG6WA==
X-Received: by 2002:a05:6808:220f:b0:472:cd4c:c36f with SMTP id
 5614622812f47-4799c873bb6mr2096904b6e.3.1776450664453; 
 Fri, 17 Apr 2026 11:31:04 -0700 (PDT)
X-Received: by 2002:a05:6808:220f:b0:472:cd4c:c36f with SMTP id
 5614622812f47-4799c873bb6mr2096860b6e.3.1776450663882; 
 Fri, 17 Apr 2026 11:31:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc333sm629956e87.24.2026.04.17.11.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 11:31:02 -0700 (PDT)
Date: Fri, 17 Apr 2026 21:31:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com
Subject: Re: [PATCH v4 3/4] misc: fastrpc: Allocate entire reserved memory
 for Audio PD in probe
Message-ID: <7rfiwbbunlbzmhdjvsfqccltdx7cveahbgg2rk6kkom2jesta4@nnbas4vn63we>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
 <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: f2-jLSslZc7RvgUXH4aDl37LFcdGnwAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE4NiBTYWx0ZWRfX/af7uub/8aVK
 KRGBo/mioMwEEvxKeE/CKDwvwYinQ5Ckg7vqSlTU72phvUfGIIyzmc57vxk8xg0/S5Y+zXFduQi
 JX4vYULC9ZjylopTO/urgILkXHC83TSjH7j5/ucydw/BgCLj89XYZwdfFs8ovJW4C2DnijE5T0H
 k/64Lpx9SDCuoVuRm/RqmXCNsfPBxYyB2rJb+ud2pqSVh9semqeGWAQzN3VyFAvOc4CimGdKx8B
 cmOR/pcfF/MJem56gVIQyzjustBuLGpF7qFgEdSvkgndB35RZFecs5OjOhGxKS/PBCxAoYPA9K4
 kd7uUuMUIxqWA3layKk24NXetgILYW7pWz8Ou6WCbvdR8PkqxoBJYAOSN9IV304QSTyyGUJ0YMT
 LTItmkiJax04LzeHkXQkylo6NUYYQcXOR6KSfCBBCyotEBba/MNuKkYMgXzcTjUIjq/yc8Y1ea9
 nrLk4me2Sh3bunOF3Pg==
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=69e27c69 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=xL7owM3MNuM7HuHup6QA:9 a=CjuIK1q_8ugA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: f2-jLSslZc7RvgUXH4aDl37LFcdGnwAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170186
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

On Thu, Apr 09, 2026 at 02:26:16PM +0800, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
> controlled alloc/free and ensures memory is reclaimed only when the DSP
> shuts down.
> 
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 104 +++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 148085c3b61a..a67ae991c0b0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>  	struct kref refcount;
>  	/* Flag if dsp attributes are cached */
>  	bool valid_attributes;
> +	/* Flag if audio PD init mem was allocated */
> +	bool audio_init_mem;
>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>  	struct fastrpc_device *secure_fdevice;
>  	struct fastrpc_device *fdevice;
> @@ -1295,15 +1297,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	struct fastrpc_init_create_static init;
>  	struct fastrpc_invoke_args *args;
>  	struct fastrpc_phy_page pages[1];
> +	struct fastrpc_channel_ctx *cctx = fl->cctx;

What was the base for this series? It doesn't apply to linux-next. The
code here is different.

>  	char *name;
>  	int err;
> -	bool scm_done = false;
>  	struct {
>  		int client_id;
>  		u32 namelen;
>  		u32 pageslen;

This struct is way bigger.

>  	} inbuf;
>  	u32 sc;
> +	unsigned long flags;
>  
>  	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>  	if (!args)

-- 
With best wishes
Dmitry
