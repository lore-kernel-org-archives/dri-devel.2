Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC998606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQgToXD/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56D310E0F1;
	Fri, 13 Nov 2026 20:18:02 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A1A10E0F1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:17:56 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6b596569640so3385620a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:17:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601075; cv=none;
 d=google.com; s=arc-20260327;
 b=L0F/sA4ZPORBh4aNGndtI+y/aXjKhJu7oZ2p3keMcSScz7czhkHpg2zBsv5ny5Hyfq
 n/I5c0+isY9falwcjlOD7pIjgmNkNpyWJi67+ul428JLmcVxdWgIO0CGCAOzdtHQGFMA
 XtnugwloCCF2MFJu9bT56IVjZ82rDdh/8Hy8ZsxvpQKu+vi3UxwOWa4jtSnPdmsJAl1r
 8H0dsj0UXVPGP4RfiM8px6l+DXuDSc77uZVZrhcpHp2zbArjx/ZKd+0LtVzXWzbmgahR
 h3dTH5nsgaSkZ7Mun+lccEkSfNLijRBa3lZAtsyX9SmPR2yHI9KPwVhiQiYZjMOqQYze
 olXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=JbmXpv9XX0gSrvsJb9+bsBLMe48XgmKOacujAZ4N+rI=;
 fh=oa7HM1yJ0fAYhRdWfUySMelpSsFIGNhkFbTT/Ck/yM0=;
 b=BExVRDU5kskhADsRyBOIY5oPO/7KqmfjTWwypK74w2S6hXrjZ5hJrYPJOQLnxUdys/
 ODleU7tygWIjipW8la0Df+h/NFPVv9x/OZGCt/4iuwzUvGSzjwejgUeLT9tW6vpDsjXG
 CZVbVpg/GQBDRezDf7AiwZxPhJktaAR7wNrJmjOiGcxXnbxt26lysHGAaX5ckcufaOra
 o/18SKJkbSLHjbK5yHY49uomd6Eb+eTWmHR+/nl5AnNBjisyN3u3YtDHOzQhksHsGK/u
 UVnvyENQHVoAEBXViBMWOH7cwnNw2AUKWkmQ+mcrdXqAsSWHMeLYa16aOyYFKOUJmvVP
 Bmyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601075; x=1795205875; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JbmXpv9XX0gSrvsJb9+bsBLMe48XgmKOacujAZ4N+rI=;
 b=pQgToXD/bFEbu0NzHSRo/MQjuyevmr8vUVQ/xnYb/2JDIvTdclvt1vtech7kE/Iiey
 rsg69DVgGP9PixVK7J+Wd+HZKpLR0lieEvUu+SNTRI5V4Wo/dTYsc4PaPaIx/rmWhs0Z
 P8Wu3Ry3HhXSO1KDdvnEdW4ukGoo5RFSKVAZG1o6e8sQePzAZoZ1QyviVBY6d6cMN9TH
 W5KaesBcVeWhGE5K1tY+LoHxtcYGmWQZhUzLmwwkUXRqKfHE3P9n+TLA8aPq+UnyRnWj
 zO9Wcgb/NXU7fMHF7c531yX3FNeETzCBYj8h+f5EQ+ihlZYlhaOI8CG3FIC+GGaTv8Vh
 q/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601075; x=1795205875;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JbmXpv9XX0gSrvsJb9+bsBLMe48XgmKOacujAZ4N+rI=;
 b=B7R22WbidDvEXJmWgIQztraouqCRjIVzeAR4osyAiNneNmy+yOo2yMiUevmGYK6mp9
 AmIlkHMBM2Ra6WJl31h6QWO0ieUolitIxquaU+4DufjW6/6NejsNyTURokqahiAw1GEQ
 mdzGHGZmdQt/408WGd39eGboYLwxbEZRk2Ng3uURkuEDydbhq9kcAiyydlKOK2OX7SeO
 +2LjU9y+uSFbfAiV3O55dX3Tjyv0q/65RbzpYGgJSjsoThkFntzhnt5Qa3l+q1OKYiX5
 sIjTihLAClmfTgU1lZ1cI16gtetiAUM2c2v0ser46LR19evCdpGgmiUJChB+iJBiGvtQ
 sY1g==
X-Gm-Message-State: APuU4Z+246TKgpbQTYwUCPqUCncXEXECxk1r2h/NGiYgCGzU0onJokAZ
 9DooPTQCQbyalP0s0sLvhQE0DOAtFkP1oqch1Dp/I/T60coioB9SRzYKYQ6fZ5UFCog1UtqFt8k
 QwoW5DruQuZ14kEAlFhi5rEu5FXRYCAs+DrkIecU=
X-Gm-Gg: AYBFou17dlsaQNY/nyGVcZVYn9sThc1vkSaZe0/n52aUITWTNg8V0sAdk20wUPze81I
 suxr4yOabloEt020AgTdZsXihOWWdP7SoWEiy9vN3YIZYSPvl9fqDWGQwlR8GE//MB1h8ZVnNGJ
 wDa5fgEKwdC6Zvl/yBcB1KuRaL1swjjeEq3om6rX4iIoTkB8bl1LG3eObp93LBYnRW+fy3eNd3w
 +3bWgLGqWlZmbdKYSX2sFCPbh4XiVrvrnnc10qoV57nNI36QPijKX/NJFyEfQT3FdN4rHrrRo+5
 bY+IbqmhloP9A6BwkMclQr8ur3hKUEMsmKYix/oo3ovAO2KFG6rtKB4v8DD/soneqJZq2gqhJFP
 hMviWRJ/LNms60VsVDisD/Lt/AYFylO7tz1I=
X-Received: by 2002:aa7:df12:0:b0:6b7:c855:f2ff with SMTP id
 4fb4d7f45d1cf-6b7c855fcdcmr1952115a12.2.1794601075012; Fri, 13 Nov 2026
 12:17:55 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 13 Nov 2026 12:17:54 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Fri, 13 Nov 2026 12:17:54 -0800
X-Gm-Features: AclHuK9acmPCMfM51uw-UacL-LftQCceNWUuDGqvNd_iVxMr85uyjOQtzwmYw7A
Message-ID: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
Subject: [PATCH 0/10] drm/gma500: fix GEM and SGX MMU failure handling
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series fixes existing gma500 dumb-buffer, GEM and SGX page-table bugs
against Linux 7.4-rc2, 7475ea8b58616b33c04afb976cf0fbaad9dd63fb. It keeps
SGX535 support and the current driver selection. The series contains no
architectural migration, new rendering interface or accelerated admission.

The existing DRM ioctl already checks width * cpp * height. The dumb-buffer
fix covers the product after 64-byte pitch alignment on 32-bit size_t.
The unpin fix uses drm_WARN_ON() and retains reservation-lock cleanup.
The cache fixes separately address a directory-entry flush after unmap
and the unconditional clflush_count division. The former is exposed by
32-bit HIGHMEM with CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP.

Following Joseph Telaak's review of the previous six-patch RFC, the MMU
changes are split into zero-page semantics, the incorrect stolen-range
unload address, removal of absent mappings, range validation, and a
transactional insertion/error-cleanup unit. The old inner do/while loops
executed once for zero-page requests; they become no-ops here.

One deliberate exception to splitting every lock change is patch 9. The
write semaphore, prefix rollback and newly introduced GEM page-release
error paths form a single safety unit. A rollback prefix cannot remain
owned while another writer is allowed to change the range. Keeping these
changes together prevents selecting an error-propagation-only patch that
frees pages while stale PTEs reference them. The temporary host fault test
explicitly checks for PTE references before each put_pages call; removing
rollback triggers that assertion.

For backports, take that entire transaction and its range-validation
prerequisite (patch 8). Do not separate err_put_pages or weaken writer
exclusion. A textual git-apply result alone does not establish safe
backporting. Fixes tags were checked against the original introducing
source: 8c8f1c958ab5 for MMU/cache behavior and ae012bdc5799 for the stolen
mapping and unchecked callers. The unload fix uses the load address,
gatt_start, rather than mmu_gatt_start (0xe0000000).

Current validation:
  - Native, UBSan and i386 CPU harnesses: ten MMU cases / 50 assertions,
    twelve extra fault/cache checks, 48 GEM checks and eleven fixture
    allocation budgets passed. Kernel services in these harnesses are
    simulated; no device or GPU is involved.
  - Actual original sizing arithmetic / DRM alignment-helper boundary
    witness passed on native, UBSan and i386 CPU backends.
  - i386 W=1 / HIGHMEM4G / forced-local-map gma500 objects compiled.
  - Normal x86_64 W=1 gma500 driver objects/archive compiled successfully.
  - Full i386 W=1 / HIGHMEM4G / forced-local-map guest-kernel link passed.
  - The actual guest kernel passed all ten software MMU KUnit cases under
    QEMU TCG; guest exit0 and parser exit0. This is software emulation,
    without a physical SGX/device or hardware cache/TLB validation.
  - Patch-prefix replay and source whitespace checks passed. Checkpatch
    has zero errors; the new KUnit file gets the generic MAINTAINERS
    advisory and is covered by the existing gma500 directory entry.

Hardware display, GPU, suspend/resume and platform validation have not
been run for this candidate. No upstream-readiness or
hardware-validation claim is made.

Patch list:
  1. Use the common dumb-buffer size helper.
  2. Prevent GEM unpin underflow with a device warning.
  3. Flush the directory entry within its local mapping lifetime.
  4. Calculate CLFLUSH count only on the path that uses it.
  5. Make zero-page MMU requests no-ops.
  6. Remove the stolen mapping at its load address.
  7. Skip absent mappings during removal.
  8. Validate MMU ranges and exclusive endpoints.
  9. Make failed MMU insertion safe for GEM error cleanup.
 10. Add software-only KUnit coverage.

Thanks,
Gabriel Gama
