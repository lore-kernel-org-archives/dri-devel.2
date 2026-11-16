Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8317606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hrhqEx4T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC2A10F260;
	Mon, 16 Nov 2026 15:14:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3946410EDD4;
 Mon, 16 Nov 2026 15:14:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 91BD01A1688;
 Mon, 16 Nov 2026 15:14:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5EAA66023F;
 Mon, 16 Nov 2026 15:14:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C02C11BC183B; Mon, 16 Nov 2026 16:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794842044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3/EqQi0niERAJNyYMq1hZvt8inmcWvBEwiXFS+iUL0s=;
 b=hrhqEx4T9QQ2tYqo/iy/LuHHWtedSZ9onNfveWjQEAHCqavnOAmS/ZBSwa0pXuUaWeGFoE
 JGCYD0UbYierkaXyh0sZ3XHSFY7px3bitUZsQ7cefgjxtV9TKEdgN+UnSHWYcazeLuMLRa
 y0D43nUuTbTvY1O4ahIhQ5AZdq9uNR1fET/1oCNLS/AAxHecGpl9Xo3GRN04KMCeM/FXbo
 HdGlvhmVr4WZLcCCC0L84Q/igHfDx5fj09IetVv+8GoiA2nGgWVaET5ZXXgFEdDbgLj2nO
 8YrbUgEfY4SbQ1e7+mgn6uxvPcnpTlwq48fuftp1BeekqTdBgBbdTLkzAUhHxA==
Message-ID: <dfe3ce17-8153-4cd1-b9df-fe0d61cec9c4@bootlin.com>
Date: Mon, 16 Nov 2026 16:13:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH RFC v3 0/8] Add support for DisplayPort link training
 information report
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>,
 Manasi Navare <navaremanasi@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>,
 Drew Davenport <ddavenport@google.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <51ec15feef9a88e460ab6fefc48b5b982f4857c0@intel.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <51ec15feef9a88e460ab6fefc48b5b982f4857c0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 14:10, Jani Nikula wrote:
> On Mon, 12 Oct 2026, Kory Maincent <kory.maincent@bootlin.com> wrote:
>> DisplayPort link training negotiates the physical-layer parameters needed
>> for a reliable connection: lane count, link rate, and optionally Display
>> Stream Compression (DSC). Currently, each driver exposes this state in
>> its own way, often through driver-specific debugfs entries, with no
>> standard interface for userspace diagnostic and monitoring tools.
>>
>> This series introduces generic helpers, for exposing DP link capabilities
>> and state as standard sysfs entries.
> 
> So how did we end up with sysfs here?

In the first RFC it was in DRM properties. I presented it in the display 
hackfest in Nice last years. People suggested to use sysfs instead but 
if the need appears later in the development move back to DRM 
properties. I first though DRM properties seems better as it is the user 
interface used by distros but I had no strong argument about the change 
to sysfs, so I moved on to it.

>> The aim of such development is to guide users to select the most suitable
>> DisplayPort connector for their needs. For example, if you have a USB-C
>> hub with lesser capabilities than your computer’s native DisplayPort
>> connector (such as HBR2 versus HBR3 support), the system could recommend
>> connecting high-resolution displays directly to the computer’s port
>> instead of through the hub to ensure optimal performance.
> 
> I do wonder how all this is supposed to work in more complex real world
> scenarios, though.
> 
> I believe the user primarily cares about *modes*. Which display modes
> can be used with each display/connector pair.
> 
> With the low level link information, are you proposing to compute the
> required bandwidth for modes in userspace? I think it's going to be a
> lot of work to compute the bandwidth requirements, taking into account
> DP SST vs. MST vs. UHBR and DSC and bit depth and everything, and you'll
> still miss any driver/GPU specific contraints. Or are you just proposing
> to match the physical characteristics only?

This is a requirement from Google, yes they want to compute the 
bandwidth for modes in the userspace side.
@Manasi could describe in detail how would you implement it?

> Given all the connectors and displays and their modes on a system, you
> could estimate a) for each display, what modes could be used on each
> connector, and b) for each connector, what modes could be used on a
> display, if connected. From the user POV, they could be shown why some
> display mode is not available on the current connector, and crucially,
> on which connector it could be available.
> 
> In general, I'm wondering if you're really after higher level
> information, something like "connector max available bandwidth
> with/without DSC", that would more directly map to the user needs as I
> see them than low level link details.
> 
> Do you have the userspace somewhere? That's needed for merging UABI
> anyway [1].
> 
> [1] https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requirements

I wanted to add it to IGT GPU tools, but I was hopping for community 
review on this RFC before the IGT development.

>> The new drm_dp_source_set_caps and drm_dp_sink_set_caps helper expose
>> source and sink training capabilities to userspace via sysfs attributes
>> under dp_link. Finally drm_dp_set_cur_link_params helper is provided to
>> report current link information at runtime.
>>
>> Three drivers are updated as reference implementations: i915 (direct
>> connector path), ANX7625 and MediaTek (via the bridge connector framework
>> using a new DRM_BRIDGE_OP_DP flag).
>>
>> Here is a sysfs example:
>>
>> cur_link_info_dsc            sink_link_caps_nlanes
>> cur_link_info_link_rate      source_link_caps_dsc
>> cur_link_info_nlanes         source_link_caps_link_rates
>> sink_link_caps_dsc           source_link_caps_nlanes
>> sink_link_caps_link_rates
>>
>> 1620000 2160000 2700000 3240000 4320000 5400000
>>
>> 1620000 2700000 5400000 10000000 20000000
>>
>> 5400000
>>
>> This series is rebased on top of drm-misc and may conflict with the
>> current state of the drm i915 tree. Which tree should pick this up,
>> given that it mixes core development with driver changes?
> 
> For development, please just base your work on top of drm-tip, and the
> tree(s) will be sorted out later.

Oh, ok, thanks you.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

