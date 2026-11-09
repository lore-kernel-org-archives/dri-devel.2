Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB27606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fxI4Jpsd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5035D10F258;
	Mon,  9 Nov 2026 12:39:38 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA2B10F258
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794227970;
 bh=SYFx4542py389igztUanI5VcIPWwi6M9GrC/elcvR9c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fxI4Jpsd3g7vTSj46IWhYwEDBmQbgb3PPI7s5SdPEz7twavuZGjBiKftphJJ7Eflf
 QNLg4yjUSTbRb1OWW9Y+oQkSrmfeeTp7c1qL4FbxVZl070dUt8dVOP/QXwVVCZ1cpR
 X3+IRgjH/7k07xdd8KUs249PG9BR2FhljH/B6WreOZKKwqi7ZgDqihPYC+z5cySMiY
 wty0hXwM6K8yzXa/l4P5d+ho2ltdBC9G8C9iq8Fu+HgKhWWK3feToXZgW9SpK1PXW4
 /2Ibxqi0slNit3as5Z2XkEkwqTAsqNlpKN7weyibzZlrK7MLa2O0ujKIO5IkubszGd
 YbtGQv0U6c6IQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8D59617E07E5;
 Mon, 09 Nov 2026 13:39:30 +0100 (CET)
Message-ID: <e9a58f67-d6ff-44a4-ab32-31e44e6f7f0f@collabora.com>
Date: Mon, 9 Nov 2026 14:39:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/display: hdmi: Prevent NULL pointer dereference
 in sync_scdc()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
 <20261104-hdmi-scdc-scramb-fixes-v1-1-16a9bb3d64a6@collabora.com>
 <712f4d29-f69c-4130-9cc6-3efccacba3aa@igalia.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <712f4d29-f69c-4130-9cc6-3efccacba3aa@igalia.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Maíra,

On 11/9/26 2:00 PM, Maíra Canal wrote:
> Hi Cristian,
> 
> On 04/11/26 10:26, Cristian Ciocaltea wrote:
>> The connector pointer is used to initialize the local variables hdmi and
>> dev before the NULL check takes place, leading to the following Smatch
>> complaint:
>>
>>    drivers/gpu/drm/display/drm_hdmi_helper.c:663 drm_connector_hdmi_sync_scdc()
>>    warn: variable dereferenced before check 'connector' (see line 657)
>>
>> Move those initializations after the sanity check to avoid a potential
>> NULL pointer dereference.
>>
>> Fixes: d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling management helpers")
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/all/arJo7A7L5hud3tyc@stanley.mountain/
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   drivers/gpu/drm/display/drm_hdmi_helper.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
>> index f85cce3d6254..872f7e32e8d2 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
>> @@ -653,9 +653,9 @@ EXPORT_SYMBOL(drm_connector_hdmi_disable_scrambling);
>>   int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>>                    struct drm_modeset_acquire_ctx *ctx)
>>   {
>> -    struct drm_connector_hdmi *hdmi = &connector->hdmi;
>> -    struct drm_device *dev = connector->dev;
>> +    struct drm_connector_hdmi *hdmi;
>>       struct drm_connector_state *conn_state;
>> +    struct drm_device *dev;
>>       struct drm_crtc *crtc;
>>       u8 config;
>>       int ret;
>> @@ -663,6 +663,9 @@ int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>>       if (!connector || !plugged || !ctx)
>>           return 0;
>>   +    hdmi = &connector->hdmi;
> 
> hdmi is only used once (and you are going to delete it in the next
> commit), so personally, I would prefer to delete this variable in this
> commit and use connector->hdmi directly when needed.

Ack.

> 
>> +    dev = connector->dev;
>> +
>>       /*
>>        * This is normally part of .detect_ctx() call path, which already holds
>>        * connection_mutex through @ctx.  However, re-acquiring it with the
>>
> 
> drm_modeset_lock() here could use the variable dev instead of
> &connector->dev.

Well spotted, I missed it.

> 
> Anyway, these are just a few nits.
> 
> Reviewed-by: Maíra Canal <mcanal@igalia.com>

Thank you for reviewing the series.  Please let me know if you'd still like me to
send a v2 to address your findings in this patch.

Kind regards,
Cristian
