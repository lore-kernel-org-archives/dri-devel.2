Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B8606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=MF6CPISN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC1310E88F;
	Tue, 24 Nov 2026 13:44:51 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F189D10E88F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:44:45 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C00C9BE1;
 Tue, 24 Nov 2026 14:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795527732;
 bh=Nj3YniFrzVnITRBYaPQKl7wSY/zEuckU+cg5R2aciho=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MF6CPISN2fCrzJXba10MkU3qtJaBi9SZ92H4Wp38+lsUI8RQF25e9/gy5Th8uUSbp
 lH6daagHqHo6aRNf9L5kXgereuYX6RWJnhkbqbGjzHw8HeUjCghwSC0T+8hEhhVYRd
 ahZGGa+kk0z0noN5r92mmWrWSTbk80Ux1YKeTbJc=
Message-ID: <7a94fa5a-ddfc-449e-b014-387d8e868e97@ideasonboard.com>
Date: Tue, 24 Nov 2026 15:44:40 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/bridge: tc358762: fix reset handling
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Marek Vasut <marex@nabladev.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 24/11/2026 13:54, Andreas Kemnade wrote:
> The bridge driver desserts reset after disable and asserts that
> upon enbale. That requires users to workaround that by declaring
> the reset gpio wrongfully active high. As an interim solution,
> ignore polarity, until things have settled to fix it afterwards.
> That will break setups with an additional inverter in the signal
> patch but those should be uncommon, at least not seen in in-tree
> devicetrees. Fix polarity in the one device tree actually declaring
> a reset line. That patch has to go in after the bridge fix.
> 
> The issue came to sight during experiments with reset lines on the
> Epson Moverio BT-200.
Indeed, the driver has it the wrong way... But what is the way to fix 
this? Fixing it will always break the backward compatibility with dtbs.

Is it worth it? Or is it easier to just adjust the bindings doc to 
mention about it, and add a note to the driver that the gpio is set the 
wrong way "on purpose".

Or, if this is to be merged, I think the code around the 
gpiod_set_raw_value_cansleep calls should have a comment to highlight 
why it's calling raw funcs and what the plan is.

  Tomi

