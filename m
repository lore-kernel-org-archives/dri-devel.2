Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F302CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 23:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FA710E0AA;
	Sat,  2 May 2026 23:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d9HOVMyV";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D9E10E00B
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 23:39:36 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g7PWn37rZz9t65;
 Sun,  3 May 2026 01:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777765173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfILjtLnryyVkFeL+4YyfSAyo9v1cIId1IUMbHc/7qg=;
 b=d9HOVMyV+ERwC0R89d4h1I+F8HG5GYp0N9FSJCr2qXU/85Mb48wp+DZY6TjAd/2swt5u5C
 tVJH8rRunB3zDWvh6WFYsLGlR5//5UycBAO8mb6rUH5l3diyGRU9V/hymox+LdbP4PpGSd
 1yhmMEJMi3hIsmC1Ec6dPh/Z3eAu572dnzoJDF5tW9ML6Y644St7vPz7cOnhR6up7AyX65
 TXTz5na3KrzEAk/1WFVpJUKWgMFX1ZqZsiQDuB9MHQwydulYZjh8OWUhHRkboMHuaOP1Cb
 Taxgx3XRXrpP+BhbCMSLGqL6APU2oYlKF5XY+kCKLC+23+K8JabFMNBeIX48YQ==
Message-ID: <380861ce-b832-4789-93fa-c2340ce487e6@mailbox.org>
Date: Sun, 3 May 2026 01:39:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car
 R8A779MD M3Le DTs
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-7-marek.vasut+renesas@mailbox.org>
 <20260429221153.GD132396@killaraus.ideasonboard.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260429221153.GD132396@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rcrxobjd51jeq56ffsfaa15qkptt7r43
X-MBO-RS-ID: 3e84285b24ac2565bce
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

On 4/30/26 12:11 AM, Laurent Pinchart wrote:

Hello Laurent,

>> +/delete-node/ &vin4csi20;
>> +/delete-node/ &vin5csi20;
>> +/delete-node/ &vin6csi20;
>> +/delete-node/ &vin7csi20;
>> +/delete-node/ &xhci0;
>> +
>> +&du {
>> +	compatible = "renesas,du-r8a779md";
>> +	renesas,cmms = <&cmm0>, <&cmm3>;
> 
> Shouldn't you then also delete the cmm1 node ?

Please see my reply to [PATCH 1/7] dt-bindings: display: renesas,du: 
Document Renesas R-Car R8A779MD M3Le , the CMM0,1,3 all seems to be on 
the chip and accessible. I think the CMM driver should be aware of the 
IP, even if it is unused, e.g. to bring it into low power state if needed.

> And does the DU still need three clocks and three interrupts ?
The Geist board schematic indicates that DU_DOTCLKIN1 is present on the 
SoC package and is supplied by Xtal X22 on the board, so I think the 
answer is "yes" for the first clock part of your question.

As for the interrupt part, it seems DU1 is present, but not connected. 
That means the DU1 interrupt does exist, but is not going to be used. Do 
you prefer to describe it or leave it out ?
