Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3CCF483DD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF5C10E142;
	Mon, 23 Mar 2026 17:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iY34ygo8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/A/ctwy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC6D10E164
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:42:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NFGjYY2490390
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Pq+HuNQwTqCN+5rhLbtTlQld
 tHfnqWRK8RkRZUljdc0=; b=iY34ygo8EkOxlNegdFpGheXXNyS9VmXO4q7MTT5k
 00T02AQyevCOW5SYbIK1UtjY0qdxcNlbEQRQvK0HDsIIZHYVYFCd8hOva7pjJQR5
 kCvncTQqHoBO6zEgz61zJim1GgX2mH1Y98g3aANB6PYDinc50Gk5s4bzz5Cb9vd5
 W2J5MQ1862ekHkPNqiMvOoJ2s/KJqXUFa6E6txNKVyBaO6AFmww8qy6WL6/ongYf
 hzoxtDShycMAtrjoz/MWRhNFUXwbUYIr5YktgQbrPbgRRvrMHAUsL9dP1iwkyn+u
 bxFLf+xVg0A4/aS9ycs373gtrwcAbtqKm/kdAzgHyNjUWg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d364js13n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:42:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899edf0171bso20389776d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774287756; x=1774892556;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pq+HuNQwTqCN+5rhLbtTlQldtHfnqWRK8RkRZUljdc0=;
 b=V/A/ctwy8fbFkXZAyEtfjtdIpPdn9M5ywBxM4CE2myUBOsLREHSJJ4sqY8QF1fuLW/
 ehwozkXp4SvL/9YKtSzZSUzfrlUdkwJKeEOJgzrMAnNh+gQm/BR+KOz7ZoXAkO30tfyg
 Tqiga9MI2gX55lfvWEhDOb4SqSTR26iJFgKqstbjleLlWNXeIjIHicvhr7oM/lXQb1Ze
 EHwFOQEe23FnG8SbbAKeEjg4HTBFjNGfxT0XXeIxCRT/Y7+6R3Ly1C6fe5r6mtoCpUnF
 ffQzUV0Zbxhntz+ZT/ouaqjTasZSplvPxMhXZy70b/i7tXAsPdL6ej3GDAKy+aiNZ7Ys
 ZlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774287756; x=1774892556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq+HuNQwTqCN+5rhLbtTlQldtHfnqWRK8RkRZUljdc0=;
 b=c36oGj1UjwNjf1EpbgTJsrOSLNiAZSaC36mNG87/op/bnaJfhhflY10QSiPq0O3lhb
 kMp65I7lhwAyMf+DloY/Xv8WLtJ4yEa9vJ+XJJuFJymoChM/u8G6t7W9ApyUhDC/aOiz
 4u1HO7pFXuKVQ4QP3KnJ/3I/k7tVZaEUrAtv++IWpwr+gNmml/IX+zmdMVm69CZdO0Fb
 aFIUx6KU4s0r4rw1JDp84jciFVURSO53ZGZmbP8j9bT57tUBke6S6MIdlkH4mEmb8AuM
 yTcZ+C3SPHnNxMTZwqH8io2QPwMzgAjC/MOdQdePdG51jy+xO2ICAXnAu4+eY0A8WTcj
 R0lg==
X-Gm-Message-State: AOJu0YyRU0JnZeaiKvuqwjNZJ+iM7O1UDZi0uZYcfd+H05G49RzYL0Bw
 jOkDDEhJVIB8Ng4dBPE/aj3yDnzwWgmOGhabyNqs00tUnBUAAplIEg4Isy8kvVPfE6YeO7Fq+Ty
 8VOpOeYyh1BvS3bjX6U2cWUH2fRUB6Gloe0gLkDZiXbaVcJvRD8cVlsH8mQnaExOA7ALKc2c=
X-Gm-Gg: ATEYQzyUaE26rgzmdZ/UsVKdzBrc0J2AGEmmfHL91a1CCy7RusNqGau5MJfnXV7cRww
 ga+74F5djljB4RXcD7mxNGfFQicV9GVmucS0IBvIdssHwIYfJNKyOP7H/BxBsHX9mxshjvwZEgl
 RqDotup705gHVENJ1AA+mpO3/Rqu2DzC7kwXYoLZqVLN4OR2N30Q7dRZEMTlPmgs6dRIJXJf9T5
 ZL4b+Hy7eUH/M0lCiJyTqxbkAktTCTkNe5WItmKwWJazFqZ4rTqno+uP2rn6/99VK3+oDsRtmgP
 PllRvLaUlVlpQCGOwgu+MfeysNEtj0+YLBQFfZdjv+O/PoLtqtdsvtuYKq+O1o1JAPtfuWJJfMW
 ReFYaMas3yHvWHHNj4xjyequdnuyT5uoS86RfAk5FDOVj5KM+lI86rOvBB+knoRwf3cJXJ9Jao9
 Pe7zvTSHHd+fU6ebKDknuNG+B1Fuk5/fFh01M=
X-Received: by 2002:a05:622a:1a91:b0:50b:551d:ca7a with SMTP id
 d75a77b69052e-50b551def56mr94757521cf.52.1774287756480; 
 Mon, 23 Mar 2026 10:42:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1a91:b0:50b:551d:ca7a with SMTP id
 d75a77b69052e-50b551def56mr94756921cf.52.1774287755909; 
 Mon, 23 Mar 2026 10:42:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28519f93fsm2715435e87.21.2026.03.23.10.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 10:42:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 19:42:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/a6xx: Add missing aperture_lock init
Message-ID: <wzmg7blv4xuvdiewbnupiswualoqo37yq2qekbfj45wuek6a7a@s37pe4q2sbis>
References: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-GUID: Gm_o3ARZmAAMJj0Blc_jgnqbuFoyI1TJ
X-Proofpoint-ORIG-GUID: Gm_o3ARZmAAMJj0Blc_jgnqbuFoyI1TJ
X-Authority-Analysis: v=2.4 cv=JcaxbEKV c=1 sm=1 tr=0 ts=69c17b8d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=-2mmMjQWwNZ6YRhNbUMA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzMCBTYWx0ZWRfXwaR1C00ag5lf
 x5onh8LOkHnyJ0/qx0Vm00QqSyq2mw0b+614zXbna+KKNIJcFEAXVhA8om4RlzpRxFVCdbMfO/d
 lcITxazJsIw70mEmN6W9/9CcMh2EChrpcbGjtotDtKSMPTzRZAFy8NLXCJpNalLMk+QFDf8MVd2
 WN6eDatvFGYrQ7Mx104LYCDC7iCe3+T51Qmzjn/Nvz3qRs7eR1t9ufDgU6bk6XXvDHCZReaYmn/
 SyMnsmi/oOemLjIgYiD0Kh468Q2bu4VZ1KBvb+Q0jPb+jfCaKtdpZMq1BRUdtn95FvCn072XJkl
 sfrViMkj1TTA0Fyujvit86NEHpBTcxPn267i19QvcaA/R2h1jsxB2/stk0UsV9tjSSn8wrsXlvN
 bDzFle+A85pz1hugUwwcVMWOlpElCT1jvzm0Z7/SgXBJUlBkt9xJyzsbugtalbkP12ffi86vf2W
 wc+5RehXi0khlO5kVAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230130
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

On Mon, Mar 23, 2026 at 09:16:02AM -0700, Rob Clark wrote:
> Looks like this was somehow missed when introducing gen8 support.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
