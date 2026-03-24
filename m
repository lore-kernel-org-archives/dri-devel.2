Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1671FEC0FA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2794510E5CD;
	Tue, 24 Mar 2026 19:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VviMisEE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izvhe58I";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47AD110E485
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:30:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJObBZ1862785
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=S+PbwUMOw7pk5C5b6YJ0/miz
 vuh+S+o9r8O5lHAOY9c=; b=VviMisEEVTf0JQKNMXS5THdDgVHtrunJMAsx/rnf
 0DpEOxKGmTEmKBgp0trY1pfHeYJSVMHbg/Bfj3inNmShCikoFbkT55vXin9Gx9ez
 bkCMe5Vc+zfTUzGm/6ZL0WoVj/vZpnsquH47FWKpAQvoOYIvs8uUbHDrExiUiBsM
 ekEcB0sD7RZnSNP5SHLjvJp4GS8+JWJnZI3o8VJLpBR/24z6atamUsKAjli91ZM9
 IdeHFzAIiEXOep5BXt/WUIWljube/c2ztJnNlhDVus1yh8+lA8QM/ESkdzUEJXTB
 lCVKHWyCRAvK3MLIQU9iFzvDQHAQGJANyxmiUHpq4UsDYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rar0j4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:30:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4987c698so10632091cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774380619; x=1774985419;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+PbwUMOw7pk5C5b6YJ0/mizvuh+S+o9r8O5lHAOY9c=;
 b=izvhe58Inan2gMbgrVo43Ae9dshFf3DruWoxIGewpUEZguh5sy/cNxyAoO7OoReJ8z
 hNBoVBjTqqREsmcnPdbyHDQqybM3CRmNQOOq9a/3mBFUB/71suckzvBM5sm2FJGU9p6u
 O5Ts6v6wRP+iI5ygjMa5sxyBBGtrH8vlf0x4vCihMPAe83ZbIHMxmbRCkiLhJFMBvi4S
 yAinBXLl1ZcgvsD5xSJkUQYwl4ITKMrdpv1fY6fl2d4LSKCUQA419AHvW28a9qy/cepv
 CEMtqiGSOz7FOwKGbwybDZzVjl8Cg0KDgFWq/Oz3jGh2ijeoh1o0lJ7xOEG0MK11L4Om
 mDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380619; x=1774985419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+PbwUMOw7pk5C5b6YJ0/mizvuh+S+o9r8O5lHAOY9c=;
 b=NFD7koEq/GXC1d8OIUNmb97xCull8fWMqlD0VIsU0vTPDaHU4RbmUhShJEyiy+5+ik
 4rJFkkF1Fk+1viqyh6RuZcT0jeZp6Ojc7tEls0cPZAtsTxlPn+aa3TiwulThukI/chtp
 RCiE06uIMh0E5fo7+YUpY7a1cM0Tk/d4gLpmJF2fSsbzGJudf+w3oxdLoe1CXZL7sACS
 389/FV0mnUxZMP5l3VKuaFSMSQwC9Wp5JMXMi/L8rpJsLVlyu0KNkw+BJVMVNmEEx700
 lE3cREXv55qkuwdhfazd3PW7/60+ZiSdpONz6SCjgaJie22qwHxmfDy07Nl0LG1NE13l
 lYAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVamEVouhyf3nrwX44Ofk6GsHN7I6HbxZ8v/f2H4xVzLH/4Fue8OWfcN4t8uK0gDILbEsGgNO2g27w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsrCK41kxOmWGDJpP0N+5WxPYFH8dwH/jNUFWmnzimltN6Vppg
 +F21J3jxKEwpoudyV8oO4ap8S/R93uSwJ1smzc7oX224Wr7SEpRtJj6DQN9ov/L++3rVEDe/cpv
 Nc4QYCpuUVGGA+ClE6i4PiWEv6rgxXDgrawguQemRUFKtGZ7pmhI1WxvWY5qB5Q9ZFpDUxCA=
X-Gm-Gg: ATEYQzzbeN7sCDUrzgfv1LugKvKscmXr3aR87mh1YcSY8Ozv9efaLo7PWFKeuL7mE9F
 cym0YSHMAyd5hqCMhMyOBTg60ilHEIbLup1QdhnKfOhvTTly2Y/x9N0YVR4OrmGI9UfVm6oUwB1
 l3tpc/Cj1uEVhG54StvTELUfXcolU6pX/xqYKHeNhhwcUSn870IEjXMLQ711wUp4TyMWOaN0yDo
 4uxunVtQo/s1ioC6o6lob0CMmUqaPr32VZiZ7nSifH14QRA6snFG18/1K/jMCYZ2foFdGS72/xX
 TPm/CuPAGnqW3oE+R1RmTURze742zjlGVbdVgwCIYbl4wkbiViY5/b3BUvKgcrOaKeQqXGjRdT1
 QzstBwg6yZBOgM6mkSF3TRLmYn1lXRze07vWD5wFEiksbyKBM98usbaGRp4uE/K0kR1sE7fTvkC
 z+rrWwGoiYWmTuxaBobJhSJmBNAqa2WNZkRA0=
X-Received: by 2002:a05:622a:8d10:b0:50b:5743:5fca with SMTP id
 d75a77b69052e-50b6ef07979mr58212451cf.39.1774380619281; 
 Tue, 24 Mar 2026 12:30:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8d10:b0:50b:5743:5fca with SMTP id
 d75a77b69052e-50b6ef07979mr58211471cf.39.1774380618650; 
 Tue, 24 Mar 2026 12:30:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c3aa03bccsm4516151fa.17.2026.03.24.12.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:30:17 -0700 (PDT)
Date: Tue, 24 Mar 2026 21:30:15 +0200
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
Message-ID: <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c2e64b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=2DgZU2EfoQVUhze0CNQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ttVDYM6ORKXzmQ2k4gkpM-lZKYo9_wsQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1MSBTYWx0ZWRfX5qEeuxRtc3vX
 c7usVLoAKnvPifvfk7N9kUNiwieBAe3jx3NlABbaIeN84SiE756VjYEXcONzIr+YybH5vqslChU
 9nO6G5vEMO8PRw5/idNr+I85GTvFHsnZQhdWGEMSkJEV0QDxiUloA3QvHgnKxjJ03ZtbY7CBkh2
 imDlbyUEJal+MxPmHT/ojmQRaZyfsg2WNXYMpdRygFIp4q59ct6I5qjpRh44HG61ypKeq5gTyFf
 XyxA7lQkNzZk4FWt/jUcy4qfnJf9tac1WEmVv+JON0wAJQhUdi1lAXCBsNialzeVVgOzFJQKxzT
 fXMKwGavMkBskNZYLM5ilDRH/AH7g5Vca+QTt9aWQzwbCj286oe0usJxbwiz9/s7XuepCN9WVqm
 UmA1rkMbzykCXgc7VhFXh4b5Ni8JyLXPH82qbXQkSJ6tofmUTEkrvs0ABhWL2uffc6vPzZunMdW
 iI9KoI6u5/KRbwDdxbg==
X-Proofpoint-GUID: ttVDYM6ORKXzmQ2k4gkpM-lZKYo9_wsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240151
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

On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Add HPD callback for the MST module which shall be invoked from the
> > > dp_display's HPD handler to perform MST specific operations in case
> > > of HPD. In MST case, route the HPD messages to MST module.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
> > >   3 files changed, 48 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
> > >   static int msm_dp_display_usbpd_attention_cb(struct device *dev)
> > >   {
> > > -	int rc = 0;
> > > -	u32 sink_request;
> > >   	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
> > > +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> > > +	u32 sink_request;
> > > +	int rc = 0;
> > > +
> > > +	if (msm_dp_display->mst_active) {
> > > +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
> > > +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> > > +		return 0;
> > > +	}
> > >   	/* check for any test request issued by sink */
> > >   	rc = msm_dp_link_process_request(dp->link);
> > > @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
> > >   	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> > >   		msm_dp_display_send_hpd_notification(dp, false);
> > > -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> > > +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> > >   		msm_dp_display_send_hpd_notification(dp, true);
> > > +		msm_dp_irq_hpd_handle(dp, 0);
> > 
> > Why is it a part of this patch?? It has nothing to do with MST.
> > 
> Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
> I tried an alternative approach by calling the MST IRQ handler from
> msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
> DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
> msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
> could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
> However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
> MST IRQ handling into the IRQ thread. Do you have any suggestions on this?

When are the link status bits updated? Please remember, we need to
support all three cases:

- Native DP, native DP HPD pin handling
- Native DP, DP HPD pin not handled by the controller
- DP AltMode, DP HPD pin not used at all

In the second and the third cases we will not be getting the IRQs.
Instead one of the next bridges (connector, EC, AltMode, etc.) will send
the HPD event, which lands in the .hpd_notify() callback.

-- 
With best wishes
Dmitry
