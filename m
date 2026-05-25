Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761BBCD5BCF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F9F10E5F0;
	Mon, 25 May 2026 08:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GIsx4X2y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEr2rl+J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9209610E5EE
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:21:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P4oda03282561
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TjrkbQZDflEL6zuLp9X/6/i6
 fJIOaLkwvYVvs3y6tZg=; b=GIsx4X2yUlFG898unqJswD3orf1dgH6JqESD6ls/
 hzOVJR469ozwytYoVxxgoPHthGJ17rTx/GQqy6mNOo6XTwbprWMQgmrwfW101E0L
 DElng1WyD2zBrxXfoNx+B/WJz2HW+7O3C9ALmTyXo5YzOn2lwNRzXIynMNoywatS
 JyulfKQKueryHambX3+SJpcXNzUINJK4C35wLh8zcaW42aDpWbDSxid+VR8DU2yB
 QxmhcZe8MaX3mQY9IRyAP8o0EWp/Ut2e2RVQds0wXFzx7j0lVb0R09hxFvGx+8m2
 t1YZ4eRtKkVp25Ie4CHbf06JhaXLXD5xDNKLyICRtZ7Zjw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3dqkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:21:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95fcbf9c0e8so14952820241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779697280; x=1780302080;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TjrkbQZDflEL6zuLp9X/6/i6fJIOaLkwvYVvs3y6tZg=;
 b=bEr2rl+JQrO0VG1MiXXSZfIBLhuHcp8s2ulSSyV50ua/gtRdNN+fcXu4mwKY9x1cUU
 34TsQ+C7niVqxQUJtl3wRECpNwu/sCXO4elKSf9lTRcbqTwF0ABkG4EujrnJjhLokJys
 XphAgg1zxeVPipXsnwKOM9PraJ+TziK7ekkcWD2/bEHWaYaaBiAWKomWa7HhM+TXp2zC
 hWwrHR55PhlQmaILLQ6oL0wSdlqHfxcNYRUTFtFKFvpO5jltp6olaxSLJ7Ze1nm1yVJm
 63+WOJx2pv9dO8eROuxegDDYacDXKZpAKI4Mtc9s02y9eo5XeCKtJ/osiXA6hwpQUeZW
 kHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697280; x=1780302080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjrkbQZDflEL6zuLp9X/6/i6fJIOaLkwvYVvs3y6tZg=;
 b=kTiPNSipLcQSIpKo5hkZUt7ex66coqh3rzsEDjdxryHcHyDk/6JenkXKd4v8v2TWi7
 ZIcMVH9LBrwnM4EPPv3EQjV944+XrWN4ALT7GK41gICG0GyCb+jqL7N8UwqvlJ5IOPzQ
 gK/7B6cjXPJf8Rs9rWAHIEAAWpMVPe+MlW1O4o33+tY/mOGXDHdC9jbUrlLN6je9cf5c
 lfR8D22DU1NkhfIv3DcB5mYe+OMcW8sH/VdZhxn5SNp0LSwCkzNXm5L1AlJugbi65gaS
 LJw6wSRGZHx1DCfhowRESjCidI8ACmgqo8i+jCj7fLSlvDNnf1QOKAe8yetAvv67KAPW
 DiAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JvNeKaM6F/b78iD0tVVx7wEifqZ0UHvM+DTkI1mKsKQFDw1ZsH2T/fbLiiwo+BGcX6+AhhbtbpvE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOiVx+B2kZiExs5WglGiswwqxL8ohsYGQcThWyE6l/OwEOfmLE
 i+CKtF+BJd16f2fpSvCLs1SfbO25Xo+0xxzi/DYgoy9rw7lDD0ZaC7Ysgy3VYaOLER09a6arjRk
 W0c51gK0KKEF1VAo5T+J4sts6Z435KP9s7bQKdeVvV+po7NXknFsVuFnEPEOzF2lt+eoR/GU=
X-Gm-Gg: Acq92OG/sisqRVnA9NYtPrUDpYteE+RW2+px43ZKgUOCmutAR07gxc/dUV6RnQFq7WO
 BZZb4SREy/g46J6WYaq4O+a8Wkq3XGZ6LBptlpAr1owSRbwodSfd0WcyR4o+XyeUQaeGhWaJS0p
 F54agMBEie1Z3GAqVkabMIUi8X+G8E9zkj5qb+YPzJLq3kfgHEiA6BlKwzi9ER9b5tTQW+W9piY
 zRKlenkDk9MktWrzTNXRTrGYPygVXtM85WcDbMTwAXo8a6UfVAg+xU9HgQJovHrSgwKpi+c51Ye
 dB/g26CAiZHu1XE1gZYF8itwszeAIx31lu7wkK8U6Q+EtfYb1OpO8cIi/QWdj7hnPD1IOwMDixr
 QpvaPNPdaXZTwob0jxVT7ggm8jV6twH5NevvQnilHHvgEm8O0C8u5tPaZ9s8FJ4EqX5qWKsa3uN
 oqZFuBsB8X+GHhyNh0MnuPu1HmfjxXy3LR3Ew=
X-Received: by 2002:a05:6102:5e88:b0:631:8665:350c with SMTP id
 ada2fe7eead31-67c8a823e5fmr6571028137.25.1779697279792; 
 Mon, 25 May 2026 01:21:19 -0700 (PDT)
X-Received: by 2002:a05:6102:5e88:b0:631:8665:350c with SMTP id
 ada2fe7eead31-67c8a823e5fmr6571016137.25.1779697279405; 
 Mon, 25 May 2026 01:21:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb3839sm2500749e87.12.2026.05.25.01.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:21:18 -0700 (PDT)
Date: Mon, 25 May 2026 11:21:16 +0300
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
Message-ID: <zeuil2bs2qlqajen7edk5e5dveeyje3q7srxgfkkwrq6ylmzaf@smko5lyfrtnf>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-16-b20518dea8de@oss.qualcomm.com>
 <exhugtt2cf2zjvbing6p5q4ubyiealzj5ijcdrmmp2s45liz5q@7ccvl4euerkq>
 <753dde5f-9032-40ed-832b-0ecba7228d1a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <753dde5f-9032-40ed-832b-0ecba7228d1a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: AQID8s-2FSmIl1hlb29K1KHK4IzkcX1j
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a140680 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=yTU8BwRFjwlpDGFP9tIA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NCBTYWx0ZWRfX3vLmi2B5vIXr
 LujXZe89jLB1f95OCFfuqaJokxBYq7VJ8gL8QkQ8kBuR2nmNcqwB1BZOsbgnhKOl+Raew623V6Z
 Z28nXy9QEEz7FtYmUyvJZkC9wNUTBofMOhd04rc6MXwM+3R0UV/4fWUTUnFI6VBcMag11n8hWG6
 Lptq1f5oPhOS0Y7K8bDgz+gycDaT3/9ieiAwc2jYhMDV2CJOH0NeRzc6U/hHJdxsqBnlMC6RAXH
 Dtw2wDXCX5HRs4LJP7nEstrS+daDRAgBoXXNquybdSFz036plybWbmU/ZUwIoAYlMUL4bmTLVPQ
 PUInD80Lz1T2f2WNAwMhdtvSE9iY+StMOtQICZXnMqyWupnjRbsNKuERqg/+I2DRwFIKutgDcAS
 ljxM2KT8eWsjfCkOXc4+KIBBSqmSwmigaaHeyuogjl86CqaKwL0soysPhhNWJMoSdIRLrTDRUnJ
 d7+EVzdN0hiEMzYoLKA==
X-Proofpoint-GUID: AQID8s-2FSmIl1hlb29K1KHK4IzkcX1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250084
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

On Mon, May 25, 2026 at 04:06:08PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 2:12 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:51PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Use the dp_panel's stream_id to adjust the offsets for stream 1 which will
> > > be used for MST in the dp_catalog.
> > 
> > Please start by describing the problem.
> > 
> Got it, thanks.
> > > Stream 1 share the same link clk with
> > > stream 0 with different reg offset. Also add additional register defines
> > > for stream 1.
> > > 
> > > Streams 2 and 3 are not covered here, as they use separate link clocks and
> > > require separate handling.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c  | 24 ++++++++++---
> > >   drivers/gpu/drm/msm/dp/dp_panel.c | 72 +++++++++++++++++++++++++++------------
> > >   drivers/gpu/drm/msm/dp/dp_reg.h   | 11 ++++++
> > >   3 files changed, 81 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> > > index 3689642b7fc0..295c1161e6b7 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> > > +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> > > @@ -332,6 +332,17 @@
> > >   #define DP_TPG_VIDEO_CONFIG_BPP_8BIT		(0x00000001)
> > >   #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
> > > +/* DP MST registers */
> > 
> > Which register spaces are they from?
> > 
> Here also from DPTX_*, what about this? /* DP_TX MST registers */

Why? don't separate them from the registers from the same space. Also,
please, name them uniformly. Why some of those are REG_DP1 and others
are MMSS_DP1?

> > > +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
> > > +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
> > > +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
> > > +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
> > > +#define REG_DP1_MISC1_MISC0			(0x0000042C)
> > > +#define MMSS_DP1_GENERIC0_0			(0x00000490)
> > > +#define MMSS_DP1_SDP_CFG			(0x000004E0)
> > > +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
> > > +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
> > > +
> > >   #define MMSS_DP_ASYNC_FIFO_CONFIG		(0x00000088)
> > >   #define REG_DP_PHY_AUX_INTERRUPT_CLEAR          (0x0000004C)
> > > 

-- 
With best wishes
Dmitry
