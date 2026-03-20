Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510B11093163
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6776810E956;
	Fri, 20 Mar 2026 01:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzfTU4yj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iGC8+6Sk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A2210E956
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:59:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JJdKmu2759400
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1/eBnmi9iQCVvM7OEFm4LI9nJNI+Pese6YtcXwYE2SA=; b=RzfTU4yjO+s8ZwDd
 G0ovYTN6BMY9QZDiAYEuzKRvHky4h78mnHTVsdw29rcbcDgVkaTVveqROQmNz5T+
 W8scu5v0+PIu89rrzuQSlXoKz4w3/3KWJnHfVxWjONMEyiLGuBMJgSdc7XZIXsBy
 TxVHv2+XwTj9DrujO0UForgdhofIPC8949GUUd575zU2+vp55wWVOuBde78fczGM
 J5BtFDSX+f3Y+D1Q282W8Nx/e7JPiufsbYIYGzKaoKlipdVsJF/Hm/RHYhCIZCkq
 Uvvc5GVb4KsIja+t1zQvz2/Q/sJNMVE1WIILYlmUqnW3/XxfX7EVk/xAw9r1iEUe
 S8Scpg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0qg78tvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:59:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50937cf66b5so26842541cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773971990; x=1774576790;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1/eBnmi9iQCVvM7OEFm4LI9nJNI+Pese6YtcXwYE2SA=;
 b=iGC8+6SkIANGHgwHMYaAZyhyCVE0q4GDpV07sYr6PiIuKDG1dKivO6mwi4oMe62W3b
 7uOoS28LlvvIUlye4rK2vHmtUctH2xR4aIWTujGlXBo6inEyjAjQuzyqiRC+9ROvqAum
 jG7MoEM5O4W7hRska47IrNKEVLSU5ewkpWgirMmwk4+hN1M5Ki3LFus/MbqXFvB4EbgE
 xZ/kKNEHYu2SIz+6+W5KpX+VyV2f3HM/1qIlb6Kf/n1k7mDr8e9+cyqdCUS2jRgLzYW0
 NNyPNOODbgnCOaJumIogDpUf5zMIofZhL4ukY3cbM4FvYXXf28Dlo9oXpXoDUcNNzUdt
 /mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773971990; x=1774576790;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/eBnmi9iQCVvM7OEFm4LI9nJNI+Pese6YtcXwYE2SA=;
 b=PBDQjdClTDEFFKROm4Ppu1sSPhMSWoZtGZcHqvj0V6irGoKBhzKqaDMpyIsNp2qpzd
 toG655deRAlT8cIhWX7Uimideuru/an7by24ouHc16vd8TtzVTadDBPGvlbfS1EC7x/u
 vGGjDK6oH1B5O+b2i4ta5FnnFTwTXzXo9Bn+s/buoBCTOw+L26wHsvzCtb7fXJqiCmn3
 wShz/9GsT57JqdQh0+9itFK2CaO286qA0Bg6AR6sUyYoWGHcgKXn9qE424d5sVmk7Y/A
 gzXO0wjlDOqwcrAAmmKy4tbiZaIDLJtleb57byXEmwzQXnRyrtpsajTdOqCT+hPr5GcL
 hY4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeDw8aCJwB2976s6nEeMnV1JnW+pxZHGcNhkDDyeU4eLVzKDRAdTjDHWgsGaUzguD8Cnqvk7cThVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWJ+w44cNtboaP9/70gbPRSTGv9qJpi/DZ3tNm6s7aP6ON1vma
 t+m+kGZ76odkbPTNOOh6BrTg9pZoOPbxMnlz7VP19o8UT2qFnAW4fzqCAm3UfiM4IP7dmHuiu08
 wkU6n0dZ2Jkf9wEOQf+8cG0DtjOzETBnUY2d5LMBvYC5Pi+Pg3BRC6qtSRE1Bn/DjMRye1qQ=
X-Gm-Gg: ATEYQzxXoqflWcSqal7n5G2e5spmfIPM7ISytzUB82MEs+nvi1slpYqof5uzw0W/X3S
 sbwJqGLaocY8BDyuQQv3GOfhfzIbMIsZW/0+xDWXelkQXkb/4eeOhPH92A5P2yvzcNEWxd0A94w
 hn+wJA+VWQ9ckfCIwzEvM6iEUfd+dXaWVFr/ifYUJmxYeBCuDx8xwpHqypyMToYv9poaYMdAdzQ
 KlvRe52cfFMiXZ7CPTY27ZWZO5fgsLHgbeRwxwl+Wv5QtqTFTISeKa3LIVzgMCt5HPdPZoZimFF
 lKJTmnZpqZkSLf+SHa57GMGXWDlwhJvCuTws6gkZB0hMVe8/L3Wa9E9vTUnmQO+my4ztu2svy1b
 3dIwsZU8XtTQawCTZX9BoDSZ0LZf17F+hmniDolduSJf8gFFt/EZ40mbIU2//DjKqx62zaO+t1V
 7EM01czch6vkZx8SGpLhhXJ4q2r0xu72Q3koU=
X-Received: by 2002:a05:622a:1249:b0:509:3098:819a with SMTP id
 d75a77b69052e-50b374e56a9mr22611351cf.44.1773971990503; 
 Thu, 19 Mar 2026 18:59:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:509:3098:819a with SMTP id
 d75a77b69052e-50b374e56a9mr22611081cf.44.1773971990064; 
 Thu, 19 Mar 2026 18:59:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf972b926sm2581181fa.1.2026.03.19.18.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:59:47 -0700 (PDT)
Date: Fri, 20 Mar 2026 03:59:46 +0200
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
Message-ID: <a2xtesu626vmfetdoykojm33at44h7zxgvo6ytf2txlg6gn7ls@34jctkwswjnk>
References: <20260311-dsi-dsc-regresses-again-v1-1-6a422141eeea@somainline.org>
 <CAH2e8h4qnF3UxWFrU59BrStWMDc-=Vz9ZNmuq8Q3smhHeUzxyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2e8h4qnF3UxWFrU59BrStWMDc-=Vz9ZNmuq8Q3smhHeUzxyw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: bVWjKFGfkUcVK_t-4zNmFycHNkg7JiVV
X-Proofpoint-GUID: bVWjKFGfkUcVK_t-4zNmFycHNkg7JiVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAxMyBTYWx0ZWRfXyVCHY9PbE128
 xeusEYIf1MjFNEyrmgUz2Z0cjEUkhs991Lnzo1q2ZuG3wzNdJK6AxLDFtNTwo3c/Okz9aeSjEgp
 qojAByLG7/dyDu84BCqMTOp8yPqOQgyAkrreS43sK9ljEwx3E0zKkJi5K3IRLo+MJaN0hEEnfaD
 OCbn/hjQAyYKc5DFQfRyx92C2kpjJTHHaooS812TxnTYpT1terMTM83T2AKmZstUuidEQUQxrxA
 REdaalBRramVQqO9k0I7adeeEBW/zT/OV19qhr6GsuAw3YNs5amW2FvrdpS0NLZCXLjOCGEkft3
 ZsgXCzM2ATblFjbnPQOVryicJfKljCDOvTvgj+tUH3AoT671k6oNiV0tiamlhCsigaAesWUnDRb
 PDp6QrcIMwt9+tPieFZQT0oBWN6Wp/0nUE8zEWIHSPJjnn0DObRzCy7VEaZW/bsssvZEQtP9GPo
 2IRIx9lKxeRxREd3TKQ==
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69bcaa17 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=BfWMck_JzIBwxaTteZ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200013
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

On Thu, Mar 12, 2026 at 01:10:07PM +0800, Pengyu Luo wrote:
> On Thu, Mar 12, 2026 at 6:31 AM Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Commit ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when
> > programming dsi registers") makes a false and ungrounded statement that
> > "Since CMD mode does not use this, we can remove !(msm_host->mode_flags
> > & MIPI_DSI_MODE_VIDEO) safely." which isn't the case at all.
> > dsi_timing_setup() affects both command mode and video mode panels, and
> > by no longer having any path that sets bits_per_pclk = 48 (contrary to
> > the updated code-comment) all DSI DSC panels on SM8350 and above (i.e.
> > with widebus support) regress thanks to this patch.
> >
> > The entire reason that video mode was originally omitted from this code
> > path is because it was never tested before; any change that enables
> > widebus for video mode panels should not regress the command mode path.
> >
> > Thus add back the path allows 6 bytes or 48 bits to be sent per pclk
> > on command mode DSI panels with widebus, restoring the panel on devices
> > like the Sony Xperia 1 III and upwards.
> >
> > Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when programming dsi registers")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> 
> Apologies, I messed up, I had sent the same fixes days ago.
> https://lore.kernel.org/linux-arm-msm/20260307111250.105772-2-mitltlatltl@gmail.com/
> 
> > In addition I can't say I understand the original commit message
> > at all; it mentions a BPC=10 mode however the highest format that
> > mipi_dsi_pixel_format_to_bpp supports is RGB888 thus it won't
> > ever return anything above 24, which is the original amount the
> > non-command-mode path defaulted to (regardless of widebus)...  Was that
> > patch doing anything for video mode at all?
> >
> 
> RGB888 is the dst bpc, which is tied to qcom,mdss-dsi-bpp in the downstream.
> 
> Actually, we should use src bpc here, another fixe
> https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitltlatltl@gmail.com/

I'm really torn between your two patchsets here.

Marijn, Pengyu, what are your testing platforms and are you testing
video or command mode panels?

> > It feels like the conditional introduced here is only making things more
> > confusing, but I don't have enough input to confirm what the video-mode
> > path should be doing in widebus mode (multiply BPC by the number of
> > components and by 2 in case of widebus?).
> 
> I left a comment. For CMD mode, it consumes 6 bytes, for Video mode,
> 
>   * DPU sends 3 bytes per pclk cycle to DSI. If widebus is
> - * enabled, bus width is extended to 6 bytes.
> + * enabled, MDP always sends out 48-bit compressed data per
> + * pclk and on average, DSI consumes an amount of compressed
> + * data equivalent to the uncompressed pixel depth per pclk.

I think this comment more or less matches what I see in the docs.

-- 
With best wishes
Dmitry
