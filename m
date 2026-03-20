Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBBA10987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229E610EBA2;
	Fri, 20 Mar 2026 16:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VoQC0Thz";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E4210EBA0;
 Fri, 20 Mar 2026 16:42:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4D280C5668D;
 Fri, 20 Mar 2026 16:42:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C6867600E0;
 Fri, 20 Mar 2026 16:42:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4ED4410450CB6; Fri, 20 Mar 2026 17:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IpIrkQUhN8f9igBcCmDP+0RFUmudVzc+7akDpTrZ6nU=;
 b=VoQC0ThzFJinqd5e1n9HS6KWBV5NRmpjFvScHyP+XxqNHEyuoSWX/aJzfFJjM0+vwswadm
 OjUlL+JUZYgTXkMBsY98T0IqlTgjoUCUhcB9UR1hGQ8ROGpbSEfVAlSLT5q3TWJzcVWee3
 l5ZfkLrEC10+81aIjQtznNYe0h/ZHdyDvrt/DaPUMkdHogNH5/T2XKtMF2Nua2cZegqO63
 xfrP2ciDmdt3rsLUxCvQvpU0EMxg2Z2HuN9QobwFYko+fZoM/cZqlokD53//4ZjwJ7C4BN
 fGHjVTCMIo9l5+cJNkCjFTauPayTbgXw++44DVBKPyCl539EX/V9wfaahjj3Pg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 26/65] dyndbg-API: promote
 DYNAMIC_DEBUG_CLASSMAP_PARAM to API
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
In-Reply-To: <20260313132103.2529746-27-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-27-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491446.6181.10584556385608309440.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=505;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=QnoSxbC/cY3NZCY1pQn05gze166+KvYaqE2hHUZIazo=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjYVKznFtfm2NveHmwQmNVFdRP9BwFBABzkr
 51i8gtIGGCJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOK8Hw/9Geg+lz6YSmcNWoNyrjdqBcH3CO8z8wC
 t2fz23bkJg28OvwD/nZ5GukYX3ab2sIlJmdvfiFd0Ny4Tt8Mc/9XH3Cvv+ujZ4xfveJ9hXSKkZV
 9qusbFNE2PsO7ZKLpnSuDYdAT60NTOa9HC7dDp0MVBXU+IpYKmJ14pN7jQbJ2CVEnzh2n2RLSSq
 FxDOQzWo4V6ssj0k0QFIht3Y089QYHUajO0tluOLa8UhEUQ5iv32TQ6fCDT82fSlZkK1kyO4DVb
 UrsRiCPFW9aiIGyoQEuUK1y/9fVQgr2ZoovaHGvM+TnCAKD8Q1ZLMRLy7g+5SoRYzTyDZk7ECvZ
 Wowy+PS29IMMg+53GOG60cLew/x14K6Fk5hifKimi6GGzP9c+jT1Q6nblzZlXO+P/Ow1pxtQcd6
 Lx89ooK+UHbLnW7Sf8GB6KMGcLCei6EFo7IB/ED8z1dcyuTU/uF0AdMAlolvK5LiUrwmwO2YFJl
 5iHi9KTPJkPS7hZvCiHQj2Co+XjUpvVE/u9ziYxKdQhnOt/MaC9Zqsq1kuf3xuIFH0FmQg/2AJQ
 YWoXOJyNtxyfhnw/cRFbLNnj1cEJanRlYGOHLz26LV5EjyowL0Jg2FVQw3R8GelQelmbqg8jEeX
 3GqWTg84YpgHUJYOAd/+S2UZ43M9Jgtq4Zn8juYazQ+7npwQVawE=
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

On Fri, 13 Mar 2026 07:19:51 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> move the DYNAMIC_DEBUG_CLASSMAP_PARAM macro from test-dynamic-debug.c into
> the header, and refine it, by distinguishing the 2 use cases:
> 
> 1.DYNAMIC_DEBUG_CLASSMAP_PARAM_REF
>     for DRM, to pass in extern __drm_debug by name.
>     dyndbg keeps bits in it, so drm can still use it as before
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
