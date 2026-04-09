Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F5410FC463
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020BC10E700;
	Thu,  9 Apr 2026 00:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTcA99GH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZwEO7ar";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA6F10E6F7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 00:35:28 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638KwNWn4107667
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 00:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ndp4gTNtatXVB59GvfySCe521WRxiQSj1huYhg236oA=; b=gTcA99GHdSXdvfbL
 NYLnYFsc+gXA5uVq6I3GeOPWhKaDUuQz7yVX3jrt6gZP22lzRKsM/zfomtB+9P7R
 +aQTSWfpEkCoiHQ8BEJRQuNcs/eDpeIDouvLmG0UzTUsBnA6+IjjJavWByIzwekv
 OAtDSjnOPEMqpxfcqX8s4FvuH9C89AQ7mx12tU2scK6lp6giCT7Wa41CS4WA1gXw
 6JpdeM5H30UEh6s97HikDpNsnw2jB/0oaE9xZcfFNDzOGFkFCzl7NCRznccylWU0
 bBpIFFhhbzUTojn217Sp6PZyZB+9Q9KbU03QZuwEx5O1ByTqjZx7+nIFW06MdkAx
 xUjEoQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhagj72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 00:35:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b220c72bbso17833881cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775694927; x=1776299727;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ndp4gTNtatXVB59GvfySCe521WRxiQSj1huYhg236oA=;
 b=LZwEO7arY0XSyQ6xGm5m6ttvWLxOuTjn3N4C3/nc2ll9Zn0t6YNBKnyfglXEXxfMCT
 jIq2ZyWJJkgHFrBXqRew1ncmkby1sdGhkxE6mHrSA4mvnZ+B87XXn+RbHAYnKsQM/8ke
 wHmt+TBWLpQ5bw/ss6qKDud8mvnBC7gbPz9F83Nrv8eAmZdmN/hl/3Fm3aYUWhEAXP2G
 Gwl85Cafv5V5nxzzZPY2mWGELr4R2NjvttcZ80Lg5HplLKaHM+KR58oQ9JAgEno40ZLd
 ZeDfdK9CigiV2d18XYlkHELujbMPlin6sPq8VqjnW7zzbWIYINIfhx4V7AieExMeotxC
 i1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775694927; x=1776299727;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndp4gTNtatXVB59GvfySCe521WRxiQSj1huYhg236oA=;
 b=Mwd6VfRDWGRiBHUPPUboOLXJ6AuvgtxSQIIrFwNVrECyLbeN3B0lhBwfv982YIhHX8
 l1J905xLFetYpp2rzKyZ2NwNAjbjMt4ojgWhKETQRebBDl3swBw6TSroyw12MOZ++J6u
 XLLrvZCe5GNS1UK/JDPVBCqYXy4T2OW2PM07uIr3UqV/dieiQq0qUrILpK5deDJsYPon
 V5S6iVqZv+/3283HGd5FdxjpmPzQJD2dWYkO8qZ/VkD5osbu3EGOv33xhHG0rkB+IzOY
 9so93TUNlbAHdur8x7KimTAgG/SOj26/f4MCnWVI2uNNWHB8lk2sh5yLn6POZyZf8/AL
 TkyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhioPXaa5wZHbhSTg9mseuz41std2i5LJRzufS0c+sE5eYvjD3mDGpeen6K250EmcL0aJAZV5OLUY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR5WbEVLBAhwIqY0pnCj89PsjZipOBHWpv6FpoSOQtzbHc9Cnn
 7hcV0FlmfMqRxMReX/brcwP9vy+Rm8pc+tUvS6lieCqpHWyb5sklx7XOpSQRr4l4gVYDc/pBVVS
 e0Ytqo0JmbHhgmXB0bTcoPAwnty9PVjCLKwZhRsUtV/eGVjTFwjtEbJ7czQglkq5L5jE/O/g=
X-Gm-Gg: AeBDieso8ZwI1fMrIhrWlvMgF3+eaPpfArmkxC9enEs4za5JyJ1AfMbQdgn4LCX4fPp
 +O5e4gP5pOFYjAJiatcZpsehR18lwnR++iFSngviYLoGUUb0O5fwn6kwi5Ik8x8qLj51vGR9CaS
 I2tIr3mSA/eHPeqB/ECzDszokUSgqgkSUbR/L/8kYqGHr/QDVtDFVbA29CiQpoVjA8IMhsQ1j6P
 7qKsnUPK8w+l+QiLKA3BjHUcxkIHkmETreoa4QlroXs4JcvRy2Rqxg3LcRUb4xlHOCAWl3Vr9iX
 NKCR5ZuoFtyTcog0/bfbtOOHd+uJv9lLT+G6T6s6SaS737YQKpeLWr2UqTU+JkJCXd4AiSZU59D
 RZF3Ps31zeLhKwWx4/3PN75cs1VI1HNj4RdsQSqRPSL5v1ylhGADe9YnJqsFkKHK/rNN+9dpEgf
 zErXXQDm6YTsFaZk9ejJ27ZD4YZHJf4AfSvRk=
X-Received: by 2002:a05:622a:1b01:b0:50d:9e69:80ac with SMTP id
 d75a77b69052e-50dc21f98e0mr22602491cf.28.1775694927126; 
 Wed, 08 Apr 2026 17:35:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1b01:b0:50d:9e69:80ac with SMTP id
 d75a77b69052e-50dc21f98e0mr22602221cf.28.1775694926707; 
 Wed, 08 Apr 2026 17:35:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cc5f90sm5240187e87.49.2026.04.08.17.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 17:35:24 -0700 (PDT)
Date: Thu, 9 Apr 2026 03:35:22 +0300
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 12/19] drm/panel: jadard-jd9365da-h3: support variable
 DSI configuration
Message-ID: <66643qwarl7jj663wlzpxjgviyzgpj2b56ixuzm3mb56yse3yo@qgplpii2ucfk>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-12-5e9119b5a014@oss.qualcomm.com>
 <CAD++jLnAaUzHun-i7PBLzFQmsKCXXfRO+4hAgTFCZtLm_Bu6iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnAaUzHun-i7PBLzFQmsKCXXfRO+4hAgTFCZtLm_Bu6iw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: u_S4S-qKf71Cue0ONs6ljuM4H2FYCVQb
X-Proofpoint-GUID: u_S4S-qKf71Cue0ONs6ljuM4H2FYCVQb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAwMyBTYWx0ZWRfX/oJDY6YPGXLX
 TsOeeudSZoqsUXtTIc76xz3MX9CjGjpR8qBLECVhHIGvfhY+hh2hMNvdm9FlvkQfcrX03GmBMbn
 bBiIta8KElSZWrJI89XvZuLQmfSgtCNZHNT7KJeTijoWGJg1xTmkg0NokD+Eg009n1e3S6x5+J8
 1is5OHN6uMZczxRCeMOTO+Vvdo0h0p30Zj5uoHoI0OuuQN8SK9wHLS5mJ1ARF5X6mzxNeF+/A0+
 TXCBkES79SrzOSmPrFlh+f98QhmAiPnctRzVrXsggfQnmTRx8/O4k5D393Y5lPv5j6DxPLUYenS
 pcZz4T7CuesAa+78XycSniU06WN69k7Tg/F3qSKjI1FA8/IjeN2XYHItUwQRx3MUe+2LZtgoWF3
 Im5WUn0cBgN7sdJOsy/FJuL7w4sWa1bGfbo2yidqa+IfhPVRkFV4Enrf/YPLMWuovF9q5KgLPTF
 SasSVTQ9C/b73ZJRFBw==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d6f44f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=yhDMsVvX-kmwEEQif6oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090003
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

On Wed, Apr 08, 2026 at 10:15:13AM +0200, Linus Walleij wrote:
> Hi Dmitry,
> 
> thanks for your patch!
> 
> On Wed, Apr 1, 2026 at 9:27 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > Several panels support attachment either using 4 DSI lanes or just 2. In
> > some cases, this requires a different panel mode to fulfill clock
> > requirements. Extend the driver to handle such cases by letting the
> > panel description to omit lanes specification and parsing number of
> > lanes from the DT.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> (...)
> 
> > +       if (dsi_ctx->dsi->lanes == 2)
> > +               mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x01);
> > +       else
> > +               mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);
> 
> If lanes 2 we do unexplicable magic A else we do unexplicable magic B?
> 
> Do we know more about what is actually going on here?
> 
> Can you check the datasheet?

The datasheet (you can find it) is pretty useless here. Unfortunately I
don't have a second source of information. As far as I know, this
value maps directly to the number of lanes and nothing else.

> 
> The patch is nice anyway and no big deal so, so +/- that fixup:
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> 
> Yours,
> Linus Walleij

-- 
With best wishes
Dmitry
