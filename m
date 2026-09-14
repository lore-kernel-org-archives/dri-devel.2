Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD21C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B0810EDFF;
	Mon, 14 Sep 2026 12:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="dz26i3F5";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F62D10EDFF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vH5FWJUJbML7o0TX43R7XyV9ISchSe+QbOJOBuqSxL0=; b=dz26i3F5wir1A7giZ/z0XkCy02
 lFLj1Yfb8HwzvW/qrsBZvi2UhqMQlQq51qTUfeMlEvWaqBKurXp5azLhhtdseoh0LeUuAXGnwg82X
 s0HU+gHQLDl+yu+oEe/Z3Ic45TQvUrdkWXzeL52yIKFxzohAvtBRmOr+sqCLs4zTR754=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1x65Su-0000000A3YR-1p0V; Mon, 14 Sep 2026 15:07:16 +0300
Message-ID: <2ba59963-75b6-4e5a-ad9a-f3e123d2b3cc@minlexx.ru>
Date: Mon, 14 Sep 2026 15:07:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: display: novatek,nt36672a: Add 5 new
 panels
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
 <20260913-nt36672a-panels-v1-3-ce097402c6ea@minlexx.ru>
 <20260913063243.B73D61F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20260913063243.B73D61F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 13.09.2026 09:32, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Incomplete Documentation Update
> - [Low] Alphabetical ordering violation in compatible strings
>

> 
> [Severity: Low]
> Could the main description block be updated to reflect these additions?
> The top-level description property for novatek,nt36672a.yaml currently says
> "Right now, support is added only for a Tianma FHD+ LCD display panel with
> a resolution of 1080x2246." Since this commit adds 5 new panels to the
> compatible items enum below, the description is now outdated.
>

I remember now that I wanted to update description, but forgot.

> 
> [Severity: Low]
> Is it possible to sort these compatible strings alphabetically? In ASCII,
> the character 4 comes before a, so it seems like "tianma,tl063fvmc43-02"
> should precede "tianma,tl063fvmca01-00" in this enum list.
> 
>> +          - txd,txdi600yanpa-43v3
>>         - const: novatek,nt36672a
>>       description: This indicates the panel manufacturer of the panel that is
>>         in turn using the NT36672A panel driver. This compatible string
> 

This sorting issue and description will be fixed in v2.

--
Regards,
Alexey Minnekhanov
