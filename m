Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549C8C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8201F10EEB9;
	Mon, 14 Sep 2026 13:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lwaESWAr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FGwfGGSU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XqE5OLZq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eG1kSkKf";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCE410EEB7
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:58:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E15181F391;
 Mon, 14 Sep 2026 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789394325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gLYlfP+RXcScEqxnc1dTj1g2B6yVAAFHt/PeYSrBmyA=;
 b=lwaESWArdKz8m7ROPYUucrNZyD0MPmlCFEnNEITnlZTK7DlK6KvthPwzRpxYW4I5yMgv1U
 gPnUODdTqXw0ZbnPEJSH6iEHEe1Y0swhjFobvr2Btj/KzXfJsA9Ki+SlfhUBXCtukw6LCP
 AmvRg2sKnsHDbi0SL69veA7sZE+FQYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789394325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gLYlfP+RXcScEqxnc1dTj1g2B6yVAAFHt/PeYSrBmyA=;
 b=FGwfGGSUAXfUOxrtO6TuRDKX20kb8c6/IqQYIBYicB/8HaqMdQun4DD8BWmw1wkni7czfQ
 /YemHm5GNGbOEaDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XqE5OLZq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eG1kSkKf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789394320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gLYlfP+RXcScEqxnc1dTj1g2B6yVAAFHt/PeYSrBmyA=;
 b=XqE5OLZqm4gfHv0RwS4aLXWWlalhrli/d1FOp4Slbbqf6nGz1OSVuKwEMC/Yo+9VHpEuFe
 eS+1gZ76bD7lH5OKy/F3yeE8xUUs8t7KqG3NJ0j0JoYdktaZ3LasyoLPymYxRIMeaI/B1c
 chs7GH+3p/kGrCcCH7SbKT85G7FFL6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789394320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gLYlfP+RXcScEqxnc1dTj1g2B6yVAAFHt/PeYSrBmyA=;
 b=eG1kSkKfveVKbYFeLYTnBAqxkQWFJ0aJO4P0K/kqb+0Q5ITdeYUzxOhWrXLCLt+/LvtcjJ
 HRZu3gMsogmca1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6FE913515;
 Mon, 14 Sep 2026 13:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xRppLI/9p2pCAQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 14 Sep 2026 13:58:39 +0000
Message-ID: <f0b2beb9-d0ad-4870-812a-fef530a964c3@suse.de>
Date: Mon, 14 Sep 2026 15:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] drm/spacemit: add Saturn DPU KMS pipeline
To: codykang.hk@gmail.com, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-10-327d7910bf71@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260809-k3-display-v2-10-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E15181F391
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org,linaro.org,4d2.org,baylibre.com,redhat.com,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ziyao.cc];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[30]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[dt];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLkaw45m9fyyou58pkcdpg1rmb)];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, bootlin.com:url, spacemit_drm_drv.name:url,
 suse.de:dkim, suse.de:mid, x:email]
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

Hi,

please find a review below.  I've only mentioned most issues once, they 
are usually throughout the code. Please fix all instances then.


Am 09.08.26 um 15:14 schrieb Cody Kang via B4 Relay:
> From: Cody Kang <codykang.hk@gmail.com>
>
> Add the atomic KMS implementation on top of the hardware backend: one
> CRTC and one primary plane per DPU instance. atomic_check validates
> the plane rectangle 1:1 against the mode and sizes the per-channel FBC
> line buffer; atomic commit builds the cmdlist batches, maps the
> framebuffer through the DMMU and arms the cfg-ready handshake, with
> vblank events driven from the DPU interrupt.
>
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
>
> ---
> v2:
> - put all five DPU reset lines behind one reset_control_bulk_* pair
>    (Philipp Zabel, Guodong Xu)
> - keep the online IRQ alive across drm_dev_unregister() and
>    drm_atomic_helper_shutdown() in unbind (Sashiko)
> - free the per-state DMA buffers in the plane .reset path instead of
>    bypassing the custom state destructor (Sashiko)
> - release the duplicated state's references on the rdmas allocation
>    failure path in crtc duplicate_state (Sashiko)
> - set clocks_on only after dpu_pm_resume() has enabled the clocks
>    (Sashiko)
> ---
>   drivers/gpu/drm/spacemit/spacemit_crtc.c   | 786 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/spacemit/spacemit_planes.c | 377 ++++++++++++++
>   2 files changed, 1163 insertions(+)
>
> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> new file mode 100644
> index 0000000000000..fd23d804d98cc
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> @@ -0,0 +1,786 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + */
> +
> +#include <drm/drm_print.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_managed.h>
> +#include <drm/clients/drm_client_setup.h>
> +#include <linux/aperture.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/component.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_qos.h>
> +#include <linux/property.h>
> +#include <linux/mutex.h>
> +#include <linux/string.h>
> +#include <linux/trace_events.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include "spacemit_dpu_ids.h"
> +#include <linux/reset.h>
> +#include "spacemit_cmdlist.h"
> +#include "spacemit_dmmu.h"
> +#include "spacemit_drm.h"
> +#include "spacemit_crtc.h"
> +#include "dpu/dpu_saturn.h"
> +#include "dpu/dpu_trace.h"
> +
> +static int spacemit_crtc_init(struct spacemit_crtc *a_crtc);
> +static int spacemit_crtc_uninit(struct spacemit_crtc *a_crtc);
> +static int dpu_pm_suspend(struct device *dev);
> +static int dpu_pm_resume(struct device *dev);
> +
> +static void saturn_count_rdma_use(struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_plane *plane;
> +	struct spacemit_crtc_state *spacemit_state =
> +			to_spacemit_crtc_state(crtc_state);
> +	struct spacemit_crtc_rdma *rdmas = spacemit_state->rdmas;
> +	u32 rdma_id = 0;
> +	const struct drm_plane_state *pstate;
> +
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		rdma_id = to_spacemit_plane_state(pstate)->rdma_id;
> +		if (rdma_id != RDMA_INVALID_ID)
> +			rdmas[rdma_id].use_cnt++;
> +	}
> +}
> +
> +static int spacemit_crtc_atomic_check_fbmem(struct drm_crtc *crtc,
> +					    struct drm_crtc_state *crtc_state)
> +{
> +	struct spacemit_crtc_rdma *rdmas =
> +			to_spacemit_crtc_state(crtc_state)->rdmas;
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +	struct spacemit_drm_private *priv = crtc->dev->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	const struct drm_plane_state *pstate;
> +	struct drm_plane *plane;
> +
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		u32 rdma_id = to_spacemit_plane_state(pstate)->rdma_id;
> +		u32 layer_fbcmem_size =
> +				to_spacemit_plane_state(pstate)->fbcmem_size;

If you need to check plane state, please do this in the plane's 
atomic_check. For atomic commits that only change plane state, the 
CRTC's atomic_check might not run, I think.

It looks like this code allocates memory. This is is something that 
should be done globally.


> +
> +		if (rdma_id != RDMA_INVALID_ID)
> +			rdmas[rdma_id].fbcmem.size = max(layer_fbcmem_size,
> +				rdmas[rdma_id].fbcmem.size);
> +	}
> +
> +	return a_crtc->core->adjust_rdma_fbcmem(hwdev, rdmas);
> +}
> +
> +static void spacemit_crtc_atomic_enable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *old_state)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +	struct spacemit_drm_private *priv = crtc->dev->dev_private;
> +	int idx;
> +	int ret;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;

drm_dev_enter() and drm_dev_exit() protect hardware access. Given hat 
you have a tracepoint below, you certainly don't want to return here. 
It's is better to write code like this

atomic_enable() {

   if (drm_dev_enter()) {

       // do HW access
       drm_dev_exit()
   }

}

although not many drivers do this.


> +
> +	trace_spacemit_crtc_atomic_enable(a_crtc->dev_id);

Why is your modesetting code is filled with tracepoints? Most other 
drivers don't need them. There is debugging infrastructure available in DRM.


> +
> +	/*
> +	 * U-Boot leaves its boot-logo pipeline running. Hard-stop it with the
> +	 * resets alone; the clocks are not ours to gate until we have enabled
> +	 * them.
> +	 */
> +	if (unlikely(a_crtc->first_modeset)) {
> +		ret = reset_control_bulk_assert(ARRAY_SIZE(priv->pipe_resets),
> +						priv->pipe_resets);
> +		if (ret)
> +			dev_warn(a_crtc->dev,
> +				 "failed to assert resets: %d\n", ret);
> +		usleep_range(10000, 20000);
> +		a_crtc->first_modeset = false;
> +	}

Just no. This code belongs into driver or platform init. It is 
definitely not for mode setting.

> +
> +	if (!a_crtc->clocks_on) {
> +		dpu_pm_resume(a_crtc->dev);
> +		a_crtc->clocks_on = true;
> +
> +		/*
> +		 * The DPU must settle after reset deassert or CFG_RDY races
> +		 * the flush.
> +		 */
> +		usleep_range(10000, 20000);
> +	}
> +
> +	drm_crtc_vblank_on(&a_crtc->crtc);

I'd say you want to enable vblanking after programming the display mode. (?)

> +
> +	spacemit_crtc_init(a_crtc);

The code is full of these tiny helpers. Please inline them. And please 
also avoid the callbacks that these tiny helpers invoke.  The DRM 
interfaces are your abstraction interface. Please don't introduce 
another one.

> +
> +	drm_dev_exit(idx);
> +}
> +
> +static void spacemit_crtc_atomic_disable(struct drm_crtc *crtc,
> +					 struct drm_atomic_commit *old_state)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +	struct drm_device *drm = a_crtc->crtc.dev;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	trace_spacemit_crtc_atomic_disable(a_crtc->dev_id);
> +
> +	spacemit_crtc_uninit(a_crtc);
> +
> +	drm_crtc_vblank_off(&a_crtc->crtc);
> +
> +	/*
> +	 * MMIO on a clock-gated DPU stalls the bus, so an in-flight handler
> +	 * must finish its status reads before dpu_pm_suspend() gates the
> +	 * clocks.
> +	 */
> +	if (a_crtc->irq_online > 0)
> +		synchronize_irq(a_crtc->irq_online);

This irq is unrelated to vblanking, I presume?


> +
> +	/*
> +	 * Nothing else cancels the watchdog; it would fire against freed state.
> +	 */
> +	timer_delete_sync(&a_crtc->cfg_rdy_timer);
> +
> +	/* Close the ISR's MMIO gate before the clocks actually stop. */
> +	a_crtc->clocks_on = false;
> +	dpu_pm_suspend(a_crtc->dev);

This whole DPU PM stuff doesn't seem to belong here.  There's are 
device-PM ops for controlling power management.  It might happen that 
compositors disable the CRTC for simple mode setting. This should not 
suspend the whole device.

> +
> +	spin_lock_irq(&drm->event_lock);
> +	if (crtc->state->event) {
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		crtc->state->event = NULL;
> +	}
> +	spin_unlock_irq(&drm->event_lock);

You need set up the vblank machinery to send the event on the next 
vblank irq. See [1] for a simple example.

[1] 
https://elixir.bootlin.com/linux/v7.2.5/source/drivers/gpu/drm/drm_vblank_helper.c#L51

> +
> +	drm_dev_exit(idx);
> +}
> +
> +static int spacemit_crtc_atomic_check(struct drm_crtc *crtc,
> +				      struct drm_atomic_commit *atomic_state)
> +{
> +	struct drm_crtc_state *state =
> +			drm_atomic_get_new_crtc_state(atomic_state, crtc);
> +	struct spacemit_crtc_state *cstate = to_spacemit_crtc_state(state);
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +	int ret = 0;
> +
> +	trace_spacemit_crtc_atomic_check(a_crtc->dev_id);

Please don't add your own tracepoints.

> +
> +	ret = spacemit_crtc_atomic_check_fbmem(crtc, state);
> +	if (ret) {
> +		drm_dbg_kms(crtc->dev,
> +			    "failed to satisfy fbcmem size for all rdmas\n");

Drivers should only use drm_dbg().  drm_dbg_kms() et al are for DRM core 
and helpers.


> +		return ret;
> +	}
> +
> +	saturn_count_rdma_use(state);
> +
> +	ret = spacemit_cmdlist_alloc(a_crtc->dev, &cstate->cl);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void spacemit_crtc_atomic_begin(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +
> +	trace_spacemit_crtc_atomic_begin(a_crtc->dev_id);
> +}
> +
> +static void spacemit_crtc_atomic_flush(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
> +		crtc);
> +	int idx;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;
> +
> +	trace_spacemit_crtc_atomic_flush(a_crtc->dev_id);
> +
> +	spacemit_crtc_run(crtc, old_state);
> +
> +	drm_dev_exit(idx);
> +}
> +
> +static struct drm_crtc_state *
> +spacemit_crtc_duplicate_state(struct drm_crtc *crtc)
> +{
> +	struct spacemit_crtc_state *state;
> +	struct spacemit_drm_private *priv = crtc->dev->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	u8 n_rdma;
> +
> +	if (WARN_ON(!crtc->state))

There are helpers like drm_WARN_ON() et al. Please prefer them over 
WARN_ON() and other non-DRM counterparts.



> +		return NULL;
> +
> +	state = kzalloc_obj(*state);
> +	if (!state)
> +		return NULL;
> +
> +	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
> +
> +	n_rdma = hwdev->rdma_nums;
> +	state->rdmas = kzalloc_objs(*state->rdmas, n_rdma);
> +	if (!state->rdmas) {
> +		__drm_atomic_helper_crtc_destroy_state(&state->base);
> +		kfree(state);
> +		return NULL;
> +	}
> +
> +	state->cl.type = CMDLIST_CRTC;
> +
> +	return &state->base;
> +}
> +
> +static void spacemit_crtc_destroy_state(struct drm_crtc *crtc,
> +					struct drm_crtc_state *state)
> +{
> +	struct spacemit_crtc_state *spacemit_state = NULL;
> +	struct spacemit_crtc *a_crtc = NULL;
> +
> +	if (state) {
> +		spacemit_state = to_spacemit_crtc_state(state);
> +		__drm_atomic_helper_crtc_destroy_state(state);
> +		a_crtc = to_spacemit_crtc(crtc);
> +		if (spacemit_state->cl.va)
> +			dma_free_coherent(a_crtc->dev,
> +					  spacemit_state->cl.size,
> +					  spacemit_state->cl.va,
> +					  spacemit_state->cl.pa);
> +		kfree(spacemit_state->rdmas);
> +		kfree(spacemit_state);
> +	}
> +}
> +
> +static void spacemit_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct spacemit_drm_private *priv = crtc->dev->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	struct spacemit_crtc_state *state;
> +
> +	if (crtc->state)
> +		spacemit_crtc_destroy_state(crtc, crtc->state);
> +
> +	state = kzalloc_obj(*state);
> +	if (!state) {
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);
> +		return;
> +	}
> +
> +	state->rdmas = kzalloc_objs(*state->rdmas, hwdev->rdma_nums);
> +	if (!state->rdmas) {
> +		kfree(state);
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);
> +		return;
> +	}
> +
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +}
> +
> +static int spacemit_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +
> +	trace_spacemit_crtc_enable_vblank(a_crtc->dev_id);
> +
> +	if (a_crtc->core && a_crtc->core->enable_vsync)
> +		a_crtc->core->enable_vsync(a_crtc);
> +
> +	return 0;
> +}
> +
> +static void spacemit_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +
> +	trace_spacemit_crtc_disable_vblank(a_crtc->dev_id);
> +
> +	if (a_crtc->core && a_crtc->core->disable_vsync)
> +		a_crtc->core->disable_vsync(a_crtc);
> +}
> +
> +static const struct drm_crtc_helper_funcs spacemit_crtc_helper_funcs = {
> +	.atomic_check = spacemit_crtc_atomic_check,
> +	.atomic_begin = spacemit_crtc_atomic_begin,
> +	.atomic_flush = spacemit_crtc_atomic_flush,
> +	.atomic_enable = spacemit_crtc_atomic_enable,
> +	.atomic_disable = spacemit_crtc_atomic_disable,
> +};
> +
> +static const struct drm_crtc_funcs spacemit_crtc_funcs = {
> +	.destroy = drm_crtc_cleanup,
> +	.set_config = drm_atomic_helper_set_config,
> +	.page_flip = drm_atomic_helper_page_flip,
> +	.reset = spacemit_crtc_reset,
> +	.atomic_duplicate_state = spacemit_crtc_duplicate_state,
> +	.atomic_destroy_state = spacemit_crtc_destroy_state,
> +	.enable_vblank = spacemit_crtc_enable_vblank,
> +	.disable_vblank = spacemit_crtc_disable_vblank,
> +};
> +
> +static void spacemit_crtc_put_port(struct drm_device *drm, void *port)
> +{
> +	of_node_put(port);
> +}
> +
> +static int spacemit_crtc_bind_init(struct drm_device *drm, struct drm_crtc *crtc,
> +				   struct drm_plane *primary, struct device_node *port)
> +{
> +	int err;
> +
> +	/*
> +	 * drm_of_find_possible_crtcs() walks crtc->port for the life of the
> +	 * drm_device.
> +	 */
> +	crtc->port = of_node_get(port);
> +	err = drmm_add_action_or_reset(drm, spacemit_crtc_put_port, port);
> +	if (err)
> +		return err;
> +
> +	err = drm_crtc_init_with_planes(drm, crtc, primary, NULL,
> +					&spacemit_crtc_funcs, NULL);
> +	if (err) {
> +		drm_err(drm, "failed to init crtc\n");
> +		return err;
> +	}
> +
> +	drm_mode_crtc_set_gamma_size(crtc, 256);
> +
> +	drm_crtc_helper_add(crtc, &spacemit_crtc_helper_funcs);
> +
> +	return 0;
> +}
> +
> +int spacemit_crtc_run(struct drm_crtc *crtc,
> +		      struct drm_crtc_state *old_state)
> +{
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(crtc);
> +
> +	trace_spacemit_crtc_run(a_crtc->dev_id);
> +
> +	if (a_crtc->core && a_crtc->core->run)
> +		a_crtc->core->run(crtc, old_state);
> +
> +	return 0;
> +}
> +
> +static int spacemit_crtc_init(struct spacemit_crtc *a_crtc)
> +{
> +	trace_spacemit_crtc_init(a_crtc->dev_id);
> +
> +	if (a_crtc->core && a_crtc->core->init)
> +		a_crtc->core->init(a_crtc);
> +
> +	a_crtc->is_1st_f = true;
> +
> +	return 0;
> +}
> +
> +static int spacemit_crtc_uninit(struct spacemit_crtc *a_crtc)
> +{
> +	trace_spacemit_crtc_uninit(a_crtc->dev_id);
> +
> +	if (a_crtc->core && a_crtc->core->uninit)
> +		a_crtc->core->uninit(a_crtc);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t spacemit_dpu_isr(int irq, void *data)
> +{
> +	struct spacemit_drm_private *priv = data;
> +	struct spacemit_crtc *a_crtc = priv->a_crtc;
> +	int idx;
> +
> +	if (!a_crtc)
> +		return IRQ_NONE;
> +
> +	if (!drm_dev_enter(a_crtc->crtc.dev, &idx))
> +		return IRQ_NONE;
> +
> +	/* Reading a clock-gated DPU's status registers stalls the bus. */
> +	if (unlikely(!a_crtc->clocks_on)) {
> +		drm_dev_exit(idx);
> +		return IRQ_NONE;
> +	}
> +
> +	if (a_crtc->core && a_crtc->core->online_isr)
> +		a_crtc->core->online_isr(a_crtc);
> +
> +	drm_dev_exit(idx);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Acquire at probe, not at bind: the aggregate can rebind without this device
> + * detaching, and the exclusive resets would not be handed out a second time.
> + */
> +static int spacemit_dpu_hw_resources_init(struct spacemit_drm_private *priv,
> +					  struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int n_rstc;
> +	int ret;
> +
> +	ret = dpu_parse_clocks(dev, &priv->clk_ctx);
> +	if (ret)
> +		return ret;
> +
> +	priv->pipe_resets[0].id = "lcd";
> +	priv->pipe_resets[1].id = "esc";
> +	priv->pipe_resets[2].id = "mclk";
> +	priv->pipe_resets[3].id = "aclk";
> +	priv->pipe_resets[4].id = "dsc";
> +	n_rstc = ARRAY_SIZE(priv->pipe_resets);
> +	ret = devm_reset_control_bulk_get_optional_exclusive(dev, n_rstc,
> +							     priv->pipe_resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get resets\n");
> +
> +	priv->irq_online = platform_get_irq_byname(pdev, "online");
> +	if (priv->irq_online < 0)
> +		return priv->irq_online;
> +
> +	/*
> +	 * Keep the line disabled until bind: the handler needs bind-created
> +	 * state, and a bootloader-left display can raise an interrupt during
> +	 * probe.
> +	 */
> +	ret = devm_request_irq(dev, priv->irq_online, spacemit_dpu_isr,
> +			       IRQF_NO_AUTOEN, "DPU_ONLINE", priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to request online IRQ\n");
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config spacemit_dpu_regmap_config = {
> +	.name		= "dpu",
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.max_register	= 0x53ffc,	/* 0x54000-byte DPU MMIO from binding */
> +};
> +
> +/* Bind-scope wrapper so devm_drm_dev_alloc has a struct to embed into. */
> +struct spacemit_kms {
> +	struct drm_device drm;
> +};
> +
> +static int spacemit_drm_master_bind(struct device *dev)
> +{
> +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
> +	struct device_node *np = dev->of_node;
> +	struct device_node *ports = NULL, *port = NULL;
> +	struct spacemit_crtc *a_crtc;
> +	struct drm_plane *plane;
> +	struct spacemit_kms *kms;
> +	struct drm_device *drm;
> +	int ret;
> +
> +	ret = aperture_remove_all_conflicting_devices(spacemit_drm_drv.name);
> +	if (ret) {
> +		dev_err(dev, "failed to remove existing framebuffers: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	kms = devm_drm_dev_alloc(dev, &spacemit_drm_drv,
> +				 struct spacemit_kms, drm);
> +	if (IS_ERR(kms))
> +		return PTR_ERR(kms);
> +	drm = &kms->drm;
> +	priv->ddev = drm;
> +	drm->dev_private = priv;
> +
> +	ret = spacemit_drm_mode_config_init(drm);
> +	if (ret)
> +		return ret;
> +
> +	a_crtc = drmm_kzalloc(drm, sizeof(*a_crtc), GFP_KERNEL);
> +	if (!a_crtc) {
> +		ret = -ENOMEM;
> +		goto err_dc;
> +	}
> +	a_crtc->dev = dev;
> +	a_crtc->first_modeset = true;
> +	priv->a_crtc = a_crtc;
> +
> +	a_crtc->clk_ctx = priv->clk_ctx;
> +	a_crtc->aclk = DPU_AXICLK_DEFAULT;
> +	a_crtc->irq_online = priv->irq_online;
> +
> +	/* Both K3 DPU instances are COMPOSER1 in the Saturn IRQ tables. */
> +	a_crtc->dev_id = COMPOSER1;
> +
> +	/* The K3 pipeline always hands RGB888 to the DP/eDP encoder. */
> +	a_crtc->out_format = OUTFMT_RGB888;
> +
> +	a_crtc->core = &dpu_saturn_ops;
> +
> +	timer_setup(&a_crtc->cfg_rdy_timer, spacemit_cfg_rdy_timer_handler, 0);
> +
> +	plane = spacemit_plane_init(drm, a_crtc);
> +	if (IS_ERR(plane)) {
> +		ret = PTR_ERR(plane);
> +		goto err_dc;
> +	}
> +
> +	ports = of_get_child_by_name(np, "ports");
> +	if (!ports) {
> +		dev_err(dev, "CRTC %pOF has no ports node\n", np);
> +		ret = -EINVAL;
> +		goto err_dc;
> +	}
> +
> +	port = of_get_child_by_name(ports, "port");
> +	if (!port) {
> +		dev_err(dev, "CRTC %pOF has no port@X node\n", np);
> +		ret = -EINVAL;
> +		goto err_ports_put;
> +	}
> +
> +	ret = spacemit_crtc_bind_init(drm, &a_crtc->crtc, plane, port);
> +	of_node_put(port);
> +	of_node_put(ports);
> +	port = NULL;
> +	ports = NULL;
> +	if (ret)
> +		goto err_dc;
> +
> +	/*
> +	 * component_bind_all() unbinds what it bound before returning an error.
> +	 */
> +	ret = component_bind_all(dev, drm);
> +	if (ret) {
> +		dev_err(dev, "failed to bind all components\n");
> +		goto err_dc;
> +	}
> +
> +	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize vblank\n");
> +		goto err_unbind_all;
> +	}

Better do this after running drm_mode_config_reset().

> +
> +	drm_mode_config_reset(drm);
> +	drmm_kms_helper_poll_init(drm);
> +	drm_helper_hpd_irq_event(drm);
> +
> +	enable_irq(priv->irq_online);
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret < 0)
> +		goto err_disable_irq;
> +	drm_client_setup(drm, NULL);
> +
> +	return 0;
> +
> +err_disable_irq:
> +	disable_irq(priv->irq_online);
> +
> +err_unbind_all:
> +	component_unbind_all(dev, drm);
> +	goto err_dc;
> +err_ports_put:
> +	of_node_put(port);
> +	of_node_put(ports);
> +err_dc:
> +	/*
> +	 * .shutdown tests priv->ddev; never leave it on a half-initialised
> +	 * device.
> +	 */
> +	priv->ddev = NULL;
> +	priv->a_crtc = NULL;
> +	return ret;
> +}
> +
> +static void spacemit_drm_master_unbind(struct device *dev)
> +{
> +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
> +	struct drm_device *drm = priv->ddev;
> +
> +	/*
> +	 * The fbdev-restore commit inside drm_dev_unregister() and the
> +	 * shutdown commit both arm the CFG_RDY handshake, which is confirmed
> +	 * from the DPU interrupt; the line must stay alive until the last
> +	 * commit has drained or every teardown commit rides the watchdog
> +	 * timeout instead.
> +	 */
> +	drm_dev_unregister(drm);
> +	drm_atomic_helper_shutdown(drm);
> +
> +	disable_irq(priv->irq_online);
> +
> +	component_unbind_all(dev, drm);
> +
> +	/* .shutdown and a later re-bind must not touch the stale instance. */
> +	priv->ddev = NULL;
> +	priv->a_crtc = NULL;
> +}
> +
> +const struct component_master_ops spacemit_drm_master_ops = {
> +	.bind = spacemit_drm_master_bind,
> +	.unbind = spacemit_drm_master_unbind,
> +};
> +
> +static int spacemit_dpu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct spacemit_hw_device *hwdev_template;
> +	struct spacemit_drm_private *priv;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	if (!np) {
> +		dev_err(dev, "no OF node for the DPU\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = dev;
> +	dev_set_drvdata(dev, priv);
> +
> +	/* The match data is shared const; the MMIO mapping is per-instance. */
> +	hwdev_template = device_get_match_data(dev);
> +	if (!hwdev_template)
> +		return -ENODEV;
> +	priv->hwdev = devm_kmemdup(dev, hwdev_template,
> +				   sizeof(*hwdev_template), GFP_KERNEL);
> +	if (!priv->hwdev)
> +		return -ENOMEM;
> +
> +	priv->cmdlist_groups = devm_kcalloc(dev,
> +		priv->hwdev->rdma_nums + priv->hwdev->crtc_nums,
> +		sizeof(*priv->cmdlist_groups), GFP_KERNEL);
> +	if (!priv->cmdlist_groups)
> +		return -ENOMEM;
> +
> +	priv->hwdev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->hwdev->base))
> +		return PTR_ERR(priv->hwdev->base);
> +
> +	priv->hwdev->regmap = devm_regmap_init_mmio(dev, priv->hwdev->base,
> +		&spacemit_dpu_regmap_config);
> +	if (IS_ERR(priv->hwdev->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->hwdev->regmap),
> +				     "failed to init DPU regmap\n");
> +
> +	ret = spacemit_dpu_hw_resources_init(priv, pdev);
> +	if (ret)
> +		return ret;
> +
> +	return spacemit_drm_of_component_probe(dev);
> +}
> +
> +static void spacemit_dpu_remove(struct platform_device *pdev)
> +{
> +	component_master_del(&pdev->dev, &spacemit_drm_master_ops);
> +}
> +
> +static void spacemit_dpu_shutdown(struct platform_device *pdev)
> +{
> +	struct spacemit_drm_private *priv = dev_get_drvdata(&pdev->dev);
> +	struct drm_device *drm = priv->ddev;
> +
> +	if (!drm) {
> +		dev_warn(&pdev->dev,
> +			 "drm device is not available, no shutdown\n");
> +		return;
> +	}
> +
> +	drm_atomic_helper_shutdown(drm);
> +}
> +
> +static int dpu_pm_suspend(struct device *dev)
> +{
> +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
> +	struct spacemit_crtc *a_crtc = priv->a_crtc;
> +	int ret;
> +
> +	/*
> +	 * Assert before gating: a reset asserted into an already-gated block
> +	 * has no clock edges to propagate on and leaves the register file
> +	 * untouched.
> +	 */
> +	ret = reset_control_bulk_assert(ARRAY_SIZE(priv->pipe_resets),
> +					priv->pipe_resets);
> +	if (ret)
> +		dev_warn(dev, "failed to assert resets: %d\n", ret);
> +	usleep_range(10000, 20000);
> +
> +	if (a_crtc->core && a_crtc->core->disable_clk)
> +		a_crtc->core->disable_clk(a_crtc);
> +
> +	return 0;
> +}
> +
> +static int dpu_pm_resume(struct device *dev)
> +{
> +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
> +	struct spacemit_crtc *a_crtc = priv->a_crtc;
> +	int ret;
> +
> +	ret = reset_control_bulk_deassert(ARRAY_SIZE(priv->pipe_resets),
> +					  priv->pipe_resets);
> +	if (ret)
> +		dev_warn(dev, "failed to deassert resets: %d\n", ret);
> +
> +	if (a_crtc->core && a_crtc->core->enable_clk)
> +		a_crtc->core->enable_clk(a_crtc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dpu_match_table[] = {
> +	{
> +		.compatible = "spacemit,k3-saturn-dpu",
> +		.data = &k3_saturn_dpu,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dpu_match_table);
> +
> +static struct platform_driver spacemit_dpu_driver = {
> +	.probe = spacemit_dpu_probe,
> +	.remove = spacemit_dpu_remove,
> +	.shutdown = spacemit_dpu_shutdown,
> +	.driver = {
> +		.name = "spacemit-dpu-drv",
> +		.of_match_table = dpu_match_table,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +module_platform_driver(spacemit_dpu_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT DRM KMS master driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/spacemit/spacemit_planes.c b/drivers/gpu/drm/spacemit/spacemit_planes.c
> new file mode 100644
> index 0000000000000..222b8ff8a1fdd
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_planes.c
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + */
> +
> +#include <drm/drm_print.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_blend.h>
> +#include <drm/drm_atomic_uapi.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_color_mgmt.h>
> +#include <drm/drm_gem.h>
> +#include <linux/component.h>
> +#include <linux/dma-mapping.h>
> +#include "spacemit_cmdlist.h"
> +#include "spacemit_dmmu.h"
> +#include "spacemit_drm.h"
> +#include "dpu/dpu_saturn.h"
> +#include "dpu/dpu_trace.h"
> +#include "dpu/saturn_fbcmem.h"
> +
> +/* The AFBC decoder exists but no modifier has been validated on hardware. */
> +static const u64 supported_format_modifiers[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
> +struct spacemit_plane *to_spacemit_plane(struct drm_plane *plane)
> +{
> +	return container_of(plane, struct spacemit_plane, plane);
> +}
> +
> +static void spacemit_plane_atomic_destroy_state(struct drm_plane *plane,
> +						struct drm_plane_state *state);
> +
> +static int spacemit_plane_atomic_check(struct drm_plane *plane,
> +				       struct drm_atomic_commit *atomic_state)
> +{
> +	struct drm_plane_state *state =
> +			drm_atomic_get_new_plane_state(atomic_state, plane);
> +	struct drm_framebuffer *fb = state->fb;
> +	u32 src_w, src_h, src_x, src_y;
> +	u32 crtc_w, crtc_h;
> +	struct spacemit_plane_state *cur_state = to_spacemit_plane_state(state);
> +	u32 cur_rdma_id = cur_state->rdma_id;
> +	struct spacemit_drm_private *priv = plane->dev->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	struct spacemit_crtc *a_crtc = NULL;
> +
> +	struct drm_crtc_state *crtc_state = NULL;
> +	int ret;
> +
> +	if (state->crtc)
> +		crtc_state = drm_atomic_get_new_crtc_state(atomic_state,
> +							   state->crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(state, crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  true, false);
> +	if (ret)
> +		return ret;
> +
> +	if (!state->visible)
> +		return 0;
> +
> +	a_crtc = to_spacemit_crtc(state->crtc);
> +	trace_spacemit_plane_atomic_check(a_crtc->dev_id);
> +
> +	src_x = state->src_x >> 16;
> +	src_y = state->src_y >> 16;
> +	src_w = state->src_w >> 16;
> +	src_h = state->src_h >> 16;
> +	crtc_w = state->crtc_w;
> +	crtc_h = state->crtc_h;
> +
> +	/* The programming paths use the raw rectangles, so refuse to clip. */
> +	if ((state->src.x1 >> 16) != src_x || (state->src.y1 >> 16) != src_y ||
> +	    (drm_rect_width(&state->src) >> 16) != src_w ||
> +	    (drm_rect_height(&state->src) >> 16) != src_h ||
> +	    state->dst.x1 != state->crtc_x || state->dst.y1 != state->crtc_y ||
> +	    drm_rect_width(&state->dst) != crtc_w ||
> +	    drm_rect_height(&state->dst) != crtc_h) {
> +		drm_dbg_kms(plane->dev,
> +			    "clipped plane rectangles not supported\n");
> +		return -EINVAL;
> +	}

What's the matter with this code?

Allocated buffers can be larger than the display mode. If the hardware 
cannot handle this, it might become a problem in some setups.


> +
> +	/* One-dimensional sources are invalid (only 0x0 = constant fill) */
> +	if ((src_w == 0) != (src_h == 0)) {
> +		drm_dbg_kms(plane->dev, "unsupported src_w %d src_h %d\n",
> +			    src_w, src_h);
> +		return -EINVAL;
> +	}

I'm not aware of any driver testing this. The above calculation of 
state->visible should have detected this case.

> +
> +	if (src_w == 0 && src_h == 0)
> +		cur_rdma_id = RDMA_INVALID_ID;	/* constant-fill layer, no RDMA */
> +	else if (cur_rdma_id == RDMA_INVALID_ID)
> +		cur_rdma_id = state->zpos;	/* first commit: bind channel by zpos */
> +	cur_state->rdma_id = cur_rdma_id;
> +
> +	if (cur_rdma_id != RDMA_INVALID_ID) {
> +		if (cur_rdma_id >= hwdev->rdma_nums) {
> +			drm_dbg_kms(plane->dev, "invalid rdma id %d\n",
> +				    cur_rdma_id);
> +			return -EINVAL;
> +		}
> +
> +		if (a_crtc->core->cal_layer_fbcmem_size(plane, state)) {
> +			drm_dbg_kms(plane->dev,
> +				    "plane %d: invalid fbcmem size\n",
> +				    state->zpos);
> +			return -EINVAL;
> +		}
> +
> +		cur_state->mmu_tbl.size =
> +			((PAGE_ALIGN(fb->obj[0]->size) >> PAGE_SHIFT) +
> +			 HW_ALIGN_TTB_NUM) * 4;
> +		cur_state->mmu_tbl.va =
> +			dma_alloc_coherent(a_crtc->dev, cur_state->mmu_tbl.size,
> +					   &cur_state->mmu_tbl.pa,
> +					   GFP_KERNEL | __GFP_ZERO);
> +		if (!cur_state->mmu_tbl.va)
> +			return -ENOMEM;

Resource allocation/deallocation like this should better be done in 
begin_fb_access/end_fb_access when you need them for the commit. 
User-space compositors might send in a large number of states only for 
atomic_check'ing. There's no point in allocating actual memory then.


Best regards
Thomas

> +	}
> +
> +	/*
> +	 * The commit cannot fail, so take the DMA buffer while -ENOMEM is an
> +	 * answer.
> +	 */
> +	ret = spacemit_cmdlist_alloc(a_crtc->dev, &cur_state->cl);
> +	if (ret)
> +		return ret;
> +
> +	cur_state->format = spacemit_plane_hw_get_format_id(fb->format->format);
> +	if (cur_state->format == SPACEMIT_DPU_INVALID_FORMAT_ID) {
> +		drm_dbg_kms(plane->dev, "unsupported format %p4cc\n",
> +			    &fb->format->format);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void spacemit_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_commit *state)
> +{
> +	int ret = 0;
> +	struct spacemit_crtc *a_crtc = to_spacemit_crtc(plane->state->crtc);
> +	struct spacemit_plane_state *spacemit_pstate =
> +			to_spacemit_plane_state(plane->state);
> +	struct spacemit_drm_private *priv = plane->dev->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	u32 rdma_id = spacemit_pstate->rdma_id;
> +	struct cmdlist *cl = NULL;
> +	int idx;
> +
> +	if (!drm_dev_enter(plane->dev, &idx))
> +		return;
> +
> +	trace_spacemit_plane_atomic_update(a_crtc->dev_id);
> +
> +	hwdev->get_cl_rdma_buf(a_crtc);
> +
> +	hwdev->plane_update_hw_channel(plane);
> +
> +	/* Solid-fill layers have no RDMA and no page table */
> +	if (rdma_id < hwdev->rdma_nums && spacemit_pstate->mmu_tbl.va) {
> +		u8 tbu_id = rdma_id * 2;
> +
> +		ret = spacemit_dmmu_map(plane->state->fb,
> +					&spacemit_pstate->mmu_tbl, tbu_id,
> +					a_crtc->cl_rdma, plane);
> +		if (!ret)
> +			cmdlist_regs_packing(plane_to_cl(plane),
> +					     CMDLIST_MOD_RDMA, a_crtc->cl_rdma);
> +		else
> +			drm_err(plane->dev, "failed to map plane: %d\n", ret);
> +	}
> +
> +	cl = &spacemit_pstate->cl;
> +	cl->rch_start_cmps_y = CMDLIST_SENTINEL_POISON;
> +	cl->cmdlist_ch_y_other = CMDLIST_SENTINEL_POISON;
> +	free_cmdlist_regs(a_crtc->cl_rdma);
> +
> +	drm_dev_exit(idx);
> +}
> +
> +static void spacemit_plane_atomic_disable(struct drm_plane *plane,
> +					  struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_state =
> +			drm_atomic_get_old_plane_state(state, plane);
> +	struct spacemit_drm_private *priv = plane->dev->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	int idx;
> +
> +	if (!drm_dev_enter(plane->dev, &idx))
> +		return;
> +
> +	hwdev->plane_disable_hw_channel(plane, old_state);
> +
> +	drm_dev_exit(idx);
> +}
> +
> +static void spacemit_plane_reset(struct drm_plane *plane)
> +{
> +	struct spacemit_plane_state *s;
> +
> +	if (plane->state) {
> +		spacemit_plane_atomic_destroy_state(plane, plane->state);
> +		plane->state = NULL;
> +	}
> +
> +	s = kzalloc(sizeof(*s), GFP_KERNEL);
> +	if (s) {
> +		__drm_atomic_helper_plane_reset(plane, &s->state);
> +		s->rdma_id = RDMA_INVALID_ID;
> +	}
> +}
> +
> +static struct drm_plane_state *
> +spacemit_plane_atomic_duplicate_state(struct drm_plane *plane)
> +{
> +	struct spacemit_plane_state *s;
> +	struct spacemit_plane_state *old_state =
> +			to_spacemit_plane_state(plane->state);
> +	struct spacemit_crtc *a_crtc = NULL;
> +
> +	if (plane->crtc) {
> +		a_crtc = to_spacemit_crtc(plane->crtc);
> +		trace_spacemit_plane_atomic_duplicate_state(a_crtc->dev_id);
> +	}
> +
> +	s = kzalloc(sizeof(*s), GFP_KERNEL);
> +	if (!s)
> +		return NULL;
> +
> +	__drm_atomic_helper_plane_duplicate_state(plane, &s->state);
> +
> +	WARN_ON(s->state.plane != plane);
> +
> +	s->cl.type = CMDLIST_PLANE;
> +
> +	s->rdma_id = old_state->rdma_id;
> +	s->format = old_state->format;
> +	s->fbcmem_size = 0;
> +
> +	return &s->state;
> +}
> +
> +static void spacemit_plane_atomic_destroy_state(struct drm_plane *plane,
> +						struct drm_plane_state *state)
> +{
> +	struct spacemit_plane_state *spacemit_pstate =
> +			to_spacemit_plane_state(state);
> +	struct spacemit_crtc *a_crtc = NULL;
> +
> +	if (state->crtc) {
> +		a_crtc = to_spacemit_crtc(state->crtc);
> +
> +		if (spacemit_pstate->mmu_tbl.va)
> +			dma_free_coherent(a_crtc->dev,
> +					  spacemit_pstate->mmu_tbl.size,
> +					  spacemit_pstate->mmu_tbl.va,
> +					  spacemit_pstate->mmu_tbl.pa);
> +
> +		if (spacemit_pstate->cl.va)
> +			dma_free_coherent(a_crtc->dev,
> +					  spacemit_pstate->cl.size,
> +					  spacemit_pstate->cl.va,
> +					  spacemit_pstate->cl.pa);
> +		trace_spacemit_plane_atomic_destroy_state(a_crtc->dev_id);
> +	}
> +	__drm_atomic_helper_plane_destroy_state(state);
> +
> +	kfree(to_spacemit_plane_state(state));
> +}
> +
> +static void spacemit_plane_create_properties(struct spacemit_plane *p)
> +{
> +	unsigned int support_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +		BIT(DRM_MODE_BLEND_PREMULTI) |
> +		BIT(DRM_MODE_BLEND_COVERAGE);
> +
> +	drm_plane_create_alpha_property(&p->plane);
> +
> +	drm_plane_create_blend_mode_property(&p->plane, support_modes);
> +}
> +
> +static const struct drm_plane_helper_funcs spacemit_plane_helper_funcs = {
> +	.atomic_check = spacemit_plane_atomic_check,
> +	.atomic_update = spacemit_plane_atomic_update,
> +	.atomic_disable = spacemit_plane_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs spacemit_plane_funcs = {
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane	= drm_atomic_helper_disable_plane,
> +	.destroy = drm_plane_cleanup,
> +	.reset = spacemit_plane_reset,
> +	.atomic_duplicate_state = spacemit_plane_atomic_duplicate_state,
> +	.atomic_destroy_state = spacemit_plane_atomic_destroy_state,
> +};
> +
> +struct drm_plane *spacemit_plane_init(struct drm_device *drm,
> +				      struct spacemit_crtc *a_crtc)
> +{
> +	struct spacemit_plane *p = NULL;
> +	int err, j;
> +	u32 *formats;
> +	struct spacemit_drm_private *priv = drm->dev_private;
> +	struct spacemit_hw_device *hwdev = priv->hwdev;
> +	u8 n_formats = hwdev->n_formats;
> +	u8 n_fbcmems = hwdev->n_fbcmems;
> +	u8 n_rdmas = hwdev->rdma_nums;
> +	u32 plane_crtc_mask;
> +
> +	trace_spacemit_plane_init(a_crtc->dev_id);
> +	if (n_fbcmems * 2 != n_rdmas) {
> +		drm_err(drm, "mismatched rdma/fbcmem counts: %d vs %d\n",
> +			n_rdmas, n_fbcmems);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	for (j = 0; j < n_fbcmems; j++) {
> +		if (hwdev->fbcmem_sizes[j] < FBCMEM_UNIT) {
> +			drm_err(drm, "invalid fbcmem_sizes[%d] = %u\n",
> +				j, hwdev->fbcmem_sizes[j]);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
> +	formats = kcalloc(n_formats, sizeof(*formats), GFP_KERNEL);
> +	if (!formats)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * The CRTC is created right after this, so its index is the current
> +	 * count.
> +	 */
> +	plane_crtc_mask = 1 << drm->mode_config.num_crtc;
> +
> +	/* drmm, not devm: an open DRM fd outlives the platform unbind. */
> +	p = drmm_kzalloc(drm, sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		kfree(formats);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	for (j = 0; j < n_formats; j++)
> +		formats[j] = hwdev->formats[j].format;
> +
> +	err = drm_universal_plane_init(drm, &p->plane, plane_crtc_mask,
> +				       &spacemit_plane_funcs, formats,
> +				       n_formats, supported_format_modifiers,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	kfree(formats);
> +	if (err) {
> +		drm_err(drm, "failed to init primary plane\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	drm_plane_helper_add(&p->plane, &spacemit_plane_helper_funcs);
> +
> +	spacemit_plane_create_properties(p);
> +
> +	p->hwdev = hwdev;
> +
> +	return &p->plane;
> +}
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


