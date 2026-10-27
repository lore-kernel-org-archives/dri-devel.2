Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F9606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=MfD5y+Bx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A9F10F53A;
	Tue, 27 Oct 2026 13:36:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A7E10F53A
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=UNc3OO7ZLeNEsfdeIxocXBns1jYe1BnBgzT9yKA91kY=; b=MfD5y+BxU4TnprhOlXnlE1SMGX
 USaVoSC09cV4FjnidQqaQtCXN8ZwO7hb0yK5xPSxLDAyOUt3CMccUYHUIHeENXGxQDAg+CB4pK/nX
 SII/FUIveaN41nvKJlX+Sks8WPsW+LijuIbcJRkgrJ7WwY+8JeUVCGk1bicn/F4jjVAw5pjiaq3bU
 niEfKZdq1f9YOl2uQcwQfbCOGUlVDmSBVo2+n4FdisK5ehETMepYEFGX3Rw4p+U+cSPK4JqOupKgV
 NDDOVoz8qRlSKRMS3rF4/qhxlNCAV9i6jeXw1cMIAhuMhrP64iHGVNfYBlI3EQGWydvy/NcVKVLhE
 qcv+AwbA==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xLhLN-00BpPJ-5N; Tue, 27 Oct 2026 14:36:01 +0100
Message-ID: <45ea1610-360f-4f6b-9ea6-30b28fbe8514@igalia.com>
Date: Tue, 27 Oct 2026 10:35:56 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
 <20261014-vc4-common-scramb-v3-6-c68d58d959a2@collabora.com>
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
In-Reply-To: <20261014-vc4-common-scramb-v3-6-c68d58d959a2@collabora.com>
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian,

On 13/10/26 22:03, Cristian Ciocaltea wrote:
> Replace driver local scrambling logic with the newly introduced common
> HDMI 2.0 scrambling support:
> 
> - Advertise source-side scrambling capability by setting supported HDMI
>    version based on the variant's max_pixel_clock.
> 
> - Provide minimal .scrambler_{enable,disable} connector callbacks that
>    only toggle the VC5 HDMI_SCRAMBLER_CTL register, while delegating
>    sink-side SCDC programming and periodic status monitoring to
>    drm_connector_hdmi_{enable,disable}_scrambling().
> 
> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>    the .detect_ctx() path to drm_atomic_helper_connector_hdmi_hotplug()
>    which internally calls drm_connector_hdmi_sync_scdc() to trigger a
>    CRTC reset on reconnection.
> 
> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>    flag, now tracked by the common drm_connector_hdmi layer, as well as
>    the now unused output_{bpc,color_format} driver data members.
> 
> No functional change intended.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 230 +++++------------------------------------
>   drivers/gpu/drm/vc4/vc4_hdmi.h |  21 ----
>   2 files changed, 28 insertions(+), 223 deletions(-)
> 

[...]

>   
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_connector_hdmi_disable_scrambling() will thus run at boot,
> +	 * make sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled = drm_connector_hdmi_scrambler_supported(connector);
> +

I'm okay merging this series to drm-misc-next, but I believe that
Sashiko's report has a point about this chunk. If the display if off or
disconnected, the boot-time disable would never run. Could you please
take a look at it?

Also, while greping the code, one thing caught my attention:
drm_connector_hdmi_disable_scrambling() is called at
vc4_crtc_disable_at_boot() before drm_dev_register(). Does that mean
that connector->status might be connector_status_unknown at that point?
I'm concerned due to the last if-block in
drm_connector_hdmi_disable_scrambling(). Am I mistaken?

Best regards,
- Maíra



