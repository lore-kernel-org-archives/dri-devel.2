Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4095A10987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409CF10EBC0;
	Fri, 20 Mar 2026 16:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Fz9+KOI5";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91C210EBBB;
 Fri, 20 Mar 2026 16:42:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A3FCE4E4273A;
 Fri, 20 Mar 2026 16:42:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7A679600E0;
 Fri, 20 Mar 2026 16:42:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29C5310450CB6; Fri, 20 Mar 2026 17:42:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024962; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7TnxlAxfxEjwQTNjRbSYJGkJHtkKFPmIUBN531IXF64=;
 b=Fz9+KOI5niCcdP485jQLFQN4jmhxDYZYFxEVE8zrzZVag2j0NaZhbNL4s3EVJHv8NSLGTs
 KO6datdkHJzfubopLGspPAel6giWKyWhO+FG9lToWw4M5e0dXbzPko1890XOQSheJLp5gj
 m9RkysLaeuE0dCt05aOEPGcxPO2eZyMVM8W2tHWy97yYk9xXNAAgA2Xqx4aH4eFNSOoNh1
 5f/a2CswNjaQTG93ZWO6Kp66Hm7hk0w+5xcvoGzjEJpnXvlugevLEtAo7s7Gf+2Vz3J/e/
 CN7MR7zdaBYocSofLrPBDGEDLgvIe+Eomnqm+lfPE1eKCZPSm/Tb4VMLc5bUvA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 43/65] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
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
In-Reply-To: <20260313132103.2529746-44-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-44-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491458.6181.15706166444323339101.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=507;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=m2c6UL2tk8kMT+C+4PEMVEtBDNTIGDGKRTBSrfGgQzw=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjZsLlEI7+NlIq7goerLfKsJgG2pHovrXRpK
 n0/tOKIdXOJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOILfBAAnoQshhVTooWQvE/IcB1KgKyVlrMBkWn
 Zsyqa9lNOlW0HUj7knSkWm32IIi17oC67gL+bvfj8Dc9VaFzXuNQmdQZ+h9+B8dTrnv8bxLCYQF
 anX5iC5c2RhrrOeA7cFY/W0WUxneGrNJcsGZpZKP+SAypJG2zNpipe3hT7v4rDSJ0Urjt9YBGd2
 KUHPtoRfMJy9XQPjqDqjSGqcl0Hy8VXZ10dN9QUKgsxzCHOyRNRWWH1bvkS6XY1CUkjwI1mkbpa
 0AEmMiS2Nyw1AkKdrVUAziEJ736slhoUh99HkJjKHcmEKIlUfpigvXMRVxFOeG2TGVJsVDfTgln
 kRFGry2M7OlIXUnlCYFgfncBiw2aMTRVwJIr7U37xPjbxgSscJSyy4OyXCqRdyfJ1bvkHWVdw7z
 Arl0BRobTROX8NM0lFR1+aEKitYBAopSNc10qYIltyDH2NCLM/VaKz6wlSk7vcOyRpuFvNoiQqW
 K1vvVl9Yeg2j0BgFLWJgx00aHGHIRWsKIZ4FwukC6ZwiM3LdkiRnx4to46R+73AKxgrJhg5R6ny
 o7zf+EWwep7x12OgHYbgbNZANetwuENXygpp8nr+UQ7DTXUpmqyX1yZMQr70eP97xKPjYhZSmy1
 6Pbu2wyHg00hZg+d2735EMo0cLDRxRZ7tnq6DXlV+FZFzNfMPiTk=
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

On Fri, 13 Mar 2026 07:20:08 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
> DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
> than re-declaring it redundantly, and error-prone-ly.
> 
> This resolves the appearance of "class:_UNKNOWN_" in the control file
> for the driver's drm_dbg()s.
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
