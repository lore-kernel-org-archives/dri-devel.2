Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED52CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840DD10EFF1;
	Wed, 20 May 2026 13:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y2xNKsMY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QGHm/MDu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A9910EDE4
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:26:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KBrgdx2983950
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vaQoESsHm3Fjd/yTXvUGh2U7
 2xcFTmSwrslZBvyqdkY=; b=Y2xNKsMYNtBOg7oJDZRcWtAT5+7On04gsPDJnNEk
 D9Ac4J3+LJu3ZTmGxIKArpVdlMZedEKPdAzGd0/3WJWgznfsaP/tPcWzWMpTeAmM
 lcKIEXgOXtH/s3Td2f/loPXrjXXDU/gVtsYNXabyD8POWTlQIeiIdxI/j4ky9sFV
 LvY/3qYL0eduYoCEgl91QKppuqoQfu7VxQPrYIdFNjltl1nt4v25CBaV2IgMGH9k
 ov4pQe4+OWVavnEPEENQSy7FmFTyqngn/YJ+QBkPG3YzJT2tCxw5T9/8CU5LTsDl
 VTzjuQ4ns4n1DksudrLHdNzvA2mY0tHhjhxESoPQ2p2CKg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4yws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:26:55 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95d25cc8f5bso7897611241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779283614; x=1779888414;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vaQoESsHm3Fjd/yTXvUGh2U72xcFTmSwrslZBvyqdkY=;
 b=QGHm/MDuFJfw9ehYttA/blJjy9rkHJal7SKDEb/66aaasTsgSjSWKFp1JSZ1U3kWNL
 28Wp7B3jib+Ik5CFwJDW/AaszkWYctwFcH3H163rAiJbWu6GNNi7iN5YmxWX4YD0hoAm
 7jWHlHkeW+CpI6ojTVLc2NoaXF/vX0Tz5+HavR9KKNgwqmJv+WZX0o7Pgd+mYfgPVbWc
 +mwKyqr9QWDoEn8sjaXU1+42HfszJoxv2GmaUBeyPnIjELG05jnWf8dTZrMSkQTL1x6s
 vwbunnJdZ2ahmmvxjE3PZ403vUlALs3dSltu+Xc0QoxN9t5XYQA1Z3hngZy8SV0YpKhX
 PiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779283614; x=1779888414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaQoESsHm3Fjd/yTXvUGh2U72xcFTmSwrslZBvyqdkY=;
 b=f30L4iJ3d0KKX+dwvHoyugh354iyrAoWr+S6Il2JmCypGBmIS5yw6n/3uvakJQ7hXb
 JkdhzIAHzfVSQDPuAO1WNdwWesj4B19Ez5jpcIVuSTvMlINam4n+As0jYxr4JRwJ/g+S
 syVizowUXxgljZ+QaO4V7hzmtJhL/5UJs8tYaVJiW1XQ4tyyo61slkcvtojVgObBF/Q7
 Wvzz6kT861Tx6KF87zzzD/vnfwr7jXXzNjWKEphrCPeMcOC4MlqATHglGf59cy5LNK29
 +UFg6Tb/favoMWShGHRpK8H/Q8S2oqJify60fbnz1cjCn5eEXAF3TtdijLRfV6gUzHJg
 bEgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iyz/1VtPDnKYYOcJEIERt6q9uosDFgtisx09SIUGPx/cXz0MUrkb2pzt5MHt6qmeq9XJypiREX7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL5lunQIV+1i30p0teaiaKnbUkP9hW6Ma26rqGlLNJ+wy1+mG8
 teFHukTS4hQ9U4KDeNqNYEi+Xj74x+zFxVrhVQjPiKaZ0cA5MEDFluQC44cfBwIT2lwzTSsNOib
 t4oPxTlxRxCV1Fesm9q90FPrSSZLQe0N06YwHqECJWor3wgwLDfAdJC76+qVx6JCjocl5l60=
X-Gm-Gg: Acq92OFWrUNV0JQi4ituV1QEoJ/8UZDZh7t9UQ/0gmz4WgPPVUd9BuuqTMkDIjR5hH/
 Isccj85oJtaio3EdaVCqH2aSklWPy3EmoUwSj+zpP0gNyQbO8TtyBrqU1tXPNcVNnvUJZy275S4
 C6s+U37UH/WyYwMJMJF5DTY7OeNElMMVFHmBGf/OEP2dyZGlq80gUqZaWvkZSSJ8V1s4vhg/ZTZ
 R98euozarSEkBUrv6f6WlazoCdX6AZlbqi5FmrlKjDxQoESlZiGYb5lNHG0X7tu+fN/Nmn4AKOy
 Y5b6qpDfwqtU5QOpYETwaNTN4+gJiQzec1kpdg/hbsqzqt4nfK7h3AT5WuQAXbvkE4o/p0SU+V4
 tY3Fdjoh52WvxxmeNJZb6uRyp38LfNTA33ZCC5nDYlYF/mvqASvGC/XiuUu/umTPgfYAM/SYa58
 6CAxVpgYpxukIWP7AfBedr2OqjGA1gy5mArAo=
X-Received: by 2002:a05:6102:511f:b0:631:4e25:5e40 with SMTP id
 ada2fe7eead31-63a3f698d43mr12171724137.25.1779283613908; 
 Wed, 20 May 2026 06:26:53 -0700 (PDT)
X-Received: by 2002:a05:6102:511f:b0:631:4e25:5e40 with SMTP id
 ada2fe7eead31-63a3f698d43mr12171674137.25.1779283613354; 
 Wed, 20 May 2026 06:26:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958828151esm28711551fa.3.2026.05.20.06.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:26:52 -0700 (PDT)
Date: Wed, 20 May 2026 16:26:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Ayushi Makhija <ayushi.makhija@oss.qualcomm.com>, rajeevny@qti.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
Message-ID: <yn7rwuguaqliovlyukcj2olxby7zerv57na3jf2pgbke5zgahk@aasd4ojwdy2u>
References: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>
 <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
 <20260519-curly-courageous-sturgeon-2facfe@quoll>
 <dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BOCDalQG c=1 sm=1 tr=0 ts=6a0db69f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=b4Uryj85X3Pt6JUd_SgA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: JU8K5A8pg5VQ6tcITnaP7qQ0Eo8-0KaY
X-Proofpoint-GUID: JU8K5A8pg5VQ6tcITnaP7qQ0Eo8-0KaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMCBTYWx0ZWRfX1x6AwLGyiqI6
 LuoBS4kbhL7bnz3TsKcMm1KYvK2EMqixaJsMIP9WKvBOvMrHv3CMhUDMygiB1X8v6cRSZjojusU
 mp9fe2LSmZ49aH9jsyViNCXoMZeGgqvUZLPn9KIvmNAYyv2EdgQS8m9Y1oDG9bL33QvOD4Irn+a
 TFx8xVmFntkwqzUrZEEXmlhu9R3kYP+1idlwoEazC3bsVV0myKzix5s+Ni4WyMQz8ITaxXZ7j2r
 IiAoR5dFyc/Irv8eoPHUIzfba1qdLAvJChrfMgaawvVj3H1Kc4zyetys4NWjkkQLoBCwvDNire0
 JWUWMqUZjQ0idfsUh1EuwD0m8OsBPncLGHRSXb3vzYOhtpvxFMxNcofeRvLtsHECj+J8IopgBH6
 SevzyUYwi/g4FG8mVLQtUJ53Hl3OFInsXLsnoTMuH82qgr5rDU4hasVpmho5fCCkgYZY1B5ct35
 tHOTYYpPjKEznQCfwpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200130
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

On Wed, May 20, 2026 at 06:10:57PM +0530, Arpit Saini wrote:
> Hi Krzysztof , Dmitry
> 
> On 5/19/2026 4:02 PM, Krzysztof Kozlowski wrote:
> > On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
> > > ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
> > > The DLC DLC0697 1080x1920 LCD panel is based on this controller.

I can't find this panel on the DLC website. Do you have a pointer to the
product page?

> > > 
> > > The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
> > 
> > If panel requires it, so should the binding.
> > 
> Ack, I will update.
> > ...
> > 
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: DSI virtual channel
> > > +
> > > +  reset-gpios: true
> > > +
> > > +  backlight-en-gpios:
> > > +    description: Backlight enable GPIO (active high)
> > 
> > What is the name of the pin in ili7807s device?
> > 
> Display daughter card has WLED driver as well as LCD bias driver.

What is the display daughter card here? Is it a Qualcomm board or is it
a part of the panel?

Also you wrote a lot of text, but you didn't really answer either of the
quesitons. Is there a GPIO on the panel connector that enables the
backlight? If not, this is some external supply on your (assumingly)
daughter card. And it should be modelled accordingly.

> 
> The WLED driver's Enable is coming from WLED_P1_EN and PWM is coming from
> LCD_CABC output of the panel.
> 
> DISPLAY0_BACKLIGHT_ENABLE (GPIO 91) of ITP baseband card ==> WLED_P1_EN of
> Display Daughter Card (DC)
> 
> In the display daughter card of Shikra ITP platform, we are not using the
> external PWM for WLED driver. But connected the CABC output of the panel to
> the WLED driver. Backlight update is happening using MIPI DCS command which
> is driving the CABC output (i.e., PWM for WLED).
> 
> Because of above HW configuration, we need to enable the MIPI DCS brightness
> update on this panel. The below command of dlc0697_init_sequence() is
> enabling this.
> mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);

So, this should be then dependent on the presence of the backlight in
the DT. Either it is a panel-internal one, or an external one.

> 
> 
> After checking this, I realized that this panel can be used without the DCS
> backlight as well when it's using PWM based backlight control.
> 
> I can add `has_dcs_backlight`  in panel_desc and set it true for dlc0697. I
> will update bindings and add backlight as optional property.

Why? Use backlight property instead. It's already there. Anyway, you
really, really need to describe the panel in the bidings. Not your
daughter card.

> 
> Currently "backlight-en" as optional. I will fix the commit text as
> Krzysztof pointed out and update the commit text to get add more clarity.
> 
> please let me know if you have any comments.
> > > +
> > > +  vddi-supply:
> > > +    description: I/O voltage supply (1.8V)
> > > +
> > > +  avdd-supply:
> > > +    description: Positive LCD bias supply (AVDD), typically +5.5V
> > > +      (range 4.5V to 6.3V)
> > > +
> > > +  avee-supply:
> > > +    description: Negative LCD bias supply (AVEE), typically -5.5V
> > > +      (range -6.3V to -4.5V)
> > > +
> > > +  port: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios
> > > +  - vddi-supply
> > > +  - avdd-supply
> > > +  - avee-supply
> > > +  - port
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    dsi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        panel@0 {
> > > +            compatible = "dlc,dlc0697", "ilitek,ili7807s";
> > > +            reg = <0>;
> > > +
> > > +            reset-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
> > > +            backlight-en-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
> > > +
> > > +            vddi-supply = <&pm4125_l15>;
> > > +            avdd-supply = <&avdd>;
> > > +            avee-supply = <&avee>;
> > > +
> > > +            port {
> > > +                panel_in: endpoint {
> > > +                    remote-endpoint = <&dsi0_out>;
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 26060e51c067..529aed669401 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7941,6 +7941,13 @@ S:	Maintained
> > >   F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > >   F:	drivers/gpu/drm/bridge/chipone-icn6211.c
> > > +DRM DRIVER FOR ILITEK ILI7807S DSI PANEL
> > > +M:	Arpit Saini <arpit.saini@oss.qualcomm.com>
> > > +S:	Maintained
> > > +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > 
> > Drop, unless you handle patches for this driver.
> Ack, I will update.
> > 
> > > +F:	Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> > > +F:	drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
> > 
> > Drop, no such file at this point.
> Ack, I will update.
> > 
> > Best regards,
> > Krzysztof
> > 
> 

-- 
With best wishes
Dmitry
