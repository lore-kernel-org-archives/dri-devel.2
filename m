Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C6CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FB810E562;
	Mon, 12 Oct 2026 12:48:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1B110F0B3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:48:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0bmt2679927
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=47vqK7Iv9Xuep7A6C/o1Hemt
 gJkLnTAUGBL9UovdPBg=; b=c1SpKsnFABlG0oAUswbhng32HHGQaOPi3tQ7ktDu
 V5WiKbfuFdchJ6e7rBuZvdNNGkQPPQKCIkgxdJhtxzOJoCC/jA6nfTyI5kT/C842
 gC75AimibBYPtQ/L0SYvdTgwAWBEAjOeeqvrHlEHUD3fii6/89GHrlHHj2Mj1hgK
 qmYzRj0Ks2DFd34WYKZ4nDRvpLxjd5lm9cDshTqGHaDtCi+damY3HhYITrPjUduf
 QT/jl+bqpGHP25gFeRJ98A0MsQ0dKtRZTXJrDcVpy0rckjVoTuClNmk7l+mMrNzs
 GK+2t6XmhAqT7WGJOL9oRnyPsRQHj2TwstivL8mE5mNbzg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1syqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:48:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a7fffbe0so46346536d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791809311; x=1792414111;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=47vqK7Iv9Xuep7A6C/o1HemtgJkLnTAUGBL9UovdPBg=;
 b=Xo6qmu+TjEcsQ42NoqO1wVaRYYQkRZwBSawajGJKfNPFFRGWdenIpg96+oFdugNqzL
 LErYE45crIpmg9cCcxagfArpj8xaF2vASEfND9dUaNButT2vcrCuG/mrSFGauYdqjsAd
 WUsz8BZjt+57rjDrNex9AWTM7xL5O7VqldTVMtkqALRSeNjtcm7PMuDmbNKjS8nw+dbm
 2sUQTNS8T7ZXxqhdxeI4DqFuSMm4WusMgvcunQr+UYFqbAycyIBpj8s/3BbUpR4HpwZG
 w8gx9dFS9rGf+bGHV+qzuglUBPaHrgTEr+Th4RLD0ic60A9juSoY51Vi396AfMnZtlXs
 B62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791809311; x=1792414111;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=47vqK7Iv9Xuep7A6C/o1HemtgJkLnTAUGBL9UovdPBg=;
 b=w0+ACX+rNcBNxqU8/VHDnykK3TDWrerlIsKIiGmQEujmgXDDFCTgoyOdS+3Zz9GZCv
 k+XtZBfA2VX38ZFInuSdH4tI3imQklj5LdQReUwSoF3B7C/hNzLWizOb8dlFxhy+7HU7
 6jeCSvqTdysCbooRhHGKo0eX7kJc7xtWd6g/X4rCLJlKJayVk7JRtgOWlOGFAWPIgRRL
 YBo9F1s/mfeNxZxtQTDrIuYfArS2jfg9ShWGJ9+ReNolxzJm2Cc7ncJvOw0zNlZgHmBu
 K64fqUhahP+YQoePvXgiDkI/aM5N5HKiJsb+57cXuQfiBo8Wi0WhersoFG9qO1NN6B0c
 yFSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzg5OBTGW8FcKE1n6dvbCjLn614iRAcRvm1M9HUj7pHKpcRcBTqhnzDLAlUvJhNOfYY11u2BrLgD28=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKpeJeGLaJ88+l1c9iVVTnBUDPEliqEd0v3oc0MluItP/l6EpX9
 qY5mHF14zCrjvfqZJpm4nawDBh9PUsnnCDahH2aKK+4ridz911pDtSt33f0NM6IbNrbImU9/hX2
 duw6VvsvcrkRq/wJoXfMTa9+7K3hSFC3RAbXADcwwJuQkRijDVRxiNI0YLaMbCV8Qf0CunPc=
X-Gm-Gg: AYBFou24WqG3ev7ZbFxvzst3v/3Lk8YzCaLXkNjp0BivJetcsiSgxlOkglzWUJOp5Wy
 sfFPHsB1kw5samDhdyt7jirf7cOfMYTDvs4QY/uXw0O99xneAlGpBzC6j6Wlzjdu3RXzznYClvq
 TQw4VCBOH6/fG1o8KpHGdj/pZHQ/GH9GcWdQDwEZIeQXu/aNaG+/AGKcc8D4i1Jji+o57rNXkD/
 H1yquGL5k6hoim5rhz3fB81SakcD0eyJGLMTQrZVTAL3Dq4qP+1g/om4P+TPhaq/OeXbQGkyFfF
 o65WnFm+pgzDAOp2RTBixn6wSs6XsvRWx0CScRcjInDU5NJ1RfvzL9+SF56PJRENuC8uTbhAMJk
 /HxzaJQ0jY9Id7IabQWa8ED5kCvHpkZLtj1xN+D4ySHVJp3vKgL07uPwSJ1Brl0FAA1QONdsvc4
 Fzw63Xp5dk68Jw
X-Received: by 2002:a05:620a:7118:b0:93e:9cc1:7b95 with SMTP id
 af79cd13be357-93ebd24265bmr1568716385a.58.1791809311357; 
 Mon, 12 Oct 2026 05:48:31 -0700 (PDT)
X-Received: by 2002:a05:620a:7118:b0:93e:9cc1:7b95 with SMTP id
 af79cd13be357-93ebd24265bmr1568711685a.58.1791809310825; 
 Mon, 12 Oct 2026 05:48:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde912a7sm2753995e87.18.2026.10.12.05.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:48:29 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:48:27 +0300
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
Subject: Re: [PATCH v2 07/20] drm/msm/dp: Serialize stream operations with
 HPD processing
Message-ID: <wk4gnn4pq4jkm7rwxle4ivleqj5eb5jpllfkjep4x3kacbadim@5bsg6g33e3es>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-7-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-7-1835d4966da3@radxa.com>
X-Proofpoint-ORIG-GUID: l4y15yoSucNMiO11k536_FYy0ibck6Em
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX1o1wjzsl3w/I
 +sKE5tQ+6RTb2sH+j3iJs55KKVcpNR29kH697NFm+vxNJbHFvtjh9GZOvzQME/I9wfxGYSDM+oh
 tAjVAJ6yMEcVk7avakzEdfWFSb8Bz5A=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6accd71f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=ksxQWNrZAAAA:8
 a=gPIhC6YDpAGJdL8mzGgA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: l4y15yoSucNMiO11k536_FYy0ibck6Em
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX3yjh1lYIaAD0
 rVkZojVwJ+6PvtbwhosKd9ZztHmRhkh2LJzcWrOrCq3JXKFHSib4bRBsA1oBxiSZp+kxGl6VmAK
 DbQxUZoAnVMuk1GmTlIcE08O0xl47vFqSetZGVBaUGQeJY3odlJHUT4C5MD4cvzc3FEpxnTLp6R
 Lyd7BF5yq79NkRyTLSa8MtGs50lj6QnKGGAbmQxofsV6JozxtCx/rdDQvQK5sHF2mDLNFr3gE9S
 6TnXLoeb/4+68sCIOY/8PJrP4Q6k1/rLE9PSu4LXDW/4EWwZ80ILPvBoknxEuTgwHZpcKNru5NE
 KiSfkVKPClmW+Wet+3TE1W8R2lAwATbPOAHnJLT9QbssXBN8MieY3Dk2qs4XtVpHxecqtWzAgqd
 3HSj4O7LcUqShUZADvLduWRZFyHb+feK3tCdQbk7ct2n0bRWflqwI+fYUVM9GmWakB/alo8QUNY
 83emzaY3bKHrvXMjP9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120050
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

On Fri, Oct 09, 2026 at 11:15:59AM +0800, Xilin Wu wrote:
> HPD PHY test requests stop and restart the mainlink under plugged_lock,

What is HPD PHY test?

> but atomic stream enable and disable do not take that lock. Both paths
> can check a resource flag before either updates it and acquire duplicate

Which flag?

> clock or PHY references. They can also reset a link while the other path
> is training it or enabling video.
> 
> Hold plugged_lock across link preparation, stream enable and post-enable,
> and protect stream disable and PSR transitions with the same lock. Add
> lock assertions to the internal stream helpers. Acquire the runtime PM
> reference and handle the eDP plug event before entering the critical
> section, and leave audio shutdown waits and runtime PM release outside.
> 
> This provides the serialization required by PHY ownership tracking and
> the subsequent stream enable rollback paths.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 

-- 
With best wishes
Dmitry
