Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65026CA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B261010F601;
	Thu,  1 Oct 2026 10:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aA5UQrzl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YjSF7WG0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26E110F60E
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:27:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xMBp1932322
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LGpC/EhxnEGpBcoNZ1aQac6B
 F248lrL0gT0U/t6mP1o=; b=aA5UQrzlLnoThkJhlyAMOr2bKa4Rm5K5KhoElpQM
 Xe/ATA06pFATQKQZSTHfQ1uIpU+8Y0JPAirK4ObY5jERCFoh4gVFarcsNMXgCC7I
 eLCs1Nc62gtxYKIYbftuJ8sZyyN0D/zOSrxQuuI+4UztlPvAyrS/L2omqGY/E9pU
 PNBvFfQZWwPgdFF04Bi6MkjBDcVKv6nM3VCyhcsjJKe/M7M/OvMt9kEnyI7dRb87
 u+0RkOk0KW6oXEezcChrYoZhztxYV4DC+o+halPYYxz82erLNeLJ0rXj5uacwz9o
 lI7ymwrSqF7pZQ58DWZpxXx4Y49zxo9Ng4fJRqO76HkHvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5aeb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:27:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc40759b2so11065085a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790850420; x=1791455220;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LGpC/EhxnEGpBcoNZ1aQac6BF248lrL0gT0U/t6mP1o=;
 b=YjSF7WG0z32vpYt0/kyzvmiJ0e6fRbH/1gTrxxG8D14teI4CPTZTJZOyrp4rqEFpjX
 vEzFBA4eKo6m8KycPbEpb6EIiUchcRJREbV5uFIoUsBIAPD6SiV5ZCmjQiS8+K8gz8zG
 +bW95dn+ZMm0kIP6EoFLbd4mJezg7a46ZY0xJm3/dhjb8P5W1nUS2HdJXDDN4Kj3IcRa
 iUDhSAQVsu/QvRIy4BiU7VaRnUB/dvaKmeCy44LN42k67/iK1L/T/DbORWbCceYl9TIU
 4G+60pH5VgIpHKXmK35p5krK/nUbeRp0WmHugSarRT/9OzGa696S+N7YPu7qc4O94p+o
 KMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850420; x=1791455220;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LGpC/EhxnEGpBcoNZ1aQac6BF248lrL0gT0U/t6mP1o=;
 b=gBfD3XS9/AtZi3pgZcHiSWJboqbYPCDRpcV95JNX6+PyQ0K+fj7iTYVmm9oUe3zwG9
 sKYgqcN6DhmrRxse9RhLKjAfzcShobM1mYPw0EO9hV0mQ1QdR80Ifrjd/WErLv0cxqru
 klnZukFvwARQz1AzqRWJnOEhJRSCrPkT4S+jqJcy0oRgzxAbZmmIls1Y7paMLihwmA+k
 fp3NqLOTsi44gurg9Fdo42eG5xT6csP1trM8Ku0NnbUfYVbOILcHLAZNq4138vQdMUr6
 zkIxWkHRoW0pgH8aC3Z8a3VLtLSxNIWxdW/31DvPs5WZmAnftMndcLT1SUQmzahPhyjm
 hKRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgihAe13oq9kwDDDradgYOEQfFPD1ZQalW0kG4RqcjxR/8cwFKeWxAFXGIeEATlRyhmnd/69kiqqI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lB1QL35mOoF0nxr1OwR2KI7OcGs6pS+VjLQKDYHHOVXZybyYDo
 ROtYYhg4pdBnho+mz/LD9YRc2p3+ztPnREpdFTn6bfENjd6Hmc8zJqZaug6043WPGkP9HciJvjj
 S7OadOKIFXccQPInyIdBQ2msZk/5gTUwlpQyJvmGvTBWjE8EDLGNkhqu79J0OouTXX/HLFQw=
X-Gm-Gg: AYBFou2SE3nJ0WHRDCjKza7HC2EODuBsdfHRFI8Wl5ciHWnZM00bui8u9qgNO37Enmp
 8bQL52lt9mUQc6IiVY4a8zEK4XUV7v1BDZXUXC3QeLLimNq5X72im/gXvpNwzsqeuJL43wz06sK
 1vimCJcxsvvlvmd8iPzqCfmgDvIFV9BUEpqEvMvBhjtfuNsvanqrSozIChEeTXztxXIJXcjkeXb
 JfKJqn2yS7vrWghP1PdLS1SL44a/xN2IVbLaVvab1mx/jkm5KMPZbhONDuTahkJvdUJX4KSUDFV
 zUDdImeYtBPefggh45aRMF8gdec8QqX9zxXWQWGxwBRjuNygv5E9C+f0WCR/hpmTs4ZjZyB2lb+
 CIsZriTQaXcWSaTMKUh2KrKh4aVy++aGRSTi0JYfhnAXA2dJzUbsjVem59BY7ba3gwXZvP2qPrc
 nUNZuJOZJmw9BT
X-Received: by 2002:a05:620a:6c85:b0:939:e93d:a66e with SMTP id
 af79cd13be357-93ca96f4d85mr760538485a.42.1790850416187; 
 Thu, 01 Oct 2026 03:26:56 -0700 (PDT)
X-Received: by 2002:a05:620a:6c85:b0:939:e93d:a66e with SMTP id
 af79cd13be357-93ca96f4d85mr760514885a.42.1790850412679; 
 Thu, 01 Oct 2026 03:26:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a7717f1983sm15528721fa.16.2026.10.01.03.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:26:51 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:26:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/35] drm/msm/dp: add MST stream register definitions
Message-ID: <kum6ib5bbkx3whaxlhhcuoswwctyi4vj2ya56dastd46jj4cyd@hh5ygaikys7q>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-6-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-6-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-GUID: eR-I8yC73nGP7q92Jd_bPqNevHIHbksI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfXwBqzcUt5lt0R
 ytXYOi12jK0JaCOqGWTP3bQB/A17bnnETRb5pl6Odml99YcqSKWfdlQjyVRnpPi7ikKRDUlI5yM
 4667xgAFWWOZFJfAQ2Nn537MA8pmhiw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfXxM7AorQgBkVx
 1Iv+RFPT0big1q1sl9YbC+32H26B/DZtFNfxM+REnczzcTfk2jVRZzwNTHpfi9rsbA4wjwCLbLW
 T6SrpwcCCnJnrWx60MdJeKjb2ObMQsuK4oWCXDZ4etvv6VaTI5HsSSS59wJ/cv37CI8zOb+2sAz
 L2Ok2Un3hNfJ5mEFSiVLXGH40WjxFr1gdyxi/0W7G3eAC6C+jcp0vWXceGaZJMdajFarBanTdnf
 YtYrkzFOn3v4PjOroMl0aDtDrlcxdKCx5fJ0yRmpP+W39dySb7FTvO9WuLKzboK9Rrrxfx4RWK1
 F7xPqYOj65kjn8H5j5U49B7wL221ptVQ01y5F8CE9C6jktzMvlg/RyEyXYHNmmkTH3/402BmG/q
 VZQg/KmfHqBOZDNTDF7ONJNlDeFouSXRLOmX2D+QT5SKcR9txcXLbPfKua72wDG3ywXoO4k+EXA
 /1gMOv2YBQf0dUi0rDQ==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe3575 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=xXsHHcRzK17jFORm5UcA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: eR-I8yC73nGP7q92Jd_bPqNevHIHbksI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010041
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

On Tue, Sep 29, 2026 at 12:25:30PM +0800, Yongxing Mou wrote:
> Add the stream-1 (DP1) and MST-link register definitions together with
> msm_dp_stream_reg(), a helper that translates stream-0 register offsets
> into their stream-specific equivalents.
> 
> Keeping the register definitions and translation helper together ensures
> that all supported mappings are defined in one place.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 65 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
>  drivers/gpu/drm/msm/dp/dp_reg.h   | 56 +++++++++++++++++++++++++++++++++
>  3 files changed, 123 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
