Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4703F10D14A7
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99A310E67C;
	Mon, 30 Mar 2026 11:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmruPPAx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ikiaj1ju";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E511C10E67C
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:42:56 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UAGdwT3173912
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rjoFSm6qiE7LWMLVtA5QcpAtvfw6I+fpcq6AR8NNYD0=; b=VmruPPAxM+D8ogZk
 NbOEHNIxyywAKKGN/r0PnpA52DtSrgXFs1QrfX03jrtU1cZJNPF7fg8yE/RNJfaH
 ORXqbUIGeqgT/29zMRd42JDFpJ9xL23ERXBVHlnOTip6UjnamLpm0jBFMQMYzwnR
 hbiTWpTUNRvFjZLQqoX+cY4ezFdKElvbl+aSY0UbXy+mh4AE72xKLnb4HxDbyqy1
 ZY9S2KfFzC1IHfQJCcv3bPn0pyqmaIvT/K8DUfDfilyRLIsfEDLJIwvHbdoHx7pA
 CWscTyOlyy03/HSlm8n1L1FbCYr5HKhip9ThrCqlQlaNjJWOmgCbDbN052/aEiKe
 iTY/mA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h08u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:42:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4031b86dso140096181cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774870975; x=1775475775;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rjoFSm6qiE7LWMLVtA5QcpAtvfw6I+fpcq6AR8NNYD0=;
 b=Ikiaj1juC9Lk4wt9dpHAcgxm3bbXsl1xvMG8R28tHXus9+TixDTBFBn8QTQKMOLtNM
 vHPqav7hcTw4Nb/rBW1qQ5UTDiV5FZacwASdEqfLI5YAq9hg1cl6vHptKi+dSMmoW5zL
 5nkzBGHPq1TusHfrmlUBKjjREuKHWuQvBZeifB0HOTCx0YQm4IXhSClkjY0iOu8ZnRWN
 t8TsHvpBEO0IPm4yoGocXM/q7hnKNhrPAQ+lG28jFiU9b4s646HiUZYsP873Fju1cgsw
 8RlYRXcZ3Iwkzl5VyrzzOFt6HJ3cYRjZrvW6O0ISzNQ3CYPa39fyI7mWQuwnvH37UcK7
 Tfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774870975; x=1775475775;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjoFSm6qiE7LWMLVtA5QcpAtvfw6I+fpcq6AR8NNYD0=;
 b=FRPPhyx+CarOyAROOBWUJQdfQj1dDA2dL3+TILvsf+miyQfslNlNfXApotMQ3OY0WE
 7YpUApqfRq6qVULVqAETWrFDhBMCafDy3LeUCXjJUmy7QggzeREv2MUrqCjqKP/c2I8d
 5HJBijdB3GgkzoxaJD8waWmTgbpl9cSXCi11gAVjCzKCZ3v1rWDpD4pKAsr5jXxIpsY/
 rl2Teov5nwwUiFbSwmzpX3JVROl+nEpjeJmjP4AXEvfwgIaVU0Ys5vcGC7Y7/pza+Sg7
 0sxgzHIdLt5Dc9plTjF5buBcWFDFcTnqwsLdkDH7sd3whI4W46x9Iow52RFcq8uTY/cO
 U0PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5S3jhixPzFej33c0tQ6+8Ms+PfOgoHGNG1IkM7B8vNP7x0w+lAJcqnobIAEBWB3xpWzcy9+FBh6g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygRy3NTFHel7BH8kqS06uEs8DXV2v9b44eFDorw3f3hAQiRKUM
 25R90+a/SpK0Y5/rE+VjjRvYEwtnDmOY0o/GjqBxUyu8eSkVKLNM5hJ2+88Vb6u9G352/tgQ02U
 c+AjaySs/6QRCEK2RVuRtQApc5985uahfvAgUp1f4HvHLfGdEM4a8+qynNaU0LUGWKMz4gP4sX3
 nxCVM=
X-Gm-Gg: ATEYQzw1/w+KA/7HUkqjV0aXr/6AeYUwyKPPk6NrSl4+6zUkLgPB6uryMy2xiMI1H3w
 5Cn5jYwQcbXqDZ5BU36suBdZ52Hl2aCuOGWDiukGRBypHfn+s0z5zNofSjiJFXCVC8cxT5qizO0
 hB4umLtI4sjE/RFZDCj2PPTLfN9wWRfKvgLmFtTWyNDAlTwI4BsRFNn/nNVhsiDK4Hxdn6tAEI8
 xGSplC32r812+gMbH4Io/Qpa8FGX0LJxIX+30Z3fAQcHE3RMVH8G2HAf8v6pX9qaF5ygUCQ+f3o
 KuSmHq12Lsn8olYF/7Xb3TmHlfRhBMQMEiF6/564UXv6KNOMkYa57RkRi8viXqUK2cVZzrziHwl
 wRHLB808M1CaHA7Bb8KYsOOfo4kE8VH/HhbO+8dqwOXU8jKcDRyKrKPpyE4XrCdbdH8Jh7QplpH
 3klrW07EXZEseah9i+2jB6Ct0x1JmGSUf/Mkc=
X-Received: by 2002:a05:622a:2443:b0:50b:4b81:e376 with SMTP id
 d75a77b69052e-50ba38b2183mr153351121cf.42.1774870974966; 
 Mon, 30 Mar 2026 04:42:54 -0700 (PDT)
X-Received: by 2002:a05:622a:2443:b0:50b:4b81:e376 with SMTP id
 d75a77b69052e-50ba38b2183mr153350931cf.42.1774870974466; 
 Mon, 30 Mar 2026 04:42:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c836d3f31sm16152051fa.3.2026.03.30.04.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:42:53 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:42:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 12/38] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <ns7sknmegndsf6uvih6znbwk6bpltjmbykvs6g2ma3ccd767fe@3q5rhx3zj27u>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
 <ltlmp5ytl2f7no7aqq7sl54pwd4f53fuema23xnuwu5uthhbg3@7wamwvv22nle>
 <c71ea478-ed93-4f10-aba2-023180c2ed42@oss.qualcomm.com>
 <ex5zvncmnt5pmb5j2utolgbw3yewj4x4e6nu7sdrgzm7ubasmi@2jdubbxuckwd>
 <99d6795e-1cea-4e7f-b8b6-97f55af55d8d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99d6795e-1cea-4e7f-b8b6-97f55af55d8d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5MSBTYWx0ZWRfX29QC2ixDO6y4
 +dt9JECFIb0S3MqwYvsdmCluDxN69e/ngR1R2ZCw/uExLxyeGIgO+4ilHQsKQczk2LL+3jGG8fj
 6yIrCi9Kphv2jhIWiqKP52OXXSf7/M0Z5DuC6XGTqdoW9/5UY4AQQpI1+/1++5ZpzFmlkPESfUb
 TWOZCcRWW+LsHbTSByirK5N5Np506qQCcnSTPcQp0RypcaANdVjdaUmxzFs2nyjer3+GeMNSxv7
 B83J8qgntpeywJzpRj/o8n+KMwQl1h0/GSQDyesIPbn48k7ipIQF6vszPtaKmYxBvZcae14iyyI
 Y66HuPgg7eRyCoosWgmo/oK/Jg+6WJxeNOSzD1/OBdvqgSts/PMUUQTm6M2jzwwcPQiCScDn7gG
 OVS5tWhXoDsMQ2BaPB92I6PLcWvzDUo5n9LBKDHsH0O6k1ULppl98DzA3zCezvsZ8CS8IyYfVYx
 0JJqZnxJjo3pVG4uvfg==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69ca61bf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=0iNppLCTePzBA08WBLAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bKQ4Cm7FGf_OPBtKsiMW_A1lBIf6ZWO4
X-Proofpoint-ORIG-GUID: bKQ4Cm7FGf_OPBtKsiMW_A1lBIf6ZWO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300091
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

On Mon, Mar 30, 2026 at 07:32:38PM +0800, Yongxing Mou wrote:
> 
> 
> On 3/30/2026 6:35 PM, Dmitry Baryshkov wrote:
> > On Mon, Mar 30, 2026 at 05:57:13PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 8/26/2025 1:42 AM, Dmitry Baryshkov wrote:
> > > > On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Introduce the `mst_streams` field in each DP controller descriptor to
> > > > > specify the number of supported MST streams. Most platforms support 2 or
> > > > > 4 MST streams, while platforms without MST support default to a single
> > > > > stream (`DEFAULT_STREAM_COUNT = 1`).
> > > > > 
> > > > > This change also accounts for platforms with asymmetric stream support,
> > > > > e.g., DP0 supporting 4 streams and DP1 supporting 2.
> > > > 
> > > > How?
> > > > 
> > > Each DP controller have it own msm_dp_desc ...
> > 
> > Why do you need to mention it?
> > 
> Sorry, I may have misunderstood your “How?”. Could you please clarify what
> aspect you are referring to (commit message wording vs. the actual
> implementation)?

"Yes." You mention it as if something was done explicitly to account for
those differences. And then fail to say, what / how. My assumtion is
that this comes from the commit text style (see
Documentation/process/submitting-patches.rst). Please use imperative
language rather than descriptive. It will make such questions go away.

> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

-- 
With best wishes
Dmitry
