Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B6606A322
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U6u90Gqi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SzI9eGSu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2052C10FBE8;
	Wed, 28 Oct 2026 12:55:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3FF10E60B
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:55:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBe6qg1053356
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oBGX3wEUWU/zL8/JcUQMeSMNE0OdIiQmKuQoXCX4P/I=; b=U6u90GqiFQG1SvVe
 b/7ZAEfeyt6CT2fIbV2taQhsmuDKtZVKiz+x4u8dTDvceG6TIDdV2tT8aOPWbaY9
 jqbfr0uNY3ipYT4UkfAWN1h3GRkfxdBS/nkSgUmAPciCC+KCd7LXpuNraJFMvmJ2
 vD5HVicr0NH/Gs8pc0hO0dgfypEX6JmpOi8sVeqY3U8GZ80eL8S5OZA5wRN9APfW
 KxCj/L4uZnPS6n3D3AQnz9JKlsC25nHSFwJ+VZBQvfSjOZOBr2o+EeKCgQif8OW1
 buV4B8HQPc/a7Z2r3SVMHh070uTuWpxodJFKgzq8oPBoqcBnOkmIBMWc00AghWfG
 qHZ8/A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhw9f61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:54:59 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eaad898904so47685e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793192099; x=1793796899;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oBGX3wEUWU/zL8/JcUQMeSMNE0OdIiQmKuQoXCX4P/I=;
 b=SzI9eGSuiCgxDTejtu4EWBOCSYyx+AKHAr23ut7gDWXudRtuMEFsKb41SkRDjttt1i
 MW81vdYH4TOy6M1i7V+knte4KRsBb6jFavd09ZZhVUjqQFP2b0lL2lfFuySJhAUl5H3I
 7RXuyMiykhXg1njcW/s+KzV+5KV2hnhnmFZB8OD4wLTVqYZgnXrgBPSt1s9K3u4qlsXh
 9DwqIFBsLITU5D8MiiKYWPELctrW4lSQLvelj7OP1+yakx0iIA8mDnO3iqdyHiorx1M3
 qCNNbs0XZhwRqQ6/odu1lqkAmDXVJZ9yl5KUSHIkrFY2k0vgPC1rsLsVkrMSEcGr7Xl3
 KqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793192099; x=1793796899;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oBGX3wEUWU/zL8/JcUQMeSMNE0OdIiQmKuQoXCX4P/I=;
 b=YlCKTqY8ARCEnHa3gMg728voJ/mqkRZoGWPXUTZBu+M04D5bC98ynUelztvh5GaF3w
 A/Gk9EEV5TodwPBBcR20HPIwUb8W1W0Is1cqpdhKxAlsLDpLJNvnICCFr5Nn93Pr6Tbm
 6etq63Iff0CRVC8xggbM8vfSXpWFYS4A/hcFIJgD1UHjKr9LZSblbGBfHvxDEvZOHDtP
 njDEUOkOyViU3ODfl62fS3WtMEqQVLBKYO1Pe2MTA8DjYjm/CUf0TiNHmXiavS+ShH60
 Q9Ee047ShX9Su34GIuSeGiABF88/iBtJ52TiWUCYLhlgY2LJZa/xDgiMpp/SQLKcs5io
 rFXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByTpVxKY1KaoWrAo/uSngUXucpD4z5/TWRHkWEqnOOroS/s6EzudA8ZN/SvMYwg9UUK9/ThozgJ3JU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/rpNqPqFro4cbSyU4uw9QdtN5uXTBfRwt6gaQjfUKFenafta/
 gbCQ8GFbhGCAZ6CxGK7xxP14cACLdtBlARNnZTzjnUUXJd565R+ckbr7uz8g6PtkH99NF9mRfnK
 pxvE5793JKZjH9C3L7UqOaLxyQLJ2XLNJYRgbZ0Wsk1M7VDBD7pdh1aBvJrVFwZb/UHwHEGc=
X-Gm-Gg: AYBFou3ufJTlfZ7rQMCFad8hxe9H19p7VOAIOKUYXauZlutG7Sb6HtONGo2yAaFUHip
 YNBfaCY3XVOLQsrgnFygNod8/fDK/IbHLh6KfgFY/hdMyyoqg8lS/zLlwXvXOHhyyZyapjTzO3R
 MXDAFqssYaLlnVeE3PWUOO09gbEbJ7kdrQeamggpxGRzlNyqked+96TkXqpPWeuE6s2u+utXT6l
 LBOz+zw59f1aOJwvqOZPAsDxz3UdeeDNsqzqwgaeQR8pVx/w/W0dDCjhVSGI2AKbiuEf1KEICK1
 hHyouVxavX202CJHQ7bsmUvG3Geu+CdMe5CWgIb1UFumbZuKj29fN2AE2Z2ixxYV9b3QZIUwpVd
 acnbibQSvQQwcAyi0G49bxz/gAuJRk+vlgVEGIjVMO5h4szVYQcJbJ1F7jqbJLsXytBHPq/Q=
X-Received: by 2002:a05:6102:8483:10b0:7ae:545d:f97c with SMTP id
 ada2fe7eead31-7d03a54962emr695022137.3.1793192098819; 
 Wed, 28 Oct 2026 05:54:58 -0700 (PDT)
X-Received: by 2002:a05:6102:8483:10b0:7ae:545d:f97c with SMTP id
 ada2fe7eead31-7d03a54962emr694977137.3.1793192098370; 
 Wed, 28 Oct 2026 05:54:58 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4964601f2sm1405843a12.37.2026.10.28.05.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 05:54:57 -0700 (PDT)
Message-ID: <465b774e-b62c-475c-84fe-da4fabc38b10@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 13:54:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: qcm6490-idp: Describe the panel
 bias enable GPIO
To: Vladimir Zapolskiy <vz@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org
References: <20261028095151.1682096-1-vz@kernel.org>
 <20261028095151.1682096-9-vz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261028095151.1682096-9-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lVBze3RaeaIS8F6Br1tLJjYiPYJYvWLs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MSBTYWx0ZWRfX2x7WsajAPfNv
 YTH9TQTTV/9sUsmuDymr7SDWNr3R3cbJ4k3yKr74NA8dYX8HXx9N5WL1Sr26kXRBkE5O1XXCOK9
 nTAuTX6+KNLtHdz3fNp3wBBOt9Ydoag=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae1f0a3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T9w7Rm2z-0zB3deyQ8AA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: lVBze3RaeaIS8F6Br1tLJjYiPYJYvWLs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MSBTYWx0ZWRfX3FNHhy7eVZdO
 HT0KdK3l9d76Q998ALMhiifKWokmaurfNgzkvM3LftabMcQtzPogGbIFGFaSRQkcn9478thlqMK
 FqngP7JXdVssAlxpoZSNE3wfatFsneHjJhr9o3q/zgKsUEVKucNa1ixSyqib4/u+GmHHMMVnYG3
 k+EQ9KtZ2s7rLP7pLNGptG2xWrYIDJLO8FpW3lijN4PkcshD7c0/EQJcv1kknHwaRa9VIMjDXtm
 gN8rA/bHlPhmHl+9LcMYHBo1xnlcOZpOES/yFEnsqwsbL1Y2BhNETISZrMFdXWvVhYG91eq+EbX
 ZKVzcfXwHdJ8In34OPV5FDSZ+9YuOaa+U2uf3NcWA116aMSUXOuBxaRiZYhKaK9l5hzPDE/a66I
 yXMucWUwaD3i4f/zLjVBFoSLlmWG50aESM8YHRaYXL/k1S2OrJmXL83N1+I8777bKY8Dy1c7eIZ
 Zp1fLZUbG/aOnNimIFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280051
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
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 10:51 AM, Vladimir Zapolskiy wrote:
> The positive and negative bias supplies of the NT36672E panel on the
> QCM6490 IDP board are switched on by the PM7250B GPIO2 bias enable
> signal, which is described as a single fixed regulator supplying both
> AVDD and AVEE bias supplies of the panel. The fixed regulator does not
> describe the hardware, it can not supply a positive and a negative
> voltage at the same time, and apparently bias supplies are generated
> right on the display panel module.
> 
> Since the panel binding supports the bias enable GPIO, describe the
> signal as such, and remove the oddly described and used fixed regulator.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
