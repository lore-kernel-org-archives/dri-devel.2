Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B811C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A53210E05E;
	Mon, 29 Jun 2026 10:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRxQaSze";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZE4jlH/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C43E10E05E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:20:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T7Dq8J2188726
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0UGKVqsdGzbosb+05ZlN0oEU
 xhwfuM2PCDbsn8tProM=; b=YRxQaSzeimiNXwkmQKEKAkI6eUjxi0HuQqHn/ObK
 C/m60CMpRpmK2tXn/hjS8eQQqNVQQeHO7gGlbejGXkt4DWDrUv24dZ7eBDpCvjbZ
 XjJl6uFNzd4nJMRJxcgSv/qaKfeI9ZFHMNm3gT2nZOwvXVffAFt0XtkaCJ7qdXi0
 a4vj5SezFbuRh7SVUsgz9HfhBzwz37P4nkkF0HgkFDvB51VdDNjMUrmvJcYzLFts
 Upu2eTUupchJ8PURTaLNhjIEO4xleFCRaSU9g+0NIxAMUo+dn3co0LbRnnlv4QG+
 gICYmB00ti4aCwTw8WI267MDSuabGd67VZJBGveC43/bIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trsfv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:20:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92b2ccd7971so573847385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782728401; x=1783333201;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0UGKVqsdGzbosb+05ZlN0oEUxhwfuM2PCDbsn8tProM=;
 b=hZE4jlH/yd/QV7HcAdHtQejNKQWbbz4fMgrjhzYRwm6g+4yFN1YbPUZAofGl6lc7AC
 CO3VbDEndYJYSSklY8IbCbbBrD3Q5vHvK05yivPpGkkmfGRB2z66jVfzyXVvw8O4w6xv
 ndH7TEgPyj3oK/ocvHuuyD47tAbpGWTxDo0X7fIr6wZTmM1r4xrKj9NIKrH6hh0KDr7N
 vzVi6wj9lb0Hl8Ttf4qYsE6CTY9cZacz9YB9JpYMb4tE8qMRIyJq2ARQZyafsLtIVVqe
 yvlvwwIlPpmRn9XktbU+fusXWWp4sdu0ckZ7/OvsBtJZGBwluBfLpllJnqjP0oMsMFx5
 sUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782728401; x=1783333201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UGKVqsdGzbosb+05ZlN0oEUxhwfuM2PCDbsn8tProM=;
 b=jQTnXC1o4KI1TnCTU9TCaN9CHD2hvEVw2y/zK84Bik5CnGEUSpQvBQfwcxmYCpFc2r
 HmLSfsO/qmJ/5dKp8wxUilet5P/tliay7R2/aMMlIpXduBlvjKaKhsSriRqhzsTwWEVQ
 Q2aJNmK+5srz9sI2oJMCgorqoanDzlxprVo2eZSgf+XPA577S4SAzQQAMosHaQFaRU8a
 83ZHBt0eF8hI5D0ZWs+g6V9f5np4erqUZ7zLRKVj+SOMdEV5BqvyKb6g2xD3KYmXuvGE
 ih9g7t+hb4qvUdJCRspfNP9fiBxR3UaLn/L+UaZKSNH1mX4PG/SSc7ZrUC7xPMoFxOeU
 kFQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ96rTnWphWc56wVMvsVs3x8AGGPx5kcYOdNHntA/kNdT2+jwQ4pkVNbSLkUjZb6+xinTkLQ+wc2jWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzn2P/aYC06CVeyLgtJzP5Mm9cgC0itEwK8tf51zGjpOj8yxes1
 P5mMT46c1Ki2U9dLgLmzC3KKb3misdVPmouYPPWgd0lPbgsSjX0LcCz5XuJzo2o7t5kc71cDwo+
 6NfHsFoUojLuxueol5isHRQrh2357/0Be354BbqqHeQq5oXuIyNbScYMP1wa6Yf413FkBP9k=
X-Gm-Gg: AfdE7cl663rqhUdGZtEQMbM+CUBkizp+WXM5fp5wB4LtBl9hnuPfbk4PXe8thrBxl8z
 UrGiZNNJv+VUhaVBeMuCEYwuBr9h7lQ+acWmwqe6wpLZZrBIZtjBMw4kc0d5a6rAICAAMG7cp1+
 Y2YhzBlwJL75zrPBkoBtdGZsX4getIR1TCSysB0FhRdTNjU/+SNGEDPlzcOh7QUN7woI3TEcw/H
 6FXiLEdyFZiSTKTWsgI4S/cftyOwNfazPIGCii4hL9RpQLBZPNcwsrluFDeJr31WpZ6qEaC+UDa
 jwgvlC9D3fmnSWtH2/cXLdWQYaBqeIi4D9frHL0HDVYRhfwBBX1Lfx5NJiCyc95C14ITuQnrVW9
 CNE0YTHM8HIbq9FG03sX7tjpxGiJgZiu2ctMvcQihFoqjfFlRyR2okzaMfPRa5g/FZRVElS6Zso
 oOHwyK/AFZs6CfCL1FNhymsEQB
X-Received: by 2002:a05:620a:2308:20b0:92b:6805:eae4 with SMTP id
 af79cd13be357-92b6805ee71mr984800985a.65.1782728401201; 
 Mon, 29 Jun 2026 03:20:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2308:20b0:92b:6805:eae4 with SMTP id
 af79cd13be357-92b6805ee71mr984796585a.65.1782728400683; 
 Mon, 29 Jun 2026 03:20:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b01631f82sm10787451fa.6.2026.06.29.03.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 03:19:58 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:19:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: me@samcday.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC] drm/msm/mdss: keep mdp1-mem interconnect alive
 during suspend on SDM845
Message-ID: <j76vpo5gxpwek7vpsjz2hydgcyibhvjueljftj24j2ritpb3mr@ej6bf335nxq4>
References: <20260627-rfc-sdm845-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627-rfc-sdm845-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MyBTYWx0ZWRfX/NW0GA+UBdUX
 vqtjsk6EkKCkLzRKoz2RvcbuosElfbZseA8qTZ5e7nqXPvYErk3HsqMaTITtoPgvhCg7WjWYDYK
 zjxC5w1GvtM75sWvBDsH+NK80UHlITrcpFK5y+kFqTDyq+IJblhL38R3KGJlWWx5b7iqaXE49jI
 yH9Tfq/6gBj97/JzHrlUlkD2gFa+86zXxNe7fe0KZrw/e9o++2dsEbllr0yEEBEL3EjtfD7FVHa
 YdPppaXZlP13qisiSc0XP92tJ1d+yJbLXRjnm92y6lXDdTEvz8JfFSP+oxg2MC4cYf2BZE7lF8w
 aWtam52Ut46/pu0OIEskbdZ5kgKriYa21OKDZhAfqwYsplwwYzYNB5lv7fgvAAW7Ud8wJ6keQUn
 raRKuWg8XXKJMNE2n9xmmMefGcTjKnl4LaA+ecOMCsgqLeuA1K8ayGWzoooLDqVnedSAxOYc/wP
 8p1rFKbn0PSV6lnNX1Q==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a4246d2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=lKQ-AihTAAAA:8 a=6hj42vQ7RftltVCiR-cA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=K6G5NyU7usMl-irPePdK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MyBTYWx0ZWRfXzMNpHRmsH64t
 QV/vC0nY2WqAeBLKfGHdrEIKy1DtKc4rr6jR1w3q2EnEHz96KAmOVXl9Oq0Ss2bmXXOzNCGpBoz
 rX5BEIROaY3Hzu2QRRSd7HKOXIPYKY8=
X-Proofpoint-ORIG-GUID: uMQxiul6P_0XfTy3dEqHIqtBLX6mtHo0
X-Proofpoint-GUID: uMQxiul6P_0XfTy3dEqHIqtBLX6mtHo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290083
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

On Sat, Jun 27, 2026 at 10:18:45PM +1000, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> If the peak vote for mdp1-mem is allowed to drop to zero, it seems to
> cause the fabric to collapse that path entirely, which causes the device
> to bus stall and fatally reset.
> 
> This issue was identified specifically on sdm845-oneplus-fajita, so this
> workaround is applied narrowly to SDM845's MDSS.
> 
> ---
> This RFC patch is a spiritual successor to the "Addressing stability
> issues on SDM845 with the -next tree" series sent by David and Petr 6
> months ago.
> 
> As Dmitry pointed out, the patch introduces leakages to the runtime PM
> refcounting. In practice, this means that MDSS never actually gets
> suspended, which is why the patch appeared to "fix" the issue.
> 
> The deeper root cause is that, when msm_mdss_disable() runs and unvotes
> the mdp1-mem interconnect bandwidth, that seems to collapse the fabric
> entirely and causes the bus stall -> hang -> reboot behaviour.
> 
> I've confirmed that a tiny non-zero peak bandwidth vote keeps the fabric
> alive and avoids the issue.
> 
> Of course, this is still a fairly egregious hack, but it *does* allow
> blanking to suspend and resume DSI + DPU + MDSS properly without the bus
> stall.

I'm a bit sceptical about this patch. The Lenovo Yoga C630 uses a
variant of SDM845. There I don't observe any issues with the MM itself.
But cluster suspend can cause issues there too. I suspect that there is
a missing vote (or undervote) on the CX or MX, which results in
suspend/resume crashes. And if that's true, then your patch does exactly
that - I think it will add an internal CX vote, which won't be dropped,
preventing CX collapse.

> 
> Here's what I've validated with instrumentation:
> 
>  * DSI host disable, IRQ disable, PLL state save, host power-off, link
>    clock disable, regulator disable, SFPB disable, and PHY disable all
>    complete successfully before the fatal reset occurrs.
>  * DPU runtime suspend also completes. The bandwidth accounting was
>    checked and confirmed to reach runtime suspend with 0 refs, with no
>    pending frame state.
>  * The device survives through MDSS clock disabling and mdp0-mem
>    zero voting, it's really just the mdp1-mem zero vote that is isolated
>    as the cause of the stall + reset.

Will it work if you suspend the MDSS (dropping all votes) and then
forcibly break the device suspend by returning an error from the later
stage?
> 
> So, I'm not really sure where to go from here. I'm sure that this
> workaround is not suitable for inclusion upstream as it still seems to
> be papering over an underlying issue... But it's unclear to me if this is
> some kind of hardware quirk on SDM845, a problem with the SDM845 DT
> wiring, a driver issue, or something else entirely.

I don't have a good advice here. Try disabling cluster idle node. If the
device still works, it's not a mdp1-mem.

> 
> I'd appreciate any advice on how to further diagnose this issue and what
> direction to take from here.
> 
> Kind regards,
> -Sam
> 
> Link: https://lore.kernel.org/phone-devel/20251213-stability-discussion-v1-0-b25df8453526@ixit.cz/
> Signed-off-by: Sam Day <me@samcday.com>

-- 
With best wishes
Dmitry
