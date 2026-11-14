Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCD606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EX+vyd7t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EB510F023;
	Sat, 14 Nov 2026 16:25:02 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D0F10E16F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:20:25 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1b50438451fso35566c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644424; x=1795249224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P7gyRMTycBiU+K9V2+iRGyig/k7M3DfU55SoQH+FP34=;
 b=EX+vyd7tcsuI28TPeHAPlrXrSnQCEDLSIF7ArTlpl8XgVW2dJewqOA1T5mUSt2e934
 e4XAwvj01pcEUe/qmNCy3DYbKPIvxtlzd386bplLmVcKaH/yuGnTDkvs1qDRcxkc3BQm
 4MFKD/lRF3+FpbrZjSrCfvQXBNYWqEHHk4OglBIEKSaHBAv0QaGegN6DtDJoHuyCGueV
 PcvVaFiL2+WGX9TbYeici7lun+PF1WAHgdQh21+gbswadXHmOwTf1gmjeteG5LIsAoDF
 zDyp/MR8uee2UCyRaCwwkudX53hc23ijqJoemZWV+0pLh/NuptPr5QnqU/LLVcEoEd5C
 n2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644424; x=1795249224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P7gyRMTycBiU+K9V2+iRGyig/k7M3DfU55SoQH+FP34=;
 b=c4e9lXzk57zJKSs0kJaVyq1dMBobwNZ02z+R8KlX0B18cAcyIEmB8Mff3n1SaFRweG
 /mZgCdY7QQTcYppxmWaFEMkbPo8WBZzvf8OsLIVjnNyXFimXJwGTLz6WV+DYaOP8I/s2
 UzeXpCE5k3g6JNpxgz9a2axd8ODk5EVWgQAzMrFn62IyVMWmxXuqaal9iP8lgxWJ+bMG
 T8oKxtr+FvDf83e6HMY3ynCMHLHTQQUylbHrf5ffF5qxPiQBFrjAwW1aM2ps9KnZTsvN
 PfFaq1oiC8JK00BPA18dXBVEtm0WUhzmiJtqVFmvNx7p8cKOopMSym0xbqz7pAETLFD1
 WmDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFmigJddSAMNq0WSAHiLR8YSJ49hn7oLvfvvUrVVqmkPa8VVCNYdv85p8qkfksqRyn+xW+2h3SJqHM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/oLYRH7J07BFZiSNcvIqwItu03gP0pihGcLcKEKchLriFyyDT0
 pl/uiHHY9ysMQzUSkqPTVvR8EpYELy/C8I6Oz2/1m+SB8m0yaXF+uBeL
X-Gm-Gg: AYBFou3f7hr1PAVu1ZyfyLcCaZdGpf62hRL3kxyepgA2sN8BFyLnDlO85GD/V+gzMLx
 RfaLQMmZoLi43lfu1Z/L6Txj7vYyVv1hWjLYH+1cWfvjUROuRrGo/pgIMTT+cNnyqfL4Ubvpz7U
 c/0bEYioo6mLeRpoEZJ+YE/6+AQjRS9emWoZvD/kqct84SoO+mczr03mjwlKVEoHmIsPDJpIlFu
 mvJJ3tMCsutGJDRM7pzV5lseqCCtPHfDVlXFp4bVStleQSWuwx9ZeWfX4t6be1ixBQ847/UdgkH
 DLPSnXofCmokHIU4OCZprc7Du5liIsAMAqYK3ge1iwGLp94lhZLK/39rniCJC6/6yuXjvPujoMz
 bwIMS4UpxRUmT4CmwjMpxZ0t1Ijy/GAAPriE0ZQegjXL0IC+mPny4Hunwa0Ie7MCwaKhNicwXx0
 PyHs0kXJYxH6HDc8wLOAOLFH9Mk/tgE4unnQFn92qSO/AvqW1oz1v95LIr6LHAFkCRrd0GItI4N
 dzUTp84YOcokll1Xqvb/TNyCqYoqALyur6CaO96t1qtLJMA+iJCjziHnslWJeaHyriZurDNHwQd
 jwwrdXdcz+9sZSjNcWaO/DforpJmDb6xbPICf9SQ0WoEXJQyGdz8XFDzpuhoHZOHSXFC1ufzoPW
 d9V8rrY8A+jdrfGd6zlLLq1jE1Q==
X-Received: by 2002:a05:7023:88b:b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-1b502fe08aemr8181038c88.0.1794644424293; 
 Sat, 14 Nov 2026 00:20:24 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:20:23 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 0/4] drm/panfrost: Fix jobs that outlive their JM context
Date: Sat, 14 Nov 2026 17:20:12 +0900
Message-ID: <20261114082016.2454-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These fix how jobs are handled when their JM context is destroyed,
explicitly or because the file is closed, and the error path of JM
context creation.

Patch 1 makes a job hold a reference to its MMU context. Patch 2 makes
panfrost_jm_ctx_destroy() find the jobs of the context again: it looks
them up by job->base.entity, which the scheduler clears when it pops a
job. Patch 3 stops a job that is queued after its context was
destroyed. Patch 4 keeps panfrost_jm_ctx_create() from destroying
entities that it never initialized when it fails.

Changes in v2:
- New patch 2, and new patch 4 for a related issue, both reported by
  Sashiko on v1.
- Patches 1 and 3: changelogs updated, as panfrost_jm_ctx_destroy() did
  not actually stop any job before patch 2.

v1: https://lore.kernel.org/r/20261114062637.2447-1-arpe1618@gmail.com

Jiwoo Kim (4):
  drm/panfrost: Hold a reference to the MMU context of a job
  drm/panfrost: Find the jobs of a destroyed JM context by their context
  drm/panfrost: Stop a job queued after its JM context was destroyed
  drm/panfrost: Don't destroy uninitialized entities of a new JM context

 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c | 91 +++++++++++++++++--------
 2 files changed, 62 insertions(+), 31 deletions(-)


base-commit: d48ea86919434695da12d280dccab72b094397e1
-- 
2.43.0

