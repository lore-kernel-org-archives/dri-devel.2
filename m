Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7453E9380A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 00:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6562D10E16C;
	Mon, 13 Apr 2026 00:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ouj5s11M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKcal/my";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A494D10E16C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:56:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CE5m1l3315443
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HijQAzOwombW0sXEz2D/Ph1M
 agV/nyykDUHyc/yg8Tk=; b=Ouj5s11Mh1U09Z/e3VoJZM+qKJ5LCf0cZdXI/iio
 4fLEtDaRgbRAf+a4WkNBJV7KUrGL16XzNJt8/ynV6mCkj25Ba+W6Z44NufE5nRKM
 IbbrHcomYp9PchajxCDdn8ufUTgvbhi8lcJykAlPrA2Yxc38rHYDM3wD5AiHwgfR
 16vXbBfPWi7Hsfaa0Ukx7zi0/kflDeOqI9brP2N/1EfG8WhXnJJZ/W97MRiIhi1a
 bvBTk8WSRTRzn2WG/xdeG0vhAwpWcckaw02mIQr/BBwgbFYUnphpcniqU1Me+FCV
 zwBFkpDT/uy80zo+mO7PNv4HuI8vdDJtMqtGNl7KmtKMJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewku6n8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:56:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d831e8083so50875021cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776041773; x=1776646573;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HijQAzOwombW0sXEz2D/Ph1MagV/nyykDUHyc/yg8Tk=;
 b=OKcal/mysny36V6wU7yPZZqDxDtEQAyWMGwYWv9odHXvdSM62inn56DneKagS52063
 AIzblg5TTeQVwSoIyoYDA3u7Uxy5y4iWgINFSFqWhC4gISGCKBQwk/LNE2E2gBxAUFv1
 WKsN2V0o3lBdgjYeRCeSxvUBuSvcompOJYdFc5M8K6Xkr06zlF5MCMzfaiFO/nOuw9aQ
 LqI+9KS7vwsiD7LAoT1wVE+Ao24MH2w7IPvDD5ES4f7mBJSX4BwuBkt0TBhm/TmYeB+S
 QQ94tvL8Zqehn0jTytzeK42otUzxeMSacTP7dZrK0trv1W0jtCclD1uTw7k6LGZLvWQ2
 dHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776041773; x=1776646573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HijQAzOwombW0sXEz2D/Ph1MagV/nyykDUHyc/yg8Tk=;
 b=S1RxXq4SdZq9cXD/DcwZCNBIXGzmZOcT+qK57/O23j1DubFBOmbxOBFB+cUhZ108Hd
 bFbxRt4vdENh4UXzM4NOVNQmg4nI0a9SMURrDoL0h6+mVc0cMy8+4ljh6hNOZwyi/B/+
 OD1eQuumc501q7z2DkFgDU2XbC+zay9yciZSCuW64i72NHRpTS11aF2rBSdCQV4DjXZL
 jR/gzdDFz2We0yfJNwI/m3ifLtYaV0eQ5f/EQxqEOLNQG+nW7gxzH8udRJ9bSoLZM/0o
 BjfLxLPiJQxFkrnbTd309W7679BO79oyjKypwia48ERIqYyoNA1OkN1x3POxZMc/wI2s
 xE5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxINOpyqYQ4NGKG+Z+x5c3QDhvEO4t0aX1CIx63OaOjRE6Qk1Adtf4BKxqbkr1KyxXF9NxoTX2DsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKeHP8hR31We/TpPWCl8ooeQrNXJB35jazZeBWoFx7if75RQJx
 keGVZcVsplH40+opachEK4IEitIvMyrIG8DfP2Dqh6A4stIlhbgUnlSX8+Arq8YIUs6f5rBujij
 wa6Q4xsf5j7vAHR1A27zhggnNvzNPydKA/CLOGNCuidxeoE/7CeTbTBNbGbf5vVNs8DfGeCY=
X-Gm-Gg: AeBDievbdljH/3OxdApp+gEDKRfs7v/xsV13a42UHdwKABNuDKQ7CtNsDq+wVLH3n9P
 x8MTGvkaIzyMD9d+npyqizSSYZjvg/mM8BEJdljtGZp5HJ8t1BvFN2+QmF75B5tPfmPraDaTvMS
 XTPGMS2m97bkAXV2K/+OQhJNSSwAfKStFv3f7Xg5bKpHhyKPv10ZEqpLPrCbyNivBHUmbvjoJd4
 oKnZE8kYD8n2OdOeOSZbXkUNSm2wQ/yQ05+cG/7L8uBds6Tt+snqrwuqCIGTGLS1jsKU8xO2zil
 lTmOswJ6vynt6mLqS/5G7z6tZvQho3ElwviGg4YLSN6XAw6K6kE0QgGnqG11qTFgIqy2DapnSd7
 ruLc6XMa8/6tsMhlzeTNqX9ejjJkPfaCWAYZIY0INp+WgkHh5GsDTQP/AV29vM1Zca0TNGJ91aF
 hNdKz/IMGbOoOemSSVkknhljgeAHuxqKq5CTg=
X-Received: by 2002:ac8:5a92:0:b0:50d:a637:6bdc with SMTP id
 d75a77b69052e-50dd5bcef84mr180329361cf.41.1776041773616; 
 Sun, 12 Apr 2026 17:56:13 -0700 (PDT)
X-Received: by 2002:ac8:5a92:0:b0:50d:a637:6bdc with SMTP id
 d75a77b69052e-50dd5bcef84mr180328931cf.41.1776041773128; 
 Sun, 12 Apr 2026 17:56:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49541ddfsm23293661fa.27.2026.04.12.17.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 17:56:12 -0700 (PDT)
Date: Mon, 13 Apr 2026 03:56:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v2 20/21] dt-bindings: gpio: describe Waveshare GPIO
 controller
Message-ID: <mzuwcmkg6u3l3b36wiemdliq7fjrmu3hx6bxba4k6nyhfffibs@a7qh6wcivc5v>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-20-75cdbeac5156@oss.qualcomm.com>
 <20260412-diligent-ginger-flamingo-f5059d@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412-diligent-ginger-flamingo-f5059d@quoll>
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dc3f2e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=7GRFYvq2Tdryq9sLJf8A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDAwNiBTYWx0ZWRfX1r3nuGt4QdCU
 utU8+wA1asjiwicWKhWEPGmpL6ff72WAKPzSP0AjOHQLIMPWfzSpR8z01z1OBDrSR1P7FHB/vKU
 MMXqdXBPzv26z4wvoqdZX5bMm+rf9b2YD+MSV56hGTesodHdr3G0G1ZSjY7FdNznW3ZVqajaD4+
 Dq8Y0IYDc1TJ/oc+zOrTkiza+fTrDZxU1y+KAocPCKMdE1F5qyN7nQZ6+rz5KRmW+oYn7mvAZ6M
 rlekzEVopfmbDDbkaFNG8mFGf2lz48QiHdhgq+UKQMliqUiroleMF+yhvRI/3/xvLzBBZ+3v03I
 747kUI8LPE1LRDdqfLKAbMtTxnVTofU4iwc1BHcTTLLOG3oqX28JcmXQyqQSRTvnemUtVaJr6e3
 +Br3okFKOqHdy0ls+0GPdB+AsJqtczMr0TL+paDaM1Ad7DvR84VgiKnM1fmVDjbEk3SGglr6AMc
 8nRgt7kUJ7JoCsgpOiw==
X-Proofpoint-ORIG-GUID: P2aNH-PdOQsggWpcHqxP5XL0w1ZM5s46
X-Proofpoint-GUID: P2aNH-PdOQsggWpcHqxP5XL0w1ZM5s46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130006
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

On Sun, Apr 12, 2026 at 11:48:46AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Apr 11, 2026 at 03:10:40PM +0300, Dmitry Baryshkov wrote:
> > The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> > controller, which controls power supplies to the panel and the touch
> > screen and provides reset pins for both the panel and the touchscreen.
> > Also it provides a simple PWM controller for panel backlight.
> > 
> > Add bindings for these GPIO controllers. As overall integration might be
> > not very obvious (and it differs significantly from the bindings used by
> > the original drivers), provide complete example with the on-board
> > regulators and the DSI panel.
> > 
> > Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> 
> You cannot test a binding, it is not possible. Otherwise explain me how
> did you copy it to the device and what sort of device runs YAML.

I'll drop it from the next iteration.

> 
> The tag was given here explicitly, so I really do not understand this. I
> could imagine tags coming from a reply to the cover letter, but adding
> tag here? That's just fake test.
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry
