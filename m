Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE678CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1BF10E47D;
	Thu, 21 May 2026 08:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AnMNJEvJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="biJg+X5j";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411B710E47D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:50:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L2T0lP3815926
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vd9ZmwiYnYNdA0AM4gu3iLlxaPjUKlAA0HQGQTfbg5g=; b=AnMNJEvJYA2RJqgK
 gu7/cUAhMobSm6IfTQYSTfSW8scWkmOt74Yh4YfFOFR7vjCR4jnCIQvfCSU6DKT2
 0vTcsO6cH0rgiEoNzvFOktY2YCWEDgxTNvmRHo5pjwgbexAPYFGJsyvm62H/KYRH
 4d6frdF1vgicruNAq219IALl83vNjuUgTL0vZrhra3O3kXFvIdwK4i6oaarT1GeN
 PkShEION0ZZmY4C+QKpsqik3u+lW0WfmF/s7MNfnzYgc/TdOZzsTq11xP++kmPcl
 oh8DkkzseRMqA4s7sWPZdryexClF7O6teeMQ7nbjH8DUb1KNARBsVVOV2Du4gb5z
 X3GbBA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa1bcf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:50:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91345d517bdso123265985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353412; x=1779958212;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vd9ZmwiYnYNdA0AM4gu3iLlxaPjUKlAA0HQGQTfbg5g=;
 b=biJg+X5ju19zmgW/xJ+AL/iYJID/y/l70IHcjxHqaeR35AiJXWdpsv2Y0JH/ZVhD/Q
 B9RFkPTe3SUQ4PSM7k4BzxwKxEXqofM06ne4xUp8IbxFBssxZf7ja9QlUMHJCkOlEoSF
 MA8K/VYknQ0taQJwUxSauZp4PuaAb8O6nXWoCM/jJVi1Vl4pIufwkb8su1nAcVQyftVB
 PLacde8rrp5AKM6eBLai/qiczRZ5MKD2/LUe/hhY8+Exq2qYS0b8aYr1sy2yxOP0+Ulw
 uJcWL8f9YFitKB9WbPi/tWYiLie4bHTaqZkc1eFDoPxoKO3746OXoIE9Rix2Bat2qsvJ
 r19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353412; x=1779958212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vd9ZmwiYnYNdA0AM4gu3iLlxaPjUKlAA0HQGQTfbg5g=;
 b=CtjBnvBK8o3dxRdglQobp476bAkBlK+KtFyIqyNeWlptyi6TsYX4C8kKCT2eVJ+KTU
 7V2mltPF4mUHrXaYHEF8ECgL9Hk8YqGpuf9N+ra1Ik1nvzp/nr7nd7tMqHjHL15QWzaC
 aSzJ8KzesWBMZ+vzK7eXoW8XA3NcNJzsNQFjrWCfT96wo3Rzbcz5j5REcg6P7qcFtCVo
 LgfkCfg3V9zNRi4GlsJqFR+kwfiuVAqp9UNY4uYovpLq4QVJeTXe6r/okGZjksTOqnW1
 3jRfdjUG3aviG8+6bV2P1r0Lu0VIEozR4+GvedqBNzHsfrssBSPHMT89p9sMw501DQnE
 r9Rw==
X-Gm-Message-State: AOJu0YzId8AJccg0mGukmFF9dmebF4kOjxxzlmZkxH5nGaIovghGBptM
 3p999xBiyV6fM0NaIQr5NIJHDj/RXXjagvKIRmTxEWzuApoLo+aU8VL9BWNBF4+EHiBEswSQF3N
 uLt5Z2lrJN17XznvLzrCf7md8ld+rYbP4udpvrV0y/DLYpHorU8nGFpXaA7h2i/jW+W8dI6I=
X-Gm-Gg: Acq92OFlcB0v7HIn/6Q6OPLgr3cTXFB9LLYLoGirI45ewQPOplNyu36lGEjO6vKU2A/
 qWBrWIcFy/0SL5K0kRbyuTbPJr8lR/InQsHtxYfh1mfHjmkOwB1DsJDP+uiHOfF+i63vBVFlX78
 iwCzhAWUdt9IIXabwnkE5hiW8r/ZKwNAgq58n6+xyx5oqsGcTfpGgAuJhQkNRlJGwx+50Nlft7k
 2wgZ7cglhmZl9Myvem2JbWp58+PUqCKW15elzSg/YJrqsVd8KN8Uhn6g4rsrx0Vkeqxyw3M1xpj
 1kLTkjwMUUyelj7OHSsT095czb+90c18/TuZumu9GpEC0eRZImpVygyDNPKdcgft8RNvCxYlAGI
 skzdlB/hVNBcX67wpEH2Bv5v+cLkXLo/vHSZchvmRGQq8U22o1Mrgf+yx508os6WmDChQ9ncA+V
 IrsZo=
X-Received: by 2002:a05:620a:2586:b0:908:a758:baae with SMTP id
 af79cd13be357-914a2cf3abdmr154517685a.6.1779353411708; 
 Thu, 21 May 2026 01:50:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:908:a758:baae with SMTP id
 af79cd13be357-914a2cf3abdmr154515385a.6.1779353411301; 
 Thu, 21 May 2026 01:50:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdc87e77772sm17619566b.14.2026.05.21.01.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:50:10 -0700 (PDT)
Message-ID: <cd5a8576-2f06-4620-bbf3-43b3f84de630@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] arm64: dts: qcom: sc8280xp-arcata: Enable the eDP
 display
To: jerome.debretagne@gmail.com, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-3-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-3-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfXzYhg4UllSyeN
 22OuMSxd6SZqdUNocle6IfeJj0Td23AH/G82yo7epOyyWuTeebrZNZNPezT1V5vdQwd7AU7OthW
 hFURW/z/uYMRRJ7XnNxvjM6rFw9nL9fGl61TtmRfaOXOVwNp3zU3cfrCJQz6rDPCoOTVdlMDZiV
 fkLOvGRLdC117WjIZe6vMwGldQlMKVk+RmcDE85+MhFj/Z+lXhW4Xnnj1nr/kzm9ntwcF2AnJSJ
 BLkbZctOhUz1JIRHvdiB9omAP+JyZ2Ycms0nreECBmOb0Mzs/HWvjobvwt2zs02G2qJrh7F4ylW
 b53/VOieafVyDo8pjPtZCSsp1D0SM+D98wcE3GPwwL9TGzUCGrrjl2orke6ETGn4JZoModYooVX
 VDxMolW9cM93R1DT20z4BHGKlVYZPHtu3x88NmLRXlqWs4+WQKcVnRTjTDPjSrpkDTgNcxf8nl5
 lV/e14eZpmdEOFey1UQ==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec744 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=LJ_b16ZpFTZdMs0EjWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: M2L_F04hhf2uNqP9-cfwwngXZUKkVmeM
X-Proofpoint-GUID: M2L_F04hhf2uNqP9-cfwwngXZUKkVmeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210086
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

On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Add the vreg_edp_3p3, edp_reg_en and mdss0_dp3 nodes to enable the
> Surface Pro 9 5G eDP-based LCD display (LG LP129WT232166).
> 
> The enable GPIO 36 was found by decompiling AeoB dumps [1]:

I'd like you to strip this from the commit message, as it
doesn't add much value and makes the git log unreasonably long

otherwise this lgtm

Konrad
