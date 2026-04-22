Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43027FA1FE3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C33610E2B4;
	Wed, 22 Apr 2026 18:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hqWJg5M/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVNdoqCa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A76A10EF06
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:39:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfQv02956335
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m2/vpE66mfP4uz2lk0mlRo3rInfiNHI7eH+lPLc4PcM=; b=hqWJg5M/6x/mZMxg
 7SfUXFlyQ0G0yDUtaUTFyiAdF32HQEy8l4vWAQjMhzkY4/qxfiu21cT0xJFAVLoD
 t4WBzmefAxtL2XuqPXOe3lEIuaqoGyrkXbj50cdYI9JWuZnAfPhpkoRs1D7ZDm/K
 c9z6k0s2akjJFRTxtQp3mzONWUzd3/Ly/g+F2KZNmVwy5PBOEiYeR/cNZIgKpDM6
 vrAY+VvzftcJnqBDP7Tl5vhD1k275VphLgdHBr1sMl+ZFKyZQhrK5buAwJS+prAG
 OZ+ywHew/K/w0H0pR2H1WC8gy4LNJf0TiRAZ+I+3vuAzZdme3OdOKOcKVsdaDg4k
 zc1uBA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q0msx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:39:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so32653471cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776883163; x=1777487963;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m2/vpE66mfP4uz2lk0mlRo3rInfiNHI7eH+lPLc4PcM=;
 b=HVNdoqCaqj2+3SDp1LqQXvmYazmdFW2ezM5qTylBopT5eYMJbegCvE5F0cbGXtGnRl
 LPiDHa88D/BNa1z9G0Ld9ngSYQaWiCrUbnXuQbUqv3ZNFhV4QZFAeV+g6XilQAw6HGB4
 z1PzQsFdkYJeFc4nB/1+lXoiadHEwygGPGE7+x1LXfcSCHHHMX/fQWRU3Gywns7h/YKr
 TzhQH1aY0Z9FZpOy+q0BtMbNG1CshDVJZloeH9upJn3MfG7OfJ5VPoW2GJDRnNCp2bO5
 0JwK1nxZit0nZOhVD3jsLOCoEkDAlU/sAYfYkdBsZnyRB2/iyXtTi43jmb/ShvgtvAd1
 sUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776883163; x=1777487963;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2/vpE66mfP4uz2lk0mlRo3rInfiNHI7eH+lPLc4PcM=;
 b=oCFBkxpbICpAjkIfMwplChBlEcpp1HIi6tQlZFM8Urn0gEMLat6ZnLegNZxndqN5dc
 eQ+crizRrh8b6iNGI45lqY3LMl3mCbc2dN4BEEAKRqshASXAJQC+RpdvZa9GyBheDTE3
 xt8ovd2IjMsADgN2lh6yN+OOrxCTKO112IJIoamgdRjWWMJxUJ4cd0Eu2B6XzOi1TBcv
 /LpMTckAES/UemJ3dAb/4ktWuiL9SOPskG7GXR9NjlN2RA7fXvw6uf32yKlHX7DEy+Da
 yYxxIXfojJ4gbEYsWRhF4HdyVLfaVxeBrsHB31xFsZYpq9a9+15mkagrls5c12OaWlP5
 +Mcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nO4W1NrdcEcLjepob4xWfbOgHzFML05MdreE9JTO2Ns3pfy/q6VwZxdS3JLPdN3jBU7kUZ+aPMCg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwasbZ8X7EA8i1h/+6fMiHUcTmnb+CFoVeMZec6/DvHQOWI7pSG
 NJtNRpEFnWd1Tkf2Z6/lXY2LoNlduZm9gJL5cahP1WsOv56+DogIrcYpZOQRJmTcIkzD/gGiLu/
 CeeV3OCyI20ccvnTv05Zazte0jA8betkjPkag9DFxvV0RsZgZB3DsVjeRXCGsJQsQTf7OIIQ=
X-Gm-Gg: AeBDiesPQqkb3DZqZFNT41gyM/cOvJ9CWIVHh4l7oxGSR3FyzFct2s1p0Z2X1OUHsRU
 MdA3/3DOVwScgvfmod2OBp6QatOWsQ+rVxKYv/0RXz/TsR6sxBBqflg9sPqQSDLQMhO63w8vwYC
 v6z+SLWyxoNr5l6HDK+9zsD2K5TbF8cuTG7b9xg1s4DxKHdX9cuFyuVbos186qtGzerczjS0QoZ
 fNcp/YQD+T2bzNakViM3KFjYOCKessaUAAOVwb7tapiaIfbRIloiIkywoA/Ycu+JFt5icj2rodM
 Uut1LFanDFjYnstkgRbcX36uhfl92xhWYQGgn5QDi9imJQUniwjQqbrKk4cFt5GK+9D2nTJMz24
 MTxxkuIic+/Hqt+Y3numzjynxFq9FI5Tr6NcSUt4vW0XfB0/rJRcsFv3TLN/SsNjqVeLQWOJDip
 /fumxB8MgwLc3mRvLwUDB5u/ejLhisKfPs6qxgWbL2iOcdZw==
X-Received: by 2002:ac8:5a90:0:b0:50f:b2e4:ec8 with SMTP id
 d75a77b69052e-50fb2e4127bmr129767391cf.7.1776883163081; 
 Wed, 22 Apr 2026 11:39:23 -0700 (PDT)
X-Received: by 2002:ac8:5a90:0:b0:50f:b2e4:ec8 with SMTP id
 d75a77b69052e-50fb2e4127bmr129766761cf.7.1776883162609; 
 Wed, 22 Apr 2026 11:39:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebe3dsm4571337e87.74.2026.04.22.11.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:39:21 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:39:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>
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
 Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v2 21/21] gpio: add GPIO controller found on Waveshare
 DSI TOUCH panels
Message-ID: <dovqowg4a3aet2f4gwd5lufh6xqopeq5slgyix2bqbf3v7z4fk@b6pwiyn6ppov>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
 <CAD++jL=zmd8yto9HuyjC8cmBj1oMgOa7C899yo_toP9Q+QJcDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=zmd8yto9HuyjC8cmBj1oMgOa7C899yo_toP9Q+QJcDw@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e915db cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=7GRFYvq2Tdryq9sLJf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: BY0RHl5VS1lgz8H6r0ewaFlMO5A_pobn
X-Proofpoint-ORIG-GUID: BY0RHl5VS1lgz8H6r0ewaFlMO5A_pobn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MCBTYWx0ZWRfXx0qGBphywHbe
 WGh3S/5Z4RkAMhv1etncKkr1+2x7cge2AX2KBD6pmPNdAnksokkkqQYNEE/7TM6nAqSwteBRgxS
 8PP4FpT/vKF2lrQRUelei8NKyQ17m8+aPMtZvUuWEOy0t2mKScbtUpicqWDDIxS68tEv0ta92ON
 hgOWVXIxwptBQKk6pngJmQW7/gtuVDpwFX3XjunVXHHIDv2TKEkTrfzBjcAMn2er2AKT/pea2rq
 MpWQwPVgbrSEtR/NFxERRLW+zFU5ftMESUs2qDeGCJ7Uo1lYUbfur6xfBRqYZ5hERapM3fxHJuK
 2ExuVo6hM/quaWXEghKXKfaj3baydstkqrAM2CylkwXEYB2K/1PuJQwG6/9hx8ymRWRUZVwEq+N
 T3O+VQ7u2O6nw30tfkw9Rq/i3ypzJjAk8dbxqEZ6HiL+lfxn+35xB1aGbYFG9SVlx/h7Bx7uI+J
 jOp71uT3GYHDQh19uZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220180
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

On Wed, Apr 22, 2026 at 03:20:26PM +0200, Linus Walleij wrote:
> Hi Dmitry,
> 
> On Sat, Apr 11, 2026 at 2:11 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> > controller, which controls power supplies to the panel and the touch
> > screen and provides reset pins for both the panel and the touchscreen.
> > Also it provides a simple PWM controller for panel backlight. Add
> > support for this GPIO controller.
> >
> > Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> (...)
> 
> > +static int waveshare_gpio_get(struct waveshare_gpio *state, unsigned int offset)
> > +{
> > +       u16 pwr_state;
> > +
> > +       guard(mutex)(&state->pwr_lock);
> > +       pwr_state = state->poweron_state & BIT(offset);
> 
> Why is this not just flagging the same register as write-only
> in the regmap and just re-reading that same register from the
> regmap cache?
> 
> > +
> > +       return !!pwr_state;
> > +}
> 
> OK so it's write-only.
> 
> > +static int waveshare_gpio_set(struct waveshare_gpio *state, unsigned int offset, int value)
> 
> This looks like it can be replaced with a few lines of
> select GPIO_REGMAP
> #include <linux/gpio/regmap.h>
> helpers.
> 
> Has this not been discussed earlier?

Yes, it was. Using gpio-regmap would complicate BL code since it
wouldn't be easy to directly toggle the BL GPIO.

> 
> Yours,
> Linus Walleij

-- 
With best wishes
Dmitry
