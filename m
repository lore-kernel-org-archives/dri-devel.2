Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF6EC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C7810E743;
	Mon,  7 Sep 2026 09:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPF8Rn3g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHI49vl4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1406810E746
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:47:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6879bsXv3618774
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 09:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E1hA4N0/5088URD+WHAfkNeTqW83E+jKM5n/INb5X6E=; b=BPF8Rn3g3KB5h89b
 g33DLCh/Q4y0z5beMVmxTIHjgxln48sF2e7OWck1NJat4gsnZnSQ7h2NX2dWGvAZ
 FdyVirAYpD6bmXrpf4ramF03O9HSdW1bGhCf2XuewY6OeHDs5SuerwQaqgPDmrwy
 QlSLXuIuWPua+ZH5Ov14bhWv0yr5mUNZQ966GJmxmyYWm1+cely1utSJkH109ggp
 ixwgzQDVxrJMyzu6gmJ4rIMFrkSPysJsw7kum+QqS2gaAS2PXp8pyapp+9kNlJ1B
 5HHt0SxLyOh3ysLhkdOL025TihOo3l1+BkD1LVtaE2OfEn0uTnu5t0DIv6sA5W9q
 HIBSdg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfygegd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 09:47:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso2477170a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788774445; x=1789379245;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E1hA4N0/5088URD+WHAfkNeTqW83E+jKM5n/INb5X6E=;
 b=DHI49vl4K/0i4YaSQUDdp0XwEzh4sYq7fecHwCO3mgJT+rjMmvyowfBK+ouRh/kAil
 6udTnfUD+v7Us+PGMxdhwR/WdxxxxkzngSkZyFdHItGnTgO1d2fEh3GDNY/ghbJzbR6t
 0RWZHlzja50N2FQHDgqww91zam42ez3xX0ZwzjBgw28RL05f01ChOt1mowqEc7w9xDrK
 koyuHQDoc2IcSuND0ZQRIM6g3VILzFjMt8kUa7G9Xf5eOh7uAjXtOtCIoMwmfT+EJtGO
 /cSC5sqkOEv+cpIUT0dIaooZycMbrOdo9cAOQlex7pCm8vfNWVFvTGs/uRy4xuguBRqk
 PJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774445; x=1789379245;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E1hA4N0/5088URD+WHAfkNeTqW83E+jKM5n/INb5X6E=;
 b=nu7MhH+Dp/7rKTKZXH/rGgMkPnyl8dnO/yp7JoFSLdvGC0k5teg8Y4qZewqgkt2sFo
 z8LV5kwRmb4Hk7kK6T502/Tb8CUcOfaPFznRQ/l+CwoKu/kroEyDQaILaJYdXwDab5pO
 LMWn551JSA7BMRbs4fkhPrbjynP7/1crBMY6uZAysrEKTta3UVRl88bC8F87UcLhmkth
 0eh96dE+mCHEp60sexazJkl3RjXK9CmToCS94IjXBMeW078LCC34BSduWLFv/pUv8KcL
 QSyVTLzNZuGC9bTti5xFFqhxtIf3K/vYHMqXcbI0d0Piroz24mvBlsuqDr4E1i4anTIy
 kI0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAz4NgVN3vRr+8K2w5x1Y7URp99hBg74pL5LxHSFwAalwbtQSYEfDUcPc2CzHe2HdQxpkAT7XFxqE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ki9vhHIloSsiD2ctvXsV8cfIuprNipjcvaetvujz8sRO/47vp2
 lc/q5XZxVjECYa5nws3UNdY5KE105pof2O+h1B9l3dZHymBwYScG4aKF1oiN3EQ6XAfcbffGOXv
 jDgy8buTG8xjLtBA72ETfXOQd/MpRkLCqnxFE34eglMzUkXREynF/Bbkl9WNrBUm7p3r0u6E=
X-Gm-Gg: AYBFou1MqCUFi5yfALsRBxuarSZV+dFVL+0WAh9ap43Bpdtv4J4576ocfobNXXEGjGu
 /X5WG9nBAuVkuYDYwEJZhk79oiiqXOSh9viijvr4OORzK1b6Q/oWSdKPNW/7/RGcWYfiXUfgnvx
 09VhDouelAbAyKSf5qf8Qkpa38/AtClaHNFMS2o/bikEHkoiAu1nLkw8E3Ko7Q7wj11lQ9soUg6
 XsGgrjDbv+TSn/uYBackWBgoUzHn3K23DdLt3/3yrKRiyZATrkSKd6d6seW0D5wTeTmtBoOhRe5
 QIk05OSp5+LzBMmp50WCIpR8D+vCnD5mAo9xdFDbMMWhzJ5aDNHirHUJ2obBPBMeXX9pCTER6SD
 ierTynJVthRioNiAKtsNMq+gfUYQ/364=
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id
 98e67ed59e1d1-39b262aaf32mr33970805a91.19.1788774444953; 
 Mon, 07 Sep 2026 02:47:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id
 98e67ed59e1d1-39b262aaf32mr33970740a91.19.1788774444513; 
 Mon, 07 Sep 2026 02:47:24 -0700 (PDT)
Received: from [10.206.103.40] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm34741879c88.2.2026.09.07.02.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 02:47:23 -0700 (PDT)
Message-ID: <902c7a41-363a-4ee7-b780-4d8cf2155d39@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:17:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] phy: qcom: qmp-combo: delay Type-C mux switch while
 DP PHY is initializing
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-1-2825e5bf8a96@oss.qualcomm.com>
 <37cs3ejjaldogjlh3oyhzxgedl2w2s6qk7sercwem5j23vdtb4@2dzhapohcgda>
Content-Language: en-US
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
In-Reply-To: <37cs3ejjaldogjlh3oyhzxgedl2w2s6qk7sercwem5j23vdtb4@2dzhapohcgda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GKAxAzscCn6gCL9W-5VCdFaZUWJV75y5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNyBTYWx0ZWRfX2rEzt9H8bFDw
 igsBENr/1AsX9smh45Sa9Vja0cLwN/1EIbqHtKOh7mw0AkOyXVY6NwjOVAxDe5mfrOQI7x9OFRA
 cObOp+PyEgRFQp4JO/Ksa4kV1fRscVPMUVyth3pM/KjKfmqpur7GgEklV8qsdpEOubm2ljxUhu/
 sB6EGKtp3ShpyLTB2Eq8MB4kyH1dVoIE/xPIUlgn8kF2MNnXlkhgRjA2cSjr2HM07pbpHhl1EUu
 jSwCszFuoTjxkrOQ4gGO1zT0HUnAGvw0Khnd8JlaK9vLISY/nCEaOLn3m5JCNvzRWmQAhwtIwWY
 JIuqRW8qQON7ZwnLkEDID+dk35UkRpGsz7RfCzj4JBTTlK/rvpRnVLdszBsHwfGlrJM4x/ohVU9
 M3d9fb1IiiuDmee7JahbznIg8aSd08g7nzl8h3tETU/F/ajUT1didO38BvEXUniZ1H8P8mqi0C8
 rpV0Y1UHmgbSZ0INq6g==
X-Proofpoint-GUID: GKAxAzscCn6gCL9W-5VCdFaZUWJV75y5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNyBTYWx0ZWRfX7BhMr1/npd6X
 cmYUoH3oZaS86Y34+aKiQJezeCo7R3XKogRK1WAhtsppriSW05aDjuZn/WLFmcHsGJW9G14wNXX
 jXqOMbaaEZd7Qoq9EFK8OifFEGa5bzk=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9e882d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5J6vajjZXZgrfOcXjUsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070107
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


On 02-09-2026 13:18, Manivannan Sadhasivam wrote:
> On Mon, Aug 24, 2026 at 04:58:04PM +0530, Saurabh Anand wrote:
>> The Type-C mux switch guard only checked dp_powered_on, which is set in
>> qmp_combo_dp_power_on(). However there is a race window between
>> qmp_combo_dp_init() and qmp_combo_dp_power_on() during which dp_init_count
>> is non-zero but dp_powered_on is still false. A Type-C orientation change
>> arriving in this window would proceed with the mux switch while the DP PHY
>> is mid-initialization, corrupting the PHY state.
>>
>> Extend the guard to also block the mux switch when dp_init_count is
>> non-zero, covering the full period from dp_init through dp_power_on.
>>
>> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> If this patch fixes a race condition, it should have a Fixes tag.

Sure, will add in next version.

Fixes: 896277138c13 ("phy: qcom: qmp-combo: register a typec mux to 
change the QMPPHY_MODE")

>
> - Mani
