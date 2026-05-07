Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9174CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2162D10E274;
	Thu,  7 May 2026 11:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8jZkoVA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LH6wPCBD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F06010E27B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:10:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6479pAX5026511
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 11:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2Y1kuY6AIGy+U4i/Y7pzL/6z
 K08GGDx+3n+4jmLdQvU=; b=O8jZkoVAqt+2HLCrU2eOD6YB3L6iTXF67LpCaRSu
 QAseQv6SNf3eYEndOf+rlKeYTn5xvcmLoniRiabHTBNmoqEMId5tALIdR3xOYLal
 M80isMChprYO83Hs+kwz+mL4ar0l+0LD04kBgpK1seap2XZ0v0VI+meYkfLPzgo3
 KBDG4EMuoWNq5Zso9HhvywmqbfipwOrbHtnNVXWsHQgvlbg5GkRkX0VlgFlAuOP/
 XMvHY5T8+aYuRcvjrt7euN2/KcH6wo7D/lvgSKY71ochyglzsfOMjdPS2CMXeRpC
 XLTzyjYCysKfoMAX/LiT99/jDAE5AaN5C03ulU4NuObiYA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t1kmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 11:10:52 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5756f9292c5so510000e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778152252; x=1778757052;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Y1kuY6AIGy+U4i/Y7pzL/6zK08GGDx+3n+4jmLdQvU=;
 b=LH6wPCBDKmWy3kjqPGWjfWj8vrNBg7DoF5LWB6TSC2AgkGRa0JVlpaFq6vA8H4cobE
 SzpEs9+XH1NQc5C91ZfaMeE4d7euhn717Osj/OcOHLIrWJar8ueBi+VVT3sPvMD+vVzj
 A2xhQnU7jFRVPNvi/YzWWLG/TDBozHcQcSA2PJE/E/CP5Vv3HNk/oTGSP7TUoR0aTwyx
 dLtd+d9Cr2kYEIj6NWWbtafdDmD6DWzy1/6DeBjst+HsQ9vakDOILy66LWPen8fqhLFD
 wtXQRigZM4zXWJmxUL5svELdlloMNgegODEc4EqyJOCaz29j5n44ycTTwo2jAkkcqX2d
 M0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152252; x=1778757052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Y1kuY6AIGy+U4i/Y7pzL/6zK08GGDx+3n+4jmLdQvU=;
 b=FmTHcs05rne61SbDd7SKncvSb/Ff8dujzYEd+sxXPaDg7//r8BU8F+VNI23O7PR4JN
 X7Ino+54ixEjOa7lLsBhRDVkNEi98QXKd17MZkMwk7r68O/jmaxLO7Pjfv7xCB1gkL+Y
 kQy4c0rso8XVZr09aNL6DZYy9UjG7tMVYFZRZCWoZxqTPeHE3gAsp32mED/4Uat6E0Y2
 fyodi3uliAR+Dzbc232aioBy3I2ZfB3OxFYwtvPOErEYlGZYFkxET2PHL7+pS7Z6df1U
 Wg2jMLtwry+NpCQAqPKs9A40vMt1sJE6O05wX0Uibh7p+oY0Nn8+hzmKK+Pf3F4G63sv
 exyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ81fZqIJH/gudDySy0uTNd6owrklmbHkHYWPzkZ/ACopH17kOwL50Gbye2TY6E7NdM0K9Il+mG6R1Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy98xsKVB3xmxsnXWDub6hosDWP4ov58JcCu8c94UYli88eBKp
 iqXQ+oddY/W8dtgfVVsI+Lc9V6A2FTa4JcvCstDI4gWrpSoVkFAd1Dfx1os5Wc640dxv1CoKxco
 diT9jn5RvOzqoXS5OdLncESzTTWxdWDG9E2GtNd0iyWNg1HRVXYiWQS6Ow5wq4l1L8epwjGc=
X-Gm-Gg: AeBDievmdEEhCYpeiqpR7QucGGkXPocpdMmCp0RGsjLAjKFEobMtlBKo97y3swse3xi
 ckrvJ6peXqRrjZgo61MsxHQn2o57vdOSM3e5kAysR0YWpXjE1xPskoYvmzCYgv7dRSKMzWOjlGg
 wJfCe2oWUa4XTOZvJijRKPl6jelKv0y4dUL8rVp4ot1wPXjxFBPLSRIIwfT3uhZMc/bxG4j5Os6
 WvrtxeJHuVdJVhZEgPvJa/Mnk4vCyhyonnt48mYtnY3eTuPfZHOoyiW5KjMGB3cK1CztUZgKn8v
 Ww1EKLnHKaRVAmXQnxCsDUCKD1/WnQXXqMe9vYbFY5pWMQ72cVAWdrx96kPqok/KyGWjdN5q3ee
 gjlkHfBC7KosReoWJoAej08WwjyTn6I6/P3GgGT3YaHdqeKYauGq2cP2MHQ6fnKgzWDFhr9OXw4
 yasycq3aqzGHyw0eMjpn3bb2mD4vH729Bj2twsFvC3iOoeYFtUJu5YGtCD
X-Received: by 2002:a05:6102:84d2:b0:605:38d2:26cc with SMTP id
 ada2fe7eead31-630f9036c70mr2284830137.26.1778152251755; 
 Thu, 07 May 2026 04:10:51 -0700 (PDT)
X-Received: by 2002:a05:6102:84d2:b0:605:38d2:26cc with SMTP id
 ada2fe7eead31-630f9036c70mr2284814137.26.1778152251228; 
 Thu, 07 May 2026 04:10:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c22de94sm5528582e87.7.2026.05.07.04.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:10:50 -0700 (PDT)
Date: Thu, 7 May 2026 14:10:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, jonathanh@nvidia.com,
 thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor Extensions
Message-ID: <nfh7duwh3o6hayhxz4pxwfwng6fi6q4l5rlzlgjjk3atakw4h6@6xbyk3nppdrt>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
 <605bcc1c-a4ab-4125-a4b9-facf801db26c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605bcc1c-a4ab-4125-a4b9-facf801db26c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc733c cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=kzQ9Fxln275sraQuM_AA:9
 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: ojhHwtZdRbJBVKf7ho0IoASRi6zSlHxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExMSBTYWx0ZWRfX00IUme3HSm9n
 PPIfebm+uGnZODxexSdDzgKPzKGxe9t/vK008GG0WI25/Ix9bxrzQQg3UsVuZT9V0GbSBblSMAZ
 mvLQa4/ORQ1bAddIALiyMRhSjTyMVU4rIr/JTXjdZts8iosPJo8hiJ0rgTcslWb/7FokdGDtKfu
 DW6jwbfB0f3fAPh+m3y8zukem9TzRAo566HW0HDLLFo5uakCIJriLbb7N6cCIT7p+IA2VZY42sR
 dL1OJ1IeTe5BkIO/lK6BS+1D8aVud+HFrm7B43iXG455auBRn5L0xMnppJ0b58xr+4Mtyy6IXLU
 3uvDqGonmq94XuTzRkLOGWrsyCxiPuk7+5Rz06AsTGSUR8Y1grOx9fAaEVXneCE7LeahtpUw70v
 cZ5B1SevNcLDhY2TYYYdDwiVAOOvl+smYlWT/TArJ3nm0E0bSWsoPYz5736+E588P1ygcv3HhvU
 5SF/shXW/4cdBPec9OA==
X-Proofpoint-GUID: ojhHwtZdRbJBVKf7ho0IoASRi6zSlHxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070111
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

On Thu, May 07, 2026 at 03:28:21PM +0530, Sibi Sankar wrote:
> 
> On 5/7/2026 2:40 PM, Dmitry Baryshkov wrote:
> > On Thu, May 07, 2026 at 11:52:29AM +0530, Sibi Sankar wrote:
> > > The QCOM SCMI vendor protocol provides a generic way of exposing a number of
> > > Qualcomm SoC specific features (like memory bus scaling) through a mixture of
> > > pre-determined algorithm strings and param_id pairs hosted on the SCMI
> > > controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
> > > mechanism to control the various caches and ram is hosted on the CPU Control
> > > Processor (CPUCP) and the method to tweak and start the governor is exposed
> > > through the QCOM SCMI Generic Extension Protocol.
> > 
> > Could you please clarify, does this apply to the common commercial
> > Glymur and Hamoa laptops?
> 
> Yes, they do apply to common commercial Glymur/Hamoa Laptops
> as is. This is the same solution used on the windows side of things
> as well. There can be certain cases like Johan has reported earlier
> where certain oems are stuck with on older version of CPUCP
> which requires a the memlat string to be sent out in lower case
> we should be able to handle those as well with overriding those
> by using driver data and specific compatibles.

Ack, thanks for the confirmation.

-- 
With best wishes
Dmitry
