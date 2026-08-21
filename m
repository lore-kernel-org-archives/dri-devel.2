Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B97EC5DF8E
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7442A10F3A4;
	Fri, 21 Aug 2026 19:42:39 +0000 (UTC)
Received: from mout-p-103.mailbox.org (unknown [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC69410F3A4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 19:41:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hRTGn5xQRzKm5q;
 Fri, 21 Aug 2026 20:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787336657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vsr+UmnV16Ldxp1uu1vh5Lyj6uMh3wHvJZvwrfdyqGk=;
 b=MnR5BK6Wv+in1IolTEl2q5rA7404qL04GeOJQ42XBJ076rhEDcjqUrzAhn39RjIuOXVzY+
 fbsZaEq7ygNcC2c+t1QGURaIRD2gz//t9CXLmscEOyy0zNghW07vPfCTVL5rkNrp1YQ8K9
 yaHNe7xq/cOOIZLYBczjTPqL3kagypImcSx5o1jRXxzncSNvvhoH/3WUaRHpmhlIA5R+vg
 0QOWnorAzVGcUgViIprMXWaQ3rVzGN7BE7ad8/qtp4lYNnOhmNByVCyrSrJA9QwqfSx1ph
 0ZYUvFroRJDTM4cuf4Iah2M+FQ2Pa7rps6sagydNV9ARaGMr9L3PRXNYkXMAUA==
Message-ID: <628a3b53-82a1-4735-a672-c3a14521f895@mailbox.org>
Date: Fri, 21 Aug 2026 20:24:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Document 10"
 Raspberry Pi Touch Display 2
To: Conor Dooley <conor@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
 <20260821-naturist-eagle-f691527ae813@spud>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260821-naturist-eagle-f691527ae813@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 21903d66f9617f21558
X-MBO-RS-META: wb83bou7tayco1mhhqn1zgsfp1us5pt1
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

On 8/21/26 7:23 PM, Conor Dooley wrote:
> On Thu, Aug 20, 2026 at 08:54:27PM +0200, Marek Vasut wrote:
>> Document the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT LCD panel.
>> The panel is based on the Ilitek ILI79600A controller.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Jessica Zhang <jesszhan0024@gmail.com>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: devicetree@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: Extend existing ilitek,il79900a.yaml document instead of introducing
>>      new one. Note that the il79900a should likely be il_i_79900a, but the
>>      binding document already shipped in Linux 6.19.y , so this can not be
>>      fixed anymore ?
> 
> Should it? Website says il79900a:
> https://www.ilitekholding.com/en/product/Mobile (ctrl + f)
> 
> Your new device also has no second I there.
Hmmm, interesting, today I learnt that not all ilitek hardware has ILI 
something prefix, some now has only IL .

Thank you, fixed in V3.
