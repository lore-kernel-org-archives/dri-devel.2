Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9B7CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4801610E6E4;
	Tue, 16 Jun 2026 00:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFA7giUC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FXlXt6lx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BFE10E6EE
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:45:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0O0eJ091280
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yjMiqxVc8eOO/stxC6osTkMjw8kH6o+EomigNC09KwI=; b=IFA7giUC3jxXpCFS
 KB2vvCSn3udjKUgRD2et6JXMxTnllhdc4RJJWGaXtnZJbO923DGHwJUjOvcLhOie
 +T/q3QWq8S1jx07pzh55W8aJsMeDR/nc+DZwmdbP5E3KCbdx/swIEa1doZ3i0hhs
 nAw3pfz4p/k+hVAJbwUCNXvQUy7f4hBeMo61L05A/civK2tWowq8i+Jig7eAWlbc
 BjHckQaoTHbf+F8YtWzrFz3+R9FGmJRmSY2QmcuWc/OCb/K6jUrLIXFKAcI56euI
 Tvzaon8Jk/xELeyHCMR9U8WCWNGM/DPlDivUPJbjQl5yF6mrzCSk7jMCwV8/+cNp
 yMI5rw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete983ycr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:45:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157de5360fso907029985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570757; x=1782175557;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yjMiqxVc8eOO/stxC6osTkMjw8kH6o+EomigNC09KwI=;
 b=FXlXt6lxdSZmNyuownN5UUP23nlZ+e07E03U9NMxnAyLxr0q3nty/YaNYLzM0xaRwn
 u0FBi0GBdlHzW0K+CSas70rZZQKOsIl+yYTJTchl/T1oEpP541dFdoBmyJE0XURaZPGP
 IjwvlDKB1wJ0FfUtgGDy8SRIudA/bXgD9grBtKpvORA/h0wHsp4USoLqhKewDb22EihT
 MgoN5uME27oSso66wdHU3YBH/bhLFZKYva33R9W+qTg6N83F3ofocFE8cqnPZ1wKGd2E
 u0p4+I35pDf7sDXPo/9k/5tntWrpNZc/chKBcNshuUrqrniwjUxbUUZCWaz/x+jkKCG5
 0w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570757; x=1782175557;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yjMiqxVc8eOO/stxC6osTkMjw8kH6o+EomigNC09KwI=;
 b=kYRkqQ4cqyF6poW6aYHSnS+nhShvu6n9+y7Id7LrxMr1FSjJkGMukydZTT2E33yURd
 Z8gr2cIvsHQRC+F4gIguz3McY0qrHPtIyfBPyW0XLh8rtToJCYcLDbrNmIjGliUV/En0
 3ureJgScekolepp6FW8UjyZgwH5OLz8WZatj9vdI1RX4tMqfa/7gIWtenXSZjIEMvFKk
 /1F97HEptFmSc5FQxdOHjvVHvxLd5RfErzwB9JUj96FJm7G14aW4ZO95Sy6xGeeu9OiE
 lpT0wBQHu5o8HYbd5Fv1lu5VlDohlMIOdzBg9m6dwCgsPCtYjfWXOXLjw5XJJH/UaoFV
 tMpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kEQSefvf35xPNsldwzkhikf7DAQHQ4rm6g9aduFzGxI1EGCWdP5denQjer41o2iqgkh0myKlwxhc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOp0aEUw7duufV+ZvJId1eUt8iKZPvURx4Q9KdolCvxQD66Xw7
 hXJWPu3t+dU6nCd9czIrj8UwlmHdEDJHy+J91UhVn7PcFueLbatV0auMDXsyDTkN1l0d7JShP4c
 33iOxcLYK8SEoM2xe+u8lgNvAxMjYxkUBON9ww+WKG7upHhnWj1dX0mozXQjFNf9VeT3UFQA=
X-Gm-Gg: Acq92OF1VHf428kLMmeJPN8oblpAfrJr4OkkPTTBgl1iJaHwEnvPsv+JtYZ2BScJuQf
 WJN/9sQuRPDiZNPaubEEuPlSCzFcRIXgfD3/j46xFW3RndKa8IhzsNCnhxFGDmlXHqrlds03MOR
 XluYzvrfeqnWKVEOvD91zW21sp704vfY/FSg9sLbyzkjdPO4NywB3+qtNXIXmaR2cTvl6Qbjl4n
 wGspanxgEjr/YpfrsV6dgLA53DJ9qKywW6GDp/tpS21Roqm0LQpgcJbuVjY4jVM1yqLLCKGLRrk
 A2Uc4nniOEb8REo4KreaK8/nD/XJt/jO5RTjzBT+YugsKbHm1vISdnBGhyL571qrxulNOSkUCrq
 uO1h4ZZ5o4sn6U/fBOEwyffazxurOSMuN6nj7H8QhkG5PS+fqEhJv1zIZTojy2L+2Wf2WIuDRF8
 Sy5Mx7/+FaCZZPjrsP/JEm8SBHWeEQgAifJkY=
X-Received: by 2002:a05:620a:179e:b0:911:e11e:dc0d with SMTP id
 af79cd13be357-91c2e9fe4f0mr247241085a.24.1781570756819; 
 Mon, 15 Jun 2026 17:45:56 -0700 (PDT)
X-Received: by 2002:a05:620a:179e:b0:911:e11e:dc0d with SMTP id
 af79cd13be357-91c2e9fe4f0mr247237885a.24.1781570756332; 
 Mon, 15 Jun 2026 17:45:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e171788sm3061583e87.35.2026.06.15.17.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 17:45:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:45:52 +0300
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
Subject: Re: [PATCH v4 29/39] drm/msm/dp: add an API to initialize MST on
 sink side
Message-ID: <kr6obgjfl3c6ggbzkb54pyb4zevcmjvhlq4xho2yej6kynj6t3@36kxpiliyt2u>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-29-b20518dea8de@oss.qualcomm.com>
 <32jtwnkusxultvsgvnalrvccfkcyk7744yf4d42pqm7wudysvt@l4pnrzfxh2f4>
 <1fe8d286-7182-49ed-b6fc-dfa3766f851a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fe8d286-7182-49ed-b6fc-dfa3766f851a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a309cc5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ftLlCC17uhUtI0jg2S8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wbvDl5XQ9Xg32Gjmlt0ccofpAdK10kBR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX8iSC8iGTEbQQ
 absjCA96G4HalIW99O3UR2/vBcDq938Uk+oqnUp029NDouiYubw6Aqgpj2OTWLd3ZTopvw+A+gr
 6ZMmPwbZE3XIUEZq+xUsassZz4BfDBY=
X-Proofpoint-ORIG-GUID: wbvDl5XQ9Xg32Gjmlt0ccofpAdK10kBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX4V9jANf8BXSB
 h8MWGeT4ctM6wHXjmUZK83u40ov26k0F2vDZ1Mz8heCurylzPjO8FGati9ScqnO6FsKYpIlSX10
 gpMApps7+rW6auCUgG6cahQ9fPSdTXPLXbKDoFxDRmgzoR4d8DFo5X3AZQq0E1uUGefhgsZxNfG
 G/9AJ5GHDhLLBH1acYdE5zbtPuBXTU5IXUWwhzkK4aXTki0UJXRKcOMCNPFAzQiZkAIrjiIkXWY
 GEdC8XOGg6VsDnF7gKZnVUI5HHKE2UnpAN/6gtZPNg7kT4twd5YWYv1HajBObIa8VlOXQBTPlRN
 /fO+Xj+2Wf81T0pOyXsSe8P+HQFLddRZFJpYz1Qu4fLNnLCEga2YzqJ6W1DlH0xrVQGN0s/tsNp
 AYxTSG3aCZb7u2aa+WgbJLH6BIZca8ob/5QL4AScvgoE8SxLUKLlfDZl1OaMpAxoq2mTEB9Gq5j
 /ByMRnefWH9RID/yW9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160003
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

On Mon, Jun 15, 2026 at 05:02:27PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 8:15 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:34:04PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > If the DP controller is capable of supporting multiple streams
> > > then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
> > > DPCD register to enable MST mode.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 57 ++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 50 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 8ae690ce2b9f..abf26951819a 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -14,6 +14,7 @@
> > >   #include <linux/string_choices.h>
> > >   #include <drm/display/drm_dp_aux_bus.h>
> > >   #include <drm/display/drm_hdmi_audio_helper.h>
> > > +#include <drm/display/drm_dp_mst_helper.h>
> > >   #include <drm/drm_edid.h>
> > >   #include "msm_drv.h"
> > > @@ -270,6 +271,40 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
> > >   	return lttpr_count;
> > >   }
> > > +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
> > > +{
> > > +	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
> > > +	u8 old_mstm_ctrl;
> > > +	struct msm_dp *msm_dp = &dp->msm_dp_display;
> > > +	int ret;
> > > +
> > > +	/* clear sink MST state */
> > > +	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
> > > +
> > > +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
> > > +		return;
> > > +	}
> > > +
> > > +	/* add extra delay if MST old state is on*/
> > > +	if (old_mstm_ctrl) {
> > > +		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
> > > +			   clear_mstm_ctrl_timeout_us);
> > > +		usleep_range(clear_mstm_ctrl_timeout_us,
> > > +			     clear_mstm_ctrl_timeout_us + 1000);
> > 
> > For 100 ms you should be using msleep() instead. But where is that
> > timeout coming from?
> > 
> Will switch to msleep(100).
> 
> The 100 ms is an empirical workaround carried over from downstream — some
> sinks don't exit MST immediately after writing DP_MSTM_CTRL = 0, and
> re-enabling MST too quickly broke topology probe.

Comment.

> It's not a DP spec
> requirement, and other drivers (drm_dp_mst core, i915, amdgpu, nouveau)
> don't have an equivalent delay.

Why?

> 
> > > +	}
> > > +
> > > +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
> > > +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
> > 
> > Isn't it too early to enable MST? (I don't remember this part of the
> > standard).
> > 
> No, this follows the DP 1.4a MST spec. DP_MSTM_CTRL must be set before
> topology discovery. Topology discovery uses AUX sideband messages, which
> don’t require link training.
> So we enable MST first, then discover topology, and only do link training
> and payload allocation later in atomic_enable().

Ack, thanks.


-- 
With best wishes
Dmitry
