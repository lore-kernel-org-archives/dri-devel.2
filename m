Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3570CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D86110E355;
	Mon, 25 May 2026 13:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpGNiRW/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8xJVlGk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DD210E34B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:31:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6rt4b1842262
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zLVbbY0c4SKAOL1UVThQUmV7
 QSh7I/GuGH7pkuZOSos=; b=JpGNiRW/ZPE+XgEeCGcgArkgUwnjn0NGgcbudQH/
 +EphSy+gkJzUHmg4puVy9ENliDrTo0q2urWZFmgjKFDSnVwtHy9CAIwiwfjE0qSM
 /ES8BT2USBTazx/lw6JXprDsxksGvKgDP12ui6+/kmhNB1pwXVoXi0g44slrqLYa
 W3BuQPumocanUpgfu8Sc9eUxGNFYr65Ia6rWvmsZUbq2WnLEjtluVs1osHwYCYPs
 yO2QokB6QpsgBsbiUvzQYG+k7W7KL3Jf3qyjL4nHmJTeso9zf9Cnp9heIaCzZIzY
 OC02iH7Y5MztQnfQYqFXa3uyZmL+O5ljzPTdqgSKo/2TKw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0x0f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:31:05 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e624dcb28dso3374878a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779715865; x=1780320665;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zLVbbY0c4SKAOL1UVThQUmV7QSh7I/GuGH7pkuZOSos=;
 b=b8xJVlGkAok/mXL4GeqB9k8qJVmVaa7G7hgcJvLfdfxJ6xi78kOaB9pD0z7o9+3n0Z
 OBrofgfsOYoy5fK9oBWIfV23+zp08BLVj4rYmPFh5F64R+y0RpjoeU6JHUlxzycMI55H
 ml4nxe/IBoTDHiLIty21QxObJnllbtWFGSk3IQ7MXMAS8L88BfRZZ3Q4RoCjujj/7uL1
 nYGC8WsGDBH639EvMDeutAM3LxkMraja2fW88Mq7nEvsAykGmCRPMtvVA1pdn3JwkqcE
 ZZtNOxpJn9wRNaoq7tqGU5ndaLcHooS6UeSVEJMubdbN/t2FDFMqxor1YbbzK/Eh4KZI
 5rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715865; x=1780320665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLVbbY0c4SKAOL1UVThQUmV7QSh7I/GuGH7pkuZOSos=;
 b=VOeLeZ59ifqAVhoxVGbPq/kGdNSQBUrsMkfqnlZ1WIA/0Po/+4kQKHCdChcO+SD8vx
 45AGhJ+FrSyPUkz2cglkMWieKOXlzuQ11s6cBUqRFMyPO5PWFPirCKDx6X5vehBnEMsm
 5bZURqG8nSEhB5aFwsAHT4uWipBPV7JmS3TK8zuDreRTT3jHpfK4dWlWnPA2KMEwJF/Q
 I94XTyoYQ5czO/d+NDrSsOke5HG+SHcLK9TMs+eKc836PwzczfHK8CqFnti83wvTUYfw
 PM1H10+j2wgeSshe8/RiFHHhLIrjnxwXbawx/HSC+z5h1bYjHlX8KDR0HUDuJLlOX8Jg
 NgUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ++XW8/4nmu53xs8v/8mYWK5KO8zH5dUD4EnBEvJmKK/1D2mzOLn5FIBpskwTXwCsWPTktp7P066N0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyP44jK8CTX6CBL16clWqmtJdVaNNBLDXzZSy5Qu6grrudb6l5
 ZfotItdtl5Q1QhKpVNjDlRns0p/xe2LsTdzquUOoDyUj1w6vw1LwC5yVWSYcj7qdC3Yx26fZeuW
 nKesQgS7oay2LrF7AJM7+CvhUipzwkaRUdJgmaXi/957d2GWnVeAnjpKBaPn3U/3J4vwKfiM=
X-Gm-Gg: Acq92OHYYkVnsk61gQV8usRoZwmtQsT0Af3dFJOQiM98oah+YKBIfMBVp9z7IU20N2h
 v7ZjjDHcJHPhAelMJPMVqejQXEqreunt2HMRV9aFhjDTDOx7l7myMmVkhMkwk+xFc9qspxA9vdD
 rAFXUlp9l8cSqjiCJKrzp8Tayb+r2sny188qv+w8K1aR+NEJ2bGD0PZ7T2fS7acnj3fs2/aaTA0
 mZSmi2uborEhuqXcq6HfB4u7IHB0AnrIK5Ag6OkSBkaPHIl0dTNTF/BKqaCewYFStmblkIjRYxN
 XZmtOvl7SntjDhchn2jYtSM23bNNYF6+IptJ0fnlrQ/y7g7xsGwDZZ3KunWPaEasyuTH3F6JByT
 yXZMU2I1ernIaZ0D0+qHZ8b0CNIkCVtTyT1b2BWMeyDbiL94pAkxMaAis1U6QNxPNlmAo/2cmds
 MwTby6yC3CfKjVJAciS939lJDte/5Nsy/f/GXl7bPyACpcXw==
X-Received: by 2002:a05:6830:438e:b0:7d7:e3b9:58d6 with SMTP id
 46e09a7af769-7e5fef848fcmr8647551a34.22.1779715864549; 
 Mon, 25 May 2026 06:31:04 -0700 (PDT)
X-Received: by 2002:a05:6830:438e:b0:7d7:e3b9:58d6 with SMTP id
 46e09a7af769-7e5fef848fcmr8647487a34.22.1779715863880; 
 Mon, 25 May 2026 06:31:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf2b2dsm2658149e87.56.2026.05.25.06.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:31:02 -0700 (PDT)
Date: Mon, 25 May 2026 16:31:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 16/39] drm/msm/dp: use stream_id to change offsets in
 dp_catalog
Message-ID: <btri3zjm75yor5dap3oahdemailljh6h2ndldmmctehxabhdjy@7qnqq5cmsx3r>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-16-b20518dea8de@oss.qualcomm.com>
 <exhugtt2cf2zjvbing6p5q4ubyiealzj5ijcdrmmp2s45liz5q@7ccvl4euerkq>
 <753dde5f-9032-40ed-832b-0ecba7228d1a@oss.qualcomm.com>
 <zeuil2bs2qlqajen7edk5e5dveeyje3q7srxgfkkwrq6ylmzaf@smko5lyfrtnf>
 <db242035-8b03-48ad-b770-7c0d05480d6b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db242035-8b03-48ad-b770-7c0d05480d6b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: I4gD95T0S-Kh1ixx3d4YKcXQgJn_kVNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfXyakoM5soxYd3
 QSTK91GKIR1tCGWPUoV7PDGUnjaeo4cGrg+dn5EwbZK1/a1zW4sPSbGuq8CRb0dfyHjWufGhr1P
 N5tpB9iv/YhUpn+pSJX6K9YFZCQjZlPTXdIA07xaWGrQJZO+QbyvyCIHz5eb0Yx7pyluVNCRMs/
 wH7/A3EjaIjQ7t3zx2H4AHJE+Vj1+M3m4InQGR5V80DCcO9mQt5lF/msRViP9ErR/BGZlsiJBOS
 PV2ORvxhpIOF9MHoVhKnQiLz10HAJAMyMrQNAnc8m+4bFR7GupckQMNdIUihrWPf5PuF7nd60W5
 lbNgqQsZXuDIUGVbuAynkqiH547FobYq3dH1BdMCInvnMW7VqDLQoYHsP4VPrUAwIytfuidaabR
 BnYidxkoCxoo3uM6S1hkNBLpf+WYLiGdL4ZUqthNPL7rediiV5bax9OE2IzfN8Fm/GrWNp401Hm
 K326rWxNjRm9CFUa/SA==
X-Proofpoint-GUID: I4gD95T0S-Kh1ixx3d4YKcXQgJn_kVNb
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a144f19 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=C6lEkYh6A9OejaXkjHgA:9 a=CjuIK1q_8ugA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250138
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

On Mon, May 25, 2026 at 08:13:35PM +0800, Yongxing Mou wrote:
> 
> 
> On 5/25/2026 4:21 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 04:06:08PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/12/2026 2:12 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Apr 10, 2026 at 05:33:51PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Use the dp_panel's stream_id to adjust the offsets for stream 1 which will
> > > > > be used for MST in the dp_catalog.
> > > > 
> > > > Please start by describing the problem.
> > > > 
> > > Got it, thanks.
> > > > > Stream 1 share the same link clk with
> > > > > stream 0 with different reg offset. Also add additional register defines
> > > > > for stream 1.
> > > > > 
> > > > > Streams 2 and 3 are not covered here, as they use separate link clocks and
> > > > > require separate handling.
> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c  | 24 ++++++++++---
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.c | 72 +++++++++++++++++++++++++++------------
> > > > >    drivers/gpu/drm/msm/dp/dp_reg.h   | 11 ++++++
> > > > >    3 files changed, 81 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> > > > > index 3689642b7fc0..295c1161e6b7 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> > > > > @@ -332,6 +332,17 @@
> > > > >    #define DP_TPG_VIDEO_CONFIG_BPP_8BIT		(0x00000001)
> > > > >    #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
> > > > > +/* DP MST registers */
> > > > 
> > > > Which register spaces are they from?
> > > > 
> > > Here also from DPTX_*, what about this? /* DP_TX MST registers */
> > 
> > Why? don't separate them from the registers from the same space. Also,
> > please, name them uniformly. Why some of those are REG_DP1 and others
> > are MMSS_DP1?
> > 
> Hmm. So should I just delete this comments and sort them in ascending
> address order?

Yes, please

> Regarding REG_DP1_ and MMSS_DP1_, this is a historical naming
> convention inherited from the existing code.

I see. Maybe it would be more obvious with the followup patches.

> > > > > +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
> > > > > +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
> > > > > +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
> > > > > +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
> > > > > +#define REG_DP1_MISC1_MISC0			(0x0000042C)
> > > > > +#define MMSS_DP1_GENERIC0_0			(0x00000490)
> > > > > +#define MMSS_DP1_SDP_CFG			(0x000004E0)
> > > > > +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
> > > > > +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
> > > > > +
> > > > >    #define MMSS_DP_ASYNC_FIFO_CONFIG		(0x00000088)
> > > > >    #define REG_DP_PHY_AUX_INTERRUPT_CLEAR          (0x0000004C)
> > > > > 
> > 
> 

-- 
With best wishes
Dmitry
