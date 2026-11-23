Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2447606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KAw+P51c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0EA10EDF3;
	Mon, 23 Nov 2026 13:39:54 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482EE10EDED
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:39:48 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6ba12b00c76so3331322a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795441186; x=1796045986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bAL0t2TGrbFIeMgy/8ZLqGke+0HtmGCWss+5lXHsJKU=;
 b=KAw+P51cMPLWeue/XDs0yape9miFYBKsDSoIfwux34Dt7zdnQNEpfGe8nbEnldqGxy
 7rcnwtJ9ir7v4Z87LHuyjJmbXLVc7y88ESEnJXtyymV+z8j3ob6jBulUR2c1KsaVgawt
 oxC7GOZQNqYJMSjdEQDM2IkB/gdVYV37JVSQflgasuMTAwlI6+3qsYrpkY+wTTc44kjg
 0C9Hr006SrJBrFzf1HeSC+ChEaOd8CHmK0IISrtZEIfh2KmooCqRn5ywTEoWQBeJrkqT
 GZIRX+yHzh5mnzLHU6FYDS/ukTuizlBD4JKM/FH2pMBhuWsL0L3U2TZ0VylzcrVXdBTs
 E6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441187; x=1796045987;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bAL0t2TGrbFIeMgy/8ZLqGke+0HtmGCWss+5lXHsJKU=;
 b=SmQjTboNRXcf7WJyHHaXWBx2VIE8ivBj8By5WW7RQBz2hvLf8xo4RXAqf8zVSY1V7n
 ztma62C0W2j6JCYttnSaWb+aKqQaX5Yt9KGQGvY0ByzNku10fVXGoQnqUyjn+xeDGOAD
 4nN+MryTeXAQ3XqRYtcSBHyfo1Xh87iP52vNv+ygN5xhw0sq1Ygbwx9WTLqYe6ylGF3j
 YywPvmePzAY9Wcui00b9iQAaI5QjoNDUvIcKEhop6bh0gGYoxakfFWpsCZIqgYUrUZml
 ZFHUi1534OAKMrhcvmjvIBEGRLQCMb/LAeoWX2euVElXMlDHu9xxgqx+inp/otzVES7b
 AMsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHzutZj96TSJGzi0XhU8onSRpGFPUq5iyXYXMExcZlC9Mhl8jw2z2yutHqHmNFixWYLn4RGKZb591w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+IXIkxdBL+hDRqbWC3K7cxsUHk3JL77jLLLim880kGq+37bNiq
 HtTmfUu9jy6/iir+lix409+kYTBaWrmwMStQzyGCpOx7klmob/Hha12D
X-Gm-Gg: AZFdTZeBmbxhVAJXgao4bNxG6nOj2eu/jm1z3oHOLQEoO347LVjHjF9/ySjKHBROodX
 Ot/LusKTIPDwMkeGL+OJkm6/TBJ3Jq9vttdMGX8p8Tv7duYfEX3SeaReAD4ZSGt/cduFIJcSlwG
 kY/nKcbfjiw0paO2VhXip/aYnJPeL5zYKyXwnRX8Gvi4y6UWRbRN76BHZpSLeL64M6XAsvch/5p
 N2xdU/BkFl4I6P0ExNQdXSKUrTXaHF/6+/pB9r9DYKE/+OewNpr1xdpCAyugysy0ai8OFpAJ0ZN
 TNfachhB0vP3sJLBvjVtfRRYy0V+cWFxjbs1b3C8kXL6mJhSrfB7gSQSH/ZIsLjzaJHSewpxPta
 UMTnQeXCRyg62E4TbdgbMUAVARIlvzSRNWRRhEnHFEKaYq7hrAMG/RrlZEQ3HIdzUY+HYfOxIQc
 l6t9e7FN/HSI6TRdpdRVOSeEhfxPA5SCsSBPCl9KPxCpJANjpownkwlF1B58mHCY0OvpXIugui8
 9zWNGz6A0mNGYiuhnmn7ko5LxPOZ/xrnSUISQNtOgda4lWkQ/B6WaO4gztWV6hiG07WI2f/HhPk
 kp5rRqYNxF7kg5cOjQMqrcBJUEqAcsPECxUh4kF5Zqh6PflbuV65J9s=
X-Received: by 2002:aa7:d351:0:b0:6b4:86e1:cc67 with SMTP id
 4fb4d7f45d1cf-6ba37ea0b91mr5687764a12.27.1795441186526; 
 Mon, 23 Nov 2026 05:39:46 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba36e355easm5212663a12.3.2026.11.23.05.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:39:45 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev,
 =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito@redhat.com>
Subject: Re: [PATCH v6 17/43] drm/vkms: Use enabled/disabled instead of 1/0
 for debug
Date: Mon, 23 Nov 2026 14:39:25 +0100
Message-ID: <awRBxApeQdS0tPZn@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-17-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-17-78ace90f4fc1@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:58:59PM +0100, Louis Chauvet wrote:
> Debug information are mainly read by human, so display human
> readable values.
> 
> Reviewed-by: José Expósito <jose.exposito@redhat.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 44ded8a86a6e..4127fb176a87 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  
>  #include <drm/drm_connector.h>
>  #include <drm/drm_print.h>
> @@ -397,8 +398,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
>  		seq_puts(m, "crtc:\n");
> -		seq_printf(m, "\twriteback=%d\n",
> -			   vkms_config_crtc_get_writeback(crtc_cfg));
> +		seq_printf(m, "\twriteback=%s\n",
> +			   str_enabled_disabled(vkms_config_crtc_get_writeback(crtc_cfg)));
>  	}
>  
>  	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
> 
> -- 
> 2.56.0
>

Reviewed-by Oarora Etimis <oaroraetimis@gmail.com>
