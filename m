Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F7CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323AD10FE19;
	Wed,  3 Jun 2026 13:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODNZo4nN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wup0swlh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37CD10FE1A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:25:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653CHKO31740485
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 13:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UhFwddlTFY09oF6cy7oYeNVke04XX3DNuQUC89hSDWQ=; b=ODNZo4nNljDaEEsi
 1dIvaUauNqUhkE5Fr31T394FGhgER/rCJQmyJBP1E+y1HnlSMLtKzu4uVtE+5e0A
 GTGjk5Z3FWKAq11NdlAKHmno2R+/mnw0barEmTPEZ/d4dKsWpSz2iBND3GpY/8q1
 +W/x/yk7omU/OqmyDBntXvKs4JPTMJcN6AVR/o08V4KgVkKl49lO5ce0uauypmdi
 aNiimcbLZTdoJBZAlKgUtz4Rp4CX6PtW00AFT/5gRhHhRobXcLfGEDIU1ZFdKfpI
 lXu8ClEOdxoMM0Jr+LoK89idmcGNfciwX+l9ud9ovRuYF4ZptNkozDdSMIi2tYLm
 0lTb5g==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7t09a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 13:25:54 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5a83b662fb8so486985e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780493154; x=1781097954;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UhFwddlTFY09oF6cy7oYeNVke04XX3DNuQUC89hSDWQ=;
 b=Wup0swlhop8taxkkX/rGstow+Z6FZIIEfjdTuF5rLB6a5I+soQ3XyvxjXGV+77rPCg
 73YGt7QtQClturYBcF1pZnI3v1OY9Z/KNBZJvsVimN4zc2uBGhki1DvKUZtuhCqkKIxe
 IUmWfpsp2Er4lOM/7ZnqsE93lC9YSBay+6MnuDckT9ZG2gFv2RHbrUHrCIiN1wLBHBgg
 CymeSnCWva0+8jla9PHssGkCw6iRkNSWFN7aanpkzh1i/xF6kDsbzjIB3bCqgBIWOp1s
 Od0jqJtBeKgw5Ni+V7XFfX4acqHbtPwdSDBopyTooqHWOFwc8U8Xf9/MPu7Q7w1irZvu
 6xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780493154; x=1781097954;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhFwddlTFY09oF6cy7oYeNVke04XX3DNuQUC89hSDWQ=;
 b=seBgmA0ypapTQwtqtWmedrTx8BJOhA9U1EQogdUf34Jb3Nr4d4bS1Pte7kdpP/8aC4
 QDKwM8+v1l89uPux2cGkVKsAV8zdTw4Sy5wJ1xfw/8EoHz5XBKlr/vBDONe5IiEZ4vWE
 u6xm3WKCAU0sKvOVqutCiZWQcQoN9v23ZSks7Y6bLjbOeg4hCJXJV7El5yKBGudcD6pD
 sc0AcjyhB9n0DFlL697ZH3qmRodZujoywsNwo4bp9e7wP/20t0s2ei8f+EaH34ynhTFA
 wnfITxTsGHhOUgv/7kVOHoJndWidoKIScvTxi29OascStZeMcwnPXawjEcv0rnCiDrsR
 OSjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mgFcOTcshRcnTjyEd2raINBQhONCLJe1WxlO5/YbwNtaKnSOhEBK7LSCxvFBeryb1rS5QRfxP9kI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWJUnGJtyj2iagEoDJVFdK51Z7EZ3YAmgvPN5dOsQ8ql443nBx
 mjL+5hf163GNyjNl6kdSd5PMfbGba/+z0+Tkv3u5wTA/zjfHuK/chHwnWzwzDjDfdWQ4AKu4Q6w
 20ceOMp+uO7VCtibflVjLl2tsc94rzq1e59XsV0Ast1HxYAHarp3vL8730LrC3lT6wKohbt0=
X-Gm-Gg: Acq92OEBZT9m3Gkkd3cehUb4vwHJfvt7+MrpRBF55C74OjaagCj9trPeWW/iA66QKdh
 hFLL360XtocOAf1by9NKJItfCiRMkbOIhGoERuh/+uv4+qCl9htiJdaLrFX+RPLPgBTFILlPG0f
 fIUYFrYuUTjKKN34bjTPCTpNkDULmIWwNwdMQdScmAjivwj792Rv8vbN7Gb7VNbdBcg5WvcRklC
 AxqUs4wZ2bwHYTzQ+zBIQ5hXP//cf6OMMF+YLRcp0YWvJh1htBfAOr2VAtGdFnqm8xhhFP5klB1
 6mX9cjRXG1d9l/zWH3/JUMqCMCvWoqQh4tt0ObbhwXRBTaFmJ+6FxaUZhZx1mz/MEYs7amtLt3S
 B2y26+Ig6OKXltIOXU/QWHUOhjQL34zzGuaesURJ2R/RlBGssFeMgr7a3TeKsntdGeL2Ox3Hdgr
 YytIRcC6LtyGubqKXlYLT6mXiEXi3gMNrswSs+KLONWrlrRA==
X-Received: by 2002:a05:6122:46a2:b0:59b:7fbd:39f8 with SMTP id
 71dfb90a1353d-5a6e852c12bmr1998158e0c.10.1780493153855; 
 Wed, 03 Jun 2026 06:25:53 -0700 (PDT)
X-Received: by 2002:a05:6122:46a2:b0:59b:7fbd:39f8 with SMTP id
 71dfb90a1353d-5a6e852c12bmr1998093e0c.10.1780493153309; 
 Wed, 03 Jun 2026 06:25:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b990d37sm653480e87.70.2026.06.03.06.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 06:25:52 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:25:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 04/15] accel/qda: Add compute bus for QDA context banks
Message-ID: <t4dcxboazzy6mxtbcjntcccxl6gc5oxjaituzyoijy2i6wfq3n@hxcrglx7bftk>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-4-b2d984c297f8@oss.qualcomm.com>
 <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
 <587b450c-c527-4c6a-b48b-8a7a266bd673@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587b450c-c527-4c6a-b48b-8a7a266bd673@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyNyBTYWx0ZWRfX+HWVkLBg8+y9
 r4XUr3SA5aI5DWm2tepmGblKmZHp7BXUkzlzoFUo0qoz+D/Y2m4e6ozh58bViTj6FfMkspXfjOr
 lWr954TO2UCwfZQ5WtyRsqFPGJNWXahAtLl9ZsWI4+jEIW7H4Oeu+LDxbQ+UxL4JnKC05cq9Lbt
 O8X5svjwXTw68pGXOc66klXNeSm7s+VlpinfAVF1QtVdUPe7yg4XF3CYitDwniPXuP/8tWRjusH
 V5eJ3THWLDZZL95dbR9Im8nYdkQlj/BmsFhy7COIjyycBb6gZLAlKkElmFHJW9HeCBuH5Fjrudy
 ZtklFcXESSydpULvBm/7VI/P41TJ6AuQCbfw3PlKnVJgx/RClqeZCk0LbGVAyGDmwJ2gJFyYCZI
 1ozl18lpX576vKNrvGMvhc0k9CNxuD0UKYK3tT4kcSTbf7gjCWFibDRQC15c0uFHvBu01ixTrZ6
 37vM6igUo6qw7CYMieg==
X-Proofpoint-ORIG-GUID: Y1vrUAbvtuvr5mt3M2hlv77S_DBHaOfo
X-Proofpoint-GUID: Y1vrUAbvtuvr5mt3M2hlv77S_DBHaOfo
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a202b62 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=w4rcs2q4Tst63B3XjnYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030127
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

On Wed, Jun 03, 2026 at 10:58:09AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:49, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:45:54AM +0530, Ekansh Gupta via B4 Relay wrote:
> >> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>
> >> Introduce a custom virtual bus (qda-compute-cb) for managing IOMMU
> >> context bank (CB) devices used by the QDA driver.
> >>
> >> IOMMU context banks are synthetic constructs — they are not real
> >> platform devices and do not appear as children of a platform bus node
> >> in the device tree. Using a platform driver to represent them was
> >> therefore incorrect and introduced a probe-ordering race: device nodes
> >> were created before the RPMsg channel resources were fully initialized,
> >> and because probe runs asynchronously, user-space could open a CB
> >> device and attempt to start a session before the underlying transport
> >> was ready.
> >>
> >> The qda-compute-cb bus solves this by allowing the main QDA driver to
> >> create CB devices explicitly and under its own control, making their
> >> lifetime strictly subordinate to the parent qda_dev. The bus provides
> >> a dma_configure callback that calls of_dma_configure() so that each CB
> >> device gets its own IOMMU domain derived from its device-tree node,
> >> enabling per-session memory isolation.
> >>
> >> The bus type and the CB device constructor (create_qda_cb_device) are
> >> exported for use by the QDA memory manager.
> >>
> >> A hidden Kconfig symbol (DRM_ACCEL_QDA_COMPUTE_BUS) is introduced and
> >> automatically selected by DRM_ACCEL_QDA so that the bus initialisation
> >> runs via postcore_initcall before any QDA device probes.
> >>
> >> Assisted-by: Claude:claude-4-6-sonnet
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/accel/Makefile              |  1 +
> >>  drivers/accel/qda/Kconfig           |  4 +++
> >>  drivers/accel/qda/Makefile          |  2 ++
> >>  drivers/accel/qda/qda_compute_bus.c | 68 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/qda_compute_bus.h     | 32 +++++++++++++++++
> >>  5 files changed, 107 insertions(+)
> >>
> >> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> >> index 58c08dd5f389..9ed843cd293f 100644
> >> --- a/drivers/accel/Makefile
> >> +++ b/drivers/accel/Makefile
> >> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
> >>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
> >>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> >>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> >> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
> > 
> > Ugh. The previous line should be enough (but don't trust me).
> I was seeing build failures if I don't add this. Took it as a reference
> from host1x driver and recent iris patch.>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
