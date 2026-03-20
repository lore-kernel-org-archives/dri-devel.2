Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CE510987B0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A20E10EBEC;
	Fri, 20 Mar 2026 16:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GQ/NRiWH";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5BA10EBEB
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:43:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 16B3E4E4274D;
 Fri, 20 Mar 2026 16:43:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DE189600E0;
 Fri, 20 Mar 2026 16:43:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA9BD10450CB3; Fri, 20 Mar 2026 17:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025003; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6UUKeb9YDarb7naiUQi82QB6epF6f3pWCvy+2iQ8f1w=;
 b=GQ/NRiWHczg2SsmPbVFNdF0LuxEF6gkM+1WfcAy7D0v2vnfNyxbbVAJaqfJfMadQmBzLOu
 OzkWlpz/GV586Vakl04I2r1+FNHopv7Dbmx+8ZnrltA8DeyA7SXVXxfjzT5qmc3DFhXWPh
 N2Ug4CawzjfwfXjvcYeB5Q9DMabTDnhvdLs34M9R46LnlLC3sxamsoqMYNRicSGRQ6cGYw
 nx7pubaqmalRADPqMcTcKzFvy5jMykAR7bBQVStO1tvHxzfy9iI+TaVOU9a8m4/QJI94nj
 v2wOSvZekyrTiXjmZ/CPaM8vS60Tkg/SvcF8lEBIwyJ6gCSrkjSky4NE2ZYiyQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 55/65] drm-dyndbg: add DRM_CLASSMAP_USE to the gud
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
In-Reply-To: <20260313132103.2529746-56-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-56-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491471.6181.8818856004573027459.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=347;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=3GrJUgGgXVLKATcxHsKk2eD7APIgE/lTouswZbgxPN8=;
 b=kA0DAAgBIK0uxlsQLOIByyZiAGm9eNuiZ9UM2gBjeFeEJYLG1d5wsg9mVQ5OBqwvW3e7HXsyj
 YkCTwQAAQgAORYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJpvXjbGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjExLDIsMgAKCRAgrS7GWxAs4ohrD/0Rz6vEhxxHgkD41nCRIatMF19OPCfKitmnetUPoxS
 q0VKv6+iIGPl2zYzyjvO8dRJNI36VXKpbJfsy3ZblZg6n1j453hh7iW+qSVl/OWJmGsUPm01D88
 5i0wBwKTawg4FGsYETxHmYVaZHwGWkuA1OOZvGw4IuFcqaFQg2dRDUoQcfsYFlb+lq8SzcMJ1W8
 NZ0UBTo/d/siJTSLxRCUJqwiUZtLFF/Qw9SXerSoOx2tFRZ/j4C4ij59d1adYgEtYsbAB2nihXK
 ZdHv93t1EIN9Z3r9dSSMJgepPGzFtIzwZAcbF/zhd48Ep3Ki99a8LdTwDYyWx4ZvZ2BwwRpr8wH
 RVf7GdS823IBWz4ox5pgNRktPDZbSe3YZYYLuxfm/OEtQG180qd5HT6h7lAB0RefMHUxaHSFuZ0
 DG8q6zuiJyTzjKc+M4657Iwg287u66l90T7pRgdvnhbU8mAEgEf8+F5rc0QvjPKWH+Gku4YDIoO
 HM1O+FA2Xaca78AJ82DonflHpRj1DPTpkGF4B67pCfDNee2f35X51aOC23yFivE/MBGa6VBUvD/
 6T0EchP/iV+EwYOhfP8toHrQrEv3XgvfCQC+Duj144xcxo0fR8UhlvxglIYc4N5HNBVHcTiZpzy
 3ysfQZ3L182Du3p8j0CigCwCzCxm6KSOBXkCTySZbNA==
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

On Fri, 13 Mar 2026 07:20:20 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The gud driver has a number of DRM_UT_* debugs, make them
> controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
> that the module uses them.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
