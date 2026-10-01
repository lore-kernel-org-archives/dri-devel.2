Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB55CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E7810E24B;
	Thu,  1 Oct 2026 00:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDFNtQPj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZzMViorD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4CB10E079
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 00:23:57 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UILfbo3655836
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 00:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dRWr4G35KeRP/qcct8QKgqT2f3p6uIgv8CYdpOrhrm8=; b=lDFNtQPjfBudE5/L
 KgLwrGdITQcqY0odUm6f5Vm6R8nS22mPoWGT/yPqIojkmXLeLX38S8jgyq3Qt2EK
 Q79L6Jomw+ueFIhgt8d3tx7f+2omTVpIx5BHmhJ72xDF5+pP6tbXyp8PqZxpxcaE
 igWo3Dko3szTHvHsPUeLP94I++4mVyf/mFTY6quLCFDNTelWWHAGFqGv0OKQugDY
 Lw6xaKdzfVuz5pSHUodP4jBSMUNSFLCifugjxksgSGWOMS137EhhotH0YXI3a0AK
 ingaca5Wbtvs2NdZDPGTprNcayDqqdM/53cF33dqxC18punAqOPerjjXWaZa5yL3
 nDn20g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvs830-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 00:23:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0c7126e7so1051032885a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790814236; x=1791419036;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dRWr4G35KeRP/qcct8QKgqT2f3p6uIgv8CYdpOrhrm8=;
 b=ZzMViorDi/yaVg6Br9gRYkd79k4MuDzPJdXa0gE2x2mG4PjFfcnhoFmQVvClgXp/dn
 98NjcebIWFHxPcvLRj8L8KTEP6r/mPdI4A4RKfGK7/a5sjaNwBUoNTXIaZWYSr6qI4pt
 XUCnc7+ks24WvqCKkm/DPdBgp6g2wgoMdIDoGVJ2iXaeFveLJeojQ2Pxx5DpcyRENShN
 pWjvwDZ3bG+ihQdPLBk/gNwsnCo1wcLKF6/Gq/vYO0LWUDyz12IV3qJtEMQjrHOWJYqg
 9vz+z8T+WHgkSESrE1/bgpq5l3K6mirLb6lRkibrrc8MWVXP3EMVAZMs6m3RxIXK3vCN
 7kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790814236; x=1791419036;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dRWr4G35KeRP/qcct8QKgqT2f3p6uIgv8CYdpOrhrm8=;
 b=GAJ9iVUwNSpT7NQ8LZJdcpUK3WyOkPn1v5gCLmkYcxWoR0m1X/yvaH2jpcQq4BaCV5
 dNYL3IVXvsKfEt5WHz3/BJ9eSwc0cR7NzAC81obf2bx0Ek0oX02QxVDlQIzOYhvS3y7F
 /3RqFnADtMTnSa8ieJiVncDRFFaDQum3VKLpNPTOqeO7lA03/cs7daSXorRgtyFElE4v
 zIQfHqY63WfpzEavXXLlhg4nqs0ZODH6bCjrcRv5iOvQNdMAbKMVrKmZBWZt3CKinj9o
 dRZhdmv69i6DMNo9rykBvWqdH7yz50T8HzP3tuEI85mJZbc+pUvDOieqR+kvTv8VhLqu
 n7rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByHWkMGQfAflGtjFj7DDbBNjmSP25eLWMEwr88NVkPFSt1th1ZwA7wN2joULTg/D+uyN+HHmVFQHuw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0DccUG7rxD/fa59FvNVS43ez/MggWis3ErUQ910FtchjD9jq6
 s5m7Sd88GnaNoafWz02tOt3FSd8GXAYNGNNDiMysacAeOVAveN9/6MYi6mwCz58i6Qbdadm7jB4
 SkyPsVAVWvmaGApzpq/uEYhLz1ehy6dOuhE3dKFdx3pV2zUsEZxh3FWWJ76UI+YShJeygiIU=
X-Gm-Gg: AYBFou2jemOo/fUA5hbCixoiYbWjDP9XA9h/I3TjQjAsOo8aW2Iyk8AmT6h1Lc2MZe8
 5FAjfiY2hnwGSr5rw70cYDJvVx9gxqBQERcD3nE4T5AhVz7ywGvgzMgfEAuXlzDNXBkR6whs4tM
 wIxmCwpbX/oymE3e3QV1L2fCUQ1hVXjNTa65RpgaUTlkZ0WmdIr8BOwfIc/Z0l8NdYp7hl0vYKz
 u2fjGf3nvSLMiRg5ca3jCpdrGww+Rtfptwqi77ooY6I7Xr0tbdPaa8kifvl+xBWmMmCsgmqFz3w
 khNhg6mECghidHQuzPhyodp3ooASHPJ3Iu0BOGL7bhNc/wF9SCMwwUyRGsC4X45dH595boTQ+6s
 L99oKSmCAU0YjANSIb3V7b7S67D/V+crTcfRJSZ57ko/zELCz0WzoRt9c1Xy7FwYLE+gUFPoJFD
 NvittG9tvLxyBm
X-Received: by 2002:a05:620a:439a:b0:93c:677c:778d with SMTP id
 af79cd13be357-93ca9889978mr559755085a.59.1790814235689; 
 Wed, 30 Sep 2026 17:23:55 -0700 (PDT)
X-Received: by 2002:a05:620a:439a:b0:93c:677c:778d with SMTP id
 af79cd13be357-93ca9889978mr559748785a.59.1790814234954; 
 Wed, 30 Sep 2026 17:23:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbc4a5sm319563e87.63.2026.09.30.17.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 17:23:53 -0700 (PDT)
Date: Thu, 1 Oct 2026 03:23:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] drm/msm/dsi: Support dual panel use case with
 single CRTC
Message-ID: <ojszylphvpite2r5hoihwcusm5xiun6rjgxsw5kdhvhh3yhq5x@s747ah6cxukd>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-4-c042266b9eeb@linaro.org>
 <jwlmzhhgpvbi47lt4biwn4razrvbf2rfi5uyyvfhjomzo7uqyh@ahf4ubqvegst>
 <CABymUCP7DMOqN9j2ZWEtDxWpZSbNWbrYzdJ57crsR03hys67mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCP7DMOqN9j2ZWEtDxWpZSbNWbrYzdJ57crsR03hys67mg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: dh81Rn2ZkgniRjFS9UNKeFxiSAIsKUcF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwMSBTYWx0ZWRfX3UXOHp8nlQgn
 2D6gEeB0fR0/wLkxwga3H+BARpNEvWvWKw+HsaH7xRGWAswdU5rartkKeYduC5zToO3TSTyteaC
 5z97sCefHOIGIjq3W2pk9Eo1JY8p69rnpXa6YeaBnIUJw0R3aS5TX6uwCxnVws9U37QfZomAJdD
 80rk5JjLaYW7mfP3/ah8fK/jCYQu3UzpELPgYFISfb70cz4hC9LhcZNpByftLZrk5Ol6se2fKKD
 YJizRJCqc2CldXYZuk7ywdfiP3FXcpKfISF149fj6fyTcZpeFsY2/1/oicPwutKFO9IP4/Z+ivl
 XMmIkRV1n9TyVTNvF6F1wQJQW2QgdlB5U8IplQ0DDjo5Gt/1BqnYrEW1wRY43GfsTyCjlCAOida
 tin2bpuBFVl4+9OBUWNN3I7Y0r5rP4JYSMqAkdphZstwkzO1/Y1E003sK5VDINcsRqUr9LYE418
 fJ9yn4ijS22PrSNpLfw==
X-Proofpoint-GUID: dh81Rn2ZkgniRjFS9UNKeFxiSAIsKUcF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwMSBTYWx0ZWRfX1kuq6Q9kTaII
 jdB/urkGgZ6FtBmoVJz8umHBSpccvw3IgdYIOGLPZe3AbEWlxIEnWr4PSkECxpPzyY/H1F/hNuy
 PRJbssTC1+83hfitIrgNVwCFE/95Kls=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abda81c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ZtgA4oShcCahqduzc80A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010001
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

On Thu, Oct 01, 2026 at 12:10:13AM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年9月30日周三 00:20写道：
> >
> > On Mon, Jul 27, 2026 at 04:08:43PM +0800, Jun Nie wrote:
> > > Support a hardware configuration where two independent DSI panels are
> > > driven by a single, synchronous CRTC. This configuration uses a bonded
> > > DSI link to provide a unified vblank for both displays.
> > >
> > > This allows application software to treat the two displays as a single,
> > > wide framebuffer with a synchronized refresh cycle, simplifying rendering
> > > logic for side-by-side panel arrangements.
> > >
> > > At the DSI host level, the frame width for each link must be that of an
> > > individual panel. The driver therefore halves the CRTC's horizontal
> > > resolution before configuring the DSI host and any DSC encoders, ensuring
> > > each panel receives the correct half of the framebuffer.
> >
> > I guess, the flag from the previous patch should be coming from the DT
> > node of the DSI host. The DSI should then get the mode from a single
> > panel and then set the adjusted_mode for the CRTC (note sure how this
> > will work for the compositors though).
> 
> The original information comes from the panel. Panel driver exposes
> the flag to dsi host. Because the panel driver hides all dual physical
> panels stuff and exposes a single panel to DRM framework, so it exposes
> the doubled mode to DRM framework level too. This simplifies the
> handling of 2 physical panels in DRM level and compositors level.

It simplifies the compositor, but it complicates the kernel code.
Handling this exctra flag becomes non-obvious, sorry. Also, how does all
of this map to any other vendor? Or to the case of non-DCS controlled
DSI output?

> >
> >
> > Also please note that the are other possible configurations. For
> > example, for some time I've had a setup using two Raspberry panels
> > attached to two DSI hosts for exactly the same purpose (please check, I
> > think Neil might still have it, or maybe somebody else from the team).
> > Each channel is an I2C-controlled DSI-to-DPI bridge + a DPI panel. I
> > understand that it's not your target, but it's something to keep in
> > mind. I'd say, the bare minimum would be to resolve a second bridge (be
> > it a full bridge or a panel bridge), possibly create a second bridge
> > chain (remember, bridges don't support branching, so you are a bit on
> > your own here) and at least manually call the callbacks. This would
> > ensure that the second panel (or a second bridge) is properly controlled
> > (and thus would get rid of the second reset GPIO from your patches).
> 
> I asked Neil but he has no idea on this. Per your description, you have 2
> DRM connectors/bridges for 2 physical panels. I guess you have topology:
> 1 CRTC + 2*(encoder / connector / bridge). The handling of 2 physical
> panels falls into DRM level, not inside panel driver as this patch set.
> This 2 methodology does not conflict in theory. Do you see and conflict in
> implementation?

Frankly, I don't think that the fake-double-panel sould land. The device
has two actual panels, tiled into L+R. So, exporting that information
would sounds like a better choice (I might be wrong here, though).
It feels like your patchset is trying to cover a single usecase, which
is understandable, but it's not a typical way we work (or accept
patches).

I *think* that the fact that having two panels should be visible.

BUT, there is a more important part. From the userspace point of view,
you have a stereo monitor, supporting the 3D SBS full mode (and
hopefully a single non-3D mode).

The compositors need to set DRM_CLIENT_CAP_STEREO_3D, then it will see
the 3D mode, etc. All other compositors will see a non-3D mode,
outputting the same image to both eyes.

> >
> > > The pic_width is used to calculated DSC parameter for DPU DSC controller
> > >  together with panel's parameter. While panel driver that support dual
> > > panel shall provide slice_width parameter of single panel. This patch
> > > only impact DSC configuration, so crtc is not aware of it and not impacted
> > > by it.
> > >
> > > While the DSI panel driver should manage two panels togehter.
> > > 1. During probe, the driver finds the sibling dsi host via device tree
> > > phandle and register the 2nd panel to get another mipi_dsi_device.
> > > 2. Set dual_panel flag on both mipi_dsi_device.
> > > 3. Prepare DSC data per requirement from single panel.
> > > 4. All DSI commands should be send on every DSI link.
> >
> > broadcasting of DSI commands is controlled by the DT flag.
> 
> Do you mean the property, qcom,sync-dual-dsi? It is QCOM specific
> feature to send DSI commands twice in host driver. It can be done
> in panel side as well. The bonus to do in panel side is that the
> panel driver is more generic and can work with other SoC in theory.
> And the DSI commands can be handled together with regulators
> etc for 2 physical panels in a centric way. The panel driver is
> more self-contained, minimizing dependency on the dsi host.

And then the panel driver becomes specific to the L+R configuration.

> 
> >
> > > 5. Handle power supply for 2 panels in one shot, the same is true to
> > >    brightness.
> > > 6. From the CRTC's perspective, the two panels appear as one wide display.
> > >    The driver exposes a DRM mode where the horizontal timings (hdisplay,
> > >    hsync_start, etc.) are doubled, while the vertical timings remain those
> > >    of a single panel. Because 2 panels are expected to be mounted in
> > >    left/right position.
> > >

-- 
With best wishes
Dmitry
