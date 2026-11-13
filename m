Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA65606A33F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C6410E2FF;
	Fri, 13 Nov 2026 02:21:06 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C388B10E2FF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:21:05 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8b331cad3cfso3981387b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794536464; x=1795141264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uei3X7eaYXoUGpiETn67YwHGgpXCnW4kjNL27gbEkSI=;
 b=y78tMvNYCCp2K+t+EzALlk43T1iN7gaw4odvashcqHc+LZpO+3ph455D0zQH80qCdj
 JKyhdp94806vQGHG6MTOsAeX0E8hjzUSJiaJ6dKHFU8+63xkgdacw37rfzXAlqtUmAsT
 Qx2o3RE1qGbXdVewyusThEV2RmMQaAa0Opuyrv4xAonQN+UYqFgbC1t5yqtjsD825KDo
 RwABaz05ZkkNcvPRLL/XbUAxF5tvVqAmu4WGbeXVl7E8d7lh2HajhSvX7qwvdhBbc6r/
 H5f2jCHO/Vaou34LbERqPu5Cb1LMH/rDyUZNEU78HGo6s59eQGl2FPzb6qiI7ZhbTXWI
 QTJQ==
X-Gm-Message-State: APuU4Z/0NwszB+YYj4k+miWZlmeCWElwwtM4DU6dN5fKlIZU/gnef6di
 rHUqtsXJqflTVR4ilMR04c+KTgzkKqxv+nPTi7toB4md4jAJ9lD2R9HH
X-Gm-Gg: AYBFou3CLdg3zz5D5zuMu8tZ35vts5zrjDRmTXe9YIZcn1BB3dQ2m6x76izZAyUi1en
 DpgjYw365MCDrAx7WIoSDiFR/UMIpdWPPalo3OkJgOf3/1J7t7eRzlTS5v3odgzPU9QMCINaqsu
 K8iU8vo5w66nABd5/G7ir+Z+vOZxmHhmAYr19Vo9TczK3hhbc4nEm6yOe8lJQCbKGnbeT8VJ8Au
 50HAM7ZQkQQjYOi6Eb3CoH577i9UePYKeoXuWt74u1PNiDitL+q8YLG5yQbze9MvZSO9TuEx5GS
 DyrOOi5QEVXUr6U+NzjAO5buhH1KH1w630AkzbNa2E7dSOtdqKTeH/14sc9gYd26WeY5xnK5C/A
 ykrshRNyqQIQd4QqxpG8vBAGYwxhq0bUHELobDSidpQxf2lodKSapfDne3d33Oiv+TLKKCR1k+E
 0S+AoUHi5b61ltAPMzcwdb6mhkJNJ7mjh4vcitT7sO1xwqrggRPrt3Y7SnIJRaPjq03OfdLZnQo
 nQlYFcSYGlNKMCEknGcgCvfNQV3LJix++Ytc8r7v7/5FptV5A2JY9t5SWNjeDlWuvEQVQ/Q7Rq4
 2EOF0SXxw47kIybuhQ2sLpeyInRZ4Y8RCgnJMFC2IhrvsPTet/yiWhFTUvgtzzYKJ/cdR/Vrli+
 U8krVMhFVsrn7HGuUsdhYlRKD0cTa3aqC
X-Received: by 2002:a05:690e:168d:b0:67b:ffed:e1c9 with SMTP id
 956f58d0204a3-67d896a37b2mr912238d50.37.1794536464486; 
 Thu, 12 Nov 2026 18:21:04 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67d8a4339c3sm890660d50.3.2026.11.12.18.21.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 18:21:04 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: operatingsystemsdepression@gmail.com
Cc: dri-devel@lists.freedesktop.org, patrik.r.jakobsson@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alessio.belle@imgtec.com,
 luigi.santivetti@imgtec.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, imagination@lists.freedesktop.org,
 frank.binns@imgtec.com, matthew.brost@intel.com, dakr@kernel.org,
 phasta@kernel.org, sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joseph Telaak <joseph@telaak.dev>
Subject: Re: [PATCH RFC 02/13] drm/gma500: Publish the Cedarview SGX as an
 auxiliary device
Date: Thu, 12 Nov 2026 21:20:41 -0500
Message-ID: <20261113022041.74295-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAFGNeagBWpdG7a9A-c6WRiPsd4oPXcWai9o=xnkZDyY+axcniw@mail.gmail.com>
References: <CAFGNeagBWpdG7a9A-c6WRiPsd4oPXcWai9o=xnkZDyY+axcniw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:08 PM Gabriel Gama wrote:
> Hi Joseph, I noticed that gma_sgx_set_irq_handler() updates sgx_data
> before publishing the new handler pointer.
> During unregister, could an in-flight IRQ still be using the previous
> handler while sgx_data is being changed?
> Would it make sense to clear the handler first, call
> synchronize_irq(), and only then clear sgx_data?

Yes, good catch. On unregister the data was cleared before the handler,
so a handler already running on another CPU could see NULL. For v2 it
does what you describe: the handler is cleared first, then
synchronize_irq(), and only then sgx_data. On register, sgx_data is set
before the handler is published, with a release/acquire pair against
the IRQ handler.

> Otherwise, the auxiliary-device approach looks interesting, especially
> for keeping the display and render responsibilities separate

Thanks, that was the main reason for it: gma500 keeps the display, and
the GPU driver doesn't need to know anything about it. The same SGX
cores sit next to quite different display hardware (gma500 on
Cedarview, simpledrm on the CE5300, omapdrm on OMAP3), so keeping the
render driver independent of the display side lets one driver cover
all of them.

Joseph
