Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D0910987B0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1242E10EBBB;
	Fri, 20 Mar 2026 16:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="AQ6I2IVB";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509C010EBBA;
 Fri, 20 Mar 2026 16:42:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6CE72C5668D;
 Fri, 20 Mar 2026 16:43:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E6B3A600E0;
 Fri, 20 Mar 2026 16:42:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D074510450CB5; Fri, 20 Mar 2026 17:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZjS1ZoIAPd/0H3Pat14vVnrI2BR4vgAhRmSVs8W3mqg=;
 b=AQ6I2IVBJUpyQX1VND38ENyZSBGcL1lwChYM6WUF25CWUSOXmQp2dSMTxjcKHadNvW875E
 tISUI0PMC5x4aQ3SQyMDoYfrnhHFse08lhH0D3COXFpBGCLNaJWbyOVVlSydN1FbZMqM/a
 RE9r1mV+qxbBRnjrhhvkssEwSZMI/nudZurR8lYPc1KGObJ83uSQHYuKyrUDWka208V9C6
 vSngTPbUEYm7mA24ccTqNj1jI+We8IzYPB5SOGR4pK9rjZBduN3IHZ8AgJWdMMeBJfRa1g
 ZfBxyjeKiACRUU0PIEtESKqMGT5mKGVfain90nnc5Ws5CMyoKq7Mf/gEjVrcJw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 34/65] drm: use correct ccflags-y spelling
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-35-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-35-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491456.6181.16882943993128640125.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=431;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=i7PwkzzW++IIbSNJiNrtCGR6lD/fF5m1m7HvQDTW8LA=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjZ1slr8Af7sYO4wbdsZMjI7UC30nsChYF5t
 vVNs/YrKhWJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOK+EBAAzKxLKW3wJDGm9A5J3BARLxqP1eIn9xi
 oz48tgFImFvuyrwO4Si+/k7ucbvB6DL9RenG7jbjQN+QsDVWnwGwjhTS/dZivu69klh462PoNBn
 NoaWppLAaPZ22ltIsdIq/0EThm2gLzNnsIWTcUPGZ/izRetid7bbvN8quzAUGP8YVfRJoMCAdTV
 2z08i3L9gCcSgnQGtozNbcVjCeQ3oPb9cWH0CfbxfObufCKS/h8yNSOv0l6WsKr/9F0TXbS3yeu
 zbrrpwb94fihx97F8+xCqaoSoSrlce4YjcCsTSu/ShCiY3bHSEOtLRnTYpaum6r5/4rTpCxM3hD
 PXCqpAiUJNiljdPx3Ca3egF+HRu5pjdJJUMMi3b71lJen+i6yFkjnk0sk4yFlOHwCzPxprukv7R
 hro4UaHjx73LGQPkahM6V132GNrnh9BxfYbajAJro7D0pWR0ETlKtcGBvSF6U/1wJzSQphcuVJO
 2O0Psx6oq8dZwRTuQK2utijA7rjRleV4+ZqXW/C+yaQ7/VHV4DYuJdhqpJpnMFRPGXzAFkF9j5r
 xOcZnWymYr4BnaIhbZlk1XFKkY2Je5ByGZbwvHNkFpmmOVX/l2xJRzX3JaKvW9h6ROWQNIlPKbr
 dKZvWOUEKxn7wsxatrB4b0+syQtctp+ylKaz+DvFJ2gLtvXEEaoE=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:19:59 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
> which disabled dynamic-debug in modules built with:
> 
> CONFIG_DYNAMIC_DEBUG=n		# 1
> CONFIG_DYNAMIC_DEBUG_CORE=y	# 2
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y	# 3
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
