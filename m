Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03903C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B33110E2EF;
	Wed, 26 Aug 2026 15:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LYiMeGj1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3BA10E2EF
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:39:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE6DE6001D;
 Wed, 26 Aug 2026 15:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F811F000E9;
 Wed, 26 Aug 2026 15:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787758741;
 bh=PcufB80+r0hfnaaaft6SSnvoAUt8Fpms4kJHZhTB/E0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LYiMeGj1J08r+tqq+QKmSVROhE6t7j13NRjjyEGSAmItELjutpsGAAtYTcvDPpHH8
 rAiDRVTgnE17Upg6aVosDTEjdi+KhV2eetQ29xW4HOCRrlhxA0AVErz/dJF5FuLPH6
 8dnZkHTr3MhWFj2zrrvLK7AK8bN7epsgUk0kNJofuW1zfvJi7L1a9x4CV9fOjo0JIN
 lKM/x6hZKBiV9X0P2FuWwPsrwZb0ChXj/Wi3uDAsM0v3OBDsJ7BhRyQoeOTcbWl4fJ
 RE+Cbr8t1dNQKk30KJBmjG5a2UrHGPrn41S6BDN6bgmSKTHWgpp4RMT0z6I9X+LHuS
 qfh326u2VXerw==
Date: Wed, 26 Aug 2026 18:38:58 +0300
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <fabric-leon-reply.1787844400.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260826093222.GC42790@unreal>
In-Reply-To: <20260826093222.GC42790@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Wed, Aug 26, 2026 at 12:32:22PM +0300, Leon Romanovsky wrote:
> Tell your AI that this is not how things work in the real world. The chances
> of multiple hardware implementations fitting a software model designed
> without considering the actual hardware are effectively zero. This is why
> successful subsystems have emerged from consolidating support for multiple
> existing hardware implementations.

Fair point. The simulator validates the implementation, not whether the
abstraction fits real hardware.

The model was shaped by the public amdgpu xGMI implementation, and the
cover letter asks AMD whether it covers their requirements. It still
needs validation against production implementations, and the read-only
milestone will not be proposed for merge without a production provider.
I will fix the wording in the next revision.

Thanks,
 Konstantin.
