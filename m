Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751C0CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00BB10F609;
	Thu,  1 Oct 2026 10:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NE+p73bP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C20vgHDp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D244610E349
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:33:03 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xbuj962499
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=z+fRcNyFokIOP6C2JoqZvYe6
 PNaD5BlV3HutyAbAUA4=; b=NE+p73bPN3ahQPGdIi5YY5hyFQ38Ob4Ba70MnpBa
 cgNW44UkH6vzVqdajHLjAeii2LDUhmWSJ3wRttKId+OEvJGTAnjz8teTffNhoHbr
 vWJnUH3+M5Gfnd75ULtX/QjNhmAGDeM95iLyM7PocPcVGCTSX9aE4rjUIbBZE00c
 hstLQisITl8lErsQDpMJ8msWZ9vAlfxSWNBv068rjBrt+HmDVR6KFE8nS6lBrA4b
 50ATa2Sv1NbKsKs7FT7OH9LS/63lPG5GVZTjpi6FoyZKDbVe30we+5UjqgUOon2x
 khmPUdweZdqOTUmvbAcwvvobXlh8fdmW8XnoAQeh6JXHxw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcupxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:33:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so323856985a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790850782; x=1791455582;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z+fRcNyFokIOP6C2JoqZvYe6PNaD5BlV3HutyAbAUA4=;
 b=C20vgHDptnx2GddmPvVvNYFnivfeLV1FN/UtBeO2g4AoJGeBQ9YWpVyloZUjulaMSl
 iwsZaWAReSlIci0oyUU/mxoTTKBRRM4/HTUR3+Ss0JKYRvhB316fbQ/GzV+nW+P49ylb
 bntdyRHFoy8aYDfslfbxvpRv9+fxvIRPf4Z1ZBEMFV+5a7O2pOgaIgKg3TOhJsPRaq0R
 rVGKL7p3/0zwatrVz2gFvajiTf3105Veg5FDqiNu/KJSy9t9JYohuGA1NkUgekZgLWi4
 /4SYrJNCiiC7xmwNDk24GCnucqowZCTLphuMj9KzLlMymwr5akvGvEPfOAei56Cs/jeJ
 AX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850782; x=1791455582;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+fRcNyFokIOP6C2JoqZvYe6PNaD5BlV3HutyAbAUA4=;
 b=RO01P+RlBtk7UDHppM+kfzHaq69AePUUoI8PvtRdC92qwGZT/y07cV8EShkFC+0SKr
 lo3L8KKi+a04BHYnmLb/bEtgWEpYfl7CvllDu4LNoOxn5GC3WD05zH8RaqOAts3D+1iU
 n9SSp+YZrXw+4kuGfIrPZ94xRQVlj4TI36yr67DwnGSfLBKcsSfLP8EmEOemJV3jxR4L
 WAz/LiWUckeHZXYqVnTC7oIUJQkDOBhzK2/NmoRDemP2PLd1FRjVFhvK6nM4OB6hO1n8
 qRa86iyZJEcGd447zyFlkuc8+5XttUYEt5M2b3zt/q2uO9gYcgD5huBLF6OSTJ5sNkkZ
 rYqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5i8756Bg0Q7Tvk39rgV3bT+7R6VjOKyqF8k3ZkizbeN9JGdRDjeH0Dq+5/TDEGhIFZUDYspE77WU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0G4OS4UIOjV4KLJSttQLbGMv4phY2PHobvT0kUme/HfSfUC5M
 1j652OkMCBhVDK//Ihzvf2FnE/MqzWtZntRuPDhJsnTHnNK18N1vJ0mX09H52k/JIw8zc0/95uK
 Uy0I6noq0X5J0JfEUJLhA2bJkorqvYjMrCltdK8L69gJ+RuMexMwbqKq5la0bW+m50iGXOnw=
X-Gm-Gg: AYBFou0ejDzdSIjCxZi6wqiIqb5JgufNg6/MS+tHkOegpTVp8DPjYS+XZZj32tzYxFR
 RDD60L67BMtSzrKyaAtijnv7Z+Ywr4tcNfSnMBf3Nf75cNpL8bU3bXg37imvjzUdU2sqRN53CnJ
 mEGee0Q4R2j2A5bOY+guHL6z0TuO55sCDMp9C4K86dZYLhfeUe1YmxMO3Kah9BluU/3ImPayjoj
 BsaRRAEfF6p163Y1Z6rbaWuFbi+eXOA9bSI1wFvaqo5uZapmKqz9zXuZdTTuxZrAxQukhOKsqe3
 94uk1yN10XtncB5wTL1kaY7v8Gw4CBqf6twORYkOtmYjxLKetDscoNxZxpoklkOIFvDVpOObse/
 ckyRD/yLy3dBL+zN3Q1d8+F0neXGgmW+hv/I0jVmn1G+8Jgbf/yuzZ3GWAENu36QbUz+9WyVtGR
 T8GZrHXCPSSfoh
X-Received: by 2002:a05:620a:4153:b0:93b:ca79:3b0b with SMTP id
 af79cd13be357-93ca97a1484mr787790885a.24.1790850782133; 
 Thu, 01 Oct 2026 03:33:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:93b:ca79:3b0b with SMTP id
 af79cd13be357-93ca97a1484mr787785885a.24.1790850781615; 
 Thu, 01 Oct 2026 03:33:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba44059a7esm460736e87.5.2026.10.01.03.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:32:59 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:32:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v7 08/35] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <aolbmfnrk6qkfifib6bmhslaro5z2734ydfip4mnn3go4efpsy@2d4m6nnh7ogv>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfX1dQdjzkNtUft
 g3nbBcDd69QX9GyGMzNnOMWvoSj/EUhZISshyJxjZ09DJhr4uow81t/ZLFMUeYt9mu4x7CJRALP
 OMTQom1uwvkTSHbQ+tjehYBKdmPm+ZIEPZzIHJAEi7/QUgOVSjRJphgBZTUfeA4g4if4oBfQjFQ
 xeS+af4y/IwGvaFSPGFuPg0CbHpA2gcyNCWyokJmCWHjdKT8nX2MoFmwXgOooXXQ0WaEsI0vcnw
 FGF9YnvUnYh3ZnjrMhBxFoskSJI8z+m6TxQlLaTfWCAzRAheVdFFvm2ak/tALsR/dt3hn2D4RUZ
 dePbqNKzd0jSP21CQknwJCRZXr/9zIjdEUx6oZJb/ht9+DDeQtnTobPeNwNNiHHoCI1/GHJpY6c
 eBWjVzMndCjXnNf4VBk6lZ9yM9TTBIK2fxVtoZyk6AaLovuEIihnNFAnF5Pr98VgmttcgfjqXot
 SgJ/Zkc+LN+vHXfEXMQ==
X-Proofpoint-GUID: 4TY5mD2xmXKYg2YcaMJPp-t1UoH50UXD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfX7lZtSr5qjVcE
 RW2HvAEPe+Vd8iqt2DyK7dt7kkBvs5Rzid9dwxhzkoxdvaPVfmXIqXnRT4Kk2Im/mvr43Z+YJJu
 9w2fa4QHYxoxRf+edK1Z02lXuan8dTs=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe36de cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=tbiIBGwOz-cSeEb3_YgA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4TY5mD2xmXKYg2YcaMJPp-t1UoH50UXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010041
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

On Tue, Sep 29, 2026 at 12:25:32PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Whenever virtual channel slot allocation changes, the DP
> source must send the action control trigger sequence to notify
> the sink about the same. This would be applicable during the
> start and stop of the pixel stream. Add the infrastructure
> to be able to send ACT packets for the DP controller when
> operating in MST mode.
> 
> Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
>  5 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index e1614bc49a7c..65d22505c2b6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>  	bool core_clks_on;
>  	bool link_clks_on;
>  	bool stream_clks_on[DP_STREAM_MAX];
> +	bool mst_active;

I really don't like the idea of having this flag in two locations. Here
and in the msm_dp_display_private. Can we have it in one place only?

>  };
>  

[...]

>  
>  static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 83117e7619f3..472429d09200 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -19,6 +19,7 @@ struct msm_dp {
>  	struct drm_bridge *bridge;
>  	bool audio_enabled;
>  	bool power_on;
> +	bool mst_active;
>  	unsigned int connector_type;
>  	bool is_edp;
>  

-- 
With best wishes
Dmitry
