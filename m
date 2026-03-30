Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E968103D95A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639B810E223;
	Mon, 30 Mar 2026 13:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Fw7a1HQ+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1914310E223
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xQUEdnTGWujFJ8cl4Fg/o580CjG3DId7b7jTkRzTYm0=; b=Fw7a1HQ+rKMI0/d9bvC9Ne4Qjf
 n36tJREAKlT2yFH4ZNw0ffnw2NN0P7e0dw44ZYs8XBeijD4bC+fDAz39yCqjPSQcFLRZv4Ngcfrlo
 dRrdmmrYMHMGUO2BXxBPJe3VgLBl8nrKwOlgWQ6G/5jDdnFkldR48XH5p1zIYwQ5vjle2BRQUADc7
 OpvB9Mx+uQMSIEFlNOZHYVswGHaTENrENWZX1tHzjAhOncOSYbOnAgQ2mDXM0oAdA2rvrXf0GcRuY
 QZlheY21hhqY5MZ/BIxfeCMf2dHKTzC10Wx+q8SfuFwyXmhKyOZq2EKvQeWMqJNpmOXgBtqtz7WBC
 nD28C83g==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7D4f-0090Nt-2v; Mon, 30 Mar 2026 15:54:37 +0200
Message-ID: <c48d1c7d-d687-49b9-b034-d0e74c4dc2bb@igalia.com>
Date: Mon, 30 Mar 2026 10:54:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/connector: Make
 drm_connector_attach_hdr_output_metadata_property() return void
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260330133446.3265938-2-mcanal@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330133446.3265938-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 30/03/2026 10:33, Maíra Canal wrote:
> drm_connector_attach_hdr_output_metadata_property() always returns zero,
> since drm_object_attach_property() returns void. No caller checks the
> return value, so change the return type to void.
>
> Also fix a typo in the kerneldoc ("HDR_OUTPUT_METADA" -> "HDR_OUTPUT_METADATA").
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/drm_connector.c | 9 ++-------
>   include/drm/drm_connector.h     | 2 +-
>   2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 47dc53c4a738..3fa4d2082cd7 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2867,23 +2867,18 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>   EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
>   
>   /**
> - * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADA" property
> + * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADATA" property
>    * @connector: connector to attach the property on.
>    *
>    * This is used to allow the userspace to send HDR Metadata to the
>    * driver.
> - *
> - * Returns:
> - * Zero on success, negative errno on failure.
>    */
> -int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector)
> +void drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector)
>   {
>   	struct drm_device *dev = connector->dev;
>   	struct drm_property *prop = dev->mode_config.hdr_output_metadata_property;
>   
>   	drm_object_attach_property(&connector->base, prop, 0);
> -
> -	return 0;
>   }
>   EXPORT_SYMBOL(drm_connector_attach_hdr_output_metadata_property);
>   
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index af8b92d2d5b7..c8dc08773a11 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -2518,7 +2518,7 @@ int drm_connector_attach_vrr_capable_property(
>   void drm_connector_attach_panel_type_property(struct drm_connector *connector);
>   int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
>   int drm_connector_attach_colorspace_property(struct drm_connector *connector);
> -int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
> +void drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
>   bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_state,
>   					     struct drm_connector_state *new_state);
>   int drm_mode_create_aspect_ratio_property(struct drm_device *dev);

