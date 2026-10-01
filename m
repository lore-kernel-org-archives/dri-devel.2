Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954FECA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F7110E086;
	Thu,  1 Oct 2026 00:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZtKAsRXL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EXlYnoux";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373B410E086
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 00:43:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UILh3d3655859
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 00:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6/YjcEN7BDbe1iCeqE6MfpaqcpTrbhOInw48Y0omQ9g=; b=ZtKAsRXLvhfaowk1
 fl3P+MjUdwjsYT4zBYuV/SxekN9B1MluKLMDWrvZ+r6vzuC+1orOZyObIK1CDr5d
 AyKdwi8vMclA+1J50tXc6w/Oo1g2Cu1xwmLQ5RoF9pi/7br20bv4EpOPykSmK61n
 cC8JXgZtEY9W0oEcbLPq040v2kCM0YtrTl6K9ImJFAWa+xj2Ug/7cWg/fbAHYNAx
 50WjiyR/6tDT9Ee9W9HjbYiRCIDeAtu+ZrdGNh2oiTq19hjtdzqGfkHws2dSeCaK
 wtD2xrCDPHI399ocLKuBqimXyqsoLJBys3EOBM3tFlR0itWO9w3xp2o8eWf3cPFr
 IgrBRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvs9s6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 00:43:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a183a0e93so1270065085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 17:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790815412; x=1791420212;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6/YjcEN7BDbe1iCeqE6MfpaqcpTrbhOInw48Y0omQ9g=;
 b=EXlYnouxnCMdUKYUZxRdwFIBy3g+BvHCzql5bi87ONokrphHpUq9vLz2e7YpIV1qNC
 0CqyVy3UpuUc/9uJ2/wu2U/WCyiAnDqhe8iq+2nQOStbpgTNBBvpIzasTWHWba/qieLJ
 uRatyHER2xtWj/UZc0T5tuvQVT0BavToEotAlNSQv3tSQHo/7YtC7DHQs39aOOxueuv4
 QDGB0LWK74pksMjNZh0FKNGFKU3BXMKExxUj4AKHBLHSA1Jyji3Tg9EuqgpAuZbi2yM4
 xZGXPlkZvKXC8FbHmwxDw/7x2JOEdK0HrKDNr8b3aTV1z7uSPCyP8H92NAc9oyfk/rZ4
 DFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790815412; x=1791420212;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6/YjcEN7BDbe1iCeqE6MfpaqcpTrbhOInw48Y0omQ9g=;
 b=u2eIQQ3PD8ozq0MfucG6S84ms/F/Wk9fdaWCKMjrbNu9Zsu6/VEmiE8mTO/9/skhmi
 d5XhVavQlrvqoX0fBzemYRp2XbN/b/spfWTh5V+MtkzxoodYov72W1phR573UuKwAm8C
 oFg5nSVj3fOll14zzoWQAGucyTw2gyniHEpGYqX6ll6fyLYiZoola5aGAt7+kJiVtpxl
 NI6hAe7vQUCaYHZRJy1ByAPwe3fZ4SmgIyVUIBQ0Qo/3KayzMmO1qrWSohr1YOB4eMxs
 QfpLxP0YEYeHD4VWPmZ7vDDqu0w4a5L0n9UeVo14qEKYCn1UFZZ+emlU7A4RdSDhsFVO
 lXnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzszQyCxxu6RRAVEEoPs4TTIK3/TkrB6DYOttc4cZ6wgq8CMGFsqnKMhIxG6ZN2vDcp//KvTzssuXU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5Mw+y2tFv9Fo1ZYf/VHaBnADOXO8/O0YKkC0+6RnwcEb7aaDl
 6pSeVEwO2E2kdB9zW0sKenHq+ne8IL4nEYQUYGQGcCZYLGFvG4ZIuBLJshwIGuEjMrD1UumEUJt
 qi8piYbU4CD3J492M6vrD14QGJ5MJ1TMNIDz5dXAo4NNMqcekcrD0cbuxjuFmxf96kEumddE=
X-Gm-Gg: AYBFou0uht/uO1LkHbZ/o18+kWQQ4AVimwuERVxomnMLY07sdJgzcTI8CzwTg/bVImw
 tRBpX4K19NmH+SUodXlPfBtb6Fwmz9sKngkmRpVSgBLUQ/MDywsE2JD8MLnV2Tkc4yE87+eqtUf
 eOXfWJrXNCkkTqx796XhBCUy8e1t4MzGhs98L4MsIMO/wWIdOePKTxcIWuAGVLGiBuM63VYaB1v
 e4zLZC8rqf7ViidQPp4gwB3Z7QntawAx6WpkTpxVu8mGs8ckABgsHnVkDdR+StQbodqTIcIosn9
 eOEC64FKPsaRR1G4LnFMF//elys1dvc2rvc2z8nCcmf7cwxy5QkBct6q6UVFJZC6XvwEr9I25we
 fZna3hu0O+alljcJjH14pi0665zSI+f058xiwnmyQYY5tq+RDA0EqZzh9KI4dKB5xpu0B3Jtdk8
 bGN31nCMcuKCIu
X-Received: by 2002:a05:620a:8906:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93ca980e5ccmr626386585a.47.1790815411435; 
 Wed, 30 Sep 2026 17:43:31 -0700 (PDT)
X-Received: by 2002:a05:620a:8906:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93ca980e5ccmr626381885a.47.1790815410920; 
 Wed, 30 Sep 2026 17:43:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbf047sm332884e87.76.2026.09.30.17.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 17:43:29 -0700 (PDT)
Date: Thu, 1 Oct 2026 03:43:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
Message-ID: <d3xs3kzc2wg5lkouaemdicrbtsoquff6bvmnlmuxwh4kspfs2d@b77l43axr6a4>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
 <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
 <2lcpzwh7fxecpffnakpnp5lecrm3e6u64ztat7cd75nuxofxa2@clj27bzgjy3r>
 <4d053234-06d8-4268-b60a-2fccc78da654@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d053234-06d8-4268-b60a-2fccc78da654@linaro.org>
X-Proofpoint-ORIG-GUID: InQx4dPAMrzdmkIemVZFS7bPuo-IVJI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwMSBTYWx0ZWRfX1BieeWgAf6bf
 QdM24WG1qJdbUaw+Tw9DUiUz4JIDBrUZrPGnrxpJPGi/U1div/LYBKsZSbic6vd5AhHJ8lad5BU
 ZL4h2Z23ixK+IAZLiWZeaU4LcVxunEhGGVM4Au81mlkzdsCBP0hOcFKE86mtJ8tAXdxM0fME0Fi
 Nefbr1ZIXQUlbgTqJ7uH1GMUiA6yYRXqjPB4w13FVuI0CEzlWFVGCPkMdRwx2qyDOtNEAioAT+o
 TMRVZHzW5/PyYvveHzu2XYn/DyXfEHOihwPNGb9iii1iwF9bFbrsF9cU4aVEQqOeBtzu/2ERu2a
 gN6tDcUBMg7k+DGz9JRt4NCh1UY0Fl+IF3jm9SHG476f5PpI7ZQAYnC3MMVjslfl672WcFyLJ1I
 DWTF9pBXgQvy+2DJemQ7pgUZspwaLzzXXBn8RN4C4XSzhcUzFozpJZIfla7F9AFZ0jCJ2KwffDA
 g11XABQYhUq8+2LQyJQ==
X-Proofpoint-GUID: InQx4dPAMrzdmkIemVZFS7bPuo-IVJI5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwMSBTYWx0ZWRfXw7ph3gFn+sBT
 LImtPXVHQwDliIVimFCfRCPATFHHZ+nEoKipFv6MTsCAHBmCix0owVjsFZGI5uL+PE89EcX+n6C
 akkVS5eXpNoJwzkp0pvALm1pR9oF2mQ=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abdacb4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=vnREMb7VAAAA:8
 a=VwQbUJbxAAAA:8 a=T0OYp5YwtksmxRz7AhAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
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

On Wed, Sep 30, 2026 at 09:18:55PM +0200, Neil Armstrong wrote:
> On 9/30/26 21:04, Dmitry Baryshkov wrote:
> > On Wed, Sep 30, 2026 at 06:43:47PM +0200, Neil Armstrong wrote:
> > > On 9/30/26 09:44, Linus Walleij wrote:
> > > > On Tue, Sep 29, 2026 at 3:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > 
> > > > > This entire binding seems like stitching two devices together, which
> > > > > might be fine (I don't even remember this stuff... two months old) or
> > > > > might be artificial grouping of separate devices.
> > > > 
> > > > I think that's a good point and fair pushback.
> > > > 
> > > > Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
> > > > https://www.youtube.com/watch?v=6tNGW8PoSzw
> > > > 
> > > > The current binding does not reflect the physical topology of the
> > > > actual device, and the bindings need improvements. I have a feeling
> > > > there is one display controller with two physical panels.
> > > 
> > > No there's really 2 controller and 2 separate panels, but they are not
> > > classic panel, they are a pair of panels+lens which are in front of
> > > the eyes which forms a single "image" for the brain, so they are
> > > technically a single display and requires to be hard synchronized.
> > 
> > Yes. However this approach makes it impossible to share the code between
> > the double-panel drivers and single-panel drivers. I think, that the
> > panel driver should still reference a single glass+DDIC, while letting
> > the DSI host driver to handle the bifurcation.
> 
> Yes, and no, it must really be considered as a "single panel driven by 2 identical controllers",
> and even this is really purely software implementation issue.

[...]


> > > Describing both panels into separate nodes would only be possible
> > > if we described a "VR display complex" nodes linked to both panels
> > > but this would probably be solved by actually describing the "display"
> > > linked to a DDIC controller and is out of subject for this serie,
> > > and can be added later when we properly define things.
> > 
> > I like the VR complex idea. In the end, you have two modes which you
> > most likely might want to support:
> > - L+R, having double-width CRTC scanning over a double-width framebuffer
> > - Mx2, having a single-width CRTC and a single-width framebuffer
> >    displaying the same picture to both eyes. I can imaging that knowing
> >    about L+R might be an explicit opt-in feature of the DRM interface.
> > 
> 
> This makes no sense to support both modes, and this will never be used,
> and anyway this is purely software implementation.
> 
> We're defining bindings here, describing the real reality, not hypothetical
> situation that will never happen.

Let's ignore software issues. On the hardware side, you have two
distinct DSI panels, each having its own set of controls, own DSI link
and own backlight control. 

-- 
With best wishes
Dmitry
