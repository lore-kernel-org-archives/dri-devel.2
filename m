Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC36F3029D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 03:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBED10E2AA;
	Mon, 16 Mar 2026 03:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k4LgyMIH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ldrim5GC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E128A10E2A0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:24:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G2wHjU3044949
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=x+7MaGjLd+vSRSDnStILHVrm
 2PQxEhWXJkJc8OhBOCU=; b=k4LgyMIHGFHiGB8DBE5dIbWvqhqTk/OpWMZ3amBs
 SCFEbU107vJM1bqN/qIWC8D/J/pfnXEwg+gUdxRxHiSg8oi+JQlLqYWTjvfpybPr
 GlIzpux4BuPihgOQKXaGfqfRWffp2z5HBugZRsPBgLWSCxk387dsxSq9MFTARGZ6
 1vwHj1Mj2M2iFM9RkJqlAPhQU6HnUrFrX4hDqdgy9Hnab/guULfY5H0B8yHVOBfO
 DGpdPKAXHP7hP2kK2PcUAihFHnxDUbMNAeRU43LLTB/9Oz1Ew8AXYliFQItGlnNp
 HXcTYfhgWMj6ZhLqdzcgEjstE8Z3KRe+89dS9k65sOLYXQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udktyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:24:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd849cd562so2814747785a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773631483; x=1774236283;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x+7MaGjLd+vSRSDnStILHVrm2PQxEhWXJkJc8OhBOCU=;
 b=Ldrim5GCkId1sMBOcexfitqrRTqPrqvCFhxAa6o46LUjdJK9L5DbxgWpcS5+UyorGz
 c1mgFurWy08qHFcwpTooTN1iILmaJkZNsNOnSu2PtoTraiFv7FyWYdQOHNPwMvREDUNa
 Qm3ieDt12STkk6RL1Jt3th/on9w8kvd/e31cJviaLFew6mb41F6dGSQ/ITkjhmlZb42u
 ImSV4uwQQgRy6cBad0F4lC6kX7W5H3UsgrdFLNYKESlvErr0uFKFLrOyEfqXBjdJK+3b
 XgJbgcE+1pISPb6yp6dZcgqc8jKda41nLW1notCqkmBNmRi5OqpL1ecrGoDZ5iqsgTMM
 JDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773631483; x=1774236283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+7MaGjLd+vSRSDnStILHVrm2PQxEhWXJkJc8OhBOCU=;
 b=jCN3WPQWya9fv16OQ3QxpRR503I4ZIz/Jb9iPDm8e1kWTc0z6/FSXjbeA7/SYYWNxF
 +OMC7tKlfyOI2f5TUN41Z3n1fNcJHPeXy2DJXy5gjpjzj4/xGOjRWTG5YG9V4xuuVonh
 VXi74FlteUuhQDdWOpdmon5lO/oyfcVkdaYedBkeFEfebmxngXtKDFpaFJkbLt5MiMZJ
 yppCN58bOPeyzymDigJ5yRGu9QZvXuJ3cpkVV8Amvt+lTB9Uq6pPPPJaFggIbD6OFe8b
 wfO9CeUZ+GO3brjYZQitgZPMo6WaBMPJJUV/6RlBc40wsvwnM8ladjNvan822kGmhA0Q
 UgQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbjNRyMd9aHQEru9pdFO3iUDC4ZWz5Y4L+tng/4VIUcgjZimjkSg3bXC5fWIyZ/ckDcm+rxzLe3Io=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDEXQ43S9L1vJyqILIucyRMQ1negPXoklkV7tkmM+wYxVXUuIb
 ufSS+5JmpVXcTc26XvlVTK9B8BqUqetONnf2MqnjWe+UjkvDrS6o1a6/eGIl9f/UsQEIUMA4TcC
 kfWJYURgxQQYHnP98vm0nRHGdLEkazHvwLIJIEFUoK1QE7sKsAXkJ+r9SLP7SakGa+Qux8XU=
X-Gm-Gg: ATEYQzx36piFK5AP4lgKV3G922neU9odr6VD6x2giNLxi4eRD4Zi9xszBiuXJgm/nd3
 LyzfB4TAbOOOefsZxtHkJLvglHpSCuAIEQpOxKD9Dl+xzkogNG/Yaw4LJxjyv24uP2/XilF9mr1
 2X358NeGQon5SWkG8bQTcxX2mJB9uCeVaSrROG9y460SVrXOU1miAMttTlcNmY99NyIFOF0DF0n
 v6R4rOG7Z9YACUvI+N2e1A/zvwED7vY1trtCXWLe5Lpx29uvwFCDCspdcdSErJ8f+sMQDlC8cOO
 yG/hfDRNEEWrFhKRTF8sahk25YrbblPnvbj4q9ErTwFpPAVEamutG8Zd6Dv5rH/9XLHit9FBUd9
 PEQ+duVQmSrZUnlAxITG/cWPhorPEc95LoCajCSunItEO0BrDuDreb/+x0/8xvRAzDkk/p2tORz
 mJOLEGgQ1zLOtxBAMDgCRLiAFM5QFW5YTJQPo=
X-Received: by 2002:a05:620a:6919:b0:8cd:8938:f01d with SMTP id
 af79cd13be357-8cdb5a54987mr1761854485a.3.1773631483267; 
 Sun, 15 Mar 2026 20:24:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6919:b0:8cd:8938:f01d with SMTP id
 af79cd13be357-8cdb5a54987mr1761853385a.3.1773631482833; 
 Sun, 15 Mar 2026 20:24:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67e67836sm28357531fa.31.2026.03.15.20.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 20:24:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:24:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT v2] drm/msm/dpu: enable virtual planes by default
Message-ID: <lvgrkx6ypchqputyzgr5vlugjxsnifuoi4gil2vjpv5wut57ps@6z7phvhzmx46>
References: <20260226-dpu-enable-virt-planes-v2-1-87971236fe86@oss.qualcomm.com>
 <776a18d5-9d7e-45ff-8cfd-4823522ea375@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776a18d5-9d7e-45ff-8cfd-4823522ea375@packett.cool>
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b777fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=NRyVjlmX0iHkmRb3oaYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: yPJ4hYSu-43Uzi6brEoURM7xyIsSX91f
X-Proofpoint-ORIG-GUID: yPJ4hYSu-43Uzi6brEoURM7xyIsSX91f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAyNCBTYWx0ZWRfX8FjgSbLkayQK
 Vuy0kwcjdLFOZbG4tI4ry5r38HYtL/rvO1E7u/7a7hCUtjTAX1TImqghAxIcxn06671qBTk/vt2
 5d6TeRORnZmxtR4r7J24ifHxb1AVREQRlYWRCSMAfUw8J3lOtRtAwS2rh7kbmIE16XVVuTzd+eQ
 WD+WSbh1wvuYLrKrBaFn9aQ0+ix4iqQOCO1B3j4Wk9xTPB/aNNWgde8mxE6AHH1OoJ6yJtDK/EU
 n2gvTxKzyj3eiDKsZUPIYzSqbVqDNvcTWLUOEFoJI4fP/ibpQt036xZx7XueQ/Oc0rc3JaqRIeW
 9goawio4OGL1wWzdGj5l6YT/ToaM78npbXLY3wpBp8TgAjfxKi9myvc1+aUuHN7Jbuc4ZcBEiJF
 xoanbVcbQYpbwpRlkv/0PN+osxQux8mUHcZCfm2KOth0SSpXxOt8lNqTV7AixrC0ffz8OHvZfKQ
 9djU3KvNA9jE7ex9isg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160024
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

On Sat, Mar 14, 2026 at 04:06:37PM -0300, Val Packett wrote:
> On 2/26/26 10:49 AM, Dmitry Baryshkov wrote:
> 
> > Turn on the switch and use virtual planes by default, enhancing
> > utilisation of the display pipelines. It is still possible to use legacy
> > implementation by using `msm.dpu_use_virtual_planes=false` kernel boot
> > parameter.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > This is being sent as an RFT for now. Please give it a test with your
> > compositor of choice. X11. Weston. Sway. Wlroot. CrOS. I plan to turn
> > the switch for 7.1
> 
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455,
> with niri
> 
> Running with this for a few days, seems like no change, everything works as
> before. Any way to confirm virtual planes are being used?

You can compare, which SSPPs are used by checking
/sys/kernel/debug/dri/*/state.

-- 
With best wishes
Dmitry
