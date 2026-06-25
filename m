Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63400CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54AF10E158;
	Thu, 25 Jun 2026 07:03:17 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F4710E502;
 Thu, 25 Jun 2026 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-05 (Coremail) with SMTP id zQCowABnus15xTxqv3coFQ--.18797S2;
 Thu, 25 Jun 2026 14:06:49 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Roman Li <Roman.Li@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Leo Chen <leo.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [RFC PATCH] drm/amd/display: wire DCN42B mcache programming callback
Date: Thu, 25 Jun 2026 14:06:47 +0800
Message-ID: <20260625060647.2353-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnus15xTxqv3coFQ--.18797S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7Kw4xWryxJFyrAw4xZwb_yoW8CFWUpa
 17Xa1a9F4kXFy2vr43W3WUWFsxGw4qyFWrtrs3Ga1fZa4UAryUtFZ0kFyjq3y5uF4Iyr4f
 t3W09r47trn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
 nIWIevJa73UjIFyTuYvjTRCnmRDUUUU
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

DCN42B enables DML2 and DML21 by default and defines
dcn42b_prepare_mcache_programming(), but the resource function table only
wires the callback when CONFIG_DRM_AMD_DC_DML21 is defined.

There is no in-tree Kconfig symbol named DRM_AMD_DC_DML21, so the
preprocessor always removes the callback entry.  Sibling DCN42 and DCN401
resource tables wire their prepare_mcache_programming callbacks
unconditionally, and the core DC code already checks whether the callback
pointer is present before calling it.

Remove the stale guard so DCN42B exposes the callback relation that its
source and DML21 build world already provide.

This is an RFC patch draft from static conditional callback legality
auditing.  It needs AMD display maintainer review before submission as a
final fix.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 000000000000..000000000000 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -1882,8 +1882,6 @@ static const struct resource_funcs dcn42b_res_pool_funcs = {
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
-#ifdef CONFIG_DRM_AMD_DC_DML21
 	.prepare_mcache_programming = dcn42b_prepare_mcache_programming,
-#endif
 	.build_pipe_pix_clk_params = dcn42b_build_pipe_pix_clk_params,
 	.get_power_profile = dcn401_get_power_profile,
 	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
-- 
2.39.5

