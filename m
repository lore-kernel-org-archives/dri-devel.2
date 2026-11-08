Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35993606A31D
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=gF8gDtt2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FAoSMHWU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A6110E0FE;
	Sun,  8 Nov 2026 07:04:56 +0000 (UTC)
X-Greylist: delayed 308 seconds by postgrey-1.36 at gabe;
 Sun, 08 Nov 2026 07:04:44 UTC
Received: from flow-b3-smtp.messagingengine.com
 (flow-b3-smtp.messagingengine.com [202.12.124.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE0C10E0FE
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:04:44 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.stl.internal (Postfix) with ESMTP id 86AD61302AB7
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 02:04:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Sun, 08 Nov 2026 02:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794121479; x=
 1794128679; bh=RZ8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=; b=g
 F8gDtt2AyXEhvH15cXZw4nuFgnFE0mqImQ8wb+iqj+zY8wqpwk5tk2jDM2KYNyJE
 1mtyH2plcTHjzGrOjDlgl/SScTv7N1zI3/hG3L9t7cm7+3S00oMWYqUx3PR8RCWY
 4oI0/daTpWGjp5zMjQAY7ljjAQP5yQ114GjlLIb5mTBzmAF0Inx9oReyD4rwd2bF
 0M9q48WCD0Qk9PjqBMkLbrDgwHL7C5AhtKx4+jVmGs25pXE1RleziDgR8wGkbH36
 cfPZi6PAE29txTcxojavPBzCzaS0/JAFKFyQfhuudcbLULAP5l63n/HLu+XDm2SL
 cWBiqjFN38cwwSAN2vI7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794121479; x=1794128679; bh=R
 Z8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=; b=FAoSMHWUR7dujBsHi
 m4Isbj6w4hrzPH7ymtpDgqwYnUzC7/zBSWOXE74Ybn02TPSYBlP12KapR3iyJ1G1
 1zTGUv1E82/ybWYvxxI7evXnKbAoBgnaB/okKUxPPwugMQgdnlAF0OxpgCiZmBRr
 B1uk/Ef9fZBRG6KczWclzkidPQ08LPO0n1IeehHlJNVNwtxEw1CE2h3JzKf5TZhC
 lBBpomvaKujJTE9mVDMTE991KXF8gOt6UqqKLAZeMm3oFYwdR0E81zqazzIMX7Zg
 nngOb4it2J4yMYTfadVOVi5CzIS5PdRe069HiHGKRi2RWM1ytwqnbGq51zX2CfyL
 9Jf0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121479; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:faN4KQF6ONkLLILo9pcboWnfFvlk2lYwnR4DA5VddxwYBic
 uMgNeMRW/ke3f3SGc/+ijxn/Q49vCh3exdVdEcAKgIWl4ANEqKFy/jXYXkG+xWbI
 R2575u3DF6s1p8NgEjcCbLWuVMYgCxesVip6GJ9k+BEUmwtK8gNTDaOhPlYugSgR
 ZFCLtz9+eNLJEqQNgqzd9KdksncepPiuejX28WpfRfozxGm/s0e+O7Tl59F5P9d+
 8gcoaAQfVklhjhFJdAQgBcMwCMOSOJGB2Ut5MyYSRuqO1c0dnUzCdAzdkFGPUj+1
 wVWlR8LmOyMA4BZZelj664Qrz0DQ5prNPChCOfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:PHwmtPat0dF7NtP1dql65wy0UbD0vgQGVZAO1EMeALc=:RZ8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=;
X-ME-Sender: <xms:Bh_waoHjMjH9rdgZPk0naIHH5zeTHsUWQ1gWyJVmuhwYPJCAoP9fPQ>
 <xme:Bh_watxEjCcEudc_9uYX8_3kqYS2Oh_tesyPWyBCBckXDmzCjTvWPa1hZWd9xoF0V
 epto-mY6ySnVxnXoRT7_pLdNRiyPUlpK96ln3F8LttRUZU01PKCKOU>
X-ME-Received: <xmr:Bh_wapZERSoz7jRVeIhKQatR7AjjAs8u3Ug8ttonC2keB6f_3UOhOxwfnC3NLeKCJ3GIIaY5>
X-ME-Proxy-Cause: dmFkZTGFrF9gbXLYK57uxfZb1bQmjwR88m5VJ3LeQ7NQGYG1ObiBENpJjk+SxbTOoy2Z2O
 oKHwECRp3KS9jz7dDXznSf0ApUhoJsyilamEIdtEYTXT10k2VMjwh1zf0cCss0F0U7et5q
 L+zOCc3HzDw5Xb8dRMNNSgRoLf8s8gmdw0zdOLPrclPF3+buMgXTngk72aEbrLF22hnWgA
 VTZOp0VJBWYDhR/uABWc6oI0e0YlG+k3JEp3i4IsBNKCJV8sn1xzPbHcY5M/PywatYwjQk
 mSiyzFHruIdZcWT8k1yuaF/RAaV2sqpoWiKHEvJK1TBYApnym0EbdVB7c741b+jRJy/rXR
 0fs+ib2N9bpAbYdcCy3wdG/dDRPzcqwQtZLAnM0q2ppIj37havxdw0noBYd2aGjOG4hW0a
 NmO8w2kyv30tTZknQr2+k1TQFU8XbYfbSfZmI7mJkkHCl3fDmaNsdHh/9C3X0sGIR6tsDU
 2sqb/y4hRf+3sbrBB0Razqxoh0cdEQSielLoNE7Br7H5QxN4iWHrw51qoZ3KrFOqlkzJqs
 a6VH4Z/rwz4HrIJtdfEPIHz9d9+poSKTtO4KXQ0u9Bmz9arT6L/aJYCLzAXUb2OZUj2Ptq
 M5a8Mak4f1pKJKdoUb9gRX1dtVQZYyhvDn5hmMkwpskKLj0hnIoWw7g84CIw
X-ME-Proxy: <xmx:Bh_wagkUukZt1evp60Wz3mcD6K-idNfXMEjvvdSOwFTwPVqigPafPQ>
 <xmx:Bx_waukCauVj9Nl87oGoNoCkO5lYNY31knt6tLv6Ynj6RlZ20FiY3Q>
 <xmx:Bx_wajOKDADVAVEdTO5Cm2VXH9bY7wfICoVdhzRa0AAsnPqo3zopUA>
 <xmx:Bx_waoqeZr-C9HwljvpFikWi6oaTkLqKo6X0bPS2Iq13zebK7HqFLQ>
 <xmx:Bx_wavpwQCJEHa-6bvfZz0o1Q2FIVPD3mKDrJHWx4p1qI-cGpL9_EGyM>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:04:29 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Sun,  8 Nov 2026 20:04:08 +1300
Message-ID: <20261108070408.136140-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3654048.cLl3JjQhRp@diego>
References: <20261101082307.151957-4-gahing@gahingwoo.com>
 <3654048.cLl3JjQhRp@diego>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On 3/15 you're right. With synchronize_irq() added, the original comment
already describes what happens, so v16 no longer changes it.

In 4/15 the code no longer uses pm_runtime_put_noidle(), so only the last
part of that comment changes to match.

I've shortened the commit messages of 3/15 and 1/15 in v16. 1/15 is
Igor's patch, so the change is marked in its tag block; Igor, say if you'd
rather keep your text.

On the power domains in 14/15: I tested each core with only its own power
domain. With both cores running the results are correct, so v16 uses one
power domain per core and drops the driver code that handled more than
one.

On the IOMMU clocks in 8/15: I tested different combinations. With only
aclk and iface the IOMMU reset fails, and without either one of the CBUF
clocks it does not work either. With all four clocks it works, and the
npu clock is not needed, so v16 lists four.

Thanks,
Jiaxing
