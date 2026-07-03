Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BBEC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84D010E61C;
	Fri,  3 Jul 2026 15:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ArhJjOTX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D6310E610
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j+hs82VTl26SVVcJUwG/SI+AspMhcWhpAmy5on17Zm0=; b=ArhJjOTX34EncUi/UGfPj7srax
 K1MSeoaXfFPg75mpeYzkJX4LWcp51lYAJqWIX1RT848Z1C+Iu4MwRItAgN5qPTRvjZ4ZkVWGKVODx
 T108Pt00wBwNBNL886c22Jrv8lbltiSoM2kBaeAfzQAV+WhirNfznEK/eDDYwbDiRqPHYpmD+hNaL
 U5tf0N5hBJCEw0cxXXl5vqS06R6YrOFcsgM52KmF9+x7u8IRKfwMOV+sbuk5MoxkPqfYnEbOBAVDb
 44JPkd/ZdCHB8DRNMMhf7Oyw9Wmy5B2v9s++s8ZosDnrG7oiux1VD0Yj8Z6+hAGspj6Ps6u3Rl2/2
 17RvdUrQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wffte-008Xuq-Rv; Fri, 03 Jul 2026 17:33:43 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/3] drm/v3d: Miscellaneous fixes
Date: Fri, 03 Jul 2026 12:33:33 -0300
Message-Id: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ7CIBAF4Ks0rB3DT23AlfcwLigMLUZLA0o0T
 e8ubVxo0uV7k/fNRBJGj4kcq4lEzD75MJQgdhUxvR46BG9LJpzyhjZUQRYWzPiEa2jB+RcmcC1
 yemAtotCk7MaI66HMzpeSe58eIb7XF5kt7VdjdEPLDChQq4yUSiq05uQ7ffN6b8KdLFzmv4TcI
 nghHBomeC1rZ+o/Yp7nD5hoB7T2AAAA
X-Change-ID: 20260609-v3d-cpu-job-fixes-fbe2051bee3a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=F/gOO+mk55RutBtxZH/GufslTMMgKlbTiDVC2f0q1IU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqR9ZTFXT/NdWqPOzm/ym7Of4ZG8U7iywYleOK0
 fzgAJkKtqSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCakfWUwAKCRA/8w6Kdoj6
 qqEbB/9rR8U0M19ftKK/F7MTZNaMv/QF2aGMQ8Oi+k38xI9q7PT710hHfMj2JakdmttTNFEeSU1
 dHxKrR9X4lAK+jtgKAErunmlAZ/zzEMOLb5cDQWYcQddi4ikpodzNVa/mNK7m7+hcOU5YH77wV7
 qAlLc3vR3dVCodwbXISXrtfwhxGcGRXwahvY/dvutbAWkHbPG75wzPPt8AH8whqiSqokRM5T7Ye
 /eZ5tfjdypYabGOUjYdBaALgCvjpsKOGub6xZN84Zs6ZF1FMv2J4D0i24Tg/6Go1/u7jDjha0Rw
 Nb3kZxaiRjztTr+rVIX4g/sGiD3h7AyLTABox6yzeFY4wGIJ
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Being brief, this small series collects a correctness fix (#1) reported by
Sashiko, a error-path fix (#2) reported by Sashiko, and a cleanup (#3)
found while reading the code.

The first patch is the only notable one: a v3d submission expands into a
chain of jobs (e.g. BIN + RENDER + CACHE CLEAN), but the BO list was only
ever attached to the last job. Since implicit synchronization is added
per-job and gated on job->bo_count, every job before the last one silently
skipped implicit dependencies. In practice the RENDER job could read a
buffer object while another context was still writing it. It's fixed by
looking up the BOs onto every job that references them.

Best regards,
- Maíra

To: Melissa Wen <mwen@igalia.com>
To: Iago Toral Quiroga <itoral@igalia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com
Cc: dri-devel@lists.freedesktop.org

v1 -> v2: https://lore.kernel.org/r/20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com

- [1/3] Don't attach implicit dependencies to BIN jobs (Iago Toral)
- [2/3, 3/3] Add Iago's R-b (Iago Toral)

v2 -> v3: https://lore.kernel.org/r/20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com

- [1/3] Add a comment clarifing why we don't attach BOs to BIN jobs (Iago Toral)
- [1/3] Add Iago's R-b (Iago Toral)

---
Maíra Canal (3):
      drm/v3d: Associate BOs with every job that accesses them
      drm/v3d: Reject invalid indirect BO handle in indirect CSD setup
      drm/v3d: Use write_to_buffer() helper in performance query copy

 drivers/gpu/drm/v3d/v3d_sched.c  | 11 ++--------
 drivers/gpu/drm/v3d/v3d_submit.c | 44 +++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 28 deletions(-)
---
base-commit: 903f8773ee96c5dc5fb9aec65227f39fd3e7a1dc
change-id: 20260609-v3d-cpu-job-fixes-fbe2051bee3a

