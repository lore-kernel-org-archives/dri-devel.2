Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=nJj+NIgZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3160010E9EE;
	Thu, 26 Nov 2026 16:40:56 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA53810E9EE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:40:50 +0000 (UTC)
Message-ID: <c31cbdf7-87ca-46bf-ad89-cb4c8b5dfe55@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795711248;
 bh=wA6+NWNs2Pzeunxgi7qRF97OZsO9dKoJhUUzdBBn10s=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=nJj+NIgZX8FjurIbJnvn704fI1Ag9bw1pNgQEwogjT4rkDWjON5w6WPe4X3747V9Y
 xfU3ptTlMU1VSCBsHjmzmaSodmVyQHiMbDD7K923DneifPJ61ATyZX7sw+FSTMip4G
 zMz6cilJzCvbtD34XhkhAyP6Vnk1CnQT8P0Co1k4=
Date: Thu, 26 Nov 2026 17:40:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v4 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
 <6e408f48-17ca-4927-ae09-c4153e294371@linaro.org>
Content-Language: en-US
In-Reply-To: <6e408f48-17ca-4927-ae09-c4153e294371@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 09:14, Neil Armstrong wrote:
> On 11/24/26 23:05, Martin Blumenstingl wrote:
>> Hi Ronald, Hi Neil,
>>
>> first of all: thanks Ronald for picking this up!
>> I like the overall approach. Before I dive deep into this series I
>> will finish the code-review of Valerio's AUDIN series.
>>
>> Two quick notes below.
>>
>> On Mon, Nov 23, 2026 at 8:38 PM Ronald Claveau via B4 Relay
>> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>> [...]
>>> Overview of the series:
>>> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>>>    add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>>>    "hdmi-phy" child node under the HHI syscon.
>> It's been a long time, but I think we've been asked by the devicetree
>> maintainers to have reg properties for the nodes within &hhi
>> But I can't find the message at the moment.
> 
> The hhi syscon nodes doesn't have #[address|size]-cells and so far it
> wasn't required, let's wait for a review from DT maintainers, I'm fine
> with the current design
> 

I found an old discussion to drop a reg [0].
My understanding is we don't need a reg here.

[0] https://lkml.iu.edu/2311.1/05612.html

>>
>>> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>>>    PHY configuration ops, along with the temporary legacy creation
>>>    helper.
>> At quick glance your PHY approach would also fit phy-meson8-hdmi-tx.c
>> There seem to be minor differences:
>> - two additional enable bits in HHI_HDMI_PHY_CNTL1 on GXBB and newer:
>> HDMI_FIFO_ENABLE=BIT(2) and  HDMI_FIFO_WR_ENALBE=BIT(3)
>> - newer SoCs seem to have HHI_HDMI_PHY_CNTL3..5
>>
>> Meson8/8b/8m2 HDMI support is not upstream yet. That's why those SoC's
>> won't need the backwards compatibility code. So if you need to tweak
>> the driver: feel free, there's not much you can break!
>>

Yes I did not want to break the Meson8 driver. I will send a proposal to
integrate the other SOCs into it, and make it generic.

>>
>> Best regards,
>> Martin
> 
> Thanks,
> Neil


-- 
Best regards,
Ronald
