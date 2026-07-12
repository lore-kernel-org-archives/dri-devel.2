Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BAFC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFED10E43E;
	Sun, 12 Jul 2026 11:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLGbLaRc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dz8YbG87";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0045F10E42F
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:56:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcDjv2332051
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KC0A5o11l+xPlKmgNI1EcL//
 XJ+YFhRLisW+sul/M2k=; b=ZLGbLaRc2YuGI0wgaZCGUsB4ZiuswQQlv7zLaaKo
 6x2ZX8fN4HIB3lUatqNhKi3z9ieniFujKabB9Q9nS6aZHueYyjdFVE26Z4Rq5hxm
 he3amQUojp2PFZ51DALlsfHVrVKTF7+2wisEe3NW05u7Wr9/aP2tDfX/g7IZKLrW
 2uW3dJL/B7/pG76QZNmvaBLfzMLpPS8CupnjdwMaS/TkffgRNIIRVTXvO2K1eqsc
 0JB7pUVdhkO/4pB79lQ4uJp32i45Go9Ce1yOw6897EdcwaTLCXeWmXHMqZQHMsG+
 03ca+g1RGA1UTbpwdd/MPxeh3db/f45+NDIrTrU7PSyZZw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamtrbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:56:24 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bfaa9192daso1960092e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783857384; x=1784462184;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KC0A5o11l+xPlKmgNI1EcL//XJ+YFhRLisW+sul/M2k=;
 b=dz8YbG873l5pMR0d36lnvRVxSB42dI54J/ohJqSZ1OxIlNKNG5m7pKbr00/I3L3/9U
 Nnw+bIspaZ2WwUSYXtu9VJfEjQyIquussej2YMLaHZlksOvNIVFtZYl+GBzjl7eQMTvn
 iWKYLTH8zfn6xRBD/hwyOBq11E1vUul+D58awvX//AjQ3wRsdpgZILh3OpQp5W8HaSnn
 22paz5FyxgvKh/V0jSPxsdO7KK2DZYrjeTj/MhfeDB3TFPvYOhwTFJ1g8jdct2+/x8vD
 KOXSKRCstfm0+RlPwlO1RYRLHfX/NQ7IJqthu7YT2hO54crNN/nfU5c/4GYLBhzUoM+P
 WbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783857384; x=1784462184;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KC0A5o11l+xPlKmgNI1EcL//XJ+YFhRLisW+sul/M2k=;
 b=UfbNtdtlmQWv0/+T6HGPOhB6hSmGgw6YEOjs6uTZ6wpstcZo8RhFAltf7zm1lKGjQh
 9jbAO06itXJDgvQR9MVG3Wj47DSuwPxZ+X6ssYUAVWM+9vgm4vBAAne5Lf4CgHqfJC7l
 S6w7vGrMaVEJjtyDw1wxpihgyxM4bRMUCkw5X2o0/Q1u6E8tWwV07PMBExvexjUIiYbz
 igiY+ERBNetzjQfNFim35/ANSm/P41Tm3bf59k/aT3NmezxAsJ1friO/T655DPLaAoNr
 ZMatVSMZw7t/dkFhIK3lDFppsGL4nzY3GNlsGDeA1k/RFeZbnYQi0eNIoihG5fZzVYyy
 hZWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMPHvD6JTCB/WvrWoIffycCRuSfjOgqfuQLcAwDiQFYyWCC63uDcLQvPFFDbonK7L8WoYTxi5owMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6ULjtc7v+eRtSpt/AjXwT1HUVSxZo8w95XkFOJqBTPK/7feo5
 3Rr0OG5mfqAtYiDbFry46DJoT4cf0geAVpGSTwqxjjBB6j07jQWrKRYjlWUMbjld+K50Z0SDvka
 oBbSBKiPLXlNWt6RR/UzlHFzO10f8CoUS61MGGk/MR4kz1bnWNDLLq3QAChIf9II+Ih6vW98=
X-Gm-Gg: AfdE7cm2p2tp/0UfRB6aOKOCQFfHHjEP5ZuEgNveyBCZ3qzKmPuHdVB6Tb2CoQjDSQ5
 aK6Tl+wYdVxzI80uKSr4toFGTWHw+I7qS/kEtC4YcvTQL8L2CW54IbtSC0ozLRrvVjHeFeQLcZo
 WdDKlzs+TLppTt9nF9zKkhPtg8Bm79fZEurgBFo0elarZXTu8zxMtvtBVhr4jfPXNz5N4CIH31I
 5qGubS4Q+gR2B2FSdJyef/BU8SA58sGQo/y0l2RtqsQdIB3b5wsLTy3uz/O45HQB0uMcBXdbVfz
 Qf85l/ous8iSoX6CfBC8un3+9Zi6AHxsSZdbKjFzBtTq+5RApjj7bZtjpI+HhmUOtbyto0bYHr9
 QJNwlGm0SOCW/ruTeF/H9gQeVo5EuWDqmBsVxDitdY3qe48oBmT+n4g/KMhqCceE9AvF4/13qM5
 STBh+10hxEXgAnyqL+RM7UBtGP
X-Received: by 2002:a05:6122:4a01:20b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5bfa49392ddmr4163131e0c.5.1783857383954; 
 Sun, 12 Jul 2026 04:56:23 -0700 (PDT)
X-Received: by 2002:a05:6122:4a01:20b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5bfa49392ddmr4163111e0c.5.1783857383553; 
 Sun, 12 Jul 2026 04:56:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b1a164sm21000341fa.16.2026.07.12.04.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:56:21 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:56:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel J Blueman <daniel@quora.org>
Cc: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, Federico Amedeo Izzo <federico@izzo.pro>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Val Packett <val@packett.cool>, Steev Klimaszewski <threeway@gmail.com>
Subject: Re: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
Message-ID: <zscjwjuqhg36vwsbt735y5gq3bcfxcfh4m46zcgpakacyoxrvf@ekji5eglhdcn>
References: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
 <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyNCBTYWx0ZWRfX/uilmx0fj/Ix
 JYuj+x6Pl33mUp6Swh3Ll/nXgUuUcdcziOpDKreothCGYAsyGGEmbh+9IK/hJQDew+HRcFs+hzh
 u94RxIBDPklSrr39VmAusWoRay9+ISc=
X-Proofpoint-GUID: osUObQd67hrhK73H1dz6so90gAwuHSRP
X-Proofpoint-ORIG-GUID: osUObQd67hrhK73H1dz6so90gAwuHSRP
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a5380e8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=t9ty7G3lAAAA:8 a=3Mq0MthYWaJk8H4ohRsA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyNCBTYWx0ZWRfX3a6Xf5mr63X9
 spcCgnP6xxc8nu7t4jmZU729znbMGvnQssdbjbp2ZrFb9gUaWl69DRV+troWLabYQjvW5mzTZTv
 C6/vgUqzGlNDJg33TFj2AL3BsnvYFAjQ/Tri+0MWt46toBuK1n6DSxnbHfShS5BmGeGfPacWo0a
 nt7kktooQgclq3ZnY/N28oqi8T9cl5RbAWNjMaxDd55z2Kw6JubccQHSxjGxDI/DGjiHEi7IHDY
 ZmlCCIBG0OPh4FbbrSPcLuJlTmoeZvIuBrzIHNgitr4K/INj/UutGS7WdHBmJGQkpoEspiPZLa1
 IO+WohRPlwSEcIPSfPbIA5vVC0zFTT2hqJubDJCOUlHVf4KfTKkGuvMqph37PYKhX5xBfVRjXGB
 uX4zPhNV0ncS2TD6pG2rcLUo2nGwazpZdtYndc5dMrmmifIntZW1nqOMYsMZVEmsltVPkCFtK/M
 xAtGwi7VqhDY7t4f2uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120124
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

On Sun, Jun 14, 2026 at 06:27:50PM +0800, Daniel J Blueman wrote:
> On Mon, 1 Jun 2026 at 13:37, Daniel J Blueman <daniel@quora.org> wrote:
> > Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
> > Ubuntu 26.04), when waking from DPMS-off, palette corruption is
> > frequently seen; this manifests as purple banding. If GNOME night
> > light or similar is enabled, the visual impact is greater.
> >
> > Further, on larger panel monitors or laptops eg the Lenovo Yoga Slim
> > 7x (2944x1840), a second INT2 block is used for the right half of the
> > screen, which may remain totally blank on wake; major usability
> > impact.
> >
> > Intuitively, the symptoms feel like the LUT SRAM clock isn't being
> > driven soon enough during the wakeup, thus state loss may depend on
> > silicon binning/variation or related. No such symptom is seen in
> > Windows on the same hardware. I found a workaround supporting this
> > mechanism is to activate the GNOME night light and adjust the slider
> > to update the LUT - any black right half of the screen always
> > reappears.
> >
> > Please can someone with X1-85 Adreno insight check the Linux clock and
> > power domain behaviour around GC_EN, Layer Mixer, INTerFace and INT2
> > on DPMS wake? Happy to test changes; this is a stunning platform
> > otherwise.
> ...
> > Link: https://gitlab.freedesktop.org/drm/msm/-/work_items/89
> 
> Just a heads-up on this with additional findings. Note this issue
> could be the only remaining daily friction on X1 laptops with suspend,
> once my video decode reboot workaround or similar is merged. Also note
> in my case, without GNOME night light active, only a few LUT entries
> render purple so visual artifacts often go unnoticed until a gradient
> eg in an image is visible.

Could you please check if increasing reg_bus_bw in msm_mdss.c would fix
the issue? It's not a proper fix yet, but it might help me to understand
the issue.

> 
> From DPMS wake on a dual-LM panel (>2560 pixels wide) with
> INTF_5/DSPP_0 (master) and INTF_6/DSPP_1, I find DSPP_1's registers
> are intermittently unresponsive just after MDSS resume. DSPP_0 doesn't
> exhibit this issue, suggesting some missing slave/second unit setup,
> despite booting clk_ignore_unused pd_ignore_unused.
> 
> I found the extracted Windows DSDT \_SB.PEP0.G0MD F-state EXIT block
> enables disp_cc_mdss_rscc_ahb_clk and disp_cc_mdss_rscc_vsync_clk;
> could this relate? RSCC being the RPMh bridge subblock. Also, could
> any of the *1_CLK or MDSS_INT2_GDSC entries in dispcc-x1e80100.c lack
> setup?

RSCC should not affect these blocks.

-- 
With best wishes
Dmitry
