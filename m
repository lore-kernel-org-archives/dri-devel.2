Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCD606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEqzu35H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0C3112061;
	Thu, 29 Oct 2026 07:59:18 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9AA10F6A9
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:47:39 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-7ce78f9d6baso800520137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793116058; x=1793720858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0DswmWoXofnI9OqDL5xwhT8a7C+9NrwyAXFpDB+jHbw=;
 b=zEqzu35HkDHYc4nlHYza96L9JMjXdPkEYcWNpijXJxXGiZ/PWUKv6B9ws7ZohdSns+
 k4mi1OZq3kt30GMdGVTjenIvLKWetGk+E9lhRXeeDtxcnG9gKPZnnEZ/YW6iyyg3PM3D
 N++d+VGGD76JWYHik/5oROAlGVZnTxHAy0DcD0hNs11Y1plAIquQzLUujfHOjaShzBVR
 xsPK1ldbbHiWiZueaS8cJ+Mvpod0NjS2ghd7/fuOuxjLkLcHXvVDTFrodAKpR1W/Bieu
 x3ln93HfD4ME4FoIRw+IHiHLP9VTl3/gy+yYWuzevMhCg5OtPOv18dBUvjvl6HINdn9+
 HmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116058; x=1793720858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0DswmWoXofnI9OqDL5xwhT8a7C+9NrwyAXFpDB+jHbw=;
 b=RElBUm7Pu0l+WVUPSoFPXmxCzhvDuV/Y7P7ZTlkz9vEganAKDgRg9WsgdZpVBFK3ym
 H2zadCtTPboaFGBGaSNTxyH3L2Pjo4vdf7Udv9cUqp71Mwga2sdGfroKtcy7kHO3vXV4
 g2WtrqP8Culkb2qeC27oRO/oq7fTiciQyiIO846LQVA6CWcQHWcwzNSb3VWqx/QzGUaN
 F9A/cOCbIvL4ws368Fv14zFN3JBPJv2EWuuVAv+cgALAVTvKoP25AwRqSylBHUOctJLz
 JTT+JH0Qjsrbah2A0J/ljly9fJksaWDRPvDypzmT96g7ueBRAvN0AZ2NMudgGnmZuaqV
 A2Dw==
X-Forwarded-Encrypted: i=1;
 AKwUvByUdErKNzXIV7Ht5i3To5wahc6OJqLEz56lQykHTF1/sDdQxjaDBX0q59BFx64caISSLf0SxR9yZB8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKK/jDAhWnA4xFf+CNgxaQlYefmBDBC9wnKu9ktvUiWpZ32grjG
 ZcS+RrLAMyXxLydxcML3k4C5CzknW2K+5Ie7PEjW2lQIrmhj/YcQ5G0F
X-Gm-Gg: AYBFou16X0/UD0QaH3TSaF6qK/TYsEqb0dVM0zKH9xfzd/T0f9zoTMaJ8bWHmGTLpFH
 Sf1aqaAE5r/j+7IjV5Xah/+qd2+1u01Vp3ToD9jqi+5/5YUszVxSonvdlUS4a/KbMkJHf4b8SxF
 AUM+dh2gNMw6z+TLWa7pjLSz0hh00HjbQk/Viu8kiKZUtEQqKSG6KyvYlYznmF+VuL0PCgzkckb
 xCXFYqUfG252UKwuOjKhzy5/W3E/vfBzqmWTKh04OdQAH6Y3a8t0CvfcRLke8tHqbC4HNsBBN5V
 FCX2NKtnPtTYRRYkiovzEjLboPozLJLFJ5xQE/OUO264VfR9FI5nBfld4jpJOHTrTiUvRiQ0oMW
 M8y+ef/X3H1DgkYT6BEVMYPdFAu2Q08rOM+WvNO12c+oDiBrwOdPvV+ZVz+ms1x35vEPLR/3BMG
 OAifrnAJwd/A2GPA+YiKMt8V/IDMfVLA/IbpieBNYJJ4+/KSwymJYRd5zvEhdMRNghP3WU/PZIB
 xyDXb5x9FYUTrAbXe9fPkvCFdgoWQnjGbXWiEaAYulfixcyqcT24M4r297lOkNYVatnw8RYovHx
 blk0oHOFX6SV9N8=
X-Received: by 2002:a05:6102:390b:b0:7bb:64cc:1362 with SMTP id
 ada2fe7eead31-7cea1300c05mr1004091137.6.1793116058224; 
 Tue, 27 Oct 2026 08:47:38 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.22])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cea3973caesm2799894137.2.2026.10.27.08.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:47:37 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
Date: Tue, 27 Oct 2026 12:47:17 -0300
Message-ID: <20261027154719.155006-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_OGgbFOJtBu7SwvvnaN01F=RSqtxZgBhJ1fty4pwBHmVg@mail.gmail.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
 <20261027001506.27266-1-mptagliari@gmail.com>
 <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
 <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
 <CADnq5_OGgbFOJtBu7SwvvnaN01F=RSqtxZgBhJ1fty4pwBHmVg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

Hi Alex, Timur, Christian,

Thanks Alex for picking these up, and Christian for the Trinity
background.

Timur, yes, that is possible. The only place where Trinity/Richland
gets the interrupt enabled is the family check in vce_v1_0_start() in
patch 2.  Today it reads "rdev->family < CHIP_BONAIRE", which also
matches CHIP_ARUBA.  Narrowing it to

	if (rdev->family >= CHIP_TAHITI && rdev->family < CHIP_BONAIRE)

enables it on Tahiti, Pitcairn, Verde, Oland and Hainan only, and
leaves Trinity/Richland (and CIK) as they were.  I built vce_v1_0.o
with that change against 6.12 and checked the gate against the
radeon_family enum: SI on, ARUBA and CIK off.  On SI the generated
code is the same register write I tested on the Cape Verde card, so
the earlier results still apply there.  I cannot test the Trinity side.

The handling added to evergreen_irq_process() by patch 1 stays
harmless on Trinity: with the trap interrupt left disabled it is
never raised.

Since the series is already applied, I did not want to send a v3 on
top of it unasked.  If Christian would still prefer to keep Trinity
out of the picture, especially for stable, I can send this as a
small follow-up against the current tree right away.  Otherwise I
will leave it as it is.

Thanks,
Matheus
