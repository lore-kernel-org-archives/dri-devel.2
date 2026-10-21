Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CE606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XMatZwEN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3675112457;
	Thu, 22 Oct 2026 09:41:27 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3E310E2ED
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:46:33 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-9906c85122cso172427241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792586792; x=1793191592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXEijJWzEN8qMzo3aWKU8aRlCg4X/j/vwnA7GLOW2G0=;
 b=XMatZwENfipbeTUUHn3hXos9cNM1osPAMIWent4H2hTQ25v0arLGFeDjbXoejvh7CF
 +ufOcXqHYfPUXPa1G4QRBNejIEd9HqfIFNDKjRZEJ/jbizI36rtdn09MH5uZ9Ja6O8UZ
 VAjWYQRTv7c323VLtIEelPndYfdjuQs0YxpMM2D3AALwbQ78LIxX7wz7a+4sWTOYF42M
 AEvvzgS0GWNcSju54DH8NnTQ0YPIm79lDbv9/43kqqbOHAa8hwEEY+4H1Kt7x0Lu43yA
 lEMqXgsmUthYXSjgaiP2I8B4cDkxPZ8dUBrYQ7E3TmaUWlknmWfZvGYwgf/BkosilPv3
 lNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586792; x=1793191592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXEijJWzEN8qMzo3aWKU8aRlCg4X/j/vwnA7GLOW2G0=;
 b=rvQwRbOzwAj5BQshW8Hjvh7cEuzsc0Ny4iSP2rHdznJFaQy5goOt7jmE7OzX9Pv4Gf
 x/koOrydGVDlcdZ2nB3P30pfID4q9rzTmt3T0CMw66O6XSnoLeng6xDBvP3RHI2n5zUV
 CJGkJVBAg3PikidyLnLzSQKol8Fot/gJrSdfFmCc6TOTV3+DGtrXE31oTL7gmYIvuZBz
 Aqavf7IyHXwCl0YvK63NffRh+EBmog1jkcPmz9zQMB8NnAZU1u4WzxMtyrBzi0ePsmj/
 s4PdV+Nif0Kmkx2BIXvdXf0rF2RCfH7CqfqUGB5gUicZjXnHEHwsDxVFCyJoY+AMiwmP
 saRA==
X-Gm-Message-State: AFq9FYLK6o1fyv3eEF6G88mb+ZjlLNKce8ZYLwfyuKvrrbUpi6pIiLie
 ZFcwNKz0DjCzIOCMKxpUzmTmyiydACZZH15NSrMUOHt+pT5vbl2fFxu4
X-Gm-Gg: AYBFou2b//CozVzAAQVd68JzshAHOLPL2pcxxacsMWlg52OLhpMzypj+nBMh1EWJsNO
 4ZmMRjF4ra7SlImULMUaZeF6vlz/a+8tuAlmvj+3vh735XmHdFiX2PKtBZ/Q1CpIIVx8wjwk8Tp
 4KoP1WqRXa23O3m7ccUS+kanq0R5jhFlvPNDNIUOkxRYmPIcP8PIWAanf3rtrlMTf+N68jaVdyT
 ZxHLXU+BS7WAzBa23RZjInUfNTJ1LktYHRyViMEyubo75qB6DuMCk2Ug5UWmMQU1n3DG5tHL8Z5
 kx2RMSJlG39plPdFbA3283jPz+OaLf+yiupmmftPI7NfDQb8K9tClbCaM9wVepomnqjDT0c/nqN
 h+xqIXU0E0oZgwLPuo318y7Oqmwvn8G2TuXNlAN8lnX9ue3+8qRRZ4M9eajUwfXNevAg+Hq8a51
 /Bw2LFH9cZyWmSnL/tLyh6MB5UYGsStuXCHv+ztX95KalMx6ABUcbQgV7qJhwlF1iIsZ9shlfid
 hGA6N10t40nGVLxRLVc39qgAqWTR/gDZIRm2QXIhBnyi7qxBiG9Pmyx2ilgbbSHRxoQPjI=
X-Received: by 2002:a05:6102:d87:b0:7a7:1db6:c769 with SMTP id
 ada2fe7eead31-7cc926828e9mr541224137.22.1792586792118; 
 Wed, 21 Oct 2026 05:46:32 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc923f5762sm2585277137.9.2026.10.21.05.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:46:31 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/radeon/vce1: enable the VCE trap interrupt
Date: Wed, 21 Oct 2026 09:46:09 -0300
Message-ID: <20261021124614.107065-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-180189@kernel.org>
References: <sashiko-outbox-180189@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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

> Does writing VCE_SYS_INT_EN unconditionally in vce_v1_0_start() access the
> wrong MMIO register offset on CIK (VCE 2.0) hardware?

Thanks, that is right.  vce_v1_0_start() is also reached on CIK through
vce_v1_0_init() (cik.c) and kv_dpm, where VCE_SYS_INT_EN lives at a
different offset (cikd.h) and is already enabled by vce_v2_0_resume().
v1 would have written the VCE1 offset on VCE2 hardware.

I have a v2 ready that only does the write for family < CHIP_BONAIRE.
I will wait a bit for further comments before sending it.
