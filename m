Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DAECD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BF010E795;
	Tue, 16 Jun 2026 00:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSeN0OOu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4mRlDse";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3689510E516
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:50:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OGnc1914887
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TsWO5RKsXXTb8O5pD3Gd6mYwJkxB/CCBjeSsyoNO8kM=; b=TSeN0OOuwW8y1jo1
 3iUGlPwpkvqoE7selmk0CriKEsVoM+sI7CNME2juL5eq9nsT4+prpbbt95lqTZKk
 rP4/cuFLulmquL3kpPmtcbzU90AkmkIZqE/d29IHy1QsmdzI2ZS5eugNJB3MJQUl
 SYvq2l1PGXDhM4OeGjdUCxods0suhEYpplFvJaZVipMwyNylWkkoHdLc1FM5rF1P
 esq3shv2CsBHQTnBlxgsq+SSRhfgyZ/glcS8rwTpdA+odfjNSu6REJftRLUDXOSw
 YMxtH+w7uUIGepwwJKYuvX8xfsNuvr4VeP4JumJLEjX5y8XPwRgxe7v2FCCyk/Mq
 Tv8fBQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx3ufw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:50:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ce9de04835so26504056d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781571057; x=1782175857;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TsWO5RKsXXTb8O5pD3Gd6mYwJkxB/CCBjeSsyoNO8kM=;
 b=e4mRlDseZ+kTqe/0h32KfBKuulGT8NNPq90bmdfXGsckVLsIm7N+vry6dxA9zGtwIH
 Irdmk19W8p0nMBDmT1jbtWeKGbBL8JcFULSSkMMKt9j14uAlq0HNkfR2v5phRpKh18rB
 5zl2t0hlnUSV7KvjSUHDKK95uffRJ89J3RdecIMKAncUOk22rdAuvl/rRFyxn1bJ9dzK
 Vry9YWMMRZ+SSto8ARSS8HfpQsEvIf3hPGLP+UPgzfkDqTH4RNSNaBkYopzyBHg6ceyP
 x+/Vdji60hSIoMm+0xcE0aD14e53QJhFfdWana7LRHKpeyLq/DR310lXqcnS6g1nc+nV
 ixXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571057; x=1782175857;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TsWO5RKsXXTb8O5pD3Gd6mYwJkxB/CCBjeSsyoNO8kM=;
 b=mfXpkP+Mvow0Pqin1HRHHHKwjzBMCEy6muP5yNhw9UpeFPTJD5HUlSFFX9Z67r6AXz
 Azc3OpvMIxu7MXCy6DerDMgC4A3RTQXMdwzTnizzdNI1KkaJD81yUgzIoRelZMfCsq+e
 TEp2FnT2QvUJVfbXAKq2O9qS4nG6HTXcGiH5XYTt3047VeXSae/wgn1aiPPZ8XWWx7Hs
 vEQBdxWB/frwaKhPrX5MziVtqR0Q6fFxWncqBIFsXTOsC8mTUl7DkDwubluuvcLxZusE
 g/BQ+VBSvYC34pZhBoM9L9+I8+RBdX1tLJ1TD9QFrWYUu00GztIedmHMLR+uoB7z3jr5
 WGrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gEpKxN9j3sIp0bwFJHon4RZvzMF3+6Dn0ejXt0mfLe/PAuN5LlB/AAPLEvyxaPjT4ZBmC5nQ2oxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzggKTmeDUItGu93bnc5GZdr6igP2YXXjCk6o/pMydW0TXc3Kpx
 3bvxWzP7CoohnVEbYw5PYCrmY3gvgRqdGC3U/1wEbpvM6FnzgkimJ5I2fR4TabqiYWUswvNT1tp
 +dFifTf9y+YpUgmpuAv2UFdWHK4TBfQnszY9k76vduhgx4jgMppXo1/ZUiEEMMFk+tB7kjqw=
X-Gm-Gg: Acq92OHe9uH/vwwHTa2zcszlQ2b/nmJr7R9bJNKbfRWFPs7bjffrwCvUNNMCmqDp+Xc
 sDm+WRvGFRyEGYBpz+l5oonuhUodU/5Kj5UWf9JWR2aGese0cgSJC/yHk1Yhzj1EST7lBXThbUP
 S/zQgnDqXrwo+gB9Km7+qDIbUAfmrLTUR1ylDw3fvh0F4x5uoolJSgOIqt4iZbjs68lFGt7qzmI
 YIb7rjnkLwP5z5+kG9+L12uP4e3vg170bvHxfrQ+9VhFXhdqqbsaKQ0eCAYFcmYBmwR1cBBimQG
 173MRYrhmmi0zB/UseOflySyc92POh6EhWPrPmDznmT9HMoL0BebuAY5xsztehLXkgJ/mElQCRL
 sAnoLhmZ2Mij0vcBrPJlrJ0YllOimMJgi8ELhbw6PKDpWFTPDniVkSAqFAeVNg+Yf0sV2F5xWHV
 K+WsYURrC7WAnEC/Zt6KiANINAN10mSzfquw4=
X-Received: by 2002:a05:620a:1a07:b0:915:94f7:55df with SMTP id
 af79cd13be357-917f069deb6mr1959120785a.20.1781571057487; 
 Mon, 15 Jun 2026 17:50:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:915:94f7:55df with SMTP id
 af79cd13be357-917f069deb6mr1959117285a.20.1781571057011; 
 Mon, 15 Jun 2026 17:50:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1ae1absm3036997e87.59.2026.06.15.17.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 17:50:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:50:51 +0300
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
Subject: Re: [PATCH v4 37/39] drm/msm/dp: add HPD callback for dp MST
Message-ID: <t4ocbdrm4d3xlocycwnsgkcyyuaebfbkid73pxzel46nh724rs@wairidx7ct2x>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-37-b20518dea8de@oss.qualcomm.com>
 <ml35zldwr6f7euzmw6noy7j5mufyhfhmwoigkwq5ykyyl3amgb@5eo63mfnd4tg>
 <42c2bbab-dd86-4ba8-94f6-a6f377425be9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42c2bbab-dd86-4ba8-94f6-a6f377425be9@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 5HMKvOILQhUUcAUXzvjtXuSsv_U1sM6A
X-Proofpoint-GUID: 5HMKvOILQhUUcAUXzvjtXuSsv_U1sM6A
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a309df2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=gNI8i-zqcxB5eE8BvuQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNSBTYWx0ZWRfXw6IHVNGVyFtV
 KG9HmSil7tlfRDJP89gF2MUy7af7haUmKanOAA+qCkAItmEYamkwxBkOZICzHQep5aH7EvbHtZM
 HnQiHSoYCy71i40oeS9Erl1BgoZku6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNSBTYWx0ZWRfX4XDDqA/r3ItT
 FP3/lP6GuvJVdLAFeGUxJYfv7uH2qattm6QdzV6g/Kul5Uir6gi7wS40rW6+fhZrtG13+HgbYJB
 4IenVlFWH2fsr2nFjx6Q34MTwvkOJXli+a3iEPNvE+BcoMPTDuHt75PCzD57Ds83CjkFNRy5sxK
 36PzUUIAR7NyGwj8n3o9jKhXHNr6iwwbS6uXJXjOBADx5U7J//2iMvSSIw5lebehONSKPJYAZS8
 5mP+KAFAfygXfAl8k1KSKPPruCsM4b6SAEog2ZGwaybNI8fYkXMe3MVduqLHLxEwwEgM2T2C9SI
 A9wmjkLcJNE8F1H9GoqE5pGn6w5MPtMWrUbnx+bDy0rYHIxHXjPVxpPfipOA/yAAPkF0aJKalI0
 AXK+N3RtNb7rUBYIk5N1Mz/ys/O+ZlGNOKsFy+SA6BATc0C5wrEPEmTfWWN5hsWpFy4fqqVwJMJ
 guLMBk30vJEQyCVPdpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160005
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

On Mon, Jun 15, 2026 at 06:05:07PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 6:00 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:34:12PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Add HPD callback for the MST module which shall be invoked from the
> > > dp_display's HPD handler to perform MST specific operations in case
> > > of HPD. In MST case, route the HPD messages to MST module.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
> > >   3 files changed, 54 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 919767945ba5..ca89e20b7563 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -454,6 +454,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
> > >   			dp->msm_dp_display.connector_type,
> > >   			dp->link->sink_count);
> > > +	if (dp->plugged)
> > > +		return 0;
> > > +
> > >   	mutex_lock(&dp->plugged_lock);
> > >   	ret = pm_runtime_resume_and_get(&pdev->dev);
> > > @@ -556,12 +559,19 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
> > >   {
> > >   	u32 sink_request;
> > >   	int rc = 0;
> > > +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> > >   	/* irq_hpd can happen at either connected or disconnected state */
> > >   	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
> > >   			dp->msm_dp_display.connector_type,
> > >   			dp->link->sink_count);
> > > +	if (msm_dp_display->mst_active) {
> > > +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
> > 
> > Will this work for USB-C?
> > 
> Hmm not work for USB-C. We can remove this check here, as the IRQ thread can
> handle the disconnect case itself.

Please. Start testing with USB-C too.

> > > +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> > > +		return 0;
> > > +	}
> > > +
> > >   	/* check for any test request issued by sink */
> > >   	rc = msm_dp_link_process_request(dp->link);
> > >   	if (!rc) {
> > > @@ -1125,9 +1135,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
> > >   				      connector_status_connected);
> > >   	/* Send HPD as connected and distinguish it in the notifier */
> > > -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> > > -		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> > > -				      connector_status_connected);
> > > +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> > > +		if (dp->msm_dp_display.mst_active)
> > > +			msm_dp_irq_hpd_handle(dp);
> > 
> > No, don't touch this code. HPD notifications might be coming from the
> > other entities. This IRQ thread can only send the HPD notification.
> > There rest should be handled in the notifier.
> > 
> Ok. From my understanding, after this series
> (https://patchwork.freedesktop.org/series/164954/#rev5) is rebased, we
> should use drm_aux_hpd_bridge_notify_extra() here to notify the IRQ?

No. There is no aux bridge here. But yes, I'd need to call a different
function in that series.

> > > +		else
> > > +			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> > > +					      connector_status_connected);
> > > +	}
> > >   	ret = IRQ_HANDLED;
> > > @@ -1793,7 +1807,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
> > >   			msm_dp_hpd_plug_handle(dp);
> > >   		}
> > >   	} else {
> > > -		msm_dp_hpd_unplug_handle(dp);
> > > +		if (hpd_link_status == ISR_DISCONNECTED)
> > 
> > Why?
> > 
> Let me explain this in more detail here.
> Currently, MST hotplug and IRQ events are handled through the SST bridge.
> This guards against spurious unplug handling caused by
> msm_dp_bridge_hpd_notify() being invoked from non-HPD contexts where status
> == connector_status_disconnected does not actually mean the cable is gone.
> 
> In addition to the real HPD IRQ path, drm_bridge_connector_detect() also
> calls drm_bridge_connector_hpd_notify() to broadcast the detect result to
> all bridges in the chain. So a single physical plug-in produces multiple
> msm_dp_bridge_hpd_notify() calls — one from the real IRQ, then several more
> from various probe/poll paths. Stack traces from a single insertion on
> QCS8300:
> 
>   1. msm_dp_display_irq_thread → real HPD plug, status=connected
>   2. fbdev probe triggered by (1) → drm_bridge_connector_detect →
> status=disconnected (link not ready yet)

This should not be happening. We don't use link status anymore to return
connected status.

>   3. output_poll_execute worker → same path → status=disconnected
>   4. drm_dp_mst_link_probe_work → same path → status=disconnected
>   5. output_poll_execute again → status=disconnected
> 
> Here not work for USB-C case yet, I’d like to switch to using
> drm_dp_read_sink_count to detect whether the sink is actually disconnected
> or no sink devices.

drm_dp_read_sink_count() isn't enough here. See the plugged flag. Maybe
we need more flags here.

> 
> > > +			msm_dp_hpd_unplug_handle(dp);
> > >   	}
> > >   	pm_runtime_put_sync(&msm_dp_display->pdev->dev);

-- 
With best wishes
Dmitry
