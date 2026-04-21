Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EADAF89256
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C32B10E880;
	Tue, 21 Apr 2026 10:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="arh2EjKO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kh9hfHPX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1091610E880
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:49:40 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LA3O9A1085680
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0kxXr375XYtQSccstxrcJdmfdnVBc/C1d7xSRxVxEqE=; b=arh2EjKOh5dfjwUV
 weP+Vp90WbGJFv29m/ZeBKHBy0Kjr55r/t05HDJoSKKjjVfDUA3h2QRt8VCuNf9v
 lPsumsSqDO75ZBNh4FyRJ9NhfqosZRcSrmkKhNl+InqYnmypUCV0RJUZZ+N+vfOn
 fHKId2pwtEHa5wnHqxp64IW/9picdVhS18Pbp370kUVaDxao9+34XSjzORgDoCWL
 puSW7x6K5SDDk8fJtK7p6KBDuy4BGUnmmKH7BavFNxSid5XBh0CYRg2zGLrtzFK1
 bxxKW/hnE8bWiDJNbSgqP5npZ+sroqkq4neGAZyxLPrycLLJl03xVJJd0sO2aORl
 yy0JIg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp75a84tn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:49:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d63962d83so55964961cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776768579; x=1777373379;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0kxXr375XYtQSccstxrcJdmfdnVBc/C1d7xSRxVxEqE=;
 b=kh9hfHPXJcV+jbUuJ0/7X0AFO/J4d/ywERKTx/NZzjOkWXUzkQmT4bG5VoqbnwiEv0
 z6PjTia540y8r6YmNSBGgM1ic6z5nCt2/7fqrROWLoORdciG36FfQHEc68M4u2GQevJF
 5YI+302WDyhInb13FiKgcKZyw7EyBUmnI8z+p455Mh4FBxmgFfGKJx2LiXiBDfNQ5H9A
 Dk9pi2LoFsltUVhWZDekUiWZJfSg+NI5WKsbLFyI580JEzgHa4OeahDJFOyQh4RohNty
 jzRMRJxYPmPvWenOTOj+/CXRuNUa6YIGM/cFBWk6QEeytgEp+k+SDpS9c3/8VvbI6s3G
 f+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776768579; x=1777373379;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0kxXr375XYtQSccstxrcJdmfdnVBc/C1d7xSRxVxEqE=;
 b=eeia3VA8xFIhLfBcv9JYi0oesf/caBi2eaSLBq7cgvnuH1+x22w0/SXJjydGquLmYk
 u+z7fwGncuiE6JayJcLBq+QvfeNSBMNkmw5VokNwoQAPFuVVVlGZwWOOyUYeULDwbnq9
 N9RNv0PG2kA5C3SV4TFQzEquDtw1CDLqfOj+AMnYiliVlaxEA+lEVOhO7EphpzelR+3U
 PEkgzTj/Hyn96SpyXU3KOmCfSzU8EAHf8DYXmYeY/i+1I1EyQKynPcmlyn6Xwcu1kAAP
 IRooPTB+go8fRxWchUSxwWoeOZOQ50WR+VC3v2CGvqxVLWWy8uilQSv6Y5EXgeNyzGj5
 1f8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wmJmo19nRvOYZfC1o5t7oUcYWGRGO/Xeu0H6ynhWx/hr7GIc0glkTAU2YtpZN0DBTQZVP425NXGA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFiD9MYb4wgpzBoRfEpLxLR1xYpTZH+IbudoExWDmE01itORnL
 0KeyOypTnulG7MjaRZ/kWmpN39wFYHxlYI5KbGlqNVbDussW9Kta2J2xjImiAGjmGZnOs6DRz+H
 tTGbxeJy3zueUiOLlHdJS1wS6QZCrW80ijKB/8m22kTftCiRnZAIRkUQVC/0Y0URa/BuIkzk=
X-Gm-Gg: AeBDieubZXwtpiexcPAZQuPcNU9sWulm64+AAY8JtPl4VDElUeXuCxOdlVEMcu+TA4i
 2PeB0JP9TiNQ7xJkIxXXZmiMKCW01tR/iytWsnUbbejaD/4SiP1Zrs9cOEtNcLnC0AFZGkA65FX
 Tego7ZqXSMNLfabvXgGtFQEL+yJlrjIjDfs1X/MdbBBkiwNmXbViW43muaKvCDhGYeuhlB0hwu4
 nBVc86t0OE2wxtkliczdhqvwoOxeUcjHK9EAB+M5nVFJnc99o98Q3KxyO/Fpo4PthexsyXzystR
 AglirGRAbhcr6jOO7Z+SwjH2yjcSxAz7zFuRriIR1Fgqo+pWPXm/do28xCNwxIXusS9awP91E52
 ETLBEEaqQqGlpOrjcHou5gtPLLY9AUc1EaWPYtpxgsxgiEFx2wDAzR3icK5d+VjJ2KZm2l4memW
 cLn2SOJImXVh1lowvkyhOJW8GpMATsT3EY2e5oToHL4JbBfQ==
X-Received: by 2002:ac8:5987:0:b0:509:1579:7c38 with SMTP id
 d75a77b69052e-50e36e9be9emr267738391cf.35.1776768579414; 
 Tue, 21 Apr 2026 03:49:39 -0700 (PDT)
X-Received: by 2002:ac8:5987:0:b0:509:1579:7c38 with SMTP id
 d75a77b69052e-50e36e9be9emr267738091cf.35.1776768578971; 
 Tue, 21 Apr 2026 03:49:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0b8sm3595646e87.15.2026.04.21.03.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 03:49:37 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:49:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com
Subject: Re: [PATCH v3 0/2] Add LT9611C(EX/UXD) DRM bridge driver and device
 tree
Message-ID: <rg6zbch5ihz44fwwek7hqn6nfgqtmi3zetynn3rekdezfgozyq@4hy5va3fpvw5>
References: <20260420061644.1251070-1-syyang@lontium.com>
 <CAO9ioeVFHn3ARCqL0NJ9jRCJV2P9-Ky2c105iF7EwLUG-cV-QQ@mail.gmail.com>
 <CAFQXuNZd8B0spcF2HNNRdF6a3UxELaEriGssFXL+se5dhoLj5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNZd8B0spcF2HNNRdF6a3UxELaEriGssFXL+se5dhoLj5w@mail.gmail.com>
X-Proofpoint-ORIG-GUID: nzhQw1assaKfCp9lvZmUOLZpqf6XjP4h
X-Authority-Analysis: v=2.4 cv=Fo81OWrq c=1 sm=1 tr=0 ts=69e75644 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=e5mUnYsNAAAA:8 a=VETm-ZgMAAAA:8 a=BKPnJh3IeGRwXN2rGlYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=RuZk68QooNbwfxovefhk:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TSum39mKrd1h5-tZHgHT:22
X-Proofpoint-GUID: nzhQw1assaKfCp9lvZmUOLZpqf6XjP4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEwNSBTYWx0ZWRfX3lx+8j8zTJsq
 3P4q+i6dQrJHcPEVo9LVvtQ8mRAIGRiLKS9SA2ek1/XqwmkH0tr2MpI9XmOPtOx8wcTWCOgxyT3
 Ua8lg/VvaIsKpJ2XG5EcpXqtkRc4DBLl7XJXjaFbPLjFwwoe9YxmJwUbQEn6A+IreZ/DfQ+PxJ+
 JsG7VdVn2M7A2KVWsga4fMhCsdGXQdzXciZaKNoUmQQLKayT3+GwURjXMLoQ16zKTTcpCD09CzW
 n3NJF0XAxbOc6jdM/AgyClh0bJSO/7JACxU5iypCaHpcrxG/eXBFp1HlfGvqtAA1SfMtk87cQdl
 u3YsS32iQQ99357qjswl6EJ4wGO80C59xofv6sOa+4vFTNVApFI79iNxWltjKZQY8RkSMw4RY/Y
 fEAWrbxuDjEXxgdS/e11XlAFh/fF0CSEzLdm9uHYabLWPKVQ3Qn+4VOgclG+dyH+kgzP2KcDSrI
 kszfl8KNJ7R7OxYnpnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210105
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

On Mon, Apr 20, 2026 at 07:05:58PM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月20日周一 18:45写道：
> 
> > On Mon, 20 Apr 2026 at 09:16, <syyang@lontium.com> wrote:
> > >
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to HDMI
> > > chip:
> > >
> > > -dt-bindings: bridge: This patch adds new content to the
> > lontium,lt9611.yaml
> > >  binding file.
> > > -drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD)
> > chip.
> > >
> > > Signed-off-by: Sunyun Yang<syyang@lontium.com>
> >
> > Once again. Your messages are not reaching the dri-devel mailing list.
> > Please fix your SMTP configuration or start using B4 tool and B4 Web
> > Relay for sending patches.
> > Most developers wouldn't even see these emails as they haven't reached
> > dri-devel.
> >
> 
>    is it dri-devel@lists.freedesktop.org ?

Yes. Currently all the emails seem to be reaching dri-devel. Maybe there
is some internal delay on FDO.org.


-- 
With best wishes
Dmitry
