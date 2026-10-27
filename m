Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE13606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vb57pl2t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZ+GwYC+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836E310E466;
	Tue, 27 Oct 2026 18:55:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A0C10E466
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:55:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHEbR2087944
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fqBmnY8T0CqGP0cX8wFwCoHF
 xWCAuxU3CcoqNGTy3Js=; b=Vb57pl2tMbv6ai+TSzye1rjbv9idcPtDHHdFNQpQ
 pZE/q4OMfAicpWV+ah2+wQabqYkuCVjJYeW+B/icdqgkBm/3zI7d5ozIXIde4oeD
 AcTbekr2Ky4CeOb6XU3tSKfVRyqYfU2Cm4pbsUa1pEE333URuBqxaJkLE1ZQYB+5
 gvcH3AAdrapWLPLFPBlj8iIFgFIxguwSeFN2knlUxfZ268DwZtclZ+db5Be4YS2h
 GxDHh5O+LruCzwzrb5KU3Mjty5BQOsxAWaJ85BABikYlzMI8dv521HCPfJ9xSWyL
 6RcC1sW5cVcbVhCUHr6mcu61e2Et4JCwS8+Davs7sVzySQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tb79a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:55:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34edae32c04so17237eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793127313; x=1793732113;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fqBmnY8T0CqGP0cX8wFwCoHFxWCAuxU3CcoqNGTy3Js=;
 b=CZ+GwYC+y2+5lJOJO/oPZt6yn4jxaCoPUzCQODPzvKEO5eCnW8FJf+CSMfaEq3HGx4
 7QLPk/ijwgP7HJLLXMVW9LqWJjKxqZiPA1v8CWNEw2PtL+V3a9qjv7LerX0hq5uaL9jd
 CX8ytnvJq7q/Lj1fNFtSJHmmUjdmcvCTrIE3x07/T7rY4PA7iI7W0mlRtbdx8ubKsrxD
 rP+byZcZSEmRj6bAuL/gLePIkmFqGp2yNBizr/0oNv12bBcth2y2vSfAQ9XETruB5qlJ
 fdrOmX8FqOiZlkJse1dZnxY+jrnesAa8xGqStQ1sMrOVxDd6l3Wkp87GLlvQN6gEmBLt
 1EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127313; x=1793732113;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fqBmnY8T0CqGP0cX8wFwCoHFxWCAuxU3CcoqNGTy3Js=;
 b=Ee92p5694iyohoCNt5OKbkeal1dFKb//3ZyvgskIZKHTZPM96XCDGiD84HpfVSutoF
 U4G+OiCParHW2onS10Qng8WHdGqzAKXjoPkEEpQk1AGTmSfWUZ4nGoQJiWvop+3K1fq9
 tuToxbXQTVymlfZv+16zZOYDmp+kteSmeayt/wDVQgwgFfynmGuu6vKcF2OIHmU4s2BQ
 8pipJeQpYVEienUh6lPpxzP2NawZDPh8dwe4gvhdox32tdCJS05c+57VgG47ZnXAqq1Q
 NRFm/pBhhH7nlkYXKEbUe87uQHqBF0aYuVm1enemBcigCoe9USU+/vu2KRctXScByOwJ
 IVUw==
X-Forwarded-Encrypted: i=1;
 AKwUvByCB7xwvRTz39YKejo086PFtIoHn0rCusqaDUUEhemTVdEPY54Fq9IH58OpeE4OMkMKXemxOO8Aij8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6+R6fd5YrMnSH9KbssVdwLA9LKysBbCuGttNrjafUOVR4agSR
 3+kZt6pqBZyXzUq6bgO3Jomv18HLd8OiffJmRoEJ2RhA4NTh9IdQYew0rXWkb0w/UPytzelrX01
 z/gNxIGUFdwvKjngA9Mz1uAeIgrcty8UDPjn9rjEkxepkDXXnMeZ9+Atu4Fa4VFPGl9d/bps=
X-Gm-Gg: AYBFou34KGydGDXEXJ/lVzrEgEOkx9mc79Ihr5jlgSQpKCbytywAVC076jbs4aIg9Nk
 vL1ImQ+entWR+cxSU/SPAd3okW6pVk5yrZO6Y5mxIuAmO9cLyySGT3zw+xouDyBvLKuEfoYeVwq
 UjtUwHa/EZ2JCNPxvDKSwA6DYG28nToDh+w7ZI9y6kzcscZV8lfMJYq94EwriNYcWTmsx4VBr5g
 bz158bjDB5EI0mnEwg2zwuAUyqo+HU7arK61mKxE+ANfMOw/tVol+Qfrzib94U4lYzwelP0alVL
 cy/Bm3lnAFQRxUOmqZPIAJNKD/NqMdO+lhh5vsJF+csntYH3aAc4JVyrkpZenUJLJvT4xSSwSpU
 Kv08PCZYoFRenBhpal6ofWjo2hFrBXWNG3BFJnZ1lgkNeTIlxdhrmLTxyQWzsWz/U1Lz4DbmtXd
 HGcQiYi6/fa9t7uBXQZ2vD7CnEYOTFNpIVryY9PnTocyeSkMpOBrYQNyDtpm0TQebqjwSUQL28H
 +L2Oi/qK1ELwAOfFhEdKGt2D22ppg==
X-Received: by 2002:a05:7300:148f:b0:368:5521:612f with SMTP id
 5a478bee46e88-36a1ffb195fmr1204190eec.0.1793127312902; 
 Tue, 27 Oct 2026 11:55:12 -0700 (PDT)
X-Received: by 2002:a05:7300:148f:b0:368:5521:612f with SMTP id
 5a478bee46e88-36a1ffb195fmr1204066eec.0.1793127312021; 
 Tue, 27 Oct 2026 11:55:12 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a005c0188sm23309209eec.9.2026.10.27.11.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:55:11 -0700 (PDT)
Date: Wed, 28 Oct 2026 00:25:04 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: display: panel: ilitek,ili7807s: Allow
 backlight property
Message-ID: <auDziHHv7Z7k4xyO@hu-vishsain-blr.qualcomm.com>
References: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
 <20261027-fantastic-benevolent-boobook-272a9a@quoll>
 <auCDgewe04WKbamD@hu-vishsain-blr.qualcomm.com>
 <c58c89cd-94a5-4776-b186-44c4b1b3c3ab@kernel.org>
 <auDrCTMk3oCLa91X@hu-vishsain-blr.qualcomm.com>
 <97ffe608-a69d-4f88-9e1c-fe991a36aa1d@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ffe608-a69d-4f88-9e1c-fe991a36aa1d@kernel.org>
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0f392 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=d80Fkh-WlB0DjQDMt3cA:9 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: FlB_EKhFt5MylOTqIZi4A_z5PPAvJ5mf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NSBTYWx0ZWRfXxCQrcmCP0iu1
 0xc+mPj0E8d5+JOwCd1W3cSuZH2fftkyjQXfqQOPOlOLvIAMXew/yBjU7EfpGda8MgGeTG9BOU+
 oyMiAvyn7ptFTntNHPhTHVgsUIY2b7Y=
X-Proofpoint-ORIG-GUID: FlB_EKhFt5MylOTqIZi4A_z5PPAvJ5mf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NSBTYWx0ZWRfXz0K5hZc4D2Ex
 txm0g6WKfn6l6utpgmq1tUGqBpC5SHTE61ltjmqIiGReBcSYc+8RgI4+maGFoZ+koupd7zu2ely
 dFskcSBfAhD3v+O69RzEitAMhwqL3I60T5Bqbze6336/Yie7PQyHgGCg8xuEESVsZz2kdZdc107
 n/tmmLNJyy4pg8WDY0/l6qChw9g70qUomHBknz3qriQQPuoAiSjOG4c9P/ZnfyFvyHU2qEsEM2S
 PoQmBnoV41RF2ExyEMIARdQHwTbLbMSouGL0hCyVJ3QoEK3KDE2ihMHKgdE8v5frS6R/w42dApp
 OqCwRVaQxOt+fB88ZDicZxMqEnfNxWWG2GGQwifb5bkkFf1aeBJnQeXcfG7sE420rAZhr3Ob6i/
 B5j5hGdpNfd0RX4Irz7ZYj78k0jFH4CivdTJguj9D9+GAk/PV1Cq89wpuiXqmCWKtQSFlf8QpRD
 zChr9xuLuoC3EyIL6VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270075
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 07:24:08PM +0100, Krzysztof Kozlowski wrote:
> On 27/10/2026 19:18, Vishnu Saini wrote:
> >>>>> Declare 'backlight: true' so the property is explicitly allowed by the
> >>>>> schema.
> >>>>
> >>>> Why do you need to explicitly allow it? Since when?
> >>>>
> >>>> I see no benefit of this patch and commit msg does not explain me what
> >>>> that benefit would be.
> >>> It is required for below DLC panel, when enabling backlight using gpio-backlight driver,
> >>
> >> How is it required? You did not really answer, so again:
> >>
> >> Why do you need to explicitly allow it?
> >>
> >> Answer starts "because ... " and you provide technical arguments, not
> >> wishes.
> > Because the DLC panel node references an external gpio-backlight device through the
> > backlight property, but the current DLC binding does not allow this property.
> > As a result, adding the backlight phandle to the panel node causes a dtbs_check validation error.
> 
> Thanks, but that's confusing or we looked at different source code,
> because to my eyes it clearly lists backlight already. Can you show me
> how can I reproduce the dtbs_check error?
You are right. I was looking at an older version of the binding which used additionalProperties: false.
The current binding uses unevaluatedProperties: false and references panel-common.yaml,
where the backlight property is already defined.
Therefore, I cannot reproduce the dtbs_check error with the current binding.
Thanks for pointing this out. This patch is redundent.
 
> 
> Best regards,
> Krzysztof
