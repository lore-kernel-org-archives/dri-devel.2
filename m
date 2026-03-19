Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AA9108E1E2
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C8410E96B;
	Thu, 19 Mar 2026 10:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lI4y85Jy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LtaRrYHJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B819B10E96D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:43:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J73w2p1898624
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AEGfw0KJee8DCRKbyA9HzJFq4eyMz9hO7wvF5okQWSk=; b=lI4y85JyUyJcVU55
 4BJNPKQTCfuGgKxwImua1ksP0xkG0XenqVPSarFiARVnGFzEk5VJWQIgpK0TwRfP
 wPLdIDrB2KAFAoktmB0/cn2zd9NplCmgdq2fFjEXR+X4CRVdH3NeOPSMo3MNllpz
 oVH5KWxPILZ91dulm/0iEc65DwtnCOH/4D2uIdjBZpxjp1rQvTOvkUElK1yEzwOK
 M4T/YO2tvUNHHdiTxaxIFt3OAyxjK2S1LweIIzg7VsSCtRJ2CEgVv2ZZHM7sENnn
 kiXwZHi2L+/FmwIGYc6e5+fSHuf8bKL5YWEUyvSNSlCMwksJDOVmHkUlzDL86+8p
 0oltyA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyyhgb3tn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:43:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd93c91075so69715885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773917005; x=1774521805;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEGfw0KJee8DCRKbyA9HzJFq4eyMz9hO7wvF5okQWSk=;
 b=LtaRrYHJWN7uGGvSKNRxdK+TZAXIN/6V1X3aCXMWfoQNtVbGvLgNw7iBJBdAns+Ml6
 Loopv2uTX2KQZ9e/y28mBX6oS6YX8F13Rvs9tE6w4ODqpMGK9OJ+f6o7oGGGq28AKMTa
 DBfB/eMx7Io0v1UqcF5LDyD5KpLv33TQUr92+pwKTpmFaGF39CjnYLJx917wpEyaQ98q
 EOwKim47oHUZxJNNLg6MJeWOA7Lx+LMWGYWyroA0sbYSTui2MssxJjhHYFpHpDZMR6On
 JkaSmczCNUAaQKF+83cqbqHq7jECvjtnCMxn/YaReCmNvz+pkczgTSokmi0TcAIV6e93
 XRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773917005; x=1774521805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AEGfw0KJee8DCRKbyA9HzJFq4eyMz9hO7wvF5okQWSk=;
 b=krKtT7RCnkUybNkIo7eyiWKBse6Kurb/FxfR5Y0gIJ1CPMJyzE308KWdCCJ7Q0F8A2
 KojbHR6bJvm6x0bBJpKq7J8JGI9cEPlefFljrJTVh5pT+FPG1IWHdZAgj9so1fdBwIrR
 jLjGzsv6pXDlI1sGVbYVVyrqfpDH3EG+C6oQ3S6DVJlrHyjsMcWvN7rJsdzHYlGwa4rh
 n007AD3uA715jH6A+RrQg4N/TvnLzJSHK/o4eUOodtlss/argZiFm1pZVl67RxGjxHqa
 ymNCMMGTz3fPyQoIlZsTUMOOUOzBP1JfFPhZ9ktqroUSGjGjMhjqVnouWOjRqbQkiEBZ
 rgpQ==
X-Gm-Message-State: AOJu0Ywuzb3BBPul+g5WlDt9AievFSRxeZ1AzwPgHIfrSOLmKVpsMYDi
 gtChNfwpLRQaHM0rnFPOzB0lTw+4QJktl7thGEAMtg+RCe//EBdv09GxmN6HTzyc/sjGfki5Pfc
 tw74rFjEfHk27KhepozN1g5QdKvxVYHKsXgek9N6WVGe9tHBMRBd76nCLtLlVm5tjwtyQO3s=
X-Gm-Gg: ATEYQzzeOBjyMfZHH9ZL/F0Bf1flXpX3T6dvepkIu5tFRIoSoS8nV7vT8IUN++FX9Ip
 e6YXCutGgRk/Z01G6+Lx86SkHEavB1LARzILud9brY0TDus8F/UQIo870Jo22Ll3BH2YuxfUOoD
 I9ewf/5AxeuFPobu3aE2HAekTJpf9Jdf1ICfuPg8tD+VHaWwlWwFQ2Og1ply1jFPc40yhQg2Rcw
 HzQRfuF5y2q7rpbNlHd45urb55fiTf/kDg2Q5ehpDL2HaEjL5AmGtG/EAkXCQ+dexvhSmwS58t7
 qzrYSHh5HmOjTBxq9NpCzgIU3HTOCsGMtwiTyvCnxAlMtlUAICwQVuxTEKhyt95AItgMuNQrNAN
 caw5QAdKzj1+G7qTlKMrD3CPQzQ45gf7zH267gCEbbbNjQrMoHqnhbdSMwkINyrHROE5Hsb1qN+
 1PNII=
X-Received: by 2002:a05:620a:4155:b0:8b2:fe27:d2ff with SMTP id
 af79cd13be357-8cfad325084mr689431785a.8.1773917005056; 
 Thu, 19 Mar 2026 03:43:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4155:b0:8b2:fe27:d2ff with SMTP id
 af79cd13be357-8cfad325084mr689428385a.8.1773917004602; 
 Thu, 19 Mar 2026 03:43:24 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667aecbcae2sm4007186a12.1.2026.03.19.03.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:43:23 -0700 (PDT)
Message-ID: <36659080-1ddc-467d-9326-87c8d685b00e@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 Hall sensor
To: cristian_ci@protonmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-6-c1bf8917449e@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260318-rimob-new-features-v2-6-c1bf8917449e@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4NSBTYWx0ZWRfX2Dx0+0zeVqfc
 Ytk/DnFYUYJ+ZZ+wejwN6rGpJSgk3ZUXC6pIHjA/z1aOpbmnuYiGlTR8ezoYWpcD/SV9JnfJWJ/
 oxaGCghokyYi0dllW2G89NsVVhpbg8YXifLCIaX+mHaGBCiPf52R05NWYS4fA7SrhetiRIfJaR0
 ESyTQ6SDdebInnKRT52R3IR4P897fpOhpG7zqyXuS4PFmnuzy/6AfdMTUGdOa68VF6pxgUHnvvC
 Z7QDr93eKQjYrTzwv2qrlx5v25w19q23D8eVKbK2h9xdsPtb/Dx3ujXIPH13UaYBWCPCtMXAUqB
 D11wahsHFj3f4w7AwfNX0LAouzIdgRpYgl44jO+Ma3NsCtAB/IC1ONKbt+D2nzGMOeqX49stZkO
 cE+Wasnk6m2ZDCRdf/UMzG8FgOSCbF6zslFpfaX3d//sjez8RkX3ChZTLcyxcqGwtRIsQ8ZOTPp
 dKxmwuwglQguWu8AiZQ==
X-Proofpoint-ORIG-GUID: PlizgyDLlkIq6aGYevzIVXJPuGFxehzP
X-Authority-Analysis: v=2.4 cv=IbSKmGqa c=1 sm=1 tr=0 ts=69bbd34e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=1r6qRtClYgtMJJxfrUIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: PlizgyDLlkIq6aGYevzIVXJPuGFxehzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190085
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

On 3/18/26 11:28 PM, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Enable the Hall effect sensor (flip cover) for Billion Capture+.
> The GPIO is mapped to SW_LID events as in other qcom devices.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

