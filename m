Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61360CD3427
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 01:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B66910E48C;
	Wed,  6 May 2026 01:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D6kwb4o6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A5F10E48C
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 01:17:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D802560181;
 Wed,  6 May 2026 01:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25038C2BCB4;
 Wed,  6 May 2026 01:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778030257;
 bh=uNjE8zToLvULhjmqF7HY+tvd8kzOnaVgEL+CQvM0G8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D6kwb4o6u5TgeCY84+MdSaQ+mv/FuL+DhauN5O7qq+tVu/ulRuA2G9Z0YxB1EckiY
 gUX0AfhbdBGgxn/AqQbRxbifOYn+cSHmD6oNSeBc5oXXBxZxAUBYTZHhlLvFblmEIb
 EueS9adw2IShYTjzGG0VpJmDoHOtwK7eWuIeem+EHqtOshPINv2M+Hbd4XLf4h77Tx
 qn0jyvz41c6mE72lAemIerdl8jiT05Y2RoqmpH6vSugfMaiMf5p9BAwA8m+sZrnqIj
 Q79YyV7r22viXeDRpLEjYIWDGX6/8v9pbByvWlKOccImmgcHDfktXXlulQHeth/w5x
 R9me4TZSBAOZw==
Date: Tue, 5 May 2026 20:17:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: qcom, fastrpc: Add compatible for Hawi
 SoC
Message-ID: <177803025320.242630.3812073319585870856.robh@kernel.org>
References: <20260427190913.3680717-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427190913.3680717-1-mukesh.ojha@oss.qualcomm.com>
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


On Tue, 28 Apr 2026 00:39:13 +0530, Mukesh Ojha wrote:
> Document compatible for Qualcomm Hawi fastrpc which is fully
> compatible with Qualcomm Kaanapali fastrpc.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

