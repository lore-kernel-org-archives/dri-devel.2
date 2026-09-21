Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC1C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C3F10EAB0;
	Mon, 21 Sep 2026 20:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="inC0rgbH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85C010EADB
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 20:19:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3696403A1;
 Mon, 21 Sep 2026 20:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1441F000FF;
 Mon, 21 Sep 2026 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790021952;
 bh=cNXdQdZRudtnqxBAb72I5voOVN5GsT81p76+NrhRJ8A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=inC0rgbHTlZZta0tfzysd01IRrwJwj5OkkqxF0M0hGhwHyA4PGIpZGE1KOwrVCpiB
 ahUbYtbqX1skiTPo+4ZkqlRo13tWiM15c2b0+MVteEMkR1X9QWHhp0ua/L/KM85sdR
 bZ3WVQyMCPZuTehc2sILYmIVoFQ4QRx4/YhIDeiAqjyb3HkpYPk8HCkQg5LAVuHQ0/
 22SXASh6J102RtipKDPpKNjuNOZgZOKPS6E+hG40t+1PosEZbmX/PXjT2HWWXANDm/
 Ph8tjWrMPz3BNP9YKqymMZ3E4KBe+gijjHxPk5soihlW/i/gmDr08IAGt4AdiH8x0O
 453iV1rHDIgbg==
Date: Mon, 21 Sep 2026 13:19:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Sinyuk <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Francois Dugast
 <francois.dugast@intel.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <20260921131911.532d81f4@kernel.org>
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 24 Aug 2026 11:09:28 +0300 Konstantin Sinyuk wrote:
>   2. Are the Generic Netlink semantics, including dump consistency,
>      notifications and optional port statistics, aligned with YNL
>      expectations?

> 39 files changed, 13189 insertions(+)

Networking is absolutely flooded with AI generated patches.
Including long term contributors excreting huge unreviewed
code dumps :/ We have absolutely no time to help other subsystems.
Please do not use Netlink going forward, sorry.
