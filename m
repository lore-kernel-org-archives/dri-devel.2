Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E967EC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E3D10E027;
	Wed, 23 Sep 2026 00:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bkcEgQuL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AD810E027
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:16:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 347BD601F0;
 Wed, 23 Sep 2026 00:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392E21F000FF;
 Wed, 23 Sep 2026 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790122611;
 bh=PdJN38GtvBaVmtStM49iEIerdNIoUBgoWJhVeW1wEg8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bkcEgQuLL16y8QC+0gdllTUn7AybM41Cii1cv/CnUKbr9A1UJuGfivJlOU8FECVkN
 q1j+nmZX2WTE5gXko0K3x/0C5OWrwzAfaxc4mYHRzNDhd7nEjMTnUpeiU2sAJ8NKDL
 qeLgCfywgLEZoJLoxFEJ/xiN+n8jZUMbOguDhySCHgRCzgN4mAAvSIafR6UPy3sLX+
 B4nU4jDD0CAKXD0jyUODimfhEGKiwCxLV/L5F9qW0sIdEnXXKdBn2p8OXgFZ0tEG3v
 KdXEx0GYxYEUyh9s+OYr2R5G1J0zR6ZSdn2CfNsbNoQ+8xbdnDxDAHja6xBOpaq444
 3M4f6BayQs7tQ==
Date: Tue, 22 Sep 2026 17:16:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Austin, Alex (DCCG)" <alex.austin@amd.com>
Cc: Konstantin Sinyuk <ksinyuk@kernel.org>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Francois Dugast
 <francois.dugast@intel.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pieter.jansen-van-vuuren@amd.com, "Lucero
 Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <20260922171650.1003abc2@kernel.org>
In-Reply-To: <21f4b63b-1aed-47ca-a766-dcce8fe55203@amd.com>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <21f4b63b-1aed-47ca-a766-dcce8fe55203@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 22 Sep 2026 17:24:01 +0100 Austin, Alex (DCCG) wrote:
> Sorry for jumping in late to this discussion. We have hardware that uses
> UALoE (https://www.amd.com/en/products/rackscale-solutions/helios.html).
> The suggestion from Jason is sensible: a new subsystem for fabrics and
> reuse ethernet stuff from networking subsystem where possible. We would
> like to continue discussing this -=C2=A0 Alejandro and I will be attending
> Plumbers virtually.

Please don't "reuse" any networking subsystem code without an ack from
a networking maintainers.
