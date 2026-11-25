Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14964606A33E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvEXUrd4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEE910E0F8;
	Wed, 25 Nov 2026 07:14:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1618010E0F8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:14:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFFDE40A5E;
 Wed, 25 Nov 2026 07:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6F61F000C6;
 Wed, 25 Nov 2026 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795590881;
 bh=9O9vWon2AID/bXAvQdP8zYGG5/Ux/NpXmOMChYy6MoU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=WvEXUrd48V04Um5yRGlR1O3i6XcYPHzzpMIBD9AacCfPfeZLoU+0DqeQX01NeK2CA
 8+1da4KV9oXHQ7gD5JQEirTsNtgv3/u7B9vyfhIQgvHJlDqkZbln9EEYA1DMg1HWnC
 PD2ogIFnYWV9A/zNDimkm2Qmh7gHRTh2D3Fqh8stSr9EvPe3827pEuLM9qR8F7uwxG
 NABN5edtMh/SLXJTYjGAlFI1cyga1Wy5YsIT3LR98UfIHdV2OVtc6X9NiGXFd1lgH/
 2FZOvRWkKfhcY3nwzafTZVcjoxmCFkVodBeBNU5xKf8eEjteI8fzrNEOevr3nzi2Kr
 7mTQrNGMK2xdQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/6] dt-bindings: input: add Jadard JD9365TX
 touchscreen binding
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
 conor@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
Date: Wed, 25 Nov 2026 08:14:38 +0100
Message-Id: <179559087806.9063.7183621842723367523.b4-reply@b4>
X-Mailer: b4 0.17-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-25 10:11 +0800, Hefei wrote:
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../input/touchscreen/jadard,jd9365tx.yaml    | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
>

Dropping all your patches from DT patchwork.

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
