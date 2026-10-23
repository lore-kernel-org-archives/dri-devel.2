Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D4606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h+kH2iX/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E22310E6CF;
	Fri, 23 Oct 2026 18:17:03 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB29410E5CD
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:02:26 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so395867a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792746146; x=1793350946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LErop/DGERkB7CZZF2w1mWsEqhlGZfF07HpoQtKJxU0=;
 b=h+kH2iX/txtFPkBC5kwDUieYg2GGTJglZa7xGRzO/4eZZABre7DbfOKQufADJR7FfE
 6IRWfyWL8DKj0iOghdGWo0ga567aUkK4wHizMYU7110uPZGJZujxbcGSXixSnTchyo96
 ZnelW5+mUbvMOIiCLPLmEwXtCifVODDKNq6Nxwfz5O8AWxZmQ8GvE91fp4aBss7tD4hq
 mMVKTyQ3sSN8Kek7gkvIcU4eW1YOArv4YN0cY5XKCwmXOjkIHYiAyC23NU7nELR9ajWd
 s/QEirl58KLnYZWaVYDnqjKaALiIxJNJqafJbLUuoKbcqyVmW+d/HlHCY1jlqNEqX6u0
 Uwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746146; x=1793350946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LErop/DGERkB7CZZF2w1mWsEqhlGZfF07HpoQtKJxU0=;
 b=Ro/JRx1rCxhBV3EVCy24qgQ6JESjUDjqAva8p6jbxhtoI5+yEHPazlPq9s3xwGZCrM
 4zxIG1lbkxlsLS6hzDD21LHX0b9WhY8W/1dczLF1zausjlYrXngP9JqUUAqyXyyt5fso
 bVkzgRLk58KHlPkEFpL88uFOwxkwVPxSHPtfYX0QA9zu1og4sGJLWCKjTIH8kTUz+tle
 kExzZkD1e6UPeP04WaAjxBWTSYyHDePpG3+yFgHZQ3toh2MCCxPHThmhvqZipovniC2p
 QHVNhrOT0qJeu9QdCEYrjN4s8QPjFXetGsN6q9VOYgeDId3eXWQrfqBl3UlZ3aKSn+fg
 rjvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKGwG08M3ik+WrTWNFweAIdrfsCerSTzN57OuqWBODyh5dS+KVF00vD/R7f1W5F364H4sgiGSkU40=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHHFen6067P/2qN/OAixz3swliOfiLSB7qeMOHKmbykD0pPgSw
 Ab/mZseV74L94snqQgVqzBfeKkClEMME3CRUFmCjFlJrjS9v7jBmh7TG
X-Gm-Gg: AYBFou1Qv9AkkQR62OUI+9/ZTtJvOysLuzGL+rGpDbdMaicSMPFoa3oRJ9CY6SodD3q
 LRU1MVLhYzlO9U1fjnGx0y3q3UsWc1qK5UsYJoxpBlcJ41GwfV5YRIy+7ifuYpauLzEDggffKds
 YlB5fPF7Y3o/GM1/E1kjSdD/bI326UEMixbBCNugt4VPKFCThVXaXlmhzRN/Nfoilj9LvghyMjh
 zNcgyWj/6f2KzAvfhskL50pz2jlCl8iRTJWTa+NQW8mcfjHbw1ursZ0Gs9vv0J279KtzUbbLwax
 gKQz1/9avXIZDJBS+Ki1Ps5Apz6ob2MynDilZtE3/m4tCJO3MR84Lf5DYgN6df0CNhQoQRD9WoO
 IHL0htSkDTeUXpZsPkghuqmgUTsFNXMng27Z4DPuzajhuZhsLPa/ii6Mo17/uS4w1MUHWEfmwaM
 dIqs/EVSS9LzJJNdJ2xVBeJ9PmpulRLoyxcvZdzrRdYTVPKMPiuOLCKu7JA84xWLFmqo8X6ieQn
 x6Fy6ZXOSO9CHrQiOUnPu0PnxJzmCntJF+eQ3Wd7BSlk5jFTSN0nhcRdEZiVcS2qm0=
X-Received: by 2002:a17:90b:5108:b0:3aa:fc22:8aac with SMTP id
 98e67ed59e1d1-3adce0cda23mr1334868a91.51.1792746145878; 
 Fri, 23 Oct 2026 02:02:25 -0700 (PDT)
Received: from LYF-imac ([120.235.89.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada49314besm7842720a91.11.2026.10.23.02.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:02:25 -0700 (PDT)
From: fausten <yunfeng.li.nb@gmail.com>
X-Google-Original-From: fausten <fausten@ebizmis.com>
To: Zack Rusin <zack.rusin@broadcom.com>,
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: fausten <yunfeng.li.nb@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
Date: Fri, 23 Oct 2026 17:01:20 +0800
Message-ID: <20261023090121.5031-1-fausten@ebizmis.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <e84774ae-b49d-4df5-923d-ae2cde480aaf@broadcom.com>
References: <e84774ae-b49d-4df5-923d-ae2cde480aaf@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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

From: fausten <yunfeng.li.nb@gmail.com>

On Tue, Sep 2, 2026 at 8:44 PM, Maaz Mombasawala
<maaz.mombasawala@broadcom.com> wrote:
> This patch bricked my testing VM, investigating..

Hi Maaz, hi Zack,

Just a gentle ping on this one. Maaz, did the investigation into your
bricked testing VM turn up anything in the meantime?

Meanwhile I've done more testing on my side. I applied this fix on
top of mainline 7.3 and the cursor works correctly again:

  Host:   VMware Fusion 26.0.1 on macOS 26.7.1 (x86_64)
  Guest:  Kylin Linux Advanced Server V10 (Halberd)
  Kernel: 7.3 + this patch

Before the patch, every cursor update was rejected with -EINVAL
because SVGA_REG_CURSOR_MAX_DIMENSION reads back 0 on this setup;
with the patch applied, cursor updates go through normally again.
3D acceleration is disabled in the VM settings.

So far I haven't been able to reproduce the failure you reported.
If you can share your test environment (hypervisor product and
version, host OS, guest kernel, 3D acceleration on/off) and the
failure symptoms (boot hang vs. cursor path only), I'd like to
narrow down what's different between our setups.

And if the conclusion is that treating 0 as "unset" with the current
fallback isn't the right fix, I'm happy to rework it as a v5.

Thanks,
fausten
