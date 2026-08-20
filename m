Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF3C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E1210EF95;
	Thu, 20 Aug 2026 10:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHJwVu+Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwfseLga";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB38110EF95
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:07:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8jfGA2529525
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=z8C6/88Cs+/FbVbD4LERoO0X
 qQDdvLPythJnwKlVaPE=; b=iHJwVu+Z5314Eps6OYQhkbLMkm5m2OY1FH/myogq
 cy72fgfxVMqCPgcJ0rsRchLfUktZPj4CEnPcU+m02xHAjw7gx6HcQNkZD1GWD2ZW
 RbtUc9F1u1JGkWt2wsI2HE2n0aQB+A23yh9wrE2ofTd3bG0s95nbIzF8WfkNHHyC
 /gW2G/aGTqN7A4mpq0QBScRllqvv4M2l7smF5WPXZbo0HS6qWP281mvyCdJzdADM
 Dq2dGN4UHWs8mVtrAQwCePpBLr8qjZAUBonXQL4BJdPD45roEtd//eEaNPtlCdWd
 BnbKoO/IamJ8BT1O2WHo5hhaadEeM8QVyY1jj9BlvHx4nA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv8ac8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:07:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91931144870so309444785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787220437; x=1787825237;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z8C6/88Cs+/FbVbD4LERoO0XqQDdvLPythJnwKlVaPE=;
 b=iwfseLga7RBDe9lhRIuUryI7GaqfT9jkWfCtgY9jcFSDekp+SIU7PxAukgC/LV1opI
 mznwDy3xEQNL8kouIpHQiYFptBESBTsehA6hZn2SYRhdyFY4jyXa0sCOddjYLD5Go/eG
 1xKw5K/RkfL1RLAqOxyS04W8pr8UhSPtRBSXLMzOaSO3SBteZConG+qmw/KbzwTPggeH
 eRxsC6KGgASPjx29xY8UBtWfIrenPbmlyZyvMzWB7ddUQEuEKrgBkDwZw1/kwhuvz9FF
 DZb0w1RTNTHy+puzw0RUiQZXEc5qxErTq2cnvrpoZmdGJ8mYq6E856tZB/gKeZLqGnYe
 PXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220437; x=1787825237;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z8C6/88Cs+/FbVbD4LERoO0XqQDdvLPythJnwKlVaPE=;
 b=ZdIHYIQxVC3d0E+6zaQFLdP4MHINaxjVH2nUVZXzQvDXkLOPHfWQy7/icZqCciXzPk
 JyKIyNILoGpTgS+6z1SbaI7wFgdUVbkFX5Af8wtLiTTYMu0QfRb3qDn34DZfurd0p4PN
 JhaZ2MIlDTP3HvPFPN3jhdYpROgRnVK84/yDASMhlVUadbYYvRyVfTXwhZuuWo3vaknx
 qXa5VmRWMG9lWu7pHjHXzVjtZjeXCg7YeYqeUqsIgEkX5vBKwhAfd7AslouF++Z2cG9z
 wV8uxF2XGCR3oAuLHWHg8jli9po/laU+Ow9frA5X9+lnd+eeOugVs0AxQTdp9HqZupxi
 yGEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9HQEeDA/nCFb6Qz3hPOlqJ122HL9hKofQa5M0mkWagNVoztR6nL454hOfxTASuw+D8AiobDJFZMA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrWJkHIu8Fs7A57+b6AwhuJ7SZ/pscPlbRd9EPAEXAk2fUaf9Z
 nELlcNzTjF6Ct6TOBomS0CaJ8lzQYNu+Yhkd3LzcjzV8iVR3eEElxMTdkFwRk/5trCHWbXtnb6J
 y/Oj8jmC65iDy62pPxkt/T6fT8KWHMWbrngUYYFlEJpw17rUEzk5RvMTp8AHrlYtaC34jRrA=
X-Gm-Gg: AR+sD10/fC7WIcg+nf4dljOPw5KsnSV099igomCFnkuZcoubdvgcQy8/nJIly8aqaY4
 4LmA4FHoaC5Wtzc81rSbgKtpbP2gwn/Ri9PhDqyVLH8uMSiwCDGXUdKslRR4/Y95eYMnlwTtmIa
 SGzWLcD8EydHKE9CJJNI9x9IAh8Snsqh9XINe8funZk0VtVXFrX91Qp8QBdXtkGb9s40X/j3hMN
 K4JVPZfCQr/CbPE42p2ehxeeuYJdeGWpQ0UMadqHsq+G5pPKE6Q1l1O78SHZC96jU0dg/1dXRMK
 Yvd90oB4fmG5Pa6qQGLryE5A0bUyr3dKRNzNtQeFHWbIdevdnJAfPLEkEA831bhUdfK0hS9aVTa
 BXbUv0CAWXVVarBwA+M4dllWc/hjCQIYoSSXQ7jXl8FHzkI1nGennb69NDgp8IJYmWvpVqQVL7A
 4c89ze3DeE1+XI
X-Received: by 2002:a05:620a:2602:b0:930:a12d:b158 with SMTP id
 af79cd13be357-9371e29fab7mr1125139585a.21.1787220436734; 
 Thu, 20 Aug 2026 03:07:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2602:b0:930:a12d:b158 with SMTP id
 af79cd13be357-9371e29fab7mr1125130885a.21.1787220436171; 
 Thu, 20 Aug 2026 03:07:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b4788f59acsm1173118e87.75.2026.08.20.03.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:07:14 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:07:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator driver
Message-ID: <4xcyqqrqbvgxojfcmnpwbi2uqk5tvhts52l6sxetltcgb7mo75@lfsgfoq4npz3>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
 <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
 <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
 <g5orcvzjbwww27vwcsxl3ehrek6lvznxptd7jutifoiuicjnm6@iqq2pus6omsl>
 <a642833b-f22a-4bea-8a20-0debc47e1895@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a642833b-f22a-4bea-8a20-0debc47e1895@kernel.org>
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86d1d5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xc-yKiw0VIFfRBD-69AA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NCBTYWx0ZWRfX+lbihqKd+P/5
 okEmR77aWU/Zj2TKoXBdF8Vq+BvFuP8UCc9wfR9qOwUNBRjyri/Vqs29bvEv1/V0pPsB/7SHVl1
 uWKoOTnKXTOc90C8KpC2OQq7T35gsRikNQvs6EW1SZaD0cGB9qQjO72pxB/wmSIEs8425IUT/jp
 gpmMRAKM2sZknQB872q0Pohq+C/cIZ479sDC7j1xfsr9EQd/4UiCe+GVr+ZE0tk2CnE/0GR5K8+
 CAFJOIdSD9jXlB2PftsA7yui/HGc8nj0ghMo+2/u4uwz7Y9OZfHXZOvtp+wQjkoQsCcnlAn06zy
 zzYk1ssuoG7edmPciFrd6dfk1rFPnYkPz00nzXtzVyMhxHFu9J29LjDcl7vLBn0XTsftN33p97q
 rcFIoLDkLb1Cbi2BJ0zpx5wlyqbA9yrniUT0ZsZY7GATFJfL1y41FNElklpbo9N9e271HQffum2
 grndtrZ3idN2JxFUXIQ==
X-Proofpoint-GUID: 9anWiEabJsx2uJWYtY2umJ3Px7SfqYD7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NCBTYWx0ZWRfX8+ez+GFM/nZR
 pqU7Vc35timWlM9R+rikNIpC+rPQ8eGsXiDW36QS5xa2AzD7wxGMRTh4Q9Vk2BZ11yv3wXPkqvK
 47Er216Jp+05J4rFJ4I/hPmDPIy3Ezo=
X-Proofpoint-ORIG-GUID: 9anWiEabJsx2uJWYtY2umJ3Px7SfqYD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200074
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

On Thu, Aug 20, 2026 at 11:07:45AM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2026 10:52, Dmitry Baryshkov wrote:
> > On Wed, Aug 19, 2026 at 04:18:51PM +0200, Krzysztof Kozlowski wrote:
> >> On 19/08/2026 15:17, Ekansh Gupta wrote:
> >>> On 19-08-2026 00:40, Krzysztof Kozlowski wrote:
> >>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>>>> Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
> >>>>> accel driver for the Hexagon DSPs found on Qualcomm SoCs.
> >>>>>
> >>>>> This patch registers a DRM accel device, exposing a /dev/accel/accelN
> >>>>> character device node, and binds it to the RPMsg channel used to reach
> >>>>> the DSP. Buffer management, IOMMU context banks and the FastRPC
> >>>>> protocol are added by later patches in this series.
> >>>>>
> >>>>> qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
> >>>>> private state (qda_file_priv) and the main device structure (qda_dev),
> >>>>> which embeds drm_device so that it can be recovered with container_of().
> >>>>>
> >>>>> qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
> >>>>> module_rpmsg_driver(), reads the DSP domain name from the "label"
> >>>>> device-tree property, and registers the DRM device.
> >>>>>
> >>>>> Assisted-by: Claude:claude-sonnet-5
> >>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>> - Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
> >>>>>   _unregister() wrappers, module_init()/module_exit() and
> >>>>>   qda_rpmsg.h entirely (Dmitry Baryshkov)
> >>>>> - Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
> >>>>> - Drop the probe/remove/init log messages (Dmitry Baryshkov)
> >>>>> - Return the result of qda_register_device() directly (Dmitry Baryshkov)
> >>>>> - Clarify the Kconfig help text (Dmitry Baryshkov)
> >>>>> ---
> >>>>>  drivers/accel/Kconfig         |  1 +
> >>>>>  drivers/accel/Makefile        |  1 +
> >>>>>  drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
> >>>>>  drivers/accel/qda/Makefile    | 10 ++++++
> >>>>>  drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
> >>>>>  drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
> >>>>>  drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
> >>>>>  7 files changed, 253 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> >>>>> index bdf48ccafcf2..74ac0f71bc9d 100644
> >>>>> --- a/drivers/accel/Kconfig
> >>>>> +++ b/drivers/accel/Kconfig
> >>>>> @@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
> >>>>>  source "drivers/accel/habanalabs/Kconfig"
> >>>>>  source "drivers/accel/ivpu/Kconfig"
> >>>>>  source "drivers/accel/qaic/Kconfig"
> >>>>> +source "drivers/accel/qda/Kconfig"
> >>>>>  source "drivers/accel/rocket/Kconfig"
> >>>>>  
> >>>>>  endif
> >>>>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> >>>>> index 1d3a7251b950..58c08dd5f389 100644
> >>>>> --- a/drivers/accel/Makefile
> >>>>> +++ b/drivers/accel/Makefile
> >>>>> @@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
> >>>>>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
> >>>>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
> >>>>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> >>>>> +obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> >>>>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> >>>>> \ No newline at end of file
> >>>>
> >>>> You have trivial patch errors.
> >>> newline problem was already there, wasn't introduced as part of this
> >>> patch series, so I wasn't sure to fix it here. I can fix this in v3.>
> >>>> ...
> >>>>
> >>>>> +}
> >>>>> +
> >>>>> +static const struct of_device_id qda_rpmsg_id_table[] = {
> >>>>> +	{ .compatible = "qcom,fastrpc" },
> >>>>> +	{},
> >>>>
> >>>> Device node with this compatible is already populated, so this looks
> >>>> simply wrong or you are adding a duplicated driver.
> >>>>
> >>>> That's a no-go, you are supposed to work with existing drivers and grow
> >>>> them.
> >>> I'll bring the discussion again here, there was a discussion to move the
> >>> driver to accel subsystem if we want to support new features/uAPI
> >>> changes. Please read [1],[2] threads. The intention is to replace
> >>> fastrpc driver with QDA eventually.
> >>
> >> None of them address the problem. You want to grow fastrpc into user of
> >> dmabuf? So you move it from misc to here.
> > 
> > It's not as easy and nice, so I think in this case it's better to repeat
> 
> I disagree. The existing fastrpc driver is not that complicated. It's
> actually moderate amount of code, much less than Venus was (~7 times less).
> 
> It easily can grow to support two interfaces and the only difficulty is
> how to manage these two interfaces simultaneously or exclusively, e.g.
> opening first one disables the second.

I see the point here.

Would it be acceptable if we add QDA support only on the new platforms
(e.g. via the SoC-specific compat), provide QDA for those platforms,
and, once it reaches complete API and feature parity, we remove the old
fastrpc driver, migrati old platforms.

> 
> > what we did for the venus/iris migration or what happened already
> > several times in the kernel history (for example the AIC7xxx SCSI host
> > drivers were migrated by introducing the second driver and then removing
> > the first one after the grace period). The backwards compatibility is a
> > separate topic, but it will be addressed before the driver can be
> 
> Backwards compatibility should be one of the first things explained in
> cover letter in one of the first paragraphs.
> 
> And if you make it backwards compatible, then just remove old driver,
> because there is no point to keep it there.

That's the plan.

> Again, this should be one of
> the first things explained in cover letter.
-- 
With best wishes
Dmitry
