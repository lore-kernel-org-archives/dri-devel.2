Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D035FC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFAF10EBA1;
	Wed, 29 Jul 2026 11:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIGCXOBa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEsdjh3h";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC0010EBA1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:37:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBPYOe2093356
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JuKTV+oT7PmTQiu/vwLbiWOH
 3Hnm+6HCgD4PAqwboi4=; b=eIGCXOBaDq/Zp7sSl4VKuXuBoKeURK9h1aUx1Qdf
 WxYgF+TOi0SFUK3WUv0HFr8eROt7ET2YJE3RhAVVBI9c0Y4inDjpj2gtkXTmcAiO
 DSaa7US8bmg2Txje04V9JdOnh4lYwbXrf7+veFWnJU2kX3LP8SINp1M7DiEuVwd+
 TiNYsL1mDBf5Mnto78xbwxEQOUwv2LwQ6uLO+S9lwLeRq/1/hZkVXMW8hnI/HH7l
 e77HEm1hY+J/GOItZeEKhTQaa38ieXVOPbc3WQGkK9y66Aebmr4pJ7z00pJSnF/q
 hPyf+IvN4B9k3GU3xrV2t+ogec+uLgypwtw3d5kl7tgWQw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgmtg1gp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:37:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so1330194a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785325044; x=1785929844;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JuKTV+oT7PmTQiu/vwLbiWOH3Hnm+6HCgD4PAqwboi4=;
 b=WEsdjh3h5sQXMwmktQM0G4RsC07Ui1WUSCYR86MGy//Q4fB/xVstd4ecQdzm8amwbb
 2rKRHEBm2OzPz+eozrRS8KvBbzJRsYwMfmXVkJ4qwbsFkgGKMIupyK2vcErirSGP+Bqg
 TiiyY+k7DjUNkJtuojD9G7LkquUr/hqLY5v/42xjslx9wfTfr0ZieGiIAuWqReTk/MNJ
 H0xRWOTGdpHCpsWPEe0ijNgrnckXI9CqDxFLGy8MbFB7z13VAAxEJ6AN7+e2/uiGXrqL
 65IKgKpdBkSCvcX7xCPL7FDRu+vMyJ/8SSfYXISN5n/hDE95A2L2K1F6QxcBpoCza/eL
 DBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785325044; x=1785929844;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JuKTV+oT7PmTQiu/vwLbiWOH3Hnm+6HCgD4PAqwboi4=;
 b=AXN773XRqEWidDKGUBZYlZoGLLelhpMPEJFOQAbjidSktdR72evukEUtSuwyLHJ0OM
 hBzXX68Sy8oPeVL66zhE183cQsfADYs5BgT0a/4JyntfiDl0bEJ3dR+2rBv+s3MtMLYY
 SQu17w/hYb8yfqHRX/Z6hrL5e0EK6t4Mg/nz8HqlQHhjXK8KGWCLcl9GhJe891vXr+CX
 u85nHazM6/qxYoweUSyYuHzfZ3edagekNGCOk7mecpObN9CSUnnAsV48nl97BnW3e0Cj
 vNBxS4nP0acdfQGr4xFDEPq5fqll5qYsxJBGNxs0BZ2BGLtaMk0d76SwtN47FKREegjv
 v6Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNPJDj0MHLYp8t4m9wXWXegrNgyFGoo+pXS7VFBVINatB55l1o+M2NUSdfigX6BO8ruIcmsyvnipE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGRCLT4lBQ2oDqC87pWdLubgC19exS6jcWTSj8H3PX7xwXyEC4
 1dsqD5orJr3f3BpbVHbEt5B5iY2la0sp8V5WoFSRghv+U0bsmPT4bIvwrp0oj3vTLxJv73qUyNF
 J12xaHZsrb5GqxOlP3rRiMZoT9u/Nvklnb5L1VlCeLEJnnLLMp/7SyTwGha+8ALbdsuj8VLQ=
X-Gm-Gg: AR+sD11HDfFS3HzMVMYkrl6kHIjwQUGz2SEo/iTwG6nCJ0+uwgproz3kK2Q/K8DIxiZ
 D2UcObKZhHsvxg2CV0RvWcRsjbHJKXEMeumV6Zqz0eMxTroSrdM+Zv4Ow/5rr8wr5Eb0zm2EV7F
 IfJbPBKfL4fzey4Rr6wP75LKtLfVvZhCo8MM0naMZJg3QzS/8fKWtK73RVdnZSYFMPxWKa876FJ
 lwwNOU1fscZIONa/mezvA1JDg6qV5BJvILxDaBSA6yvVe9Amx3XRfdvoOggY2lmImco7a3gl/en
 9PQuG1yLGT/2lIezvW6ogc/7Wqgyk3N1Tc44Hi4SFKnu2N1j0JFzIxtGAhqLfDwdWcZuFaHM49E
 xVKjys3mMnKKQnHk0mixuLZ38HA==
X-Received: by 2002:a17:90b:2701:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-38f6a4585e5mr6625880a91.10.1785325044118; 
 Wed, 29 Jul 2026 04:37:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2701:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-38f6a4585e5mr6625838a91.10.1785325043665; 
 Wed, 29 Jul 2026 04:37:23 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504db2c4csm9199730eec.28.2026.07.29.04.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:37:23 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:07:13 +0530
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
 Jessica Zhang <jesszhan0024@gmail.com>, Mohit Dsor <mdsor@oss.qualcomm.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <amnl6SENeY3jjBm4@hu-mdsor-hyd.qualcomm.com>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
 <114159dd-0271-4d15-b07d-20fc1e28ee6d@kernel.org>
 <20260729-truthful-cinnamon-giraffe-f250d6@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-truthful-cinnamon-giraffe-f250d6@quoll>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5NiBTYWx0ZWRfXyClu6SN8cdrh
 ecv+oCLbASTHW04v8Wo6oghez3g0jVgCdguErrDTmG33R7ayTTwCixQICv3+KZ1yCIQzuZ6xxJk
 Lo0+Tq8nm+dQhT9JIyM8tQk02Kadgt0=
X-Proofpoint-ORIG-GUID: tld-Cw1lz2D5PHZ33wWK1p9TFgTc7okH
X-Proofpoint-GUID: tld-Cw1lz2D5PHZ33wWK1p9TFgTc7okH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5NiBTYWx0ZWRfX7taF4L2zE+IL
 lLc12YEpvXcd0WJBQnTRhXn2Os6cLHviOYjN39UTNY7CUMeYw9AxS0LuUkunn9JpEy5jB+YhhP+
 hC1xQkY363CK3KAVDHYe9xEq3qojUEnMQJIErELCEv926qQjb1EIM2VmvDqHpvO+t9XfSwT2k74
 dus8vZ/jRSATf+KI13HQqktH7X2KBmrNzLszlYFU8oJokcEZQFRTEJLCMRQxQkyOowVxHqtfNKL
 xrfiVeXi3+iL4GmXnaxsKQ695MaYPl3yCJxwQzaSi32bTnTxsdNVa7wUvyPOxQR5nltu8bPFFke
 Grz11XZIKwgqf7UUQJVbyz5sM5lNUaIaOFz+VG2hMHCldiAACFcZAPpuocZAJmo7cupEJ82XI1W
 lebrUjy9rbcg8JBdOs9u0SvwdUKOFrMQ48iCLcmtxNCJf1MMBCETiVn9oJaXXjxpzBb/g4FA8SV
 2W8o5SdvxCoTK9BWKkA==
X-Authority-Analysis: v=2.4 cv=M7197Sws c=1 sm=1 tr=0 ts=6a69e5f4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=9bdzyRqNf_OfPh25cPwA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290096
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

On Wed, Jul 29, 2026 at 08:37:42AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2026 at 08:18:58AM +0200, Krzysztof Kozlowski wrote:
> > On 28/07/2026 13:09, mohit.dsor@oss.qualcomm.com wrote:
> > > From: Sunyun Yang <syyang@lontium.com>
> > > 
> > > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > > mipi dsi and output hdmi, differences in hardware features:
> > > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > > 
> > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > Signed-off-by: Mohit Dsor <mdsor@oss.qualcomm.com>
> > > ---
> > 
> > NAK. You received review. Sending the same is wasting our time.
> 
> Actually you ignored TWO independent reviews, so I will not waste time
> on this patchset anymore.
1.
>> So you need "if:then:" block disallowing port@1.
>Ok, need to add in driver code? Will add this in v8.
 
Sorry, I missed adding this in the bindings. I assumed a driver-side check would be sufficient, so I added the following validation in the driver:
+       if (lt9611c->dsi1_node && lt9611c->chip_type == CHIP_LT9611C) {
+               of_node_put(lt9611c->dsi1_node);
+               of_node_put(lt9611c->dsi0_node);
+               return dev_err_probe(dev, -EINVAL,
+                                    "LT9611C does not support dual DSI\n");
+       }
 
 
If I understand your suggestion correctly, it would be preferable to enforce this constraint in the DT bindings as well.
let me know if this is correct approach for DT bindings:
 
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -82,6 +82,16 @@ required:
allOf:
   - $ref: /schemas/sound/dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lontium,lt9611c
+    then:
+      properties:
+        ports:
+          properties:
+            port@1: false

2. These are some odd characters here. I guess this was in earlier versions
as well....
I am sorry for this, I missed it. I will correct it in v9.
> 
> Best regards,
> Krzysztof
> 
