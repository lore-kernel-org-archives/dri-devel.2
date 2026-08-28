Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F65C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F46C890BE;
	Fri, 28 Aug 2026 10:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hdSU6528";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D8F890BE;
 Fri, 28 Aug 2026 10:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=0OoBxdqWvijDwJb9Z1krSSzEfUtAgPL5sxmV9JATbDA=; b=hdSU6528m6U
 P0cPsMK/fiOFC+RsSC4yBCaKVa/UeR5yolRjo/80yhu94MWqBI8ehyZyqkZJOkKEsVT9xw7o8to0l
 6mk8sYRYZweuCGOGRaVbMNID3sCt9q8TKMx1MsyZgWflozk4Ti78bPvLyAx7dujzzM/YpbrLEiKdh
 5+Tv8PTD/La8kPcH3UWPEPbkXfP+i/PZk4fQyNZahH8tm6P2tXWPR73vb8zTClPejxr/Dl6wiUc+I
 w6vGXN5iSKwT5LpM6nxDR8KsbIHXOCd33IFACM1vQ+X8qRieCylb/q3dskwuAvHqU12WIYC1fP3uP
 HCtN+oZQ7VbyqrbiWo6n5DQ==;
Received: from 179-125-75-211-dinamico.pombonet.net.br ([179.125.75.211]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wztlC-00Ao94-RU; Fri, 28 Aug 2026 12:24:35 +0200
Date: Fri, 28 Aug 2026 07:24:27 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Mark Yacoub <markyacoub@google.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.comm,
 simona@ffwll.ch, melissa.srw@gmail.com,
 robin.clark@oss.qualcomm.com, umag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org
Subject: Re: [PATCH] lib/igt_kms: Do not treat writeback and virtual
 connectors as connected
Message-ID: <apFh2_fIKV1I39fL@quatroqueijos.cascardo.eti.br>
References: <20260819190740.1392859-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819190740.1392859-1-markyacoub@google.com>
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

On Wed, Aug 19, 2026 at 03:07:40PM -0400, Mark Yacoub wrote:
> Writeback and virtual connectors (e.g. DRM_MODE_CONNECTOR_WRITEBACK and
> DRM_MODE_CONNECTOR_VIRTUAL) do not represent physical display sinks and
> cannot be modeset using standard CRTC / atomic commit operations without
> configuring a writeback output framebuffer (WRITEBACK_FB_ID).
> 
> On drivers such as MSM, writeback connectors (e.g. Virtual-1, Virtual-2)
> report connected status with virtual modes. When generic KMS tests iterate
> over connected outputs via for_each_connected_output() or during initial
> display setup in igt_display_init(), attempting standard modesets on these
> connectors causes failures (-EINVAL) before test execution can begin.
> 
> Exclude DRM_MODE_CONNECTOR_WRITEBACK and DRM_MODE_CONNECTOR_VIRTUAL in
> igt_output_is_connected() so generic KMS tests only target standard
> physical display outputs, while dedicated writeback tests can continue to
> iterate all outputs explicitly via for_each_output().
> 
> Signed-off-by: Mark Yacoub <markyacoub@google.com>
> ---
>  lib/igt_kms.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/igt_kms.h b/lib/igt_kms.h
> index 521a03c01..8d4d14847 100644
> --- a/lib/igt_kms.h
> +++ b/lib/igt_kms.h
> @@ -668,6 +668,10 @@ static inline bool igt_output_is_connected(igt_output_t *output)
>  	    !output->config.connector->count_modes)
>  		return false;
>  
> +	if (output->config.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK ||
> +	    output->config.connector->connector_type == DRM_MODE_CONNECTOR_VIRTUAL)
> +		return false;
> +
>  	if (output->config.connector->connection == DRM_MODE_CONNECTED)
>  		return true;
>  
> -- 
> 2.55.0.737.g08866a6d13-goog
> 

This makes a lot of tests (including a lot of kms_*) be skipped on VKMS. Is
that correct?

Cascardo.
