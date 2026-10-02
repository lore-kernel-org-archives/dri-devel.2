Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BA2CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FEF10E48E;
	Fri,  2 Oct 2026 17:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="QcxQCy9a";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11CD10E49A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790961516; bh=JMK2b0sy9rfTplSWVAHUGA+iVOrAfcBxnx+nESulluI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=QcxQCy9a9XPLzXZm08u+TB2MJPaGohrbWTLm5Rrx6QE00wGWMrQTJTG8frYg1r1gpmU6L8Pma4eaQ4JpUcH3x2CoOfO1I9u/hu5v+JGj9u8Cehy/TiHYi08OnNMM7+pqK2xtB6LS4KrIyyQr26Is639wE4gzqlCaQl4zx2+jroJY1JHBABwnYIhFUbD6FJqDhUP28iCtHzi4ja/vHchOS3Xd416n/ABQbP/0KViFrU3eBqJzIy4dZu3zs15IsDcbqNvy02Ej8ClFGPQxjzAYUSkUKAezq0FSKz2QOmTDSyDRi+bAU69McacO1iHOjowcllBahew9iOC78gZaMxwuVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790961516; bh=cljhZuKvGN9dSZ191+Vp8jwErfgIn1SBuL5pFGbRcHd=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=pMLqIn6+LtK5mx4Wx0pf5hTPL0u/+OEsWIqDY/BTuPOR0ffmzjJzMYqk9Egvs7mSeGSqgnbLTZCRyJY02A9TjjLsCHt0D9hW5YzlyWHfwPO6Ef+NBtcAK6bTeqwQ4PbGYoEblujKlmAasMEtfhBjYhMow30MlKzcg+9iM+atYp8QWYyj4y3ORwUY3wNOp1RpSyQkAsCoi4IYnlNau9wFdi1cSMIbwHMaejPBlZKJ3tA/up4BVo2lzp7AuUOhh+L9yH2/ZU7ug8aIBFm9qdcryNYOgNexXUgW+FSeiy/RaS+oGklw52lH2CeXbKUSZJj8UpnS8pcnG6sFJQ2K+BBMwg==
X-YMail-OSG: KrmHvUQVM1mr5mBL9iJGkhA1PvBsymrumsxgftJkI4n7gwgxbkj01tuTMHcM1QV
 g0fMNPWe1uL1KnKhabZNj8.lpHCm6jRwVrfnkYr9_WC5MwGAvAC0tQMhSebK8RIAhlAy.P7_D0Jl
 yahsxp6I9iScapv7znKjLa6ZvtimpbutYnaOsh7HMTcPrS6izWSlDoIFF2F3rqqUM93yQJGPWUor
 7Fc5da8luXL_02vOzlwd_J.22PdOebTCuNTBh.4V.AebAxSEJIh1VwPTlxPWakzGq0r5CnWBUzML
 B8qQ8g2nKjCoOY9i6yytXI5bZoTbbiOH6ZNhmnZD7_5yFnbt4CFEEfA171L.f7CndDkD328k4xCD
 1a4O1_ujIc9BNgJgCAi7D7.v3Ofm65PMqFfzfL_i2u0RX7amQ2mW4xNDg_wyfSEE_V6ncS97_bMT
 _p_YF.kkncQUqnfaW5uUq_wmfKAkV7d2jZPPBvlFHfFZppuNrWa1V0N0xFrgFPydPtmujGlkUlHQ
 0ogi69vrToU_8flrWePC.aCum0c0vz0viqcpk2yOFewXum.mqta3JD8ifaH2Gl0w2ixzpkiZL550
 ZyF9jz1PsCyBlTlFh3A0jzkjawWsDCBFV4sJOgLJ.wGVAyNWmcc6OJLHe1cE8XD7XYcFLUb383pJ
 QSgeu0L7DQtVw0RktBoZ1tFp83p_Ps0G4f6kKqX_HaU7gaIgCFzTrC65UBbxKLU27zdzBPG9KG_S
 CvFAR_Fddm6UJ00RqSid_CilCyn04YkkZvY3XLbZMrg3X70azY4nXxTJPgUpdGS3bCC6X7oEMSCv
 XjMR43E5J_2hNLyeX5ASuyGGkGz3ANkWAwPg4ffKl4BRzNV_AbwPOHIlEUvT3cySUck6Un7qlaK1
 bewFIZCj_uqLKD_GAD.qQPx0gZFUR1iCS9ero_Th3qtXlF90e7xE.8vLXn1i_zUBStOjz69o76B5
 PG6ael9aQ3qFGIU5L1Kye_IIzed347K_oYQeDAwTvDZiUsRH888opp7mH9CqmFJWZiTo0yFdHO5V
 InuiYtruCVFVT8dQjD_26AIRCZc8EeNkFykwjnPyLK0IeqOtqg_VquAaOyLykalb4XyJMMHNzWOL
 MpQ0EyZ58fOxnNk44j2ZrsTbPczBBnE.UunxTcBWU.9TD0fuN6EkqPtpFlYk.qFRrX_PJ3eiYQfA
 pjf8Uu3a_o.oF5z15EOEvEJ3hcThY8l3SA0OZ1p4t73xLPu3Iy0YizjRTvC4C6evdjnCFFxUviXJ
 jLXEnvu_.4vQPJUoLgFLKdFaLErQoyMp2qdN1zFH4c21jyxWtA3oNcWZx66mLtxhjpxUwWoRNt7p
 Htw5Pn1TmNuh8PymWJ08Nl.0TULRUjBZtGJaND6zYoVn7Akr0k.4TVaUzj5KvvJMn0AgWbtajitR
 Zog_bLcjkN1Dz3j2Y.J4XL59T28yKBIBNmlyvtBlFtbii6B_88EvLOVIWTvqQDkGndhvp2SNPHy8
 t.7Y0ZX5eQW_Bl_RpaTxKnKeFsF4ncQ.pl42HTWlWMTvZi5EzrYfDy_2IfSc6FWZ9C65pNfdWFE4
 zWm0sbBlm4hArgI4M_fJ7xSM1yFD9nJqb5mACZjhevp5wjGT9E4y1vbiTjAjQEdSZd8Aq7Wc75EF
 GCA4uwYae6oh4JSFEADCguKzamBSeRnAL7U.Etunp1zEy1Eg_Wrq_pFHUZFuObxUkWVLuTd8KCa3
 DxtoHkvV2WZTagSrHlbebfQ_DAhYOQY3R.Ww272DBWLbz3Rwuw7ILhRoVM0ms9p57sVLy452i09n
 U9coH8IJmlhYztjp7IhM9VJwS4snbxKsMTfpQEOOw8ES1cgAs2dxkbrLnXaFh4EFw8vd.brQhNnY
 8eCeQtAvyqOG.MFxDKWM0XgwwZxon8ihfpjV8x7ELwpAGKYoL8zlRUgrlEraB_AjGjubJHdtG7oa
 AcmbOiUNtorAkZJM_eQzxqrAtEpwt5Bn5UR4jNw2XbYZB51Z4WhaG4KiVq2S4f1oeq2KncDSyGX_
 qgIRCEwYYRv8-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 9f39a02d-5abc-4464-b7a3-cc0d4e00d0d3
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Fri, 2 Oct 2026 17:18:36 +0000
Received: from dip101.lsn.bf1.yahoo.com ([67.195.177.110])
 by hello (SMTP) with SMTP ID d3b1e2f7640dcd7522ba0b0650d3ea06;
 Fri, 02 Oct 2026 17:18:30 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Zhenhao Wan <whi4ed0g@gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau: Fix NULL pointer dereference in
 GET_ZCULL_INFO ioctl
Date: Fri,  2 Oct 2026 14:18:17 -0300
Message-ID: <20261002171818.281885-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815-null-fixes-v1-2-0df9dda951fb@gmail.com>
References: <20260815-null-fixes-v1-2-0df9dda951fb@gmail.com>
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

Hi Jim, Lyude,

This one repeats here every time.
Setup: an RTX 3060 (GA106) passed through to a VM, kernel 7.3-rc1,
Mesa 26.1.6 (Debian testing), firmware-nvidia-gsp not installed.
nouveau probes with "gr: firmware unavailable", so nvxx_gr() is NULL.
As soon as KWin starts, Mesa's NVK asks for the zcull info and the
kernel oopses:

  BUG: kernel NULL pointer dereference, address: 00000000000000f0
  RIP: 0010:nouveau_abi16_ioctl_get_zcull_info+0x17/0xa0 [nouveau]
  Comm: kwin_wayland

kwin_wayland dies with it, so the whole session goes, not only
acceleration.

With this patch alone the zcull oops is gone, but the next NULL
dereference follows right away, in GETPARAM with
NOUVEAU_GETPARAM_GRAPH_UNITS:

  RIP: 0010:nvkm_gr_units+0x9/0x30 [nouveau]

With this patch plus Zhenhao Wan's "drm/nouveau: prevent NULL deref of
gr in GETPARAM_GRAPH_UNITS", there is no oops: KWin starts and
composites, and NVK refuses the device cleanly (vkEnumeratePhysicalDevices
returns VK_ERROR_INITIALIZATION_FAILED).

To reproduce: a Turing or newer card on nouveau without
firmware-nvidia-gsp, then start any Vulkan or zink client.
Both fixes are needed for a desktop to survive a missing firmware
package.
Whatever helped find it, the bug is real, it repeats, and the check is
the obvious one.

Disclosure: I did this testing with an AI assistant, Claude Code
(Claude Opus 5.5). It built the kernels, ran the VM and read the
traces under my direction; I checked the results on the hardware.

For this patch, tested together with Zhenhao's:

Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>

Daniel
