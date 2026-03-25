Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6580BFEA80C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 06:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC3310E77D;
	Wed, 25 Mar 2026 06:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RdXZUI74";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A7B10E77D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:08:47 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-82a3d3235c9so1837651b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774418927; x=1775023727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zoa2MoiF0mKzbu/HxLLzZaaZ2klLwju72NrX2oHwXew=;
 b=RdXZUI74IHOejxylxvprxdAeD0TWp6QpUFO2sLynPEOTi1e/5/IlvLLQxHAxgImpCE
 vthCcV6ag6xjPtuaOKkevRNvhbnSy2nDWFVwjRYr/IwcXrHodI4FOxtPO+zc3QpsPmSD
 kUdTOe4DNvnAtjC1DBB4MU+3MQatX8HqB2Tj9dqofAkd5lu/9asNiSnWk8dnQMYPE3FM
 u22oGPaKdd9v+kapYNt5AA8UUb5RurmRuycHrktrFfWGiYE/30pMXQLxGbXgOHPfp8td
 NmBUoxNqW2UfRZgI4UgTkwuqZI3URJYF7yaXLvep/rGCSsaiii/52rP01NZBIhjIcujm
 jKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774418927; x=1775023727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zoa2MoiF0mKzbu/HxLLzZaaZ2klLwju72NrX2oHwXew=;
 b=TlbHYwNs8VL7Vm/eS/jfDrGe0uAKNLGMDR3+raRJfb3FZdcvW3+dCz8I8SkBS+FH4Q
 f16I//JkzdjpJELcnoK6L7zXTKMEtulnq6MnTQj39qWUeAFLknXM9v/2NVINQFq0ya70
 wcARePA0G5Pym+JIfq+bzIv0NtiboR8rCVmrSnoyt+8dqnkbvsOWyyK6T0GcKr0O9jqa
 eDBcIBfYJkrfeQhgh2+7i2IsfTM83ZawdEvSP0zHEBrlcivrRB+dYlLVeHhgdVF8yFBv
 2KOFNzEatZsgifngPZBQfG4dy8qkBfWkccsZWfb9X/hyxSUGeRp/gV586atXGfpqt5I8
 IBZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmHB+0gezmRArfti7IvJVi9LVUgl6nzGK+IQp8BZ8kJ3WnSqzHMysaaCP2Faosxz6EKOyLpS+uwBM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOXtECvmH07hbODScb9Gy/V84/IwSahj+eU4O12daORDpRBSGb
 TQO3zPtnQyucnvav5Wpz8AnJto+T+PqhmLkxeiS+ERmB8zmYPBH7hpuu
X-Gm-Gg: ATEYQzxayh/ddVK1Vvl5buOFLABZ6prJC1YeNZAZKgzsxNyir28RBu2y+q8XxdF1gO4
 pn+b9+63IQtnLIzfEd1wMMcZMgLLLdNd7XJa1rzMdX4Acm4kMKtQTxawYw2vIRZX3bFM/KRDxCb
 YQoebt4fZAr4iR+QmIVpYF6ge431j0HXbx//8+38bPCqLRelVfDlvLULojbmNXOvZKGZcoZ3Yxm
 4A5XduAOes78UoMg+tLYUd0bDgebHSiBdZ3eIuCTtFaDSUmlWyv1I/0sgu9zYognh6GnJtx2RMP
 1gWr/K87S1zf0JRGToQ0ND8knr9mhmEY6LpW9Cu3e+ZVRKGLmeVCIj79RkGiHSEAREVhOe0QWx9
 Uej1USoIGkjEfYJW+uul/NY3hMsOW0V44FiWMIIqr73wYe08axGvJfGb7YlmrNrdc6XHdmC6x62
 vM+d5v6e+R3lyaTX1V6q1Nj+5oxWlgSO75xPCqeTUDmuZneyqQ6ATKviJJ5Q==
X-Received: by 2002:a05:6a00:2da7:b0:82a:7758:1416 with SMTP id
 d2e1a72fcca58-82c6de6df6amr2498384b3a.12.1774418926718; 
 Tue, 24 Mar 2026 23:08:46 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c76e5a6fcsm503033b3a.59.2026.03.24.23.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 23:08:46 -0700 (PDT)
Message-ID: <d93f15af-219c-4118-bc33-e2ddd2188922@gmail.com>
Date: Wed, 25 Mar 2026 11:39:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm: bridge: ti-sn65dsi83: Improve dual-link LVDS
 support
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@nabladev.com>,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <DH6T0NTZHP93.2DWN4BWDPP331@bootlin.com>
 <1ecbcd57-83d9-410c-8e1a-d6a171321ccd@gmail.com>
 <3019871.ElGaqSPkdT@steina-w>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <3019871.ElGaqSPkdT@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 24-03-2026 16:40, Alexander Stein wrote:
> Am Dienstag, 24. März 2026, 12:00:43 CET schrieb tessolveupstream@gmail.com:
>> [snip]
>>> Thanks for the detailed explanation.
>> Regarding the panel timings, they are not explicitly defined in the DTS. 
>> The panel is currently using the timings provided by the panel driver 
>> (panel-simple.c), specifically:
>>
>> static const struct display_timing auo_g133han01_timings = {
>>         .pixelclock = { 134000000, 141200000, 149000000 },
>>         .hactive = { 1920, 1920, 1920 },
>>         .hfront_porch = { 39, 58, 77 },
>>         .hback_porch = { 59, 88, 117 },
>>         .hsync_len = { 28, 42, 56 },
>>         .vactive = { 1080, 1080, 1080 },
>>         .vfront_porch = { 3, 8, 11 },
>>         .vback_porch = { 5, 14, 19 },
>>         .vsync_len = { 4, 14, 19 },
>> };
>>
>> The panel I am using is based on AUO G133HAN01, and the datasheet can 
>> be found here:
>> https://datasheet4u.com/pdf/1257948/G133HAN01.0.pdf > About CHA_DSI_CLK_RANGE: what is your DSI clock?
>>>
>>
>> In the current working configuration, the measured clock frequencies 
>> are:
>> DSI_CLK: ~422MHz
>> LVDS_CLK(both A & B Channels): ~70MHz
>>> Finally I don't think the swing values are problematic, so I'd leave them
>>> as the last thing to check.
> 
> I managed to get this display running with this DSI->LVDS bridge on
> TQMa8MxML/TQMa8MxNL (imx8mm or imx8mn) platform.
> See [1] for the DT. What platform/ DSI host are you using?
>

Thanks for sharing your setup.

I am currently working on the Qualcomm QCS615 platform. The setup 
is as follows:

- SoC: QCS615
- Bridge: TI SN65DSI84 (DSI to dual-link LVDS)
- Panel: AUO G133HAN01

I am currently using the following DT overlay:
(talos-evk-lvds-auo,g133han01.dtso)
https://lore.kernel.org/all/20260302121159.1938694-1-tessolveupstream@gmail.com/T/#m00e90e7ff95915bbdb21dbd786c232526e3360a2

Could you please confirm whether the display was brought up on your platform 
using only the DT changes you shared, without requiring any driver 
modifications?
 
> Best regards,
> Alexander
> 
> [1] https://lore.kernel.org/all/20260316135820.760073-2-alexander.stein@ew.tq-group.com/

