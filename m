Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E4F3D5FE
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1854310E0D8;
	Sun, 29 Mar 2026 09:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="WbfS4Qzv";
	dkim-atps=neutral
Received: from sonic311-23.consmr.mail.ne1.yahoo.com
 (sonic311-23.consmr.mail.ne1.yahoo.com [66.163.188.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D4110E4BF
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1774769673; bh=V7Fe5j5YmQNWtMWv+HiettIuHXaF9B12nKExBxT8Hk4=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=WbfS4QzvqvhefStTi/MvPdH/+0wdO8m2qItn3B4WCYAGWSidtjqIus8Q9fUoVaEuucJwKfXte43Ddf/ARXZKy4A1hNgu8dTMql60Wvx416rcOHOWzYvMzrdUxs4S+fAvhF93/9iuRLUXLH4PtxyKRMlK/CrxYtI4Bx6DYhn/g7phr14WzoZn7x4/cqRqXebf4nBlHBkbo0xo83S1w4t2KokringcE/sx3/BAIMCaTBKtIY6wl4ygkIlLSKnNB6xSvRePmmVAb8ttipjVQIXQiKqdXH16tuTIOMWwvQv4NzZ1J3oPef/vORs7kIw5D0iOyBJypeQisEGXqYbbHbaKBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1774769673; bh=cCbimxfdOGXC4/KwP+oN36JbXQmpwEOrlp9nc8FFdN3=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=DPjVkCZZfqzIVgvZ1Yu7gwzy08hvFjTOM+WUms4b/W2h8oCyOEhCcjCgPV9/UKsMKFQ2rzJRMCybMDvdVOUsb6AOjKdxJKHDa/PWwX8+6N3hnAG6o8ZZUaRYj0cfNqY6LOfxNqfbM1Co26CJvGKEirpWSTjvWT8UqnGilrEZ3GMMg584wD5xhzEccHv4DVEChuQb37D+DF25FXbXkyaBGa0y2IZOfKUI+5Zw77kdO+SKHGRY2vYwGDR3hBSVAnhGify9wyt0HM3LxQG8o+lChOntZoFqwFqZdKXDLH7Dy8dn13rnNWLXOWTVqY9a3Tnpa6W1uvOtmnw/wbIYBvZDPg==
X-YMail-OSG: wiG56L0VM1lXOrMO7zYN_3EBKtFe6gaNfbn4VxGauCW_4zaeyWLtTSFI_K4VXlU
 EVq8lBrotN1UgbHOZtnlDPQtCZnzwdeQq5fctod.kzCbXw1him0Zzw_LJHlmbyidWFdxuGh2lpbm
 GEqj6M2ivlm91NkusoqEyoxIVifZWYrpMMVkQMkYLnLfPVlFyDCVFTKYzGWflhEcCwMaJE30RdDe
 l2YwVBDRT7LL6V0K40EdXRM8FhDV3s4HydYtec4LFR6sTPGfLB70hayBvC2DcPlZBUh.BlkEfqhg
 tZVQ4eL6MXghcWc3Q3d2xo7Z.uokBG0LmIxtTbbuQSdSgdu950Brs__nd6be_YohY_aQOal_KLgH
 d2n8AemC3GRr0_40zbQ2oU6wypwy.wTxX583wUV_XeCUe3DoQvtrmQVAthC.sNFoag_BGDcaSrLx
 Gzvtbf0qiVPQzHDzlHGRRRobYP0DR5h7SlCiqfHUNUhiEAXT1zV5pb4FsQZoO_39LKKRQyRnzXuS
 acsF6FLJDCI8YYLgMcFnetc7EK8Z4EbYSzdiet9uiao0rq5Qg6d.eei.sqvsy1klaJZfaQp_86cm
 1LM7Yxg8PSpm3mm.mE3awxBGpUUmF9Rm8fUsBPd.cDWxZhjN5HnFYRJOYafM7GS8qWPqF8CwQorL
 11_O3z15NbcRyKFEFkM4vHWjVqqmTvnPCVRZBFTlWM5sYT13hrIs6BaKDnJ9glSyTfxvvDCOx.p_
 k80eS7_8X2QeTOyokKXtxBvgv7RJNwxLtDmXCzL3nKklnqq6JyRK8AUkGoT5OAB5nRlaX2OZIqJu
 pEKB8hoHCvvnh.XkkqDNNjdVL3T8yoYsAxWgvibjD69SqGyMh95pKKKWUmYLV2uYvb8OZiGYh38x
 fEns0XbT.gVObyxX8fTZ1Ut0660FdBmndzuKt9k.bKGucvKw_yqKpcC.juPY4DOsM85jQhQMUsIK
 giY2PsvUjpSSbXnhhu6HGEbeZ_rCfg6GEY5q2pm4d1o_7YVNCh7OmDef.WeyGfhyqrYKoZEuTeAW
 pWzPx2F3kTH.5Ocuis1tl9qSccArVf2U6AftT4.px8d2pGfQ.ZPZfJyyxj3E2aIT.e.9ibPnowRe
 YQ5rWY32ReBbmrVRkhR29oB5pAWHBH9_1eKaNukLYfxSokHfU9IvTeUgl99JZ04K.tR3axRf_V2Q
 nSqtdBlqEqIV9UHZWIGXpKJuzrF2XKKsLUqU1GR_6LhaTAlpbmGkEQBV9b9ydBdXzwy2Bcf98M9.
 BUKFznTlvaTTpokaDDvKqPCsAds3HPYeSYe043X40DEpY93YafL3svwtg648ZnSKBakeRsau9Lj2
 ZrU6N0.reRDtIIYpnclmXLKSuhY75ineJD5rSme.L_LkOiCDWYnY_63.JBSEtmKyxZ9O455osAjM
 4rgtRgrIsmBOe7m77troeCD_2IIUuwx7AIQn0fb8D6rXqwAbHAYtaMMFzggWU0Gsst0yJDjAxWIi
 A8iECGs5bTmfQkGIScICpPEYicR0o1ed5.cUappYW9m8hIqNmIKXEK0LdKam1nb.mOSU7MBqp6Ux
 GnXFtuTaU0vpNCW_4z2rdVj65QDEC6MxeqBIUnCum2WEk6He1RWRc4h.oB4kio19n4YyBwxj3h4I
 0zABzRNZkNm_VNZhfXbFiJjEUJj5h8giBRJ49ExhfbQQS9GcBJnUoxHRsUF_eubvdqNHUCMRuZpq
 KielRewyByp7LO2vzenPi893zm.aBkyO6dUBkFH_BmoX2svPw7rGc_3XoHCrM8aYp4GLwJ7TfSql
 ATgdC5xqahwiLJE9McDL.ZqwFmu64ugmrrLuldui3IzoGt2F1sNo1dypHKoS3bWw4MTQtgByiruv
 lgeFG.NJJ3IpUku1mAHGo3w.RHs9lIXFNpBxxWi7ZkzfYvXn4y.doqz5YO4DaUnbDohsOzO.vm1D
 eV24BnIw7FqC8qBxzCL61lfSujwEqpKLMFCIs1tG0cMh1VLvQ12Tg.8FO5enJxfD19PGZmw6.rgW
 Huwpb5tOMUqUMmlh0mBQTo_Bzmm3LlF6rdbKMovPRUseU70lcCNN1DblylyCFzcUYJ3ByqUTKP19
 emvDcICj68Be9HMLGZuYfAVo_bG.y8p3ixPbSol5zVWmpItFelmqPTnBcdOseO7V6oFz.vx.nsPg
 SgFKlzBX2kliio.pOEnUQfYbil4WKUoeqtl_XDQQyAIBVEPkj0ti86l3XqXRwHG.4PJMFI.H5ju7
 2mKzfWo0LhvOpCnkxQck9WyS8mjbGZ4PxNt73vuSeeDPwnakpkrAF9GTytqbn7714YtFZrU4MjeP
 QPc8E2g9KzgVvp0tSRNcxQwQgUcnQp4.Bvsom
X-Sonic-MF: <abhishek_sts8@yahoo.com>
X-Sonic-ID: f9e14122-7cc6-405d-9192-7017615a970f
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 29 Mar 2026 07:34:33 +0000
Received: by hermes--production-sg3-6959968fbd-gj7s8 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 704786d9823fd8a8253f68d6c834048e; 
 Sun, 29 Mar 2026 07:34:27 +0000 (UTC)
From: Abhishek Kumar <abhishek_sts8@yahoo.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch,
 syzbot+3fc9eecaf97147282c87@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Abhishek Kumar <abhishek_sts8@yahoo.com>
Subject: [PATCH] drm/atomic: fix vblank event leak in complete_signaling()
Date: Sun, 29 Mar 2026 13:04:23 +0530
Message-ID: <20260329073423.8390-1-abhishek_sts8@yahoo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260329073423.8390-1-abhishek_sts8.ref@yahoo.com>
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

When prepare_signaling() creates a vblank event via create_vblank_event()
but hits an error before the event is fully initialized (i.e. before
drm_event_reserve_init() sets file_priv or a fence is assigned to
event->base.fence), the subsequent call to complete_signaling() fails to
free the event because its cleanup condition requires at least one of
those fields to be set:

    if (event && (event->base.fence || event->base.file_priv))

This happens when only fence_ptr triggers event creation but a subsequent
allocation failure occurs before the fence is assigned to the event. The
128-byte event object is then orphaned and reported by kmemleak.

Fix this by adding an else-if branch that frees events which have no
completion callback set. Events allocated by
drm_atomic_helper_setup_commit() always have completion set, so checking
for its absence safely identifies events that were allocated by
prepare_signaling() but never fully set up.

Reported-by: syzbot+3fc9eecaf97147282c87@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3fc9eecaf97147282c87
Fixes: 92c715fca907 ("drm/atomic: Fix double free in drm_atomic_state_default_clear")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Kumar <abhishek_sts8@yahoo.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 87de41fb4459..52a6b8436437 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1523,6 +1523,17 @@ static void complete_signaling(struct drm_device *dev,
 		if (event && (event->base.fence || event->base.file_priv)) {
 			drm_event_cancel_free(dev, &event->base);
 			crtc_state->event = NULL;
+		} else if (event && !event->base.completion) {
+			/*
+			 * The event was allocated by prepare_signaling()
+			 * but an error path was hit before the event got
+			 * fully set up (fence or file_priv assigned).
+			 * Events from drm_atomic_helper_setup_commit()
+			 * always have completion set, so checking for its
+			 * absence safely distinguishes our events.
+			 */
+			kfree(event);
+			crtc_state->event = NULL;
 		}
 	}
 
-- 
2.43.0

