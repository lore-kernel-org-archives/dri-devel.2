Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE1606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=omdeFpoT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A805112902;
	Fri, 27 Nov 2026 10:41:31 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86606112902
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:41:24 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso80042475e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795776083; x=1796380883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OE3iaTdUoerIU9O/A0rtQ8dKzE06q6SN9k4omG/eVuE=;
 b=omdeFpoTsuSUaJravdcWzlo1XjMaeyZudIpeENB0V/GxaHHuy9HjhxtrVIJABa6Nly
 DECw8P+xg7/UxfebF85KAuWxbanZMQoKqo9GjE8ocUUIolb/ndHnGM3jdP9dHIR7kx82
 68C27JHGkK1Yge+RZZ0PbXGqSCUUnqgIxB1UF5IRT+PWFrggDCeJwumVhcXgYkG9XwTb
 NGOjsX20B4NdoBPjPGfC72k7o/OCbNFdmMwoPK3I9RxfXbEfp1D8uQH4k6reH7v17ej1
 c6Fsmk+QcwJF+8x6zEKZcLzir+3/+wvw9VsnLBVtVcaMPLqsulMzQyB3Gl56YJklP4+2
 QIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795776083; x=1796380883;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OE3iaTdUoerIU9O/A0rtQ8dKzE06q6SN9k4omG/eVuE=;
 b=D5KzSmrtRVTl/4SLzBlzRY8oM7TljKv7cFUh8rWnif1ffw+6XtlUc2eEUGf5SLtaZ2
 ReiZosFkt6c7ExHp6pBQCT0xMvESY+pMYDVy9ztJvWYVdzI2TxpRfdPy2tAvgHCAIc2y
 mZ0hDi2DFvD5Q2Hj9XOaNP54LhwBFXnNyYqLJ+2XwmWCGHet89mjSpDUSaxSUi/dl04f
 8put0YHx+e0MrI2LZT7T6Xj0M4T38ViuXIiJzxavJ0LSHETnAG46pW+OonS0k/eDV1iV
 gO1iL8WvhUj0gpuhWCc+sPUEOdzeTXxZA6O2UxtsyMZmefhF5KzKYsUPtpPOsHp9XC9P
 n1Qw==
X-Forwarded-Encrypted: i=1;
 AL+hErE+UES/a5x9P/7VqTwnyPvFvxLlgl+qWNazWlCnjITivOyRjgV+ISUC+2w57AdQNEcrCVesl1OWyd8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8xI0c6wt9lD/2/COZzo2RpokXTQaxQIpGHI3nSl6YC1ofvS242
 /yC2xgs8g41aPoankYCQOl3qXSYhkWzTCJck4GGfJVKwHjYO55aZM4gH
X-Gm-Gg: AZFdTZc3HsoRFAr81iheXzyB5E1JG3M6O9kfoPxm191ZzM+fizSAqEnLMAebGXRYetG
 kYHGiz0iPs9cJWEOIX53F1ybR9O/6sMBrIvazxJvy6CZDXWcu6gs9twtTWdgH7hfF1u5S5iXXY6
 S8OKTGyrEmzeO0H/2sNuSxIf3faiZKe5vqvjC8TYJq/XEUuiLTOUX4vLvCK2wIyBgwMtsvJxSvL
 DfsvqmfNX+C5jdV+4R4DL6lQ+lH1YxaSyJKimo3Bnvh/v1cq7D5KQE3JuCBQuDsIPOwhuE4D02G
 j6b9X8HZHOJU/fu6Rms3vyiLUqJlStuDVUTseN1NjgrayKrV3Ai1GBrEUDD2mLdeJ9DA7APz4Yi
 mPfcqGS4GO0oZIABiwy+cCmhcw3s/EhrUYUy1ds1QN7YGHVUpCdioTuehk3AV2irubVnEka4KgX
 +89s3PIgrWuV/0Rpk92SaFSYipZHcvtpOmp/nLOjn+ko3rP7iGLIQIk8e+PHKsp6fQj/UUFNUWM
 8cCw6B6aKOwMP99iGyJ99SWvlCItua5FdXuf2/85MP1lKP5cV2QikzD+fDGXKGnvk3x2DltT8KR
 pelks2cgNHPmDi3kZxsUnKlP8TPeM+0=
X-Received: by 2002:a05:600c:848d:b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4bb88811da9mr501158075e9.13.1795776082653; 
 Fri, 27 Nov 2026 02:41:22 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm797348905e9.11.2026.11.27.02.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:41:22 -0800 (PST)
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
 linux-doc@vger.kernel.org, llvm@lists.linux.dev,
 =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito@redhat.com>
Subject: Re: [PATCH v7 16/43] drm/vkms: Use enabled/disabled instead of 1/0
 for debug
Date: Fri, 27 Nov 2026 11:41:08 +0100
Message-ID: <awleOdfY9e_UnwVF@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-16-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-16-21194cda2468@bootlin.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 12:28:59PM +0100, Louis Chauvet wrote:
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
> index e933d61cb526..e2b656723898 100644
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
> @@ -394,8 +395,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  		vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
>  			seq_puts(m, "crtc:\n");
> -			seq_printf(m, "\twriteback=%d\n",
> -				   vkms_config_crtc_get_writeback(crtc_cfg));
> +			seq_printf(m, "\twriteback=%s\n",
> +				   str_enabled_disabled(vkms_config_crtc_get_writeback(crtc_cfg)));
>  		}
>  
>  		vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
