Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96843C79FAD
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E820B10EB6B;
	Tue,  8 Sep 2026 11:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M/S5KLcF";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8725B10EB6B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788867723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrNJtw6g290ODPNBtFlQPVdYDxDOj1rXvh8h+/vQvhk=;
 b=M/S5KLcFgMhfhZhOsB3t9TILoJn+aaiTXr4VfHD2g8ekOf+lR+vjcJLkWh0RLfc8Ei/XeW
 zshYvJociPAL6utr0iNoXQ8JkDYoTnpZiUZnfTZPyiAw/BbhvN7D3wAYSOiXf+wjS7rLjn
 9VdemQpmZBX093Jk8EIgk1lSQkA/0/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-owQYkfPyMmyXBauIcdfHQQ-1; Tue, 08 Sep 2026 07:42:02 -0400
X-MC-Unique: owQYkfPyMmyXBauIcdfHQQ-1
X-Mimecast-MFC-AGG-ID: owQYkfPyMmyXBauIcdfHQQ_1788867721
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49ccb223bceso26533105e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 04:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867721; x=1789472521;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RrNJtw6g290ODPNBtFlQPVdYDxDOj1rXvh8h+/vQvhk=;
 b=qj+wbtFy3Yiollfj+1TAcabU5VAUO6QJGIzJbXBFC4+zeqIIVPEzIESbho9qNkTDwR
 dxG4cI1k1S0GbW45/215wCWrQSQSM0oqjm0JoS3ySktt++Sdow3jeTVoRJT3tFVrd94D
 9y87lFfzOOWXw0xzLTBW2EPVVOEj/5lvEX9jYMoaP+BKckmkO+lf65pjhbXzhRt+9RJD
 GhSlAdUGsdTbdJAQatXODp45cK2AtvdaaVOD2gcCS8T90GNiO9McaNSZH5MxFTIaAh08
 DS6M6gjO7bLE5TdyVArfKj5OnWamrlMGGk3Z7vFi5GmqPpQOhiefnD0s6/8SB/rngUbv
 Oi9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGrDlgom+NhLyqRhofawib523P0waxDJIPVnHOzXWt60vrWGmL9lnmKqOvKWyjhPKeZNCw2R/i3gw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9bGC+HFFLcSl6Ga+C/QYNi3/KUN7CEWkJsW84+Z967aaOk9Vp
 wVIg8Aa4cfIYjYFXnCS2X7k2ajHkCAMJieUojA4rIHXAUF1ZKjwQtbVjc9DyYIW8yX9NJsj/gm+
 6uXXBcthVvFSUAUKSKqkgYOovjhnX1UHBI/y92ohW6LJ9rH1O9Xul7PPbmNUHqcpg3MzQcA==
X-Gm-Gg: AYBFou37ChPwkCtPOkB7V92LXPDf9iiejiH32lNH5YddJGQle8+ZdnZFN9+499p9mMn
 DTElYpjULPzIzOK+NR9ECqvhZZznMZ6eoVb+Pwj4iwKNHnclkjso1X7dkHu5En5rC9De1iers6w
 TsSoqL5qy/oI+U2qjDtjJwsRQ4e5+S+BlFazw1B274PtBKSXGqU/xemllWXN7HOvIHM1kzxRUzB
 MW2FZq2TUDFJHzWCfVsC6YiluR7mbSoOeGKasgdFc/zbXt0vNb/VneKiWOiuXOdHzHGD2DQQDMH
 OpfqP+h8tjfpdFwVYhDwlMJIjBUXe6WjHYfYjnNVvKgLO5dulDqaZGE4OcYWR30aKxmiz4F4ogw
 Jw2wdj/3YDrlV8N9cxQFb/SiEjLg08NqW/izV5UGCSUCdYfQHBCTIRy29SA==
X-Received: by 2002:a05:600c:4752:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49d175439dbmr67723935e9.1.1788867720850; 
 Tue, 08 Sep 2026 04:42:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49d175439dbmr67723525e9.1.1788867720384; 
 Tue, 08 Sep 2026 04:42:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm296441395e9.13.2026.09.08.04.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 04:41:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Piparo <holofermes@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Amit Barzilai
 <amit.barzilai22@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fabio Piparo <holofermes@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
In-Reply-To: <20260817152500.703770-1-holofermes@gmail.com>
References: <20260817152500.703770-1-holofermes@gmail.com>
Date: Tue, 08 Sep 2026 13:41:58 +0200
Message-ID: <87h5k0dl6h.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jGb5TB6msO2lrRp9yNLClzPVbuUNj7lPRdMEoR3eXHk_1788867721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Fabio Piparo <holofermes@gmail.com> writes:

Hello Fabio,

Sorry for the delay. I was on vacation for a few weeks and I'm just
catching up on email.

> ssd132x_clear_screen() sends its zeroes without setting the column and
> row ranges first, so they land in whatever window the last
> ssd132x_update_rect() left programmed. A partial final update then
> leaves the rest of the screen uncleared, with fbcon the last damage is
> typically the cursor cell, so blanking keeps the console content on
> the panel.
>
> Set the full-screen window first, as ssd130x_clear_screen() already
> does.
>

All this makes a lot of sense to me.

> Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
> Assisted-by: LLM

I was going to mention that this isn't the convention documented in
https://docs.kernel.org/process/coding-assistants.html#attribution,
but I just noticed that there is a recent commit 816d9992d9ed
("coding-assistants: simplify attribution").

So your tag is correct and I learned today that "AGENT_NAME:MODEL_VERSION"
got deprecated.

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Piparo <holofermes@gmail.com>
> ---
> Exercised on an SPI SSD1322 under local enablement patches for that
> chip; compile-tested only on the SSD1325/1327. ssd133x_clear_screen()
> has the same problem, left alone here for lack of hardware.
>
>  drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I'll push to drm-misc (drm-misc-fixes). Thanks for fixing this issue!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

