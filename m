Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nJeizpLC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E1C10F66F;
	Tue, 24 Nov 2026 14:38:55 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0700B10F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:38:49 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCB9FBE1;
 Tue, 24 Nov 2026 15:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795530974;
 bh=UB0ii/fj7GuuWSBblXDInqUrRawYOWHMp4NCHjO6TU0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nJeizpLCa0dEauhPzl0WVPhSd4v/7qp6+E4dm5D7AHuDpDyN9pteU4GnVq1f8IbIf
 LCM+exM7Xs+WZ3zud3Fe1DyrkvYsXHwy/vl7MQHjODpXxxiDZJjk5dElw5waaTMhCm
 Zs+r2ikB9dyXsbNxRgAe0XL9IAyfCeCh3bGPEveQ=
Message-ID: <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
Date: Tue, 24 Nov 2026 16:38:43 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
To: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261124141119.441163-1-maximpedraza@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 24/11/2026 16:11, Màxim Pedraza Padilla wrote:
> On Wed, Nov 18, 2026 at 10:21:14PM +0100, Màxim Pedraza Padilla wrote:
>> Makes sense, I'll use the same approach in tilcdc, and see if it can be
>> turned into a common helper along the way.
> 
> A follow-up on this one, now that I've rebased on v9. I ended up doing
> it differently, so I'd rather explain why before sending the next
> version.
> 
> The tidss approach rounds the clock to the closest standard refresh rate.
> Panels driven by tilcdc often don't use one: with the timings from its
> datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which would
> be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
> match the panel mode, even with U-Boot programming exactly the same one.

I felt that approach was a bit odd (and if I recall right, failed with 
my OLDI panel), and in my tidss version I just used the clock rate 
directly from the clk_get_rate() (see dispc_vp_readout_mode):

https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git/commit/?h=ti/boot-splash-v8.5&id=b08e04d7ff284234aebd048982c98cc5368affa8

  Tomi

