Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1160A261A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=H2NZ64xm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6699A10F607;
	Tue, 10 Nov 2026 11:57:58 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AD310E121
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=N1/wz6KUYVi+96sij3kj8fWuuxqtPbXXot2DW5Jb/e0=; t=1794311871; x=2109671871; 
 b=H2NZ64xmIpUkptGCjA4cDwqE57HWxGrkrtPNEC8rcZOoiRYBUz5wQTC55CnyS5d2uwDQe5pfLIf
 SFAbFgXuaU+6CcJbxNiNAelwCQ2Q0TKqRlVhQjRQDmeZ7l+DwJV8mXRkhWlOFO75aCOmTqCQjOK9b
 1WWooGSjRELTgCEbKYrkugNnw/xeXVKOr9s5z4oBif6ECsah9mzUIqhqjVSk2HiMfX6Lzyub9yUQY
 jTQgcNit5hyt+9rgKbkYA8HDo6NH4TNiQH5uR4OZXfB/b89V3yTYXLlGitEaaPHx2ggqYNHkcC8ku
 1qQNSo9Z45PcBtrLo4mUe2TIXbvV/BOTIznQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQkTg-0088nY-Pq; Tue, 10 Nov 2026 12:57:29 +0100
Message-ID: <924b1db7-3498-4cc6-a57a-16b1c7c3bc73@igalia.com>
Date: Tue, 10 Nov 2026 08:57:23 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] drm/vc4: hdmi: Switch to
 drm_hdmi_mode_needs_scrambling()
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
 <20261110-vc4-common-scramb-v4-2-eaa141a0da0f@collabora.com>
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
In-Reply-To: <20261110-vc4-common-scramb-v4-2-eaa141a0da0f@collabora.com>
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

On 09/11/26 21:13, Cristian Ciocaltea wrote:
> The VC4 HDMI driver has a local helper to check whether a mode requires
> scrambling.  It is equivalent to drm_hdmi_mode_needs_scrambling(), so
> use the common helper instead.
> 
> No functional change intended.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 22533f1c6207..d9383af60906 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -129,15 +129,6 @@ static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
>   	return true;
>   }
>   
> -static bool vc4_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode,
> -					   unsigned int bpc,
> -					   enum drm_output_color_format fmt)
> -{
> -	unsigned long long clock = drm_hdmi_compute_mode_clock(mode, bpc, fmt);
> -
> -	return clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> -}
> -
>   static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>   {
>   	struct drm_debugfs_entry *entry = m->private;
> @@ -312,7 +303,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
>   		return 0;
>   	}
>   
> -	scrambling_needed = vc4_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
> +	scrambling_needed = drm_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
>   							   vc4_hdmi->output_bpc,
>   							   vc4_hdmi->output_format);
>   	if (!scrambling_needed) {
> @@ -442,7 +433,8 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
>   		const struct drm_display_mode *mode;
>   
>   		list_for_each_entry(mode, &connector->probed_modes, head) {
> -			if (vc4_hdmi_mode_needs_scrambling(mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444)) {
> +			if (drm_hdmi_mode_needs_scrambling(mode, 8,
> +							   DRM_OUTPUT_COLOR_FORMAT_RGB444)) {
>   				drm_warn_once(drm, "The core clock cannot reach frequencies high enough to support 4k @ 60Hz.");
>   				drm_warn_once(drm, "Please change your config.txt file to add hdmi_enable_4kp60.");
>   			}
> @@ -819,7 +811,7 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
>   	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
>   		return;
>   
> -	if (!vc4_hdmi_mode_needs_scrambling(mode,
> +	if (!drm_hdmi_mode_needs_scrambling(mode,
>   					    vc4_hdmi->output_bpc,
>   					    vc4_hdmi->output_format))
>   		return;
> 

