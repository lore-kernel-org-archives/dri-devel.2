Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E0410987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509A310EBAE;
	Fri, 20 Mar 2026 16:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qOdbOsHK";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F02F10EBA3;
 Fri, 20 Mar 2026 16:42:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 618B11A2F12;
 Fri, 20 Mar 2026 16:42:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 36ED9600E0;
 Fri, 20 Mar 2026 16:42:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A5B910450CB2; Fri, 20 Mar 2026 17:42:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5Upo3hScNRXxfD8KfH+RzSygMfHGPA+CXsfw3S8Dwtw=;
 b=qOdbOsHKbUalYcoMJLG9W8ylvNpWSwXQF7LjJUVIyIgEa6rvaKTl9nkcR+3dVeYfNDe6Vl
 cx1Cd9KTbXx4P1bkcR8CAy+D8FoDK7Oix1hiPAFRhAA3eItd8nN/R0rmVABNuvxr4fPqDc
 V9R/K+2uLlipNZrfsF/m+LKHepmZKkPwosqAWfo+l2BIiT3MjVtZenoGq2Z7KIcH26GLX0
 fPzACSPQPvC/4wH7DWpZUqE2NZvg+qM4jWH4Zhqr//OA4X7CnfbdXO91Bf7ad1Q7J77z7R
 INFzXq/eZMFTayVnJeIqGReb7oiG+/Wgv8SwCexr4rxGqNvkIprVBmT0xMXlYQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 31/65] dyndbg: add
 DYNAMIC_DEBUG_CLASSMAP_USE_(dd_class_name, offset)
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
In-Reply-To: <20260313132103.2529746-32-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-32-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491451.6181.5247342952148189934.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tNHRJNfsxbH6Lp1F09jvKXwBOTF5PEoW5rnafUEr6/c=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjYBrvAKr/WIcrVFbIsSIV6B7jPOf4kKz/EQ
 7fnAkaCD2yJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOL2Zw//chy8SGHsGdRzra1AMEAMpga41OVDHRz
 QSQI/98l1wQgvP4MCu2eKyIV97OnKGwtMi9WtVY8rb9y+yUWtKsugGY3ZBQTYEuXcoTEfmlfG9o
 HQvdNZmcXO9byGrgrwYK1X7C33njLoUswwpg3R/ixO+A3jKluBFE8MA4xs+qENTQLyE97zK3Pbf
 KBdZEqkUbbF9Doo208VhC6LFM0+d+Gm/FezIRRq1uDXrkAYwsNhR040V2qILEruTiKeD2VIBKij
 AnlcOjV+dG0cUOM2IMEKYgzaK3VHIvuIeWh5uUQSpwQCaXQ/jzJqJOR1qRpwutgQDkGSNouVFxo
 fXQyDw+sH1kQ4yWAZ1qDsq8MjfuS1WO+ij1c6EBzbeLlosLSP/cAD1lEuwkHIBdgSI+b12Jb/rW
 w+5aaxyt8tBwzB/OZhh74yJ2BR+ddiEo8pTiSDyTgMi8HCC77EUg1lI0Banz1ve5jyEjZoF+26D
 sKLzXUSQXdrlgLshwz1I5/vMBjitcp1ABKNq3e3fJnpb3EiXUfk0i6R9JkL1Wui/8TXeKkVhwW1
 mWDU1LokiXHhP8rOQ3s8TDtYVVba+cXOo45HjCXjDb+LApMoF0cGJi2LqcxEKINn0GOsApj1q7Q
 RCFHRKuwAJxqjjsf+IV4cZv0mYmHFafOVEqj+4fpJD9rq6yHAzwc=
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

On Fri, 13 Mar 2026 07:19:56 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> [...]
> cases; perhaps a 3-X-3 of classmap-defns X classmap-users would get
> too awkward and fiddly.
> 
> This is an untested interface extension, so drop this patch if it
> feels too speculative, knowing theres at least a notional solution
> should the situation arise.

I agree on the patch principle, the implementation seems good.

Can you move this patch after the BROKEN removal? I think you should
"stabilize" core features first so we can merge part of the series (and
reduce patch count).

>
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e9fa0c8868db..2083a8546460 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -206,12 +206,17 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
>  	return NULL;
>  }
>  
> -static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class_map *map)
> +static bool ddebug_class_map_in_range(const int class_id, const struct _ddebug_class_map *map)

(that the rename I mentionned earlier)

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
