Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9197C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE6310E615;
	Mon, 13 Jul 2026 14:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="q0Hjk0dS";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3FB10E60A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783951557; x=1784556357; i=markus.elfring@web.de;
 bh=IN1IQs896HSaIw9gEbrqKaClxJt5RzMdKHMvraSsIio=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=q0Hjk0dSX2p6Y6fnLhzEmrxuAD9/dIL8t6tLZkncNVbtqwdpgN1dCbjvAu0FiCGh
 93XR/evK0CPKUCaeCnfFMwd8UNjIz0cw1EJihBYbGXWxtj2aydroJulvLvj0vmwIt
 D+oE0GAWPueocHbLXQCJ1R4GJ8UhzcTB2L9kaWg7ggc2xV2M4jhcQ9ECdfWbkyHb/
 JOca63O6f6sX48KlrNUEUN2CN38Lclf4vm1SLhbtsxQy4XFK7vt2gXYMUfHrWYmYu
 Yrb8ztUxjpr1TMwKUaMrf30pg6NAouNTqVDBBbgHehtlBSZXMwWotXhW+5SypvKHh
 MLD+49DARya0nRYIRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1wqwnw3duG-008vCf; Mon, 13
 Jul 2026 16:05:56 +0200
Message-ID: <e81277a0-93f8-45e9-9fa4-7c2c2df9c311@web.de>
Date: Mon, 13 Jul 2026 16:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/i915/bios: Move a variable assignment behind a null
 pointer check in intel_bios_encoder_supports_dp_dual_mode()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AGCv3si7pPH/jwVPGEDa/a4Gmy9w8/cL73mE/HY67HNX3d+sY5Z
 C58P4Nn/oryUeQvtlygm8FWT6oHpeLcG5NB32NY1LS2cMxuuoM/Q+uuk5csqXMhickScT22
 FR1fQY5SId6UI3OHX/d3XpVU4MCuKMRJ183DRjXpdGSJyZip8N29wQU7E/M+Xf9vZqzLnLX
 hhRuAMHLP5GL40agOxRTQ==
UI-OutboundReport: notjunk:1;M01:P0:Ek2Z/cCXGqU=;FWnwjbl8MR+daRXRfpbV6+arv8y
 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
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Jul 2026 15:56:46 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cintel_bios_encoder_supports_dp_dual_mode=E2=80=9D.

Thus avoid the risk for undefined behaviour by reducing the scope for
the variable =E2=80=9Cchild=E2=80=9D behind condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 044cbc7a74c136f12a80c855cadd1b085084aef1 ("drm/i915/bios: Nuke DEVI=
CE_TYPE_DP_DUAL_MODE_BITS")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/i915/display/intel_bios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i=
915/display/intel_bios.c
index 97cbae2e547e..1c4760373514 100644
=2D-- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -3514,8 +3514,6 @@ bool intel_bios_is_port_present(struct intel_display=
 *display, enum port port)
=20
 bool intel_bios_encoder_supports_dp_dual_mode(const struct intel_bios_enc=
oder_data *devdata)
 {
-	const struct child_device_config *child =3D &devdata->child;
-
 	if (!devdata)
 		return false;
=20
@@ -3523,6 +3521,8 @@ bool intel_bios_encoder_supports_dp_dual_mode(const =
struct intel_bios_encoder_da
 	    !intel_bios_encoder_supports_hdmi(devdata))
 		return false;
=20
+	const struct child_device_config *child =3D &devdata->child;
+
 	if (dvo_port_type(child->dvo_port) =3D=3D DVO_PORT_DPA)
 		return true;
=20
=2D-=20
2.55.0

