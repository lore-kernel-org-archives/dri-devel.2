Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD82CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0301111385A;
	Tue,  2 Jun 2026 05:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JYAkLoHx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55F211385A
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 05:43:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E90776001A;
 Tue,  2 Jun 2026 05:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D55F1F00893;
 Tue,  2 Jun 2026 05:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780379027;
 bh=HO5T4hY4oc72i5yAiqIBqEAKJnsVhjoYb+g6SW4aadk=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=JYAkLoHxgLsddiRyD6WgoC6u2YtzcpUd5X6eajBqOUdW3sCf9sHmY8x8vjwdWpFok
 imRiFit2XT9p8560qsmT4YTu1OrGyID9DR2t2ZaXJy+nsh80bySUqmgnM/gKCJFNKa
 j/8nrzLtjtMvPX75KIcHkucxkwC912HA0mjs1V+X9bVrLDVNfDmbjMLBQUHoP+YYQM
 wU81CadENp+5ikPruN1NogklTtfq6dO+KpMviEWy3JJ31sSOZ3hZLIe4FVFx4gqd9j
 z0kunfjrhL0WdUzdwOTUyUjhOcniUSXZ3C/kKLH+qGofeyI5c+NfreGUtTHQR7HWDd
 MFQMOvW4dG4dA==
Message-ID: <39961362-0a9e-434c-85f2-2f9f5c7846a9@kernel.org>
Date: Tue, 2 Jun 2026 07:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v4 1/4] drm/scdc-helper: Don't use ssize_t return type for
 scdc_read/write
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
 <20260527-scdc-link-health-v4-1-622ea40a1f59@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <20260527-scdc-link-health-v4-1-622ea40a1f59@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 27/05/2026 16:03, Nicolas Frattaroli wrote:
> drm_scdc_read and drm_scdc_write, both of which are only used within
> drm_scdc_helper (although exported), use a ssize_t as their return type.
> 
> This would make sense if they returned the number of bytes read/written
> on success, and negative errno otherwise. However, they return 0 on
> success.
> 
> Demote them to "int" as their return type, in order to avoid needlessly
> using 64 bits when less suffices.
> 
> No functional change.

Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_scdc_helper.c | 8 ++++----
>  include/drm/display/drm_scdc_helper.h     | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> index df878aad4a36..8403f2390ab6 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> @@ -67,8 +67,8 @@
>   * Returns:
>   * 0 on success, negative error code on failure.
>   */
> -ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
> -		      size_t size)
> +int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
> +		  size_t size)
>  {
>  	int ret;
>  	struct i2c_msg msgs[2] = {
> @@ -107,8 +107,8 @@ EXPORT_SYMBOL(drm_scdc_read);
>   * Returns:
>   * 0 on success, negative error code on failure.
>   */
> -ssize_t drm_scdc_write(struct i2c_adapter *adapter, u8 offset,
> -		       const void *buffer, size_t size)
> +int drm_scdc_write(struct i2c_adapter *adapter, u8 offset, const void *buffer,
> +		   size_t size)
>  {
>  	struct i2c_msg msg = {
>  		.addr = SCDC_I2C_SLAVE_ADDRESS,
> diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
> index 34600476a1b9..e9ccaeba56dd 100644
> --- a/include/drm/display/drm_scdc_helper.h
> +++ b/include/drm/display/drm_scdc_helper.h
> @@ -31,10 +31,10 @@
>  struct drm_connector;
>  struct i2c_adapter;
>  
> -ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
> -		      size_t size);
> -ssize_t drm_scdc_write(struct i2c_adapter *adapter, u8 offset,
> -		       const void *buffer, size_t size);
> +int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
> +		  size_t size);
> +int drm_scdc_write(struct i2c_adapter *adapter, u8 offset, const void *buffer,
> +		   size_t size);
>  
>  /**
>   * drm_scdc_readb - read a single byte from SCDC
> 

