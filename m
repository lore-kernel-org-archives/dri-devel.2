Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3559E10987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F15010EB79;
	Fri, 20 Mar 2026 16:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DADgRnDB";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3971510EB6B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:41:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2B1711A2F1D;
 Fri, 20 Mar 2026 16:41:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0222F600E0;
 Fri, 20 Mar 2026 16:41:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8949F10450CB2; Fri, 20 Mar 2026 17:41:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=flcUBo2gDv14/Dcbspe4hLZsUmRO6oCu2ydk55bztLY=;
 b=DADgRnDBI6Turp8B6+93Gz0ZVgV7esIK+f1hXBAQMFWer7+2uG3x5PEyKDlE5KgQuk4eNb
 mlaehVZC/mZzh5inwm+AJNKdXdZR9jGSCI/UPIi80HgNVpUe9Ha8IHfSNkeg19afQ/oiWT
 jbpXHabAfPhZWUL0KjryKfToEeIjQkep/0edLvbVVVeAlcKvaYPIK4rBDdgtqVjL6TG0r6
 cdpHcW+sgRV7UbyIAaBTsCSH4NevL4fhVHBpPor1s0nF0RLxk1T6EJ9dZ0oopH7QoyGI7+
 18kJwf4JRSVf25Nxnat/t5k8xHIE5KO3OXaxCckMS9JNuB3O1SsjWAq3ssPzdg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 19/65] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
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
In-Reply-To: <20260313132103.2529746-20-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-20-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491434.6181.11890337294367473264.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=429;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=1pgdbshmE/Cq0nlfaNfGi8txJNcbpdrUoKURG+brXsk=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjXquxHUtG4nlEXHRTG+cLbsIxIFMqa+75fx
 hTqQFFfEA6JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab141xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOL3NxAApjJLmyYJYDlzy0eWBTTuXZkRgqSa5Mo
 IZNgfziDrXMnhcxPkRZpA6gT1Ac+y5Qk3PLwGnuiATk6VrlNyEx5xDv0R3+ZyOCMSZ4igQ53g8o
 oeWWXp9uJ0Cm7se7I4EAHVnrLZcb+pGv617pgP/7yc51icSEQ6qpFhcxRYCu18BnGr40aIZeDOb
 FjLKmS5jwPsosbU6sBjHi2d+ChEy2u0yrzNndzOD3B1oH1OYW6qPXUzLoWeOz9RHs5wANf/aY+a
 SHJQwf93DOJemuUSsV9x2RRkJUOpB27/Ns9xuMOdCAZVC6FDfik2dipLEvkIJmy7rNnHyLX/sLn
 8S6Ob6TShbbimsb0amH+joj1h3sd1vgH8vCu/oplroSVW9M1ZKmDNqoUkj3GNpt3ZHBEQ8gciTe
 VoBjN8JUeaA4JUA05cNhLkkPAprKc0MKpvy7D/EL/zwaQVZ07VK+GoAOzx3YIQrt8iCrKk+Hj3n
 ABrae9kASiebqXVdoZfRhHM73a1JW30yMUv3gI4Y4Q0lTn4WeiUmfnhiZfOvwbtzYmSrSsvUS4I
 P0RYZxKwT4bBG5Kc6vWTC8n0qEm7GypNoOfI/8FzjV1ujYc/Hv2BkA0COiP2ij/p2MI0SOJaIi9
 rBgQpEi3Bi2VH5v2jO88o5oZ1xnAb3/99CQ565k3Swr+mXVso0xY=
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

On Fri, 13 Mar 2026 07:19:44 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> Remove the DD_CLASS_TYPE_*_NAMES classmap types and code.
> 
> These 2 classmap types accept class names at the PARAM interface, for
> example:
> 
>   echo +DRM_UT_CORE,-DRM_UT_KMS > /sys/module/drm/parameters/debug_names
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
