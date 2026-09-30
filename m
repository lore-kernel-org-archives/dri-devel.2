Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC128CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F394810F399;
	Wed, 30 Sep 2026 19:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bwt9pseH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkYbwqML";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4B610F313
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:04:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UIPIQB3881862
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n+yNVJmf6N6JAqx65mEM5Tj02xGBuXskr0wTh+rjirk=; b=bwt9pseHMIHAfkSc
 bn+n0tlrDMTjIlSMiibMFrTlfErRB3rTVKgiJlIPiWi53RIObkXBTmBIJyBbnqKo
 j3FdIl7rMcrCLMKsmaXi/OWwgL8eP5ZuW5MFqmURc/AHBeK84hdPBggrCGo9pCrB
 CdMk0MFbSvlvZYwSu7cpvE1LA9pd36V/LosmsvjfxxxrqUJO18HyRq9MXzhd3QT4
 plHf5a21LnytTrUUg0w5KcpFwVx6I9DKspAU5WdDWZ5TjVJUT2Dl8csmOeXiEBrm
 822cmtag5qdNaRnVKs7YVubmb5HWKCio+W20lsaB0UT9lgK3zy85rWInNFuEo6yG
 EJIAyw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pj85t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:04:35 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7b335ce0f18so797688137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790795074; x=1791399874;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n+yNVJmf6N6JAqx65mEM5Tj02xGBuXskr0wTh+rjirk=;
 b=dkYbwqMLj9yJQuJHoJYOBOoPs9PjXeyKum20mX7gNgcrihgZrZ32fuyFedpN+9JAVx
 ZRQyhI5x9FoqcGd5O2HHhXEqGug6xDrY/8ERm3JDLd6jaF0+IQyqu3lM+YgvLheq8Azr
 4UKDTR8VPs55hThtFC7Ok2iDEeIj/FDqrZSsqTTc44l5KJHoym+A4OYYFK0o5qf2tX09
 aMAdUbNYRcoGedTbcKMo2CqqrOeg2m8Au8Ut+qHIwT7tnJWpW2DiCSBp9TC4una2JrIP
 F7UmVU4hqNznilBwCk8r8lLD4NGDvkexgSbMs9BnNJkPAwVZQPr7p03XbAzRvVTAS5Od
 lVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790795074; x=1791399874;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n+yNVJmf6N6JAqx65mEM5Tj02xGBuXskr0wTh+rjirk=;
 b=Ude9jyNIfWbvEcgoFbhY12rSTNN/nX6n8XSyGWUtRSTGbCYHe1YRkzj6SuUnDr+z7q
 ZVBthm21n8sYnn6QYbkuIiHrfF0MgtHYprWv9zNn72snyNpSuDLX3M1UE7QRJOpcRRMP
 19Dl9fcKAWc2GjTIvIjEqqi7vsnNbWteyZbu59qc5tHwa/BYLLrLdV3d0WLNE1pnU9GO
 QCswSG4aFafJ4mMJ2n1fpuots8KdF2XOosyFuX6Xhzoa+7auRbgNa8zbTAz+80/yw13V
 gPQM3E9O8W0hRH13DMvAZukPyuwtDxNWa1sHefRmsvLJTWDItA/0nq/eTmOeuY24/1n4
 p8nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5MiheGGKxeqNJpNp9z4t2NHVRmDGE12ifAEWM5iVFw/E+bfg2qyEOryt6jYiINtyvrTCb7sSh7dE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLJYTG01C+0Ifo7+wjyAcCy4e92n/uTwICK1jVSjxEgqT1HEsRu
 RqfdMjzw5EF6m5xRhPsdx6GyhzYqla2ivmhiTjwzTgGFl3zA7K9QsWG2dMMRVG8XEEn/QeWnW9k
 8dGd3m/9xy6Hn/vFv0Jz3wL30xhItZ3fnN+ofZTEnZN9d5ewynCYmEUQqSeqxNIAcY43ikBY=
X-Gm-Gg: AYBFou0RPKZuGw2XUWWWSR8MIbrG0w8ftBQ4FY3QAl14764gwRJ+8lfhU7WM5PJu879
 La1wqV3hJXfTjZi9GNZtZCOCgiKXjo0lUP+YBwbYlWdGBvL+NDVhbYocxO11RCTuOVj+1eyNtts
 P0ns/5M6RkJFbedLjR3RZFKgSdtNXrcql4wlO9rB51NndkhC+UO4nOCTpu3ekcON0eyKm/y7Vvi
 XcPg5ZsOD1g4HNF2YFBA8DDWRi5QpG6K2P2p+LPq0rmABnS+Rf6LfLznTTOVmnvQuG8N7EbGXs+
 SlERJGgVjmN3Su8By7feoElqludoPBQA4qan+M6hYyQOUF1Ox5+pTCTUX97MpYhXbznQLGt/qPu
 zS1VV2h5kGEL0Ier6vnD8k2KfH2kaYOs8HGiwtg1e6HI7t4kihWdo/E9VeSilt0sYZT19ZcBs+r
 fIK7NTlyrDPYK+
X-Received: by 2002:a05:6102:41a8:b0:7a8:f2be:9517 with SMTP id
 ada2fe7eead31-7be733a564cmr586801137.23.1790795073929; 
 Wed, 30 Sep 2026 12:04:33 -0700 (PDT)
X-Received: by 2002:a05:6102:41a8:b0:7a8:f2be:9517 with SMTP id
 ada2fe7eead31-7be733a564cmr586784137.23.1790795073234; 
 Wed, 30 Sep 2026 12:04:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbc4a5sm174124e87.63.2026.09.30.12.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 12:04:32 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:04:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
Message-ID: <2lcpzwh7fxecpffnakpnp5lecrm3e6u64ztat7cd75nuxofxa2@clj27bzgjy3r>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
 <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abd5d43 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=vnREMb7VAAAA:8
 a=VwQbUJbxAAAA:8 a=twE6rBcdgA2BTABM_JsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: 6cU92MairuF5SAtav1fgTgwhDyJKF3mD
X-Proofpoint-ORIG-GUID: 6cU92MairuF5SAtav1fgTgwhDyJKF3mD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3OCBTYWx0ZWRfXzz6p4qT6Yh+S
 E6ssSsDyrSbECUsJ8y5yD99VMXVufQb2dlrAXjzulcQInfo1cs7sJ9ZfNPqdLh+DP94mNdItO8y
 ZWJIX0kZGrWIT2nUd0gBSM5vy3tgR7Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3OCBTYWx0ZWRfX5ocoZg5qsikt
 KN1hXD4g62AJT/kUyZb86furooQtld/mUxCF4KDMeTxDyXT72I8oloy+IqNdfZBkefVXyDJkUF0
 9i59GswcNJmkLwhiTHIH1K8QyGJsLZShFoadAT6gokgxWz4zhVdbSPcK5YtDhaSxAyWQJiWa5uq
 mKtTZO7yXiy/EM2kkkyvpd7KqZpwrbu8jJ7GY79fXqVVQBRCrfW1pFLqsXDi6/DS3lQz8B5QwkT
 XAZB58hptF3xbgVJj2ZKk1yblXuUORrKvl9rbuXCG0i3oqy4sv2Jk/qUpPY0O0eGRrhu0+uag7M
 5rQmzlkU/BDrc9C9+I0Fszn7mi2BcYyYJttUFp7HKjTGLCXuRLtDiB60m84emK0yQ5t9PnzJsdz
 yGSte/RLM3a7MVxFl7j/gZoS2mOHrBHYfoWWqLtjkaqOZSOFQanq+ouR6q5gBFHbsMvGT8wan10
 CkTjbTe0yZFsCorPHhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300078
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

On Wed, Sep 30, 2026 at 06:43:47PM +0200, Neil Armstrong wrote:
> On 9/30/26 09:44, Linus Walleij wrote:
> > On Tue, Sep 29, 2026 at 3:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > 
> > > This entire binding seems like stitching two devices together, which
> > > might be fine (I don't even remember this stuff... two months old) or
> > > might be artificial grouping of separate devices.
> > 
> > I think that's a good point and fair pushback.
> > 
> > Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
> > https://www.youtube.com/watch?v=6tNGW8PoSzw
> > 
> > The current binding does not reflect the physical topology of the
> > actual device, and the bindings need improvements. I have a feeling
> > there is one display controller with two physical panels.
> 
> No there's really 2 controller and 2 separate panels, but they are not
> classic panel, they are a pair of panels+lens which are in front of
> the eyes which forms a single "image" for the brain, so they are
> technically a single display and requires to be hard synchronized.

Yes. However this approach makes it impossible to share the code between
the double-panel drivers and single-panel drivers. I think, that the
panel driver should still reference a single glass+DDIC, while letting
the DSI host driver to handle the bifurcation.

> The R63455 is designed for this exact use case and are only supposed
> to be use in XR application in pair.

yes, but no, but yes, but no. I mean, nothing prevents one from using
this DDIC in some other usecase.

> See it like a single physical panel with 2 controllers which
> shouldn't be used separately. While technically a controller could
> be used to driver single panel, it's likely impossible Synaptics
> would sell this IC for non XR applications.

I think, this was causing an issue with the DSC too. A normal
bonded-DSI-panel-with-DSC and this-double-panel require different widths
to be programmed. Having a panel report real resolution would drop that
quirk from the DSI host driver.

> We want the both panels to be seen at a single big panel because
> physically the human eye will see it as a single display.

That's the CRTC side.

> Describing both panels into separate nodes would only be possible
> if we described a "VR display complex" nodes linked to both panels
> but this would probably be solved by actually describing the "display"
> linked to a DDIC controller and is out of subject for this serie,
> and can be added later when we properly define things.

I like the VR complex idea. In the end, you have two modes which you
most likely might want to support:
- L+R, having double-width CRTC scanning over a double-width framebuffer
- Mx2, having a single-width CRTC and a single-width framebuffer
  displaying the same picture to both eyes. I can imaging that knowing
  about L+R might be an explicit opt-in feature of the DRM interface.

-- 
With best wishes
Dmitry
