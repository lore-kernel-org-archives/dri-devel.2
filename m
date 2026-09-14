Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B3CC88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D42510EAA5;
	Mon, 14 Sep 2026 00:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivwwbir1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jcmHHxGi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE3910EAA5
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:49:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E066iX2659890
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8NmfChnxo2IRmwbHnf/kQA3C
 nLeLHIcwhqHWKX+NDPw=; b=ivwwbir1QmoA/WcQUVtfLIY86ofLq1SXvX4BIJup
 0ul2sFFHAp+KiiXI2i705dfQgd4SWlF+RzFaBWlXmf1e5w81EsS8PYPdGH3pr03R
 kDNS6f680wt6BR9ISGBekyLJz66JImkhtvYeh/zWNjZrV9waXTexM+3RtA52CNqY
 rGhxFuv/qE1NmlZyftgQPhqWGzq8CidVnRnoHTc5pYzBUCTx17AnwdRxSnR4YMBy
 GM+xdSOkv7zD9SuGigzd2Y6F5G8EbIyW3bn1rlcr+YlA0dkwoe15fnZ3ClIysVoJ
 p43qKCC0Ce9yWmmtNZf80BX16++RtFkSPJaHI0fHj5TXIQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd4gdb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:49:23 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97cb8d1b032so169717241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789346963; x=1789951763;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8NmfChnxo2IRmwbHnf/kQA3CnLeLHIcwhqHWKX+NDPw=;
 b=jcmHHxGiHOgV6lWR8kNzoFlfIC13mc4Rv9Tc6FkIDpu0sX00nXLbHKhD4PRWMmqgR8
 DwtxApEQD3s+y9VBPFCg3FYQHafnzoGJmJ/8GaiYLRNZKY4YFd8EPWewOF+orsp437Im
 TQl33z+8k5EY3N+WIeDmJ0irYHMbtoDM5D1F9raD7XxRNDloCD5D/mapoJLBy/fRaIql
 qhkzSEjFysPaL6w9ZZDoXA2aKnyD5uIkn/fw6VOUgsS3xUIyWewVAlN6JLy4gfhvxLZc
 CG0GGmC4ErMZoEEBQWtAqdqWnhGvLMz6ZT0wqdEq19O5YXk5SlcajTed4zFCZGlil9gB
 H2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789346963; x=1789951763;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8NmfChnxo2IRmwbHnf/kQA3CnLeLHIcwhqHWKX+NDPw=;
 b=UgfbJbeRWtfG6+jpxrdbr/oURihTZDkUQKEJipPRf88PPNblbhh65Ei5xxWvJ6Y5eu
 7mRVMlNQGriW7YnZ2u1ImNJwUu+YBpq4n0vZT7fRbr8CifSPOD167iLCCTXEQk5ngAk4
 FV1H3lcm1h7Ceb5iLuXhdOOrZaGItO9g9cZI5OKFGSsLu3A/rScazjdzSROPCIeMMdoG
 GNT8XErsINq8JOQ2cpLzTxv2C1vrV69CcXhvDyyqRa0rcvq9UT2rxhqHOS61OCWJt1Ar
 XV8WYRJDm0rX/mby3LwcKBzORZL+c3J9NT4PEK71xSMXpUGAbKBJ6W89O3z9iwwdLA8C
 4Z1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByCFNZM5smO4Vc7H/JOMOiGqwSLo+HEibK9jKadY+4jQMzaNHZMZh8hkhQ93OP8mnmyYAt0KJ5joQ8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7uHfKk0o7yKk5HhiKVKmjCgWf1dIxcjMRTKbzmekuYVUjG4xU
 CLlNvAtFvsS4l98nwRbgfv5+t3GPwuDIe3fRXoGsK7uIN94bt65GnXRRdl2ukd+JSGfssIxk6Dr
 NxOS2pGArTxxm5IIPhW30vVSwY0vVOUyPCZFw1F1WkCK4BleFRfkZoj3Y4iVnkojx2YE1jCY=
X-Gm-Gg: AYBFou2DUI/v57gb/CYQWMDFFhgAK2CCjdnswXuoVbDdqRjTiIi56xdwzkXR1c7ROY4
 9v8CSqEKSFvmfCLQ4L5EXz9MBIHJFikwGeFOwIiwwBR5RRo4Au6TBlC66TFA77zO46H6FGmWrwc
 1/6i4IU8V4CgY75CbEVCBMcV9TJx7LiJjJl0FbYp+Sg4LS7RsJF2VxUFCM3i110gr9J7GCobQG2
 N6OtOHnRfxFy267LALFwsG/Nt2j5HNu7ojU4l03euK71HYnaPO7E+dn/ZApca9MM4zlUbMXR2j5
 oE+FsvhFHofFGVOjixbQ7dkmH2fBxhQIy04G9am4hbuzgQIgT2xcHHiQkcDTEG3GiJQ+DOf5OGc
 1A3I65SnqP9drw+xvKEArHb4jTwG8n7QtA1wLnrTWYWJF0dc63Pm1yW5SKI1qWtJVFjIs7aS699
 fNHJrlLH3JNJ7l
X-Received: by 2002:a05:6102:5f07:b0:79b:3059:5a75 with SMTP id
 ada2fe7eead31-79b56efc485mr108151137.2.1789346962806; 
 Sun, 13 Sep 2026 17:49:22 -0700 (PDT)
X-Received: by 2002:a05:6102:5f07:b0:79b:3059:5a75 with SMTP id
 ada2fe7eead31-79b56efc485mr108121137.2.1789346962362; 
 Sun, 13 Sep 2026 17:49:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0457189sm1977356e87.25.2026.09.13.17.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:49:19 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:49:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v4 5/7] drm/msm: Properly handle msm_ioremap() without name
Message-ID: <cnazznrbqwprv753cmzhevttegxhhkkamsfvullaullyo7jjwv@75lksywtfhmh>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-5-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-5-87bdb9f1987f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa74493 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=sfZjJuiDFS-vDwBeDzYA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfX7YPBaSrF5SI2
 Db8atEbYLveMbnE4UocR8muR7xBKN0Jcb6eGEwtHFY+LDlkRe2BQxxdAGQXdbjsNj+7Dxqi3mB4
 HPRcsoaaOjA0HadvLDXxpY9FLU+5P+ipPJwOAJK23E/vIjjZUINXdoEJ1Hki75lClBm/bPuNYZ9
 SnwHokhwuexyRQ9TczIzv5HExxYHlYvqHTRquIzRRK3lDnh4RM9Y43VjKYRF2k4W/bUXsSHDmfG
 3jzNyYXOT0wwTcqpbbxLqsTh76NiVbLWCqKJ035WMf+eBKNtqRD/7Da8yzp+tMy2dVfLjqoekDR
 LaQHOCzl93XrYg44k7sXC3C4wPSh7zsQIRFr/oeBnO7MKx7JMPF70VMl3rqE8YPsbevqJW1Ba/X
 oWVlhPGq+WhKUPAy6KnDmKH0x70TDwa9kCPHM8UkCuT+5HoTjNdhDymsRtSSGoddtt7gvLuZeOJ
 TdpLbdo6Fz9gyD/jqJQ==
X-Proofpoint-ORIG-GUID: OxfYHu9JAUXeyNc8hh3tAp3CFmdSiEeS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfXzadVh0nfkZec
 1zwG33Vi3o/9dXybgTnSh6J8EZsQB52sQS2sgw4NQp3i39Wck+AeoRryaRer/XNBHaUYrRTOIw8
 ZV4e0XPE8qaWZ83ijj7rNZrbXVrNAEQ=
X-Proofpoint-GUID: OxfYHu9JAUXeyNc8hh3tAp3CFmdSiEeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140008
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

On Fri, Sep 11, 2026 at 12:29:38PM +0200, Krzysztof Kozlowski wrote:
> msm_ioremap() accepts being called without name of the region to map and
> in such case maps by index 0.  However error paths still use the name in
> error message.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
