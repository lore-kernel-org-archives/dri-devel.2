Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF29CC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF67D10E9E7;
	Tue, 18 Aug 2026 04:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d4g3Sp8T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PMwaJ6w9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFBB10E9E7
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:44:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I4Q38I3464536
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+VhAlrPJjjcR4cgApAcBunef
 pIwGteIoKexT12Xm+PQ=; b=d4g3Sp8TrzXwJwOmUupLetOfSkAkAbo3IrH/0X7V
 r3RDpHZbFTvySya4aXBJnQUmP+pBb2cvATh7XjTLYAcWMLpwH9utxAIHDXTmSX41
 oRqtN7i6d+8Ct+J5ZW4/2BtU1Vdh85Q4dvQu741YawaaKupuGuwMY46MC4/I7fMK
 yYqgnIkTuQ5G4+s5I8NIOYtyeRrHm9VhVPkLX+m2C4MPRCYfeUbbJ7umMSrcfxso
 rFX6Yewbr5nyQeNd579dtQ5ECqTmjPflnYD/Odh9PoiNxQLlhmKJKHUVs6UqZgVs
 ZcvkGP4SDFalGkSrYKy3lFXwEGbXpSMVuHtvq6WEAo8nWQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4611apag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:44:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d28f8737eso75640961cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787028266; x=1787633066;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+VhAlrPJjjcR4cgApAcBunefpIwGteIoKexT12Xm+PQ=;
 b=PMwaJ6w9UsKAfQdxCgLEPYRPFqmwbGC03wAsQr1KYTH/WF/Hy8VH8c/Gw7yB+prWyM
 DBxgHR34NihG6PwSsnm88zi7GHbye6uaoeikH/Fi2FaQ0kmN4qqEdU4s6hpwsxovkS+q
 2mXaeE0XQkQSYn9eOaH64eBYxUoEVn489M9AIsCN5Ii0PMwfYI9sZwwx+c1hkhka9twb
 I+hgquS/bUEsDxtMkboitb1vNorvhZDORo1QkFTywaujMqghxD4oYTZtd6URZay10s9n
 m8PEX0IgO9tQLVNUyOUhjyxYKPlcVwWnrrKG0tup/Tl4zVO8G/9SH0ddvKy/5g1FLmMT
 Hu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787028266; x=1787633066;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+VhAlrPJjjcR4cgApAcBunefpIwGteIoKexT12Xm+PQ=;
 b=XvyRZZiug5X7F4KfaDmW85/YjpCYrmHLdSgFApNjKV7FYDDUZ6B21IeuD5JNcUgXMS
 jYiyDmM4UjsrinuWaBX/9erYR7tNYU7GGchVsZHXOJQITtLKsADI2MesOsuVfKb1ukig
 y4KBJSrmCoXgIw00cutAXj3ON2HayGX1kl1PRsbqOKvCuqDComSCIdbwwzBG8N4Lp4Ym
 si42bqmK0J2HCqcZePv4dEhqNp7q2X9KpocUYGXUDYns1mFcmFNZ5Vy/1+wi2JZlgT+I
 mM5RwuCB2dBrlkihzOPJgEvtSPo4CsUTXYPk6QSEOOFntKWEf/MutL1xxkVsdWL55HBG
 QeoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9NmVR3QT3s2ZhHZpEKKaTKeWDTy6gNOeKffa0AMlWjGvq3zZEH0nK8vL9fcI7MLkCwop7KGf4aQM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySIknBYa2brOz9FVqN7vImOUg1jOZXL4NY93BD4upYB6OKTkbk
 /GPx1hfgYXOzGyxE7vno3zT0YWSvs82EzMv1965QxibW2TRypR2hBAmRJBhJ3B6JvNnYM8NHwCm
 A6k1VTu1VwaEEhy+Gknq0/E6Iz5fVs4e5SQ5r27aOc0X9IaL4H0qEed0jTdLJaexjfQppgC8=
X-Gm-Gg: AR+sD10xDQmibrgZH03tm56+9Fv3bbpAOip1Af4ouPfgQfJ7Z1oqzS/Wm1fUBl11Ubx
 EJ+m+RfFwu1fB75cVn5FDnwLU3hTs2pfKmQ8ThQthOr2JMfmGrVkGWA8c5CL3LA5mFyC7/6CqVt
 EeioniuIBl7Ga5MjItkWVkINYj9yUE2N+FLAwwKsBdIKbT38KFRQylnE/0j1mr3tiyBb60qHk/w
 CNJWyqyvN/r9H40OWJonP/we4OlXC090dvxZOgMcFfUm5FoZN7HMZQwWtq5gzEM+uVJF/lw7ZEA
 IdTW9sUOIJ4O6QlDeAjb9pzPMXn51E2P4pWyNo9OBZYSPWv+M8Dz58FUVUxFZM0XjljqMovvRu6
 7PwTUJ8124WN8GyW6pYJyrPvGaqpp5XReA11RwIEbqYY+hkctBbZivYA+cYLvWaKEvMw1kOu3gS
 ZIXWR6rm2VWIf6
X-Received: by 2002:ac8:58c5:0:b0:52d:771a:23f1 with SMTP id
 d75a77b69052e-52d853cb033mr315816371cf.14.1787028265565; 
 Mon, 17 Aug 2026 21:44:25 -0700 (PDT)
X-Received: by 2002:ac8:58c5:0:b0:52d:771a:23f1 with SMTP id
 d75a77b69052e-52d853cb033mr315815811cf.14.1787028264997; 
 Mon, 17 Aug 2026 21:44:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46d01a74dsm880330e87.73.2026.08.17.21.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 21:44:23 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:44:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v2 07/15] accel/qda: Add memory manager for CB devices
Message-ID: <phiwowaf74wgykqrvkvu2s3ya6eln72jolngpstadjb4vbbdrb@p7j7j2kc33su>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-7-69a02e9090d4@oss.qualcomm.com>
 <wt2pdo3m3nlhvyofuvbsqnvggywx75ucs65vjt3dzrxkrpgztz@xwwlhq2iuiun>
 <c4820424-eff0-4c28-ba77-5b595ed09a4e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4820424-eff0-4c28-ba77-5b595ed09a4e@oss.qualcomm.com>
X-Proofpoint-GUID: sCDQEa3EvHYsXDYZCagpEtK18e7q3mFk
X-Proofpoint-ORIG-GUID: sCDQEa3EvHYsXDYZCagpEtK18e7q3mFk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX0kUYbV3hCnWS
 /VohrIyjONCOCRJEhM/W//j/kGGjfvTGdu7ln6kfmNbOmVh0OAT17BKs8hT4Xt5mHKrluPcDphf
 ECLwVvyu6dqh+zmFyaV+DtnSLe1tP5c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfXw0gx0q15B2P0
 IvkiEVEhy1MEaiQF7wEKz0/ynITe9osPA6LQvRsgrBVHHAQ5ywvtnDmnz8fDXGflpobIVgmtQbk
 7vIfTfeTtctV0AzLOGEBLyMrOfOzAZ1urLAHLkUPJxZEXE+BBZ1Q079h6BRvzyG0Z1TMLFquHEX
 ENNsFU+eWEGOgoGb1T0JyGogbJxRi3bV7ocaizvOJJst3rbZ1jPajTZ1QeLOPwsR/NDcABXSSIV
 ZoIplZ9sZYzjymfNJAFDReDksSIKBQeZhfx9CCUR5XclsoHwfc17JBv0cN6PEpnvf1znaVoU21n
 QgpDGZg8flu3kp7PuMdfgNgA2foW/aeWVjvvo0AjckM4lR6sNjlArdbYVXpb2zhsv5iNGDBJfIe
 2dIbr9hFqWY611TjKI1/r1gUWgJOZakOLsPlPsqtPFGa0b0vYEsPwEX6su1VHHEXZUTEpWM3gGG
 IfyfOQ7LW0xVQhBHx9w==
X-Authority-Analysis: v=2.4 cv=UslT8ewB c=1 sm=1 tr=0 ts=6a83e32a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=kDtCMvKoDeDWkizO3CQA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180032
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

On Tue, Aug 18, 2026 at 10:03:56AM +0530, Ekansh Gupta wrote:
> On 17-08-2026 12:22, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:42AM +0530, Ekansh Gupta wrote:
> >> Introduce the QDA memory manager (qda_memory_manager) to track the
> >> IOMMU devices that back each compute context bank (CB).
> >>
> >> Each CB device registered on the qda-compute-cb bus is wrapped in a
> >> qda_iommu_device descriptor recording the device pointer and its stream
> >> ID, and stored in the memory manager's registry. Later patches use this
> >> registry to resolve the IOMMU device a session should allocate from.
> >>
> >> The registry is a plain array sized to the number of
> >> "qcom,fastrpc-compute-cb" nodes present in the device tree: the RPMsg
> >> probe counts those nodes and passes the count to qda_init_device(),
> >> which allocates the array in qda_memory_manager_init(). The memory
> >> manager is created before CB devices are populated and destroyed after
> >> they are torn down, so no dangling descriptors remain.
> >>
> >> qda_cb_setup_device() is called immediately after a CB device is
> >> registered on the bus: it allocates the descriptor, registers it with
> >> the memory manager, and stores it as the CB device's driver data so
> >> that qda_destroy_cb_device() can unregister and free it during teardown.
> >>
> >> Assisted-by: Claude:claude-sonnet-5
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >> Changes in v2:
> >> - Replace the XArray with a plain array sized to the device tree's CB
> >>   node count instead of a fixed 16-entry table (Dmitry Baryshkov)
> >> - Fold the init_memory_manager()/cleanup_memory_manager() wrappers into
> >>   qda_init_device()/qda_deinit_device() (Dmitry Baryshkov)
> >> - Drop the pr_debug() calls (Dmitry Baryshkov)
> >> - Use goto labels to unwind probe failures instead of open-coding the
> >>   cleanup at each error site (Dmitry Baryshkov)
> >> ---
> >>  drivers/accel/qda/Makefile             |  1 +
> >>  drivers/accel/qda/qda_cb.c             | 39 ++++++++++++++
> >>  drivers/accel/qda/qda_drv.c            | 26 +++++++++
> >>  drivers/accel/qda/qda_drv.h            |  5 ++
> >>  drivers/accel/qda/qda_memory_manager.c | 98 ++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_memory_manager.h | 55 +++++++++++++++++++
> >>  drivers/accel/qda/qda_rpmsg.c          | 23 +++++++-
> >>  7 files changed, 246 insertions(+), 1 deletion(-)
> >>
> >> +
> >> +/**
> >> + * struct qda_memory_manager - Central memory management coordinator
> >> + *
> >> + * Coordinates memory management across multiple IOMMU devices. Maintains
> >> + * a registry of devices in an array sized to the number of context banks
> >> + * described in the device tree.
> >> + */
> >> +struct qda_memory_manager {
> >> +	/** @devices: Array storing registered IOMMU devices */
> >> +	struct qda_iommu_device **devices;
> >> +	/** @num_devices: Number of registered IOMMU devices */
> >> +	int num_devices;
> > 
> > What for? Is devices array to be looped up to num_devices or
> > max_devices?
> num_devices is to trace device registry with manager, it grows on
> register operation. I'll improve the comment.

If it's a loop counter during device registration, make it a loop
counter. Don't store useless data.


-- 
With best wishes
Dmitry
