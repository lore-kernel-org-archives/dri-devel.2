Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68AECA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D0A10F4CF;
	Wed, 30 Sep 2026 19:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iq+1l6iO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SuKZWSoh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E85D10F4CF
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:39:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfm1U238927
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZIwUVVn2XD5RlNtj5pFv3FY2widvV63M2fwz15YP7Ks=; b=iq+1l6iOt43+HODB
 OrP2L1N18QN8DVokSnxOSMoDoUYxGEViWcv2dXrfeH6pIW7NscwRUUD8yOm0ftDC
 hzY1EHzXXhkPcXAFxgqIg5AVuNU6sKBKLrtgSuUIz5x4KOgVkOIQRo3AbV7Gb9T0
 ORkpaU9j0dGWsf832oqkqVSEwYPal3KZUKiCPVkXsCvo8dTEFSs40d5+yh9CMvJY
 4jUSwTQlnMjY7JfGKNzXwh91020S0N1HPgBjS/2i8h97cECtAVb5+9kWhbQ+m5fd
 igmq3trzbanjXQJIHCO9jLIUv+3eyCazHiVDU2UG04Ycv6H6h7AoaHx0RxkbsVbo
 7i0imw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w143h02-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:39:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so888027385a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790797194; x=1791401994;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZIwUVVn2XD5RlNtj5pFv3FY2widvV63M2fwz15YP7Ks=;
 b=SuKZWSohclp37L91m5JVpntLPzXLC/ArwnPhwYcxoN8yR6WTm6kahp/88siL9A/Sw/
 eyntZrsCum3Km3yW4QRJEItDZSQ8NgxTiM9H2OuRyQOGtuJIfLO4zI0PaxcG7lu4OWYJ
 ZABOAy/ZwibrMKMaqYGEWnh49KSl1Y/f3g/WAbxf21gktUzMhJPo3YzF7os6XKMDVGhp
 afO2Dr1QrM2KbsyurXE+GhoMN3rdlLGmPMyiIuTGhB3vvYSD58Xoh6lqSYSsyVuLUxHS
 FYssmHAg2Ay04Srlfrw9JfJwmNVLhkyRs3clobxqyqN6HWade2Ob5TQBU2aCj5lrNkks
 cfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790797194; x=1791401994;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZIwUVVn2XD5RlNtj5pFv3FY2widvV63M2fwz15YP7Ks=;
 b=c3TNSB3Su/J+nQyKVO2QIMJJKH9dBnaPFuegxNT6j1mIF1xVtqI4K3RFhQHnXy06zC
 zsvKsSfUzJtcLu3l0x3QJ6ip2rv7tQSTjArUP//KgkxprUxaMl6K3/3HpydDOF0peCUa
 DNQhhuY9LCD8Hi+4vfwRWCk2O8/kG8O/jkdIHEVoXcA2pw7SA92OrmHbj52Wt+molFnB
 Ga5KWayOIvWylm+pr9zcv6zxehubsrcn6jQX3VEVnKbsWCvg/hyuJg12k22xxnaqAAXv
 CG5Eh4cg+u+++ds40ZbnWQbdPWxJ1TvRk6Z1MIqYCoRFI7w5SJbhgJ2Tt9GaQ6FnZyb/
 xErQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmHUtcE06SCOKyi4NEs+S72hjyRf8NAKwbfw6udTkWFULJwudYEGRhzSDNzv++mKSho3GL4WDg+qM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kM7emuY+wN/jPJu9cTOlIu6Cuxf3/CjS3ejANOTQ27DwF4AnNT
 sdhxbQwobYUPBq8JjAdMQYk9KYQPQIOeM6vYanapeZ/lJzobIP3qsnLo8YW2iF7dKCkq5XzpK/n
 jxzhn00Zw/MKZecv2Zm/83caKpfUAUEeg/r8zbB5N14Qf6owRjdmKnPJt05WSEOxQPcWevbY=
X-Gm-Gg: AYBFou1PfEtf6xqvh6gHIxeO+PpCx1VQ6v22pmoguJD/+jrZoloc+bXfj+IEamoQEgz
 o8lWT4Q1O6TMmCa6wtaKuJqOM8wQtnGfBrIWSPuoNN3jPXlXUEqVEugZMNXs6jtjxpy5wobCFUY
 lKd45JreX6I0MZHr9wYRcg02pC8Z1XhscPkR8L01HSGN+bxtmumn7YDCwd353dFQy0JX3SAzLmk
 R1a7PKB2fogTAhXN1HJUnIhCKcmHJJDKKP1FPVVBtB+hT0/8uhX8vvmjIUco6zX5F6ivGiRX9ta
 q4ZhrwXXJIpiU+yHT+H+zmkrDDvYV2LiBOXxpyWAUzC6x+nYrO8e6EwiqhnKjx1cwVYtJz7/ULw
 HcVa+Y3t/LUhAddDonXVHulJ5m3OVq8cN2SvqvMxy6rUtcWofBz3VagLVZ1NBmozREZ58csGZkW
 segtL6M1jP+UnM
X-Received: by 2002:a05:620a:4728:b0:930:9091:f0ce with SMTP id
 af79cd13be357-93cac0bc11emr385860285a.22.1790797193919; 
 Wed, 30 Sep 2026 12:39:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:930:9091:f0ce with SMTP id
 af79cd13be357-93cac0bc11emr385854385a.22.1790797193398; 
 Wed, 30 Sep 2026 12:39:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a7717f21bfsm9587661fa.18.2026.09.30.12.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 12:39:52 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:39:50 +0300
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
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v5 2/6] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <zr4c25viml2zz2wsveroirwg7ufs4ptlrv6tluqrjtngw7v3hr@firiyjbrj4cq>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-2-c042266b9eeb@linaro.org>
 <5r6xd4iiwnv2v5ji7xeddihlqstmtajvw5ixmntlwxxmcvo7y6@zueqflvz3lr5>
 <CABymUCP5Gs5Zx9C39RHj+1_mU7aLou9sfgZO=7yS=+fVPWHeLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCP5Gs5Zx9C39RHj+1_mU7aLou9sfgZO=7yS=+fVPWHeLg@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX5Rt+YiRT/jDU
 ZIGOjCH2iodRwp0rbWmjmb9rNsLyTkBjOM5dZs/zbwDaPsjubpA+tCqZAfiLGdYQf/a/IykP/04
 WLYc3vFyj1Ce0zfLOqDxICuBhyR9/4U=
X-Proofpoint-GUID: _MXEXSEad-m2CNkSoV9t6KEGu0UKlzRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX3a+U+C6a4jTS
 2pbV7JG0/jt2Wwx3UbV1auJV6JUQbJ2wTOAz1AIg72ST5TrQbRoPcV5apPi1rbhL61lUzZhLsFH
 4h178hPsFowC18G3djKywDBM58kDZtxDBxcvrNGLuxF8mNze+gP20BpKLlpLaxDQahb6spkc4m6
 NqbifyWzLez4qoKIqL7zC3wlD1HA337d5WFwh4F0oR2GoQsQwQ47oDyXtkirCT0NHN9vgaiskLK
 DMLDM0mPfdmIW5RFqmMohisulOs/DSbuzJnA1Zu4kfp3y2rIVnV3GBH1MsTobrmkpvBoS9sGTHi
 jfM7j8dfOYRhs5r/5adFkR16dRM+YcIK4Pee6UCZf9lMxfNAdk3kYR1eHfpGOyThddpznG9mWi5
 sq6h7wwKG/MBHbRmXMlqqnGf4d66ySqijW3fnspBb0VJgNYeoqhOv5g5HjCjxEMhQnYtPxGPNnk
 amRDkfrYc4Jao2Mt/9Q==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abd658b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=RAbU-raeAAAA:8 a=KKAkSRfTAAAA:8 a=GV4QO6qSl_99BXC8EjIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=JiizpSU_mAIq9zsZDqn2:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _MXEXSEad-m2CNkSoV9t6KEGu0UKlzRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300080
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

On Wed, Sep 30, 2026 at 09:42:41PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年9月30日周三 00:03写道：
> >
> > On Mon, Jul 27, 2026 at 04:08:41PM +0800, Jun Nie wrote:
> > > Some panels require multiple slice to be sent in a single DSC packet. And
> > > this feature is a must for specific panels, such as Sharp ls026b3sa06. Add
> > > a dsc_slice_per_pkt member into struct drm_dsc_config and support the
> > > feature in msm mdss driver.
> > >
> > > Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> > > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/dsi_host.c | 27 ++++++++++++---------------
> > >  include/drm/display/drm_dsc.h      |  7 +++++++
> > >  2 files changed, 19 insertions(+), 15 deletions(-)
> > >
> > > @@ -1719,8 +1709,14 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
> > >       msm_host->lanes = dsi->lanes;
> > >       msm_host->format = dsi->format;
> > >       msm_host->mode_flags = dsi->mode_flags;
> > > -     if (dsi->dsc)
> > > +     if (dsi->dsc) {
> > >               msm_host->dsc = dsi->dsc;
> > > +             /* for backwards compatibility, assume 1 if not set */
> > > +             msm_host->dsc_slice_per_pkt = dsi->dsc->dsc_slice_per_pkt ?: 1;
> > > +     } else {
> > > +             msm_host->dsc = NULL;
> > > +             msm_host->dsc_slice_per_pkt = 0;
> > > +     }
> >
> > Why do you need the else branch? Isn't it already NULL / 0 by default?
> 
> AI bot review comments reminding a case that panel device may be switched
> to another panel. Not sure whether it is possible in real world. Just add this
> for safe.

No, thank you. Either it can happen (and so it should be handled, maybe
at some other place) or it's just a pure AI dillusion.

> >
> > >
> > >       if (msm_host->format == MIPI_DSI_FMT_RGB101010) {
> > >               if (!msm_dsi_host_version_geq(msm_host, MSM_DSI_VER_MAJOR_6G,
> > > @@ -1757,6 +1753,7 @@ static int dsi_host_detach(struct mipi_dsi_host *host,
> > >       struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> > >
> > >       dsi_dev_detach(msm_host->pdev);
> > > +     msm_host->dsc = NULL;
> >
> > If you are fixing something, it should come as a separate commit.
> 
> The same case as above.
> >
> > >
> > >       DBG("id=%d", msm_host->id);
> > >
> > > diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_dsc.h
> > > index bbbe7438473d3..c522ab3d71853 100644
> > > --- a/include/drm/display/drm_dsc.h
> > > +++ b/include/drm/display/drm_dsc.h
> > > @@ -267,6 +267,13 @@ struct drm_dsc_config {
> > >        * Offset adjustment for second line in Native 4:2:0 mode
> > >        */
> > >       u16 second_line_offset_adj;
> > > +
> > > +     /**
> > > +      * @dsc_slice_per_pkt:
> > > +      * Number of DSC slices to be sent in a single packet. This is not
> > > +      * part of DSC standard, and only used in some DSI panels so far.
> > > +      */
> > > +     unsigned int dsc_slice_per_pkt;
> >
> > If it's not a part of the standard, I think, it should not be a part of
> > drm_dsc_config. In the end, drm_dsc_config is also being used by other
> > parties, e.g. DP or HDMI. A year ago I saw a version of this patch,
> > having this field in the struct mipi_dsi_device. I think it's a more
> > correct place.
> 
> I will move to struct mipi_dsi_device in next version.

Thanks

> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
