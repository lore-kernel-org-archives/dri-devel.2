Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE3CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0131126DB;
	Fri, 16 Oct 2026 09:09:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231E81126DB
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:09:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G8lEED1761574
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I2Y61SbarNC1NRnPllqbF3Qp+uuYMSjYKhtAVsLZu3E=; b=ARk50zr6m3Ulzobk
 Fy8URqJ1oVGMLtdbHqnYnRv84JSNMxzau0MmfzbOAkygZW9vRUd+AscGgJBO8bQl
 +2ci70X87BY2ea2bxh9Y8ThaXS06+7xA4x0zuTlJtJBLfA17NeILaC6JokLq3AYg
 cSKedk95t2G92JDJsOMPIstIA8C3eSfhLbAEXgUDbsHrPdu/klGgnElkogCh6JD+
 CSM8Dd+99XGmrxq5Uitk9tvNE9e4MNauCm6Fy3Uy3a8EtNAbga9TirOKGc3r0CnT
 viQM9o/NbaO1NWYSP+kMXEsIU2fYfa8GiA459iIgtsqrAGONl3NfvBF32zrlXZwr
 5bMp0g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yr7dk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:09:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93edac58b24so93998185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792141753; x=1792746553;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I2Y61SbarNC1NRnPllqbF3Qp+uuYMSjYKhtAVsLZu3E=;
 b=T6F/O4fH0rWLvxoc2QZuD7vrCLt80DaWRv+JDzSjHjsFVgl0zu2C+dl00D3+gk5ZN6
 hJD8TKv71dMUd9ejh0kbRxcU9rJG5DCjz0yXjBtdZdE/AMEJrFdCLUxU2XvEIVoaIfUQ
 F2utxnOXUq+kuuFD1B3XiA+D5SP1jSAEbtmwdkLVZQFxURrqO7iCicGHKMZV8qZcX/Vq
 Aj7BVCHMbCbj+NeG6a9c5qieNUX8bX3UjshTBGQx/hnjXzm4x4z9OqOrvDNB2OCDPSTy
 Mvs56P+9E+l3VaPnEDFFxvJT9nkikqoBigl69xIp7l9IWjhGzw63Js8mBrUQzgT87tME
 H4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141753; x=1792746553;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I2Y61SbarNC1NRnPllqbF3Qp+uuYMSjYKhtAVsLZu3E=;
 b=lLejbn2dP4vyFRkriTpuhGYe5//uGYarbLT8LJoKcWtbejoW8/cppOb0b1+g0Udbrl
 4Qze9FMYUlN+6ou/HdYvmTVRJ8ubN4nQDqkJ+8lHegVk5IJrA0FFXiIWq2tckfjYrna2
 If3mHRfgB2iWWodp+Ws2qxAMSFhZF+PDKdNuxotEcsJ5tNI7NSXQmjGiw95xTV9FABmC
 9mUdHQcjftJcIaTcUoIY3B5BeZNHBJHG4P6Efn35cMtESxjDGfdowih8seU7Q1NPx88v
 Ucsj+3Wy2UfSwwrSo3ij8osrvt0iP7HBuu+uUXMZQZimuDkTDXFvkSdvuuiDaoMn8wx1
 tGtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYZW1KpsyanaerpNuDOx1wE808W26TzDCPxdYY/Edkdgb1t+Izkk++aZcqyYKIktRayJcKAzcij7k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKvR86yylUXH4jYbGilsEqQfBp4MBCPgtQeu+NBT2vPhPX03B8u
 DujpxRf/WhDRji48x4cEWPC4EmRnBInUiu7NgAx6fmxbdw7iilvbrd28+7G8H4eoPwoBicvPRzT
 gEQ4GEymLvtjPogXkBiNuhGzisTZAGT/jY9R6ClrZxGHRGWosewwPOKxqekrKMC/oaQJQxfM=
X-Gm-Gg: AYBFou1d78ShKFFXFq4SUk2F1Ueel37C/1ELYYThDwNLoc+YPo+01/+X+SVUA5GwAj+
 GjcQeJfp40BDlYWbO0cWwRjPlu9/EUocY8aI/+ZlbpeEFz/IdZGf8Cz3HvwmsyZa4QVOfNeArXQ
 oGBsv1KYlpD5xDr5a0HZw9tN5u7m+7QYoTm2tJFL+kEuyyFIQmtDgVVr2rKFF9sSSsGfRDFma1e
 cZMFswSnQmUjHz51QmPiydD2xt0NGNx1Uk5LQRaBxH2C6hdQ13VWU0NUgSfdBLHjEpsDDB9R+oF
 6GN4REjYfYqUNE0Fmx93KEpTxrneqAx3g52jKYJFjjSP56ayp8HV3yC7xThcqmy8vKcuocbNRCE
 rc8cn2AN/VcBNaYJxnBmv0w==
X-Received: by 2002:a05:620a:6506:b0:93e:508b:7800 with SMTP id
 af79cd13be357-93ebcd29970mr3675062085a.0.1792141753536; 
 Fri, 16 Oct 2026 02:09:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6506:b0:93e:508b:7800 with SMTP id
 af79cd13be357-93ebcd29970mr3675052785a.0.1792141752034; 
 Fri, 16 Oct 2026 02:09:12 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091eb256csm53638266b.78.2026.10.16.02.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 02:09:10 -0700 (PDT)
Message-ID: <4faab1aa-18d1-44ec-8a3f-79d732f7d0b6@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: kaanapali-mtp: Enable
 DisplayPort over USB
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
 <20261015-kaanapali_dp-v2-5-c15cb83d9140@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-5-c15cb83d9140@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: doDdGIfR9VWrTeWeR_w8On8v7RHthehs
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad1e9ba cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=8oCPm4Ec_qhLfyN9vMMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX4IQ34p+3sn6L
 lZqodhH5oAsxW+gpn4dyTOR/BcFkTJqydadIESv3a71xeQpSREKVvqGHC+YgmcVVMLhjRpd+HsS
 CdGhC26v/pRSIxqrWDCSdKujevA18VQ=
X-Proofpoint-GUID: doDdGIfR9VWrTeWeR_w8On8v7RHthehs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX5+YKzAGynXl4
 UUQP3JaybaTPxe/8OYVdy1G2+pgIW01XPSY1gsEor3dIL/YrNWq4s53/ybwqSUsTyx3tCmpONRt
 Hkbo6O1Rklt08FeeulqWiC1sO4IiMpwA8hpb0xaVhhLFtpYEpDXInfRshjpZ8re6gsjxgCfD2xs
 DaXSuXdfK0hkBi/VrA9Oh9+GnrtEAuJvrrP55CRQWwrI4do/20O9BRWtn9QTYHOWQaVR1mA6bme
 EUvO8XXxp9OHKCrjcQO1jNYSga416WU1JTBOrjPvJXPppclEKJcQQ+qY1lSg6cNF2DJwEriC0rt
 5ZsbQQk6Jyvk1t3t7nrtkDepCktfWrsHsJL+xyZnC8BhF2r7QLV7vDUGFrTrFRHgUwsJ39+t6AM
 94nQYcC6uycC9TcrLWh3j3WCjJyUuoq1zY7/s04yMKl4gD73ayhNpZqr19/wOdSwp+HBElMVBPK
 CJiLVn1lwNw3k2/Z2rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160036
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

On 10/15/26 11:54 AM, Balaji Kalkonda wrote:
> Hook up DisplayPort parts over Type-C USB on MTP.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> index 22eeacd7aecd..3bf7baa2bc82 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> @@ -1017,6 +1017,14 @@ &mdss_dsi0_phy {
>  	status = "okay";
>  };
>  
> +&mdss_dp0 {

Please keep the nodes ordered

Konrad
