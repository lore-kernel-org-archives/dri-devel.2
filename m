Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC06CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C9D10E966;
	Wed, 30 Sep 2026 19:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHZLvR+l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQDqNB0g";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE35310E1B0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:43:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UILf6L3655836
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 007PSKl5xLWMYdPRP2bDBtZ6gH/PmdJJeMhutR+eJOA=; b=MHZLvR+lJBkqEsIZ
 Zs/mnDoPFEP6EiqWdJtGzMF52HeZLRW2KXrPLQciTRjzKqomyUnMry4XKgbuVqWX
 eMK6bPuEYd+NOqe0CYLjR7rokFmy5StvslTdRKpoU0Bgs+2R+P1k+nKbuFkYbrxM
 bl9YZ3PIOZYVmFHOFvE0lAF75gqDOTh/mxpNb/lyf1KvtqT0F2UkTYUfC+cGaW0x
 Sau5pNyCk7VuPEJ4rZode64wBcZg8mNu96+Z+JHAKXM3/a0Tu3jDKf+02a01avL3
 J6Ab2+O/9cwgCe4/i8TURpLAtFv82pCcmSedUAZxrcdTsxUmBVQrUhfvQHTIwp+B
 ILN4nQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvr9uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:43:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so199639485a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790797399; x=1791402199;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=007PSKl5xLWMYdPRP2bDBtZ6gH/PmdJJeMhutR+eJOA=;
 b=CQDqNB0gKGFqD/iQbFyHVrn8cvmSx2J7/YFMx6Z3N22aXhcU9NSa3ntsR2gWc3e0fj
 f4q2XwxBfw/OJRxc8ZqD8uPoH+SYTW2OR8CuZlJmtMTadxT2ih3Dgc7Ff7d/7q1RZWVh
 PyusJLXISdCGOHlaQuEdSRau6Wk3dXWkgUXVfUIurhs0Zktb/bsPyNOU2f9RFtFPsOV6
 LGECCAM0I8yW/P604/eRn+fs27Qb4ZFq8NBe76Zt0FTa7gFTW/cwiXJ65dEqxcS5UbPR
 NylTNa6enP63/LP4DB3WgVNhCu+X3PofcZb+zJMFzrMe8x+m+K4rKdXJscCVW+/dvMpq
 +PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790797399; x=1791402199;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=007PSKl5xLWMYdPRP2bDBtZ6gH/PmdJJeMhutR+eJOA=;
 b=HWprL0JzZIiQTZK1erHPu3D5Caibe7q3apt4/tGRVkL+4REPAEXj9zOXlx7SB8FZpy
 D55LMuOgVU7JD4p/ktbtfoyPnx1Uckt+w35McaxJNi0Ii3qrxlavuvC8yj8mWT8AIbfK
 sO05/XhnP8AmfLmGW+a2JeV+X8Bs4bauTDd4aYKORGXZ2S6aM/X4I3yj7nXy7PmCTgYI
 9HrKsvJyM6n6dYU2Og3PUc5IpV1eCDgLKvGnW7zQDQH2FdHhXnPjMrxK+hRxSy4odr6K
 29tHOeU9sMDsJeE18mfQHjtMHsWxv6Qyczo23M8Tam19wSDsBCHuMwxIyNcZNdlX/Vzd
 KDJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP0yg7rKA8XUiO5B6CqhYNSBl+xFyj03qk3yj7SiizQISX793YG7wHZ9B1GEwjVzurwfNZCcYuwFY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnw5zy1/pj68crlcgjvXTwspeDMZc0Awk+6YrY3lPH4FGXcUSH
 g9oGwUMS/OJbF+oSYqTDnavD6XTTGKB9Y3o/fD0YiiPnp/0WBYzlh+Enx1L0v5HjsoUPDiFFHs4
 IZJdkFgb3wN4mtdcFwpYI4FZ+v7FNNbK3kyw1S7HLeYx2iSsB9h6Er2YIv7IVYpGaN+hnyEU=
X-Gm-Gg: AYBFou29waDMhYc8SlLcYZRFTqPY06mACMFrXXKarGevChibtQK3XoNKG3ZnqPSMlCg
 19te6dNcpWeAse8MVOt2jzM5/VAbSUpwsuuCKwiz+XXemPEYyToTbJW6m+N8tF5T6JPdGdxf4Cc
 m/j/rsanKsfKEsqsTtOsXTPNtxKCmo869mnX5NuYuU6BpeCySs0mIIg2fhs1qGBSHBkVufNkNip
 95y2rRdHLtx/JXnW3T0pbQi5zAQAvnFwJiDwKJ1UQpHD/culoYttD3Fk8XLKXqu7sTIKlV2NImY
 4be7le68KigNwGLiipyLZS2iUYZElru/HBNvQZfsCQwsa7bn2bRiuKvTZ3C04FWMNPIN6urcWn/
 Etd9hzTr6hGTAxfuhMo5M/CW33SDuulrx0iylfNMs+XtJiIRqV790Uk0HkQsxKOyQ3qXNipKL+o
 +QwEa5ePKdstbJ
X-Received: by 2002:a05:620a:880a:b0:93b:d7a2:83d1 with SMTP id
 af79cd13be357-93ca98aec8fmr429664485a.64.1790797399137; 
 Wed, 30 Sep 2026 12:43:19 -0700 (PDT)
X-Received: by 2002:a05:620a:880a:b0:93b:d7a2:83d1 with SMTP id
 af79cd13be357-93ca98aec8fmr429658785a.64.1790797398603; 
 Wed, 30 Sep 2026 12:43:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba44059773sm18477e87.11.2026.09.30.12.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 12:43:17 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:43:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm/mipi-dsi: Add flag to support dual-panel
 configurations
Message-ID: <kgnrsnko7u4g6bpxudfo6yqubhd5gcyrdyovjfkohlgo63yrwn@xbgp7jgv6ns3>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-3-c042266b9eeb@linaro.org>
 <gu22hz3dnttzyu2eewpalgzxtocmlbfvnpwore36ufmyr3xtag@r5bbhafsn562>
 <CABymUCNtcgbcRNXdMUjVdnH_ybOxjFB31gd6AW-0HCFDSn9w4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCNtcgbcRNXdMUjVdnH_ybOxjFB31gd6AW-0HCFDSn9w4g@mail.gmail.com>
X-Proofpoint-ORIG-GUID: vfC6qhV_jDJ3GMtu7Ra867bYmmUa1gJ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX0bE7zQcqCvRo
 jZW1jcBPv8NKCHI0Jpm3C5mVz1lFXexhQ7exwnERcLbl7EuU8TXwAi+zBAqobb0BOsWn+svDHF3
 +xrq/mWJWJKcD7pVJNf3xnLEhzP04udDcWgV4w2X8HDduRjrHAbya6rRjnSFSRsBFTCFhKsHcHD
 QyqT+tWn0Eg0uu9vFXhasGTEKMYZjOg+a++khSYwIX9zNE8oeJ2/WasFMxm8WCgBbzAAsddX8AI
 djaKQEqhCJ3tQZ+i/tj/Z3sAEG7zh5IOdpBBMg1dI+WK/BV26TvP4sOwhhA+2T8t8YDGwm5cKmI
 kHR9H9dwBGhJcOqeTPIdN3He2ULK8OS6kF/1nGPcvZkAynh78NX0uPlgJUQlx66+M/KM2Q+s/rN
 fBY4rt83IbfFNHLCz0Jy3K6DXhDUtYpwVVjr+xNkRRuaKNjH2hhneZNdyFJHmIVLXyjmC6zeGFJ
 kdKOBAxhQ2zThAB6C4A==
X-Proofpoint-GUID: vfC6qhV_jDJ3GMtu7Ra867bYmmUa1gJ5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfXzPJMd8L3HdC5
 akhpDFuwAVtuQ206+ItzdZE+ev9oPib3/Zj8+IvJeWzsaXJtZDXvGkPe7/olqGOkZJMmmS5f/EE
 GWh3VuJ3kgKKH8ntOqCcToVfpOFqdyU=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abd6658 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=gnaAZu_HdrVRTMOkdIcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300080
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

On Wed, Sep 30, 2026 at 09:52:48PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年9月30日周三 00:05写道：
> >
> > On Mon, Jul 27, 2026 at 04:08:42PM +0800, Jun Nie wrote:
> > > Some devices treat two independent physical DSI panels as a single
> > > logical panel from the CRTC's perspective. However, two separate DSI
> > > hosts are still required to drive the panels individually.
> > >
> > > Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
> > > allows a panel driver to inform the DSI host that it is part of a
> > > dual-panel setup, enabling the host to coordinate both physical
> > > displays as one.
> > >
> > > This change does not force individual panel driver to manage
> > > system-level display topology if the driver does not intended to
> > > support dual panel topology. Only the driver that set the flag to
> > > true need to take care of panel topology.
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  include/drm/drm_mipi_dsi.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Do you have a single MIPI DSI device, or are there two independent MIPI
> > DSI devices? In the latter case, the flag is wrongly placed.
> 
> Yes, there are 2 mipi devices, and 2 mipi hosts. This flag is used for
> mipi device
> to notify host they are one of dual panels, so that horizontal
> configuration(width)
> in mipi host can be handled correctly. Where do you suggest to put this flag?
> Thanks!

Into the msm DSI structures. We already have several Qualcomm-specific
flags. I'm thinking from the 'generic device' point of view. The
'dual_panel' doesn't mean anything if the device has more than two DSI
hosts. You need to specify which hosts are mapped to L or R channels, etc.

-- 
With best wishes
Dmitry
