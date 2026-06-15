Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70857CD98C7
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C146110E315;
	Mon, 15 Jun 2026 11:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rkWpy4Gt";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE18E10E315
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:07:35 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DBB5919DC;
 Mon, 15 Jun 2026 13:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781521622;
 bh=N/hg2A20qBERMOLfSOzyDt/oeRbtkj0OfMiW3erTfHo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rkWpy4GttUssHAa8nVGl5LH4bkj3hko5jqVKbyA2rwz/86ZBDBOBAZSbHSErOnrVx
 31idD8dgTs4jUlh9EnmI6PfqaYLIyg8CEFii8/zyJ/6BoXDgKIGdRxTbqJZ933hxAY
 s8Adgbr4vMTqvQ7EyEMrF1T/R5lPf8tzy6Dk6HIY=
Message-ID: <9789d4e8-8afc-4349-bff7-5f546eec795a@ideasonboard.com>
Date: Mon, 15 Jun 2026 14:07:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
To: Conor Dooley <conor.dooley@microchip.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
 <20260615-rcar-du-dsc-v4-2-93096a1b56a3@ideasonboard.com>
 <20260615-undiluted-gallery-d7318905c8fe@wendy>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260615-undiluted-gallery-d7318905c8fe@wendy>
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

On 15/06/2026 12:38, Conor Dooley wrote:
> On Mon, Jun 15, 2026 at 09:28:07AM +0300, Tomi Valkeinen wrote:
>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> The Renesas DSC Display Stream Compression is a bridge embedded in the
>> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
>> 8k or 400 Mpixel/s .
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> [tomi.valkeinen: fix the example]
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   .../bindings/display/bridge/renesas,dsc.yaml       | 99 ++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
> 
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - renesas,r8a779g0-dsc
>> +      - const: renesas,rcar-dsc
> 
> I didn't provide an ack for this FYI, I was giving the ack for the
> file being called renesas,r8a779g0-dsc.yaml. Since Geert isn't happy
> with what's here, could you drop my ack when you send another version?
Yep, I took too much liberty there, sorry about that. I'll drop your 
ack, unless I move to just renaming the file to "renesas,r8a779g0-dsc.yaml".

  Tomi

