Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74A6F327D0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061A810E85C;
	Tue, 21 Apr 2026 09:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="df7tAtBN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G9Pi5IR9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548D310E864
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:51:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L74FeF1538490
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tNz2hyaIKunso93P6B5FzOeK7zMcpTMCwZPp1Ux4pv8=; b=df7tAtBNSOEWW4QV
 PYh+L9tHKd2hG80sD0WCzKbTf+PwkzNyMtQM+WUZnIb0bFLacmUhKm6B2Feg/owB
 zYAsr9IYG/aIzInS5zplrETdOCy4LmVtvnF8d9eho42WfPY0yoWjdY/S5eT9FZ9d
 PgwH4os3tew/ZaDiDZPe0hnMPXAXfKpNrG21DbT/lqS49asRON35kJKr1yLcVKqt
 BUcdXmgVeqNsc3g6lQn0vzl1boWOn3kG1CawRExKwexBL3XO8DniH0pMLIbYJNk4
 NQlY1Kg4KGs6NlJmdrH1KE28Tom4U/l3EZWmME3jkIkiaYw9kDeELJMnwiFpwRSA
 aBWquQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp4hagmvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:51:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eab57f0e8bso33517785a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776765073; x=1777369873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNz2hyaIKunso93P6B5FzOeK7zMcpTMCwZPp1Ux4pv8=;
 b=G9Pi5IR9h49/9cYJGcWFykXGGg4fdAElWfS+8M97RMZU51GQZ7VIR+M4r7SW5Ay+hh
 AnjzRscsXUR3W3wknm/cjmhE5LmBn0+QOVjaSI79lrtWe7QemgAdj0Xuj3pMJ6XAizPv
 kbT0QyE/SG3CqjGfr/6TudcfCxOkBlRvKN8A2xWQNGviSJQj7DFuEDlg3iGC+vvZjAI9
 bXojLB6Tf6cvbXhPEt1dkMGGdSB/VGphl4Dy1nrOvVZ1O6SeH9G9YAJId8Lr2wYMV3Fh
 a7dEoEE4fQiRBAEfS9A8IekcMIidMen7H54bcxZfo1pu96zDs8u9BTXUri8s6CaZM23l
 j5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776765073; x=1777369873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNz2hyaIKunso93P6B5FzOeK7zMcpTMCwZPp1Ux4pv8=;
 b=DdgBFZ3C7UlwqCaBNgJDufNPBA3D7ov4mss8EFK3iTLw7FglSecJKpvu1xX4oLS+Cy
 XhUJmXu6nCmn+21L6T2qha/pM8aez8Gw8CVu7IU6VuJe0MbCafwOTfRh1KXooiCQLKYK
 9tfMboeklSzX0BDgGMT7Ij31rC/TPsbp0a5bLFWuetReJP8p5/qtXu04aHnTZNdPRUxX
 wTFosYfiu3EZhy9Ee3s4aJNJ/YO0czut5apszZd6yUeF/AYRigsTp41f7R+6UmXrHDmP
 sqyjgO0a30fB2NE6+FWQNIsd4i0yGncECgtDRvZ+7TQ9B3vjYkE1v8+SevpyCiNKd3ux
 yiIg==
X-Gm-Message-State: AOJu0YzUOq9Psu3Kjp8BsJ+uLVKH5I0gyYEDZSQRAsNcwVnu4hewKuzp
 b0pxHLRGb+XZQmOP10YtNZQV5Yo2aHDkXzy/bzhQ9wi8CvC1ORYKB/luwmOfg75WwplI/4rw47u
 nBNbjoecKDyKlAUtK0ne/g1vkeGnQV2QfHWev83vAxwjVhA64H3A10kQzRpZMMzrPZUdNmZU=
X-Gm-Gg: AeBDietWbfgU56gfEobi4XoDTrwfQ+D5uB00CAa3dgpZ8PAMJ8dNaUPWPrgEoHP8fPb
 4+mJzESZxrFLDocPLcuk95G2/vn0QiaQc6eCA231qkFMvAcLdVkt8v906Mqqnf37r3avrh70DJj
 6sQNFmxx1U/QGCTk070Uk+JEehlJ4IdJHKx51eTrM1rK1leAm4pJVAqdWOwBErYgEWTYlwJW9hJ
 YbL5WK+hv5w1zfDicN1e9dhDJQ1P68kGsyF4Tyn4fpbbjxLGWPkHSnt5RD5QuF8Z/4t2RFQ64h+
 juqGls6mkfFXlOI6q04vcH2P/+B6+1caaVZ6Uka3RHwjTMIbDq3A4x3J47oefXdRw1kNSvCtO40
 F6YK2qJy3cSH5wzgK7nfo+Q7CHsSqp+5pGFqG+vw03jtNGbEHndDkm0ySdohBMyb4Qees+Gc+ZB
 aGWKwG1hmbNzgIaQ==
X-Received: by 2002:a05:620a:2ae8:b0:8ea:c7a8:5065 with SMTP id
 af79cd13be357-8eac7a856ecmr572411185a.2.1776765072676; 
 Tue, 21 Apr 2026 02:51:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2ae8:b0:8ea:c7a8:5065 with SMTP id
 af79cd13be357-8eac7a856ecmr572407185a.2.1776765072156; 
 Tue, 21 Apr 2026 02:51:12 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c480e22asm2692461a12.9.2026.04.21.02.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 02:51:10 -0700 (PDT)
Message-ID: <b340dec3-8c4b-49f6-89bd-61a8233bda2c@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 11:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] soc: qcom: pmic-glink-altmode: pass down HPD_IRQ
 events
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
 <20260421-hpd-irq-events-v3-5-44d2bf40dfc2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260421-hpd-irq-events-v3-5-44d2bf40dfc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bOQm5v+Z c=1 sm=1 tr=0 ts=69e74891 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KAErmEmBofBSjU3YeWYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: -ntuk6rpyR4XkQLp2m_L92v2LxHy4gpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA5NSBTYWx0ZWRfXzHoVfAanNe8k
 ugN9CFgYYFgKOP4CBEOPzR/omy2NZePBposP/GNV5MA4gEp3n77dUb7JRtURh6XPlJn2mz3G/MC
 vU1OajeUmF4QlXFnuiv4hSdZRSGE+K8r7E6lT0O0SPJMIYiuAXYEQcd9X8RC8LEUm/hlXHBPhzp
 LyMJut/jXbvo+bX1ITdtzdHrHjdJQOovTD8JViXk36x6v65UslG427O3nvnXDzo+RN4yuIKYbY+
 I8YN28q4C4zk9fypRCM2hxLR1gLs/vjfW7+g/ZWz/MrkpDffTZwagHdH+T5U6rl5UTmZfZpUOsT
 4VTAiYxAjn4hJVZl3L81aRPVk+J+IodZWwAx5TBas+wkakUh03uBcbMKAh67Tpy4Nx/I/oVuHGY
 WPx66Yjs+d9ewjp3sseE1zd1D+amG+r6NAhCj892Nxc5oeoZUB8Zmzd+/Q4PTHOcNZlPahpWaG3
 ko8PI5lHco+blcSkQgg==
X-Proofpoint-ORIG-GUID: -ntuk6rpyR4XkQLp2m_L92v2LxHy4gpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210095
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

On 4/21/26 1:33 AM, Dmitry Baryshkov wrote:
> Pass IRQ_HPD events to the HPD bridge, letting those to be delivered to
> the DisplayPort driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
