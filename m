Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C674C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE94310E011;
	Mon, 21 Sep 2026 12:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJcKXguN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jpUHvyRz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3854B10E011
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:00:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAeAVR837790
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5hds0TdhjMv2BFxmZw8drlMG
 gZASdjiaOg7eKPpN1Ss=; b=eJcKXguNAJYFDldZqwNECB0yy45dEqxPmprFFhyw
 05fQbLK9cBtdu32Q35kGSJOVDproPqldruARFjP+oiTFJB/oxDp12TX4vdCmlFOb
 ga9TNKnrJbTB9iNFbSF72HMTuh4JJMLOY2+DUGiRCAHFiNtAeeadV6Df6CZfCdHC
 S3YHP/edD3Me1L+AvcBJCGEmSbRci031VMJnvroWxyO3RVH/vWQRuIf0KER5unpg
 MdnpO5WTNE07qZIjbbWjSCCvDTJsQFawjBhK6UHrw9kkOnvR8B5QC4aRhQQWy7g7
 v0zXvjhWfMc3HaZuOs7Q3xSL3Dupy7gEp4xW2kkzRI2gKw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hpc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:00:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939062ecda9so471783385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789992029; x=1790596829;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5hds0TdhjMv2BFxmZw8drlMGgZASdjiaOg7eKPpN1Ss=;
 b=jpUHvyRzZFEAX45fWJ0qzvs9xVZwSRzeRKfgyWKKLQRoTuuvfbQ4zPhQHhmmBdyvTy
 YD9aes5fdujqk9ALK5UVTs5NJt8C225x+aF4Lkjxb7n4rOPPhYiXI+Yj0iUVDW0+lKp1
 IWUrGE9bH+FsLQAiuvBUKnJMQeLvaAVRJjxzXFQNFs++LnRb3M+YBZVc2bqzrPuARAOk
 4CgzrV3Cfho9Gv/X6/3PyII8oa/JDhDaHchywyRxLXbcBCh/xzVm3xocvFJTc206DSkI
 7cXHN50svxx3IwYOY1MhebPOmA1IkvVNBWPONuoN5dFThtGAXRE2qXkKtd0M4X4kPV4k
 mCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789992029; x=1790596829;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5hds0TdhjMv2BFxmZw8drlMGgZASdjiaOg7eKPpN1Ss=;
 b=My1/I4T7J5p0YUkdBwC7FGSznpbuHhvvuAYD+XbMUCSofTASz2QKCmcQ5hhofUpXn4
 foTzQpNbea9UTYXRROV/rlRQlK34iPtktIITk9HIY48b9mS5DS8Mw1zgJ9Od0hnH5nFb
 yeWklbyjk5PoUcVV19VkYmhHdd8VZJYD0XM+P4nm/W0kiYvsCl92rIRpRvvHxKsQrnSd
 ilOx+kcP1RwUCeGUOwg6nKR9KSeqp+TAjzrfjQ/fAZN/PxkIKP95KvONa8FE2JyFw+o5
 dOA4RrbGMF4cTMMtO0SYA0GkRNgh2KcBumA4E1uNxL+9qY+ps8YgC5kgLs1cYLxXsYHB
 0agw==
X-Forwarded-Encrypted: i=1;
 AKwUvByNjKu/CBDDwFy5ZyXtV8OJyNgU4MVnHC7YzdzN89zPFBnhrpAbQUHB0r1kwkn3JqDeniqRyo+hgcc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUTUhtfpRU7AXN9e25G42QE2gbrGVg0Pzw6uz7/kY92sSpg461
 eU6zDtUuygNOkqONuXmxOUp1vYY2u6Vt6XpsBBrRInvPEnvM67F5s7RzISTvu/VR+oyb54JRPrB
 s90aSOJ3d9MpAgRrYBnC7YgdtHEiMl4PxNa9IclcTlxzJQb3Z90THGjV8Qm95NWLc2AWF8Ts=
X-Gm-Gg: AYBFou33v3nfgASd4eCNME0oUGpRTlkhd16iqJWhdVZSKQ/qrkLJgoxrh6czqlf9JSC
 Vqi52X/aWnJW43JTuJtd/MjgCcBsWxsmbkGjZWmWCLQD686F0I0mmFgRu3iano0sOTS17YmzluT
 4diqTyCzfQd83fQpY+Jn8370VRksGfPi/vxEgdFA/DZXXcDsab+hmAv/l5kbe1A7cRspjFvB3iP
 qqjW7HELM0GCSy+XUT6rXX7eH1DrcQjlN3k3WUGG1HiNBqCvHsXwqaa/WJStG3FJ8n7qKo6WFtC
 RXDbOX/WUpitte6caX/lz47BJMqao12MPBJIHw++FdoV5x6yrnUmJ4gla281UAJRHu50029ziDA
 Gjg3Z40Icb0B0Mg==
X-Received: by 2002:a05:620a:460f:b0:93b:d79a:c45f with SMTP id
 af79cd13be357-93c15ea1ef8mr20049385a.55.1789992028937; 
 Mon, 21 Sep 2026 05:00:28 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93b:d79a:c45f with SMTP id
 af79cd13be357-93c15ea1ef8mr20035385a.55.1789992028117; 
 Mon, 21 Sep 2026 05:00:28 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724422790sm21382516f8f.5.2026.09.21.05.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 05:00:26 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:00:24 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Abel Vesa <abelvesa@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] drm/panel-edp: add CSOT MNE007QB1-1 entry
Message-ID: <wgj5qfghiglcwzg5ouhjr4hv7mgsb5zlerwrmouq4kt2o3ywsl@wkt7trsfjygh>
References: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260918120515.595782-3-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918120515.595782-3-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab11c5e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-iAOE1hZoH9ZQyiuzH4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: c_jVV_Sq-rz9v2EdOH-BHjPELcGDN558
X-Proofpoint-ORIG-GUID: c_jVV_Sq-rz9v2EdOH-BHjPELcGDN558
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX/7aym9fSJKVX
 rnbH3ORz20SjQXPOg+kAwexC1egUTbBeIbidpd+kotnRungZCBvdDtIZmQeDPlSxzE/5qe1qM1B
 0UMWXimq9qcoPKcg055YaDLGsJ3d+2k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX7vSvKb62iFU7
 vb1lkWFo/3Ges2bn7S3c6oFDiBpVpO29VLZ9yJsewl44+KFtzEPu/bwQKpTkzwh8HGH9zSwiVUc
 B0iUF5syS6PpmicN7kfPjnB1J6w4llryD47Wm8DcV6odQWYh2AiXd+M805PuXX3ietBGFxdOg/N
 7QQe3KR5+IAXo95SFEUvwgublms1uyC5fFynUwNpBUXYUFWPx1Z9LvX8VeL5vwMx5CVnQrhd1aL
 U5LDqD2A3FB3em4ft3Sz6eFEemMdijXqiwos7udyG+W51KKP9f2Fomk2q2gtFVwmPmFsMqhxrhr
 VgHvS4nH5VtnuxVIiYG2jLsjSTQgC0wXb2SE0aPFMXghsw0n0M5Pui44Sh1dWMS2YMV7m+i5SnD
 rpYeT2NQMbRKFAySR7T5XgWbwn7y0bo+pjYyMdqWQYp57ldRi9f3XNPFsS5vE+SUuX54cWVM7rW
 83vEdvzyk4jmL3+x3pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174
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

On 26-09-18 13:05:14, Srinivas Kandagatla wrote:
> 14" 1920x1200 IPS panel used on Lenovo ThinkPad T14s Gen 7 (Mahua).
> The panel identifies as CSW 0x1465 over eDP AUX and is not in
> edp_panels[] today, so probe falls back to conservative timings.
> 
> EDID, read over the panel's DP AUX DDC bus:
> 
>   00 ff ff ff ff ff ff 00 0e 77 65 14 00 00 00 00
>   00 23 01 04 a5 1e 13 78 07 37 3a a3 55 4d 9c 25
>   0c 50 55 00 00 00 01 01 01 01 01 01 01 01 01 01
>   01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
>   66 00 2d bc 10 00 00 18 00 00 00 fd 00 1e 3c 4a
>   4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
>   53 4f 54 20 54 33 0a 20 20 20 20 20 00 00 00 fc
>   00 4d 4e 45 30 30 37 51 42 31 2d 31 0a 20 01 6a
> 
>   70 20 79 02 00 20 00 0c 40 8b f6 65 14 00 00 00
>   00 00 19 00 21 00 1d c8 0b 5d 07 80 07 b0 04 00
>   3d 7a 54 cc 94 99 66 52 0f 02 35 54 00 80 00 80
>   00 80 12 78 26 00 09 02 00 00 00 00 00 01 00 00
>   22 00 14 0f 5a 02 05 7f 07 9f 00 2f 00 1f 00 af
>   04 22 00 05 00 05 00 81 00 15 74 1a 00 00 03 51
>   1e 3c 00 00 00 00 00 00 3c 00 00 00 00 8d 00 00
>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 11 90
> 
>   Manufacturer: CSW
>   Model: 0x1465
>   Made in: 2025
>   Display Product Name: 'MNE007QB1-1'
>   ASCII String: 'CSOT T3'
>   DTD 1: 1920x1200 60.006199 Hz 16:10 (302 mm x 189 mm)
> 
> Datasheet was not available, so timings are not datasheet-derived.
> The delay_200_500_e50 preset matches the sibling CSOT MNE007QB/QS
> entries already in the file.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
