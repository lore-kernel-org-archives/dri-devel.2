Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D239606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BUEnskkz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h2MU32qw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED8910E348;
	Fri, 27 Nov 2026 04:58:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A0110E348
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:58:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw8km781864
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4JR4pQFfNiYIOOdiiGpAjc21yV4RSSVFN7iI72ZS3r8=; b=BUEnskkzvBDazavk
 7KHeSowFViWKLUZ5dgeOI3qjqhHp8oLy+qrLkAS6B1MktiA1VanIDymJKU2lyEnf
 +eGIkXnDokyqAvO4OIHWxJhbBwh0ktJodqpPAseFJa6OA+GVpOdEgq0g1we39VGu
 z8o6OwHp2k+7CORCauydVhlISrPzg1ZGunzcusmjX1A5tyjtu01+95tmMGsJy7oc
 k0iae/EpdP+XD50qw57AlnDPUeh40OL5GYNTEc2ypKPoyUsF7+BsvpJ9UbGbE2m0
 FPrThvu8JAHr1FoCvN3jl2EQ/fZyHUJRVU8AUatCRQI/fYRh01GmM0tIM2Dt5uE8
 obGZsQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm83bex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:58:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b56c696405so11538434c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795755516; x=1796360316;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4JR4pQFfNiYIOOdiiGpAjc21yV4RSSVFN7iI72ZS3r8=;
 b=h2MU32qwqky9XdihvLEgLFh4VCQlvude6UeBQFk5HwhxPfvFpFkhNpqeuf8P+9e3Vc
 zQUK/3UmoqxX1huFnfMdj0TmjQL4ymtn3QDPWjbOT8M+470VOt+g/QbDjStFnA7HilUM
 0C71ZTa9PL2NbhmtAU9tfCusBfZWoXD1VyMfb5msVGtwfkKZk4mSpQCMFlvyv+388Lx4
 HJyKPRL12TmZ+xvnrORqCkqkgzOTt8HisjSdQenf8hB23oKaZtviTpXD5WS0MC87LoQh
 h3EfVUv9K7pgd2GZs4zHpwzlOvG2J7i2ORZ5AGfvMhyTkLQuFqd31kkdO0n8ojbeaBlq
 4B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795755516; x=1796360316;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4JR4pQFfNiYIOOdiiGpAjc21yV4RSSVFN7iI72ZS3r8=;
 b=pWIs+77Yb6Q6XiUEjgGRmspyDYyQabqAE93NdAwYFVoG1Cg3J6OzUS2PqaoLxOC5Oa
 VIgfDZtWaepcAMPz0UZmYC511DWpwqLmE5yu2hFy58EMFcoTCzEBQZmrh+FbVXaEwZz8
 NGKMwytPrE9fzbtGBePlkGxvlfR4pO5Da1cDPZu+BXZT6sfn7UajpDICoWPY9j7zIEjX
 LVYlXFKRCsBdnRPbR7pz1sEioABXCQ7AMOoayKCPPotDSaoWjcOuKNx/sBV6+zIsScb5
 OsyFlXlD/b+4H3CCDJgtStieAIh926bTrxJ2ilk6j+AJmYl7MzacmOhwQgyhGdlGmxJp
 vQ8g==
X-Gm-Message-State: APuU4Z8evncTy7zfL9cEGuTZsLquob8PBRMSESCK1jzMJ0tRoPCjRIxR
 kTJssgqv/X4wJpU2f/nkXraiSB8nBnRsIaz+7QctvgyeBzOz4T+yClGrPzFitwNP0uSrpgkWwR/
 1G+Z+e/5VbNxdLg2YpGxGcTEAdlOh/OYPXFYPkDbi5T7o6pkWVpAhCW62mA1VwulSJfUVgcU=
X-Gm-Gg: AZFdTZf5tCmmtaWCsDad2qDgAq1rnb5kLFTWXifo8CctiVP0VGhMrOHOYHwzZVqUZMs
 7S9HeNgMnHdJZEugPEKpoGlYxhkRW7yF2SrGmIGb+GNLa9cf4cEKnyJA7N7R2TtR64zkqUg3GC4
 csjKFyqIeeVhnRbdXyMp5tBQHyn9qm3MzmA+wDOPgp5yVk3CB3PUCDH3Kny6DsFUVeUc4f4CN7M
 wGJUIA256BkNafsspo173QhgjhJOQnR6qE3vzNfrQ69AsY97dw0DqqRWuhBva8fhjYcQ+Aqgxw7
 R05JngiFWcYxopwUwg/Gnq5sNzH1tqjTL77sHEP6Di1dZegbyIntsYPTlzdPDaiKRo5cf/FiOeE
 Tb3awapIZvASU5LtPNAarV0hArteHWKig0vqJ6a80qreNzTbCjdSSUcOx3dds72mPnX8sNpw3J2
 BuTRNmesE=
X-Received: by 2002:a05:701b:450d:20b0:1b2:4378:3545 with SMTP id
 a92af1059eb24-1b5568e825emr25219028c88.21.1795755516400; 
 Thu, 26 Nov 2026 20:58:36 -0800 (PST)
X-Received: by 2002:a05:701b:450d:20b0:1b2:4378:3545 with SMTP id
 a92af1059eb24-1b5568e825emr25219009c88.21.1795755515892; 
 Thu, 26 Nov 2026 20:58:35 -0800 (PST)
Received: from [192.168.1.42] ([183.82.131.33])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5567ff27bsm60891790c88.6.2026.11.26.20.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 20:58:35 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <1e6971ec-41a1-4195-a46c-d267e1ced071@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 10:28:28 +0530
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
 <c19f662d-8d04-47c9-a458-838e46521f2d@oss.qualcomm.com>
 <6f256993-24e5-457e-bcba-7bad2defc9ee@kernel.org>
Content-Language: en-US
In-Reply-To: <6f256993-24e5-457e-bcba-7bad2defc9ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: clFIFV0vLtnN0GNNC7ClpImIWYvH9lXM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAxOSBTYWx0ZWRfX5Jq8zafYOwK0
 SZm1weYcElw6hasHS+xjZrnN/xvEfUYbMfzOQb6p5RlIYgLYZLLUFOogzi1Nx6LM2v9yqhXuyWE
 +MBHWmQoe2XH7bJGkd6meDJZaubBBW8=
X-Proofpoint-GUID: clFIFV0vLtnN0GNNC7ClpImIWYvH9lXM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAxOSBTYWx0ZWRfX4rgnW4X30iui
 WEXhn7OXB5+hkiny6D4rtoADAdVLWNb0zBzoxXlyDu168REwEFCusaSiBTPtyXkW4JKzcfvy5Xs
 m4dX/hEM+23pvkKvpHuTDEiKO6T7bsaVxRps9T1rqcVmzNYZxLGM41nWfEtaL3c3jwlrFWRGCo7
 IOKCvDaJuJQZetrcJb8vTuaQVxQb5uBmcg7GLP6O5j824trrgv7H60HKJY8Zc3nB2U37jxcMbhS
 +OLfcZYj+M/LuUvv7dDVfPT7eSRk9zYqbDAReFUYUlo0LHItM2h4OsKZQpESgqB+gJGccygFXy0
 OF0W5fysyQGNXlfQodXUKfkknr1jG0hTN08ryXdbLqpTGJGGQqIz/RVnbgoySEMVKqxVO27i+yP
 Dtn+SUkybk3Sp7RWEiH2fC/aoB4ilxjXthhhaLWtYUB/5GZR9Oid1vl4o6RQPH22ZDhSfpCdn8B
 dVaZQW+/CdadgXJPGnA==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b090dfd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=i7XPzsavtsL+s9i5bvvXzg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=iiqVWuNAnhh-rcyhhn8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270019
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


On 13-11-2026 13:19, Krzysztof Kozlowski wrote:
> On 12/11/2026 10:37, Jayant Shekhar wrote:
>> On 09-11-2026 18:48, Krzysztof Kozlowski wrote:
>>> On 09/11/2026 07:27, Jayant Shekhar wrote:
>>>> Document the Novatek NT37802 AMOLED DSI command-mode panel.
>>>>
>>>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/display/panel/novatek,nt37801.yaml    | 49 ++++++++++++++++++++--
>>>>    1 file changed, 45 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>>>> index 1b38c1d0af68..be318cc84d52 100644
>>>> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>>>> @@ -4,26 +4,30 @@
>>>>    $id: http://devicetree.org/schemas/display/panel/novatek,nt37801.yaml#
>>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>    
>>>> -title: Novatek NT37801 AMOLED DSI Panel
>>>> +title: Novatek NT37801 and NT37802 AMOLED DSI Panels
>>>>    
>>>>    maintainers:
>>>>      - Krzysztof Kozlowski <krzk@kernel.org>
>>>>    
>>>>    description:
>>>> -  Naming is inconclusive and different sources claim this is either Novatek
>>>> -  NT37801 or NT37810 AMOLED DSI Panel.
>>>> +  Naming is inconclusive and different sources claim the NT37801 panel is
>>>> +  either Novatek NT37801 or NT37810. The NT37802 panel uses the same common
>>>> +  DSI interface and regulator supplies, and additionally requires EXVDD.
>>> What is EXVDD supply? The example DTS suggests it is something fake.
>>
>> Its not fake, it would be something like below:
> OK, how is the pin named on NT37802 side?
>
>>       display_panel_vdd: regulator-display-panel-vdd {
>>           compatible = "regulator-fixed";
>>           regulator-name = "display-panel-vdd";
>>           regulator-min-microvolt = <1100000>;
>>           regulator-max-microvolt = <1100000>;
>>           startup-delay-us = <233>;
>>           gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
>>           enable-active-high;
>>           regulator-boot-on;
>>           pinctrl-0 = <&sde_disp0_vdd_active>;
>>           pinctrl-names = "default";
> Looks like something for backlight honestly.


  This is a panel power connection, not a backlight supply.

  Its purpose is to let the panel use a system-provided DVDD rail.


>
> Best regards,
> Krzysztof
