Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45CFF588D4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240E410E223;
	Mon, 20 Apr 2026 13:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uYlF6hQr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kdB3irtN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uYlF6hQr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kdB3irtN";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3273A10E223
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:57:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 460655BCCB;
 Mon, 20 Apr 2026 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776693418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yf3K3GGLm2EaKkq15h+qBc5GzZ9LA4nrtTLwc5BYIio=;
 b=uYlF6hQr45mghRkG0tsTvhzD9NGRxsoIGV3B3ZdNMgdhRq47gpdMpBu0Q3tm4al3DUKEIi
 j8d03qfwt8MaB+0Ubjc6BXdfI6iWZZThvellsS7tGP8avwZWJmc6i+qGy59vDW5pKaaW3G
 tgRCSWPCuofjk1Wkjjt3ZTrFcadwdes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776693418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yf3K3GGLm2EaKkq15h+qBc5GzZ9LA4nrtTLwc5BYIio=;
 b=kdB3irtNWREAhJhYooazk8pb2TogX8WZB+lCvQm8T01e4hAM4+zhE55sdkP/jd8wxvF+ZB
 pzfoD8IRTiHBtZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776693418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yf3K3GGLm2EaKkq15h+qBc5GzZ9LA4nrtTLwc5BYIio=;
 b=uYlF6hQr45mghRkG0tsTvhzD9NGRxsoIGV3B3ZdNMgdhRq47gpdMpBu0Q3tm4al3DUKEIi
 j8d03qfwt8MaB+0Ubjc6BXdfI6iWZZThvellsS7tGP8avwZWJmc6i+qGy59vDW5pKaaW3G
 tgRCSWPCuofjk1Wkjjt3ZTrFcadwdes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776693418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yf3K3GGLm2EaKkq15h+qBc5GzZ9LA4nrtTLwc5BYIio=;
 b=kdB3irtNWREAhJhYooazk8pb2TogX8WZB+lCvQm8T01e4hAM4+zhE55sdkP/jd8wxvF+ZB
 pzfoD8IRTiHBtZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D772B593AE;
 Mon, 20 Apr 2026 13:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x5YtM6kw5mkJSwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 13:56:57 +0000
Message-ID: <d649270c-7f31-4c5d-99b5-c5df189deff4@suse.de>
Date: Mon, 20 Apr 2026 15:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 for drm-misc-fixes] MAINTAINERS: split hisilicon
 maintenance and add Yongbang Shi for hibmc-drm matainers
To: Yongbang Shi <shiyongbang@huawei.com>, tiantao6@hisilicon.com,
 xinliang.liu@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 kong.kongxinwei@hisilicon.com, dmitry.baryshkov@oss.qualcomm.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260319131132.722033-1-shiyongbang@huawei.com>
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
In-Reply-To: <20260319131132.722033-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[17];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,oss.qualcomm.com];
 URIBL_BLOCKED(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:url,gitlab.freedesktop.org:url];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email, suse.de:mid, suse.de:email,
 suse.com:url, linaro.org:email, imap1.dmz-prg2.suse.org:helo]
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



Am 19.03.26 um 14:11 schrieb Yongbang Shi:
> To improve maintainability, split the maintainer information for the hibmc and
> kirin drivers under the drivers/gpu/drm/hisilicon directory.
>
> drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature development
> based on the new generation HiSilicon BMC chip. It was co-developed by
> Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
> maintained by Yongbang Shi.

Merged into drm-misc-fixes

>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> Acked-by: Tao Tian <tiantao6@hisilicon.com>
> Acked-by: Xinliang Liu <xinliang.liu@linaro.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>
> ChangeLog:
> V1 -> V2:
>    - remove Xinliang Liu, Sumit Semwal, Yongqin Liu, and John Stultz from DRM DRIVERS
>      FOR HISILICON HIBMC
>    - remove Tian Tao and Xinwei Kong from DRM DRIVERS FOR HISILICON KIRIN
>
> ---
>   MAINTAINERS | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7241695df96..7c0bdd7b8f08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8603,18 +8603,25 @@ S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/gma500/
>   
> -DRM DRIVERS FOR HISILICON
> -M:	Xinliang Liu <xinliang.liu@linaro.org>
> -M:	Tian Tao  <tiantao6@hisilicon.com>
> -R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
> -R:	Sumit Semwal <sumit.semwal@linaro.org>
> -R:	Yongqin Liu <yongqin.liu@linaro.org>
> -R:	John Stultz <jstultz@google.com>
> -L:	dri-devel@lists.freedesktop.org
> -S:	Maintained
> -T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> -F:	Documentation/devicetree/bindings/display/hisilicon/
> -F:	drivers/gpu/drm/hisilicon/
> +DRM DRIVERS FOR HISILICON HIBMC
> +M:      Yongbang Shi <shiyongbang@huawei.com>
> +M:      Tian Tao  <tiantao6@hisilicon.com>
> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
> +L:      dri-devel@lists.freedesktop.org
> +S:      Maintained
> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:      drivers/gpu/drm/hisilicon/hibmc
> +
> +DRM DRIVERS FOR HISILICON KIRIN
> +M:      Xinliang Liu <xinliang.liu@linaro.org>
> +R:      Sumit Semwal <sumit.semwal@linaro.org>
> +R:      Yongqin Liu <yongqin.liu@linaro.org>
> +R:      John Stultz <jstultz@google.com>
> +L:      dri-devel@lists.freedesktop.org
> +S:      Maintained
> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:      Documentation/devicetree/bindings/display/hisilicon/
> +F:      drivers/gpu/drm/hisilicon/kirin
>   
>   DRM DRIVERS FOR LIMA
>   M:	Qiang Yu <yuq825@gmail.com>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


