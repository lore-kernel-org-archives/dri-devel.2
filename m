Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF402CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 12:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F0C10F46F;
	Fri,  8 May 2026 12:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="asrMxzoZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/N7m0La";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175E910F46E
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 12:07:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648AUfSq2182933
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 12:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eVsTALs8yQuwUz11IVk8+Pby7wTwW8t8CLZPh0Fg3XE=; b=asrMxzoZ2nc8CVtb
 QfEsgxHkuEO4CssLLzL4PSG8xDjTMlc2yv9YiKlILTVYmhYe60VJ0n1AA4dABNPr
 DOxtm7mfjSQdrtePvy1RZqETCdeLaBXz8BAnmvIlos4UzryJGlpDCxJDBwVQFphe
 UWLeZm4R+8gNCFfrkfXxNyNNXQtBxz9yFS+ES1zRJu7cGFIkjArrMvb+766wAPs+
 TOCOT1vzGF8LRB2i6zB6ARFLKjqayaKjX5JoYuRpZoBNisdQGJ9iCO7vufvcrUW3
 tVnSqoXt9rpfcRfM45kGlMbv/OW+9pgm/2etfAj23oxPTgpzqvR1zfkH2ckPCUin
 kd2tzg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10pyb9bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 12:07:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-958a0e94ff9so944423241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778242072; x=1778846872;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eVsTALs8yQuwUz11IVk8+Pby7wTwW8t8CLZPh0Fg3XE=;
 b=A/N7m0LaLUuxT6GeRXXEAg9snIXEfEQDCx7AgcoLDVkdNSa3JQA2ZmRzYZAUNPatyt
 DgVoPkdCwof3oy36IbKV4U585H3/4oJ5zfv6xLjGJVeJmnDvWt6y9xSpw2FnIEsElgUS
 2ce0PRz760BC+VMPrLThy++7zr+bLIlT0KBM48bcpLvxOOcqCK+7qy6sWBVFSCVCM7nq
 VDwvAiL+mpD87cq+NJHB7WvWSVETr6zFruudxaMLmLH9NX5vamlDk+aI/d/Im/eumeHP
 OunX7F54dDo407HHZPI922a1GYVqOXTmWq3/Fn/nKQkhvmnAReJSwdclw9TZ2ZKfSfer
 HwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778242072; x=1778846872;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVsTALs8yQuwUz11IVk8+Pby7wTwW8t8CLZPh0Fg3XE=;
 b=p5KQcXpsPYzMxti+weu3mLxI9apGR7iskSdmNAn6lAHjA4e5lo7P9G2B4YwHeDZVex
 gmSf0voZlpdSucs70jRZ9Ylp44Ft+Ts2DJSJ+vbMlEhPYqpAU5jrTC83XMk8ZQE4SUnS
 I9UR2JP1JBcOdcQ39mC4f5PDqXhdbr+chZDnABWLtQT2O19RbOn/60jh89RaWhLXRmBp
 y63CUpm+P6nRYdsdW3mmH7+PuzeSdilbcRs4wrbaw9OfV6pXp86QZ1LrJ5UE8uaaQ8sL
 bKau7DvKfmpRSAgXYPY3JDR+P883Bec2DZWKECChNVWEautJ4KKUJ45IQBvZzQ4tujBF
 wKgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JNrtjVqgkK7JF6Yzu7rC1K/8W53PzYh7ANwfocn1xFBMwJOGJoJ92FG65Aq1lOKlSh7RJON8WAE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7e7jJr8As0J8lNknmsXU+TDsfZkB/OfvXosb3fPVKaitFn/6R
 5DTVOvjco+uek/H3e0codv6CwpQ4pR/4PQToh0wfcpd6rYS61GgaQv/n2TFuumJNKvD/KC21ZfZ
 STaJRaecvKg48Qya1HqkwsSRDRGthpBub/+Msa5hErWHkchzvMZDv88XbypdwLUxfSi8+zJY=
X-Gm-Gg: Acq92OEW0TqFdkliuEGreFFxtj/xDmExW3TPLLWDblIummPJvisquIg3cRVd0nHaXOq
 +SPSnS4kj1XEweJSek+PLUStWsGqAuX7vMYpbxQqpegHklG8dOv6Ib0EoKCr5/VjSmJbFzr0XsD
 aC8DObicAldg0kTV5nwLhrAoqitMCWmrZTeY8blf5k40NJUQVzvEn6XiXfhaoCazRG65fujLWw/
 856dM4B/9+LSK0IHLkA8tSeTphiZT5IkpR1zIGqODXefwQ90VbB5kYdwJaj+bJoYALR2oaUGNBf
 Br14YaUupv0MPKlSrL43IpKS0NUneBMhoJQ9mRogFYLzkN7NnTECFMu6cptYavi0EJLL5dTetDE
 NPM+OWU3WXPqKn1r5QyVFqMfg5O5IpwkPtKQvEKVunfi5KgVRf925rWk2B1tymScKFrNISW+52Q
 WywQhxhdjwYN8KTTkvlFKhF7HVKRJWAYbQo6E=
X-Received: by 2002:a05:6102:5045:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-630f8e751ccmr6928167137.3.1778242072244; 
 Fri, 08 May 2026 05:07:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5045:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-630f8e751ccmr6928116137.3.1778242071782; 
 Fri, 08 May 2026 05:07:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f9ffa0a0sm3001251fa.21.2026.05.08.05.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 05:07:50 -0700 (PDT)
Date: Fri, 8 May 2026 15:07:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: John Harrison <John.Harrison@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
Message-ID: <hzesog5n7iv7rsgk246uzjmqjvkxwv4nqx3uc3ybx4fgia7smq@fue5c3cjobi3>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
 <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
 <f6d9e805-328d-4d9c-8a40-32b47fcedd51@Igalia.com>
 <CACSVV00zgV02t0CGaDUJyTGBceBk7MFaOQ7Uc6ynpRkxdBwZhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00zgV02t0CGaDUJyTGBceBk7MFaOQ7Uc6ynpRkxdBwZhA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=DZUnbPtW c=1 sm=1 tr=0 ts=69fdd219 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=V2sgnzSHAAAA:8 a=EUspDBNiAAAA:8 a=ZsvpycJ9WFwsJDxaJ5IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: jz8pG_mNOtxAP7eXHEIHACsk3F-LmTOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNiBTYWx0ZWRfX0Otm3+UDLZJV
 4OfAOQpMNENfDxxy9IwFQ+32NvWEVXreWTQflHZCjvMdG/ASNxQ8p2J2MN3LX28VOsMhwS7vL4p
 vdJ1xjHdP7ae2fBfQsUFXCvZ2/fpBimWOf7V0PhQxxctwAaC8iCjiCtgIwEeyzeroib8w3/NHvQ
 mxcItujntxM+2V1CMENAfIl2NZ8p1mMtUNkAvWqlnDOmgoxX3oc4Xw/Xa1rQn4ZIb4HfcCS2hRW
 MXk/nN43hYjlaHigLPhkIufA+Z6mktmfD758tMhaoM0LQf37eeUTKnRWbfsbj4Dfy7E2rXlp/7s
 er9Iz5kVf1y8uGoxdU+uqw3fQpF2eR62fUst8IKBaUoZcQQLh727htV2dtzh2SGDLt1FzpHn0PQ
 gvyAgKon998OLKib7HMHrfTNopxJDYFsJBRxlHKaxofmog81wjrld9rzNzBpVsF1QzTglv/ggdD
 lv0xTTBALf7pUXEVEeA==
X-Proofpoint-ORIG-GUID: jz8pG_mNOtxAP7eXHEIHACsk3F-LmTOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080126
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

On Thu, May 07, 2026 at 09:30:44AM -0700, Rob Clark wrote:
> On Thu, May 7, 2026 at 9:29 AM John Harrison <John.Harrison@igalia.com> wrote:
> >
> > Resending because apparently it got sent as HTML and was rejected by the
> > mailing lists...
> >
> > On 5/5/26 14:49, Rob Clark wrote:
> > > On Mon, May 4, 2026 at 5:25 PM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >> Mixing devm and drmm functions will result in a use-after-free on msm
> > >> driver teardown if userspace keeps a reference on the drm device:
> > >> The WB connector data will be destroyed because of the use of
> > >> devm_kzalloc()), while the usersoace still can try interacting with the
> > >> WB connector (which uses drmm_ functions).
> > >>
> > >> Change dpu_writeback_init() to use drmm_.
> > >  From [1] it doesn't sound like userspace holding the drm device open
> > > is the issue (if that were possible, it seems like it would go badly),
> > > but rather the order of managed cleanup?
> > >
> > > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753
> > So is this not an actual issue that has been seen in the wild? It is
> > just a theoretical issue based on code observation?
> >
> > If so, then maybe the comment should just be something like:
> >
> >     dpu_writeback_init() was mixing devm and drmm functions - allocating
> >     using devm and then passing to drmm to manage. This creates the
> >     potential for a use-after-free bug as drmm and devm have different
> >     lifetimes. Fix that by consistently using drmm management.
> >
> 
> I've not seen this issue myself, but I guess Dmitry has.  That comment
> sounds more in-line with what I _think_ is happening..

No, I also haven't seen it. It's a teoretical issue from my PoV.


-- 
With best wishes
Dmitry
