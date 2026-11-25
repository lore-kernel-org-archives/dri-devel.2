Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAF606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B8GNBCfk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8D510FAF2;
	Wed, 25 Nov 2026 10:22:57 +0000 (UTC)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E6810FAF2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795602165; bh=fK3tKISj3R25ArhBdy5LM7VopeCl3BiNHMyMArgUl0M=;
 h=From:To:Cc:Subject:In-Reply-To:References;
 b=B8GNBCfkblKhl6TOcGp2hDi3EssDZrsTX2bduAyTKpPg0lcVBo9MBZprXP3FlzNpq
 AMZyZ7NaqyHuKEI0RDaj86yvfj3L0zmf+iUrVSmM+jeA9MCDjvisvE3q3kN0bUo08q
 T43teeGb1jcbdtqbXmevmMZpsbVnXTpIhPBBDJNU=
Received: from [172.20.10.2] ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 5ABBA6A3; Wed, 25 Nov 2026 18:22:43 +0800
X-QQ-mid: xmsmtpt1795602163ty7ddubw1
Message-ID: <tencent_B5ED38EF87A715D7F71A61C813EBEF0F6A06@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+ZKVBiD/neVVJOZQa17843ytV7XWf3iVWxCttgHZToC973ei0aS
 NYtd4s6YAMYBD62XlclZSXyjRchRuTnUUneAF0RajY2nCnW/Cpp2hTtqbQbA5ZvY9hJNHWwuCNCg
 lHjmjM5EeMAiMMPAvZTJ2WwFEiELRPaHOgfZYxnHgyrc87pbE5Bs/4rhDLMDM3dqKeGzmHVNt7pL
 JWzZUDfxa51ROrart2e5RvkJ0PtKzMz28TVd35ZtWcz5LPgTDrf7N5q8m/9AfoAI72KcOjTsVBAI
 QUjbYBBn0wB1TkaZ7g9CvAEpJJhKyift32J3ada0n/pMXfgj2uL9HPULjqmcjFj8jij88jxdjjRT
 4p//xo2Z3U+tpCVJyMSPySjV9TPbiWybqjZM86P7bPvoGDviGf6seaJ80pNxdzOxRA8PibBmkQGu
 qhSKuj4XaglaOvfovsGxXVIqkDaVIy0Pr9eTCwCHYEVMmrnxZXcwYD9sdRm4JQexxwqw1zRhEr1V
 bOPgINHoCDV/gODr+vzGeD7k/T3b/oeqnXtRatqNJmFp0EeFe2MEhu4++d3xL5/bk6g5u2moF94p
 4DuvE0fXhz5fXPw0siaEKOSvar0OlnV1MDOVW+zRM65Td1PO8bJXvyudesF+hXRUL/M4c+tvRyn4
 bmJ6CMQ9uqZZAGVd6ZawQBj6u8G6S70CG2f+yeyKg6QG8VeXmcpNPsOYWFH46YtnJfLvmJ94Otm1
 7lQvwhHad23gG+6duAY4WX3/u7x7ZfZCWOquwcMOrMB6xv37nUrVo+J8PWP26YBtyAQmFEpwqVqd
 O5/7AiM4qKShjY063FPDWoKqBBjrNpi5mRcGIbaXnU/dmNPciyvY+rooaQ0RU7kviZtJLf7OAIKh
 hsCp+d6UI0MgoMxscm9y4BdRTgL4euxrAoog7FnKXyDdEAKVaQc58bpVhyOHePWB8jQGGBptlRq6
 kGuxSd7E3CoNaspI3nRRXxX9ug29b5BuhDi+u9fNJA+fNmvUOP5/SLuNCb6egdGT9jgGWI8P7zOd
 BPCBYw4lY2mTW66yFk8KlsghIc1jogeuLARQKv4hhGa3yR/rGbdDupHriHM6tdFTNmLCQbvTLygL
 Wj/kAn
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Hefei <3066883572@qq.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add VIEWE JD9365TX panel
 binding
In-Reply-To: <179559080931.9063.6197450233674722560.b4-reply@b4>
References: <179559080931.9063.6197450233674722560.b4-reply@b4>
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
Date: Wed, 25 Nov 2026 10:22:57 +0000 (UTC)
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEkgcmFuIGNoZWNrcGF0Y2gg
YW5kIGNoZWNrcGF0Y2ggLS1zdHJpY3QgYW5kCmFkZHJlc3NlZCB0aGUgcmVwb3J0ZWQgaXNzdWVz
LiBQbGVhc2Ugc2VlIFBBVENIIHY2IG9mIHRoaXMgc2VyaWVzCihNZXNzYWdlLUlEOiA8MjAyNjEx
MjUxMDIxMzAuMjU2LTEtMzA2Njg4MzU3MkBxcS5jb20+KS4KClNvcnJ5IGZvciB0aGUgbm9pc2Ug
b24gdGhlIGVhcmxpZXIgcmV2aXNpb25zLgoKQmVzdCByZWdhcmRzLApIZWZlaQo=

