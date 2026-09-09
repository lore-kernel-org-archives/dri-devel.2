Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C676AC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DA110E1B0;
	Wed,  9 Sep 2026 13:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RZuFXX5d";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B03210E1A4
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:18:13 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso50726875e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788959891; x=1789564691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HvghOuLjdGckWUGg22tsk2EsT2+V1tsYrjUZGr3klh0=;
 b=RZuFXX5dSk1ajB8BBKKG8pYsUSxKm7Xn6jwzlykhvViTNqmbWplYk0Vc+Q5ZiMj3da
 OyOKL7n15WRnTuicJeLqP3BC+0dMu/LwmrDWXYX25G8br5x8+Fk9KWa/nzrt97vAf8/r
 DDpMRZrQa9STx6jHSUvxx55M2WlR/yuKrm9JVIGDSYQNnDAtt/DZFEsLV7u7lzriksZt
 oXKbV7wwhF6ZccpvzbzvInqKtRBQXvGNFj3SBCdrcAtF4r0N9MdyavK0HOymunwzc2rK
 zdSCjazL9kfpBMvhOmjRbI8Khe7ot+jUMOZPutERIhWZ6pBTXh/kHfMNej6oYJ6UI+kS
 uD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959891; x=1789564691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HvghOuLjdGckWUGg22tsk2EsT2+V1tsYrjUZGr3klh0=;
 b=aQYkw7G89IdMjEewEHhsSMW95NEsRYOegGXGxYr6YsmcBxyYfsKnu3Fi3/VezW+7x8
 ZMheoz7lKqQyJOKijMHhhTL+zgyHWbvYTgE3i4QQdWj4xQrreCdJH+N25N2AWG0dSfB1
 s0bDMSHVoDVUhH4+K6EfP3Bzf7tOAoQoSR/83/T14N4dCVwr8e+DwBymnIFVlOR2trmk
 SmCX27hPqMJSZ1oudKw7T9Gd07T24eGL7vE5LAFen2njrSkccHJFk7X73CyLhdloYC/i
 wGd5rdlkLUSkM675h9j9AfHFQC9Yq5Jki08D44VoR4gFjjoIUaGvVbwIKUd0v2fdgJaz
 fuRg==
X-Gm-Message-State: AFuF++k6wn9JR2fdaOlihu6oYPnWMErQTsdHg6Nxaz56nxrUOJ01h9HH
 gau4GjsWe91FbWxAW+SrjjkX+0L8MoLpvfXUQL394brp3LRJJpNYIhO5
X-Gm-Gg: AYBFou0uh8Z/tDv8Okl8+vEQZbmbc3vtNNsB/uiSobHA37LmDXjk8fHARnjSsv91eRy
 epOMsDv6Je7Lgfy+YsXPsNjez0rLzzR7j2k5OMmYGeWtJZhmNMWsruNA2/GvTYw0d3f402k6sSl
 sOG6fhIlgWc7o7yaUuh6qvd1relwQEgPoYxk5bwFj1RB+99yC1OhLucy/5/YYwWgGW5DX0fHbNr
 Zqwh0EJ6PEdy7qzVegqmzYAY2rRTFomexxhrbM3uQ1oQgMPItFxy2WBvDa6M0uxhtszbvBLnMXI
 YFSyr+93ekvEvVUmZzqwP7oSlLiUimXc9IsqNfqYmjZYdQmc3NPJarwCjtc5Kqb37A2tHNQfQAv
 r4Q5pxqwvVq3+uF0OxOJpLqQpCqtnL8OQJONQthqfQxb4mgtcvIi9jSWDnqhnhrpLaGLRE7xZMv
 uOOS7PBLj+5ESnYi/bHt+BZIKt4ltSJssZ8UY18KT5QXql4MEUSi7dHJJceHPfjGk5KfDpHAz2V
 MxLa/3tTwmR
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49cf82a514cmr371518115e9.16.1788959891201; 
 Wed, 09 Sep 2026 06:18:11 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1568:cb00:7389:2b93:7e4e:44c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm555457755e9.15.2026.09.09.06.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:18:10 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, malhyuk97@gmail.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: Fix dma_fence use after free regression
Date: Wed,  9 Sep 2026 15:14:22 +0200
Message-ID: <20260909131808.2201-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi everyone,

as discussed in a separate thread Jonghyuk Kim(MalHyuk) stumbled over an
use after free which we through should have already been fixed last
year.

Turned out that a recent patch regressed that by limiting the check to
the ops pointer instead of checking both ops and signaling status of a
dma_fence.

Fix this and also add a few lines of comments to drm_sched_fini() to
document the necessity of an RCU barriere after signaling the last
drm_sched_fence object.

Please review and comment,
Christian.

