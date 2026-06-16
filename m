Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFDACD98DE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CC110E699;
	Tue, 16 Jun 2026 00:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqIpPNgS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JXJmx0OC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358A10E25E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:41:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OQwI1941101
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ja+WUL/JeEMUp3C7V9cZu6IMQ7GDhDQOxcuPvhdlOiM=; b=cqIpPNgSclclA99u
 n5INq/3dtExF2V05XOyuXC/wB2KFDLDGT70hVu99ztcMD04nnhcHWCzA6GEj3CJ/
 Whdjl41iv8iW+NncOxHZ9SYRxH7xE6vKgcXMRAjAVS7oWC28GSXjDFc1CFZXZyyx
 iKM4T7IKzAU+mI7hE5/BDGlGMcy5HW2JYQgGRRiY7eAIMbmCC+EfuiAu/3thcuT4
 1h5dTyHRDDEwe+8+nqh3yQJDPiDfJU14Hc0UnUYNSyzGlQ+k5mZF5rWHerp4KQE5
 3nMZ0NSMnNExuqH2onu1vg2oOO9lgJUpUstc1M8b0Comwq9xEo4gaHJO1idVUYPL
 9JMleQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf3s1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:41:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91574ad681eso615289085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570484; x=1782175284;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ja+WUL/JeEMUp3C7V9cZu6IMQ7GDhDQOxcuPvhdlOiM=;
 b=JXJmx0OCGjC6bcnMvQa/wfPfwE+XLgKgpx8pksypC8/R6MjgEB25V4RyFw0XBW1J2U
 WttGVyPBXmE0bbhHV0PUOALzxzn0ln2CJHNmuiyz4uxt89OGe4CqMgsJdzWdrHAcwvux
 3jFlR4zFhfN/ePdjSTMHIv0elaEWJ0dxYpyoHUwqcFEK/AuuOqQ7Ah4GIYWNaqVk3FZC
 Q4dnN27zRnSsp2yl4hvLuumL0vsw5508seaVKQbexHUG9vpx5Hfc7Srdq/qRYwuPPO8I
 bQND2X8PTfpf1u32FcxTVAcF8kqgNojMvIrANaKxPQ++J3BdmNn2zlFddTp4JVdKTnzy
 oDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570485; x=1782175285;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ja+WUL/JeEMUp3C7V9cZu6IMQ7GDhDQOxcuPvhdlOiM=;
 b=WEzZgZusjucCN0ecR8JUQdp3jm23VYAjoctBKwG0/nJ/WusMRSIXPoxqYqcxRIBQNa
 Piy07VN1YAIZ8JRaSB1X98dZtPLGLH1hQ0vRlb9OVeIrsNaWEeqtc22QZiGR7/0h0J9W
 lcw4ZnCJ6EASvFWstBWAQ1lEChd4ljrYcV72Cit5anPWD0I8TbKzc9bhIANstMQEjpSQ
 RAA9/9OOFp7OmoNnY7mARc6CP14fm7hMoH8gY8phAEqO/O+b7zw+3ZR3NQEUhLIKQgXo
 E0jzsTPszvAKVBzr+4vUPopMi6UrcuLxDo4FWRw43ckpFAukVPtAyjiyjmKnkstFqcDW
 S6Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sgDLH4qhW9FWQ9+/pr9amkuMcIs2K0yJEhQOOf8Yi5PoA3a9BMQ4PEfBPvhpaeS83ynMEgzKoA+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSSaQ1803Zp38ltIqMXWINSza0ItNCbMZaX9mthV05RkXcVP5X
 BA1l8ScPSyDKiBezhrxVjw6us7J0qg5hm/PHEJ2QThFudr5ZnmWGGmLoSBF7/T4hXiPa4xUzGl2
 Y4nKNY3CNLuxNTdX2Czg4LJh48JfuWDov1tNVKxJcOZgi0TgjG3Hf+YJE3tnyAZo2nLxcKWQ=
X-Gm-Gg: Acq92OGSzLgTZtKp2eFQUzvYd3fLzvGfMJbSYDHZO5EX8vZ75HxnW1axFQAY8NcWFoY
 dtk4l0gp5atyh0vnwiCPq1koHiKTdinmrZ5U+WRNLmgcd82++1ZFHQuPZuc4/kTBpiDLKX6ytEb
 QNmfrQHHlF69QOzjoejdd6FYIlgdhc3Hep+bidWHlf1uIINyY1oLFTBis/fXwKYcsoLrmirsTj3
 HbohjrDkRwIg9AYfvH0m7MkjtdzDY6c+BPjrWCPUoW1mOB2S6S8ZswqYbIJCmi9XISzCm+545S3
 8O3AKUDfwF5djrSpzyMnAi/63sphP+hfy6YuLtqcOTo0XA+uNUWHP4b8dzzt8nmmyeZo7OcAUa/
 BBlAAZrpl3KoS7DFzXUDNJfESGD+Ahih15bYMF06NtcuYmkklYGU2caTcyrIo5Ec0tNUzbGsRTz
 3OKrbZl1uzaWFrJOX9srfOTh3ID5Rmf6ZTwg4=
X-Received: by 2002:a05:620a:bc6:b0:914:b65f:6b00 with SMTP id
 af79cd13be357-91c45513091mr266707985a.6.1781570484634; 
 Mon, 15 Jun 2026 17:41:24 -0700 (PDT)
X-Received: by 2002:a05:620a:bc6:b0:914:b65f:6b00 with SMTP id
 af79cd13be357-91c45513091mr266705485a.6.1781570484189; 
 Mon, 15 Jun 2026 17:41:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1b08d4sm3053588e87.66.2026.06.15.17.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 17:41:22 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:41:21 +0300
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
Subject: Re: [PATCH v4 18/39] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <hwomujvf4h6hmyk3bu2a26k4ck26aggxbkovf36hdilk72zfcs@c67fzpbpx56c>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-18-b20518dea8de@oss.qualcomm.com>
 <6jkqen322yklhb4zzoj2kcgwayhcqm3mhnbrkgimr7zubwewao@gmuopu6uxakq>
 <49131a73-f60e-4296-a6d4-5ff59331a9dd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49131a73-f60e-4296-a6d4-5ff59331a9dd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a309bb5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=UKJBJXdgpxAKM_2I6NcA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZtNrh8xdCaNQMtRsAuWk3SM8AOOLfu7V
X-Proofpoint-ORIG-GUID: ZtNrh8xdCaNQMtRsAuWk3SM8AOOLfu7V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX2+AyjOEoxvP5
 Jne0wT6wsmFfFblLlk3VRVzJMmbUMU57nDyvYye1kyvdIW4q8H1DgqhxgTfAqNnK/TCLkOVr7To
 LOVulQE5MurrXdfVlIlstvo+XxtwHyk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX6IJw2KqipL0L
 +EBw5ebapltspLe7cX3zytKimsMfXrUWgmvq3+XPyUFJzsY9lheLalCYq7wJetVf6u6t8LSp7R3
 Xwa0Z7RxH9ffMfSbZ6lI9pFfbF48Q02i5+QtdFz4zBsxvolxmdBwEFPi3+LTWz/Fq3x+jOh8R5+
 8B9Zl8pG908pwSh+1bU2M5rrHRNbYzMSVn50a1A8gCh1hD3EtXwKktDqjkJCSo77GVJG+GZUdt8
 nttuwUjeuthr2l4y4/pyvBrcrg7djTOwDsGxS6CV8/onmwX+P392SCePTC3RIsRSp4nvmW6dEnk
 bc7unYiDUWNOxo5NV+1DepnS9s402eBupRimdHC5dPKvI4P+PhWl9CLoRtLEymQaRKWtNnZJaoK
 +SvJEUCe+afIy+tFz8plOHVeVuOIQj0D8hLMb40YUP10QxUdAA3qKPmffokD27impRU0YmJTgBH
 OrIJpZowLjzlCOd53XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160003
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

On Mon, Jun 15, 2026 at 04:21:14PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 2:57 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:53PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Whenever virtual channel slot allocation changes, the DP
> > > source must send the action control trigger sequence to notify
> > > the sink about the same. This would be applicable during the
> > > start and stop of the pixel stream. Add the infrastructure
> > > to be able to send ACT packets for the DP controller when
> > > operating in MST mode.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 43 +++++++++++++++++++++++++++++++++++--
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
> > >   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > >   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
> > >   5 files changed, 48 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index 1109b2df21be..6f25145ef214 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -143,6 +143,7 @@ struct msm_dp_ctrl_private {
> > >   	bool core_clks_on;
> > >   	bool link_clks_on;
> > >   	bool stream_clks_on[DP_STREAM_MAX];
> > > +	bool mst_active;
> > >   };
> > >   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> > > @@ -228,6 +229,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
> > >   	return err;
> > >   }
> > > +int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
> > > +{
> > > +	struct msm_dp_ctrl_private *ctrl;
> > > +	bool act_complete;
> > > +
> > > +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> > > +
> > > +	if (!ctrl->mst_active)
> > > +		return 0;
> > > +
> > > +	msm_dp_write_link(ctrl, 0, REG_DP_MST_ACT, 0x1);
> > > +	/* make sure ACT signal is performed */
> > > +	wmb();
> > > +
> > > +	msleep(20); /* needs 1 frame time */
> > 
> > 20 ms is 50fps. What if we have 30 or 25 fps?
> > 
> This hasn’t been considered yet. Do we need to change this to wait based on
> the per-frame duration of the mode?

I don't know. You wrote that we wait for 1 frame here. Why?


-- 
With best wishes
Dmitry
