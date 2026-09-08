Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE03C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3EE10EF3C;
	Wed,  9 Sep 2026 06:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9Bl6cAv";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDFE10EB0F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 10:49:18 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so5807619a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788864558; x=1789469358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H7Reb5/FkRfbcDYcZ4Sxy1Xn1C7+jIuC2a5ZFlPXPUA=;
 b=d9Bl6cAvu9svBVoTKaJM7/1cU3J+GPu1LYOTs25ew4U+zDdxh594ZGjOBAsEWpFmeV
 l8Usc3/Ap9CJMCq1pzdzJQBTGDE/BPbKFGaoLQpwCQJkWKEo7waXzS3UjPvdPyauCB0L
 QdlPfc3njuTt8HZUcVplKsa5qEYjt2XgVI401Bd4RwuwpAX/GFqVOy7O1LeALExbD6pf
 bDFN15Fy9p6qETCN4e1mVg20gUN9ikE2j2m6+VJrz7BjuPuanJxNN3uLtbohPxShLOt+
 4TOQDSPsD9WW7IqGg8oj+mtPIa+diw/EwAkjyQT+VCEGJ/fjRl1IDfJMcwcGu3ipytUb
 Ouhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864558; x=1789469358;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H7Reb5/FkRfbcDYcZ4Sxy1Xn1C7+jIuC2a5ZFlPXPUA=;
 b=E1xVI4bFpfOg64gPCjDx3i3pWN9W6BxWiwIYOLvayYW1f0fsZ0HRxvMbUJJPiJkk8O
 uQtid4uWbEVjOUqRQ62M/hy+37zTVK/+0dazPgjrwziUPjdzP5vKY9QarKv1T8yQJXFL
 /GuHE16wvh2PgUZOCa78ICaKrofqB/WrlbI8zhSoxjgZVpyIF5S9mmeTaA4RwzbDPewh
 AxQKv5WlYKSIBVD7OtqYt3e6qn2+P75dHU+w0hF8dLPuq4KXZygD92GcPAIgRQYM44iV
 86i6HjlpBlomxcmDhn0xop1qk4D2HKDaB2x5JQYZ5eO2KJFeaMitn9rpKCE6DugQSo8p
 cPZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCM2y1jy+nPGMJ5pE3j4R833fo6xh7bf9X1iSElX1/yR+RDFwzPhw4u0xIuVL9qCSIsns5Z3vX+0o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1BY6o2xkGe4DK1DU3tZ39SGAyept3lxbFpY8cR0PpYayACvu9
 L5BS9xyGKWldZMPDHvaacV4qpLE0IIjqlrsr+UhFmD9SnZ/GIVKlcte10O8NOclRvA==
X-Gm-Gg: AYBFou0D5pXPSwUm56wNV+qqVruHftrvX53BXAMtCaN5Z8BKOfpRUHz7RD+4nfYxWop
 2xjkMDAY+jNzX3rG8hBPSsC9z9my5oluFeNM4Rn8eUT5zUo1zYlLuF50K5wMMSWkV5MOnzYBXXH
 08O85nx7WP6Y9IpyyC8adTbgqU5ogbeWCwmMyR62VvUHL0/KNlrklp7YZR/UHaACFnfb+LIdAcN
 p7dJR1Gxg69i7F2TbJ+s2z0W/kZqvXabi30/Wf5dOQTw9xlMJFB3AEcM88DYXWZ0xAtJv535+mR
 2jL4Pmffzr9OMnh8q5DFQzu8cpwZSAMZd4tCHKD44gJRDXsKXP6M07KaESiDf0i5uHWMtE7YIv3
 7yKwvova+jvYegD6BotumGqmfIJUdYaPeZipGjyBCoETGnyBUhIIgR40Z0FjxsnMzMQWU2cUdLv
 GP+lfSS+77fqiLHS/2LDzyXm85sI0iaC3kEmA8h8mugQjkx5VhL8S7BjEkmyMR+Mp4GdKzgFV9Y
 h2oTmywHHucwSNmQkwncG3Mx2U=
X-Received: by 2002:a17:90b:39ab:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39b261da75cmr43885301a91.21.1788864557719; 
 Tue, 08 Sep 2026 03:49:17 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260f64ecsm26116182a91.8.2026.09.08.03.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 03:49:17 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: christian.koenig@amd.com, phasta@kernel.org, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: Jonghyuk Kim <malhyuk97@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mdaenzer@redhat.com,
 alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Tue,  8 Sep 2026 19:49:10 +0900
Message-ID: <20260908104910.183638-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
 <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
 <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
 <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org>
 <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On 07/09/2026 17:21, Christian König wrote:
>> Maybe Jonghyuk can give your patch a test run and then we could use
>> it as a hot-fix to backport
> 
> Completely agree.

Ran 0001 on v7.3-rc1-99-g89a312991dc6 with the KUnit regression test from my
v4 3/3 (mock scheduler, KASAN, no hardware). Without it the test fails with

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name+0x9c/0xb0

and with it applied it passes. Reverted and re-applied twice, same both times.

Tested-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

Two things it doesn't cover: it's x86 only, so nothing about the load ordering
you discussed; and only the signaled case - for a fence exported before it
signals, get_timeline_name() is still reached and reads fence->sched->name.
I haven't tried to build that case.

Could you add a Reported-by for me when you post it? I'm happy to drop my
v4 1/3 in favour of this, and can respin the KUnit test standalone so the
fix lands with a regression test.

Thanks,
Jonghyuk
