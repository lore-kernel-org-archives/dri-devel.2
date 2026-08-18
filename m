Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604BC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9FA10E53D;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPiJRZuU";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C2810E2A2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:17:31 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d032846c95so64715035ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787055451; x=1787660251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C6sELIhv1S+5sf5c4uqOjdCGgTBs3Sk91TiW2PizCkk=;
 b=nPiJRZuUsNAT5n5mS7IDdxlzFFAOZ5NK1F/QOQxouPC2cuzgJA43WwQNDTHcj1Yhwa
 tmnTFMmwPu2R+mRSkAgH2nlAQfAFFruU0qclO+93TmbTfMDwGvEzKIoI5hbpcWyADGpn
 ZyMe4NnwAhVUeEoEOtGbhscdd4GBFDPEbfEO3FpsjWqoW/zHyz68D5ibavORriOty3QD
 jWlsw+WO0SFO76AXEgDEUoI4o9FhNbmuMUHfznTnw1+xN1z6FoXkOmK5wHHrJqx5DCSp
 Hq3r9VA815QtVMglBm4A5id2pn3RjSx5ZyROZ7IVzwU+Beg2bagCiZp2KbcrVKxE0zbg
 9eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787055451; x=1787660251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C6sELIhv1S+5sf5c4uqOjdCGgTBs3Sk91TiW2PizCkk=;
 b=n9yQFIjpjBkRZX9gsknQcvP783yRX0FWhZBia3iEXJ53p8RIopp4cIFzGxTBeTcJhC
 eECV9/NK8Li5r0Y01fKS7QyIws/6hgIhuci4w9MS47WKo5LKy007PCuJfVv1u1Jz8+aA
 63LIBWGy+utc1ekiFHjF73lA69p1WtVNMFPEpjbQMyWzSMvfZJwJsfuL3tO2eqLKM0lZ
 6k0/CCaFMStHrGgllFsQy56m8cgZ/L0I2RT2SScJwXKBnOHHFYM7Qtjs1nABPTbGzCa2
 fBIu1BkFQS7VukwvmSO39NySohYQ458uKfezVJB7pDoYfhf/UQbkp8GwwwGTLr2GChLC
 iRLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdaZttRIZzQbcciave1DLKNDDVPsm6UZ+r353Jjl6SFrFRKx1W0w/gdVMS+NH64SY5jjZXmZr3B1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkwCAFltziUGf/TVf+hLCOmW7kBZPg1pwVxNpLkDrx+7vn2i89
 jOgDCdKrQkywj7wzsVkNd4k5s573DZ5DYHpI0i11JTK/YzQXeEAI7kM=
X-Gm-Gg: AR+sD12zGfAEYH6hfTo4UjwlXP+9AS+UDybDXMJwg+/T1injlrVcHx1HWUnkWtGCom1
 YIqrgtpCpOxn8IMN8FH2j+NVHfZVAIXt2aLZXQl51PGCU5XWL9jDROMHmU68OZxoOjKtrJGO3LH
 tSFLR71dI2RLG/cbglP9CpkHFhTiWSEdXQU6QkWkN3UR/EwkLp1SW4jkUihZTFdLUcoM1LrfBKQ
 Zbl8YpG7pPTDUuMjm73QjhWqZQjogj/G/SwVvBVafBj9DiGCMILJ0tjpm3wXqkIIIpZsDKSzN6a
 ABQmz8u6JNqb2RzoMgXI1C3cpr4YEpsdzR7PD1LfbWxEuOsqxNrilhBRuMaoPqTGoFoZvgOH519
 YilJBQXOQlx6w+eWMsPkRI4A1PlWFlRmqHXbFBGwqgfG7OWECt8rfkA+NrtnsfRMGwDV0+bCsE4
 PNLw+nLfGus6NjidEl92eVAvWOeZvvDCOCpypQocfR14EFBWUWus4LxWNvIDJ7HCcj3iJSx9VuV
 RDt4qRbv6eAq+o1zxGXMhUFh/s4Xo3XOrVt3GMzvvSWlHMmWzhnUjM8l9TMsqdXmYPp
X-Received: by 2002:a17:902:eb83:b0:2cf:b68a:2050 with SMTP id
 d9443c01a7336-2d5c5370140mr111173305ad.15.1787055451082; 
 Tue, 18 Aug 2026 05:17:31 -0700 (PDT)
Received: from
 codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.119]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1ed8b0csm13769275ad.74.2026.08.18.05.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 05:17:30 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: triet.hoang.dev@gmail.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com,
 dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org,
 kraxel@redhat.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com,
 simona@ffwll.ch, tzimmermann@suse.de, virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: Fix possible memory allocation failure
Date: Tue, 18 Aug 2026 12:17:14 +0000
Message-ID: <20260818121714.47251-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
References: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

This is a stupid idea. Sorry about that and just forget the PATCH.

Regards,
Triet
