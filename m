Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1168C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FD810F2E3;
	Fri, 24 Jul 2026 07:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="E36dmo78";
	dkim-atps=neutral
X-Greylist: delayed 65437 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 02:30:11 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.74.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4417210E662
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1784860168;
 bh=+ZvTI/fcAWs1dkQ4W9g4AT4WdA/up4PGQNqGKnn0rhc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=E36dmo78kh/yyu/q/SFkWKgtLkmXa3lNLHr2zOdo+jTF5icGfxEpesU7j1j6LqF10
 QQwvZdTVAlYgqiW3pimDLTXMBli0Soqng7q9p8S59eQcUdzXh9lkODYgaJpnoNS5zY
 g2lv+WASdoWmV7/oPQi1SHKTdfaHsCYZQk5nlNqc=
X-QQ-mid: zesmtpip4t1784860156t81fb8ef9
X-QQ-Originating-IP: uU8Dw1tobLbkmKcfvIpWRxgng5wGRpu3yzVVioqlHrE=
Received: from localhost.localdomain ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 24 Jul 2026 10:29:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1489989829865237816
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org,
 akpm@linux-foundation.org, gouhao@uniontech.com, namcao@linutronix.de,
 ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com, clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: [PATCH v2 4/6] drm: remove dead WARN_ON NULL check after GFP_NOFAIL
 allocation
Date: Fri, 24 Jul 2026 10:28:49 +0800
Message-Id: <20260724022851.466017-5-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: OYMEOeTae7ml72uGin0H1C3pK5c9+QYjdQgDAuIFE8UGp823CcBF0aYB
 ZKuHTFQzUBDRlCCNVVKBEEqLTSr/VaM2rPwDKyCTrGbnV/MPothXGcA9BT0eRYmQRPQs8v2
 O6U4Zv7/YfNIf4td3jgO7KgvCtBJ9u/wHryrW3jKTlN5J3uC/8FdbZuQRjpJ1hz4CVS2aP0
 cVIqk7f9U5YjmgnEBzicWs3R5SAKrhjb4QrV0SGXtVI5T89n3z4Bact50WL9niureseFM8l
 o7HczQfFeKq92yiYknL5UJ5vPSjQypJ0hQHz0s6X3Jb/qCZ3qScVhP9foBlMtZB1qzhM0M1
 XOr0fOlJ29Owb8350tpKn9hHgezZ8iLzU60rhfTOvnBAL7GTvx5RMXuk8A12aNSqoTQoNYM
 lmz/BYgdNOz7lBNJo3kwQyrUFLtM8MYBPbR7mItQjPPMKrodCMyKu3sa7xu4uH7odekH2jj
 MST4050YnBUrc9R4S0ITAoIqo7WdL+JGjYo/TjZlKMWvBIEhRgF4NZ/x0TA8PQJXzv3OP5f
 k8Gi+t4iP5dIuRrh6QqKpxwO0OP8KL7aFEIvWHgvD6MbF9zJw0oQl8a0RxLyKG/8eRFGeqD
 eq2LGunZFJFHg8XULD5CdVu8m24dk4uOr7NOdIAxTiYkgBhT3/bxqOFEuZ5MVJk4K/WLLyY
 EdMYhJF3Woz7PcNdPEwvXCmSfW3oKNlmjzl3oOeGlV0bHYO2oZOtlkuTn/WI1A0wTL2iaQz
 GaG6V/QJd4YVSfzao5wBMOhbxXrc7vl2YmAIfmiPoXJNHVQamZDknqvoeFU7OcShz7Q+cAF
 ffLI7Eg+a53SaJ1S7DJHISPzn2g9ISKMdCMGoAOW2Z8gbuLw7ZLRev09eQUY67Jb2njfIr7
 75gfyFUDQeH6F3tLev9bvRRh76ZObFlCMldHLKJ+p7sug1V1PfXyPIT6HCb5RbiLQoq3ONE
 PIbQvv4jJ52LdZYvMhgz0Vg32VUnEh7Yc8qmgRzHY3T+o3iM54h+T8gzIZ7wdtBzQPu+GWW
 UblXcnNa763eZb0zlOcfpsdjvY4y9+DNmGrzpdGYXoPfJWhEQv
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

kzalloc_obj with the __GFP_NOFAIL flag will never return NULL, so the
subsequent WARN_ON(!ctx) is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 2c806b0146d67..e14814c30d8c0 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -149,11 +149,7 @@ void drm_modeset_lock_all(struct drm_device *dev)
 	int ret;
 
 	ctx = kzalloc_obj(*ctx, GFP_KERNEL | __GFP_NOFAIL);
-	if (WARN_ON(!ctx))
-		return;
-
 	mutex_lock(&config->mutex);
-
 	drm_modeset_acquire_init(ctx, 0);
 
 retry:
-- 
2.20.1

