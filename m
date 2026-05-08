Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD87CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBAD510F451;
	Fri,  8 May 2026 11:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eik6HdXM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MwpAmNQZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C16E10F47A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:29:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6487KejI318043
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 11:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4n0gQBv7g7lIgSwaGYb3+mof
 ndGuALBc8vtoBzZ53cQ=; b=Eik6HdXMKFPgC6JzNCcdlb5WF5VPsb6EHsZmktl0
 1UpMdQ7b3Jn/28Z5mB88ZMwA6xIGcISEQpqzPESIP3Por1y0/m+6nnlS0ZC+mTh8
 OkpNovdzZxRUo8eznjAKx5r0Gc/qQfrRJCAzxMS53tJSiMxu8u4Rgecuyqwp3+Du
 TFFQch1xeGTE2dz8oBh7kpGNI8DX3hg/LGLYIm4cOkZnhz6vnLcGn1kYBYGZlx8c
 xOQ9SFtBRBKrn/lbwtlvzmWBwAZlgSfoZjaIu4GHjLNMhK8b/crsLx6QTTnPw+qX
 piHIes65Sxpar0A6XF7lcN1jB2ZAaYQvkarq94/FILDJ/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc00yek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:29:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d890580e1so32635771cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778239773; x=1778844573;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4n0gQBv7g7lIgSwaGYb3+mofndGuALBc8vtoBzZ53cQ=;
 b=MwpAmNQZhF83wSUgfLF3HIuQsP/8GI013I6SngB0aFZuKocixr7G2s+bvYPo4nWbAe
 +8T1K373vOo7u/GOUowKJmU29dN3ltD/mCxiJqDNoGXQEAus5DTFHef3/z8bWahTwIXC
 ufePxmo/k+R0F6nOpC1QlVvET9aXxfm5tsUQiZ2AGBio4dUleiwh37Fhjktgq9I6zQMD
 5QfSk+sCCvZv5kofPWQgNRMCFCtL7MJvURfp/knNikC1kgUDLMUs7DyC0E4HrjnrG3sB
 oJHQ847lqmDzPqYlwRHOA9p2VpehSTICGOu7N3QipsGK3EbCh9zK1e05786M98cIL2Y4
 pItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239773; x=1778844573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4n0gQBv7g7lIgSwaGYb3+mofndGuALBc8vtoBzZ53cQ=;
 b=CE90w8/kmE2hT58oC067rEIq8an+43tjjx8QFzCHpdDuO6W+vDaiOWukssxesTAoP7
 fk7ZiSz5wm27ThcLJoMpu84WRMN+etXDzh2vfwUSpVQr2/61oOgIyXgnPqtkwmGJo0/3
 SMStIJ5Gysy4B6r0hs+eOkrnOn5IT61EmDwbq79nT/u5mpnLaw8KxDp6guYFy3s0sXDy
 VmBms9eBRo2PG1SLgocgJr0vie1kpVihYtS0urfx/8+EVJ+ROdYQj13H4yfqhwcMjBjm
 IdcluAtjbSYVjUyGvByoJcg7XsTFs21aENeCOemV8OuVUva0UgTkBb8lV+4iRnPE5uFi
 UTMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YxMXHrRUyabOmheN5VTU5Z+vo0oz7lcz0O0ThjI3JyUklg1lHYWuvXEI0KmUMEyAj5iEJX0Fe8ow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0uhSUoDT35pBNUCzlhZxNFM514RFXTnG4+Va1nqy6AaQWEsQw
 VHAkioAPBaoFTFnXHIJGEpZRNYAFCrOr3IVa5h6Y18XNo36540p0YHAcBfP/TrsVF5bqtw8mKcK
 0hgPIy/YzDJ1xEJmaqM1fnOi0HpL8+EOOS5vuLIMOMSXHkyMTC49crWbM+Am3qVs7o0zMPWI=
X-Gm-Gg: AeBDietwvgL3R4wpo5a0ZfLQSXOMat0bPwCcqRdJnsuIKR+6jXR9n4sCzsLH7H+TH1u
 zfb3Si5lefvPFu+lSopKA40boslSRf5nt7fjkeqEZp80aIX1Oue56P7BlVNodjMGdpybtHBGx0s
 Kx9qOuk48EmlRiM5OnVQOfc3bVpGnU9HGO7/VZxi5g+KPLM9U8y6s9K2JSrXxEvd5T5M4y+VN/q
 fhOpxboi35nEWF6lOcL09voWuYG+Wd0LhKbA9dDB0NjLDFUD3zASyBe7etXlu5U9zLljWiL/JlX
 yvNoCSWtO/oAi0YHba6QTOaD+ecKf0x3aNNVEMdEayukEYj4azDsNYdYPdS+iMRamLnS0aK8clM
 +az/5YsqpvamzlVFS8H8MHzSE1IXTCp6fIj/RSOvGa4vkdTizzVyr4M7kd1C4Hk5PxuTlPAxOn4
 0b8qHeWVAyOd6jSOy7TvBbxQDhn6UHYESoAQw=
X-Received: by 2002:ac8:5845:0:b0:50f:b6ef:e10b with SMTP id
 d75a77b69052e-51461e3e804mr161618161cf.27.1778239773166; 
 Fri, 08 May 2026 04:29:33 -0700 (PDT)
X-Received: by 2002:ac8:5845:0:b0:50f:b6ef:e10b with SMTP id
 d75a77b69052e-51461e3e804mr161617811cf.27.1778239772633; 
 Fri, 08 May 2026 04:29:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a9527087sm436597e87.33.2026.05.08.04.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:29:31 -0700 (PDT)
Date: Fri, 8 May 2026 14:29:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Junzhi Zhao <junzhi.zhao@mediatek.com>, Jie Qiu <jie.qiu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drm/mediatek: hdmi: report jack plugged state from
 bridge enable/disable
Message-ID: <v343uqdgy65yg3lm7rcv57mlpkudqxrnori6lnunaiiewakhyd@wnxkqhhwwvgg>
References: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
 <c4d62fc2244fb72207855c5a366ff10fad419f2d.1776265222.git.daniel@makrotopia.org>
 <lhxivpwo6aq3ehgzsnkgxnqis5tptmey4dtbhaokyckkl7ghbn@dzaj225pnpk3>
 <afyUfcr8HuFs6EKF@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afyUfcr8HuFs6EKF@makrotopia.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExOCBTYWx0ZWRfX2ubM5OIgtHBR
 KVCpd7UW8b/lt47t9gkj7/FjA6P9tb1E/e5vL/t3GlW5NqJiKmqBs7apgPc6vjHJ4TyRdfzlvgG
 4/VfnwTSXsk1xp/QM6lmuMtcqCfWvxSWQufjhJjm0fa4kpMQ314qWCoFcgMAKCznrYQBTIrPbzG
 pJVEWiZIvpV/vmHW9hMJTtL9GhZkC+eljBo5qgbpPvwn9hVOKKhfP++ZHkFBlnGzfwZIHPggISW
 /k/R+Ld5akC3eMhVRrxCg/UK8zb3YrNe1DTBKmjB7y5gpImKdiZVIV/8nzbAnr95HZJlbQdAsc0
 nJcTX1Inq+QMT0GAT0HR8wx0K1FTLmDkEFzRZoRZlhR2Vz6s7izo5l412oBpzb/pPw/7E02/ddJ
 ismSsPtkWW8H+/KxE3dLBqW9O0H93tI1f9fjcaV+V+lUVKMvXukyHeGDXUBfCldHKKtzojzBu2u
 WmlZuocppWjMpKbdBzw==
X-Proofpoint-GUID: h4EraeNFENOkay0c0F0cjD4f3F9jO5ri
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fdc91e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=eCKN-1Wp6XfqvTAENJ4A:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: h4EraeNFENOkay0c0F0cjD4f3F9jO5ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080118
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

On Thu, May 07, 2026 at 02:32:45PM +0100, Daniel Golle wrote:
> On Thu, May 07, 2026 at 12:51:56PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Apr 15, 2026 at 04:04:16PM +0100, Daniel Golle wrote:
> > > Notify hdmi-codec of the current sink plugged state from
> > > mtk_hdmi_bridge_atomic_enable() and mtk_hdmi_bridge_atomic_disable()
> > > via mtk_hdmi_update_plugged_status(). This matches the pattern used
> > > by dw-hdmi, which invokes handle_plugged_change() from the bridge
> > > enable and disable paths so that ASoC jack state stays in sync with
> > > the actual sink presence across atomic commit cycles, and not only
> > > on CEC HPD transitions.
> > > 
> > > Userspace audio daemons (e.g. pipewire) rely on the jack state to
> > > route streams, restore per-sink volume levels, and recover the last
> > > used device after a reconnect. Without this, those transitions are
> > > missed whenever the sink change is driven by a mode set rather than
> > > by a bare HPD event.
> > 
> > I can only hope to see mtk_hdmi to migrate to DRM_BRIDGE_OP_HDMI and
> > DRM_BRIDGE_OP_HDMI_AUDIO...
> > 
> > I think the correct timing was discussed several times and the overall
> > conclusion was that the correct time is when the actual HDMI cable is
> > being plugged / unplugged. See the discussion around [1] and the
> > captured response of Mark Brown.
> 
> Thank you for bringing this to my attention. I'll follow up on it.
> Meanwhile, can (independent) patch 1/2 already be merged, or at least
> get reviewed?


The discussion that I pointed to suggests that the patch is incorrect.

-- 
With best wishes
Dmitry
