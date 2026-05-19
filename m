Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49072CD5BAE
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED1510EF37;
	Wed, 20 May 2026 07:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="boFELgrf";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F56910E0ED
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 19:41:18 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-83f674f978fso1234179b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779219678; x=1779824478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5zkIDXNPi64nFlT7okV3y3GeLL/YTDVtR8pIYeqBjA4=;
 b=boFELgrfqRLBHlIMN1+Kg/IhAWhA3z/5jxlrd7qUk6ov/AfztWEXcUKMzbOcV1eEao
 7X6XSkhBH1iEuE1g8W406Mj1evuTRz9fQ9fmYe3RksNJPH9nVn12wDkFIoOm0ODXQkRH
 xFlQGSmdxJa+AgERdAARfYw4QzuRLT7OzrALDppp3dXLY7BxCOTswE+2LAyU/elvUbyN
 YAU1vJMaU7zf91LLSYVq5we4XpwoL8ESeWBiesFy0beqNx3TX+cZY/eosvAgYKgZKgVq
 I0nqJ4rt6iYMpfHo24IJthSGwmIPXPlBxiR+UPSPCf6z+ZCc/V0kG8s1KIk4yswz8oiS
 gKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779219678; x=1779824478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zkIDXNPi64nFlT7okV3y3GeLL/YTDVtR8pIYeqBjA4=;
 b=axXOQb3eO/ECS9PcNWgxjt+A+X1j6cGLhJzUaryuI+PLaGH0qx5vLNkefX/nf4loq2
 h/UyBI0NMGk8TIVhEZFt+x2RFYREdw4CB9kyqMfLTUWX1Hu83kBHk1v2uTsZX9v+sjei
 W1kBTjkDGxahUOzGx0AohiFqL728p3cdxxohz21ehxK2GEzy6Z3np8cvZ/NHdB5jWAt8
 S4uLs5WsdkhApr6OCNM+PrlOG6yXocNOKcYZrYMRvQuVWdHx4X40ajw1vl5+3rDafCEg
 dHiKeGed6C/9+p1mEqCuMZsZaDf23Ix9cAt3fAhq7UfnKCSmT+X+zVUF4ZsLYM86hOgZ
 UOPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Iu+KcwN7AoqCSQ3TnCRVdwo5CV61P0sRaxgRsDQxl5BThUvMkSxqX72zW07h5sMAbsWqn3yvSUzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMyZgM3uMALEZvn8L6EvbPsq1bhZ7Lp4d3WfkdlJ33AnGZU9J3
 RUebhJFjm05GJhs96x5zUbOAZGA0wgX8hEX77rcdssozj8NZVEJYEcQF
X-Gm-Gg: Acq92OEAh+vgWqRJHZqsXQCpPshfkgoDUvCJweCqDD1VULzlNuE+7GHyTJ7UN/E9+hb
 t7IHo01kmLvLKiS80Bfvobia2ju/QAQRJEUoXPlg9PfIyqBwMfJt4zu/lEcHa3s+on9BsIsx47L
 qkAKf4fARN7QBbvSBZyhNMP+CbBbgDs/sirRMNYZhqWHy9Xv28Ga14TBTxDVOlZtL1+HoIsj9pw
 D2LW4NMhKMJYqplkoGTYk9B02Ett9pqZZHdr488F3IeOt2dsoIjkCHlfiSeyjU0QneNdeJeoYVS
 ZlWEP1KpT4967OiIelfwtUxhpi0w+U2uwalUfT2bBRDXnNI94H3zbeY/GKigleOc3s2xbcOE6Bc
 fXDFHeeFWDr+muVq4J2ydg0Yn2IA5e5inpiCDBhy7hlsaZtNjRzIVXZYeaaRyxH1kQgG7WtxGWE
 7+9JN/lbySyV2VwBb4+Ql/nJwMkd3j64hamqGwc5QISnQbRhcR
X-Received: by 2002:a05:6a00:90aa:b0:829:8c08:d1f4 with SMTP id
 d2e1a72fcca58-83f33ccd856mr21588284b3a.39.1779219677970; 
 Tue, 19 May 2026 12:41:17 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5ceb3sm18604410b3a.34.2026.05.19.12.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:41:17 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: drm/amdgpu: dead empty checks on e->list in ring_mux ib_mark_offset
 and end_ib?
Date: Wed, 20 May 2026 03:41:13 +0800
Message-Id: <20260519194113.2411822-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

Hi all,

While auditing list_last_entry callsites, I noticed two places in
drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c where the developer
wrote a NULL check for an empty list but used the unsafe API. The
check is dead code. I would appreciate it if you could take a
look and let me know whether these are worth fixing.

The two sites are amdgpu_ring_mux_ib_mark_offset() and
amdgpu_ring_mux_end_ib() (linux-7.1-rc1, around lines 497 and
530):

    chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
    if (!chunk) {
            DRM_ERROR("cannot find chunk!\n");
            return;
    }

list_last_entry() returns container_of(&e->list, struct
amdgpu_mux_chunk, entry) when e->list is empty, never NULL. The
"cannot find chunk!" error path is dead code.

With an empty e->list, the fall through pointer aliases &e->list
inside struct amdgpu_mux_entry. The writes that follow then
corrupt fields of the mux_entry at the corresponding offsets.
mark_offset writes cntl_offset, de_offset and ce_offset. end_ib
writes end and sync_seq.

e->list is empty if a software ring submits an IB mark or IB end
before any chunk is queued for that ring. This can happen on a
fresh start_ib path, or after end_ib drops the last chunk.

A candidate fix is a one liner per site. Switch to
list_last_entry_or_null so the existing error path runs.

Similar dead empty checks after list_first_entry / list_last_entry
have been cleaned up in the same shape, for example commit
fbb8bc408027 (net: qed: Remove redundant NULL checks after
list_first_entry), commit c708d3fad421 (crypto: atmel: use
list_first_entry_or_null to simplify find_dev) and commit
10379171f346 (ksmbd: use list_first_entry_or_null for
opinfo_get_list). The qed commit message describes the exact
shape we observe here. These two sites appear to be missed by
those cleanups.

If this is intentional or already known, please disregard.
Otherwise I am happy to send a [PATCH] or to leave the fix to you.

Thanks,
Maoyi Xie
https://maoyixie.com/
