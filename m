Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461F3C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D0210EA39;
	Sun, 13 Sep 2026 21:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSUM0FhH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMUtJO0z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3213E10EA39
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:36:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxQRA2685716
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9NG7m+b/WWrUHSwlQRSzFSoC
 lkdz/Noo7KR5PJVocI4=; b=QSUM0FhHkfoqqdMnY5xBavLUZPk3Qo9KSi7TSrkr
 Xta+weX9GGY2ETDqc/xbTVhwC99LoLS1f5UJsuj/WO3/q1C24LACOSV+uC/OPZ55
 p849UZPa85VwwQw1zvrFCzq8dgAGHFbyfJd3NMEPQm7kEe/yhqlieYcdKc8pihtz
 yALsgRouBTSWUsATaEqySYFRtnGvjzNavsVHsEUhwPKe90AJzSs6L1ElnZoThTle
 KacV0ja7EKeRcf2bS6gdYGwSM3p5wg1LyNxuaVxinBYO6Zd6Ujb/vkHDv/LTh7AV
 zaQyWNF5OQAG/AM2JHCdizdBGIQVO24mo3G6lbiXlF46Dw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d45wb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:36:17 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e9e2deaa4so2585681241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789335376; x=1789940176;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9NG7m+b/WWrUHSwlQRSzFSoClkdz/Noo7KR5PJVocI4=;
 b=kMUtJO0zPAfVLPJFdOtjcsFr17MbdR9HaYefRvt4lnKZ7MNhUy4oHTSBlxlXEc4Pgc
 +5qFVJGTAMcol6yqb3xg1BYgdHAStrt72OGham3UZCgso59Erb7sBzv5eKzZcA/kIgse
 OvX/2yoG8VTThwczmFbZEdI7CMyAoj83aXt1DXkEJVBOu92v/tUvyuJN5xUQ2gbEFAkM
 Il7W1Q3VKx+2fifA+ktbnuYWcP6C8wE9liGxaaVzBLy/MIho9hWveIA0Q8rk3a/dlGOI
 7ML1kyFS0uAcF+MI3RK3hiSz8SP48N/ayxj8NRVY3IXBWRz5HlQxM0mV+Mk1MhnWZaZ1
 Em3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335376; x=1789940176;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9NG7m+b/WWrUHSwlQRSzFSoClkdz/Noo7KR5PJVocI4=;
 b=OlvSLMvuMx2UJJ9XkQVqMWuT+v+7dgXyIs3TkEOz40DtJnUAUNgDxtosMRtUuoYAQM
 E9daaZrAR7mqKYBX8uOaR3OX6EpZiZpe30OyqBNVb12fXTG6PhYOCPFtdDI6k/eyzfcD
 L0eYJD9jrzlUT3LVLSZxes+O4LU4lePUdCb1GX5gAPqI66fW+X5BXQ93+CZhZoa4dSBe
 1vLcnZOuDbCIufZqyC+IHRaKB9XmTUhSeKNXMJjVgZLenjonJ1MZS2BLlqGs8sloUIe5
 UJDdok1mUh0nnYw7UgsVURh3dR8Rz6eznWBFI7snlbMPf/6Oa/qYVL5CtHW6JAe73SLv
 hI2g==
X-Forwarded-Encrypted: i=1;
 AKwUvByQTgSNEYXXmE+NdtBdU/4wu1yeUixGCyk2/5Cj7XLA0VySD66s+7AOfUqgkvNLeBY9i4z2+gJRyF4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l29gY3hw7k40aslI0XGC5/AjoCVTHamwwu48JFGUfM75jKLJX/
 +j1sVhpdTKNd2mLwUWVp3A+CgbsHGg4s3XGtj2i8WDQExywVKhlWCYzA8EzNMsRv0X+m6p3yKbZ
 1mrRv1ocLc4mFw5aV1JZOqH1xcD+Clo1qpT6l0M0vVdGX0jlqJDvsu/uGQU5dW4iOsrmpjyw=
X-Gm-Gg: AYBFou0xUpwPZ9UJypovVs8eGYb8df7x57vK+krpGGkzXT+nw0mbi4y9ij2SWKaWmf5
 yz47gESfhOa+xj9L15lVhTaYbtvh0If5I28wWonF8N9FBtQVcy5uf4C99P/S8PBknm3hvlC9dgU
 eNkzu5kPezDjAxFtX3iI+sNkSbo4lMtARX39UDoXVToZoyaraY5zgS/6fu026icgexVzrnFzwY3
 rd91vb863U3uZg82xIQ9Aw+NBDUKqEAYBHaZT63M+Uoa/A3rSi6xUrfq9GCE4neO0I9yS07O/xf
 I0cr4ceI6ZbliOEP4gRB1uOAXs6suphRRExar8Hr3P+O9DfZmoQCZhZWKMXx4zaGaQsYiaytrSh
 +SEypMJQcm4XtU6PS0k9p8GzkHGDjUeIWaq8o+atZA3FUoNH3bv1ZSirekFr2q8ET2z4jf4wAPu
 a+pYA0wWjtrJ1Q
X-Received: by 2002:a05:6102:8309:b0:785:c960:ff85 with SMTP id
 ada2fe7eead31-792a96ab51cmr10976025137.7.1789335376481; 
 Sun, 13 Sep 2026 14:36:16 -0700 (PDT)
X-Received: by 2002:a05:6102:8309:b0:785:c960:ff85 with SMTP id
 ada2fe7eead31-792a96ab51cmr10976019137.7.1789335376094; 
 Sun, 13 Sep 2026 14:36:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a88a5sm1937493e87.8.2026.09.13.14.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:36:13 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:36:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] phy: qcom: qmp-combo: delay Type-C mux switch while
 DP PHY is initializing
Message-ID: <glm3mcwzq3uawbexxaggbqwkatudk3jrunnz5rwbp6gg5kcvm5@xbpqetiznnk5>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-1-2825e5bf8a96@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-1-2825e5bf8a96@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwOCBTYWx0ZWRfXzi6N0TCce3tr
 FF3Lxz2mQP5L7TVIL0OSKxyxnxqS3YhjOW1m3podLtObwwg4w5PDlCM5wpK4T1wljAm4e2gx8+S
 woIAh4Qw/6UtSVDrQMVJMPW2iwN9VHI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwOCBTYWx0ZWRfX4muNeNA5P+0O
 mdDNuk6jvOzRtuuauHYL4HRIn7ORzZaiuQXjaHX/zy9GkrhgCcAD3t3qI0GLTirt23KduQoyPUH
 gZQk/VbIqmQuDVN7gRgKeYSiSn2YlaVjGZjtcQZfn8r8aYEm3nbA0hvENyVjj/aQfISeeDvqlZ8
 7AxUup2BvOlZKH4tw7gYKWajpKeVpvbbt289cr9IU0MZ3bYkJeQ6ktRNBghkIkD81sS8mgIalyM
 wGKAWkijhwfjGIT71LK1lvSIr6M+HBIdjJ/LPPCuaU2fwfUgcQ4sTzPmigVcDg8jAjDOW5TGGvX
 TwoGElomY1C4hb0vlphLXymwbB2bX9WSt5WBso0GCoWEUf64R8YXi+XeCIn7o2SMX/0vG37Vt5g
 P9vE+SGBSuwdnj0iwWS0QuTPX6MFbstODfG80Jsbi9Typ24vNLXsp/D6TIYw9jOQsrOIh2XJZHw
 QgJ7zhPJNho/8EBgAYA==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa71751 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=nEuW5l_y3reV5ifXg-kA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: SUFiHHKH-8QoldPEGzH13n1HnY1jwuwT
X-Proofpoint-GUID: SUFiHHKH-8QoldPEGzH13n1HnY1jwuwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130308
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

On Mon, Aug 24, 2026 at 04:58:04PM +0530, Saurabh Anand wrote:
> The Type-C mux switch guard only checked dp_powered_on, which is set in
> qmp_combo_dp_power_on(). However there is a race window between
> qmp_combo_dp_init() and qmp_combo_dp_power_on() during which dp_init_count
> is non-zero but dp_powered_on is still false. A Type-C orientation change
> arriving in this window would proceed with the mux switch while the DP PHY
> is mid-initialization, corrupting the PHY state.
> 
> Extend the guard to also block the mux switch when dp_init_count is
> non-zero, covering the full period from dp_init through dp_power_on.
> 
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

If it's a race, it usually means you need a lock. Otherwise you can
still read the incorrect value of the variable.

-- 
With best wishes
Dmitry
