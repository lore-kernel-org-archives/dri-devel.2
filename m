Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3C3109448F
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 20:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149F610E30F;
	Sat, 21 Mar 2026 20:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gczEInCf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689BA10E30F
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 20:23:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E701643F0D;
 Sat, 21 Mar 2026 20:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DD3C2BC87;
 Sat, 21 Mar 2026 20:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774124624;
 bh=WgBd29EmtamWxuNTMjO9kusdS4C4KjchmKnjrPoseLo=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=gczEInCfXPwmMUyeOG8F06gHbhygdMskfkMo41dPlQFoegruQpkWHHhVJIMCNOsrX
 ppfodQoxm7N9Mi5uBzchHprwnstJZke2/QWLxXr3yYwN4rl5JqpZ5MnBFcLV5FIPpc
 gbySISO3nZw7EmLzm2w12/qf00vXUzsMCmfrrlWb83gpMAriZFq/nxQD409KPxwMQw
 /xbFRHD0UqirPC/8sSo8FmyvVXseoo6raUVX9IpBSxq2RaadqFOLhS3xkXPA+TCIQz
 P+UgqumoLBs+i7v6f40BEvs9ahoS9R3ljSWYHiPZloIGMh1XytBkzCP8M8Lo8eb8BL
 5UHFAuVJJfujg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] dt-bindings: display: arm,komeda: add Arm China
 Linlon D6 compatible
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunyuan Liu <cunyuan.liu@cixtech.com>
Cc: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com, 
 dev@kael-k.io, prabhakar.mahadev-lad.rj@bp.renesas.com, 
 andre.przywara@arm.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cix-kernel-upstream@cixtech.com
In-Reply-To: <20260313033119.33686-3-cunyuan.liu@cixtech.com>
References: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
 <20260313033119.33686-3-cunyuan.liu@cixtech.com>
Date: Sat, 21 Mar 2026 21:23:37 +0100
Message-Id: <177412461794.18368.12679919205884501337.b4-reply@b4>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=595; i=krzk@kernel.org;
 h=from:subject:message-id; bh=WgBd29EmtamWxuNTMjO9kusdS4C4KjchmKnjrPoseLo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpvv5LrpZeM6/FosQBePmyo/2PNwsL4E5j4hL9O
 +z1+txl5u6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCab7+SwAKCRDBN2bmhouD
 15I9D/4yD0TSh7IPoMAQCObRcmwfy2fgdPjf6tz8jNWAGCgpeAIKEvShKyHzEn3+250BJzZJ20j
 PL6i+TAb3zz/ZHF2mI3EOlmqnTGDE2/htCxyGlmuwo6G9z/XCRR7Bjm27N2briBjK5dPUpr0p0i
 96g6T4ZoXoWXgb2mlU+kRzLo5vLa2Vu64sn+SxTnYzARIjDrdRmxpmbgwA783Fd7PKyiKt/lksI
 uOcTIuWBcdqi9WbgvwjvE/dnLopUV1vtVutgNn1rb76xGBp/xnjTkCsyXD/jHzaao7Ss2/VWPpR
 3qNSdAh7ZybRBcYyE/B/NHzZ0DXwp9phMHCYZm7XJJMYUsrRWeawtncW/gb0ZU4/sHlbqVFEErP
 PKzQAzZE2Wx5U++zJqCR4sLRst2VLt10w6sVHgpPI7um8ZAuWcNT+99gxdZShYCU3fFPn82efqA
 xMzq+3Zf4P4+PhBrZSj7jeOEDBoKn1LbU3/aeBgj9muip8vrANsRpVgbd1pZhHfZDQmT9/2I+BA
 x4B2ixDws9oL/9gOW0Kf2Z0307GCQTxfQl75mzPFYhuZ5HjlS41Si5ZUQwdpdYeh78aELJN5Crr
 13TdxWzP/xk88RUzl3afnX6gREbdOpu13cARVGIlMth9LR7Cd5jKtxLYtMCzIBT14bGEoZyVjbZ
 XlW+7JH753hvWQA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
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

On 2026-03-13 11:31 +0800, Cunyuan Liu wrote:
> Add the Arm China Linlon D6 display controller compatible string.
> 
> Linlon D6 is register-compatible with Mali-D71, so describe it as a
> vendor-specific compatible with a fallback to "arm,mali-d71".
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
> ---
>  Documentation/devicetree/bindings/display/arm,komeda.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


