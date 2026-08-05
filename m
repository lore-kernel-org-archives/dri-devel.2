Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D7C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1410010E221;
	Wed,  5 Aug 2026 12:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kFDi2Dml";
	dkim-atps=neutral
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE0610E221
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:52:17 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso7567655e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785934336; x=1786539136;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z/NPkdzGeUxE+XJKwXBdnkTjo09nqeSRkWLmgkx7m2E=;
 b=kFDi2DmlhO3gdgN1NGxDIiluvhrdxgnXvOJTvyPcq5BM35Qn7KS9K12+0NWsbRTBuM
 wpkUWbHig7rD7KLDWWy38f1uVjS6ZJHFxazlFvCDJQ/qWj7wvsl+uZ8yqQ7Kcy/7YtMu
 ky+bpGyd379TSPB8FnlJnVJo5e9VzG+aRpfcoEjtzkN8LirjLRnzATCxZsgEP7ksYaaJ
 O6YIyEq7ySbaRPap1vHJ5bNKNU2V8GtUsLvIeZyg6MnlVhzodK8M4Gm4K3XSCpFl3zUT
 UUZfTqyK4re3blk4Q+Xl6Dfe7LPngSxaHALCQLB/hesAy4z9B5FNCbVDsXHdgfOBtm+5
 PcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785934336; x=1786539136;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z/NPkdzGeUxE+XJKwXBdnkTjo09nqeSRkWLmgkx7m2E=;
 b=GgM9GLANF9ZMqi6V7Q+TXy+VDX654ydH4ZM5qi82736t68Tv5dIharm70JAg3fWRWa
 9xyTJR9eqaum8lP7OEkiXF1sLtVuadG5hCybObTYmZW2iL9VGbgmfy5XnyKYl4gKWxf3
 bNMkeHFkjmMDD6xi0cKLLSEiJu+/uWfwvdFl3Qez4pwycAWq7RKhtK6GetjxGPjHgk6q
 ISXJpJmb9h2xw5RcvskUcN6iDNXC1cMNZB/dKObWBIDf8R/Y8nWXGgY8HETvdVy/P+H5
 kEsDLbLzccly0uzs/9Tv8JbWdvyRE74HfZ9VhigJ9svIu/2RjB6Gi7z52sBPeQ05A4nO
 Q1iA==
X-Forwarded-Encrypted: i=1;
 AHgh+RojrAfdxHOZZvXzUFJ+HJQFjQz+yOWCyYaKb4gXSst0L4dSZTJgA589+gh/FpNgJx+eKTBoAlwwRdA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfNoW1an/EFwUJbIYZZYR2XhLx3Fy+W11ad3LCXXeggPf5Kq5M
 CWC6RN+Ygge3M6k10Bl2dJ930qFgjLRMxhNLawnwq6dc1AV7vv80zaMUATDJkPqMqS6L98jOvpG
 y+Q==
X-Received: from wmoq8.prod.google.com ([2002:a05:600c:46c8:b0:496:bd16:f52f])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5694:b0:495:503f:cf9a
 with SMTP id 5b1f17b1804b1-4994e7bab0emr55081065e9.9.1785934336069; Wed, 05
 Aug 2026 05:52:16 -0700 (PDT)
Date: Wed,  5 Aug 2026 14:51:59 +0200
In-Reply-To: <20260728143858.1498697-2-pimyn@google.com>
Mime-Version: 1.0
References: <20260728143858.1498697-2-pimyn@google.com>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805125159.2600321-1-pimyn@google.com>
Subject: Re: [PATCH] [PATCH] drm/vkms: Advertise PREMULTI blend mode
From: Pimyn Girgis <pimyn@google.com>
To: pimyn@google.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org, 
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com, 
 melissa.srw@gmail.com, michail.tatas@gmail.com, mripard@kernel.org, 
 simona@ffwll.ch, tzimmermann@suse.de, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Cc+ Dave Airlie <airlied@redhat.com>

> Now that Louis has reviewed and approved this fix, could someone please
> pick it up for the appropriate branch for linux-next?
> 
> This bug is currently breaking one of our syzbot managers, so getting
> it merged there would help unblock our fuzzing.

FTR, The manager has now been broken for over two weeks. Another one is
currently running a 3-week-old kernel. We'd really appreciate getting
this change merged.

Thanks,
Pimyn
