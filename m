Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93759E9DE62
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABC510E765;
	Thu,  9 Apr 2026 08:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Ril56Gyn";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F3A10E765
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775722405; x=1776327205; i=deller@gmx.de;
 bh=A2AtQJWg7/BW14MTL2rLwVbELlbfQPXDnTfIDxtRm4Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ril56Gynd58MLSiUW7BFQ1d3gE6BsGu8Uu6G3VKXHG8iRMSnxuK8SkTx4xoYczmK
 wfv2n7zwxir7z55TkV3AYI9kvfwjWf3H3bRVwRn/kwCsXNd+2YuDLts9Mbnpp2Olp
 3mKEFgvVhdbT9+U+dimB83lfjRGaEslhW4jwNm5R3ia7rhXyNKrvgmp9tTWD34oEo
 xHNq3hhkmyBg996ExfWyrbWIq2YE2MZ17o2MgMAguaV0SHdnqaqeqIfoMv13AmoUs
 WwF14k+wm/4Lqgi8SuyIYC9lSBqHyO1wqplTz1aN5ub1Ivx39rgk5ToP77pTtBtcW
 Z5+hYLdY32Km5Iilog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1vI5Yo39JX-00vSo8; Thu, 09
 Apr 2026 10:13:25 +0200
Message-ID: <673fc34d-769e-422f-9dbb-d118c3cd785e@gmx.de>
Date: Thu, 9 Apr 2026 10:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Add dedicated entry for fbcon
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260409072711.12500-1-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260409072711.12500-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8dKuvS1i1kIO5cn7bRp95IawZvJ2sfB0uSzH6oBAp1V0FxoUmMW
 hkVF+O3UXvHz8GFufeHD9H7cKBEWGWzGvH3Sxp8pDYLbC6i48w5T8eAn7RESbkfOhInPNeQ
 9VJ4Q/4GRMg7fLQoP6PlYk7udy56I99jDPgl9LN/GxCousYgV3iYfJgJCydewKMxmd7XoUF
 tgtJ1a9/2iqMWwCgHIXKw==
UI-OutboundReport: notjunk:1;M01:P0:NX5i9tTU9mA=;ql3cNEpTT24OZ04GwxdfnsoaYzw
 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
 PT
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

On 4/9/26 09:26, Thomas Zimmermann wrote:
> Add an own entry for the framebuffer console code, which is jointly
> used by the fbdev and DRM drivers.
>=20
> v2:
> - add Helge as maintainer
> - list font and include files
> - update commit message (Helge)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   MAINTAINERS | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
applied.

Thanks!
Helge
