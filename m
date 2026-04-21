Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F7EF8925C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E740810EC25;
	Tue, 21 Apr 2026 11:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDZ1x7dA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEhwMT3q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4300910EC25
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:08:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L5fplk1012009
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MSKGPyTIVnf7CS8YuXLCet8XHrDFl5o/w9bZgb2MKfQ=; b=WDZ1x7dAVaEjT8Fk
 fxK18G72dqrq8lYLZG8C8SDp6HMnCuhl3bOnIaXx446v7AMZ9TT6TnTNNFe3b7EW
 /t7tPu/4cu2V+V7ZKCiqx0MZQL1aHksPedL6OE+QqdxaTWKwQrPgWHsfB+h842xB
 PDKz6oq8wfRIL+klKD6uvkpNObGpeleN6OCSU0/qPL8Yhg9CsbuImut9TfSA0mQx
 JZ94qA47VOguqmACih+Tx9K3rhj25CpaLO6mjPKOWHpLcNvrV0bxx703SFCFbf9B
 xowDvsql4dxllUnqzELVqpCm1yB7AI1r90sOk6HLhG/QL6MbGtKZfZ4NqMcTwIVV
 x9AT1g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt902v50-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:07:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-605e5d95cccso3300489137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776769678; x=1777374478;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MSKGPyTIVnf7CS8YuXLCet8XHrDFl5o/w9bZgb2MKfQ=;
 b=IEhwMT3q2mGwRMtju2Eeslb9dopvDt8VFnL9S2zr981S5cz0L/SSrIsF6aKPHO2U2o
 EyUF1EGXeEBwnZVDPdSSXpIz7Gt47SuE5wgVFGlAvPQ1q7M34n2BXoUOWqCBB/zzw2lE
 zCiu0h6oDLJ9Zl+lR3Ynx1d5m0sd3yTMAkrs4Ivcter/ijTL+SR2NtNCL6Cs4YbhgRFk
 sfLHmIozsL3PD5vOIDhvTQP6CR4FL651BGRqbKTqRd6kYjBeeAejhLCgPSAnaA/Nyxc4
 L9gcpyQYQDwJZ5i0gwZ5SpJOp7cwrXcR4orxyxEuTmzehTKb15rQvhCagtP3axUASk7y
 l3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776769678; x=1777374478;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MSKGPyTIVnf7CS8YuXLCet8XHrDFl5o/w9bZgb2MKfQ=;
 b=GbUa22oX98C1WvQkYdHCSP+M0fNUihDjYUU2w9tL5Ul0xoYD9wvVmP+67SbIBhf28b
 qN+NtQYk6tABgdwA3lSDUH7e9JDDLK97iusI+BW2mBYRGe6RP2mcGhofStO2pfxaXGuX
 XMoyEAAskzck54PxLlIG90RPHMIttpoxpUpyjXQ1rVoBO+TnwXhvCjp+DTaqzDZTxHC9
 hm6RLsb3oC2B2LeuIOeGkS/gASkvfwf96JBHmbZLgYutqnYyOSGkflSZ3UYdTVQho0T8
 pEVf9Y4jZNg17F0xLj0nZkbXyJveQ6MU5EMqe9H7+Ctos5pi/T3oqV/YG7qr0z9ZdhKK
 mWlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8p0kjHxL24CAMjv1aHVzS+izMSOfYHH+OpUmxeNlw8uZD5BDQZB+phY7ME+7SjCn5As8HmWtzAscw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIonng0JAb05riFNHJ6g4qjUsOnac7DPovGGaTdo/C+fsuMMkv
 mB9ZXv0lF4lxgl3PTIxH6frPLiKOAoDAyJAKEhEBy9VDqjAax0zN/oS9ZmxHqKhEoKJOhi1kkIM
 tglTcdewT/IYsDaBOSPg8qs01wQIE5P34AJ6/lzZZf7s/xdPTmHkZyBPq0oIvf7s2Ff0otzg=
X-Gm-Gg: AeBDies4hylj0WHKagbK795V8pbvE76I7SlgMPOdhWVJ+/Xfq/UTxNnup0oZLXkcddf
 dp7auwq4QNMrhjkVDEuUEaR6gwbRHE5zBzzt4FaOnFrn8kQ1S5X2stABDgmo/ENOvknyQYj26oX
 sh96ILCBHYzXzwImEYXTmKiaKGe/imcNYYLhCsn82FRoXlyLac+1TO9yFtVk2/v4S5C+QVXgEIc
 CXWzluXL54XrfXzMEYjdAj/xXHv8p9O/Ejujen1BnGUsTZvymQJSfS1hf8gPMXFhWY9RfWqdd+U
 bW4kQPs4n4YtvMqUBGCRsvTUeMzmf2cfpRt3Jwi+8d2kgRVKoD1HVqlzZqYsVlRchbYpPWTMcVJ
 hb8KcpBZ+hyXQROkvqaIQsV/bPA74oIUxcVWV3ktvbEvCfAPMdf3NhSOfj6iTrIvxV7IhRQ8662
 skykLenEcZGTiczbMeTibSKi74xFEoYJQxW/IhPVD/yipwsA==
X-Received: by 2002:a05:6102:5987:b0:602:86a6:9877 with SMTP id
 ada2fe7eead31-616f68d3997mr7735213137.19.1776769678563; 
 Tue, 21 Apr 2026 04:07:58 -0700 (PDT)
X-Received: by 2002:a05:6102:5987:b0:602:86a6:9877 with SMTP id
 ada2fe7eead31-616f68d3997mr7735192137.19.1776769678045; 
 Tue, 21 Apr 2026 04:07:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb73aa8dsm28362761fa.35.2026.04.21.04.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 04:07:56 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:07:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH 1/2] dt-bindings:bridge Add LT7911EXC binding
Message-ID: <p3aruen3h3ddmzlqbdseksuqwuwvxa32qbi66yf4gjwdtb5h2a@xs3dleimg2an>
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-2-syyang@lontium.com>
 <CAO9ioeWhWemzyF30t8KDJht6_59b1Y5+GrH9nYCeKuPwddVLHQ@mail.gmail.com>
 <CAFQXuNbyH88Ab_LgfZknRxhK9QzN8Xe-G9NuRMuECZF_SrRpfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNbyH88Ab_LgfZknRxhK9QzN8Xe-G9NuRMuECZF_SrRpfA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e75a8f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=SyGcD3P3TnKYVP3v8i4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: Y_h1QbAWExDGrz597A19eYt54uhY2sKf
X-Proofpoint-GUID: Y_h1QbAWExDGrz597A19eYt54uhY2sKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMCBTYWx0ZWRfX0Eo24XSYX72T
 glJSgqncZLatqrYM1ZveJSkoSVF56J7a5PRKBBciiu33G2WjYAzrVD/Hk3GWV4XKEnm1WcFKhGc
 uTsukf1qAFtEDCR4B6lYxnsnXoqRf4+rA8C0c4uS3Ae+GkyxvHSBA6hwvXuE11bXVwTbKjOz8zg
 1fOKSpzRzh/c8eB4NYGASfGK2brjqvwPORzcwz5Ic8B3VyW2R2PXCgSiftpt8U3xcd13XMKlHWg
 CSegmP3UieqH+dKEL2xNdesY1pkzg9slLZiEQSlbOyMuaoGVrF0PoXRxi2WIR7FdYHVjyEsRzO4
 QJacZCv5WzOqgXKubFnDJdyyQ5tlO0XcxPirnZTI62gU53ssCdZx7C/3EbCAADvvxcXKeGwynhC
 7hBZT4XvoqwxUjfr+WmXd4G7QCE8qoj7dFQvdlN6uxGe7iJzDIKpnFKj4Hlb8pxKHpEmUwl0wkh
 /wDAcuhQqObS0QT0Wqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210110
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

On Tue, Apr 21, 2026 at 09:33:34AM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月20日周一 11:12写道：
> >
> > ote, your message didn't reach dri-devel. Please check why. You might
> > need to switch to B4 Web relay submission, if there are any issues
> > with the SMTP on your side.
> >
> > On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> > >
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > -binding for lt7911exc.
> >
> > Less is more, but here please settle for slightly more information
> > about the chip.
> >
> 
> It will be modified in the next version.
> 
> > >
> > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > ---
> > >  .../display/bridge/lontium,lt7911exc.yaml     | 91 +++++++++++++++++++
> > >  1 file changed, 91 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
> > > new file mode 100644
> > > index 000000000000..54a73d41635a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
> > > @@ -0,0 +1,91 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/bridge/lontium,lt7911exc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Lontium LT7911EXC eDP to MIPI Bridge
> > > +
> > > +maintainers:
> > > +  - Sunyun Yang <syyang@lontium.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - lontium,lt7911exc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description: GPIO connected to RST_ pin.
> > > +
> > > +  vdd-supply:
> > > +    description: Regulator for 1.2V MIPI phy power.
> > > +
> > > +  vcc-supply:
> > > +    description: Regulator for 3.3V IO power.
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Video port for mipi dsi output.
> >
> > MIPI, DSI
> >
> It will be use MIPI DSI,  in the next version.
> 
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Video port for eDP input.
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios
> > > +  - vdd-supply
> > > +  - vcc-supply
> > > +  - ports
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        mipi-bridge@41 {
> > > +            compatible = "lontium,lt7911exc";
> > > +            reg = <0x41>;
> > > +            reset-gpios = <&gpy8 8 GPIO_ACTIVE_HIGH>;
> >
> > Reset pins are usually active low.
> >
> if reset pins use active low, lt7911exc_reset function needs to be modified to:
> static void lt7911exc_reset(struct lt7911exc *lt7911exc)
> {
>     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
>     msleep(20);
> 
>     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
>     msleep(20);
> 
>     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
>     msleep(400);
> 
>     dev_dbg(lt7911exc->dev, "lt7911exc reset");
> }
> 
> I think the two are essentially the same. Please confirm whether I
> need to make the change?

If the GPIO is active-low in the hardware, it should be declared so in
DT.

> 
> > > +            vdd-supply = <&lt7911exc_1v2>;
> > > +            vcc-supply = <&lt7911exc_3v3>;
> > > +
> > > +            ports {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +
> > > +                port@0 {
> > > +                    reg = <0>;
> > > +
> > > +                    bridge_out: endpoint {
> > > +                        remote-endpoint = <&panel_in>;
> > > +                    };
> > > +                };
> > > +
> > > +                port@1 {
> > > +                    reg = <1>;
> > > +
> > > +                    bridge_in: endpoint {
> > > +                        remote-endpoint = <&edp_out>;
> > > +                    };
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
