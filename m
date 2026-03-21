Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261AC109446E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 11:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B54D10E2B3;
	Sat, 21 Mar 2026 11:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="hUW42sbQ";
	dkim-atps=neutral
X-Greylist: delayed 557 seconds by postgrey-1.36 at gabe;
 Sat, 21 Mar 2026 11:06:55 UTC
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8D010E2B3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1774091213;
 bh=7/oPAJf1T5VvKf2s5H19YsALbKy5vPqQclHz0heLcvI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=hUW42sbQVicBHNN3gQBX7OdTU/0AgThPUxidxQyyCsVyVOtq4+/0ZhslKFZOPi3JC
 3QirWMJ8qbfwVbS/5iCHlTvtn9VhnjYzKmAOvxafidyPSHoYYNzCKt2T0j29+6SwW8
 W8+ntnyyTJiE3ZexhVjvy0utHiC+S14JifWySZtY=
X-QQ-mid: esmtpgz11t1774090661tc87c6998
X-QQ-Originating-IP: aov22Bp+36g+WJtRK7mcau7ZMkNSuGyS69IbPF/6/yQ=
Received: from localhost.localdomain ( [116.172.93.199])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 21 Mar 2026 18:57:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15415683190539263554
EX-QQ-RecipientCnt: 12
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, kexinsun@smail.nju.edu.cn,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: [PATCH] drm/sysfs: update outdated comment for renamed
 drm_sysfs_connector_status_event()
Date: Sat, 21 Mar 2026 18:57:39 +0800
Message-Id: <20260321105739.6472-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NC2sbZ2AMa4Kl/mpKNwUAdC3xOJczozdxlzjLiawOoCE8LjTOqxyqyjU
 E+Ni2mh0GQPMiBw4yxRiAAY9GENBTjlGFNSxIsLUgrgaKggJRBS0nnxm5ebKM3vepM9qGik
 2PZpIzsxtVo0VagvmZ+WvNjjDDRxOYp9lHEy1HV3Ypi9sKtuWTQATZ2ys3IOqM5EbldFlYu
 2IXk9Em0JRVIhxHB+4NPTlWKOF7IBE40eUxVoR/fzaweL06KmC577jUJaivIDzftHxMd1m1
 sdKKXqZ4Be2Ret26nz6a2FeZjecKq0Xm6Q2ROJ3RUIxbcJYe7YYZgyMFYM6re73dLrlYDxV
 sFD7SkCw6P5korcqjj8mbIpZaBcNt1T/rIy1NiUediKCnL8anguhxw0Lqo/N/CL5KcyDWF0
 DG4mpzZi/uTtzbjk1IK+r3PmFw8SPo/NpOAncZ9amoikY2yHI60q1L90ndA2AnTbWgbOvQR
 Hj4DC1DOPSwTn7zybXDVsOHRIywqMv5dEmOzjQ0HSKp3qBUSFAuhI6xDuG4XpqXFlei7U43
 +C4OGcn2bqFGbHSqAm5tKRlHyXBWLJNf0I49ozOzubZA2OruOH+O5RrsiltJ2LuE1L4D9J6
 zUZDl1O6Sd5AezImoBKrJw8B77aip5CBzktxB62rO2wYRaqiPBn+DPQn4rx/SYd/FLd6v9/
 +HOUtwOch3Lg5IFg7y3HYIZ5eLBAosHJDG6k7RZuz3NWswa9WDDmZBg4VfXcJQqyeGyOi5k
 mBOdwU5QOGyTiTS0ltg6yxIVV4FDHbLa0i7/WNlWMB4DsmVwnkoGOgzCbvIputfdTwQewnT
 n1xROjxLTh+KxUa35L21sN15/qU3rRgXaTkOB93Wpg0iJfDt+xMDGXCAE4byI7H1xvKbKfw
 rwzMvnirFCXu9jJvFA2rfEtSk6y757jX5PKpJ+fNyR0EIBeKvmYxNhYKFOk3qwbcRe50HFk
 Zv/wHuQINfHkhAtlFpxoIRuwEQLNYFTqCVqjrvfzcEmiSBALJtiJ9nrTA6Ff9d3WTKLybFj
 ikTXebkwaNAkVVuuknvmcAqpkBebOe8Ia2WhF/bAmQjUyOH0+w2XusjPgzSwrf51Hie1F9S
 BIaOFp28zdo
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

The function drm_sysfs_connector_status_event() was renamed to
drm_sysfs_connector_property_event() by commit 0cf8d292ba5e
("drm/sysfs: rename drm_sysfs_connector_status_event()").  Update
the comment in drm_sysfs_hotplug_event() accordingly, including
changing "connector status change" to "connector property change"
to match the rename rationale.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/gpu/drm/drm_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a8728..c543249d32c3 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -438,8 +438,8 @@ void drm_sysfs_lease_event(struct drm_device *dev)
  * set HOTPLUG=1 in the uevent environment, but this could be expanded to
  * deal with other types of events.
  *
- * Any new uapi should be using the drm_sysfs_connector_status_event()
- * for uevents on connector status change.
+ * Any new uapi should be using the drm_sysfs_connector_property_event()
+ * for uevents on connector property change.
  */
 void drm_sysfs_hotplug_event(struct drm_device *dev)
 {
-- 
2.25.1

