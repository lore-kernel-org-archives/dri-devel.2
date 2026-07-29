Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5FFC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7583710EDD9;
	Thu, 30 Jul 2026 07:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="B/Ee5JNH";
	dkim-atps=neutral
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C99F10E392
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1785319491;
 bh=rGjRoJY2bcOuoh/YLY1s9eXB07hnFRse6TYTrFiBgo0=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=B/Ee5JNHBb6O03VFB1ylyBJ/8BqoGaS6ExKQEnnPpLv9EtzyomiggXWib6OUSc9DG
 0iiTbfH2/jDxpBRZ1f90D4CGck/40j3MTpudAbAlRxnGmn4F48ZYMVhRFwq1GIOw7H
 ho36qc9UFEeqhhZBMEr1HHVSPFjpurRTDlgij9cI=
X-QQ-mid: zesmtpgz6t1785319483t91deea57
X-QQ-Originating-IP: 5tTKMPmo2435qtvnLyHekoCjA48pilenE9UZy9JvxsA=
Received: from localhost ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Jul 2026 18:04:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 286073189035881177
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 18:04:41 +0800
Message-Id: <DKAYXR5BO1X3.3R5L4FN5KF6L7@linux.spacemit.com>
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
 <DKAXV3CTQ6B1.36715CJUMEB9A@linux.spacemit.com>
 <39f12852-a0d4-4d90-8ea3-dbfa7e1c2059@kernel.org>
In-Reply-To: <39f12852-a0d4-4d90-8ea3-dbfa7e1c2059@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NFQMG86uACrUwTrKvbPcTPng7ir3UJFqNOcGB1iYuTWJpwGjyDBbqxZ0
 9F/a9j2pPoGkkGb7JA7F7A7iEA+F0ZYKNs+N+KRlSdwjw8fT4Ss4NZ+r6CZ1MfNDf8o6h3D
 tVrPPLlpwhovr7zfTfxr9QaJ5q0tALhqpiPUBEwgO2SrAFYaCytnZNgNrvlImgERVVEtKQI
 3KnnzeXkOU0LtZrITZpMU2RFt+zLvXS++mVQollO4embq9qR1PNNUfaI4PBD4q83ULKQCTI
 y1QPDnLwemgeydmajD/NisDpS+1IPyx3+DTQFEPED9iunGjq9+u/+hZV6xTBWd1EgGA41CZ
 h8N2IEEMU1w6At4CuLEWZjjss9J9a+OAcEFuO56vH7VIIGb8UNF32WUeRmD/LY2qtUgcQVH
 +JLNnjBzLFGfzRIcF3Q2MGC3YNvnnDR2JyzTklZ1oqg9HRujvGpIrAuxlNic7wbs0aNZAZD
 nanRQ4FCbBSdZL0wVGudfkG3A26Oln6khbSSsYXR2dPH3hobOwCTsllxAB1bfCjWpoMTVOy
 S7b7OsIwxlCh3pMwR9lQ7trtRQnQhpD3KbT4qWdu0KIh+pLOfGAU/peHgIKNgOXtOpy/TeS
 zy/c/LSZkJE6u5s06eu/owszPXzfwKEngXw3e3aQGSZiS3/3Q/plaoFxE3zznw6zKxRgQY9
 Ymyd9yuuQd9T/9bnDqOxlzsn3okUlP+pvf3TvZeO4Zq+0Z0xijlqSDqF5FO5/GP89XaQJ+T
 lKmK3O/uCCqpib3yPSL6L7PYiNip+b4g7s7Qi6Visb280rduV3jLr17P+2Q2trPVYNT+9aq
 t8fbM7bWMB1Myfi/1VE4CE80HoKcqLwU/cxguTZPpv1PbYwtTHkCBNAu6mGfeagCo5mh3Ie
 W/H3uh3533b5MXL0wsJNydzDxo08ZvlwqYxaJzKp3sS8vHWlc7fcAFy8Zb13TcUGGFXDnrZ
 UfqmKdBKu8nWip8GQHPjTCVyo+pNsAdPwnXfHCUPBzCy+oDiVacK/B3hnhh9/YrJbbWTf+h
 hotNKNCJarIFvk1WWUYNMAXA3SVTHjoFRTOnOOQgBDK4lRZRl5
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

On Wed Jul 29, 2026 at 5:16 PM CST, Krzysztof Kozlowski wrote:
> On 29/07/2026 11:14, Baihui Liang wrote:
> > On Wed Jul 29, 2026 at 3:57 PM CST, Krzysztof Kozlowski wrote:
> >> On 29/07/2026 09:46, Baihui Liang wrote:
> >>> On Tue, Jul 28, 2026, Krzysztof Kozlowski wrote:
> >>> &gt; &gt; [...]
> >>> &gt; &gt; spacemit,k3-gpu is added to the existing ti,am62-gpu/ti,am6=
2p-gpu/
> >>> &gt; &gt; ti,j721s2-gpu "if" block that restricts clocks to a single =
entry,
> >>> &gt; &gt; since K3 has the same single-clock requirement. It does not=
 match any
> >>> &gt; &gt; "if" block that constrains power-domains, so that property =
falls back
> >>> &gt;
> >>> &gt; I don't get this explanation. Are you explaining what the patch =
is doing
> >>> &gt; or explaining WHY you did this that way?
> >>>
> >>>
> >>> That paragraph was describing schema mechanics, which does not belong=
 in
> >>> a commit message. v4 will drop it and state only the hardware facts: =
the
> >>> K3 integration of the BXM-4-64 has a single "core" clock, and it has =
no
> >>> software-controllable GPU power domain.
> >>>
> >>>
> >>> &gt; &gt; to this schema's general constraints, where it is optional.=
 This
> >>> &gt; &gt; leaves room for a power-domains provider to be added later =
without a
> >>> &gt; &gt; further binding change, should one ever be modelled in Linu=
x for this
> >>> &gt; &gt; SoC.
> >>> &gt;
> >>> &gt; No, you need to provide constraints now. Please read carefully
> >>> &gt; writing-bindings.
> >>>
> >>>
> >>> Understood. spacemit,k3-gpu currently matches no power-domains "if"
> >>> block, so it falls back to the top-level 1-2 domains with
> >>> power-domain-names "a"/"b". That would let a K3 DT with two power
> >>> domains pass validation, which does not describe this hardware. v4 wi=
ll
> >>> add an explicit "if" block:
> >>>
> >>>
> >>> &nbsp; &nbsp; - if:
> >>> &nbsp; &nbsp; &nbsp; &nbsp; properties:
> >>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible:
> >>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; contains:
> >>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const: spacemit,k3-g=
pu
> >>> &nbsp; &nbsp; &nbsp; then:
> >>> &nbsp; &nbsp; &nbsp; &nbsp; properties:
> >>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; power-domains: false
> >>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; power-domain-names: false
> >>
> >> I understand only half of this. Please fix your email client.
> >>
> >> And why this reply misses reply-to header which connects it to proper
> >> thread? How am I supposed to find the thread now, among 200 I received
> >> yesterday?
> >=20
> > Sorry -- that went out through a webmail client which sent HTML, so the
> > quoting and the YAML indentation were destroyed, and it composed a new
> > message instead of replying in place, which is why it lost the thread.
> > I have switched to git send-email over our own SMTP; this reply should
> > be plain text and properly threaded.
> >=20
> >> So your name is presented here as "Baihui Liang" then why do you use
> >> some fake company name?
> >=20
> > liangbaihui@linux.spacemit.com is my real work address at SpacemiT. It =
is
> > now sent through the company's own mail server.
>
> Again: then why do you use fake company name as name? Actually not a
> company name, but laminated product of some company?
>
> What is Sterling-Ash?
>
> Best regards,
> Krzysztof

Sorry, I misread what you were asking and answered the wrong question.

"Sterling-Ash" is not a company and not a product name. It was a
personal nickname left over in my git config, and I did not notice it
was being used as the author name on the patches until you asked. It is
not my name and should not have appeared there.

The git config is fixed, and v4 will be sent with:

  From: Baihui Liang <liangbaihui@linux.spacemit.com>
  Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>

Best regards,
Baihui Liang
