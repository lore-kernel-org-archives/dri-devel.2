Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED2606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AXL5GIjx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A4110E52E;
	Tue, 24 Nov 2026 08:19:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1A910E52E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=8oyzW5Xhq7U02BOQUFs8WVt9Q7wuDOt/dl3tR8yBzUc=; t=1795508353; x=2110868353; 
 b=AXL5GIjxO4CXtmNkC6X/cLFjfqsg4RpNKyghBEiMgsum1HbsXV36rkQuVgMjiVkUKemaZUwAwE6
 jO/iChrTsX1HCwx1mD6KiyaUrekSo/33TF9TbYoxnPG7DAV2z6ni55FSRCB9FWMOIforRhMdmo5B3
 YEDs+ujMfPDxHFKeDITN9uj6u11TUP+qEtdP71ryWMBVbX0UtfW2ephRtKCMhNAWxQk/dTgZ/WA3g
 G1J5ekVdJmyOmocN/V5p8LVE4jucHHZczvMoYPRQNldS7iCuYD6HehfM5pxXJn4ulqXDUvXAZ4qfR
 ukexLrbmUklvcdA6EIO90BBQ+0eBSOhxU86w==;
Received: from [137.101.48.64] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVlk5-00000003FWX-32K0; Tue, 24 Nov 2026 09:19:09 +0100
Message-ID: <164b646734156ec16171abdb0de4ce1f3a723b6b.camel@igalia.com>
Subject: Re: [PATCH 2/2] drm/v3d: Remove V3D 3.3 and 4.1 support
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Melissa Wen <mwen@igalia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
Date: Tue, 24 Nov 2026 09:18:59 +0100
In-Reply-To: <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
References: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
 <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

El dom, 22-11-2026 a las 12:47 -0300, Ma=C3=ADra Canal escribi=C3=B3:
>=20
(...)
> @@ -210,8 +194,6 @@ static int v3d_v3d_debugfs_ident(struct seq_file
> *m, void *unused)
> =C2=A0		if (v3d->ver <=3D V3D_GEN_42) {
> =C2=A0			seq_printf(m, "=C2=A0 BCG int:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %d\=
n",
> =C2=A0				=C2=A0=C2=A0 (ident2 & V3D_IDENT2_BCG_INT) !=3D
> 0);
> -		}
> -		if (v3d->ver < V3D_GEN_41) {
> =C2=A0			seq_printf(m, "=C2=A0 Override TMU: %d\n",
> =C2=A0				=C2=A0=C2=A0 (misccfg & V3D_MISCCFG_OVRTMUOUT)
> !=3D 0);
> =C2=A0		}


This looks like a bugfix, since MISCCFG_OVRTMUOUT seems to exist in V3D
4.2 as well, maybe split out to a separate patch? Or at least mention
the small fix in the commit log.

Otherwise, pending feedback from Floarian and DT maintainers on your
question about removing compatibles, this patch is:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>



