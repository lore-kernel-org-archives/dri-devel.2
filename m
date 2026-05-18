Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621FCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F5910E8F6;
	Mon, 18 May 2026 16:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKfWG0lX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JosH13EE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FA410E327
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:37:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEnGEh2975394
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z6bl1rogyLjzkYkDgztN3fk05kEH9UeuqTmadnwHZ50=; b=FKfWG0lX3m885V/j
 XA03cSmyeynZpezhjq1eXzi0ZABTxe2hEl3o2x2xyFl6ZDMlUYsJKY+mLusApkPw
 v1rUJPtDQnGVTibeVJpICr/XpE8GW1Pi2pT/Jn8jEt2P3+HOu0RWqzrqlfXsBgSZ
 cqLWWtNMtf6W1J6NprDX0KyK71gkVhUTipkfccCdOpWsWIOb2PnEmYT3rRcDI8/u
 dUkfQPnjYZs3hKnBYlH9yjJFCvP8Yd3xsQlXagDV6Vu3O8eC8xpcqjfA85WiGGkh
 0jLwQG/R75KFBEgXgq67Eib7P43f8w32UMlxPD33BBs9OKi4+6S0B8azyppGZW/2
 g2bB6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48djn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:37:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50faf575af4so72414511cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779122223; x=1779727023;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z6bl1rogyLjzkYkDgztN3fk05kEH9UeuqTmadnwHZ50=;
 b=JosH13EEv2Y2HvnvLk+K7g6M3Nxc/RUQmD1B0m3P7WGXfGEW9iuOCMdevpR338tKne
 sbPoW3BCqTj4c0C9SROAzSei/WTOO+cbPyM3qkepPVPsx7vOZdrA3Ol2EF5cVDb20aPi
 4HsAZ/qDC4ixecipi/R0JxGFm4bAdzyQRsaHFWeJE3ucwgrzy1gz6j22NN58q8dgMFgt
 HFyzRO5HwugES3/8hBjFXiEveTrS6/aipG1tgeSqmkoFt/iuaQslW+/NDf192O2Dv/yB
 DECbDDH2QGiPeL6t3ADxE3EVTHfGbfnDQuBnesD685XwcAok9Dspyv0wph49SsIgWRWZ
 7bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122223; x=1779727023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6bl1rogyLjzkYkDgztN3fk05kEH9UeuqTmadnwHZ50=;
 b=D1PBZkpIzbIx5M8KY+Mg2pztRDuRWpMrNTLm/rLspOiiBqTnm9iB9V+4A1cBzhFyvC
 fSIW9Xzxk1/4HDmnR+FrKuJgykNm/f2v9GEYvLYGKIAY02S/clxxBhY5lxXtCkEt825o
 UKoWTovJr6D8XpuO9i9Y9vowz6XjkImqKuvMeAqRqMc6VghjfCVNLMNfqRhfPv+R9JdR
 ERXafP3qBUEQYjHePZdWII9P7GQ8OiMpOZA2zruMMvNlPUTnmNuc1UDike4liOT4UN90
 eynUVpAJEO0GCtlwzgJZn5EXSM8gSip1QWR7wfScINnB5VFA1Tl8xFufeI4QI8fvhSkw
 ZlVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9baqFJPskGh44DhF2JENbsFWWpe4jQTKIu3h8AJRKR2acsqKtGCOlzJgn9lAwGn1j0seKVkcWNNpQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj6vKdNv4VW5MLo7PdipbzTvQWHHVikispL6SAkXZct8z5tUB8
 RY7LSHPZSCd68fZsB6sZOq3ZoXAWSmPtcnv+5N35kxb84Jxgnq37++k/juJsmGSGdD1Hjjlbkkr
 /5zUN2LnQ1rIizyB/rtOALNmspDe+ewV7wT3D6A3gMGFqwETRgFlbndrmMSlJuWw36t5mH5Q=
X-Gm-Gg: Acq92OEwx9wa7JCuLWYCN9y1+L4Zrz6QCy9tC0rrnC61Q1picoVqWei5+eHNDnfpHyu
 9ZORydqbvC74USCLRjIGOldgjeTlZ+zbmonSsYR0JLil2IsE17oq8Z0tCCeuvxC+Gt8tDD6gYGJ
 AZZ2nH2wHb+EGmmnQwgxpKgIsHFErwoN3/+wENDLcURbquYLNjJLvm51I/+DVvl0yenN90n1sAJ
 lUvQWyJeo6jcwxs7N+NqHkTRHscac10brivCGX0SB/Ncbqea5iHYNqvqjVSnW3VsOz8rBeSr+kK
 DxlkUvNDiHDTdW9wGHeeMVxGrenNTyOeX0iWSeYDEOYUsSnasqbrZrfUk76JENoAiylYDtoQzNN
 ZKl3r3k1TczG4xv3Vhmp6DdfunAbB6Gz0d+OjXBOmGa5gL277YYj3k2DwBGUi5LN2At6qIGzjvO
 1O1x+2GyokpFAJVDOWPyzkqUh2/acYvNIaf1o=
X-Received: by 2002:ac8:5cc5:0:b0:50e:601a:217f with SMTP id
 d75a77b69052e-5165a076dcamr221804651cf.25.1779122223044; 
 Mon, 18 May 2026 09:37:03 -0700 (PDT)
X-Received: by 2002:ac8:5cc5:0:b0:50e:601a:217f with SMTP id
 d75a77b69052e-5165a076dcamr221803841cf.25.1779122222344; 
 Mon, 18 May 2026 09:37:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958878a128sm14023331fa.28.2026.05.18.09.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:37:01 -0700 (PDT)
Date: Mon, 18 May 2026 19:36:59 +0300
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
Message-ID: <djigwx5k7j2rkaoq7g6paor6l6i25srvq7chjqqnjlbs3shcco@x5drauwxzngp>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
 <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
 <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
 <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
 <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
 <k6y3e4fqfwkevvvv3zmzmovsrz4i6qkxs3duhz7khsggxwwa77@uogtrpuaxhnc>
 <d4c5d26c-47f1-4e42-9852-d407982cb4f6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4c5d26c-47f1-4e42-9852-d407982cb4f6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b4030 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=-gHNLQfvCd7OBxZQGsYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: l3ciji3u8Y8LhfeniG1MuTqg4cF3io_f
X-Proofpoint-GUID: l3ciji3u8Y8LhfeniG1MuTqg4cF3io_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NCBTYWx0ZWRfX9BV1XCryEpvm
 JGs2wzAA4yHseUnMwxE34oH7ndpuuL9DZDUy5gJLgpe6OTxpsM4ol5jjIDyEh9wREnt3nWvvDVJ
 oBA2fOAD3xXNtJ0OHWkIXETyP2V2O/g/CfELAx3edI04Ry5lhUhUW62PMY8zv4GaGCa+zqVU5vH
 5KxLBhvz0aehOHcOacBpnHkc1QYV3LY36u7YDbz5ak9NN24NQ34rjXCjGyIrfI7ZweY37bzFw0u
 PLDRt29AR3RAjIqd56X8dmYDic98EX3MY8pNQdIV4ihCm7brrhzP0JNJ3YNQsl3sisiq4JAajZA
 FicrO/xsaL0zmKF4GFjWFhEkutB7vf3SsOcRdI73S+v2evOOj/RZN0E4nSTMOLiGWxEwUEbnCUi
 Hqf2u8Ovfh5NbA3PC0fMHETdmdivygpv6Nyl5wz0wlMpKKMeEY4DOJWdbYeK90gPTrbC4+2hA/T
 ZEbxX29XjlTI4lizMHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180164
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

On Thu, May 14, 2026 at 03:12:17PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/19/2026 8:29 AM, Dmitry Baryshkov wrote:
> > On Wed, Apr 15, 2026 at 06:32:29PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/15/2026 2:43 AM, Dmitry Baryshkov wrote:
> > > > On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
> > > > > 
> > > > > 
> > > > > On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
> > > > > > On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
> > > > > > > > On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
> > > > > > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > > > > > 
> > > > > > > > > Add HPD callback for the MST module which shall be invoked from the
> > > > > > > > > dp_display's HPD handler to perform MST specific operations in case
> > > > > > > > > of HPD. In MST case, route the HPD messages to MST module.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
> > > > > > > > >      drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
> > > > > > > > >      drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
> > > > > > > > >      3 files changed, 48 insertions(+), 3 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > > > index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
> > > > > > > > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > > > @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
> > > > > > > > >      static int msm_dp_display_usbpd_attention_cb(struct device *dev)
> > > > > > > > >      {
> > > > > > > > > -	int rc = 0;
> > > > > > > > > -	u32 sink_request;
> > > > > > > > >      	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
> > > > > > > > > +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> > > > > > > > > +	u32 sink_request;
> > > > > > > > > +	int rc = 0;
> > > > > > > > > +
> > > > > > > > > +	if (msm_dp_display->mst_active) {
> > > > > > > > > +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
> > > > > > > > > +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> > > > > > > > > +		return 0;
> > > > > > > > > +	}
> > > > > > > > >      	/* check for any test request issued by sink */
> > > > > > > > >      	rc = msm_dp_link_process_request(dp->link);
> > > > > > > > > @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
> > > > > > > > >      	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> > > > > > > > >      		msm_dp_display_send_hpd_notification(dp, false);
> > > > > > > > > -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> > > > > > > > > +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> > > > > > > > >      		msm_dp_display_send_hpd_notification(dp, true);
> > > > > > > > > +		msm_dp_irq_hpd_handle(dp, 0);
> > > > > > > > 
> > > > > > > > Why is it a part of this patch?? It has nothing to do with MST.
> > > > > > > > 
> > > > > > > Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
> > > > > > > I tried an alternative approach by calling the MST IRQ handler from
> > > > > > > msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
> > > > > > > DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
> > > > > > > msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
> > > > > > > could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
> > > > > > > However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
> > > > > > > MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
> > > > > > 
> > > > > > When are the link status bits updated? Please remember, we need to
> > > > > > support all three cases:
> > > > > > 
> > > > > > - Native DP, native DP HPD pin handling
> > > > > > - Native DP, DP HPD pin not handled by the controller
> > > > > > - DP AltMode, DP HPD pin not used at all
> > > > > > 
> > > > > > In the second and the third cases we will not be getting the IRQs.
> > > > > > Instead one of the next bridges (connector, EC, AltMode, etc.) will send
> > > > > > the HPD event, which lands in the .hpd_notify() callback.
> > > > > > 
> > > > > I added some logs and did some testing. I think
> > > > > msm_dp_aux_is_link_connected() only shows the current HPD state. Since IRQ
> > > > > HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_INT_STATUS
> > > > > in the IRQ flow, the HPD state machine has usually already finished pulse
> > > > > classification and returned to Connected.
> > > > 
> > > > But the IRQ should be sticky and it should be readable from the status
> > > > bits.
> > > > 
> > > Yes... I’m not sure how this is handled on other platforms, but on LeMans
> > > can not get IRQ status from msm_dp_aux_is_link_connected().
> > 
> > Can we clarify that somehow? Maybe with the hardware team if it is
> > uncear from the HPG?
> > 
> > > > Note, in the USB-C AltMode case the HPD machine is not used at all.
> > > > 
> > > > > 
> > > > > Because of that, the condition hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT
> > > > > will usually not be hit.
> > > > > 
> > > > > do you have any suggestion that in how to distinguish between an IRQ event
> > > > > and a plug event in .hpd_notify() better? We probably don’t want to
> > > > > introduce another state machine.
> > > > 
> > > > Then, I assume, currently there is no way to actually distinguish those.
> > > > The easiest way to handle the replug would be to store the current
> > > > "connected" status and verify if we are receiving "connected" while
> > > > being connected or if it is a disconnected -> connected change.
> > > > 
> > > Emm.. Currently, regardless of whether it is the native DP HPD (on LeMans)
> > > or DP over Type‑C Alt Mode(test on Hamoa), a single plug event always
> > > results in two or more identical .hpd_notify() callbacks.
> > 
> > Could you please check, why? On Hamoa it might be because of the LTTPRs.
> > 
> > > In other words, after the transition from disconnected → connected is
> > > completed, there is still one more .hpd_notify() with connected → connected.
> > > So it still can store "connected" to distinguish between an IRQ event and a
> > > plug event from .hpd_notify()?
> > 
> > I've sent a series, which explicitly tracks the IRQ events. Hope that
> > helps.
> > 
> Very thanks for sending the HPD IRQ series
> https://patchwork.freedesktop.org/series/151522/. it very helpful for TYPE-C
> MST.
> 
> I’ve been testing it locally based on HPD refator series, and TYPE-C basic
> plug case works on my side (although with some local modify, maybe now it is
> workaround). At least the IRQ is being delivered correctly now and the
> simplest case works. It still need to do some additional testing.
> 
> There is a small question:
> When do you plan to merge the HPD refactor series?

Would you or your colleagues review it? Or at least T-B it?

> and could you please
> rebase the irq series patch to HPD refactor series ?

Once it is merged.

> so that i can keep MST
> depend on those 2 series.
> > Thoug storing of the "connected" state should help us to identify the
> > long HPD pulse (wich should be treated as unplug & replug).
> > 
> > > This is my current understanding. If this is incorrect, please feel free to
> > > correct me. Thanks.
> > > As an additional note, msm_dp_hpd_plug_handle runs through its full flow
> > > twice for a single plug event. Also, the behavior I described above does not
> > > include any MST-specific filtering codes.
> > > > For a longer term (and granted that HDMI also has a notion of HPD pulse
> > > > events) we might want to extend the DRM HPD API to pass through the "IRQ
> > > > pulse" events as is (instead of converting those to
> > > > connected-whilec-connected events).
> > > > 
> > > > Let me sketch a draft for that.
> > > > 
> > > 
> > 
> 

-- 
With best wishes
Dmitry
