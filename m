Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5013ACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942CF1122CD;
	Thu, 15 Oct 2026 10:49:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778EF1122CC
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YcmYNt/gMhxdaIj/6PLYTkAXyAHJ490Awmdvej+Tuqw=;
 b=bJbMyBdco4sJzLZmKZYFwgFn3tnBKp0x9aZZMNlbt5rdaYVTYnxjSOSNEaA0Wuq3HbE76N
 G1K9pH1kB5GOfttGgtdqlOZOTQsTVl11K/Hk3X9y5JhndGvJ9NLYgawK3eMe8sIjeoy5cT
 e/PUrQyq0PpdqX47AaOeRtkIUwvHMrY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-RjcriPa1NTK1OMAV6PtMng-1; Thu, 15 Oct 2026 10:49:50 +0000
X-MC-Unique: RjcriPa1NTK1OMAV6PtMng-1
X-Mimecast-MFC-AGG-ID: RjcriPa1NTK1OMAV6PtMng_1792061389
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2929165f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061389; x=1792666189;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YcmYNt/gMhxdaIj/6PLYTkAXyAHJ490Awmdvej+Tuqw=;
 b=CLDLddUeB0mdcQTrXgnUu9L5CdzTVTjGg39asiGGY/5GZyuRP2+y906bmqFxe8cK/b
 fnkse0gAtTyDru4i7QgyQi5KjVgUk/DLNELutLShpTWuNCRhpzvdnd4JBTy1M9wUqDt1
 7lxR4SQMQERoyV4QuDrZUbAicGUC6/wliJRfx1Q5iTs98L3let2rluRTiMPewmcYEIaY
 Ipm0OK4cBA0gEnH5+K8zPIMkibGNU0n0alhVC7oGEUW0WF71dLRAa9uJAW0zTYn89jps
 9rD6uTZskhbJNkIqNsgiTtFdIi5SO+EnZxua7YKU6R8+k1ZMh4Sz/fAZ6w43BStWcRF6
 SGgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGnJAjk0fsCn77gcvD5eAz5OYtTR9g7ZgPYTXvv8HYv9vktkQpoY+NBrPQ4Gpp50yI9zWq4ZS0Pug=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjdvcbWNXVyt0mXw/ynWiJg28h8XkDFwoL9vvbvEpoAbLRQ24v
 tF/3OAGCD2nfnGq4vN78ogp3BuuRhnF3OaFPY1RaLtto6ByeHlkLGZutBzxrbSBYhFifRBo7LVX
 tCRP1Ntb9uexKVKfuEGEt8ACHqhqPMJXeboesax9bQJSVpCYPB27dI9ZLCCTnqSC8CudZTA==
X-Gm-Gg: AYBFou0EQsu1X84n1/3rxq4DFM8sx7oesvBINqwDJ5LULmD9kYKeQvs4+LgHlz52CIU
 Kc2b4VDB940Ara9MjBHGhXz5k80T47AStmb2ybULP+sK3/0AWKUYhBRVqkd7FmXy3uE6/qQXdWf
 cjZWCYnQC1F9pWmVUbFa8eRuxjIfIbqIINsl1Fm+eX/NkdaKH5JhnASOj1VhU05grAsAqYe2IXF
 PGzitvXxXBZoIuXSZfztfM5aOsFg05vuFHAJ9EXpDEMVPrOm5ACasa7HghSJ2MWJI+eOGjnWRCS
 HgXxW4hQG/8xAx4kJaVs3GR/Ki9oCqtZBkRRows6VPekF2bAAwbaiknQ0o/ju2ZjOggBCWB2E7f
 b8A6RiQY2iNknkxiVutLi0lT+xg3xSRDMR7/OI6RD2hOUyo8+JpkyhkbT1UI/2yLomQ==
X-Received: by 2002:adf:e185:0:b0:48d:f56d:be56 with SMTP id
 ffacd0b85a97d-48df56dc2c4mr3636398f8f.13.1792061388876; 
 Thu, 15 Oct 2026 03:49:48 -0700 (PDT)
X-Received: by 2002:adf:e185:0:b0:48d:f56d:be56 with SMTP id
 ffacd0b85a97d-48df56dc2c4mr3636319f8f.13.1792061388254; 
 Thu, 15 Oct 2026 03:49:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48deeadc0b5sm8405153f8f.6.2026.10.15.03.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:49:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Phong LE <ple@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Julien
 Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 3/3] drm/bridge: ite-it66121: make successful probe quiet
In-Reply-To: <xlv1se27fddc.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-3-7fd6994e0be0@bootlin.com>
 <xlv1se27fddc.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Date: Thu, 15 Oct 2026 12:49:46 +0200
Message-ID: <xlv1pkxbfdbp.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4DzmR7O-M58gDbF6SjsbHNAjUGQiYwitCMQ34-WWcqY_1792061389
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Luca Ceresoli <luca.ceresoli@bootlin.com> writes:
>
>> When drivers are working properly they should be quiet. Turn the dev_info()
>> into a dev_dbg(). While there, also make it more informative.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---

Ups, forgot to add:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

