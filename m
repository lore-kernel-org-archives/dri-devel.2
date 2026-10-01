Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC09CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1BF10E057;
	Thu,  1 Oct 2026 09:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNDOguyE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMwbbN4q";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46FA10E057
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:55:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xPmj2176837
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 09:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OmdWzDgQaJhw28/RsHEB8YAe
 ng3ivItati6H6co2/Pk=; b=RNDOguyEAiXYC0PxI/DoQfl0KQvRqFpSBIKN80Jd
 kwdlj6p3VhX1JHLBtw82NWqKvTzlVSk6EXtTAShw1Yy+CMB2Ufq1ccYLIJJyCGju
 ryonpVEPCeSKlKvrFEbcEJTf2/JrLSwfKNH43ZvyZIHjhhVuejMKtgJGi2FHnqU2
 DRQMBXVYVKt0pB6fR4BKpu/F7F77v/lyWK9zMRPw7598L/0KFKJI5gr+1t3ZdMBl
 1J5h+UKIQfRO36Whe1vx3imJmH7TgjAvEeiusx2+zf32xTrs4kFFI8bUtI9mO/T0
 8SuN2ishHHm82MrDgz/MAiVbtMgmT9hXDq2mfOCprWJjxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7ns494-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 09:55:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso281657885a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790848558; x=1791453358;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OmdWzDgQaJhw28/RsHEB8YAeng3ivItati6H6co2/Pk=;
 b=EMwbbN4qRiG1oCpVohCKufjPAwAjQmI7RRehHIqav+PoOnncyIWoP+JzZJYEyXQQbA
 MmErbeemKyE9IAtKNHo8aito4ENicePjP+ysmnu/ks/4oiNlfemq/VsJWo/GsRMVfXk4
 oJYCeWy0+WEBUKWg3dyfSIDwmlftG6qikPrAH8gjLP2XYYZ4WNgu5XEb16WsZqxl9F4q
 VUttTyVnJjAnGthyTN0YqOz5OPiicfdMME5I5THUkpVw4S7193UuBy/a6LbtLmfR1Zn+
 XanxVXtNt2II1QBOC3OjGyPS+oQgodOukNH+wdhMmu1DGWwrOKzMbFp5e3FqIlI34FCc
 nQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848558; x=1791453358;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OmdWzDgQaJhw28/RsHEB8YAeng3ivItati6H6co2/Pk=;
 b=KsJ8Kicd3Fo60rVJ00iGpYyG0o3oOkahfVN1YjoIK5heli7mtZ0X6y7z03ZR6A6yIM
 R8oKeHCHszuFPJ0vWgIpGEO+i2pKPlAajzUGg3ggZ4ZOgTSBhlZSJXSLhdTa8Mjuawor
 Gz1LO8OL8C5sN8UOJLAkAuUaKHjkuT6l0WYQGVkaRHlUS4R0Kd4wfmi5PAO7fOQz2yPs
 5ulzXr1yYuiUcfDpf9VKmLoAfQQtj6jrJ/iNPZenVJ1hpsfXgZQnWhIxmR9dNeqVFPas
 rAHih78EnNkkRXDNALFJkcTAIjHllkMH5mtfbqOIouX8sXMOHIkVmpJLOUhFAxxIOIgO
 E8DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoEXOb/hXclapHKXTVmd4EPiAaO2wf9wnMIAU0lKsZfRg2iPA0oYW5aykwsFnRObN6e2BnaDKTG3s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8jAbch7RkZ/oL5RCazYTqGJAqsDnh0odrES0Yee1j5s0ST7K+
 +Z4NaHChnvWDvNvspKPlr17VE2ljvcZjuvSi33jIVEj+/vSAfs6mi8xcBZR5Q/6vLRLFl0S5z2i
 7HqFxbMU9BR5ygLVAbhETsnqlq4/5RImXhvsNrUX5C7fiMaqgbT9dpZxQ6JGh7i/jG9aBxRQ=
X-Gm-Gg: AYBFou34EJ13MbZMqlvO/1j7b/QEPoe8fevrv7+kyl4KEFmTMKZLPogchHMoPMN50Ar
 SjdGDoexsTTp1wrQYJGxfMx4h0gzDBpwV9hHkUDRrFYJcubRSI6ZG4K/VsPmUq5tiDaSD3aYZZd
 imwDcOt3EbfhfiBsy935DGcFSfS51NIzrvvLdRfQdb9KjNDdhoMFBhkHEzU+N+I0anR3XAqyV64
 TenYfOwy79qfjVdVPBuvpHE/JOkJkY0XhIixyPZsoZlZs716Ycd+a5+xnL9BjSIUHOnlhts4GZ3
 dD4NG4EeOcjSMa0OSZsF63JPw5LUUIfpb1YOwz68h/vft4IvV3A9oHj5cvoGugVbUxu8lKdrZb9
 zKEhcux95bfefCWUMYS0fs94Xv3Jz1tN4PS4J71UxKHUzxy1P/4+RFbJGbi3AlW5nMpfB354tXa
 3HF7UYf7GBldSB
X-Received: by 2002:a05:620a:370a:b0:93c:b47b:26f with SMTP id
 af79cd13be357-93cb47b0cd1mr495779185a.49.1790848557920; 
 Thu, 01 Oct 2026 02:55:57 -0700 (PDT)
X-Received: by 2002:a05:620a:370a:b0:93c:b47b:26f with SMTP id
 af79cd13be357-93cb47b0cd1mr495776285a.49.1790848557435; 
 Thu, 01 Oct 2026 02:55:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbb999sm603556e87.62.2026.10.01.02.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:55:56 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:55:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arpit Saini <arpit.saini@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, rajeevny@qti.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add optional wled-supply
Message-ID: <cebrka4ya7u32ntiya42yx4txa3uryf5k2di234zm4enz3a6vy@xhily6qqmevo>
References: <20260929-wled-supply-series-v1-0-75d0a83b4b00@oss.qualcomm.com>
 <20260929-wled-supply-series-v1-1-75d0a83b4b00@oss.qualcomm.com>
 <20261001-private-wooden-chachalaca-51aa57@quoll>
 <997cefa0-384c-466f-b318-077939946768@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997cefa0-384c-466f-b318-077939946768@kernel.org>
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe2e2e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=rj3IgQrshAo4T4ftDsUA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOSBTYWx0ZWRfX3vIPymcfaRO3
 0BzEGA+KNHQfxJNF6O/4yl9vjaEWtHjrtsdsP6h55W4P4mEmXghcnzafyWbBG1THXZqKDTzHOfP
 PTgNFWaEVlToZJJBqeRASpS0c/TuGc8=
X-Proofpoint-ORIG-GUID: byNL_AMlnY7R7fmg8ynvV7viFnYY43gn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOSBTYWx0ZWRfX0yaKHNbkWDsc
 ajNPLDTtcJMsE6LntvxepomlNpdC89ySG7k5hX+95seMKTXAbZq4ndce+YleXc4Bg1mJpVIDolh
 FUeOnItnAi+7ZM64FgrwRvJS7UQ7RlcOAmvYGzravMdFRRRnFkZPFxItUAcfUEsuTpZdHHjb5MR
 1SHOVtGfSSOsl9BQwUwatBNRqKdDflEFnY5xWPfA+Ks4azo0NOrom3GLQoUvt7ZXSXQKakvS35a
 G7PMswh4dV6BK2oiZ7tShMzneY/1i8IqmVbpGW6sQj7q0foWn+lyZLMEHu8+VBQSqaM+KYNTI8J
 E3IQdBI0xqakLQV10D+6xPzZgjfMPuF+566MPOHTPpxA8g0VHU6m79gmwg86JeXpyToBPGfvgjc
 MH5u6KhUmYpkxvuVmfDBafz1NK7EtGHIqtdBCNP9qI6AnEgPrGyKiQkOH46uT2nmOHS0fVHwZfp
 FhK1Pc2rF670n3Qvz6g==
X-Proofpoint-GUID: byNL_AMlnY7R7fmg8ynvV7viFnYY43gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010039
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

On Thu, Oct 01, 2026 at 08:57:52AM +0200, Krzysztof Kozlowski wrote:
> On 01/10/2026 08:55, Krzysztof Kozlowski wrote:
> > On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
> >> Some boards drive the ILI7807S panel's backlight from an external
> >> WLED driver whose enable input is wired to a GPIO, typically modeled
> >> as a fixed regulator (e.g. vreg_wled).
> > 
> > You describe something else. What's fixed regulator should not matter
> > here. Which pin is it in ILI7807S?
> > 
> > It seems you just want to represent GPIO with a regulator. This is just
> > confusing and typical downstream workaround.
> 
> What's more, you basically REVERT the review YOU RECEIVED in v1. Really,
> just sneak the same stuff 3 months after like the review never happened.
> 
> NAK

After discussing this offline with Krzysztof. It's not a supply (my
fault), it's an LCD driver. So, the best way to handle your displaycard
seems to add a gpio-backlight, reference it from the panel and then in
the driver check for the backlight's max_brightness level. If it's 1,
then you have to send extra DCS commands to control PWM. If it's
higher, use normal backlight class controls.

-- 
With best wishes
Dmitry
