Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C0FA1FEB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FC710EF0F;
	Wed, 22 Apr 2026 19:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BT5o0int";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jQEm3iBl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1B010EF0F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:36:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MHtlgH2630069
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p7getAbtuwjys8gy+hm+EGK6ZsIm6NuSTLfjNxjvD/U=; b=BT5o0intOoWRwcKk
 0T4e0Hgl+A5K7WapCdR44MlSEv2s9k1OhSwGweAq8L6iSJH95ZBCx6Lvu0zlH7l5
 nUY/T7lsBc7lSe6iEeSyhuG585oEy+n+my0D1VzdmNI+42O8SR1/5lj3/UQibJMw
 3Oc3mIQNrzTQn9ntRh2Dplm/F8bXjP4K3iA3uOKpkXKstmpvbLQpkIeGWDMgSI1Y
 PBV5kjVtlEUeK8yLqfkALqxkJ3IU5vKylnSOcMHbKp96jl4L8MeDXAeMJso5HyRR
 t8HRrF4cIdFv7gxi+zfSnQJcmzyCPQswJBjhHPCxG0PUlBPafQzPLKqEfW7COwRF
 H7k/ZQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35r8brw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:36:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb007bc36so73856911cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776886557; x=1777491357;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7getAbtuwjys8gy+hm+EGK6ZsIm6NuSTLfjNxjvD/U=;
 b=jQEm3iBlyWIU4oTlwxiL9Pb4aQRSIktvbd50Tr5SVyXlFUitQCsTps6VSmGUbq2vvT
 iXxH4sv9VZ8X5Woxlj4FJFZ8pij2WKFo/4W4P0Px/EiP1R5w9xhwam7X9RmdnTGNv5hu
 3MUT3VFv/z5GpaSqd/bS8LgfkrN4xvnUEDBqHZvtOnOac9riCnh5RxSKIMdcF6caQTEt
 dGHYiE0wJydGYU329Jzye9Ah0ulsLFG+6k/zRXiRA01okSaVNqfNTVQIOEhbOIeRkmMj
 mIdLKk/7poXP/xjZ3Kd5/DdDsM37/alS+Ks/x0p1u8o9wceDMB3WrYZBfJb6WT08shVx
 1icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776886557; x=1777491357;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7getAbtuwjys8gy+hm+EGK6ZsIm6NuSTLfjNxjvD/U=;
 b=Z185Mgq3VT6v12rmHD/VuPdmon6sLkYBtsC4jzZQg95/v8ORz1nTIWhiPUrBaFf0rV
 FxZj00pd9951pFMaNJSKbrvGUsiBbUHwzrrWqLsTFSAJr0BZO85wX6/7vX8YBuUoVqan
 eRPLJXNN9PJtUYENp0VYuefXju0Pur1g/Iotp6u5Bwrx7km3EPtzsy1AcLz71Ueg+fJQ
 Mdw9sbaNJ1+R2DHy/XlwsFARfsvtsT5rqDhd37lmd+or4KIjK7kkI0UMkZp6oFAW9aTZ
 7FEKvEoYmks/I7xtR7G4bUv1NSTbCqIBDwgYQXtZJcxUQDGfbuvKXrGDuBbUij37qObY
 Xy3g==
X-Gm-Message-State: AOJu0YyQyn96toRM0zvnLT80cxdjDOnfFrG5XEXVxzYSwUGnlQ8QwiqY
 nN6SDAK8v4VDIL3eGFusbyfQJkngU+zFAhV0wtyROReE6ewJ8Tq+D8x2+lwA96AeUsG6t+c6mIT
 Z5+5HrB9lyCx/dKQ62bX+PitUK5I1VTifftqE1l5oO61hdHNkcilI/BYFWllDo9hwI38U4Nc=
X-Gm-Gg: AeBDievcHwl/vEDilXtts9ODsn2hffLxE2QkKH8UXXiicGvD74bwVuZuo6tQaX3nPSP
 8lutlvToQe1Rq8edcfIhTuBDwte6rwct4cDrU128mz2Kn+eSTMXPADX2tdHR3ABk7XhMbr+EK9r
 lonB6sejLBrQZw2fb8BLA7G8KLfdHoBINWN65A/Wa2lMTs4hkKb9+Pt8TrwMK+liJCboctPrNU/
 7C+y8/f/h+gC8fBpW3Ob6PR1K4Sy4FBCiWkDj5mHKisBoJDee8LkhKyQmxm3yKoEznjxfwfJXV2
 Fx64e2vnK61L4TpXdU/rIskd3wa5Yq3PqyXNoy36q47LWxxRTE3I8JSIHikS88B9s+qA/Jds22I
 E8aog+UGp8eNiofoLYDvutf6ViF7YbhvxC66P47m7oaxy25tJfvVo4z8wX2fCIUJO5ZzYEfjTRI
 lQ6+gJVIaCzIiguFmeOTB6zuIl/eUqTbGSy3HH7H5nPQTbqg==
X-Received: by 2002:a05:622a:1918:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-50e631cc465mr177606701cf.44.1776886557597; 
 Wed, 22 Apr 2026 12:35:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1918:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-50e631cc465mr177606141cf.44.1776886557164; 
 Wed, 22 Apr 2026 12:35:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185c8a33sm4723395e87.36.2026.04.22.12.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:35:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
In-Reply-To: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/4] drm/panel: support Waveshare DSI TOUCH
 kits
Message-Id: <177688655533.759482.6233087265509719567.b4-ty@b4>
Date: Wed, 22 Apr 2026 22:35:55 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4OSBTYWx0ZWRfX7aMnTm+yJVVH
 hbAr3I05U+pGQ62Z6ql1KE8UCYE+Ke0xDHFFB8tZ3tNcOO8T0W4kXgdTq7BieyUE/kmX4lyIobN
 8X45KkATnno00K+ovSa/qcx8XT+7qY7jpvRG6NWKEIjyYIZl/V92bj/xHAVeovbPDQB/gu5X/eW
 z7LJW5zNPFc9aptGadJre80skIFcRKVFn9gEDfixb+nA5Wghma7UmvzEd70JtJEXUJGclcxKowE
 DVqn2qmBef8Emu9AtDJiGSXtGN4mtZ1ZuLuVaaWIa+mlSmT3LZuLLY8RCgC/gkros6wKux0xKAt
 SU5OQXjghCFIsRA+Pq2FOgjhR1fwyXCXgDwRWmzxvTI0DIsdO/QyUgQ4F8KkJoU00Ye37/WN2hO
 AghSdcHCb5Hdph4BcFbkzaV71V/nMYSc6NKNRGIc6Jk1BctBMl1hRFqg7wqciuIzNgfvqQgNkAQ
 rLR1yPWSO0o+TvgyIBw==
X-Proofpoint-ORIG-GUID: 3Tik8o0QIa--wafVLx7RWGkmflGDw6kG
X-Proofpoint-GUID: 3Tik8o0QIa--wafVLx7RWGkmflGDw6kG
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69e92320 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=V1Sr_61zPZr-dZQ6qXoA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220189
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

On Sat, 18 Apr 2026 02:16:19 +0300, Dmitry Baryshkov wrote:
> The Waveshare DSI TOUCH family of DSI panel kits feature different DSI
> video-mode panels, bundled with the separate controlling circuit,
> produing necessary voltages from the 3.3V and 5V supplies. Extend panel
> drivers to support those Waveshare panels and also add GPIO driver for
> the onboard control circuitry.
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/4] dt-bindings: display/panel: ilitek,ili9881c: describe Waveshare panel
      commit: 7ae674a399b6d83ab9b463adb61cc0b64e298eaf
[2/4] drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel
      commit: 4c95b2b7d49edc5846730970cef322a6d8d967ba

Best regards,
-- 
With best wishes
Dmitry


