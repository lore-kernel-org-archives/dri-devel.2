Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9688DC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 18:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CE510E217;
	Sun, 12 Jul 2026 18:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BndAxUmz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIR+gkfL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7A810E217
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:43:11 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CGsY5h3176754
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Dd1HYR9i+2priB7NS9AsVQef
 +C1A76nILFZcby4DIrg=; b=BndAxUmzbmpurBbxKk/tOWqMtzJdcUB5eIexgvPr
 3EnRsSKua6Isf6goDqTE+dOt2GAHZ0R2U1N6SyNFq3QFb1oB47Db34wBMtssCqAb
 n7kCptK4n4ohFmfDFz4zDkaA1RZnyFbOTRZpSQlUeO2Dve6g+hRAI488lcdbUZut
 8xQyi6FezGs4zdXOhL+8FGDQJ7htnPV4smuI/2yBX5CRwwGPkVoaostptBhuyWLe
 yE46iPCCIySDn70qkP+vwQhtV6VdrPT27ciP7b7pNHnu6LDJ2MrzzVIBqUtBxT15
 KKCcYaVFA4sSM8wd2ebaSbyLwKWnq4llhAl96b9JigJJ/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hkcbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:43:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so26579541cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783881790; x=1784486590;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dd1HYR9i+2priB7NS9AsVQef+C1A76nILFZcby4DIrg=;
 b=eIR+gkfL5h7yC0YddLoCh2Yq6NW69ajuRBymMMbZFrccDOxqyHyPfWI8NjYLoRfXo0
 2tcPtkWrp2lWK+ydRfIw2FfoMP2KOuJzd0L1jYT+A+VyB6acnqjJTG8xB3ndYQVnvN6F
 CQJMW52AFTEDqvQSyNMwoPMaC2teFOj3HBvkQATABVBZlNjQ15ozky4IbWFleQWY/EfP
 bgZZRfWrUFb8rfLbVBVu8MuPdimZ4PeDyzdBN49Nj10zdlJkvbEab8VheMu68FFG21Jc
 8uxcnTJ0A9HpPfeJFJms1MMIbXihbt7IhjlhiGv418nQknYz6aM7cQt5+NZFh5wD+ukm
 TdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783881790; x=1784486590;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dd1HYR9i+2priB7NS9AsVQef+C1A76nILFZcby4DIrg=;
 b=aev2bCGfUfyRCXrljyDRaJw2Zrqcgi4oqjwZhp6V43K7KYPO2eflUSVyEFk8uMwuAo
 0rY8M3CajsEeepirB9tyXKQ+ZUk31qbNb++4WHk0ge1lIYjI6dlXiMtAH/w3Fv3LHoEc
 +/qbQaq0ZQTolII9Ja5M1Kodoh8U/YiSWOZUFrvQSGRERl/BCOs8JMwFDHE+bQ8YZ20f
 bocnMzD4Ie8stb5Xy1dN5PU+ZRPYjqj00jeOJ/ntPyEiPdWWPMbgZw/PpAj1eeyK9OVl
 juj67lb8kbtodW2XOT7JNcViSZh06B47RxX77q9Fj2CeSESQlX9K1e2B/weKbwr+z81W
 ZdbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrukcYHaJ6IkzDxvVSDjNbCuhvqQna1TBVahA8ETglqbzIdlScS8P3Iz/JyL7QoGewu3cu1hQ4XqPM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yys4X7FneQJTzYZe8irA5TigRcKGcQtSbBnie1/JOnC/GJxehtl
 iFvDKT33VvYjwxKyLLdIJzg/vYLsBi5xCBiBAYLRI+azrt1d6KGhVDcopg5ES1sJ6BeguSWOYzU
 qNwV9zoGKe9xLxzAIb9dQFUtsd4JsP225MvMocOfAWtUFcQP0tQyleFQ7nWrRfP+LTfxa24E=
X-Gm-Gg: AfdE7cntfk+msxlbis002WTB0JMKguvgCxGBpXkaAu2c+2Dx2b+w7Zv9MFCpgxepGI0
 RxbM4XEOxHau+VCNp7GrNg1NPKwguPybuTQTDBJRVRDfzDvpnwSLbcV11B0EeVqf1WKPFgABUNq
 4RReWM7by2bSW3otu9wpp17ABzuOcVPjUItWqHo4TRM1MxFOamP/YR4aLNhcma24Ympuietlg1g
 cHCn7ij6QqYvbH5sYR/8CMb/77q8qCaTAow/eml8AY9rgpyyQ0Ko44xyjv5Uzyk1pj3gTq8/46b
 etvMjlsXFbmrZJzfnBuM3U9+xLuILsjGB0Rl8ATK+x41Uty/mlu0FyJG12PMvhgLnLMjEe+XM3g
 M2Nq1Zcmy1ha2X21/3lEMlikL4LjlLygwMjzsukwmmwc0IE8PM/TqMR+QrC6l48kMGXh4dGe+up
 mi1gbw9eKSmOwqtE1BaCr184qn
X-Received: by 2002:a05:622a:10a:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-51cbf137976mr69665011cf.37.1783881789524; 
 Sun, 12 Jul 2026 11:43:09 -0700 (PDT)
X-Received: by 2002:a05:622a:10a:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-51cbf137976mr69664741cf.37.1783881789026; 
 Sun, 12 Jul 2026 11:43:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca4a2f4sm2239528e87.10.2026.07.12.11.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 11:43:07 -0700 (PDT)
Date: Sun, 12 Jul 2026 21:43:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH RESEND v5 12/25] drm/msm/dp: factor out _helper variants
 of bridge ops accepting a panel
Message-ID: <v3cg3jip6vvjvytnb6de2c2ivcoa6gdbclxto5qgwziyfy5dvu@tt65oy3xz4zh>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-12-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-12-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-GUID: uTHs4Iy7mbjZvNGRg-qGBKBWb53rcu9U
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a53e03e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lnGR3UyN__oGQJQYKTQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uTHs4Iy7mbjZvNGRg-qGBKBWb53rcu9U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIwMSBTYWx0ZWRfX4oRccO3bHLug
 0Vn4bjusCDSFwWI2WORNwvbwVBb7kpbkDFkg+U4UU8ytI/bs4ZDdEZmWD6zbM4S4++MgesXE1OU
 oIRCi1lNrNnta5UHqyP/F/z67bDWGwf2hgTEz0TdNDdgYbyeRy/qbih5Dhhvaahs2cPlqIXhMHm
 2VCqqqyHe96QePkIczKqTCYTen43iYwHkMpf7Z8FQowOipBFB8WwWOAJ1SlqdrbA3iZIG+TOVdf
 Px9nisD+3g0Py8KiXmJrdgvAhd0/jKHVw1KVdST500B/tgdPhwvLnlW3UKCEzFut7AQAy4rqfGF
 cxGZ7ZpXI6F/y+4GkfIyuxWe+Gf4z3iZwgf5P2+JHmTtrDW7PR9k7FShRIQScw2s9p+5QEuvkkV
 hHjNNgNl+JmFA6woIu4cycRzit9nGykzh+rxhj/FsVJkQ+IIROExyOguNMKH+OrUcrRwx/SepSC
 rgj/KPOUvLaQMcTtmjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIwMSBTYWx0ZWRfXyHSsjZiulwuf
 DaWsV3xaleP5UDBnu5i/ejn12Tgm/C2xPXyIXM4yZbVTsc4bNJ1AChMcBCb0YwkolYFMFyve3TE
 JobAqK/izoCZuL3SLDVcZet8vICbXh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120201
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

On Mon, Jun 29, 2026 at 10:14:33PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The atomic bridge callbacks (set_mode / enable / disable /
> post_disable) on dp_display currently hard-code dp->panel. For
> DP MST every stream has its own msm_dp_panel that the MST
> encoder owns, so the same enable/disable sequence needs to be
> invokable against an arbitrary panel.
> 
> Introduce *_helper variants that take struct msm_dp_panel * and
> reduce the existing atomic_* callbacks to thin wrappers that
> pass dp->panel. No SST-path behaviour change.
> 
> Also drop the static qualifier from msm_dp_display_prepare_link()
> and msm_dp_display_unprepare() and change them to take
> struct msm_dp * so the upcoming MST encoder code can drive
> link-level prepare/unprepare uniformly through the public API.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 93 +++++++++++++++++++++++++++----------
>  drivers/gpu/drm/msm/dp/dp_display.h | 12 +++++
>  2 files changed, 80 insertions(+), 25 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
