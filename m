Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E74606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1NMIfIKM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461C010E16F;
	Thu, 19 Nov 2026 09:32:40 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4A310E16F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:32:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E17A4C4CBEE;
 Thu, 19 Nov 2026 09:32:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A9BFE60237;
 Thu, 19 Nov 2026 09:32:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 025E611BC3181; Thu, 19 Nov 2026 10:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795080747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1C61xeBKulLYwJuVc3RNoDRJIx6752+oYOVVPuwYWnM=;
 b=1NMIfIKMPP2FMqofim4VxYfnvhVhXzRa596xSE2KG7GDRAZ+HBAozTvxFduwS1Jx1sChCC
 WDvyssEyHm/rLrlgsPdsF4hT9PqPlYvRpburMmzAll5TCEZRt1RWacwCKo4WSD4Mqm/H0D
 8QpFAwZv/KAV0hqQc28+bGuE7WDg27MwKLlD7mWMUWmsSeNoQl123z0Wq6mv+LfG5J0u7d
 L3himQqA0aDc3yC5rSS1VBSq50UbALaumQWGSJwYwr67/2K8qb6Kbc8efQk6EpNMlvMgpT
 lWc9uGvD62ssIZfU9zFbU66+8sOFNjJi6kAYUDuMsUl13/r83/uzKrKwrnMJKA==
Message-ID: <eb6dd7e6-34ee-46f4-82d8-3303d0361e8b@bootlin.com>
Date: Thu, 19 Nov 2026 10:32:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v4 04/20] drm/tilcdc: Fix endpoint node names in the
 legacy panel overlay
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-5-ville.syrjala@linux.intel.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261118214518.29317-5-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/26 22:45, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> The overlay names its two graph endpoints "endpoint@0" but gives them
> no reg property, so dtc complains with W=1:
> 
>    Warning (unit_address_vs_reg): .../endpoint@0: node has a unit name,
>    but no reg or ranges property
> 
> There is only one endpoint per port, and the overlay refers to the
> nodes through the panel_in and lcd_0 labels, not by name. Use plain
> "endpoint" for the node names, which is the usual form for a single
> endpoint, and drop the bogus unit address. The remote-endpoint
> phandle links between the two nodes are unchanged.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

