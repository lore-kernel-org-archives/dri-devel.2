Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17EFC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3E010EA2E;
	Sun, 13 Sep 2026 21:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eyGzXy9y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzOYyr0y";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1BE10EA2D
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:16:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK0sgL3043760
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wpeg4tsULyvmQiKySynkFQbT
 OmdnvDQyhOwFobjVtL8=; b=eyGzXy9yCmSIC1dmb0L56WHzbG3zxvbGUh2RXfWV
 wWFwpK+0jAwTXYhODUxQl4jVb1OR3A4QCLmCB6qaaUqpFG21rCFwJw+ijSHaBONz
 PM2cmiOr54uM1tID4Q7N3LabPpv7Pw7tbJk0yN1p8497R6d0cbRIIN6RaHYyNywx
 imz+g5TMvPXGMLOQsUM0MAYQLGR4z3xj2uV7nnjuYQ+TixqO4Tt0NsQIZ9+m9edp
 dv/0MExZ25PyKZqXU6Fj/ilarW9oAHnAHXoG6vVCmz89zqSA+wjXJNJMxphraIPY
 ChMtjTAVm5mkv/yHh0WOarKmjpjdtoTL3WHKKz37HnQNCQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm6pt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:16:08 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7866c4ed349so2405826137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789334167; x=1789938967;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wpeg4tsULyvmQiKySynkFQbTOmdnvDQyhOwFobjVtL8=;
 b=WzOYyr0yBqDNok1ZvHN0y0TqMUK+0nFuW4sy4YOBvODVDtNylkE588K3qKxVafeIfe
 qUixONce6s6Qo0auE03TkWuF4mimxvOyW3Y2Yk+dttpY78uzzESsLYLc728ViS7fel0o
 Qvd/zWm5llT+OZVbaAW7sk66Kx75Egunc6JBcYx0oSuBdBuwKu2cZUSDVJAGKUF+QXbc
 41VMZ/esqWqjQaws0EFXgBVM4CewZBzwNCGw/lx5v+ik3oZV2UBw0rTXMlgOtGTwqStC
 Kfi6YgoutHf85AwBKGzs10M0s0R7yFnOlpgvqUSm+Lw1e7E8x1HWDlD7rEM127lR5b3P
 pY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789334167; x=1789938967;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wpeg4tsULyvmQiKySynkFQbTOmdnvDQyhOwFobjVtL8=;
 b=aApzpDNEUNztCYZ/5FcButUdeheAcfmbDGIH4z4NPqMpKjW7p8MRcfrZ4uwAYJOJyW
 zIMWMKjri1dgh1y4UhKSg7xK+WbZUxjo6id3eJyqv4/6JEBsQgdr7bBZyidP1xOmSMEN
 et/uzTQDg63i0OIkcYRkebJRT16Nb1ZmwuJqAkhm7wHZjWRwxiFpeWhzIHcfXh+NZw3c
 vq5JYX9uqcbs+DoRg7JUOAmopARIhsSNCCR8mCT/m5oaE9H/Q3LAI829htNVLSqZeFrC
 CNtRjma9nziIMbwfLQQqeeiosPwvNFlhZ/Yd28wUMvQbIaqfKInrF4C2TQhaIfqWJSVU
 sB8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbb5RwcXikgkvGnftpVC26t+x/+90LtUZN+lkPZe2ruk/r52fvP2PLyM9MzdAv5PI0xihD6XTeC0Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kUU9sb2T7Qu20W7QJBOzueMtoI2rHFdbg0Bccp3SLEvp1VRktQ
 FjKC+KzvESH1UocqPcmFgPrfBjH4h7jPfTlT+l175AuLyeBEbTBPtM2iDAY+0eEoTA7U0/JHzJj
 JxhjyN11SW0p5mHEAn0xdleQHgWDoJZXZ94Xkl6NPLc//rZCExwGXVJemY97RlFPEJ+njGYU=
X-Gm-Gg: AYBFou2VhBb7y8NXZEJdLbnpLwMP2GjRlp1AgIriBKyKMxxrCjKniIwXX8wVd1sjK4o
 sV6m6XXX/MdVcdTOEq/rdpkxfvMkhT5vQY4SzagSXGwTVAj8+CCuWz5jXG29OpnipRgL1pGg8r0
 i5d2caxBgV7uyM5/6OyGAWHII8glALKxrqc3YVQkzBoLaKj+J0Iz3uAuEG8glOtXaS/LlSczfp2
 dLEPP+yO/V/h7Qqvh3s/H8ElJL4hTk3WIePFcA7REJI+KxF2FAc9dboZn+JTFfpS23eWAB84ASv
 ZhJ7S10z/XMuviWZrkOxm81glUrrivi2kg+oXxWEdNcbtnimXzW01VBaJTHuueYhFTQ57/+c+BL
 BcYeryD/MDaCfKiJPX80awztCdvXz4eAhvTqqmrZl1kHZf5OqCFkhztauDUzU8rrZ4zH6NTbrA3
 A+n2616vL+e/dJ
X-Received: by 2002:a05:6102:f88:b0:796:1ed:ba3f with SMTP id
 ada2fe7eead31-79601edbb2bmr6668211137.0.1789334167504; 
 Sun, 13 Sep 2026 14:16:07 -0700 (PDT)
X-Received: by 2002:a05:6102:f88:b0:796:1ed:ba3f with SMTP id
 ada2fe7eead31-79601edbb2bmr6668197137.0.1789334167150; 
 Sun, 13 Sep 2026 14:16:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a334baf8sm22310821fa.25.2026.09.13.14.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:16:06 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:16:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jesse Casco <jesse.casco@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: skip PUSH_IDLE when the link was never enabled
Message-ID: <kf43s2b4bt6q555leqyy3xlsv4ccqhapmcsesa535rmsnth4eb@zlz24kv7v4r3>
References: <20260808171325.133041-1-jesse.casco@gmail.com>
 <8728ddab-ec45-48a3-b2e0-93b85938d8b5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8728ddab-ec45-48a3-b2e0-93b85938d8b5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwMyBTYWx0ZWRfX0YYBqeDPN/JW
 07D4KsL7fz+8bH4M+62tyZ5ZcMmdyELqOo9eyNfwhLMXULlePWuAchXC2UPP/w+yGHVFeaYyI08
 HjirKVYRl5Nn18BgruRPhinu14VZAmTtnW9UDaEfzl6rx6KyeuvRtM9F9EESBzACLHcKwTQbOlg
 V/+6Mu8QOkvGGEpH/5nWLNe2uDoahMyvndfOxx41lIJNx2F/d/kWCvB7ZtbpaLi9B4GZAuTK2OQ
 jRS1jwhbBzJeozMyPj/n3HOkxFK6Bme77QOjcl3X/qOO0VQ8o8cWexFyYSi1tAXf9DpQqTUtDgW
 y+SYlnsrPvUC6r6CL43fmaN/CQdE+UJKQ4nFQw6vnyGUXTUyVrOdsCJ2wiyHfqW1RVLfyLxaBtw
 UEVMJwPVXtWnYPkPpq7fDUl8yLaXt0NN0lv9r+lYF1+OGv6dhkqocyFsZT22qbZOEkD20AWTn44
 OnX7ndAlbv+RipIxTyQ==
X-Proofpoint-ORIG-GUID: 0-bviRYKDHnlFCt7h6q59-pXnDG7qZo8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwMyBTYWx0ZWRfXyeHImAMRSoU1
 qx0i9oUlE+b5Hspz4tCfrPiLlqzrrg7kfDEDr1wR+0UFWwaJ0xCVAqSRBSGebEzMY59hLXZ9FH5
 fUiVK5m8AJqwewZQXn5zAN6ZJdkOgk8=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa71298 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=bqXh0vLP62WSRRxxKw8A:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: 0-bviRYKDHnlFCt7h6q59-pXnDG7qZo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130303
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

On Tue, Aug 18, 2026 at 11:48:58AM +0200, Konrad Dybcio wrote:
> On 8/8/26 7:13 PM, Jesse Casco wrote:
> > msm_dp_display_atomic_enable() returns early when link training fails,
> > leaving ->power_on false and the main link down.
> > msm_dp_display_atomic_disable() nevertheless writes DP_STATE_CTRL_PUSH_IDLE
> > and waits for an idle-pattern completion that cannot arrive, so every failed
> > enable is followed by "PUSH_IDLE pattern timedout".
> > 
> > Every other step of the teardown is already gated on that flag:
> > msm_dp_display_disable(), called from .atomic_post_disable(), returns early
> > on !power_on. The PUSH_IDLE write is the only one that is not, so the
> > controller's runtime-PM reference is then dropped without the link having
> > been taken down.
> > 
> > On glymur (Snapdragon X2 Elite) the consequence is not a warning. The SoC
> > does not survive it: TrustZone force-stops the SOCCP and ADSP remote
> > processors and the machine resets silently about 50 ms later, with no oops
> > and no panic. On an ASUS Zenbook A16 (UX3607OA), whose eDP panel does not
> > currently train, this reproduces without any compositor or GPU involvement:
> > 
> 
> > +	/*
> > +	 * If .atomic_enable() bailed out - link training failure is the common
> > +	 * case - the mainlink was never brought up and ->power_on stayed false.
> > +	 * Driving the PUSH_IDLE pattern into a controller that was never
> > +	 * enabled times out, and .atomic_post_disable() then drops the
> > +	 * controller's runtime-PM reference without tearing the PHY back down,
> > +	 * because msm_dp_display_disable() returns early on !power_on.  On
> > +	 * glymur (Snapdragon X2 Elite) that combination is answered by a
> > +	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
> > +	 * There is nothing to push idle, so leave it alone.
> > +	 */
> > +	if (!dp->power_on)
> > +		return;
> 
> Dmitry, should we even be reaching atomic_disable if lt fails before?

Unfortuately. The atomic_disable() always comes after atomic_enable(),
there is no way to fail the enable path (you can see the outcome in
other drivers where the _enable path ends up setting flags which
_disable path checks before shutting down corresponding hardware).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
