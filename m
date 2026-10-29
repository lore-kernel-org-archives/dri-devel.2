Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8B606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=startmail.com header.i=@startmail.com header.a=rsa-sha256 header.s=2020-07 header.b=AwUnEXQe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49623112060;
	Thu, 29 Oct 2026 07:59:18 +0000 (UTC)
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D6F10E256
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 04:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2020-07; t=1793246876;
 bh=6xWtChXQBPQ1C6X5kt31/tO1McPybT42OFZhLYS5vtY=;
 h=Message-ID:Date:Mime-Version:From:Subject:To:References:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Subject:To:
 Date:Sender:Content-Type:Content-Transfer-Encoding:
 Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
 Message-Id:Autocrypt;
 b=AwUnEXQe8jjmGNKY69pwSWMwD9M9i9BNIQtiYyxE8QunYdforYHC1A/CnsbKEMgAO
 CT302c1+CpbfFJykhBwOJZO1XC0LV+J0ALv5K97MI3fGSDUUCvmPigAaj+/FLXp7q5
 L2NAtbxDvAp+GLHi26y/3RmX+KcTOGE7tR/kvVEDrblxkBFh0YwjDmGabnnpKBdEjm
 gWIYHaV3TneFwzeasAaeLk3jQCcDHv3tq5qJulS44CJc+6Umrhk5EZbknQLCNfhzEv
 ctTsNb/HlSV9qdUMhpVRqFk0F3siA9onjARVlJFdHNCTcDTE86CBvRWYrESY2DGdpk
 QnygcDQL5dRHQ==
Message-ID: <7c3464b0-db2c-4554-a055-4add944818f7@pyk.ee>
Date: Thu, 29 Oct 2026 14:07:49 +1000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: Jacob Pyke <jacob@pyk.ee>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Retroid Pocket
 IL97680A panels
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, teguh@sobir.in,
 Andrew.liu@moorechip.net
References: <20261025133741.100490-1-jacob@pyk.ee>
 <20261025133741.100490-2-jacob@pyk.ee>
 <20261027-inventive-hidden-ostrich-66dfac@quoll>
Content-Language: en-US
In-Reply-To: <20261027-inventive-hidden-ostrich-66dfac@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Please do not reference random 3rd party repositories for no reason.

> Drop tag

> Keep the entire allOf just before additionalProperties: block.

No worries, will address these in V2

> I would expect IL97680A fallback compatible.

I'll add a "ilitek,il97680a" after each panel-specific compatible and update the examples in V2

Thanks for the review. First submission so still learning the ropes. Appreciate the patience.

Thanks,
Jacob
