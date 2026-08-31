Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A0CC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5817210EA3C;
	Mon, 31 Aug 2026 18:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUwlRdwb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyDqBM0Y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB0C10EA38
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:39:36 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIXsR01334973
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QxMgKDaOstJSBOtr31wH2Ju7
 pPTVHzgnyzroxjk5cwQ=; b=BUwlRdwbqPFH9U8TJUQ8Lxi54h6uiWVZfIhEt1Pz
 fpUKCy9WUIbLxL30OgDarf7W0vW6P5vZqFKpX8b1yCPfhNCroNF35AminW+q+ZMV
 oGLc5JLaJgG8Xr7/qDfOV8dq0zaJdlMiP7XLl6D++oPXOj7+zWl/EHz8FFRA+30z
 SRoz2FMYrXvv0pYaqv95ZkK0iN05JQvZtqbuR4KL6BRAqwrHjuz+A3QL6VjiWgvo
 2nDjq2zm6RWnpn9Ncib/2pW3aCpkcMV+23asLcdR+d93vRn93Dnzs5ZMEiz8lq9n
 eUD1EcMHC/OlaVcm08nh7Y7f0ZSTK9DFGSrraO9IknmhbQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd8cvt524-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:39:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so891020a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788201575; x=1788806375;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QxMgKDaOstJSBOtr31wH2Ju7pPTVHzgnyzroxjk5cwQ=;
 b=XyDqBM0YSneeCFvaB6BnYUU/+ORnXVpYgqu3t7T9u3tB0dBSn0aWUGSevqP79A4DKO
 A/6pdCPNbtipzIauKNjZTbLIGP+BUBVIlT5meWz8YZPe6w6qGZp7hm01Im4rBwvnyNas
 VUCLDLhxEwY9rGTq8M/YGMRO93V2mkGCTafUXd7dLgSuIukeZP4VmwKY6EygvfdjP1fF
 CjZKHvO3ho4lDeMXoGvMEDUomR5+mx9NmXFRIYI62kKZ2b/C11wya0YRYxiONGK7AXvs
 jpze9vkIzevkF75f6SR9+EMNIoWZTGBD2KjZCcM32xqqGunq9ae4ya7pPCFen36Mm/YA
 h08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788201575; x=1788806375;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QxMgKDaOstJSBOtr31wH2Ju7pPTVHzgnyzroxjk5cwQ=;
 b=nK+9dgOblRrtPqUhcmJjDLRNPmk8BSQ59P48OCNolCbvcPFWRRmvTq2WXusoYe1gTA
 u+YVtMrdBdzXMN+thQWAKG8YJbWH64/23Xce9g3v4TwoXkRPPvz4e5OH8b6SCsP3Mkmg
 ZnERSLE7+8AI0Zcq5w+3DyWkmiUy6A5fpEKoE06LP2rdK+NvI8O9NIE1eRFt6tUGFcSk
 TDwzmn5NtTA7gdSURk3q7KQzF4lez8DcqXcuNV6AYklHLaZ+XHxTjWoxVwSTZAM7qNFV
 spznI3YimUkkFplt/Zn3hk0c7P2xwMX/ccWRTOa5sCJvAH6M3qygy6KhH/19+pVkUlCp
 HCNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAAXR6T3anmszbo/YWPA85WXDqLryP6Y6v7QFxbVtrZd+nb+8WEu3CtimszkVgiM7FwLqRZdwWOUM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7o3OgIMAnZQkWuy9VmwVtbEb6L7SUFIlb8Aj+d/Wm1DzEsA5U
 I5vlIY07sAkHE58WuV5SL2O83QH6HArGhOCWHM8Wpzfd3Cizcr7FvbrpOXOiC1Mw4XkYqzyh4CD
 XKoQJ3nwjbjztyM1z8WOhhD4bD4AmoAeyqUZggnTA/lXsjVIGG9o5I9UOKrbwnrHUV7g19kE=
X-Gm-Gg: AYBFou2LgXiIRz+X0Js5kZ87ySQxlZyeFCDXga07zDcuZzPOlVgWcDHx8INEhFACWkv
 1nh6wTEUwIJFfgSgQl5bOyuo+MoSCELIjFJLETXGNjndDvvvpRThVAiVO0Qf9amPw2+k6L+BZpj
 kp9uEp6T7gzw1V0vzScz66HUnpPR7tLRX+Kp69bIh2fIfrjXAafvN8M0HCB6IeUk8OL3YdzdT6K
 YvVaBvYuLeqOyogsiXxC/TvFb0cfq65FhJXx2D4tUx/3iomnWghWJVivVqAVwEOjbnn6CY4CYxY
 ziHcYNhhvdwpSweI+sfRzE0ooBsZJ1K7Xt3V53aSES6Iq8L0Nde2iQHUD1SdhNQvIHz8t1ihLhi
 kfTynY3php+1bUXXlnoysGfqh4g==
X-Received: by 2002:a17:90b:4ac9:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39907aff7acmr2952480a91.2.1788201574762; 
 Mon, 31 Aug 2026 11:39:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac9:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39907aff7acmr2952407a91.2.1788201574207; 
 Mon, 31 Aug 2026 11:39:34 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32874498f9esm28349715eec.20.2026.08.31.11.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:39:33 -0700 (PDT)
Date: Tue, 1 Sep 2026 00:09:24 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <apXKXNBPA1slpAXi@hu-mdsor-hyd.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
 <178766696083.117435.16339828039068931624.b4-review@b4>
 <ea3accea-4c20-488a-97a2-7675f54fe401@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3accea-4c20-488a-97a2-7675f54fe401@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1OSBTYWx0ZWRfX7NdhWLjsdOxT
 M5f6z1bMZElCC5ZFzAmMEujXq2SBC09WI69/VR6qAllVH4cTH5cI7+N0RPc14pPC8f8XUP7R8EH
 amLjSZKKZ4rVOeZYZZlmCcOkWrXxFpM=
X-Authority-Analysis: v=2.4 cv=JtnBas4C c=1 sm=1 tr=0 ts=6a95ca67 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=BWdvLCTEkTRRry6nPpcA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1OSBTYWx0ZWRfX98cLVL32ebPz
 KT448Jw9G8hLZovCXJXEOl5HCx+1Q+4T+4+TUcx8hk16Ee0L1rMN2yl5m6yI4/5hRwmfKpgA0Uz
 U27uU6efEoOgnS7ZwxPUwug/Hs/pKEfk40cPzwtrx8k0IkGFtzRPWzSg49mKlM1iAmb54yv+1wZ
 AcqVff0hMyafl/0Ve7C8TjV8f4EtAftJKH07w3wfBuvCHt90w7f8zZV43hLwtdLcPiKEdgBSJCL
 Am2WaM45AwacNkYdYpbFU06KsXKlHLXjX75LvLYBka5AqyA9e6wH5BvrdXvA1D6osBYHwUGhKJD
 9CfN0ksKwt6XPcNlOyuMX72MCb8qyeryF8w1BmKP07N8I+4rC3sA2wJANfdn/6DvjzwNYwY7PbG
 GgCxWeWH9S6uuHU5Pq7CBq8AgNsN3jWGOtCR0WZiC+z0UgO28l7yjVdvKTyaW3OxF5SP3Q5v8Xc
 SrwdhiLn/kyKR6JRoMg==
X-Proofpoint-GUID: rtiSVThbwqEAfFduVJBm9hwKHOKPGfbT
X-Proofpoint-ORIG-GUID: rtiSVThbwqEAfFduVJBm9hwKHOKPGfbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310159
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

On Tue, Aug 25, 2026 at 04:29:32PM +0200, Krzysztof Kozlowski wrote:
> On 25/08/2026 16:09, Luca Ceresoli wrote:
> > 
> >> +static struct i2c_device_id lt9611c_id[] = {
> >> +	{ "lontium,lt9611c",   (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
> >> +	{ "lontium,lt9611ex",  (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
> >> +	{ "lontium,lt9611uxd", (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
> > 
> > AFAIK there should be no vendor prefix for the i2c_device_id. Have a look
> > at the docs and other drivers for the best practice.
> 
> This is because of bugs in the driver, which I reported at v6. Code had
> NULL ptr and to solve it, instead of fixing it, Lontium added such prefixes.
> 
> Obviously this is a no-go and they MUST fix the null pointer in the
> first place.
Will remove the prefix in v12.
> 
> Best regards,
> Krzysztof
