Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E7CCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5704210ED06;
	Tue, 29 Sep 2026 06:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBzp+yXC";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F319A10ED04
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:56:08 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso19917975e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790664967; x=1791269767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4pzOI0dqfXOjphwaIy4ajDJicrR2uXepG+CBQhlx9B0=;
 b=UBzp+yXCtoH8r2xqh/nv7ckMDsxCTjfjTQ0PxQjSQd4pglabRZ+vL66fPAEcF+mhF+
 /5mAxi/Hiv1nSMA2I3Jnxir8ngA8WXQmjDreHwKCHoprYkBuTPEo1alWC8DYBQlm72Bh
 corU3vS5zdROo/Wl24k+CMWthRdqJj21qEQ45GSI75W9xNv8thqAhZujeZIXgRzBTcFZ
 P2yzYZdc7vBBzlfj4M6Ab0+/oRHBuRBZYfUHb1BBQbJIIe3+H6f/U2iZGdeFHS4Z0/+m
 p+zvG+OhXicYYQLahnt02uQf+xd4aHNlz1JPqsj8IySBxdVLOcmptkJ/jiOnC3NEmGAY
 C5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790664967; x=1791269767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4pzOI0dqfXOjphwaIy4ajDJicrR2uXepG+CBQhlx9B0=;
 b=hPyAT5X0TRNgLd2ABJhAaKu0qVgEJ07qzbt4BeGvKyOcuqcgv2OGufxcmSxaRQWgc5
 eagmnFVPNZMsHitw/ZvPd5H2Wbzr6RT+Fjj5oFp306h9lRM2SvwisLKtfowaLGtKtQJ/
 4BwjEMP2X4bQs2pKLB9NdPodlmEd9o4nDRPzV/9186QkCLXckq8KEcTZiwrTDGUKKO1j
 qb82iejgL7tem94hTmjIALlf2LTMBF+MMmr/a6mG2bwThU6MkdfBhGNGyXekZbCD7L6b
 u+1qo3mGEvKRwRX17693rygkJvSg09irQg9I/usd8hubidSKhlUF9sGiNygoNyiqjV8v
 5oew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjKnfqB/d8cm/DSfJT0XlFh59s5u3Xum5d6Y3kIXXBwQBxTEnYMLctpQtJSp/XqLTUE4zoxdkpNCM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lWc0oqYBRAtZYONClkNOrIM4J1ZkpEm4XeXBPgOT4+mkPo+3LC
 fDncP6eElfuz7NWDBrFub9VQ86ckZ0FGrOy5BxCbHQpmp8ikIADmpzTL
X-Gm-Gg: AYBFou0sNkKhHn78yaDTlwbzCY42rwOe/RWQyxrRU2fa+TZZlWwYwduAJ3ETsl6rfd7
 9LjTp9+ylZidoVTFBpwptjesR4/9yHblbFW4LeAJf+xPpJw6tP+7XuVFnLphlsidbnkFj224yab
 2pFWNSuFrM8Dlmg2GZyuwQAIukUO0MZyA6SSQrBDt35A4lBAG2+KRBxooTKTqv9np04VwtaGMCf
 hTf/esvnjhKBLl/ramo9iE48JnpAK2KCGENT4EuG22YGtcPXk0w35MK1BeEA5hu7rv5MYYu/WOt
 ZoXVoB6sywXeCMiXm/h5re++3ttEutJJ8f4ITrpvQxSWfqfPpXGDjLMvHnjPrBTPNVLvCFY0Bi/
 mkkD/+W0JyKVlYINLIcUjVY/XZbRhWmWc1GIC0R2gDaGLvrleevQc+5iAVUs4WqOjypJYNpiGJF
 KCSSTrW2ik8l38rQrwbMZoP6/9DVCVxke4Kb0sqCgicPiyfTQ7EopuVOHKDx1Gb0vZHP8ZavUP1
 AU1ZIpxPckRFBgnNQd/jrUqYoZdkxJR7nto8iC5EelQM9mE1A54uqLWVXnXzQrWCt8updJzwPLB
 iMJ3PDyJZGbFbcHcdjHv1aYJYC+Q769TMkPYxuMzAq7KYXF23KMyavBL+gShDl/23I/WADkqVcS
 RWwHtT3WVNlhj7hy0
X-Received: by 2002:a05:600c:c4a3:b0:4a0:a34:f6fe with SMTP id
 5b1f17b1804b1-4a00a34f7ffmr46104355e9.17.1790664966699; 
 Mon, 28 Sep 2026 23:56:06 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c32-f801-0451-cc94-d3ca-f56b.310.pool.telefonica.de.
 [2a02:3100:9c32:f801:451:cc94:d3ca:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af507611csm1570357f8f.22.2026.09.28.23.56.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 23:56:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-bot@kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udmabuf: respect the device's maximum segment size
Date: Tue, 29 Sep 2026 08:56:01 +0200
Message-Id: <20260929065601.99518-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260929060028.371041F00893@smtp.kernel.org>
References: <20260929054835.94118-1-kmehltretter@gmail.com>
 <20260929060028.371041F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Tue, Sep 29, 2026 at 06:00:27AM +0000, sashiko-bot@kernel.org wrote:
> On architectures with a 256KB PAGE_SIZE (such as Hexagon or PowerPC), this
> new validation evaluates to 65536 < 262144, unconditionally returning
> -EINVAL and breaking all CPU mappings.

Right, the misc device has no dma_parms, so it gets the 64K default and
sync fails with 256K pages

The misc device has no real segment limit, so for v3 I'll give it
dma_parms with an unlimited max segment size and keep the -EINVAL for
importers that report a limit below PAGE_SIZE.

Karl
