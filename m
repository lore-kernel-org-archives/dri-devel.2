Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B618CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1EA10EFE4;
	Mon,  8 Jun 2026 09:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTlG9WNl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLRen21j";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82B710EFE4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:05:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OvGc2833009
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 09:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sSSvva9xyhbhw+Xk4pnwYk8T29hV+yUkpgxYP1wpWEs=; b=jTlG9WNl7JLKg+Fy
 bUqRmnmhWFVi5PBAz47hJ81GdasdN2AbDuyOZZ9MDe85ZPVC0tbD6zTMx56S02p/
 TaAKmX4lTtgPpc/l5F9IKBJFGMU8anCwQfEL23qQRKNwE92pNriR+YICD7uh1uvN
 w/37ks/smnTCDgJSQMIdRJtoLGMoRKt7mBSXpW7Vd2ApRx03m5gd/nDj5EQ9YyOu
 /ZcrIUJU1QlDLyM0tEZ/VCtApj1lfrdgOsI23+X6659790WiahjornmxuqfwekP7
 LD6rpidN7ZXcRDrm28E1zdwCssmV0ZXM/92a1KButn5ylOjFBTtoj5oTLY+pyTz1
 hU7BWg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmrf1gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 09:05:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51759082206so12464901cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909551; x=1781514351;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSSvva9xyhbhw+Xk4pnwYk8T29hV+yUkpgxYP1wpWEs=;
 b=cLRen21jlooUdRMi9nW1CPSOf2iuydxpU62W47lsjMI30IHG4jbTDh8ho2MEPIv6OG
 AEmcecbisGI3RSMCqBino1X8KA3G0fnRF3y4cJvBBadj0S67EdWiPd7kU+ZCGN6dzxAF
 mb3EE7PU66cau1E4STZIc6lDnwUgPt9Ti+zH+PYK/yzHc6IVCs2Dv6eMChIpNRS6vFnF
 oWotsz1fWms4xM005XgCJ5E2z8HuD8vN7XeXPyq+5+qohsBHlG5Vc0H4/qxyJ0ygBcRE
 fzxr2PR/JuxPfZhUlwG9NekVnZsMRFC5yFlh8yTlKGW82H2uwWFGAH37O67axhibWtzF
 hhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909551; x=1781514351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sSSvva9xyhbhw+Xk4pnwYk8T29hV+yUkpgxYP1wpWEs=;
 b=JfmMncsV29mQ/4hFD0t0XFpY0tOXhnz7KwLLalImAAxSilzeRZYRbpatmB+qJCO6E5
 isCk04zIt/DFCEAd7eEJqMuiEJdgQ4TBpVUTg2O99dRDfS8beFjluHRkkjPE4SsHo2if
 Lh6l9uvdktrL3mD1Fk/eNxoWB+r9I9WUk8LDeCDURTxfhX9IpOlHCvXao+F/exh80AGH
 hdr8Ljie2uzvS6q5wsBehg5uHD4xdnqOpPyVZLRTFOQHJlj0JOr2+G9apiGxx979Iu8O
 NJOZBZ32supnRi2j0lhTFRB3tfvjB3xucRyBLYiw3i7p0+OolmgOgfGmfCXiv+/60Zph
 bmJQ==
X-Gm-Message-State: AOJu0YzO1XoA/nm/mCueArIDJTvNVEWJWjoJb+c6sQW25wk+ykVRwBdq
 Hqu0o6Kiuc+7awVH1lZ9Rcq1TXKwVKZL5mUumRrF8xX72Hk5Ik9KWSSco992jMIVglX56UVQK+M
 0WZGVoCDGoRmuzM6lMUM2dRl03HzXm41munMRJ9fSUXU1iU+9+MjD3RdMa6lxBkP+z3mp0Oc=
X-Gm-Gg: Acq92OGifCvWIuSloPOvBhRT3OXuLDb/oES0sfXJH3BV4StKYrM/aK3RbsFDsAMlQ9e
 KzuhEMOg+kmpUHtNz+RBs50lRJvc+wMVr13lbW+nXnNdZlMsDLnxwchY7nslFjfQ/C3YiPwhKpY
 s1eoMXRkpa3Okp4VMGl6LixqOGe6bZaCNomETE9MSEJrIYHTCZYfM0RAunwwDvV1+a3/EP649+s
 f+fj+sHKPUPKXIqtOstoR+WiujzdyfzuyQYLHudZpgBS/8WVMyFlrLMuVcGrZvh2DB0gtDuzG4K
 Mph4p/oC6HQsZk2hYIqozWuMAKeXEu6et4AVWkBuSA1/Slm9By5qnoeGLnDD8uQEPK/sQqh3hfz
 /d+MST1gTVZCfN/WoABe+FQq40xgjPGcWx+FHQMaYnV5Y9t5XZsmMZUXe
X-Received: by 2002:a05:620a:6084:b0:915:7c1a:138c with SMTP id
 af79cd13be357-915a9d5fd58mr1326855385a.4.1780909551190; 
 Mon, 08 Jun 2026 02:05:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6084:b0:915:7c1a:138c with SMTP id
 af79cd13be357-915a9d5fd58mr1326851785a.4.1780909550709; 
 Mon, 08 Jun 2026 02:05:50 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf41f05041esm427079066b.62.2026.06.08.02.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:05:49 -0700 (PDT)
Message-ID: <f9be384e-9ab6-4201-a737-4be331c180d3@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Glymur-based Lenovo Yoga Slim
 7x Gen11
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-3-57c70c23d0d6@oss.qualcomm.com>
 <6d2ca392-148a-4539-92b8-05bdab1d07e3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6d2ca392-148a-4539-92b8-05bdab1d07e3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX9yiGeBso6cId
 0iMatmIiUOl3Pt+MdqAe85XF6VWoV3owpQU2jMQGpGCNMhkSDIl7b620ayDy5CfyHlU6ouRuBhR
 mEMNSmDvn5oUmUNEwmvHWraUp0m2SdoxcPau3Dp6CXV4iURj0fJDg90SzlN7/oJQymfacb0GllU
 dTMIi9C89x3Iyzfs+0prGg9S4/eIgCigJoNph/qTI7vwFH7PC08vIUoUvU6I0Le8PBGFy11Sgnp
 5M64f050WflMiN/N2awm/k3vVJ/AKXylEuL6pcaN3jar4mgpPz8kuXIi3EY+tVVp/SM2dVX4S03
 PvkkAxGILrDthSSeDnB7Yzb90lRdMffCpI8ork7p9jAkv6vvn08KzL8ZdfxfjTbRn8UcxKZVxh8
 YRIPbnim6lGg1OP3GQlauZvgWhnFQ5LTGI3943MFpX2qfS7e0WbM4XV9m7XvElujcmHEgzsCaJJ
 D0ZpwwobuZaHLbDBCxw==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a2685ef cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kKXrk63Xix4RLwVNwpMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: T3r7Ue6Yy4iaFfEFlDEStTEgRv0k0RpJ
X-Proofpoint-ORIG-GUID: T3r7Ue6Yy4iaFfEFlDEStTEgRv0k0RpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
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

On 6/4/26 11:59 AM, Gopikrishna Garmidi wrote:
> 
> 
> On 6/4/2026 1:36 PM, Konrad Dybcio wrote:
>> Introduce a device tree for the Glymur-based Lenovo Yoga Slim 7x Gen11
>> laptop. It's fairly similar to the reference design, although there are
>> a couple of major differences, including a different EC.

[...]

>> +&pmh0101_gpios {
>> +    key_vol_up_default: key-vol-up-default-state {
>> +        pins = "gpio6";
>> +        function = "normal";
>> +        output-disable;
>> +        bias-pull-up;
>> +    };
>> +};
> The &pmh0101_gpios node is extended twice here. Please merge both
> pinctrl states into a single block, similar to the fix already sent
> for glymur-crd.dtsi [1].

Thanks! I'll just skip it here, as there's probably a RESIN input
on the debug connector, but it's not soldered (we didn't use it) so
it doesn't really make sense to poke at it unless someone really wants
to go the extra mile

> 
> While at it, could you also take a look at [1]? It addresses the
> same issue in glymur-crd.dtsi and has been awaiting review.
> 
> [1] https://lore.kernel.org/all/20260602-merge-duplicate-pmh0101-gpios-node-v2-1-251107b3d9fe@oss.qualcomm.com/

I was under the impression I've already done that, but rb'd it now.

Konrad
