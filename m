Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D00C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBB110EC6B;
	Tue,  7 Jul 2026 11:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QkUazNn2";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA7610EC6B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783425383;
 bh=5La47mugR86zNwVAYVmIlynmty3b35suIyPgIrKNa6Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QkUazNn2ulg5g0wRD75nGqhs3FODngy61+asFxo9b5oAqQLyrCpdMUt5imj3yszwe
 U6G+nKWXawpzRFongj99CeFI1GHvp4VuoOhqpNAxgcp08p7RY69xOXCu4Qf3iiT369
 HLJOAuArQy/SdwO50/+G2tJo/j5eWXT2q+P0KZracXexDmCDX9RJ71wYJ90B+4qzlH
 6SBIzevm+25I9yup2XMoL0LIp6Dl33BXPTnDnM3hLC5TNA8RZphTGZBWvlF0GgMNlV
 3DjP7I1b2EG2NXRaRPqMppMAnHUceu9JjIzboa+chN2nigEM+OX9BzkYXWR/wKdWu2
 Z8Qsis+ohYePQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 101AA17E013E;
 Tue, 07 Jul 2026 13:56:22 +0200 (CEST)
Message-ID: <16980e9f-c183-41c4-8001-ac7807cc087b@collabora.com>
Date: Tue, 7 Jul 2026 13:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/42] drm/mediatek: Use hashtable for components
 discovery and registration
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
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-7-angelogioacchino.delregno@collabora.com>
 <79f44c827c78fd823300509c22058f2b6f3600b6.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <79f44c827c78fd823300509c22058f2b6f3600b6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/6/26 09:02, CK Hu (胡俊光) wrote:
> On Wed, 2026-07-01 at 14:20 +0200, AngeloGioacchino Del Regno wrote:
>> As a preparation for refactoring the concept of hardware component
>> identification, search, and final usage, remove the ddp_comp array
>> of components and replace it with a hashtable, indexed by ID.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_crtc.c     | 44 ++++++++++++++++-------
>>   drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 48 ++++++++++++++++++-------
>>   drivers/gpu/drm/mediatek/mtk_ddp_comp.h | 23 +++++++++++-
>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  7 ++--
>>   drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
>>   5 files changed, 94 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
>> index f39f197057a7..3f4d6ab1bfc2 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
>> @@ -725,8 +725,12 @@ static void mtk_crtc_update_output(struct drm_crtc *crtc,
>>   		crtc_state->connectors_changed, encoder_mask, crtc_index);
>>   
>>   	for (i = 0; i < mtk_crtc->num_conn_routes; i++) {
>> -		unsigned int comp_id = mtk_crtc->conn_routes[i].route_ddp;
>> -		struct mtk_ddp_comp *comp = &priv->ddp_comp[comp_id];
>> +		const struct mtk_drm_route *conn_route = &mtk_crtc->conn_routes[i];
>> +		struct mtk_ddp_comp *comp;
>> +
>> +		comp = mtk_ddp_comp_find_by_id(&priv->hlist, conn_route->route_ddp);
> 
> I don't know why you invent conn_route? Keep comp_id use it here looks the same.
> 

I'm not inventing conn_route, that's something that was already there as a dynamic
replacement of the last component in a stack of possible outputs for a single
full-fledged display pipeline.

The change here is about changing the search/retrieval of a `route_ddp` from a
number that comes from an enumeration, to a full component structure instead....

>> +		if (!comp)
>> +			continue;
> 
> In original code, it never check comp is null or not.
> I think it base on an assumption that it would not be null.
> If it's null here, print error message and it's not necessary to do the rest thing.
> 

.... and the component structure, with the new code, has to be *initialized*: this
is because we cannot assume that a component that was not registered will actually
be registered later (which was a broken behavior of mediatek-drm!).



----> IMPORTANT PART: <-----
Note that, at this point, "comp" is *not* pointing to a *statically* initialized
array of components, but to a *dynamically* initialized one: while before this the
comp pointer was guaranteed to be *always* a valid pointer to a comp structure, now
it is *not guaranteed anymore*, because again - it's *dynamically* allocated, so
we NEED to check for comp != NULL, or we're exposing ourselves to a possible NULL
pointer kernel panic (or worse)!



If the component is not initialized at this point, it simply means that it cannot
be - in any way - used by mediatek-drm, so.. if !comp -> continue means effectively
"if the component is not registered, we cannot use it, hence don't try to evaluate
the possibility of using it".

Is it clear now?

>>   
>>   		if (comp->encoder_index >= 0 &&
>>   		    (encoder_mask & BIT(comp->encoder_index))) {
>> @@ -1028,10 +1032,11 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>>   {
>>   	struct mtk_drm_private *priv = drm_dev->dev_private;
>>   	struct device *dev = drm_dev->dev;
>> +	struct mtk_ddp_comp *dma_comp;
>>   	struct mtk_crtc *mtk_crtc;
>>   	unsigned int num_comp_planes = 0;
>>   	int ret;
>> -	int i;
>> +	int i, j;
>>   	bool has_ctm = false;
>>   	uint gamma_lut_size = 0;
>>   	struct drm_crtc *tmp;
>> @@ -1051,7 +1056,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>>   		struct mtk_ddp_comp *comp;
>>   
>>   		node = priv->comp_node[comp_id];
>> -		comp = &priv->ddp_comp[comp_id];
>> +		comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_id);
>>   
>>   		/* Not all drm components have a DTS device node, such as ovl_adaptor,
>>   		 * which is the drm bring up sub driver
>> @@ -1063,7 +1068,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>>   			return 0;
>>   		}
>>   
>> -		if (!comp->dev) {
>> +		if (!comp || !comp->dev) {
>>   			dev_err(dev, "Component %pOF not initialized\n", node);
> 
> I think you should print other error message and return other value for !comp.
> 

In mtk_crtc_create, at this point, the component (which always has a node, pointed
by node = priv->comp_node[comp_id]) has to be initialized by mtk_ddp_comp.

Keeping in mind that the component is actually a device, if the component itself
was not initialized at this point, this means that there is NO DEVice associated
with it.

This is why -ENODEV.

Also, we're printing %pOF (like before) because this gives hints about precisely
which one was not registered at this point.

>>   			return -ENODEV;
>>   		}
>> @@ -1089,12 +1094,17 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>>   		return ret;
>>   	}
>>   
>> -	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>> +	for (i = 0, j = 0; i < mtk_crtc->ddp_comp_nr; i++, j++) {
>>   		unsigned int comp_id = path[i];
>>   		struct mtk_ddp_comp *comp;
>>   
>> -		comp = &priv->ddp_comp[comp_id];
>> -		mtk_crtc->ddp_comp[i] = comp;
>> +		comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_id);
>> +		if (!comp) {
> 
> In original code, it never check comp is null or not.
> I think it base on an assumption that it would not be null.
> If it's null here, print error message and it's not necessary to do the rest thing.
> 

The iterator here tries to still setup a display pipeline in case a component is
missing, and this actually works in a couple of corner cases, which were not
possible before the restructuring of mediatek-drm.

In later commits, this case will be handled differently: the problem here is rather
that the code readability is not the best at this point in time (of the series),
but this will make a lot more sense when going forward in this exact series.

The main issue here is that mediatek-drm's complexity is very, very high, and the
maintainability suffers a lot: doing each and every change as a perfectly clean
(and perfectly readable) diff means adding another ~4k thousand lines of changes
that are simply addition and removal of the same lines over and over again.

>> +			j--;
>> +			dev_dbg(dev, "Cannot find component %d.\n", comp_id);
>> +			continue;
>> +		}
>> +		mtk_crtc->ddp_comp[j] = comp;
>>   
>>   		if (comp->funcs) {
>>   			if (comp->funcs->gamma_set && comp->funcs->gamma_get_lut_size) {
>> @@ -1131,7 +1141,14 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>>   	 * In the case of ovl_adaptor sub driver, it needs to use the
>>   	 * dma_dev_get function to get representative dma dev.
>>   	 */
>> -	mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(&priv->ddp_comp[path[0]]);
>> +	dma_comp = mtk_ddp_comp_find_by_id(&priv->hlist, path[0]);
>> +	if (dma_comp == NULL) {
> 
> if (!dma_comp) is more simple.
> 

Yeah, I agree. If you're really worried about seeing this instead of !dma_comp I
can change it here... but if you can ignore that, in later commits this will be
removed and completely changed so that it becomes

	ret = mtk_crtc_find_suitable_dma_dev(mtk_crtc);
	if (ret) {
		dev_err(dev, "Could not find appropriate DMA device!\n");
		return -EINVAL;
	}
	dev_dbg(dev, "Using DMA device %pOF\n", mtk_crtc->dma_dev->of_node);

Note that if I change this simple line here, I'll have to fix other patches as
they won't apply anymore because of the changed line... so again, if we could
ignore that it would be great...

>> +		dev_err(dev, "Could not find appropriate DMA device!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(dma_comp);
>> +	dev_dbg(dev, "Using DMA device %pOF\n", mtk_crtc->dma_dev->of_node);
>>   
>>   	ret = mtk_crtc_init(drm_dev, mtk_crtc, crtc_i);
>>   	if (ret < 0)
>> @@ -1188,17 +1205,18 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>>   		for (i = 0; i < num_conn_routes; i++) {
>>   			unsigned int comp_id = conn_routes[i].route_ddp;
>>   			struct device_node *node = priv->comp_node[comp_id];
>> -			struct mtk_ddp_comp *comp = &priv->ddp_comp[comp_id];
>> +			struct mtk_ddp_comp *comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_id);
>>   
>> -			if (!comp->dev) {
>> +			if (!comp || !comp->dev) {
> 
> In original code, it never check comp is null or not.
> I think it base on an assumption that it would not be null.
> If it's null here, print error message and it's not necessary to do the rest thing.
> 

Already explained why we need comp to be checked for NULL.

>>   				dev_dbg(dev, "comp_id:%d, Component %pOF not initialized\n",
>>   					comp_id, node);
>>   				/* mark encoder_index to -1, if route comp device is not enabled */
>> -				comp->encoder_index = -1;
>> +				if (comp)
>> +					comp->encoder_index = -1;
>>   				continue;
>>   			}
>>   
>> -			mtk_ddp_comp_encoder_index_set(&priv->ddp_comp[comp_id]);
>> +			mtk_ddp_comp_encoder_index_set(comp);
>>   
>>
> 
> [snip]
> 
>> 		}
>>   @@ -1116,8 +1118,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>>   							    PLATFORM_DEVID_AUTO,
>>   							    (void *)private->mmsys_dev,
>>   							    sizeof(*private->mmsys_dev));
>> -		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev = &ovl_adaptor->dev;
>> -		mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR],
>> +		mtk_ddp_comp_init(&ovl_adaptor->dev, NULL, &private->hlist,
> 
> mtk_ddp_comp_init(dev, NULL, &private->hlist,
> 

That was only done for readability purposes. This will be entirely moved out of
here in a later commit.

Same as before, if you really think that this needs to be (dev, NULL, ...) instead
of (&ovl_adaptor->dev, NULL, ...) I can change that, but this means I'll have to
fix 30 patches ahead (plus ones that I have in my tree that are not in this series)

It's not a bug, nor anything critical, not breaking anything, and resolved with
later commits changing everything so, for the sake of efficiency, if this could
be ignored (as it's just a nit), I'd be happy.

Cheers,
Angelo
