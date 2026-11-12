Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA74606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H3apqZVV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hkawu31V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884D310FF56;
	Thu, 12 Nov 2026 09:37:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500A310FF4D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:37:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9CXUj4092381
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0C4VCPOf2XQTwUREky8icGWL7YCz198hjE5AQAs6rkQ=; b=H3apqZVVjjVPAEjl
 cN2Cq6WnQgu82yoBdhcSfDWr/trszx65NmUBb1sj36/gsMjViqa1kMPyawRmJTPh
 J5kJz3KHXLt31PdG+BUb2dXRCFQphRDLPTY8aHR47Pb0BT7m6E/ouT3WBpWr3/9M
 EucYbXufySicB3u1Y1WSCK3vL4ubXLyamSK9yPmVL8g2LtZNhwkgndRBFPe5Xj88
 7spNDVV2ZTlc93g+rdkSRxZI7ou6EmwZCty/Hu+CaCdtJJCND2cms/MROOp7ylA5
 oYMz+C0bW1i9HpZNbD4/B75A6YO03cD3+SeHt+jPugAXuX02VOiOn3/2XlTmHu9S
 C7L/wg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8j77a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:37:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-89e96c03cd0so3726053b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794476254; x=1795081054;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0C4VCPOf2XQTwUREky8icGWL7YCz198hjE5AQAs6rkQ=;
 b=Hkawu31VdcjWcIYv1KlRkO0M5F3QmFPT/HEuqOd+XhaCQc/r1FHDGHnbqTERqgYY+b
 eVhojNfRlj1k4z96ZJa7HE3seOueJzAIDmpWN4kXgXuRgn9lsqOAm2ArHbZ7hWLQbDv2
 WMbIe9YfOVZTdCSabQhiZH1j+FvawjKwozRoJV/bpc/hO/4IzcKJI40faEzsZ64e1C+k
 k7sZOz6O04TqnNTn5L0Vsyj6aOM9HkJ9Gj+F3WtPxiQoxbDCFZ9YMgD+/VcVrEERVfal
 rVFKNAfJtqOZFcMxwOrTSYv+mRUAxjD+95wXrbh3mUZ6K4dICezEzLjWLlTVqMko8W9/
 00xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794476254; x=1795081054;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0C4VCPOf2XQTwUREky8icGWL7YCz198hjE5AQAs6rkQ=;
 b=n5oJ4SPyznA+fCfs+jewpZJoysJ2p9fEyCvPZi30zYUrO0ggDxUxKj8A9O5qlTGxRc
 6i+UI0iGzbF8i9hl9SuEotcyaPCOb7dxuuIYqW9RRCA+HqfagqPRo5JE3pquh4xAJ7bW
 n1ox/GDj4AaB0xn5FvNjmcr106n15zwelGXaOtV1Sy8u8+ze2jYsZ7m5QjR7ihV9YljO
 Dl2EyjjXelpXRYtLaXBem1n/Kk74evmMwZOvRMGDk6H5bfdj3p0CPdHp58B4CHMsrvoE
 D3ftF8h+g6/0M6YH+gtzjVcUjaTtrlhB9IFoPpsvseqbp+OkMAzhr39P8fBtOv2zC4Uf
 Iicg==
X-Gm-Message-State: APuU4Z8pXMsleMzuJRRli1qwGymQz4+TG3qqXdgbI86rq7ZrV+MgCKmV
 R2ymMbQvj/HGrtr8zDFfN/ZrlTL3Z9aeAtX75ekDpX6q2zCWmBkuGKrWHp2bc1HkmerG4pNAP56
 e+5R2gmo/REPWeUJYT+Ln1HOndU8XgOy62uO/MlyaACo/CN4LMx5ssiiFY4kdYlLuKYnt6g8=
X-Gm-Gg: AYBFou1NIL7SFHI4KfLeWW7I4kMMJF6RKnTj88vL6UUdWe1Atl7eW0CpCHtrzUM9Czn
 A5qgG2YyZYJap7gmJYcot1CHhCcEjpXYax8uEt44KNXgFXV2cxl1xZ4HvQe/8jgHfM1fS4sgbVb
 t7F2v4v8X1aIOQXOQ4t7jspNszoprKMS1TCUVNLZyCJXUwKUtjCmt5pblHv6esMFosEuXPtLLiI
 jnbMQB6XwKJLOZkCD65rDq9wDb+XEAQH/SBz64VeRTdkOtocOIrX2UIRQ5VNP4ghk41tCYaj2dW
 tpudXTTH8UHczk1oDgyFuhqDLlHVNEMm2fpIx+eeRMLjSaeUONkVaHzlts6CXUBb3Qn5rG9N1ze
 DZPEwX3iLftsITUwr1pc3Rtj8LQDId4OPKNFRrzSoSUhkk2nK6m4S3R1NFnTYBfISsBVi8a3WgL
 +xh0m74PE=
X-Received: by 2002:a05:6a00:22c5:b0:8a0:4807:457c with SMTP id
 d2e1a72fcca58-8bc1d332510mr4962206b3a.39.1794476254216; 
 Thu, 12 Nov 2026 01:37:34 -0800 (PST)
X-Received: by 2002:a05:6a00:22c5:b0:8a0:4807:457c with SMTP id
 d2e1a72fcca58-8bc1d332510mr4962180b3a.39.1794476253726; 
 Thu, 12 Nov 2026 01:37:33 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaa1b1bf1sm3225569b3a.12.2026.11.12.01.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 01:37:33 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <c19f662d-8d04-47c9-a458-838e46521f2d@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:07:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT37802
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jayant Shekhar <jshekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109-jshekhar-nt37802-v2-0-a8e9efdcabd7@oss.qualcomm.com>
 <20261109-jshekhar-nt37802-v2-1-a8e9efdcabd7@oss.qualcomm.com>
 <9b05fd08-7bfc-462b-81b8-a560350f4235@kernel.org>
Content-Language: en-US
In-Reply-To: <9b05fd08-7bfc-462b-81b8-a560350f4235@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX2WgiVAZEQZwe
 lxewaGu29EZShj25MoHq9BPg2AEc1F5Bw5cCbhgfql41F3nulGU5T/UXDnPnUtN4jxqOvDwvwwQ
 1qD1mrlp6viI+23bsFjK8AqTmPRiRdE=
X-Proofpoint-GUID: mWyLAnguy0KvZF6WjjSJ9Gu3BQcGZ1jJ
X-Proofpoint-ORIG-GUID: mWyLAnguy0KvZF6WjjSJ9Gu3BQcGZ1jJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX0cghrk//bfTt
 uMqAMzltHxtNmQoEiStyUiw5bjkkixvmNugJMOm+q6skpjOJv9C2Y+ACeh3Hbe4hWep3WRhV3ey
 EG+trA3HDV840M+UivnVC2ex3PiNM2+cfnjd9vWQPmIawDxzT6DWk9F/IbSlEe95e911nx57afY
 m9ADMoewCzC02DB+iDG3DS36zEVNGIeIhuAmY9YXE0lKwIPPYegKVQFDn2c7lcE6sp6BnVnpf7z
 eQPhl6jYel0rMKe6WQGzS67YHJP3GhiJ2Z2NZAFC7e4BzsWDv+PzkjpOvMVM3zl0op/ln2Iu760
 x7fiAStZQxfzqHOt8jL4BVSBCcdLlIuJmZy+g+2DhTA0nQXZq4FyYFHc+JeWadDmnHDf1caRlTM
 rxFB/9DklwuQlUjAdVIv9BcX2qCclfHxvM7ACFyNbSWb+FEXDRhS7VkvZYwkOdGlkqnsrm2Jx9a
 ptC0n2JHgOZ1vAHPnSQ==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af588de cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=sM0BxRoSGqECXxgCHJEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120038
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 09-11-2026 18:48, Krzysztof Kozlowski wrote:
> On 09/11/2026 07:27, Jayant Shekhar wrote:
>> Document the Novatek NT37802 AMOLED DSI command-mode panel.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   .../bindings/display/panel/novatek,nt37801.yaml    | 49 ++++++++++++++++++++--
>>   1 file changed, 45 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>> index 1b38c1d0af68..be318cc84d52 100644
>> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>> @@ -4,26 +4,30 @@
>>   $id: http://devicetree.org/schemas/display/panel/novatek,nt37801.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Novatek NT37801 AMOLED DSI Panel
>> +title: Novatek NT37801 and NT37802 AMOLED DSI Panels
>>   
>>   maintainers:
>>     - Krzysztof Kozlowski <krzk@kernel.org>
>>   
>>   description:
>> -  Naming is inconclusive and different sources claim this is either Novatek
>> -  NT37801 or NT37810 AMOLED DSI Panel.
>> +  Naming is inconclusive and different sources claim the NT37801 panel is
>> +  either Novatek NT37801 or NT37810. The NT37802 panel uses the same common
>> +  DSI interface and regulator supplies, and additionally requires EXVDD.
> What is EXVDD supply? The example DTS suggests it is something fake.


Its not fake, it would be something like below:

     display_panel_vdd: regulator-display-panel-vdd {
         compatible = "regulator-fixed";
         regulator-name = "display-panel-vdd";
         regulator-min-microvolt = <1100000>;
         regulator-max-microvolt = <1100000>;
         startup-delay-us = <233>;
         gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
         enable-active-high;
         regulator-boot-on;
         pinctrl-0 = <&sde_disp0_vdd_active>;
         pinctrl-names = "default";
};


Thanks, Jayant

> Best regards,
> Krzysztof
