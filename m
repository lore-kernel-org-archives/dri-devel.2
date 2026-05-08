Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B82CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F150610F4F6;
	Fri,  8 May 2026 14:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="D+LM6dot";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F0D10F4F2
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778250863; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CnabNJEtr6eCnmWKcZbDnkjLV/Cfo2uZBzvWp9vaS3xnZu7fDxs+lVPb2mDcb7XCXCmf0eqVhSzAc67AuZ/rDWIshpJ70Mn1KphMMkC7s8gz4RbJRo9klbY7xsze5y6IXWCdjzMx71sODezlR7mb4YQTLSm7uRgzhos02mQfplY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778250863;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UzweqPYXG/kNARl3JTSJmCAH2zJtQI9VMfU1tdfVnOQ=; 
 b=lZ4bxf2IWgXIEDLbSYaNO5X3qGgWQL8h7F09X0qjbgKOVX9p6sWSh+s/faS0hPQ7TPa7lTV7jTnxH4Pq14fz2AXGaR9J29qdv7bTNfJFcUdZyLYTfzby3XYY7YnqgshonSnEhbuTt8mjQNg3Gz1BIRwoefHMYjqOF0bKTiNmOro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778250862; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=UzweqPYXG/kNARl3JTSJmCAH2zJtQI9VMfU1tdfVnOQ=;
 b=D+LM6dotZTOnrZVp7DDDDYJY/2uYVdvWhUrOEjlQELaaYoznZWkuxJttXgR7540/
 U6W+wT/CeErkMHpDNKwteodhxp6KBDuNmEshMdMSquuwTk/jOCnpAC1+xnz+XsnQnbx
 Y5xTP5ke7+kmIg6K5E1lgCTF3rY5pN6LTj/HDKd4=
Received: by mx.zohomail.com with SMTPS id 1778250861133200.60037958313694;
 Fri, 8 May 2026 07:34:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add SCDC information to connector debugfs
Date: Fri, 08 May 2026 16:34:16 +0200
Message-ID: <WkoE87WOR7Ocja6EhwKpsQ@collabora.com>
In-Reply-To: <20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com>
References: <20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, 15 April 2026 17:56:41 Central European Summer Time Nicolas Frattaroli wrote:
> HDMI uses the DDC I2C bus for communicating various bits of link status
> out of band with the actual HDMI video signal. This information can be
> useful for debugging issues like questionable cables sabotaged by feline
> teeth, Enthusiast Grade cables made of cow fencing wire, and other such
> problems that ruin one's media viewing plans.
> 
> Consequently, this series exposes various bits of pertinent information
> from the SCDC protocol in an HDMI connector's debugfs. To continually
> poll the link status, userspace can poll the debugfs file.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Nicolas Frattaroli (2):
>       drm/scdc-helper: Add scdc_status debugfs entry
>       drm/display: bridge_connector: init scdc debugfs for HDMI
> 
>  drivers/gpu/drm/display/drm_bridge_connector.c |   4 +
>  drivers/gpu/drm/display/drm_scdc_helper.c      | 229 +++++++++++++++++++++++++
>  include/drm/display/drm_scdc_helper.h          |  56 ++++++
>  3 files changed, 289 insertions(+)
> ---
> base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
> change-id: 20260413-scdc-link-health-89326013d96c
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> 

Is anyone interested in picking this up for review? It has been over
three weeks with no response so far, and I'm getting worried this
will just be forgotten about.

Thanks,
Nicolas Frattaroli


