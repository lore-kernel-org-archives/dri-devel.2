Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87E5F31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1097610E7FE;
	Thu,  9 Apr 2026 14:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezfnK4pB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5QW1bRY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E01810E3AD
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:13:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639BcGWD4107774
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SUiCVgOWHvBBOrrdz7pA0iDj
 gBsstSlgoVOzC5ll9m8=; b=ezfnK4pBiJ2fC0cutjXd8+5yYoQoWeQUUGQ5ufYj
 B94/Qq05FgNUav39KuyAi0/rSVXYx4eFusunqJLQFaUpMXnsX7p95L8BpQPtAYnn
 FwqI/N6V8jsXDo3mFmozroSlMTnUdkdZuQ92RZhbqz30ko1ZdbetznB/+hSlRKSC
 DdD3VCPBMkmRZDy/M3gRAlsF+ljpN1Y1XlXiAqmmXf0IHgGhkTuzgbz2evGEGFbl
 ULnAg4IcntcqWoBZ1SHgw1rL7Tc5Ts8IxRIwmEIUN/MyKk1kovcb6GgEK9xsMEty
 72MwnvnCMJlRXGYKapaJFfhRXsHFijF88RmtDSGX5vhaeA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhak9v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:13:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6055b9cfa08so318511137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775744007; x=1776348807;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SUiCVgOWHvBBOrrdz7pA0iDjgBsstSlgoVOzC5ll9m8=;
 b=L5QW1bRYe5t5Sk/OMnOpvTvlTfGwDjOqOWy6TDbr6pc5z3DxJpCkoXMWIME6JR8Qt3
 ZUZx1rS/oLbREGIzAmW8Yiv0GAtHYPAgpaN6ShQMjWWSF+4U964Ml/NZ3BbaUvbDuu7D
 dzjWK2bWa6cXhe66IeiEfMTewQxTtg7j7W+aRqhmGfHYTRUriVF4tQUVi7T9N4vxtJht
 aqor2W1OiEWkkCjyx6kv3RGeK+gmE53z7QcuoZ+fWEiFLrNqLU1nYNCltnHCibFJ0ujR
 2+6lBaGS3tdXjZ4ihtUUPPpu9CcYMsKiWEnW0+VZwKpd2o0flbXamRu8paL4Cb7CbVAR
 EMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744007; x=1776348807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUiCVgOWHvBBOrrdz7pA0iDjgBsstSlgoVOzC5ll9m8=;
 b=tPRY2hPBL153ApyoRTX4bZZomlAbqvY2dEHLkliAbeNEvHWZyaNrmeIS/urJeZ1nYJ
 usObXOQfy9KrOtoKz46Xi7q3MdlwL/WweA/21jbNaXzzTdV/J86dtgKYGZWRFSm7cZon
 MsjbJlPr8qZhP2q/ERru0gmGXjXFVpUSGh9PRESa7U3CyfJgVXADAIARkNVb3Wtd70Ve
 qK/bazYsEdmTMaclw2t83z4J1kTiq4IbJrHQv1EL7kclyj3i0VPTMTrcm5qqs1FwNSMJ
 8Xpn6gGrJCHAvpTaoXQwBk98JzT60TickWWfNzFiHIBxSsAjjQmkBNk7cGMEZV1D2Q9j
 mAWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUnY1yhvr7f9+gNAZQ7oMBG3lPSiRF1QzRF07FPmyGrcbLNU37hSj5znCxrT7fpvoOSwvzAOc5L5o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiLA9pIt7h6ZFD1rtDQPxoY3aHVhrHvUJoO25ALBrw5asWNkmw
 O3kBUBtZQzD/JovsxMZdgeU6+DXlA47GUR4AEh3ajY1B6Gooui71BeyJgshbU7866+kznMh5ycR
 YC1h9EzQCydFOKzU3ml/4k39xqs96keQuHtcjAZjcXPsJkDxyVmKQOmLq9xSDYorb72jkPHM=
X-Gm-Gg: AeBDiettw0X60H2X1V6kegnNJzdfinG66U2+Ypzyg9j944nG79NPRrIBKVcLo8YqQHN
 KLdzY4WA7FKGa6VQ+X3uM3Xy9++7oyNUDaqIafoscR/dmYQ/EQFBAB2la8UOovqn3sc2uCKLZ4/
 WJ2e2TY71jUxs7ohNc4M6Mst+qiIf6erMwkvu/txg1ghhqUsdtnt+O8y79hz09kbMCLGkd4Rxba
 ETJqMYO3w6+wIKxMFUll21dNUkxKZ72uep2pfhgNg0+sT5QwsmYNq3TxaTQ+eerByEuQC953XNC
 Czd1DKAKz2a8M5IlNeDB6/fHG1wAIWQTyirXjaRYEk8UX7RWHymDEKvLUpJTHyffl/0HG8RAl8Q
 Fhk47/u66odWz5E+sfO4mCUlryGpC7InSgpHLptevng+LNt5ljevEjh9AgP+nTBLcAi4pnOmfz8
 3wJifQqrSt3tExSpyuC5vDFjTyI5CIhU4CVFI=
X-Received: by 2002:a05:6102:2b97:b0:608:706b:b346 with SMTP id
 ada2fe7eead31-608706bba83mr1416924137.20.1775744007312; 
 Thu, 09 Apr 2026 07:13:27 -0700 (PDT)
X-Received: by 2002:a05:6102:2b97:b0:608:706b:b346 with SMTP id
 ada2fe7eead31-608706bba83mr1416870137.20.1775744006833; 
 Thu, 09 Apr 2026 07:13:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd2108a4fsm50745461fa.23.2026.04.09.07.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:13:25 -0700 (PDT)
Date: Thu, 9 Apr 2026 17:13:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 28/38] drm/msm/dp: add dp_mst_drm to manage DP MST
 bridge operations
Message-ID: <4hsivepf5wc7m25njjcwdns426k7otjywke3r5bfsskccl2esn@cy6hvs2ercgd>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-28-01faacfcdedd@oss.qualcomm.com>
 <h22zh2zcgdcv2k3mxc5rslpfd3xnerjfailehtaw3wbtpnisy3@s56vudwvoh4q>
 <cda87928-c2e2-4f75-ade1-5a4ae49c4399@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda87928-c2e2-4f75-ade1-5a4ae49c4399@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: xssqvO_TALWd7ttWxp7XBmOjp1pluHKs
X-Proofpoint-GUID: xssqvO_TALWd7ttWxp7XBmOjp1pluHKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyOSBTYWx0ZWRfX/pIfOJVCn5Hp
 uRAZFdI5Kx+bplI2IkBWpgZ8AHY/92mj6SFtCHxQjYXW72eZlUtqnZ5GzhR9725HzoBfKlmu5Il
 pE6Elky6bjKqLiODpbzvDqxYHumgJ7xd8i2m8iErNjblkAAToG6ZKuNvq1q4/3YsCQ6vQn75V1h
 HEid8dMsE93wkYkIhytiL2oS/ucA3JL7SimOg2nxDu0BhNUlc3VQXn2ZW9AV7YVeAy2A1YikBwF
 HsMu0NYZ8KhGWGikQwxLuLWI2iwG8Ryjj004QrgJgpS22bnj33JVCxWl01HJaz+ik23gkrULdxU
 fkgl8O1hrWnkYlc6TQ9UVVnbEdAt/wlVh9791cIctQzQdJ9aNbMILBiNrbLpmJ+2r5Uxk9z5ufL
 7NCIIc4Ab8zaEOhm2MG6Jl5Jo5kGYVpBec1kyAmfDctfom/X77eJJQd9tH3tExpnfB6tVxALCOn
 PxEpCKy+DS/0MYXrpQA==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d7b408 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=uH1RIaAHKDEITSwYPBYA:9
 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090129
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

On Tue, Apr 07, 2026 at 03:42:34PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 1:36 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:14PM +0800, Yongxing Mou wrote:
> > > +	struct msm_dp_panel *msm_dp_panel;
> > > +};
> > > +
> > > +struct msm_dp_mst_bridge_state {
> > > +	struct drm_private_state base;
> > > +	struct drm_connector *connector;
> > > +	struct msm_dp_panel *msm_dp_panel;
> > > +
> > > +	int vcpi;
> > > +	int pbn;
> > > +	int num_slots;
> > > +	int start_slot;
> > 
> > I'd definitely prefer to have payload pointer here, if that's also a
> > part of the state.
> > 
> Here if we not need pbn/vcpi/slots/start_slot in bridge state, can we delete
> whole bridge state and move connector/dp_panel to bridge?

Where is dp_panel identified / assigned? If it is not atomic_check(),
then you can move it away from the bridge state. The same applied to
connector.


-- 
With best wishes
Dmitry
