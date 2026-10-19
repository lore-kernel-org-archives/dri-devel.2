Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=noirlang.tr header.i=@noirlang.tr header.a=rsa-sha256 header.s=mail header.b=rWwqLpRQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BCA10F304;
	Tue, 20 Oct 2026 07:36:38 +0000 (UTC)
Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9894410E8AA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
 t=1792400329; bh=vy/QfJwvOl5NZkN6GRHZUnAWaidHniVzTUyIxztUz5A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rWwqLpRQNbqu1C6KCGrBhcGyE42MBBklQIH10/nPIR45sOm9V/TEohudTUIWHBnaQ
 H9QRhNjEViIsbj9nxumsdjkOO8Eli/w8cPHplN0KppING18R5o1M4EEEJMV/UmUW4i
 p2MhkJ1yP8bV144CSx0l1c2XbgCTQDQFDJ7f+HBgpFe2m1ts3f/D03O2ejrGUfg2oc
 kWbvzgGx5cwx6zlMR+uErBTvQzlvYnYeeH/2kuLfaxbW3SIYkfjATEobq/lQn62z1d
 meI56C+1v8IUYzAj6ZyN4jUszLCU3zTItVkr+d3FRlMVYAG0WjUaGX+OwQ93qddDNT
 fRHFDSOiewYbQ==
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Melih Emik <melihemik@noirlang.tr>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, gurchetansingh@chromium.org,
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: inline drm_simple_encoder_init()
In-Reply-To: <f91ca908-689f-4732-bfb3-0e254c22361d@suse.de>
References: <20261018112844.360262-1-melihemik@noirlang.tr>
 <f91ca908-689f-4732-bfb3-0e254c22361d@suse.de>
Date: Mon, 19 Oct 2026 11:58:44 +0300
Message-ID: <179240032411.5720.11612713342126517911@noirlang.tr>
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVGhvbWFzLAoKVGhhbmtzIGZvciB0aGUgcG9pbnRlciEgSSB3aWxsIGJhc2UgZnV0dXJlIERS
TSB3b3JrIG9uIGRybS1taXNjL2RybS10aXAuCgpCZXN0IHJlZ2FyZHMsCk1lbGloCg==
