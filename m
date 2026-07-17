Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB8BC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8C210E448;
	Fri, 17 Jul 2026 12:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="MEIJF4Qx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PguwGIHW";
	dkim-atps=neutral
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100E910E448
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:26:02 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4E1EE14000FF;
 Fri, 17 Jul 2026 08:26:01 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 08:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784291161;
 x=1784377561; bh=LlIvT5HVnRIYn4/t+E8XZ0B2vCQAJ0CtxWj3Ne8SfsQ=; b=
 MEIJF4Qx3j3Au4p7A61C/3znO/lkfCSRnF7G7XI32sYDZv89RyX2aw1eKPC7kv1A
 azKXjDhxucjf8LBCN9aMJjQWYXyHonAuocNZxE9VNhsUGoFRAofZz67Y7Icvwk9j
 hkB6R+dcaa5XIURJCMbjOG+CywtWoga/ufGYbP9YXbCSHg9zVJBGcKXOvTfDu9Mm
 ePm1mMdUnKcbXLGxoC4aJ2W5/dxc8vKfMgIOIAY8FiK8nxLrFIchSJvN0XptWwKR
 vw9zY+i6/GyaOCg+IZTTMay0WznTCQ0Bqr1S4QvcrF7dkKG0KV82VYtRWgZxZTgQ
 c8UZiVNl2Kj+Hs9dqLIdwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784291161; x=
 1784377561; bh=LlIvT5HVnRIYn4/t+E8XZ0B2vCQAJ0CtxWj3Ne8SfsQ=; b=P
 guwGIHWNgZ8QOUFY/hFZyzdstLoSjAeU0+gkQ2EXSoLc1ZJ68bkgb/bS32/OcFHq
 BB+XKUFCS4ivi6jnuJdLkl5+F6AVX1JxDx1s/lY0Wsibt3oqZ7deFnbFhLzixGlN
 YhVT3/z+E1eGfIeNCUTLDP7c8ihuxwYdEJC8BgfI3NZVh+/6STrmNc7MZRsn7Ojc
 y5UXi5zrwfh7OfP8/u1t/0Co1BXi6Lnd+S3Nmv5PCxJgHCuXBgWUODLXRVq8MNqf
 23cA7wKXMRE9cfL9/axde1BOgiIuU5viYI01KMCkpnuWUYRPQIFyBdXpjET4T642
 3fO90exEAIGWzu4111NeA==
X-ME-Sender: <xms:WR9aasY0SR1H3vxCePN4sWvtap0-a_F1NnN9EE2X-jAE397u61iogQ>
 <xme:WR9aaiMwrHO5Jb0C-yLZriVnCoFWijzzg6Hls8AfOBtPgYG_J_6edGbAR1InJ8RpZ
 NQ_TRWrVwON1YQAkrnKVXXEpq_VztWpOVq0z06Dqil6Rb4PeJ0ITac>
X-ME-Proxy-Cause: dmFkZTGRM8jFItkZCb1OBLwF4zCtBCdR74KKXPw8FxCpuL66Au3L2aLw/M7kjNhXMfuqeB
 Y/sQB6wWkpNu0Dtqe7+W4FtMhLx7Ve69S9yQDwx6m4yXJ8vfq45gJdmnA1Lm+dyheKhp5g
 byFVJRbpGI5TfsDN1e8khFoRX7cwjcle6LZrfzUOGSOkab4DarlLUvqYys1GnTGZqCkHu2
 krZbK9Xs3Ska8nqc7uDNtE6B4+HQH0on6dvcVbouC104prSGsrB/DH+CcssNv0/fQrxvh0
 8ySSbwDnwUQ4EAgjr3g89RXji2NCC70qn0ReYRGjp6bDFFrqKAj6iHmbWWJe+h7ApKKgKa
 49fXAv+WpvZvHp7/HXruG1W52LJ4jNMyRcFb4JTzNqdpu+mko6Qrp07TiHSXJRHkoyVh4s
 qZJepAyP56+P+lFG30q9SHLC/8mUMOhPt/C+ioSWwUhWKyqdLitqulGfQYmnorXUXWP3Ds
 OP7Qc3Y6SFRn56jUyQnYsu+r+HitXTDBFjV6J7FGaPp3lwusIzhhxiHMJQC/wsvWuc1y/t
 nRPik26tHRF7eEnMPpU95m9xoeMdUKqBdOoPLdWwWgWT3utsnt18hsr1PV+gJcfJJliFW4
 pjpNSUcz1nnbTECXEXOtJUrIvGN9VYOSg7SpTTsWIypg8HQyLfs69qTPjnhA
X-ME-Proxy: <xmx:WR9aaorBU9sMbw1024DlamQ5Eb2n_Af55McOcc0gptyFCm3MMMjRhA>
 <xmx:WR9aalIDMR_ZfRCm77Xn93SqPAzZ5q2PSlWJuBMLRNWA_avbUDYZdg>
 <xmx:WR9aarMgXBVfsqliAeYzE6IPLbfcEuLkh5TrqUv1tyQq3Mmu2TLIgQ>
 <xmx:WR9aaioKSUriPIfJCaBe7M8DgAC76Xwuc0pTWEcdJ4Be8a7R1U48pA>
 <xmx:WR9aauvZOGI-IDcA0AWfKFNh0qSVMQBzRfTWy8axJpivpFb-QsC6xb-6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id EEEAF182007E; Fri, 17 Jul 2026 08:26:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Asac4qraI3UJ
Date: Fri, 17 Jul 2026 14:25:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, 
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jean-Philippe Brucker" <jpb@kernel.org>, "Oded Gabbay" <ogabbay@kernel.org>, 
 "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Message-Id: <7927c483-57ed-4253-a7df-40104ff2b192@app.fastmail.com>
In-Reply-To: <20260717104759.123203-4-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-4-ryan.roberts@arm.com>
Subject: Re: [RFC PATCH v1 3/8] misc/arm-cla: Probe firmware-described devices
Content-Type: text/plain
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

On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
> +
> +static const struct of_device_id cla_of_match[] = {
> +	{.compatible = "arm,cla",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cla_of_match);

This is missing a device tree binding, and probably needs to versioned
in some form.

      Arnd
