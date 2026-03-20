Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5FC10987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6B810EBDF;
	Fri, 20 Mar 2026 16:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YRYh3UYU";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9208F10EBD0;
 Fri, 20 Mar 2026 16:43:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7C5A44E4274C;
 Fri, 20 Mar 2026 16:42:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 52326600E0;
 Fri, 20 Mar 2026 16:42:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 24F5D10450CB3; Fri, 20 Mar 2026 17:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qMcVQiftVhfBkmML8o2ktmysqfxHkp+YMWDo00Lyi34=;
 b=YRYh3UYUIjppt26iyz9tShHn+RkvXLKX1gzUyVLtKfFdja4HfSJQAcm2nl3iWwu9TN+SGq
 uB+fOnYPzDHqXzNEoZFK7YksJnZfNPNLYOd6wGo8cKr2VjYBJ5X1R3iXOvlQwdPmmkyNrG
 V0uMgGxba95DlA3mdwQe7bJ7EC/eQ91blvukKpVcVVWA7Nygllg6T3dFyN6S5AwDTw+256
 G2qZF2/fjwvs5c16g8dwegDpcuSpchAJb5FmimW8zRdToeDNGfPxxtkaRTR7smiWqNo2ly
 0AS8yXW29qyM2lPqAWb3YrwPLWCyOhmRqr62AcLN3stEJ/Bod97z2jvUrkBsdQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 48/65] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
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
In-Reply-To: <20260313132103.2529746-49-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-49-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491464.6181.7285802673166697323.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=374;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=FbFQHKIzRc0orxa83RdZyoT3C7omF7bMn9AFR/3PkUA=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjaEf66zVN4xl9/AZ1btwhO/UJ1hBONRbpsQ
 JhIIJ30nXSJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOJsgw//RSgM4dN+d7CGaI8KsrRtYT/mmaVkMKf
 aIrzpcNNOuzz+Fx9wHnX7sY/hTZImbh7fJa9UINHzk2lPxe0GZHD64fQVg+jB8HWGNy73uyTeiy
 Zx2I3IKIY3/TjzXoon7fRnr4espAU0O8/2ahlqLWeKMwch+AATkagtwt+B9Jf/ah/EfSxONbD0K
 3sYR/yF3HKDNS7/ZmbtIXQIIruTWt52wCCmP0LBQiGX08xsawEAYcZY4STfS/Y+yB3wIuSVF+fv
 LP1DxhU5rxFfIF0gN6+nGXtX1uheQC9XREVrvY74RAay0xBocCFT2bxt92S0lvcJi++rvaQF21v
 XERyu9pSEZDPXir2utxDefLdK+QdLIlNq5aiK+jEsXLkWJvb0TRpW3Qk8YbQYqqZtIQJ49Swzu0
 MFV7v5QX9lq1XtE8oK++h8nNWNq9vhWVhUVZvzCP+25JxT3ZCdQZmZr4KCrseZHnYJQ35927q33
 KkQLQq0uZk97DUsbjwbwiCpmJUIJEanpreYISNrBbKV95xKetp/nBMBTIaaYYyIh6gL9wb2NxHb
 YSUBieHdZLPlJgrFYM0xQgNuAGqr3ZEhrbsqT89ECab1WGE3U6JKMrOSml2Y3d3qKUQLGK8x3ut
 45ZUXjr3/ADoKOfl7J0lwkakm8U3rgo4G+28WfubsAV7zOVzPtHQ=
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

On Fri, 13 Mar 2026 07:20:13 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> etnaviv has 5 DRM_UT_CORE debugs, make them controllable when
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
> class'd debugs as well as plain-old pr_debug()s

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
