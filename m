Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25218109446E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 11:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF77410E0BA;
	Sat, 21 Mar 2026 11:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="dmQoj5oA";
	dkim-atps=neutral
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6B910E0BA
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1774091149;
 bh=advCDYONKqzCph5ZTFUFSWs19v2fi8pIDpKWdb7DT7k=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=dmQoj5oAbGmuqiMHbjUwxTfbeVHD77lQ/Y7GqZKmxOJS8NuzpIKCxi8YpC2R0yDjY
 E+HPWlRUbYe7HjmrvTrnj68nUXPO0XwY+arUBi27MVSy+U/J+d/Unt8DuCZyduRgY0
 HEaF+vvE1fbjrq5uRwoslcZqSO06TLh0hLsntYn4=
X-QQ-mid: esmtpsz16t1774090671tfd588e52
X-QQ-Originating-IP: f67St6LdxydDGswlyYyuwo1CRPZJU43NiFBCtGm6+wo=
Received: from localhost.localdomain ( [116.172.93.199])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 21 Mar 2026 18:57:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6951342301802925313
EX-QQ-RecipientCnt: 13
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, kexinsun@smail.nju.edu.cn,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: [PATCH] drm/xe: update outdated reference to xe_pt_commit_bind()
Date: Sat, 21 Mar 2026 18:57:48 +0800
Message-Id: <20260321105748.6646-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OLsBWtCIHsg6uc3gAasrhab4LLEiuXzpv1HgRjTEDijafJGEytScpz39
 lZHvmhqmFiYYkASypeBlCC9iaQ0L/RHMyXKRxbATdF25P4h1PdpLiinRYDwoPLBqnPBVDWF
 oBfrue3ueIy3NRMJJFaPtkAt0U8LesfjtGhR0rrKnYc4zCjaqvMZxbPXi1zFQ9YKWx3FhqI
 1SA9J45a7w69Bej6pcHKxf/QneSacZCXIF1Bx0mGM7PrhY2cMBor42cRn9QYrIz2rGIJkw4
 KwZjzn4Oss7H3fVqRCkCpotoOH4aiN0MjpDiUFx3kYAS/6rm3ZSzRWf6xZUEWfuXdqRk0a4
 DwsGPvZyIrGam8Gipourt5Lpc/aJj1U1bvYtf/ldlMV7GVPPNHY62zJ2TOGHnZ3wW1ao4EL
 N2VeYwFiAALzX9TxXEtWxZJYj32OKBSrZL6cYx5ANqt4eSLQpVzjEo1JAYFs5vcpAYur4+m
 ilN3cTd5z8uJIMYzCaDCaEO8WZw0gXB79C/DHPGjRrUU4SVN8/+jerZZCdn2pfpcvzpmzte
 hQ+AMoENTan+RCS4T862w+qLUuVxO0setNm4ZHDB0m9Xku47NwZKZL4jxtqA0P1ZQIBXXDn
 9jMTVXjwsgpVK8REztj2uAC/ohsPjF2OAPcB3WUOyuS3g179FmoSvuscXpPBORFayRtJIj0
 7GUmIYetuTuL3RFPi9/8XmmSbbWJtBikN9AuhpjvoEd4yer56OLhUaPY3WpLs56nFSt/zxY
 LVxYSc3Qz9P5FFigPuHGUCD7lfpyWKbZ2p1Gr28NQIAttp1BM83MasDj4l5GONJ/wyKNDC1
 Qkgw56WmTP5AZ66EVXaYG3hDLrAzpqDwd5JKbNWvV33PzCWiMnyFcwA03PQ4U4zgzzbmASt
 6lKs+uMYkTRrgcHhWYTMgt069T6EOHwuC/+dtOjCTc3vu56kTMGOrmeSdxekBw1dQSGuFTP
 4fmCIW3L4GAdJGQdwlzg87QuVEenfryYB4mwvHiqqIFZxu9q992YTsc7XZKoD2B3lFaI9qT
 KMlhPiX3LBpTNZFazAamjEVuEVArgJad4vJrMeLF5hrNGaRRADIcBKgOOwQ+4=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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

The function xe_pt_commit_bind() was split into
xe_pt_commit_prepare_bind(), xe_pt_commit(), and
xe_pt_abort_bind() by commit a708f6501c69 ("drm/xe: Update
PT layer with better error handling").  Update the stale
reference in xe_pt_stage_bind() to list the two functions
that now perform the cpu-side page-table connection.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/gpu/drm/xe/xe_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 13b355fadd58..8f00e6454721 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -686,7 +686,8 @@ static bool xe_atomic_for_system(struct xe_vm *vm, struct xe_vma *vma)
  *
  * This function builds a disconnected page-table tree for a given address
  * range. The tree is connected to the main vm tree for the gpu using
- * xe_migrate_update_pgtables() and for the cpu using xe_pt_commit_bind().
+ * xe_migrate_update_pgtables() and for the cpu using
+ * xe_pt_commit_prepare_bind() and xe_pt_commit().
  * The function builds xe_vm_pgtable_update structures for already existing
  * shared page-tables, and non-existing shared and non-shared page-tables
  * are built and populated directly.
-- 
2.25.1

