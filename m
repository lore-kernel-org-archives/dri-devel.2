Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C0F94CBC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 01:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5316110EE21;
	Wed, 22 Apr 2026 01:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OtdRSAQS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SBMniFQo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A4710E26B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 01:54:18 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZuHc3730894
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 01:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1EVhPscDl7ppUgS3ObH0c8/S
 ANPa07oJZissK0SnRo4=; b=OtdRSAQSnn5ks9g5mzd+1LRTi0D/e7c7gHpNFos6
 iHiydNQJC1IdzI1DWb3ceT2D88FsjGX8R8QRumthXqsCQIWW+QorpL410rNzgYVn
 wSKFqkS1h/gL+SiDF2Fj0ml1GGqpemyUdhjpqACuIvTk6+cfHbv+yj7L5lk24bHa
 lqS0N27YWy366V4seWteWZmH8vknJsUjX8tDq+3kAm9WztPkl9RVNf2H47+7zSCO
 uNce92GGsq+WwyqTqRbCgg6Qb/V3s7uNdXHvzgHYvUbCF1LN3Buo2vsmIQJNVdaM
 3EndaELKYRfpJ0PuCmR8YKJI3pzYsRsyHscFux0UdgMaGQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfs4hb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 01:54:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a1accb970fso25596316d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776822856; x=1777427656;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1EVhPscDl7ppUgS3ObH0c8/SANPa07oJZissK0SnRo4=;
 b=SBMniFQoqRU8mPgLm19wzE0pg6wnKViU+y5F9XvP3vxzQVYQfI1QIBiMNWDN/4DM9j
 biFtC18Qm79vk9XyJ9XlIrZkZjryEYZ91XMeL7ger4t6StJtuIzBDeOE0xzrkdk5v5xO
 KBC1hongFEBK3pkm1mhpM5m85I6HaSA82kpbDnscUNnnp+PMKdREfLeRkInqNVFf2Dm6
 lHSj12KQTaM28vrj7B6/uAp0O8WoHWfZzfk+X27T+IwwHDfIZt48uO8VME4BpereafQu
 keM1EsExWjecU1TtD5Vm9Ta/BCYBcuy94EoN8zt3hUPx8t7ZZMNOES5IZHLlayYV1SyI
 kVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776822856; x=1777427656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EVhPscDl7ppUgS3ObH0c8/SANPa07oJZissK0SnRo4=;
 b=HTOcChjYt5bK+ss7DsWK28g5F8BZLisrl+3Rbi07v7H7E3Xy/w4wrlkaW8oEMK7VIA
 VEFgX2lOfNg/lCXcKp3yjFwfnRj1F2o+IEfTfLJ7CLuONiZphGRpuiqUcsNJptcqylsU
 R+WxFt0QP42NQSnFweNmEBZvw/hw8HO9Oym8eSgPAv4AD12OomuowKD/SwA6vblLBq8h
 QlR9XpRE3aQP3lgx/DS9vbJRWi2aq3+kpms2Zd7htwPpZjyut5iVdzHbQ78PSAZRZgWt
 RiuG8BBEnCsVreGQKOgQ/Uqu3x1RXaurDGCm66jySHp2n5kyeal0f7DdDPL8RtEyYrPP
 VhHQ==
X-Gm-Message-State: AOJu0YxFTk8WW3Apt2ek0O6NOtrmKfzFm09AKhhaKylVEzx9t40pV7fT
 oLtTvtiEf2lGXMyxv7Cza+QiEBKWRK+ilE8cYDlqOIJGvEKXY5n6opwGjgWCieLN28OmIG+ikAf
 wLveR7vr3XOEDaOhi0bb7Z8nMsS+MdJNahZ0GgVSiPSbXgr+9mXsG2HrOMRg25wA40qhlcsw=
X-Gm-Gg: AeBDietiUximj3eruehYlQJiAbGtSsDmJ4glj7YFBoW3fvgpIc1vZZQzwg9Lj14304x
 h1kLSJn1Bj1KxGCov0+/logdOKf/0MTslEBjTuepIp9ImOBvc6lg7iPMl9KTwz2QCAD+G9JTAgb
 tv3ONeJ5CrX9gglQqsMEu6mOe9a8bPAaYJAd2DLA9KAsGqNJHJrEAZdijg+pLHl+jJyICiw03gh
 RZ6w7+rPAKI8wJzVlisEuaDc/920EsdtwnmbED5HfZ+7q4vxgEBwaxO90QXCmq3cMk/XPvJ/VXd
 BuHAyvggwWfm6QKyCVAfvO88sk2pfIwj8P5QVkoL6r2zQky6d87IzWL77JPeThk5wBJeoNtQSs8
 GF5qQ2FNQFTmoPV1HtSQxiSbvWa2bZRMEV+qeITpQfFxkmPdJMf12/fsSzGDW2v8SHo4jVHJlvD
 q5N3M3SomAfg4EIB0g/RGP2BqysOUyk4kIgetv1Ej3q4hpRA==
X-Received: by 2002:a05:6214:5691:b0:89c:a2b2:8d3a with SMTP id
 6a1803df08f44-8b027fd9b67mr378068706d6.4.1776822856533; 
 Tue, 21 Apr 2026 18:54:16 -0700 (PDT)
X-Received: by 2002:a05:6214:5691:b0:89c:a2b2:8d3a with SMTP id
 6a1803df08f44-8b027fd9b67mr378068396d6.4.1776822856107; 
 Tue, 21 Apr 2026 18:54:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e12c8sm4049951e87.49.2026.04.21.18.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 18:54:13 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:54:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bill Wendling <morbo@google.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Justin Stitt <justinstitt@google.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/13] drm/msm: Add PERFCNTR_CONFIG ioctl
Message-ID: <b4hkax45ohmz3dk4b2wgfmq73px7er66wqxixquxhwd64ngboa@zu4frfofekef>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-GUID: 4kx5zkq_Yl9AHJ3XKtlMAoWeH0axyJvg
X-Authority-Analysis: v=2.4 cv=YJuvDxGx c=1 sm=1 tr=0 ts=69e82a49 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=vNHeVWmE5UuQZPkiQX4A:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNiBTYWx0ZWRfX6592CYgtt5+S
 6fIM20nL2XiOmg5OgOLhMEGSmh7s3p8VHpdEC2eBEIeQX3D46eRpa8uTm3vFOOoZ4zzQU0TD0mt
 2luIfZojGaZI2p2a/ItigXtjU3Wh89wVQPNzA4JvjMELW3s1Za76fQM8f6y4vVk9g6gpV+JquCh
 NtKP3tQRmSfs5ILbytze4y5qT0QJluwsVYmxuo5bkcwrMrpsLQOFp/VHbRe0wb1Bw2ePAXxbmKV
 Rp3/NCcrM8ZRJPIeyKQY3MwZ0Rj/nrbzo4eKuIg9zN4JmP876B/7VXr9AaYjDQCGOiEZIiXKsf+
 fYwBZQw1bjPjZAbkTDU8mePZt59+QO6ys01suTWAMrjWl7a75rNhiiIxwr+ko3BuNqTkeS017vP
 DXNrrcGYuB4P55B+vKs72qoTJBOIKKQYypwxPu8ezR5HUppK5YYioVOa4wW4+0DlMjiqojOlZ8B
 1pUecMQMvNYALQjh+3w==
X-Proofpoint-ORIG-GUID: 4kx5zkq_Yl9AHJ3XKtlMAoWeH0axyJvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220016
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

On Mon, Apr 20, 2026 at 03:25:22PM -0700, Rob Clark wrote:
> Add a new PERFCNTR_CONFIG ioctl, serving two functions:
> 
> 1. Global counter collection (restricted to perfmon_capable()) using the
>    MSM_PERFCNTR_STREAM flag.  Global counter sampling is, global, across
>    contexts.  Only a single global counter stream is allowed at a time.
> 2. Reserve counters for local counter collection.  Local counter
>    collection is local to a cmdstream (GEM_SUBMIT), and as such is
>    allowed in all processes without additional privileges.
> 
> The kernel enforces that counters assigned for global counter collection
> do not conflict with counters reserved for local counter collection, and
> visa versa.  Since local counter collection is scoped to a single cmd-
> stream, multiple UMD processes can overlap in their reserved counters.
> But cannot conflict with global counter usage.
> 
> In the case of local counter collection, the UMD is still responsible
> for programming the corresponding SELect registers, and sampling the
> counter values, from it's cmdstream.  But by performing the reservation
> step, the UMD protects itself from the kernel trying to use the same
> SEL/counter regs for global counter collection.
> 
> For global counter collection, the kernel programs SEL regs, and sets up
> a timer for counter sampling.  Userspace reads out the sampled values
> from the returned perfcntr stream fd.  Releasing the global perfcntr
> stream is simply a matter of close()ing the fd.
> 
> Since the counter sampling is done in the kernel, this prepares us for
> not having to disable IFPC while global counter sampling is active.  But
> wiring this up will come in a later patch.
> 
> The mesa side of this is at:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40522
> 
> Rob Clark (13):
>   drm/msm: Remove obsolete perf infrastructure
>   drm/msm/adreno: Sync registers from mesa
>   drm/msm/registers: Sync gen_header.py from mesa
>   drm/msm/registers: Add perfcntr json
>   drm/msm: Allow CAP_PERFMON for setting SYSPROF
>   drm/msm: Add a6xx+ perfcntr tables
>   drm/msm: Add sysprof accessors
>   drm/msm/a6xx: Add yield & flush helper
>   drm/msm: Add per-context perfcntr state
>   drm/msm: Add basic perfcntr infrastructure
>   drm/msm/a6xx+: Add support to configure perfcntrs
>   drm/msm/a8xx: Add perfcntr flush sequence
>   drm/msm: Add PERFCNTR_CONFIG ioctl
> 
The series doesn't apply to linux-next. Please switch to b4 and use b4
--edit-deps to specify dependencies.

-- 
With best wishes
Dmitry
