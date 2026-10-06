Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CB9CA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32D910E24B;
	Tue,  6 Oct 2026 00:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="xHoS5FoX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIMEQInV";
	dkim-atps=neutral
X-Greylist: delayed 572 seconds by postgrey-1.36 at gabe;
 Tue, 06 Oct 2026 00:51:12 UTC
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A67710E24B
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 00:51:12 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 058907A012B
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 20:41:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 20:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to; s=fm1; t=
 1791247298; x=1791333698; bh=qUjwN6cVWimq4YGkDnD9OApHHc6tso2lhN6
 DEzPEgHk=; b=xHoS5FoX4e3YYYobIQQN2o8oCyjJ4ojXWcayRZh1tPsjZ3VmzmW
 i1GoceGKdzy67LzbU1C4bXEVODLYHIHSMZeCOc8ObW6EppXgqDX7QYOdHBKqNsGz
 ku2wpqm8VsKAONnyOcQxrLoSDMM6glWfXCsQx6l6MLXEPpuDLA4PdTGuipsMseQG
 +b9mVgWu36ZQxZXg3AlJX4ok9yCH1ehMoA7qtnUbm3UccrPLnNahtlBLR0Fc47Mk
 uj+aOEFS7+JhdbmRDGZQQ3hPBfBjRWqM1CThv5CPfPRyn0Nr8ZxmLCADUpebUlaH
 7XFybN1qHlbyUkmTRYKcDL0Sd0F+4Tgy1Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1791247298; x=1791333698; bh=qUjwN6cVWimq4YGkDnD9OApHHc6tso2lhN6
 DEzPEgHk=; b=aIMEQInVSQVHFj5VHejKIc/XmKqx+XqIAOqpT9+9kpk+q9w5i8B
 XzBzexpF6wx9o9zBH9+PbhtLylzxQQjF2yajYI3G9cKsi8cmdkp56Jz0yYnGXe4P
 4PWVlaETNc9MCjr0UJkiMdNF5n5FrlGXvi1CKC3Znz7Ev1bNa3KN+Kwq+NeKmY9M
 MwkLnbLcOgBXg7avs65jKlTCIH83p0zw93XIF8pdH1UKXiNp8uaB2rj0YW+IYbMG
 KJmjfkM4qGnyulzvLt/nErPEgoi6PFpMdJWBaU/+ugS7EJPdmTSQowSaAuK3YPEm
 xwRJWV4Ubvy+cmIrEplfEOoJCrBqzaz4XlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791247298; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:sOEiC0uqxvhUv3ODMvcGtMsvlYw8d8928FWGLSsWLEufLoR
 v8fuzV5mPHccW1uYxY9WpeXGbc4xZEdXqK05BEkRxsCw0gff8IQJ0izAHvu7xkrS
 b0x8wmwZH9kt54BlTdHxGbOIswDpfdCuf2ShYNaQeD8NrmWtnUwaWkPZTDRvJGgv
 KQx7cUR8Cbv6VyRcpx8uzNpgague4fAuJeAVkRCrlM8K+LyW9581GAt8G37ZKrl6
 sZ1peU62Pk304axY1FeFXrkCp0WpzlxCNmmImq4SonToCUoKw+tU750HtHaFlDff
 dCK2PLz/xNt92bgFHk94aexJm7Xt43tLM8BXGzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:VXGmOAcHE+COIr+Ugk47dsMGRRfa4TSxLqKmM5gRJlg=:/JKKG9OWHsEXY2DgUq3Osook2NoOxoMNSVYoBMcJ0Us=;
X-ME-Sender: <xms:wUPEakJPHm4tN2jJLC1tSYxAFsy_-9WFuBhcDardYcd-H2-q3Q8jSQ>
 <xme:wUPEagiL1auyRq8Ray9OJ2T9uInjW3YEQs-rIVytXsWiOQjMnfG_r2KJqDTZdaIPF
 mJG9uSIoZj6lP1coM71QHpLkxQ-ygDX6leJ-AMNSd9z6sVcbg>
X-ME-Received: <xmr:wUPEapLz8GKfYXNweGhHuFJRluUtsiSQMhKtvEtJ8bTpJvvALHdVMRZu_serq6jCvQOvTSGjRIOvkdZ1D_e4xVxkbu4kaDijLn0Qn8L9Yj8XOi55JHmVY2TsK9__gA>
X-ME-Proxy-Cause: dmFkZTEghPExglsMQAefHWpXnSoQaFUzwamSACfKtu18jVVn7YsaobEf1oB3Cblr20uVmj
 Rbcy7X1THMQvdvnO+0a74l/r04m00V8rlcpN2nFCpsY8rtnwVOcT42yEhbNomVHAyzwQla
 IZp8Tjnc7lGuUBZYF+2zK7/nex4iWmeJr3ZBkDYa6MxmN7gWHV2YZGrELddNoZdkxS250L
 67TYwR6yXz0D4jgR8ukTX0AQlE5F3dpvSlLp2CXWCkvC1O68uR5blx6j7df6Q7fQyTtNK/
 EWM6j/dSzW9HSzHIhdcnJiIvhwV6N5ZZKp3y49k9omvdX7jfwS/6m6QaVZ+lEmW/GuUBVj
 Sh624997kl7RH+d0txrybDPHg6SV0VQQl+Zy3re6pgq/QMzlNMdscinCEEAgh2rtZR5zLE
 0bd9YpfNdv1S2DL5jZ5meFAuxswrCBbBXA9ydQE22p6AUj6eForvyPmlVw5a3D84SKL9JC
 Bk2TkhVG0oMYlrcc8Mj+AmQhq8xlhYt7rIRUn0FCk74lhJ9E4CCbMzEB/t790vM4FKmPSg
 paohVATps/zukDW6/uj1+UnMnl8aplA/MuZeTB6BPKk2N2jASx2zXDOCXyn6MIiGvmU7dB
 cWLTU0Ipzfci9cjJr4oW1BHugm+Z8WIYvDAO2WCRtzplfluM99i6YE2Jvztw
X-ME-Proxy: <xmx:wUPEavj1OUl9MiHPGg9qoQio3sskCMnRZGTxVGX54Go7cdWwaNzbdg>
 <xmx:wUPEan0qEb7KZXH6GgeViKeVXI4LdoHkXD0QxojTo94tx1z3zzCluQ>
 <xmx:wUPEaliJHgY0tk844L-FAGA5OE6f-bOwKolwlrnGolGAZyZr_9CQjQ>
 <xmx:wUPEao-PsItpWjuuazUdeqwaASS8819v9QjdbUrHubfORPQxHpb-Yg>
 <xmx:wkPEauJ6_g0_uducp_PemI5u4-SVAKWM8Hv89N51XC6GU5Qxa3QrTxoB>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 20:41:34 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Sergio Lopez <slp@redhat.com>
Cc: Val Packett <val@invisiblethingslab.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: do not enforce blob_alignment in cross-domain
 contexts
Date: Mon,  5 Oct 2026 21:34:09 -0300
Message-ID: <20261006004044.2242154-1-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context types,
however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resources
created under cross-domain contexts are arbitrary shared system memory
files, which includes unusual things like Wayland keymaps received
from the host compositor. Do not enforce alignment requirements there.

Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements")
Signed-off-by: Val Packett <val@invisiblethingslab.com>
---

That took its time to be discovered since devices didn't start offering
blob_alignment until now e.g. https://github.com/libkrun/libkrun/pull/886

It would also be fine to just revert 47248e0d8264 but I guess this way
no one would question why "there's an alignment and we aren't enforcing it"..

Thanks,
~val

---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 01a5f17cb22b..d493f04b9993 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -551,6 +551,8 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob_hints = rc_blob->blob_hints;
 
 	if (vgdev->has_blob_alignment &&
+	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=
+	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
 		return -EINVAL;
 
-- 
2.55.0

