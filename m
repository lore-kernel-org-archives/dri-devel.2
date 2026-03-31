Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE41061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 01:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6053710E7DA;
	Tue, 31 Mar 2026 01:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEYGpNOo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iNWU1k/S";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2859810E7DA
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:22:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ULC0rG1092014
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FglpwYN3DHXtSL4YMHAgwanV
 zgoIboSVzAH2SkiaCGY=; b=cEYGpNOoZX2g9te/Efl+EWsdq5Ma+DTqx1oN5j9g
 Dl6nyET6Hx4z6DGKgOSm2kXCY+jsUVTHneI9Lnz5uKBVi64uSxxRg4Ui3tOXWsFI
 DQRnrn7N0iReOESm9Q48XXuG9GyPbMsbke/UYhQ78l0byLTSsWoL/ES+QBkPsOfH
 WmygPLu7xuJGt3c+uT4/mdoQ7yx3dm9FWchV4l1vlPSMRwEP3hZmfWVYdFeftiBG
 F79GRmkyRGuot5tZujOignWqkg0wDYOUoIgjB3ZWeOI/UQeyE5FrCIYDrrqsvwR9
 Fdb6IYIaOMa7B35XdPhRsP2SbMEFmgbKXuzEItO6vAdvwA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7trd282k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:22:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so26778295ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774920149; cv=none;
 d=google.com; s=arc-20240605;
 b=imU4XC3VltneUWOFrfyLT3gRRnaT13aufwcAQb/D8+76VLkdm+QlyjX+4egTnZZ/66
 Rv4c94ZLHIhgJBMQqiw3+rvpV2KD/I6Yn2CXJu3kWwcIkfTl4IQ4c/ivs6ai/wlTDchQ
 o5J4yYf7c14BERtnwEFNO5WYK/mxe8uN7TkmhLg6RxCT1yWzWAoaXyQinPmin4nmV0L4
 wwYOEtfauNHplpsHB9Ib7pv8UaczYdltPH9V/n6+RH+0NhiI5l6aNv78gNdCgemBi9Aj
 gifqMyBoRfXaqhARc6PZ3w9eKsJd2KsbHDBtizqY4x0UaM5xHm2x0Tq0XZh2ZFS3c7Wq
 /CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FglpwYN3DHXtSL4YMHAgwanVzgoIboSVzAH2SkiaCGY=;
 fh=32znIuKdZvsK6k7aFicb5CVIVVHw4Gr5b1urZHxC11Q=;
 b=X8doZ8da9HFm3IZpw08HX0z/kw8bjBjbkN0/veHRN5K+aLeXf62hKsw8xm4kZP7XuD
 bHjUsBxNhTu+X9NOAZzBmo6mLZbC9cB7x7ZLkRmeGe2PFVSEwc+HiTb8+kixRdjR8jAD
 XCCny7pLDqYygJb2r6hnfCHf3/l0klPno6eM51kslglfKYbw+i5vIMqh9XpRhwdMgJ3g
 dTB5ixxBJfX5/oaSk3113vBQTu6F3Kn+Z7TDKekTzllV21mCR9TCjAwLw0Dk6VNc+xiN
 cP1rziKRp9TQ5zICrxj2fxZHo/TST/PxW+NT9ARYGnao9VIgi2Yqr6dms61tLwMkNuLe
 lcTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774920149; x=1775524949;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FglpwYN3DHXtSL4YMHAgwanVzgoIboSVzAH2SkiaCGY=;
 b=iNWU1k/SWLn2b1fveS7scCU3vjbr3DfpviRFZkpLHVW9NJlhCeo3tKIjfmsKx65T/Z
 jVRaVMbNirG32fPyRO71G48VXN1I9hIybCLExWNNUZqpoHoEKzROMeCiY47LE8ry9I/R
 Wisj3mfqeFjkmXcrhjPmwn7zkAqkkXv92DPhPOh87AOfjwH5kJl1PMF3OnVX11xV0V8M
 bHR3ljzSw2pwzs96o6Q2BecRd38ouNolli8qOvER7QmfYroIPqrlxjMC7oTxY2TtD7u/
 bYZjFWc+oRex/9tVIHW9QK0YAFZSzAGYt6C9QZjAEsXRXYnb+pGCxhjijO6cj642tVkC
 6GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774920149; x=1775524949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FglpwYN3DHXtSL4YMHAgwanVzgoIboSVzAH2SkiaCGY=;
 b=q43vEo3irKBxJ0TlCI8kbZ3hl2VQq6MQFcbyFFSVvEuRiTScRsauogBK7GQgLHezpf
 wDR+julelfd4C3x8OAUvnFNO6LeZFX2gqbI2bFBxAaH1MGovUZnGSW14AMJ63k3WcKEz
 THJb4rJqdL/hryHdQUk9BRqi5sVx+YlSYLWZ16mqs2EezaP7hRW5thLbbJ8GmoNqNAeh
 C7txRSSMvTPcLn6lBbb2QrS8ubOdQE56zcaEzl1xHW5aAQu7HONnObbt1z3J51CmcoPv
 CqYXNeVCs0ekplwkCrv+2Yb9BRF3sznkSyK/Ksfdm7g2FB6+RoMlES6c5Nkd8TwCZiUu
 S3Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK+M+/2G0O6guFZ8AUA2QbgM+ER2nvnuzO+NTifJKXfba2dJIkac0ufpTlJOEakrnjxW1o3LRX6Wc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpGXkw6SnA157olsCw5VfPY3+LMRGfewZKX88CgbXD5P9otXjy
 GXO9KsP9MViIyu5vh3E5Nv+A3wh9TKO38hSHImimsn4wGK5Fks9yKqJll22l+LkBdmcHwcH/RAK
 aXSd7VXKyEhfa7JAml9gH0iBk1zfMfXM8Ah4kDigR8O/XTrkxAoQMKBAU1CoTQhuhgxAf/SrwBN
 YSWLcIKfigCY0B1JI5bCxwwnQW3GptICkCu1OOOrub5NG2wA==
X-Gm-Gg: ATEYQzxSBosrdCY1zT5XZcJBgALfKJr+A2hRxPWCSuJEHOl5g61SC2ERGDxk+OPreVP
 JfL0pBxU5DF9gHsvgQzezNyiKixSWtXQ6FefowI52LtrvEUEo9nHxpLDKWO1y1U/pPcv5EqRQHE
 5m65hjyisC5D+cdYCO7xrAL4VWgaC9nQo1F2KzrRBCu9mCG7DzkTxyIkZJTQbaWGJiCPti4hwe0
 UC/K193JvkzK67j4YlC
X-Received: by 2002:a17:902:d2cd:b0:2b2:4697:78f5 with SMTP id
 d9443c01a7336-2b246977e0cmr104087635ad.36.1774920148878; 
 Mon, 30 Mar 2026 18:22:28 -0700 (PDT)
X-Received: by 2002:a17:902:d2cd:b0:2b2:4697:78f5 with SMTP id
 d9443c01a7336-2b246977e0cmr104087245ad.36.1774920148336; Mon, 30 Mar 2026
 18:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <a13f5d5a-76aa-420e-a724-9b4714b51ccd@mailbox.org>
In-Reply-To: <a13f5d5a-76aa-420e-a724-9b4714b51ccd@mailbox.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 04:22:17 +0300
X-Gm-Features: AQROBzDUu0m0vxRdZiV311FDBz_K9vvLMLjO71ysaQC6-lK9obqGdVTMB9BbA5Y
Message-ID: <CAO9ioeUFfjr3Dh58TQ8EB7H3NgUX04N24OXXYijiigRZ8Kkh0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/panel: simple: add Waveshare LCD panels
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: LBjfHOCwXWtK_sYL25TDkvNb8sK227T5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAxMCBTYWx0ZWRfXzmElIU5Zuihi
 NlDhmY055m9mT9jQ5peeDOvjX/049PkOHkxMNExbs6v4s9Nz0VIu2AZDAcaXj7dK3QH8tnoGy6Q
 8MHeEgo2pf4D7E2zAaK8+2smpUjJS/u38NZPMW5EOe5DD3/XlJqi4u9BO0obtqd7Wk3fl0taiCc
 7t1iqrxYciqsBAdiUo/1J4+FUgcFLlabEvoRgoe8+IJqAQ1w7hDM34pC6LuSYE5k8KEE6RHksF/
 ddTXXQKz0H5YXJ97JCP1HVK9kLK0EAmszK+2PJTaIWVsDUGdunyJJ3LPBBSJ/8wlc/sCXTjwicl
 vB2+oFIiWIy2shzuBivtaSjU9uy5S98mB6t0wccB3ZjOUOwfWQJntu0Gk7WVYy85vZdQZKy0kla
 y87ZbI+cz41h6UIToCtl1CdrpQfA9CNzbRV9weDd6n5HBY8QuW8ofKYFd2Qnt/QwIa7JQN4eL3k
 2a1c3OGUdbAHfxN5p0Q==
X-Proofpoint-ORIG-GUID: LBjfHOCwXWtK_sYL25TDkvNb8sK227T5
X-Authority-Analysis: v=2.4 cv=H8/WAuYi c=1 sm=1 tr=0 ts=69cb21d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=b3CbU_ItAAAA:8 a=fCAXtarhQ_C1yj2ChB8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310010
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

On Tue, 31 Mar 2026 at 00:07, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 3/30/26 3:25 PM, Dmitry Baryshkov wrote:
> > Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
> > being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
> > ("dt-bindings: display: panel: Add waveshare DPI panel support")
> > described two of them in the bindings and commit 46be11b678e0
> > ("drm/panel: simple: Add Waveshare 13.3" panel support") added
> > definitions for one of those panels. Add support for the rest of them.
> Can we by any chance use the icn6211 driver in tree for this ?

As far as I can see, no. Waveshare kits have an extra ASIC in front of
ICN6211 / ICN6202, which completely hides all programming. So far the
interface is really better expressed by the waveshare,dsi2dpi /
dsi2lvds: this way, even if they decide to change the actual
implementation (like they did for DPI -> LVDS), we won't have to worry
about it for as long as their programming interface remains stable.

-- 
With best wishes
Dmitry
