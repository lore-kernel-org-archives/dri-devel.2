Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136F3F9D0EF
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4569810E089;
	Tue, 14 Apr 2026 18:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ck2aewBP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DRMlZ07i";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290E010E089
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:43:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EHvqGd3059047
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w8RtLPSozU52UhmvNz4FrnHnwFB/QlA4/KBpy5nfkaY=; b=ck2aewBP3jiXTX3+
 1LmSPXOxOB514JUhaaK+g4DciQRp1eXcblXcLDmA03NBzRvdNaVg6Y9wqJzUzeUy
 Uvb/8CI7vpGuM9u8488tVPn6PUkiKU7I3GQFYs8HmrLdEM5nXGdMp3MUKCKd470Q
 tEkmDs7sX6hX/5yU/d0U+s7vmP4PzjV/2aUA+HQ/wm4gKt0D57lKxds+CWSudR5f
 S6YC9j3O0nOAKN4vTik6jRoirSMUnJ+rk8SsKX7YCK/rbDtPzjU0MMxe8woMiuU9
 S27DZtRfX3FyTo3gWGeVQlCSAkyeTYzSXorSI5f5f4d7xtWngdyr2bPUcIF2xE9r
 AtNoOg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhtepr5cv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:43:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso147710171cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776192186; x=1776796986;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w8RtLPSozU52UhmvNz4FrnHnwFB/QlA4/KBpy5nfkaY=;
 b=DRMlZ07i5ut7XVhqYblGGS+Do+VvALXaJjebAf7//2ayO/c0lqWuOHVGz2XbP8swAD
 KYdSO44POO9AGTClzTaX3mgpIFrS7Kw8bQW6Kog6kaBw/mUza9cUw1Lv8ILPLl8SK6qX
 7jKg1k2UN7BvIK3wyHCAoTGRtLJv3I/Dpq2q+2/HoE60cEAfY0SCJx+J13sHM3/aze6K
 eRLuedL18k7xh2KQK2YQTRudGCRjsUYrpQD8dHT4Xuz43pF1kkdl14lKHA/2YIOuTyLu
 3OTb0RZtidqZviRdeRpHPQfeUVqng3CNqvQyP1Y+SYJx0AX+8lhiuGkLg4rCLuVak2mm
 1zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776192186; x=1776796986;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w8RtLPSozU52UhmvNz4FrnHnwFB/QlA4/KBpy5nfkaY=;
 b=ZVTKbDyT6IpNR+7PJT2PzYXrp8WdUE0Kyaq5su15KxvRhah3d5SxKepMaGaiiIjBRE
 fam90Rxcu3K9OD5drvaLX34GNEL9jqjLsC384+tSVwrhvHlmKsjD9wcQMqwpC7NfKg7V
 cA9ZeV06g6+7MwM8SCiyujZA1uQvOm2Nmhun6uTS50mpeMmXGPQPUiu2AzTG+Q+net18
 fdFQnbKBwAnrOUFlL9d0AUotqXbRRzfUIqNUwKgb5wNivni7JGmayGfl7qkVktsWLU2K
 YgjXGHmiN7c53xtgtGLLKnOIZtOpJ1bZzLpKoUrHZ2QjR47efbPq1ZY0bhU8QAWWxpbL
 AuYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MCsGN8YStMPP43xVDnBTA3tZXRtaW6vrgVqfkEbUO1SjRmOwp6sp/hyXQGJ30xXADBqYDk9EoW6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5ZWwuejiJs4nEYWhdkpOJLXPUxy8J4pvely0VE3QNo8rinTlD
 sK9EbdQw/g938MdWe93vQLUyxAPPmEZaWCs3TF41o++ME3jwllO7GJCgGzoMjAJb0eZSvcpcGXq
 XeEcjqswklOPYxzpjYLNePJDFhN1f8SW6pbaVujCBima/F5gZ9pM1Tb7r2diaRjynliyngBE=
X-Gm-Gg: AeBDieuZQnvyaXFR6wXSyTi9AxifMAyvcR8LUowReLVLL3CrZDHN1MJkU+4qHAsGqgQ
 Tp9Z+r14NfhwzLC9zVAdzqviR/S+HpYQ7e+wmUjPTQqEfbcQL8U0mCSnfTV1GyuTcJVNLpq/v1H
 a8I1fweRPemmClZodmtbGjiD0Umm/d4IBkwZHUqpoH/cirkmK/w2kYFdE9Wos24kvA1vrXl3C5/
 PQX/QvScZj1n2p/g+G8RRVmVZkaATClbjZEdf2/UsQRxrjt47LlM7aIDXcSP0NB11bgbp/I2xsB
 rpz4oFj7YnEEWuzO5E12bu1Eq9OBFcVsdPMoy1zTANA1cxfUJrHkaBd9GY5jmDXlKTRU6bx32q1
 jPo24eVHAoXDjmZMwb/7unr8gkVuJEtkTi1KKuhcdKfVE3Bg8Te+eorFHAi+vXJq0qxctTtuRBk
 pEuvP6Znh3b17UfiTWNoAS9aqte+DsWuHXIzXJinMpW8AGCw==
X-Received: by 2002:a05:622a:9:b0:50d:7b0c:35de with SMTP id
 d75a77b69052e-50dd5c74756mr283929391cf.44.1776192186403; 
 Tue, 14 Apr 2026 11:43:06 -0700 (PDT)
X-Received: by 2002:a05:622a:9:b0:50d:7b0c:35de with SMTP id
 d75a77b69052e-50dd5c74756mr283928871cf.44.1776192185902; 
 Tue, 14 Apr 2026 11:43:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e81fe72ffsm12355161fa.6.2026.04.14.11.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 11:43:04 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:43:03 +0300
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
Subject: Re: [PATCH v3 31/38] drm/msm/dp: add HPD callback for dp MST
Message-ID: <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
 <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
 <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
X-Proofpoint-GUID: ppObb7VDhfTtYgDa3L_ZK9XNH_dh1DQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3NCBTYWx0ZWRfX5OEq6MLEDjYE
 moBFiF/HM0KxNeZRFkMYWrVVVS5YdxGOJPOyTsTI6ekhIqo5C1qlo7Dy+Y/IXmDvJ0Qk17ZXWWO
 McYAHlvoZRnXvSLR9gWIYo4zTwcuPMgJ60YGC2e4iUqxJWulrc5AnYoafL0D2PyeOEf5rvxijKO
 +ILyCZz9e0kQSUX2oRTlsBkO6tDHx7u2NEcUsE+hGay4hM0R1ToSMiI1aQ6DUuVmSZ+0VIzSiwP
 6F++2NaGghM67/H2rvaZLM6kb7XNwA++rDRGuMEkn9b92I7N3sjBRrnvJVPXF0j9IkzO9AbO+ZK
 j3MBUvloW2rMbfw4Ha3eGuRidIoI8t6Gfczk/kESWr6iYJ8NV7c9eg/ZM2igdjUNp/id0COKAzB
 zxeMyol/ErzG7zVk5Igr4QyD/iwenwYHAFAq7jbfDj3cFUCFPmyy5pPMJLcqqHDn+16/NKDhWif
 /4W3djYYf585LhslrRA==
X-Authority-Analysis: v=2.4 cv=CoGPtH4D c=1 sm=1 tr=0 ts=69de8abb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ZMo_a_pv_yQQi4daUAkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ppObb7VDhfTtYgDa3L_ZK9XNH_dh1DQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140174
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

On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
> 
> 
> On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
> > On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
> > > > On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Add HPD callback for the MST module which shall be invoked from the
> > > > > dp_display's HPD handler to perform MST specific operations in case
> > > > > of HPD. In MST case, route the HPD messages to MST module.
> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
> > > > >    drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >    drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
> > > > >    3 files changed, 48 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
> > > > >    static int msm_dp_display_usbpd_attention_cb(struct device *dev)
> > > > >    {
> > > > > -	int rc = 0;
> > > > > -	u32 sink_request;
> > > > >    	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
> > > > > +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> > > > > +	u32 sink_request;
> > > > > +	int rc = 0;
> > > > > +
> > > > > +	if (msm_dp_display->mst_active) {
> > > > > +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
> > > > > +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> > > > > +		return 0;
> > > > > +	}
> > > > >    	/* check for any test request issued by sink */
> > > > >    	rc = msm_dp_link_process_request(dp->link);
> > > > > @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
> > > > >    	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> > > > >    		msm_dp_display_send_hpd_notification(dp, false);
> > > > > -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> > > > > +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> > > > >    		msm_dp_display_send_hpd_notification(dp, true);
> > > > > +		msm_dp_irq_hpd_handle(dp, 0);
> > > > 
> > > > Why is it a part of this patch?? It has nothing to do with MST.
> > > > 
> > > Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
> > > I tried an alternative approach by calling the MST IRQ handler from
> > > msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
> > > DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
> > > msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
> > > could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
> > > However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
> > > MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
> > 
> > When are the link status bits updated? Please remember, we need to
> > support all three cases:
> > 
> > - Native DP, native DP HPD pin handling
> > - Native DP, DP HPD pin not handled by the controller
> > - DP AltMode, DP HPD pin not used at all
> > 
> > In the second and the third cases we will not be getting the IRQs.
> > Instead one of the next bridges (connector, EC, AltMode, etc.) will send
> > the HPD event, which lands in the .hpd_notify() callback.
> > 
> I added some logs and did some testing. I think
> msm_dp_aux_is_link_connected() only shows the current HPD state. Since IRQ
> HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_INT_STATUS
> in the IRQ flow, the HPD state machine has usually already finished pulse
> classification and returned to Connected.

But the IRQ should be sticky and it should be readable from the status
bits.

Note, in the USB-C AltMode case the HPD machine is not used at all.

> 
> Because of that, the condition hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT
> will usually not be hit.
> 
> do you have any suggestion that in how to distinguish between an IRQ event
> and a plug event in .hpd_notify() better? We probably don’t want to
> introduce another state machine.

Then, I assume, currently there is no way to actually distinguish those.
The easiest way to handle the replug would be to store the current
"connected" status and verify if we are receiving "connected" while
being connected or if it is a disconnected -> connected change.

For a longer term (and granted that HDMI also has a notion of HPD pulse
events) we might want to extend the DRM HPD API to pass through the "IRQ
pulse" events as is (instead of converting those to
connected-whilec-connected events).

Let me sketch a draft for that.

-- 
With best wishes
Dmitry
