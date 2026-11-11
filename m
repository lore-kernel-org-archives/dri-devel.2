Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D59606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tg/jxDjT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=US/98F20
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E8710E44A;
	Wed, 11 Nov 2026 18:04:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF93F10E400
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:04:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtKUU2499192
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yMzNv0aTJrSt8UYD2LUVyq/F
 8tblmivrrCSb6+nO2Ts=; b=Tg/jxDjTx75J68MDIuAo5nCo7HnZ6v19JjFiBW4d
 1q5066SF72hwrQeUo1kEL+D/Vbg36y7iYcH8lEoIYlLioWpOu43iFDFpXKOo1OVW
 DKcYeCb1gtKuzqPcB/K2dgUbUlKhawt1ASywinxrRLQkFxMYQJkYhE8gaB22ftj4
 OITHIfoXK8kD4QNlPhZvIOSGn0CP6BpMh3Zddyzam+pzwDkgQzqkZzrKBUBvEYZs
 3UwpA8UpTMFsZTd06CqAWYu91z1j+YU25Nh4RkzmUUa89yGEkySRUBrpUWKU0kkF
 HlgQKxOaufXnYbur8AZ83pwDuk/C86D9lZh6nvA3e5+RZQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawkehx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:04:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so4390870e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420273; x=1795025073;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yMzNv0aTJrSt8UYD2LUVyq/F8tblmivrrCSb6+nO2Ts=;
 b=US/98F20GMgLnE/b+AYiAYs6xhcC7CO3++glEtDINyAlCoR9nSRxB4h5qWNI/zXzbu
 rjkZkUal1DPtwru0MiKLh0GctQ3vXtA3gEkZATG9y7n/d9toFeLs0i91bTvSxMjsPTi+
 OLWa0T5Es7lLIh+NTrCyORWRJwvR20O2PIl3mQxXmpCOhFVT10o8qgDtHo7tZiB2gnBW
 s3MtL4yLR5e7aBhq72ITUgHctbIh4VK6j4/CiN2yoiptbGpXCL0kSkEEH6boYOKJaf9F
 CnThpBFtHYFWQhf8UU4h0gQSrmewcAJNcVkwktrvs+CqGY5vOAmHeNKFB4kGIb/zOug6
 TOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420273; x=1795025073;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yMzNv0aTJrSt8UYD2LUVyq/F8tblmivrrCSb6+nO2Ts=;
 b=0t9jQCOYm6kD4lQAxyI9Np8eYfi/sPDT/h2vNzBQYmMDl3BzfA2eFkUTafx0uifu+K
 qK0/fw20LfG0nFTP3HN3I+kf596/cWFEDkH06Eipk7jJs90oriMZlKfOkjCh9FuUTQSG
 SsAN836YsEVXmwyGPJcA3VWwW5O6h/TVXEBwHYC5fvNGrM6eIgSGzx0nyqmX+RoHiNnj
 oRiCjgqfVHtc0x24gb/Twvc+1qs8mJ/+8E0BvALS2F+iaFKNlKeIHyJb24rDpNEY7x0R
 MvjjzTXK+WibI+Zva4GXErPnmDwASSPIcTYXF7solpC/OGSP9+UkmzpUCg/MaG1sax+5
 aIgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF0ek4IKCl6IC520nRtHooojYi/lMrqmr1ml6Q6R4ipyPHPBIcs2+nViTWNzZDo00TPSYwaYMZUDaQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8E827KwatERdnn+6AFIPl3L9H3V7Rys0lhgpqEqiKbzP5URFxG
 a7WvjoAQiv+6/8KLctIX4Q9pHZRJ3lEb9wxW8BzZvksim7YISOVvih3b29F7Ou4eWa3fjKoV9YY
 lB8vjrKew0NMn9KZv947pIyUPw2zzQ94BC5z3x+Rh68B/WjAO6NRsk3KyHiTc0EMprPeErRs=
X-Gm-Gg: AYBFou2eVO8Fm4brENaWuaYtAnHFqKEd70TpgPcxMsSYs22CLZ80dr65Kn98+7qZkPT
 hGNupahIFM1KzTr9CxH0LG8AswxxSyBfCM0UE1iggdZVYBZWJ4FV0gFWVnzUC9ctdfbhm+Zlv/X
 FXqgRI5LyRwLssiERq4uuyxqHjNcTNDQp6HbTgjfd2Ss3pvPjdA54ztKOmF/ogt3RXIDwGY8QYl
 FvLuB65WtEW9Ibcl1B0ZiC6fYYC6uSMypEHtGtDsatcNf5ZPzhX9Laa7AugnMAh1kBrR2U4Jwir
 RbaCNNBP7EEtAoz0aNpetDBr9MT2hGunpP9XzDeNathtq69ac1mCAVwo7hQ6iyQO/fIt0DONMdQ
 5dJaATxFVPNBgCXJ7YdVFuLp5hFHWWq4FrTQ8kTeUPeAXX96w21Klv3aV6hgc17NI4JcNr/fat1
 hHBaiSrtH3j8OfbGWPxArIeoFGLIqOpM14waLInDxbsRvGMUrXQ1n7ZHMxcrqBPw==
X-Received: by 2002:a05:6122:3c44:b0:5c9:c60e:3a4a with SMTP id
 71dfb90a1353d-5ee1c4ae46amr1391414e0c.22.1794420273194; 
 Wed, 11 Nov 2026 10:04:33 -0800 (PST)
X-Received: by 2002:a05:6122:3c44:b0:5c9:c60e:3a4a with SMTP id
 71dfb90a1353d-5ee1c4ae46amr1391338e0c.22.1794420272673; 
 Wed, 11 Nov 2026 10:04:32 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157baa637sm1056344e87.33.2026.11.11.10.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:04:31 -0800 (PST)
Date: Wed, 11 Nov 2026 20:04:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,sa8775p-mdss: Remove
 bouncing Mahadevan
Message-ID: <2gfqgoiyvspgjj246a5go5ij5yrq6kvgw3vv2ttdbn2iobvbqs@bronlyxmhjqh>
References: <20261110130255.134252-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110130255.134252-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX4ChMAnI9FkPK
 FZICDoGRtnC+N5Dva1gxQ7WQG4Ejm7nUXORLhFsTyVKAzbvVWBoSBJ9ZC33oy8tzqYA+1kEWvv3
 690m2KsXKM40UG1kK32SzsHLrNHVR/c=
X-Proofpoint-ORIG-GUID: ciCD0fB5ZblcvcMf5PCL3Nr4MmNa7R-2
X-Proofpoint-GUID: ciCD0fB5ZblcvcMf5PCL3Nr4MmNa7R-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX/uWV6knbmuup
 P9hxuVloBeoPHDVkbzwnXx8mDRchAiQrEk9Ts8tQKehordgpnhtjkEFmklpcEkfe/o/HbHxHJtR
 baffv4WBisSp1x4v86+0hk/6R25OJ7RiXaFvWR2LWT/kgLbnEuGT0EpQO7jmhvbw7KA5VLCV5Ml
 0aZ+9IyxjATmFkco5/6efXd0ilzBtktgqVQtiBwuYeo16DD21FPO+MC7d5toFlBBxzzZr/QRPgK
 h76Pd7QInOyfrf+x3PQMX8obA7RRE5hAc2CRVcOMQJlWv+1oucUhzK4DuysGGUkRLKFtF18yYAA
 yCr2dDalb5a0yzHSLf2PpGygtg8oXYAchWC5fWGtq1+ut4ExvjUVGNR4RJLB/eliamgwytFBWWy
 Ux2fHWoPgOxGdnc/+wk6/LhEKojD2Y7hIxxPRsups7ghEs+mxo0IBNk84K0ALmPG4G9R43eRjFr
 WT5JI0q5ynajBMdeUyw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4ae32 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=euJXWGPXM6RQpXQweeQA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110071
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:02:56PM +0100, Krzysztof Kozlowski wrote:
> Emails to Mahadevan bounce permanently (error 550), so change the
> maintainer to DRM MSM maintainers (Dmitry Baryshkov and Rob Clark).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml     | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
