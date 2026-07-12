Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84786C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A6810E464;
	Sun, 12 Jul 2026 13:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MkrXFiIu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HiAYtWRO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A21B10E464
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:53:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CDZaNV2808058
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wjc4jE7ttkmjfByvpgXMpVeJ
 fd5zNu6E5KL7m0FWXjA=; b=MkrXFiIuacuzuNaxb/j54iq2shzJb0TXLsDf1iOy
 9z4WJXtOUu50Srh5JFv7/gR8NM/d69SQe+Q0qm52LEU1D5mHaZPNkK43vyywzU45
 2U/ED91zhZfO7MfvoSdM/sFiFfZeQyOS09yYfHuW0scvB3JdyhaIIrUx7YvdjxCJ
 aJ8hxvvBhNNwVHBwuavigvlrRiirB/NV6amwGfVPq1tvt1CXpOmtW7rSXdjJodSp
 /wZkU+wk+l5nf9lB6hbUW4NHws83g0xEunzRQSZa4Yvv9d8IHC7GFoBUEyKsy3Rj
 8LTdMdCVjJmudA/Aw9EvjhXQH+jhbrCRsB+1x1F1/3y7cQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeafau2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:53:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so4107487b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 06:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783864431; cv=none;
 d=google.com; s=arc-20260327;
 b=DdNg9FvGrNKixFUrqDMDDLHdw3gwrlNJ4bVHNuELAvUtAhr79lmMo5SZgILu4s3pAO
 K/ASz8gLS5EdP8N0Vmyl0AzqYmTcSe8dcnNOLw7KIE38j3tQUzVzKYNGWf8tB4uDEUpb
 Dx4gCn5uwK1b0R5VbN03ENdVBrENwtie4r54Su3YaKsoIi1zQ0TM+L4HANmxltysrJhC
 DlsSJfaG/X8VJ2pgqvzDhcS48DoA7AFmksqEuFyeCHZtPBR8g+XEI5T0kl/W3DbGF0hj
 PiT5guoVfZCxUgLQZlliXyfX/4cjACc7AOUmzzBVDFMBTj7AfhHJFT+DXYCxfXTHy1zu
 F/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wjc4jE7ttkmjfByvpgXMpVeJfd5zNu6E5KL7m0FWXjA=;
 fh=OeGwkY+Oa8MCBn0Mb0xx31+jqiZthd3fws5y1jtrnbw=;
 b=Wyiw1SvVGGCGr3YkvuRHDJXHDBA8/FpH1RNsxyJ2ZHEKTZAfoAbx/xH+cI9RyekuxA
 Byjhf5KO/i3XPquOXvq8fkuWSjv+9EOkOCX23Q8GLRAx32SpUlV9BipiP5kFTydXQSVj
 VrmQuCgsLwC+SUuPTGHQqJ0tpOgyNODe5n+m/6CtmO1xi2piZAmL2fdELitzy5AJYsov
 G/bakgmJSHn+eDxI2+9FK4Ix/PuYh482dMFSTOjZRy8DsOjIKvtfXHcI5/GpjAIx0Y//
 rlklQWRCFR+yYme8jUAiNsB0d7d6Mn07bU8s7JD4b3jn4IgTFrL3UfCpuWTfpDeeP4cg
 zdnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783864431; x=1784469231;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wjc4jE7ttkmjfByvpgXMpVeJfd5zNu6E5KL7m0FWXjA=;
 b=HiAYtWROwrAp01HaYyimEzWqDV8HtZxMqWwfVn2aifI+0OkmtakQj4TgQam40uJxyS
 iowJ/vkvbh/0DBhZyZU2K+YtGqNWsE6Mrv/wvb2qxVHHpB6rSeMQgddb7q35fYyQkVfb
 uuZbI+i0gRceSzv+m87KJ0bNqYFk6R0koUQRX1XN9t971eKh+gj72sQboGX6EZCc5e7Y
 leg7otG5TF/yzIw00DRnWTW1WPN8CgT9MoQ9o7zO1h+SB6vodtHiMNbN74BeEiYiAWO2
 5/wD4HsOHtETWydlmd/jCE1nZnByJat29Z/ZnT9Ctf3LiL33ANluKny7hYLMLEChwv4y
 ZFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783864431; x=1784469231;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wjc4jE7ttkmjfByvpgXMpVeJfd5zNu6E5KL7m0FWXjA=;
 b=oz9r0Gklh0ck23VW8lFK/WycRIYMRyZ8niIci3t16z1wK8CRoSA4Frkyzxv0TV16sv
 T4p3jkxxp6dyJyyUbLtYng1iShCFb5Xl4HRVN7s9X7wSArO1hD/Ayr88QLv671VT6Vpu
 WwwOYYMfg41mGXMtHd0+gSXWLPJX6MIEzJQOOw4TdVqnnQ84SNbKY9HHXTlWhgPDR2Ts
 CKjqjYNY98MmZ+Z3rY5/ndVRgIZ7id49iNLZ8YHFah6ue0KC/d2DgQqIuB01fjmilpy4
 RJr2pfbpy6io5wenitc01M2zsyK6sPkE5yLOj68vWDcbK/iKBMBTR2ygphPe7iXFQlfq
 v29g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpkw0Rz1AHaAcQMSXg/r0YYbc9bFAQAAG4mboY0aakdvzKAL522Skq2Mui3nF4wqOpZm/ATmYcebEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9VVABGWcz8nWk0WpYDiaQC9vBLzX/9bVDwJB/ccIFHu5fjEZv
 8BhLd9NyOLbcQtbEQpBemg7yuXIJPHxQw3b4CMpDi7/W934or5BOBXCfyYE96gQN2v1LJvmFmD/
 R8kLP5OX4pgUsR6rQ6VguFXYCjzZBGjzyAVeYshqtCVtLXfs3CMwLx7CopWrcdDeWnsNhvuRH/K
 4+juF5ZYePt+1aU2emnqbfTzhdR1NkPaMf2245BC90PR1mJQ==
X-Gm-Gg: AfdE7cm3JUrr6AeHq7LQ+WrQ3+WjKHZyRztCHo883f7sV2psfTZoYD5Edjo8y6VnqP7
 tS0wRWnymNxjCryRvVZ521xbeuyrXlKoPhjGuKJOK65J/dE6hMfz9nFuFtUbZ+hQElRiDDwchqp
 OTBkjExreH8DzGGeJVH5RfTDBfe8dmf1KKn6mecFn0bdPih0fsew7ERk1bxh4AQMxwFt0=
X-Received: by 2002:a05:6a00:a14:b0:848:44ae:47c1 with SMTP id
 d2e1a72fcca58-848897e8fe5mr5691768b3a.78.1783864430563; 
 Sun, 12 Jul 2026 06:53:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:a14:b0:848:44ae:47c1 with SMTP id
 d2e1a72fcca58-848897e8fe5mr5691735b3a.78.1783864430087; Sun, 12 Jul 2026
 06:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
 <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
 <zscjwjuqhg36vwsbt735y5gq3bcfxcfh4m46zcgpakacyoxrvf@ekji5eglhdcn>
 <CAMVG2st0i7W3S5pyZRqMufL+pfKTkv8e3sLnws0UhOpbqfXbmg@mail.gmail.com>
In-Reply-To: <CAMVG2st0i7W3S5pyZRqMufL+pfKTkv8e3sLnws0UhOpbqfXbmg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Jul 2026 16:53:38 +0300
X-Gm-Features: AVVi8CfadGqN0BIMmGxTSgFHMkTaIMmMj6VdmWTupcppvZWmGwD2dRsxo7YUrZY
Message-ID: <CAO9ioeV7tJ01eH6m9nSKv4Xr0gi3x0uaidFZNSKsKSQrTSqLow@mail.gmail.com>
Subject: Re: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
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
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Val Packett <val@packett.cool>, Steev Klimaszewski <threeway@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: 4rW4YEYhWEVdRAnm1mphn7s4-nZVD9B8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDE0NyBTYWx0ZWRfXx2CjeissXxL0
 5+IzG7+48XyXkHIhifYPsWX8t9zKKUEWb9zSH/FYStqeqx7ero5LnmuJlW5aC3AJqknKkwWlnuW
 vODi03pFeAcZBeceJN0Yjw4VH/fnO9WjHQjuX2luZC7OHOZ03nB85X94RLH8bmQoDvA+D0hLDAH
 JSZjMAtpxnTj0ShCZ8Y9QAzvqr6/m/fxThIyUuhMY28YJbDZ+u4HTXjg0rc2JwhDby4WHamlq7s
 s2Pk4SAy9MjQ/5uvDTeaCXu9u1u7mF4Dz2+FP5m7SOTLRIjcZryKfLiYsOTuBuu96onfNiY1wCk
 KwFlnf5lFfoAWG735hlraaV+PCIwRzyQEeXZLKfdXd2MfTKqsMgDee7ZHP4D1H8NALylW0PL0fm
 /YhLIiBHHZ+80HALTOOzdzr+l/TJbT4lGhE/GCue9GawbLc5d8URVAoP/UyScP0Q/9FbQtozx+t
 9C0XhijX0P/kMv/Jb7A==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a539c6f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8
 a=FiFy6uYC1nMt2OdNVO0A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: 4rW4YEYhWEVdRAnm1mphn7s4-nZVD9B8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDE0NyBTYWx0ZWRfXwscvlTnr6XPE
 sj4U3mxgeEcWInWEECcdnIntp9Rc8qNqRsAu7gDgnpYGL9wiWlPsPqHTKiIzz/pCBUh5wehuVyQ
 BZUwS8dDiu3uHH9PLMACvk1Dokc5TLo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120147
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

On Sun, 12 Jul 2026 at 15:47, Daniel J Blueman <daniel@quora.org> wrote:
>
> On Sun, 12 Jul 2026 at 19:56, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sun, Jun 14, 2026 at 06:27:50PM +0800, Daniel J Blueman wrote:
> > > On Mon, 1 Jun 2026 at 13:37, Daniel J Blueman <daniel@quora.org> wrote:
> > > > Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
> > > > Ubuntu 26.04), when waking from DPMS-off, palette corruption is
> > > > frequently seen; this manifests as purple banding. If GNOME night
> > > > light or similar is enabled, the visual impact is greater.
> > > >
> > > > Further, on larger panel monitors or laptops eg the Lenovo Yoga Slim
> > > > 7x (2944x1840), a second INT2 block is used for the right half of the
> > > > screen, which may remain totally blank on wake; major usability
> > > > impact.
> > > >
> > > > Intuitively, the symptoms feel like the LUT SRAM clock isn't being
> > > > driven soon enough during the wakeup, thus state loss may depend on
> > > > silicon binning/variation or related. No such symptom is seen in
> > > > Windows on the same hardware. I found a workaround supporting this
> > > > mechanism is to activate the GNOME night light and adjust the slider
> > > > to update the LUT - any black right half of the screen always
> > > > reappears.
> > > >
> > > > Please can someone with X1-85 Adreno insight check the Linux clock and
> > > > power domain behaviour around GC_EN, Layer Mixer, INTerFace and INT2
> > > > on DPMS wake? Happy to test changes; this is a stunning platform
> > > > otherwise.
> > > ...
> > > > Link: https://gitlab.freedesktop.org/drm/msm/-/work_items/89
> > >
> > > Just a heads-up on this with additional findings. Note this issue
> > > could be the only remaining daily friction on X1 laptops with suspend,
> > > once my video decode reboot workaround or similar is merged. Also note
> > > in my case, without GNOME night light active, only a few LUT entries
> > > render purple so visual artifacts often go unnoticed until a gradient
> > > eg in an image is visible.
> >
> > Could you please check if increasing reg_bus_bw in msm_mdss.c would fix
> > the issue? It's not a proper fix yet, but it might help me to understand
> > the issue.
>
> Adjusting like so [1] didn't resolve the issue, however it was worth
> ruling out. Perhaps you could check with the Windows driver team why
> the DMA descriptor approach was used for LUT setup?

Thanks for the test.

SDE driver also uses LUT DMA, it's just another piece of code that has
not been ported from the downstream.


-- 
With best wishes
Dmitry
