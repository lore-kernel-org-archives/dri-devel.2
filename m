Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21628F327CB
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7075910E855;
	Tue, 21 Apr 2026 09:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.b="ponEd1zl";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3419F10E84A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:11:32 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso45365985e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuxon.dev; s=google; t=1776762690; x=1777367490; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNfuWJu37z+/2le7LSB6+FRY2Cw1Ca4xlFzZNv69CQ0=;
 b=ponEd1zlXS6MXzE5DcJgSf5jdoRSR82nmwUGSJsPseAdG0aCfu+GK27kekWVzpqjX3
 TPsg94S2vr7ZWiTKeDe48DAZ8dwa0/xDzq/RoED5C9nvFuwoSYWmQRZvF0KNEtsdjVsZ
 D1p5952VklqcRZJnN3TXgm4jOGp74DIB2hgERbOGJGLtmvZSgU5NSV4O4jIHIQf/99H6
 RYbbA9A2yRIJCb7aM04qnauRKAqmPCDTyQZ0j8A8asubREGmczt1hi66BqEFEPdCPnVG
 Tpl7CUkBvwEcZe2CNJ76WwflcAbQFCSCyGUwJ08OriosQ4QtTbx91X3C7/SCuTnOmSZo
 ileg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776762690; x=1777367490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNfuWJu37z+/2le7LSB6+FRY2Cw1Ca4xlFzZNv69CQ0=;
 b=RmZL9pnGC/BkyX6S9rKZuyW3EnmKmeeNTI4NGS5pfiHWyOMw8YFVGC3yMvgJMG8LF7
 aD3Dga4DsQxF76V020i+baEYhPyv7RqzQAtngyagglKjhwYM/8IT+KJRImSeul6WL0he
 LXzrpZPGIcIg1HEOZ0QSqT8n2f0Gv8l3Iqq0kqsQ8HRkHJiApLrRXbSznLFK5lAtP0D9
 tEF6GYKBJccJElBXid88CXL0p3KC/8Z1l+wX/8tlPh0PdsRHEt142bpB1eWso0/ttKIk
 vq3MsxzStmTb+Q+9ovfr6hrA1kX2ibbtSP4JFRDf3j4h01c693fqU97ke9PS7uiyiV79
 rlNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NixV2D5q9XAPAje+Mqesc/3/9GGy6yshOAKlkOoTzyihcGj3xMAGvjpIg/eB92Giqq6E4be+Kv+I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJZ5tQ5F1WIpTHpjQGCrgDlPoQzyVjje4MDfvurE9cu9hCtUP0
 eTX7DLeq7SiM6vNvZm8HyFEZw8tYh+AgUHvXlQEVkNcQNsFh6Mn5bAjRFxfuLJkPZo8=
X-Gm-Gg: AeBDietJuEst2lUfBMPE+09FDiEXI8n7UiiP3w+Fa3kbe3FIveMVUh5Qk2GFpgfw/fI
 dyv/szkmTR/1ozEePgtvbWkNyYyA9Nt+U3laYqrYy2W8M0ZO9B0+PyqAumYJdheZEtIh4jY43Dl
 K215FcXXT8niRUQGk3yGTncXsE2tkG/ii7K9jLjPc0q20l3Qn/eTOsYqwisTA5ckYWaNjeOCb44
 p5rvFEuOYdYLYm4viqIQ9evHLZg/Cxi6K92iFcLeRj250YHPb3SHSCsRZZD6DZBqsQ1pohHYOCF
 y8wwmA4qi/lzxzTdLbMJ40hSnzgxqD2oooAjWOt1lyNvwAKrmkzKgMS1JQ77qQG9/fWxvlvImcL
 2OGTdIyYTr8R9RN81KMIwfxz3FXzcpckVJpt28lrsnOjvqWLhBeYSYkjB173pN5TKcMR6QexkKU
 ZUkkHlpRpllIAu19VstNJxZJBl4GeNY0DD8HwJwJ/szg==
X-Received: by 2002:a05:600c:498a:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48900ad7b76mr107952685e9.24.1776762690040; 
 Tue, 21 Apr 2026 02:11:30 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.162])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55b8baaesm55126775e9.10.2026.04.21.02.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 02:11:29 -0700 (PDT)
Message-ID: <9523bd97-2730-4b99-b3d0-6accc7622478@tuxon.dev>
Date: Tue, 21 Apr 2026 12:11:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
 <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

On 4/19/26 18:58, Dmitry Baryshkov wrote:
> On Fri, Apr 17, 2026 at 06:52:30PM +0100, Biju wrote:
>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>
>> Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
>> mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
>> from 25 to 87 MHz. The LVDS module cannot be used at the same time as
>> MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
>> the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
>> MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
>> module.
>>
>> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>> ---

[ ...]

>> +/* -----------------------------------------------------------------------------
>> + * Bridge
>> + */
>> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
>> +				     struct drm_atomic_state *state)
>> +{
>> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
>> +	const struct drm_bridge_state *bridge_state;
>> +	int ret;
>> +	u32 fmt;
>> +
>> +	/* Get the LVDS format from the bridge state. */
>> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
>> +	if (!bridge_state) {
>> +		dev_err(lvds->dev, "failed to get bridge state\n");
>> +		return;
>> +	}
>> +
>> +	switch (bridge_state->output_bus_cfg.format) {
>> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
>> +		fmt = RZG3L_LVDS_MODE_JEIDA;
>> +		break;
>> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
>> +		fmt = RZG3L_LVDS_MODE_VESA;
>> +		break;
>> +	default:
>> +		fmt = RZG3L_LVDS_MODE_VESA;
>> +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
>> +			 bridge_state->output_bus_cfg.format);
>> +		break;
>> +	}
>> +
>> +	ret = pm_runtime_resume_and_get(lvds->dev);
> 
> If this  fails for any reason, the atomic_disable() would still be
> called and it will decrement the counter, potentially undeflowing it.
> Consider switching to pm_runtime_get_sync(), which suits better here.

AFAIK, the clocks of this HW blocks have MSTOP functionality. HW manual of 
RZ/G3S [1] (should be the same for RZ/G3L as well) mentions the following in the 
chapter 41.2.1. "If the master accesses a module that has the clock stopped and 
the MSTOP bit set, a bus error will occur". [1]
MSTOP is set though the clock enable/disable APIs.

The clocks on RZ/G3L are part of clock power domains. If the 
pm_runtime_resume_and_get() fails (or any runtime PM resume calls), the clocks 
will be off and MSTOP set. In this case, calling atomic_disable() or any API 
setting HW registers will lead to sync aborts.

Thank you,
Claudiu

[1] 
https://renesasweb.s3.us-west-2.amazonaws.com/prod/docs/X014/X0141882/r01uh1014ej0120-rzg3s.pdf?response-content-disposition=inline%3B%20filename%3D%22r01uh1014ej0120-rzg3s.pdf%22&response-content-type=application%2Fpdf&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3WXFIBJWSDVTHJX3%2F20260421%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20260421T075408Z&X-Amz-SignedHeaders=host&X-Amz-Expires=86700&X-Amz-Signature=435eb49a37a080094aecf291bc3dc2d5b7ee62d3de8075151082e9db6c6acbe7

