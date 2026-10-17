Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A12CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C204D10E66F;
	Sun, 18 Oct 2026 14:53:19 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6153E10E0BD
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:05:39 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e915887d9dso3476595ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792245939; x=1792850739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mm1SkJAd0ZzUVZM2VvxblTUHLtQ02hFHKTpaC6z+4w=;
 b=lpczYBcpzTj8iS+o0XS8CzMuFjYLFNbTILFronUzHTnzkcucc+83bFMB4bJq0IM9Nv
 fpb2iGeMlaLqOXHsaIsNdprHBxvANMAidJt+V+raNPGCLMG1pXbjOcsQZX++pRDlsydo
 RSqESiGC+PNItzsfLFQGYkrj7wjP94sf6xmi2ETPxR9KQ7LZZOTfUTrf7y9FezochVuw
 Jo3CXyTUz3pSxClO/IgoCw6yq4xZpfQRgegTVQJ/j1GMV8TjsXxBC0DDGTYYL5iICbEl
 6utvp2oGmApZ2idJk09Uyj2cijF+HIbbg+9Kxu2ffxkPEmCWKr8IgxIhiW0wk9kY0Sgv
 xPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792245939; x=1792850739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8mm1SkJAd0ZzUVZM2VvxblTUHLtQ02hFHKTpaC6z+4w=;
 b=XjfeNNDiqVRm0LCPi6Sq012VqMKYnY740VasuSQ4AX2z+NFuYd291w0PLH2ynDYzQ0
 GhoazcRPvTu7DMBdyfIwinn/rW9RpQjrAT3vlIY7zd6lTMWicI28aK8pZmur1z02gwD/
 xqR5GFESNhU/6E3HamGIZq5IbEWxXxsJwnud+Nza4SxO0zdF1h2VMLOBcpbNGU96i9KE
 ueQsY1hpvQp5GU2Kto417UXJUlxFQXk3wHVHj29hVS6azWlhWio2zk6YKTKuBQQ16tLc
 j3vm2sDvZGlZK5sAGjH7T4pIFbj+jQQ9giOx8GoMiK1xiKQC11etctA5KBVhTPLZtnfK
 gJeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx21ChUlssg8UWphP0dfxq7nkeqGEmww684Lx8u/mbdAEAufyJYyuWKy2bzXfV6mIsP9IX7iCciKmQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKXZdBiVW0Xi4eb52eS3CBLgfSJTJAtlsu63k8lAtDYULKm/4Cm
 lic1oT46xhJnZzqdRbzCjqKI9ixuufOPsZw6gETWsh//yeGdhbyKpP7Hp+uscvy2
X-Gm-Gg: AYBFou3EOB7aCxkgqPJiHWPSy6eMVf9d1MKzqjqHikFPtJRitT1Ir3mXUG7axJikrvc
 iZM5G+6IVfCYqJ+Mb/TEG21Lq5YxoT+al+tBM7mbtt4qEtvmPNXxzkN9aurAXmUINnmUOP2tBrX
 NAszYxvuiaAnavMarTKUEfa9S1bIQQsoqPulGVzsG8bY3L9H1RC+o/EBulEKMQOE8kPoYmG3L9/
 JhfTtg6F1rna7JFmvRwpV1AxSPTSyC4ZCi6KmLVdzGqnV2Q5+ZlmMa5Fa2OpIA1nDcSea+DndSM
 Z5lTmTt3hPt7E9w67ylp0iRM940eG1/GJm5Hy+4DN9uiUEMoaUAPS81+0h/uxchTlYZhwffdwRb
 Pgb26DeT+ZPDZ9nDAGYOP0um8DKo0wp9gOgzFWIlJLvMxTHyhGCxB3MVLzf0dcPX/dtu1oHc4kL
 d7o+uJ0rhoDrpvO2Pvw1XnEVUA6iIsbc1VabJYJdg1s5S41Az95WnhcYshyTRrwktdAzdbiyf5F
 Ky9rjAc7IeoxMpSvdIChaYHseOfAFNqV50AfYENTupkO0/moNOYxSwyRckugC8+HlfCzQzCF/Do
 7qpT24N1/MsaWgm7elq2lX/YhflQLFGNFOeOqBBJElseT7v9pWuJjAc=
X-Received: by 2002:a17:902:c943:b0:2e9:5eee:e085 with SMTP id
 d9443c01a7336-2e9a68da44emr20543265ad.19.1792245938535; 
 Sat, 17 Oct 2026 07:05:38 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804eb4sm21848265ad.20.2026.10.17.07.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:05:38 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: fix stale return value documentation for
 dma_buf_set_name()
Date: Sat, 17 Oct 2026 22:05:34 +0800
Message-ID: <20261017140534.3264870-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902135923.3599022-1-alan.tseng.cs@gmail.com>
References: <20260902135923.3599022-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

Hi Sumit, Christian,

Gentle ping on this one. It still applies cleanly to next-20261016, where
the comment still documents the -EBUSY return that commit e73c317efbf9
("dma-buf: remove restriction of IOCTL:DMA_BUF_SET_NAME") removed.

Sorry for the noise around v2: it went out three times (2026-07-30,
2026-09-01 and 2026-09-02) while I was sorting out the recipients. This
posting from 2026-09-02 is the one to look at; the others can be dropped.

Thanks,
Hung-Chun
