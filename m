Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CCEC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD24510E292;
	Sun, 12 Jul 2026 10:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TcdywV/v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVfDcizo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA5510E0A5
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:17:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66C7SG1O1857802
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kTvxjps4eROawjZBgxnV201Y
 dE2QzA2QQ1k2r2UcRA4=; b=TcdywV/vnEEIA006FwxTQ6S1QW+0Esa9QDL8jdxA
 y2ypJsBk27z4Km/8mR1fUI8TWQAPIEt/04kdeg+x8D1b2+PPzxNGHq7rZ9wm2JtD
 T5RrVyACmTP6PVmukRT4mgmJo7KFf737RO7GwYWhCJVyRjYXnc3aM6TW2Sg3Nlgu
 zQHnI9b5krQqAoMXbiCI2FFo9XyWTjUGaYQd1znq46B802odlXPnkVV75D6WrYLh
 XlfeDeBTWaQFuGwlTmeBKEMgGaAp+N+mWPQlhD9iptSzUSlImHP8gKejVC5t1n+T
 z1xZMvpbfeihXI+1eyomiM0wsDZK5tf0ziGWLOZSzNXqkA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcjhjf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:17:04 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bbd4255f46so420428e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783851423; x=1784456223;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kTvxjps4eROawjZBgxnV201YdE2QzA2QQ1k2r2UcRA4=;
 b=eVfDcizoVS2vdjoo+qC+UcJm5GOV7hlnu4D50++V4FxYgcCFKfg0ZUUjXlFrJ1kN85
 k0oLKRkkanKBq+LskqAE+D5SVK4uinyyrYVzCYmkaL+ldTpYNraexO+FBsCWSFGBbIuP
 OUOdd7mAwrYMSZwUdaT+yRtD1mE+ljHcOPmehUSVdMLzmMSrO3nOr3Gu59OeV8G3Ph2f
 jHi+A0iZdZ1qeZ8MxYqM1FnUvrayUTbpxSAhm64vqF8OkssQ8EMWiFaprPaW8DnjMYhE
 ls9QY5Fdo3lW86XxnyGK3PvvzV8sSenkkSkVpQ/Jk3wzBk3eG0EJ9W9bHBhO0hgaLR51
 R5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783851423; x=1784456223;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kTvxjps4eROawjZBgxnV201YdE2QzA2QQ1k2r2UcRA4=;
 b=aDlZcD8ZfixPWssz0YGAw2NvjZk1Hnkc1TpPyXAoEvWggHrQb5zvIYK4MjEs27TxA+
 6hj5p0kk7ZCdW8a5SsLRqap3ldmPHcyWi2/oiPYS6fNhecgBt4qIQdGGXZaoe9ufM8/a
 OTdKJMh2h/sbsgZjuMngjUpo3FMHRLo1DGggypForXkopSzRURgGnhayw97AY0srpNrz
 geM3h8LwC4pBKlt/N+OAJhfGdjetPByxXciStRQky2PaHE97efnrIifGJi1Z54CdOggV
 SnkAPBrfMUa350mb0wpshOCFu8UL93mZ/e70YBPaHhSGdCWHiumojAvPONAkINtRzr60
 V+lQ==
X-Gm-Message-State: AOJu0YxrTnU7yQmrXqUPTaK6zZKI7HPSg0JoAu09zpNj1DAruIK4b+86
 Hz8f1cbOdRouaklt6Ulix3OxDRO6Mnyz6a1X83jnwGASmos3j/Rq/jUbJO2qKpvTpyi5NTWbmRT
 b48NAb/LdCKM9E2MN5vl9lf915wXnB7CX29ry0Rt/OiKmZZIK/4E0DwmRgWC2K4t+J8WEYn8=
X-Gm-Gg: AfdE7clhVf5H9iOB9stiUShAhyQyL77Two6iCHsPwgJ1rshyKrwE6g7FnXIU2YDDbCB
 LfZ1FfrBHvLiY2wDOPE7riW2vMKQVN9ASUPuJv5O3WczGPh13+RWlx9Q498nVF4yA1fyKO9gtrp
 loFG86g6vYuqJHmlAoLJa0YfDcDUYLZmbEbm/+qWNBJP6yRckPFi1/Hhoxw+yp58fCSYbzqjxhW
 HujJ+4ySwFh7+6pf0QIGLFb/Xce4MOz57t9+Y7fCIDp29II8vlbR1Jsk6iBcJMEbbCDDwg5wl9S
 AH3ozM35YE3HU6VQK8eMlJCFL9wFxZSDqpArU69OqsnBsx64jg3ntPeswVjSadQdOqxFDIrkiPo
 pDwNwGrVoANmf5lSG3f/NWueb0CWjRliTMKv44QYeifJo+qezybAKW8f0ljfdcbZZiroWqU3tDx
 aJEilPgkRn1JwYipkLNt3TrEAX
X-Received: by 2002:a05:6122:218f:b0:5bd:faa8:74e1 with SMTP id
 71dfb90a1353d-5bfbf4da3bcmr2919339e0c.13.1783851423190; 
 Sun, 12 Jul 2026 03:17:03 -0700 (PDT)
X-Received: by 2002:a05:6122:218f:b0:5bd:faa8:74e1 with SMTP id
 71dfb90a1353d-5bfbf4da3bcmr2919310e0c.13.1783851422514; 
 Sun, 12 Jul 2026 03:17:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b97553sm22237151fa.33.2026.07.12.03.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 03:17:00 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:16:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev,
 Kumar Anurag <kumar.singh@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: return 0 from audio_prepare when cable is
 disconnected
Message-ID: <5ixuxbgngzobl5c5fsyahdsouohwuykoat7s4hy6sczrye7vwf@rj7nmn7x3c56>
References: <20260616151252.3599089-2-kumar.singh@oss.qualcomm.com>
 <20260616152536.D81FB1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616152536.D81FB1F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEwNiBTYWx0ZWRfX6vAUuTLW5zWk
 LVPR+fD0dpM6U5rmqNvv1LD97HrDIh7m/uaHBYfjXFH2a2krUpm1KweyJGe57bgTecana4foY6f
 O3MKgm4YtVaZ6EMTnt+KhZINndEZND0S9dEWdCaiT+VsEcuUZ+MhT04Q+AKZ90v9Kgn2EFLXisH
 dt9tpqz2DixmxVbpDCFWSYfnIoGT7mQdMAD6BXLcPzcM0eOorIn4DORM1SLWX2GvfMUYpZfuab6
 6oSigK1AIhucgkzrp2wh2yekPm6AVW6Yxa0MRM1qJhifH2OvVlf2anJkWV4CrrmMkvPbIFCs24k
 sL7+ifUGpPt9+FCKHC/lJu9LBKQK0dh0KSH8QzADXvE3zoiTu96Eap57gbjhdzoIHvVHmSNxXeH
 ndXPbiRb1TLBe4hND/hxKVsSdkcQ7zq5SVBp4tJ3dHLpxvVCrwamreTcN261PFuQR0iKGQWmDuL
 ZLrq9YYm2Yny/ywPWnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEwNiBTYWx0ZWRfX5VWMZnDl+HLK
 csFLZCTbrBrgt8UaP5uLY1z9XdNPUSU13HMHLaw7BFk38siQq6vGEnsaXmRRRFSsqV1VL+JcjY5
 Lia3X2CKq/Xs3/XQZ7A4lx60NiQwsbQ=
X-Proofpoint-GUID: EdCxMA8gnDgtKeTIDg45vP_1CUMGYlVM
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a5369a0 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8zdHjTvXFIs7SsKF2MMA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: EdCxMA8gnDgtKeTIDg45vP_1CUMGYlVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120106
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

On Tue, Jun 16, 2026 at 03:25:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Returning success (0) from `msm_dp_audio_prepare` when the display is disconnected causes silent audio failures upon hotplug and NoC errors due to unclocked DSP hardware access.
> 
> Pre-existing issues:
> - [High] Race condition between `msm_dp_audio_prepare` and `msm_dp_display_disable` causes unclocked MMIO accesses.
> --
> 
> commit bfb65364e66313dc1385a42e09172f44a1e1fbd1
> Author: Kumar Anurag <kumar.singh@oss.qualcomm.com>
> 
> drm/msm/dp: return 0 from audio_prepare when cable is disconnected
> 
> PipeWire treats a non-zero return from prepare as fatal, marking the
> DP audio device as a dummy sink when the cable is unplugged.
> 
> > The active_stream_cnt guard already prevents any unclocked hardware access,
> > so return success instead of -EINVAL when the link is not active.
> 
> [Severity: High]
> Is this commit message accurate for the upstream tree? There doesn't appear
> to be an active_stream_cnt guard in the mainline driver. Without this guard,
> will the DSP push data to powered-off, unclocked DP hardware and cause NoC
> errors?

$ git describe
v7.2-rc2-4669-gb9810cd75b9f
$ git grep active_stream_cnt
$

Which tree has this commit message been based on?

> 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> > index 41018e82efa10..df222943ae57f 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> > @@ -284,10 +284,8 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
> >  	 * such cases check for connection status and bail out if not
> >  	 * connected.
> >  	 */
> > -	if (!msm_dp_display->power_on) {
> > -		rc = -EINVAL;
> > +	if (!msm_dp_display->power_on)
> >  		goto end;
> 
> [Severity: High]
> Does returning 0 here trick the ALSA/ASoC framework into marking the stream
> as successfully prepared?
> 
> If the stream is marked RUNNING, ALSA won't re-invoke prepare() when the
> display is later connected. Could this regression result in silent playback
> because the DP hardware is never actually configured?
> 
> [Severity: High]
> This is a pre-existing issue, but does this lockless check of power_on
> race with msm_dp_display_disable()?
> 
> If msm_dp_display_disable() runs concurrently (e.g., from a hotplug interrupt)
> immediately after this check but before audio_enabled is set to true, it will
> skip waiting and disable the DP link and clocks.
> 
> When msm_dp_audio_prepare() resumes, it will call msm_dp_audio_setup_sdp() and
> attempt MMIO operations on unclocked DP audio registers. Could this lead to a
> synchronous external abort?

I'd agree with Sashiko here. Do we guard against the unlocked access? Or
how do we ensure that the stream will be prepared later?

I think this needs to be fixed on the other side of the pipe. Do we need
to define a special prepare error code, which means "working, but not
available now" and make PulseAudio / PipeWire handle those errors
specially? How is it solved for other platforms? I don't think that
msm/dp is unique here.

Mark, would you have any particular recommendations?

-- 
With best wishes
Dmitry
