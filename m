Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E838F483D7
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716F110E4A0;
	Mon, 23 Mar 2026 19:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJRs+bYa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyM8ZlfI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A54610E4A0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 19:26:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqj5I2971973
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 19:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7dPTef1e6jAQ0fE4f4FsGbPo
 ArdFqQ4ib1xYhnmmN5A=; b=CJRs+bYa6Q/taOndhNL76Mg+3vW8Q9IUMX37hy+J
 hN3LAFq5wNmqdvCGWIxLTraoiNQG7yVqWWuzzi5xM1vbsyzbzHmGaDM0c/oV4RZs
 ShqlGsY2ZBHHUohHUGm03Ai2sx0PpJ0YVdQesTUrwx3QHZZlU595C9hGEnH1XfRm
 OFN/Ij/dPPUCL9Oyp3/iGlVzkZ3VLWoppfTp/TUANrAtblkEwUaqGekI0sTyU0HI
 YS4UlotmP3+1QkYszhlrs93BZvj+FgPY3eV5+ePl5H37aQiF3iXsKbGDjXMNRKRw
 /UQ1Sz8hUl1c64srCXeLR8ImohWwz9Jf2mrc6m+MWGiTGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc2fm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 19:26:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5093a985e21so344337581cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774293998; x=1774898798;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7dPTef1e6jAQ0fE4f4FsGbPoArdFqQ4ib1xYhnmmN5A=;
 b=PyM8ZlfIlOdbejqttuG2JNUoi3ImtqOGtpglQOXIdIgDhTMFJmsQXjFl1sZ5mzVLO0
 C5J7Hi5zXnGxnznwPeN4u+30vaSxnRVT8volTlhji/+Tw59qsfSRqNqygjAmzu9gaBSQ
 B46ILZOT54VwRFE314DUUNp+R3giOKfolgfadbSuFeqk4r+ngrO4wmTL9MPsx7D3M+5a
 YhgWsy/QGjR657XCNuMX70ehTUsM1yWyAvW0MkPR0m99W19hdYnE0WcIXVCEP6SEzq0t
 JEhJeZLOca+n55t9zhgfcfHIHvakoye6JlwLk612DtE1w1m7aF8W5bCl4fJVJOWD1/dv
 K/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293998; x=1774898798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dPTef1e6jAQ0fE4f4FsGbPoArdFqQ4ib1xYhnmmN5A=;
 b=G6JzoA+bRmyaV4gUd6Dqk3r+OuPK+PsrTlcpFx6JzaYE7mVcRHyH9y+0HAQBM1ZSgo
 HidfQorJQhozyyyoBUfehFjtzW4hfGs2Du2zCnRPqW9UIzZM/gF3DRsD/GYWLh1GTx66
 di4efi+KOnrPjtYjgjYV7Ia20SNvoaa+bc0QzkjB1sVJ5wQ+Ei7JYwT6LlxLk00k4gVt
 sGCTw3z5buAQ91RX4Dz92T3ec9c7C+kLDMuS+z0v2s3onSGJI9GQhpDxl8rg/AUhXHRh
 fNmwnxBJrPfuN3TnmRC9qwCK+FkIu0WGTYJXNA+ChrdDk/dogH3XROUkk4cRhkBu+spS
 4n0g==
X-Gm-Message-State: AOJu0Yy/EU4O1nHKjq3mEqPTezV4Ea1McuLiiBZWSFFbM0gjGRu0Io9s
 aa5CzDjKcHE6EFXoX7VYh4Va+cn+nfmZ4nnZEdFOAexRJDxZJ3fZbmDigOddTItO/XFMfO6BwLv
 wTgOqz/9VGzRfnKogsT0WoT041H2zxqLwcxnPli8QuwjiWzfoxfqEPnjDWau4nPzw6Y4G7Ss=
X-Gm-Gg: ATEYQzwYyMFyOo0sLh7qU8Dr1KH2DUE3515Y3v7srrHEn3zkzLbB+iOrDVSh/GzyCHm
 /qOKL7Q8iA8iSMopMK78LEJSAPWiIwjYyoPWBRSIcrx7x/8gnBjY40AP7qLJECybt0vJz5NPrq8
 jQgtItBPl7zaPdUyFBN+Xnklhp6dVMW+3hthdjTZ6f2KFeLfD0LKMLvFR3fJZPuZXzECKJSjyfN
 Qp/ttWJg7CtUy9xvK2P1w7MyIPdw+LrA0g3p5TIrrmVVcYfyJpDMoaXTKdE49957iEv45jjXz3I
 ExONfZVt6/MfRnpXF7ppjnN0Tg3SmQQR7T8F8FTo3cSFYAHYY5gJDCLYcWu3wGC7tr8XA6cNmIJ
 4AVBEUudvZr1ICCohL3xyvC7+XAAaVQkG176+Ej581FNEa56I1RxHWBc9FMVy99nFXeSrIwkaTV
 WeJZ0CTLS4TDv2eGvhAulkY3vbTa7Td+CYOXU=
X-Received: by 2002:ac8:7f0f:0:b0:509:2222:4202 with SMTP id
 d75a77b69052e-50b375f747fmr195307851cf.71.1774293997672; 
 Mon, 23 Mar 2026 12:26:37 -0700 (PDT)
X-Received: by 2002:ac8:7f0f:0:b0:509:2222:4202 with SMTP id
 d75a77b69052e-50b375f747fmr195307521cf.71.1774293997200; 
 Mon, 23 Mar 2026 12:26:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851ac69fsm2773829e87.32.2026.03.23.12.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:26:34 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:26:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/ci: add sc7180-trogdor-wormdingler-rev1-boe
Message-ID: <fs6nbg44r2ralxrkuc7slciapnufyyw6derolzlwzt7hjxlx62@vftuo2vmfpom>
References: <20260224081036.220820-1-vignesh.raman@collabora.com>
 <hnlupswfdkrzv45y6jl5x5u25zp2k642z6ordzthqbdw4azhxb@6gz5hx4dcujc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hnlupswfdkrzv45y6jl5x5u25zp2k642z6ordzthqbdw4azhxb@6gz5hx4dcujc>
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c193ee cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=MvT_i2rHHVxhWai1pmYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: At3WGFPxkMyjFf8aMokzFEuN8E-Oqpxg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NCBTYWx0ZWRfXwVo3Z5FJXEmd
 gNhCUXVl7/mpPBa4EuU55zMGC7uZRYQv1lGxcjMIoOc4R1Y5dZdb46N4+ZBmMTEsM+PSYIqmElw
 LYX0aUGbWcF4gJacWjf5GRlmaeDVIUe0s9/HBufewHS/LrL1I4UCk2hNOd3WAoWlxyBrtSf0czX
 0Eh4+WRsx8GFUGy04EyFVKVzgJxkIDAjLfpz6DE1vpBW3Um8EIYXcK3vk33dYoW28CDkrQQDOAT
 lSI70iAoWJXRzVfmMS8sWvGyY6fJDsBQRvAdn+f9Y2kLXVb5cBO8JMRcKsm9Gm6yoiZOEjzRqsR
 JtcdzZUa1SFD2DJto5mdrxdOA+0Osnx9tSX+BRozMhn4kyaLSod3OCnvP8KT59ZpVV3mWQg9CJb
 asAGEbY7BQMhkR4gvTvCEKQx01zY72zM9rc7KNVAz+Zh1kzNwK1aTngN1EWARlhKhBYzbqQm3AN
 Z58KqGqMRVibQNl0Ygg==
X-Proofpoint-ORIG-GUID: At3WGFPxkMyjFf8aMokzFEuN8E-Oqpxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230144
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

On Sun, Mar 01, 2026 at 02:23:40PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 01:40:34PM +0530, Vignesh Raman wrote:
> > Add job that executes the IGT test suite for
> > sc7180-trogdor-wormdingler-rev1-boe.
> > 
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> > 
> > v1:
> >   - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
> >   - Depends on https://lore.kernel.org/dri-devel/20260210071138.2256773-1-vignesh.raman@collabora.com/
> > 
> > ---
> >  drivers/gpu/drm/ci/arm64.config               |  4 +++
> >  drivers/gpu/drm/ci/build.sh                   |  1 +
> >  drivers/gpu/drm/ci/test.yml                   | 10 +++++++
> >  ...180-trogdor-wormdingler-rev1-boe-fails.txt | 23 ++++++++++++++
> >  ...180-trogdor-wormdingler-rev1-boe-skips.txt | 30 +++++++++++++++++++
> >  5 files changed, 68 insertions(+)
> >  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
> >  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
> > 
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
> > new file mode 100644
> > index 000000000000..4af93eeeaf99
> > --- /dev/null
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
> > @@ -0,0 +1,23 @@
> > +core_setmaster@master-drop-set-user,Fail
> > +kms_color@ctm-0-25,Fail
> > +kms_color@ctm-0-50,Fail
> > +kms_color@ctm-0-75,Fail
> > +kms_color@ctm-blue-to-red,Fail
> > +kms_color@ctm-green-to-red,Fail
> > +kms_color@ctm-negative,Fail
> > +kms_color@ctm-red-to-blue,Fail
> > +kms_color@ctm-signed,Fail
> > +kms_color@gamma,Fail
> > +kms_color@legacy-gamma,Fail
> > +kms_cursor_legacy@cursor-vs-flip-toggle,Fail
> > +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> > +kms_flip@flip-vs-modeset-vs-hang,Fail
> > +kms_flip@flip-vs-panning-vs-hang,Fail
> > +kms_invalid_mode@overflow-vrefresh,Fail
> 
> I don't see this failure in the logs. If it is removed, then all three
> failure lists (and all three skip lists) are the same.

Any updates?

-- 
With best wishes
Dmitry
