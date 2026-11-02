Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B6606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f/7QXLQZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g/9JFEEa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FEE89C28;
	Mon,  2 Nov 2026 12:06:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FC510ED71
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 12:06:28 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29ALTd4039632
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 12:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6MljPg5apEnzZuIOweleKga/OQMxPXsuquwAJikFRpI=; b=f/7QXLQZPnwmp4m1
 ZUVYDFMF/eoPWW7FrjclGu6np/3fhIlm418hZsTYVl0UPZjXN2sLW+5BPJx0S8r0
 zs/97Vbad7g3Qr2Knm/qCTgB5ehvfrRoMbd1IH4NO9RYjicr2yl0YWP434iNQ0El
 OjmxptxCL8K0Q1vJeNYjfYeNTYFVIhFzMfzyeDxCrsf/+24iMNn/dTkrqgA5TkcQ
 nrnApZbUEAh+sB13cyupW/r9CUBNaDr5C59Rp+rR36+9avYbgPtNtCHyzoyw80J/
 Y2IN6ryDe5jdYhM/3AfiTRj+aPsCnM+etYp+M20nMw3N7gnPFihH8WXDiMG0CbTp
 UdgDkw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph191gj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 12:06:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd750de6e8eso263705a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 04:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793621187; x=1794225987;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6MljPg5apEnzZuIOweleKga/OQMxPXsuquwAJikFRpI=;
 b=g/9JFEEaxt6JYGwndFpf25u+TyG8BrO0iat5s5uwDh/A/CSufHiJvkWQqLFu1nxjfu
 Jt01v2rXNDUR4Qq0BG24teXxBhgO7UIiD99N89QWoxisCk30Wv7dPrj97CSnU0BEV0lY
 UOYUtH+91pCCa9qvf82P7+M2E1rkBvgJusSQwDRsZcmoEqebBcRLU4EEHOY4hLYNlYhk
 zugRUEDX8SQLsPg0sWQJeUa1e6FxIpOVXgosJ1xFnk+w21PQPrIPkAQen8Y54jak9HVR
 nnRFnMToX2bX8mDzi7R0xmk/7UGWbn15w59lAPwyn0hf7qobkKppEcnS9SHMferFQDSX
 Bh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793621187; x=1794225987;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6MljPg5apEnzZuIOweleKga/OQMxPXsuquwAJikFRpI=;
 b=Off10IbTVuXxkDNW+J2Gj+hDQxMEF5Py4L8jE1F/PMxCLEIlkPPirdhV7IEO2+ZH/u
 56Z0TO/i1Ykp2gcMoDPMhKYenCHlbKwwEs2ZXN1Z1XB4BUvWvlaYkylatR5ecFcmtzSf
 Zm9AHyQVZrw6hNSgFNrfE3AvZ1lvIPbAOzAsajQZrIdLRfKFgNZbSQ5SqbkMwAv3WyIc
 vWzB0i8iFwPUtivkE8KPUgUcsQZJZYVQh2jBS4fdoC8QAFDl/P0xqDzaxQIhsDUqRoeA
 4es9HmHulick4bkow3ffVIOYV1hZu0nFFkEP6gLw/F93m5LfaselUQOK5GHonYg6Gyvb
 NiCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6xg8AaLiGIul59u66/vGkSZ6T1e3FODR+U30UsXwxrru2o2zduJ2rHzdUp3vquBn3nZ/jHUr59CA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMk4wvS7N8HU7qtMINsvosbGU9Zn20KxAO60BcVC2+JBWnaIR5
 n4WixMYZh5zbcbunl73t47/oSHxvDrYEXXAYWJNt7Hvf6B/nuCPgwNfzrzlZdPOACu1HX7+RDg8
 IMzGHHBfr/vsa2/W28i54FSsRmbDr1D83kllIFON0xO+39kqoNTQCLVKlywonLVmZY+vdimH4MW
 847jA=
X-Gm-Gg: AYBFou0SDyeJUxQAB4oOlj8OUX3dGzMJCuRPTM4uQxojGCJSFXG3dKifAGGvisggZUQ
 KWY0IPHBCLkFAxKdDr0Y53FNjc8yeuQ4R3eGkqXcTh9RQa2cPMU0VhftX44/YkK8E+fKt74/EL6
 kOvWKrxFZnahepteRiOqX28c9ahvRn1dUqqPihO3224sHatVl5I7d4TXmphTy+USYa/pQzVkabw
 94wpkbYbwO+Crno2CBk1FhbE8HniWqyeFQTwVSxnP40KT9FaQsUMWwLfXSiHFj6JY8qM/0ASlcw
 wS0+fsHvwdfxiPZ4XyaHJNaF1pQb4HroKyS/CP/VJ5Y6NaFZp0AEfGxHt9QBh4zGpSCiJkx5fmC
 3UzH8HRgErb0Y7XN2wZLiNGWEfG3XaAFiW7yoxmuPPwKrYVR6fTnD7Jd8vDd0mL4qEzG3eMw=
X-Received: by 2002:a05:620a:a40e:10b0:92e:6485:f640 with SMTP id
 af79cd13be357-94421762860mr1606916285a.4.1793620826282; 
 Mon, 02 Nov 2026 04:00:26 -0800 (PST)
X-Received: by 2002:a05:620a:a40e:10b0:92e:6485:f640 with SMTP id
 af79cd13be357-94421762860mr1606909685a.4.1793620825694; 
 Mon, 02 Nov 2026 04:00:25 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4cf60sm377507566b.53.2026.11.02.04.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 04:00:24 -0800 (PST)
Message-ID: <7264dc6f-ff30-46d7-865e-32d050c8c4a2@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:00:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: sm6350-lena: enable remaining
 i2c busses
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-12-cdc3be96d257@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-pdx213-upstream-3-v3-12-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZKUCzy9JWVcAA8W6OY1-7UBk9yxKGOf-
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae87cc3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=XQlgmqBj-IynFr2M_OMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-ORIG-GUID: ZKUCzy9JWVcAA8W6OY1-7UBk9yxKGOf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX7mqDyvkrCllq
 i4KzaW1Gq9+WBTB6vI/EHXU83vMI8c3tk6a33A00j64SIeDH3cN8FqclLFSZTFOqqaZMM1du2ja
 IRY3BjStgA6Tot7mdjWofSk4hqJ8oiliIyhN9h+kdXJFuu4o9wpKXAa0xnieab4ciMOoo1wCkHJ
 eDMzSGXSnaeGAQtUvDo+cjb5jKxu8xYOBYaeG+PVqGrtCKT0vurSxKIpiDFv1l5sRpAwItL7wz8
 MLwrS6OO8CCIDhoTWPKeWP7o0Py5jJxw77+3S4iZJeYB/gZLSmf+5wRFONOdAbfPrzrqgeoSaf6
 RMPWetM2JXqkqw9+jky+8pvubzKKXNMWFAPQlSdaYred40kQJZIkElii0pvc4wfx9+v8iWuYzkd
 TxQkovV3WXd7LgNrfwND+fW28xGHuokwt1dFBys1MxTCyGDlAJu5nv2At5vVj6JCT+OIVvaAnGE
 6tgw8D36HjDE9wVhusA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXzTxfq3GRMIeV
 DdZ98GOZc7xUIBlkf/rF80XNQo6e4SWfpLLcvGBevQpD9Mqr3L5apXj+cssQDn6LqFUum+yFd8P
 1JLza3RfUr4wM/JLtSP4r8RQ1MfRUMI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020048
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 12:32 AM, erebion wrote:
> Enable all i2c busses where something is connected on this phone. Add
> comments as placeholders for which components are still missing.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Many of these are fairly low-hanging fruits

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
