Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82DCC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D7D10EF74;
	Thu, 20 Aug 2026 08:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMXsYwoh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZgO2kU3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489C110EF74
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:52:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6ZpHW1258605
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7pRjGAagJWUGoFGnU1ugBrwj
 EF+1RslNAkeOCCC3woY=; b=lMXsYwohJXoOFUUz5vHVF+7qKIlqg27ZPHNA/k6q
 25rddxQ4uXOwlg/AFrE+U3y4wmB+zuEgcpDb3jQow30Tbez0TR7xGVRWiJiBx87A
 rxUTyAbmtBuKY7tYJSVCGJvXEVE15QXhCVmBftVGYpEPMWc9zoy9F2MZ9/8tlbJB
 VmPcYZ6pjL87JylMozbeEEginNKkKRq0k2yRzFp6SvnJ2GNTflAadUfYwUW3Lhf+
 3niYZhSKi+1AgExLjabS7z5hyEsqz01HyhqByCcWdEa+Y8OpcGBQMv/uyUktnObA
 kt0Z1u6ppLwN7VTkcLh9epL9ev2MTq8KJdibui/Io5Kyhg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es63xr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:52:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9368f2b7b2bso209022285a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787215965; x=1787820765;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7pRjGAagJWUGoFGnU1ugBrwjEF+1RslNAkeOCCC3woY=;
 b=WZgO2kU3ZOxcE0lla18zgNIPwT25ArgzK4yWwNyT70fZ3nBkyU8ScSSICKoCF2Ewbg
 dbe4kPIR4zP1BJnTU1mogwPRAwojc3qNWCta/Fvzuo4ieZH7xngrXQK734VkGl9VYoko
 jtnKHqlhK8LQBJa6cyVDlB3hrumbM7f0inoeyngcCuWpiHZAxTncBn6haWQ4Rk6T0R3p
 0XZ56Ey5VVTQARD/z7s0q66xaRU5YOvPsw6Yd51DwycppT7KUpXk52gp0QXRNkG2aYFi
 r8uIatiSjz1Duex5aWmlxh6Z6AhoWFyJs5cAMdGlihgmO/+O3hu/myDyAVdkn9ebcf1c
 H17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787215965; x=1787820765;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7pRjGAagJWUGoFGnU1ugBrwjEF+1RslNAkeOCCC3woY=;
 b=gkd6fj48eJYNixftSAxI4SPqXBEC9+gkmBQ8lecgDdROPQtpkFXXlhJn6Ht4rPJDpt
 rV+KniOIj4Y/htL3KrHPZIDhoODceCixIbeo2Agy3MJgH0+FPYOVPN9y3ZYp6sryskcF
 uncTEF+CnjNEgGuRpd2NMGJ0MouWDFULHrJ21qoADt9MJvZjTzbr/FNtJvIHyFqPHGZd
 JsoqizebzaZBcrpkzJFuskhukZNUZ+5yM5NpuSBfGd8RN7NbsymkMNfz4gPM9uBsQMEM
 EohgLTXLjs4ABmoeYDmitbuuwzPRYMAk0u2o9SXx/vnsRzNSM793mDQ/RE1rrtn282Up
 bJWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrh8oQYm9YSD3Q8lI7lnEISev9H3Rbj+Asc8wgLz7t+mAIuaMgZhZdwivD5324ZguyUqKQ6ANV5akw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yynerj31TyNN5eSjME9oeaBlCvVZzaajhHbpUk/INJpswOvwmxC
 6bJmq64ilCgSvoqsDLXMuaK/Ff5dyElgNxH6r5/V3fMFAN/WLyz709bF2QtZH7xnxHu1fgrmWI1
 yTdzAJM38G0q36XqyEd8YsY/S45yNOZZJClQs+PFPMp15mu/sp2m0M3FmjRolgVAC3E1s54w=
X-Gm-Gg: AR+sD11odj/H7bPldH4caMDQLVeGGXzmKPU52AxMz3+kZ6hHMAUQu7PL5jnrZbczz6B
 WkIxpzHA1l7bGcjKsIuf69pzoMpqzKyQuqptuxhY7yicZJuePDa1j5hk5IZgVB2A5wbJJAeXqYz
 qI7bE6s3b2fs0yOI/NcgS0KDXWP49aUKxWr8IjBZO+S6NLj59gQgex2SRwUW/xVwhnD5aoSjNUo
 RPE4lqn2N4vcJCJrbk1jO8UvUv61DUojoCv/qr1sAnzMds3nl8vzV3K7zSe8hPI3vLG4hN71FQT
 qvSgBVFPBNLKLWVTfdZqkpBij5aC+PW61YwwoP2zHWzkl/49UKIjm/KzFBmPD0G3nLszqv/IYla
 KagQd1X+N/LDgGQAAI3AwI1VJUD8cB9wwVSjoqDuvghjboPgvwRINsc4QW7dBayTD7OqMVUlXkb
 S1N/Brb2CQh+OA
X-Received: by 2002:a05:620a:4505:b0:936:883d:89c6 with SMTP id
 af79cd13be357-9371e2ff241mr1009578085a.28.1787215965452; 
 Thu, 20 Aug 2026 01:52:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:936:883d:89c6 with SMTP id
 af79cd13be357-9371e2ff241mr1009575385a.28.1787215964943; 
 Thu, 20 Aug 2026 01:52:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b4788d9223sm1121021e87.46.2026.08.20.01.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:52:43 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:52:41 +0300
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
Message-ID: <g5orcvzjbwww27vwcsxl3ehrek6lvznxptd7jutifoiuicjnm6@iqq2pus6omsl>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
 <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
 <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
X-Authority-Analysis: v=2.4 cv=E5/9Y6dl c=1 sm=1 tr=0 ts=6a86c05e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=D19gQVrFAAAA:8
 a=EUspDBNiAAAA:8 a=qpzGY3gMejqFJFcM8zUA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-GUID: 7SmJdA_uROq0MVCws7rV0s5day21Ayzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2NCBTYWx0ZWRfXz6v53vZjLoG+
 EeJ3lhl1015DGskMtllpFXlsuPtGe8TMEkj6IjX1R7qhiiKNnX6ZwU4x0ZAlj2uC/EWEk/EMy0H
 FdkZWu5+CdNdxtp6JoPxv8O997pbiRixpKk+ZH6AeNW/zjSBIgHVKOyjcaswlGHu7EdY2pxnOYG
 gnGirEnC6Z9cXeJynpprxLpiTf0SCU0yU1oC0snoZqH25jruyhbmQfcnYt6n2bnxPxpLWQEpst0
 aYwC9X1SbCCWcbk3c8msklm5gg8b/wSjW8917756AH+IM0VVUixkbq/KCKQXIbl5IqdZxqfOSGz
 ePyJcaFEC1qPYMlMR72P4jprdU7ayM343RnjGKNhCJI2gIfc2lnC6uKZUmGOOEy8cwE8BCJQt9b
 l5aP3rbzkzXyU2G+3n7NmiBXXL43DQhq2fpj1HmWcBU/Na+P6ltVb04ofLoCjw2zu01D7Hbgc7Q
 L1YJQ5kbxxOvXSxbdZw==
X-Proofpoint-ORIG-GUID: 7SmJdA_uROq0MVCws7rV0s5day21Ayzw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2NCBTYWx0ZWRfXyilF4xK2yBm9
 1IDbfxlVlgPxG8PR6DqLLzZl9FKUvX0dzrhXcWs4L6gV9B8MnfEYDeHVodGiwpE8OH744IuTbBs
 xfSfY/IfiZgEyX/0c9x6X5RcVcPrCEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200064
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

On Wed, Aug 19, 2026 at 04:18:51PM +0200, Krzysztof Kozlowski wrote:
> On 19/08/2026 15:17, Ekansh Gupta wrote:
> > On 19-08-2026 00:40, Krzysztof Kozlowski wrote:
> >> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>> Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
> >>> accel driver for the Hexagon DSPs found on Qualcomm SoCs.
> >>>
> >>> This patch registers a DRM accel device, exposing a /dev/accel/accelN
> >>> character device node, and binds it to the RPMsg channel used to reach
> >>> the DSP. Buffer management, IOMMU context banks and the FastRPC
> >>> protocol are added by later patches in this series.
> >>>
> >>> qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
> >>> private state (qda_file_priv) and the main device structure (qda_dev),
> >>> which embeds drm_device so that it can be recovered with container_of().
> >>>
> >>> qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
> >>> module_rpmsg_driver(), reads the DSP domain name from the "label"
> >>> device-tree property, and registers the DRM device.
> >>>
> >>> Assisted-by: Claude:claude-sonnet-5
> >>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>> ---
> >>> Changes in v2:
> >>> - Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
> >>>   _unregister() wrappers, module_init()/module_exit() and
> >>>   qda_rpmsg.h entirely (Dmitry Baryshkov)
> >>> - Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
> >>> - Drop the probe/remove/init log messages (Dmitry Baryshkov)
> >>> - Return the result of qda_register_device() directly (Dmitry Baryshkov)
> >>> - Clarify the Kconfig help text (Dmitry Baryshkov)
> >>> ---
> >>>  drivers/accel/Kconfig         |  1 +
> >>>  drivers/accel/Makefile        |  1 +
> >>>  drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
> >>>  drivers/accel/qda/Makefile    | 10 ++++++
> >>>  drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
> >>>  drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
> >>>  drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
> >>>  7 files changed, 253 insertions(+)
> >>>
> >>> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> >>> index bdf48ccafcf2..74ac0f71bc9d 100644
> >>> --- a/drivers/accel/Kconfig
> >>> +++ b/drivers/accel/Kconfig
> >>> @@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
> >>>  source "drivers/accel/habanalabs/Kconfig"
> >>>  source "drivers/accel/ivpu/Kconfig"
> >>>  source "drivers/accel/qaic/Kconfig"
> >>> +source "drivers/accel/qda/Kconfig"
> >>>  source "drivers/accel/rocket/Kconfig"
> >>>  
> >>>  endif
> >>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> >>> index 1d3a7251b950..58c08dd5f389 100644
> >>> --- a/drivers/accel/Makefile
> >>> +++ b/drivers/accel/Makefile
> >>> @@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
> >>>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
> >>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
> >>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> >>> +obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> >>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> >>> \ No newline at end of file
> >>
> >> You have trivial patch errors.
> > newline problem was already there, wasn't introduced as part of this
> > patch series, so I wasn't sure to fix it here. I can fix this in v3.>
> >> ...
> >>
> >>> +}
> >>> +
> >>> +static const struct of_device_id qda_rpmsg_id_table[] = {
> >>> +	{ .compatible = "qcom,fastrpc" },
> >>> +	{},
> >>
> >> Device node with this compatible is already populated, so this looks
> >> simply wrong or you are adding a duplicated driver.
> >>
> >> That's a no-go, you are supposed to work with existing drivers and grow
> >> them.
> > I'll bring the discussion again here, there was a discussion to move the
> > driver to accel subsystem if we want to support new features/uAPI
> > changes. Please read [1],[2] threads. The intention is to replace
> > fastrpc driver with QDA eventually.
> 
> None of them address the problem. You want to grow fastrpc into user of
> dmabuf? So you move it from misc to here.

It's not as easy and nice, so I think in this case it's better to repeat
what we did for the venus/iris migration or what happened already
several times in the kernel history (for example the AIC7xxx SCSI host
drivers were migrated by introducing the second driver and then removing
the first one after the grace period). The backwards compatibility is a
separate topic, but it will be addressed before the driver can be
merged.

> 
> Again: you have one driver.
> 
> > 
> > Do you suggest adding a different compatible, say "qcom,qda" for this
> > driver?
> 
> How would that even work? How much (or many?) hardware do you have in
> your SoC?

No, it's the same compat. In the end, changing the driver doesn't change
the hardware.

> 
> > 
> > Let me know if you have a better suggestion to proceed here.
> > 
> > [1] https://lkml.org/lkml/2024/6/24/479
> > [2] https://lkml.org/lkml/2024/6/21/1252>
> 
> 
> Please do not ever reference lkml.org, it's long time deprecated and
> barely working. Use lore.

-- 
With best wishes
Dmitry
