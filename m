Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA0FC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1CE10E552;
	Fri, 24 Jul 2026 08:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LBFNw8Uj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C5910E552
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:59:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 434DF4093B;
 Fri, 24 Jul 2026 08:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F181F000E9;
 Fri, 24 Jul 2026 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784883566;
 bh=TzCoFLDYKfBuglSaXI1zoyf1U3HVpuaWEr07IUAs0KY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=LBFNw8UjO//W4K6jJNzxAcGStiMl+APiNWF30d8yQ9CDL/pJYgAQpYelAh6iB58KS
 yTYB/LXOiOcDcogJfs4QZUVmRWFBCPi1ylI/9sFrZEw/0yiWeAUlncTPr9RCNfnK18
 /pJGvRQLJyMwC4eHXyxgz9nXWyCM6EuY4pbgqNkKwT9qKyJeFENSnbov50Z64KGbzs
 9qg6eRZwapTYS3fiVGkT/00gwY6wAcOJdjm9dq8DIj31PGGlh+mP9xemmNxcXcJuP/
 XwqPa+e10BZcbEtAAxQmKgzul7PVDKiTHCqu+HKpAeo8O3B5CIc6mHEIX9iZDA+jY9
 mrXm06TllyKag==
From: Srinivas Kandagatla <srini@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260724085650.224899-1-shengchao.guo@oss.qualcomm.com>
References: <20260724085650.224899-1-shengchao.guo@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Document Nord FastRPC
Message-Id: <178488356375.437795.2129751296429802854.b4-ty@kernel.org>
Date: Fri, 24 Jul 2026 09:59:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Fri, 24 Jul 2026 16:56:50 +0800, Shawn Guo wrote:
> Add compatible for Qualcomm Nord FastRPC which is compatible with
> Kaanapali FastRPC.
> 
> As there are 4 CDSPs on Nord, add label for cdsp2 and cdsp3 as well.
> 
> 

Applied, thanks!

[1/1] dt-bindings: misc: qcom,fastrpc: Document Nord FastRPC
      commit: f52f4a167e0e24ed6769f6df9b8b00280d9adf85

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

