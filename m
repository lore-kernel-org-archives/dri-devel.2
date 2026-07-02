Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E43C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480FF10F36E;
	Thu,  2 Jul 2026 12:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8Wm4OvI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="US0hxV1I";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64C110F34B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:37:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6629nUXE4139572
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 12:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/gkd7p4t6B1GFo8GZ/Q/pEKv
 RUF8yp8H3VgwhQak3W0=; b=K8Wm4OvI1acux7DGfhKQkI2Zkz/YliMAnqjEAehl
 byXQ6YGe7fj1B1F/JA+PVUOI7AqL3qxRIIkUsPRFx5igfmSqC4K9krMF1NhewMg5
 VkJEkrRTQlwqcHn3LSKynk9WAX17ZjPgJMolbdJRNCrrkkSaOHrxdqFHfg4usg1h
 HhPgLUnnBRipp1mGS0RAe5GTRR6rUl93zeLqltNNAZ0uJtvQEE+EAzHempYFmex3
 Wsy36yGl7MkU6Pq1rkNc0vcmUrJtEjmol5EHJJeAYslMcvPymU6sHE6Q7BJ7Z7if
 I0Fr01qG0EmDnDDRrw7tXdWU/PHmNSc9UjLo8lX5YmLDfg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr8mh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:37:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55f0613cso175253285a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782995836; x=1783600636;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/gkd7p4t6B1GFo8GZ/Q/pEKvRUF8yp8H3VgwhQak3W0=;
 b=US0hxV1I6os497NLQeYHMCiw96jT8L0rm8K+VKCpmX8AHwoJYwHbTt12a3HwVkBCyn
 mxl318j4iiczvjHFSvVfzFHk59LoCciiRukRtcSmh+qvAOEKLFnh7EriXvl4kxA/nIGN
 dkf1PgTHChfnT68f+fQFlBNnXMyCcHjBOVtnZruKR3EgzB5/6A+rmtGGoCy1ddY3tlJS
 54vnetCB6rC74AHeAlyDsI6hIkOexdupKnDBlzF6ca9lqMGVQbt7h+Qqaj98QcE7JH4X
 88c4PKhwupZtL53c/gVs+Uo9L7YylSbkR4Kqh863f8KfvMC7dSDfoEVievc4MY8kTwZC
 d69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995836; x=1783600636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gkd7p4t6B1GFo8GZ/Q/pEKvRUF8yp8H3VgwhQak3W0=;
 b=rzcLskVpp+zMWx8JIf74TQrtUD/8tGeBiXHHnSORUBwaWyED38PXBXjmcGdCAYu90N
 7c70WhePrN3j/3ew8vova44vaABzsWjhcSb7Nm+luyjqoYLHjy7BHX4OisN16H00ujsj
 w7TgxgIQGXxgFu5rpJkvB9b9G2XxonqS/yVyllVEQSr5y4NS4FmPBI+k07dz1FesxJ3e
 L9FLk3MUxNnZbYOTjYmS0J/N1HpoNYP56ti/fb52VMcLDuNhU+j3o26F6itoPkLqkdny
 RZ8iESw1gyw0KoBd2P3FJ8ogA+c/ai6TbM3EikkaQCr4zsX4a4ED9FbGj84R/w3MWKy9
 bEAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xmGrafqKHLOsxG8i0SoXdRZhctJSYN06RaGtHR9tbawCWHSgFQ3gBPO63hfMhPnDnqs0gHO9fHww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7cxWCFa9njM9ZO4hk7NAr+PuZLt79Q/2VXIOzcGtiPI2QGFU+
 pSZsD4s8z702Yf6gbHp0LX3k9t0QnQZhdf3sFGOzzlTd3Dj2snosgkT/3OwsIDPU5JsnGry9hil
 tkZKH7dmz35qobu8QcH4R9fDALlqb/b4X4YkTnea2bt3cegisYFWXnMo3J5oiPPJ+RAglxRE=
X-Gm-Gg: AfdE7ckSrx3rHUuiYsMhW9mZPfr1Fht+XDmNES0ubGDweORLVEYa9mJOY6w5XBRPnIB
 KdX5TkrZNmqXLZgv2oVuYAEYhUVWkD3hhv64WmR1FOAtyMpcPfuvqocudczbaCJExkzY3npmbEW
 qZRRVvJCmPhrhEwBsZMS633R03F+TF9Gia9V1oyagzAsV7UEu1sIUlOw0aTPc9nA/V44Z4ISqRe
 IOI7Y6+/AoAzs50yvhwm9NXgLchEo3fl1FjPWFrq4kZIkVjPbgwriTU6RnVl44+hkbEDuc4Srka
 j/MZxgwuU/Qld6dhIKGIAcKoc3Rshv9qmDtQW0/IW7QSa+N6lGYwY6AxpMtQhNds5yd9wU+Olsn
 5XUqjDhaGQ4NTdB6TDnk+phS96cLwyvSvbOEltrcvka7nTyfiYs/GmZP4WIG2phHoOiie6ErtBN
 hr1Wwsdx9+C32SQH7jQR77cvsE
X-Received: by 2002:a05:620a:19a2:b0:92e:64af:3e59 with SMTP id
 af79cd13be357-92e78530f8amr830690185a.67.1782995836043; 
 Thu, 02 Jul 2026 05:37:16 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:92e:64af:3e59 with SMTP id
 af79cd13be357-92e78530f8amr830684685a.67.1782995835473; 
 Thu, 02 Jul 2026 05:37:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b37fc4952sm6393931fa.23.2026.07.02.05.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:37:14 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:37:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: visionox-vtdr6130: switch to devm
 panel calls and drop remove
Message-ID: <aw7zcgv27nl5yckge7jyh7kusz26d6p3ku4a2val3ugx52q3vv@pu4sykok6ycu>
References: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
 <20260702-topic-sm8x50-vtdr6130-dsc-v3-2-db881a3fc026@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-topic-sm8x50-vtdr6130-dsc-v3-2-db881a3fc026@linaro.org>
X-Proofpoint-ORIG-GUID: yEY6uiAolPHVBEs-87QuqpWaLmJB25NI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX5qE79p8Q6MPx
 6gHvEf3LIjZIEsZXdYDuvS2qWbDwXPFGTlL9SfhP3CgPksvD8VWAgaiwkXF49GD4T+6fygiM0fH
 lfic379SJDiW4ExKvvjq+aBplrW04JQ=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a465b7d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=gy4a2p5Hswq1fkLbpqgA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yEY6uiAolPHVBEs-87QuqpWaLmJB25NI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX6+g4YoeAoCkc
 /uktfnbWc1z9IM09pQ2g+FlFuTfZFH5kBhwQ0Yzt0sW11fhdDKQHGekFCheWOLVTiiDb5k5sT0S
 tQJ3IeFeKb2u2c/PDx50IhRxyJTKKPvpVSiJLrLp+/WWYi3zX9L55sgqPNySKxmlwlLKZzzs/SR
 x3PyUbIVPFgJX7o6xdiyOt78gsUHK337Dc1Z5CTXqi6VshwOi29QsFTQ7tIZqWU6+P7Af1DnFzg
 7g92dtql6/WRY8scxii7A0/o4tKggabA+gI5X37Y/PQdGAsY74Bf024o+oXHqSmirufC5agqZmd
 LfY4zlv2KSxrAI/hD/5J7ENiwcn7Du1gXzr0eHsPbV8/WhSnsK6zAlKcv/2agUEFPGVJgSiuPYz
 U7wVyCC9xTWLz6f7hXp7HrgGBwapZEgTzGydU3H8z0Z0XVd7NIP9FHmXmxM8guPNgarNHhTugEO
 J0UGEu5OvGiYCUIf5cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020132
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

On Thu, Jul 02, 2026 at 11:36:10AM +0200, Neil Armstrong wrote:
> Switch to devm_drm_panel_add() and devm_mipi_dsi_attach() and drop
> the remove() callback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
