Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1127110987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5905010EC0E;
	Fri, 20 Mar 2026 16:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Qr0Q2O5S";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7EA010EC03
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:43:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C18434E4274C;
 Fri, 20 Mar 2026 16:43:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8DD23600E0;
 Fri, 20 Mar 2026 16:43:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8486C10450CB2; Fri, 20 Mar 2026 17:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025032; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=o3TXJDYgzD0dmnxmRY/CvJQPOemiCTt86JVL7IpYsus=;
 b=Qr0Q2O5SE+fxx+BR+IEUfeudH8G1RGHpvsTIxl0lO3sHWEr1nxCj8M+cmuq+6likWftabc
 aKoCCWdCgy7zYI6+gK+BKVP9VDeIasNX8GTZHW8p/qkB6mz8r8+gPQ53uuD2v3hmyzBHgh
 gC5OZNZdyTKRMZmgx+YN+T7shDBpfo83fOZMkWnldBpE+zX//abG3C+nDS3ntGOV/hO/Dl
 +yNLTzWhDe7V/lQ4jIxz7vRzKmfx6aKxOM4A4gRzqh6EIImsnPqtTwbP713HKN+L3mHRYl
 QOUDd8C9Uf4JoWjEprmzCXyVusw8YoJPgiUzT5oO3e/1HG8brXogLOQdG96l6Q==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 64/65] drm_print: fix drm_printer dynamic debug bypass
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
In-Reply-To: <20260313132103.2529746-65-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-65-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491485.6181.1878747749743687917.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=612;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Enxz/CcS4dPtd+s/MVIidGMfH3pGlf0ScOzJEm/MQ4Q=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjcBJnEH32EGjcohuGKyo7Uk6ttAtORp7pSX
 79okPPk9HqJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab143BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOJ0IRAAtvJ4V8XWD0jXnFnIuRM6s2dU3QGRQgk
 At7QqstxQUvULu6HboZlEUCOhM2osLgght28TTqVfqSoSXbRvnaXH+c67yBYiNXFmasvKZfDtWg
 uyZbxw+8eY2awXf4pevPmqRMqXfSeDBvHJGFaklLCfp0ye+Vnkt7rAZeFqNC7x+keU8GsD6o1NT
 w1aQaSbtpiWjwhi5F5K7AjAAd6jAY5OF8JAFszDtU2fHi2LjiPl5Poelw9Z0uo+F7fXfl+onx1w
 6Y2A8cy2UJdQofxR994qGF50aTav6ttOMe0xjWQGjF+ZGxARs4Dvwbp/IOttfGeyt06WZaLIXXm
 5YqMD5c922q+Z+tyLZTyoqE8I3C1A5kgcJt3OuXeE+SHJemRULzw1qQzk1894bMkiSiSKEIs8q7
 mb90QP7D5mgjAWyJZYPjcGtsaYvZCqvVoaeGwAQ4B4SZburEa9NLyVlp7H4Hv+gvW7Ap4I40eS6
 W5urVH4tV/wBnYX6Zfee4PYYoqjc+W2ALcCKBGElxOTB7wk7YgZNNKPFX0YL/nUXmZPAdx1rGag
 98YKY0suxFrzi2fY8d1ZSLPTyVvrPrzddRpaI2qBZQObVlQbzLME0vKW7q/vfjQ0JpA83AfKdUl
 vfgmf0JNMYfRfZ1Fh8rT88GbwL261lTZLvaJWxVOVIBxE/82V/+I=
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

On Fri, 13 Mar 2026 07:20:29 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> [...]
> mismatch in intel_pipe_config_compare(), the resulting UART storm
> causes a hard timeout after 20 minutes (see below the snip).
> 
> To fix this, change __drm_printfn_dbg() to use the explicit
> drm_debug_enabled_instrumented() instead. This ensures the bit-test is
> performed at runtime for this unguarded helper, stopping the UART storm.

Why don't use use drm_debug_enabled directly? Does it make sense to call
the _instrumented when [2] is not enabled?

>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
