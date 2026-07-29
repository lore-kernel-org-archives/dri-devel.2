Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD4C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B7F10EDE9;
	Thu, 30 Jul 2026 07:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="t+rz80j6";
	dkim-atps=neutral
X-Greylist: delayed 115216 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 09:14:45 UTC
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D8010E028
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1785316462;
 bh=7dQJOLYN/AMcn00lyTExvQ2yf6auzhnjf1GDAS+h8Qg=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=t+rz80j6QvUXPZ3fax4An8udlSlIJg8WIEQfzxtYlPImTYt48OeSN+A6zRPRwgRr1
 Y67L3RDsYtftIUfk3xMiNHw8uVGV6sdAiSKbnoyiwzEfILt8o82Onskd/Uqc7XBNhy
 C/wOWZzHCtDkiNeOzICYpJja5orIm/SUE4AiHHhI=
X-QQ-mid: zesmtpgz5t1785316453t920e2043
X-QQ-Originating-IP: zAlwTsMr81y+gJMiR91lCYUcBGOKHctjS3NDk86hNXY=
Received: from localhost ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Jul 2026 17:14:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7786942154255255945
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 17:14:11 +0800
Message-Id: <DKAXV3CTQ6B1.36715CJUMEB9A@linux.spacemit.com>
Cc: "frank.binns" <frank.binns@imgtec.com>, "robh" <robh@kernel.org>,
 "krzk+dt" <krzk+dt@kernel.org>, "conor+dt" <conor+dt@kernel.org>, "dlan"
 <dlan@kernel.org>, "dri-devel" <dri-devel@lists.freedesktop.org>,
 "devicetree" <devicetree@vger.kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv@lists.infradead.org>, "spacemit" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpu: img,powervr-rogue: add
 spacemit,k3-gpu
From: "Baihui Liang" <liangbaihui@linux.spacemit.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.17.0
References: <tencent_79CE08BE248E9ACA2E62BF64@qq.com>
 <065a229b-e6a8-4cce-8725-9c2e19c8f463@kernel.org>
In-Reply-To: <065a229b-e6a8-4cce-8725-9c2e19c8f463@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NiFdmnmiW14nHyLZW49OFnOnrQv7pEUGBojWfLnJ5yyoCmLXC9cz7V5p
 xGYy4V4aS2FXmrhIlarC0KUF4HW/Ytv84XSJOMeZxZixfipGOyrmKSZ0Tue1w0gJyngmx6Y
 tMcExDPFYoORhVJDscoUyzklc9rhuDteR8z7ZNybSv6rgXSl4VoyKNSa6vPwUY/OTP3Vfnv
 GBsI0s3u1Wb3WB7VN0h97oSUuP+mijAVdiHXU9pci7XErPtzuEAl5Zx32vLQLMnRHK42x3B
 aTqPBaRnb3tsSfZBdjafuAS3ARLHlxjNE+Q+avYxEomNF9cN2OP6loWP3URpcOVHdwca5tF
 fZkU6wL8uQKaSHqPieiSMnJOAEBMIDvQ2dUtjRkMGAqtGDY34Q4lC8aC/z/Ol1Y2DxaCEFe
 PXqK8EBPQh/BXyKqwJs+IIqyh8HnvreNpR2PHJV4rqkzAoPg+XTnZNtRC74Sie+GFO7qzYI
 h1zslLcCeASZ4re6kWEC9sf7TdCvYKnef94EFvaXVVhmdHmAbd/6MMf9VDevrTULRoFJxMH
 j+szNkMzHCGz52H07E15GY+aj0iAOAlhEfNXvCJrRErXeVXs9KboV4mION+I/BCy6g2/gRR
 lxl8bYIF65zW9JgtIQbjTwU1nRicBCzIZABF4XQZ49g1MR18T9b5K3v+rb8r+k/UJ7G53jP
 p4cRLEXMj+XvJnuXsgVK18HtNJBFCK7cJKnCBsKKvMIHDj5IGEfju4fY9Dvx/JVC1VzjIyk
 mPnTTGHnwCw3p6fbrl+wnZCrOLhqPb/lt1fPG64stuqxtTQQasokD53eAm8BORRhe/9TkHk
 nltwMblDW6a+Wi1nGCQ9dY9GrsP0xibn+Tlit9DKF/YxagcV8cBRe3lo/ENzWdME60JPxrK
 vcBHl51DDsv/tjSAgqGmt0sujy/Gk4e45lSvCbc3tQ5y2tWy1tqFymHwDZKwJJUGaNJ2QFf
 JJCCaIhPK2/Hwc7xF71hL8Ks1eJ+AV9wlboPg5K3sdh0WURQFjnv60o/QG8D/cTJFFWrbi/
 vy8CYeTuXZqD8LPTKQiPysHz7jrfpOdgKb2/caUg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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

On Wed Jul 29, 2026 at 3:57 PM CST, Krzysztof Kozlowski wrote:
> On 29/07/2026 09:46, Baihui Liang wrote:
> > On Tue, Jul 28, 2026, Krzysztof Kozlowski wrote:
> > &gt; &gt; [...]
> > &gt; &gt; spacemit,k3-gpu is added to the existing ti,am62-gpu/ti,am62p=
-gpu/
> > &gt; &gt; ti,j721s2-gpu "if" block that restricts clocks to a single en=
try,
> > &gt; &gt; since K3 has the same single-clock requirement. It does not m=
atch any
> > &gt; &gt; "if" block that constrains power-domains, so that property fa=
lls back
> > &gt;
> > &gt; I don't get this explanation. Are you explaining what the patch is=
 doing
> > &gt; or explaining WHY you did this that way?
> >=20
> >=20
> > That paragraph was describing schema mechanics, which does not belong i=
n
> > a commit message. v4 will drop it and state only the hardware facts: th=
e
> > K3 integration of the BXM-4-64 has a single "core" clock, and it has no
> > software-controllable GPU power domain.
> >=20
> >=20
> > &gt; &gt; to this schema's general constraints, where it is optional. T=
his
> > &gt; &gt; leaves room for a power-domains provider to be added later wi=
thout a
> > &gt; &gt; further binding change, should one ever be modelled in Linux =
for this
> > &gt; &gt; SoC.
> > &gt;
> > &gt; No, you need to provide constraints now. Please read carefully
> > &gt; writing-bindings.
> >=20
> >=20
> > Understood. spacemit,k3-gpu currently matches no power-domains "if"
> > block, so it falls back to the top-level 1-2 domains with
> > power-domain-names "a"/"b". That would let a K3 DT with two power
> > domains pass validation, which does not describe this hardware. v4 will
> > add an explicit "if" block:
> >=20
> >=20
> > &nbsp; &nbsp; - if:
> > &nbsp; &nbsp; &nbsp; &nbsp; properties:
> > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible:
> > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; contains:
> > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const: spacemit,k3-gpu
> > &nbsp; &nbsp; &nbsp; then:
> > &nbsp; &nbsp; &nbsp; &nbsp; properties:
> > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; power-domains: false
> > &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; power-domain-names: false
>
> I understand only half of this. Please fix your email client.
>
> And why this reply misses reply-to header which connects it to proper
> thread? How am I supposed to find the thread now, among 200 I received
> yesterday?

Sorry -- that went out through a webmail client which sent HTML, so the
quoting and the YAML indentation were destroyed, and it composed a new
message instead of replying in place, which is why it lost the thread.
I have switched to git send-email over our own SMTP; this reply should
be plain text and properly threaded.

> So your name is presented here as "Baihui Liang" then why do you use
> some fake company name?

liangbaihui@linux.spacemit.com is my real work address at SpacemiT. It is
now sent through the company's own mail server.

> Best regards,
> Krzysztof
