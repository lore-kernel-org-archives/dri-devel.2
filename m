Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF91C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B22210E025;
	Mon, 21 Sep 2026 06:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGHpVfrU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JuzSjmQg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6711710E1E6
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:57:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L4Jmic002450
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sxxN/THrSyRW5wXS4Y0iUrjV5rVX5I/Bsxrc5z1M8nw=; b=BGHpVfrUtTxhFFtp
 4B27Q2Ji+0WJwK/KVGNyE2Gzik2MkkhFo472YSf1+Ykrv7g1LqSbw9yhzRixDJL5
 NQXACOg54oXeU37fMrFlE0vhB5MVBdyeX9qxDZytw8cvKjgvP2T5D9L2vziWdBP9
 nyquOaTjq591p2UxjCdD3LOjW9RitYDhY3hy9lHi06VcBL3pbHt5lawtD7DB1oIN
 YybbmHWpnPEn1UYG7EteILBzC05Zf0ui4myHZnS5Smbqrb0mDNuNwUWVTZqwHZp2
 Q4MqaqoWhOJOLc7aDWGaQGIKuzlK+gkLzpbGHJCwkuiDejNomLRaGuDzKD8j5ZSc
 vIyyPQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5gg1j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:57:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc51591102fso3967098a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789973826; x=1790578626;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sxxN/THrSyRW5wXS4Y0iUrjV5rVX5I/Bsxrc5z1M8nw=;
 b=JuzSjmQgTZ1Z81jneIRxU5U4RejoeckG5WmsleL1y1pybb78iE1psFQVHeG6M0XTSb
 v/bh+EcdKbpSRoowXDqgD6pMb48MXWPh1iJrJgvoWzPEPl/ip+HagZtdZ3XUn7fRKIvy
 0S1ewbZ+GY9HAHvn9CkS74x5b8PGLKe9+zVGraopNqVT7Bf4u2FD/O5TFDqRJTC3gFfz
 5jalRHEnihi3LbE5CWXkTbCq/C60jVQFcopy6yWm1rod+3897fMF2zj4FdBv0R6mCPll
 3mV3kiRojJliU1Is8HW3giXw5+5yUSxjNoXvpVivQzdCvOVkpQesYjIPs7GE5uk/Yucf
 zg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789973826; x=1790578626;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sxxN/THrSyRW5wXS4Y0iUrjV5rVX5I/Bsxrc5z1M8nw=;
 b=t6yPZVtsTUwN3x1xnYpPinq22rpv+8YlAvhL+zu1tKK2mZ+5NKj2EI0RzVvYD+5GCf
 KRPNwyP4zd9/eydVunj9wU9g+NGkR1E4NUgptQ7l0oZ4DVksOxRQ/76JRmUfvvtF+EfT
 XJnkScXWPIoTz6dLXnd7NO2qA+OFA0lkH4ng/nEbo+lX5xjkfEodgneQX7R8SqKopeFU
 rKyfabYIPduij1sNfz/EvIZKe78p3UTzbOnSHUxzX2bE9LAzDMAfX/TYQV2NDwOkDSbP
 7KbKdoQX0zoNUkhlH7dX4aKNnDvSB9hbQyRiecaMLf/kz5Veo9rZ2meTeY5aXLDvfSSS
 6Jtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbAk5yqqUSwe95e+iEF/u5lZ8pGa8i/ARIe2yNpi2a9xgzm+lOTTj/GSeivpAnC+89MMASN5MT9q4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlXqZg5e4NltLLjcVgkaIEAnWazYueNjSKcy7xFtw5LQai2Toa
 GGwcm1zyafCqL9VM8D1oCgK7ZHAF4aBSC6QbE3a4d+5gdAuUdBqg35ivNDYUq3eBU/zPxsirbbX
 8+f/dmJL6mkAlvnWwTryxrdNVfW8rQLCFvSSEe3GChF1ixEZOTIS08cG6Lss+rrggsfBftZA=
X-Gm-Gg: AYBFou3iqfKcLbpp3lAJLz5iD8031FU/agXJ3heKry27ZMRGwsN2sXn1G1gYxA9YdDI
 CNfw3BVBcD3DV4SCUEwBgbFXZ6IPIzUdLcRiRV5Onsl1lSQkPWv9/l5rnbDp7lKZDlhe+U7sb+F
 JES+Fs74ylwTSvOxILOzfKLxVEdXI27S87HM1WkcdgR1XKgLUwIGH/QKCU4BsbQIWgWXUvuEpJr
 VCOoma1LtscTeH1JkM8JWUamzmOsKhIeWCSmWiBf22wOBaqVvzp2oNeCqAAq83y33eeGRFWkoeX
 PxhmXZI7ivP2rOB1CWLANrn8AdAW0AhpJDeODIs1RBhFVh8nOb1DoJ+PXqB1MluW13+ICpTiW/7
 p/rHDH7S+wdUBJd2B6llSmiOJ5MS7vg==
X-Received: by 2002:a05:6a21:e0a2:b0:3dd:a196:9074 with SMTP id
 adf61e73a8af0-3dda196a6a2mr8758760637.62.1789973826132; 
 Sun, 20 Sep 2026 23:57:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:e0a2:b0:3dd:a196:9074 with SMTP id
 adf61e73a8af0-3dda196a6a2mr8758747637.62.1789973825773; 
 Sun, 20 Sep 2026 23:57:05 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.232.197])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c33186490sm14551450eec.18.2026.09.20.23.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 23:57:05 -0700 (PDT)
Message-ID: <a5a4abe4-17a4-4ee3-a213-a9e136e31648@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 12:26:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] dt-bindings: phy: qcom,edp-phy: Document Nord eDP
 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar
 <ritesh.kumar@oss.qualcomm.com>, Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
 <evvgtf6b46zqpolvybz6xfklakgoyv2llnvawrblgz6np7viza@gtmqflkwwmgk>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <evvgtf6b46zqpolvybz6xfklakgoyv2llnvawrblgz6np7viza@gtmqflkwwmgk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab0d543 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=u/G8viX4uCBxjZ048G+IxQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JS77pFG_HBBnnPoPU-kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: aRdeQweXC5GzXZRrMMf0ut6YmRAZ8iy5
X-Proofpoint-ORIG-GUID: aRdeQweXC5GzXZRrMMf0ut6YmRAZ8iy5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA5OCBTYWx0ZWRfX5ChOXJ3VtMdZ
 JbIgu2hynt9ddziCj/+Yvsjpn6b4o2zMcEnudhZueLa/qVZwTrr9vJ2dg7S7htjuEZBSl4JdxEK
 vhURVvn2TX2FfHsWqw6yBytAjTl0jvg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA5OCBTYWx0ZWRfX1+XZ+mo6NPFt
 UU8QZtSzdze2z5UOwJJ1WztumsPmaVGDajHhE+8LsFBn1he8I9lqYj5Mdz7K9n1y8/9ulMpdH2+
 9FfazQqqqf8/zh+mmV1IhVnp5NX9A0VZXwD/JWfOKQ8ZEqvuCNwaqRbGVQNiYuVnVvySpgzw8EM
 5U5x+dj57YQEgjZAhjDpLSFnKzBy3Bao221vlLvkC6oLZP3ASGWu7Gq5v52JTRy8PdP54t5AEXg
 Lz3nCu/HVbSruT1+k7zu4oL1Hgiuq7iJxH3MOZnxkyExtJNI66cRCqjGShDjIs8JywNJ5AfxaSD
 WRPvqwN7122uy0wthv3jQsUSNtWCLObIKtNQzZUSEGCZKaTNfJDiHIAUCZcugfcF8AcGvuirzh1
 YrRDuDct3ufRkvEaJEF7OTnSZsUdpKBNOnOss5cs+jCRcu9dRm5F7FA21QC86vNXuA9GITXzKmf
 tPj5zRtVvKs9fPmOZaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210098
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


On 9/14/2026 4:59 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 11, 2026 at 09:06:32PM +0530, Nabige Aala wrote:
>> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>
>> Add the compatible for the eDP PHY found on the Qualcomm Nord SoC.
>>
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> Does it use ref clock?

Yes, it is using the ref clock.

[PATCH v2 1/3] arm64: dts: qcom: nord: Add display subsystem nodes - 
Shawn Guo 
<https://lore.kernel.org/all/20260920091930.2215803-2-shengchao.guo@oss.qualcomm.com/>

>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>> index 0bf8bf4f66ac..91d7a5c8e19a 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>> @@ -19,6 +19,7 @@ properties:
>>       oneOf:
>>         - enum:
>>             - qcom,glymur-dp-phy
>> +          - qcom,nord-dp-phy
>>             - qcom,sa8775p-edp-phy
>>             - qcom,sc7280-edp-phy
>>             - qcom,sc8180x-edp-phy
>>
>> -- 
>> 2.34.1
>>
