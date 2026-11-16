Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AE606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cwMONJbl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691FA10F46D;
	Mon, 16 Nov 2026 21:40:22 +0000 (UTC)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD5B10E466
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:40:08 +0000 (UTC)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cd69954c755so3322401a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865208; x=1795470008;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w7gJaq0U2XA1qzZik/lkoh6ncUAk4PKRnqK8WDeKiB8=;
 b=pv67EMiKHEPwwQ54qmIcDWct+Zj9v6VOpX8/1AYWXKRW/xXJ7Hg6wzV+CEJnEb+GwY
 aXsVL1PsRid1bHNyCDyUt2Ozf49NVHMnKFpTj8d7fOJ2anELu3erMe2IbVi2jkLgzbLO
 JBWUqU+wqOaVaATYxgv+wMonzbA125uaBOsxk990VgppLtgXaGlF9UKyWPOs0dEwMtMR
 eQvakhXbW9m5L31a9LJtCN04gAMCs3f9gjV00v0uXYAH33t++1AmDXqYc0iXY0L595AU
 ZagzCq+gAS6YY6EGT8ucPyoJ/g5WXnr27hsCi6YJNbCeotu/E/C9+twuuvSCgEAO72/4
 3pvA==
X-Forwarded-Encrypted: i=1;
 AL+hErE0aToi7SZvpcbZbQvJGsVTo0HQLAnqX8wxYrR0DfgIHPsNZCiaiRRXBZxznW/ke5VnytlFJOLuKMU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/MHfDi7HrgGyQqXMox3WUrhqVAjFUhfZH7+9VFf7DCJ1A6oFFz
 sPeITFBqa33vl+UElpLcVrmUC53VlHcvtEC0TTo5P/rueoZsrzzPnU7RnJ/TEnYFXbeEsDTHfXx
 VHFnNSqVAWAdyvyP4QohOuM8GiTl/oUNncAtVASQJbVtUz6ifyXy5YPTzSYo4zb4r26TstQ0qgy
 TM9b1TukDliHp/8ZGaDtBBYc4srMoMiOLGlFc1KryOe2dqk0a7lhPMgL500PJWmxGLu6idgPpUP
 ikbOTA0Jy67zR20JmGL
X-Gm-Gg: AZFdTZd45FYQI37UI1CWAb+Ym0fxm0Q0ZyrB8mF3l7mB64VH/0T8uc1EK6oBOmLj3Ct
 GeKR5QYk9b7WL+/MNHEdP4nMH+qMupdb7sFXl/yVG4OTjkVr0vG+jza6k83YTMn/XDNLUoFw1er
 Br0QR8+T2qqaYnYGDruWL4moMBQLeC1fxhexohmssjLowXbHvpMBxWBNJuWcg8Ho9kLwJiPP5Zh
 tqMArs2/yGlOp+FvW+POyB86PnG///5GUF3N6RhR8QZ60TD6QkJV6lo6CNmW4WM//PuuCgCVM5X
 O0zarC4sST+6HT7vbY1C08qg9OMpnbl3Piqz0PjQv1LuZROIm+xavxN4LvrAcqWNL+McDtudgDI
 Du4fwerHJgvKKSmsca871msyfjFFnKYxIqm5its4dLnqaF5f25i/Y653ra7vfXMAi4kESXVwXFz
 0ZVHi+cheJgaBM2GFSVyAJpRZgyK0xc1eR
X-Received: by 2002:a17:90a:c88b:b0:3ac:9c37:9430 with SMTP id
 98e67ed59e1d1-3b1b09e6a07mr11806617a91.21.1794865208309; 
 Mon, 16 Nov 2026 13:40:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1c3e09606sm3735319a91.3.2026.11.16.13.40.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:40:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so6055009eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794865206; x=1795470006;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w7gJaq0U2XA1qzZik/lkoh6ncUAk4PKRnqK8WDeKiB8=;
 b=cwMONJbluQFvfcFct1Nd6PkixvArZbxGUwShZUVcwqyn6Uzss0xylt6oUXctzZP1z7
 UJ6iRYUHXg7RQ91eOcjOUTZ0xiLwGrUkorvzpZ2/JxsijZeuDJbwgRegPqpgsnAW1HYj
 72QGxycg2ubDQGtO+5gLKSX2c4HkxZSNpst+0=
X-Forwarded-Encrypted: i=1;
 AL+hErHzWiIl3qatsX/qC1nQVuoDVjPqt1emAmaQz+pIMtkfEwopo8pA9lekY9b8IbX3uHw+gOs8+CwjaUE=@lists.freedesktop.org
X-Received: by 2002:a05:7300:2204:b0:367:185e:867a with SMTP id
 5a478bee46e88-379679df9d9mr17264299eec.38.1794865190197; 
 Mon, 16 Nov 2026 13:39:50 -0800 (PST)
X-Received: by 2002:a05:7300:2204:b0:367:185e:867a with SMTP id
 5a478bee46e88-379679df9d9mr17264030eec.38.1794865184515; 
 Mon, 16 Nov 2026 13:39:44 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955e0d966sm37780089eec.15.2026.11.16.13.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:39:43 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Jaeyeong Lee <finpiler@protonmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Erase the detached resource entry on resource
 release
Date: Mon, 16 Nov 2026 16:39:41 -0500
Message-ID: <179485275604.3430538.5664968222788399295@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725143859.797134-1-finpiler@protonmail.com>
References: <20260725143859.797134-1-finpiler@protonmail.com>
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

Thank you. I rebased it, dropped the v7.2-rc4 analysis note from the
commit message and applied it to drm-misc-fixes.

z
