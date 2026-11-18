Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6087606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=timdoug.com header.i=@timdoug.com header.a=rsa-sha256 header.s=fm3 header.b=bfgILWXr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UCQvYI5m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55E410EB31;
	Wed, 18 Nov 2026 08:23:07 +0000 (UTC)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5AC10E5BE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:59:40 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D782D1400184
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:59:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 17 Nov 2026 20:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timdoug.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1794967179; x=1795053579; bh=ZSV2UPAtaoVAnpwZ/BtCX
 biGF7M5OXK+ikdh8M9ib90=; b=bfgILWXrTdFYbJXjgZTZH/7o1iSLO/AePkmnu
 lXD5LLmwXbImofnFF54QOcYKkHeEh1F4qVYQXFEKU+b4ptPLPlAEq80tc51ExQyx
 k2/33LQJNjSQWaIIK5xav+bhCLuJxMohhmqkSJTkQIV2Cp5a10fhfHEkRQFbaPdf
 9dZbyKeuZCZZ2BS8DLfnZVyDt5/kdwL2jlRERsScMKg/mwksmg9j39wE2nkRqBZe
 WJgq7hxsNDrpIg/dy3MCGv3kA/PYMcsylpuLRmUs/XZojyI+GWXJagSFy+iBSDPz
 7zu2H97OwD4HqKAyQv/XAPYlPm7zv1H+/oUB2cAz5C1Eh8kcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794967179; x=1795053579; bh=ZSV2UPAtaoVAnpwZ/BtCXbiGF7M5OXK+ikd
 h8M9ib90=; b=UCQvYI5mBBVo/BlZ4w+XYTQoX8AAYeszT37nEOjaZVzNOjlHBeK
 /o9Re5o4J7SiqyZe1ApxYiQh/coKmLHfRmSO8a5s0dsh9Pcjl8VrbJp9RxkF29N/
 CKXsimdtpm8MDlETFT/Af+OrccU5NHOWLF546hS1DfnJQJwzLUfyc82QX1wTz4bB
 jh7sGwFtSgufNnMQgPDQ65tCNneSBWswKso3cc2GsHcOqoS2lIKjWXkrPh+ni1uj
 uSqn6va9E+QDYeMQs2WmloeOorJ/obseYJD61lzJAK4zInVPgYcW0k82irZMWPfw
 IjT8S3a5a0stQCukzA2Kw427pwVVQ+ZrcTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=timdoug.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794967179; d=timdoug.com;
 mf=PG1lQHRpbWRvdWcuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm3:rsa-sha256:g5JdNjPMRnKjVUdLzhjodBiS7zwqCyWnA89n7yXaTpg7khS
 WGfokZuRipC77nngCjoZnwIZkhF+ebXWC8WxYwzZgvP+0edBKGY6AvIXjjEadWAl
 b+WtV3uhYurB/y8URIhD6E2Kgeczttf/Q9u0HX/Dcb/Y8VN8X9/QtvajwuzSezWI
 FemlsoyiE7op+DryW2ULjDnQvHmEQricEa2EKuY1NUXfZUuXIOgfP4Nix5ehCugd
 zD6ivl2cm3IHXJ9riI6IZDtCMXkyudqqkzd4tC5LxSURp7hemcBbrTUv4rGBPlal
 2NBpr5z9M8c4sIHRCO6w5irlHSyhHh8kwYFk5Tg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:ZT4NBP+dZ6kEpTng0nw9OzKrl9rxtmFzgkZR97ggba0=:onF1i3XQsk5QUNA9WnF/o0ScZsWHUpbLtliEd4TzH2k=;
X-ME-Sender: <xms:iwb9avdF0ygW8J-XIGC96vcrcX6deNnmF1rvJN9VCUHkJbd7LowQKw>
 <xme:iwb9agoCGzNM2lwjk-J7JXor9s88O81Ek311LbQm_JMEEOS_HyLo1P2YSHZTUfwHc
 DBbqhh6rygFxPLaTcIFySACIR08f4uSmtioeLH2R07C-jVmXkxXDA>
X-ME-Received: <xmr:iwb9asDtdxsok4Y4CyRNgW19f0PKFdF6oVMBY8ShJKt4apGSP8oYQd059GdV>
X-ME-Proxy-Cause: dmFkZTEyqy1RfkBWV1OkqVtKccxbuSkVy3qNQElWzhM9d8A63OOyz0GU41AxauMglzV6j1
 xuVozbgBF30Rk+IhNslkk3V9Qgh8bOtfnahyq5Kk8hc8mJoWRq3OEeDrcuqOY2+ET7LEMm
 KOOv1SVCt4+/isiI7qK8vrZrHDAxo2qE9usdd7NGdywKscxsW3q72e/5EK01ACmfPhA8SX
 zUSC0zcCMTBarhg85y22i6cPJJHzMgtU+nB6qbrBFHqzdQe6bH7n35a/QPurGKhDMdotIz
 rjL0Qj3awm4VXmSM/Gh216qMquIFEbZBz0TXH3rU1Rq7Q7P3wwDla0B221F0Ocoek7j2se
 mQnZaerVEUuwhwWrQtL5s2kD4I0Bh9MgPGulSIqyDK7Nry1wMbpvaPlUYSgbNz7SxaQYUI
 mTOF0pyIZpr3fDbHFsV0l9IhLkjhp2F2xLR1m8cGDvWxW8f5WAP+sBNWfxOntnFMQo8Yfb
 33WmlOWikeW4Hh2v2a2Boohn7n6QC5Vwwt9wlpNkzR1OC82osgeGQyso8z+o+4qVTOaSH2
 Tskby3UNgMXX/iRZNAzPVFzIbf0u6NWDuYWzHs/5YMJ/wH5QKtMGrpsLx+YNFOetFa4/9n
 vliFW2pWeqcUBo5bOyjTTpLMPQEowvRKUv1riGv6BpNMjq6Qly8fhsj98dzQ
X-ME-Proxy: <xmx:iwb9alah1zlVOc_VmCwGwIe-ucAdHxiiskYojLZcQW27MdBnYtSUog>
 <xmx:iwb9an6IHU4w7U16Ura1XA48N1fU_tpRaSBn9KPR9xuGv2vQqzmBdA>
 <xmx:iwb9auZ7_Wjz7r5kmuaW0RPNUORK_sXvWOp4kLDjPSiWfx31gWE6Sg>
 <xmx:iwb9aughXFI7z7MYAu4CCMXLv3JXiuZNJnreqQiDLmbMa6CnsyXHVg>
 <xmx:iwb9avBuYyQrVub7lQlRIWV9FOXxblxudrBm088Kx_ToKW4OZe9zg3lN>
Feedback-ID: i12bc4175:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 20:59:39 -0500 (EST)
From: Tim Douglas <me@timdoug.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: valkyriefb: keep the framebuffer mapping size fixed
Date: Tue, 17 Nov 2026 20:58:59 -0500
Message-ID: <20261118015859.83794-1-me@timdoug.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

When /dev/fb0 is mapped before a depth change, as with Xorg's fbdev
driver, the mapping may be too short for the new mode. At 640x480,
a full frame at 16 bpp is 600 KiB, so drawing it through the
original 300 KiB mapping from 8 bpp can fault.

Set smem_len to the usable video RAM by subtracting the 4 KiB offset
already applied to smem_start, then keep that size across mode
changes.

On a Performa 6200CD using a kernel with local platform support,
a write past the mapping caused a fault during an Xorg test at
16 bpp. With the corrected mapping size in the test kernel, twm
and xterm were displayed successfully in Xorg at 640x480 and 16 bpp.

In a test on a Quadra 630 in MAME with Linux v7.4-rc3, /dev/fb0 was
mapped at 8 bpp and the depth was changed to 16 bpp with the original
mapping still in place. A SIGSEGV was reported during the 16 bpp draw
before the fix, and all 480 lines were drawn afterward.

AI assistance was used to investigate the mapping size and draft
the fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tim Douglas <me@timdoug.com>
---
 drivers/video/fbdev/valkyriefb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index ec3cf4589..e067c89c9 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -510,7 +510,7 @@ static void valkyrie_init_fix(struct fb_fix_screeninfo *fix, struct fb_info_valk
 	fix->mmio_len = sizeof(struct valkyrie_regs);
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->smem_start = p->frame_buffer_phys + 0x1000;
-	fix->smem_len = p->total_vram;
+	fix->smem_len = p->total_vram - 0x1000;
 
 	fix->type_aux = 0;
 	fix->ywrapstep = 0;
@@ -523,7 +523,6 @@ static void valkyrie_init_fix(struct fb_fix_screeninfo *fix, struct fb_info_valk
 static void valkyrie_par_to_fix(struct fb_par_valkyrie *par,
 	struct fb_fix_screeninfo *fix)
 {
-	fix->smem_len = valkyrie_vram_reqd(par->vmode, par->cmode);
 	fix->visual = (par->cmode == CMODE_8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 	fix->line_length = par->vxres << par->cmode;

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.39.5

