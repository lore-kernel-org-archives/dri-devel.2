Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AD7D58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E4F10E356;
	Mon, 23 Mar 2026 03:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LrBHAcfL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNT+YZfl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9AA10E356
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:52:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MEclbF3871174
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SBHZmWG2eos/Z0fys+HWZX/5
 ZQMkVDuGUC128e2/3xg=; b=LrBHAcfL5InXVNGkVuV8D/y/OCEI3X9xrtuAI7J8
 x+qYR4bqk4ArExKkf0CYnQl4t4t0psm8dRw08fcMFfs/VbzSI+XQrrO1Yk4BCt3V
 AzQGmiFGb9DUEr7D2Les454qUmqZTHe7TvDn42zsN2ZuzUHCsluZg2QMTgIKXmHT
 +FNj5ZKDNeodnSkjPqkfJUpumYdVpoEW+S8kpA9PP9JbhPiqLNVe9xqNbaTM00bK
 F88ZlNc66ZD5AJAe/gxLH9WKRkbxQPvru8Pnl7MX8zjIcY15dBP7RYy5rA7lGemL
 DFY8zNk5p5FoSHra+6r6vj7DZq0PI/yPM7s5l1Ud9bNzCA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jwvkn73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:52:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5090cc6a7d2so228783671cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774237976; x=1774842776;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SBHZmWG2eos/Z0fys+HWZX/5ZQMkVDuGUC128e2/3xg=;
 b=WNT+YZflWv/hi3VQNmkYw9ReesJqwjxwj71lg6f9yoPcGuEQLoaEJ35HS+YXanbL7O
 VGElmhX8SCHCpv78qkrnnzH0OgWsGIAstxewkCZUa3ed5qvXZMGwuoD3wk8CjDyRhpDw
 7CMZ7M/h/uHgVh4JuIbd7vrsRYzp3IBI6Isliix9pQzS3hl0Y7t1WQ1Vwu1ircmV1MUj
 LB5Q378DYpT5o47pzCa1M7QeB3s5sNzpALLPboQDDv4uPc/SLz3kJgkMRRBHP/rofkI2
 gRN0R9ppsgDfMZH0YvKxI6L0NOaJCuTFvhG2Z0Zn7FsKcEQj6Ob/uDqpGGCai+4nuvJI
 AhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774237976; x=1774842776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBHZmWG2eos/Z0fys+HWZX/5ZQMkVDuGUC128e2/3xg=;
 b=eGuA4n8u1gEzPxTf9Yiy0fV1i4jNFVI1x93kPCVFzR4wTTEnPg8UfD3E1bzzYAKjOj
 QtNFMJlviJqpMBiMd52tGbMTDecdBBry+m6s/+zX74pQkJJ/Tgfe/L4p+qSHMZMT6u2q
 SYaQ40kwywwu0CcmjdRynbgtsupVluWrrDBXAhL67W2zk8CTo5Bn8SINEVjh+/1r2wBQ
 SixASdjlhq8aK6clFDu8/tuNeWJdD9ITllr/3mw0g2T9A8vgDDtTyW7OO6fLvubGlikI
 O0Rz1VEFGx11OeLQ+Yc5u2omyAwkMcSkc/WK8o3NXiqx3OFqG6ewj52x2Qp5X4PMLTH4
 ECYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfG0NcS2vKThmuSSbebC2pAZ0pqZEf20SxZ8od7RPrnj+qxOPN6RIAnAdziDp5f0GV8l5xKw+v824=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwscC3QuSzH3egF7EWjm5cfGwErhuVYl10+Yvaq/M5ji6H2qsRo
 gLjjPG6KKYg0ZmebYWgWKZvCD2DzDuagKAhB8gGTi2WPvj56yOcAep5cDuCGI8p3YuKMDXYoUuw
 Nx64I+VYa8f75px8z1WVYePy0VTZebA3D7PqKVn2Fb3g5QFABg8Ue1s8ogHrB77j2oulGsNY=
X-Gm-Gg: ATEYQzx0bcsbuuj1CaGKVh9StlgndRly+1zXLHuxH7Fco59zXQqnfybWITNH27R2c4x
 emtF7p5LA5tF7P4Mf4+3/22xS9bb2kAXLoh+9//zopUi03gJxfSuXoAbNxoAebqAWJJB0eXX+pr
 ahnu6+O56a7GfLIGTFYvjacMXEMHVA60rghBylFydcXG7AP0LWTb7GU0A1bgynuB87c6hRayOoi
 IFZ1dFkMvGmlHl9Lyq6W4NeZgBQDnB5pcKBT0wjidqkgsLQnDWp+iHUzU2VGrjozjyCGXCtiwWd
 fSAeGWU2cbi9sEurxFUJubNI9jRdBpJBdD0fVQJeaklEWqcp2ZcThUQp66MKFO4KVDg/Ke4B09u
 Z90H3GxZuuCHeGY26F82yxT2h5nVdlt2P2558JgpRAAWJIENffCNnT5p4P8qMR5bgWMWLNePhCQ
 kqXnkHN72kgIS+1RButW7/ZvU5fjvH0NIxeD4=
X-Received: by 2002:a05:622a:2611:b0:50b:4e65:95dd with SMTP id
 d75a77b69052e-50b4e6598dcmr83704861cf.62.1774237975749; 
 Sun, 22 Mar 2026 20:52:55 -0700 (PDT)
X-Received: by 2002:a05:622a:2611:b0:50b:4e65:95dd with SMTP id
 d75a77b69052e-50b4e6598dcmr83704731cf.62.1774237975316; 
 Sun, 22 Mar 2026 20:52:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f24sm2308266e87.39.2026.03.22.20.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:52:52 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:52:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Icenowy Zheng <uwu@icenowy.me>, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: th1520-dw-hdmi: Fix error check on
 dw_hdmi_probe() return value
Message-ID: <dorukiihun3m5h72y5o7vox2e6rpc4dgommbskj2snai2hegf2@6w3wrtludgg3>
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
 <20260321-th1520-v1-1-ec877197770d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-th1520-v1-1-ec877197770d@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNiBTYWx0ZWRfXwErqyUn0U2Bj
 wO53MuvHjRHbQDFvZOI9KbGLWRLHiPIj//D312u+Eo5OqjWI4YaqlquYf2F0F9AFIapOQ291NJY
 bhclf1eBfRKE9NT65/UTeSQUDXLyT1tqv/0HZugsTU5JT7WRYmaDym87W8tdPFW4kaDok3qW5VH
 qoP4N1RcaZuTMqrlYQC3kwDYgPYHe5uVuo6AKWk8MZdYn2/1Zu6tGVvWDRszhxQ5Hx/7D1HXMxZ
 NZa52fe4dVbVI9d83JZfGYf9oE8ss80f+xnPXKqCVbSy2RWGEWSO0u8/upWHCKD6Hz9A2eEsMb5
 pEy4Zpp8h1rEi28DRfEYwoB51yIV0Im/eqjudF1KucWKZ5ojIckhgq9YuhiPQo1iYl96TwweGCx
 TWuZ6FWGI1AvQc3FYxhC686oUSlAL2iL+V2cWg0RhhBigWYfGhzcrb878RJEl8zHk6B+7wfs1K/
 +W76YHJ7GnQDfrOP0FA==
X-Authority-Analysis: v=2.4 cv=bcdmkePB c=1 sm=1 tr=0 ts=69c0b918 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=AnjFVvH9sMFINUPBRAEA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: gnq32Xx__dF8gl8cQ_G1WHTCTeqHvKyn
X-Proofpoint-GUID: gnq32Xx__dF8gl8cQ_G1WHTCTeqHvKyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230026
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

On Sat, Mar 21, 2026 at 03:12:10AM +0800, Felix Gu wrote:
> The error check after calling dw_hdmi_probe() was incorrectly checking
> the struct pointer hdmi instead of the probe result hdmi->dw_hdmi.
> 
> Fix this by checking the correct variable.
> 
> Fixes: 96f30ee0fb9d ("drm/bridge: add a driver for T-Head TH1520 HDMI controller")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
