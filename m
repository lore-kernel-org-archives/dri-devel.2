Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11114C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED36C10E192;
	Mon, 14 Sep 2026 13:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdYADE78";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YTzWJ6Bw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183CE10E192
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:29:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0jju512755
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A2oe9WYaH4TAkTlCFmhnHizk5lGknQxaw0iqFnj0J8k=; b=CdYADE78z/zH8CyG
 FRA32jzDGmlkiHgOcX90VEsNibqKg/uouUN9JLiWmCTe8cYgWKsizhKfQukbbUsq
 LLZx+/1Qi+Dh//KFH6kJwoOOFdS1heOaaKFHktKpOLdNugLgGTIksinRlhfJ6fM+
 m6KAKvmQsb8NadTRgzZ7Okrwi1LvB/bSttjNBdMc/jJM/oscOCjSc7ndzJBhz76K
 uBB0+EGKpZ8GUJ6lg/OnGguFMWCpNfHLMSWOq4UgNBS8kIAPWhCTRgAzDargEb0/
 Ly51XRROf1cLP+1/UDZQukfmlDs3dW5Q1JUlkAYYLyiQnsst1o1h/FFfKQKudN1Z
 4+66BQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtg7cd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:29:18 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78f2fe53829so2878084137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789392558; x=1789997358;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A2oe9WYaH4TAkTlCFmhnHizk5lGknQxaw0iqFnj0J8k=;
 b=YTzWJ6Bwp5dfx/IOxI2vj2cVicisJhdfR3tqzH3PtdXMuNu8CY7ATzDKKAO1iP5EJf
 uahX1RN6PRgvGgWLMaAoLqQ5jdFCFoYa13nsgXiqtJs9tISp9sTbLX5kF8BFANoz9yUA
 iaXbfACkK7TJ5PkO2UvOzJCFZ3aNjfOUQ+20jBW4C4zpckyZGbMJL6vSV02Sjkg5NeQu
 1mCqomgiztYkjd5QjAKEKpLH2D2nXw74f4ZnpGuX/xr/yE+yaRJoLF7/0rguDYg19GUa
 hwfUxFpY82IOE1il8Ql1uJZqWr+cgOAhoDH0y/j+WhELpv6KElGOn6ZiDyKk1I7z3AF7
 NhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392558; x=1789997358;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A2oe9WYaH4TAkTlCFmhnHizk5lGknQxaw0iqFnj0J8k=;
 b=Pc2hJaZBMJrngHpkTHUcOCPbCS5G8XPS5RzK33GJJJHrsQjbanEmkX09BzB0VCdS2c
 m1yilNlMKxE25JTKBahBlJTOMrt9O4o0zsW/WkgnlOaZopHVXOE6ven4Lomv9slk0Z+x
 OtCNUaB1HUhJkpCwQYo6aDVLeoi0vAcJ8HTuaiKLWcGhMqDYeIvkAgZ5SUS23O8bk6OJ
 6CwFOS8k+av9WRORt2GLnEGVLAGCDkdYKugTQiMianzfajWSN700GH0hkwZOw041No0I
 EiAXoljKc3IddV3ZF/Es8qA2VqoRc31DBAztyCon9UJae1EAWmrFZfDaK/bxCYeASBvR
 ElVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxOQFdB25SQTb+XOJKud/DIw+ygjdtz0Y/Wswn/G8RpeAYipFMkoyIXRQTE4Hr1I0/3qMCC1I1pdQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nSIvRhnHtmPZasAmoW8pPm5WBN8tMYVxYBHTkaFyYiqmC7kq7y
 HdVJO75e4C7ljorWvvT4tsDiuTPj36at9GfEddcR64vPWRCxnRd1VzXShmpXQ/IG5MpfMD6Tsgw
 ZWmjjpUQyl4a9586SnpSCbLN03sMEy7ibJAvGeMdkXrcV4t4yjELeqpmTId3WCXmL9wEhLio=
X-Gm-Gg: AYBFou1p7vwXuoBq6lfSY4Tkuk7Qtcim5RA+q+ucgT9f3ALD1eM6E2Z15DxSHvd4MTN
 Cj1CI2hT5JZI9IfYV2twnULfRt38tTxJ/IMI0Mzb7HbnSa16mpmynF+CQhTwPiksw4Qhiaj129d
 jJKDj0sTpxD1Y7DOxj+aE1ZRhUyepLHZWGOBNgg1rYoaylk88ls69HI8s/WUEfMySyLZJh9aSjS
 g9Wqs31joNw2z5UtEOiD1O0E88scQbSbkRfYNTTG+evrpoA9xm2HqL2HkA5wJnLsqmyJ8XebVE3
 mMx4D2gqWuJ33328bU0fP0jitt+1bq3jEF/0ifoOj9o5u4u5O/7PG1PBPAhEd4coKoC5qHeZnqS
 8ZmAKfThpdSLOJnEZFjY8kl1zb5id3OgnTy1T9srfpanHiVHUtxgTVjUo5hn8PbzpwsfDHYK3xZ
 AISSmYkR8vgq7h
X-Received: by 2002:a05:6102:512c:b0:778:f972:32eb with SMTP id
 ada2fe7eead31-79b5c515679mr1850386137.12.1789392558298; 
 Mon, 14 Sep 2026 06:29:18 -0700 (PDT)
X-Received: by 2002:a05:6102:512c:b0:778:f972:32eb with SMTP id
 ada2fe7eead31-79b5c515679mr1850285137.12.1789392557779; 
 Mon, 14 Sep 2026 06:29:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a3144a4esm26968051fa.0.2026.09.14.06.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:29:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:29:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 09/10] drm/msm/dsi: separate host link enable from
 video stream enable
Message-ID: <2wj3y5o5edya4uifambdpzh2jkpo7xpxtjgrmtvdxk3z76uty6@tuoe2vkh7p6u>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa7f6ae cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=4I8C5fWqZRg8XWo767wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MyBTYWx0ZWRfX95zh8iontVTN
 Sc2DvyApBHL4pl54ZRzAkB6Hbytv7Q+1U/ZDNwZlcsJPSe6PgUCLudM8vJKIiNQU3T+S2zYbO+L
 S1ZRN4HGd5If1W6lL20wd9MWW296A58WtwjucKb9oOsqzCWD8Za6PQAyikPpDLnOrdxDIMgT4fk
 aKfXmQotYbVjBleS6sOtrcH9piSoTCNuxZe7h20LnpFLZgjI5lVdFgnwM7FrKAEP2O9XgrT0hyO
 p2TmKtF50VJK7WyipNrGD5TrOav2wjhSEIzT1bufNVFIAfFeAHseaDX1Rg/DZ4nZgSt2uRB8tiz
 ajfx1bcKMizIq+E0+R7THFrc71t5dtY0Yx2JkulYCBCb0Yb+16P07wf+nPOZ0uQt3rmr9LY9jbT
 TW0MgpOTU1E9BnXQwAg3lzegyZwrQ0QHaelGd/GdVeRn119/LUMRvgDQNohXTQ+ud1iMmgsbiNh
 r3IgBiuNpAAATkwQN6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MyBTYWx0ZWRfX9+twv/bFqKE9
 QQRC7/dRPH2sXJF0hUK0S6GLi6/Kdh4HY/AvPWLE5gMoHl87+ySO/KbDkkb3xmF3MsAd0ND/zep
 fXHEnjd7rZmBMNzJ2a0oHwl8SG2kMD0=
X-Proofpoint-ORIG-GUID: Zi8C95nzTk8To4Q8JkG4qCGIBFIzOFJH
X-Proofpoint-GUID: Zi8C95nzTk8To4Q8JkG4qCGIBFIzOFJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140193
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

On Fri, Sep 11, 2026 at 11:51:06AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> In video mode DSI displays, enabling the host previously engaged the
> hardware video engine immediately during atomic_pre_enable. When panel
> prepare routines transmit initial DCS sleep-out and setup commands,
> concurrent active video transmission causes DMA timeouts (-110).
> 
> Keep the DSI host in command mode during atomic_pre_enable to permit
> clean panel preparation, and start video streaming in atomic_enable
> after the panel has completed initialization.

I've not seen this kind of issue with the DSI mode panels. Do you have a
more exact issue description or a downstream reference? Is it the case
that the bootloader has configured the DSI host for the command mode
transfers and you are reconfiguring it for the video mode?

> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h         |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 23 ++++++++++++-----------
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 11 deletions(-)

> 
> +	/* Keep DSI host in command mode (VID_MODE_EN = 0) during panel init
> +	 * to allow clean DCS communication without premature video engine startup.
>  	 */
> +	dsi_op_mode_config(msm_host, false, true);

This sounds plausible, but I'd like to check it out.

> +
>  	msm_host->enabled = true;
>  	return 0;
>  }
>  

-- 
With best wishes
Dmitry
