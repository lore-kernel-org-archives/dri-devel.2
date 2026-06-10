Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26D3CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 22:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A43A10EC07;
	Wed, 10 Jun 2026 22:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GNPGFIbj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C29110EC02
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HOUisjRPiagWPkm906ixgF89ZGY8Ls26pZOVNLDovGw=; b=GNPGFIbjBb449bcXucaKfG3Rvq
 Z9YaTsqcploh5Z8uoaKfPk5N/ePRX9HAmEV4++5Fa3TPpf2lr+nts+4JMv5AxBejkjzU1yQ4OGc03
 CGwHvIaaioKqurg05oaPWTuauooIlXbChshwlbL0kiX3LTODaA+9K3tvGrPvGe2l2w02oiTZaKfyw
 Sa/L3IjNW58mwy//W/57r73qXxDKd/o3+q/25rzcL5HRdmVl2Z/2dUhu1x8DKzMi2sUy3EOk2ru7L
 FawUg+14di3fPRZtBexJPJJgl279EbY4Se99Xee61oo8E0QPSpL5O1GfEkIJKPjR4yWD74udsKx/y
 7zqb/VOQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXRlT-00FrrZ-2l; Thu, 11 Jun 2026 00:51:15 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 10 Jun 2026 19:51:00 -0300
Subject: [PATCH 2/3] drm/v3d: Reject invalid indirect BO handle in indirect
 CSD setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-v3d-cpu-job-fixes-v1-2-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=7/TX1912vtttcPnEeRCrkrxpIEErjhHE/LnO4RkuORc=;
 b=kA0DAAoBP/MOinaI+qoByyZiAGop6lqh2zlQDxRanztQIN6ighFDkWx9SipES1R6/5uZiK21o
 YkBMwQAAQoAHRYhBPjkXX0BFncHKaZ30T/zDop2iPqqBQJqKepaAAoJED/zDop2iPqqcg0H/RAd
 MKAkSbu8ARjTHl6LDyE3VxMtdofuu6wTv+Fw/dznF8DSsK1NAXDWE3N4shdbyS0T35b16Dj68VY
 piWCEdRkKhy7Ti6VQG/f425GaK2EzwFKINjq7IDOtTWBo3SD9Kx1Rgfm3EfEguPUTc1CGN1fXlm
 LIUCLVVPNs7kLcfgSnlygCipVmy53vSjKOWhoH2LKBMyqzT5Fwi7TcDDAINEmJbpFFiJDGFtWtm
 N8gTLTZ8lv9vxIacz4qOaA7jHbdIJL6JZI6TiBChm9LxWr/bTZcpq2sk1OxCUroxjoyoXwMU0fa
 xxiFTshjVJltQKsB+DcOmEXnS5u6kEgkOIOSK2E=
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

v3d_get_cpu_indirect_csd_params() looks up the indirect buffer object
from a userspace-supplied handle but never checks the result. A bogus
or stale handle makes drm_gem_object_lookup() return NULL, which is
then stored in info->indirect and only dereferenced later when the
indirect CSD job runs, turning a userspace mistake into a NULL pointer
dereference in the kernel.

Bail out with -ENOENT as soon as the lookup fails, so the bad handle is
rejected at submission time.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 3d6582dfb1bf..122b93eaa8bf 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -601,6 +601,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	       sizeof(indirect_csd.wg_uniform_offsets));
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
+	if (!info->indirect)
+		return -ENOENT;
 
 	return 0;
 }

-- 
2.54.0

