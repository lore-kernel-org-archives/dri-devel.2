Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A719BC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAD410EB69;
	Tue, 21 Jul 2026 20:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6t69iPL";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FA410EB44
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:17 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6a31c05e1f7so2762797eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667436; x=1785272236; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T319eudiwbUhIX801T9R3taNsc3hT1nhhg5oWUNGgcw=;
 b=E6t69iPLN7xUEw7TbfBWnZhDASWTJEDUrWdwUgHLTB+E599llz4cJL/9+5WWovtluj
 qiQNmLwl21hgDGYlmda5lNg3ZadujV457VeALjFeBv5t7kuMvRRq2BFxhdzuZuGPkDgp
 +o0g8Cqv2VRKU2sjEbWinwRU8p1wZ3IGi3rtNza0IprWGWahLrmt+aE1aukcrkEYZrgr
 ln0br58F/E/7L+0pQUlZnNrNDrnXwoTJMuiNDwv3+jEuo6eba9VRHTgwpBBKoS+/dLh1
 ZT906V5QO9HUNcANVyj3OtBFXSzhKot8VXdOyYtHH2apdDpr76hrrVpDdqK7DUGi363r
 6Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667436; x=1785272236;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T319eudiwbUhIX801T9R3taNsc3hT1nhhg5oWUNGgcw=;
 b=CTenBm7UZG1kus2N0rqsoAkfyRtz5Bz3PkMRFDbELTtf1zruYIk7g8mDMfjWhpC1nE
 9xRoOcLCBLF7sqgFQSLu9Cx1wcbWK9w/AOmld3+5PGwp5n4SP/aFoZvx8A5fB9dcrGfa
 rBQ7bek/QNkyB6lcFrFnXise+pimEXE43xRg7T+dZlyklER9c1nWIqIlDnfU1gYjHhqR
 5cbtGI+7d3LNnHAvK9fCLhylBTti+UaKWLLkcDFst8Eqh0BPYYtfLLOWrUBfG6H/sO5v
 Emo5mDqXvNef6Cv/dvU7XojxVuLAuVyMFy7QGiRvZoO5FtZJQbYcrDZHqjEveRr0j5F3
 TlGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/LfhErwP2k9cxwGk2De+DBaTFnzoXrm35lj+UEKSljQDHtXFv7v65Fbn2nSgkxDUmwwt1ACYQ0fo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWEYtEkr2KddLOaT+jdaS7kAI9IDUrGvvGZyFHT7U9HVhER/I9
 6iiy6BFMQQnFs7m+iWYiXac15ZUuBbZ0ubVZ2/ltagqjYnnE8t+lfNtO
X-Gm-Gg: AfdE7cnIi9iaYvN3WKeiYMiKdk1K/fxP5aBPo6N2gP3BhlqkpJgOPuGfjSa9RaZVRxz
 woAubJ5FFAC53/agPHTl8kVr5VvJs/F9V7tFCRlzukPcNhjRoQdlkNJIdPW07xQO616wGIXA6pP
 Cd/9p9BrgPCbXbaH1yUfpLbqPCGZcIwtyFgRXixUXQMEGfWnRHZDLumeW1ILfzyGYsxKX/t73iP
 jgJWWQGkJEl0CihnF1ZcUsSAG4ivwN9GPTbYE2gz9NbTdeOInZbaCOcTMwoKtEwscImpXYsoK85
 rF0FuwOHoMB2ng0CHw1cypKTpa3f0znETY2ppF+F9uf+OU3IknYdlKlFuPp0HTCq2yeclomg7Ac
 jt33MOFt5wO7sl7Crz5JrQU4pDvO2Oiq5k5YUHoT25gYIwBi6A29BpO9fuxlOX+eAGtA7iFK/ok
 fkx6cTHo1kh8lac8612lUAedD94XNDANAlxvHTmNeFCKmlhsb+4ty8NAx+AJxYuUe7N3ZSY6OML
 T3l2U9zfKOxfxZLwSpDVrY7vA==
X-Received: by 2002:a05:6820:6ae4:b0:6aa:9be1:4844 with SMTP id
 006d021491bc7-6aa9be14d0bmr55047eaf.5.1784667436247; 
 Tue, 21 Jul 2026 13:57:16 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:53 -0600
Subject: [PATCH v7 04/29] drm: fix config dependent unused variable
 warning.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-4-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1088;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=krCb8u5AazdMsEF9z+e+5QeJqi85jxNa/cGvt6tyuY0=;
 b=4M1ooBzHTgHpKgFhIU2vZ89NHilgFq/cQh/hvWXLai2vEDkjLvu3XSirc+eK0dRZWMohPAFVL
 Zfn8h9XTG/6CWHI77V78nTlSjqAbqe9MSXYq7/3dAJFbL+3xt8Yvtzu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

__drm_printfn_dbg() does
  int category = p->category;
then does:
  if (drm_debug_enabled(category))

When CONFIG_DRM_USE_DYNAMIC_DEBUG=y, that macro doesn't reference the
category arg, because its optimized away, as not needed when dyndbg's
static-key is under the callsite.  Silence the warning by passing
p->category directly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..ac0288dabfc0 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -216,9 +216,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);

-- 
2.55.0

