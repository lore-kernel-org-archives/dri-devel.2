Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D710CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B734110E9CE;
	Wed, 17 Jun 2026 12:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5fk6zOu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YQ3t/CFU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE5A10E9CE
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 12:12:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HC9scj2767765
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 12:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BM7xOnT7k39jKKMfHpXEUbFH/ygimJf7hwotvg5lHcU=; b=k5fk6zOurvf2PaNt
 eQVOPo78fhgQrzRrP23NZ1CzWWw4DYeljgbdrl7QJuInWpSlw12AZErCUAFrgscj
 dhgW8CGaJUk/Ibo6ldjXfjQMOLkDq7H1B2wf9gmF66nYpwHsaWJhgWvEwA+9ucTO
 M5+TkW1sz7Nr7M+cB3AB9yIwViXnSX5BxSxCxub6I/M3bsHmebLb00HYVB3M0OV4
 lK3E6+ZMoxPhyVWKodhsqT1BAX8RfJqxQ6t144BwoHfgE+jmwy81zhGoybuTPkYY
 r3b/kJF2UR29gLzML4DXWRgiqwLp1gLMA4jGyoKBPeBYdc8BOTL6ADAz9J2rBA+e
 8E01aA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2b3qf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 12:12:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517bdeceb54so13430201cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781698368; x=1782303168;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BM7xOnT7k39jKKMfHpXEUbFH/ygimJf7hwotvg5lHcU=;
 b=YQ3t/CFUlBq9TYupzxmaphV+Qd8becno3MdP8EjbnJ982j4MMpGxH1P0sOAx3t0Q9L
 /DY0JNUVYVb9m0bQ3200BbGkSsppMis1Cbc/htcDyyUJKFw1oqwkFmel24BMcAa1gOgG
 Ql6Wzri8mXXYfebaTih+EIIqvzDYxyzDyAOdCWXLy4tHk5kNshuw/6L/LdPPWo/tIUPg
 1JfW5ULoAetgpdbLJF/jP5dm6pfkwz+x5q0rqsVyyjzSoTBeWi1diaSQt3Jlm+ZNIrsz
 DJoT3UWRtJO+/I8qHbiFFZ33mI82opBjPQDMJx4tF8Yhiv8sCcXGHWv7+tf8Lkzk5GWl
 RkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781698368; x=1782303168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BM7xOnT7k39jKKMfHpXEUbFH/ygimJf7hwotvg5lHcU=;
 b=gMRZDH/o3jTkTIEW6x+MTRrvm+lvh2mtKdSZEljZGaThPnmqPnUPTV901iEnDJcLbp
 NjEw+fsT5sl20cxKcMGrlKCvL4WpreK+NSw7Ckx3v8Sdo5ESKjk5dultM7jll5ClEj1Y
 ucP+Q/xriw6us2jpJTKD7DmmywbgOMnK2KHgX5i4dko1Dl5i8pU9mir/qBR5CRyvKCgI
 g+tM6EtkzxtZzVQN/tVSV9YY9rk0rtQ5I99t9OookXBweH5npAXPx2MOgocebRcULdv+
 thN68JaLnJnBgGlc9XlsyKmfZNasKrebwM0KQIxbyWJ6BDQHfkJIxe0Jvk13JLjH3oB7
 1NpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5tMdxOJ1Ws4u1bs8P6JhQQca4rV7tKIvifNJ66a9Ea2RwJFQZbrJwdafFRiDR959jyJlJCbmtCZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZL7o/w7vau/p2WXfll1I5AV1GMbrzcCmSMQgQ+xQwUbUsixBm
 yX/XSiysQmM/1eh6iRpkEXZlxY/5NK/Mzwh+Ilb3Ztkm2S11AAiHh4Y3vUi1badHoWghpq6/BgC
 UO8b9vEa32LZwCS5FRUQUbOigMfBsSGqrC17Ah1uEluUTb8KadSJx7ZEe1JXOBjqIL37dStY=
X-Gm-Gg: Acq92OEUhzV/0+VWx/Ru8S0uQLpUj42wrhjFz/tA66c3v7MXA67mPS6SHICimUMBszI
 RUG7cRkAIO3oYFtxeJwoQZ7l8uQaGvUjD3s3lpg4Ot/cpW9VNnXaNrvFIEx+c9mNln93PWFwzwH
 afgL5698hPM7/yjQM7MCEdgISve0L8Bqqw+RxMxVLACKOXg9ReaO7tY7utCr9On9HPhgkQG7mR8
 EuyqHi3GiI5RE1YVESGbxUwOodEVwRfkcbgbgeokaru7Vgo2T+4UoxjVQ7zv5TMQbgWGX0fXi4m
 Nk7sT99mrSvyzwqA+SOi39L5u83PEp0OiSLFEGQD4Vol7CF/YxL0uEP4kux1rtL3Tnrbnjphviw
 5O8uNT9kGPWIwD069bqlrE9mnp2oXWeGFMoI=
X-Received: by 2002:ac8:5d41:0:b0:519:51a9:ff67 with SMTP id
 d75a77b69052e-519abb5394cmr27927531cf.0.1781698368284; 
 Wed, 17 Jun 2026 05:12:48 -0700 (PDT)
X-Received: by 2002:ac8:5d41:0:b0:519:51a9:ff67 with SMTP id
 d75a77b69052e-519abb5394cmr27926871cf.0.1781698367625; 
 Wed, 17 Jun 2026 05:12:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937948dff8sm6308440a12.22.2026.06.17.05.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 05:12:46 -0700 (PDT)
Message-ID: <af46a084-0544-49ec-a75c-70eac0d0ea49@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 14:12:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: milos-fairphone-fp6: Enable display
To: Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-4-e09cb05651cc@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260501-fp6-panel-v1-4-e09cb05651cc@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a328f40 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=t_WoDEAhxH4J7FjSGWwA:9 a=QEXdDO2ut3YA:10
 a=AYr37p2UDEkA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNSBTYWx0ZWRfX8lfIIaxDFLEG
 pkx6ngMZRjcYBxnbz4YzmxL/jvFfNXhCLcGlW4JZSUw3dWeZ+J+pObsUqnCLs1ceTIoxlBJ0xZ6
 EQcWCfWk1vBQJT7gJomiXmdDQSqvxIo=
X-Proofpoint-GUID: CiU08eY9aIR8oSbGHz9zdPsNYvPbuLNq
X-Proofpoint-ORIG-GUID: CiU08eY9aIR8oSbGHz9zdPsNYvPbuLNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNSBTYWx0ZWRfX/1XjunyLYce4
 p5Zu1+9Mv3h1a2uPhQR5jHgO4wmfJqIZsJSa05r5n8/DDEqg4f/doAoHhMPpx27XbijKiPxkBEc
 rIhW+HcKvBxUhvk+3765cco7m+wd9/Ehi10WIMp/qXr1DvH8qi4O+q08lFRcx7mXHWXCwEwdwoQ
 uSGNbubt75JUIJoI1vWmmo5DOwYUHh/xxyZ2nadxdF1Rz3Pw0ptFLmCqavc4YL8fCZ05d5W5NC2
 b3Dt2g7tINPxAvloopgnY0tj8HE1ByC/DdxvnXmEnb8iWMM1EfsjiACTgHBgNObTaYgV2f3hDSa
 ZWbqTuYPQWyG+p4b8hlXrCElYDMFwekXB0triQUkETaM8MaMFmKG3V0ZJSyz9pJx3dYpkRHmyWp
 1a6t9nj+TmuzWeVS88+4qVnKII5qHAZvM09oz1li2tHhZ5JK1+6tqvlyDqa48hJQ6hzLpLK6W+m
 HhRtp/UKGjYHsrrNdHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170115
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

On 5/1/26 3:52 PM, Luca Weiss wrote:
> Configure the MDSS nodes for the phone and add the panel node.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
