Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E425EFCD0AD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF3110E697;
	Wed, 18 Mar 2026 05:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bpuOQ0xI";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EE310E699
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:48:58 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso26708965ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773812938; x=1774417738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RTBJ3ZdbKmtxUEiIDKVG3F9qt5sUaMf7IHNuSeINr0s=;
 b=bpuOQ0xIuJq8ponFRcOj2voj/zaCFmgDbDNnngTjVe6KIf14/xQvieNWgvUy4BsPLZ
 vHbCHzvo72BOu+vbe9bNcju+GPvp2BCwRmiMXmEqF0qOSFWkDdmtstpDUIKfxGbtqy36
 TPEO/K7Pmbgxebk1mTrGbCXTFeQNmNHoGN4r9nAPNXPtDXZLlQBSZMdrc7ry4ldzIGjm
 aG3I8e9P/WpHnNWNxSH1XTAx/A1ByhciLCKjZCSLMwqvJtgLoSCcetomtPufdLfXPTcZ
 jdlaD408YpHxMwXy96zkXkOykXgVW1GR73D4hkIDJYOvsOEisEqN7lgLyQe4cgFq4oLy
 XETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773812938; x=1774417738;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTBJ3ZdbKmtxUEiIDKVG3F9qt5sUaMf7IHNuSeINr0s=;
 b=YLwfsBIwmvIrXkgAsjf/HwwpAI9IgmMlKDSo+/wUjtlyUxY43z4HY9f83CcoLiuj3u
 6XKsGWZ6gIs8XJOpsWb8JEz22/Znyt9LOprYNmDiSf7ZIIJkwOiuX4QVMt2rSgr3+FdI
 eT5duVL/UZgTjyKmV6KAV23DYuEKG5JNZfLhmBJmMtB5anX8qNIufyM+n14KInDI3o2j
 5yzPWemDW9+Fn5KHYaKwCvT9tZdc+Zx8ABZTutS66QNX+sutTrii6w4JDBwNbPo6TKaQ
 f4mKt0JcrVuWu8yluOw31gdQJg1RDtN5UmNkoVj2FYdlv+e+VI0YBq3IdHUqeAAb/XE7
 oi7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEum9r+2VHNApcq+99mIGEB5m9uW/rKUhN2xmR6F9fH29qVwNadrg/OcQ9E3F3vycnHmKvHdnOVVg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRvbKvHQzfhSV9Af+dhrqqPkDcAAyrWZNMpNZHZGQWW0Z3xWmU
 k9BSdHeF1FsJzYJpxQZ7KBAu+zJvDdVzIHQzlJATQKQTc1p1B4cYmaZo
X-Gm-Gg: ATEYQzxVc06ef6hroc2JEhoLJk9IeFCDaCZoKaa7GJ8SFghT9z42JPpDSTUnNIoWRVd
 lFbu682wMp4xbScy5zH3SPF+YOtAUtxBPU1m3Pn1vJv+O9Cy844Gqe0SBc0B/feH67datxvgEPM
 Mza/+wuQ/+UF4MYeNoAJvldT+tlXwh1u1o6yyADC/XjubjWwTVp/5WqifT67GpWFF2e6/ouTHgU
 QsucYS4ZzjDlbhfatnQmDTlpThLEF5jq4mM5suy9bZjnwakuJNLtA+PGnFRufimjYL7UaxNOUik
 qpa3GcPYrS2hlVv+cCHAalAzG9RJgXmnIHEiBZNAlc82Tcq3B3+L0k74l+ZBrOZ18wo5CZEBqxz
 +Az09ZP6yFJV5f6RrJLa+pyb2obTEQH2jnaefLJWtzuHwPDFYoTZzXqRWGYW9prQ2cYFmTHUfSn
 EWlfjfM4ZsBm1MFemb19WnZgfK0YZT/Rw=
X-Received: by 2002:a17:903:2cc:b0:2b0:6d2d:f1d5 with SMTP id
 d9443c01a7336-2b06e401894mr19914475ad.45.1773812937654; 
 Tue, 17 Mar 2026 22:48:57 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0b92sm16471795ad.50.2026.03.17.22.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 22:48:57 -0700 (PDT)
Message-ID: <ff819e02-3ecc-4729-9c6f-16c74c2b23cb@gmail.com>
Date: Wed, 18 Mar 2026 11:19:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: tessolveupstream@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: ti, sn65dsi83: Add
 dual-link video mode property
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de,
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <20260312043743.261475-2-tessolveupstream@gmail.com>
 <DH0X5VHW15QI.XOHUGC314J1P@bootlin.com>
Content-Language: en-US
In-Reply-To: <DH0X5VHW15QI.XOHUGC314J1P@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 12-03-2026 21:16, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> On Thu Mar 12, 2026 at 5:37 AM CET, Sudarshan Shetty wrote:
>> Add a new optional device tree property `ti,dual-link-video-mode`
>> to indicate that the bridge should configure the device for
>> dual-link LVDS video mode.
>>
>> In dual-link configurations, some panels require the horizontal
>> timing parameters to be adjusted before programming them into
>> the device. In such cases, the horizontal timing values must be
>> divided by two when operating in dual-link mode.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> 
> This is not needed. Dual link mode is already implied by the presence of
> port@2 and port@3.
> 
> Also, the driver implements that already, and handles even/odd pixel swap
> as well:
> 
> 	ctx->lvds_dual_link = false;
> 	ctx->lvds_dual_link_even_odd_swap = false;
> 	if (model != MODEL_SN65DSI83) {
> 		struct device_node *port2, *port3;
> 		int dual_link;
> 
> 		port2 = of_graph_get_port_by_id(dev->of_node, 2);
> 		port3 = of_graph_get_port_by_id(dev->of_node, 3);
> 		dual_link = drm_of_lvds_get_dual_link_pixel_order(port2, port3);
> 		of_node_put(port2);
> 		of_node_put(port3);
> 
> 		if (dual_link == DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS) {
> 			ctx->lvds_dual_link = true;
> 			/* Odd pixels to LVDS Channel A, even pixels to B */
> 			ctx->lvds_dual_link_even_odd_swap = false;
> 		} else if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
> 			ctx->lvds_dual_link = true;
> 			/* Even pixels to LVDS Channel A, odd pixels to B */
> 			ctx->lvds_dual_link_even_odd_swap = true;
> 		}
> 	}
> 
> (https://elixir.bootlin.com/linux/v7.0-rc3/source/drivers/gpu/drm/bridge/ti-sn65dsi83.c#L895-L916)
> 

Thanks for the clarification.
For reference, the DTS currently used on our platform already 
describes the two LVDS output ports as follows:

lvds_bridge: bridge@2c {
                compatible = "ti,sn65dsi84";
                reg = <0x2c>;
                enable-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;

                ti,dual-link-video-mode;

                ports {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        port@0 {
                                reg = <0>;

                                sn65dsi84_in: endpoint {
                                        data-lanes = <1 2 3 4>;
                                        remote-endpoint = <&mdss_dsi0_out>;
                                };
                        };

                        port@2 {
                                reg = <2>;

                                sn65dsi84_out_a: endpoint {
                                        data-lanes = <1 2 3 4>;
                                        remote-endpoint = <&lvds_panel_out_a>;
                                };
                        };

                        port@3 {
                                reg = <3>;

                                sn65dsi84_out_b: endpoint {
                                        data-lanes = <1 2 3 4>;
                                        remote-endpoint = <&lvds_panel_out_b>;
                                };
                        };
                };

> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

