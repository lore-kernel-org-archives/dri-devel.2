Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10578606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=KRKJo35A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFDD10F25D;
	Mon,  9 Nov 2026 12:41:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B27110F25D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=f+/rvpSnyGAg1uGXCiVfJRDQ5Zsx/f3G/vzkEJ12Kx4=; t=1794228060; x=2109588060; 
 b=KRKJo35AcJobuyMoWpZwXsfek8YlQlYFKKgIcVYOk+GMmm/YlI8qg/pZ1k3gRvhTi+drnOLg2+C
 akguTNgYr6suFn1OpBzfZOpN+JudehXOgh869lx2lJejeWIbq7bnWryIJxl2NLlcCFRSMZ7DiktIi
 OwEkk989ScbBimFGVIZDS4EJm9NybhzmzBJUMsAEmduj6coBEOGeLzkFzd+kSTl6ju+mrTUiZyu2o
 0A5NDtnmuSstHGJwceQeOQKRskIyJ+IQs8FIQK8o5GW3CVKxCNmQvxIU0meEQuJEy5Q07DtAKJMJW
 dsEpLpdCQWjpwE7oPWaAxTeuSRLcBy9uOyxA==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQOg7-007Gw2-Og; Mon, 09 Nov 2026 13:40:51 +0100
Message-ID: <b3b2bfc8-b6cf-4b89-bc7f-5f1987beea7e@igalia.com>
Date: Mon, 9 Nov 2026 09:40:47 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/display: hdmi: Prevent NULL pointer dereference
 in sync_scdc()
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
 <20261104-hdmi-scdc-scramb-fixes-v1-1-16a9bb3d64a6@collabora.com>
 <712f4d29-f69c-4130-9cc6-3efccacba3aa@igalia.com>
 <e9a58f67-d6ff-44a4-ab32-31e44e6f7f0f@collabora.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <e9a58f67-d6ff-44a4-ab32-31e44e6f7f0f@collabora.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/11/26 09:39, Cristian Ciocaltea wrote:
> Hi Maíra,
> 
> On 11/9/26 2:00 PM, Maíra Canal wrote:
>> Hi Cristian,
>>
>> On 04/11/26 10:26, Cristian Ciocaltea wrote:
>>> The connector pointer is used to initialize the local variables hdmi and
>>> dev before the NULL check takes place, leading to the following Smatch
>>> complaint:
>>>
>>>     drivers/gpu/drm/display/drm_hdmi_helper.c:663 drm_connector_hdmi_sync_scdc()
>>>     warn: variable dereferenced before check 'connector' (see line 657)
>>>
>>> Move those initializations after the sanity check to avoid a potential
>>> NULL pointer dereference.
>>>
>>> Fixes: d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling management helpers")
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>> Closes: https://lore.kernel.org/all/arJo7A7L5hud3tyc@stanley.mountain/
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>    drivers/gpu/drm/display/drm_hdmi_helper.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
>>> index f85cce3d6254..872f7e32e8d2 100644
>>> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
>>> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
>>> @@ -653,9 +653,9 @@ EXPORT_SYMBOL(drm_connector_hdmi_disable_scrambling);
>>>    int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>>>                     struct drm_modeset_acquire_ctx *ctx)
>>>    {
>>> -    struct drm_connector_hdmi *hdmi = &connector->hdmi;
>>> -    struct drm_device *dev = connector->dev;
>>> +    struct drm_connector_hdmi *hdmi;
>>>        struct drm_connector_state *conn_state;
>>> +    struct drm_device *dev;
>>>        struct drm_crtc *crtc;
>>>        u8 config;
>>>        int ret;
>>> @@ -663,6 +663,9 @@ int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>>>        if (!connector || !plugged || !ctx)
>>>            return 0;
>>>    +    hdmi = &connector->hdmi;
>>
>> hdmi is only used once (and you are going to delete it in the next
>> commit), so personally, I would prefer to delete this variable in this
>> commit and use connector->hdmi directly when needed.
> 
> Ack.
> 
>>
>>> +    dev = connector->dev;
>>> +
>>>        /*
>>>         * This is normally part of .detect_ctx() call path, which already holds
>>>         * connection_mutex through @ctx.  However, re-acquiring it with the
>>>
>>
>> drm_modeset_lock() here could use the variable dev instead of
>> &connector->dev.
> 
> Well spotted, I missed it.
> 
>>
>> Anyway, these are just a few nits.
>>
>> Reviewed-by: Maíra Canal <mcanal@igalia.com>
> 
> Thank you for reviewing the series.  Please let me know if you'd still like me to
> send a v2 to address your findings in this patch.
> 

These are very small nits, not worth a v2. Feel free to push the patches
to drm-misc-fixes.

Best regards,
- Maíra

> Kind regards,
> Cristian

