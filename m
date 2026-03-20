Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D060C10987B0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF6110EBD7;
	Fri, 20 Mar 2026 16:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="g5D/oyGa";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569BB10EBD2;
 Fri, 20 Mar 2026 16:43:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 412A34E4274C;
 Fri, 20 Mar 2026 16:43:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17A4B600E0;
 Fri, 20 Mar 2026 16:43:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 384D210450CB5; Fri, 20 Mar 2026 17:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=yVKKtFyA9DidtZm5jLKM84Q7/lY9FYwbHVUGWxBkhsc=;
 b=g5D/oyGaKKqw8Y7BJ8EZNy/E0a0YKrC2KEi5W7jJOonIl81YvPoIXZbmsWyGbMbnLbiVEb
 cbiajhz6qKIw4E5WR+ynpCA9uOLkwd34jYkxvvR67dXnk9RAUMA5xVZKQ2tZIxAO/5WIEO
 oTz2xW7nVA3+Laq64D2g4dz1DyD4g7NzdiE9g6x4OYrfrZsdxfmxJ1tRsA/kihgywokery
 B4EXNg6/RXyUsCRsn6lTejZXsdMzTotPWm/HhlFSXgYD7IDPlgLk1NIU75U/UpnUGE3VRB
 JfkZVbDj0FNf7+mirQn0UqWy7KHbLiDjGBv3JMZfAVkKj/R17zkKqX6zO9sZFA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 50/65] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
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
In-Reply-To: <20260313132103.2529746-51-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-51-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491466.6181.13101083951648427716.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=342;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=XjeURTC8B5LFHL8twqKgk5E8IIjYxafTskje/7umE08=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjakz4wkagD2nfr1D1czN1I8E59Kwy4DxqTM
 Or7cfF7XJeJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOKUXRAAlB/qDIOZf9YSF8wRqhV9WtryWG033vA
 o0U1RIOXNfUdxHTAPy82/bkNcOY6JQZNuDghnBTS2J6UROHxKn8gQtGt8lOn+hRyuP0mTGcsIXf
 EufkWtnyygNgBlSBdfw1b59GB6Brja5m4A0qFbVbHoOE6RcmDq/Ey3bH9SmV5HR2z3j7qNaTbhU
 m90cWmVmx964SqwId8yriby20rbRT2KNtuFv00wZ23X9zPuLCUSRARFqlx9q9FH72qud/L0ru6b
 IWSsM7yKybrTTDneIEhPHhH3D5sL2AwwNvfNdIRHg0bSnTq7185fDUs/ysFAJZHg0NOB1xzpTmS
 aU2+1ZZjADtBLS+SWqqHiBRhwFCqKaD1gn1lnPm4RpUOVce7bwSAiCvYKdlDO35Erm16cd82Lhz
 /vaXJwRW5eBsyawT0PeVAsbLSCNyspknDGhcIWAPZbKz2rkbGsGjaISyCkBYRGsG45lDNtZmlMz
 +R2B6tsbScEFTSvkAsO62B8g4WHxih/MigXFSteDigYyHRnBj4UkA98TwDIAwIlfRxyzBgsCoNs
 +WJfsRGuxLg1swJndoNZBDj8oE2PNkhDpY5bXkDlRcPnKw1A/dWySh+AQt8jqEd8iUD9GZv/gbG
 dCfKcsMo8fz77uIOEDwWqwoxqMLkhNBeyTBYUgziisJ5KZfCyavw=
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

On Fri, 13 Mar 2026 07:20:15 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> radeon has some DRM_UT_* debugs, make them controllable when
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
> the class'd debugs.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
