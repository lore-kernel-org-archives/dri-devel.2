Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994C606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHOEIbMg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F8110E892;
	Fri, 30 Oct 2026 09:13:16 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529D8112614
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:11:45 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ea0efd636dso2072745ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793326305; x=1793931105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OJ+UbYof1H6RaTL5sRkRgBhaKvjzbtyBbRi1EGwIN5U=;
 b=GHOEIbMgHPYsQ2MonwKKho0JiQvg18gyuPBiIHH2HgXCwxLGKsxEsCpfFxI6h691sv
 R26NfbT2LXcGskzmjoi0nIAIMKdvF0RXCLIF3dKv06x8jrSeziqqSWvl6/pYWGPB1pRr
 jEswIhHq5cz47BbqN5Ansb7LkSjtuv6qRQtIbCVRorA0EOxMUOPiSuVFi/LBNDygwaaq
 0bYTw6XMUv4Rv6R50IUOu7ACd4YlbjMgPgC6qCCdQS+rqVy88jE99mgm5s6k8cTWMZs/
 Ib/EQaPmZ2lBpNQoyKfb4FICO03u7zb1Xyr9NynTEZZ/gGYyIr3VPI/kEM0Yx3vQNAfs
 U7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793326305; x=1793931105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OJ+UbYof1H6RaTL5sRkRgBhaKvjzbtyBbRi1EGwIN5U=;
 b=vNdL3hhzSYu+YPui3lo+ef+v3KNwd4Qa4M+F/AyiI8/wOszjtT7OVuU70GCg/cNwty
 JOh4eCzoA7SEHG6CK8fD7BZoWgqTmpskHieeZxgx9HvpAF1EP521HYSjYkfs74enTTKB
 ibIRPt53TFAPdexdTaDl2/sCq3wxfyoHMfXw2ANEKUDQcP11Q/3V3+i5ZSUxVvhjRGim
 vk1Qf5SAzgoO0TNusQ0OW7GimDrp/TGyfC+HJ4+UmaXzqng9SLnxEvJXVBctxTpoCHS0
 ONEKA0Dapojau176iXzk58dvcly/e+W24ZspZ7ZIyegy2EXkl8EplRIp+7ZyjCMl559l
 1b1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzahhLt1YJe+HE+UClTRGJbYq0FH/+4Nxmv4kyC2jzhegev1t9fi7kwf5xB6tkuwer/H3lY0hSRyQE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKahWidAzYE81FftqPp/fTUE/Cs0tELABCSy64W+hCJyxtEPPWG
 5pXTngjeyLL6HJKH9qdUa25rxfs9tZrsmMXMZbiX2b5Zumur4ZSxLxlP
X-Gm-Gg: AYBFou00jpEHz40CQi3ECUn3PTzZuCZYit0myLuhqOgcQVE2Gmb7dDH9hEcaJIdAtcV
 Nb8VFtHbNCMbLjJuKjTJfMIDEPOEFYALNAaHWZ8zYKBgrjuTPSrrKKg5ZoEZe+gr2FgFl6l2Nhl
 RZZbDISZCOtX+OZxETkHMnRAFOOyIO4Hja65MZGPyqZro1sc0qvvOSwmAXxvEfBUEnidLPs4KBg
 OH9imWYwEyUd8c0z1YyhOpbCWcWnj57nZMze0tyLeldmHwUmmk6ZEGP0tdBJ0bqOev+LDdMoM1g
 l5vHpDMVOiHuFjlWqgxGy/kbg/t9MeSdP6OxsNdHGSIRA/gBQZ2+twbGe2bVEZsyvFMujla7wOp
 qJfXrO1W6Bx76+PckZcvJb4k9C1m/lhPCLWB/alf6O/ulFzlmxCpQL/zvhwKyp8/UHFnwvq03rL
 5Eol3i0ec/N0c7TZ9/kVSndTwipmkQfpTry8MKH9TJ/i+potTiSdbtblxdmYzRDJUhwxUIuAViR
 XikQEwSEm2koFrhvmdm3jFG6vq45jQVh4sytrQfpeZH0vDMGvt1G+F4K/AgwDv5N08P7f7eac4h
 tRCPoiBCbCzFCH3X4/45338miudNwcfqOXwzjbo7
X-Received: by 2002:a17:90b:180d:b0:3ac:a204:aa27 with SMTP id
 98e67ed59e1d1-3ae8985edbfmr647922a91.66.1793326304829; 
 Thu, 29 Oct 2026 19:11:44 -0700 (PDT)
Received: from LYF-imac ([120.235.89.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e98afe3sm6164303a91.12.2026.10.29.19.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:11:44 -0700 (PDT)
From: fausten <yunfeng.li.nb@gmail.com>
To: zack.rusin@broadcom.com
Cc: fausten <yunfeng.li.nb@gmail.com>, maaz.mombasawala@broadcom.com,
 ian.forbes@broadcom.com, tomas@slax.org, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/vmwgfx: fix cursor validation and buffer lifetimes
Date: Fri, 30 Oct 2026 10:10:46 +0800
Message-ID: <20261030021115.35069-1-yunfeng.li.nb@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zack,

Tested the whole series on top of 7.3.

  Host:  VMware Fusion 26.0.1 on macOS 26.7.1 (x86_64)
  Guest: Kylin Linux Advanced Server V10, 3D acceleration disabled
         (GB-only cursor path, SVGA_REG_CURSOR_MAX_DIMENSION reads 0)

Before the series every cursor update was rejected with -EINVAL;
with it applied the cursor works normally again. No regressions
noticed in basic desktop use.

Tested-by: fausten <yunfeng.li.nb@gmail.com>
