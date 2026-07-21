Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35200C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A6E10EB15;
	Tue, 21 Jul 2026 18:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="opjV8clX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bbZYKmA+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490F310E3BF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:42:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2bM02160257
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XxgIPt4uIKTpJH4ljRKs75ea
 ji3gER7/Fq9oXA0nBdo=; b=opjV8clXLOL0QZpRZ+/bFbjrIAApYEvrzR7E6Xe2
 ixLtkAIGosyJkCJDa+pbdqIFMVHOoauJtd2j/ygxL2vvAn0oP4oKMRiQXGVduTDm
 FcPA7GGBLELmQnS+MeHYcNW0Dr1HgwpKSyeh6sEnFPmk3NpB8SQkkHss+vf+CR6C
 YXRQ8WyWgGgypPe78CvuCtCqTLOB5fZrWXj7iHpCkZMDE1r4NKPq3xJNdp2ExRF9
 lzFBbRUqg40SNeCC+XIc8yMOyzpcDy3CXHK0bNwx1HzOSX/3hCU7LvIrUnBPYTMc
 cRNjMQBV/Euz5oSEBNhn+lNmmvOoZdFm5v+DlJVpIjIPCA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9c41md2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:42:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso19989311cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784659369; x=1785264169;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XxgIPt4uIKTpJH4ljRKs75eaji3gER7/Fq9oXA0nBdo=;
 b=bbZYKmA+dyns3bIHblP5Wb5jDeJcy7wsltoMLZZgisn0G4DgNfKCd5YY6dtfdfBTRm
 2JwwmbjqmFkSKH/gQRKaqg8po0c2NnDEK1LTO0RfOwvfMhC8dQZ3KiPY3f5r4Hdyr9wI
 ZLmIVVVvnVxbN1m1ZweV9lTA3JoOYsp3mzyYnJDDUC9soN4cl325XWDWuEdFKjgXvQ1r
 VxpzAVvnCJ0I9M00RT43oLHhiKyfUJ6gXoTgGg1qLA3TrUmK6f6vIiIz7KrOI0/CDlV8
 VEYnc1eRmY1g1BBO91g8FDEGM1ruv1/34xtPUOBZFqS0azGiA/GvRymsiNdGiKH+/AXQ
 pPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659369; x=1785264169;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XxgIPt4uIKTpJH4ljRKs75eaji3gER7/Fq9oXA0nBdo=;
 b=pixCXX6wVr5weoK6pq1EhrcIowJttEnGc75S8VnVgXDk8fQRVZ+R0h65RJGPbhx8Cc
 UbD7fltnndsy/mclUOTjWmwTTNpBK3zVm/5XnsBScrYg5IWPn5bDrfwKQaUwQueHr9q9
 l+fr1+VwRff7Ryed+v3kcykMPuy4sk87aYG26C2QIdJSuJAbsjhNqbY16W6kYWOoaNoG
 bzAxYbhdQYZH/t5t8nXimHEG1Lg6Jnt1r+ymO8Hkpc01wp701Da7heaYpEheabNeyi8d
 ANAKdCxoedUJ5jF7XOcv2+Jwz7EvxMnKa6VDjmFwtOCOe4NnqQNVzWsPFOpEyApL7Mof
 BBZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RowYVWYfWeL50AsJV+U4mijT43ICulxq5J5h9nazr7QjGM0aN+CVb7YsuucfbDJ/rmF70nUg9qrs+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxD6phYL3o/H2+vRP09iUSdz+h0Ans2D4Uz3xiPR277uyuIk1lt
 gG2JFDrEP1p7poU429pD/uv6HtdKg81SlKvsSA+cLcQD3sWfVmmemwI+0TomPOQZMolBslCw+6L
 Xk0PWcr65h5I2STcj4m5K5LK9fzxrp3Ps+fXe0X8IegjG2Ravul9XhBsmBD41RZq78pFWDRM=
X-Gm-Gg: AfdE7cnueqT2baJeiN9iu/HcR8z0cNNa39apk0k7qLg0IeCto69F3r68ycRfOVUVBgX
 9yt6jt748YAJvxbV1LBfTDh0LzfYil6IcAECMDH/AZB8OPbx/ICYoEcJFvBpZ617IeU7iZ6L6ET
 Dq28NXb3kSFELRDTdKCDM4y8xZvD5pE9dYdL8euVYePoPqxirMoZKKX8S6LbJuXGVr0nQTY0Krt
 WCMDk64+SRfz7ugCnyi4g+0YpvZ+DlafBtTQ3KEcbwzVIDLD+GQGwgYZCqme7COrLVVNY4CyZYp
 Wynp6uZAIxHfb8eSw3UoBPDTYP5a9Riayf2h/ukCYgJ6NS5Eq1wyvW5wtylkB/XW2SuHsVFtWr/
 7sqPRVaYnFg5B7ltq27lsutObFdx8zXHVLoKi/5GG6Y/ULwAOqvMsWUzi6+EKUOJ/0Pok2C99Ic
 +iQdPZohfniE0o9g==
X-Received: by 2002:ac8:5e4e:0:b0:51c:1a17:eb92 with SMTP id
 d75a77b69052e-5213e886198mr177989221cf.63.1784659369316; 
 Tue, 21 Jul 2026 11:42:49 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:51c:1a17:eb92 with SMTP id
 d75a77b69052e-5213e886198mr177988851cf.63.1784659368825; 
 Tue, 21 Jul 2026 11:42:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9ba342esm71324e87.27.2026.07.21.11.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:42:46 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:42:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v8 00/15] drm/msm/dp: Prerequisite cleanup for upcoming
 MST support
Message-ID: <holysetuq67usmwr2ueyqhh4rim373g3kmxdpaatymhqu24c2o@addzr5eufp2i>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a5fbdaa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=M23Z6b5qFLN2yysIzvQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: qWSsI67IWrfL7le0PakgnxH5qn3M_hYQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX5hHcCwSjevi6
 8HG2Ag7kd6fPUiuH1fFK0l05Xyttr3UVPLJY6imAYUcv9lk7iKBuRE0pUXiNtzoOVOEepSth3KX
 wo37QTZ/E8SrW2nvpHFOjzO+hWd+MW3kTmwOL9sWVr7lT7oTh53Ei/viEhHdrnHvtjJ5kOlCxZc
 OTl7aumCNg8cMsDByrD5BB4M5qK6BRXfMFgSSY2GEdidm3MisBHi4CyBqmVh691axkGvJqH3cm7
 LYIreC8+d2ywPmejdvefNoWK/QmFNu+blzJqz9fmhZ9dwqmT+bsIe3ezeLENPiTh7Ah/6AgYz5A
 qpd2mJiYHwMxgUF7/YH45Nj6yp2ehekctnhfw4Gpl9wio+jl6qoXa14nNuhJ7YTQl8rTlLCEvQH
 zTsHegI+xTbmdivw7VFUL311Yu1gAnJe2WKnZgki68OC6dnKQyprPoQQnmnxuK3qGQ1geXj8MJQ
 Z53gGWQ7npiog6zy53A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX9DiC9k917Nsr
 JfGkjqN3sFagihL9i+FpXg/US+Ul4w0D8x4a4jk2ikjFq4ypP4sZR4AEhEeokysCd0n5gjoM329
 jK+9Uw7jT4Qehcw8NeTsBUH0obsNJfw=
X-Proofpoint-GUID: qWSsI67IWrfL7le0PakgnxH5qn3M_hYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210196
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

On Mon, Jul 20, 2026 at 02:08:07PM +0800, Yongxing Mou wrote:
> This series is the SST-only prerequisite portion of the MSM DP MST
> work. It refactors the existing DP code paths so that MST can
> plug in cleanly in a follow-up series, without bundling the cleanup
> with MST functionality in the same submission.
> 
> SST behaviour is preserved end-to-end; no new functionality is added
> here. The intent is to land these refactors first to keep the
> follow-up MST series focused, smaller, and easier to review.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Changes in v8:
> - Rebase to next-20260717.
> - Fix comments from sashiko-bot.

Which comments? In future please describe your changes. (and please
update this entry if this gets reposted for any other reason).

> - Link to v7: https://lore.kernel.org/r/20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com
> 

-- 
With best wishes
Dmitry
