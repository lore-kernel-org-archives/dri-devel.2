Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AF1FED9F6
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6941510E5EB;
	Tue, 17 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDpdg9LH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LMIdB5lS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A08110E5AE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:45:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HG5ZXi2977512
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sve/0XHVXakpPoL6EEAxjWXr
 d/xyFE0tTXS0gGte2N0=; b=nDpdg9LH6CceQx9RwAn5zn9AU+Xt2QzpPN2MYRF5
 3INjPlpOOCTH1DZA3EqWY0MRvluGeq6/EnccZEF2Ojmbx7ixmZOmQYNCBFPdhN2S
 Mou7xh+70D3aGseV2PFHlzu5pJrdGNxr/ioc+/iT6tFdrg+cmA2DyPoIXH34ZgkQ
 uPMO+Rumub2H3y102PI5ZXEzxqsdkz2kAXl0LwNxh7OrVz+TXFXuxZZ8MFMSFvMR
 w3th+G25fSoxgTOQIo1BqBaFch+QknnSd3VjhohHtf8zypOGIyK9bIlLraiUPZP9
 xlZj1snVyEJQ0I15FKhOT/qHeYeR2L/Sfn94N95vx99K1Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya62re85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:45:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89a17ec1eecso123305626d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773769529; x=1774374329;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sve/0XHVXakpPoL6EEAxjWXrd/xyFE0tTXS0gGte2N0=;
 b=LMIdB5lS5nYGLmlLt0unNcsTOVHTtg5jFvFA6u+6p+acbxlO2ooYrMRsXSfiwueM1W
 2fAlqS+nmyfynbZvQQb7UvR96A14H7V+S/oF7PExkdmx8b3YdwZ08TgElke7wG2XxipV
 p8z1GZsw1AOJbgm6qd+JX0ri7plRkCr5wQGJhOu9RTR8X4qgJptQR8i68cWrLi/NZkCI
 DDoqeV5iSokVhqyj3VzYpG5oADeoYVVqk+8icnbFHIkm5RTRRca4q3cYX0c+2dbBy/Kv
 svYKN/O3Mp9xwjXKqAX3WcIfNUQY+dvZdveutYg/+Gmh4CDkRc/jZzT2n6Hac5ZTkd8d
 oZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769529; x=1774374329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sve/0XHVXakpPoL6EEAxjWXrd/xyFE0tTXS0gGte2N0=;
 b=dF3p1oizYqLsbfV/Nk/I6PgJ9puV9HQW8p0BumBtLWpcKvq7HxG8kmZSNE4DHPFjhr
 LTghuebgI3FnEWZp8lHzK9rtpzZWms+7V+UilncIHQIW4LM7fSNhyHkm8AEtTgwdEgBX
 OyiYVfGL6prx06n8CkIrX1OEAwxGilQrOtUaEBQ6sOUpuBdTGY8c21aJ7ZHLQyAj/vsB
 B41A1BY4hYhJqIKMBINEUXsDZ5xwUGX9sqj5ZzG5JUYtJAlByxEKfiDb3J7btYBYFoeV
 2cXG4Y4myzRT4Aftt6+QuI6AEdb5mOM7YkMPXihtX/dY/PV7QdpzLPCMqJc0a2C/wsqI
 464Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCgn7T4kwmjYEVs7EmOzpuKy5Ebm6naK39PLhNIT1wTj/1mf1cj7MWEQAkzeXRbrWMa9EVg/mLwwQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwrwR5TyVTC18tGUl0dtd1u/bWpOWrWgQ4KqZx9QkIbFq1uv+d
 oEgJol/m8kxX6ZBUizy+sSVtAWYeqVpCXtpKP69bixZpeaPanL7ZauBH56cZNq55BlKu73540Vd
 rp7W7Rsk9Ft7ztqeEpCHUCyd1vN+wIUXJ9vSp9ybVbDDISTMkx2isAxgK/jL6E6c7M1Gs3zc=
X-Gm-Gg: ATEYQzz/0pKNeXNRK58pvcaFSds7EelKNlwu9BltGzIDL05MxzDkZLa+EwqIzey4K79
 9v7kIIO/6Rrybyd17OQEW6iSvzmrKFUossPfEnZ5BT1SQKpzCdngwh/KpE9LnWnRPCwFouGX/9Q
 dXt1fKZ1H3PNeVu877sOgrlxoaebIWGFhOBwX9WD0Pvv8pv3teIsGyPcVjl/HcGj8FcTDu+47kz
 olMchHejrYuUZu7apNxwWidIICVuQipXdcbO7f3/1yhz4kUPO9cJddPHmUhn2eTVnr48I1ien6/
 4DqJDUvUT2PsHasvL9m+Xmli+uhGs0iQ2XZVIPrJuK4I/uuDB990dzcKyOT3Ak3NlIz6zb+OnuY
 7gYQNDrT2+DQrPiwqBoD8WGwIiz3bMtAtBW2FOs5q+saNElAkGlaSbsSYBtg9QbC7voXLxF5R6a
 ZU3kAiSWjexIP8oO980dAZNOVzrf5PNA4jIpY=
X-Received: by 2002:a05:620a:19a9:b0:8cd:8320:3359 with SMTP id
 af79cd13be357-8cfad1e0b92mr60711085a.9.1773769528706; 
 Tue, 17 Mar 2026 10:45:28 -0700 (PDT)
X-Received: by 2002:a05:620a:19a9:b0:8cd:8320:3359 with SMTP id
 af79cd13be357-8cfad1e0b92mr60702685a.9.1773769528096; 
 Tue, 17 Mar 2026 10:45:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd517df25sm1088111fa.15.2026.03.17.10.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:45:26 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:45:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH v2] drm/msm/disp/dpu: add merge3d support for sc7280
Message-ID: <7tcmh65lhy7t452mwkiv37pxqwh6dbuh6voelaag6kph7tfr65@cskiwvoafbdy>
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
 <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
 <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
 <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
X-Authority-Analysis: v=2.4 cv=Ns3cssdJ c=1 sm=1 tr=0 ts=69b99339 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=xNf9USuDAAAA:8
 a=EUspDBNiAAAA:8 a=WX5Q9rlaD-dN8u3Ux8UA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: CJdvTevhlxcluaSYgmjQMXdQEKygHwxt
X-Proofpoint-GUID: CJdvTevhlxcluaSYgmjQMXdQEKygHwxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NiBTYWx0ZWRfX06tu+6ZB1Uzo
 j1j5Y4GRplFx4Ym3xD/b6Hq7PznzACurAycTGuGX0P04uFP89khuaY7P/98ohA0VvojVvL9JXXG
 KKnhI3Zm8eEB1y2RkVazGw0fJ2EcODxloIEa0ot5yBGx+ps5U5eHyLvZ8kkGSX/+I7hjPdqGnXm
 aeDwShd4HFaWGchz6saxFIBZINpU0pwmCnK+h3DJc7CkiTFa0vBz1NanDVJAhcAMq48bv3WCLsT
 8Az4sEVEAqvoqBehfidoWTGJ74CCE3YYpENBmUydm1fJxFDwejcw8JszSdQnkR4n7IMOFX9mZs0
 V5axiuJpJcsIPkjmCw1ITq1sfdwH/O5wA5lxFrPi9wlJJ+pD14Bxrf0e1t9NeVjBeaBnp9+QY0J
 KCLX7tsn6JXpwBtwzGtD8Aq7xGTixQuIvsqjDA6rnqS2gvOUb+ZVXco96oOso+RWBlRknxSjZ0/
 H4yj+0PfAaQmqLnNvjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170156
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

On Mon, Mar 16, 2026 at 10:08:47AM +0100, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Fri Mar 13, 2026 at 6:14 PM CET, Dmitry Baryshkov wrote:
> > On Fri, Mar 13, 2026 at 09:33:18AM +0100, Luca Weiss wrote:
> >> Hi Mahadevan,
> >> 
> >> On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
> >> > On SC7280 targets, display modes with a width greater than the
> >> > max_mixer_width (2400) are rejected during mode validation when
> >> > merge3d is disabled. This limitation exists because, without a
> >> > 3D merge block, two layer mixers cannot be combined(non-DSC interface),
> >> > preventing large layers from being split across mixers. As a result,
> >> > higher resolution modes cannot be supported.
> >> >
> >> > Enable merge3d support on SC7280 to allow combining streams from
> >> > two layer mixers into a single non-DSC interface. This capability
> >> > removes the width restriction and enables buffer sizes beyond the
> >> > 2400-pixel limit.
> >> >
> >> > Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for SC7280 target")
> >> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> >> 
> >> This patch is causing display regression on QCM6490 fairphone-fp5.
> >> 
> >> With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on the
> >> screen. When reverting this patch everything becomes working again.
> >> 
> >> See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux/-/issues/41
> >> 
> >> @Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
> >> quickly?
> >
> > Could you please provide the resource allocation parts of
> > debugfs/dri/0/state for both working and non-working cases?
> 
> Working (patch reverted)
> 
> resource mapping:
>         pingpong=# # 68 # - - - - - - - - - 
>         mixer=# - 68 # - - - - 
>         ctl=68 # # # - - - - 
>         dspp=# - - - - - - - 
>         dsc=68 - - - - - - - 
>         cdm=# 
>         sspp=# - - - - - - - # # # - - - - - 
>         cwb=- - - - 
> 
> 
> Broken (with the patch)
> 
> resource mapping:
>         pingpong=# # 68 68 - - - - - - - - - 
>         mixer=# - 68 68 - - - - 
>         ctl=68 # # # - - - - 
>         dspp=# - - - - - - - 
>         dsc=68 - - - - - - - 
>         cdm=# 
>         sspp=# - - - - - - - # # # - - - - - 
>         cwb=- - - - 

As we have identified that the issue is what downstream calls
DUALPIPE_3DMERGE_DSC topology, could you please also check several
things (with the broken kernel):

- What is being returned by dpu_encoder_helper_get_3d_blend_mode() (in
  the broken config)?

- If there is any difference in working and broken configs between
  values being passed to (and programmed to the DSC) in
  dpu_encoder_prep_dsc() ?

- The same question for pclk calculation in dsi_host.c

-- 
With best wishes
Dmitry
