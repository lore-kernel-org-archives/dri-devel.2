Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6131E10987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECB910EBA3;
	Fri, 20 Mar 2026 16:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SBBxmhr6";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F19B10EBAC
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 73E7D1A2F1D;
 Fri, 20 Mar 2026 16:42:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4A5E4600E0;
 Fri, 20 Mar 2026 16:42:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B31EA10450CB4; Fri, 20 Mar 2026 17:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0jgXwa52ZddKFGAULnlWCD3CvHRYu/FIffa1Wa1TR18=;
 b=SBBxmhr6uOQd78BgMRZ6i1hJ25m58QyLFke/+xWjGbrg3I7MIU+ne9HtMxqk+6mpmMUUWG
 +GPDLg4pI3Vk7kPW4Iw+DJxqJ++fjOhBiQrrgD4Xx1bKboTMsFY8eE8plANIvt6sfWz5WZ
 Tr8vaF/bTPU5meWJkYvX0bSAu5kQsG8Au99cyYoS+2Om1Ka7WbO14mkvh2fmuN5XGCqOU8
 HZSawYJpwbhXD9k14iO8fuoWSfUXG3xoBif/Vzj8qSSFE/YTy8hh5viM/JqAFwjAgCMuow
 4UFBVhfP+D9/1UWULrvTWMHfI3zB54ynmc5HQB4iWo4agztG5jgU2j9yftmzRw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 30/65] dyndbg: resolve "protection" of class'd pr_debug
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
In-Reply-To: <20260313132103.2529746-31-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-31-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491449.6181.8307660284249533157.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vAVTGyCwCitGcQBi9zybWTqkZvRi6CuQUZTaiYTOkYg=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjY8Ybs8wXApEHBP9mQOJ31WG+UPhXQsNhXC
 ZrmRwyJOZuJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOINmBAAmml69jJeewbDfBoulxPnNRYIQy8axha
 h0+F6fX5YzlQAWkZnwOzG5ZttRRJC2lqENTqciJOk3IU6hlNZ8CUZuj2VvC7o6yk1zBYYbnlO9K
 SgJPaYwApdpJTvqjobFHuvHhMkferpJCRbgkecf7RlYNX6VVWotjixUSqSKP36Of15EsMhDPjn6
 xVQOMqD7jbrsBpHWTN3R0cLi34IVzKTQNd/sBosL8m6JQzHGJRFY4WmWg3Ud4r/qy1AtndUDBUV
 hOeXXVMDif1U5Qjyd8ltLCo2d4AQ7YwYNqioqxWo94wtfWtITj9MI28be+roLWM0hkbrhNhgLYk
 on6AYdkSD86v+gH0JJTIfNq8RLBFOa5JbFY82vjogBi4ao3aD1i6Ske8Tt6cKKWXP17KPK5sf1I
 suhoa22PknhfvxAt4eNMxFi7pGUEH+fWI2NdHpFqJqLOdFgZR/iqvKbEqLo0WYcXM1eurCj8rKR
 3fi/EsgfhTgQ2ybRFxS3xpxR8n4p/ZfV0XuldQ1N5AYY68tSqysOi3tc1WniXrSa4XTJVI5b5Z5
 +nM4Lg1UTzEJMWvvea7Fwv0jGjA5tDc31VIE0KuZIGoI9ZYffGPOoOcpQqS9RRGglU7Vqg2lEA+
 V75aFQRkrU5fpXGJrYXnGDpD/6VepQ3HNd2eQzynJ5Bqr+VD+pYM=
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

On Fri, 13 Mar 2026 07:19:55 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> [...]
> 
> The new resolution:
> 
> If ABI is the blocking issue, then no ABI means no blocking issue.
> IOW, if the classmap has no presence under /sys/*, ie no PARAM, there
> is no ABI to guard, and no reason to enforce a tedious interface.

That a good improvment! For me this is a good solution. The tideous part is
removed for "new" logging systems, and the DRM case is properly handled
until they decide to break their ABI.

>
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index a1c3141372d1..e9fa0c8868db 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -206,6 +206,50 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
>  	return NULL;
>  }
>  
> +static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class_map *map)
> +{
> +	return (class_id >= map->base &&
> +		class_id < map->base + map->length);
> +}

I think you introduced this function in a previous patch (macro
class_in_range->ddebug_class_in_range), you move it here and you rename it
later.

Can you do a separate "preparatory" patch for this macro->function+rename
to simplify the change here?

> @@ -1275,6 +1344,13 @@ static void ddebug_apply_params(const struct _ddebug_class_map *cm, const char *
> [ ... skip 7 lines ... ]
> + * use it, and expects it to reflect reality.  We should oblige him,
> + * and protect those classmaps from classless "-p" changes.
> + */
>  static void ddebug_apply_class_maps(const struct _ddebug_info *di)
>  {
>  	struct _ddebug_class_map *cm;

With the splitting of the patch:

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
