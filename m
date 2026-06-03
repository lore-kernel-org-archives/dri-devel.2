Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0531DCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537AB10FCED;
	Wed,  3 Jun 2026 12:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RX0i2Hu1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WrpAKbVy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A383010FCED
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 12:11:39 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536RMCT2076277
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 12:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rH7jaaUAkMdsadi5LkmVJE+Xx13HgQWJkgJsQc8hK/M=; b=RX0i2Hu14Z6G/nYV
 llUN5ypYsyHNPLreImPDfjN2eiGdjbi0nd7FFBpSgq9qSu5gLRabRJ/pW/Uh6qEH
 ZyBXxR3Phuc6JsYJAiTjSfpF6Q5xsIcgfl652hYFkyLjwK9ZxxFC2GZMPazZPwPa
 HZV2l2i5/aH/HWnqW90I+raV7Kn4Su9+hdqRqhYpoKFP1Jes9ebb0t+L4fuG/WlY
 EcMwjEUtkB0Sk2YvrKqKGEphL5U6ZYVhsCqdYfK4gzM+zaTVHbU0C6FnIBpMWwUd
 E9qbCSlg8UgzIZfoiqotFy1hlANEPbT4qpt6eupp6D5BCu7SyqyrE3ES5hSVbpnI
 pPgQNw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev19ek4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 12:11:38 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59ed1788158so2555185e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780488698; x=1781093498;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rH7jaaUAkMdsadi5LkmVJE+Xx13HgQWJkgJsQc8hK/M=;
 b=WrpAKbVyVhfQ97Ds/jipdUkL6qqGCCRizg1ceFw8123NuX0Qo8Q54T3y4Gaq7G/PAY
 TinM8jh4u1FL3g9HDy0PS6SGnXE3uTHZZiH4WTVjEDdwbCvA9SX7VAuFFZXjX7GbyzF8
 0DsxVSiXxARDz3MbY5rEWgVZeEsFVaXZIc4TcefnJJ0GFOcxnZVuSDGXc4Z8bw/bmcZW
 3hephG7ufJ5zHaNzmwvHp2EfjKqo6NvcVk8yoNCjg0jDAOlczD8jP3NE+q9LqGv181SV
 Eg6UCYXrcU7MvnUAmySJjLRm5ISJZioovBAgvXWUZXE/CHS9wpTLqXdJAsdMu0waVxtN
 r3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780488698; x=1781093498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rH7jaaUAkMdsadi5LkmVJE+Xx13HgQWJkgJsQc8hK/M=;
 b=k6NwaBCsgQ5K9xDoeN+B7e69ttKOLDU2DQZ0oD3sJ4zdfwRgQFVK6AdHOmWlSr5Wd6
 uFYQSZfiUF2hYu7+Z8kpD04jIWgfc0Us7SPz3g8WdWIwXUPkuQT+2+ifY7bgDsrzbe3A
 UYlarFWcnHVHEAq2gRJW0K6VfNsJbvglrdgAM3snsFlEK0/6x5GKd3dgAONIARj7+yph
 BqUyljxK9MZkPp7jf5MU40BbjDNoHMr4kyoTaRVdfnkB8GRG6BiTWRe3Vkmi7CWg5t8Q
 ccBXPFPdQrvQ646mQI/KB9FmjJLGegb3cr1Aaxc0cy1AvpxfHLxp1I1e0dVBn2d8kXvj
 IXxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/J+rCgnKukG/Hhe04EJdhLUoME9SNklUyP3F20Zuqdqmxc+BDYZydCRhv70fPEBSoW9/WscrtwCe8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFh35d0idLtpJPIA/HnwAUBC0exwpTkKrmN9ho/fvQGPeAYWRZ
 pl4YCTUV7/HadHGiKLhiTAzTNHjnK6Vl4JMHX3v/vgulJZjqlLSW6C0+VZSlACCUPanVQep9z42
 fmaI4v8RN83Hqd5kfymCoZQP9Q5EngP2HKVz5BVEucQ8F9QtpdE12aX0wG5NwHJtNtOzKhkw=
X-Gm-Gg: Acq92OHVvLt2rywuoXyPGEnRmzWJ/zbWgVzP+ZCe1s/+3LEabNYF4kh5F9bZdC9TwFk
 +bOKDHT98TEaN4c7e5eSCqmNALU+Pz9GhoPKgklKFgJZ/zLQLnC6Ys3charFmwXLy2V5TFbkmiT
 5/GcGSr28mqrK6LcyiviNwnXbR6YeBhYFvJvjymbw+wmnPoJq+VsMpFn3uiJktRtgAsZ2LsdBvP
 8O6o5bv1SdgP8TGx1Aq1ZyTdUfFiVXdF6sBz+tiMUL5CzTJNNrO7pjMXl3gZDxmCpMUCeN8QD0W
 70NBxphS3Pu5qFzh4J79S4GIergg1uchYRPzlMYYPma8/tPcqZJye7sVZq6xZqx9/wbOCpFx3Cm
 BowRcXjrLkjRrhAR0MKkYSb5TV9lgphiKFWKaEk8g2yeTFkkyXCRWWuz6NlTLC6aBVli+VKOS/+
 cI2wsIt8vexmeejk/IqDl5Yh9QfpCeP0rIvQ4AKp1DkitVvg==
X-Received: by 2002:a05:6122:4b81:b0:5a1:de02:b177 with SMTP id
 71dfb90a1353d-5a6e9aa38d3mr1534854e0c.13.1780488698082; 
 Wed, 03 Jun 2026 05:11:38 -0700 (PDT)
X-Received: by 2002:a05:6122:4b81:b0:5a1:de02:b177 with SMTP id
 71dfb90a1353d-5a6e9aa38d3mr1534817e0c.13.1780488697683; 
 Wed, 03 Jun 2026 05:11:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8fbcc7sm616108e87.23.2026.06.03.05.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 05:11:36 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:11:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: neil.armstrong@linaro.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vishnu.saini@qualcomm.oss.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL
 init in bonded mode"
Message-ID: <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
 <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
 <CAJfMnmEVwUwt=wMJ-8HKH1yz9+erWLrRGB+6wVYCdSGDK+_T_Q@mail.gmail.com>
 <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
X-Proofpoint-ORIG-GUID: DX8oaerBHt2FuM6-u_ShthKSnOiRkOmA
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a2019fa cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=kGZGFaQSV3qHyNJQVSEA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: DX8oaerBHt2FuM6-u_ShthKSnOiRkOmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExNiBTYWx0ZWRfXz/3dv5zjyAHi
 YOPnGxpM0vL/CD2sR39FzaTPtTAtfMeGpMRKIL2uLni8PIbuSKTYNFFQ0soHe2Wx7Q0dNDhF0g7
 Pw6wcEktN6pO/1oXyEJLpkd36GzC65uet3zswDUkwPKj2fVMQwpirnmgDzWB0tQxDuI/z71Ih8M
 zXkCBVjtUZ8j/ZSCwSe7478Q7cWzmRibMZe/FDXZ7keMilcTs+eXqxWncFYJteh1g7R6USF5a9B
 JwixFh9L267ra4ZD38MmQnUZ+GOwGLicy3oYNd9U8IlEBmRJTSE8wUefMUmXGEa4j2iRG7XlWca
 SXHkCqBi+wBRzcFClO0HHj/URPX3iR7FkgmN1R4glRG/ss3CafYEWtvdI8L7O4H85qeEUQDjwca
 Azz3q7JhL80pCPjzwHg7It8L/+GipuZPVFLzX3D+Ynfsw0ZeHBEE+5+7Zm+r2AJ37Uj8EhCWnmu
 xI8poL5Zl0x+T/oR2mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030116
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

On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
> On 5/4/26 22:09, Mohit Dsor wrote:
> > Sorry for the late reply. I am attaching clk_summary and reg_dump in
> > working and non working case. Lilliput is just a normal display working
> > with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
> > Gen2 only.
> 
> Neil, Dmitry, and Mohit: what's the status here? From the outside it
> looks like this regression is still unfixed with nothing happening for
> weeks now. Or has progress been made and I just missed it?

Thanks as a reminder. Unfortunately, it takes some more time (and I've
been a bit overloaded lately). Worst case I will send a revert soon.

> 

-- 
With best wishes
Dmitry
