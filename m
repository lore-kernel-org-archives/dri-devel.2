Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F0606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=M2GPKORH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6845210E46E;
	Tue, 17 Nov 2026 05:14:25 +0000 (UTC)
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EE810E46E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:14:19 +0000 (UTC)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-99e156fe905so339957241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794892458; x=1795497258;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=mj1aDMHc3GE0wU1DsIP1PfaexidA2lCD5GrsR7T4k++DQ8Ck+ABNFkJq54pCK0LPAk
 R/LjlNlBrlJE+wxkXWgQ1JAru4KU/gAvKBPEjbLQo64PAF5FPPJBg08cWC1y26y1Tk+X
 GIk0A0zkVZAeEy0q9xMhHWPyluGNpD5xl9Dd4LG2p4Ynvs5y3jzrFJuclSLrFzy8VdnS
 oXDGpkbOBKfGMyXJR4OWrgLIEit0beezNAAjSrT+1KwDaYi626gJj/naoQtPjOK697E+
 W2onYZFWshAjq1E+9shH5DntWOpzyz56LKbnLWx5zE4KLICHT8rYAkGT8cWhHvT+CD2c
 AxBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFw6iphQleua5TWFZ7bSdzTmR80iXHWDyUCuXYUKClnrzbR6rI0O9utDSz4uKtAkhyhLrt4nuPhptw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+a6ErRpNb43wvklMlfLbyfrH0vJKhawwPwSMByPG2wF4zD35zn
 I8+/sr87BnWrg1qR3th9xZo9VL9+x8gFE8p6/bLbp998NiD2AruGf68g6/YKGttZeNM4Sjym/fe
 GOd4jxtR5exYXl5HEdzfseBPAzeGM0lOxnEaqTtptgXZUbz0feiYdCxZ4k95RyhGGFaGonHUwJk
 fv56dr3m+PMpbbwxPEhlmJMoDwJnNH2Sk90PKB9KIurWmgjsCCbOxkzJQlgw62sWKdn2qcgb6k0
 OqUo37GDgC7uUGGfNwy
X-Gm-Gg: AYBFou1YE7OvJr0VybRa0WtnzcdZDpoyDcfHOfPdnDmmQ9i8tkHrRf6vEuFNe0rWq5g
 o2xgd4H5s5njEKXZugsrHr436yYcbvXj0UG2oxY1PROcV9EGCefBdyud/H5dxjdR75omzv9Jzl4
 Pg93xT7MYXhLMys6ax5EgdBNlxmdKeqGQnAen8g5qRnV2zlBGsQMML1GuKSIDrqN/RNLBcpOLV5
 e0JL+S9SFc3OFgzohvUKjABTR12BBum7T/500AbTy7gjOBZSZ9baIUfsdAK7KiPthaPjJX6xn4e
 GCLmcNgILjwDgUTZAzLxbIsgX7NETfgpdr67CgmZT+Afl7GNKpZzpAUp3gh0Fbp/U0ZW7ox5FtK
 9I/VMKDhPmV9GTXtXcrsL63j0+J9JDPWI3oAKqfA/BLpJ+MG0NxRTRZQ/nGDzwcQKfYMKF1AU1K
 sMjyW5sFUyNo4gzup1fRpWbUPO1ZCANi9P
X-Received: by 2002:a05:6102:54ab:b0:7d2:d876:fb3c with SMTP id
 ada2fe7eead31-7d69f8593fdmr418756137.35.1794892457548; 
 Mon, 16 Nov 2026 21:14:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-99e335cf5e0sm228689241.1.2026.11.16.21.14.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 21:14:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aed37745bcso480131a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794892456; x=1795497256;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=M2GPKORHbTwjF/c5CmGQqGGoMc29nVpxtz+niTx0F+8dVWuUuhrEARj/f8sS4xMDOP
 FomI/MNTSDsvxUylnemXr+4UPwhZeqiGUMPBuFjKwTbS82apOgae+XelUYdVIfAPBPcm
 c/1gF5dW4caX1HDJyQeQGPo6lrbvent07FoLs=
X-Forwarded-Encrypted: i=1;
 AL+hErGZCIBzz+lP9NUsYuiJLta0gtGkAafHGaCsqv0nXAnZzskwzSZVLDzWBJ/tOFDIxrKyNCoSoPmecNI=@lists.freedesktop.org
X-Received: by 2002:a17:90b:48cd:b0:3a0:e568:ed63 with SMTP id
 98e67ed59e1d1-3b3abaf90ffmr845995a91.8.1794892456179; 
 Mon, 16 Nov 2026 21:14:16 -0800 (PST)
X-Received: by 2002:a17:90b:48cd:b0:3a0:e568:ed63 with SMTP id
 98e67ed59e1d1-3b3abaf90ffmr845973a91.8.1794892455435; 
 Mon, 16 Nov 2026 21:14:15 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ab9f3c5dsm2158002a91.0.2026.11.16.21.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 21:14:14 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Vladimir Popov <popov.nkv@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Deepak Rawat <drawat@vmware.com>, Sinclair Yeh <syeh@vmware.com>,
 Thomas Hellstrom <thellstrom@vmware.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 15901/15901] drm/vmwgfx: fix NULL pointer dereference in
 vmw_validation_bo_fence()
Date: Tue, 17 Nov 2026 00:14:10 -0500
Message-ID: <179487959552.2515856.5690215138822621209@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414105529.9883-1-popov.nkv@gmail.com>
References: <20260414105529.9883-1-popov.nkv@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. Applied to drm-misc-fixes.

z
