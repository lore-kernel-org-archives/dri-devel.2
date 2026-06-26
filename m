Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D42C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D903A10E3EE;
	Fri, 26 Jun 2026 20:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQHN9312";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HKlwl1BW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70F610E3EE
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:32:42 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8d0C1980951
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eTsqUjqMEM2wDTe2a8HKt8xg
 pxNC8Ob7VcHEtgqhrC8=; b=fQHN9312M4A/UHpdzecnMoU5JNPaZbPVmG+9lLNE
 a8KI6xoxi9/kqCSsEKODaCIZnnmUprUDHYKUpBzNsUQHnqggi8gJCA2nh6uYpl+c
 k/PDO3G1DHcyJb3pagCpzI93gTcQ6/m6ITJGINbkE95xwUBzo4WTYFy/qaOaiBBy
 ZQsYCRNAIfH+y2hUENTbfh9UuKNgUtmxQbWb7aIxjqLe/O7K+jStJVTMVyYcksaT
 qzHcsQpP4efdqTNYEXMqlXYKBl1KCIQn2hqDt7f/dg+0lGtYDVHQ2cgOjFGoZvsF
 Za5MYhY+xlL7Bcm9fswliwhQmA/SUKCWNgncrdyzcuC3AQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2tthg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:32:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92229624a71so243856685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782505961; x=1783110761;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eTsqUjqMEM2wDTe2a8HKt8xgpxNC8Ob7VcHEtgqhrC8=;
 b=HKlwl1BWxVvvUu6TaLtGSEcgmagLSCR/SL/+B6ncGnHONACdburIH+dcNKoBvdQ9Qo
 LkjWDamvtPz4kt7YrgawWgOtrkuRA9uABn9fKfgiiUy5fQgItpcsbg6bLyDuvPABv9GT
 8fw95rIRcOw8UmckcmuncUkwQhA1ldBJUce+z28ZuXr9urqPHBcfa06LgKHw+ZyOBNZj
 raamlRmjvLssCCrup0smOTTEAHPQY0NsGT05f+0GVvJpa9VXzSEvLvLEjWwmUWas8LzM
 CuNJ5mtkKRqx6qY179rPZwKCliujKthDop5vmnL0fb49N8rLEsTbsWZWsKpW+m6TyshV
 TaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782505961; x=1783110761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTsqUjqMEM2wDTe2a8HKt8xgpxNC8Ob7VcHEtgqhrC8=;
 b=GYXvyUBeqtzG2Yv5Onc1pCKYzrhhhUFmMC5T/68npu9kyl/jXrr7hesCURdvsBMX7l
 jGWPkX1GZjwMaGBpPS6k68Vxys8bKsXHWqfb13sBgT5W4bhVCI0v8f+8e0ohPtseGWko
 WK42xnyDB0+qpdlQyx1S5kgUhec3o8VmXsjaVdejQrqkoZ/Kuy88XLc+zbK6Vf/Ocisg
 X8tUA/WHkqhWrA4zXckv/X2K/TyzogXcf8hA2MtQyhHwd5uqLdeRC41zfWKaZRz1B7k5
 dBwvrhIEVPfqN35wEnudTHXZAlZHMXIsKkymAhdnNFWPJ04kSXiYveG3Q3CvS8ueCs1g
 wxvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kkFDZEqLBeXXOFUdrcIQlsAFO7LWK8x7ZpUnT2NS56UesvuvWHlIem8QSmttG4GDg+qFPscTQ2+g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywsq0viQ4VrfMJZbEj5r73CWgrE2nUzaPMX64mEzZ5BiC0O6Raf
 RDQNteO9GSEBiQ5D3i05Fhgj/fUIjVZBlkhQf5FHLJN+nZheCwx+R2jEJkj+nr3SEanQ5gefZJw
 d/2nR79OwlaIwTqqfw4rqeQ07byWCg3eHBe8Gfd0d6xWxEPCbYs5hf78fMVUsqYzAmVM7uNo=
X-Gm-Gg: AfdE7cluc5rEvOjCaTQgP1t4CmyceUeNtRCDlLtVlpyMLpyPh4XLHoTsCG6jXxtQgZX
 IA6Z3yTTEiQq6Od2jHAZBZpEw1UR+SLmGCi0lUIbqN7beBahUj2g4XihKhcI0LzQ5ljCgQjq+lm
 MA8/AtPgKqUm6JppgMEmjtAhvG2VESccjadPhy7gxtyBkWbonyg32IXSqzAF+sVwblXCVENFqL3
 7MJ8BrqkJ8O96nz0Zk5SLtHmkfZvggvVBxxScPJxtzvKiqXHdAj9ADc4UXRhWHTOMZS1oKpZI/a
 oIHg36yksgopHhVZGIH3JkOvZDdrmHPv34nnrXCf89GwT82RrTsXh2gS+0PeNoiK1tihTuIpRQf
 CJAk81sIKVK7yn8oDVNk4FcUFoEx93O8GhbIoBtF/9j+PDp99Y9ZTP1pHnhwsc6IGMErgx7YyqP
 BJ9yu3QS7iW0glcvK7UbNJiQ8Y
X-Received: by 2002:a05:620a:4487:b0:925:c160:f3a with SMTP id
 af79cd13be357-9293c121085mr1287063685a.36.1782505961016; 
 Fri, 26 Jun 2026 13:32:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4487:b0:925:c160:f3a with SMTP id
 af79cd13be357-9293c121085mr1287057685a.36.1782505960521; 
 Fri, 26 Jun 2026 13:32:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad6954aa40sm3646395e87.10.2026.06.26.13.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 13:32:38 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:32:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH 0/4] (no cover subject)
Message-ID: <gmsllfyrj5a7u63v4mizde3lmf6kbpnxu5ca73rxkmc57qrhg2@lmo7enmlj7w7>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfXxCnVIjIJtZlW
 68b9x43DObFxXbp880JagOKM0xKM4hF7eLF5YauvMhXO+awKNK4z6/IFVuzpME+ku/EKtg2gZgw
 Etw8q1WYQh3bx9XrEq+ELcudxeDzdIc=
X-Proofpoint-GUID: yw55_5KUM98S1a-yh3bZg272VXR2vj_K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX0DObll/b+uwn
 0FZ2ILkXD+XYo0T4hgRF3babR3sQUeqziCSrI6RBjMqZFAV4Z4N8njmu/eNlIKPlAO6Z92l5jfU
 oRwcbIUHuzjahDBf6ZeYyTn64JiDZ6ZRAGsF8/elVk4sowZci/gPU8W9ZhdgoMJ4U6VjX3artZ1
 CwvBviORjGJoWONJ2z9Ow0OmgMrrLE2nleMnSjqSHIga7GLRBSlsJXEReSkfnads82uHDKNLW0P
 eznE9lpMHgeh6P004dyDgsigRgVRPjdbWHtw0ju/fGV5H3RYHdj7AXysH9lCKBifvHoLzvixHZ/
 dd88Dq/8FdNdnbZvIlQ0OiQAlZV/FpTutlB71oeyZI5/TGFt1c0gSVZqamSE4njv9pgJiRhr1do
 Jc4TAdJcCGXdqRx+eLehv3P6+e16unUObRVUh7Y4BGX1CBdm3dPsjvS/eUQccrYZFLjoz8vtG2N
 8Y312i9BXmOJ1kwqTHA==
X-Proofpoint-ORIG-GUID: yw55_5KUM98S1a-yh3bZg272VXR2vj_K
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3ee1e9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=epBqaNyAPFBQRbiHezgA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260169
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

On Thu, Jun 11, 2026 at 02:44:55AM +0530, Mohit Dsor wrote:
> From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> Subject: [PATCH 0/4] LT9611C improvements and fixes updates

Heh. Is there a reason why you don't follow the internal docs and don't
use b4 tool?

> 
> Hi,
> 
> This series contains improvements and fixes for the Lontium LT9611C
> MIPI DSI to HDMI bridge driver, along with DT binding updates.
> 
> The key addition is support for selecting the DSI input port using
> a new device tree property, which is required for configurations
> using port B or dual-port (A+B) operation.
> 
> Summary of changes:
> - Add DSI port selection support via DT property
> - Fixes and improvements
> - Increase MCU polling timeout for stability
> 
> - Add dt-binding for port configuration
> 
> Patches:
> 
> 1. dt-bindings: bridge: lt9611c: add port-select property for LT9611C
> 2. drm/bridge: lontium-lt9611c: Increase MCU poll timeout to 200ms
> 3. drm-bridge: lontium lt9611c: fixes and improvements
> 4. drm/bridge: lontium-lt9611c: Add DSI port selection via DT property

This is written several lines below. No need to repeat it again and
again.

> 
> This has been tested on LT9611C-based platforms.
> Please review.
> 
> Thanks,
> Mohit
> 
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> ---
> Mohit Dsor (4):
>       dt-bindings: brige: lt9611c: add port-select property for LT9611C
>       drm/bridge: lontium-lt9611c: Increase MCU poll timeout to 200ms
>       drm-bridge: lontium lt9611c: fixes and improvements
>       drm/bridge: lontium-lt9611c: Add DSI port selection via DT property
> 
>  .../bindings/display/bridge/lontium,lt9611.yaml    | 13 ++++
>  drivers/gpu/drm/bridge/lontium-lt9611c.c           | 79 ++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 7 deletions(-)
> ---
> base-commit: 7b61c580d964f499f3eaf96d6579a7127dda606b
> change-id: 20260611-lt9611-b4-send-6f1d39c2d6d7
> prerequisite-message-id: <20260420061644.1251070-1-syyang@lontium.com>
> prerequisite-patch-id: 5e0ea8907c87174a28fac5456fc51183d8e8b36f
> prerequisite-patch-id: 6fd8685174c2c83b8871d9e6419c6f3bd29ccc1a

Well... The series is not merged. With these issues it is unlikely that
it will be merged. Please work with the authors from Lontium to
incorporate your changes.

-- 
With best wishes
Dmitry
