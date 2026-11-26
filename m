Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90B606A336
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WLBp88Yd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OafZZsct
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5763D112444;
	Thu, 26 Nov 2026 14:13:42 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4429B112444
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:13:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQBVYY82758331
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FDJ82FHg+x9YvhW2dNbSMIILPOdbryVsdHA8c0swgyo=; b=WLBp88Yd9Isb5HNV
 zaYDUPM66mu8uNKM6YbWhBtBapSGaI2FXbduLvTu04xJ9QoS1N/lLDryZG2C1RrP
 KQBB/olxf/kIxdYTSUbfsUTJuG3r97vjf12ToVD9m3aBbkC2zM4+qpbVd6Wb4zRU
 JIpWu/MaWjQemL9VsDnywAxFs5HJ7H5FghFPC0QqxMxw4gjeLxAq6uaEEjBZcb2r
 bijegpEiX0WWMdaY2rwmiO9jYHL77wLRF8iJzbUn2j0lwsOamXzedr4Gg6Jaio8g
 qS4pm+6gYH1enz3KNJM+sTPwhQW0If3/fX+r+KUKZDAcFMC/Y8nhC+lNrXgJzGtw
 2A5s3A==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahvqk8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:13:30 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5ecf0967947so270984e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795702409; x=1796307209;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FDJ82FHg+x9YvhW2dNbSMIILPOdbryVsdHA8c0swgyo=;
 b=OafZZsctDvB1j8Frqvk9G5Ek2uYUt+GhJMO0s8XSQoVAQmHCaQ6/DwECqRUkAbJE/c
 50RCBs3cdKbGjFp42ixZpkcoMqSKKJ9StLwIexm+mVD6BIFtfiYBVoBPb7Pivjf8tAX4
 kTGFII/pPxPNJv1LSpddItbpNhFhoEp/wsUgotUaNSRiXc/IAQjHL3OaQk0541cR6EdQ
 PSbe2DqMJf18K6e1cGo/PJ5Yf3TguA6pg3GJNH/Fdk4ZvAfX+xld4551fEFOCqRLgX69
 x4G1XDpiNFgzoSzRgds82DRY/9XkirQtQo8p8ztJcfSbT5UcXYuoRzOL/v99AAV/HJTH
 TFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702409; x=1796307209;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDJ82FHg+x9YvhW2dNbSMIILPOdbryVsdHA8c0swgyo=;
 b=W78udPk0UZAC9sTa/tojFNUDCmXqChgKofXARbkttQBbdgiK+hL+eKZpLZrEIVolbY
 PNz0UyyhhuBACh3kQzIUFKXdJcGybl3UXQq1nJw+zrqu75YsVDMcRi35F3UiFjvv+Ng0
 +IpDejXNtmZ2bKKrb//x61AKsx3pFYc+WAvTCmlHLUdkR3b+vLW3x9EnBwFlVGFSRs70
 ev0uf9M3blT8FSXCs0y6Fdd0O88l8cpt9UwT2SHdfE+L/kwFiUBigGRPx641YlRH5Pbu
 F7WMzvmv41ZqVFFMztlTlZOZYlLrsXF9C8Ul2OeB1dsmuKKqUYoXosUSxWKfTUdau2df
 ygnw==
X-Forwarded-Encrypted: i=1;
 AL+hErFp6iDUwEM4X0e6nkn1TH6vFpO1oyilkH0hjXs7FOCKKua3Gw+QeRH132Tl1Pbic1VOQ/SjxAN7rNE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KZmlYynBQKhb2b3LSw5SLv4b2iNVXX+nb14t7milcRshsr8Ol
 orEGSyC4NL7ivLR2nN79DC+2I9M0yF9u30zR4CU3f2VzxgULeQlDBRPKpAo5lYTx8j+dGaix4Pc
 6CltB8P3bM3D7Ca8SIVTaqPxyELsl12uf+c7UowhHRuyyN5Ie4O+6NXHM1ehzuebMrll78tA=
X-Gm-Gg: AZFdTZcbC2Giykd8I69xgvt4ZJTnJ/UrdvAtALMIssJhCCMSbR03MDSke7Uclw/VFt3
 gXOVYqN6MPskc0QJ5dwD8DA38BBi5uNh9N4xKmS0jqjFfajeAw1zzAY30DiyZHH90m4U5j7S3as
 NtIJE1mmsuaqZEny+F5xtbxpK8BV5rp3sUygxFGxzbQFqoKedPX8qR8Qmfmxyriq+EgVFe+wnrs
 zDYGVjx/99xn1oWU4H5EQanSfYYJQOLX6FkAMxhCIpHfETv7aGVeBPHAmfSiYoyZ7fxwrxMpexT
 NokuvDIcW36CUFPQHvz2SQmlf9rRWR2biWKMw32MR6FJJTxJoHbnmvq3NFDRszrQzAyPTl89z/p
 RdszVeIy0BbXwPIDt0z99vPVjOSKQQiKRf+1iO8qNUCHsGjO5iG2fQz7d547SPftJUEyeZN4=
X-Received: by 2002:a05:6122:25d0:b0:5ec:2394:ef94 with SMTP id
 71dfb90a1353d-5ee8ad0fde5mr14137657e0c.0.1795702409538; 
 Thu, 26 Nov 2026 06:13:29 -0800 (PST)
X-Received: by 2002:a05:6122:25d0:b0:5ec:2394:ef94 with SMTP id
 71dfb90a1353d-5ee8ad0fde5mr14137637e0c.0.1795702409150; 
 Thu, 26 Nov 2026 06:13:29 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cc257sm9124759a12.13.2026.11.26.06.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 06:13:28 -0800 (PST)
Message-ID: <cc092fdb-67f7-4261-b450-d3bcbc16bfe7@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:13:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] arm64: dts: qcom: qcm6490-idp: Fix the panel
 reset GPIO polarity
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
References: <20261126134508.320700-1-vz@kernel.org>
 <20261126134508.320700-10-vz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261126134508.320700-10-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PZ-Zt_pkVgc-eW8lHZnPFYUe86ycAZ1g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfX88OnPoI11b0i
 uDB4QlAfP6+LEuzrlBAtU/WvwjbA2aBAJ+UCSFdwvwRGf6Z7kMRyLYeNnd8z29UXqoieOZpbX6v
 siyFvd3UJCB3L+afDWjkBZZ/lZpsphA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfXz9Wbi28kqHsR
 ZZWp6TCSVIVT2i3RF6azSq3hSkxaDkSJ5VFtDp4ItinZOc2GJTwoMrtmssUUHigNFn7Q3ObPj4o
 dX4tbKMk1rjeNfuIgtZZeOVfGJcDr3Rxlx1X4B4t2Pn0Ju5Qe4YZS4NpJeFqbdWXfGSFvhATCWj
 C5TuZAtLOh7Nxpf75Qd5azIk+wUvsRtUXr+38KgvCQbsG7AOp/wZWseS6rwIujJsGQSP1ybitag
 JT3gGusTno90SVDYg00TDHkaDkPB1/oS5M3nxDoYgL5/PHEnpmyEEZ5vcitsPP9oJVIp9CY3JHT
 orZg3r3aqHcW1CO2lNFJqVd/hkkVPngi0YnieT1MnP0ECWyFsWaVBJbG1A1y6AHRTonXnnZihT0
 q5QQus8L6mbQvcP85aElmEzkunIxiRdqvPDkGWZgsxOAdd17i9+zWudjnJn6Z8xIHfzX2uGD/+A
 Ro4BCw6TxXK4Y3+5zvQ==
X-Proofpoint-ORIG-GUID: PZ-Zt_pkVgc-eW8lHZnPFYUe86ycAZ1g
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b083e8a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=guKfAgVxrzOWnIkQY5wA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260055
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

On 11/26/26 2:45 PM, Vladimir Zapolskiy wrote:
> The RESET_N pin of the NT36672E panel is an active low signal, however
> the panel reset GPIO is described as active high to match the inverted
> reset signal polarity, which was assumed by the panel driver.
> 
> Now the polarity of the panel reset GPIO is enforced by the gpiolib-of
> quirk, so describe the panel reset GPIO as active low to match hardware.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
