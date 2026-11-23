Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B3606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=kbsdTwEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFCC10E4CB;
	Mon, 23 Nov 2026 14:17:17 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED6CC10EBD4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:17:27 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id A1A6C20DC66E;
 Mon, 23 Nov 2026 11:17:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 7DFCB20DC66D;
 Mon, 23 Nov 2026 11:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 7DFCB20DC66D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795429046;
 bh=rhAFp8q6hcVFicw1cnkwUehJMti1UXGDz3sIyHd3ZfU=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=kbsdTwEQx3Qet/c/r74j7BeWCKXfebqtsECFzaLjncgdOeUZTMcZzQV/1t8pINZaQ
 VzdpzXh9w2JzL0VocJt46lQT7I0qEp4250WiPOSQOqtVQViZzfjKBGglZq2b8nptOs
 kNttmQNxKLHpdOALqZc0uMrLB+k+4m8pgsW1uAaNyxyrVUlTh5MaMIY+SyU5D2iQvt
 DG5YxUHozYi+ngVwB4hq4Au/U3JuMfTtGLWnBS0H0ZLppr9QbqqjgeOWOMkFFOdbKV
 bJ9N2/2ToVUQLDeUSDwhemT3N3iuSrOZCoFAt4CqOPkgoYr30zb2zs9hLb0KjBp1jG
 YJ6WOvApPMnCw==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id s7PvU-pu6kNA; Mon, 23 Nov 2026 11:17:26 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id 2A8F320DB5C2;
 Mon, 23 Nov 2026 11:17:26 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
Subject: [PATCH 2/2] drm/nouveau/dispnv50: reject DP modes that don't fit the
 link
Date: Mon, 23 Nov 2026 11:16:59 +0100
Message-ID: <20261123101659.600247-3-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123101659.600247-1-frederic.mahe@cirad.fr>
References: <20261123101659.600247-1-frederic.mahe@cirad.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nv50_dp_mode_valid() keeps modes that are too fast for the DP link out
of the connector's mode list, but a user-supplied mode only goes through
atomic check, where nv50_outp_atomic_fix_depth() lowers bpc to 6 and
then accepts the mode even if it still does not fit.  Link training
then fails, the display stays dark and, before the previous fix, the
kernel crashed.

This happens with Xorg's modesetting driver, which builds modes from
the EDID itself: on a Quadro 600 (DP 1.1, 4 lanes at 2.7 Gbit/s) with a
4K monitor it sets 3840x2160@60 (533 MHz), which needs 1200 MB/s even
at 18 bpp against 1080 MB/s for the link.

Return -EINVAL from atomic check in that case, so userspace can fall
back to another mode.  Only check when the link capabilities are known,
so that a sink that is asleep or still resuming does not make every
commit fail.

Written with help from Claude (Anthropic); reviewed and tested on hardwar=
e.

Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
index e91130f..fbe8528 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -423,6 +423,21 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
 	/* We might have to reduce the bpc */
 	nv50_outp_atomic_fix_depth(encoder, crtc_state);
=20
+	/* Reject a mode that does not fit the DP link even at the lowest bpc:
+	 * link training would fail and the display would stay dark.  Only
+	 * when the link capabilities are known, so that a sink that is
+	 * asleep or still resuming does not make every commit fail.
+	 */
+	if (crtc_state->mode_changed && crtc_state->active) {
+		struct nouveau_encoder *nv_encoder =3D nouveau_encoder(encoder);
+
+		if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP &&
+		    nv_encoder->dp.link_nr && nv_encoder->dp.link_bw &&
+		    nv50_dp_mode_valid(nv_encoder, &crtc_state->adjusted_mode,
+				       NULL) !=3D MODE_OK)
+			return -EINVAL;
+	}
+
 	return 0;
 }
=20
--=20
2.53.0

