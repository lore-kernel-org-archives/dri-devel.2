Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B0DFEA83E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E18110E56E;
	Wed, 25 Mar 2026 11:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BdpbJLQT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/tsEJGa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D2F10E56E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:21:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBGHKD241589
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aTdLSXt1gffIHU1hMmW9BTasufvL9YE1TkFyszLzfa4=; b=BdpbJLQT20mtGYWs
 bKOF4GG8EultDAccXuhIU5O6AVzNCXyYI6SdU8Dy/y//J66+sP7wZ09mMzahKgPI
 m8Lh3Im46u4klRzIudeTElN1LFUBN9VZe5k1Ogk1L3308YNkjnGPYi9CrB06CflI
 5KnGr7KuxEDhGL/ae+CkpQ1zE7yOUhcvS+/em60ua2zOnjnWtlq3Bguj1CxSBcJX
 oLEktw+uN4SgSRyAOoIkk4Zu9xD8i5gmbmgkaO4YDYqNcA04udR30Qcn2v58SMos
 PRfE5pEzL7cA3BqunC6vjfzvDNRD9GZpWGI2AS1WevscIgNyI2nSD9XGOjfLh/WS
 ZxWh8Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4cvp0fyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:21:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89cd0f68ed4so358056d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774437685; x=1775042485;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTdLSXt1gffIHU1hMmW9BTasufvL9YE1TkFyszLzfa4=;
 b=j/tsEJGa1TpC7y7j9SUy2AQc1BtlGJbGr09VJt5kcKcz8o681yFpZqBtjMX8wz9GyA
 XMhdKVwP3KMe/XxZz29fZ+yhu3NznsoZNBil169droCg/wIqTTLYJ/6iLA1Uzx3+HC4M
 UPl1wFPnOPSxG1ODsaqwk4Deab6TYBsjL7L0GX1CfrgmY8qRUFmxStktD9NC+m1uJRp+
 qeCsIsrRHS7fyV/8jRGHnz/fmdu39aJwe5Vuh54JYIsI+JcYaDMoyFYHhBoUUeIiTedF
 6fFpKDgkbuvdfrzW6LsGl+EQHpga6seRCf+PqBRVCAdiM7EnXNiuwtxUoL+tPz+q9GRM
 EmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774437685; x=1775042485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTdLSXt1gffIHU1hMmW9BTasufvL9YE1TkFyszLzfa4=;
 b=cRQwiJ0gYEIF98NOIMc13Pnb+e4Bc0pbpHiE9coNpin06UrVivVAVExp7QcLfDyv2r
 51XvVuHi/PxH68/tWvB9BfWRCTwpIfYGKbLkH+B4JeCceI8HzplpgQJ7xrRGLoogh2EB
 OIm9x9zBXf8W5AV0tdYJHwE+8sIqHVFX8Qg7L5nUx7Vbq/Qx3JqYeHuV9Fj+ERSHNGpX
 ItUHOMsVmvGJ9svLXAR9x1nq1VB5ZjZ1Vt9+yBtNTTz9X8z5FV5jlMgDJr/sRiN99h4U
 R8MwFyd3TPUi+4XBiNRZNoX4H600P1p0hUYd5aCnyN9yZoFM5IWNz7NfCS/q8jjVs5wA
 k82w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwPJKYcIDzCI3ZNoVOhamKCysdwTTvclYzcRanKNkG59A+KuvDJDaVmLmBJc9i+yA7vdEehwG0I3s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMxc72e2ziSwaMcqLOLh0UL35BhBLJpN734P5VJvPatxMghfHq
 sHATXIiCXu7jUTwtKJu1JkR6grvVzP3yg1sLJlrQBcO7Gwnae8pJj1FSljEWzZttV4TDRNEzJ1B
 yzQU2lY/emucWvhpVlWklxvbvn6GuSbTPmGlEPkFa41vOHbeb4roQcfWMCliXPz9/gbLv8dU=
X-Gm-Gg: ATEYQzwYAL469KmI7HO8NWsnq+Z3Gv7fZViEH49wnpJNAWtqVcKrK8qbUXM32LG7gTJ
 yPlojc8jVfxN8LjdFBAVpKa2PWLi6/MtN+tnd4+9OsgiFtOW+ObLQPmK3gnJfgShBnIeU4jnm7h
 7HXECMy4BJsReq2U/eJPuCJ/fGz3WLegfPDIRpLVNBaEt1Utqk1q1m7zG7P/VC6gtHfPRKDwTaK
 5NUoSR6ROZLbwUzVGHe5AkM5wXZKBSiQyks9y9jZOO0iV/U5nF9ElnrvxQ/j/QTHxQkQTOxxC8Y
 3ldbPTZkxYF/eXjTR4aia8D+XWCM66nLGOloVLJAZmD2zb2dxFpXSRiqLWRzVJmHTH3aZJQGFPD
 ics2SvFycqlMAW473UICw8T8acUX/vbWF+m8Ic+K73bykXEw2Rxbi8u3qDPhqDLReuR7fe9f9Gb
 NYv2Y=
X-Received: by 2002:a05:622a:4898:b0:50b:2bc1:2c5c with SMTP id
 d75a77b69052e-50b80cb7bf5mr31274091cf.2.1774437685331; 
 Wed, 25 Mar 2026 04:21:25 -0700 (PDT)
X-Received: by 2002:a05:622a:4898:b0:50b:2bc1:2c5c with SMTP id
 d75a77b69052e-50b80cb7bf5mr31273691cf.2.1774437684776; 
 Wed, 25 Mar 2026 04:21:24 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b996169cbccsm169471166b.60.2026.03.25.04.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 04:21:23 -0700 (PDT)
Message-ID: <4a681725-c8fc-445e-9772-6b67ab948172@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 12:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] arm64: dts: glymur: Add LPASS macro codecs and
 pinctrl
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, robh@kernel.org,
 srini@kernel.org, amahesh@qti.qualcomm.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
 <20260325035338.1393287-5-sibi.sankar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260325035338.1393287-5-sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tDcCONX8V4LND1xodvcEPUAT_02J7Bqn
X-Proofpoint-GUID: tDcCONX8V4LND1xodvcEPUAT_02J7Bqn
X-Authority-Analysis: v=2.4 cv=Q73fIo2a c=1 sm=1 tr=0 ts=69c3c536 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6EmWahZ5WOOBv7564f0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4MCBTYWx0ZWRfX5iOoNksEvE/5
 0OdSqrRuPYxW7glJ3nBGb2IOZybebeWrnceSEAaT3P4UFnRuIp4/sQW3hchZqF1lG3iSCQbVlsi
 hQ8boRnU11nFsP3sy7GfUpq6ncscX+rsrfTBgJhYBdGgLeGwGURlFINfsr6pS5tob5U+zlE/UNa
 XP0up39sthSvgUHQc4glHJ7/h8TY00pXL9Y60GSUiCgsnIpNmrZZDpnydCgJtQMr+lj8rR/lNi5
 JBfbqQeCoDDUyWcJ3nRHVN5VmMfCqNY+YpdticxShtlPJOG8yqnhol6bn/HOBsyPkCAS8nrU+dr
 NKFtwFLzgaKZw8axjTNmosIMWf1bg2snCCQKgL6m19EmwFTCw/RPKXo4FSCEaps0qs4RTJ0WVy7
 ccsdr2W7HNU+SD9Sd8kcg2V/neoVZ/W2EcLzKnhDx/NCXzCGa0oUEMrBQ/edxnGSaw3RBlfy9/i
 V2ODERrpVNiozsubChw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250080
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

On 3/25/26 4:53 AM, Sibi Sankar wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Add LPASS macro codecs and LPASS TLMM pin controller on Qualcomm glymur.
> for proper sound support.
> 
> Also add GPR(Generic Pack router) node along with
> APM(Audio Process Manager) and PRM(Proxy resource
> Manager) audio services.
> 
> Co-developed-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
