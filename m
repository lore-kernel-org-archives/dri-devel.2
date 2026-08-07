Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445F6C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4207910E3F5;
	Fri,  7 Aug 2026 10:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKt/1nGi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+LrAxqJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F0710E3F5
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:05:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6778IHsS493284
 for <dri-devel@lists.freedesktop.org>; Fri, 7 Aug 2026 10:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fAWs1UURLeEUz5Iks1N6ZLGS
 oNm7yU/XEj25H4dV1/4=; b=KKt/1nGi4WfbGU2cFvbb3TgJclAIq/vVviHNWdTQ
 6j5I9Mb3uTkTbzgIx4cHHrYqD3OvbOY9VwqjRcA4oH6qb/NljcTRos88FoMXBEVL
 HHTCJK2oyz4kQP3COyqg6LB4TuSM2jAZ4pV8buvtrltxU+xF+c+ZcNvwc6tp8zyW
 ehGuWdV/nCLAYVFlVeRid2bMQZsq8dBdLBSsuEn0hpQ7gCFJQVQlufFwfJSn4aZ9
 KNo6qbgf7VrGTGxMYWQqZwh8iz4dXdC3LrqEDvCeC9RCFDVWv2w6m1c1fynqcT+f
 dpKfhVcxFVLc0vbuhcp11ZW+ahJvMZdiSWPFSJu784hl4A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6rbamm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 10:05:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7621655eso4822775a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786097116; x=1786701916;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fAWs1UURLeEUz5Iks1N6ZLGSoNm7yU/XEj25H4dV1/4=;
 b=W+LrAxqJG5+CGs3DxCdKcYt4+TLZsg/wljt8PXcp/xqnkN53dth/B7ZkGeodCTXY/s
 CMHr1HEO9u5jHjaHk6J9gbVgcNDtYF0a2KauXPWLoKi4lyJKpjRap7Mc/DL6rXiZ2yzS
 bIn3auIrnDbrCwO7WVjgVgbIQ7Blb8dDKjUCNws1uaAcdhc4HvEflj/zYNP2GdlIBN8r
 CPt76ViOxGQAiEF9gKG5DSZVw6RxQD/EGJP70rj5Ij3/6mk9jwM5u+qEn5T4L4hxTuv/
 FkzAku7EQO4mDY3ptQgLCDR/c1gtA6NedWtEeR53o2SMDSesATB4+xkYoSscZOSZKVWn
 p37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097116; x=1786701916;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fAWs1UURLeEUz5Iks1N6ZLGSoNm7yU/XEj25H4dV1/4=;
 b=dW4/ED1CZZk0yG8bF/SLTWsNj57DwVpUTiMmVQLO/hV/dabt4Ica1J/Qq6d6lZjnyL
 Ab5rpeXmiWQR104T2YBGapaDFqFW97sbU83B02GJqEEI0/q1O6E9t3MyK1BMau/9Ufeb
 RAoNozBsC0yz+2pnr+07UixJCAZtnYOOm9NxYyA5AZsHRZRvwukfCB7wHqHor7hZ50oZ
 f2iaOLdEgVydQWrb0fjm9YDczGQoSgmXy6/bMV25Pkc+XF4KuODjk4MvY6LfSlAVf1vt
 UrkainbkbUMfiohlgaTSVeG+JUe1p0kAyDZ/Ps3njMu6LewNPsrj0f3Cni4G8C5THPWu
 /pQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RquB7j4Zou/IvJ278qlF+irZtRC7oo+3AwOuUaV6VMEECtbc+giVAvcBsroP0MJgh+WVhCVyrl21Lk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywcarn4fv1L0mkX7EWosDn+zQiYEK8GVQAWArg7mbLCKKqUalUO
 83ek84H7XImvv/Nku1N1gbQdpmJ3mryL9iOKCgL2MUkCTcQBmTJOmEW8wfi7GwLRnkwbqXOR/AJ
 fonMlOrdGJmd3lV3g4HxZd9+yO2xz7+nmu30AZNW3f+DDoijFLHnetRScO3Pe6fp90+cL1Uo=
X-Gm-Gg: AR+sD12cNTm60p0HFF+AVMj5k2bm7qBHcY1l1NxNGIpfjk0401xVvZKQOQ+yuR7To7u
 LfbBNz5N8Vqj0PDhn5BmATYJaEeI7R1Pz4DxrjuKh4QsV4t8EGYHWtzaG+3uOZpDuNLy8Mf6OjC
 AuGHu8r7EqDXsJHPyYVTLItggL5LIIfoQRHPMIHKRr7vIGU3JvIfADHBtf3rGIfSgIhZ9vhIhbD
 MsEls2o8qo9ib6pDh/Hh4qc8uEnxLPaToScBThm+6zXcFU1Zo/y5b59degrIaMkB8gcU9XpVKlB
 v4ubcjPYLW2AToB6VQq8ud/9ruIC5mlgXvFiuru8ykRnvWx7n7UeLyhfAbOEe8meUH0/u8PtDFY
 TKQntR7XLKJthLw5tTodHX6R9JQ==
X-Received: by 2002:a17:90a:fc47:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-3903c599361mr24076647a91.1.1786097115738; 
 Fri, 07 Aug 2026 03:05:15 -0700 (PDT)
X-Received: by 2002:a17:90a:fc47:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-3903c599361mr24076598a91.1.1786097115298; 
 Fri, 07 Aug 2026 03:05:15 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86f98esm5832917eec.6.2026.08.07.03.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:05:14 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:35:05 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <anWt0ZD/99ImqtGW@hu-mdsor-hyd.qualcomm.com>
References: <20260804-lt9611c-v7-v9-0-3423a76856d3@oss.qualcomm.com>
 <20260804-lt9611c-v7-v9-1-3423a76856d3@oss.qualcomm.com>
 <20260806-gregarious-swinging-cormorant-f666e1@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-gregarious-swinging-cormorant-f666e1@quoll>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NiBTYWx0ZWRfX4PN+SLfmQISg
 p+EAdlc6+ZliTmBR/EmReypkSh+z6n+T5jscrFvGGCE/c8ju7N7gWlHic0R38G6evmQslp9hVpk
 qHFFH3VlfqO1p0t6owcrOZHqH9TKr7uClUvUtwh5xzxsmPw7Dqy4UPuZKLHF+gtCPsYNqWUaRx+
 Pr7DviaxkLLrPhFWFWdoFsLoAHiJNaphN59GXLDv97HvWlTmCv9yLuyIn7ldS3wbQ5R9pK0bQQg
 l2iAUQfzf9eysNWGJpRNmYVSn43srgy8ZpTtcPHao6pRvdMcVdm8VINZXi+4HH5zqir7mb+plqR
 k3IhHbtVSsXUhC3nmtouWt3CDCTBxs+/66g//gnImdz09Fkqvhm8hlgTrDCpveix2n9CiAKqJ60
 vaTGaPt08Lye4Lf03xavVSG75z3yuJSk5LncQNHPD3dEioGPWzA8McFcIOr9Pcq6hi61hANgexA
 5fkn/fnVjx8CZ6GGVGA==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a75adde cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=JFLwbLnQxsueZ3v4IKMA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: -4E1SmiU55boBV0_iWpvDVdkDRxGXsZB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NiBTYWx0ZWRfX7tylRHMw8nbx
 YT5msFgSisAFiVTZvhXMMTpdR4kZfA3krivXvdQ5kTsiuKHpLNmQoUpIhtB1YlOKPObJFkm+g1f
 pIxl9lRfOabVgQvk6ZBQpLNkJ0slda0=
X-Proofpoint-GUID: -4E1SmiU55boBV0_iWpvDVdkDRxGXsZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070076
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

On Thu, Aug 06, 2026 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 04, 2026 at 06:10:14PM +0530, mohit.dsor@oss.qualcomm.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> > 
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > 
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > ---
> >  .../bindings/display/bridge/lontium,lt9611.yaml        | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Thanks, Krzysztof.
> 
> Best regards,
> Krzysztof
> 
