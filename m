Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49745C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835BE10E3F9;
	Tue,  1 Sep 2026 14:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfREpZUE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fuFEw567";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAF510EA31
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 14:17:33 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681E8hRj3002674
 for <dri-devel@lists.freedesktop.org>; Tue, 1 Sep 2026 14:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L2p4PVMRQyap4QtREvmTG+zHDqqjqe019cA/N4E/d+w=; b=DfREpZUE17EnVXWt
 FsfvZnSl8y0oz3seSNn36W8vVQlcx9BmPZ1tbeB4g8+miJh8a5XEIDe8nAk/reWc
 eqPzvUE/CBhpFp1fBaeOR/mpbFjTDAVXfV3HTz2k5qUU6bhsG7dODoAkntR+7MuI
 myXv/LFolnqeGAWOUyidi7usccMXvaCVDj5laKJolcA4g9mK0dV1d/51akXLuPsS
 iM0GwsNfLfEG8TMMKnsAmvAime+DqCvyn3RMte8Q982wI3w7sssHbgwf0Fu/HZsg
 u15usGLKjh7u4OD7X/Zh+dPaPXaW9yyjU5e+I/H1WT4wO7PvFDdz9Sh04NrSqI2O
 gqW3pw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh2fam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 14:17:31 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73a1cf1638fso109682137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788272251; x=1788877051;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L2p4PVMRQyap4QtREvmTG+zHDqqjqe019cA/N4E/d+w=;
 b=fuFEw567T7t32VqZol7x+MLYAQjnCz0Uz34W5ZXG7COf5fkfk8owA5EJNfQAKuq834
 iXO9QIB9XKlQdztzfhhyGtgdbPFjgRJbc+poQITybirPNycQ+g2Ys2Oer2AdhfHSWllJ
 lLnWGQq3SQb3EGSnTHaTFPkIUHyNYrCZWFk5CRLOJDG/Ezg3HnK4nLk35imMphgahugj
 3IA2pD2iLem8gCs/9kkkBKKZb57jsK3uqm/w7vgCxHKm0URJzlORuOrnIgnmjTncpPV+
 uMeb8evBgEAzd/Pv/yfP5gLvulTs2owIYXCSZ1bQkITUxz1zyyTkZ8Lxrna/LHvycue0
 xMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272251; x=1788877051;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L2p4PVMRQyap4QtREvmTG+zHDqqjqe019cA/N4E/d+w=;
 b=XlBn95tsgAtT5FAnlcZQyM3RXLalbVMiNdmty09ypXb2RT3yb0AdpsUKRt/tJJ1rBs
 00/qVw4HDAcHajePc5V3e7xMXfHwcOJQ3C/7Rfsyms+3UE9t4famh/uuAyfo9wmQsG5u
 QgGMTx/bk6XwZ7Ang1CTyjP9KbH1H6PWOmHcQIUpLhupDHwECU/3g4Ce4EESbYmNOZzF
 3N//pMOkI6F7LK7arheCEY+A5klpzGwPMJDTle2YMwoDKp8wkcU75yuy7aYK3dvrxqp7
 /9OMyTTr5hcrzTFUai9/vVpzbvjT7xS6Qe1VvEEJPt/kFjlTYbknW61anIvp1ctJCsBG
 c1bA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHV4lQS91DBhNH39HBSM7XoDgo6uvoryipz33FI6PSrR/gcoSNxmOuAJuF5D7pTaa6YvzIVxotO6I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kkp7DVJZDyvj7X6849c8lMRWWU440WjFQqqTHJjso6U8dwqAup
 pcOcNGU0ctd5S4aliBHYvQiIntVe/4IG7dfteqBhBBCLH0twYyERMu3Tvj9vBWoCTnKdxnaJQTj
 9ajcFG9oIDVJ+YXUWPYBq0cresW01mrbSaeP8q+l/npkqMkWqurZbo/TZY5Ztwb+tgNzSfTU=
X-Gm-Gg: AR+sD11TSLgayCTmB+nkYgYxggu8o+ujwWThuOIp6MRIkbhMtkPVsPuRwOvTYh7RBhS
 hYL9+hVZ9tNjaJBjcxH4GZwrEGYILK2nwEY6mh84ZHvDHXhyHabrC+yOIAhODPRItJzf5XKIxKV
 IX9hl3rKYKAFnmpCITDHzpz4/0RDUW1EMGjtObFo53kcxKEI/8cvFMRycnQ2XwIlPhsNOCY0rSi
 f9BeX1/WfP2k08hbFNasCf6yrtY80V4yygXTViinTuA4d84CJOuJcVjd0CpvaR9fAShit/uloq5
 K2ZH4N/DXrGtTbmWVZeEF4IdfbSiAMoZAYi+HKsU3IlLkex+ML8O2BER0yLXM4pjgt3uVlrnKW0
 5ARdXXARbTeOsMm36PFrBPg==
X-Received: by 2002:a05:6122:c2d1:10b0:5bf:b91f:3bb5 with SMTP id
 71dfb90a1353d-5c6814304b4mr4067435e0c.2.1788272251230; 
 Tue, 01 Sep 2026 07:17:31 -0700 (PDT)
X-Received: by 2002:a05:6122:c2d1:10b0:5bf:b91f:3bb5 with SMTP id
 71dfb90a1353d-5c6814304b4mr4067408e0c.2.1788272250419; 
 Tue, 01 Sep 2026 07:17:30 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25618430fasm597611966b.22.2026.09.01.07.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 07:17:29 -0700 (PDT)
Message-ID: <a5702e89-d083-4dd6-859a-9a52faeebfd2@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNyBTYWx0ZWRfX+I3YATymvbEh
 p8zI/izIbDg1Q+mPBUHypJXU4XT61UKNfcYYtW22pI8ntF/VsZIj6C1CxwZJ0uBFKeknPkdTLst
 UEPGrcVJKLtimLurwxXxkBluOEB8cIQ=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96de7b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ksxQWNrZAAAA:8 a=EUspDBNiAAAA:8 a=hDogp9jCFjaJvwT77eQA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: JBWReU35kV2qSaBqNwGlFXjAg1oP17Rp
X-Proofpoint-ORIG-GUID: JBWReU35kV2qSaBqNwGlFXjAg1oP17Rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNyBTYWx0ZWRfX28fsvWqp9X+h
 shNaGeKdsJbdB6MCt/O33XKxd3E5uAiwid4fxLsaQO+IoafzuFXRaU+FGg7z0dTE5v2azAYNcZl
 i41hgzxp8FoFVYL4k3Ya9tgg9bRxJ1SIT3Tp6vEisokJbyYqa/9saycxOMaWX8/pCss3tvRoTCe
 ie6hE5r1XanM0//KT5wCcis2DGH/P/h3aU2oZUFVWfgWjQNhlOk1nzK1vjtCamJJFPbDaLEyxVG
 b/xTFpm3O95IuxQQtFMpxvWksdE2v9iBYDExRILnYGjyXNF5FjyCs6BVP+ztf0NXsSQVXseDne9
 lSZtcKCZtKRy+MNYcehtcVlThq1jJSTmUajZ/OcrsQYi+Tc/lKXm6XMH/ZqMSQ0IcPpPHVSLSbC
 yFCgkNdvAnI1lsx3DGAOZROpeBcb0m4k9F7R5lhWAcmzjlDcDKv4oQEZZ3hR8ezMh8e1Yynma53
 Y2gIPDc/zNnBB8d6s9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010127
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

On 9/1/26 10:47 AM, Xilin Wu wrote:
> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
