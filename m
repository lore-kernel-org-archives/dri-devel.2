Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84202606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2492F112101;
	Thu, 12 Nov 2026 12:56:27 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA16710E9FF
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:46:07 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2517626f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404766; x=1795009566;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gU5SfropLbeuhhZVQHKyKXg+TDGqXO/o10GMjJa5hHQ=;
 b=yNIl4kyh5SzAby+5lceMnYs+fwv7wks4Qj2Ckk30eHbDL5gMDG1L1SS4GcTZNA3EUL
 1916h7v+G/8KGtiznuRiyFrRAX2NSl1FSxF0Fv+9lwLIco9CDq/jquaSrIYSlFdkG2NY
 Inr9b+ZUfxs4ubp9BgAXzq+2DP+3hJcoK2pa1AplGI1BzLx9gES8HK+3NkbitoBXlWRm
 gj/j43/+FCFQ+E76XuuyMmvToh7OiWCBe1B8B4/Ilp7H5Hd7Zg6+DkjF7V94ydPZGoFZ
 vth8bCQnvXEZItb7ekx6E0DgvhbwZMJKUW9nNQvLH3Rudlk+gUoiuy6RbqwSs6QXAWiD
 w6sg==
X-Forwarded-Encrypted: i=1;
 AL+hErHG7u/dX+3L4io9CQGiXQYVJOCFjK5nS+ApGT5IhnEDwqPQEYPIsvPKxbd24i0V6NtR36+XcvR2SVo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ZZxoWkESTZJ5QlUul2+IfIZU1GdnHhL1E8AoK09Qj0OqSPN4q
 Y3uafKb/nJJP1OcQskNE4t5a/rYIzNixyxE1vZTjZWnlYgxk6CeO1KDq
X-Gm-Gg: AYBFou2nRMaDzOED50Cubbe7WFjLMvI+cFKOInuHimf8SjvrHzk55JFWhs7Q/Yw1xtm
 l3mwGhC3LyiOvwdorqmu93d3cQghSNcI7m79oWtVhvUGTKnU8ui/2jBmyEbVDPQcTQS/cHR5o4I
 7L5g13FY6WSHikAAiiiWK7M1mmbmHy6AJ5pHmB4XMI2LmhNxxaMcDWiF0KoKEJDeyPHj7FAeD0o
 bgKXZ67M3hY0bKQH966jTSPFu9gWPGLwgbduB0l6KXJxwVRMbdozjc0tzCFfqH+LWq3PpcIhJeN
 HMz01wKZMvFJUK+0/qkMCk4HTIuRbD2jq+eVLQUioddiDbn41AINBTpHfqU72p7wmzNXNgY51n+
 Sihek3cJskTyciee3GeHydElSoXviZFPvdWxjKTo6SCWn4sCaYwteoA+SCnZdt+CQYsKn7LU7+b
 EKrwUjLGSdkqjZVIZIlKcPG+1TDIqZJ8P9+ecUqtfyrLMUO7nLT3nKBMfY3HBqvWOZDd4dgUS0B
 sC+v+/pXY3vTj4w27VcuGSgv+Cx5Tg8kl3jmfpgbAF/+fSlovZq7hd0pGu2mPJ28N6lzozzRlQi
 KYhHpV40klS+SQ/1qE1xiNQEEY3TTUEZjiaL0MrZA9fv6RUYjyy66wAHK0MUC2ffK9HXQDuDWHg
 aA+KsmgUT6AIh2mjcDF1ym+sb7GjAouJV/832M/zcZjvu89rJJpUy+XfcePqm
X-Received: by 2002:a05:6000:3107:b0:48d:f3f8:f910 with SMTP id
 ffacd0b85a97d-499c96002fcmr5471214f8f.34.1794404765741; 
 Wed, 11 Nov 2026 05:46:05 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c30b1sm11189059f8f.46.2026.11.11.05.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:46:05 -0800 (PST)
Date: Wed, 11 Nov 2026 16:45:57 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/vc4: release firmware on error paths in
 vc4_hvs_bind()
Message-ID: <avRxlbgy9mtT1rR6@stanley.mountain>
References: <ee4989e2-f55e-4d09-8a0d-306b78b9c9d0@stanley.mountain>
 <20261111131528.316472-1-tomasz.unger@yahoo.pl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111131528.316472-1-tomasz.unger@yahoo.pl>
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 02:15:28PM +0100, Tomasz Unger wrote:
> So without the patch every failed bind leaks one reference, and with the
> patch the reference is dropped.
> 
> Tested-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> One note about the Fixes tag: 2fa4ef5fb943 only moved this code around.
> As far as I can tell, the rpi_firmware_get() before devm_clk_get()
> without a put on the error path was introduced by commit 2a001ca00ad5
> ("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code"), which went
> into v6.2.

Huh.  Wow.  Thanks.  I'll resend the patch with the correct Fixes tag.

regards,
dan carpenter

