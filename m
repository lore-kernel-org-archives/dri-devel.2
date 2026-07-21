Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977A5C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E093410E347;
	Tue, 21 Jul 2026 13:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqtjO2F7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eRc2N8H9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA2F10E347
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:54:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg7wd1958773
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YNbDulAa1I+AbKFTKUClc7Hwh6v/gjl6MCRbbkrXRFI=; b=GqtjO2F7DqutUXGu
 IGh4Zy8RyYG2knw2smRWSwMNamUqzcbOf/D+c1ZAgozDJY2jiAjQ7fQxXjlGaRVS
 O4Rk6pHglewkWirb1l1CxLECDtWO9i3X2u+W66AI6JQLNE6/eZhKOQERJYbeF1nG
 NY884cqM7n6wl6h+9PvYAoAq+2BIAu8uYp/tci88ByK0B83G8JYzKcYlghaTvVLK
 +vSOqDYm7ZKZtE6PNLUJDz5FuXXFMS7yD2ywya2h6Q92HY0JslLhnK83aQF510Oe
 qAJh0Y1pZY50k+WfUlBehuf01+Qehpk+I9Kc0pbDs2DgQBEPMm8O5xtukLX2H1xz
 XuNHfw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvtqde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:54:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so7928683a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784642059; x=1785246859;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YNbDulAa1I+AbKFTKUClc7Hwh6v/gjl6MCRbbkrXRFI=;
 b=eRc2N8H9Ht9pfg9Xj08f5Ydqvo6PhAG7sE7A98KKTftzQH6YTzV06rdcI2kisfdqXb
 j8dfKUjKyTFwZRSzpOuPd5Il80wdtGBoZRW262SyEtCZPNhv7fxj5Bzm6CbVtSgs8MpA
 Tot9v4e3xTtRFNOiyCYowqDaBqoLdaropgEdEQTv/xy5qf35oXmMhlnQtJVVBWXZJON0
 SISCRg+d9DYPjwMoZdYg0Yv5bizp2YQo7iQ54aJIyLo9VuA/8/iaQ5uDcFegpdxyDfaB
 u0QKvS6lRyEEGm01FC2iR+LOyX9he52u7w85OsdjRnXQM4/Jqcw3rQmt7I7/5Nni+zAq
 +djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784642059; x=1785246859;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YNbDulAa1I+AbKFTKUClc7Hwh6v/gjl6MCRbbkrXRFI=;
 b=LQfVnLixUpmqH8/MuSr3/lXu3hpH6nebfvWE9jGarDb2U168+s5Am2v9WT3Ks9z0DF
 gnF5ni7uzUckwr61GemdoCubxAk+VClff4PXMHs9SY793rS2/WqjeYNlObJ9lkWGCq8w
 eP7Rd0m+KqN+m0J+gW80LbHeYOBx1yn6q3l1w1PqG1Z+m1I+w4jCCLfGMpWdmMFPatkZ
 qioIKTHJReHI1FBoNDWzOw52B1Gszovn+uyN5qYavrwh7dr91JKzSf7VOSUEVpD6zCB/
 Q7E7zRwgYuBldkID9CPDETaZ/MI6YnTelnAmlnaubr20Eftoi7Y/3u28rG/Ky0e0iOA6
 cL+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpl2miBGrfFGw7/nvGa+rXkA9aVre9neZjwsCX3h8/qeoAM1d9sasW+92MzF93gU0oVIQQ8+pIb6q8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0/+3q+38+AxmM6H+n3Y3ZDMBlGM2fWIk7GH8c63LmkPGXNrtT
 OK+7NE3DEPB54/DXOXQhfJWDowxIiH6MYKCwwGXkIaPsuHxroLAZhU8dQvQijfu0oMsuuD4Rgpe
 7VSDr2VknDDpsKDZqIUSknRm6z811Ui64Gq1JGIXHImeIyLIGrsAjfOeAbIzLsAYNpSXR+pz5Pp
 aV+OU=
X-Gm-Gg: AR+sD13xGusXwO/myixxoOPcsOwK+Pt5S2KkwbJxGglVXh9wwd765wk1WMWFAV3aUjg
 24XiLVk2LY4XyG7zJ55DO/TJy03G/+HTcA7IHQQbY/YBWFlR1VX6Fbt+KQeBfZJ2GlZ3RD673zj
 eHmBixk+/2s2EMDPVZRJGPGu10BeDdPIfwnvLHirzzemDkK0iI+9shmE0fqV5/NEJo/QAfZlBU5
 dM7jts/h5GBN90HJ9cBJgKu/PvPXwALluhCFZyfMKtANkKyFbHbGmXQ+uhV33yl1Iwz3mD/TAH1
 1EGyzZHkTSk+JdjYHP6sNTmTmSrPyeDFb2u7wWg5NiRcngOHiAdiUubkbN+iWz1C22DdcB3Ly9a
 ka9BvVqQWM84fkX14/GeTfo31kw==
X-Received: by 2002:a17:90b:4f89:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-38e4b40f926mr19219111a91.11.1784642058554; 
 Tue, 21 Jul 2026 06:54:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4f89:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-38e4b40f926mr19219082a91.11.1784642058084; 
 Tue, 21 Jul 2026 06:54:18 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2900a37sm39019725c88.0.2026.07.21.06.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:54:17 -0700 (PDT)
Date: Tue, 21 Jul 2026 19:24:07 +0530
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
Subject: Re: [PATCH v7 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <al95/zd0JTOv8UY1@hu-mdsor-hyd.qualcomm.com>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-1-7553a14735fc@oss.qualcomm.com>
 <20260719-sparkling-musical-lionfish-bb9d80@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260719-sparkling-musical-lionfish-bb9d80@quoll>
X-Proofpoint-ORIG-GUID: P18hnmZenv1YKXkNMLgNoduChOhXBnt0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NyBTYWx0ZWRfXzsUGLJOYZJIE
 sIrhr/VzaSCgmDsh0p+g7VxlO+DQK2WvL7jXOHRc2H6DlfcyyMKBy0NOHV42I+8B76YeSee9RFC
 3Qz/4PqTRLRtAqIglJnw5GatN6ZNRsw=
X-Proofpoint-GUID: P18hnmZenv1YKXkNMLgNoduChOhXBnt0
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f7a0b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8
 a=UgQGg25I8tL8cNqpnCwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NyBTYWx0ZWRfXwP5r5wt8MG6e
 4SybLBO+yCX7HwFZC4sp90Bx2G2jV97HfEobejcE/sJQOIdPQLNhHYKA0tVUAKwdgPefZVSIge3
 fqc2sdSiiTjUiqQTBBSR/ocegopb3DlwNkqOyr/XPHNC8LZs4kmXKCK59Garxnf+ddQDjERRtKh
 2P5CogkMgmU0yZAxKsHH0VXZAPZxaOnqnD18sLgprU9byYof/Ga9bnHl8dzPv10tLcGo9Dhye2v
 RjpPfMjLdXhr2wtyvMZnEzOsEwGyh4Di6TB8wqEia5HcpNgvjf9RS4T8VFCNfin3ZmyF2CPQ2vf
 pgFo2gG0gaK/3JaGV++fREK4KRG2M6UO/WxpeD11l1wAP5JqZQLAhrwWEV9nGVt0JyYj/M46fFo
 E3f61LIXWMQZBY8ibLnEMRPHDhVVnRugPe5aQB/IPwre6ScN65BynrLrTXdX6uaDySp5aqawyNt
 lN6Y99PVFs/t3dWEAyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210147
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

On Sun, Jul 19, 2026 at 08:36:51AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jul 16, 2026 at 05:01:09PM +0530, mohit.dsor@oss.qualcomm.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> > 
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> 
> So you need "if:then:" block disallowing port@1.
Ok, need to add in driver code? Will add this in v8.
> 
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > 
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > Signed-off-by: Mohit Dsor <mdsor@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/bridge/lontium,lt9611.yaml        | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > index 429a06057ae8..e0821a63d9d7 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > @@ -4,19 +4,23 @@
> >  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> > +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
> >  
> >  maintainers:
> >    - Vinod Koul <vkoul@kernel.org>
> >  
> >  description: |
> > -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
> > +  The LT9611、LT9611UXC、LT9611C、LT9611EX and LT9611UXD
> 
> These are some odd characters here. I guess this was in earlier versions
> as well...
Ok, I will fix this.
> 
> Best regards,
> Krzysztof
> 
