Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B17606A332
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=iqC4ytrj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EAE10F562;
	Tue, 24 Nov 2026 12:44:12 +0000 (UTC)
Received: from mail-m1045.netease.com (mail-m1045.netease.com [154.81.10.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A976A10F562
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:44:05 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55d3a622a;
 Tue, 24 Nov 2026 20:44:01 +0800 (GMT+08:00)
Message-ID: <16906835-557f-48c1-aecc-63df816a4672@rock-chips.com>
Date: Tue, 24 Nov 2026 20:43:57 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/42] drm/atomic_sro: Add atomic state readout
 infrastructure
To: Maxime Ripard <mripard@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-15-a67c2b45b8ec@kernel.org>
 <898d050d-9c19-4706-b1b2-ff3e23d68efe@rock-chips.com>
 <awWAd4GbeBziItCE@houat>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <awWAd4GbeBziItCE@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa20d95a9b803a7kunm21e2b36ed0b8b7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkwZVh1KH0lCS0tOH0MdHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=iqC4ytrjFVjAo/854TNIJxlvtA1o+POysCV9i+LDRYkTNVyuV4KHzqJQNFm05IHhgUgmlKdMLZMaN3GNV42cl2CKzPKGfoYC+OiEyRAVly5uWL1rLB5vAG1TIIrp+Wcirnp8PGFGDLk+CqLL1+5UnTCLa2F2MR0iLGVMEL+JBEE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=LlGqM64xMHz03kQHhXEC2QxSSp/8/oo0Ou/dnDCF5QI=;
 h=date:mime-version:subject:message-id:from;
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/2026 8:28 PM, Maxime Ripard wrote:
> Hi Chaoyi,
> 
> On Tue, Nov 24, 2026 at 11:54:03AM +0800, Chaoyi Chen wrote:
>> Hi Maxime,
>>
>> For a long time, we have implemented something similar through our own
>> hack. Thank you very much for this series.
> 
> I'm glad it's useful :)
> 
>> Please see below:
>>
>> On 11/20/2026 8:55 PM, Maxime Ripard wrote:
>>> In order to enable drivers to read their initial state from the
>>> hardware, each KMS object needs a hook to fill a pre-allocated state
>>> from the hardware registers.
>>>
>>> Introduce the atomic_sro_readout_state hook in every KMS object funcs
>>> vtable: drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs,
>>> drm_bridge_funcs, and drm_private_state_funcs.
>>>
>>> Also introduce the drm_mode_config_funcs.atomic_sro_readout_state and
>>> drm_mode_config_helper_funcs.atomic_sro_build_state hooks, which are the
>>> top-level entry points for drivers and helpers respectively.
>>>
>>> The states read out aren't the current states of the objects yet, so
>>> they also need to be installed. Introduce the
>>> drm_mode_config_helper_funcs.atomic_sro_install_state hook to install a
>>> whole drm_atomic_sro_state, and an optional atomic_sro_install_state
>>> hook in drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs and
>>> drm_private_state_funcs. The latter is called before the state of an
>>> object is replaced, so that drivers can acquire the resources needed to
>>> keep the hardware state active.
>>>
>>> Finally, add drm_atomic_sro_can_readout() to verify that all objects on
>>> a device implement the readout hook, and wire it into
>>> drm_atomic_sro_device_can_readout().
>>>
>>> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>>> ---
>>
>> [...]
>>
>>> +
>>> +	/**
>>> +	 * @atomic_sro_install_state:
>>> +	 *
>>> +	 * This optional hook is called when a state read out from
>>> +	 * hardware is about to be installed as the plane's current
>>> +	 * state.
>>> +	 *
>>> +	 * It allows drivers to acquire the resources needed to keep
>>> +	 * the current hardware state active, such as power domains,
>>> +	 * clocks, or interrupts.
>>> +	 *
>>> +	 * This hook cannot fail. It is called by the
>>> +	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
>>> +	 * implementation, which is part of the hardware state readout
>>> +	 * initialization sequence.
>>> +	 */
>>> +	void (*atomic_sro_install_state)(struct drm_plane *plane,
>>> +					 struct drm_plane_state *plane_state);
>>> +
>>
>> Due to the presence of clk_disable_unused(), the relevant clk is likely
>> to be disabled prematurely, which may cause symptoms such as a black
>> screen. 
>>
>> How does atomic_sro_install_state() ensure that it is called early enough,
>> thereby enabling the driver to turn on the corresponding clock?
>>
>> Or is this something that driver implementers need to consider, and should
>> the DRM core provide some kind of helper? Thank you.
> 
> I guess you have mainly three options, depending on what your preferred
> setup is:
> 
> - If your display driver is compiled as a built-in, it's a non-issue
>   since the read-out will have been done before clk_disable_unused()
>   runs.
> 
> - The typical "distro" setup is that simpledrm will be builtin, grab the
>   clock, we'll then load the driver as a module, do the readout, call
>   install_state to get a clock reference and then drop simpledrm and its
>   clock reference.
> 
>   In such a case, you always have a prepare / enable count > 1 so the
>   clock never gets disabled by clk_disable_unused().
> 
> - If you don't want to have simpledrm but have the display driver as a
>   module, and thus need to keep the clock running even though
>   clk_disable_unused runs, I guess your best bet is to look into the
>   sync_state Brian has been working on:
>   https://lore.kernel.org/linux-clk/20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com/
> 
> Maxime

Very insightful. Thank you for sharing this information. :)

-- 
Best, 
Chaoyi

