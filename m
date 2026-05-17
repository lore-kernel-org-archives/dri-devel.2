Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8DBCD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 20:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC44610E2A0;
	Sun, 17 May 2026 20:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngnCTQnY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gQowaXaU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4B710E2A0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:59:24 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64H5tupT1683834
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8tSMXPekC/J4p5XtW96m54v5
 S0fpVbU6y8iqZunzDKw=; b=ngnCTQnYSRhzRh+hzQIqY6ZYMAYVA8JNP8KkoXsr
 vTNme8lBTyqYTxVYU4uGppw5h7f1km7E1KchK9QXhM80iUEow9olNWGdt/bKxEoN
 lDt2by7GkaygrZiOIiQWtwIgHkBdz4vdD+XYpgQed7WQThVUm42X4AjK4JqJU+wE
 jsL6rVJJfNdaNd28yqk6dJaU1Rxgz/MSEbYA5TOZgaH+mm2r/TcCkiVIu9YkqbJJ
 xDPx1l3VIMtp7Uuz4kYfLHRy9JK6CWRRVDr19GD/TpUF6QIedtIgW2yY3jih5dRB
 44i6+jIz5k0tXG/bNx7g+YLkOM38Z4G1ywAK1N2dPbZOLQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7ug17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:59:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fbc70cfbdso49997451cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779051563; x=1779656363;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8tSMXPekC/J4p5XtW96m54v5S0fpVbU6y8iqZunzDKw=;
 b=gQowaXaUgNgoX/PLdHUelys9j1s/KQCWStjr6cnK5o9qVhKlu5SwDZB0D5VDXyx2lS
 xqg0HPO/x5PZjRajTml5D4WJ39CUaNtExDb6uz5BZWHBW5mECdSWaGusJhJCz5HJYeeK
 adKJXC943Njr4eEb0ra1zupCcOVGfIwgnaWNz7/yZYKaUFCx+RVdfEvmEUZ3fjJn5S0U
 OB+EfPwcl34fZoQw47ho2HgmTcCHO4En8nWNizj6JcnsGHPI0Zj8GhKwUtMDVgLuovV8
 u34XHKIWu7RmVf9atgmnY4Ou1fEDRZkHhrni4GRdR0iAGdR8iAInP25mWbxSTvkaoxR+
 Sotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779051563; x=1779656363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tSMXPekC/J4p5XtW96m54v5S0fpVbU6y8iqZunzDKw=;
 b=qKteNiBhk7RI0gdwex2+vt7W4c1cWzSAHQ20u2KG1x+Qio1SiPcdY/TEVcjZedAXuF
 rQpzvVFHAgBN7Vvx8tUpSBHlmJf+dfr7pdcPsG9q32BJZtlPNO/0q+1j/OlpbodfUPIv
 CyPcMntEfHN0YDOJpsnqXp18wVktF8NUllc6Uzbxj/7IxXGoPozv7OpfoezgJIvFfkCN
 4TfPNaMn4AoSt0QgZiExoPnIeyLL1IUUgSAfv1aMnhU7sMVq3JfGCMs6TxHYMzAERwXD
 EeuGfH9Z5f08Pite7uAPsi1biEMmtvFy0uSR5Vg9rL90TCaMYDgjhleE90EYjwD8rmVZ
 YOIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2pwq4KlgWRHqGi6IbolWhjT2f+R7TwhXuQ4zF/SvDkYuyzcpEGjt0qQlJv/bUPNoouuOsCv9kqHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLyJ73pC19dPyahN7KeJ15vrmHJt6RlWqZSJbiFtt3rCXsfgbl
 50DoyhiY0DGtT+uM6NGzisRQaPSpgHP+81bgke1TQjNxgA+JFkvDzjxFhWGdP88RRE2idYVk3Rq
 Lezs//MThSMrdSVnBhzFnexnt8XGEtKIfP+wNIsd/cmVZzExzhA8FqUIWzlLTJ5Eazh5uoPw=
X-Gm-Gg: Acq92OFVSR0Rlx14ns8c7pMkMe9LzXfOYBPnOkuxekP92i8xtsr7Gp9cZyjBI+UtZlh
 7Qu3l2RrrYJGrrLEjrKm/UpiPQQYoclyZxasOvLQNL2FRCrzBIV6BSYQFW8TXSDhNFdlQPo3ZRo
 G6d1ZxvMFns7ECmrpK3pcXF1FTpWchwYkCviv975dbDuf8cHV8H4iwXbf3nwZCGbQ958gSJQzaI
 xfdf+YYrEusheib5aDszBvTkeSMjXPKqo/7BqvVyO2OHMzog78xBeXherJDFhZrgYhKzRC/zDEv
 ntacnPwq+a4m1Kf9JAi409vmetlsHUx0474rH6rdgAwi22rLUd1D1WdttWDXSAs58yaHuJcp2X+
 TBCq8pZW7SnZi+Xo0qnJ1U8g9nVnryd8AaF7SyTlc2enfoLbrFWeHFxozCapu7oxb5DOKKLo06q
 8nl8tFnugLRvn/gUlFxyuXLu460OKc/o5R3GU=
X-Received: by 2002:a05:622a:608e:b0:50f:bc35:aae with SMTP id
 d75a77b69052e-5165a25e9bdmr165770201cf.52.1779051563321; 
 Sun, 17 May 2026 13:59:23 -0700 (PDT)
X-Received: by 2002:a05:622a:608e:b0:50f:bc35:aae with SMTP id
 d75a77b69052e-5165a25e9bdmr165769991cf.52.1779051562898; 
 Sun, 17 May 2026 13:59:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39588791302sm7350111fa.32.2026.05.17.13.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 13:59:20 -0700 (PDT)
Date: Sun, 17 May 2026 23:59:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/bridge: sii902x: inline
 i2c_check_functionality check
Message-ID: <t5v6r4nl2o2kr3v5rkn7dmih74m4htc4cuyij32t2m6pxadc7m@vobfko5ywjsz>
References: <20260517172136.3321-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517172136.3321-2-thorsten.blum@linux.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIyNiBTYWx0ZWRfX3XnTasmEhR0A
 8xls91aeSHPpFN8/CsytNUiVsaYNUKD4gzTuSDL2k2Icx7sgtkBOOj9CcSTbivnc07Zowf8R7yQ
 d+9Xgfq6FWwDAMKztXeL9wS4YPbIuMhzZO0iWz6t5U+XwF8RqzicCu2aLAeyDp7mxNWr20xA0iD
 07CX7gBdtalruuKvdi1J0nHf+IMn9o87BePh/Ku/FKUHF4dmu/+Ww1AA3cUBRST9i6mkfkYiGWh
 6en+A8xuAvFmqqGF49dLzrkJZcygl+B7ja4RpFbZPPmdfIO5zu70myr1j7tCyLxXjVGLiTdulxC
 NWX2DmBS7YlWsd8isu8g/ld1N7vG/ss8yhmJtdWv2wDxVNjWIM9coUVXB9wi6E8pJ3I9xrNZQzn
 qmUirM9TOOCWcdJOckglZlUuwCNlYodvMJba4C69ZRRNEuzDRmquCEHCbRsZyzgesq89Y4L+BSM
 Jv6zYe5Y00XSuwocumQ==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a0a2c2c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=mfqEOVj5ZEcZdDVMyRkA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: hd5jCiBuOAJQycSArSCTNURfOvJOybT2
X-Proofpoint-GUID: hd5jCiBuOAJQycSArSCTNURfOvJOybT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170226
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

On Sun, May 17, 2026 at 07:21:37PM +0200, Thorsten Blum wrote:
> Inline the i2c_check_functionality() check, since the function returns a
> boolean status rather than an error code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
