Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C4606A69C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmoay3OR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB56010E0CD;
	Wed, 25 Nov 2026 07:13:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7EE10E0CD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:13:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCB7D41297;
 Wed, 25 Nov 2026 07:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7291F000CA;
 Wed, 25 Nov 2026 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795590812;
 bh=4qbr+XP/W07IFoinYY/JS5Q6/NHAvlLOGK7BiMA8ui0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Rmoay3ORo30nP6bKHTq5PNW3QTRX8PYNHTXA1nLqHSbhEVwKxzVO+G1h+fvMBXwPs
 5YoHlZcORylh1FkygCSep7WPoJ4HmrN/uNwxClTF6aNDRuvoRLqwqgzL8QR6qoTsrM
 JtXWHbNdJBxnPn7I9B4qoClENg8RIMqX6VWW/7L05ZgVWHG4jRD/NbGeuAwi81x1Du
 PLeuRJGywZwyWd0lXTPI4UDK4zH+JmkusYp8mEXPJQsqZK4dWmYVwRhCnP0xVujqtO
 MxButjDt8eM5UHkeiX+feQIoRNm4Ao/1o777atqo8haqUYmuxzjlgKe6CZlLY76wBX
 FKUFny2gN/XPA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add VIEWE JD9365TX panel
 binding
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
 conor@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
Date: Wed, 25 Nov 2026 08:13:29 +0100
Message-Id: <179559080931.9063.6197450233674722560.b4-reply@b4>
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
>  .../display/panel/viewe,jd9365tx.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
>

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

At v3 I do not expect such feedback to be given...

> diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
> new file mode 100644
> index 0000000..1043f93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
