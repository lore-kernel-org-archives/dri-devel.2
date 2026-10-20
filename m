Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F30606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T5Ax8urK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786D510F31D;
	Tue, 20 Oct 2026 07:36:51 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A72110E7C7
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:34:50 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ea138a3497so5561085ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792474490; x=1793079290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
 b=T5Ax8urKAW+FrtUecHS8GMlQTmmBbIJYCmBaTWGFADFf9BKnlpQ6k40h1LL2PWVANV
 6nruPtAaz3m6bXvqyJMhxIHI2j5c3CbCCj+EbnJsvks6ZyRaMGY3xghrIwe8oHynnqpK
 lKDayk103AbLoRtQohTE8Rm0xZnxdxp8o1Qd81wNc/xT3Iey99uoruAlxUads/UFC9Xf
 6YcD7CuB8fw7eMcpv9u5GhPS/QV2zdsTiVL4EG/PIcQlqM/kCj+rMjLqzbdSgZs7aT+d
 6tYhV9ij13tTj9qJIFJ/ogLWj7jtHWo67KsbMVmbGiN6lII0HDx/abcaLpT6oYhKKIC6
 hrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792474490; x=1793079290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
 b=NI1PwZ9pT5mbHqYjGWNBujaHp0lxp6V9zr3vgJcijV4Kiggx2a+ZsYLEH7iZZ8ba4D
 ywmBKPvp6WmSZdF9S5HGFAU+66EOHcnavgqe793r7kuL281pQuNBllP2CjvPQk+AP4NP
 I0ov9vn9wWxse4/wNFocgg+iUOn1i5OpmvW9xWmz6S7Oh3yEncNtApBEVQzwPHjvVtCs
 fqVi1K1XqapdY9jZUkbkyQrEMfk7NmWtr3NT9nfUpBzMEWCWDOy2zc5S/NqHFtdqBIMv
 /+A7lIzPL52tUO1algG5HufLXW5GQ9kdkYMyHUluhE+dOczLzsiZu0zghC2Kua/9BF/+
 kVaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByBurPLMDCnBJhXLLKJyClH9+ZgadRS4Z491bvloVWUu2gSHXRvynmKblyIkL5zH1jxPwZL5VAfaKI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJDyUYGhsrhb+XzenW6AyG8ap40zl/z8DxFk2IiAnYPtRBSjmDY
 Z0nGVbRlW7mQxbguoRAc9Wgneb9HoCoUagQHebgAPJkXjXof6RQ0rhBV
X-Gm-Gg: AYBFou2EIluyVhSIS53jSddm+ThKlX4lwEn+GdPR52l8KahcLkkONXtp08sW4n25fH9
 iuxGy2ibBJa0JHH0Lut+OTX4/adLK9U/PBiWUjeW68fDWYuommsH7xnOR2GwQsbqoaU8aCbDRen
 5RnSHLykSiaklS+UbsVP0wGbpVjnlaquHLGoeaqbspeD7Dpdc0lKauJK7OfeUdSRIQ5Ep0PIP4r
 DRaUEuJl0ot7sLlHnY3INmJTIoSbQ+suVAgilBZpQmJ375B44SRdu19Mm7tdLwEC7eyyMk6qjEd
 hlTb/lFzT/z6J8B28fmJ6p1/ZIYwoCGHhLn7e9bP0wFeuc4aYSd71UyYlgptJmldJP/XYi2A+n7
 9vSEPCNT/MxIx5SEyiKGCBYW+LHBvfd561mROSMs2vJBgwUPGH3DCpOitk6UZlCpk8doPyem5bO
 9hG8apPRM+8WnQaEBYVKytACj6t7gEp3285pF5Ot15qf543Omedci8hFhNxOBgcWhRGw==
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id
 98e67ed59e1d1-3acee98d90emr8576204a91.8.1792474489983; 
 Mon, 19 Oct 2026 22:34:49 -0700 (PDT)
Received: from hachimi ([101.5.175.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60102ebdsm2216041a91.1.2026.10.19.22.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 22:34:49 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com, decui@microsoft.com, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 longli@microsoft.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, regressions@lists.linux.dev, simona@ffwll.ch,
 ssengar@linux.microsoft.com, stable@vger.kernel.org,
 xlfylawarthur@gmail.com
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Tue, 20 Oct 2026 13:34:09 +0800
Message-ID: <20261020053433.9419-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
References: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 18:03:55 +0200, Thomas Zimmermann wrote:
> The problem is that module parameters are impossible to remove in 
> practice. Once in place, someone always depends on it. They also 
> increase the number of states to test.  Avoiding them is usually a good 
> idea. Especially as workarounds for bug or regressions.

Understood. Since Hamza is working on an implementation of cursor plane,
I think this patch can be dropped for now.
