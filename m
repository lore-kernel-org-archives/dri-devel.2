Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED827606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=zlSOePED
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC35410E293;
	Sun, 15 Nov 2026 20:51:30 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F99410E293
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=mzOs5klzZsM8DpqoUJkRmjxNxFZASEQHOw94+lLwCGA=; b=zlSOePEDqRn4Zo4UkzqpUSx/w5
 JgSMLMHUQZ97X3XIrSM/KIzDKoua1s9XMmvoYaRP6vr7fal/+zIm+mFb15i4OmRDyLrgOa1ETZPz5
 ynwuGz1Dz8iOeE5cdEGF7+UgBP0/yRCP1bzgpLUyONv6Orsgw/cMpu10SBQKqHjE/GBfUYmGmJSBA
 UOpf/+9CQ8/zYA6lEvGTDvhKGUEgsq4/wZCR9xBLjyg63aiS6kfhgPvx+SmPtJjXu397oYbFLkZNr
 VNQYza7sKMrLWBOxyKCQO6fw4xQ5QoNcLu66tZUZsZDm0v7Dq06K3wTGywPrfV3hg0R31Y+EeQnvA
 1BlxRdVg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH] accel/rocket: put IOMMU domain on BO creation failure
Date: Sun, 15 Nov 2026 21:51:18 +0100
Message-ID: <Z8-0sxgbQR2_ndmAA6Kohg@sntech.de>
In-Reply-To: <20260708114354.753817-1-lgs201920130244@gmail.com>
References: <20260708114354.753817-1-lgs201920130244@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Mittwoch, 8. Juli 2026, 13:43:54 Mitteleurop=C3=A4ische Normalzeit schri=
eb Guangshuo Li:
> rocket_ioctl_create_bo() takes an IOMMU domain reference for each newly
> created BO.
>=20
> The normal GEM object release path drops that reference from
> rocket_gem_bo_free(). However, the BO creation error paths free the
> object with drm_gem_shmem_object_free(), which bypasses the driver's GEM
> .free callback. Those paths therefore release the shmem object without
> dropping the IOMMU domain reference.
>=20
> Drop the domain reference explicitly on the BO creation error path before
> freeing the shmem object.
>=20
> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


