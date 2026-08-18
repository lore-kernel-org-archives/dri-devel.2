Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC37C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F62610E9E9;
	Tue, 18 Aug 2026 04:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZLXrhLK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cPpW1zwP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D3E10E9E9
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:45:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I28U8V2884789
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+GMonc/RpYRTRb39qbdjpzhy
 wf/yWb6wWhYjSvEgMFI=; b=AZLXrhLKeOIaJbOQhN1f/mV6AmzKXDGGHr8sd/FP
 7A+yZhwyDyc8rsYV7paaj8MfyyGlu2+8FEHFBxB3FDNNe575kDViwsLOaRFA/Hkn
 aTx+Dd/oz1uZtz9s7Bs0vPRDMM0ykNJ8OrjZnOB7SVbgL8vi67NCBkpxcrXdsMCw
 lI6kJW9ReRAeujuzScXbbRs6M7hMEhzHGVpVVHLiqIjLfQ1dJAW3Dt0v7ZRziutA
 AP3P4MxLAFodKbVBWk+25KmxZ62v9kYY+6gFRk5Y8nZAtNJZCVALufyWOBMsKMY4
 vafCsyO1RxVJJrxpQ/VrLht+HPB9lc+PSnApQn6WOBAMAw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ebprjw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:45:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso381409385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787028328; x=1787633128;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+GMonc/RpYRTRb39qbdjpzhywf/yWb6wWhYjSvEgMFI=;
 b=cPpW1zwPBisz4SkD/ZN0mfHgaUdUy+qiIMmJzYw/dZcO9KB+5Z9nV53l2K+TOziStb
 6TZT4z3rweTFAOcplclO7k8yeJronYgS52ARRZKlSfJVAq+ZkjvMRptWLkJEQkUxva+S
 YX3Shsx+af/qLiBgZ00OYCHsyh9ctaoBsSVIz0cIJVTfM7M+fWMhMnSs2BJ3tws6Hfkp
 XuAlB6AUJ2W3VEd8pV3etxvFvQln9Ei+IpeUSmeP4b72Uc9LZQysr5kg7sseMOKVL2am
 Eu4k3oshyjssrWx7RirzhB8ayHAGr+SqtHYMMbgB3GBFG8P6Z2EYUv1BjCEbDo/2eJYQ
 azpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787028328; x=1787633128;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+GMonc/RpYRTRb39qbdjpzhywf/yWb6wWhYjSvEgMFI=;
 b=h2t1kTpLazHZ+I6bv2kvP3gOYtWOpDxSTMkVMOSm9EVPSwSZpeXDIHiAqrjporEd5M
 riY9oWuhQlaGKgLBWZ7pwG9Oks83OOJhdaQKWVoAfxiUzWPRT8H4kP7E1u1Tu0AxAZ1Z
 ywxiY+fheJ0WyyXy/2UCMxlbqIo/M0FJDGaIqoy7Md4XjCsfbYlHCiwGXnyUW8y6JEEa
 F+6Z0qlBBBz9MwC0Ug3Y0eilCT/QCiVD7whqkqoABLXS2m0BCjLMlddWIdqyubl0yl2O
 IbofPDc70X/IuBplq3HA6W5/jbL31fks4YJspInPFeCDqvWLMuCI5f68aYiP2pMqtE99
 c0dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI7WaenRofsLo/DGjXz1p9loPXbxBDs8ScXFddrlBbPhoJVwr549Ucmx+fbCs/xDg2p1264PO9hyY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLKlXwsEjIRWfC++TzkcTvyfFmS16Dl2KQAp++4kqBgpQkoZZu
 fyKAi6LnYVi551YbphLMXC+RXF2BVpC9FQGw59K6KlUdgprpjkCXvwTCtz9WqYbRc1/RZRGzNo7
 B8lbiRR5CQ8HaqAxgZ3CVYUNgxs4TXIY9fWImR4/nSVaKAS0uAEbwujlhangXjLdvO7oVbC0=
X-Gm-Gg: AR+sD1020LtWVQ84HksCkDP7uZNvcbj1fy9PrPqzEtT8qZYfuXroStnsOVYxfWZc/5d
 Lq1bgTwJUku32ANfhwn9o7cqCUYDI3MVegMguKovUeYx15iL0vHcCdfrHXa+Z/IWjhGJYCXNL4L
 MUHPiilcG5TO1O1VH1cvG2/9HEPr8fxDFwbZM9aXXv1N0mVkn0plpOO0OyFaHygYb+0pKw6MnMq
 cySDfrzR+55Zw82w1lXakMstTAad7GCZEJ3eiIhzkGpHszK9TzHGNt66T9VKIGm0ZNQquztmfaQ
 83MKqqaBn1M+FawrtVXy4Z/F/iZPMwCSC0cWSev3YHtdaUVJ4jkWXp1hh/4X/LDCK1L7uWUu6GU
 kTqSFjrk0pxL/qoCuPG69gt7ot7+r/Yby6S3UFZcpjb/FOry98ESHrzoIoVWdB80uOTjQ+/puYC
 UzSnDf5thB/2DC
X-Received: by 2002:a05:620a:a217:b0:936:cf64:97cf with SMTP id
 af79cd13be357-936d239212dmr3033325585a.41.1787028328464; 
 Mon, 17 Aug 2026 21:45:28 -0700 (PDT)
X-Received: by 2002:a05:620a:a217:b0:936:cf64:97cf with SMTP id
 af79cd13be357-936d239212dmr3033322485a.41.1787028328017; 
 Mon, 17 Aug 2026 21:45:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cf960b6sm911796e87.13.2026.08.17.21.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 21:45:26 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:45:24 +0300
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
Subject: Re: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
Message-ID: <bi3zx3rvebd4ywnyzhsu2ft2sqz3rnoblcgt3jpmyik3n4dxar@nnddlv2susx4>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
 <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
 <c54f5212-809e-4517-beda-f86b375c086f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54f5212-809e-4517-beda-f86b375c086f@oss.qualcomm.com>
X-Proofpoint-GUID: TsjUEDwCLfyiHRAqfY956vIENk1t0t70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfXyo/cNq9DfDxX
 HCSSNtqROCvkZHcubOtsNCWvxsNuUo9xNijK5k7HTgrTiA7bwepvbMeHRnjZUZgvch6ySnwJSMu
 6lpBFMorDawDPQZylw2pLj2KvYdpUbkI7NuByoM9oVT8DeeDgokTO/uSRmsncihcTnAuUgAw2Hl
 2z7MShXXW6yViqlxobvtWFZioCRTINswDitwbsFSv/v/qJG9L+gVyZ0tDE3YoFUPvfasymeUAdb
 cGn7qVKxJLPxxPw0BIn4HLIRAKivpjw4v0Viii7AmfrR3hlnlu7uTxBmDM/65J17KIyZWNotrUV
 A3od8Fw42m0Gqw5fH7ShDlpVmvWVBaHZuXvFPj8ql8+QCJ3N+kV81WnffJi6kkYsVAofrqPxuvF
 rk/UhvIEhC0Sni0oJDgJCmOiKgojiwLq6EkE9Q65tFIXCLmZPZsQWFRA/yF52+mWAhibhMSJdus
 qpmZ+HUE7WCRp7Epxig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfXya3WfdwzTPEc
 6onxi2zsEY44jYTEIr1b4AknrNvWYza7bxEf06b2xjCMvSGs/h8zwUc7xjovuC0eFZIIT8hhhxb
 iNEWwyCOgvXAnLh0g33XplUdh4e4qmk=
X-Authority-Analysis: v=2.4 cv=FsU1OWrq c=1 sm=1 tr=0 ts=6a83e369 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=SJmWK-JnP90tPv7FAzsA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TsjUEDwCLfyiHRAqfY956vIENk1t0t70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
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

On Tue, Aug 18, 2026 at 10:10:16AM +0530, Ekansh Gupta wrote:
> On 17-08-2026 12:28, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:43AM +0530, Ekansh Gupta wrote:
> >> Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
> >> retrieve information about the DSP a given /dev/accel/accel* node
> >> represents.
> >>
> >> The IOCTL takes a query_type selector as input, so it can be extended
> >> to return additional parameters (capabilities, attributes) in the
> >> future without adding new IOCTLs: drm_ioctl() zero-extends the argument
> >> structure, so new fields can be appended to struct drm_qda_query as
> >> long as they go at the end. The first supported query,
> >> QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").
> >>
> >> The UAPI header include/uapi/drm/qda_accel.h defines the command number,
> >> the DRM_IOWR IOCTL definition, the query_type values, and struct
> >> drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
> >> types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
> >> licensing.
> >>
> >> qda_ioctl_query() validates the reserved pad field, dispatches on
> >> query_type, and copies the DSP name from qda_dev.dsp_name into the
> >> user-supplied buffer with strscpy(). Unknown query types are rejected
> >> with -EINVAL.
> >>
> >> qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
> >> DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
> > 


> >> + */
> >> +#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
> >> +					 struct drm_qda_query)
> >> +
> >> +/* Query type definitions for drm_qda_query */
> >> +#define QDA_QUERY_DSP_NAME	1
> > 
> > Why is it necessary for the userspace?
> Currently the requirement is that on systems with multiple DSP domains,
> each is exposed as a separate /dev/accel/accelN node, the library must
> query the domain name to select the correct DSP to offload to and use
> other dependencies like shell etc.

Commit message.


-- 
With best wishes
Dmitry
