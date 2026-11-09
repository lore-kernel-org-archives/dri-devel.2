Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B0606EE82
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k/1lxwbO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S35T7Dg8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441AD10F285;
	Mon,  9 Nov 2026 13:10:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F01210F285
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:10:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99usBD550707
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 13:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cnZsY44wFy3q/HITacB4SEcKnwDZevDNn4+gnmN9bLY=; b=k/1lxwbOE4uLP7VY
 MujD+j9Rh5noUzT/4yrskSNS6wTzY+zyyYhKGXcRYcC2oZRi8QTzrHJ3mShp2tCy
 JldXh9BfcQxQCXhYl5podohUWvhuIYtOr3atR33Vhi3J2/An3iDrALGWugu9fd/V
 BCX57x8g2fQhu3xrUUqnydn2tR+z5JTPPBGeaQuvlfXGoCr5GJSXT81JR7GUVLvc
 ub4bQrSpLpYp1MnYURxWW0zXAfqO7SU9NmMdKJTTu7OtzZAmR0QnMcXsTPYMaJkf
 0ClzobaQ1lXp9iyd1quFUkg8WLgw/aQ4aTHz7F/Y9rWFgCm0CJwEQhfQZccfgnpA
 dV18XQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm38da-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 13:10:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5356c6d98cbso2705571cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794229836; x=1794834636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cnZsY44wFy3q/HITacB4SEcKnwDZevDNn4+gnmN9bLY=;
 b=S35T7Dg8ZTRew9of6cMMFbMnYd+R9tqxM0EIUDIo3jK4StsBxkQsz2pOVRXyDPkcmp
 UYd7QmUPkjuvKBR3Fy8pzBDXkVcPRKLOYr+v+3IZwnxc9AmzPyevqMzEOgaD1uRx3R6+
 WjuLBXNvHyJNZdqORljQaW42kIlCl0T2xd5/6fwYCEyPJh9K/SLd8Ut5pK1IQGGugftp
 0cGpuOVGqOaEc1Y8jogKQhhWZRaVbewSp8f2ioKP0lWOvP/QfxtAScBFlNLIpLnJsAEm
 DetSIUViWeQsWYeQuagk+Hs50VDRYKwot8EjE71TgFE6HtKVvIqGSsmpdiQnlKHK10+8
 UQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794229836; x=1794834636;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cnZsY44wFy3q/HITacB4SEcKnwDZevDNn4+gnmN9bLY=;
 b=s3U1KiaeVHMzWHBfn563SlsJlt1YzaSx1Xf31TsZAu7fGxH6uby6uwqm80ZeQcdQGc
 VEEJN6OvwLm316LhIo2GXfaHRxu7q5+tmOsFUsA96IfevBGtjhGZTMBx7d8XZWw2M78h
 Gdbx5POfSfyFPdoyzj/0bqBxDNTCd3zPaRkrnE4bO7jQ148olayt8T36eySWvjV+9iW3
 yP9aNDzPbIqYZuHoAi2QYTCjES4/C1tD02DqbW3ldFhdL8Xyc/EMIC6+aChkG0FFzmpb
 DDV/NoGKcvv2Cba0tXdrRGUFzendrRwH8UZQ7OPK1o5jkAmCcwbdBmLrVIdCvlJE4t8B
 waWw==
X-Forwarded-Encrypted: i=1;
 AL+hErFLvphUoMF7lsA8XQ262JZ9YffFuO98UaKmFl484n6DEh4DNpcxncyigeW1yWdO2dV9nomChMTHOl4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9B0uUKyukD/2IH6jgaJLdVV1n7FNtvoTHmOaT5TFko5juZw6ts
 kcgfXhCT71ipRdiqhPA2wpuVzQzsKtGzgcNTS5UvuX8O2t7jQl568MNK3TCKOocGXKaxM3VD+zc
 8Uv9r0bK53X4YG+VYKQZmNnyz3aTBeazWZtCDTdazWnJ2fjv/OKQbGnoZRgqQFZXqH4Jy1C8=
X-Gm-Gg: AYBFou3AN01HYDdT+FLkqetWf0j9Wv1QTaZ/cdFcForF6hvzDmrhJCTaEWWGuB0tdO6
 0LnXbMrxkI1Sg/5gBZN+eq4dnsstMrT9SniIzFk+7BMdS/X2rTOqEx9QJDGTlPyY1/lHE/idGdb
 7F/e4YmRxNqo6wUASh81bCFhFFvxqosEciing+Ee3YFzZ+UvLYD9Sza+7dzEZMbp0sZ9bz949zQ
 LtCmLkoMDQNwQ9K2j88alvexnCYaoJwqmNK+9egwXXSRTntaImGl/pFng/JMGWGJZLpR6/s+X4W
 EKSIQ/ORrnglMkcD5IZFPZqUeELilYBnaulKLTld5FYxx+Ws3R55qJ0kHpFzzlt2nffyW4yrM9r
 95100CPPuVrCt/SEPAAV6vr0EslDgMkQToUx0IDLocDLxDJnA7kz+vi06vYhA/UqPgWONRw==
X-Received: by 2002:a05:622a:e487:10b0:54a:a0ae:795b with SMTP id
 d75a77b69052e-552a46edbbdmr59576701cf.3.1794229835799; 
 Mon, 09 Nov 2026 05:10:35 -0800 (PST)
X-Received: by 2002:a05:622a:e487:10b0:54a:a0ae:795b with SMTP id
 d75a77b69052e-552a46edbbdmr59576271cf.3.1794229835244; 
 Mon, 09 Nov 2026 05:10:35 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c14b7fc273sm905653e87.24.2026.11.09.05.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 05:10:33 -0800 (PST)
Message-ID: <86c73833-99f2-488e-ab90-114f2c9d1c19@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:10:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: sdm845-google-crosshatch: Add
 display panel
To: david@ixit.cz, Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-10-87dd4ec4f7cc@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261108-crosshatch-panel-v3-10-87dd4ec4f7cc@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX4JpU9OTB8HGP
 jknG/S7anpMg3YSohU7pPJ2CikTJh8WR70bPuNXH7y9Ki2vTd07mF7kE1Tc8c6WBBgX0isCxjYR
 o1l49+DZEAPquR+sAT+GXNKQwEaOCLg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX4yb0JiSJnQfR
 9RdqUqgB95ANVlYtftknycDEUaAMuRKOlWnSaeOpRR+/iS6lXawTif89QmFH35RDHB7MJzfenlX
 Q6+4TUgzsfBGqTRkJRTueCqIM10vjZ3Or6AawGuMLMZHDnkYI+wqw36i6VELyeVfrWC6Z89tVwK
 6j+e0toL5TrzEh/4I2AZXoUSYrkPsoZDtrheWASMCPKQmLros316brEVmBiqLTjEZL6ZPQ44SG+
 +7ajAemYYUImLGEL15WcpBr9SUm/WbugltyFXjv2m0S+fpfrpJ8eVGieEwgEmVlwMlJ7hYqekOS
 uT+czWNVlhuSxZ/7CosB390H3gunRMNKCdSQVj1eNVHsF8cWnikY4yFoMfRWJcsoHpcEoZP0Cbr
 15egH9v2z/eqFtvp65bbwPmbVGm1XhEywbHEfuub/mqV2luyW3L0/bm2Sue2dgbnqN6zk6Jspdt
 8wSBRjvYQow1xHwU/Iw==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1c64c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rlgZYKK0SKzbOMFyHoYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: LF1f94t4AyxFXNi4jjMNz6OJcjvvvJ0l
X-Proofpoint-ORIG-GUID: LF1f94t4AyxFXNi4jjMNz6OJcjvvvJ0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090052
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 1:32 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Wire up the Samsung AMB630QY01 AMOLED panel on the Pixel 3 XL and drop
> the MDSS/DISPCC disables that kept simple-framebuffer alive.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
