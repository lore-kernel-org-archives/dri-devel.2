Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72FCCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD0610F5D3;
	Mon,  8 Jun 2026 15:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N39eBM79";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B2110F078
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:44:30 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c85d8615b09so2439277a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780911870; x=1781516670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1wz0gmvL+00jwYzggF0MlmA1dhQA7/85d2swuD/6js=;
 b=N39eBM79FouFxfgD7CL6793cP+W86Rk1cm+zNH9pt4yuAxIXdKfozcf6IYmdD2Zptt
 y/N2LQ3VRsMp2KYklqgFkavQ/dZVfvpm48XwJbqL/zf/yQQXWMCO1RGgsFioy7vzAfs/
 Xy8hmwz6xSGRRE/G0Gr77ZVFOyxnBLktFYuzAGH22li6sNngUIeHWTYCeTwLNooYgJD8
 ZJ40FUTS5L8QTgXfmvWUTTgWxy87eMkx4TFWwc86Ni4TRHlD/7uSl1ytO+FXzff/XTXS
 AKjMPIAxy7Dg58/Ygrg6KbFSpA619P7YRJQrUQJwYfnKxrLEDWsIjlf435fxRpvHXA1t
 zhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911870; x=1781516670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1wz0gmvL+00jwYzggF0MlmA1dhQA7/85d2swuD/6js=;
 b=QU3zaUew8FgXovTM14O4jiZaeyAF5qkHq2D0+SbAXuCQiOcGeTVtDnMmnG81ZeF1zs
 GdpsGkZdbz8wt/eAHnNAAHB7WlD9KPZ3c5rd1+kVuELKfGhw0yciahE/MufaqZI2ydDv
 YlLHsyHeVGf1X2aUouWNnZ38q9pBS56+c0TPQ2lXXX1pS5XA1E0uQ5WJ1QTN1kvbsz4k
 Pum5QGV00Ne+E7iiq8XCfSREa/95Yw571fwIh4JlbtdY3pLboxDbnN2+TLV6X2g5Zr3a
 RwOk857hjX84DxA+ElMDiNbKvtWBMyHir61ySe/DghOkV/YMa4bTeHGDw/OGSVpTVhOD
 p5oA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AnSDelPAmvBN1SNs09sG0wEWIG0KCpdiDCaEODwfBa8zMUczRu6Reth1B1GjymNuUQ/dxim6GDZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz84lxsAnwdDm6miLvJc32ZywZ4pZ0ixP28/iHxKpT9FEm7itx9
 TzThfvQDF7oXr8k/RSKLVO4XnwQeg1RCuZ/nh+jZkZSkAyb3okalgQ/F
X-Gm-Gg: Acq92OFrrX8Gl81xP20Ix0GKAglayyPAOtf8MPak7xDvs2GsR9dlKGWk2M9uYhGnvIi
 mAYH2X6lhi3NiLHM3rEvhSLYx6uw4EAkdC6ihSHg5NkjCJtx6Vlc4kGagBEJSLVMeQLzXNk4eY5
 q+JYb20kzliGclIuEW4S4KpdkmyJKAsCskizv55WCNjG5xDjy3Qv4FMxJznNL6RDYaYmKyo27eb
 P2PMvU8mTarO23041T7m8xdANhK81NvBEP+/8avjfxrt7W1sAe5OYx9D7awL/fFStgNO2/48naV
 EpJ7oA31OaL4Uh/553V7rAS65por8nk1z5iClywXJV1vn/HUiBFci2AovVnsoiNdYROBLD6cVdx
 /yBDnTSF5riUmP+pX92GWbINwcxnrMMPzKJNbOOn5EiMUxE96xvlgOikZEy63JJrjOufXReQZdg
 AW9n/T7ZfMWAOO1Dvk4YtWGQFypQgjxzobN7VjnVV9IHsgQYBL4JZf5gOfjM7QGyxMgeSnJgUB0
 SiwbDD8uVtvdJ0=
X-Received: by 2002:a05:6a20:d48f:b0:3aa:f9cb:d43a with SMTP id
 adf61e73a8af0-3b4cccf7d06mr15690657637.5.1780911870286; 
 Mon, 08 Jun 2026 02:44:30 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df034ab9sm14584651a12.5.2026.06.08.02.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:44:29 -0700 (PDT)
Message-ID: <28292e35-f41c-4719-a5e0-cac4ab3884f2@gmail.com>
Date: Mon, 8 Jun 2026 17:44:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-2-a0987203069@gmail.com>
 <20260608-baboon-of-theoretical-stamina-6db63f@quoll>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260608-baboon-of-theoretical-stamina-6db63f@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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


On 6/8/2026 4:02 PM, Krzysztof Kozlowski wrote:
> On Mon, Jun 08, 2026 at 10:32:33AM +0800, Joey Lu wrote:
>> The existing schema hard-codes the five-clock/three-reset/dual-port
>> topology of the DC8200 IP block, preventing reuse for single-output
>> variants such as the Verisilicon DCUltraLite used in the Nuvoton MA35D1
>> SoC.
>>
>> Rework the schema so that variant-specific constraints are expressed via
>> allOf/if blocks:
>>
>> - Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.  The
>>    generic verisilicon,dc fallback remains the driver-binding string.
>> - Relax the top-level clocks/resets definitions to minItems ranges so
>>    the base schema accepts both variants.
>> - Keep ports in the global required list and keep additionalProperties
>>    tightened to unevaluatedProperties.
>> - Add an allOf/if block for thead,th1520-dc8200: five-clock (core, axi,
>>    ahb, pix0, pix1), three-reset (core, axi, ahb).
>> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core, pix0),
>>    one-reset (core).
>> - Fix a stray space in the port@0 description.
>> - Add a DT example for the Nuvoton MA35D1 DCU Lite using ports/port@0.
> Difference in clocks and resets does not need a new new example.
>
> Best regards,
> Krzysztof
Understood. I will remove the second example for nuvoton,ma35d1-dcu from 
the binding.
