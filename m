Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF1AC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353D110F9AD;
	Fri,  4 Sep 2026 14:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOwa0Gl3";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A8D10F9AD
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:59:58 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-499db1740f0so451735e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788530397; x=1789135197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pL5oIYV7zk9vcM9H1fRzBKbJl+oOE//iZp70tDsfKtQ=;
 b=IOwa0Gl34pGcYjQwjqninB+ubQPl7e55FBGj+y9HIKOxrJ61nWDG70i5xBxihFXZ5x
 f0Cz6w0ZhoUMGIC287G/7G//U688XFVEIHm2t8+4AV2nUwVUG8Qln2ziVwBRGtbbfVDL
 UUwpY02cGov+rbfPlEYR8VDOFksjBKotKP2VsWu7LOB9MvFE1aPBCC0bEqYj3Ea8drnU
 K8e0QJmSrynA/wzjED74Bge8I+ZtEvSeK+VOQ5M9BCoa8iRG62PEy/yhQySuNP8d2kkm
 cZbOBI0yZWNy3G/jjtZqdAGnkIWsW8OWIEt4ajiwajr0XTzueUutwEcR3J2d1SzeBJiz
 3VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788530397; x=1789135197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pL5oIYV7zk9vcM9H1fRzBKbJl+oOE//iZp70tDsfKtQ=;
 b=LdwrNAmD6iq7oqHIFzYv0UWiV/Y4J8v/mRXrlHgMuMIYlTGAQijOfI5GBXA4rsvp/E
 57gzrXTVTXZYz0wZ2EM0V7ttliwS8WrmCJGvT/rpXiKVz/mCOtyytQZkXJro/EhYuG0Y
 AyGm/2FSiVfvYi8tw5wqFDN+ssbdB7Zf71ES/Bu7zSZ20bnUqXee1cuo/8kVZDEqBswl
 s33YHXvSnwsK9kuMzTIsRBJSlPVi6phU0VGI4YNjS473XO14399FyEYA7xLYl4Wy/gtm
 o8ah1hgJ0XY4Q9obvRp2qRQQQtp5HO2DOH4Gnl+of/Ec7DGMhEej5LVPfnfTXlgkcZon
 woNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9/+9ZW+dsuTNQzmfL+7qiaXk6MjVpxbbLhbLOeNtblT3UcGGU5OUexQw9Y5Qtw/dG7KyeF1uO3Bs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbBBwezbHCsraSwX95dnL9VCkZQiq3+rb/xtMNAVe659KsqCDx
 ZZ8C8OeJ3ho48dufHSFOWv64OLdA2zWKx/X4RAZH465y5I8wF4VIVocA
X-Gm-Gg: AYBFou1ddPLtE8AXtQlEXWo07MjeyVCh5AedX9w6wQpZ4vsjhlVil2hsiQn1TooFAXK
 64wblqiWWZTN9dZQ6bL8A10VRhtC0Dt8MjGZHMzjdRJJlPGS78NDyNMvK0kWDB2n+kLmlb3zuud
 jYXnph16gAYfX7TS+fs3/1Xgrsepbs3ERXrondGE+s0PUrgSbGvbZ3Za/+cfBxasZH/0lQiCGLj
 X5VpyEM/dg186h0N+bj45yroTzrQMaPwTGLD8l93/N48qSJgLf6wWGw3nxMm0VBR/ruYFI/btre
 kAULol+2dISh+4nOdr6nkIktlfP/TQTQIXuUyDdiQFf5D9SztAgrFAon9PteOcjL/uzxpASsmd/
 zMr5YCUdSkdOUSihjCenwEG6Yp6Ge8ThRSjqEf53/xlmk7PMfjRidfQC6+ApjGBmbaKJpo9NeH6
 o4S4F/hrQriO+l1/eUp5falDMOdmos5CJ3iUjcRhXQE2bkl5Bel2bexxs+5nEIJWooQ28rav4AW
 qVJxGaxcabzsGneNfxPNbSfe/t9uHOPgzbkI1Y9cBda7SSwpOSQO8NBaqWTKsyUV1nSJ/Oq3PcL
 1KHhiA==
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id
 5b1f17b1804b1-49cf823c012mr44419095e9.1.1788530396364; 
 Fri, 04 Sep 2026 06:59:56 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500455C8730D6A15F49.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:455c:8730:d6a1:5f49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm70619115e9.6.2026.09.04.06.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:59:55 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>,
 Guangshuo Li <lgs201920130244@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
Date: Fri,  4 Sep 2026 15:59:36 +0200
Message-ID: <20260904135938.8757-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904125936.26234-1-royalnet026@gmail.com>
References: <20260904125936.26234-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Answering the one question that is about this patch rather than about the
state it leaves behind, and confirming the rest.

> Because rocket_remove() doesn't clear the dev pointer or compact the
> array, wouldn't subsequent out-of-order unbinds match stale pointers
> since find_core_for_dev() now searches up to max_cores?

There are three callers: rocket_remove() and the two runtime PM callbacks.
The driver core calls remove once per device, and the PM callbacks cannot
run for an unbound one, because rocket_core_fini() has already called
pm_runtime_disable() on it. The slots the widened search adds are either
never filled, where .dev is NULL and matches nothing, or held by a device
that has been unbound - and nothing asks after such a device again.

What the narrower search did do was lose live cores. Unbind the core in
slot 0 of three: num_cores drops to two, so find_core_for_dev() stops
before slot 2. The core sitting there is still bound and still running,
but its own runtime suspend and resume callbacks start returning -ENODEV.
Searching every allocated slot fixes that as well.

An earlier version of this patch did clear .dev on removal and take a free
slot on probe. I dropped both. Clearing .dev turns rocket_open()'s
unconditional cores[0] into a NULL dereference whenever the core in slot 0
is unbound while its siblings stay bound, which is a worse failure than
the one it cures - and it is the same rocket_open() issue listed further
down. That is why the commit message says out-of-order unbind wants more
thought than a fix should carry, rather than quietly half-fixing it.

On the rest: all eight are pre-existing and I agree with all eight. Two of
them have names already.

The ERR_PTR left in the file-scoped rdev is fixed by Guangshuo Li's
"accel/rocket: clear rdev on device init failure", posted in July and
still unapplied:

  https://lore.kernel.org/dri-devel/20260708062845.716487-1-lgs201920130244@gmail.com/

It carries my Reviewed-by. It would be good to see that one land.

The devm point may explain something I measured this week and could not
account for. Unbinding and rebinding all three cores walks the DRM minor
upwards - 1 through 10 over ten rounds in one run - and only a module
reload puts it back to 0. I have not shown that the allocations are
leaked, only that something survives a rebind that should not, which is
consistent with what you describe.

Igor
