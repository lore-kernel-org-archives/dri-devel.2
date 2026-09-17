Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D934C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BEC10E444;
	Thu, 17 Sep 2026 07:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cC351Cz3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFvAYSiS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D8010E444
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:56:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60GqR1924343
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PfClSxRVkrfkzd/aMC38kqBu
 wsc6wodH7g/O5+B060M=; b=cC351Cz3FKnbAmbwF8Valz1+O3Ke711ETI/IspiF
 EV/gAjRy3MflaR3dA98hBp7VpmynY6LvnCUp9tEJd0zGodlV0vvnWp3e8XUHGsxa
 97Shdep2V9woRBLB4X7V+XmbBmWKycVhHPa0xcPmCLu/Noldyxb6h+UcQNNyYiV7
 tjwIQWMYpinQa4pm9Pv2tpBWdY00VvpJ+C/9NE07va0RxsXNwSRmFll8IJ9oh46T
 Vnyaww+Ga7IcftNRYzbMrYl/8IhDwMGQjqDHxQk9jB2Dxd9LUIwl4CYDEFzbQsF3
 XrIvUqsddweiQ733QzZsTURMhp8600BMoFBRp5zRsqIemg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8ua9r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:56:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bd22160bbso21079785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631799; x=1790236599;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PfClSxRVkrfkzd/aMC38kqBuwsc6wodH7g/O5+B060M=;
 b=KFvAYSiSFG2nyMWpqdDpG/8tCZc7wVT73cVaHtqvWYTUhg5jgSaC44lvJakRrcV9q4
 TrK8YGPAxmjZpRdhGmFr6+CjTL55ieRYGOeHvbJjCaUllEBVgcap1TQaqmHeTRq4yZul
 26m7Eb2QUqJyLsRVRxPhqOZbHvubWu4Ug8+i9G42nSWvYsNJcpNXzzrqitEgdJFgcsHl
 eBElQd5rZWuZoVn6l4vrF1hDBkNZZQNjYdlTUOwrzE/+LOnvqhy7GBTQhKEt9iq3r4me
 cPkvoALzzm3X59Xo9H5z2fe3LwGDitMTl0ywyGYC09Vphdx224QNof4E0zEmI5lC6+0f
 c3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631799; x=1790236599;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PfClSxRVkrfkzd/aMC38kqBuwsc6wodH7g/O5+B060M=;
 b=XugNcYDoac9aG/2ShNLG4MokhArMxH/q8VNhLLbPA+h+mMW84R0clixadmvyFdo3xa
 Jujpp8wYqsQ+lnD16ULbtFj6oQvCI5NT/YjI1GJLGf6EC8kIbi/udfVx/xsIwib/j1Of
 LsXZm9valIgzKi+tAdOVJZgN5o8qW5FFjiwmye0vHN/PXy06MZdmIHRh0z4TIre3r+w1
 AVYQWJF3p6YLBdQj2hBzmhWJv5e+/9rw062ZnOz28FGhxT23IRJSxhQ3L8i9DLk8sxXn
 yCDgDeWRJNfNaHIUDC6JEmUWETH4xnFZiyIROYlHT2safREreHGOABAsWdN7aKgRHoRj
 XkFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZiKT9FiAowKCZPQ1YRo+CBGm4qXTO6HpJpjBN83VCggsv0U4hHNUk1GFu3sG1Savb5pDqx467GVM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ncLYYua9+9X//YKNyHjId4mlwGaLub0Lo0Cd/D3yMotCImSAxN
 +tkXV5nA3ppr42DJvst8Gc2hLDSLF2iB+FTVk9iCWOI4K0adiEkFfN/fhwlC7EiHvX7+VeJn94e
 YBzI1Sl6vlRApcuUxJsTq0ecCgwIvKiRyqrt/L1sJNlgZrdwGh5XL5IIoQcPvfoRghF3GVRc=
X-Gm-Gg: AYBFou35751z0te/NoPnMtRaaxhoKHtiypHRS7wowLXVuMgALNsDMonyAWzO/E0xlWo
 PmGwY1vzj9UcaT2hdlE91WNOiXyMMJIO1ArxC79o1rzK8aMoBOqU18FQ7O5HRsYNTkBOnOQF5dZ
 1r2dBmLDOFdTEjGARrWLmMllKxlhZiiAqyjX7Z5JtiILEc37689cY6dqJJEuEHt4Q87SeFmz+Rd
 Dqrrlk+FR+6g5AcFRzP3Cfiy0d5BwUJyF8jL87O+rbGpPbPG3Ig56EZfbNf7CYUB2A1o2nqJInp
 /4bHzJqPu36HR95DXAKj9pRGRIYPquKoeUGG9yiotHdxCB+GLzjQm5Ggk0VbXjMQ+Lx+AlLYhYj
 KK8K1kA3Uz/Xi0KrKaayLeYLPf7ZwTnP/8+KSrqcX8ev22RjeNgC2XBky+TgR/v6yP/0ubjlw4r
 aqSWb0fCYT0I5/
X-Received: by 2002:a05:620a:600b:b0:93b:c45f:9024 with SMTP id
 af79cd13be357-93bc45f915fmr557190785a.7.1789631799328; 
 Thu, 17 Sep 2026 00:56:39 -0700 (PDT)
X-Received: by 2002:a05:620a:600b:b0:93b:c45f:9024 with SMTP id
 af79cd13be357-93bc45f915fmr557188085a.7.1789631798944; 
 Thu, 17 Sep 2026 00:56:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57deda4sm1587200e87.55.2026.09.17.00.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:56:37 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:56:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/29] drm/msm/dp: refactor msm_dp_ctrl_config_msa()
 to take panel
Message-ID: <lo76t74cekbhmigetz5ovb6t7fg2pbvkh5h2pzjbjxmq6lb3e2@f2nhqd4la3w2>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-2-c91d35d6fb9e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-msm-dp-mst-v6-2-c91d35d6fb9e@oss.qualcomm.com>
X-Proofpoint-GUID: F-QT-CFJx-z1MWO4mMj8FAI_nBc042y7
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aab9d38 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=HrO3g0W2lMO92zknuLYA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNiBTYWx0ZWRfX9rk3/Ua4cDPx
 kzL3oRHlgPqLpOz1cFXULpd7v7wQp1L4NgJYGqMOhNkCzP8TQHtfVbyWCxLaaz5xNyQdZCFsIgt
 +H94yEeBYHnAFWJDNf/uZlx8rgLuTws=
X-Proofpoint-ORIG-GUID: F-QT-CFJx-z1MWO4mMj8FAI_nBc042y7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNiBTYWx0ZWRfX0E8jslsNWT2S
 VqT3UhN+rjkUD3rSCUGckUXPYsdYbFjBtznznBxR5y//Ghxy2bVQbFHkjAmzM/60DnoPkme4XwW
 tZefC1pPHXFomIK0FXgG/Gi/j8sA/5fJMcf8JWVZXNdpvDMYKIJ/6JbHhHglYWru8WA3BNPbdoK
 rWgcmmFj5XrHfy51FqrxI5PiKHxmoMFAB5PTidXowDblE/ctEJGuuQHAcgtjiXVC41OJFOuP7nz
 gxDUXzQ6/zUVMwBd9LFPTyRDVWNe2M84peuLCq1ozLc/VGdjbP+zs3K74/mQkGBFo3aQwugTIOe
 jdLx1M8zEovTl9Cte10ccFK6QgTYJzVmVKnPm4XRLng0UbLoeRXtdxnZJ6eJ0feq58rHy/5JIUt
 LgFh1qqjMTnOPIvC1z2zuQBc9xgw90PQ4Ki24KZD7aeY7EyLzC24pgb+VR7P/Enz5DCo/rgfAb/
 PMSxwOomLJlSB1k3UlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170106
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

On Mon, Aug 31, 2026 at 04:17:19PM +0800, Yongxing Mou wrote:
> Replace the (rate, stream_rate_khz, is_ycbcr_420) parameter triple with
> (panel, rate); both values are already derivable from panel->msm_dp_mode.
> 
> This lets config_msa() use panel->stream_id when writing
> SOFTWARE_MVID/NVID for MST streams, added by a later patch.

Please note the difference from other commit messages. Start by
describing the issue or the problem, then continue with the solution.
Yours instead describes the change and then mentions that 'This lets
something to do something'.

Why are we performing this change?

> 
> No functional change.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry
