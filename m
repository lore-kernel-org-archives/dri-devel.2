Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B4CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 18:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD08D11295D;
	Sat, 30 May 2026 18:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="Ti/6Zda0";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B3011295D
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=21esaUBXJ091oJzAvFKvNgOydIHEV5ciaaDpOKvacLg=; b=Ti/6Zda0EBw/pNoizxg4lTVY2g
 55JW7+nC/O8wsrpkLm8j3r27UbgMCy65q7wnBGIuYrBRvf9uJ9ZUrCpc77cjDERVYJy/3QeY9x7Pb
 JRIbKVq55guXlymPSEI2IATShliPs9QaknOXYKC0+RHiF2la28Aw+4MRC3Rf0bvOtKTOI5ONfz5Jr
 IWj8Qa+ZUkFNjAfhyinaQaanmfwjcI2VebxMB34qzPBqwuSD242Lo4Hxa6ILSFwsLmcVSUvWtsX/L
 pjnUdUdTpkem788YHilV9lRJkNiq5HKPyDqxBQQlBS8HvyzXzC5AqBOuiM+ClwN1UoXwVjbW3s194
 GSDASGVA==;
Date: Sat, 30 May 2026 20:09:51 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/connector: check if destroy function exist
Message-ID: <20260530200951.5ab2dabf@kemnade.info>
In-Reply-To: <20260521103329.140064-1-andreas@kemnade.info>
References: <20260521103329.140064-1-andreas@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

A friendly ping.

Anything to do from my side?

On Thu, 21 May 2026 12:33:29 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Connectors might have not resources needed to be manually freed.
> E.g. the drm_bridge_connector does not have such a callback.
> 
> Fixes: c12907be57b1 ("drm/bridge-connector: switch to using drmm allocations")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/drm_connector.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 47dc53c4a738..d2dfc6e8f7d0 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -198,7 +198,9 @@ static void drm_connector_free(struct kref *kref)
>  	struct drm_device *dev = connector->dev;
>  
>  	drm_mode_object_unregister(dev, &connector->base);
> -	connector->funcs->destroy(connector);
> +
> +	if (connector->funcs->destroy)
> +		connector->funcs->destroy(connector);
>  }
>  
>  void drm_connector_free_work_fn(struct work_struct *work)
> @@ -216,7 +218,9 @@ void drm_connector_free_work_fn(struct work_struct *work)
>  
>  	llist_for_each_entry_safe(connector, n, freed, free_node) {
>  		drm_mode_object_unregister(dev, &connector->base);
> -		connector->funcs->destroy(connector);
> +
> +		if (connector->funcs->destroy)
> +			connector->funcs->destroy(connector);
>  	}
>  }
>  

