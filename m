Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DF3CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C2410FC36;
	Fri, 29 May 2026 09:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bF8Aye57";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dV6+DSJd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D0810FC36
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:56:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T6KGYs1369434
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oq0H4CwrABbr09oUXS571+Si
 t15jLqxOa1KaFkcBAXA=; b=bF8Aye571s3BvrfIvwHsx2RhOa6fKcGpLzOnOppJ
 HCby5RZryJ2wfvwXt2zFvAQo+6ttDBwyRreHDziQ3x3KnXcg574/G/e13XGu7glM
 kP6PT8hGe8eA345gDzbH574L1nNqzMwxA0Sbs/cBuYgmFKcJyrLCZZOBi6UJfXzO
 idYHEIXKUu2ur49NbIGcI2pk2byXkgOCoFgO13BIgYOQ4adlrJsCPR3qyaQpNyEq
 yWx/MEtWYMBuU8tXYhkXqKPkzRLFgWaRB3f0CvbxxFIuswJjbnDvAPqlUkXWiiiR
 Ut46nbwrtPfpCZYcer8EzioxcE22ZPlTnE50ULqfzuRXFA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5uk6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:56:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d19f68acso152546491cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780048572; x=1780653372;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oq0H4CwrABbr09oUXS571+Sit15jLqxOa1KaFkcBAXA=;
 b=dV6+DSJdx8XlgHbSXDNkb9WYPUTJKPwynO+W0bVt9Fbx1Mcv+6gKYSQaa2NMO1ZPtf
 qEhMoP4X8sm/qwlLghHcO2DrmRC2myOsnMCXKWvepCD5gMAfZuUw8N6NVjg4NbDqCdZf
 m8bldvxJo624uTitMPfPiSnW19eX8u+M5AqREgtL9fdykDpGcxKQJt0fMrcYFV9qSb/O
 zxNlkqbsn2PL1lsh8wQok+ogxnWdWIo4mBiuni5B5O99Y9QjWir0d6nrapUlC7ZD2u+p
 gEULGccYdmKFV46v33YXNIdd5pSaGW8FYX8aWWARYzL8P8A3QxBn7QUIQKO/tp4un9Nh
 SJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048572; x=1780653372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oq0H4CwrABbr09oUXS571+Sit15jLqxOa1KaFkcBAXA=;
 b=EXA+rA0wVFcS6ygcSLFWUMfs4QziylEZcE8TFpFbi5KcM0ig1ECSaOg+TAErOTYe/q
 41uxw+CAK7JPaiCPA9D0nT1FwEGRW4nVNvm1GkJAI75hza5oKPyQXgVQhMiQGrIL2/XB
 G86iRqQlGW+0gcaFCb2NuabyORybYVPa/4qj6ywPF1Ko0KGwwDvqKQszbwQ+aMee83fH
 /d5cdL52nN29RnKpganWFVW5DRruesHxnn87A793kOswdBzFJsS9n1mmQfdfuQ3fL6jm
 EoqvcW4V5zI+4EkEfs/Nrf755rhvBQsk8u4hFxtdBd8Bm21/HvdAyftqXLyuS3QtgUC5
 pyNA==
X-Gm-Message-State: AOJu0YyX0lYxQeDBklH5zwUO0vwG4cBtYpNgp4ZW7J6bpVojw2nUZBfW
 lZ9s4jNYpX+4J2kU9iFYHHcBGTrQ9XZM44HEOOffwRvMGrNjMxDpkNliAtFhdF6GO/q6n8D43IR
 h2JQ2SDUEhgwy96K+0ZqAaMJo2v6+lb38mxIi8r7GVTHt5DDhbG41syMAH4sI3AUlTr/6WmM=
X-Gm-Gg: Acq92OFxXHBABHO2V30v5qsTW3f22Aq6dS3Ou8DwkaN1JAKVWDk8rcvG8M04FDYDPNk
 hl6fjI7f5Z38XYxZcIczxwgORzjaqMzjfpxPQmGTKtJOdEbQs8z4oEJOJw0Uf34rrEccKd4Z6nG
 cr87+RAWjwp7QFUKwIomqvBU/1lPxuhA/pMp7bNdYv05SYedgV+vu3MRAftGF8eWhLMNVKjAf/w
 es/Ehf9uDvbSzDQ+KcTccA8zKh5vLCfTUC2hypLodplH6IjrM6tVhHfoaFEg9gb4ByJIjyH7Pdq
 qmsZzT+cF+393wTUfI4QZ6C6nejYIEdGTvVjy3q7hyf9IlcXUP5jZn99YmnmNc/2KmHzZ5Jlaek
 r8v5VQMXOe3OWEkma1aO2s1+4WcebfuheMIanQ4gaIxLZ7z5bWtpPPtwnHZS3l+X+f2vEV9I7ke
 iMSiqce2HWcQsP/twfDaYhWB0rG5vzQctNzsI2grgBFTxGVQ==
X-Received: by 2002:a05:622a:5b8c:b0:516:f4ef:5cc with SMTP id
 d75a77b69052e-5172dda3a7amr25047441cf.54.1780048571750; 
 Fri, 29 May 2026 02:56:11 -0700 (PDT)
X-Received: by 2002:a05:622a:5b8c:b0:516:f4ef:5cc with SMTP id
 d75a77b69052e-5172dda3a7amr25047101cf.54.1780048571289; 
 Fri, 29 May 2026 02:56:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39659e88c14sm1383711fa.42.2026.05.29.02.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:56:10 -0700 (PDT)
Date: Fri, 29 May 2026 12:56:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v4 3/9] drm: link connectors to backlight devices
Message-ID: <vtyq4mxhyyp5nt4vtl2ct4yxxqogzpqxrvnupwqfa46ucddnil@cul44errvgnb>
References: <20260528054911.1513208-1-superm1@kernel.org>
 <20260528054911.1513208-4-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528054911.1513208-4-superm1@kernel.org>
X-Proofpoint-ORIG-GUID: Fl4be8xD4Txj3n4m75uaKtxJ3j57GV1p
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a1962bc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7xP7o_5yXfbHSuqn-lgA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Fl4be8xD4Txj3n4m75uaKtxJ3j57GV1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA5NiBTYWx0ZWRfXxdOYkruHP4JF
 u7eLXElir1lgB6KWBGGde3FDHdAg+u5HUhVDPGb8UjsIt2W+PGKDscLGnDRO6Lo413H8kq/eh4k
 /Hm4AmdVf0/Bi3iTaY+iTPtt77zVHtsy9lA1LQE6ZyLxgfCb88ZA9cIwJjQAexJbZYAWOaQom/G
 kYx4eEVwD0R2mkeEt3mom3KS68LoQbFCBV8fQCub43Edbt4TIlvpZ49JBBRMOSaz0cgyzqqWgX2
 JDtc1ZuIt+4T/e6Zm6djiC83pCXo/kZzrIWQoEof5f4YE3EgN7U5F4NFbJb0jVRUXPzFDke14oZ
 BYvrDZhoLLROveJ/VL36M0gkt5Z+E0PGmKpSliIpJb3IgEUjQJ6wbv+TsSxVFSgcQnM4FVQGlHv
 jC+o7NVcOtOElT0gswljQopnjwT+qNIRuBaEV0wDxw1RJcCrhgYuIf3IxRSJXF3gTegzrq9lHWN
 J/J3Wy2CAA+olRbp4JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290096
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

On Thu, May 28, 2026 at 12:49:05AM -0500, Mario Limonciello (AMD) wrote:
> This will show which connector in sysfs matches which backlight.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig             |   1 +
>  drivers/gpu/drm/Makefile            |   2 +
>  drivers/gpu/drm/drm_atomic_helper.c |   8 +
>  drivers/gpu/drm/drm_backlight.c     | 430 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c     |  12 +
>  drivers/gpu/drm/drm_drv.c           |   8 +
>  drivers/gpu/drm/drm_mode_config.c   |   7 +
>  drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
>  drivers/gpu/drm/drm_sysfs.c         |  28 +-
>  drivers/video/backlight/backlight.c |  17 ++
>  include/drm/drm_backlight.h         |  46 +++
>  include/drm/drm_connector.h         |   3 +
>  include/drm/drm_mode_config.h       |   5 +
>  include/linux/backlight.h           |  13 +
>  14 files changed, 641 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_backlight.c
>  create mode 100644 include/drm/drm_backlight.h
> 
> +
> +static void __drm_backlight_worker(struct work_struct *w)
> +{
> +	struct drm_backlight *b = container_of(w, struct drm_backlight, work);
> +	static const char * const ep[] = { "BACKLIGHT=1", NULL };

This caused compile errors on linux-next, I had to drop both const
specifiers from this declaration.

> +	struct backlight_device *bd;
> +	bool send_uevent;
> +	unsigned int v;
> +

Nevertheless:


Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK



-- 
With best wishes
Dmitry
