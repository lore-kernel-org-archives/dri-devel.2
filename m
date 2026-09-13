Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5ECC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA09F10EA3A;
	Sun, 13 Sep 2026 21:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIv24318";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DPcZ2DoD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B6510E538
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:59:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DLFan43674082
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C5HYUvgwnNyezi4DPkW8H3ba
 CzRfmbYpk5g0hHr8iEI=; b=QIv24318GDSw+I3oxP6aB1sILBiVgSXDetUkMeGz
 29IUAhrqAja6P2giZ3Zv0Ve4Mu61H6U21K770k/LlzaGoq7dZOOyVq79ih2rVxQN
 uRZhATZVBp6IXQiTRMb7ectV/fjyRSF7jufX67EINMhrDn+cuP166Q/uZBmfnoQI
 nmXcuE5xFMEWeuWr124W/FoIcU3gtkmua8aTEoBWO0n1JT2G9k13QWHFR7ak634o
 7YKK2YoQpJQ2mvy0IsuOtIIV38NqnZgyt7dbSZSxUl18gXld7KMVvVyOvwD1U5Uv
 cH77OFbPAdnlPQX7XavOKHeGRgB5l+8tdhig+dmysZEkUw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k082dk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:59:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e768af628so2292125241.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789336774; x=1789941574;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C5HYUvgwnNyezi4DPkW8H3baCzRfmbYpk5g0hHr8iEI=;
 b=DPcZ2DoD2e/I9sdAqn2SLyCjCcZbqE3YR7DzBSvuG2jkIDsPCXco4JnpJuwoiPYiBp
 7wMuZ6eHvoEHE7qnVLOaqzTFl4tYM3XtrxQNcgtV9dlfejxo3pIzszkMcEk9Ua2o4B8n
 LQUHDP2pTleNJETBpmNDgAo4BsZxrrsa2oCKAN0FL6EHCfaUs+cjGQH5v79QVZSm4Vy3
 zXMOcwUM9ZxUPufG12H7mZEliFQ5MhnEi512p7Ussh3ll/zlFxIGYpA8pAZDxIWCFNIy
 l4m2ysW1txcBNzundD2hmMiTJ2pvLH/Gxg6EloXrVyKKzu8Xm1vdJqv7VgqWBk59fM1x
 fr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789336774; x=1789941574;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C5HYUvgwnNyezi4DPkW8H3baCzRfmbYpk5g0hHr8iEI=;
 b=MKVrywofBXDyTF2JwYJ0xCfqnx8aNo3nPJDmcyr8FJqAN9Rsg9sJnfqqNewfY9aRol
 z1/mZvw8bdfheamK2Y1g05XVfxDfgBJIWsV4PK3Fv0eimPM9zf3+FiuSMTByz+ukEfHX
 tOex+OuOM/iA9/OPTl2+x6RbDNcx8IN5i+gOUouBOlZ0kSRLCHQ7b+7zK2DarXhqYavx
 qcgZqgeqgi39DkbyLfZyjG4gGn6Rrz/PAprNtMZOTljluWwPSOblB+BZ6LAySE1+2bDi
 NEWiq5R3oVhkXDqTMdLQ/ydFukEIJWCLtbhE++p2x+dMBheJJhkir0daCfeaTduaaa2E
 +NEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwJa3uL/QCgoSQtXMhh4bSTxvtFHko5W50zwEccCsLwuHb5wupovjorSFX0wsn2vvjHbfIC3ep9OI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZQJ3STTIeCq3ybfg0IWSS8xIS0wTBGck6ZRs4n4w5jXuSguun
 LBapndVx1+VlDv5aTnF7yBbE0DShNm/RV8+BVIBJNS+cuYN9H8DzTdCATBPVTtXC4gIEPowobl9
 Lkc5mTFSMlPMeh2aRMThQR3xp3Slkyq54Pdvc3adAzFVEyjmfRKkiOdVcIiATLXY7oD6J+2o=
X-Gm-Gg: AYBFou39S+d4tTKd2rwCUw8F7Dl983jGOHFce+NjNFqysTF4VmM1cwuRbW1OG1kXBXa
 F5oPYuWFDOukef/Xs1ijFdoivT38XA5VuiTN9XJYR5gLQ92A1/mFCVxQpAWHPNBeR5TFN6kKYhO
 C/CfPre63Y1j3Nkp9KTsdyo/40kWpdxgcAHvSZqh0AnC83b18vyVRGefnvjDv2C6YxbgxPskbC5
 C4usRA9BhnBIO2lQoqh2318cO3jOiCXeskzP+wmhzR9wCEKWkBvthi7jpH+g89yEfnvTk0eYhDr
 6yvKKHejicGCTD+YIV1cC4heKP+HYelHYeh3h8rSJ+SslJ1Go8zadT6xY+D1PY5juVfAkH65jWX
 wnF9jgQnee6Rktva9vc1DNRcT7m2gwoZXw6IpH2ksXf8ntg9kIlxSG+5dkiS7pkhgmI3NEQPx6I
 pWy2cthyrkAOa6
X-Received: by 2002:a05:6102:869a:10b0:79a:62cf:2a50 with SMTP id
 ada2fe7eead31-79a62cf501emr764783137.7.1789336773917; 
 Sun, 13 Sep 2026 14:59:33 -0700 (PDT)
X-Received: by 2002:a05:6102:869a:10b0:79a:62cf:2a50 with SMTP id
 ada2fe7eead31-79a62cf501emr764768137.7.1789336773560; 
 Sun, 13 Sep 2026 14:59:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0457189sm1907495e87.25.2026.09.13.14.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:59:32 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:59:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saim Shujah <saimzst@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: clear pending flush state before physical
 cleanup
Message-ID: <wyoltftfpoxowxs4g4uwa2vi2pnspubn4vw4l2y52bwrhcjvew@xh3og5yp7uaq>
References: <20260826182459.1506522-1-saimzst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826182459.1506522-1-saimzst@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMxNCBTYWx0ZWRfX4KQnaMDUCcad
 23SIp6VmbOAq8F9B+GhAP0PCNhAgu0acoDLe3X7HBRaat1/a1qg8vKEXPUVDsZbAIce180QdD16
 dNb9SVxqjt884zd5/I+Gch+CMIChOBA=
X-Proofpoint-GUID: sNQhbLVoWM30MO1jnsXi9R5MsZR_fhjz
X-Proofpoint-ORIG-GUID: sNQhbLVoWM30MO1jnsXi9R5MsZR_fhjz
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa71cc6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=r5cTPNi_baYN2tIuLokA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMxNCBTYWx0ZWRfX9N+EwjgL+PcZ
 DTqF4DPfXKk1Yg+tuVrU/JAJabkyDvYNQLkzNlJ9vBwzjxT0WOO2x+FRBRPdP+xelWqFh7oyODW
 xsxbAPGMDkhcaGZuvvYKC7F8z2fSvbCaAs6pXshdpCbwGESlfZDOyOrYAgKbdkx0Vjsy+XUhilw
 1m0P/lEfkbSru9s/H0JMVLYEGQzBt+9UTbamg9tinKKAZ6yg2yP2muZ/W8/zl0F8g6hzWvIrwoH
 cfaQLUN7zOuKToM8vckgYKA+yufIjiTGd7c1RtRBehYk9gV8Xns8aZfnzYqTq7E+BAgxlC15lA1
 yveYQuvMJ0F99KB0TGZXng85+GIR/0SCgBPBMMVCwauQxkecq2eNgzsmDLuJ1GkkeiSHbEgB8eG
 r6UX3epk0LIRU2icIEcGgDf8naBZHbPW0OJ2vDvcv2rUv77ZX3CZ1TYqCycRZjKJ4JGbi13FNhs
 tMOPuhrTLzY4AYVTkhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130314
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

On Wed, Aug 26, 2026 at 11:24:59PM +0500, Saim Shujah wrote:
> Hardware can consume an active-frame CTL flush while the cached software
> pending-flush mask retains the submitted bits. Video-mode disable stops the
> timing engine before physical cleanup, which then adds teardown bits to the
> stale cached mask.
> 
> The teardown trigger can replay source-pipe bits after timing
> stops, leaving one pending and preventing the first commit after re-enable.
> 
> Clear the cached pending-flush bookkeeping before constructing the teardown
> state. clear_pending_flush() updates software bookkeeping only; it does not
> write the hardware CTL_FLUSH register.
> 
> Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saim Shujah <saimzst@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
-- 
With best wishes
Dmitry
