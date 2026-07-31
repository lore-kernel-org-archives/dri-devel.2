Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CF4C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9D510F258;
	Fri, 31 Jul 2026 13:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wj919ht1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f3xTrIwC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0C510F258
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:35:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VBaPRQ3743850
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pUE7JydRHoj2bR2XQTZhL1X0
 wyHiUYs8hq0ouIE4owk=; b=Wj919ht1vZTBTg26b2P2nHDsmrpA5znkFKVoHoj7
 qSDn0DofSQVHue332EnFH596hBVdT6Xd+qnB4atMwtxaszsawd+D2FkczOF+tvj2
 3OBJM1meGxKqAv5TCMM6jD5KdqUVQpLtap8NglBmUGQPQiL+tessah0ZxIGYmyjr
 gemIQkrMH6j7nYv5wjOkv6uhqsLrBmAf5av0c8Gmqtvj4uoGUhXFclb4/w9hCSkt
 pAp/5J9JFwr3bC9tJp5vNf+IaPTvdSC8QEhdcyUfFdr+6UpCH+S0X28GonMz7ZwD
 5RO+YDauyVSSmFSEm88L5VbuR0PaPDoZteas3yvZrqZfPg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtyqgfky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:35:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-529ae8e96e8so9697551cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785504921; x=1786109721;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pUE7JydRHoj2bR2XQTZhL1X0wyHiUYs8hq0ouIE4owk=;
 b=f3xTrIwC2vBi/n0r2MmTh9rNyLsOGgQgiHqr1msta2XHySlkJxWCBkcr9dz3zsdvNk
 8SmvRpREc8guNyL1y7QXFZVvq3X7L4wBgSQijKFjyqIiGOT1oBt1cApzOfQjDZw2nZ11
 rx+L0+SWrDbadaSyxHJwvwjYZnLYy1Y1OF6kORUm53avfGVeoKqoBptXAVrJ9K2RcceY
 6fMJXCGhafH/uRHOKg9iTKGcuHcZxd75kB2MgTwGpWjbk9Rd0LTTLRG1xKJMJifs79hS
 TskZKYU/NgEOR/9HklKMfkekrS7BZQf6n3z8mOBQVY0UW31ADTP3SkEZrDQkuJ7Mnpay
 5vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785504921; x=1786109721;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pUE7JydRHoj2bR2XQTZhL1X0wyHiUYs8hq0ouIE4owk=;
 b=hoMHoH2Pq2HhEJKvvIn531CvNOoTA7K17C9d4mGYm86N477lMCxTI3f1aHEB0ShqJ4
 4MsRqckl567PM0XFqDbS/H9EVLvOxUqsjGr80gsZKrd8sO3qr4l1Xej/NGdH2pv2KWqw
 tXLEXzu4Ty0odSPAVJTUzCFq+12mXU0BmjDIPb/e2wxwHOZBJo4DbmSPzypgAwXY4qV+
 ap6QkPAHRWrGczmI3PTay/GmnttLQ9gGyoFuXR454uptoOHoUAFkQSchmNpqaxijEygq
 LA+fWNAcB/cMdShnLnbGIn9wrenljijbp92Rrqas5GrORILez4D/Zmp+Kz9rRhRKGPu3
 YwIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpeXpLyp/Hs4eav1YX/RRUXjB+vWHZTS8D17HSg5QDJIg+U/VLHx9Q+hSniR+pp1UfWqx7lpVkXQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/TH7Ha4U8IcNX24ujwbVxqQHqh2U6ET2rPTGvGjUorPJhpH7y
 R1VQ7/mPiP2vUUkgU+A+1IgfBqaM9A3mM6as/jWm7ZLMzZpMys296BNNS5RtL5ki+UHP4pobM8E
 zb1mcRTCKC9Ywt/Wtvh5v6mFqPTZdseV75GZhPuWJa9Ya3xEQeNwHELKtxXyjSXJB94wXLMs=
X-Gm-Gg: AR+sD115hR846eRM9uJ0MPyqRhfgfiq18Q4ov1aVUXW1G18m7S5VeTDSTLWwAOjQXOL
 0uvrBReMz0hDv1wa2rbcJu18NmAVBApO0fmKQUvw0XNcGOzTm+Qnk+Kps/3uIf3lX+E//U4ONbP
 MD/rLyteiduT3W+ahQkEP2R0U92UEyL/BRKkse4FTWVOzKgs5tzgu1XsecbqqnVkvF+GQmJKMs4
 /ZL1VtIhq5rh+JLcCe0LXY/IPe0WbFsr92GhEU05qpe+ef91Bd2mQ7o0oBnuTQvXAbmT8LkhCGv
 IqTTXxvo95/VXP37C4vWqvxJfrPXF/z4bTaGBQoT8lC0JLyyltS8JMF6YYEECh8cpkF1t8z/jmx
 HTGYCpZ9rxas2mkjwwauqO7v+IgyCFcjoCfY2EUI0Vj5LbhJKalouyecjJ2QaUyNpUZTqngXprF
 OLwJMH3GMvlvQKVQ==
X-Received: by 2002:a05:622a:1b07:b0:51c:6e:ef23 with SMTP id
 d75a77b69052e-52b5680e85amr1128851cf.32.1785504920221; 
 Fri, 31 Jul 2026 06:35:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1b07:b0:51c:6e:ef23 with SMTP id
 d75a77b69052e-52b5680e85amr1127411cf.32.1785504919360; 
 Fri, 31 Jul 2026 06:35:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e23cb4f1sm312343e87.18.2026.07.31.06.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 06:35:17 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:35:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: sashiko-reviews@lists.linux.dev,
 Kumar Anurag <kumar.singh@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: return 0 from audio_prepare when cable is
 disconnected
Message-ID: <fv2gtrgxx6emfdhnw5xowmhouvig6fl6g3ewqbdiw6rrwpfvk5@pdze7uawd5df>
References: <20260616151252.3599089-2-kumar.singh@oss.qualcomm.com>
 <20260616152536.D81FB1F000E9@smtp.kernel.org>
 <5ixuxbgngzobl5c5fsyahdsouohwuykoat7s4hy6sczrye7vwf@rj7nmn7x3c56>
 <b5c0de1f-75e3-443e-9e29-a70fbdbf4441@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c0de1f-75e3-443e-9e29-a70fbdbf4441@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMyBTYWx0ZWRfX6GGZDT3vT8wX
 UVo1q8bnEoXlH2JXmpgD06nXlRWV5xZ9KsdFZWf5CXL3DD2O/N8xaLkNuzA7OHi528R8PpupGv/
 VoQX2ahvhNuYAzzxlTsToPL8s2peB//Ezer54C1j0s1xEvXO7KLS9C27EtEuMxZr95whEvk9FP/
 1DfPmoCW8odCejoLE/bMrOPojK1XlpwvsHmwig1RmsneBXOk9b6fkWwC0MgNnNEnGvqUhf56z/X
 8Zv/xPytlkOrNKP4nNGEDqHy+PfmtLr+BW+EcadSGIihePUSGxrlVAIWw1Ow9m3y3v+BHZzfQpC
 iFxhYFY1glYwtnbGQuC+oBgAOT4920AbcVzfAa8CtRbdEeOTUnk5P1Rr4VS+3MsR52TOwKq3kO0
 +ykO6xX/dmxmBE1DjEVVUmUm08gPUKWoWPlG1ddddA8RwOTJcNEskdDgg5OVt4LDnQRRnr0NW1i
 w33yXAzKAJd77CBqmiQ==
X-Proofpoint-ORIG-GUID: ZpCT-agluBaE9hytqSV62vT48NH67vEs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMyBTYWx0ZWRfX1Hw5Sj45hoEA
 EgqVGRNtOsuuhF2vNZ0STruYn8KVajTGI51RBfhkb8nSnZ3VxhVDecDc2HYhWjJ+e0PdNR5GxqJ
 pq24gPZh8uKWeHtW32gEI72IP58nKj0=
X-Authority-Analysis: v=2.4 cv=YaGNIQRf c=1 sm=1 tr=0 ts=6a6ca499 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=eoBTR9oA_HawxltPn1EA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ZpCT-agluBaE9hytqSV62vT48NH67vEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310103
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

On Fri, Jul 17, 2026 at 08:26:18AM +0100, Srinivas Kandagatla wrote:
> On 7/12/26 11:16 AM, Dmitry Baryshkov wrote:
> > On Tue, Jun 16, 2026 at 03:25:36PM +0000, sashiko-bot@kernel.org wrote:
> >> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> >>
> >> New issues:
> >> - [High] Returning success (0) from `msm_dp_audio_prepare` when the display is disconnected causes silent audio failures upon hotplug and NoC errors due to unclocked DSP hardware access.
> >>
> >> Pre-existing issues:
> >> - [High] Race condition between `msm_dp_audio_prepare` and `msm_dp_display_disable` causes unclocked MMIO accesses.
> >> --
> >>
> >> commit bfb65364e66313dc1385a42e09172f44a1e1fbd1
> >> Author: Kumar Anurag <kumar.singh@oss.qualcomm.com>
> >>
> >> drm/msm/dp: return 0 from audio_prepare when cable is disconnected
> >>
> >> PipeWire treats a non-zero return from prepare as fatal, marking the
> >> DP audio device as a dummy sink when the cable is unplugged.
> >>
> >>> The active_stream_cnt guard already prevents any unclocked hardware access,
> >>> so return success instead of -EINVAL when the link is not active.
> >>
> >> [Severity: High]
> >> Is this commit message accurate for the upstream tree? There doesn't appear
> >> to be an active_stream_cnt guard in the mainline driver. Without this guard,
> >> will the DSP push data to powered-off, unclocked DP hardware and cause NoC
> >> errors?
> > 
> > $ git describe
> > v7.2-rc2-4669-gb9810cd75b9f
> > $ git grep active_stream_cnt
> > $
> > 
> > Which tree has this commit message been based on?
> > 
> >>
> >>> diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> >>> index 41018e82efa10..df222943ae57f 100644
> >>> --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> >>> +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> >>> @@ -284,10 +284,8 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
> >>>  	 * such cases check for connection status and bail out if not
> >>>  	 * connected.
> >>>  	 */
> >>> -	if (!msm_dp_display->power_on) {
> >>> -		rc = -EINVAL;
> >>> +	if (!msm_dp_display->power_on)
> >>>  		goto end;
> >>
> >> [Severity: High]
> >> Does returning 0 here trick the ALSA/ASoC framework into marking the stream
> >> as successfully prepared?
> >>
> >> If the stream is marked RUNNING, ALSA won't re-invoke prepare() when the
> >> display is later connected. Could this regression result in silent playback
> >> because the DP hardware is never actually configured?
> >>
> >> [Severity: High]
> >> This is a pre-existing issue, but does this lockless check of power_on
> >> race with msm_dp_display_disable()?
> >>
> >> If msm_dp_display_disable() runs concurrently (e.g., from a hotplug interrupt)
> >> immediately after this check but before audio_enabled is set to true, it will
> >> skip waiting and disable the DP link and clocks.
> >>
> >> When msm_dp_audio_prepare() resumes, it will call msm_dp_audio_setup_sdp() and
> >> attempt MMIO operations on unclocked DP audio registers. Could this lead to a
> >> synchronous external abort?
> > 
> > I'd agree with Sashiko here. Do we guard against the unlocked access? Or
> > how do we ensure that the stream will be prepared later?
> > 
> > I think this needs to be fixed on the other side of the pipe. Do we need
> > to define a special prepare error code, which means "working, but not
> > available now" and make PulseAudio / PipeWire handle those errors
> > specially? How is it solved for other platforms? I don't think that
> > msm/dp is unique here.
> 
> AFAIU,There is no special error code for prepare to flag that cable is
> not connected, the standard way is to read Jack events. Wireplumber is
> is one which deals with Jack event, even before getting to there
> pipewire will fail to probe the devices on the card if prepare fails.
> 
> Once we are at Wireplumber level we are good, and stream will never sent
> to the sinks which are in disconnected state (via Jack).
> 
> This has been a known issue for very long time, most of the codecs like
> 
> Its also interesting to note that same Qualcomm SoC drivers deal with
> this situation by returning zero, so why dp has to be different?
> 
> drivers/gpu/drm/msm/hdmi/hdmi_audio.c
> 
> Other drivers that do not care about plug state in prepare are.
> sound/x86/intel_hdmi_audio.c
> drivers/gpu/drm/mediatek/mtk_hdmi.c
> sound/hda/codecs/hdmi/hdmi.c
> drivers/gpu/drm/xlnx/zynqmp_dp_audio.c
> 
> 
> I think there is enough evidence how this is handled in the codec
> drivers, we should consider this patch.

Let's discuss this at the LPC or some other F2F where we can get other
parties. I'd like to sort out the issue. Or maybe next year's pipewire
workshop.

For now:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # same behaviour

-- 
With best wishes
Dmitry
