Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74771FA1FEC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD7010EF37;
	Wed, 22 Apr 2026 20:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtLDY9uF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TbmaNEMh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A8910EA94
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 20:04:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG4luO1587837
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TWNv/n77xtlQNACjJ3+8jJLY
 WYV7KxtU3j5KJIFZm9w=; b=YtLDY9uF5xOkCoR8E3Hapt6dWg8lw9y4CViURo4X
 3sj1xGiBYjfiOlGRP6eA/ix80qQtgSD5BDXQ3OUdZi2TY8vDwvtnHONVZG5N4Mtp
 Evjab88v4Ddg4qOo+pRr/xWx9Ns8qPgqG9+E9Y5FUY1c+m9NyDi490VZ+5rT9V3X
 rNy5DzOcpX3JpNZdLuhslsk3tCP+DLqiJIYsqlrsEn3PjEuWX87GqgAERsSGEPLs
 4Q9NPD4F4ixz33UAUspYkKvlTw16b6m5PgJ3Hig/XunesxrltP8r2sSMMsafu2is
 qNEkRl9ZPlkFePAbtM2xVw8xZtpC76DJp4eX5vb3NdhhPA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq0udn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 20:04:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6056898a01dso7933845137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776888256; x=1777493056;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
 b=TbmaNEMhueRhPr/Y/QiUv8EChrTsIDoCgWXDed7AX+c3z6F2SeBSHfeBsxZGJMOswE
 67l+c6cMRDgfpKYMj4+0SJgJxvUx9tAu9EEpZMSbtnzLrjtFgootL5wxEHfTKwyhVjR3
 +yQoSfJca+Zz5Ky5o9owQp7/VnJA7n5vP8rNaxA0BOkl4sm3ewbfwUylDLZKlo4P+lpV
 HWww8HXaljkIQiRZbyo39cYOszYmNzkbFh+bSgp0hvRALEuzU9l3o+xXIztG2SDpJS/I
 +TRsoo0IXVpA98w2uWDpPzTCpaNdKozSE5Xnvn4t1+zL38Hs4fFeX8EddMNR7Jf0yW22
 9AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888256; x=1777493056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
 b=j+DivXSqCoRzqJwRPlJEdhzVkl/s1G5Lv35M/dTMcvmzMbUakkztM3hyLs88kX+Pd2
 e5g51GC9mpWCrAcG1PC+4YLo0eHZZ6dGFzYJBoYqbaBKXd5DNn5tr624DSO9hE1YlfSp
 6KZIJMFsor2JN1DvCrOkblA0bZZwmmE+/a/nYs5u9eOLBMMelTPAqvVRpU05cI61PZLZ
 ELdJm4oaqypau4S+0QJn8W1mBnxWj+1fOUebdRDPmSR1qlYR50o2Wj1KU5ZeLVnTUEUN
 eaA4SUPohaUCrprgopH/CoHfB0aLNzEIDLHPESzMbVZPA+kMAkVHDnAF9vrXPJcMkUQZ
 O9Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iIrfbY9aorYGD93ejhMzCiLsWaOGCIGaymh33Vc9cG4h14XwSw5+++RIlSYVPQvfiM1XGUuzxqSI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuNIKYDDoPjBzdjlalDz8K/O3OI83Db5W7QX/PWVU7AkGyKFZJ
 UZ4lBUSLcuJKzRmeDTZJe/olHxi0YeOWv7LUhpLnYqCJ8D04+U5p2xQHRy/jf12ZIorIU4jqUBa
 01rLSTXAqpxiRzFvuL1EOMlEqZpcj3890mNL91loAn87fih6GYfcwPY3QPPotxm3CDGffmaYrYu
 faD88=
X-Gm-Gg: AeBDieth7a6ZRK17OYeZad5H2xPWfmd0gGr5xVvZoloGMZa/XZDnGr7NpmSHcdAvHUB
 Vo2SlhKDzafZtURhdFJt5v4OlWqvf4Fym93uce1/20pJropyKM6ewEvwG2kfp1mdPjE2NC7gmCW
 /g3TuVx9uT0McFd+vxwVueh0D0zRi9pp+L5UJvfo+kNw2smk4TMCnquoOZnxx0mj00aYKNt2UF1
 FaoC4euwC8RVutl0152gAMlEyM+pRApygxC8dGaOI05AB5gSAYiIPASTvfGKYhAbUNv2/Fyp66D
 uNIWzXNnAt8ANHS+T8+mJ6xfKo6kiaQWaBr4TIWlh6qGUHROAsMnLAci50IX+7pLi/iB0gktiCU
 nLdRKq/XJhaZk/vrSTE14gyM6DNit7FBQdlQ0bDDITWyy36ObsA02REjqhRQFxzydHfSvRBGraN
 wUvAYm++nEER3U3+0DlnziyHXpQqivsm1GPDTu+7cJQPs0bg==
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id
 ada2fe7eead31-616f73fb077mr11984429137.24.1776888256332; 
 Wed, 22 Apr 2026 13:04:16 -0700 (PDT)
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id
 ada2fe7eead31-616f73fb077mr11984380137.24.1776888255894; 
 Wed, 22 Apr 2026 13:04:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc25csm4689196e87.26.2026.04.22.13.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 13:04:14 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:04:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: lumag@kernel.org, robin.clark@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, sean@poorly.run, akhilpo@oss.qualcomm.com,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <fuypqlwseulyvlsgiq3dnh3kwhernjid2yqljiwmrxufzfuukq@mfy343uq5gs3>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-11-sumit.garg@kernel.org>
 <aeduRrAMOAW4f5TU@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeduRrAMOAW4f5TU@sumit-xelite>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5NCBTYWx0ZWRfX7Z9/OecBdqA9
 WoeqLRKLHZ69/CqMKK2oQacIOEzh8Nt538uiWzU74jQ9w3yVIcYShNgd/B5TYUXeIZAIwFLlfkV
 7NGcHPYwuE/CFtAkoNbV4dBotWpIY6c9uuWzuxNABncEvONp2tlHfLC/kILHeb75fOaUbopiDrL
 xsen4qd+lm33L+CwdL3X1NYUKtOIKLccqXURcfcS6VkH1ivAyZRuv125p5xBvDnVAvv1pw2r30/
 xfIkgAANvHY6l9XWxgWg4SoNVw/rBeDIT1Y2K+2qldGvdOEWl0aG9UFyciYHkJ2TmU5BHM/V62s
 08KC2Ind4CPFZsfHGE5ifOfJso+kVGZ1ueF71ADFi42rfY1iesTpMWLj5AD2m6teGzBtuxbyJwk
 HcOQptvpznZBOF3/NaAaraROWei1pvd8YIxSQcah4f+ZyP/QW+o0cdPtNdGLHS/PxlP7SkfKAd+
 rC+l7v51XHar/bKqWtQ==
X-Proofpoint-ORIG-GUID: YVFwpIFolcmokrM2PFhNdIcpiorciUhd
X-Proofpoint-GUID: YVFwpIFolcmokrM2PFhNdIcpiorciUhd
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e929c1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=dgZ2eqGgcVFd7X0fNysA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220194
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

On Tue, Apr 21, 2026 at 06:02:06PM +0530, Sumit Garg wrote:
> Hey Rob, Dmitry,
> 
> On Fri, Mar 27, 2026 at 06:40:38PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> 
> Can I get an ack from you on this change? I expect this complete
> patch-set to land via Qcom SoC tree.
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
