Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96855CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F134410F60A;
	Thu,  1 Oct 2026 10:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gG6oya37";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpH2kpML";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD7A10F60A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:26:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xJJF2805833
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=btECEzNcIUrnRhydSG297BC0
 t1Sy/7JZkAmu8xyyFo0=; b=gG6oya37F1zEmtdk3v4kdXz16qy2VnDbEy55z8Da
 /fx2fZLwmZUyOqOWTJLOo9RdzaqlDVWb0G1bDXm5NHFH0upJzogdB9rhJb+fEiVC
 aVTPCT1c+Sa5ad7YwyuSqwfKOaKumMH664q47+HQ15bSZiVZU2Yt8qLajzGstwwZ
 +1j/v9+JQDRGcf0q86uvdjfldFlhoO5nXP5a+AoOw6UyamhYkAi6hzxL+3MTGPh2
 /eRQl7sEiZUgdW+ICY4sooOIz2neizcRBgqcWa5NEM5im7GDiA3EVg+YPtLhlZzN
 jA/MEOLAabf22l2s3UJNndVThhpC2AtHEbA7tftx5Hq1tg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkh4tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:26:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939c30aa9a0so676103185a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790850403; x=1791455203;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=btECEzNcIUrnRhydSG297BC0t1Sy/7JZkAmu8xyyFo0=;
 b=LpH2kpMLagU5GK0zIiila12LZ9UIpAkYecTeEXkTlPRWBzVz6H6IwXACuXg5dXQKhd
 kffpkRSdFFKrPcSdxjM5UzWOEUonTl+WN4bdVYxTTFVQwRShrI8+ODMm+6VFkKaLfnaN
 khN+kj05WZOfYFrKTEqV1hAUz+l+IZDhxfrXB9Xs4fOXleVBjkQgQV7gMggofM4DGmiI
 O+gli/DYNIk1KGjb2iDu1S1f0mbDgNufYF4wXegXSCS2U042It1q67QNSsCA5jLkHnkW
 IAhyvfX/AYxs1c7HMFRorflaeJMaBb9xllNYuWLxQpZS29c0ezc8IjZIVtnZuX4lVOl5
 M/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850403; x=1791455203;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=btECEzNcIUrnRhydSG297BC0t1Sy/7JZkAmu8xyyFo0=;
 b=lVFpb/CHsv1iXNUvZjBhPYwQP4cc+ehTa1BCH3//9PEUUMtavjWpnf/dAS2Sd/HJoR
 tGF5ru522FvmPwmgaSjmafDEapmKXO7VXga6LrphvlSzNwzwMS1S9K9cP6HPVlDrfW0C
 0rCkASfgFGMpA//FdIrV02VQCYQbeq4s1frzfLajaITeMVU/wO+xFC+LyrfW3cAyArDB
 arAURCPEqOIY7haxnChvAl74286JZMU+ect/sBVto9rupO0n3u0VL1PKiqrp4L32HVxm
 uFKxLRPewA5o8S2/v86gdcy3wF5GDw8mJPCR4RNNhniGA4ZPAFjW3TiMNykZmv14j0Bd
 ky+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPRKxiRtsE54uTYv5PufmXXqawoGZ51qP7n++GTmI2wNlfJoWhfZ4qJwt6GW/DQJotpc4ug3UE3C4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ny56GgI9odNu35PFl8MJ1DC8gMndTkxZTYq4J9eqwKqv4T0eqo
 H5bi5XDvi0yhJ52eTH9i9IjBcvwClwKtTCqvRl7iZ1ke1sTd7Z+2xRp9cyuHik6QmVvyouGk3YB
 MMr/NLqhdMzS9Q8TO/wH8MCLE8DTEkTOhnH0UeGn/g0BF++7G7eqyUX0fTJM8eVAl94CqwdI=
X-Gm-Gg: AYBFou1qU9ycIw9KGZG6Yumz8T/0+k/mrtc54kmVAWFkLJYCs4DwtM8cCV0d+bWBSkq
 pggzZjtezcA7hEBdJxN2IyJcfVAZy5TKHXftA8iyd6t9+WnWbcJuxpqrPhykj5ag6NlXBfbinXo
 zyMUAvko5ztcscbZTGyTdkyYoBROxoIEprsZw1Cs2Q1jzR0RvjvjqZRvtc+kcQEMHd5O0AuNEOF
 RvRGOBzBha6qZNFRrUzuEtqd5ebL/lL3jdTnYQtr/Ob4d9NMif8J8Z7VvGv1BzzlsFZACiDJM8U
 mseRFmZJrwTTgEH0YYkwkIsfPU494gEOrOHIrtIXVMyYOABue3ogv3b14BkYxbQRPndv9nYbD8U
 VmEjspWpPJstJMtyGMGIgmG3ylmULumoK7DlzhAZvvnmxf+IamiIbDi5f2rRVDq2q1gf/l9DdTk
 E1/SYNdxWm9W8r
X-Received: by 2002:a05:620a:410f:b0:93a:48a:167 with SMTP id
 af79cd13be357-93ca973260fmr782549785a.39.1790850402720; 
 Thu, 01 Oct 2026 03:26:42 -0700 (PDT)
X-Received: by 2002:a05:620a:410f:b0:93a:48a:167 with SMTP id
 af79cd13be357-93ca973260fmr782546685a.39.1790850402160; 
 Thu, 01 Oct 2026 03:26:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fb2970sm652330e87.41.2026.10.01.03.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:26:41 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:26:39 +0300
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
Subject: Re: [PATCH v7 07/35] drm/msm/dp: add stream-aware link register
 accessors
Message-ID: <uifszh5ste2v47fq5rb2ajopdb2tbkjqxvmgcizsl6gial3bdv@qv43p5qqopjx>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-7-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-7-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfXxfbiTYiZQnwa
 ZVwj6i3q9Wg/hfPQKwmU6USuPd2lsmeG72vJUW/zqIHYp8wKTxXL3fMjg0/KgD21yKmrdH1SQUh
 WPqQVJ0P0M2EYpdMEVfcoZ/KDyzDrm0=
X-Proofpoint-ORIG-GUID: aJ5DUtQT7uE9pKGKQx8yLnKOK69Ti77E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfX2Gr9SXPKnSkj
 sG/nGHh6doTnqglvs1dd4ghyY0x3KYR8Zo5DqJ/iLlv4dzGtXL6XZKCZksvNNn4WRiADo+CKZaa
 Ca7dS6YjX2G/3A+7sUio1vEjeaLY9cO1Z+c+WB+zQspJiB25hgH+7571kXtHgDq1TMcIbCsLXcO
 j5wYLDwEVgduVcgGfNA3Whn8zEwgeWUrEzizXLv2wEIVTqnvbu9fvGZyHXVRPiL0u6mhkN5UT4X
 qhYi6x+x1RWyUGXrFnK705n84d/PWoow0sBwpz3m7HmBPQ8fCQpDyFLgcHzHuF5dD7rWekCcsrB
 WRcu91hi65s/xAclAg7R8LhtZKSP59W40mHPoaH9129Ihu3bdcdZJuAxH1W20S+QK+KEx/CIUXz
 QIRmAbW7Oc5CNWm0ogoerWhg7iwjNwFYqBXVEEVNtv7cvHy0RVaJMUmCi86oYVyzAZW4vdfUvk1
 9J08YvY6JiW6spkAB8g==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe3563 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=_HEUNlLEu-QooldpwzgA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aJ5DUtQT7uE9pKGKQx8yLnKOK69Ti77E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
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

On Tue, Sep 29, 2026 at 12:25:31PM +0800, Yongxing Mou wrote:
> DisplayPort MST uses multiple stream-specific register spaces. Streams
> 0 and 1 share the primary link register block with different register
> offsets, while streams 2 and 3 use dedicated MST link register blocks.
> 
> Add stream-aware register access helpers that translate stream-specific
> register offsets and route accesses to the appropriate register space
> based on the stream id.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 64 +++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 37 +++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  2 ++
>  5 files changed, 121 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
