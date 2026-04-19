Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A400DF99C98
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B6E10E3AF;
	Sun, 19 Apr 2026 00:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCfesNHq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TlMMcZoG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C848510E3A9
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:30:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63IL8nuN2309460
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yVJVf4XIvKZ6i7x+0NR4DP8TeKhTKkDlVKnam6ZbTfY=; b=XCfesNHqu7/JXNhC
 DfUihonBbpUxE+I6FKIijHA8AUNDMMK9CPuahdVcYLpD/hq+gP2bug7d9VW8aj8p
 sXPsp01ZIbbKPbSQ7KvdxN+KXvwgwI52Ag/XHtVcKy6YcGoh1aRuHPt0BqT+r8ZT
 mBapBmWYTVCccXsnRp3IxAfin6Ogdc6/buHFprAvTH1q8kqKSYGpB1+ZaUWlf0OT
 aXurqJvciymnFh7U+raySWe1PudXOH3f31LPEZlotLccpzTqVmqG4JbuFh/I1ZVw
 FMlDpLT+HWb2FRyt2yMZD9dVvV3RgIEkbFKcJUtY419QsH4MaV8UwJluLAzPH9Mm
 aMPoug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr1tgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:30:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d812c898cso55181171cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776558600; x=1777163400;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yVJVf4XIvKZ6i7x+0NR4DP8TeKhTKkDlVKnam6ZbTfY=;
 b=TlMMcZoGWPRjdcgkPSG/nTgX1ogP2KJsnajePAY4RVv/d7XSESEGjCDMRpZP05BC5S
 Sd45Wy0hjvsjzm1Hf5VNMrCuSVG8lYxdVLvxIjSd66TpNQ5Yj/eh0gy0xSadZRiRPW+g
 qUrn9A+xSBSSBHmaTccgb2JEaMHepxScwEfsZ4NMGjoXzBB9m/eTK18HMejyXTNWOMEH
 GLt2VoDkwAbUcbmCN6SKa5AD5RTCUsphbsZbpvj95todq6XuQcJX6w4tH2ZuLeNdD4b7
 F2AnZnfn2U7GoayrXrhxqqBKzD9FOKGwkVOQBzl93tUCqGESIy3ZGN03GNCbsDT/qOM6
 GAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776558600; x=1777163400;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yVJVf4XIvKZ6i7x+0NR4DP8TeKhTKkDlVKnam6ZbTfY=;
 b=Wg+ndQJu+rxR/wW2/SOzoBtWVHBVcjgy0izlUkrTUS1FAVjHC6KTfKNn7Ytveww5c0
 WlAwBnBTM2aNabq1n+UzHm5LhFZKfMZZVypyJmYmCTkOnV3aGWJQAaScHsrKqdNvOOB+
 lIfct/nAikYecQCCrfxbn6+hO90VQ4KYhNV+UxsQdnwwIRzzTcBkEMnQvHHlQWQwMYiG
 Vct0IpSwXmwLtJiVEI1MoB+XZ4qBkpbJudG74YnaxTczCncDLM9xdKtv4yFiLtUja/6T
 U+B85Pu8zRKaMC6tYzWSGri1OxHwJRO/mfZsuz4qMdk6oDr6/3lT/iwJsKYMhEdzAqZH
 q8Dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8INWI8jWltPtlN4I35n87jq/uvzMXQRZUzDa8HdoGLmNHe5jQmw2CdnMzZTnbRpvnu9nQgN7UpHtQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySkYyyMKPUJxCQ7hMttBPMHWcYr+ImlfqG6PHKNdp/yyak6+7u
 QKW29JkBPRg86TXrE5s5rj8rSFr74o37yOIfor99fD9dQ4JF1bW+6Kimi46vfxt91iUmD4/YioF
 Xy2GFsjluY2hEIBXX8UL4XeaXUI6DLtTX+64G/IeQHdx3neSuDVki5RmC1H4FDMUwIDJIm/FIER
 z/ml4=
X-Gm-Gg: AeBDievA6AG96dQjozAfeu7xvTdGJR6e/Xn33/AAwy9ydAbTOu+ou6wOY0mtY885JQk
 i8Sj+mMiHxju7y8MUkS9vn1beLmO4tEC6bBTmkKCpD5GhnqXT/hzlAuw2hI3MZDVJrK+mF+s1G+
 FaeRu503f/yhgxpXyK8WCcONTcwyMca3Cg9usMclrSbuDXzBFIQTsHD4GKBJ/cbCPPkfQgAapqP
 oUT+g7ZP9oLhh3udolC6f5RfwN35zdgd2iTcetWYcbPd/jU+Dc3RCE/O6HD102qDzR393jc/wye
 YSOKLBQEXYDCjhz6aHo05uaZ8l/qvJ1Tr/YjY1nvkBURLXb6e/nd+tb+Cqh9gGx5YXyLA7191Q1
 YJ+jUuv3m0aeTSKNoGnOagt2roiw/eIT2y/+cd/PJ5+oSq7ESWwlvmNSFRrkvrRFks0H8BptS8n
 /TV2J3RIPZi8xRpY41+abIxDd/xKdfUWDNtqH9c1JiZppyEA==
X-Received: by 2002:ac8:5790:0:b0:50d:8cad:2381 with SMTP id
 d75a77b69052e-50e36f18d42mr127332851cf.54.1776558600489; 
 Sat, 18 Apr 2026 17:30:00 -0700 (PDT)
X-Received: by 2002:ac8:5790:0:b0:50d:8cad:2381 with SMTP id
 d75a77b69052e-50e36f18d42mr127332511cf.54.1776558599998; 
 Sat, 18 Apr 2026 17:29:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc240sm1759416e87.23.2026.04.18.17.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:29:57 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:29:54 +0300
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
Message-ID: <k6y3e4fqfwkevvvv3zmzmovsrz4i6qkxs3duhz7khsggxwwa77@uogtrpuaxhnc>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
 <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
 <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
 <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
 <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwMyBTYWx0ZWRfX+O4WrwhvpAd6
 60AeMfx4+2Lknop/61yJZuFcKwstxRefo/gYag810Jc+h3+US8cWafqnnbNJUK2g+iUZasMy2wx
 jWOH6iz0t10Ue/R80v2p2jRfL52ln3ivtKo/kwofRmP0cXaIwK9yzLUh5KttA7ToRVvqu6D35/h
 Th1ilN+KCRzc2mKZvTj4UdkQwHG6zZguBw1PhuxCopoFAwhOds5397k9mYeRv4GmW6bL/7tT7Rs
 MA0rfL+2FbApbaXOE25JHWU6tCm4lTzte86643wW1BPnJczThyDX3H48YvmdRM4jh+uiwOqtfLA
 gZeSTo0kR2N37t/R+vmkP1jI8VhTcTmtf4A+oNweZTme6OTG1WppP1ldkqwlDPHxHXPYXjRE27l
 4hN0L/sOigMJ/HpzUmd+d9FIngPHb5lLNxM6W59X62kh3KHouo1jS5HEsom/urfTR4KXSpKnrcu
 M/BmPfA3Spx44DvBlAw==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e4220a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=1-tdV8naFid5rhdxo8UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rQ7fdbAQbOutwO26f74YGapFsVQrCOuE
X-Proofpoint-GUID: rQ7fdbAQbOutwO26f74YGapFsVQrCOuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190003
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

On Wed, Apr 15, 2026 at 06:32:29PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/15/2026 2:43 AM, Dmitry Baryshkov wrote:
> > On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
> > > > On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
> > > > > 
> > > > > 
> > > > > On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
> > > > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > > > 
> > > > > > > Add HPD callback for the MST module which shall be invoked from the
> > > > > > > dp_display's HPD handler to perform MST specific operations in case
> > > > > > > of HPD. In MST case, route the HPD messages to MST module.
> > > > > > > 
> > > > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >     drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
> > > > > > >     drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
> > > > > > >     drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
> > > > > > >     3 files changed, 48 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
> > > > > > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > > > > > @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
> > > > > > >     static int msm_dp_display_usbpd_attention_cb(struct device *dev)
> > > > > > >     {
> > > > > > > -	int rc = 0;
> > > > > > > -	u32 sink_request;
> > > > > > >     	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
> > > > > > > +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> > > > > > > +	u32 sink_request;
> > > > > > > +	int rc = 0;
> > > > > > > +
> > > > > > > +	if (msm_dp_display->mst_active) {
> > > > > > > +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
> > > > > > > +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> > > > > > > +		return 0;
> > > > > > > +	}
> > > > > > >     	/* check for any test request issued by sink */
> > > > > > >     	rc = msm_dp_link_process_request(dp->link);
> > > > > > > @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
> > > > > > >     	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> > > > > > >     		msm_dp_display_send_hpd_notification(dp, false);
> > > > > > > -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> > > > > > > +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> > > > > > >     		msm_dp_display_send_hpd_notification(dp, true);
> > > > > > > +		msm_dp_irq_hpd_handle(dp, 0);
> > > > > > 
> > > > > > Why is it a part of this patch?? It has nothing to do with MST.
> > > > > > 
> > > > > Emm ... maybe here we can directly call msm_dp_mst_display_hpd_irq..
> > > > > I tried an alternative approach by calling the MST IRQ handler from
> > > > > msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status ==
> > > > > DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
> > > > > msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. That way, we
> > > > > could handle both SST and MST interrupt paths in msm_dp_irq_hpd_handle().
> > > > > However, hpd_link_status only reports ISR_CONNECTED. So I had to move the
> > > > > MST IRQ handling into the IRQ thread. Do you have any suggestions on this?
> > > > 
> > > > When are the link status bits updated? Please remember, we need to
> > > > support all three cases:
> > > > 
> > > > - Native DP, native DP HPD pin handling
> > > > - Native DP, DP HPD pin not handled by the controller
> > > > - DP AltMode, DP HPD pin not used at all
> > > > 
> > > > In the second and the third cases we will not be getting the IRQs.
> > > > Instead one of the next bridges (connector, EC, AltMode, etc.) will send
> > > > the HPD event, which lands in the .hpd_notify() callback.
> > > > 
> > > I added some logs and did some testing. I think
> > > msm_dp_aux_is_link_connected() only shows the current HPD state. Since IRQ
> > > HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_INT_STATUS
> > > in the IRQ flow, the HPD state machine has usually already finished pulse
> > > classification and returned to Connected.
> > 
> > But the IRQ should be sticky and it should be readable from the status
> > bits.
> > 
> Yes... I’m not sure how this is handled on other platforms, but on LeMans
> can not get IRQ status from msm_dp_aux_is_link_connected().

Can we clarify that somehow? Maybe with the hardware team if it is
uncear from the HPG?

> > Note, in the USB-C AltMode case the HPD machine is not used at all.
> > 
> > > 
> > > Because of that, the condition hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT
> > > will usually not be hit.
> > > 
> > > do you have any suggestion that in how to distinguish between an IRQ event
> > > and a plug event in .hpd_notify() better? We probably don’t want to
> > > introduce another state machine.
> > 
> > Then, I assume, currently there is no way to actually distinguish those.
> > The easiest way to handle the replug would be to store the current
> > "connected" status and verify if we are receiving "connected" while
> > being connected or if it is a disconnected -> connected change.
> > 
> Emm.. Currently, regardless of whether it is the native DP HPD (on LeMans)
> or DP over Type‑C Alt Mode(test on Hamoa), a single plug event always
> results in two or more identical .hpd_notify() callbacks.

Could you please check, why? On Hamoa it might be because of the LTTPRs.

> In other words, after the transition from disconnected → connected is
> completed, there is still one more .hpd_notify() with connected → connected.
> So it still can store "connected" to distinguish between an IRQ event and a
> plug event from .hpd_notify()?

I've sent a series, which explicitly tracks the IRQ events. Hope that
helps.

Thoug storing of the "connected" state should help us to identify the
long HPD pulse (wich should be treated as unplug & replug).

> This is my current understanding. If this is incorrect, please feel free to
> correct me. Thanks.
> As an additional note, msm_dp_hpd_plug_handle runs through its full flow
> twice for a single plug event. Also, the behavior I described above does not
> include any MST-specific filtering codes.
> > For a longer term (and granted that HDMI also has a notion of HPD pulse
> > events) we might want to extend the DRM HPD API to pass through the "IRQ
> > pulse" events as is (instead of converting those to
> > connected-whilec-connected events).
> > 
> > Let me sketch a draft for that.
> > 
> 

-- 
With best wishes
Dmitry
