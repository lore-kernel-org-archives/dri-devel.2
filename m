Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B17CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DA310E34E;
	Mon, 12 Oct 2026 12:30:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1067810F078
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:30:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC091h3292333
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=e0yYPVIKMmnK9rTXk1h7BEsH
 GLRAY3pbRSFJzuzDlBQ=; b=GFrGlgPTPBFwYT3nhbJPmE3dcVIoCq37LB36kKb9
 8zWXD9iu+3iL+xBAPAOwncIHJScQX0RwOubckj3WlTA3XoHcvSvhZGi31k25oxp9
 EthtTvq38SgJROc84nYFblFiA1db+uNiEZe7fOfmstqSz3bbQq6+L48sE9WragHn
 P75oHsE2vgNiLS9+ZvX/HWSPZ+MwoM2VpvZnuSdVIa7pfMCNUcOjlr9PE5jys/tN
 VXwr9BXgNinf5DG4so5PPzI1L7fOURdgO3icrAZRtIj0rtFFc4TFqrYBkxAP9Yx7
 FGpkQ+X2hkH34sv2i12UOGAiM7tzG+rQjemhUD+TKDU5Ag==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3ha4f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:30:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc359d9easo318060885a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791808243; x=1792413043;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0yYPVIKMmnK9rTXk1h7BEsHGLRAY3pbRSFJzuzDlBQ=;
 b=NMxLqYx8OzIOjWVwfkWnWgaAOPmqn5+/GpmDVgjvUqtZYxRPz5Fz71uE0bt1V9stmx
 mluq6ZCHt8vXa8HBzgxjZNeeI2urkrZhXbKt6r1mDry4/w8sI1n8wp4C2QeBkI/mG/Li
 YiH62Abz/qTM1RFDXyvBLWCfYqwVNvcVqEyhpuBjWMnPaUGSIUNRbsFqZDGCgXETgIoN
 JFb/I0FKKDJEeUczcX5FNiRLTSgwwrFryR822l5p3TXPHkPctzr2FTztS9IkpKilBice
 BxPApMglW0oySPVKOtiGgS6hpx4eRKi8TCwWZwIr/B09dgw98649mSRPigDCp2EiXjRt
 TIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808243; x=1792413043;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0yYPVIKMmnK9rTXk1h7BEsHGLRAY3pbRSFJzuzDlBQ=;
 b=EhqykY29x6+d5I7Qk9eW2Cje2CLlTAE0x8p9SgHhFE8RSeezZ/b6agBjhy4KZdDHrr
 KX8sIJjHM9grqn6zZaXgmzcsXJbhBZlZOquGvYYdITXaiClUTJ9nca/CIk4dTGs/S+ls
 O5151HhIg0LvpjsdYM9edmjeRpiKE6m7P6GDwn+AyAAt6Qei+uNN+cb0DWsTahW7Agzx
 XlYZ/uk78aWX0R1bgUrF/FzdWZlFnXbuWJE3UVGIHvcuF/f01/nZTS2arSpDPdAwuTkI
 c980EJm6WR6zKvFHgNmM1v9tT7CyqQuxqej4n7OLg3KPD+Zk0GZOl3PWXfLZMTzlT15v
 047A==
X-Gm-Message-State: AFq9FYKoDVY+r8o07b8ix8v+uBpkR2PGuvW79no33tMr3CgiTrqDs/o1
 oBjDunoALbHpdLjIBZHtKrTxVJ0hImsqH1OlvAIIaTWfQsNaApOafJPcOWSlOfHTZhM30yq8H0l
 t5Tx+VTw1Ktpt3kmEWCXplVrOQQenEVNW/c4a6TD+F43iTNjCw6UKHjkci5X003rFYF5QyxU=
X-Gm-Gg: AYBFou1t9OspouSM0nJP3khXFGjBDWFxEl9un/w60uDWW9x296QYkekgpvKibfHd1h3
 Bk2/x8RaVkFLVrCYbbiNpURSgLh//m/N57kEI56x54y69y290DzdHO+RxxyPPzx9lzOgooOqewx
 tOJ72lqkAFs+ZF2vmAY51vQ+dgrp5mZNrfpc0JWI7OuMTZE5CJ18N1r6L9OzrVzRaf9W/IEN4tD
 0pCJf7zdxmrB/VT1Fw532ZNMYD8CoKWtu630XspnwXH3Vr4QPIJMrCWW7e35ieIwru276uXr87+
 TDIjPMiZs32GSw/CwQhy36UBxovy5FaaO3mH4Q9Lv29D5y6mlqdHeF7cM8NYo8NsWMIGjqUYMc4
 SF6moQZuXfXIb/n8uE7DRvaWjUtEbT1JexOc0yPFQijcmIovVOeVVTZCYqNDiB1h3vbeVJ+Dk9z
 JYIJfHYkmI4RUV
X-Received: by 2002:a05:620a:890d:b0:93e:9627:533c with SMTP id
 af79cd13be357-93ebd265157mr1462917785a.50.1791808243304; 
 Mon, 12 Oct 2026 05:30:43 -0700 (PDT)
X-Received: by 2002:a05:620a:890d:b0:93e:9627:533c with SMTP id
 af79cd13be357-93ebd265157mr1462912085a.50.1791808242582; 
 Mon, 12 Oct 2026 05:30:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde912b3sm2766910e87.21.2026.10.12.05.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:30:41 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:30:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drm/msm/a6xx: Move a702/a704 to a6xx list
Message-ID: <ggwbnf4yr6f2pguzu444akwt5fdl2cwk77ovhc5ihnahnc24yf@ohnqcwyo5pb6>
References: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
 <20261010154125.726149-2-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010154125.726149-2-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfXzsijN65hayUR
 k4XII97+I67uGK7SDoYhzf8d/IN5IW1K4/qrTOMeqjfSX6vNBnEbWdTiTVuemj0ymqlMePSbxy4
 QE2IJKmSihMhW3MBe3mUOKae+SdxA4rwuhMtd0GghVNg6Fy2CV7x8ZSlwO33UP0wmmzUs8wNHVa
 ZtK2QPWUhHDiVYvNB3g0QibfpPL47AQa0Dg4ENyx7tlcvBPo0WUPLf36uqVVfH5BArUjPBt9qtq
 1m7Kea0iSrOkcmYdC7ukivJK3hPLtKUxYEMRiQVP66wOa7DaV8zxHX7MVpneu+5J1pEwkE9UL9c
 bUz8NVDtRH6w6ZakqTXQOBkb9FR2EkusJ9HFkZ//uk2aZet6MluIKZUy0EFK37zFBWrcqyCrS1t
 X+LAScr0yEmX3vM1hPti7g9OgFmTuMkmBPjPqwfFKZD8Skeq9k9mYs7qJ4WkO+G3PdWG7F/vCZn
 coOXup8cenOxiWc+k8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfXyYp1MMKJaizr
 1ZGAAWVqdfv+Q6oqDVrN929xvvwsU2lGyhVNP9yfIdeqylFp4Ks1ahf8aOcwF3H4sP1mvsOkmIt
 wZdDGiZXGp2Oq5h+IxqQZo5WePrzsoQ=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6accd2f4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-2mmMjQWwNZ6YRhNbUMA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: OM1dHZItKa4KbY-gBMfTVzlyxdYQyZJo
X-Proofpoint-GUID: OM1dHZItKa4KbY-gBMfTVzlyxdYQyZJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120049
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

On Sat, Oct 10, 2026 at 08:41:19AM -0700, Rob Clark wrote:
> It is a bit more a6xx than a7xx, and this simplifies the next patch.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 168 +++++++++++-----------
>  1 file changed, 84 insertions(+), 84 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
