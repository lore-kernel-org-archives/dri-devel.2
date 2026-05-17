Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A38CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 13:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B092B10E00C;
	Sun, 17 May 2026 13:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="T3V6Q0mL";
	dkim-atps=neutral
X-Greylist: delayed 322 seconds by postgrey-1.36 at gabe;
 Sun, 17 May 2026 13:15:40 UTC
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3635610E00C
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID
 :Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wh3QcLRs83WEkHTY6XgRRLXC3lPrZS+fkSDBdkuCb2w=; b=T3V6Q0mLe/hf0fDRBP3wwzlUjz
 S5HGjL99n44Zsv1b71qdGElZRcdB4XgbsUKlvgx6QG2B3PCQouHaxTCmRDYuOlef2iWFTK2XbKf9s
 5Tz6tha8ORPgUFah201AvcSdq6SgA0hA0tmaDGUHf+CbSJuboOX7VnJsUAdzKfF/F2n2TDofFT+Bq
 UoeBaegRgcpZ0E4FhMmub2R+k5Q9gjRHAYZ4RcF+MewOUuoTh1TL8WZ0+gW9ogZj0O7yLLQuhvefI
 kE39a7JRiYb2i3aKptcDqzL6eZ8m8iVgJfEgk+z/he69pVPU+LTSzhTlKsh7dDbIvQ68p8XOQgSFe
 cfyp/GOg==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wObLB-00H6O5-1w;
 Sun, 17 May 2026 13:15:34 +0000
From: Berkant Koc <me@berkoc.com>
To: security@kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [REPORT] drm/vmwgfx: vmw_cmd_draw header.size lower-bound missing -
 guest-local OOB-read/write
Message-ID: <20260517-vmwgfx-uaf-report@berkoc.com>
Date: Sun, 17 May 2026 15:00:00 +0200
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi all,

Following the drm/qxl apply_reloc report from 14 May 2026
(prior thread: https://lore.kernel.org/virtualization/36acd33982bfdce04090e17294596ff8@berkoc.com/T/),
I audited the DRM cousin-drivers for the same bug-class. vmwgfx exposes a
stronger instance.

Primary site: `vmw_cmd_draw` in
`drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:1558-1607`. The verifier does

    maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);
    if (cmd->body.numVertexDecls > maxnum) return -EINVAL;

Commit `32b415a9dc2c` ("drm/vmwgfx: Validate command header size against
SVGA_CMD_MAX_DATASIZE", Oct 2025) added the upper bound but not the
lower bound. With `header->size < sizeof(cmd->body)` the size_t
subtraction wraps, `maxnum` becomes ~SIZE_MAX, and the loop walks
attacker-chosen `numVertexDecls` entries past the cmd-buffer. Each
iteration is a 4-byte OOB-read via `vmw_cmd_res_check`; on a handle
collision `vmw_resource_relocation_add` records the OOB address as
`rel->offset` (29-bit), and `vmw_resource_relocations_apply` later does
a 32-bit kernel write at `cb + rel->offset` within a 512 MiB window.

Exploitability split:
  - OOB-read at first iteration is deterministic.
  - OOB-write requires `id_loc` to resolve to a valid surface handle;
    surface-spray makes this practical but the write side is probabilistic.

Two cousin sites share the same root cause (details in BUG.md):
  - `vmw_cmd_dma` (line 1495): pointer underflow -> 4-byte OOB-read of
    `suffix->suffixSize`.
  - `vmw_cmd_shader_define` (line 1898): `size = header.size - sizeof(body)`
    wraps and reaches `vmw_compat_shader_add`; ENOMEM-bounded DoS.

Reachability: DRM_VMW_EXECBUF, DRM_RENDER_ALLOW. Any `/dev/dri/renderD128`
user (default `video` group) on a VMware or KVM SVGA-II guest. No DRM_AUTH,
no DRM_MASTER, no root.

CVSS 3.1: `CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H` -> 7.8 High
(deterministic OOB-read, probabilistic 32-bit kernel write within 512 MiB;
guest-local LPE, no host escape claimed).

Suggested fix: per-site lower-bound check on `header->size` before the
subtraction, or the safe pattern using `check_mul_overflow` /
`check_add_overflow`. A draft patch is sent as the follow-up RFC in
this thread.

Attachments: BUG.md (full trace) and repro.c (KASAN-trigger PoC, no
exploitation).

Happy to follow your standard timeline per Documentation/process/security-bugs.rst
(typically <=7 days post-fix-merge).

Berkant Koc <me@berkoc.com>
GPG: 0C58 8DFD 7620 4987 2842 13EA 0AC5 29C4 1F8A A5D6
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQMWI39diBJhyhCE+oKxSnEH4ql1gUCagm/bwAKCRAKxSnEH4ql
1i1PAQCXhrf6CdxpwCifgpjYZJdzspd9dckht9le4AeUJpKRpwD/csbOYVl+oMDY
mekPtFhNq+TujSRVzvRZ0MKzOawzAwU=
=7oh3
-----END PGP SIGNATURE-----
