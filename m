Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923C4CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE55310E4E9;
	Wed,  7 Oct 2026 07:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IP25/w94";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIvsnwSH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E381610E4E9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 07:12:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974UCpP2774169
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 07:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3GX4DX9WHgkoCjexscTyxRsp0Y9v+fPY3Ro9VgKRBTc=; b=IP25/w94e84gY3+7
 bAA0FSOYhxfaZT80uGMtUqAm36yFYmE6tYipp3D8zrmSAUXrpx4enx1uJI6qg1ta
 hJW+JeVpJtgLdGFpVpnT+T/OBUz08P9h4fZkSD6xvd+vKAoNtL3WCgnsgEQn44fT
 2WSB5a5sYOEDR+672T9xJPdddEmgsLlpPaUtJtS5fbw1O/j0Ipjaepdk5D5IIu/Y
 TeP0BxnW2O3TN+na6G0Or2m9oO+sWABZXpsre+Hsum7UAJhp+c1dYqux2BzgoL91
 PUIbC2n7JRwpANKNrCGRH9calDqkNfaizDud28fIJ0335JXW1t/CciCxW3xT5Fwr
 wh1i7g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541uk5nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 07:12:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so7089254a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791357126; x=1791961926;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3GX4DX9WHgkoCjexscTyxRsp0Y9v+fPY3Ro9VgKRBTc=;
 b=dIvsnwSHMqd5Urk41U9EmykY656nLNnzvw01tquSuFN8TGXORTFJ/2SO5m1BCaBdx2
 OrKhl+LCcOHvyCrXCAQp6X8cgu5eVW8HI823QCUQqGv+uM4foKbmcL2pu/Nko+UDIVnb
 gyWMQyIAvMMnrnH1Ej8FHYvzuCfuSPmNHs60HQPwRMXQFWnmB5yHG7f0Ss6EaAcTcn8p
 q67M8LOnVz0FdXnA+PnGJQPG/Vx417Ao8WdcwpMkUTmJh/rgaMPqOHvzgtr9AA6grZX/
 y3LQUeSNl2mqyKnVrOog5L68vFhv/PJGxtXbv+Mw6Yci6HZh+nFzOk+/1iE5Tko5JfWy
 z7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791357126; x=1791961926;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3GX4DX9WHgkoCjexscTyxRsp0Y9v+fPY3Ro9VgKRBTc=;
 b=AZmjfqmYcA+rj13oFmb8QQNjSAWBVUQX2UY/cdOs+vaK+X9Pl7D73hXH65Ftru4Oe+
 zlc+3HARcCgIRK4GaYrOOWawErKi+Mbf4j8mWNaPiTFqCI2H3qq1dbmJi+8XCjaesuA7
 3NN4Mb80ajRjIFCSU3+BRW10RDfaoKxcmhJXd2VoeRdX0GwbNDdccr3VQZrFJufFhBEP
 51XSdd7gaQkRmazWViYl0YixgB/W35SW2viNSqXQ9o78ZsdQzI7SQiZiKgAgBBLQatKl
 7RQFcqmx2qrE6vTGaA+cgcfKwY49DX3V8wr0jRlh3p+jlBMYabJP07ZhUGWTGe9TeZa8
 jIXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMgHHK3JqNvQ5D7iGt3uExn/8eeiiSxflHNmHdtZkK/IGbuuopILU2aeg+MA2YGChHTdkRcVnLcaU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJEFjaPRcER4rSBa8pLXscciBmAIMpJtsXYqg8ubc7CAew+bSln
 YqcObHjUaS7+B0kro6McrngpAykzEl31IbgQJcjfqr+ty2RfjQ50C1tFqmKMg2zNK2jAglJgDg5
 jQVBofRuy7nNBRqGCAGRgBrmPFnlQ89sNlf2SYEOgXod0M7QmnRWSTB8kFQUtvjpnpfiswYI=
X-Gm-Gg: AYBFou2XXEQ2A0kQxZghDOmip15LLs0imw6UxRDUcqMu9Hg63Tz3jtJc4nAkFranFeV
 5FMIYLOqujgEBviHrfkTvkH/hzo12/muhyOl4nOoF6H44FpSjv/7zWS72uRlYOn3rEVsfZUZetg
 mzrsY38wZ+FwOGzyMMmFd/mVtnFl3aHBOKSP5lejzErqqOBVa31Cduaaz5lbSsmiRDXPr1ka0CK
 rTm8k/sZMMqTyOu9aFwwZx2Zcbx8l64Ge60uX58AD5vxmPRZHZUhM0wxBehDfnxjhsn+wW8HdN7
 yVrY1RjrrX5+jKpwf61vphbAui9WjB+Jjg92dvcDyDtckS4eJ7jMpnTJEMF7ouOkc8+FZpLerqY
 lcCXVrNC/7FZrEM6f8h4F3aMqZjEDO0eqCWRShGOx406qZBmHwXu/FgN67b0NPvh1QRk0CWyls/
 nN45A+TDE5Ul/GMOmlgGt09RF0+24=
X-Received: by 2002:a17:90b:3809:b0:3a7:8350:3faf with SMTP id
 98e67ed59e1d1-3a8a17f850emr1227721a91.18.1791357125520; 
 Wed, 07 Oct 2026 00:12:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3809:b0:3a7:8350:3faf with SMTP id
 98e67ed59e1d1-3a8a17f850emr1227675a91.18.1791357124810; 
 Wed, 07 Oct 2026 00:12:04 -0700 (PDT)
Received: from [10.79.117.106]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a897a22610sm3843683a91.0.2026.10.07.00.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 00:12:04 -0700 (PDT)
Message-ID: <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -ROFlB7FbE-er_o88tzYvpQW9RCaF97a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyOCBTYWx0ZWRfXwnCKmeroUZMB
 WrW8EZBX5ErGgmp1QmSJpwT/OYXT/S9gThNe9eGILJJwmd48lXZ0LEBfFUuukLf+Rwqn1W4VmJq
 iVr5pztDNqk5jq+kK4AsrOg/kHkxiFs=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac5f0c6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=yMhMjlubAAAA:8 a=EUspDBNiAAAA:8 a=jx5OK0JlhDPw0se3NWkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyOCBTYWx0ZWRfX9PVVrU8ZpFrf
 tbRJ/wJWIa+Yi2NPAqMY2xkf+NmtyICyJ1SCoBjArXrhGonlGuWp5FDxKdg0GHiLLTcQ4oigHVH
 B2XeTfUUTcf3O3OS/7YpfdVcobFbfKXscME+JsCBf9vC8bwsuLbxCeU49G1huKSl77bKuWS6OEe
 h2AROCeo/auob8yoX1n7Kr0yoDBQHsoqj1PWqLC8V+iZEGSWkEitNr6JGE36q7k22pM+mhkKgUE
 imRHalO1leDm6Uo/hFgrErFx30wiNrCdbwGnykko7SV3ElUYk33ybcvVYIoHIUskeAN9s67WyEM
 l9o3FFmBT7AcHkv8JZvYsGAT+Os+ZckyD62878Smjo7pETvV+7IpynMe6fVA/RB6BAFyl926RI5
 7WvcmV8HDg8U5fbDOyat1j3el2NqOVyb1oU/elgtdCL440UVso3CO8unUCKQ9xrfBdewSgHHsXT
 O/9DNQwCFzdWgmzZmIA==
X-Proofpoint-ORIG-GUID: -ROFlB7FbE-er_o88tzYvpQW9RCaF97a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070028
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



On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
> 
> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 121ca557ce1e..eecc00e2a718 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -191,6 +191,7 @@ properties:
>   
>         - items:
>             - enum:
> +              - microsoft,surface-laptop-8-13in
>                 - qcom,mahua-crd
>             - const: qcom,mahua
>   



Hi Krzysztof, Konrad,

Before review, I'd appreciate your input on the naming.

Surface Laptop 8th Edition comes in three sizes [1]:

   - 13 inch:   Snapdragon X2 Plus (6-core), UFS storage
   - 13.8 inch: Snapdragon X2 Plus / X2 Elite (Mahua), NVMe
   - 15 inch:   Snapdragon X2 Plus / X2 Elite

This series adds the 13.8 inch model only. I named it
"microsoft,surface-laptop-8-13in" (mahua-microsoft-surface
-laptop-8-13in.dts), but that clashes with the real 13 inch model, which 
is a different board (UFS instead of NVMe) and will need its own DTS.

I couldn't find a codename for these, so I can't follow the Laptop 7
scheme (romulus13/15). Could you please suggest the naming you'd prefer
for the compatible and DTS file name? I'll update it in v2.

[1] https://www.microsoft.com/en-in/surface/devices/surface-laptop

Thanks,
Gopikrishna
