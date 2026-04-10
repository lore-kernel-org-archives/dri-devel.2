Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A745F44873
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A301210E968;
	Fri, 10 Apr 2026 14:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g/p8S5Dd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6288810E968
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b2dPa/9qUelkczGFI96N5BYgXRq9S9K4H3gpRq2Dwas=; b=g/p8S5DdA4TX7TA8slNLktilGG
 2deAebdnn7zjdHSM8tCMUEf4CC+gdDIRTQaw7byXOq0+AT9+3gBy2vosEx+86nqE4MCKdWh5ZGhRh
 0+hFkjkKtkKmGjTDUkOha0oudQftchewFJibU7PKncLIFBugiLNdDgAfdrn+ij94NWO5JIi/DcJCP
 XJr/jND5vfq2rVWMtJEKCOoD+HEYkXGN9MAkvCK+OHzidKc20CsPPfzzmW/OABK8eQKRpeShiXkDW
 XFi0Eslb2xh9zseuldnBrJ6EbkNgG7ork89H3WPpRkQLYJVqEpaIYQawygRd785uF3TNzAPTl37/e
 94LyF35A==;
Received: from [189.7.87.169] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wBChp-00EQWN-Sx; Fri, 10 Apr 2026 16:19:34 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] drm/connector: Make
 drm_connector_attach_hdr_output_metadata_property() return void
Date: Fri, 10 Apr 2026 11:17:49 -0300
Message-ID: <177583066681.895246.3015776180024405417.b4-ty@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330133446.3265938-2-mcanal@igalia.com>
References: <20260330133446.3265938-2-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 30 Mar 2026 10:33:04 -0300, Maíra Canal wrote:
> drm_connector_attach_hdr_output_metadata_property() always returns zero,
> since drm_object_attach_property() returns void. No caller checks the
> return value, so change the return type to void.
> 
> Also fix a typo in the kerneldoc ("HDR_OUTPUT_METADA" -> "HDR_OUTPUT_METADATA").
> 
> 
> [...]

Applied, thanks!

[1/1] drm/connector: Make drm_connector_attach_hdr_output_metadata_property() return void
      commit: efcd474ed273ae7da614b30e798651c6d57d3109

Best regards,
- Maíra
