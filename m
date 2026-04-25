Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4767FF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 22:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA54110E4B5;
	Sat, 25 Apr 2026 22:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VEKPH/3G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eECBD+Lu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABE910E4B4
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 22:38:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PGNIbV156927
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 22:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=loyhz1y0SFqYlxKzVEQwQ1IC
 pNq/7m+Badw7tgFbFeo=; b=VEKPH/3GSPHeYjXKm82JY5NMXM1N096rx0ts4oaE
 tJ7SsCNlj7jUq16Xz+Rc8h8m9fn5t/RT8PjsOhHOlUF1HK+YJl7nQlx9c9tEKbjn
 WL+AXqrjOD73liPdA8cT8Vost/LSouQ5NqyTgtDMpyq/HHYW6aNlm36L3+AI9LwB
 cQYNm/TYjbyYc0BhCxWo0DVej6TOnLPNxoVjUkCBUEhL9+Fq7wp9I+8nNKx5b2v0
 Onor1khWPrAjpv7GcVHEtVXS7pfgPFrAI9a8WxDNN3lcXFJ+O/X/JkUuqxMzrebQ
 TVcEa7UKXdkQo5NL7hrvxMyCOcTQl1XdCpiY5A4c+PREvg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnpw1tg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 22:38:12 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56f52dcdc90so6300257e0c.2
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777156691; x=1777761491;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=loyhz1y0SFqYlxKzVEQwQ1ICpNq/7m+Badw7tgFbFeo=;
 b=eECBD+LuzMrzCewXW/xZ4yXicMOF0uOqo0hqqWapkczaJj1uHkayKwb3OwIjhYI21S
 Kya9tsa5x7iFed3bvxlBRZT/0FWfZ2t/FrfvZUcbR3N8ax3+bJAYM020UGl2gSghzMjN
 hCUjNnlGw2HRHue9kiFwWKSDSNTR5wDWwH362Tr+UKdrDguB9DTUihI18lTKFluMbkRo
 8BhN6fpBnHt0eLFjGs2uTG9NBsyw46/3tHYTiRoNrMzV82vZvzK1AL7JOCYtVc45NHXD
 BiAa+EpRkpzSRaUx3gtobbB2OYY3zjJHl8aJuknM5yt7XHflAQbYSoOt/jkA/Bojle1H
 bXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777156691; x=1777761491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loyhz1y0SFqYlxKzVEQwQ1ICpNq/7m+Badw7tgFbFeo=;
 b=QX37AKppvav987Tjp14c0j7rG+BrCiR44TofLCLTkdx0JWAeLb4+Ukpaom3Yd6kXSf
 iLY3fZ8OsFJxHc4DU8E/WQY/oe8aar2iMbe1kAwdPavZkj14JoM5bjeIS/pDPItUuC5q
 bhWIusNSYxptdiSzZl35TyeaLAfnSk8xibfsC0bTJvXDKNlZTtraZtNKoQwUuZPMZSiL
 lGdL5QPoZHS25CTsPqOmUe40jbHZDCykl2+OeSk++6qhtHJGxE6FX1NZQjuhas7vS78R
 omgHmvlaPfbvr/mTc4fO7JZwVsczJb9cQjOfqOPmghITmIA9v4JUpG8DVchK4m2Rh5xh
 E8oQ==
X-Gm-Message-State: AOJu0Yz1LrwY2b8oyCTy9Nt/kWuHLJPQ1FtQedrUcFVbBcTdz8qDGu33
 m944u4310wvGsfUpQSN9EVPtV+sxoZM61Do+bn9bHNSOPK4yhQ9UIXPh/YDx1CMXdEjH4TZy9GS
 zGUvQfbTzVAyll2NGDLk1UUvDRNKw1C64rROxTRUQG05U09K97RdFsuFE6JsE7SdTGG5lQG0=
X-Gm-Gg: AeBDiesKMIDQaX66hHLek+ZKuSRMoaoc4ckInCsR5mVyJ2VGyFlM4/9CfBKRN71Pelm
 yMJuFB9WKuaDWfYylHQ0uSGEpOGnW3rOfhp32SvoTHY2v1Fllb8+wCAHqXdrLaMxtoPQyNvFAsj
 VZ8phpvqk15+r3QLU4jpxPl6c8Srs/niZUbR1tE96/hjS2UeBCzrB3qaP5Vozeebx1YgdQkoS3M
 g04UJ/G9YWGwGPn5shBeipke+myguKp3gKGETbLj26ARv8WwyzZISOzN0BuLFq5JxMPzZDUHe15
 7J6x01+BbnocPVVgXdBMkVPhDqss9LKX7cb3bwLtMDtrIVnrbw8GeQDiHyCSZRPSufmbUIErmVf
 sCboIajL5K21+GOXu4dywNVV/ZogsPo6l/gRhwVT2i6THnwRsLqdnHokF2JbC5FejbZEOkmC7iv
 9zp6xTytMjC44bAGOQJeLpacRPqAIACg5UHYe4d7Brq5YDaQ==
X-Received: by 2002:a05:6102:4496:b0:605:4ff8:fc21 with SMTP id
 ada2fe7eead31-616f4d6dee8mr18177089137.8.1777156691394; 
 Sat, 25 Apr 2026 15:38:11 -0700 (PDT)
X-Received: by 2002:a05:6102:4496:b0:605:4ff8:fc21 with SMTP id
 ada2fe7eead31-616f4d6dee8mr18177076137.8.1777156690889; 
 Sat, 25 Apr 2026 15:38:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f669dsm58246391fa.14.2026.04.25.15.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 15:38:08 -0700 (PDT)
Date: Sun, 26 Apr 2026 01:38:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 4/8] DRM: Add support for client and driver indicating
 support for luminance
Message-ID: <36yykzt74yblmvomo2v6vvjrwd4cabyizvrotgqlz7pyhdujmt@ovawnnjsu44k>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-5-mario.limonciello@amd.com>
 <5trcw3bcadvk2ltmat5axlezuznylsgm5xr7dmo66o5ijcrpdz@fhv7yhmlklub>
 <cb1ab06a-630b-4bd7-95a3-5f679b84dbe2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb1ab06a-630b-4bd7-95a3-5f679b84dbe2@amd.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDI0MCBTYWx0ZWRfX1HiISxae/JXM
 +d4xrPhr7D8WhYDxAz9YgHx9TAzn94IUHgiU0Rm+YWaE05eS62iADhEKhzwe7hKDzSSgXGg45LN
 YONWEpKduXBopfQSHo25pAWZuGacQDWHzjb/+yUpqi+sTy1a/jtuuoPI1bZxReDlJeN4Ex99R3p
 IsCMK5sJ6jue2qjDT+z5zUWeT7ez5wxHHDpseERgg8CUeZBlQCUm79lNv8ebMVTH7myciU5BOHP
 Y9E0Q+l2TtSMtKfAjXp9riCPAESy5JP+fpydNuLpVIvr8Ph0hW5MaSgi9oj6QFAC84xIx//LGuB
 Ya4bzV1idFKpwSodzx/d6JjCwYJwcSpS/8z77nsv9asEQg/+PfYUzaLQCrVDEZEZuxrcJ4o0AiR
 G+CuScIXS0667uhkGqGM5oNgOwu9Mxe4fkGlgoPLju14SGVd6zjntMR6JgQPxfnCvE4rlxoGTyI
 9lo5DrRYWSNcHOp3t1A==
X-Proofpoint-ORIG-GUID: C1sHOxeh7GTMD8D9Dq_3KCFiSrpHCVlb
X-Authority-Analysis: v=2.4 cv=RaGgzVtv c=1 sm=1 tr=0 ts=69ed4254 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=ws1xHSm7LW_IKOyM:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zd2uoN0lAAAA:8 a=DhcKTTyXoQiyAYNTDQMA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: C1sHOxeh7GTMD8D9Dq_3KCFiSrpHCVlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_06,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250240
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

On Sat, Apr 25, 2026 at 09:45:30AM -0500, Mario Limonciello wrote:
> 
> 
> On 4/25/26 07:17, Dmitry Baryshkov wrote:
> > On Fri, Apr 24, 2026 at 05:09:49PM -0500, Mario Limonciello wrote:
> > > The legacy backlight control interface can only be disabled when both
> > > the client and driver have agreed that the luminance can be set during
> > > a modeset. Add capability for the client to register and for the driver
> > > to indicate support.
> > 
> > Please describe, why do we need DRM_CLIENT_CAP_LUMINANCE.
> > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++++++
> > >   drivers/gpu/drm/drm_connector.c   |  4 ++--
> > >   drivers/gpu/drm/drm_ioctl.c       | 10 ++++++++++
> > >   include/drm/drm_connector.h       |  5 +++++
> > >   include/drm/drm_drv.h             |  7 +++++++
> > >   include/drm/drm_file.h            |  8 ++++++++
> > >   include/uapi/drm/drm.h            | 10 ++++++++++
> > >   7 files changed, 66 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > index 27cc159c1d275..b5e6d940f2816 100644
> > > --- a/include/uapi/drm/drm.h
> > > +++ b/include/uapi/drm/drm.h
> > > @@ -921,6 +921,16 @@ struct drm_get_cap {
> > >    */
> > >   #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
> > > +/**
> > > + * DRM_CLIENT_CAP_LUMINANCE
> > > + *
> > > + * If set to 1, legacy sysfs interface for controlling backlight brightness will
> > > + * be disabled.  The client will include luminance values as part of the modeset.
> > 
> > I don't think this is accurate (anymore?). The sysfs doesn't seem to be
> > disabled. Rather the DRM updates it internally. Which might mean that we
> > don't need an extra client cap.
> 
> I had code in my tree for doing it and decided to defer that (see cover
> letter) but forgot to drop the cap.
> 
> I suppose this is an area that would be good to discuss if it's worth
> getting some of it done in the same series or should be deferred.
> 
> The overally idea I have is:
> 
> 1) Allow both sysfs and DRM master to do writes initially (allow
> transitioning and PoC)
> 2) Userspace changes to DRM master
> 3) Introduce client cap for it and block off sysfs writes when DRM master
> indicates it.
> 4) Move sysfs compat behind a kconfig
> 5) Drop Kconfig
> 
> The timescale between steps 3 and 5 is "many kernel cycles".

I like the idea of controlling the backlight through the connector API,
but frankly speaking, I think that the implementation is somewhat
strange. After checking the AMD driver, I'd really like to propose the
following plan (again, unless I miss something, please feel free to
point me to discussions or other patches describing the reasons):

1. Establish a way to link connectors to the backlight devices. For the
   userspace this might be visible as a symlink in sysfs, for the kernel
   drivers it should be drm_connector::backlight link to struct
   backlight_device.

   Three major cases. Maybe four.
   - Native backlight in the "big" drivers: amdgpu, i915 nouveau,
     radeon, gma500, gud, solomon.

   - ACPI backlight (here the kernel would need to find the mapping. See
     ACPI DSDT standard and USB-C mapping code for the inspiration)

   - backlight supported by the drm_panel

   - backlight provided by the separate device and identified via the
     link in OF.

   present around the time the drm_connector is created, maybe right
   after the connector is created (AMD does it in late_register, which
   sounds matching this description).

   I can help you with the "embedded" systems. Keeping the word in
   quotes as, for example, I'm currently writing from the Snapdragon
   laptop (X13s), which uses drm_panel and all the stuff.

2. Find a good way to turn the backlight on and off. I see that you have
   hooked it into the drm_atomic_connector_commit_dpms(), but the
   problem is that it is only called when userspace toggles the DPMS
   property. There are other ways to turn the output off and on.

   I _think_ the correct place would be
   drm_atomic_helper_commit_encoder_bridge_enable(). and corresponding
   dsiable() function. This is the place where the output chain gets
   enabled or disabled, no matter why is it happening.

3. Implement the client property. I don't think there is a need for the
   client capability or anything comples. The major design decision here
   should be if the property is always from 0 to 65535 or whether it
   takes backlight's max_brightness into the account and registers only
   relevant values. I don't have a strong opinion here.

   There is no need to store the brightness level, calls to
   backlight_disable() / backlight_enable() (used in the previous
   step) should do the trick.


-- 
With best wishes
Dmitry
