Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E6CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B06310E64A;
	Fri,  2 Oct 2026 15:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ho54ubB3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N9DRNXHv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D42410E64A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:37:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGxce2120793
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=h4g/WPviei+C6SLy/mZQbFaJ
 FBkh7Ho9Q8Bl9QVgB5g=; b=Ho54ubB3Nd9JwBssip9zGOvC9VCZgXFbNytV2Hh7
 DdH7Vo80XXAL+1X2naRzDljJvgK5Q/BJ6mCT1ToE5Whq/1FPKn4NWxXsLOYt2nIf
 CI2LeGV4x5aGOdfpQ7/9Kfs4pkKOgvJ/u1vWU51+AqtbHwg5Z8diGBIwRdgbNtlF
 2int0ckx/qSIyil0xqf9xVdIUrHnugtm7bIvbZ6wuERg1XBYXhIke2CiHAjgQPg9
 09SikmLLncLqXO/u8tqHMtkiXqY9OxlEQxJteb6QtosgweJUodLQC1ZB4CibbA2V
 PS6gi8w4H5CCizcgtuxWgCfq1QCoSyEfWK05OFT90CQkuw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh2x7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:37:46 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf08dc2fc8so385794137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790955466; x=1791560266;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h4g/WPviei+C6SLy/mZQbFaJFBkh7Ho9Q8Bl9QVgB5g=;
 b=N9DRNXHvwBfZ0QSy8ZjJpdbZ1U7XZBM1pLH6B9y+ltqZCofZTNDr9LSgQ5EWtD7/cB
 o4L1wcdksNJ1TlkJkLpstXg6YFgMLD82l2TWjNPQ8pnV2gYlsBdoR0RD7pu7zONLH4av
 5LaRWhQj3qXOcVcvL/plAOw8DhB8Mx2MFEiRbozKKw5iFft0cferhfrRwrWX0hfGSokP
 P38RgTzQ9EjqLy18B3um7cZmb4Yj8xJmbnfUBrXdDSonOQnSAdv8N97FYJnXua3QDw2C
 CNpHh8CJvwxHC4Vl6PE+1Ujt/9w5Jbw5WlTdGNVuLYusy3ElzG0AT+P3RL9Da3XhKpZc
 DT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955466; x=1791560266;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h4g/WPviei+C6SLy/mZQbFaJFBkh7Ho9Q8Bl9QVgB5g=;
 b=HWcSiHQIlZbvIr7WSrSvu1Vb6Be2EPTCVofn/0Jjku+cuxi6Y4oQyou6Iw8JRccYax
 TF481Xzk5FTdOFKBL5nGmyKUTHLCcQ9/rjw8k4ClFdagdtIlBpYaCnqtpLslKrGrCM5B
 BgyUV7uLjfuOr0Hk7lwhUb/tyrjCGMORK3n7TUmtY447pnMQdW7BPBNKVyjxT8s6mvNX
 eKwccZ48V8u5qhbLBwQ2JhyjeZfgMLG0FiXE1pIP5HWVL//pZhIIQY5q+6pqo9Ww9ZD2
 dfTi+0b6m0j0a3wwz00GGHZIDgRFxv5bY3KzczC+PpE0JLcaLEbIPzDPtbgbCW3IIAUR
 tfng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhW1dVd6uCH88As5PfK4I+QEEgOPqj61d4RIpGYbgGJ+7HkyDeI3Bw8Fwp7fo/EilyHGrkhE8w/fk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJzbG18E9fXzN3+IYcZkLfZNZOKWwQH2FVyFEyJgxCoPAVLO6gB
 vr9L0+0rpKcVp4b5WJm9LiU1ZNvf6MyIX87wE1obipYnG+739cgLZdttN67JI1f4zVuCLw+SbGN
 4T9/4ma26dT2/axdZ19spBxNsoLC+xSx3Nm/n0+uo6k2Z3RwYKdtz9QH7jZOOuFnXB/ev0Rc=
X-Gm-Gg: AYBFou3wUYoBmgle59epwwYNH+H0rlcDyHBOQrchSUQ5oBArXhdM1PEHhNivpNaJyfj
 fhWYIztdXI0UqeHJf1cuQovDGIAhU1Q7IRHOUOC5UFhhnuB8eR4ZTXkiR943P1hO6ocmt57P1I8
 VhqKmb/PLwAsnerIETMWYXovuvy4g6DYfBHVT2vO7y9B5x+/wah4tz7vdxnUtovJMb44zeuCwom
 op7hzPui0nQOC5xw333DS4ybH3bntLq+thFLfpYo/SsN9r9IGxOfjqNQ0ZFSaco7ajnoa0PwoIP
 eTiWQ8td5mu8qMcrv07sss7RC9rGeaBweLvnMrsytEZiR/sNB7DWbCiTIZ31QSkq9d1G31SP7Bc
 9edYKjN5NTzIGjFeS1g2vpFUw4uOty5sQu19VH4CfTEenZlPVyEqyKPNuHAKq8tP8+9x8kqEkhA
 ==
X-Received: by 2002:a05:6102:2ad0:b0:7af:51a:de01 with SMTP id
 ada2fe7eead31-7c0f4c9a360mr642499137.19.1790955465695; 
 Fri, 02 Oct 2026 08:37:45 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad0:b0:7af:51a:de01 with SMTP id
 ada2fe7eead31-7c0f4c9a360mr642478137.19.1790955465135; 
 Fri, 02 Oct 2026 08:37:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7abcbesm825562e87.63.2026.10.02.08.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:37:43 -0700 (PDT)
Date: Fri, 2 Oct 2026 18:37:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: compute the CRTC bandwidth from the
 state being checked
Message-ID: <nixnxmt6flxt5wlibwi5bkb4l5yggh4lhgmfvib35lzx5jqiwv@3jsm6ydhxxki>
References: <20261002130656.50577-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002130656.50577-1-26rote@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MiBTYWx0ZWRfXxkMXCVfu5Hlt
 VAyWEHeQec4R16wug5B1Gc5YvGKLuLcwL/EBqJL5hkXwviNWoJrZS9NJY2H/kApjUC5iz7FrhzX
 Kokik5PcPJxFaHarKRmFjOforZgNi0c=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abfcfca cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GO0EqH_1EsdgCyMpDf4A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MiBTYWx0ZWRfX5VIBMTCDoTsQ
 wMBPXX9it072MPDh/tG1eGtQ5NQ6cuIVYy2EJUODWZmrATYyw5ev+M27NTnijPJ0f1PL3+SvSYk
 JSUW5VuFlBrGzslahakWizzfybxTMU5uGBSVjmbxoxJdNMq1ssRVaXs/LegCAHRkkTVwvNvXz7a
 yJEAOEp2j+NowQyB/N85k6QN3FSd+bwKHONlqmEckGBI1GYtzqD0rGxQB+oh5t4R3eo0eeKTDRs
 wBy477419OfufERoJEwSPMc4t4bUPbXMqhmJHqPR4XTxosplkLweSO9gd1OzIpDXJIJaEx1Rysr
 3xiHksGBwsCRpKpTe/GHIWmQzxBiePt/fxhNHT94mkBODIZvoodKtv1kKaI0Fxf7NBciOcwwh8V
 gGFUjZjXqIYZJe1nCNUhbWGeGP+DJgDrpNusc3/v2OvrVl4/GqQi/8t4bQb+bDfiH22HDkonam/
 K0S2Vw3N8R6h+MaI3fw==
X-Proofpoint-GUID: IBwmVNWlJDdnC0HyUIRBXrosSnQu_hg5
X-Proofpoint-ORIG-GUID: IBwmVNWlJDdnC0HyUIRBXrosSnQu_hg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020062
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

On Fri, Oct 02, 2026 at 10:06:56PM +0900, Joonhoe Kim wrote:
> _dpu_core_perf_calc_bw() is called with the new CRTC state but sums
> plane_fetch_bw over drm_atomic_crtc_for_each_plane(), i.e. the planes
> of the committed state. When the CRTC is re-enabled (DPMS on, system
> resume) the committed state has no planes attached, so the check
> computes bw_ctl = 0 and the display runs without an average bandwidth
> vote on the MDP path until some later commit changes a plane -- which
> may not happen for a long time on a static screen such as a lock
> screen.
> 
> Seen on a Lenovo TB323FU (SM8850) through the interconnect and DPU
> tracepoints: after DPMS off/on or s2idle, dpu_perf_crtc_update reported
> bw_ctl=0 and qnm_mdp was left at avg_bw=0 (peak 800000) instead of the
> 3728793 kBps voted before, until the next mode change.
> 
> Iterate the plane states of the CRTC state being checked instead.
> drm_atomic_crtc_state_for_each_plane_state() falls back to the current
> plane state for planes that are not part of the commit, so the result
> is unchanged for commits that do touch the planes.
> 
> With this, bw_ctl is 3728793600 right after DPMS on and after resume.
> Only tested on this device.
> 
> Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> Changes in v2:
> - Drop the code comment that repeated the commit message. [Dmitry]
> - Link to v1: https://lore.kernel.org/all/20260929130633.977-1-26rote@gmail.com/
> 
> _dpu_core_perf_calc_clk() walks the planes the same way; it is not
> touched here since I have not seen a wrong clock vote from it.
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
