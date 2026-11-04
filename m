Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D913606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=charmerstraining.com header.i=@charmerstraining.com header.a=rsa-sha256 header.s=google header.b=oXzPQ/Aa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5AA112C57;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5A510E772
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:52:53 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso942587c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=charmerstraining.com; s=google; t=1793796772; x=1794401572;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EPqf68p4zgOm5bk1tzpmfEq+lDmfobnZCEG8E1tQHtw=;
 b=oXzPQ/AaJBIhfly5dtPs4Bf6Ex6WX2Y88kSYMIjINbyQYpNSvidEcmFVWyDa6YSRjy
 8Gcaiw4eFTwj6MsdBSWLnbTWDWco5imG/gdACw3Euxi4jVRbMfjGRbIdD0h1/EmQ7qp4
 CGEjVvkYZEvABVCmJfFjmCvN/t1JryQcNIeLPYNL30krYUfbAY78YkUVNVNIYdUR6SXc
 Kl8R0GZ/LYHp2tY/qKqfvxURP6zeuakOZMPUehyVQlwQ6fKg0ZQZ/iac4sdFXqm0yNE6
 BDL7C37GTt1SpyAXhsXZubEPz36yYTKB/UYwdwbNAtxyK1JaNHYZGo8BOdB4OFRZVGvt
 fbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796772; x=1794401572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPqf68p4zgOm5bk1tzpmfEq+lDmfobnZCEG8E1tQHtw=;
 b=t6052cJ9Ri1ew9Ow3pp2qf7tELzYT7/1jHnJjItOfy7AP4aF8avYo3pLmtlqQVJCvy
 cAt9XZ5sUyYm1hDl9guuxQXPH0ODF5y5gj20kzhnWpKS1S1hazTmmPfiMv1LTGN3ztxv
 Xt7J1TFm49bqYQWqhje75v/Fpii652FIy0H6wHb2rL8K6/gb0gXxIosiGag70Tp5YESU
 c9i526dAMLjUrlyJ4hntua6FTHX8PporpcA+pt/UCB4BgkrNFQlS2z6d2FBPdZk0Z53O
 NlUIjdq+atmSkILKRqBq7o1dhNPKswHPmX0M9MBF/1PEZaDNCXEMXbOp/QSbJZ3ZQzyt
 QmlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByRt8cD6LAb7fqgUBrHBlmNZ2KxDFfFOUzE3taRtMCC0pb8viGRT38arrRlj8oKKCraPIlYxHBN9d8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ptyrBxVqlBwoKXzWBpxJUrWVk0opCqCyPC7qko7u17vJObf/7
 qooam35Tt3/c7UqHJzGaZe0mcytfnHteX8npSOuZYH6zt1idc3huNrZ/6qaPBQ4rkDo=
X-Gm-Gg: AYBFou0kQrzwVaJtDd+TmaogbuqBBNkUFIPdrXJPA5xNPhSqvJ8vucqEg3yxX8j/sL2
 pBap8dn/OE/bfUuXogbaI3v4wbGQxtancyWmDXP5V2nhNcSVTJRCQcit+SBe5DS0XnaqxUefY1/
 rxKULwKULrRS+4pNPBdxtxinqMQlBwOhHQ8HWlLks4Vryd/bknv3E1TnVQ/Menan0jOiAvQO3kc
 WhgxC3QLlEneKq2+b89aU/faXRKQ2t6GRRghVR6UmalqAYLoA3UHGGCxPAjpI/+ACD/E/EYzPNt
 wP0XuCnKqG79YuPzXTcVvsAI0O8aHh/SEdTZfiE5SwYxkRCAZoG8sy0KI+Q4ffzceLL7Ip6yq7x
 bkA/2RtKsdzCBQsPraOMI/dAp8qOjNj2n6VKh2pt45mi5J8dXQh+E6wdV0+EvckNR9bcywquh9G
 HvvFVyLhJeOfujMC5C/W1uU09GASwwGn+1Za/0R6iLKNj+nrJSTTvC8PQ9viHODbBn+gqbvPH0k
 /KlgrfUKkWHdIk22ygkdYmrxDs4TC4seSpl3gTYQ9YEkVC8Tfyp/1b4eZMEypgZFcjIBCc85msY
 VHVdWf6a76e5u7gG/Bc61z8d26m240+e1PYMOiQnU+OPdxUfb4/emb+AC/H07ZLfiD6Rd6CWcd9
 XRNZtI3FJao4cuoxSkiUNIP8za5uT8zTElzjFPQVKMVLUW1QKOW9WUqa5h7fnT63uZs/6W9w=
X-Received: by 2002:a05:7022:92b:b0:1ab:fe29:5055 with SMTP id
 a92af1059eb24-1ac5bbb9041mr29240092c88.9.1793796772092; 
 Wed, 04 Nov 2026 04:52:52 -0800 (PST)
Received: from ip-192-168-20-3.ap-southeast-2.compute.internal
 (167-179-142-232.a7b38e.mel.nbn.aussiebb.net. [167.179.142.232])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c6f0dcsm9787264c88.21.2026.11.04.04.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 04:52:50 -0800 (PST)
From: Ed Schofield <ed@charmerstraining.com>
To: alexdeucher@gmail.com
Cc: atharvatiwarilinuxdev@gmail.com, dev@deq.rocks, aditya.garg@linux.dev,
 alexander.deucher@amd.com, kenneth.feng@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Wed,  4 Nov 2026 23:52:41 +1100
Message-ID: <20261104125241.39209-1-ed@charmerstraining.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
 <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex, hi Atharva, hi all,

Alex, I'd like to withdraw my September v4 submission. I also don't support
applying v5 as posted or the simplified patch you attached later in this
thread. Please remove my Co-developed-by and Signed-off-by tags from both
versions. I no longer think deferring UCLK is the right approach for the iMacs.

I also excluded the MacBookPro16,1 (020f) from v4 deliberately because a tester
found that with deferred UCLK it still hung after login, as it does without the
patch [1], which seems to fit André's PPTable diagnosis.

Since then, I've been working with Atharva to get his native-5K iMac support
upstream. His patch initializes the display before the SMU, which has also
prevented the boot failures without deferring UCLK. On my iMac20,1 (0218), 13
of 20 warm boots failed with the upstream order; with display first, all 40
boots passed [4]. Another tester reported one warm and one cold boot, both
successful, on a 0219 [2]. On an iMac20,2 (021a), changing only the
initialization order improved warm boot success from 11 out of 20 to 100 out of
100 [3]. His patch only applies to the iMac20,1 and iMac20,2, so it doesn't fix
the 16,1 either.

I don't think the iMacs and the MacBookPro16,1 have the same problem. The
iMacs fail while amdgpu is loading: the SMU stops responding to
EnableAllSmuFeatures (message 6), and the probe fails with -62. With the
display initialized first, the same message succeeds with UCLK included,
and the iMac boots normally. The 16,1 loads amdgpu without errors and hangs
later, after login, with or without deferred UCLK [1]. So deferring UCLK
seems to help the iMacs only because it moves the enable after display
init, and it doesn't help the MacBookPro16,1.

I have prepared a draft patch with Atharva as author and me as co-developer,
incorporating his review feedback. It combines display-first initialization and
native 5120x2880 support through two tiled connectors with suspend/resume and
display power-management changes. The current draft is here:

https://github.com/edschofield/linux-t2-patches/blob/7273823e425200e9f371e9272e02ebf9abb6f1c2/7003-amdgpu-add-support-for-5K.patch

This has passed some initial automated testing on my iMac20,1 but I need to do
more testing and get Atharva's final review and sign-off.

Alex, thanks for following up on the boot issue and checking with the Windows
team.

Best regards,
Ed

[1] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646139127
[2] https://github.com/t2linux/wiki/issues/743#issuecomment-6083265811
[3] https://github.com/t2linux/wiki/issues/743#issuecomment-6131809640
[4] https://github.com/t2linux/wiki/issues/743#issuecomment-6163146905
