Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C435210987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F74410EBC6;
	Fri, 20 Mar 2026 16:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QBGi33PF";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF2A10EBC4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A42E74E4273A;
 Fri, 20 Mar 2026 16:42:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7849D600E0;
 Fri, 20 Mar 2026 16:42:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C8E9E10450CB2; Fri, 20 Mar 2026 17:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024965; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=D2eov9mYgoOzrdqvxhU1NeQE4IQQdBebEx/n/f8G0ME=;
 b=QBGi33PFaeySJZjofVkltE3FOtnyClXGNlUTbAongG5IFlHUyubUklxGvwt+qhccNaCXnd
 C/XrqMFGJ+xXH84I8AJAlKUnjcgXsc9OmsomvNEagi63cc7p6Yo9UJ0widhWKSs8lPgt8O
 ZvOkjUDHRLXRzqUOTWteo+oP6DIK8j1FvEr0S4Wfa2wj8wvKDv90hqihpqyMXih2twXJu1
 iFuyNQ/KnuE/J7XsP20H2xGZVqLZFAl2CP2p9UyXzXwp8hypgPMTyVO1DQVz3bXSeMZ1H4
 SDlI4hDk6TT1ematey90MIOWvDnmHO5kWba7GfGU5FF32ssE6TrdOQmdV1mlzQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 44/65] drm-dyndbg: add DRM_CLASSMAP_USE to Xe
 driver
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
In-Reply-To: <20260313132103.2529746-45-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-45-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491459.6181.310434310040242842.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=341;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=wkPeMfWFdMwsBgB9lnGrK7e21ulZjCPnOjdFb/W3iHU=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjZECJCyxwaADPwvoKLVgXSmGrbG/LHfkNEY
 OOLqtoJH9SJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOLagw//Vow/v1/XrmcXv+zlbKHhvVk+B8Crvu5
 fRj5VwFXcHlCNIzMK96hsTYCOGpoTRn2gi3WfY2RIAKOR87MW20IcmiTwvlIl6tYs1iVijR9BRw
 BPXJVcYwiAIYEc2Ss5DmVOXAjhBbI0tEtIrJg/b5eAZ0ZilgNvz7VWi4leVrngtLtmm9SH2QXV9
 9l2PN5RhL5QePGKPCCI92s2dH3HLVEIxWZuj0WME9Edhasl79/4B+G0jTBh1cmgPHacbZjgVjV4
 ZkpfEhbUw+ZfisYf1SYsNxQE5/lbkUm0wyFlDm9l96fGDiwznT2IlHRuLNW8bvht3Pb5c/Ml4OB
 JVPkAkeGmozCyHqyQjT2+/N3HyQZA9WYkZ9Vr2NEf8UxqSosAvvgeHN2nB+htYW1HIzBNEl5YQF
 wXg8h8e+dGJhmfBobo3TORbZ3wQIizg7PFxxukEkXB/cCbOqKfVN50B3Iw9jSG5VjebJAvtv+n7
 h/q41NpF/pvHZFCk4LwwGkSU0nNEIJRhceH4vAc5hQaQCMJUbSz2i5vlRtGJ8+ZlmZPnIzStc3u
 HcYWIi+qAhuro1FM/CDstjLAHH56c6hb9gJGEhBNaS/LW0iu+oFisy9iIhsglf8LzB2MeD83hpJ
 uLxZTDzQVKQbMxyD8fOA/7CSHPx9cRMOZDFCKBRDpDySS8fFkjb4=
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

On Fri, 13 Mar 2026 07:20:09 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this tells dydnbg that Xe has
> drm.debug callsites.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
