Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A983ACD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E0010E22B;
	Sun, 17 May 2026 14:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="XAwLGIrs";
	dkim-atps=neutral
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8E410E22B
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID
 :References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=07i/g/3Qja7ieAQrUk+sKmkgbN29B4mnFsuWaZjIhwI=; b=XAwLGIrs1dxOKw/8B1dA5vxomj
 +QhRG2aC2nMu/RJw6v4VzE1Ftifr6+rjwtTC6KO1dDoEpTEcBagfPXHU9cPD8ozKlpsZloyHPgbCC
 hevERJRT+x3QOed5sxD1X4//BL7hfQOnnaPqLTT6fSzTA29g1Upv0hsY5OHz84+06u9g1v4f6lXnl
 y8NoZ1RhUQP9eNCwv57IC+GDMi3uesOFn6DzC+lPjnKXxR2ZcVvjdpUZwMNDw/ERqd3HLxF4M7UQn
 A3RsER1I24cLrUn5QDpMGnZ1/1CjYBMvEv6tqBN2ICecZWV3SxPjtwWrIGYLwPgKRF/Bw5H79QTTk
 X9IGbJLA==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wOc9o-00HEJm-2p;
 Sun, 17 May 2026 14:07:53 +0000
From: Berkant Koc <me@berkoc.com>
To: Zack Rusin <zack.rusin@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org
Cc: security@kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: validate execbuf header.size lower bound
In-Reply-To: <2026051743-genre-cacti-bdf3@gregkh>
References: <20260517-vmwgfx-uaf-report@berkoc.com>
 <2026051743-genre-cacti-bdf3@gregkh>
Message-ID: <20260517-vmwgfx-uaf-patch@berkoc.com>
Date: Sun, 17 May 2026 15:05:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

Commit 32b415a9dc2c ("drm/vmwgfx: Validate command header size against
SVGA_CMD_MAX_DATASIZE") added an upper bound on the user-supplied
SVGA3dCmdHeader.size field but no matching lower bound. When
header->size is smaller than sizeof(cmd->body), the size_t subtraction
in expressions like

  maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);

underflows. The subsequent bound check

  if (cmd->body.numVertexDecls > maxnum) return -EINVAL;

is bypassed because maxnum is ~SIZE_MAX, and the loop walks
attacker-chosen entries past the command buffer.

In vmw_cmd_draw this leads to a 4-byte OOB-read per iteration via
vmw_cmd_res_check(&decl[i].array.surfaceId, ...); on a surface-handle
collision, vmw_resource_relocation_add records the OOB address as
rel->offset (29-bit bitfield), and vmw_resource_relocations_apply
later performs a 32-bit kernel write at cb + rel->offset.

The same root cause is present in vmw_cmd_dma (suffix pointer-arith
underflow leading to OOB-read of suffix->suffixSize) and
vmw_cmd_shader_define (size_t wraparound passed to
vmw_compat_shader_add).

Reachable via DRM_VMW_EXECBUF (DRM_RENDER_ALLOW). Reject undersized
headers at all three sites before the subtraction.

Cc: stable@vger.kernel.org # v6.18+
Fixes: 32b415a9dc2c ("drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE")
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e1f18020170a..6f9c7d61cc66 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1506,6 +1506,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 	bool dirty;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("DMA cmd header.size too small.\n");
+		return -EINVAL;
+	}
+
 	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
 					       header->size - sizeof(*suffix));
 
@@ -1572,6 +1578,12 @@ static int vmw_cmd_draw(struct vmw_private *dev_priv,
 		return ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Draw cmd header.size smaller than body.\n");
+		return -EINVAL;
+	}
+
 	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);
 
 	if (unlikely(cmd->body.numVertexDecls > maxnum)) {
@@ -1915,6 +1927,11 @@ static int vmw_cmd_shader_define(struct vmw_private *dev_priv,
 	if (unlikely(!dev_priv->has_mob))
 		return 0;
 
+	if (unlikely(cmd->header.size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Shader define cmd header.size smaller than body.\n");
+		return -EINVAL;
+	}
+
 	size = cmd->header.size - sizeof(cmd->body);
 	ret = vmw_compat_shader_add(dev_priv, vmw_context_res_man(ctx),
 				    cmd->body.shid, cmd + 1, cmd->body.type,
-- 
2.47.3

