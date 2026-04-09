Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5369F364BD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DB010E083;
	Thu,  9 Apr 2026 21:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="frtGo8D5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kRU8qk7u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6969B10E083
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:21:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639L25QN2624720
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DN2wFx6p2wCNVnJcSNzftWZ8j0GCyOvdQSpWKMBTDHw=; b=frtGo8D5a9pyM1/Q
 79i9cCgV//F7ALy1COkXTTYhspDkC8bKhAMWuyKunIMYiJeTiaZ3+9ojtT/7P48r
 hp0QL/TlBhvvFdu9nQ8wrVLIofrvwo06j2kODxHxIOuThEKZQd8WntZAEfM+faBR
 rM9ekLyrUUmzv2+Ny5/C+j7XdR8DH+aIoiPp/zqZnLc7ik3peglCvygOkknR1vJO
 JTe5JjfbX1n2QKERB+pS2mCmHulSR6f61GyVTSAz4Xe4GP7jnTsHQlM5HIVYd7zC
 zjbRngk/WiUDC8/K0KwFS3qzk17e6w2xg+VFmeP9CPuKvI33VgfzKHVQQp/t1eA3
 bnZVKg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decmu1qg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:21:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso36124291cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775769663; x=1776374463;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DN2wFx6p2wCNVnJcSNzftWZ8j0GCyOvdQSpWKMBTDHw=;
 b=kRU8qk7ul+A5aDa5/uE+zT/toQ/Wu1ztmMbP9cqshGqUAK9gpEPMpq6MNvZqBAy8cX
 6ZfnVE4uJ4yT2GtUulNNwtp2RW7MACjRu9Mqlk9GTC29w7DE+HUugEc2tTSR5RRxDtaf
 PCemKZLYYF5rJdPVktJGf9G7v0OcnmOnOWY1p5kuERT9E95hNAAjgo5SVtoddmX53uqc
 oVIvXGr2eSMyjQMoiVVMKYLItvjgVmLQ3y7E3c2sx2+m0M5GCsP1xNosc2u4aIvkfxIC
 DddDOwlfXKG+A2OhPCO5eojefTLJ/ApLP4Xzt4rKKlKUwl/4pfRMS7/TGcrAXq+YI3iu
 mk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775769663; x=1776374463;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DN2wFx6p2wCNVnJcSNzftWZ8j0GCyOvdQSpWKMBTDHw=;
 b=ZSZUZyh65KdNYizDZsId2AXbbsAMtTUz9+1GzEyaCviZNXj9TL/bNQjQ1/8zpuG2Pg
 t4HOIhW9zG4HcyQKta+p/OisSAUCB4yRHuIDYsNzlrutwdYlOxonBMe0qwK4MNh8txqJ
 VTTv+l17UwKNcegMncJx3T6JLKLWLjtBkrhzVhU060IRTf/IJd9BThFfzVpeQ2EkihV9
 Gq5lIRJYo8jdjz/hL+DPyOtd3tcg4F4HjjopeNj11HPAnTVt84MgSlAC2I2Rams53GHf
 zssbDfPuYkM8C5H6P86M3liwTbd3zUrOcs8YAq566vVLS0W42jufV867MeFmtPUTkJwl
 hj3w==
X-Gm-Message-State: AOJu0YxlygRbFvomZuNjwZMzI6VaapkHxobKAgrzSAKJ+sam1hr9ewzu
 HA2vIy+5TUUhPC9hvyw79IrGn7uflo1DuLFgFpJokUfFDVBsyCXfmxplx/4sC4gOjpSr1AtJLjX
 o91PVZFmIiQXGde7HJhrJstAmFr8eFlsU/e35AskDuhs4rzSt0tEsZMSHLWJSuoD+o6ErkLE=
X-Gm-Gg: AeBDietdc4qq2XZrN5DXTUnK9DZTJ0aTQozABetaqYUyNG6S6R4iLYycdm2Fccvhoem
 lQazZYUNeqRJTsB3NDJC1909weGZcBewNCyDDGwmqyxwDIamUOW9bDAOUyDDPqq1q2dqQW08XaE
 P3zQtusrLf9SK/fgi0IlgseVA/SvFBZiFoRpNuhmgya4TjiOfLztbCBA/ySOmQBgPlUkrWom2Ib
 dgzwvIwqtJj8b5zyyU80Q6XQQFFhB1fZOZ4UNbVtcqqPChooEqkdaph5IAytbdqsEndJNV+ZmJo
 3efSrOMw9RBpymYz9MsiF5Uxm2a+7QpWcZ4Bv6ni9dKFmK+KKlsnka4Tu0NyIJSfndnLEb0IFJT
 vo9I4xU21SNlIQmakNr8hxTK1pf5nl5Fe3ovVtapHerd7dz6szA8RlRjvbDm0uYmOK2KZieSlfd
 Z1pi/ri3mbhUHkwa5Jh/iBgkjLjT0Fqj5BuvM=
X-Received: by 2002:ac8:5f87:0:b0:50b:51f7:c660 with SMTP id
 d75a77b69052e-50dd5cd70ddmr13597661cf.61.1775769662683; 
 Thu, 09 Apr 2026 14:21:02 -0700 (PDT)
X-Received: by 2002:ac8:5f87:0:b0:50b:51f7:c660 with SMTP id
 d75a77b69052e-50dd5cd70ddmr13597141cf.61.1775769662243; 
 Thu, 09 Apr 2026 14:21:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e48fda7a6sm1876381fa.0.2026.04.09.14.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 14:21:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
References: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/4] drm/panel: simple: add Waveshare LCD
 panels
Message-Id: <177576966070.4179768.2416900967619768301.b4-ty@b4>
Date: Fri, 10 Apr 2026 00:21:00 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: gFla6SM8Cdc-KOTYW85NdunhS6DMNaFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5NyBTYWx0ZWRfX4anVgZ0mjL+S
 CB2OO9XXwh49+bDL9IwJfZHIkvWR3m1/g/xXJeIh3dQxjfU5qp6kUBDnaWSCBMpPLhFAIrm9AvH
 K96f7LoabvP0fwR3n2n5wNGVugjF0/q8nPDeoUOpySbZ4c6B4p1nQvOCwxG39sqg/u87hJQMcAy
 EazxaHInMtp6llKBBI9SiyaBZvfS6qEI+ekKd3N3lGC/ZS9tUEYMkA8OOu/+pk9f0DHvl/VAze/
 EdQGiwC32eT4JMYzEM66BKoolHOEtjUnYEt+k+XGLFLt0gBDasbPX9H9PL3q9Gq8zl8lZsMTvy7
 1qemNsRPJaAz4iQqANa7zkxIRaFko4VuZoSU0hI873c9wykbjKAUZ3wKWJW8BrAh0mbd1T9xiDp
 UifH2Q6POsUCy8ZHuJKsqIKtcdIsbhAfUcUVYNZrF5eodfjbjFWkMTd8L2+00XarNJQPp11Ba2C
 rFGJWRqIKY7sAeW/FVA==
X-Proofpoint-ORIG-GUID: gFla6SM8Cdc-KOTYW85NdunhS6DMNaFI
X-Authority-Analysis: v=2.4 cv=DslmPm/+ c=1 sm=1 tr=0 ts=69d8183f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=XqiqF6kKystFwB6n1pwA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090197
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

On Tue, 31 Mar 2026 18:44:09 +0300, Dmitry Baryshkov wrote:
> Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
> being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
> ("dt-bindings: display: panel: Add waveshare DPI panel support")
> described two of them in the bindings and commit 46be11b678e0
> ("drm/panel: simple: Add Waveshare 13.3" panel support") added
> definitions for one of those panels. Add support for the rest of them.
> 
> [...]

Applied to drm-misc-next, thanks!

[3/4] dt-bindings: display: panel: add Waveshare LCD panels
      commit: 89bb9b36d3c49961743c97f3c25befd9a2f86989
[4/4] drm/panel: simple: add Waveshare LCD panels
      commit: bef9eeb62c47902f73a386a8176795fba5e5e2e7

Best regards,
-- 
With best wishes
Dmitry


