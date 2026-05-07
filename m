Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A34CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFB310E1EF;
	Thu,  7 May 2026 09:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mSy67VyC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TgFBcfFA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3807E10E1DD
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:09:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64792RHx258806
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MRlv/vWMWSGrGcfgYMRuEbAIZnTMixwhQUhla57tg80=; b=mSy67VyC6fv61xBc
 xL59k9x8r6RFhgDslfQzQhNkrQOL6TaqwDzdgZ2lbQtNhS9I8VXKySW0QSfq3G/B
 WH9jDkkaOBYwq5lRyRndPazgL4i+iJ4Wbj/WDaKr7Dq/DBX+R5iVrTs0yCx5/Bml
 GgeSZJz3zlr+dve2ckR+oAfHjQjKYBTMH6P5scEgcjhct612GWcjZeQ6qQKMfXDp
 2RA6rlHlidW8/lqELqxaSScIVTQFx6TkPHPUhKnB+riWPMWHwRiSIQUdF6y8fR1V
 vYkJUpHxhXGxnSR1E/DdA8DArLLAtITT8+H8RR24Hjneni3pxbrnWANeVeoalHDg
 lArFzQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8sd2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:09:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb3c7b989so9550141cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778144951; x=1778749751;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MRlv/vWMWSGrGcfgYMRuEbAIZnTMixwhQUhla57tg80=;
 b=TgFBcfFAkdPwoGK9GsgzvC1ft2nidoQ48RRbFyvIuW3YN/fJLAF+Jkr1cXArZCqETR
 +8/fA/OghYs0ZpfqKcf9F4iy0DK8M5AQ/QPudLN3KlxhCaqI6rb8XrHor35433jve2Fj
 WXK7eFOsrikcdCv8sWIxY0+pUDBaXVb2bBZjqPVMhmZpG2V/i7NK+uA+gI0pKp57yfwx
 lNfp5SnScb5nkpqMB0TqQEuuyDeRXuvC8RsUQNrp09nrAwB384iHhokQHrkLgk4p7z9g
 whgdq+W5nQyvCcjL5tfZcX0nv8epXiCsflEjREPtp7JtVzRS1djojQFWszxo3uSJDPQV
 mSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778144951; x=1778749751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRlv/vWMWSGrGcfgYMRuEbAIZnTMixwhQUhla57tg80=;
 b=WvTfDuTIfwK6JO2EkWQEC3Ghc8KNPGAzhgSQRjPlkVgIurh2gHEIlW5g025o4X6l5f
 VyHFYpjm/rg6SS7kIsvXK4EA97ny5miz9hl4CybwigtDux99C5oguqFPph1ye758Q+h/
 akXyjC2/M6FXjDwj+RxS17AN2N5he1NwWzU8pPTfEIBDfyW0vEjctcrxlWPbo3kvKorZ
 rX22Wk+KM2VA13Y3DE2YGM4Nd9lb1bmPMx3I7JZDqWu+AHx0sg1Y8mAfx6BCn98Tdy8h
 mTiCQohPvVjXadDuBZLfOQuBkH5LTi4jxATVsq4CE+9uFZ3NJJspYqJgVuUH6Xph2C+a
 2skg==
X-Forwarded-Encrypted: i=1;
 AFNElJ867f32ux+dXrx9RZrUgYKopemxW7He+El+wQnt2uda0CycfG26omhaVjLjsFaXnoVhIJxybp5TwEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzt45v2lfasa8ums2+TB9Os8YMuc9Ll2wevywki7LcGxGbPecox
 vJ6Szd1fOpAxw/Igow81cDY5cwD4UpacN7GPsYsGB9F5NZShCDOZ665xOqpoxIn0Ft7vINuwzaY
 Kz1mlKATywMQPL3NpyG8iiIfoXpz6aRk+kzBrkuTPI6LKrK6efUsARG1llhKlzsVu/CJ8XMc=
X-Gm-Gg: AeBDietKHI2OVePSpILtrOmqLNMT9M5HRKUxT3OUI284rIFlca4PvDAEfrMF/9+2E7w
 bVTWFqoRwEzWAXEBbHqHj2LcItY1mGVvgMyYSS1+rdkAAZXBWuQx6q2Om7wrH5oUo3AQB0O9w4P
 mxJj6uGuzzTOlCt0FuGL1GbH7oXyK9xYWIG5oW5HfnUcud7LQP5mVck/8WDDkdFhGc2ZJM6mHPD
 e05cRAA0zQUDH6+VP7sGda6UPMMgid+qV3rn3+4OosTkfGWFee5geetl4Ct32pszdCsOgP3Eq9I
 /7PKEQvQYp4gyKX3Iejl+dMSRMNhUP6H2PnWkdogsr5xnlwOIvclnWCHFCWoALiV8nxxLJxGD+/
 Y+qaIV6qUH8SEMlo59gnuF6NG/DJiS7pizBIVgQp8DLvIuJEYc4FO5HR+sFVAZ27ptkX0bhIHUv
 4a1NXRNxoaor+DHm5mZIzmv9rUCWA9qWpCo1+/WOwthzMm3w==
X-Received: by 2002:a05:622a:2486:b0:50f:bea3:9490 with SMTP id
 d75a77b69052e-514621f48damr91366761cf.60.1778144950614; 
 Thu, 07 May 2026 02:09:10 -0700 (PDT)
X-Received: by 2002:a05:622a:2486:b0:50f:bea3:9490 with SMTP id
 d75a77b69052e-514621f48damr91366531cf.60.1778144950157; 
 Thu, 07 May 2026 02:09:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a882e3589dsm2004459e87.30.2026.05.07.02.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:09:08 -0700 (PDT)
Date: Thu, 7 May 2026 12:09:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/2] drm/panel: visionox-rm69299: Split DSI commands out
 into enable/disable
Message-ID: <y36bb3gilquvtkgcwwo7kti7efxij3tnjn7lzuv36g25eymfr7@kuy3xas4lcrx>
References: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
 <20260427-visionox-rm69299-enable-v1-1-fa7d62d26d87@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-visionox-rm69299-enable-v1-1-fa7d62d26d87@sigxcpu.org>
X-Proofpoint-ORIG-GUID: qxeYjtRkaaUDh12H01pA-QgE-KAmcF-a
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fc56b7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=ze386MxoAAAA:8
 a=P5i0MRGMJQ-gJ7s2cWYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=iBZjaW-pnkserzjvUTHh:22
X-Proofpoint-GUID: qxeYjtRkaaUDh12H01pA-QgE-KAmcF-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5MCBTYWx0ZWRfX9Jsl+4RfFNif
 Edhk7xTnCL4a/8gKSelnmqbDAYp9zEUC+exojeBvfnYRShrzBADcwOk3ZhakAsTfle+gSXPvUrS
 s0ja4elZ/jIYvXs0zZ89KtiIofCM8QNPUOIFGPOdR+4n8trFUFpb8JB0mSIfxaxQ5cNLYwYsV56
 chiuv3QVHuZPHuf5rFQZN6/kQxPJhDzU4tZdqcqGHbmyFoNSW3mtLF3Xks7zPI2a6p3mwRzPFVf
 9p5bGjBoZPxV52iBwJCyannZCPGIB0A6spewWZXRwuRVw/YGb1aVyFPmBtBzSY3r72Fr3Vnmzoi
 P6u92JAVlK7Oc2TwLD43ZVPA9uMWLVA/4q+wE4LuOR1u8wRM4/mazGZ+n0QT7vLCiJJ0tYXo+0J
 0WFAZPd6Wjb7ga24iPckDgeKimVZXOV9+eztKQGxKpyWj4I1+b1SQUnX6s/bb5sXsliVP66VTvU
 wup45Itm0mFVGzNT+Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070090
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

On Mon, Apr 27, 2026 at 03:56:06PM +0200, Guido Günther wrote:
> It's when DSI commands should be sent and it also fixes these DSI errors
> on every screen blank/unblank on the SHIFT6mq:
> 
> dmesg:
>   msm_dsi ae94000.dsi: [drm:dsi_cmds2buf_tx] *ERROR* wait for video done timed out
>   dsi_cmds2buf_tx: cmd dma tx failed, type=0x5, data0=0x28, len=4, ret=-110
>   panel-visionox-rm69299 ae94000.dsi.0: sending DCS SET_DISPLAY_OFF failed: -110

Unfortunately, no. There are controllers which can't send DSI commands
after starting the stream, which means that all DSI config should be
done in prepare() / unprepare(). Granted that other panels work, I
suspect that the issue is somewhere else.

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 77 +++++++++++++++-----------
>  1 file changed, 44 insertions(+), 33 deletions(-)
> 
-- 
With best wishes
Dmitry
