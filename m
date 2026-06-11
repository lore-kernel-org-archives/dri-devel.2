Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70C0CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D7010ED59;
	Thu, 11 Jun 2026 07:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OiQWMt0h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MdcHkE1l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F28310ED56
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:51:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQh23817113
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p/X20Z2CefrI8yMv/8IpDBoqq2Hb9n39SsxgdwnIVWs=; b=OiQWMt0hPdkUmBxQ
 L0B8ZhmcJtjmI1w/TbShYSDVRgrpWZW3o6vafFjuE0HHB5d4eg5YBL1PKWZ1XKSv
 WWrAqqtcYVONSwYsxy1VvU1LPnHiBq99pR5mSGX1Wbg85GFooHwCicTtMacQLlcv
 qt66nVW97zM7XKl+3Dk3SCZDAyFw41fA9+BUTWUODQ4ubac9aHSme6wwEegIU9td
 7JZObfCtWbHxPom/sUnpVg69aTqAmJ1cOwAnqfZ+7G41+pav2BuqsyD5Fgg1ZDiY
 LJQA2KS62PW3HlNLh3TUU0UdaM3hib3nSeF2Hsx2TmMeCFGAtp081s4WBYRsB32l
 vO0VRw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ut9pk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:51:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517865e6219so16577711cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781164264; x=1781769064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p/X20Z2CefrI8yMv/8IpDBoqq2Hb9n39SsxgdwnIVWs=;
 b=MdcHkE1lGWg+C6wn6gW8HgKE6UKc0+tQa1bq4U738RUW9LWY6r9AiT04Nmpp8c1htf
 8wcwgW2hMyfW8tBO8D2xA/d9O+WhrZieBMq1J1SF5jfUH9xbyP3EFErs25/T/fOtEG9w
 gL2r12YtZD/gzbMm2vM/uiqekT++84A+GtG+6t3aA22e4CQcof3hb8bppA8Ogg2Jh6uf
 BHYr8AY/vlQtTwrZ6rBKwZiLIgMTc0s6UiiF77ifKND1eUnUhUbNq1ng6aeZO/umhdTS
 OCo5PRs4DTFaAefaK8L64vwBeWmilSmNHpFtuwRZz+ISb3rjHInscvHM4hAB4jzgQco8
 /CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164264; x=1781769064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/X20Z2CefrI8yMv/8IpDBoqq2Hb9n39SsxgdwnIVWs=;
 b=R+QftSbntw/vFNN8WUwtzZSQFuKXmJ4zLQY0qbbEVm2mL2sHwbE7Th0n8L8dIqJ+kn
 tm+hOju/TF5BSlI3/oCSFobIAFWoh9BSvy/LT5gv583qBzhGz0SuPxFjQHXrs4L4/B7Q
 rRxawivMvhnAihlQP/DOZQNUViGIO6SCQbgWW8f3fRIGAs+CyGBORHUn3UHcdvc9Zrw0
 gkpaC00Jiox6k1nDpNIddlz/Ppr1R5Vrc7bq3/NkcANJwlTrxiT+4h++LZUZQJhIeM4U
 s2YwaxgjGGX9W0gHa4/ORh+hvERm/uUM3Cum7Y1+CfNZjP8z1NDcrmUiBrr590MgYd/Q
 2W5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EMOswuaINMIIdQMDqVeThVL/TO8CPdXCssDXWFl7QzYRefI+u6NMGxssRRdQAvbw+T+ZNwfDYn3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwV5dRQdg5ID3R30mNppNhCy6e8idLeGMZybjF1xU6g0a1zhZpp
 ilwq4HDnvY3pBy4+765FaWEt6VrEjYA5fi/IU53DMZ/sl+n+RSY9N1W2XxcpAZjYhG6va/AyX8B
 PjcWcl9qtJ+5kyHtfssUbgZZKuxmEGEavjKTL98qAyS1iyo9bWxK0cl79iKUe2jDr1I2BEe0=
X-Gm-Gg: Acq92OHmg3pzJQx3nHVaq5KTRJc1SS7jzzdUauXAVn7R4SQDO4CjTCWklSgcaOwmEqG
 jXivwz0M8L5TCYs5dyd34ZgwJA9B+3rxUUfH234w8Voa3pR6QB8MxXH/3s1/SBgXC/fCPXM8M6V
 0hxc/b84AsaknAXesIDpnJ39jdJXLbTDSJUikCZYQa3ZipCwskrBNwtLuxLxyhlUS+OTqPkZcIY
 zp0tJSHKIluRRVy+QGfmHoFDGB4ad5TvQD9NIIKxwhkWwQudYedd+xMHg8HOriPdW9x0YtVu81a
 L41GzhQaNYolhus6C5tncUtKlYRDbPo00vudZcZQVv6U0zI8GX9YLk6d4hAKqQoUttEjsg3MmUk
 rvvduIDPSDlMDfs6qciaaKRZ+PylrlfIClEKiuxok9QGIWxmp2N0oC5ng
X-Received: by 2002:a05:622a:c16:b0:510:144a:636 with SMTP id
 d75a77b69052e-517ee281cf9mr17195381cf.8.1781164263959; 
 Thu, 11 Jun 2026 00:51:03 -0700 (PDT)
X-Received: by 2002:a05:622a:c16:b0:510:144a:636 with SMTP id
 d75a77b69052e-517ee281cf9mr17195171cf.8.1781164263570; 
 Thu, 11 Jun 2026 00:51:03 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb6a6cc97sm23272366b.63.2026.06.11.00.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 00:51:02 -0700 (PDT)
Message-ID: <998b673a-9754-4bdd-a305-73824a8f8060@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 09:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/mdp4: keep the bus clock enabled while a CRTC
 is active
To: contact@alex-min.fr, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-0-22925600e4f2@alex-min.fr>
 <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-1-22925600e4f2@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-1-22925600e4f2@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a68e9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=qYPBgzPrCaqp2f--smQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3NiBTYWx0ZWRfX0iCjtZNnFPui
 fnGrfIvwntRcfJ83b/5sNzzHrlOwj5N3zzYKBqRRPt48MYYiTqgzAQTAFFfzFFtpP8T6cQjMs/L
 v+90IWzmqFCVbEPPzjwALTDKg12MXk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3NiBTYWx0ZWRfX15Ycojx+9Tb3
 u89csKbDGDeHmC4VWw6MAPvVffpK9krU/VEryr/JJ9pSTpM11Jen55dyy0GBxO8nSHU2ybY9Bjf
 odL6tm47omW8B7EkeXbSQ1KSa+PJz1TtKNYTb6TVXaIctxm+W7ALbp4MKTgr3Uy2TBjW3M1quT5
 5G8HteNo53lAdV2NmzrKTnovb7xs1qM2yFvM+Kf0XVkx0oafTYCpx0wr0X0de+Pz1frwiVyb+lP
 4jZRVgE4PyusBWQNsnKci1ACFfu2qrxFFnfi4ExyjjnCSgVihoNiBYjFNnOHR3TJ8BEOIqtZqqN
 QYACP3FGcyl7IFKqe2wB3ICJfF2WSoFhYBsnwe/nmEYbAD/q2ieezHlBzj6MFyuR9jhingzeurI
 5Lvtq87ypNZh/VASiv4P5wwFEnvhW8kMnLRQg9y5Tr8DEaWmS7wgQbauBkDjbmVBihUepm0adV4
 T13n9pcGtGsr24j93Ag==
X-Proofpoint-GUID: SKAx86pIZpn3Qo6JC2yTomYdVLP1O1HC
X-Proofpoint-ORIG-GUID: SKAx86pIZpn3Qo6JC2yTomYdVLP1O1HC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110076
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

On 6/11/26 8:07 AM, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> MDP4 scanout continues to fetch framebuffer data while the CRTC is
> active. Keep the AXI/bus clock enabled for the lifetime of each active
> CRTC so that temporary MDP4 disable paths do not gate the bus clock
> while scanout is still running.
> 
> This avoids display corruption seen on the Samsung Galaxy S4 when the
> display pipeline is active.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---

[...]

> +void mdp4_crtc_bus_put(struct mdp4_kms *mdp4_kms)
> +{
> +	mutex_lock(&mdp4_kms->clock_lock);

If you use guard(mutex)(&mdp4_kms->lock_lock), you can drop
the manual _unlock() calls (the lock will be dropped once you
exit the scope

Konrad
