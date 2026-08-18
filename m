Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08836C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC2310E064;
	Tue, 18 Aug 2026 15:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKGcqWHy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="huOSwhZr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF0A10E064
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:42:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE0ocf1843500
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C82d/+UAQNXbeW8G+O9iN6tLHSBIaUfkFkI8qR5+s5k=; b=FKGcqWHywCNRTvhW
 r3YCGBK/lLZfLnApS9RjN849l3AU/zFIxI84Wxj8QwD5A2x0VhEPgxWzfqW4ANaL
 Pmr3zscAiUjGvVW4IuiAl91SYTkNiZsvzDzWXMDfVplJXEvjoXqANXSvGfHxGBOs
 z0aXKavwHhMDf1yT56wTM6n3icNRW40aoGlxEBB7lNp2jzkcxRHoefABNi4S32jN
 c8JrQW6xB+ag+LIoeJc8uQxQo4YTXifnk+7RnL2/55ReBSS4MJSfxLlj1IIaMeIe
 BCt67MKqa+G3FwfJjFEAg7fyRXviiBoKKeBBmHeBRBtg0AbO9+Bc284f6tjvBFRP
 jFIX4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp2w2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:42:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c9d953b71so4836461cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787067745; x=1787672545;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C82d/+UAQNXbeW8G+O9iN6tLHSBIaUfkFkI8qR5+s5k=;
 b=huOSwhZrRJmVPE/CArjdgmUk28guhUoh63IXxp+WC45J2qq4ok+ZOY1JC37T2wmeIr
 XPtifjKiYbRxbf02FVxLGUmGfToHXYcjuE2P1cShRs7IIPrUkVQ0wZzCtzptaT1qTGOM
 bxbUFNlLWECMB0iVqiOS3E790nsDAeBzu+eHZ0HMagsWKqgG5lQfV6Dl2p0RxYq3IqSt
 3F3MLw0OBaeSYHL2Zr6hoOv9pO2rz3pWgKL6sP/xOfjWgb2a7XGwieDHKsEaqVAVjXcb
 VK3gNVqgRYh7sxz9BLy0WXbhJzbS8YxK2yk1cNnjYeXbX3lzdGfhPbgya46BRpY8jcMv
 20ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787067745; x=1787672545;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C82d/+UAQNXbeW8G+O9iN6tLHSBIaUfkFkI8qR5+s5k=;
 b=an9putvjkkIpVGrlHbOg/5e0hGW88hdQpZZJehbaJ277kmr18gmWnOHhCE53qlUXZ1
 LDx/6C9eHPsoYgaQCCGdXdxkaG7+M58E1UPAqNe5SOnH5+wxZZ2op1je5byfdnbhFVan
 h0nzEKvkhG+cHwv1umt9NSQmNTQ3s3Nl7sB7amXaBUEdn5zxfaZ4tSh2ULKptbU9bA7H
 O2iBagYJyfIaEfrbRS+4OrGrFVxRwM4fH6AQUEnd31FfF3QGPDUSQi9NopA1s8wk/afn
 tfvgDYnqPPQ64HGJAlPqPiW5jIAflfoKJOQPAAcJ/x/v9/vnwvnMGxpMX8rlEa4XiWqi
 435Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3VLl9FY8e5yRjX7p7AcidUnqji1gtIgI8nvtODK9T1xZGO2enkGBD7UIkVTkPPAwWOXX78ztrFHY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz1sF/2rmCyLnL7/TtLPvdws6GEOXbXx4oU+B0cxqck8uXviLs
 CvY49LqI26xmgxyBDD+4hWXSrrI+TYQhxQvUS5evrtb6JAuWcB7c6mDrI1v9+FEZZTgWEKzM2ry
 gQlLy+8bd0nfvW5Dg9U/9E/ifJOQPR43DHCEFBsXtVFopmBGIr6ZJAtrU+RRv8Pt1x/yV90I=
X-Gm-Gg: AR+sD13hvOK0j7mwUOMe/gwD+R0jl//st21GasdZyINpCeyOL/MKQGtkx9+Aoz6TApG
 evIO77dR+aSdxVuyoTcI+g/nySxG0GwzYYJb5baJpCH+419tHg41YOxBV33Zda5yGh5ocYkyJ/r
 4lyfWPyIPBzolxfGKgixCF95KI/i9lY4+ujXqkR4XntTDcMXNF9eiYK9CSAf52pOs3lTLCw4R5Z
 R2/JKkQAHOO/5dMC4+XOGaGWuWITmtHByiNfSi+RJUAxVk22Zc4HZNBcHEn0IYJK9oEUSSjVq2J
 pyLHYHjEs8652CAkMl6xFTwkfMznpz6RA7wJrTi5mRteF/IPZjgvkeJavV865tllMvyBCfNc+AT
 TrvD5boMAgLrTqKzabTyM+NWS
X-Received: by 2002:a05:622a:11c5:b0:50f:a53b:9d5 with SMTP id
 d75a77b69052e-52d85333bf8mr269352871cf.2.1787067744912; 
 Tue, 18 Aug 2026 08:42:24 -0700 (PDT)
X-Received: by 2002:a05:622a:11c5:b0:50f:a53b:9d5 with SMTP id
 d75a77b69052e-52d85333bf8mr269352451cf.2.1787067744407; 
 Tue, 18 Aug 2026 08:42:24 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3f7111907sm226210a12.16.2026.08.18.08.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 08:42:23 -0700 (PDT)
Message-ID: <26c49938-2287-4d3e-a6d5-afb9f21d057a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 17:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: phy-qcom-qmp-combo: com_aux enable fails on a DP-only instance
 with no USB half (Snapdragon X2 Elite / glymur)
To: Jesse Casco <jesse.casco@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260808164148.123057-1-jesse.casco@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260808164148.123057-1-jesse.casco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: r5voST22E_2Zg2G9bWuu9nE1jc10Ipol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExNSBTYWx0ZWRfXyBz4TBLMz9Tu
 tXNnuAjVOgKIdC4Nmyt0fDLwYF0QzL44dQ0eTS7u8LKE7NdOAnkg82bKPP46EXbvA7De6whZ14m
 DWBlw5QGLx8i97Q+WUnZ7tBVrbVsZsGsqcLB41ieVcuQK7JmjmJg5sqSYJOFi4hg7bCTTgJ0/f1
 3ZnPGyDnrYa7ssHqYnxz2uuarSOE+IY8XUv5SqaiJhaZwZMpHdHCtFBrmQtmObdubiBvdDF20ua
 r8R3jj0aFeE5aWjNOygJzTjjVby7pMrz/4z3jQazT11bPL/9A2UpOsutEQNRU/s2ci+JGRqvnl6
 6QU66mJ+FC5Itn4sXUaUySZ+0WMvlg/536a8emI5w/DDgj3oKf+6/Seh8PnQvnHVKTN49X7qSok
 eqs2m5g8ybXZ6MPqEr5eb3rnUyrnvahouIWMb/lnX9iJ7h7uuTRWy2o+K1dmwVPiH2t5WJTyNJs
 F7ntgO2bl6PTPVXmTjw==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a847d61 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=koz2UQyQ733Cima-qgIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExNSBTYWx0ZWRfX0WZsMQVJ+ob6
 XHEZgXNSfRBA2SIRFZT223SXOCV5T9rQyWXu+tHOaLA5W0ukbTi523WF/5q+uERxsBuTQw8qbTR
 a/jIqHJzdrHLRA2ncm8s6kzK5cpsdtg=
X-Proofpoint-GUID: r5voST22E_2Zg2G9bWuu9nE1jc10Ipol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180115
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

On 8/8/26 6:41 PM, Jesse Casco wrote:
> Hi,
> 
> On the ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme, glymur /
> X2E94100) the internal HDMI output never produces a picture, and a second
> problem turns that into an unusable machine. I would like verification on
> the reading of both.
> 
> The failure
> 
> 	Failed to enable clk 'com_aux': -16
> 	phy phy-88e1000.phy.7: phy init failed --> -16
> 	  clk_branch_toggle <- clk_branch2_enable <- qmp_combo_com_init
> 	    <- qmp_combo_dp_init <- phy_init
> 
> Plugging a display in afterwards produces only "phy_power_on was called
> before phy_init", and the connector comes up with nothing behind it:

Seems like the display code blissfully ignores any errors that may come
from the PHY APIs.. Checking the return values and adding any unrolling
as necessary should make such failures non-fatal.

[...]

> Konrad, the merged commit lists the HDMI port as working, and it does not
> work here, so I am sure I am missing something on my side: kernel revision,
> a prerequisite, or a difference between units. One thing I can rule out --
> booting your merged DTS, the board brings up all three USB controllers
> including &usb_mp, so that is not it. Any pointer on what to check next
> would be welcome.

I carried a local hack to ignore this warning in my local tree. We're
trying to chase down the root cause of why the clock doesn't wanna
enable. I believe the DT is correct and it's a Linux problem.

Konrad
