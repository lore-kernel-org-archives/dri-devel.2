Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E57606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mpa85pA/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9B610E5A0;
	Sat, 14 Nov 2026 18:15:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E212710E5A0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:15:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02C4B601EF;
 Sat, 14 Nov 2026 18:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8BA1F000C4;
 Sat, 14 Nov 2026 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794680137;
 bh=5b02MZZayhLsxpIzoaQ9gsuLh7vJhSxmtQtS4FAzGr8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mpa85pA//SXnkJSokqeLC7mUvb+UjxZ//2uFatP7OJ5PzNpY3USt1l6lKgduu2WT+
 fUWtTBMUYq60IGgspEjR3UvRTlfacvUSPuz1mF0yh3rYlR4GTIp9GtZME5sjJPN/JO
 hksNqfwmLHFbi1QSuo50Z2VmmtKjDXngL/HVftCrAKh9C4F67M68TJJphgNX12Ofcr
 ygAnh0sEAcnwyISMS7yWhi/615zilHqYERcKD0p8OttivK8hd4B4lFk59oTGXvhh4/
 0DXYB+i4Xgnu6o7w8XqkJGyi4Ii+CfrhcrkMBRknWdKJCMznjfST/TE66qdZkD5aXw
 WdpOuqJtkJ3ZA==
Message-ID: <sashiko-outbox-214896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/25] video/hdmi: Copy SPD vendor/product with
 strtomem_pad()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:15:35 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] video/hdmi: inaccurate Fixes trailer for
  hdmi_spd_infoframe_init()
--

commit 7959e6f9456b8b3e3ae9874fc5b26920be113583
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

> video/hdmi: Copy SPD vendor/product with strtomem_pad()
>
> The HDMI specification defines the SPD InfoFrame Vendor Name and Product
> Description as fixed-size fields, padded with zeros and left without any
> trailing NUL when a name spans the whole field.
>
> Mark the fields as non-strings, so that the copies can be handed over to
> strtomem_pad(), which implements precisely the required semantics.  This
> also bounds the reads from the source strings, whereas the open-coded
> strlen() could run past the end of the buffer in the
> hdmi_spd_infoframe_unpack() path, where the names come straight from the
> wire and are not NUL-terminated.
>
> Fixes: 2c676f378edb ("[media] hdmi: added unpack and logging functions fo=
r InfoFrames")
> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[Severity: Low]
Should the Fixes: tag point to 35bed3fa9ec5 ("drivers/video: Fix
-Wstringop-truncation in hdmi.c") instead?

When 2c676f378edb ("[media] hdmi: added unpack and logging functions for
InfoFrames") added hdmi_spd_infoframe_unpack(), hdmi_spd_infoframe_init()
used strncpy() bounded by sizeof(frame->vendor) and
sizeof(frame->product).  The unbounded strlen() calls replaced by this
patch were introduced by 35bed3fa9ec5 ("drivers/video: Fix
-Wstringop-truncation in hdmi.c").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-drm-conn-h=
dmi-cleanup-v1-0-20e8a33a2286@collabora.com?part=3D1
