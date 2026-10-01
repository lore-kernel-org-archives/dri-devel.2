Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD3CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3583F10E47D;
	Thu,  1 Oct 2026 23:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDDE+JBP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BlAjd+rs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8861510E47D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 23:30:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691NEw9M100788
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 23:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4AbQ8DsiqRNyKzuYux5OlMD/
 rfuVBocWRxUHqNysAxE=; b=dDDE+JBPep5SyEc8jlf1fw7rJFKRDS/np2bW2+Z+
 pGEZxB35h0PtXlY59A8Negt0Zdpqr4V2g7rW5isDPxzY7g39Z+t0KTIjhaGIfY/z
 uShHC7pKtX0bLvZK5948jIsB55+n7INtJwZuaiYZw3F2werpTUQl7oxl2j1OR/yY
 tsXLIxYd//LhsQc1eXzSE7bkrNc5ruL+qluMcvti+/dMwmNOg1bQlocY0vdxPVp1
 wIZMtrMIfzohSQJdhJlVeyxmL/T2jhOlOddCp9KXBWlwbz49tMekLe/E6r1ezrcl
 g8q4IS3XzfNddY63Ntvf1sJS2x5N+lpvohK5szrSeJu0OQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh02wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 23:30:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934956beec8so1435279385a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790897435; x=1791502235;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4AbQ8DsiqRNyKzuYux5OlMD/rfuVBocWRxUHqNysAxE=;
 b=BlAjd+rsq7Oo6l1T7jP2x3dsfqW1MI7fgb57K+8z9wONb9cdenhkf1HIj33vH8sOoQ
 a/ntQf2j0gNFcqhhgD6YFloVivDI9vBg9FHumZ4o/tIN9z2ydQ/VmFupLzirBpUzKYCI
 nO0xwHeaal6W65q/4UXOfpBV870nq8z1dQqYptG34sY/g4Nayyfph/fU6ObrGpai/dLa
 S7qq8fPy2PGQV815a4O3/ojv6F5D2mBBG4ap+wgYi0eSmmlI8edsChncRC46QKldyv1d
 FFmoSy30vcwBrNXehj7413wh3lkqpvYa1PcVKxQBR0scepo7cAquqOBjYvQ5H1a6t1Ej
 +Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897435; x=1791502235;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4AbQ8DsiqRNyKzuYux5OlMD/rfuVBocWRxUHqNysAxE=;
 b=SocWZTbZ8JkmKiI9FvH7JY+q/7jiMrvekNzCIMMev9WfLYgrpnYc0f/QRbCoBMu8f/
 saH7HBM/D9XdU/zo9lSznSVccj+UxyZ9kYj9ZEadfgeADnS9ETlM4/oLyOHYJe2tzbTJ
 wEkl+TbKDjwtT63Yi6KGVLlwhoyYDDzqh+MH5qu64iWLwj1IJwU5+nBRjXsv+MKRdrJi
 k6DpVN5x5j8mqwww27FrNvkFAKs+0SPqWWHmpI9IX7xy2OkdOL9uiz852jSwkE65uAgd
 2+EPIQ47tdZjRsTmMigxMe9by8SFTK7mO7K6JifHb0Q0WrFSs4GbLF1UVknjMpfmSUh/
 xwtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGDg86uwIJLM5gINuhlH4ZZgglDPoockue9sVyQlEePhcLCUpRgSgFHmXNhnptAOGuzoM4LgbQLYM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAPBmsZz4gGeK2tN+M8qC2mIoy53URHM+WO80bA8VG76AmSXvK
 AQG1ANaqzCFfaWD4/LE4Nfdm+pC+We+B1BGIGn1ctDIdgJmnmoDyT0r2ubBbvK85N0Gdrrfq9Bm
 UDQmvxshM2/WqYgk80P0ik0A0mkZxP/gu1g3M/7yn921V/0J0jYdyzeGeJl09ddsPGVc+KdE=
X-Gm-Gg: AYBFou0cZpeORtdICukbQu3La616giu1rPVmLih8ogUbyTr6WCSqZLftKierIAmNU5Z
 M1x++thdc7eBgi+HsINM/UAKYNVVuPmk4iI7VJ1FagALFEXuw0hoFU5xho+LE2T4tAGx7PUvGGw
 Suj9I8o3uHB3Urr3OrnMl7/F919hYKJUIGZZxQUKPo2xVVuO87N29j1ULCeQC6zX4JFjryAUlzV
 gjkKTfSvDAw8zxZEfC5HkwUCgK9mqjbLhQ73v+AIADTiTY/Ffdept8+o3MgMv8A4SjdiL4VUcnQ
 Pad2mO1d5mvQ6LhvUnuNdxiArspnESWnyCqmehmYW2ANvDLsI1Uyut0wj8O7u0zNGhsivQvr43W
 Vw9ip3gDUeSQ1TMdp+nDEf45y60gxN+oplZmosxXqqGUPOebazruUyxCeaGhNdPieIJ5NNRmqba
 4ZXF+OHasQJiIY
X-Received: by 2002:a05:620a:444f:b0:93c:6450:9cf2 with SMTP id
 af79cd13be357-93cf16e70f1mr157178385a.28.1790897435247; 
 Thu, 01 Oct 2026 16:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:444f:b0:93c:6450:9cf2 with SMTP id
 af79cd13be357-93cf16e70f1mr157164785a.28.1790897434369; 
 Thu, 01 Oct 2026 16:30:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c78bec9sm224988e87.27.2026.10.01.16.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:30:33 -0700 (PDT)
Date: Fri, 2 Oct 2026 02:30:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, Val Packett <val@packett.cool>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi/phy: power up the digital top before
 starting the 7nm PLL
Message-ID: <f6w6anqecd27vgvu74ykjnd3smwhiji6uzejtj4geoe2kupiyh@v7spur2rtwqi>
References: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA5MyBTYWx0ZWRfX/ZTjWra2JZ6H
 szZNdXdO3uqgme+wTUf2B6/3hXephWnlTjC301mzxqqFBnMA7qnUWHdisWghFpWMm6KDeD4esVN
 YMQbviIP8UAeXg20Y3WH/776qLJJscg=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abeed1c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=GMMiCQSux9nJ0xNYgbgA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA5MyBTYWx0ZWRfX3+X5bM6Chmyk
 EqyzTMHawE8IN8ehPdtx5ZjE73UPdkEoX6FnWNVb/Prihy+iAsWPWHiUhvHCrPU8+tkX55skzZi
 uAzM64gO+kDWNu5J/+BRK4KOEGErmEl5UrVGLFXfkosQjxdTTsDiPi/I1Jgy0mPDyPNFkfVRIet
 G947Z5lABnTuFkNUWPHZbulZO+N8UOMOl8Lw7hlwEyRh/iytp559CJO/qYY3PTAMr8vRBa7XZg0
 yrfzzMjxPVycod2Dm4gowqy/7QmZHdTT+ZHouItkOLSAt3rQXqfCZ8TMiTScLd57DwKr0Y3bcEc
 DSbvveIoNt5d0GaUqPJU1JH+pLBpcYBPAQb/Yelq2N9EqXq0cL3g/YG0unOP+NDtjUj4Pm1IW/H
 mO1nVr6Ta0aVAvuMq2QyDz32rhxsMcpt/Q3u4s1MtjtQMP2ESlw8rOg9foHry2ETUpCMu0TXXQF
 P6lo/1ieaLzPsAdjFpg==
X-Proofpoint-GUID: _FhZkqfHg794KSAxmCotEgEUey1ZfqOk
X-Proofpoint-ORIG-GUID: _FhZkqfHg794KSAxmCotEgEUey1ZfqOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_05,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010093
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

On Thu, Sep 24, 2026 at 03:51:03AM +0300, Dmitry Baryshkov wrote:
> dsi_pll_7nm_vco_prepare() de-asserts PLL_SHUTDOWNB and starts the PLL,
> but leaves the PHY digital top powered down; only dsi_7nm_phy_enable()
> sets DIGTOP_PWRDN_B.  The PLL cannot lock in that state.  This went
> unnoticed for as long as the PLL was only ever prepared from the DSI
> host's enable path, after the PHY had been enabled.
> 
> Since commit acf7a91d0b0e ("clk: qcom: dispcc-sm8250: Enable parents for
> pixel clocks") the clock framework enables the PHY PLL on its own while
> applying the DT's assigned-clock-parents from of_clk_set_defaults(), at
> probe time, before the PHY has been touched.  The lock fails, the failed
> enable leaves the pixel clock with an unbalanced enable count, and the
> retries on every probe attempt stall the boot for tens of seconds:
> 
>   DSI PLL(0) lock failed, status=0x00000000
>   PLL(0) lock failed
>   dsi0_phy_pll_out_dsiclk already disabled
>   WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x244/0x24c
>    clk_core_disable
>    __clk_set_parent_after
>    clk_core_set_parent_nolock
>    clk_set_parent
>    of_clk_set_defaults
>    platform_probe
> 
> CMN_CTRL_0 reads 0x20 at the failing attempt: PLL_SHUTDOWNB set,
> DIGTOP_PWRDN_B clear.  Setting DIGTOP_PWRDN_B alone makes the same PLL
> lock, with no rate change and no other register touched.
> 
> Power up the digital top together with the PLL bias, and power it down
> again with it.  The normal enable path is unaffected: dsi_7nm_phy_enable()
> holds the bias reference and writes CMN_CTRL_0 in full anyway.
> 
> Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
> Fixes: acf7a91d0b0e ("clk: qcom: dispcc-sm8250: Enable parents for pixel clocks")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

For the reference, picking up this patch breaks the boot on SM8350 HDK
with the disconnected HDMI display output. I'll try debugging it later.

-- 
With best wishes
Dmitry
