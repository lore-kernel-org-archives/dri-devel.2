Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1A1098784
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1327010EA23;
	Fri, 20 Mar 2026 13:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xv4oQ79y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rl22gkiK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AD610EA23
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:06:44 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2Xk8r331755
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GEj9UHhLvaK+ebnYW0UfI7jc7cKQ+chi4rWPJEcsFuQ=; b=Xv4oQ79ydw4opY0s
 ub4LwOZ+nh+qypPKrpQOIdo9JdD9jWFGajdXT2bajBTImHTk+GO5uMgthzTXdxvB
 k5wVmEcGn/47dgJOWKfO7xdKpQnRZ/p2l6SFcu+VE1aawOQ8N2hF5ehjizoLynUN
 L5H5BcHsyMXA9cLwfdjQhRmWNMqCF48Y53Ono/y/ZdpQwBrLN81klvM/cwcvVSRh
 zUap77/Z0c3k6nGztVabtHmqQK0EV7ury52mdp3wt7lQyTV8WRuLV16gKREUUTqy
 RnMNpSMD5jaT+1RvurGuGoNwG65fFpE9M4NuBr5EEA93H0IbZSjtvZjql4QK+Qtb
 AauyPg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k083dtc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:06:43 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-67bb6081a0dso9130410eaf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774012003; x=1774616803;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GEj9UHhLvaK+ebnYW0UfI7jc7cKQ+chi4rWPJEcsFuQ=;
 b=Rl22gkiKsifWGBSPKDWZB2Z7tZZ4pB9vgOGI7oJfUJ+ZvL5WQI97jvBIi5fI8BoLqs
 Y3sIyB3GzRBACuEYLCAoDXPJqWxv4ETjAQVjucnzUHz3tgRLh7dVM14MeLFQGE8DVc/a
 lyUgg+aXkRrh7heuwhTzbh7dVkvT8HaxOczj6WqWGNCJZauLOu1QScRK9kt0l+fElFbD
 qvGCb8fOWYCFhl2fh/ldBNp5f2mpYiKrXKMr6JJgEhyVr4oVMxBc1vicVS/xqG7/OqXy
 XOzDwAHmyru6y4aBzQMhr9Y7odkbJKbICYKAy/NCIJmYNKSMsmNYR+YkZs4HQ91np7bj
 fG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012003; x=1774616803;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEj9UHhLvaK+ebnYW0UfI7jc7cKQ+chi4rWPJEcsFuQ=;
 b=O5N182vngDLo/8leOsxuCPUj7My2PzFR9m90XT7Ksf1DJlgAYRKrFVjuTKVVFCQIzd
 coWr20TMbZMF4vjUvWxwzz6+gWYzvdT9ooc7mk/w1JOk8R5vCsqfJ+cHmDpnoC+RYxgp
 PCfoq2/f7yFgu/z/q98GBuUNPbA11FtQOpqlDmWACzz9QrBs0ZW/o/G97SrefSXC2QvZ
 ogx2EnOnmiSMPswb3ewCgCpf4asoRa3ETzSI+qFgdcq0mESMl07+4vG2OTXniV3e7rSp
 Zd3ok6ovPCMNfC6QyDX2KJj0bFzNaGUnUHU7jFpT5PRZtC/Yclf6Z2yRyhbF9XlLz4QH
 nF1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyAVFDdPcP4C3va2fWBi2sjhVKrX1haTjySXytpYhmDDQjFjHEgM3iCGEbYgf1XELlDjofqXCPPsI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDhRWmuajz9JukX9xQkKl/Eq575qZy+hKLUfVD+AC4nx2w0neJ
 My1227S21ZXD1t+e0OX31kSJUlzQJDj/BDffiJc9FU5/YapxjAly4Lxp7+d2m7LNmbPKOxjuCrL
 ukPgUqVe2+67Y9+QCyRUMyiUxs67oVj5RZk2dcUXukkizmGQIMx9jjAQ4idoJjW2DW8bIS7E=
X-Gm-Gg: ATEYQzzVWOfhuxQJNsCE8CbC4qRerBhl76BZfoVT7xbHOlbjftaOeRaZMwzsV8bRC4+
 fHC61hMNMPJhaoZmvSSqe1NwJaeCm1NdFClE0sue+Fb56eTkdRD+PKHKq/XDJ5Q/viJXXXWoCNm
 wv9D4GcyYB+J3YCZFCIv+NkNBpZrN8Hc8HH/x3Xb46Y9WAXTrD+AqLHQO4LLqb2KU/dp0DVUccy
 iV1h34iouJ2LBKPkUJS2dyDBMbmM646MFDpl5uHrHb4G0iYvX/7COOw3hbFGNM99xqYfnyp1HwX
 cJNovSHTfTstkXwbLRrTeDaKccu3ZKhwh7VgeyJUOoa4J5wYyf5jn8u14Omb7P5E1UGND7AgH3a
 sLbcXRoYWFqfRBAnCSF7tagrO968csZJZY1LZVv/5dwj86NHHc/A3TWaVGOwJhMiNTXmzkC+F9x
 Oc/ooYwfHjUPw6mIOpG3QN9CdvYDVFf9C1Fkw=
X-Received: by 2002:a05:6820:1886:b0:67c:2c83:ad02 with SMTP id
 006d021491bc7-67c2c83b70bmr429595eaf.58.1774012002734; 
 Fri, 20 Mar 2026 06:06:42 -0700 (PDT)
X-Received: by 2002:a05:6820:1886:b0:67c:2c83:ad02 with SMTP id
 006d021491bc7-67c2c83b70bmr429564eaf.58.1774012002231; 
 Fri, 20 Mar 2026 06:06:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285305eefsm516187e87.70.2026.03.20.06.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:41 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:06:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 ~postmarketos/upstreaming@lists.sr.ht,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Restore widebus calculation for CMDMode
 panels
Message-ID: <5vqqcoggq3mrwc567jhrondk6m7vfpth57wu3gyvyjjkezfmnl@mqzlarjlsgcx>
References: <20260311-dsi-dsc-regresses-again-v1-1-6a422141eeea@somainline.org>
 <CAH2e8h4qnF3UxWFrU59BrStWMDc-=Vz9ZNmuq8Q3smhHeUzxyw@mail.gmail.com>
 <a2xtesu626vmfetdoykojm33at44h7zxgvo6ytf2txlg6gn7ls@34jctkwswjnk>
 <CAH2e8h4p4fyoPXTcjbhSXVgWEm54PH_=yCWiCGWOsDaMZu1bvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2e8h4p4fyoPXTcjbhSXVgWEm54PH_=yCWiCGWOsDaMZu1bvw@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bd4663 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tVI0ZWmoAAAA:8 a=FyIlvsOcNDrvurPcZs4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-ORIG-GUID: jUGUEyy-0VxmFfjHRVYCI6_W_stVdxsH
X-Proofpoint-GUID: jUGUEyy-0VxmFfjHRVYCI6_W_stVdxsH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwNCBTYWx0ZWRfXwU3RFnDvgRZ1
 WmZ/53/EAwPqLkjBTDYB1aXL/EsP1QdKlETXrwpho7iA+u5z9HkvV9XViw+xWdv0ecQ9CiXJhrc
 zM28PgY93jTdJ2OpOsuSl2DNgaeXmiuWX/mgZHoHS5onYrFcylaKd2+ISzBgd4t+QNFRv+SGAo2
 yTBq10NN0pXAxMMobwCgTmO+RmZOEHk6cW8E3QvUwoMhhhxBiBr/bLo3RRum0QFzNw8VLEQedNU
 g1d6ENayBhuh6dP5wiamMznAi+nJOhuvkyguOPimQV5ltHkXU4sF7ptQK67y7sHxt+fPNk/LZ89
 YE/mGd4Vmo86nNLubUCebYlSisqxHgu9jA2e1dHhmVklXqXs+nEqFzctKXwCyGwQrHg91jZcGEF
 Ae0bk2mzFIakXSWeyn8h0q3Y8/Vxq5333qO4ITJR6vSBCkWavh47McM8gjf0XTwcH7gIYyp/hPB
 nuMYAwcdh4ZZawQ+EDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200104
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

On Fri, Mar 20, 2026 at 07:26:22PM +0800, Pengyu Luo wrote:
> On Fri, Mar 20, 2026 at 9:59 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 01:10:07PM +0800, Pengyu Luo wrote:
> > > On Thu, Mar 12, 2026 at 6:31 AM Marijn Suijten
> > > <marijn.suijten@somainline.org> wrote:
> > > >
> > > > Commit ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when
> > > > programming dsi registers") makes a false and ungrounded statement that
> > > > "Since CMD mode does not use this, we can remove !(msm_host->mode_flags
> > > > & MIPI_DSI_MODE_VIDEO) safely." which isn't the case at all.
> > > > dsi_timing_setup() affects both command mode and video mode panels, and
> > > > by no longer having any path that sets bits_per_pclk = 48 (contrary to
> > > > the updated code-comment) all DSI DSC panels on SM8350 and above (i.e.
> > > > with widebus support) regress thanks to this patch.
> > > >
> > > > The entire reason that video mode was originally omitted from this code
> > > > path is because it was never tested before; any change that enables
> > > > widebus for video mode panels should not regress the command mode path.
> > > >
> > > > Thus add back the path allows 6 bytes or 48 bits to be sent per pclk
> > > > on command mode DSI panels with widebus, restoring the panel on devices
> > > > like the Sony Xperia 1 III and upwards.
> > > >
> > > > Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when programming dsi registers")
> > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > ---
> > >
> > > Apologies, I messed up, I had sent the same fixes days ago.
> > > https://lore.kernel.org/linux-arm-msm/20260307111250.105772-2-mitltlatltl@gmail.com/
> > >
> > > > In addition I can't say I understand the original commit message
> > > > at all; it mentions a BPC=10 mode however the highest format that
> > > > mipi_dsi_pixel_format_to_bpp supports is RGB888 thus it won't
> > > > ever return anything above 24, which is the original amount the
> > > > non-command-mode path defaulted to (regardless of widebus)...  Was that
> > > > patch doing anything for video mode at all?
> > > >
> > >
> > > RGB888 is the dst bpc, which is tied to qcom,mdss-dsi-bpp in the downstream.
> > >
> > > Actually, we should use src bpc here, another fixe
> > > https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitltlatltl@gmail.com/
> >
> > I'm really torn between your two patchsets here.
> >
> > Marijn, Pengyu, what are your testing platforms and are you testing
> > video or command mode panels?
> >
> 
> SM8750, I am testing on a native 10-bit video mode panel.

Is the framerate correct for you?

> 
> My thoughts are we should restore 6 for the cmd panel, and we should
> fix video mode too.
> As I mentioned, I overlooked something, I thought the cmd panel didn't
> use the value, which
> made the value for the cmd panel wrong. So we can restore it for the
> cmd panel (though I can't say why 6).

2 (wide) x 24 (normal bus) / 8 (byte)

-- 
With best wishes
Dmitry
