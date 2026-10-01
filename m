Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C852CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654F610F5FB;
	Thu,  1 Oct 2026 10:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODclBncv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SlPk2OeW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B5910E14A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:11:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xMd71933056
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=W7HiTzxnqmMRW21kIsXXn+mS
 WVyRXOggKI8Jw+ouGq8=; b=ODclBncvDQw7kJWsRdEjozEm1hqY9fhclNGowQst
 4gt0sD7YW99zVYN0FbgNWhSwpEnbw5XOLCQG+8Mm5KC3roywidi5BGHCftHpZSeP
 l1ogiXCPUkFrQn00KfaKLE8VkUNiO+qvPv/LCze4Ms2K9xg7tsqcYMMYh7YmQMoi
 xJ6zepFCGhwIzDieQaXRiRxSrYm2LvmFavg3tAbbScTzjH+m0YcG+7niyLondHcd
 G3wg6fU7Y820oZ9MhViVV0jOKw/aREFj5GzTQrEeGl8NaP21x788igPeZAyGu3xq
 d0Gl2wFX16ay7N98Z0UFtrPdzeQot9NhdLoQnuR/oqyePw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfrwf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:11:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917b76ad48cso3693746d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790849494; x=1791454294;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W7HiTzxnqmMRW21kIsXXn+mSWVyRXOggKI8Jw+ouGq8=;
 b=SlPk2OeWfRDajaLfWmffQBBk3Slg9ZXQrSAdrM0wYQkWryhwcpA3ZzmJYP/kPeAx/f
 8CBIZCemXKBNlfnqCV/5EYveuG6Q0wD6HK4pr9O4gMHcOJdfyLsAgvv/2hQvBtqXdqWr
 lhr+WxRu0cwC9ZQtiCL81oTlHTAExNEwPJkluORZ3dpTtbG8r++LOB40LKLD/pJVYruI
 y06j5Qd1rgVX7/IXz/EuebLluQOWopMuUnd+3ie7sE1kT88w/XXta2UeOTmgT2mL0Ybm
 c8dt7oAhcYHuyqckTH/C373mrTAEapbQ1tNgTxyRPpZ6Ky+dwtQU+OYAdCAAnivLwJj9
 QXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790849494; x=1791454294;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7HiTzxnqmMRW21kIsXXn+mSWVyRXOggKI8Jw+ouGq8=;
 b=pBZIwfqdkr3WsoaS3WA5g2N6HYOjgdmsCalfU+8omoYqKtwqJechH+Lt5UOTo6cqkD
 ka4Dg1RiURYnld6h2s6qqRTxi0qm1UP71QmEu0xCuXmxFLKH2V8AafKlI5/sDhpbyJpW
 uNMpADi/Ms7yg5QXo6IEp3RIKi3vBjMNCME4gMfhQSPhB/rS4npe750PeFiFlxoACZ40
 SCIgrx3tXh6iNLvDhhe4inw9iV9JW1JYF8D+rSvreUqfnYorkw27hoy83XObYZ/8b11Z
 0inVjJhGhY33IdPYRT7wBUNqJh9cP2Jln2ujRPDtgz7N2YkE0+R0utfSXn5VqSvuyyca
 mWUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrA6zrB+TynnIYzeMt0zwfZJ6hIdqSoCCW4wY5q1BbdC/y+5gojWNjgXnKKsGCzpcKQy5R9q5K3+Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mRtixj/lsb7+2duTAiXm9b4Ad6zDMiXaDaJXXSlJ+XLlcWTYp9
 e8JcbBI5KdLdMvFIwnJ8tmngCUVg/IJpEDFScSy2jy2tBuxLFkp0JP7hUp/cdjiGpmbacZebZ+V
 kXL8jdDJo8EZ+igc7vK1NNnvETE94D3DbzHRT2BzHN9AdLHAnJ1COwxfqakNUDHW0a5txpEo=
X-Gm-Gg: AYBFou3jEXvtNi3TBzBfDSNj5oGteWL+Ah0QFe+CBBWPs5YlprbAOBPcVDPHXpoY8KU
 llXnKDWadWGXm7Rrhr+iH9WNCRtTe7lv5kan5t8esYTpStwW5Kpnf3q/lyz0JqYfN3rwPD1cCMp
 GyzXLh2ojWLO4/btTjUWNicRs/atTQbGMzdFaujyZZB3okQHuZBbeLPiixLgpxWE9sn64cbIE5D
 ABlw4sVP+T/62PHLege+3q/sLI7pczlp3BW7ikJlWaCGK83S9SLXVuC3VLbhnrxMLd6RE3lUAwU
 BKvP4GVOfed4J3WCPXm8kkQYosU/QMAJDc7yMo19FRNXt/ZawY5s44McP6VXcItX/9EJiSuTkTQ
 1qqu5QnaHFFVCP51U1J634k+EukLil+a1HC5RCWW+/1Vehfee1sfJnIPl8Nq6gAs+qm3b0RYPNG
 lC0AQwr1e133HJ
X-Received: by 2002:a05:620a:84c2:b0:93c:9edd:7e6b with SMTP id
 af79cd13be357-93cac1475d8mr638119985a.29.1790849494399; 
 Thu, 01 Oct 2026 03:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:84c2:b0:93c:9edd:7e6b with SMTP id
 af79cd13be357-93cac1475d8mr638116685a.29.1790849493961; 
 Thu, 01 Oct 2026 03:11:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba440772c4sm447585e87.1.2026.10.01.03.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:11:32 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:11:30 +0300
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
Subject: Re: [PATCH v7 01/35] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
Message-ID: <u6albuy2zlbxl5rmxaokpyitub47toemfefgszttykinavh4ir@xbnczy53fyds>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-1-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-1-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3DNh0fo9cqMl
 2ZHWtdtRsgGoCOOiP1Iqjf/ArRavYoBKoMJ3g6GJfIJNdEQmhQcOqURt/M+SnCcepFTFf+kR+kP
 SRrl2vTdVgR28U9txOiJwi11FVA2AEU=
X-Proofpoint-GUID: 5TQGQAFwdujybcsa7Rz7hTGy6myxrcbW
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe31d7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Ull_tw8qIylx0EAJJFQA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5TQGQAFwdujybcsa7Rz7hTGy6myxrcbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3reYPJrW5L8G
 voXvXyYy5migRFn6e7QWsuhdudDmZZtwHUx6bLlU+C25Cd+9fdmUcq3Hl0+8M7EsDqT8R1BJU9Y
 LBCxjey+R1+IjlQo8bZ5ikk4Ik3wSHICkjmlwUNKVJ1mJA6BF1tf7N/aaMWp2ZECCsDXsp0RePT
 LV2fXmO7Ej2U/GUFZt9JCjQxCklvmojzcZ7TAZmXnu46TYnguVVelFut8tcTdLBHOg7tJLIjXvO
 v6KGoOXcFrlbkL+ITX3dfG6Cp2Rd7L6BGTNW/3R2oyVD/GJt8hDViQgmQR7mZDbpty4OpIHFs6H
 PUP7LbzjJ+Hkr0pJaI5/7C0fXqIpyDaWEkXpdccApgBT3MIDgBEju+uJrJ1/kto6LdT+R6wG2qz
 jju1TvglJjSNZRsivUxMJVLVbohfcA75hKy2i5NQBYiwFa8OBu4Wqx7JEEBmp7MLG4KU1xoDqp7
 xrWPqCpMj5N7I2Y4bcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040
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

On Tue, Sep 29, 2026 at 12:25:25PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> msm_dp_display_disable() currently mixes stream-level shutdown
> (disable VSC SDP, off pixel clk, clear power_on) with link-level
> teardown (PSM config when sink_count==0, off_link, PHY re-init or
> host PHY exit).
> 
> For DP MST the same link is shared across multiple streams, so
> disabling one stream must not tear down the link. Move the
> link-level steps into msm_dp_display_unprepare() so that
> display_disable() handles only the per-stream sequence, mirroring
> the split already present on the prepare path
> (display_prepare_link vs display_set_mode / display_enable).
> 
> SST behaviour is unchanged: atomic_post_disable() still calls
> display_disable() followed by display_unprepare() in the same
> order, and the cached dp->panel used inside unprepare is the same
> panel that was previously passed in.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
