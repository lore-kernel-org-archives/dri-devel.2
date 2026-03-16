Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B52F53D9A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4D010E3B5;
	Mon, 16 Mar 2026 20:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hvc3m18f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h7eeXa+D";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB2C10E367
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:56:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GF2bUH1533916
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xXH4KTGm9N1/4icJ/ulRPZ2l9E6SCinN+yvg/kMT4Xw=; b=Hvc3m18fpCHkQzD7
 M6U+MdbUsXg3NwhK7sfrx/LfURxLx8JZHHGxfJ0PVnMu2dDR9qzm/ciJCejHHHJe
 cadfPUtogQUh/rzDu2zU3M74twM/YfxLoQf06YOBkfTT0cN+w3TX3QwOIb5bhIkD
 Tk6/cWd+GE83EiCH2iNCHmxbkVwPgNATYe4gi/1mPCoei2noj15bovGmLM9LuCh5
 nAEBduXY3zi3yZJyP3Y0L3sXky4mEJYxSYCzs/2C/N+lCQ70NvDqrk4xWac7at7d
 dYsLWdIrjTf7eg6a/56+0ocO+9STrFlggUgGkvwBa8ufDdY4L9PVK8x4SftMZDh+
 mF8QXQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k15s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:56:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b064884a7cso9390345ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773694559; x=1774299359;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xXH4KTGm9N1/4icJ/ulRPZ2l9E6SCinN+yvg/kMT4Xw=;
 b=h7eeXa+DsLmQZ8Trt6yNn8mUWU5zv3sg5rIWA4t5BFjmorTt/PPWGHcW8CR+KYCG9T
 spMxdiQvQfWBBIbi9kIxLTI/5fuLI0WbXd+JF7TuWGHQthgDQD6M4nOVy4ay/uH2hv+0
 7X8wVeBo0E5DeKZNjSXFNoX9GLSBtzVqydPWhLIFz7jHLxXKeG+KQyUofVSFT48qaKOw
 pmGCCn/CcZLISVtvzqYNuIVJWO74EgpTHUUm/HtRqHXTkyRD1dK903Xo9wJ56xnf/HnQ
 LW9IDU/JWYckcdwfX4HjM54VlRC5pLA7wRRntMMAA26X2ww3IGdZg0FjeAyfSc5WcbnA
 /R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773694559; x=1774299359;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXH4KTGm9N1/4icJ/ulRPZ2l9E6SCinN+yvg/kMT4Xw=;
 b=rNsH7SZpplp3ZU/G8JkjeWaJNtux5t5WPjgJdYRE4jsr1oRh7vbjyk1K1hbbK4sNRR
 Eda/EZ9pDY1PHYJNMVT22qq0e/VMOT1RheUoP+aMO9DA6DNTTVbcpiCvK/6bvJGm5CPn
 YdewlAUTXp561nNReTxbnmlHOZxzrI2WuYoZSGWOP9i6Qj36drBYfao0tslpU/jwt7+5
 4zfbStmaEw5fdezqDZdqXy6VUoVlbkExxwKue+AorjWEoL/8GV5B6RNVufzruPeGvqmw
 nGb3uLJK25Vul/Z2l8Zu1kQ4aGUo/p7sD4ZZ71JSl2E0As8MATGatBCDRjzKvV2paOHx
 3VEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdVgxfpKjhNfO9PE1XzUEJeiCTlEmTSIod72PikaSKVgyye/BMEGuTeTDiFtiuWVmGLggykzkcWjg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxig08MUlzHDDbo21ES4YLPskBCPQpg1+aiQyRIX88Vc8O6feFS
 0YynSDlV+XRsPW87qlgYeVok+A6ionoJpKhf/hlAmzvQ39wZhrZ37ZManA3L6FvtNN2W/wB1/og
 X2/hQgpAJJvc5lWkYgdwlLJXNZEPkCPp9nAnIg4Bfmk3Y+yoKImdl5KS5NLWipgn970l/wF8=
X-Gm-Gg: ATEYQzzaAbOBi305O48vsCTxVCB5yOFwd95NrL9VPBxH5mh+L8XOByLe4YE+Lg76EHZ
 s+6VHk3BjLDDafVkXOnWym5dhZJJIRtyvuHoqulXydJGiuPeG6V+qGLzfkYIQvhU1GyFzz8S0WT
 dqc6IadGeah4QDdyPO4GR1Ek9+58ePnIZOwUmEVkGNZ8ymTS7FoVn0b7Xu/oRTa8BI6a5mRsrGR
 lmf/aSDS4NuHdSevuJgJCT+rIyCboYyAEFH2uYZzxNu5MgZRJ962FFOyo22hN4h59Q52NWY90aO
 Kl5U8Ej3mhcz9QF2AGVC2ZEGQHTaLjzpzijkYcFfeUGigarOFJ7BPZ9toZRjH+gfpSEBgwVkGdO
 mkYTyaWJzKOfea08pqLs/khY4/z3BieDbVxoDkvBnW6IpQmOurSEqmv2mTDFNwvjrIRFyjauEZR
 vSDUX3
X-Received: by 2002:a17:902:f547:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b062dd3cf0mr12638265ad.17.1773694559382; 
 Mon, 16 Mar 2026 13:55:59 -0700 (PDT)
X-Received: by 2002:a17:902:f547:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b062dd3cf0mr12638105ad.17.1773694558954; 
 Mon, 16 Mar 2026 13:55:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c27:17c8:7897:b4f6:fc6e:b55?
 ([2401:4900:1c27:17c8:7897:b4f6:fc6e:b55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee9f2sm120239795ad.56.2026.03.16.13.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 13:55:58 -0700 (PDT)
Message-ID: <2b416eb0-ec84-425b-a845-3995fb2fda4b@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 02:25:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/msm/adreno: Update GPU name format
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
References: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b86e60 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=cqCk_WuF3EJCmBEnIEcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE3MCBTYWx0ZWRfX77+YAeS/QHsW
 2GkMzPd1C8k8/0nRnRwDzIp4TDhURw0wW0ZA9IiAO1mh9dJik8peM3HrFvTSQ/U1whJ3EZXcN9X
 hvYZO1KajdTiXlVISXORpypOik2NCV/jg3ahDfVl9qN/rke9cPfXbNgC7PIb20GF2hKS7YlqyDp
 CA2EArp2Ri0gEFtMqU3IP7WV5qK58jqgYlR7hCHnkuSQFdOVK/i3upJgY89iw6EdyNhow79D/WZ
 USREmOvJ5xtpwmhwR0dtbQkzhz7jWcEh+etKEGlPZX+Ds9scTQVDJtuZOdsbBtD40U53Bdg+Mmh
 ngEZLx4JP1Nvmvy/+x3mSz2NdyktBUY6pFXp6QHmJhNzPHhZsu+jj7t1Yyt+xZ7f2FB9DvohRTm
 oOIsrKuo9Yvp+W1SrAAV0c8cs3KflpOrInu/aQMuT53EiXdsqqikhquotwq6F86YVZOcwYRKW8e
 dlgsIzXvpDAmkPCE2QA==
X-Proofpoint-GUID: WGgiQYiJg1w5rvLnM3_9K_NQJbp5C_RH
X-Proofpoint-ORIG-GUID: WGgiQYiJg1w5rvLnM3_9K_NQJbp5C_RH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160170
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

On 3/17/2026 12:04 AM, Rob Clark wrote:
> The "ipv4 style" of formatting the chip_id is less useful after a740
> with the new chip_id format.  Rather than doing dec->hex conversion in
> my head, just switch to using %08x, which is still easy enough to read
> for the old scheme.
> 
> Also, for a8xx update the name after patching in the slice-count.
> 
> This series only changes things for kernel dmesg.
> 
> Rob Clark (2):
>   drm/msm/adreno: Change chip_id format
>   drm/msm/a8xx: Update GPU name with slice_mask
> 
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 10 ++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  8 ++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.
