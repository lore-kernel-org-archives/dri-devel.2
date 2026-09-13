Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC6AC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E5110EA5E;
	Sun, 13 Sep 2026 22:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSN3ULp/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbBF9+fb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2C910EA5B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:51:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DLF4a93672586
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=btDF+i2KLcySKsRDG04ke9EX
 GqLGBKkYRlkEl3KSsbc=; b=cSN3ULp/jmbD+RpqhvAi7G4b8xI5NHqzdYnUZhQk
 pqRdi8OFg4yp6abdziJVVvNQxLPekTUoi2qzD+Hf6CUBJY52mICx0i+Ild//Ou35
 cv3WwDThVV+NN299SEV0hpMYpHSNwQ+6XYCpWNzK4diPVU90zzLYiejU8LUXjatK
 ocOuYsNom8HvdaXAbadzhrtybdJLnz2OcOF3OP2UVbplsG85bTwkdndc1wOrUOsi
 22pcbkOiL3fe+wZJUqic9K/G/UBZx7yiNiVjQhvqDoPqLjxph6Z24wMWk4g2d559
 0vUESeSvhT7fybc3nCMhBJN4uPKQrfSJ3Ye7FY765JOdIg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k084r7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:51:23 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78f2fe53829so2400013137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789339882; x=1789944682;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=btDF+i2KLcySKsRDG04ke9EXGqLGBKkYRlkEl3KSsbc=;
 b=FbBF9+fbHf6g2QupACEiX8Wpz79ZG+h7570v0qrdohILZwFlynKQw4LXpJb4haaYf5
 LIBGekc0Rejuuf4V8c9qD99A6e0vnUysget6CUAaPsAsXnZ+YtXsc1vgQl3yOaFJ8Gym
 0AbhNYfTjEPQex0oVLiGPJaoszSffkz4eUyq9+prQv4P35vs3iXz2Kec8EseYQAzjjTk
 NDTYyYBU/cWywz67vMG2S2B3xMviUclW4fDshpAKGafuFk5AaR1PjSFjKiGs3jQcUnZL
 GtDnyTAEP3lh5COQ+dkTxEhbGwW2NTpNCJe4Q82rJJudv1UxXNTpgHjhaz7imBZKlFkY
 Ew+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789339882; x=1789944682;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=btDF+i2KLcySKsRDG04ke9EXGqLGBKkYRlkEl3KSsbc=;
 b=Nr0G0gwv5AU2zap5tD5+wxQ6tew77XuTaisoqz5jIsocCGlh6d2jBKj4KycdZqjufA
 dIUnfU+r6ykNnO8TAD27uMeNlOonKgSjFAf2Iiqg6EcUdgtm/nBXgRUrhYuPVC9kK+6j
 fWc9fWfG+VUItuKU5Pjx9MiSlJJY6WnFthlcGCCA0phs2YV8h3tnXSwg4hHPNg2Ft3z8
 8mO68TeMFa0kQgd+7bADfHjPqgyllF9DJNWxdVFGnbd1RrrfYrAzK+QbEvRv3EcDJjhP
 U++bQ48NhD7S3qFPe/35HFjeyY27kiowZnFAqU8RNNAjfv3P50xkGdtLdtJ+kpMK82Bl
 /UWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywkAgN0/d5zU0Fn5VufMfT+j22YWPRi8xwonsxzxTH3s8tv702X1Mwi9/tzVfe8BP2mVxcNrUEsdc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktWk2a6JdywgiVRPK6b81NZyboFoHjOfXWTP41qEP8ftnT5ThS
 n73EA7h0arj4nNs0mTxaXXOPsOLlnEp1gmUjlm785B2KETSWcpiEqmfH3x4FTpX6v8x0cuQsWnJ
 mRxPJRJvCQwMh3MpWJWkMe98iq/kRDai5MzkO8iYQEJMUipzU++P0kKQxkjzzAYr3W5Nh1kc=
X-Gm-Gg: AYBFou2mAEfOZ8VohVvJ6pqEHofLDS2MhjaoqrDX2fSfrH/X5nrO5uumE/vcoNZVr4J
 hy97PiLWo7thsp8G5teMsEWwguciczaU68JlxM9N44Q9jXF6PK7Jc8JdcbsLMOALvj/TZoMEDow
 qmAGlmzfHOxpMZo4OdFrP+naGnxk1XEBDPXRZ4WiS8v3uXnMqd95Nr27uTGF4Sth5xtcoW8EstR
 eft6ruI3+0Fe7SEaVd5A3Wt1q1PdN8JQV8773rsJ7+KtH4qKJ7z5RfyMmL1kmN1afp9cC8mCj9l
 NBOKkm0GwJism/jI02gqcg7mturiMXgtUJMhT2PqsnRYtJnQ9p+4jHHtAYrj7gfMLrRxqvXwn/d
 0GUvNdUHUbtZYDCe+1XJcF15xEGn3c98Gip157fidk4+PsZJfhOMOMzyM9OwGeh98L8lIKlynr/
 EJC2i3HcM2cHtN
X-Received: by 2002:a67:e08a:0:b0:792:94bd:9be7 with SMTP id
 ada2fe7eead31-792a675d7e0mr11888849137.2.1789339882089; 
 Sun, 13 Sep 2026 15:51:22 -0700 (PDT)
X-Received: by 2002:a67:e08a:0:b0:792:94bd:9be7 with SMTP id
 ada2fe7eead31-792a675d7e0mr11888827137.2.1789339881698; 
 Sun, 13 Sep 2026 15:51:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047d1d1sm2086254e87.80.2026.09.13.15.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:51:19 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:51:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Liu Ying <victor.liu@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simha BN <simhavcs@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abel Vesa <abelvesa@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] dt-bindings: display/msm: Use consistent indentation
 in the example
Message-ID: <acryik4zjxxt76ldqk46a3wymgettocilimua4tlm7wl3tvfo7@yrh36odg6fju>
References: <20260913123331.100293-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260913123331.100293-4-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913123331.100293-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMyNyBTYWx0ZWRfX9m4mjDFCDFd4
 fEVAdzcr+cV1O3eJ1rQ8qi9TiqsH1z37UYUhPXJVkkUavCfBPJzrurpJT/6Qx2K7fRWAnReV9nN
 BCWzsJXmbG4c8PQi9KpKJ5PKTOrOYMQ=
X-Proofpoint-GUID: 1aZanspE-7sY2d3hY_FOpcqJ6iL-wu7J
X-Proofpoint-ORIG-GUID: 1aZanspE-7sY2d3hY_FOpcqJ6iL-wu7J
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa728eb cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=6MNK4Np0iOagQr2kdRsA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMyNyBTYWx0ZWRfX7Xf6afYJovVx
 Jx5CiiPF2mRY0OBq5k9Yh/T37llo+0SgO3GjmkEySbxiL/2qyNSIG++S4wlpEMaGwGhVKefub1h
 dTdoEtb7Mx2+Pjmp96Q4jTLkl8a2+9WwOvs56hsDM+Uc/ED3cp9pAZvZqERV+NaUSRnhu02n216
 yxM6xggrV5u1+OFcIyQEhCHNT23QF5bqy3sh/y16u85yM67/F5yI1n7BdE9Lo6wBzQcuYCQfjnD
 ky1tnFLkFN/KufXjyD3wArm5EZTBZXOTB4T1FDFqsWyVvDF7jSb0ZhxHI6El8sMd4tVuH7M5JCi
 XCZTsS+CQW7SxIFEjlamCDhBq1GX4WQPBq9p3osAhocMzGK7YzBhMa0P2g6SJ7eU6zeKJ/6vxYF
 CDgjC2UMjG733MYRn560MuwwJNGz+72t68+DoRHjGbbHm8OwRIAJLzhG/Ne0qGHnGCQ7dOC4ZWN
 lx610IzIRmD4c2jg+gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130327
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

On Sun, Sep 13, 2026 at 02:33:33PM +0200, Krzysztof Kozlowski wrote:
> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../display/msm/qcom,qcs8300-mdss.yaml        |  6 +-
>  .../display/msm/qcom,sar2130p-mdss.yaml       |  4 +-
>  .../bindings/display/msm/qcom,sm6150-dpu.yaml | 14 ++---
>  .../display/msm/qcom,sm8350-mdss.yaml         |  2 +-
>  .../display/msm/qcom,x1e80100-mdss.yaml       | 60 +++++++++----------
>  5 files changed, 43 insertions(+), 43 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
