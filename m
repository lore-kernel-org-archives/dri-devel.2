Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429DDCD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBAA10F1A8;
	Thu,  7 May 2026 15:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR5gwrTp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gypxXDGs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CBD10F1A8
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:18:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647EeR9S259326
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 15:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=auDUMuRyfN/cj1KdvcrFiCPeRsi8JlAAoEjgRQUWack=; b=TR
 5gwrTpW9iBTzyT/I9+2hDrKUU0mfax2DrSOuyzHxjgDo3aa7wqf/3Ei90nmkHyXV
 THoiYja3E1KH++YptQ1k6X1RFJmVPn4wwIAMw2ircLv4aErMZxLXYcPuN2lWzVca
 AhDZ56cQ3U5XKsWlipF1f2OU1V9Xp6HKNGZYfxExWvNUJsIQvRo4iQtuc1q7nulA
 4cNb8W6IDczTXQtxCW8Hnx42B4SPNwldclNzLKlgYDXbxs0UUijrcE1sgilcAnrN
 v5avALktFJO+RAlgwNYOghpJz8XQogtsWH8UmvFdVffIJH78Rvv2XYYO6SBjcIPd
 gAMDmjXETOWKRtUruyHA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8tt6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 15:18:24 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1306c2f7037so992204c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167104; cv=none;
 d=google.com; s=arc-20240605;
 b=LW/RhFCgtfieeDw/8HkILDoAxPfOHgnVctvd6Zrc85rTrbzymkUpE03Ptmf9LzicOw
 1VV2m7DNQAHYuhcOyT5i1U8fYCqTYB9qSOeMGGYLbzsEGtqFyPURHWqCm03sHpbRPC8f
 tzlJiOTk3us+C5TKO5HQz277IfaEUO1q+NI4vxnr1za9Y1KYqDFc6stzOycFwv72ND/E
 VD7yomdpOfJUHniZNDBGLdN/Q8yXEyrezKQ0EQXw0x9LurPIFwCU6AtrA0VTev8Lnu07
 8J3nYnq6usUuo1OE2pd4gHXSBuO1JOusOCdwQ5MEdLL2fYKX9mKh+0ITqj8VE9ATc+XQ
 KfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=auDUMuRyfN/cj1KdvcrFiCPeRsi8JlAAoEjgRQUWack=;
 fh=AFdiETHM3QE5sXCFSKRiwQ4dxilJB2Fb3/Slc3OlJ/w=;
 b=Cxq+Vxnc7vHIPqKIZ9jHUpkZdjEIneVdgx2uSsgsrmY9UyufiYrHWdnDHk+hmyWS7S
 HKhTg2B4BArjty0RKuByj9K1PAuGzRIRvvq8HDJnHOLeqZCq8+Ka4DSg0lW44fX0FM2P
 SSPNFXB3rhN2RokFOOWAOdL/m6hzT/srsqi455oMvgiQxoTZgigBH1koRR0SfgyBSHY3
 i+020XnLVGn1v/osCz8ZNvj6jYCKAI6Nd08Kr66UHRB7j7+1xz68m5VCQsc91e8Q/bzs
 8H0V8HfDYTdfNivi6SN/jtsqCcmoXDKQyULQ1clwq8fXptbRQ+T4Cwnw5/U9SFyPWdpu
 3fgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778167104; x=1778771904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=auDUMuRyfN/cj1KdvcrFiCPeRsi8JlAAoEjgRQUWack=;
 b=gypxXDGs2fyfKpOd4XbtkjpV8puDiorw/LWVGlY26uBAe/0VoCXtEfs/Biw/KtI0OC
 67YsuSudD4HPHxIjcyEfX3Lz4vXjdkJR6mmo4k8oVQlH01oFpyfnr4drfaEIc2a7zRbs
 wRVRftARA7KtToxGSGpx3LmA239ZvKH647SjWf2fJwJwoF1lpCyX+xiTZJvop40IT9NJ
 8SYB5VmJO8aXJk6bVPcAFTf6E53uW6OPqrmBfPwux4Rhnn+kAfGJJMecTSwd9F6P0len
 7o4FkzZ2vI4uLxWceH5DBr+1AuEq/mUuEpC8G8vzg3ZwZvKu4FoIUvEVxO/bmvt137LT
 ZBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167104; x=1778771904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auDUMuRyfN/cj1KdvcrFiCPeRsi8JlAAoEjgRQUWack=;
 b=DHVAuOT20e/HMqCWb31p5QsoR0b7xRTHvVGowqySngU33JdwQ12m2V3VqmDrdxS68p
 FIgrbb1cL16jeFgcH/BOFtRhe8vk43GhZ/zkz/CeB2eg9GB8IYka0G8yvYLGZGi+m12D
 ZRxn9Dd3E5mHrk7gYDW6Xrla98RIkuWUwQwFWIDa15YyMtq1ieBAu/OUGsVGLWPktOH7
 m8Fl+AV1VnMCFyE96bxTbEyhIcNHwKy61hrfjm2CJyIkCrhlaPAvVYa5SyFpqWDklDGC
 Jdsz8sLlTawwjj/HwMvp6qCADamWcgzratXNBXvVpluoEXAHrg6Z+phNq1yuy+1ch9Mo
 fc7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BFVdRyAUKLgapaa6x3N1mhWGbMaCbVCkzxwRLxh6xeUhE3HUJeCslE2RxO4kR6ntiYpDY+ZaZ7UM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFXmkqdHUfoZcZljOM8Oki+iVZCV2WfIKBM6EGrcvycD8HMHf7
 SYwovEW1EQw6rkXbnTEcEydqt4uXNpESszG0aAw38Ldp7XKhRCkj2uq79Jsh1JJQXsbqkBR2bVJ
 zkvo7wkb1qgyDmWPSO3BWRiq8JtR8kLFRJD6/J1u7wHlYgY/YC2lKcqeB8z8abdIw6uvSkYEEgX
 a73ePy2qwQ/8TRAUpWnqDnShV7FsOLy0sp+2NuDdD8W7kRkw==
X-Gm-Gg: AeBDiesCPkIl2CcPrqgOv7GvztaMkjHoY6hqHcoiG2/0qF0Z62nyZalx3szOKqLJ/A8
 NqlkGcQyoXU7ONL1LagGIxjXJMXf0AR9w5FPr/4bKhH74YmXNQcLujHof/ylLkXhadRp4ILemtZ
 yl8p24myk/mrkJ1CCL1fmjDeGF37NXTxd0OiVvPCCF7vmmrqazM52IBltkovPk/zyvZyNCuqmzl
 JulZ44v9OF9jTyAEOCw0kcOkEs1S9bhOjkv4KPyaIy0Atks
X-Received: by 2002:a05:7022:6184:b0:12d:c4cf:cd7 with SMTP id
 a92af1059eb24-131967d5328mr4459212c88.8.1778167103634; 
 Thu, 07 May 2026 08:18:23 -0700 (PDT)
X-Received: by 2002:a05:7022:6184:b0:12d:c4cf:cd7 with SMTP id
 a92af1059eb24-131967d5328mr4459165c88.8.1778167103051; Thu, 07 May 2026
 08:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
 <afxi9ab1O9J_7J1Y@e142607> <20260507141027.166ab00d@fedora>
 <afykcyiURGZh0xdr@e142607> <20260507170343.044934a0@fedora>
In-Reply-To: <20260507170343.044934a0@fedora>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 7 May 2026 08:18:11 -0700
X-Gm-Features: AVHnY4IZP4mKinqS_tOhHtXbsn7pn6oSMK1COKrIgdveZWhU3OUNJZSGy0duX7w
Message-ID: <CACSVV00_OjD_MLcpnqBo-4Q0iTQuR=QoU+s30+iLw=HeW3v8YQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panthor: Don't use the racy drm_gem_lru_remove()
 helper
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: qpFnN80vYvfhVgFKGP-SkAaG5S8vqWuc
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fcad40 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=QX4gbG5DAAAA:8 a=7CQSdrXTAAAA:8
 a=9BaP3OHj2w789GXPJEAA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: qpFnN80vYvfhVgFKGP-SkAaG5S8vqWuc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MyBTYWx0ZWRfX/U/j7jtXIMWs
 JKXxfEaUeLFOBXnxEz+fDdke0F60HKP3gaYGg7xDyZHDryNNxrF8G5S9Njcm6rnkG2fPrvKcZLq
 UorLX8gXuYCG+BMI9lYVyHUDLZHYu9FDi2jHtRreai5bRy4BxI0DSJ1oXChRm9WcFsNci5H+jv/
 hd930bRSvyoWH8OPEY8RhBK9CUOE2NyPEtugwUD91rA3q/NpKqKrOPHHGpK5bb6yBhXH1eo95Ne
 wGO+a192plczOvhgte+m8tkBkXaFxcejTMSZLf6Ms8sSWSRWiZa5Rzz7hyGNYmbu4spKpNbJJ/p
 UdiG50w1fWbXH5znndFxbrQP4OXn3OLypUI8bdldon6I/x+eVzSTSXvye7DEpdYp1eNjuN+ppYj
 mpO6WQWCH+73Yf9eU/Bt7DoGuiPSpnR31pV+XSTfBR8yXewlF/FDZjysIChGRJLMdxJYhThOHM1
 hecmsF/VeC6N185gq1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070153
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, May 7, 2026 at 8:03=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 7 May 2026 15:40:51 +0100
> Liviu Dudau <liviu.dudau@arm.com> wrote:
>
> > On Thu, May 07, 2026 at 02:10:27PM +0200, Boris Brezillon wrote:
> > > On Thu, 7 May 2026 11:01:25 +0100
> > > Liviu Dudau <liviu.dudau@arm.com> wrote:
> > >
> > > > On Wed, May 06, 2026 at 02:16:26PM +0200, Boris Brezillon wrote:
> > > > > drm_gem_lru_remove() dereference stores drm_gem_object::lru in a =
local
> > > > > variable that's then dereferenced to acquire the LRU lock. Becaus=
e this
> > > > > assignment in done without the LRU lock held, it can race with
> > > > > drm_gem_lru_scan() where drm_gem_object::lru is temporarily assig=
ned
> > > > > a stack-allcated LRU that goes away when leaving the function. By
> > > > > the time we dereference this local lru variable, the object might=
 already
> > > > > be gone.
> > > > >
> > > > > It feels like drm_gem_lru_move_tail() was never meant to be used =
this
> > > > > way, because there's no easy way we can avoid this race unless we=
 defer
> > > > > the locking to the caller. Let's add an explicit LRU for unreclai=
mable
> > > > > BOs instead, and have all BOs added to this LRU at creation time.
> > > >
> > > > I would argue that drm_gem_lru_scan() is broken by design. If you'r=
e going
> > > > to release the LRU lock in the middle of a loop you can expect that=
 someone
> > > > will get hold of your stack-allocated LRU and end up picking the pi=
eces.
> > >
> > > I think it's fine as long as you always use the drm_gem_lru helpers t=
o
> > > manipulate the lru field, which is true of a lot of kernel constructs=
.
> >
> > I think drm_gem_lru_scan() should never set an object's lru field to st=
ill_in_lru.
> > It should set it to NULL when the object's node is removed from its lru=
 and add
> > it into still_in_lru without making the drm_gem_object->lru to point ba=
ck to it.
> > At the very end when we splice back the still_in_lru list back into lru=
's list we
> > can then update obj->lru.
>
> Then you run into another race between drm_gem_lru_scan() and
> drm_gem_object_release(), where the LRU removal in _release() is
> skipped because obj->lru is NULL, and all of a sudden, the still_in_lru
> list has an element that's freed. Honestly, I don't think obj->lru
> pointing to a stack allocated object is a problem as long as we don't
> let gem users play freely with obj->lru (which we shouldn't do anyway).

Holding a ref while we drop the lock should keep us out of
drm_gem_object_release()..

But yeah, we should probably just document this..

BR,
-R

> >
> > >
> > > > This patch is fine in itself by trying to avoid stepping into the f=
ight,
> > > > but I think we should also add a warning in drm_gem_lru_scan() for =
future
> > > > users to be aware of the dangers.
> > >
> > > Warning the user about what? There's nothing they can do about it, an=
d
> > > I don't even think it's unsafe per-se, unless someone goes off and
> > > stores the drm_gem_object::lru value somewhere else while their shrin=
k()
> > > callback is called, and accesses it later, outside the shrinker path.
> > > Given drm_gem_lru is not refcounted, there's no way one could safely
> > > hold on the LRU they saw in the shrink() callback anyway, so I don't
> > > think that's fair to blame the drm_gem_lru API for this kind of misus=
e.
> >
> > Yeah, that would be the warning: don't store the object's lru as you mi=
ght
> > get a temporary one that will become invalid after the shrinker has run=
.
>
> Oh, you mean a comment explaining this should be avoided, not an actual
> drm_warn(). Then yes, I think it's fine to document the expectations in
> the drm_gem_object::lru doc.
