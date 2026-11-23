Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C1606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn0X8FZZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F5110E0B1;
	Mon, 23 Nov 2026 13:02:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104F410E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:02:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23EE861934;
 Mon, 23 Nov 2026 13:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C91F000C4;
 Mon, 23 Nov 2026 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795438927;
 bh=TJ2A87nOClwrvrq6t2auqPCfNpbW4imX0mx2kNoeTLo=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=hn0X8FZZh4Mjm5RDchkTDW5x555D25XzaKP3/VwujyCBP8DyWqtYBD3Ok7J5QyWr2
 JghiuQAsOMq7eMwOIo6V8nmhWZ8CpE/rIWZGsEugUvi7oRcQ6KhLEBfgaWUq8J/Bqy
 ZUt7tYli/3VI3AJR3mwWihDjG0Ng6kET74+L7U5Ule6hD1vJIvoFr8AGz12+sN8zn3
 SfdIHoTmFZqeuTIEGHzw1iLq4FyD8iCLZ09bwdl8D1rYSB9U4paqEy3PL5pfADH7wM
 l0CU5qNJlPQmTaZRJ0fFPsAls3Q61rABNf43CX+oI86jpuhPqs1Z7KJEIjJ5FC21Ak
 xzpnS4XoUO6yg==
Message-ID: <a7ab0adec79adca2dba948c634f45d6c@kernel.org>
Date: Mon, 23 Nov 2026 13:02:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 07/25] drm/connector: Remove drmm_connector_hdmi_ini2()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-7-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-7-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>,
 "Hans Verkuil" <hverkuil@kernel.org>, "Helge Deller" <deller@gmx.de>, "Igor
 Paunovic" <royalnet026@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?Um9iaW4gUsOkYmVy?= <robin.raebi@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thierry Reding" <treding@nvidia.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On Sat, 14 Nov 2026 20:03:31 +0200, Cristian Ciocaltea wrote:
> All callers have been converted to the new drmm_connector_hdmi_init()
> signature, so drop the transitional drmm_connector_hdmi_init2() helper
> along with its declaration, EXPORT_SYMBOL() and kernel-doc.
>=20
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, R=
ock 5B
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
