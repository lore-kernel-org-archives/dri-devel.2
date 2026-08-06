Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDFC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AE2892D3;
	Thu,  6 Aug 2026 11:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="n5qLcXtu";
	dkim-atps=neutral
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004CB892D3
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 11:29:26 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1786015764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=felpSIkdk6QTqa6eAv8dEuh25mt0u+aADh0BF20qvVM=;
 b=n5qLcXtuXkYS0rpKRIbv02qJcUNngkhYcwZ+ntbyiLi6oT4MFMB/tSYI22gM1bCcPjLurC
 Zn6BgtaMWwJZFCw4KIuyeZo/8ASpSMkf2Z2ShjDCf6Hc0Om2dY2i7YWOI40p392WwQ9MiC
 SnXxX2r8bzVcxujq/SfpnXPHLyk8BdXtqxvVFu4XzDztHc3de/8uQTIafYp0cG3I581rsl
 0U5XROAavYc4dyiTKLNT+89IdGZDTpd/sMfA+evf3NDV2/8zDae95uBwq8B4IYiCdioJ7a
 5htupH3TR1kTzVm9e3SDexfmZmjnWRxEL2mcy3GKhSPQvwPayzPRUONxIJ7+Iw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 13:29:05 +0200
Message-Id: <DKHTQQEWO6S1.1IKS244AQ1263@cknow-tech.com>
Cc: <royalnet026@gmail.com>, <alchark@flipper.net>,
 <chaoyi.chen@rock-chips.com>, <iommu@lists.linux.dev>,
 <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v6 3/9] dt-bindings: iommu: rockchip: allow the
 RK3576 NPU MMU clock set
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jiaxing Hu" <gahing@gahingwoo.com>, <diederik@cknow-tech.com>,
 <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <tomeu@tomeuvizoso.net>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-4-gahing@gahingwoo.com>
 <DKHR2P0XJF0B.OY937NT39DR7@cknow-tech.com>
 <20260806095551.368456-1-gahing@gahingwoo.com>
In-Reply-To: <20260806095551.368456-1-gahing@gahingwoo.com>
X-Migadu-Flow: FLOW_OUT
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

Hi Jiaxing,

On Thu Aug 6, 2026 at 11:55 AM CEST, Jiaxing Hu wrote:
> Hi Diederik,
>
>> Now every MMU with "rockchip,rk3568-iommu", "rockchip,rk3588-iommu" or
>> "rockchip,rk3576-iommu" is allowed to have a minimum of 2 clocks, instea=
d
>> of having exactly 2 clocks. That does not sound desirable.
>
> You are right, and it is worse than sounding undesirable, it actually

Yeah, it was a 'bit' of an understatement ;-)

> happens. I gave an RK3588 NPU MMU a bogus third clock and v6's schema
> accepted it without a word. That is a real loss of coverage for every
> existing Rockchip IOMMU and I should not have sent it that way.
>
> Fixed for v7 the way you and the bot suggest, with a compatible of its
> own:

If you haven't already, it's probably worth checking whether Sashiko made
other useful remarks. I don't feel qualified to judge those, so I didn't
reference those. But they made be valid as well. Or hallucinations ;-)

>   compatible =3D "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
>
> and an allOf that pins each side:
>
>   if compatible contains rockchip,rk3576-npu-iommu
>     then clocks/clock-names minItems: 5
>     else clocks/clock-names maxItems: 2
>
> so the NPU MMUs are required to carry all five and everything else is
> back to exactly two. Checked in both directions: the three clock RK3588
> node is rejected again, an NPU MMU with only aclk and iface is rejected,
> and every rockchip dtb in the tree validates clean.
>
> No driver change goes with it. rk_iommu matches only "rockchip,iommu"
> and "rockchip,rk3568-iommu", and the fallback stays, so the new string
> is documentation only.

I'll leave it up to others to comment whether that's correct or not.

Another thing you could consider is splitting this NPU iommu 'stuff' into
a separate patch set and drop the RFC 'prefix' for that series.
IIUC the RFC is (only) related to the working of the NPU on RK3576.

Cheers,
  Diederik

> The name is the part I am least sure of. Everything else in that binding
> ends in -iommu, which is why I did not use -mmu to pair with the
> rknn-core node it belongs to. Happy to change it if Heiko or Krzysztof
> prefer something else.
>
> Thanks for catching it.
>
> Cheers,
> Jiaxing
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


