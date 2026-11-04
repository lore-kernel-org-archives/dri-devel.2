Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA554606A33D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Mi5zsXMM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E5310E89B;
	Wed,  4 Nov 2026 10:19:53 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7041310E89B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793787585;
 bh=NzNI8VtsA0ljYvXPDaErQQ7OtTTbiLza/hp8LMLP3oI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Mi5zsXMMqj+yrpowR48mCHZcQOmmhenRhsTfiIv+peZ/eCUf2IQBI9ZE80IMT4uBs
 HJJ4HN/7yZvOhvJlNmGXIpxH6q5jKEBJ3pSXpXpvj5+JifFSSOfjkr4SoWvZOmolvM
 iUiLnGkvT2oPX6qB/aYLLmNwxb2v1jQMs1mVM+uEb0ApTXYk2Jj+V4WAFAML/ipEG4
 lYRCA2683iwMUx6llAe/uQTfumomirs7D0eWlRPsOiRDIB9ZTUg6HR6LWo1kjRUM+v
 ZUrEbfRAX4UyYZXAkxbtzn99XdZeFYk8l3kiEuZ6Gr4HT/XIeXJMJZwjVPpVEqzp7A
 0TJxsRdDCL8NA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E55517E003A;
 Wed, 04 Nov 2026 11:19:45 +0100 (CET)
Message-ID: <f29128c6-f4a1-4f06-b82d-8d49713849b0@collabora.com>
Date: Wed, 4 Nov 2026 11:19:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/46] drm/mediatek: Add support for hardware
 multi-stage layers
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?UTF-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-18-angelogioacchino.delregno@collabora.com>
 <10e114d1f682a24e5eeb29ef03980762fb9712ba.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <10e114d1f682a24e5eeb29ef03980762fb9712ba.camel@mediatek.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 10:46, CK Hu (胡俊光) wrote:
> On Tue, 2026-07-14 at 13:43 +0200, AngeloGioacchino Del Regno wrote:
>> In preparation for adding support for newer, more complex, display
>> controllers like the ones found in the MediaTek Kompanio Ultra and
>> Genio Pro 5100 (MT8196/MT8894), add support for multi-stage layers
>> as in newer hardware, there is a special strategy using multiple
>> hardware components of one (or multiple) display controller(s) to
>> form one single layer.
>>
>> Multi-stage layers are one more step towards extra flexibility of
>> the Display Subsystem, making it possible to change capabilities
>> of Display Controller Pipelines depending on the final application
>> of a board: for example, one board may choose to use fewer layers
>> per pipeline to achieve more pipelines (more concurrent outputs),
>> or more layers to achieve less, but more capable (as in offloading
>> and in achievable bandwidth) concurrent outputs.
>>
>> This currently adds boilerplate to support this hardware, but does
>> not yet implement the IP-specific support for MT8196/8894, which
>> will be done after all preparation is done.
> 
> Could you add mt8196 support based on original layer architecture first then introduce this multi-stage architecture?

Unfortunately, no.

MT8196 cannot work with the previous code made for the previous display controller
as it is fundamentally different from the previous ones.

This is effectively enabling support for the new MediaTek display controllers.
Without this, MT8196 would not have layers.

> This series is so large and I would like to break it into multiple series.

I can break it in multiple series, but merging one series and not the other
would leave you with just dead code (as everything in here is needed to actually
get the rest to work) in mediatek-drm that would:
  1. Make no sense; and
  2. Maybe break before you merge the other series.

This really needs to be one big series and really needs to be merged all together:
it is restructuring lots of stuff in mediatek-drm, and you can't really merge in a
partial restructuring, leaving the rest floating, as that would simply create a
huge mess in the whole driver for literally no reason.

> For other upstreamed SoC, the hardware also has some flexibility to route display pipeline,

This series is already huge, if I start implementing other components for the older
SoCs, this gets to 100+ commits, and becomes unmanageable.

Honestly, we're carrying this series in our integration kernel, and it's become a
huge burden for us to rebase it everytime, because it's ... well, again, huge.

> but we still implement the fixed pipeline first.

The spirit of this restructuring is continuing the previous restructuring work that
I already upstreamed (where I added the OF Graph support): I remind you that the
target of that one was to remove the fixed pipeline arrays because having board
specific pipelines as arrays in code is plain wrong.

Unless "we still implement the fixed pipeline first" means "we still have it here
for the old socs": in this case, well, ABI can't be broken, and if we remove that
the old SoCs running on old devicetrees will get regressions (as in, display will
not work anymore).

I'd really like to remove those big senseless arrays but there's no way: past ABI
related mistakes will always have their ghosts haunting us here, unfortunately...
...and this is why I added a compat layer, trying to separate those from the main
mediatek-drm code as much as possible, because then otherwise the alternative would
have been to clone mediatek-drm to another driver, and freeze this one, which means
that with the technical debt that this driver has, it'd break in 5 upstream kernel
versions and old SoCs wouldn't work anymore.

> This suggestion just want to simplify the review process.

I know, and I appreciate your suggestions to allow me to make this as smooth as
possible - being a maintainer myself I can completely understand you on that, but
this series is really that big, and really that complicated.

I can try and retry and re-retry again to make things easier for you to review and
apply, but I don't think there's much more I can do for that.

The only thing that I can tell you here is that we've been carrying this series
since kernel 7.0.0 (included), rebased on 7.1, 7.2, 7.3, and always checked for
any regression on Genio boards and Chromebooks (8173, 8183, 8188, 8192, 8195).

All of those are working as expected and good, and have been working great for
all this time.

Well, including MT8196, of course, and Genio Pro 5100.

Ah, one last thing - this series is part 2: the first one was in soc/mediatek which
I was able to merge, and then there are another two series that I did *not* send
yet, adding *full* support for MT8196... so this was already split!! :-)

> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> [snip]
> 
>> +static void mtk_crtc_config_layer(struct mtk_crtc *mtk_crtc,
>> +				  struct mtk_plane_state *plane_state,
>> +				  int layer_num, struct cmdq_pkt *cmdq_pkt)
>> +{
>> +	u8 *layer_stages = mtk_crtc->hwlayers[layer_num].layer_stages;
>> +	u8 i = 0;
> 
> In mtk_ddp_comp_for_plane(), it consider mt8183 main path which two component has OVL layers: OVL0 and OVL_2L0.
> That crtc has 6 planes.
> When calling mtk_ddp_comp_layer_config() with OVL_2L0, the layer_num would be 0 or 1 not 4 or 5.
> So add this adjustment like mtk_ddp_comp_for_plane().

You didn't understand this code: mt8183 is effectively untouched.
The OVL_2L0 is not evaluated as a layerstage, but as a layer, exactly like the old
code was doing.

Seriously, the code that is specific to multi-stage layers is practically doing
*nothing* for the old display controllers (other than shuffling things around in
code) and not changing their behavior *at all*.

It's just adding stages for the new controllers, found in MT6991/6993 (where
8196==6991).

> 
> I would not review rest part because you may base on a wrong assumption to implement.
> 

As I explained, I didn't use any wrong assumptions here.

Cheers,
Angelo

> Regards,
> CK
> 
>> +
>> +	do {
>> +		mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[layer_stages[i]],
>> +					  layer_num, plane_state, cmdq_pkt);
>> +	} while (++i < mtk_crtc->hwlayers[layer_num].layer_stages_nr);
>> +
>> +	return;
>> +}
>> +
