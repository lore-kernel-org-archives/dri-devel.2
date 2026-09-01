Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF848C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3309C10E3A1;
	Tue,  1 Sep 2026 06:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qfSiRiMb";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF3310E3A1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 06:55:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 34B791A192B;
 Tue,  1 Sep 2026 06:55:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 039C66053C;
 Tue,  1 Sep 2026 06:55:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 171F211C79252; 
 Tue,  1 Sep 2026 08:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788245715; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=g/4nzwCLkeiwyDmxbPDKBN1nmVr53VNFfbnwq6i7x5M=;
 b=qfSiRiMbcWc9WiAj0ks+D4Z8KFnzQehkISlSvmKWObEHMrAOG39Qj+Kwu77WG4bsU3F20U
 WaZnvyESCNLbyrOgnFWYgnJttJuOt595PiEvTmMz1igC01dOeGdX6Jn/0QN3yQ8pFqciCP
 vAGttUfyhtNm86vj7aMQ/XxoEI9/xDRA8Ho9PHZ9w8GMnyuRxagNP+g3Nx9sXMtuSPyzZE
 MK4ZGZsfPfQOc9ssEL3mFTb44XfIkli/s55ha/oUDN1rFjlCL0T74wP1cVRnKVdGN4C+iN
 FU8uDFeXr9LRsXuu3f3CVsVF3ECTgmQHTY46HxQc3NqPg+4fTItgIZJtlCLE5A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 08:55:13 +0200
Message-Id: <DL3S77X727AD.1714RQA4420L4@bootlin.com>
Subject: Re: [PATCH v3 10/13] drm/bridge: tc358767: select DRM_PANEL_BRIDGE
Cc: <dri-devel@lists.freedesktop.org>
To: <sashiko-reviews@lists.linux.dev>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com>
 <20260831-drm-bridge-drm_panel-cleanup-v3-10-50efd8168b3e@bootlin.com>
 <20260831195144.BF3EB1F000E9@smtp.kernel.org>
In-Reply-To: <20260831195144.BF3EB1F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon Aug 31, 2026 at 9:51 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message inaccurately claims the driver uses `devm_d=
rm_of_get_bridge()`, but it actually uses `devm_drm_panel_bridge_add()`.

Indeed. Fix queued locally for v4. If the v3 patch is acked I will fix the
commit message while applying.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
