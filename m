Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA49C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9211C10E57E;
	Wed,  8 Jul 2026 07:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jpcn+bRu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5466110E57E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:11:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A114416EA;
 Wed,  8 Jul 2026 07:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE91F000E9;
 Wed,  8 Jul 2026 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783494702;
 bh=Z+wjSAKNbtcG5gkpojA7VMnMewbLe69OoijhfgLiBaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jpcn+bRuleOzjL9yzPm71v+1hwOhsm9CFRyWqY+p+hXwGZHGQMoUwWOXU7SaS5Ok3
 W6X9Yjdgt6vxY5TdHANzurLCGpKJ3fMkASc8qtsQ7WofNNlbLEb2V6E2Kwuqxhakav
 ARfgF+wm2wsfOLz9WzjV+Az7hkk/htQZ4lOrhVLzNa+FZVmz2qwte4ZfYUZt/shvpy
 mm9jYUWL3nffkGNo31tyg8klxRTEhm4yXmqH8wH5sb+YrGlRUWbiNsTpmVfkKgcYPi
 M00wA/0vYH2n9YIXnPRKOi3oeh82a8z+EyW5rQIt3PtDGGtlqq1UUiFjq0BW/Oyajj
 Uq23mrShcH6uQ==
Date: Wed, 8 Jul 2026 09:11:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
Message-ID: <20260708-slim-naughty-mushroom-dbe81c@quoll>
References: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
 <20260708-dup-sessions-v2-1-da40f9c98a2b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708-dup-sessions-v2-1-da40f9c98a2b@oss.qualcomm.com>
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

On Wed, Jul 08, 2026 at 09:28:32AM +0530, Vinayak Katoch wrote:
> The qcom,nsessions property was used to duplicate FastRPC sessions
> inline during context bank probing. Session duplication is now handled
> at the driver level, making this DT property redundant. Mark it
> deprecated.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

