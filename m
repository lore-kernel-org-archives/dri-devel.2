Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D5606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IQS9CR5M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EWErBDAV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2680310ECB3;
	Mon,  2 Nov 2026 10:28:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B90510ECB3
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:27:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29ALVt2880827
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 10:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aFnKrPahxdZItDKPsTLjlGEt
 tL3SSieVGxwpz1WB970=; b=IQS9CR5MACBtEgzZAUwsfGRBNBndxkNx3KxtN6wm
 nzzvUcIrtUWoZvfcz3lxaYoP5z5E4WOVGKw0KnNu5YhODMOCSigK2z5aMtyHE0hw
 jqrLaWGw2rDer9HWBxd2jxzGDhVKIroDzLBFKC7zqFirq8Yb3olkEKcnDVGceYF9
 KvYb9X39CWKCSSzJvDR0P89H8z7B1u6VcSr79w5h4saFPpqcsn7KbWkNTquDE1pg
 tSWKlwBZIbXAis3zBL4sSsFRdZutqQX9A0ZhyS2sI4H7/jPqDtjlp6L5cceWD+Ct
 vHiAnUr9ZXL48/gen198v/P7GlTJySX85vXo03VDCyWR8Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrgc8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:27:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c7cb9e267so32045306d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793615274; x=1794220074;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aFnKrPahxdZItDKPsTLjlGEttL3SSieVGxwpz1WB970=;
 b=EWErBDAVsH/HQxtCKP0GLgm3OuszoWH6fJd+gtfUHxvWDUmPkMgQnlG4EaGz+jB8ze
 NSLoOsa+IpU+O0Kynh//hCZggOCQ9uxt9DGsqmVmim41xt/64pTsrD//VeRgvBUkB3c2
 5ggpamlp3o1gdV+6urfc/ZAdj7W2PZhKQ5mn7AyFf+jqK88aYDbk/YKaJDkvmUJMfDub
 VGZk/+7c+GZ4SNItASWT14to7Ga3OCu/xGMH1Zrxj/WAXxMmZCjlDm3sDbXbHKLIsqkn
 ADpMrI/kM1plfzttn+HPC5K8/CjcWBsa5mH5NVUJmK7uhuBs7RIAyfNLCOh09ejtaqfw
 qLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615274; x=1794220074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aFnKrPahxdZItDKPsTLjlGEttL3SSieVGxwpz1WB970=;
 b=G9TEkszayzoqurNo4iWCiKh/s7GgkyE81KVJCYHsYIiZFDK6Li7j0c+B8kSRDXXi3o
 V1CSLXt0X/i1D36Zs74EghDTbx89DXD9r/Jz85jE8OckJhUY9lh0Gl2D7DD6jjmYHvZw
 PqBKri7fQwRylyAD+PaE1eUH+4Zck7uOGHoiZnpT7SYikVDS95l57cungQtFU36291jm
 RFKU1nhz+6zsjVTcn+ANHg/Shjz22Al+WacEXXDlQU/b5VTXAWXfVXXgkh/o2XuieyD9
 ru81AsIl5IZbXjP0Raa8Fc7nFsoBB2inoFQLKSk1nEd9VSO3HyiTl4PpZwG/MFncKurN
 BYhA==
X-Gm-Message-State: AFq9FYJQqPWVaJuB+NjxBc2K6dfdcGRAQKEqNuQoT0oT8AzC9WYyz2yi
 Q8E+r1vv4WysneNv/D6cd0QLYO2LzOWr2m3Qh4KC/yGBAhCOXOiP02RuBITyqAaVYi1nTxHR+8O
 20BmYsIVZQb5pJl4hCwyU7Ox39yOiPJLZKMdSccnx9RkSKi5Aq4uUJmlGutjD5Jdr9z+83gk=
X-Gm-Gg: AYBFou3d6gMx8cRdjNu4Rbn6KktKkQHpoTde2rIt3ee+LAu6tvbaA2mGyEfTx5Ttsr8
 ZYj0i5LSK/EsgcmENne5yAtxjWXHURXQt5E7iunP+KvIQV3fK43RFCfYlJgySepA1FI4BcxkHNv
 aZozz0fQjdca34mraCLfcJY5CWiTA3z3DOQn/SfflJ/mrZhGaS2U0stFN52Gc4fVndwXxShqu12
 fm5qOeh8iTOmpbjAh7P9PvVwE52m46E3eav5FBk0/quRdc7NCnoMTL8Da3gG0qZVVQQotC1Fbhd
 uLHggdVT25HRy58ZtNOtPOKGjzm/0bvGFEQoz6CjJlLAG/g0fvhVwtJYALFyd+unOT2Oy+mh34k
 fezgiTDq7eM7mCS3zPvMuU7fsJ+zF88MN9FznD62RzrM04K6SoURATT3Rh+kuYPyfHqWdNJ1bkg
 8DyWsyhFRNKyJXflzPuKxR0OtYSX23i3fmncG16Xg/FUWYDMt+5knsP9ifbMHH
X-Received: by 2002:a05:620a:458c:b0:93f:102:566 with SMTP id
 af79cd13be357-9442178cd46mr1656685785a.67.1793615274501; 
 Mon, 02 Nov 2026 02:27:54 -0800 (PST)
X-Received: by 2002:a05:620a:458c:b0:93f:102:566 with SMTP id
 af79cd13be357-9442178cd46mr1656684185a.67.1793615274078; 
 Mon, 02 Nov 2026 02:27:54 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0721784sm1677022e87.22.2026.11.02.02.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:27:52 -0800 (PST)
Date: Mon, 2 Nov 2026 12:27:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
Message-ID: <425xxjrsglh7hzenjwogtxto3xyn46zdm7mzfrrvonyichqv6m@72f4nygmedgy>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae865ab cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=chFjt-TYfWtG2qqLwSIA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: t-hx1NuW8HmlJzmA85yBcoLl2cKscORs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX5mkp0bhuRlbp
 8+qBf3M0eaxGwfOmiSTKE+3AaGm6TbxEAWraMkjPo7aZBKglZw6k9mgf2XVnMDfTidRmE/YWoUS
 NiI1agCezZmPLUSjA9fkLiVYROixgc8=
X-Proofpoint-ORIG-GUID: t-hx1NuW8HmlJzmA85yBcoLl2cKscORs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfXwHXO8X/DiDtk
 hO3kHx/UpiRKso0TefaRBsbPOOBMj0JMduZn2AeBpnM0sdavCdazOGYlv9s4sZQI1jsHTtQJI5b
 3fyNG85fTrUyg5gq7WbD9XpFdrEW2+M4TQYPKw6pqnr1jXLDT+RktUR/dst332KEME2fWeM8Dj+
 1NxEYCp5Jb3pvu8A+H5ZYGPA4R1TzPUH+CkCAlTJtTwyVi1tc0TR7RCgZ3ErhKFjSbKrE21ZNxJ
 kRbl+4L7DFH+mzkTOy5ywCoSfvDcDbDMIlK16/+0rGluF0II76M6RR3o/4BmQUZn9dLC+f9qBrW
 6/p6KuhMui11xj77VpsHE5ms+mEAu5a9QvXpCN72j6geu8TVB514ZSH6D3VsjxBQ9xCX0Eq+scG
 xjkcMVN+lOMuQQ2HUjfFrnbA9M5q6Zm2JkrJbUsc/4AyVR8YkpnkJPkBarmS16MHMVH28Do8/Vv
 ri1U2qCcvxODfvonCPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020041
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 09:49:09AM -0800, Rob Clark wrote:
> Use size_add() to guard against overflow.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
