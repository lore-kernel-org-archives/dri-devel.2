Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4DFC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704A410EDD4;
	Thu, 30 Jul 2026 07:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.b="r/oLO9AF";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com
 [34.2.82.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6CF10E14B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048;
 t=1785322176; bh=uxve866BWF4htd0+CpMI2/Yr/XqQcHixAEiZK3UmVoQ=;
 h=From:Date:Subject:To:Cc:References:From:Subject:Reply-To;
 b=r/oLO9AFViCRBKgswai6DoE1qp59XiIj8hlVP2eKJYE3tSduf5kvRojeCRrA9COfStVLsfMd257vNcb8O28ok+XHS4f/9fEcKbn5JVSXXelAzYNnqtjuOoDdsk+Ze1L7zDCU6JF2HpT7CCTQz32r6T0FFsDQirpE6uIlYNtCZqbq6uAZG8T48IBRudH1v7FZgmmwcXShtXhQo1KsDPMYaXIbKqEKskTUZ+pXnpEOTcc7dHshZioupLsjyFdS2tUpmhZEbmIlmosw1aVzOivs6ZQXohxcTmrCRUx10oP6vaZ8uLpbQmv3YgExFIUbNzras/PmzE1+IJSJJF74dx/FMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785322176; bh=0txDAdqkQeVMnTeBx7ONn8K1Mad+UlpB9gvmCojtVMV=;
 h=X-Sonic-MF:From:Date:Subject:To:From:Subject;
 b=VqGjtUaGaJUV/LsGrf3xMIO+qw8tsZC5iOEpV99Ek9dd9fiap/CC1U5g14TOMjI6/aM6Z52alebpYEguzV1XOtGFM2SScE6apXm3loRVsw43WkgUCnnGgsIHE2V4axs1PS7kpvLxx/K517CKiVXDwbkrjPcRdTYOgTG9Ozbr5uw9kR1iPkopq/gmGT1xla3z3Pw4buFQP4uS8Gv5hHe0j2f2kNWj43+eulA6ErnP2qKFymW3WRIH6SMc9wc5utZBSYqid4ntJk8UteJDd2vCGZLklMbD4WciEmBxxwfRR6sP0JZSvIxCV5FHzACDIwvzu70CO6KT1S51KNih5rZk+A==
X-YMail-OSG: VUJu24IVM1mEqiOHtHeWkIGRHPvkQHCoy0RQnbWt7J6oM2M0Ju6S1_TKpxFfD6G
 F6wR6lVinD6HSIyN19YwqYhkKxNPctz5Taf9WLROw0Wp8n6JXN9mO4JguRU3uqX4mGLpRAgs0zGT
 ypw5VNbzUaCjd489fHgUCyrYGym43gEiNNog9FmjsG5TkSR6DH1t.lVu_bArHfWsHg7hYB_0Ifxd
 oCJY0EKeqMHWPnSGgbmcaQGPg3VqcthkjM3QpJmHi6cV52W6tqMO0Svwihyan0vKjC.lMvUccqSO
 iRa9BdZnYHvXJX8mUkI4W.zNyacPqbGktlTkJlwhioXUeiDxl2_uJv_v1fPfubjCA.dJs7n3z.n0
 jUPLFw3SmvNV.9KXNxGPbNEX76GRviHEjKRhdjFOv8kVNe9r_2NInbkZyst9oMcQgpYH7xya1dmb
 ayf_3PWvmQs1e9c0PvkUNjgIDIbQu8UfONuiCTdMH_7Kb.rK7MD_fax6MPr6v3PNuho4O5upBYDt
 Eh9mJA0CPa4yw4ibF5rBgHuiRVZlpndq8hZhZcuxD8n8D74QFsVCK0.Vh8Ia6YPZxPg_6RDgOkuK
 KnPpuKuKUPL4L3MlIyOUQTbFIL4YPwFfNrHRQ.v0RjfOlvUZe.8k_Dv98vGrXBTlR6znoNzlrsZy
 P5KQSyoJ51dQyJubAama52HRLPz3l6Lp9xaqYJ9BkU7gJDTcVnOMeHHO9XhzaMC.EHjZlBtD5LPW
 eVrambySjBI.iDZS1lAas6XjbF5nuHceBinc7sZ99lsdLpfSSUCJDIxN.dSxonCdn_y4xZ63HpmR
 UJv1dcPfwxM8l_nyEEGfFbmlzQl30g1gbDjEJE4VE1nw5fpZEZ58qpiNZQ1j1b2sgprQzNrFAZ31
 lEW5X5odav27Qe39Bu6rmvjzkUcxevIOAShXonNhPvbGx9oS.xL2fhSV3.ao.MHXRCK6Gf4oUWCG
 L.pnAkkqwvVSQ4B4LjG7xy8C9GyCZb_n9GZ0eZ7r3iQGTj4kTrwME_nvltourCyjbHfKoilKnGdd
 .UoEU1kIjQ6TUGCi3Tuj4CaLkJkmYBOo6wN.3ZHd1vyfUwmezRQvQwmpluQbPXoEKhaI5qErfhY0
 k3l4Ey5a7jLuitrtmHBmJdzcsQGy1gbZj5fENOuW11iF7_hGLqsOa8eVRO9VTVDnwZb.QJ5omVAq
 RPCDRTYLBVWErgLbGXXmEuhpprWkwcUyFyC5qMU4Hb26QpoAp7I1mDx0tG5F8TrSkhBC1wTCoAYz
 MgiNzK.qRJn_yFmabQyLuRba.9TRYg3da8LtV27y5CBkiIvmo.iEZf1AeghKvgg9KUgwyeriQK0N
 yqWIxD6L6lBaq0l_njg.Nkf5Xi3JPWjUKJlv2To2gYobZmh6avkgaqO7.q2EB_K1Tgjizz1yqyJv
 rjHQyCbSMnSKRuN7ycVf_zaxDbxHScrg4foV1JSkSIHydvVraCyYWC3r37.9Sy64w7mf4LYWTUW_
 OLZp3.WMAU6xck9pFJSr4hDjxBPmwYMxris7ctbwDViWHwWZOVIcyPRnrDS7CdbMBVAncarq48fB
 TDmeD8JalCDVq.rAbdRyJKL1NV8vITwzehkbI2XvnpMMzrDrVtaDG5x9romujTW8hZVE.XKSu3DV
 2RhSF.7slSR5ua6hZOpDoIyyfuSXylKyh4u9Zl8kDdpaJS0rxY07mg4XsEOi7HLeuudPyQvbfyit
 mLXMm5HrNdjifkBKqIYYitj5fAuhkLNDVgtJe5bP_NOBn.NwITE33HPohi1LI3qkn_VZBhEl.p0A
 AshhgUVSaru_XAFaRE8o.uZu61Czbvxc4u8O3bNiep_6koDIAfyaXfE5Q_jigrNIBx6KWO.QpYrO
 OujqLLzvGHhw5ZE4R9ezYCNCNbFDws4JozxRGsRVYdhRFgePqS05qt49g_unBHg0asoiHYi_EF1s
 tSdpMjExD_nGeuJHCO9zVdnyIJE7bTcCAm3zjHcRyB1k_84VzHHxQIqTVNC29UFlac3gNffI3aO2
 Tt7qRS.2lmzXFJsxrV.jSWcDvZ6_xBlYbl43MVLEtGH6m9eJxt0_qKDdtIzo.Hn627A5QbMGKoKM
 DWBm3
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 9838cddb-c3db-4c47-8765-365365e09484
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 29 Jul 2026 10:49:36 +0000
Received: from dip182.lsn.ir2.yahoo.com ([87.248.99.191])
 by hello (SMTP) with SMTP ID 55ed7eb25d4b538459b72a781fc4e23e;
 Wed, 29 Jul 2026 10:49:34 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
Date: Wed, 29 Jul 2026 12:49:35 +0200
Subject: [PATCH] staging: fbtft: fix typo in fb_upd161704.c comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-upd161704-typo-v3-v1-1-69c962e35d59@yahoo.pl>
X-B4-Tracking: v=1; b=H4sIAL7aaWoC/yXMTQ6DIBBA4auYWTsJPxaSXqXpQnBspwskIEZjv
 LtUl9/ivR0yJaYMz2aHRAtnnkKFbBvw3z58CHmoBiWUEVZZLHGQRlrR4bzFCReNJI2mR++0dwZ
 qFxONvF7P1/t2Lu5Hfv6P4DhO05YSrHUAAAA=
X-Change-ID: 20260727-upd161704-typo-v3-e163e5ab3cb6
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Tomasz Unger <tomasz.unger@yahoo.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785322179; l=1089;
 i=tomasz.unger@yahoo.pl; s=20260611; h=from:subject:message-id;
 bh=csNuAcxNQxEm0JFQBbE30OkWlqKgkmwFKZ1ttNV2frY=;
 b=G47v76Ny6yUZ7ibrRTdY5NkJWZTUwHVOvWCnpBnqpgt9J+OBIpTkcz7L9OBRxDg5rsbOvcF9Y
 Bb4ZLnBBvbyB5yBUaubzhwssd5KaqpTlbW/+FZlPR5xWLGz/Sj85fD1
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519;
 pk=elW+gk1cZhyVAkPUfX4QaVHbxERM6w8ByGYxz0Rijl0=
References: <20260729-upd161704-typo-v3-v1-1-69c962e35d59.ref@yahoo.pl>
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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

Fix 'cencter' typo to 'center' in a register setting comment.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/staging/fbtft/fb_upd161704.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..7288140e7c3e 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -67,7 +67,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x001D, 0x0000);	/* Regulator current setting */
 	write_reg(par, 0x001E, 0x0009);	/* VCOM output setting */
 	write_reg(par, 0x001F, 0x0035);	/* VCOM amplitude setting */
-	write_reg(par, 0x0020, 0x0015);	/* VCOMM cencter setting */
+	write_reg(par, 0x0020, 0x0015);	/* VCOMM center setting */
 	write_reg(par, 0x0018, 0x1E7B);	/* DC/DC operation setting */
 
 	/* windows setting */

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-upd161704-typo-v3-e163e5ab3cb6

Best regards,
--  
Tomasz Unger <tomasz.unger@yahoo.pl>

