Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A32FCDE000
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC0910E9E5;
	Tue, 23 Jun 2026 08:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHX4wQmy";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A8510E429
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:30:44 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2c6a97e1d1bso27490475ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 19:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782095444; x=1782700244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ipKRVPzkC3/bLO3loiWzGU9J/nN5jU3SnxMn7jqpCwk=;
 b=lHX4wQmyssfpRiwFHwaJjlR+gRZb8vVisX7XCPvJmavi8MJlBhvAD3maTYx4FdDe8P
 P6wIy7Qjak/fLSQeUBvCsRo44pAVLeVqnHsFG3Rao6lSpDQiZBoz8LrqsoVl2+UsDQf1
 wAJW/RxZY4VraF0YHEK1rpeIwiDHViSJontXzomSCsN/lbaNRScIU0WVkecZexUAUOYV
 whnrO+71pCOjEjNpG5Rj5CyQ+CAz3QMzalZabkue0HpDlan+kfSWRB2b/iju/qmtm4bc
 5YgWqJ5rfI/VI/U+pQkCISZ45qanFWzqsMpGNzSUT9qyrdyXTer88UDo1oztZPZtwZ5Q
 176A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782095444; x=1782700244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipKRVPzkC3/bLO3loiWzGU9J/nN5jU3SnxMn7jqpCwk=;
 b=TRt7G33yB4krRe0vposwWs+lGS89Nor1WKco9qN8+jlAtR2gUXmodPnuDIIlL3Uxh+
 wWZIcREHF0YJk2S1ZtywtP1r2E3sYk8EIPJfppLBFN5ylguJhl5ld319ViFUvbV+/E2n
 nLYeJV2o1WWHwU4SMEJvhiQzNwc9TdT+R4G7bWEaVMiQ7i5rC5HHIrYk7CAjSFc0LkPJ
 uHWl0RAV8OmqjXSQc91YLcMRtM5pUg2kVPXb7I4jVZK+SLrKLFeC/KOjoFyDvyA5tnQn
 bao4phsDUv/pyuG3sgCW5yqpSMDy+l0id/jfNG1fr614e5j+GyzYk/4ZGPXPYRc6rhCZ
 dE6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfBtL1HYMrKEKGtP2lN+PXinDiEhVn/yBUB/dUex+9SksNqGpG4SjhSaQr5kKC9XXE+Z8/Z66ZLT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+mixVIe+wtwnnKKjxh4v653aK9/nF53hDstg+OwizPVUr1SSZ
 JMSHxS+hUB2oyEgv76Lb6BU3V16Rvr+i1kO2MrxAB6Y/RyTVUuDAGC7U
X-Gm-Gg: AfdE7cmOmxi/K45JXkNBw+iGJYeugY1avOJYZauHwFMzqNgMRERiXaqlgfa1XfnEhHm
 GyL/KK+66tDdhPiou63yJOG0LUeXBmxp+/mQ/zj/rLlpbBq5Var57jEW8SLZt21B1OfIFKig+xP
 DQY7N7XdOYRC0yJU5MB5EC5gNt1J1h7pqY6MkGJSrXbKESk+jABQWiXSCijw7Ha4C5h4Nz8KDFd
 j+DaWzevs6bnenTHdAdtFFzYscXf89YVOHDsRZzeWFpCP+MxSRkMAlPjKFvRCm6B7vqnnSKM0RC
 B0GhyYY4GHlaSlZ+7NCw+RpESxSOT80yx+nMonP7SRpD6d8aJiJHATnkWcyEWg3RNGbZ+FK1+MQ
 k8Fj1rTVj7Nj8yRwBeeiFZHu9bqu5MbyZsYQdksim9XeooUJs7stJ+ZSekNaQ+kmjwGTNwyQmCw
 QlTiRaQcNE3o5AIsPR+28irFgE0lvLlNcMDzIXss22H/VxUSDkzhf47zSOr5qCQIohnA==
X-Received: by 2002:a17:903:b47:b0:2c6:a487:f431 with SMTP id
 d9443c01a7336-2c718fe2eb1mr137529215ad.23.1782095443621; 
 Sun, 21 Jun 2026 19:30:43 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c742fdd411sm64398555ad.0.2026.06.21.19.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2026 19:30:43 -0700 (PDT)
Message-ID: <6d6dd8d0-292a-43f6-a94a-dedebe22c582@gmail.com>
Date: Mon, 22 Jun 2026 10:30:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/verisilicon: add DC8000 (DCUltraLite) display
 controller support
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-5-a0987203069@gmail.com>
 <d5df0e9df3a9a68aae982f2fce830a4b10468476.camel@iscas.ac.cn>
 <df7363be-0e3f-4459-be4a-43ffb0a5366c@gmail.com>
 <0bb460aefb97e44cc0890a7841b8d217349143de.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <0bb460aefb97e44cc0890a7841b8d217349143de.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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


On 6/18/2026 6:33 PM, Icenowy Zheng wrote:
> (CC'ed clk maintainers for weird clock gate bit)
>
> 在 2026-06-17三的 18:35 +0800，Joey Lu写道：
>> On 6/15/2026 4:51 PM, Icenowy Zheng wrote:
>>> 在 2026-06-15一的 14:50 +0800，Joey Lu写道：
>>>> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite
>>>> display
>>>> controller whose register layout differs from the DC8200 in
>>>> several
>>>> important ways:
>>>>
>>>> 1. No CONFIG_EX commit path: framebuffer updates use the enable
>>>> (bit
>>>> 0)
>>>>      and reset (bit 4) bits in FB_CONFIG instead of the DC8200
>>>> staging
>>>>      registers (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT,
>>>>      FB_BLEND_CONFIG, PANEL_CONFIG_EX).
>>>>
>>>> 2. No PANEL_START register: panel output starts when
>>>>      PANEL_CONFIG.RUNNING is set; there is no multi-display sync
>>>> start
>>>>      register.
>>>>
>>>> 3. Different IRQ registers: DCUltraLite uses DISP_IRQ_STA
>>>> (0x147C) /
>>>>      DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (0x0010) /
>>>>      TOP_IRQ_EN (0x0014).
>>>>
>>>> 4. Per-frame commit cycle: DCUltraLite requires the VALID bit in
>>>>      FB_CONFIG to be set at the start of each atomic commit
>>>> (crtc_begin)
>>>>      and cleared after (crtc_flush).
>>>>
>>>> 5. Simpler clock topology: only 'core' (bus gate) and 'pix0'
>>>> (pixel
>>>>      divider) clocks; no axi or ahb clocks required.  Make axi_clk
>>>> and
>>>>      ahb_clk optional (devm_clk_get_optional_enabled) so DC8000
>>>> nodes
>>>>      without those clocks are handled gracefully.
>>>>
>>>> Add vs_dc8000.c implementing the vs_dc_funcs vtable for the above
>>>> differences.  The probe now selects vs_dc8000_funcs when the
>>>> identified
>>>> generation is VSDC_GEN_DC8000 (DCUltraLite reads model 0x0,
>>>> revision 0x5560, customer_id 0x305).
>>>>
>>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/verisilicon/Makefile    |  2 +-
>>>>    drivers/gpu/drm/verisilicon/vs_dc.c     |  9 ++-
>>>>    drivers/gpu/drm/verisilicon/vs_dc.h     |  1 +
>>>>    drivers/gpu/drm/verisilicon/vs_dc8000.c | 78
>>>> +++++++++++++++++++++++++
>>>>    4 files changed, 86 insertions(+), 4 deletions(-)
>>>>    create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
>>>>
>>>> diff --git a/drivers/gpu/drm/verisilicon/Makefile
>>>> b/drivers/gpu/drm/verisilicon/Makefile
>>>> index 9d4cd16452fa..d2fd8e4dff24 100644
>>>> --- a/drivers/gpu/drm/verisilicon/Makefile
>>>> +++ b/drivers/gpu/drm/verisilicon/Makefile
>>>> @@ -1,6 +1,6 @@
>>>>    # SPDX-License-Identifier: GPL-2.0-only
>>>>    
>>>> -verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
>>>> vs_drm.o vs_hwdb.o \
>>>> +verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
>>>> vs_dc8000.o vs_drm.o vs_hwdb.o \
>>>>    	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
>>>>    
>>>>    obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>>>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>>>> index 9729b693d360..9499fffbca58 100644
>>>> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
>>>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
>>>> @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device
>>>> *pdev)
>>>>    		return PTR_ERR(dc->core_clk);
>>>>    	}
>>>>    
>>>> -	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
>>>> +	dc->axi_clk = devm_clk_get_optional_enabled(dev, "axi");
>>>>    	if (IS_ERR(dc->axi_clk)) {
>>>>    		dev_err(dev, "can't get axi clock\n");
>>>>    		return PTR_ERR(dc->axi_clk);
>>>>    	}
>>>>    
>>>> -	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
>>>> +	dc->ahb_clk = devm_clk_get_optional_enabled(dev, "ahb");
>>> Please make the clock change a separated patch for atomicity.
>>>
>>> BTW the MA35D1 manual's clock tree shows that DCUltra appears on
>>> AXI2
>>> ACLK, AHB_HCLK2, behind a mux of SYS-PLL/EPLL-DIV2 (which seems to
>>> be
>>> the core clock), and behind a divider (which seems to be the pixel
>>> clock).
>>>
>>> However it's weird that only one DCUltra Clock Enable Bit exists
>>> despite both bus clocks have "ICG" (I think it means "Integrated
>>> Clock
>>> Gating"). In addition the linux clk-ma35d1 driver assigns
>>> "dcu_gate" as
>>> a downstream of "dcu_mux", although the Figure 6.5-2 in the TRM
>>> shows
>>> no ICG after the "Display core CLK" mux.
>>>
>>> Is the two bus clocks controlled by a single gate bit, and is the
>>> bit
>>> also gating DC core clock?
>>>
>>> Thanks,
>>> Icenowy
>> I will split the axi/ahb optional-clock change into its own patch in
>> v5
>> for atomicity.
>> Regarding the MA35D1 clock tree: from the TRM, the single "dcu_gate"
>> bit
>> gates both bus clocks (AXI ACLK and AHB HCLK) together with the
>> display
>> core clock through the same ICG cell. The clk-ma35d1 driver exposes
>> only
>> "dcu_gate" (downstream of "dcu_mux") and does not provide separate
> Then it's one of the case that the clock tree doesn't properly
> represent the hardware, which is bad. However, as three gates share the
> same bit, I am not sure how to represent such kind of thing in the
> common clk framework.
>
>> axi/ahb clock entries. Therefore the MA35D1 DT binding will use only
>> two
>> clocks ("core" and "pix0"); making axi and ahb optional in the driver
>> is the correct approach, and this will be stated clearly in the
>>   split-out patch.
> I agree to make them optional, although these two clocks do exist in
> the hardware of MA35D1.
>
> Thanks,
> Icenowy
As mentioned in the DT binding reply, the absence of separate AXI/AHB 
clock entries for DCU in clk driver is due to the hardware design 
constraint of a single shared enable bit, not a driver oversight. In v5, 
the axi and ahb clock fetches in `vs_dc_probe` will be split into their 
own patch and made optional via `devm_clk_get_optional_enabled`, with a 
comment explaining that on MA35D1 the AXI and AHB bus clocks share the 
single `dcu_gate` enable bit and are therefore not separately exposed by 
the clock driver.
>>>>    	if (IS_ERR(dc->ahb_clk)) {
>>>>    		dev_err(dev, "can't get ahb clock\n");
>>>>    		return PTR_ERR(dc->ahb_clk);
