Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF1EF99355
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C4010EF93;
	Thu, 23 Apr 2026 08:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AG6SpB1W";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEAA10E04D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:30:13 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so52129245e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776871812; x=1777476612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysBs+qqXtlvRGKKjFh3kR4dBpeQzZzEKzPI/gcg4dkM=;
 b=AG6SpB1WiGGHfykDKbKH8ifgQH9t3QGwnTi6Ia53oFTa3sZXzG+SmYOTFpndMR4HQE
 CoHcjFWqYTJpnqdYlT0yWxYAFd2VWcBi/2K9NTFw6o+zh6kbXKecZ5Y5SSuAiySJeHFL
 QeZweWCp2/5Yo6z13CP1vJnCZT7g8FxGwzUPf4JQuPHrClERWgya/6OT61mCbYNHOw5I
 dizXtL1ZpfwUPh3g29wxzS+P+KQEH3pqnF6i8us2jbplYDh69eNAKjk/lkvimZxbVPK0
 B2N7ZrtsXpHccwOpPVD7yKM7UR6VaBPTnO4iJtGbdLD9ZbvyYqQ80xe5XBXrZVQN57m5
 8l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776871812; x=1777476612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ysBs+qqXtlvRGKKjFh3kR4dBpeQzZzEKzPI/gcg4dkM=;
 b=LXJvrnLU641rcPomiFEW0nuBCOOK+qmZLYg4oI+lHAE+rOzLS53JAGdnaE8HvGQ0OZ
 PrpJGtRlBT8yJ3zNcRVl6QMiHU2/2FzJWNh6ZvRwDD+Mf/Wm47zUI5fxOxg5Ak8mf+ab
 pjPse3Ok2JIwbVb2Fc9mj07WdnuDEe4qxVVusoIn4cO1jlnku6NQqUZhr4Gymvda4U1x
 aTTabgybWz2XeBoDzOL+RcBhhvonTjj5Ag3jDKHzoSVq3oTm8vKYRQOOinBnV1d9Ey79
 9qzbgzHHq0xYMQ/mD9RBJXCtVuTXEU1KBwratr11aG6UVbQF1wmPXs5Lvcal23ImZGMU
 Krog==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xoV1OnW9j5fFDHEYEFbqMLvYWKWg1fY5OeKQQmf3aVE+R9M2A9ayncX1lRm34DEwIKqLTUO1dNnE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDE/Qler0DnvIsT8lvvyqC94JdkxLnV4qdmjwuBfeSkXWmLH/a
 YqE9HXIEHZwNYFBYR5+2CubukRJUoPdi4qLt8kOa7K1BeNYWdig/nhqI
X-Gm-Gg: AeBDieumBSDatOmJY2boTTLVgIxO6xcTEVRYid5ogabN6rg+JEekPEG9nntHp/yeDZj
 Z3SGtpW0SwCwVq8LPqBIZb7du1LsvEsm5ERMF7cps/ZJjCAqI62WQgimnMXE/IRLNtFT8KStEdD
 FX8+vlpZApx99RBLHoAzDEZM63yeoADpqJr+hZ90Q7+7bS32WQ68hdgTx3DW26oWc0Ajx1o1c4i
 GNe1AXGtXL1V4E6pLQDzldzDejCRzyWrCPGRXAV9hr/PLGPhCMMMVFUHSXYVbG6KENRquVMXySm
 ocUAdBmuePXM2cvS9oyvEggJ63jhu54wavz/uXvcVUqIN7jQIRz9qEsPnxsdNrrrXF7gaD4/H+K
 dxz1rdclfinn9v4K3Pmd/vr6WINFvlsmWtw+Fdc4VFsaM2RrvDrhFlh7V5jqZhBDyil/aKnj8tb
 PHqao9GfPZYiwXwBCwV6xqeLwA7FLB5uOew7n86h9D
X-Received: by 2002:a05:600c:3213:b0:489:149a:f9e6 with SMTP id
 5b1f17b1804b1-489149afa07mr117244535e9.28.1776871811450; 
 Wed, 22 Apr 2026 08:30:11 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm434627425e9.0.2026.04.22.08.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:30:10 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: amit.barzilai22@gmail.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, thomas.zimmermann@suse.de
Subject: Re: [PATCH 1/3] fbdev: cobalt_lcdfb: Request memory region
Date: Wed, 22 Apr 2026 18:29:46 +0300
Message-ID: <20260422152946.5163-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
References: <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:51:37 +0000
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

Hi Helge,

Yes, I wrote all three patches and I am OK with the added Signed-off-by line.
Sorry for the oversight, I'll make sure to include it in future submissions.

Thanks,
Amit
