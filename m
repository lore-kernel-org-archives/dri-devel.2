Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D1F10987B0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6CB10EC0F;
	Fri, 20 Mar 2026 16:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="16zynauu";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E83F10EC09;
 Fri, 20 Mar 2026 16:43:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 399B71A2F1D;
 Fri, 20 Mar 2026 16:43:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 09077600E0;
 Fri, 20 Mar 2026 16:43:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D243110450CB5; Fri, 20 Mar 2026 17:43:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=a3n5vw+rDIMQiLwiaCuuTlkkpK5uafDLslMZG+41CRQ=;
 b=16zynauuABPys0pqMhPSawKQXkY2A4j9NE56YqAFfewB46l7Eq0PSQoqO22+2j82fHcbL5
 aQyZA+xe1dSlVx07tbweMjLr9oH8P9xTHQ/Z61A3T3/6zSJIXw31IgGq9N1NOi1DEwdrtE
 NcEI3EHfiuMmGNkS17WOplrpZ3drcicO7HJYH2sIgT73+yOTjaeRTJlSFs0/gRUHnIkavX
 MLS7A7yx8XUQ4wDSex9+Yr4lUVYC4A7xZawA62TYtCu4XGbOZwG3SEjIAb2cSGA2EhwqFe
 OwIRIIFZpBMi6TCuR4qG05FMYrr7frtaWoHvLFVUAGYDsFBZbLkiXglJBlfmBg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 65/65] drm_vblank: use dyndbg's static-key to avoid
 flag-check
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
In-Reply-To: <20260313132103.2529746-66-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-66-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491486.6181.8708643086354041969.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=624;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=p10Kv8NeHTDKVeqeVN7NQm9HSesgyb+B0sSXPicMRLE=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjc8KwPlWKu7gsoo5PcwPkMXzTLFkSOijp+D
 tv/3lOAJB+JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab143BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOKdhxAAwbAtpk6ueQX/rSWm8t4jVCvV/PFBvTN
 OCx7C/IfCLz8n+wmMSuovEnMBPCL8ddcycGWajInsmSA6WI3DwyCGWBZSTdaMHCyVnm6TIOoD2P
 wkhUpwNXWKA4vAXUR7hn4he8OHxMtZURiR9IdDonjTnNIBVVPC59+AQRhtebEcKmjLbpfbI0llH
 VgqiUsQAyk3Vg6m+8ZVMBpt6a0gDYGw/ky1+8gLvGkFOuz3MnurM1vKF1A1mkm2vjXeXwtORIeS
 KpFfxL8urNEOEsQNbEUy4edMrEmK2MC1J3QuWMt1W6Axv1/kA2TCia0m9krYfbkG7Lx/mFM9MwK
 9DgLhJgi7J/PYyW9BPiNQDVEV4W/bdwiYFwQQPxKe8f21bTGheBXh//2jb98EsweX/DWM6O682r
 PpDyW2ddLO6R+/SVwPruTqMcHvudkAxek6ywZzWISKdMe/2mgDE3Zv7VH2gbNSSlcsyxgNut1yq
 LDCtk8PvZl4AIsTDlsMbUIisZ5yBRvZbE/MAUThp5oKxC8hfB3TbfxRsRtUB2nTS4UC4gVgC/Jp
 sn/0nYx0CCYrVdB7y7gNg/3NGDGHycSNtLYp2LtE0RkhChCT+h0xx35wS9Uo137YurGSAIUBh+B
 Q+CkTZrfE2vakSSRIDNpf9BB+bXH04OfysqgYHSLGUMPVTvofgPM=
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

On Fri, 13 Mar 2026 07:20:30 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> drm_crtc_vblank_helper_get_vblank_timestamp_internal() is called about
> ~100 times per sec, on a single display. It currently calls
> drm_debug_enabled(DRM_UT_VBL) to avoid doing ktime_to_timespec64()
> conversions when the debug logging is disabled.
> 
> When CONFIG_DRM_USE_DYNAMIC_DEBUG=Y, the drm_debug_enabled() is
> redundant, because the following drm_dbg_vbl() already carries a
> static-key optimization.
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
