Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A2606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jxe8ahch;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5lN59G5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05C110F2C8;
	Tue, 20 Oct 2026 07:34:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9111D10F2CD
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:34:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tBbv2877673
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LWzrZZFQhSyO/FR7rQo4rKuqvNnZWfQyCXRPSU+R25I=; b=Jxe8ahchk1wjRBJc
 s4o4UFhlDXJ0jw+NqXMrnEh1GWL0YaAMDQR4nmF8AFWbthX5JqJhb9RBoawKuzR7
 RA1hK3KqMQ0MySBNY9jS2cYOeLw383XT5U3HMmGmXTG5tmoOW8qURACbpH5MK+Be
 1DliUpgwv+GwIvPWHxNQ6gfRrpa2qml4v5U6TPSI5MaTcYfHtF/EWaLoV35PU18C
 zeJH5oWNEZ9f3RXXxRBQr7JwAKvbJ2yr+TNli3HzGMoQoM7xqZUf+rXQvK+lnb85
 0cWqYTSvEztmg1yA3ILUPgvO6Mr5r4O0fekBS3NQpMsPxtDXiFesRHaClSLhjm/f
 VqKgsg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5psd6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:33:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179ef12a03so13876526d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792481639; x=1793086439;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LWzrZZFQhSyO/FR7rQo4rKuqvNnZWfQyCXRPSU+R25I=;
 b=D5lN59G5hfHdaC31EBpl9KsC45E1oMssVNmAx+/eFZ32l92X9m9vMdSiCsmjLoMNp3
 e6rEeNYPzvVpke78MENeix/JwW+R8jwAHppyz3TCZlLA4FpBd+fx1KDUmgtRxq2tQY8N
 woZdieGRJVtcNDfHYycYi3IN/jsa0hDD/pVkhfr3OkQX8TS4NGaiyTIVW+9rbDKECJN3
 5tixp9NxbRvJdX0RNBhlrSlrsXodBDAVHnpDkB+jQXxXHa7SAbF33BH62/ebJjOQyt/k
 TM6TIhsquta561MQirCYiPWPHmQpgEuoC1F6CtJPdEuHIn8p3Z5y61TQ2MDrcGp3JVGY
 n6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792481639; x=1793086439;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LWzrZZFQhSyO/FR7rQo4rKuqvNnZWfQyCXRPSU+R25I=;
 b=tgpHE06t0h1Gty1RUSlUP6KYaQhpHQOSofo+s1jw2kMzUsgh8hbIJTiHQQ2kG3M81C
 l1xnxWphOlVQ0Xm00rwef9bhRua/3Vhl+mVk7pHmm1YURx2xhTeuOyI4U5hSN7scx1i0
 hqX7kjWQ4nJ+4QvuhinqbpwUvXXN8i8afG0Sj1EzjcjQJwPtQWE+5uz0d0F6fpw+K6Je
 /17daZeIc481J4fquXbAyvIgN0eZqOpbF3NrBwm2/Owu8pQ6YRBQxZyViXe1anOLjY/g
 YJWcCj232Ak5zrOqEQIz9g3/1YYO2GWTDKMHZo3OF590dv8IxDov3XZcLfvnvpqD2Z5S
 HW1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwscWtju86ILRmR4IeBIh+77p4nvxvVcNA7SsEq4gssWPiPmXOkiR8/u9Sxqa075COxY2NHKi9x0sU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKTKQyjsFvrrRpUQSyodGGwL6Dva6fpoI3faw0lXuxinYviOMoa
 O6ox2aanx4eNnInfPgGG7nrBVfB5yZJYZSYkZFzNZcgf/R5OGC1+BZg44K1dkHnb1IIMCVDQFeI
 Pd/9nx+FKPD3buhqksUdf2FFWNPig8Ed0Av49a3q3cwd2gy1Xg1VEP9ha8itZHJLUKGdIKDY=
X-Gm-Gg: AYBFou3QeaE2w/WzPPKcFxkBV/WEt4QDTdgnQmsa08AH8/3/At1MvyCDmTNwikppabe
 /NyPYcvxHgsDYTP4WKuDHF/Z9z44XprHwizdal+ZdboxDxsJc/U7kQphhRojPQZOeQH/8wE/y7J
 8hyIEr79rReWrcdI5i/QPhbP+brmUiNsMZWgnk3Q1FQjPo0JrLt/DzDzESb9YvaXE3De2Hd3cxr
 nNc8RdreeSqJ4SwM7R315YCr2lZj4/Apw0CTqV52pikhPeNg+8wsu4pfKxBfDUfAqw0w20WoEtd
 5g2vWdqlFujoNszBatZHGyYsCx2Hxy4ySHMedCPDGcYZe5GTQdLru/V1ljx5Q3XofJw4YiuRkHg
 H84Ykw5ANuYzPjyXiO5zSKA==
X-Received: by 2002:a05:622a:1304:b0:52e:3991:84c8 with SMTP id
 d75a77b69052e-53645d643e9mr179572571cf.2.1792481638749; 
 Tue, 20 Oct 2026 00:33:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1304:b0:52e:3991:84c8 with SMTP id
 d75a77b69052e-53645d643e9mr179572261cf.2.1792481638228; 
 Tue, 20 Oct 2026 00:33:58 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dceadesm461490166b.20.2026.10.20.00.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:33:57 -0700 (PDT)
Message-ID: <720ed230-4284-49c6-9332-e29f23765944@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:33:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
To: Luca Weiss <luca.weiss@fairphone.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Jasper Korten <jja2000@gmail.com>,
 Federico Amedeo Izzo <federico@izzo.pro>, Luca Weiss <luca@lucaweiss.eu>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
 <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad71967 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=nd-lUt6iTfUX6z0NebQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX+FU55EgYj86g
 kzFY6qchQl0s2wW59mMEZxxa2r8sWaKxDTVpPHbw0dV3Oo4pLYiTdNi3GDoNfOVnA4opo4uaHN5
 rVmbkPiwdHfCNgXPxjiTLmKKTqxnntZItyl7WklqoaL+VuuHP6a2lLnX8BAWrbkvHduY3vJ3UWV
 yfEMUlghDzzrP9YwiUSnP6jWMTi4Vc9CpiIvkn7i7zX6PTzQlndDvGyd4f+OxbOKJ6lao3ZSIN3
 3Fd54WAwmUgPW+QC/srh1ltQvgkAu5+BCfVliFUklzS5m2fYxcpOU0qwTBjzkDZC+Gp4X8fUKs2
 ZWpY1wCnixlmMG5lx7JeHkvcSKpGpGlr/MomOr+jMFX2A850Vx3fb/tfL4jT49z1Y9vSupB008l
 a7vUYjYgHI4CF+1vSBXsOSvHEpcLrX5IRHU6kPmf1vPX7KX/aom1+NzpIUHzJsaZEX6ed1iCvV2
 D7td9dmwUQaz67PsD0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX6A310SJUPLXf
 m2Ukpze1D5BHS4FuMx6YyOwdkR1JLEgPuvJ+SS1OC4lWyRznYtMC+sU1eMpXwmsleuVCm5nWWWD
 4s4/8V4H3i65gSaPEkUVRrkGLmGtL+k=
X-Proofpoint-GUID: p_fy290Y4c06M0GRLU199FC9gZ7xu_C3
X-Proofpoint-ORIG-GUID: p_fy290Y4c06M0GRLU199FC9gZ7xu_C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200029
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 12:17 PM, Luca Weiss wrote:
> On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
>> On 10/12/26 8:11 PM, Luca Weiss wrote:
>>> From: Jasper Korten <jja2000@gmail.com>

[...]

>> Drop the output-low, the consumers already take care of the state
> 
> For both enable and pwm?

Yeah

Konrad
