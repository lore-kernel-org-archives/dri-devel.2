Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E38606A339
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ykLiUdxW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB34310F576;
	Tue,  3 Nov 2026 13:01:32 +0000 (UTC)
X-Greylist: delayed 521 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 13:01:26 UTC
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru
 [93.188.205.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 344AF10F576;
 Tue,  3 Nov 2026 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
 s=mail; t=1793710362;
 bh=iouGWSMMa76ghwbzwSYQ6bAw7O0sN2zqkEE0UIP46bw=;
 h=From:To:Cc:Subject:Date:From;
 b=ykLiUdxWD+FUHhMSFlnG326R1gDFgCSR6JuEP42ivk6fJK84+ldEl1Zf+5NMZOEkG
 iBqxPCON5M61IjyIqsiyXMwBjIASRwZV5BvsUMXmVypdrv4GiNgZ5Ys8iOhxbnW34U
 PJKfc7b3XrDncNLGqcZ+OaJeg+MJmPgLC/D23FN5arZjYL1btjFravq41pSXRCTY8j
 GNtjQi+D+Ca4FQOfXxKf9cSi6MEGLOWxSXCyI4rl9H484QO5rJpBeDPwPxoO9IafDU
 /YxGkHS99gupu/Ihi56tLZ3M7gue8ZI2Pdrs1bXtwQm31Tpam9BYC5aGuKHN7mkeSG
 2nBr49abPVZ+g==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw02.astralinux.ru (Postfix) with ESMTP id B499E1FA27;
 Tue,  3 Nov 2026 15:52:42 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
 Tue,  3 Nov 2026 15:52:41 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.27.207])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJlCK5Myzz3vN0;
 Tue, 03 Nov 2026 13:28:13 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
 Yinjie Yao <yinjie.yao@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] drm/amdgpu/vcn: set no_user_fence for VCN v2.0
 enc/dec rings
Date: Tue,  3 Nov 2026 13:27:48 +0300
Message-ID: <20261103102754.1500-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133
 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {diag_burst_silent},
 {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to},
 astralinux.ru:7.1.1; new-mail.astralinux.ru:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207221 [Nov 03 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2026/11/03 11:26:00 #28786010
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yinjie Yao <yinjie.yao@amd.com>

commit 8d80b293b41fcb5e9396db93e788b0f4ebcbafb7 upstream.

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e2b5499fca55f1a32960a311bbb62e35891eaf73)
[mdmitrichenko: Adjust the ring initializers to the 5.10/5.15 context,
 preserving the existing vmhub fields.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-63856.

 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e2744f172610a..da3809fef38ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2005,6 +2005,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
@@ -2036,6 +2037,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
-- 
2.43.0

