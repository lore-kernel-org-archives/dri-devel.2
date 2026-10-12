Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD0CCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99B510E5BC;
	Mon, 12 Oct 2026 14:36:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C5510F16C
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:36:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC07Om1933164
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J9HMb+rbLJfcyQVlt0skqJmt
 qpokfqdjdof9s+dJvi8=; b=INGTTlaKgMcesmWieZ5+nkXVfzKBctT08I2hS1+2
 lrAfjshdJKeBapa44nzbbOQK+iIA7HCBxWG7HeVGPhMG+S+CtJ8BpiJOkiw7J/xR
 Cnbnnk0ynBhXsCo5nHSZO5sICr/dOsKCaQPOorI1LmIlykwa1bu/tDI86QxYUMee
 oTjT3N3DvWCHn5LGjoIzrAplCoX9cbFVQrCJzaxvlTF0pj7fLcEGEejbA1fIw0YU
 TrRYsefKmZ/aIhja8bFTxb4EfWGarC7VB4kSdBASJDKCMOP0uACKfeDTRgv0fSvU
 cS+uBNPtjRUiBW2aF8vjernE9mvzGV6Sut95H4MkvAu6VQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkjnsj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:36:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so369389185a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791815800; x=1792420600;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J9HMb+rbLJfcyQVlt0skqJmtqpokfqdjdof9s+dJvi8=;
 b=Q9N1gBUz+gU68jlFHqdtW5TsZHjhqoAYCMVzuxXajayMnRN/Ye1bv9xdybLmsWbRPI
 RNvRHw1H3tVuEZf6JuuhvSX4otujUMhg3mLgAJ39s1IFPG8GSjg4X0FD0g0Uwi519ozf
 8Ev4WY/Ldl6MgP83fl3oN/4QtxS9TjbdVIcH062aIvQvVPjWQh2qwUGWlWO03hJ2gaer
 MJ9n54FexlfkE4jljOTbZa0BHqgnt2hJaZr6iYpaOK8ywROiC8r0uVk2680/z1WvNAX0
 zjPipAKnqQ5qUCFVciZyGCgtzJFN5p0J0tS8e7EgtYdTPJITShQ7dJTJl1S2LQqvmRwE
 OmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791815800; x=1792420600;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9HMb+rbLJfcyQVlt0skqJmtqpokfqdjdof9s+dJvi8=;
 b=QdW3QUBz2UMG5f72gTApct+P+IGowXiK+Zi0a5bjisYHIiYdx442TV2NEq6TEm5fKV
 8O+iG/cgG5PpenzrB1Uo/mxx09Q5AvRnzYbSY/iW0PlNom19kQ/rO9mmJ/CPgWtbtOR7
 YvL6zoqf9eFNUNPUaZDDgPCcTgX/IGoOuE6nG9ksIgOOwTuvFfkH0/DNxLu3ifc0neTP
 k5Xv9hgT8K5Kqft1+Kd4oVp7Bmldl34XQ04k2UT/6j13jZvzrk6fxDI88gDz65bcDYzf
 prncWW3FePp7Ii5xuGK7O55VixtoU2YxVcYMpeZUjW0GXj/UG0PMOfCl5/BseZ8XJQ4T
 mSqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKFeTdzNXdfV6+Ms2Ip7oZ0K4JY6ruXCai2DOGo2C0EP7TCmXKpUMJD6iP2mIgRstJjXmoZ4x8ygQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIMORi/G9mPzbskvkkLxxC9zMBQdwY3Bnl9zG+go+b+lgR2HL/i
 Lgw/1LlMQ8KbM01h8jglH3ATC+cV8V9wzpRjhUzDQ3flbKxal8ba5iI1tH7DaciXZVmKk9DyGKc
 uk29H48XiXpm8/N61vL0pljNjUUX0GsHCi4cm8W98SsVl2FEEyCVqq37Y1SAAdJ8d+b7VhUQ=
X-Gm-Gg: AYBFou2DYykiNixl05aA441S77XwcW6soHYJWDk2pQ3gmFZ2gQ7z2RSwZpBxfkapZYs
 VqR5wEN25ncxvTyrees6GqUX9qM5onlmCNdMkJ1ceSMjp5rqp1WXP7uH1KaBjx6VmKyGG3NeMfW
 CAyvNNiSq2tD7UV16j0YZ+QFG2gpM9RtjtsYB/kegJILYmGyaP3e687zXjgdCTNaLuTND3YbSiR
 KSA6QPHlpJHKUzwAxzTPHtuV+jzO1O9fs4eNrm08gHGMcnNo86cV52Pr6MlVpmEpJ2Ku72z5W8Z
 ATrkaBwb6T6jdaubA6l6nQeveUcScimre2ydLy4H24xBSlSC25+80v8DOk0ybY/5fZwGJB4oHoJ
 QKfIJtAl2Is/8s9v0GOy4T6trs0dwJA/ltuPvc5owZu4EyHmGRYAzN5W3zdNSkLVabC8NvDmztv
 BwbE0mcE3VsvpV
X-Received: by 2002:a05:620a:2b9a:b0:939:a0f3:6aef with SMTP id
 af79cd13be357-93ebd1ba6eamr1634169485a.23.1791815799536; 
 Mon, 12 Oct 2026 07:36:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9a:b0:939:a0f3:6aef with SMTP id
 af79cd13be357-93ebd1ba6eamr1634164385a.23.1791815798995; 
 Mon, 12 Oct 2026 07:36:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde36693sm2933145e87.3.2026.10.12.07.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:36:37 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:36:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 16/20] drm/msm/dp: Disable PSR for YUV420 streams
Message-ID: <oxdplbus736krf5p6ilqattox57iv5htwlof2otcgk62xgkxrh@wg2yt2iogwjr>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-16-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-16-1835d4966da3@radxa.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX+WWQEam2GQty
 LX5ci41Pmw++mYIp7F7bwcx5VMwWS4Oj/ly81+aSl5d5djlVBML3Wqn255dWAvkDvUzggN1AotC
 bvgNdzXQCrbSQ8hOGYV0ASUMSEsOOpqyxroY8WH/hGiCyV0wanJKol2mRku6lOypg+mes8kW1VP
 pOtUV/7Yefra6wHx84Fr9R7xLlQ7LXIcoqgnT7GXkJxmhse8WByaseTVaBntyQS0IgCBkRYyso8
 ixq0PeQLGXQQxv8xlKopO/EU+wK9r/Du1ApWBKsdrHXy07L1u5wsjC74h2mwYqEHbHjPp3v2JCc
 mcqUf7o9XY7NKMzdMGBKxwuP3Ymud9MDtY4P+7FYYAL2+kRm46KjBoLf2bCTi6xEgABF2bHnrfK
 j4sOyIN0pFi2Uwvv3xVTMtZqxpXJccrX9jK0CZa09wK7e+4iuYZfTA2OLCX9QqPEDo8TgfkQy84
 fROfJvf++jrrsEyq+mw==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6accf078 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=ksxQWNrZAAAA:8
 a=q6X74nQK2RvUw6JQmdMA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX7iBg6LE0cZVL
 LuLN9F07t1LWSjZQCGIMOjLTJo/2HHIJ9d2syJRfBi3ipo1NvSywKrP90EfcPzm2nWl9naO9D4x
 3Shod4fS1lqnhD3/FYFJL7mKPG9UPYA=
X-Proofpoint-ORIG-GUID: rW6Y8_pR-H8EIeH0ShkANPeKq7GGzveF
X-Proofpoint-GUID: rW6Y8_pR-H8EIeH0ShkANPeKq7GGzveF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120058
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

On Fri, Oct 09, 2026 at 11:16:08AM +0800, Xilin Wu wrote:
> YUV420 uses colorimetry VSC packets, which cannot share the automatic
> PSR packet generator. Do not advertise self-refresh eligibility for
> these streams while disabling PSR in the controller and sink.

I'd need to check if it's possible to handle both. Otherwise it looks
good.

> 
> Compute eligibility after the common atomic check and reject an
> incompatible self-refresh entry. Clear the automatic VSC generation bit
> for YUV420 and restore PSR configuration when returning to RGB.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 ++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 16 ++++++++++++----
>  4 files changed, 27 insertions(+), 13 deletions(-)
> 

-- 
With best wishes
Dmitry
