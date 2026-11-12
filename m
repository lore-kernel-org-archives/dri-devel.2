Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA87606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96791122DC;
	Thu, 12 Nov 2026 21:20:56 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F8F10EBC2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:20:44 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8b349d21fd1so2745757b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518444; x=1795123244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rP/94ULdOIDzMfyx/NDut6OK2G7JW3VujvazPMQufoE=;
 b=aLiQcFOwJ2zsVTJjXOxc+rGES2PSXZ9cQGj3r44GQJfeFngzWgJ6xI8bxZTjSEHB6C
 O7DwsphfFeRqbIO46o51DucUg72fRjUMZ7iKL3Zt1Qsm108VDUsFFMyyFvxgxkx0h123
 BMlvPqfHhMch4n6pZ9D/6ozc/xqz5MDNBqLIXIM8cH+URC8mdfO6CWoEHaCR3gQystVC
 XZ+MTUHgVdMQrbftzbK5X1Iox3M3we82rXsq9LIWbK2NF+wdNhcpctIBA03DedAlhGsW
 XLRPziAY+hrIAKLIyaCgbFvxay8dkv7fG5Pd/KzCMgWgORTfZnxEnnnFe0Uqr30y2l/A
 zDxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFEHT3PUjL7iYyzded7qp/BUYFCsWMHrhZjMx6xCAD7AoO0w5RdJgXWSM/UhJqm/2Pgzvf0xtBlxn4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TZ3WW80B4LBUnSd/ViGowDmLHW4B55ZFAuNAPIp6DU/ZztW/v
 Gtuw5dng36WLBYYNPh5B6jJaXMCEVjsg+RUXNKeeDJaLwHZQthdRTYyE
X-Gm-Gg: AYBFou3Q22oQZBBgqRwHO0EyT4PiKDrYAZc7ngrDvOOvxUVJtum+kqo5rTGkwJQyj9O
 sD0f2JOAWrLcT9nPe3sNWx3K4SBFHDxBrCNzpp+9kcmXXTg99e8Jk/g/de1GKGyVfrDqHQlMi4s
 pL6Ysf5fN8Nd+q3D6hReTnpqSjyGcV0+WHd/z+l2jH1DB2G4hZXHnaefc8tKlgMsRO6/qPPsalf
 6SlJtqOHV69lN6f98SGEejC+rDSJm1mvAnng2gqXYXvXxHFHaS7Z1Wpl4l/3LMH/A/QHp1KUkbH
 jKNoSi9cr3Skq+uuwREocc87y5El9vZR66BcyGLbAXZw/iyRun1JBVbjzhdWmcT7FcLUBeuMvDb
 K+epFPUCZ7Vr5brtyQ5rN0q1TsNdEzQFqP56P4Vi685kqw1zWdiqiTld+2M11eNVn1+mmudvidz
 DZ+jdQHSZ2RO+Lk0RfEfJfoW5BmriqmXXqqbEHQf/yaIM9AEZIo8tQ7pSeo8BGtJ253MhH8/hLy
 f+f+VjzF0XIn/mxMie1TBBYq6pIDWL+ApH3P2zNuyA/6rWNJfZi+OS3jHlZoDiCLu7aiCIEyDJo
 vVcyX7ylUtv5r2iFKvE04hKemSN/KG9FNMecVP4Gt6DrKj3cjkg7qtZFUrxzUaGNHIoS4S7gN0G
 R/BwhTXoaIV5q4QhN9y3kovW2R0/YqfXSEOYkwoWs0il9YCn90bTG
X-Received: by 2002:a05:690c:450e:b0:8b3:2eb4:1423 with SMTP id
 00721157ae682-8b4aa2a8492mr4482577b3.25.1794518443835; 
 Thu, 12 Nov 2026 13:20:43 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa67085bsm6051947b3.0.2026.11.12.13.20.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 13:20:43 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 4/6] drm/gma500: Make SGX MMU insertion checked and
 transactional
Date: Thu, 12 Nov 2026 16:20:31 -0500
Message-ID: <20261112212032.10576-3-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109063303.32658-5-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-5-operatingsystemsdepression@gmail.com>
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

On Mon, Nov 09, 2026 at 03:33:01AM -0300, Gabriel Gama wrote:
> Use 64-bit exclusive endpoints so mapping the last GPU page does not wrap
> on i386. Zero-page requests remain no-ops.

They weren't no-ops before. The inner do/while ran once, so a zero-page
insert or remove touched one PTE. They become no-ops with this patch.

This does a lot in one patch: u64 endpoints, validation, the remove-hole
fix, collision and rollback, and the semaphore change. Could you split
it? The hole fix is reachable at unload: psb_driver_unload() removes
mmu_gatt_start (0xe0000000) for vram_stolen_size, while load maps the
stolen range at gatt_start, so unless the GATT BAR sits at 0xe0000000
the removed range was never mapped. That part could take the Fixes tag
the bot suggested.
