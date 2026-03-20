Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A2310987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF8910EBD8;
	Fri, 20 Mar 2026 16:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VfVvPUka";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8EE10EBCA
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id F39FEC5668D;
 Fri, 20 Mar 2026 16:43:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7855A600E0;
 Fri, 20 Mar 2026 16:42:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A3D110450CB6; Fri, 20 Mar 2026 17:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ng4JhdsTJJyshZU7Z8wG7ah3v/b7t8Ek/DzG/SwNHls=;
 b=VfVvPUka2Z6GE97Ejs5S/Zgot1NwEWyzSWCBWrZSo8+4KmfUV4QFCRDgCh1nU7gqF0gb2M
 IJLPK5iZKhpQlisg+hYC9Wpy6vcsdOcU34BPAu3eE6FkBWFgirSzMLO2wex2/4hMIGxMtm
 k7AeSqqxCBFOnK/MhI74wIPdlr8ph9IqxqzE4ul8DYhUFUs3D1JREUEVaJ6Xrzk4OpsD3c
 ffyl/0VyiT7bXIzdJRL/Hx5A82fkt1xrwGDYfKaJvU7smjEtAm85+hyuj28TojNZiuaXLS
 0B1XlLx5sgDALbjdxaqbUl7N2ieyky6y+C/r8PNk//PyBR0a4Hzo716NRxmueQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 46/65] drm-dyndbg: add DRM_CLASSMAP_USE to
 simpledrm
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
In-Reply-To: <20260313132103.2529746-47-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-47-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491462.6181.11857331396045294184.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=351;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=jRGHvGCSK73Yf22bn0ZMUkzfIexa3s85Q39fOenYGFE=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjZCQDTtNcfg9X2biz9bNBG1caPcGcLZ48mz
 ZrwfQChxC+JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOLX5w/+JAkpfQWOg4UH0cLGl0Ae/Av7CYRGxxb
 hWkw8ED3Q5BbhIBYvbR5LQbWABZZVDdZUwxdFi+ovzTwgl2gOLU+cHYYiYDrkwyH2x0/1n0HYS9
 zqb2lSbTxOiiqcYAPmjJifBgMWYIt/Cy1MyIb/6/lYkJ6YEh5RuMw3z9WrYHeB6k5gkN6/qEbU8
 d7hW+Lu2PHzOrJujarHIVlvvkdsfV8ZDKSuE5j6Ky+W+MzKbciY2hOKxSJw6MRh91xm5aHXR8ft
 eOvkukNwF+93mmJHVBOW+uUjduefn8o5zCb/kcZ37hVRYLXvx/vxrGIMvEuINiJhDGv6C8rrd9I
 CxrTaJp5krF5GuFDKVnhonVh96oNoTzIUjjETfdjmWA0OnNeERHd3jRFnf0KOGm1e5w/zwc26hk
 UybD7WGENj8bKUVah/LlKnCpI19HbR93BYlnZmOtiVzsUvfRUUlKlAo7dES68EATBOAScl+SzGS
 0JYateK5Wk3B4G6pidAy6YqoEEv2HMyDA5wEDv+ki7uwvyfPosCM0zfl3zf9qwdIJTYb3vZzHbS
 oQ4vTWx7lO7GWz0kpsJTTCVa7HOc6fvoVsQE+aS0WS19/z1h7wROp6mnZxFl/qJS/d+xXqqEzyh
 B5CFy8WaZddDlVnsjzQLt3COqlB8Lsa3dWgQvl/P3Jr62MG7pwKQ=
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

On Fri, 13 Mar 2026 07:20:11 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
> class'd debugs.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
