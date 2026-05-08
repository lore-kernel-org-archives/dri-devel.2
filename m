Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8B6CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D50A10F459;
	Fri,  8 May 2026 11:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdYLbyBL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUGBl03z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CBA10F459
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:28:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6486jG3W257883
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 11:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lZj8wKQLRDlWLBw5Ye9hIxrQ
 RupoN9Xpb0IQCpWIxt4=; b=IdYLbyBLBmMleugIXz64/ZzbT2j6l8SeIMZ1V0OD
 1mEJW3jBdQDHrbcoQe27rwKnb0RK6UmtZ6TxHkuXBXBEHoYZxB/PttDsPgP19lYl
 ryzZWqwdImihFVLYZCtRgo9hd0U5zGA3HZLH5faw54M16WAvpL5wZnbqDIJHl99i
 T+gYMT/F4AXThbsjpB14rXy8WbODr9UMwj8Ub9WKbipX2ajVI/D5cJaHItq9dxeY
 sHQBKpQIG1KSNBPKZdY0dqzNGBDp3fbtwXaXgDZFqwnXhNGo3UpUFIgAXWJeL3jz
 ZHSQt8iPtX4zExc/KkTQDsnXXOuNjyR3RFVeHadM9wn7uw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1aueh1wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:28:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fb6d713ddso31986581cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778239693; x=1778844493;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lZj8wKQLRDlWLBw5Ye9hIxrQRupoN9Xpb0IQCpWIxt4=;
 b=aUGBl03zmXH2iivW9FUXP3X62O7aIeRiy3KsE3nAPrDYvbstgThYf5qVmZk1F3s90R
 Fo3OPNJB0VuVWqHvmcpUEDItSiNvfaioaYktfdS3cLqPjPk+4PWN0BGy1V7VWw22vQY/
 UrpdqkyJu5n0Y3gAGgPK7dw2uqXAXUitwXSQxVS6LMBgN4RA3fRRs9rcVfXv1BSBPwTv
 Er/a+Qrtp8xOa4FvYmp9AKRn7lbCVy++jS6Mkp2bq++gg3i8Q/OXbSb6JmlxHH7BAgOQ
 ITP6OfXXkqGMc+RGGodBxzLN623OBXj55fWS8cYS3cXIqSrOWJca52gC0qMjBBdH/sDJ
 Wfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239693; x=1778844493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZj8wKQLRDlWLBw5Ye9hIxrQRupoN9Xpb0IQCpWIxt4=;
 b=FetB+oJVohJblfOgHCsAhsANV0P6/MCyah+SNAl4+Z7Jkidg/dHBQoBLJA4hrsW5ZL
 u0XzEj5M2KpF3S/FHr2mq4E44df4yy8ZFEIFH71QTg4JXwsfncFS5ET/cxPgbtVL9WJo
 pAMcKcitkba56mPrq6XY4aufPVzFkScvBYjWYMBYUg0NVWRSCUqMueDgabayATb/jzb/
 RjZo3EpcseCJvQxU8oPHMKJoCMyQqQfLN7/rfKTwOkmr1U+r3lf1V8N4rhFRhc8ql8Px
 Sina5qkpA84MdoVHhuvA7wSyrM/TjXa3u3qhN0H9n3eFlt0uFyRNiptmTyUWsWkJ+f/S
 5O3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kknnv5GygfI6AtjeMerWBUIE1eL9dpARNUwjnJhP499Zl1LgeTokBuRLvNV4BVLsR9t2pDnR7VuU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNGxQj6ojxJBsL/n6wsZDbSlZ6upghvyE3GJV81M2nQwk3LstC
 Z3xTnojFmJBlAYEvnY+FxUFWPREw2fwDA7/hnALiObSRhWICj+k6QoOMwk+q7EwWdrY0XqpGmwW
 /ljUqxZKtGID1VcMPACgL+m+65LKegw8hJqoTPOI3Sqgp5QnB2/yTExsXtGFLdcrcALaPZU4=
X-Gm-Gg: AeBDievL7zxEBqhsKTgsSfY0qFGc+pnT+vxFtlgbLZKRqweGog8y+izCgBUreLAHSn/
 4zU+khyTG6FNIZT5PcvIWvGHLRIW62Y8jRiq0ABN13KoWo5N7N8Yz/NRzekq4kl/TTiMF9XNQ5X
 6ZXKwIQsJeRVkfbcDUCDbvbDI3r7290jbGaGeGHgqc+efhZTcKt6yrWPuv4DTeCgSDArGNe/MMQ
 TpYeDwccbCmK97j4OjquuxhNJUhv/ubfnwDDu5/rr3W3zIoEseWH3wQMvLmLy+JQ8p0mBO091iq
 WVKrqNMlgxkMv6tfrKeIdSPV+4eqjehZoLFPc13/TaDEBbgDRNm3L54IMxxH6sDBVCW/3l+PXfU
 UnnrOgRba6KthYP26ZIyuzFC7oVjd3hAlUPnqI/LpiN0qlBz2IDM0DeM8oCqWb2DPfP0ksC13Gu
 l00K1geRrGbeSFTlBnUGdQcQwwXLd/m+W3JkY=
X-Received: by 2002:a05:622a:1f09:b0:50e:5cc7:97c9 with SMTP id
 d75a77b69052e-51461f9e7aemr157909161cf.34.1778239692693; 
 Fri, 08 May 2026 04:28:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1f09:b0:50e:5cc7:97c9 with SMTP id
 d75a77b69052e-51461f9e7aemr157908711cf.34.1778239692115; 
 Fri, 08 May 2026 04:28:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f60db4f1sm4073741fa.27.2026.05.08.04.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:28:11 -0700 (PDT)
Date: Fri, 8 May 2026 14:28:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] drm/panel: Use refcounted allocation for
 remaining panel drivers
Message-ID: <zpavxomuwm2orkncl5kp3e7nhesbnnjqci3imidt4nnoiyndqd@qnkgocn7vqzq>
References: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExOCBTYWx0ZWRfX+AVKpkT6FqRW
 SfpXPzcQhn8aU5z843qkloCM+JrKS9WyUZ0S6vCW8En4XL+6ZnRxsbw+mApbvm9FsWnyYfiQNvA
 LtQWNw3XWdk3XDFYJY9LoodA4/B0Ep+ApWyfwbgDLmxWrl/HKlv5m5Gwln4IT69C1Sq7qchDb9p
 /KBmkmpB/Wktu/Gu1bFURAINuBkIEDdMSETej7y1hCXiUYMYWhExjjawrTZXLtnUo2PXq0dW5xP
 q0qd06eHFuZmukx9i4gj1BggKcXg1jteVJVQ2+ZO9iPounTG3TSwjxp7Tgvj++A9s2UX0ipBIn/
 3C9XjO7vAa07zLCSELMVXd4QbRc5wAtCY2+dI+TilK74T5wDoMCr5ehbZOxOwxnzNDFwLKwdOeQ
 borLw4Zbis8laCrMCQVYWkE/TOlx72le+luKswfJHpIArA2ictORC1mRB61DL6CIItfH5UOtYuy
 IZr7K2lBuXIdvM+RW8A==
X-Proofpoint-GUID: bZF4EZBFj-R9JXGf7ILFQ54z2wxPPXSV
X-Proofpoint-ORIG-GUID: bZF4EZBFj-R9JXGf7ILFQ54z2wxPPXSV
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fdc8cd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=gvhMLlSAHK5mRaL_7nYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080118
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

On Fri, May 08, 2026 at 09:04:40AM +0200, Albert Esteve wrote:
> This series converts 9 remaining panel drivers from the deprecated
> devm_kzalloc() + drm_panel_init() pattern to the refcounted
> devm_drm_panel_alloc() API. This follows the work by Anusha Srivatsa
> who introduced the refcounted panel allocation infrastructure [1] and
> converted a first batch of drivers [2] (the last part of a 5 sub-series).
> 
> Reasoning:
> ----------
> The old allocation pattern is unsafe: when the panel device is
> unbound, devm frees the context struct immediately, but the DRM
> device may still hold a reference to the embedded drm_panel through
> the panel bridge, leading to a use-after-free. devm_drm_panel_alloc()
> wraps the allocation in a kref scheme, so the memory is only freed
> when the last reference is dropped.
> 
> After this series, there are no remaining callers of drm_panel_init()
> under drivers/gpu/drm/panel/, and drm_panel_init() is entirely removed
> from the public API.
> 
> [1] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-0-dad50c60c6c9@redhat.com/
> [2] https://lore.kernel.org/all/20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com/
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
> Changes in v2:
> - Remove drm_panel_init/alloc precedence mentions in kdocs
> - Link to v1: https://lore.kernel.org/r/20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com
> 

For the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
