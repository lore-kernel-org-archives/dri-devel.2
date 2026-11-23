Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F8606A68D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jf/OJI0u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5D910E72A;
	Mon, 23 Nov 2026 12:53:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E3310E72A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:53:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBCAD4420D;
 Mon, 23 Nov 2026 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C029D1F000CF;
 Mon, 23 Nov 2026 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795438381;
 bh=HU6ScoabHL06Z0tq1jjSkMGrZ76XZfdtU4bDDbS3dPs=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Jf/OJI0ufwqrmkYaNVEMPsk8kCX+SBiA2TZUjqVJ9buukz8Jsj1xYGL54wcE0dUI9
 Fl2HQFgAebH62FGTr8L45Sl0TLC8u5l5jKoMASn+vJkK9pCTOOKx8SoOIfWPOqJZ5+
 a7MLPs+k6DnK2H2ishQlbvZoIBHz6VNSSfSKVRUzTI4ZuDpFPzRnX64gWZn7baxEKt
 w/JYKhFX7OGYjYOR4u63AZJZft7lM2f1tEFJznOHQhVXaOks0Z3F6Ez8QX0m9qyJRg
 0aUdCzSieTzXw4E3D5vJ5O86D2UyZcrYAwAg0XjQl4eCtSzb2cL3YB9BIhSuAUogWP
 IKQcY48qfAvbw==
Message-ID: <bc455d63f5e201cd12d81dbd29230bfc@kernel.org>
Date: Mon, 23 Nov 2026 12:52:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 02/25] video/hdmi: Define SPD InfoFrame vendor/product
 field lengths
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-2-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-2-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Sat, 14 Nov 2026 20:03:26 +0200, Cristian Ciocaltea wrote:
> The HDMI specification defines the SPD InfoFrame Vendor Name and
> Product Description as fixed-size fields of 8 and 16 bytes
> respectively.
> 
> Add defines for those lengths and use them in place of the related
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
