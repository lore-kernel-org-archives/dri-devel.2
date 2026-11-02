Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE1606A337
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RK2HHeBj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OwgUDWJX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F14110ED54;
	Mon,  2 Nov 2026 11:59:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048B010ED54
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:59:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AOFt3086531
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KxBPqpgXhfqvGlKpWpzmxhKDsK56vJpqqow3NQ9e2TQ=; b=RK2HHeBjVeFnidnU
 oFUwn1G0rZsfbDoIOe1mDEJvDU6WhYabIXrOIvTTN3R43DuyYCZlTATTzJu0SiS6
 ynVHCuAa+dM+NZEwSt2Hf948QH2vcvU2OZma8qirKGKo+vrdU89NuzdpF9o6fkyf
 uHsre8dliUieMfKhh9aIBZX6QfAb1ioWU5Uey32f+40HX3kw18Y+xc3awFjLnBf8
 kR8rxv+9y8z8bFmREfbNZq0TG26DM0s2udi9mh/0yYMXukXRBXqeYE+M8iRoWNWV
 eA/GNeyP5qGN2Ry+kg4OFlkQqU8BVhvseC7L507JppsaenXY9J4v0H0Y2QKJZUhm
 LzqRIw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61nkm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:59:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536708d1a3eso4739811cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793620767; x=1794225567;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KxBPqpgXhfqvGlKpWpzmxhKDsK56vJpqqow3NQ9e2TQ=;
 b=OwgUDWJXyF5FNopy/TNGl73q7WhdlLwnztab9HL8OFyxgC0Yaod48iQ41jL12POlX+
 +RTpzHLOq550Gtr2VXUhysM0ftk6RJ7NWeiALnGUilwjni/eztXyY1yH8wdZ69PKNXS2
 r0ZvkHL10uBaTZb9ulf6o/fWIlwENk201zQpuQ+4CHGuawC8CmphipxdeH77UrW+HM1J
 2Vd6FwoeKCi/ICwxRbuIhsIJD7ArPLZcTPaHpTGXRik2PDawt8aXlU1+Mp+A+mnzX2YR
 NcUmWVn5x3b/MCJs+LJXI9gnisBNX5ItX5S0Ma/79f/VAwkXQtpwNK5yyNiDXPaV+qS7
 9q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620767; x=1794225567;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KxBPqpgXhfqvGlKpWpzmxhKDsK56vJpqqow3NQ9e2TQ=;
 b=n9agTh/GDOzdlSfparCnZk2zbj8jGrU2VSTA3AHB8/xUU0Rpwt8X1yw0HIIBDU5zEN
 uix3qb64WCez7DGRnDsymjZTNjJAFIYEJIxdhDhgD0X8iIxw8za+6YT9B5TbmTFGR9yL
 VpAf+YA/i/52kRd5KrvbRl1OPmurnY+cVp3HE59eS9Rwta4QTahq6xBYnFNoYAlUZiKP
 TGBTyDNMHj+SoOai11qjd3hLRUEnCvRKmRErEgsmwWinNLlkyeuNn6ZVf5vbwF9ueTTh
 wtB/hzwCyOVP9XUbFB60HdPAcAl19uHLe5hbQy7CngmITnsg14EYlRUxzShicMN9bEZ5
 acrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw47s7Y0q+RkHksLIH3deDQIQIpqcFZs9Ykst+oI0CmchK4+kk4kjeOCcyL+iTJ7mR3VhiKOrKszt4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIazEQDj/qaelye1EClQAUu4mzwp9Xl7l39OLJWBfZNvHI5Wo+d
 xDf/attrq7ZJjZewleEjJTzC//AaPL5zNpljR7IA/6OyiNotAGCocYUbWXbEgOYEGRJSPhZ3AlD
 gES52KXZWthDWRLR4/QsmasawQlqOXkxqiHvvim67wkxjVQkJ/6OjORfz2DVwmrZdUWZexOoDXS
 644t8=
X-Gm-Gg: AYBFou0/XDMZ1B7uDnq/Sm41eFVqioFc1jlpVYDDo2H5dqGttDLu8+TGswfvPO9gXCg
 rwZYgRlraOxKKEH16lJsLj0BFGKLqqEgm7abzVbYHGTGObawSpbXdG4RfQ81+xO/9sak6j+b+64
 o6dKSVU+4+j8uk9PEipklpPPiTC6U/i1vURnL9BfR6BOYFNdhg9NOdWIBChbtG6VKbHCobRynl9
 lWEnyPQ3VN7ylnUMzsnnwHh5bkneMc2cybabqIz7efeaipGzf7masSIM+qhqt0zio8v4zFaRojI
 WouPIeWLv93YrsBafs02m+gqLk59uv/yhwHpCqF10x9Mm7pK364r4rjVj37kVq2j7cq5h5ZNqOs
 QPEf1XI0O9kZBcPcYZ6MMFbbQ4U/cz1YbSA03pyz8//q6dyOwFZZ96FM2Ane50SPmHS1ALFc=
X-Received: by 2002:a05:620a:6f9a:20b0:939:9205:4d78 with SMTP id
 af79cd13be357-94421654ce0mr1517091685a.3.1793620767302; 
 Mon, 02 Nov 2026 03:59:27 -0800 (PST)
X-Received: by 2002:a05:620a:6f9a:20b0:939:9205:4d78 with SMTP id
 af79cd13be357-94421654ce0mr1517088585a.3.1793620766638; 
 Mon, 02 Nov 2026 03:59:26 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc1915csm377913466b.7.2026.11.02.03.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:59:25 -0800 (PST)
Message-ID: <44ac4c60-d89a-42f3-82aa-ef3fb0f54636@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:59:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] arm64: dts: qcom: sm6350-lena: Enable PM7250B
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
 <20261102-pdx213-upstream-3-v3-7-cdc3be96d257@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-pdx213-upstream-3-v3-7-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _NxLxJx3_TKll3pJu5l42ErQ31NvNGYP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfXyXhoU9G7lmgo
 89j76fqRajfebT26/8Ire+ANqOVBmpJOvJL4iQJh6DrFC+0av3RDO3GRPoDPw/2CSn0em3eeaIO
 v9HTuOlPGPQkt2DuqaDbDXk2p8DkcrQ=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae87b20 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=dNZ_EX_IlpB_z2sQReYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX8Kb5mvDY7PIC
 IFqKRz1WXwidU1F7oIrhYoSZkyow1cqGSuWyYxFxAk0rCbP78mqpgFw9fXFBGU/Jk2z/niL5ep8
 eEWolnnE2owiB1J0F+KrOuEwvOzssC6DRsxTcSbeXBCxQzWYVCe+rCyleQuQylCk3+PdEIRvyHR
 CQuMZ84U5lvzuzHitxxm2na+ZbQzX4OAdaehq7xWiJRNiFIRUFF80lD/jB29IAJOwCHvrRgUnm2
 pW9vH0DuD3bPdhccSvnUkI+RWLLYMynx0i9+QHloefwl4tUpVI7OA2hQF0Xhv0zsEg9KGx0Ngyy
 IW35ORoKndYpdrxq3TKwKHUDeXUVY3al6vMJbII5cgOYb92a4dYCHpWZP86HRZYaCPQaFg58ToM
 RtszDmMOCyyCBfSo+FYLZ5WmT9/9pFV4Edt6Ru0DYEdn8vKKcVlPpvWIglNZlaLGyspXryLjW6M
 daLWgAX1p3CmwIpfIJA==
X-Proofpoint-GUID: _NxLxJx3_TKll3pJu5l42ErQ31NvNGYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020047
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
> Enable PM7250B and some components on it for the Xperia 10 III.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
