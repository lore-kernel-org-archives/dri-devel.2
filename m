Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A9606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F+B7eqKV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4681610E571;
	Tue, 24 Nov 2026 19:50:04 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6D110E571
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795549796;
 bh=5+s3ntbrWWKLh7zmQebaGp4DJFwhHHTRju1hyqw1NWY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F+B7eqKVvizIse/ZJu2JcFT0aznOBckGoON/nDF/bRi2SNlidw6B7KJtluVFz9Boh
 m28lpeAl62x+DfW4To84cgQOW8eGEj3PeKWbQuJTg/6MHkKFdHnd532MF38gqeSWPg
 YgR5gENYbFJVDuX1jPDCxp/VHT/5HKdALWT/+wJLXpoC85vKJwBa3dNb7uTDm2oRvU
 sjKaRNFncg7W1GxixFbLnYShuC1sZdofUCSQg7iJWGlCGdfQI8TsrjoCrEjgtAIx3E
 ouOe3Nw33BQ20w07l51t8BeSx+8DNYDT3S2riYaaM9KWVwsV3r1597eObaMi5Z9AdX
 NxdzoBJKiTweg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CC26F17E010E;
 Tue, 24 Nov 2026 20:49:55 +0100 (CET)
Message-ID: <a267fd1e-412a-489b-8c2f-be95b6ad8b31@collabora.com>
Date: Tue, 24 Nov 2026 21:49:55 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] drm/display: hdmi-state-helper: Reject connectors
 lacking HDMI funcs
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>,
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-4-20e8a33a2286@collabora.com>
 <awQ37kPdVr3Rb4rL@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <awQ37kPdVr3Rb4rL@houat>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

Thanks for checking this out!

On 11/23/26 2:57 PM, Maxime Ripard wrote:
> On Sat, Nov 14, 2026 at 08:03:28PM +0200, Cristian Ciocaltea wrote:
>> drm_atomic_helper_connector_hdmi_check() must only be used with
>> connectors set up via drmm_connector_hdmi_init(), which guarantees
>> connector->hdmi.funcs is set.
> 
> I don't think that's true or mandated anywhere, and just like any other
> helpers, we'll probably end up with a driver reusing parts of the states
> but reimplementing part of the logic.

Ack, I will drop drm_WARN_ON_ONCE() and move the guard in hdmi_compute_config(),
before accessing connector->hdmi.funcs->max_bpc.

I would simply return -EINVAL with a proper debug message, rather than forcing
max_bpc to 0 and letting hdmi_compute_format_bpc() still be called, which would
generate a bunch of potentially misleading "output format not supported for any
bpc count" messages.

Regards,
Cristian

> 
> Maxime
> 
>> Other connectors used to fail gracefully: with max_bpc and
>> supported_formats both zero, hdmi_compute_config() found no usable
>> format/bpc combination and returned -EINVAL before
>> hdmi_generate_infoframes() dereferenced hdmi.funcs.
>>
>> As those fields are being replaced by drm_connector_hdmi_funcs
>> counterparts, hdmi_compute_config() would dereference hdmi.funcs right
>> away.  To preserve the old behaviour, return an error early for such
>> connectors, and use drm_WARN_ON_ONCE() to flag the driver bug.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index c50cedc7fa65..f533d5a7aab9 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -912,6 +912,9 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>>  	if (!new_conn_state->crtc || !new_conn_state->best_encoder)
>>  		return 0;
>>  
>> +	if (drm_WARN_ON_ONCE(connector->dev, !connector->hdmi.funcs))
>> +		return -EINVAL;
>> +
>>  	ret = hdmi_compute_config(connector, new_conn_state, mode);
>>  	if (ret)
>>  		return ret;
>>
>> -- 
>> 2.56.0
>>
